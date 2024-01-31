Return-Path: <linux-kernel+bounces-45954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F9843853
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7103D1F2277D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AE75577C;
	Wed, 31 Jan 2024 07:54:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727C5B5DB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687648; cv=none; b=qdd5M4t0QdWraXzQXoVvTGTA2YdNoBS5H/JbNFD3rqnFy6uVSdISDOdGZQub7AIL7u49R+OIDtYGIkFhFMWWpKlsQsmo65gnHOEEnJW1ebEt0eWbQmpeJgvGe+7hPzDpJTlI2rkHzECjlm3L+X4Yw7yb2Zs5oO7S0GMtQuztQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687648; c=relaxed/simple;
	bh=beo6gSt1QAsAaPVlslJWxP8U50mMSGq9m9ZM0VfL2no=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xll6pgJXi4OfK8p4ruuTU9x+ZsKw6EwYGazib67H7ydmsInjZZTATkX4L+lftGwuAnX+ivvUDSDZkmbx62n7o+VonjCgQQfZQw5d+X+ot3dan4arPVvZAHkWqvHOWfDk16u7IGvXA4ZEupv37tB2HyE8mWha1UVh0ZHo+Qb0ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3639649adcaso4261105ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706687644; x=1707292444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p93KU6zvtWa6b62+WyYFBv21CrkgACZJkqwgxMh5FXU=;
        b=uYDXvWeGNmjUSPbJOaD81P03Q7I+Kd9vvt57uLfSoa8uvyCTLZGs7uDXS7Tn2EtFcq
         o9WWid7Oa/MeTsWZuFWHOlL/dSqmFvD/Kyki7xP73OOp/ryL/QMjDJMMTAewZ92UEfMj
         qGysnXZluzl6mjVEprk3yPdbfGVcnktm5fnHNexzHXn9cp42LxyLYhgob/6OkshAUfvO
         cdKPIvjLallzUdQt1GJMVxaUVS1q+vVeK8YHd2imLf4cGmRfS4zJfK7D+vlk9mQuUv3i
         oQjMZS+JmyjJ/HxgAAbeotmRpTR23m/rNJfeSN0iUytvIOpigpWzzFp1akg+Ns0Hia0j
         JwQQ==
X-Gm-Message-State: AOJu0YxVulYnnXEtVjQAJlpSAlJQm2S9hy1pAQ3PHyzDK3YxW+7Klk+J
	bhk+P/I8NkhUX20/GpkEomsv0MZciuIfUIIGss8+Np8tKDshjae0k3SUQjzQocfwwYwtiqKRbqt
	YJ4RCoHD7/SoLvQ+sgbIc/KubjtLVwKr+W8gqtXk/PHal49Ik4/g4JM8=
X-Google-Smtp-Source: AGHT+IG2bTbqWhT0IG7S7Th7RyMYLTXl8A5QSBgZyrZUWdPmmLgUT+aphNQf4+ywE5OtzxkV1oSCmw0KUpOThoSDC2vZuXou237r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c9:b0:363:8336:b256 with SMTP id
 r9-20020a056e0219c900b003638336b256mr107994ill.3.1706687644579; Tue, 30 Jan
 2024 23:54:04 -0800 (PST)
Date: Tue, 30 Jan 2024 23:54:04 -0800
In-Reply-To: <tencent_BCCCBAE7D686E812D8067B09826EF6EEC506@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc407e0610392e4d@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_setup

INFO: task syz-executor.3:5666 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:27776 pid:5666  tgid:5665  ppid:5428   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f680bc7cda9
RSP: 002b:00007f680ca220c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f680bdabf80 RCX: 00007f680bc7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f680bcc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f680bdabf80 R15: 00007ffd8f207988
 </TASK>
INFO: task syz-executor.3:5667 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:29536 pid:5667  tgid:5665  ppid:5428   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f680bc7cda9
RSP: 002b:00007f680ca010c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f680bdac050 RCX: 00007f680bc7cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f680bcc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f680bdac050 R15: 00007ffd8f207988
 </TASK>
INFO: task syz-executor.5:5682 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:27776 pid:5682  tgid:5681  ppid:5430   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f950f07cda9
RSP: 002b:00007f950fd610c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f950f1abf80 RCX: 00007f950f07cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f950f0c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f950f1abf80 R15: 00007ffe1f43dd68
 </TASK>
INFO: task syz-executor.5:5683 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29536 pid:5683  tgid:5681  ppid:5430   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f950f07cda9
RSP: 002b:00007f950fd400c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f950f1ac050 RCX: 00007f950f07cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f950f0c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f950f1ac050 R15: 00007ffe1f43dd68
 </TASK>
INFO: task syz-executor.1:5692 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:27776 pid:5692  tgid:5691  ppid:5442   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fbb0187cda9
RSP: 002b:00007fbb025800c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbb019abf80 RCX: 00007fbb0187cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007fbb018c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbb019abf80 R15: 00007ffd83ded188
 </TASK>
INFO: task syz-executor.1:5693 blocked for more than 145 seconds.
      Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:29536 pid:5693  tgid:5691  ppid:5442   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fbb0187cda9
RSP: 002b:00007fbb0255f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbb019ac050 RCX: 00007fbb0187cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007fbb018c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fbb019ac050 R15: 00007ffd83ded188
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
 #0: ffff888013088d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900000e7d80 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888170815240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x1bb/0x26e0 drivers/net/netdevsim/fib.c:1489
1 lock held by khungtaskd/28:
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acbe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
3 locks held by kworker/1:1/34:
 #0: ffff8880289ac138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000aafd80 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff8880206a3240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x1bb/0x26e0 drivers/net/netdevsim/fib.c:1489
2 locks held by kworker/u4:2/36:
 #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffff8880b9928a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
3 locks held by kworker/u4:9/2474:
2 locks held by getty/4818:
 #0: ffff88802e4880a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
2 locks held by kworker/0:5/5077:
 #0: ffff88801308a938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90003c1fd80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
3 locks held by kworker/0:6/5530:
 #0: ffff8880289ac138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90004ff7d80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4129
3 locks held by syz-executor.0/5653:
1 lock held by syz-executor.3/5666:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.3/5667:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.5/5682:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.5/5683:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.1/5692:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.1/5693:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.2/5973:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.2/5974:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.4/5980:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.4/5981:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.0/5985:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.0/5986:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.1/5996:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.1/5997:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.3/5999:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.3/6001:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.5/6003:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.5/6004:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.2/6072:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.2/6073:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.0/6098:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.0/6099:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.4/6111:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.4/6113:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.1/6115:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.1/6116:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.3/6118:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.3/6119:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.5/6123:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.5/6124:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.0/6146:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.2/6150:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:675
1 lock held by syz-executor.2/6151:
 #0: ffff88801f122a20 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:433
1 lock held by syz-executor.4/6159:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
2 locks held by syz-executor.1/6168:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
 #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x6b1/0x800 kernel/rcu/tree_exp.h:995
1 lock held by syz-executor.3/6171:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6612
1 lock held by syz-executor.5/6177:
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8ecc25a8 (rtnl_mutex){+.+.}-{3:3}, at: __rtnl_newlink+0x657/0x1940 net/core/rtnetlink.c:3725

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5666 Comm: syz-executor.3 Not tainted 6.8.0-rc2-syzkaller-g1bbb19b6eb1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:__sanitizer_cov_trace_pc+0x19/0x60 kernel/kcov.c:203
Code: ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 65 48 8b 14 25 80 c2 03 00 65 8b 05 a4 9c 7b 7e a9 00 01 ff 00 <48> 8b 34 24 74 0f f6 c4 01 74 35 8b 82 fc 15 00 00 85 c0 74 2b 8b
RSP: 0018:ffffc9000528f618 EFLAGS: 00000246
RAX: 0000000080000000 RBX: 0000000000000000 RCX: ffffffff81eac359
RDX: ffff88801e088000 RSI: 000000000000003f RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 000000000000003f
R10: 0000000000000000 R11: 0000000000000002 R12: ffff88801417ceb0
R13: 0000000000000000 R14: ffff88801417ceac R15: dffffc0000000000
FS:  00007f680ca226c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff3a50a9a8 CR3: 0000000061d18000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __page_table_check_zero+0x198/0x5e0 mm/page_table_check.c:142
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 relay_alloc_buf kernel/relay.c:121 [inline]
 relay_create_buf kernel/relay.c:162 [inline]
 relay_open_buf.part.0+0x27d/0xba0 kernel/relay.c:384
 relay_open_buf kernel/relay.c:536 [inline]
 relay_open+0x641/0xab0 kernel/relay.c:517
 do_blk_trace_setup+0x4a9/0xaa0 kernel/trace/blktrace.c:618
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:658
 blk_trace_setup+0x47/0x60 kernel/trace/blktrace.c:676
 sg_ioctl_common drivers/scsi/sg.c:1118 [inline]
 sg_ioctl+0x669/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f680bc7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f680ca220c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f680bdabf80 RCX: 00007f680bc7cda9
RDX: 0000000020000040 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f680bcc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f680bdabf80 R15: 00007ffd8f207988
 </TASK>


Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=164d3090180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ec6d0fe80000


