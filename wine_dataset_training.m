load wine_dataset
winedata=wineInputs;

%wine_dataset���Է�Ϊ3�࣬��3�־�;
%��1��59������Ϊ��һ�࣬��60-130��Ϊ�ڶ��࣬��131-178��Ϊ������;
%��wine_dataset���Ϊ��������traindata��testdata;
%��ÿ�����ݵĺ�20�����ڲ��ԣ��鵽testdata,��������ѵ�����鵽traindata;
traindata1=winedata(1:13,1:39);
testdata1=winedata(1:13,40:59);
traindata2=winedata(1:13,60:110);
testdata2=winedata(1:13,111:130);
traindata3=winedata(1:13,131:158);
testdata3=winedata(1:13,159:178);
traindata=[traindata1 traindata2 traindata3];
testdata=[testdata1 testdata2 testdata3];

%����wine_datasetÿһ�ࡢÿһά��������̬�ֲ�;
%�ֱ����3�����13�ֻ�ѧ�ɷֵľ�ֵ�ͷ���;
mu=zeros(13,3);
sigma=zeros(13,3);
for i=1:13
    [mu(i,1),sigma(i,1)]=normfit(traindata1(i,:));
    [mu(i,2),sigma(i,2)]=normfit(traindata2(i,:));
    [mu(i,3),sigma(i,3)]=normfit(traindata3(i,:));
end

%�����ر�Ҷ˹����������Ȼ����;
%����evidenceһ�£�������ʴ���Ϊ��Ȼ������������ʵĳ˻�;
posterior=zeros(3,60);
priori=zeros(3,1);
category=zeros(1,30);
for i=1:60
    for j=1:3
        if j==1
           priori(j,1)=59/178;
        elseif j==2
            priori(j,1)=71/178;
        else 
            priori(j,1)=48/178;
        end
        likelihood=ones(3,1);
        for d=1:13
            likelihood(j,1)=likelihood(j,1)*normpdf(testdata(d,i),mu(d,j),sigma(d,j));
        end
        posterior(j,i)=likelihood(j,1)*priori(j,1);
    end
    A=posterior(:,i)';
    [c,s]=max(A);
    category(1,i)=s;
end

%���������ȷ�ĸ��ʣ�
category_true1=0;
category_true2=0;
category_true3=0;
category_false1=0;
category_false2=0;
category_false3=0;
for k=1:20
    if category(k)==1
        category_true1=category_true1+1;
    else 
        category_false1=category_false1+1;
    end
end
for k=21:40
    if category(k)==2
        category_true2=category_true2+1;
    else 
        category_false2=category_false2+1;
    end
end
for k=41:60
    if category(k)==3
        category_true3=category_true3+1;
    else 
        category_false3=category_false3+1;
    end
end
category_true=category_true1+category_true2+category_true3;
category_false=category_false1+category_false2+category_false3;
true_probability=category_true/60;
false_probability=category_false/60;

%��ͼ���ֱ�չʾ13ά���ݵķ����������ɫ��ͬΪͬһ�ࣩ;
%��һ������Ϊ��ɫ���ڶ�������Ϊ��ɫ������������Ϊ��ɫ;
figure ('name','model1')
hold on
scatter(1:60,testdata(1,:),50,category,'filled');
plot([20,20],[0,20],'--k');
plot([40,40],[0,20],'--k');
xlabel('sample');
ylabel('Alchole');
hold off
figure ('name','model2')
hold on
scatter(1:60,testdata(2,:),50,category,'filled');
plot([20,20],[0,10],'--k');
plot([40,40],[0,10],'--k');
xlabel('sample');
ylabel('Malicacid');
figure ('name','model3')
hold on
scatter(1:60,testdata(3,:),50,category,'filled');
plot([20,20],[0,5],'--k');
plot([40,40],[0,5],'--k');
xlabel('sample');
ylabel('Ash');
hold off
figure ('name','model4')
hold on
scatter(1:60,testdata(4,:),50,category,'filled');
plot([20,20],[0,40],'--k');
plot([40,40],[0,40],'--k');
xlabel('sample');
ylabel('Alcalinity of ash');
hold off
figure ('name','model5')
hold on
scatter(1:60,testdata(5,:),50,category,'filled');
plot([20,20],[0,150],'--k');
plot([40,40],[0,150],'--k');
xlabel('sample');
ylabel('Magnesium');
hold off
figure ('name','model6')
hold on
scatter(1:60,testdata(6,:),50,category,'filled');
plot([20,20],[0,5],'--k');
plot([40,40],[0,5],'--k');
xlabel('sample');
ylabel('Total phenols');
hold off
figure ('name','model7')
hold on
scatter(1:60,testdata(7,:),50,category,'filled');
plot([20,20],[0,10],'--k');
plot([40,40],[0,10],'--k');
xlabel('sample');
ylabel('Flavanoids');
hold off
figure ('name','model8')
hold on
scatter(1:60,testdata(8,:),50,category,'filled');
plot([20,20],[0,1],'--k');
plot([40,40],[0,1],'--k');
xlabel('sample');
ylabel('Nonflavanoid phenols');
hold off
figure ('name','model9')
hold on
scatter(1:60,testdata(9,:),50,category,'filled');
plot([20,20],[0,10],'--k');
plot([40,40],[0,10],'--k');
xlabel('sample');
ylabel('Proanthocyanins');
hold off
figure ('name','model10')
hold on
scatter(1:60,testdata(10,:),50,category,'filled');
plot([20,20],[0,15],'--k');
plot([40,40],[0,15],'--k');
xlabel('sample');
ylabel('Color intensity');
figure ('name','model11')
hold on
scatter(1:60,testdata(11,:),50,category,'filled');
plot([20,20],[0,5],'--k');
plot([40,40],[0,5],'--k');
xlabel('sample');
ylabel('Hue');
hold off
figure ('name','model12')
hold on
scatter(1:60,testdata(12,:),50,category,'filled');
plot([20,20],[0,5],'--k');
plot([40,40],[0,5],'--k');
xlabel('sample');
ylabel('OD280/OD315 of diluted wines');
hold off
figure ('name','model13')
hold on
scatter(1:60,testdata(13,:),50,category,'filled');
plot([20,20],[0,1500],'--k');
plot([40,40],[0,1500],'--k');
xlabel('sample');
ylabel('Proline');
hold off