%% clean up
clear all;
newobjs = instrfind;
if ~isempty(newobjs)
    fclose(newobjs);
    delete(newobjs);
end
%% start up
s = serial('/dev/tty.usbmodem1451');
set(s,'BaudRate',115200);
fopen(s);
pause(5);

%% read data
out_datas = zeros(1,10000); 
out_times = zeros(1,10000); 
tic;
try
    for i = 1:10000
        out_line = fscanf(s,'%f');
        out_datas(i) = out_line;
        out_times(i) = toc;
    end
catch exception
    warning('read failed');
    msgString = getReport(exception);
    warning(msgString);
end
%% cleanup
fclose(s);
delete(s);

%% plotting
figure(1);
plot(out_times,out_datas);
axis([1,10,-500,1000]);

