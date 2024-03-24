Return-Path: <linux-kernel+bounces-112608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF8D887BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169951C21422
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C414A89;
	Sun, 24 Mar 2024 07:02:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53033CA
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711263725; cv=none; b=spZfUm9YCThmAg2vYaFJYvNngt/1QiDhdo1Mb3zjaMSWMg32EcAriVBIUahGSlwGjiEOhsmF0SBc1wGwVaFMTzcj3owTedBMRupO5EQUP5W/C65yWMKVz3miblE8dfavas1W5tEk/z5CjPoCiA9OwkenJPzb1EHLfsth4V+GQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711263725; c=relaxed/simple;
	bh=2YFpLBMNc0SGVHyRLSaQ4Ud1NyWSBuvE5ltoiWDi6hg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qByBE5JX3jBr3edBTsmm12rJWoZ36kjJyy383ocAPC97sOpEguilUcZoerq0UAMYK3RUVt3AxFgIrYS/V8xAMC8MBarhR8I/FE7iCaECKG9VUDDedQKvS7XcHZcOv3PjiBw+BwG9SEskU3FP3Dcue7pZh2Mr1xaB67ViCcVOois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso360121239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 00:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711263722; x=1711868522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szCFvUD70ptRQMFo7Rcf67TelpVBICGDGxPcusOmkO8=;
        b=ZpaStCpnMOHGuDruLT8IYuea6r30dlrZRq7DIO8JeE7u/6gYGt7ftl/1y9fRjPsCgg
         fBd88uG7Ymm9vkNGe5v42Cz1nJ98E4oH+IITwA+1pSuhdqVMR+J+prtwkIwiM7vZDCzf
         mZXA7WL5uQpsmvCfP/YuZK47ePIPekozhzt0eo9GW3T7uAjb/nboZAJ7xQt3dB2J5x1c
         ZKLh6ReLwysY/seRyrkayxb70dhFbCHLDpM4p9rXLpOVWOyPjKvmBz4bzo3dfE/OrzYx
         no5w3jYU7Jdmvyzt/Rd1jjXa9O4t+GwX+iGg6ya5yH1vlBTcxbOVjMvLX4PNL107VZ3n
         b2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVciaYiHu+UWZ7BLuD4N/lOsTsQwfXixObs6hbdNzoin6vaSfnmcdo2YPqMBLnPqSlwqigm0Ged+nqM2esVJxiePok2KXOrK2oDlOEq
X-Gm-Message-State: AOJu0YyIPoLUxSDpb/mN409KnuYwUwnkiWxWFHfSrHgjk2934vQJ/uJR
	SGgLUVO/50o6vYeE5mp0lsNVOd2ePzXErzGoAFHqa27EeGFvQ/j5V3ripQM6tb4kVq+R6jue5xd
	HhQ9/Xj+egzGZWVjiQEabThmdPJeHnL9FMApM5ZtdcjkhNRX6zZP9tAc=
X-Google-Smtp-Source: AGHT+IEuEmo9r4v4aiqbK0CALYrjmSVAOVX7Dk1vnvKsZclS6lxrl4vnU4l03A3Rzaibrg1AZXgL0SJGQ3vQD4ZkS58LVyRKvW6c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4111:b0:47c:184a:42c0 with SMTP id
 ay17-20020a056638411100b0047c184a42c0mr46445jab.1.1711263722676; Sun, 24 Mar
 2024 00:02:02 -0700 (PDT)
Date: Sun, 24 Mar 2024 00:02:02 -0700
In-Reply-To: <tencent_C8BEBAAEBB1A33CC9E9E1B1E4B461B882508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004eb4c4061462a246@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in do_new_mount (2)
From: syzbot <syzbot+f59c2feaf7cb5988e877@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in __fdget_pos

INFO: task syz-executor.2:5529 blocked for more than 143 seconds.
      Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28792 pid:5529  ppid:5388   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x187f/0x4970 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6845
 __mutex_lock_common+0xe6b/0x2380 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:799
 __fdget_pos+0x2c1/0x370 fs/file.c:1062
 fdget_pos include/linux/file.h:74 [inline]
 __do_sys_getdents64 fs/readdir.c:365 [inline]
 __se_sys_getdents64+0x1dc/0x4f0 fs/readdir.c:354
 do_syscall_64+0x46/0xc0
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7f7b1747dda9
RSP: 002b:00007f7b1812d0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f7b175ac050 RCX: 00007f7b1747dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f7b174ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f7b175ac050 R15: 00007ffe0719f878
 </TASK>
INFO: task syz-executor.1:5544 blocked for more than 144 seconds.
      Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:29360 pid:5544  ppid:5389   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x187f/0x4970 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6845
 __mutex_lock_common+0xe6b/0x2380 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:799
 __fdget_pos+0x2c1/0x370 fs/file.c:1062
 fdget_pos include/linux/file.h:74 [inline]
 __do_sys_getdents64 fs/readdir.c:365 [inline]
 __se_sys_getdents64+0x1dc/0x4f0 fs/readdir.c:354
 do_syscall_64+0x46/0xc0
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7f85ae47dda9
RSP: 002b:00007f85ad7fe0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f85ae5ac050 RCX: 00007f85ae47dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f85ae4ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f85ae5ac050 R15: 00007fff4f482218
 </TASK>
INFO: task syz-executor.4:5547 blocked for more than 145 seconds.
      Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:29360 pid:5547  ppid:5394   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x187f/0x4970 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6845
 __mutex_lock_common+0xe6b/0x2380 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:799
 __fdget_pos+0x2c1/0x370 fs/file.c:1062
 fdget_pos include/linux/file.h:74 [inline]
 __do_sys_getdents64 fs/readdir.c:365 [inline]
 __se_sys_getdents64+0x1dc/0x4f0 fs/readdir.c:354
 do_syscall_64+0x46/0xc0
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7f3a6fa7dda9
RSP: 002b:00007f3a707b90c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f3a6fbac050 RCX: 00007f3a6fa7dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f3a6faca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f3a6fbac050 R15: 00007ffc33ae2ae8
 </TASK>
INFO: task syz-executor.3:5555 blocked for more than 146 seconds.
      Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:29360 pid:5555  ppid:5387   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x187f/0x4970 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6845
 __mutex_lock_common+0xe6b/0x2380 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:799
 __fdget_pos+0x2c1/0x370 fs/file.c:1062
 fdget_pos include/linux/file.h:74 [inline]
 __do_sys_getdents64 fs/readdir.c:365 [inline]
 __se_sys_getdents64+0x1dc/0x4f0 fs/readdir.c:354
 do_syscall_64+0x46/0xc0
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7fc6b007dda9
RSP: 002b:00007fc6b0e5c0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007fc6b01ac050 RCX: 00007fc6b007dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fc6b00ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fc6b01ac050 R15: 00007fff5c668248
 </TASK>
INFO: task syz-executor.0:5556 blocked for more than 146 seconds.
      Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29360 pid:5556  ppid:5393   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x187f/0x4970 kernel/sched/core.c:6710
 schedule+0xc3/0x180 kernel/sched/core.c:6786
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6845
 __mutex_lock_common+0xe6b/0x2380 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:799
 __fdget_pos+0x2c1/0x370 fs/file.c:1062
 fdget_pos include/linux/file.h:74 [inline]
 __do_sys_getdents64 fs/readdir.c:365 [inline]
 __se_sys_getdents64+0x1dc/0x4f0 fs/readdir.c:354
 do_syscall_64+0x46/0xc0
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7ff50387dda9
RSP: 002b:00007ff5045a70c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007ff5039ac050 RCX: 00007ff50387dda9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007ff5038ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007ff5039ac050 R15: 00007ffeb4f70208
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8d72b470 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd30 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8d72b830 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd30 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8d72b2a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by kworker/u4:2/29:
1 lock held by udevd/4478:
2 locks held by getty/4775:
 #0: ffff88814b316098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b1/0x1dc0 drivers/tty/n_tty.c:2187
3 locks held by syz-executor.2/5525:
1 lock held by syz-executor.2/5529:
 #0: ffff88802ba85c48 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2c1/0x370 fs/file.c:1062
3 locks held by syz-executor.1/5537:
1 lock held by syz-executor.1/5544:
 #0: ffff88802bd45248 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2c1/0x370 fs/file.c:1062
3 locks held by syz-executor.4/5541:
1 lock held by syz-executor.4/5547:
 #0: ffff8880294525c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2c1/0x370 fs/file.c:1062
3 locks held by syz-executor.3/5550:
1 lock held by syz-executor.3/5555:
 #0: ffff88802d6f8348 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2c1/0x370 fs/file.c:1062
3 locks held by syz-executor.0/5552:
1 lock held by syz-executor.0/5556:
 #0: ffff88802288a848 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x2c1/0x370 fs/file.c:1062
1 lock held by syz-executor.1/5838:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec8/0xf10 kernel/hung_task.c:379
 kthread+0x2ec/0x390 kernel/kthread.c:389
 ret_from_fork+0x32/0x60 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:304
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 12278 Comm: syz-executor.1 Not tainted 6.5.0-rc4-syzkaller-00229-g0a2c2baafa31 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:smk_access_entry security/smack/smack_access.c:86 [inline]
RIP: 0010:smk_tskacc+0x223/0x360 security/smack/smack_access.c:234
Code: e8 12 bb ee fd 49 8b 36 bf 20 00 00 00 e8 75 1b 00 00 84 c0 74 1e e8 dc 4b 94 fd e9 81 00 00 00 e8 d2 4b 94 fd 45 31 e4 eb 77 <e8> c8 4b 94 fd 45 31 e4 eb 6d e8 be 4b 94 fd 45 89 ec eb 63 48 83
RSP: 0018:ffffc9000392f648 EFLAGS: 00000246
RAX: 1ffff11005d742c4 RBX: ffffffff8dd06320 RCX: ffff88801ab8bb80
RDX: ffff88801ab8bb80 RSI: 0000000000000000 RDI: 00000000ffffffff
RBP: ffff88802eba1620 R08: ffffffff83fbda6b R09: 0000000000000000
R10: ffffc9000392f708 R11: fffff52000725ee5 R12: ffffffff8b7195c0
R13: ffffffff8b7195c0 R14: ffff88802eba1620 R15: dffffc0000000000
FS:  00007fa55a5076c0(0000) GS:ffff8880b9600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557549788 CR3: 000000002b9f4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 smack_inode_permission+0x2dc/0x380 security/smack/smack_lsm.c:1158
 security_inode_permission+0xa5/0x100 security/security.c:2072
 may_lookup fs/namei.c:1720 [inline]
 link_path_walk+0x2da/0xe80 fs/namei.c:2267
 path_openat+0x249/0x31e0 fs/namei.c:3789
 do_filp_open+0x234/0x490 fs/namei.c:3820
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
 do_syscall_64+0x46/0xc0
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7fa55987c9a0
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 09 82 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 5c 82 02 00 8b 44
RSP: 002b:00007fa55a506e30 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa55987c9a0
RDX: 0000000000000002 RSI: 00007fa55a506f40 RDI: 00000000ffffff9c
RBP: 00007fa55a506f40 R08: 0000000000000000 R09: 00000000000014f8
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
R13: 00007fa55a506f80 R14: 00007fa55a506f40 R15: 00007fa5507ff000
 </TASK>


Tested on:

commit:         0a2c2baa proc: fix missing conversion to 'iterate_shar..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116e4711180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52460339570262b2
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c2feaf7cb5988e877
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

