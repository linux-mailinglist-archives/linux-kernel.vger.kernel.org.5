Return-Path: <linux-kernel+bounces-103991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8B87C79A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F4D282AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC48BEE;
	Fri, 15 Mar 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWYKi9Hz"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F94BD266;
	Fri, 15 Mar 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470280; cv=none; b=Xa2Fl1jF1vCIjWKeSPv+3Fh3Z7MfWKj1jlasp8GeU99IQIgmfpwdWTvcWXmiUAA+ugjAPVButXSA/jh7dZxhkscJhxR+zu7jIp9EB+gz5URKqwEo70FxcmjQMg0/jwbcB9v8c26bQXorIqK3cnXc42ek0pFOJ7cmZfUZrlyYGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470280; c=relaxed/simple;
	bh=ocimqnVYtIVU9GxPn48peC3hav6pyNjL8M+KvXyHxm8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kuCzqgEAcW/eVBBjvLqhZwbMQm4SmH6MGj9BTcO25Neupcdjv43ZatNOhlaQ40AipLMiTvKQ4GYO8ry0+7N9/GVT/bt3fYCQTCMFSfdKO061dfwrTLWow5cQbXeqoLt8L1ww8nIXW6TQ7SqTiNfp3i2sa31vCMPF/T/upVrG8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWYKi9Hz; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4644bde1d4so205682666b.3;
        Thu, 14 Mar 2024 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710470277; x=1711075077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6HNkoZ4/PqSz0Vt4KG3P6RxcMaB1WNaZlZ9l8EdyjI=;
        b=FWYKi9HzCW8v7j+XGNrqfgH1UJs9QQp7FSLgCkX9JAu+FXvz0TD2aDbJ5+WN9zr9/Z
         1CPaB2wOrr9uWDxuKXsxhI6sCcf5vWMNuLfXJ+vaHOQWP6U6pSPU03zz7GlgzKAQTq5/
         rFuXOHE3LPQlXDzHW+A6HST0zlm33ni5PmawWCg02qTDvXKv+cj8MCDVQ97KVtJlyLKw
         Uz7cTung06SYzFDOG0qYXKQvNgNRFFSQCTjozRbyFsao2m/9JQ4yC0GVK0/vI8hkpjYb
         VFdHub00VPDAInIaXlKIJt2cZrmNJtcrjqQJx8h3aUwewpWmWxTHqqn2AHdyU1+gwQPf
         pn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710470277; x=1711075077;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6HNkoZ4/PqSz0Vt4KG3P6RxcMaB1WNaZlZ9l8EdyjI=;
        b=IxlnHVkWMNzNKtQu4fD+LCkCjlwyqjal+7DpWgdrp3oRqfLTFARV/2KSsW0IQ/TmWU
         dzeaUa+tu0OEmtqoLXkd5Ctid4+MKbdN6OvGf0Bk+Vm5KX6Sbn7yaZmIhImYuSMK3BS4
         GzdBudfFFLzU9MTuYzARdSJNtn+PjwL+Fy5olLaiYf3Gpfb1ntUL/QH5evtSLXshAlyK
         f2SnVpADyWqEK1jKIJA4uV/s6VVbOq5CvWJ9HEuqwtNZ/OyeyUDAExk2PG+/VNJHal1m
         zTS6v66/kdCeUtLtCOW6sHJYsXTMLT9e33s8Ul3qBQC/Keovu9dHKwMQ3nf3ROnvcrZW
         OW1A==
X-Forwarded-Encrypted: i=1; AJvYcCWdhcjSNwewo7qzK8xkmRnlvn2jW7AFzpQnvn2QixTMlGQrEFOtdQrCy9xhScgH3WVKZD6w8MDpQBPB7NFCm5C/WPLl2YlBDH0QtoSuUwxybb4YovPaQ3HYxB2rbDRWJaEX8ADr/ZbFgT4qB8+nYQ==
X-Gm-Message-State: AOJu0YxQnFYB3kKfh/SsS3+RffRrOJTzNiy+XXmQ0FFYQGp/fec0P3eX
	Em/mHoJStivtO5AFAOQGckVNaM7PDtjIDpDy+wTsdeqB9JQylm7dsoz30jL33+SpHxTyuQvnmyE
	PKC5gssIyZQ+eGVGtsBsFcK4dSVk=
X-Google-Smtp-Source: AGHT+IE6huE6GGv62WQGS1xTcRTtBIpI25U1oPeV5YFdqnWlUQOzWCmweYnukjNdc8+hidtCAD5QzC/BO5+O5Of+yXA=
X-Received: by 2002:a17:906:e28b:b0:a46:2039:e8ff with SMTP id
 gg11-20020a170906e28b00b00a462039e8ffmr448949ejb.39.1710470276700; Thu, 14
 Mar 2024 19:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 15 Mar 2024 10:37:45 +0800
Message-ID: <CAKHoSAtj-TKqwgVkXZMSDfiKYNe=T4_pb=U8-xcxv2cUQqCKGw@mail.gmail.com>
Subject: WARNING in perf_cgroup_switch
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72  (tag: v6.8-rc7)

git tree: upstream

console output: https://pastebin.com/raw/JUHdKvrL

kernel config: https://pastebin.com/raw/UriWWdtC

C reproducer: https://pastebin.com/raw/LbJ4dUAF

Syzlang reproducer: https://pastebin.com/raw/anTbwgS5

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

------------[ cut here ]------------
WARNING: CPU: 0 PID: 191666 at kernel/events/core.c:859
perf_cgroup_switch+0x204/0x270 kernel/events/core.c:859
Modules linked in:
CPU: 0 PID: 191666 Comm: syz-executor.6 Not tainted 6.8.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:perf_cgroup_switch+0x204/0x270 kernel/events/core.c:859
Code: ef ff 4c 89 e7 e8 6c 88 8c 02 e8 f7 eb ef ff 48 89 ef e8 5f 88
8c 02 5b 5d 41 5c 41 5d 41 5e e9 e2 eb ef ff e8 dd eb ef ff 90 <0f> 0b
90 e9 89 fe ff ff e8 5f b4 1c 00 e9 71 fe ff ff 4c 89 e7 e8
RSP: 0018:ffff88816802f8c8 EFLAGS: 00010012
RAX: ffff888104952f80 RBX: ffffffffa9c143c0 RCX: ffffffffa64e48c3
RDX: 0000000040000000 RSI: 0000000000000004 RDI: ffff8881c0034084
RBP: ffff8881c0033fc0 R08: 0000000000002001 R09: fffffbfff548507b
R10: fffffbfff548507a R11: ffffffffaa4283d3 R12: ffff8881c00340b0
R13: 0000000000000000 R14: ffff8881049538d8 R15: ffff888104952f80
FS:  00007f97672de700(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c67bd50c0 CR3: 000000010db06003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __perf_event_task_sched_out+0x12a/0x1050 kernel/events/core.c:3683
 perf_event_task_sched_out include/linux/perf_event.h:1507 [inline]
 prepare_task_switch kernel/sched/core.c:5204 [inline]
 context_switch kernel/sched/core.c:5347 [inline]
 __schedule+0xbd5/0x2100 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x68/0x140 kernel/sched/core.c:6817
 futex_wait_queue+0xc3/0x160 kernel/futex/waitwake.c:370
 __futex_wait+0x256/0x360 kernel/futex/waitwake.c:669
 futex_wait+0xde/0x180 kernel/futex/waitwake.c:697
 do_futex+0x2b4/0x330 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1b1/0x400 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb4/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9767fb1c8d
Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97672ddc98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f97680ed120 RCX: 00007f9767fb1c8d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f97680ed128
RBP: 00007f97680ed128 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f97680ed12c
R13: 00007ffe6612df6f R14: 00007ffe6612e110 R15: 00007f97672ddd80
 </TASK>
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 191687 at kernel/events/core.c:834
perf_cgroup_set_timestamp kernel/events/core.c:834 [inline]
WARNING: CPU: 0 PID: 191687 at kernel/events/core.c:834
ctx_sched_in+0x44a/0x560 kernel/events/core.c:3910
Modules linked in:
CPU: 0 PID: 191687 Comm: syz-executor.0 Tainted: G        W
6.8.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:perf_cgroup_set_timestamp kernel/events/core.c:834 [inline]
RIP: 0010:ctx_sched_in+0x44a/0x560 kernel/events/core.c:3910
Code: 00 00 44 8b 6d 70 e9 7b fc ff ff e8 a0 05 f0 ff 0f b6 d3 48 8d
75 38 48 89 ef e8 01 fa ff ff e9 24 fd ff ff e8 87 05 f0 ff 90 <0f> 0b
90 e9 9f fe ff ff 4c 89 c7 48 89 44 24 18 e8 f1 ce 1c 00 48
RSP: 0018:ffff88817925f9f0 EFLAGS: 00010082
RAX: 0000000000040000 RBX: 0000000000000002 RCX: ffffffff816e2f19
RDX: 0000000000002b70 RSI: ffffc9001f7f8000 RDI: ffff8881c0034084
RBP: ffff888153538e00 R08: 00000221966807f5 R09: ffffed102f24bf49
R10: ffffed102f24bf48 R11: 0000000000000003 R12: 0000000000000000
R13: ffff88810f39f800 R14: fffffdde6997f80b R15: ffff8881c0033fc0
FS:  00007f7176579700(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 000000013b6d2005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 perf_event_sched_in+0x32/0x70 kernel/events/core.c:2677
 ctx_resched+0x82/0xe0 kernel/events/core.c:2736
 __perf_install_in_context+0x2f1/0x820 kernel/events/core.c:2807
 remote_function kernel/events/core.c:92 [inline]
 remote_function+0x111/0x1a0 kernel/events/core.c:72
 csd_do_func kernel/smp.c:133 [inline]
 generic_exec_single kernel/smp.c:404 [inline]
 generic_exec_single+0x14f/0x390 kernel/smp.c:390
 smp_call_function_single+0x2bb/0x3a0 kernel/smp.c:647
 task_function_call+0xce/0x150 kernel/events/core.c:120
 perf_install_in_context+0x23e/0x480 kernel/events/core.c:2909
 __do_sys_perf_event_open+0x10a2/0x1d50 kernel/events/core.c:12768
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb4/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f717724cc8d
Code: c3 e8 17 32 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7176578bf8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f7177388120 RCX: 00007f717724cc8d
RDX: ffffffffffffffff RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f71772aa4af R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc524ce3ef R14: 00007ffc524ce590 R15: 00007f7176578d80
 </TASK>
---[ end trace 0000000000000000 ]---
netlink: 608 bytes leftover after parsing attributes in process
`syz-executor.0'.
netlink: 608 bytes leftover after parsing attributes in process
`syz-executor.0'.
netlink: 608 bytes leftover after parsing attributes in process
`syz-executor.0'.
netlink: 76 bytes leftover after parsing attributes in process `syz-executor.6'.
netlink: 76 bytes leftover after parsing attributes in process `syz-executor.6'.
netlink: 76 bytes leftover after parsing attributes in process `syz-executor.6'.
netlink: 77364 bytes leftover after parsing attributes in process
`syz-executor.5'.
netlink: 77364 bytes leftover after parsing attributes in process
`syz-executor.5'.
netlink: 77364 bytes leftover after parsing attributes in process
`syz-executor.5'.
audit: type=1326 audit(6914317446.261:390): auid=0 uid=0 gid=0 ses=4
subj=system_u:system_r:kernel_t:s0 pid=193378 comm="syz-executor.3"
exe="/syz-executor.3" sig=31 arch=c000003e syscall=202 compat=0
ip=0x7f716584dc8d code=0x0
pimreg: entered allmulticast mode
netlink: 'syz-executor.2': attribute type 27 has an invalid length.
netlink: 12 bytes leftover after parsing attributes in process `syz-executor.2'.
kvm: pic: non byte read
kvm: pic: level sensitive irq not supported
kvm: pic: non byte read
kvm: pic: level sensitive irq not supported
kvm: pic: non byte read
kvm: pic: non byte read
kvm: pic: non byte read
kvm: pic: non byte read
kvm: pic: non byte read
kvm: pic: non byte read
kvm: pic: non byte read
kvm: pic: non byte read
audit: type=1326 audit(6914317447.111:391): auid=0 uid=0 gid=0 ses=4
subj=system_u:system_r:kernel_t:s0 pid=193497 comm="syz-executor.3"
exe="/syz-executor.3" sig=31 arch=c000003e syscall=202 compat=0
ip=0x7f716584dc8d code=0x0

