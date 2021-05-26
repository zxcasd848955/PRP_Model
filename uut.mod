// Test
//****************************�������****************************\\
//�Ű�����
int N = ...;
//��ĩ(�������ϰ�ʱ��)
{int} weekend = ...;//��ʾ����
//3��ְ������
int pc = ...;
{int} P = ...; //�ֱ��ʾ
//��ͬ ְ��ҽʦ�ĸ���
int cp1 = ...; int cp2 = ...; int cp3 = ...;
int Cp[1..pc] = ...; 
//��ְͬ��ҽʦ�Ĳ���������������
{int} nw_p1[1..cp1] = ...;
{int} nw_p2[1..cp2] = ...;
{int} nw_p3[1..cp3] = ...;
//�������͵İ�ı��
int sn = ...;
int S[1..sn] = ...;// �װ࣬ҹ�࣬���ֵ��
//���������Ű���򼯺�
int forbidden_S[1..7][1..2] = ...;
// ÿ��ÿ�����͵İ���Ҫ�����ٺ�����ҽʦ����
int D_min[1..N][1..sn] = ...;
int D_max[1..N][1..sn] = ...;
//���������ҹ�������
int N_max = ...;
//�����������������
int W_max = ...;

//ְ��Ϊp��������Ϊs�İ�����ٺ��������
int Q_min[1..pc][1..sn] = ...;

int Q_max[1..pc][1..sn] = ...;
//**************************ȥ���ı���**************************\\
//ÿ��ҽʦ����ĩ�ۼƹ������������
//int on_weekend_day_max = 1; //2
//��ְͬ��ÿ��ҽʦ����ĩ���ٹ���ʱ�����๤��ʱ�䣬��Ҫ����סԺҽʦ����ֵ�ܶ�İ࣬����
//int on_weekend_hours_min[1..pc] = [0, 0, 0]; //����8��ֵ��24
//int on_weekend_hours_max[1..pc] = [24, 24, 16];
//����������Ϣ������
//int R_min = 1;
//��ְͬ��ҽʦ�����ŵİ�ļ���
//int fs_p1 = 3; //����
//int fs_p3[1..2] = [2, 4]; //ҹ���ֵ��

//ÿ��ҽʦ���ٺ���๤�������� �ֲ�ְͬ����
int on_all_day_min = ...;
int on_all_day_max = ...; //6

//ÿ�����͵İ��ʱ��
int long_shift[1..sn] = ...;

//��ְͬ��ҽʦ������ʱ����������
int on_all_hours_min[1..pc] = ...;//
int on_all_hours_max[1..pc] = ...; //[64, 64, 42]

//��Լ��Ȩ��
int cn = ...;
int w[1..cn] = ...;
//���ֵ����� 
int duty_max = ...;

//����ĩ�ۼ���Ϣ���ܵ����������
int rest_weekend_min = ...;

//Model
//****************************���߱����͸�������****************************\\
dvar boolean X1[1..cp1][1..N][1..sn];
dvar boolean X2[1..cp2][1..N][1..sn];
dvar boolean X3[1..cp3][1..N][1..sn];
//dvar boolean X[p in P][1..Cp[p]][1..N][1..sn];
//dvar boolean w[X1, X2, X3];???
//int X1_S[i in 1..cp1][j in 1..N] = sum(k in 1..sn) X1[i][j][k];
//�Ƿ���
dvar boolean O1[1..cp1][1..N];
dvar boolean O2[1..cp2][1..N];
dvar boolean O3[1..cp3][1..N];
//dvar boolean O[p in P][1..Cp[p]][1..N];
//�Ƿ���Ϣ
dvar boolean R1[1..cp1][1..N];
dvar boolean R2[1..cp2][1..N];
dvar boolean R3[1..cp3][1..N];
//dvar boolean R[p in P][1..Cp[p]][1..N];
//��������
dvar int j_p1[1..cp1]; 
dvar int j_p2[1..cp2];
//dvar int j[p in {1,2}][1..Cp[p]];
dvar int g_p2[1..cp2][1..sn];
dvar int h_p1[1..cp1][i in 1..4];
dvar int h_p2[1..cp2][i in 1..4];
dvar int h_p3[1..cp3][i in 1..4];

//****************************Ŀ�귽��****************************\\
minimize 
		sum(k in 1..cp1)sum(i in 1..4) h_p1[k][i] * w[i+2]+
		sum(k in 1..cp2)sum(i in 1..4) h_p2[k][i] * w[i+2]+
		sum(k in 1..cp3)sum(i in 1..4) h_p3[k][i] * w[i+2]+
//		sum(p in P)sum(k in 1..Cp[p])sum(i in 1..4)(h[p][k][i] * w[i+2])+
//		sum(p in {1,2})sum(k in 1..Cp[p])j[p][k] * w[1]+
		sum(k in 1..cp1)j_p1[k] * w[1]+
		sum(k in 1..cp2)j_p2[k] * w[1]+
		sum(k in 1..cp2)sum(s in 1..sn)g_p2[k][s] * w[2];

//****************************Լ��****************************\\
subject to{
// H1
forall(k in 1..cp1)
  forall(n in 1..N)
    sum(s in 1..sn)X1[k][n][s] <= 1;
forall(k in 1..cp2)
  forall(n in 1..N)
    sum(s in 1..sn)X2[k][n][s] <= 1;
forall(k in 1..cp3)
  forall(n in 1..N)
    sum(s in 1..sn)X3[k][n][s] <= 1;

// H2a/H2b
forall(n in 1..N)
  forall(s in 1..sn)
    sum(k in 1..cp1)X1[k][n][s]+
    sum(k in 1..cp2)X2[k][n][s]+
    sum(k in 1..cp3)X3[k][n][s] >= D_min[n][s];
forall(n in 1..N)
  forall(s in 1..sn)
    sum(k in 1..cp1)X1[k][n][s]+
    sum(k in 1..cp2)X2[k][n][s]+
    sum(k in 1..cp3)X3[k][n][s] <= D_max[n][s];

// H3a
forall(n in 1..N)
  	sum(k in 1..Cp[1])X1[k][n][S[3]] +
  	sum(k in 1..Cp[3])X3[k][n][S[4]] +
  	sum(k in 1..Cp[3])X3[k][n][S[2]] == 0;

// H3b
forall(n in weekend)
	sum(k in 1..Cp[2])X2[k][n][S[1]] >= 0; //1
forall(n in weekend)
	sum(k in 1..Cp[2])X2[k][n][S[2]] >= 0; //1 

// H4
forall(p in P)
forall(k in 1..cp1)
  forall(n in nw_p1[k])
    forall(s in 1..sn)
      X1[k][n][s] == 0;
//
forall(k in 1..cp2)
  forall(n in nw_p2[k])
    forall(s in 1..sn)
      X2[k][n][s] == 0;
////
forall(k in 1..cp3)
  forall(n in nw_p3[k])
    forall(s in 1..sn)
      X3[k][n][s] == 0;


// H5
forall(n in weekend)
  sum(k in 1..Cp[1])X1[k][n][S[1]]+
  sum(k in 1..Cp[1])X1[k][n][S[2]] == 0;
  
// H6 ְ��
forall(p in P)
forall(k in 1..Cp[1])
  sum(n in 1..N)O1[k][n] >= on_all_day_min;
forall(k in 1..Cp[1])
  sum(n in 1..N)O1[k][n] <= on_all_day_max;
forall(k in 1..Cp[2])
  sum(n in 1..N)O2[k][n] >= on_all_day_min;
forall(k in 1..Cp[3])
  sum(n in 1..N)O3[k][n] <= on_all_day_max;

// H7
forall(n in 1..N-1)
    forall(k in 1..Cp[1])
     X1[k][n][S[4]] + O1[k][n+1] <= 1;
forall(n in 1..N-1)
    forall(k in 1..Cp[2])
     X2[k][n][S[4]] + O2[k][n+1] <= 1;
     
// H8
forall(n in 1..N-1)
  forall(k in 1..Cp[1])
   forall(tmp in 1..7)
     X1[k][n][forbidden_S[tmp][1]] + X1[k][n+1][forbidden_S[tmp][2]] != 2;
forall(n in 1..N-1)
  forall(k in 1..Cp[2])
   forall(tmp in 1..7)
     X2[k][n][forbidden_S[tmp][1]] + X2[k][n+1][forbidden_S[tmp][2]] != 2;
forall(n in 1..N-1)
  forall(k in 1..Cp[3])
   forall(tmp in 1..7)
     X3[k][n][forbidden_S[tmp][1]] + X3[k][n+1][forbidden_S[tmp][2]] != 2;

// H9
forall(k in 1..Cp[1])
    forall(s in 1..sn)
      sum(n in 1..N)X1[k][n][s] <= Q_max[1][s]; 
forall(k in 1..Cp[1])
    forall(s in 1..sn)
      sum(n in 1..N)X1[k][n][s] >= Q_min[1][s];
forall(k in 1..Cp[2])
    forall(s in 1..sn)
      sum(n in 1..N)X2[k][n][s] <= Q_max[2][s]; 
forall(k in 1..Cp[3])
    forall(s in 1..sn)
      sum(n in 1..N)X3[k][n][s] >= Q_min[3][s];
//      
// H10
forall(k in 1..Cp[1])
    sum(n in 1..N)sum(s in 1..sn)(X1[k][n][s] * long_shift[s]) 
    <= on_all_hours_max[1];
forall(k in 1..Cp[1])
    sum(n in 1..N)sum(s in 1..sn)(X1[k][n][s] * long_shift[s]) 
    >= on_all_hours_min[1];
    
forall(k in 1..Cp[2])
    sum(n in 1..N)sum(s in 1..sn)(X2[k][n][s] * long_shift[s]) 
    <= on_all_hours_max[2];
forall(k in 1..Cp[2])
    sum(n in 1..N)sum(s in 1..sn)(X2[k][n][s] * long_shift[s]) 
    >= on_all_hours_min[2];
    
forall(k in 1..Cp[3])
    sum(n in 1..N)sum(s in 1..sn)(X3[k][n][s] * long_shift[s]) 
    <= on_all_hours_max[3];
forall(k in 1..Cp[3])
    sum(n in 1..N)sum(s in 1..sn)(X3[k][n][s] * long_shift[s]) 
    >= on_all_hours_min[3];     

     
// S1
forall(k in 1..Cp[1])
    sum(n in 1..N)X1[k][n][S[2]] - j_p1[k] <= duty_max;
forall(k in 1..Cp[2])
    sum(n in 1..N)X2[k][n][S[2]] - j_p2[k] <= duty_max;
    
// S2
forall(s in 1..sn)
   sum(k in 1..Cp[2])(
     abs(sum(n in 1..N)X2[k][n][s] - (sum(n in 1..N)sum(k in 1..Cp[2])X2[k][n][s]) / Cp[2])
     - g_p2[k][s]
     ) <= 0; 
     
// S3
forall(k in 1..Cp[1])
    sum(n in weekend)R1[k][n] + h_p1[k][1] >= rest_weekend_min;
forall(k in 1..Cp[2])
    sum(n in weekend)R2[k][n] + h_p2[k][1] >= rest_weekend_min;
forall(k in 1..Cp[3])
    sum(n in weekend)R3[k][n] + h_p3[k][1] >= rest_weekend_min;

//S4
sum(k in 1..Cp[1])(
  	abs(sum(n in 1..N)sum(s in 1..sn)(X1[k][n][s] * long_shift[s]) - 
  	sum(k in 1..Cp[1])sum(n in 1..N)sum(s in 1..sn)(X1[k][n][s] * long_shift[s]) / Cp[1])
  	- h_p1[k][2]
  ) <= 0;
sum(k in 1..Cp[2])(
  	abs(sum(n in 1..N)sum(s in 1..sn)(X2[k][n][s] * long_shift[s]) - 
  	sum(k in 1..Cp[2])sum(n in 1..N)sum(s in 1..sn)(X2[k][n][s] * long_shift[s]) / Cp[2])
  	- h_p2[k][2]
  ) <= 0;
sum(k in 1..Cp[3])(
  	abs(sum(n in 1..N)sum(s in 1..sn)(X3[k][n][s] * long_shift[s]) - 
  	sum(k in 1..Cp[3])sum(n in 1..N)sum(s in 1..sn)(X3[k][n][s] * long_shift[s]) / Cp[3])
  	- h_p3[k][2]
  ) <= 0;
      
// S5
forall(k in 1..Cp[1])
    forall(n in 1..N-N_max+1)
      sum(i in n..n+N_max-1)X1[k][i][S[2]] - h_p1[k][3] <= N_max;
forall(k in 1..Cp[2])
    forall(n in 1..N-N_max+1)
      sum(i in n..n+N_max-1)X2[k][i][S[2]] - h_p2[k][3] <= N_max;
forall(k in 1..Cp[3])
    forall(n in 1..N-N_max+1)
      sum(i in n..n+N_max-1)X3[k][i][S[2]] - h_p3[k][3] <= N_max;

// S6
forall(k in 1..Cp[1])
    forall(n in 1..N-W_max+1)
      sum(i in n..n+W_max-1)O1[k][i] - h_p1[k][4] <= W_max;
forall(k in 1..Cp[2])
    forall(n in 1..N-W_max+1)
      sum(i in n..n+W_max-1)O2[k][i] - h_p2[k][4] <= W_max;
forall(k in 1..Cp[3])
    forall(n in 1..N-W_max+1)
      sum(i in n..n+W_max-1)O3[k][i] - h_p3[k][4] <= W_max;
};