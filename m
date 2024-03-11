Return-Path: <linux-kernel+bounces-98648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E4877D35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B02281044
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4971CD1C;
	Mon, 11 Mar 2024 09:48:49 +0000 (UTC)
Received: from outbound22.service-now.com (outbound22.service-now.com [149.96.6.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2617577;
	Mon, 11 Mar 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.96.6.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150528; cv=none; b=sRfmET4H/12JL9p5bHLYM/Ns4Sb+BVTXyJAQnIxzx5Y8IAhzZSmdgCoCs43bECvgCcggWR+MZmamKA1hvnIoRXb6K7fvg04bQSkeTdvTsw2AtqlE7DkySDx9i6ufwQj6q29uo9uyqJSGzFm/QThIQtyz+KjJx2T0ND8mChmtz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150528; c=relaxed/simple;
	bh=xkxCOZOyPpR+nLsPnbW+p93kqIEkT3k+kQCE4SEKpko=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=qqE4Zp7ykKRCpjNiD5FdAnt5mbj40ucOlNjELWakTgl6C/1+xbFjU2UO1A29S9+3UlRaiSi28gwItuxJJA2ZpE/CDPBR7W6B4BxSRYiBtxDRFMHxzHTEYKMuccvx4+NXpg6akbSv2SgBIXUgI9UVaaWNROdR+llDjMsHZJ+vru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=149.96.6.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from app138038.ycg3.service-now.com (unknown [10.248.3.236])
	by outbound22.service-now.com (Postfix) with ESMTP id 3B6FD46902;
	Mon, 11 Mar 2024 02:48:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 outbound22.service-now.com 3B6FD46902
Date: Mon, 11 Mar 2024 02:48:45 -0700 (PDT)
From: Red Hat Product Security <secalert@redhat.com>
Reply-To: Red Hat Product Security <secalert@redhat.com>
To: richardcochran@gmail.com, syzkaller@googlegroups.com,
	liujingfeng@qianxin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <13977296.34150.1710150525225@app138038.ycg3.service-now.com>
Subject: Re: memory leak in posix_clock_open
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_34148_118593.1710150525224"
X-ServiceNow-Source: Notification-ec04d32213ede300196f7e276144b04e
X-ServiceNow-SysEmail-Version: 2
Precedence: bulk
Auto-Submitted: auto-generated
X-ServiceNow-Generated: true

------=_Part_34148_118593.1710150525224
Content-Type: multipart/alternative; 
	boundary="----=_Part_34149_25135062.1710150525224"

------=_Part_34149_25135062.1710150525224
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

Hello!

INC2889741 (memory leak in posix_clock_open) has been updated.

Opened for: liujingfeng@qianxin.com
Followers: richardcochran@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

A Guest updated your request with the following comments:

Reply from: qiang.zhang1211@gmail.com [mailto:qiang.zhang1211@gmail.com]
 >
> There is a memory leak in posix_clock_open,it was found by syzkaller when I tested it with linux-6.7(commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a).
>
> When the ptp_open function (in driver/ptp/ptp.chardev. c) is called in posix_clock_open and the ptp_open function returns an error, it appears to crash, posix_clock_release has not been called to free pccontext.
>
> Here is crash info:
>
> BUG: memory leak
> unreferenced object 0xffff8881065327c0 (size 16):
> comm "syz-executor.7", pid 8994, jiffies 4295144661 (age 17.222s)
> hex dump (first 16 bytes):
> 00 20 79 01 81 88 ff ff 00 00 00 00 00 00 00 00 . y.............
> backtrace:
> [<00000000fba736c4>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
> [<00000000fba736c4>] slab_post_alloc_hook mm/slab.h:766 [inline]
> [<00000000fba736c4>] slab_alloc_node mm/slub.c:3478 [inline]
> [<00000000fba736c4>] __kmem_cache_alloc_node+0x1ee/0x250 mm/slub.c:3517
> [<00000000f8fcb419>] kmalloc_trace+0x22/0xc0 mm/slab_common.c:1098
> [<00000000afc910b4>] kmalloc include/linux/slab.h:600 [inline]
> [<00000000afc910b4>] kzalloc include/linux/slab.h:721 [inline]
> [<00000000afc910b4>] posix_clock_open+0xd3/0x250 kernel/time/posix-clock.c:126
> [<00000000b1a43627>] chrdev_open+0x24b/0x6a0 fs/char_dev.c:414
> [<00000000364febd5>] do_dentry_open+0x630/0x1580 fs/open.c:948
> [<00000000ac62c8f4>] do_open fs/namei.c:3622 [inline]
> [<00000000ac62c8f4>] path_openat+0x13f1/0x1c30 fs/namei.c:3779
> [<0000000087bfc1bc>] do_filp_open+0x1c5/0x410 fs/namei.c:3809
> [<0000000044db899a>] do_sys_openat2+0x139/0x190 fs/open.c:1437
> [<00000000ee967f42>] do_sys_open fs/open.c:1452 [inline]
> [<00000000ee967f42>] __do_sys_openat fs/open.c:1468 [inline]
> [<00000000ee967f42>] __se_sys_openat fs/open.c:1463 [inline]
> [<00000000ee967f42>] __x64_sys_openat+0x13d/0x1f0 fs/open.c:1463
> [<000000004fad64b5>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> [<000000004fad64b5>] do_syscall_64+0x3e/0xf0 arch/x86/entry/common.c:83
> [<00000000c2701c13>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> BUG: leak checking failed
 Hi, jingfeng
 Please try the following modifications:
 diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 9de66bbbb3d1..71d9d8c394fa 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -137,6 +137,8 @@ static int posix_clock_open(struct inode *inode,
struct file *fp)
  if (!err) {
 get_device(clk->dev);
+ } else {
+ kfree(pccontext);
 }
 out:
 up_read(&clk->rwsem);
 Thanks
Zqiang
 >
>
>
>
> Here is the C code reproducer by syzkaller,It used inject fault to make ptp_open returns a error:
>
> // autogenerated by syzkaller (https://github.com/google/syzkaller [https://github.com/google/syzkaller])
>
> #define _GNU_SOURCE
>
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
> #include 
>
> static void sleep_ms(uint64_t ms)
> {
> usleep(ms * 1000);
> }
>
> static uint64_t current_time_ms(void)
> {
> struct timespec ts;
> if (clock_gettime(CLOCK_MONOTONIC, &ts))
> exit(1);
> return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
>
> static bool write_file(const char* file, const char* what, ...)
> {
> char buf[1024];
> va_list args;
> va_start(args, what);
> vsnprintf(buf, sizeof(buf), what, args);
> va_end(args);
> buf[sizeof(buf) - 1] = 0;
> int len = strlen(buf);
> int fd = open(file, O_WRONLY | O_CLOEXEC);
> if (fd == -1)
> return false;
> if (write(fd, buf, len) != len) {
> int err = errno;
> close(fd);
> errno = err;
> return false;
> }
> close(fd);
> return true;
> }
>
> static int inject_fault(int nth)
> {
> int fd;
> fd = open("/proc/thread-self/fail-nth", O_RDWR);
> if (fd == -1)
> exit(1);
> char buf[16];
> sprintf(buf, "%d", nth);
> if (write(fd, buf, strlen(buf)) != (ssize_t)strlen(buf))
> exit(1);
> return fd;
> }
>
> static void kill_and_wait(int pid, int* status)
> {
> kill(-pid, SIGKILL);
> kill(pid, SIGKILL);
> for (int i = 0; i < 100; i++) {
> if (waitpid(-1, status, WNOHANG | __WALL) == pid)
> return;
> usleep(1000);
> }
> DIR* dir = opendir("/sys/fs/fuse/connections");
> if (dir) {
> for (;;) {
> struct dirent* ent = readdir(dir);
> if (!ent)
> break;
> if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
> continue;
> char abort[300];
> snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
> int fd = open(abort, O_WRONLY);
> if (fd == -1) {
> continue;
> }
> if (write(fd, abort, 1) < 0) {
> }
> close(fd);
> }
> closedir(dir);
> } else {
> }
> while (waitpid(-1, status, __WALL) != pid) {
> }
> }
>
> static void setup_test()
> {
> prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
> setpgrp();
> write_file("/proc/self/oom_score_adj", "1000");
> }
>
> static void setup_fault()
> {
> static struct {
> const char* file;
> const char* val;
> bool fatal;
> } files[] = {
> {"/sys/kernel/debug/failslab/ignore-gfp-wait", "N", true},
> {"/sys/kernel/debug/fail_futex/ignore-private", "N", false},
> {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},
> {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", false},
> {"/sys/kernel/debug/fail_page_alloc/min-order", "0", false},
> };
> unsigned i;
> for (i = 0; i < sizeof(files) / sizeof(files[0]); i++) {
> if (!write_file(files[i].file, files[i].val)) {
> if (files[i].fatal)
> exit(1);
> }
> }
> }
>
> #define KMEMLEAK_FILE "/sys/kernel/debug/kmemleak"
>
> static void setup_leak()
> {
> if (!write_file(KMEMLEAK_FILE, "scan"))
> exit(1);
> sleep(5);
> if (!write_file(KMEMLEAK_FILE, "scan"))
> exit(1);
> if (!write_file(KMEMLEAK_FILE, "clear"))
> exit(1);
> }
>
> static void check_leaks(void)
> {
> int fd = open(KMEMLEAK_FILE, O_RDWR);
> if (fd == -1)
> exit(1);
> uint64_t start = current_time_ms();
> if (write(fd, "scan", 4) != 4)
> exit(1);
> sleep(1);
> while (current_time_ms() - start < 4 * 1000)
> sleep(1);
> if (write(fd, "scan", 4) != 4)
> exit(1);
> static char buf[128 << 10];
> ssize_t n = read(fd, buf, sizeof(buf) - 1);
> if (n < 0)
> exit(1);
> int nleaks = 0;
> if (n != 0) {
> sleep(1);
> if (write(fd, "scan", 4) != 4)
> exit(1);
> if (lseek(fd, 0, SEEK_SET) < 0)
> exit(1);
> n = read(fd, buf, sizeof(buf) - 1);
> if (n < 0)
> exit(1);
> buf[n] = 0;
> char* pos = buf;
> char* end = buf + n;
> while (pos < end) {
> char* next = strstr(pos + 1, "unreferenced object");
> if (!next)
> next = end;
> char prev = *next;
> *next = 0;
> fprintf(stderr, "BUG: memory leak\n%s\n", pos);
> *next = prev;
> pos = next;
> nleaks++;
> }
> }
> if (write(fd, "clear", 5) != 5)
> exit(1);
> close(fd);
> if (nleaks)
> exit(1);
> }
>
> static void execute_one(void);
>
> #define WAIT_FLAGS __WALL
>
> static void loop(void)
> {
> int iter = 0;
> for (;; iter++) {
> int pid = fork();
> if (pid < 0)
> exit(1);
> if (pid == 0) {
> setup_test();
> execute_one();
> exit(0);
> }
> int status = 0;
> uint64_t start = current_time_ms();
> for (;;) {
> if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
> break;
> sleep_ms(1);
> if (current_time_ms() - start < 5000)
> continue;
> kill_and_wait(pid, &status);
> break;
> }
> check_leaks();
> }
> }
>
> void execute_one(void)
> {
> memcpy((void*)0x20001180, "/dev/ptp0\000", 10);
> inject_fault(7);
> syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x20001180ul, /*flags=*/0ul, /*mode=*/0ul);
>
> }
> int main(void)
> {
> syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
> syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
> syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
> setup_leak();
> setup_fault();
> loop();
> return 0;
> }
>

How can I track and update my request?

To respond, reply to this email. You may also create a new email and include the request number (INC2889741) in the subject.

Thank you,
Product Security

Ref:MSG86490725
------=_Part_34149_25135062.1710150525224
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div><p style=3D"margin-top:0;margin-bottom:10px;"=
>Hello!</p><p style=3D"margin-top:0;margin-bottom:10px;">INC2889741 (memory=
 leak in posix_clock_open) has been updated.</p><p style=3D"margin-top:0;ma=
rgin-bottom:10px;">Opened for:&nbsp;liujingfeng@qianxin.com<br>Followers:&n=
bsp;richardcochran@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.ker=
nel.org, syzkaller@googlegroups.com</p></div>
<p style=3D"margin-top: 10px; margin-bottom: 10px;">A Guest updated your re=
quest with the following comments:</p>
<div style=3D"padding: 10px 0 10px 10px; background-color: ivory;"><div>Rep=
ly from: <a target=3D"_blank" href=3D"mailto:qiang.zhang1211@gmail.com" rel=
=3D"noopener noreferrer nofollow">qiang.zhang1211@gmail.com</a></div><div>&=
nbsp;</div><div>&gt;</div><div>&gt; There is a memory leak in posix_clock_o=
pen,it was found by syzkaller when I tested it with linux-6.7(commit: 0dd3e=
e31125508cd67f7e7172247f05b7fd1753a).</div><div>&gt;</div><div>&gt; When th=
e ptp_open function (in driver/ptp/ptp.chardev. c) is called in posix_clock=
_open and the ptp_open function returns an error, it appears to crash, posi=
x_clock_release has not been called to free pccontext.</div><div>&gt;</div>=
<div>&gt; Here is crash info:</div><div>&gt;</div><div>&gt; BUG: memory lea=
k</div><div>&gt; unreferenced object 0xffff8881065327c0 (size 16):</div><di=
v>&gt;   comm "syz-executor.7", pid 8994, jiffies 4295144661 (age 17.222s)<=
/div><div>&gt;   hex dump (first 16 bytes):</div><div>&gt;     00 20 79 01 =
81 88 ff ff 00 00 00 00 00 00 00 00  . y.............</div><div>&gt;   back=
trace:</div><div>&gt;     [&lt;00000000fba736c4&gt;] kmemleak_alloc_recursi=
ve include/linux/kmemleak.h:42 [inline]</div><div>&gt;     [&lt;00000000fba=
736c4&gt;] slab_post_alloc_hook mm/slab.h:766 [inline]</div><div>&gt;     [=
&lt;00000000fba736c4&gt;] slab_alloc_node mm/slub.c:3478 [inline]</div><div=
>&gt;     [&lt;00000000fba736c4&gt;] __kmem_cache_alloc_node+0x1ee/0x250 mm=
/slub.c:3517</div><div>&gt;     [&lt;00000000f8fcb419&gt;] kmalloc_trace+0x=
22/0xc0 mm/slab_common.c:1098</div><div>&gt;     [&lt;00000000afc910b4&gt;]=
 kmalloc include/linux/slab.h:600 [inline]</div><div>&gt;     [&lt;00000000=
afc910b4&gt;] kzalloc include/linux/slab.h:721 [inline]</div><div>&gt;     =
[&lt;00000000afc910b4&gt;] posix_clock_open+0xd3/0x250 kernel/time/posix-cl=
ock.c:126</div><div>&gt;     [&lt;00000000b1a43627&gt;] chrdev_open+0x24b/0=
x6a0 fs/char_dev.c:414</div><div>&gt;     [&lt;00000000364febd5&gt;] do_den=
try_open+0x630/0x1580 fs/open.c:948</div><div>&gt;     [&lt;00000000ac62c8f=
4&gt;] do_open fs/namei.c:3622 [inline]</div><div>&gt;     [&lt;00000000ac6=
2c8f4&gt;] path_openat+0x13f1/0x1c30 fs/namei.c:3779</div><div>&gt;     [&l=
t;0000000087bfc1bc&gt;] do_filp_open+0x1c5/0x410 fs/namei.c:3809</div><div>=
&gt;     [&lt;0000000044db899a&gt;] do_sys_openat2+0x139/0x190 fs/open.c:14=
37</div><div>&gt;     [&lt;00000000ee967f42&gt;] do_sys_open fs/open.c:1452=
 [inline]</div><div>&gt;     [&lt;00000000ee967f42&gt;] __do_sys_openat fs/=
open.c:1468 [inline]</div><div>&gt;     [&lt;00000000ee967f42&gt;] __se_sys=
_openat fs/open.c:1463 [inline]</div><div>&gt;     [&lt;00000000ee967f42&gt=
;] __x64_sys_openat+0x13d/0x1f0 fs/open.c:1463</div><div>&gt;     [&lt;0000=
00004fad64b5&gt;] do_syscall_x64 arch/x86/entry/common.c:52 [inline]</div><=
div>&gt;     [&lt;000000004fad64b5&gt;] do_syscall_64+0x3e/0xf0 arch/x86/en=
try/common.c:83</div><div>&gt;     [&lt;00000000c2701c13&gt;] entry_SYSCALL=
_64_after_hwframe+0x6e/0x76</div><div>&gt;</div><div>&gt; BUG: leak checkin=
g failed</div><div>&nbsp;</div><div>Hi, jingfeng</div><div>&nbsp;</div><div=
>Please try the following modifications:</div><div>&nbsp;</div><div>diff --=
git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c</div><div>index=
 9de66bbbb3d1..71d9d8c394fa 100644</div><div>--- a/kernel/time/posix-clock.=
c</div><div>+++ b/kernel/time/posix-clock.c</div><div>@@ -137,6 +137,8 @@ s=
tatic int posix_clock_open(struct inode *inode,</div><div>struct file *fp)<=
/div><div>&nbsp;</div><div>        if (!err) {</div><div>                ge=
t_device(clk-&gt;dev);</div><div>+       } else {</div><div>+              =
 kfree(pccontext);</div><div>        }</div><div> out:</div><div>        up=
_read(&amp;clk-&gt;rwsem);</div><div>&nbsp;</div><div>Thanks</div><div>Zqia=
ng</div><div>&nbsp;</div><div>&gt;</div><div>&gt;</div><div>&gt;</div><div>=
&gt;</div><div>&gt; Here is the C code reproducer by syzkaller,It used inje=
ct fault to make ptp_open returns a error:</div><div>&gt;</div><div>&gt; //=
 autogenerated by syzkaller (<a target=3D"_blank" href=3D"https://github.co=
m/google/syzkaller" rel=3D"noopener noreferrer nofollow">https://github.com=
/google/syzkaller</a>)</div><div>&gt;</div><div>&gt; #define _GNU_SOURCE</d=
iv><div>&gt;</div><div>&gt; #include </div><div>&gt; #include </div><div>&g=
t; #include </div><div>&gt; #include </div><div>&gt; #include </div><div>&g=
t; #include </div><div>&gt; #include </div><div>&gt; #include </div><div>&g=
t; #include </div><div>&gt; #include </div><div>&gt; #include </div><div>&g=
t; #include </div><div>&gt; #include </div><div>&gt; #include </div><div>&g=
t; #include </div><div>&gt; #include </div><div>&gt; #include </div><div>&g=
t; #include </div><div>&gt;</div><div>&gt; static void sleep_ms(uint64_t ms=
)</div><div>&gt; {</div><div>&gt;        usleep(ms * 1000);</div><div>&gt; =
}</div><div>&gt;</div><div>&gt; static uint64_t current_time_ms(void)</div>=
<div>&gt; {</div><div>&gt;        struct timespec ts;</div><div>&gt;       =
 if (clock_gettime(CLOCK_MONOTONIC, &amp;ts))</div><div>&gt;        exit(1)=
;</div><div>&gt;        return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv=
_nsec / 1000000;</div><div>&gt; }</div><div>&gt;</div><div>&gt; static bool=
 write_file(const char* file, const char* what, ...)</div><div>&gt; {</div>=
<div>&gt;        char buf[1024];</div><div>&gt;        va_list args;</div><=
div>&gt;        va_start(args, what);</div><div>&gt;        vsnprintf(buf, =
sizeof(buf), what, args);</div><div>&gt;        va_end(args);</div><div>&gt=
;        buf[sizeof(buf) - 1] =3D 0;</div><div>&gt;        int len =3D strl=
en(buf);</div><div>&gt;        int fd =3D open(file, O_WRONLY | O_CLOEXEC);=
</div><div>&gt;        if (fd =3D=3D -1)</div><div>&gt;               retur=
n false;</div><div>&gt;        if (write(fd, buf, len) !=3D len) {</div><di=
v>&gt;               int err =3D errno;</div><div>&gt;               close(=
fd);</div><div>&gt;               errno =3D err;</div><div>&gt;            =
   return false;</div><div>&gt;        }</div><div>&gt;        close(fd);</=
div><div>&gt;        return true;</div><div>&gt; }</div><div>&gt;</div><div=
>&gt; static int inject_fault(int nth)</div><div>&gt; {</div><div>&gt;     =
   int fd;</div><div>&gt;        fd =3D open("/proc/thread-self/fail-nth", =
O_RDWR);</div><div>&gt;        if (fd =3D=3D -1)</div><div>&gt;        exit=
(1);</div><div>&gt;        char buf[16];</div><div>&gt;        sprintf(buf,=
 "%d", nth);</div><div>&gt;        if (write(fd, buf, strlen(buf)) !=3D (ss=
ize_t)strlen(buf))</div><div>&gt;        exit(1);</div><div>&gt;        ret=
urn fd;</div><div>&gt; }</div><div>&gt;</div><div>&gt; static void kill_and=
_wait(int pid, int* status)</div><div>&gt; {</div><div>&gt;        kill(-pi=
d, SIGKILL);</div><div>&gt;        kill(pid, SIGKILL);</div><div>&gt;      =
  for (int i =3D 0; i &lt; 100; i++) {</div><div>&gt;               if (wai=
tpid(-1, status, WNOHANG | __WALL) =3D=3D pid)</div><div>&gt;              =
        return;</div><div>&gt;               usleep(1000);</div><div>&gt;  =
      }</div><div>&gt;        DIR* dir =3D opendir("/sys/fs/fuse/connection=
s");</div><div>&gt;        if (dir) {</div><div>&gt;               for (;;)=
 {</div><div>&gt;                      struct dirent* ent =3D readdir(dir);=
</div><div>&gt;                      if (!ent)</div><div>&gt;              =
               break;</div><div>&gt;                      if (strcmp(ent-&g=
t;d_name, ".") =3D=3D 0 || strcmp(ent-&gt;d_name, "..") =3D=3D 0)</div><div=
>&gt;                             continue;</div><div>&gt;                 =
     char abort[300];</div><div>&gt;                      snprintf(abort, s=
izeof(abort), "/sys/fs/fuse/connections/%s/abort", ent-&gt;d_name);</div><d=
iv>&gt;                      int fd =3D open(abort, O_WRONLY);</div><div>&g=
t;                      if (fd =3D=3D -1) {</div><div>&gt;                 =
            continue;</div><div>&gt;                      }</div><div>&gt; =
                     if (write(fd, abort, 1) &lt; 0) {</div><div>&gt;      =
                }</div><div>&gt;                      close(fd);</div><div>=
&gt;               }</div><div>&gt;               closedir(dir);</div><div>=
&gt;        } else {</div><div>&gt;        }</div><div>&gt;        while (w=
aitpid(-1, status, __WALL) !=3D pid) {</div><div>&gt;        }</div><div>&g=
t; }</div><div>&gt;</div><div>&gt; static void setup_test()</div><div>&gt; =
{</div><div>&gt;        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);</div><di=
v>&gt;        setpgrp();</div><div>&gt;        write_file("/proc/self/oom_s=
core_adj", "1000");</div><div>&gt; }</div><div>&gt;</div><div>&gt; static v=
oid setup_fault()</div><div>&gt; {</div><div>&gt;        static struct {</d=
iv><div>&gt;               const char* file;</div><div>&gt;               c=
onst char* val;</div><div>&gt;               bool fatal;</div><div>&gt;    =
    } files[] =3D {</div><div>&gt;            {"/sys/kernel/debug/failslab/=
ignore-gfp-wait", "N", true},</div><div>&gt;            {"/sys/kernel/debug=
/fail_futex/ignore-private", "N", false},</div><div>&gt;           {"/sys/k=
ernel/debug/fail_page_alloc/ignore-gfp-highmem", "N", false},</div><div>&gt=
;            {"/sys/kernel/debug/fail_page_alloc/ignore-gfp-wait", "N", fal=
se},</div><div>&gt;            {"/sys/kernel/debug/fail_page_alloc/min-orde=
r", "0", false},</div><div>&gt;        };</div><div>&gt;        unsigned i;=
</div><div>&gt;        for (i =3D 0; i &lt; sizeof(files) / sizeof(files[0]=
); i++) {</div><div>&gt;               if (!write_file(files[i].file, files=
[i].val)) {</div><div>&gt;                      if (files[i].fatal)</div><d=
iv>&gt;        exit(1);</div><div>&gt;               }</div><div>&gt;      =
  }</div><div>&gt; }</div><div>&gt;</div><div>&gt; #define KMEMLEAK_FILE "/=
sys/kernel/debug/kmemleak"</div><div>&gt;</div><div>&gt; static void setup_=
leak()</div><div>&gt; {</div><div>&gt;        if (!write_file(KMEMLEAK_FILE=
, "scan"))</div><div>&gt;        exit(1);</div><div>&gt;        sleep(5);</=
div><div>&gt;        if (!write_file(KMEMLEAK_FILE, "scan"))</div><div>&gt;=
        exit(1);</div><div>&gt;        if (!write_file(KMEMLEAK_FILE, "clea=
r"))</div><div>&gt;        exit(1);</div><div>&gt; }</div><div>&gt;</div><d=
iv>&gt; static void check_leaks(void)</div><div>&gt; {</div><div>&gt;      =
  int fd =3D open(KMEMLEAK_FILE, O_RDWR);</div><div>&gt;        if (fd =3D=
=3D -1)</div><div>&gt;        exit(1);</div><div>&gt;        uint64_t start=
 =3D current_time_ms();</div><div>&gt;        if (write(fd, "scan", 4) !=3D=
 4)</div><div>&gt;        exit(1);</div><div>&gt;        sleep(1);</div><di=
v>&gt;        while (current_time_ms() - start &lt; 4 * 1000)</div><div>&gt=
;               sleep(1);</div><div>&gt;        if (write(fd, "scan", 4) !=
=3D 4)</div><div>&gt;        exit(1);</div><div>&gt;        static char buf=
[128 &lt;&lt; 10];</div><div>&gt;        ssize_t n =3D read(fd, buf, sizeof=
(buf) - 1);</div><div>&gt;        if (n &lt; 0)</div><div>&gt;        exit(=
1);</div><div>&gt;        int nleaks =3D 0;</div><div>&gt;        if (n !=
=3D 0) {</div><div>&gt;               sleep(1);</div><div>&gt;             =
  if (write(fd, "scan", 4) !=3D 4)</div><div>&gt;        exit(1);</div><div=
>&gt;               if (lseek(fd, 0, SEEK_SET) &lt; 0)</div><div>&gt;      =
  exit(1);</div><div>&gt;               n =3D read(fd, buf, sizeof(buf) - 1=
);</div><div>&gt;               if (n &lt; 0)</div><div>&gt;        exit(1)=
;</div><div>&gt;               buf[n] =3D 0;</div><div>&gt;               c=
har* pos =3D buf;</div><div>&gt;               char* end =3D buf + n;</div>=
<div>&gt;               while (pos &lt; end) {</div><div>&gt;              =
        char* next =3D strstr(pos + 1, "unreferenced object");</div><div>&g=
t;                      if (!next)</div><div>&gt;                          =
   next =3D end;</div><div>&gt;                      char prev =3D *next;</=
div><div>&gt;                      *next =3D 0;</div><div>&gt;             =
         fprintf(stderr, "BUG: memory leak\n%s\n", pos);</div><div>&gt;    =
                  *next =3D prev;</div><div>&gt;                      pos =
=3D next;</div><div>&gt;                      nleaks++;</div><div>&gt;     =
          }</div><div>&gt;        }</div><div>&gt;        if (write(fd, "cl=
ear", 5) !=3D 5)</div><div>&gt;        exit(1);</div><div>&gt;        close=
(fd);</div><div>&gt;        if (nleaks)</div><div>&gt;               exit(1=
);</div><div>&gt; }</div><div>&gt;</div><div>&gt; static void execute_one(v=
oid);</div><div>&gt;</div><div>&gt; #define WAIT_FLAGS __WALL</div><div>&gt=
;</div><div>&gt; static void loop(void)</div><div>&gt; {</div><div>&gt;    =
    int iter =3D 0;</div><div>&gt;        for (;; iter++) {</div><div>&gt; =
              int pid =3D fork();</div><div>&gt;               if (pid &lt;=
 0)</div><div>&gt;        exit(1);</div><div>&gt;               if (pid =3D=
=3D 0) {</div><div>&gt;                      setup_test();</div><div>&gt;  =
                    execute_one();</div><div>&gt;                      exit=
(0);</div><div>&gt;               }</div><div>&gt;               int status=
 =3D 0;</div><div>&gt;               uint64_t start =3D current_time_ms();<=
/div><div>&gt;               for (;;) {</div><div>&gt;                     =
 if (waitpid(-1, &amp;status, WNOHANG | WAIT_FLAGS) =3D=3D pid)</div><div>&=
gt;                             break;</div><div>&gt;                      =
sleep_ms(1);</div><div>&gt;                      if (current_time_ms() - st=
art &lt; 5000)</div><div>&gt;                             continue;</div><d=
iv>&gt;                      kill_and_wait(pid, &amp;status);</div><div>&gt=
;                      break;</div><div>&gt;               }</div><div>&gt;=
               check_leaks();</div><div>&gt;        }</div><div>&gt; }</div=
><div>&gt;</div><div>&gt; void execute_one(void)</div><div>&gt; {</div><div=
>&gt; memcpy((void*)0x20001180, "/dev/ptp0\000", 10);</div><div>&gt;       =
 inject_fault(7);</div><div>&gt;        syscall(__NR_openat, /*fd=3D*/0xfff=
fffffffffff9cul, /*file=3D*/0x20001180ul, /*flags=3D*/0ul, /*mode=3D*/0ul);=
</div><div>&gt;</div><div>&gt; }</div><div>&gt; int main(void)</div><div>&g=
t; {</div><div>&gt;               syscall(__NR_mmap, /*addr=3D*/0x1ffff000u=
l, /*len=3D*/0x1000ul, /*prot=3D*/0ul, /*flags=3D*/0x32ul, /*fd=3D*/-1, /*o=
ffset=3D*/0ul);</div><div>&gt;        syscall(__NR_mmap, /*addr=3D*/0x20000=
000ul, /*len=3D*/0x1000000ul, /*prot=3D*/7ul, /*flags=3D*/0x32ul, /*fd=3D*/=
-1, /*offset=3D*/0ul);</div><div>&gt;        syscall(__NR_mmap, /*addr=3D*/=
0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D*/0ul, /*flags=3D*/0x32ul, /*fd=
=3D*/-1, /*offset=3D*/0ul);</div><div>&gt;        setup_leak();</div><div>&=
gt;        setup_fault();</div><div>&gt;                      loop();</div>=
<div>&gt;        return 0;</div><div>&gt; }</div><div>&gt;</div></div>
<div><p style=3D"margin-top:20px;margin-bottom:10px;"><strong>How can I tra=
ck and update my request?</strong></p><p style=3D"margin-top:0;margin-botto=
m:10px;">To respond, reply to this email. You may also create a new email a=
nd include the request number (INC2889741) in the subject.</p></div>
<p style=3D"margin-top: 14px; margin-bottom: 0;">Thank you,<br>Product Secu=
rity</p><div>&nbsp;</div><div style=3D"display:inline">Ref:MSG86490725</div=
></body></html>
------=_Part_34149_25135062.1710150525224--

------=_Part_34148_118593.1710150525224--

