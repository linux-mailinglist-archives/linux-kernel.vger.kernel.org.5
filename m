Return-Path: <linux-kernel+bounces-90663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D808E8702DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33F1F25A24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3B3F8C8;
	Mon,  4 Mar 2024 13:37:43 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38D3E497
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559462; cv=none; b=Eh/NJvQni6ji0lKWmVhxmoze/q+YQ84YSxA/Z+oP4HQdqIC/BuJBFSwA2CXp401TAkNBvBvMSct4VjFUCpadp2LkF88P+LT/l7gpCKRnbZLmLgE6k8LNjltPk5IercboxKt5f4ISUmoS/8Kx9KVMtTx+lhR75Ic93g5WK+9hXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559462; c=relaxed/simple;
	bh=8wfVtvDBv+gK5wrT/UUuQKAIRV34sX+Pz4mgrJEQS4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r+a0Eqcz4BYhWdu/IBYz5KNFm8lzv/X9ojppkmpmDsFEz+FgtBcHUXu6296LS48Oz5LDrW1P7q2H5Uaiu5cgmH/D2AUDImi8gJLJexRqAMnlNLz+KYrsBsCBo/+czAALeU0VQuJ0/T+nGSG4iiJYPBPLkMMtRzbjwO93m9xeHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.159])
	by sina.com (172.16.235.25) with ESMTP
	id 65E5CE93000021B6; Mon, 4 Mar 2024 21:37:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 75886134210591
X-SMAIL-UIID: B0EB2A5B73174825B40F0FE26A3AA73F-20240304-213725-1
From: Hillf Danton <hdanton@sina.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	xingwei lee <xrivendell7@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Bug] INFO: task hung in hub_activate
Date: Mon,  4 Mar 2024 21:37:16 +0800
Message-Id: <20240304133716.1401-1-hdanton@sina.com>
In-Reply-To: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 4 Mar 2024 20:10:02 +0800 Sam Sun <samsun1006219@gmail.com>
> Dear developers and maintainers,
> 
> We encountered a task hung in function hub_activate(). It was reported
> before by Syzbot several years ago
> (https://groups.google.com/g/syzkaller-lts-bugs/c/_komEgHj03Y/m/rbcVKyLXBwAJ),
> but no repro at that time. We have a C repro this time and kernel
> config is attached to this email. The bug report is listed below.

Thanks for your report.
> 
> ```
> INFO: task kworker/0:3:4535 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:3     state:D stack:28176 pid:4535  tgid:4535  ppid:2
>    flags:0x00004000
> Workqueue: events_power_efficient hub_init_func2
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x509/0x940 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  hub_activate+0x320/0x1df0 drivers/usb/core/hub.c:1048
>  process_one_work+0x878/0x15c0 kernel/workqueue.c:2627
>  process_scheduled_works kernel/workqueue.c:2700 [inline]
>  worker_thread+0x855/0x1200 kernel/workqueue.c:2781
>  kthread+0x2cc/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: task kworker/0:4:7627 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:4     state:D stack:28176 pid:7627  tgid:7627  ppid:2
>    flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x509/0x940 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  hub_event+0x1b0/0x4cd0 drivers/usb/core/hub.c:5768
>  process_one_work+0x878/0x15c0 kernel/workqueue.c:2627
>  process_scheduled_works kernel/workqueue.c:2700 [inline]
>  worker_thread+0x855/0x1200 kernel/workqueue.c:2781
>  kthread+0x2cc/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: task syz-executor111:8108 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor111 state:D stack:25600 pid:8108  tgid:8108
> ppid:8106   flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x509/0x940 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  usb_deauthorize_interface+0x4d/0x130 drivers/usb/core/message.c:1789
>  interface_authorized_store+0xaf/0x110 drivers/usb/core/sysfs.c:1178
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f78ff4f187d
> RSP: 002b:00007ffdb1de8df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f78ff4f187d
> RDX: 0000000000000015 RSI: 0000000020000040 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f78ff546bb5
> R10: 0000000000000011 R11: 0000000000000246 R12: 00007f78ff54204e
> R13: 00007ffdb1de9058 R14: 00007ffdb1de8e20 R15: 00007ffdb1de8e10
>  </TASK>
> INFO: task syz-executor111:8110 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor111 state:D stack:28096 pid:8110  tgid:8110
> ppid:8107   flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x509/0x940 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  usb_deauthorize_device+0x2a/0x110 drivers/usb/core/hub.c:2633
>  authorized_store+0x122/0x140 drivers/usb/core/sysfs.c:747
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f78ff4f187d
> RSP: 002b:00007ffdb1de8df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f78ff4f187d
> RDX: 0000000000000015 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f78ff546bb5
> R10: 0000000000000013 R11: 0000000000000246 R12: 00007f78ff54204e
> R13: 00007ffdb1de9058 R14: 00007ffdb1de8e20 R15: 00007ffdb1de8e10
>  </TASK>
> INFO: task syz-executor111:8113 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor111 state:D stack:27984 pid:8113  tgid:8113
> ppid:8109   flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  kernfs_drain+0x36c/0x550 fs/kernfs/dir.c:505
>  __kernfs_remove+0x280/0x650 fs/kernfs/dir.c:1465
>  kernfs_remove_by_name_ns+0xb4/0x130 fs/kernfs/dir.c:1673
>  kernfs_remove_by_name include/linux/kernfs.h:623 [inline]
>  remove_files+0x96/0x1c0 fs/sysfs/group.c:28
>  sysfs_remove_group+0x8b/0x180 fs/sysfs/group.c:292
>  sysfs_remove_groups fs/sysfs/group.c:316 [inline]
>  sysfs_remove_groups+0x60/0xa0 fs/sysfs/group.c:308
>  device_remove_groups drivers/base/core.c:2734 [inline]
>  device_remove_attrs+0x192/0x290 drivers/base/core.c:2909
>  device_del+0x391/0xa30 drivers/base/core.c:3813
>  usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1416
>  usb_set_configuration+0x1243/0x1c40 drivers/usb/core/message.c:2063
>  usb_deauthorize_device+0xe4/0x110 drivers/usb/core/hub.c:2638
>  authorized_store+0x122/0x140 drivers/usb/core/sysfs.c:747
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f78ff4f187d
> RSP: 002b:00007ffdb1de8df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f78ff4f187d
> RDX: 0000000000000015 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f78ff546bb5
> R10: 0000000000000013 R11: 0000000000000246 R12: 00007f78ff54204e
> R13: 00007ffdb1de9058 R14: 00007ffdb1de8e20 R15: 00007ffdb1de8e10
>  </TASK>
> INFO: task syz-executor111:8112 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor111 state:D stack:28224 pid:8112  tgid:8112
> ppid:8111   flags:0x00000006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0xcea/0x59e0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0xe9/0x270 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x509/0x940 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  usb_deauthorize_device+0x2a/0x110 drivers/usb/core/hub.c:2633
>  authorized_store+0x122/0x140 drivers/usb/core/sysfs.c:747
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f78ff4f187d
> RSP: 002b:00007ffdb1de8df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f78ff4f187d
> RDX: 0000000000000015 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f78ff546bb5
> R10: 0000000000000013 R11: 0000000000000246 R12: 00007f78ff54204e
> R13: 00007ffdb1de9058 R14: 00007ffdb1de8e20 R15: 00007ffdb1de8e10
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/32:
>  #0: ffffffff8cfa9a60 (rcu_read_lock){....}-{1:2}, at:
> rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
>  #0: ffffffff8cfa9a60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
> include/linux/rcupdate.h:747 [inline]
>  #0: ffffffff8cfa9a60 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
> 3 locks held by kworker/0:3/4535:
>  #0: ffff88801307a138
> ((wq_completion)events_power_efficient){+.+.}-{0:0}, at:
> process_one_work+0x77b/0x15c0 kernel/workqueue.c:2602
>  #1: ffffc90002a1fd88
> ((work_completion)(&(&hub->init_work)->work)){+.+.}-{0:0}, at:
> process_one_work+0x7dd/0x15c0 kernel/workqueue.c:2603
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:992 [inline]
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at:
> hub_activate+0x320/0x1df0 drivers/usb/core/hub.c:1048
> 3 locks held by kworker/0:4/7627:
>  #0: ffff888013f4ed38 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
> process_one_work+0x77b/0x15c0 kernel/workqueue.c:2602
>  #1: ffffc9000fe27d88 ((work_completion)(&hub->events)){+.+.}-{0:0},
> at: process_one_work+0x7dd/0x15c0 kernel/workqueue.c:2603
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:992 [inline]
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at:
> hub_event+0x1b0/0x4cd0 drivers/usb/core/hub.c:5768
> 4 locks held by syz-executor111/8108:
>  #0: ffff88801d00a418 (sb_writers#5){.+.+}-{0:0}, at:
> ksys_write+0x122/0x250 fs/read_write.c:637
>  #1: ffff88801d83d488 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write_iter+0x27c/0x500 fs/kernfs/file.c:325
>  #2: ffff888019fd5e88 (kn->active#63){++++}-{0:0}, at:
> kernfs_fop_write_iter+0x2a0/0x500 fs/kernfs/file.c:326
>  #3: ffff88801c280190 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:992 [inline]
>  #3: ffff88801c280190 (&dev->mutex){....}-{3:3}, at:
> usb_deauthorize_interface+0x4d/0x130 drivers/usb/core/message.c:1789
> 3 locks held by syz-executor111/8110:
>  #0: ffff88801d00a418 (sb_writers#5){.+.+}-{0:0}, at:
> ksys_write+0x122/0x250 fs/read_write.c:637
>  #1: ffff888019becc88 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write_iter+0x27c/0x500 fs/kernfs/file.c:325
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:992 [inline]
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at:
> usb_deauthorize_device+0x2a/0x110 drivers/usb/core/hub.c:2633
> 4 locks held by syz-executor111/8113:
>  #0: ffff88801d00a418 (sb_writers#5){.+.+}-{0:0}, at:
> ksys_write+0x122/0x250 fs/read_write.c:637
>  #1: ffff8881098b4c88 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write_iter+0x27c/0x500 fs/kernfs/file.c:325
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:992 [inline]
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at:
> usb_deauthorize_device+0x2a/0x110 drivers/usb/core/hub.c:2633
>  #3: ffff888019fd5e88 (kn->active#63){++++}-{0:0}, at:
> __kernfs_remove+0x280/0x650 fs/kernfs/dir.c:1465
> 3 locks held by syz-executor111/8112:
>  #0: ffff88801d00a418 (sb_writers#5){.+.+}-{0:0}, at:
> ksys_write+0x122/0x250 fs/read_write.c:637
>  #1: ffff88810503f488 (&of->mutex){+.+.}-{3:3}, at:
> kernfs_fop_write_iter+0x27c/0x500 fs/kernfs/file.c:325
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:992 [inline]
>  #2: ffff88801c280190 (&dev->mutex){....}-{3:3}, at:
> usb_deauthorize_device+0x2a/0x110 drivers/usb/core/hub.c:2633
> 
> =============================================
> 
> NMI backtrace for cpu 1
> CPU: 1 PID: 32 Comm: khungtaskd Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xe7a/0x1100 kernel/hung_task.c:379
>  kthread+0x2cc/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 4522 Comm: systemd-journal Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
> RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:127 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:178 [inline]
> RIP: 0010:kasan_check_range+0x10e/0x190 mm/kasan/generic.c:187
> Code: 5d 41 5c c3 44 89 c2 e8 f0 ed ff ff 83 f0 01 5b 5d 41 5c c3 48
> 85 d2 74 e1 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 d3 80 38 00 <74> f2
> eb b1 41 bc 08 00 00 00 45 29 dc 49 8d 14 2c eb 0c 48 83 c0
> RSP: 0018:ffffc9000273fa88 EFLAGS: 00000046
> RAX: fffffbfff23e55d2 RBX: fffffbfff23e55d3 RCX: ffffffff816515ee
> RDX: fffffbfff23e55d3 RSI: 0000000000000008 RDI: ffffffff91f2ae90
> RBP: fffffbfff23e55d2 R08: 0000000000000000 R09: fffffbfff23e55d2
> R10: ffffffff91f2ae97 R11: 0000000000000000 R12: ffff8881078d0b80
> R13: 0000000000000000 R14: ffff8881078d00c0 R15: 00000000000400b2
> FS:  00007f26bae49900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f26b911d000 CR3: 000000001b582000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  instrument_atomic_read include/linux/instrumented.h:68 [inline]
>  _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
>  hlock_class+0x4e/0x120 kernel/locking/lockdep.c:228
>  check_wait_context kernel/locking/lockdep.c:4774 [inline]
>  __lock_acquire+0x42d/0x3bb0 kernel/locking/lockdep.c:5087
>  lock_acquire kernel/locking/lockdep.c:5754 [inline]
>  lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5719
>  __fs_reclaim_acquire mm/page_alloc.c:3693 [inline]
>  fs_reclaim_acquire+0x100/0x150 mm/page_alloc.c:3707
>  might_alloc include/linux/sched/mm.h:303 [inline]
>  slab_pre_alloc_hook mm/slab.h:710 [inline]
>  slab_alloc_node mm/slab.c:3221 [inline]
>  slab_alloc mm/slab.c:3246 [inline]
>  __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
>  kmem_cache_alloc+0x3d/0x370 mm/slab.c:3432
>  getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
>  getname_flags include/linux/audit.h:321 [inline]
>  getname+0x92/0xd0 fs/namei.c:219
>  do_sys_openat2+0xe8/0x1c0 fs/open.c:1431
>  do_sys_open fs/open.c:1452 [inline]
>  __do_sys_openat fs/open.c:1468 [inline]
>  __se_sys_openat fs/open.c:1463 [inline]
>  __x64_sys_openat+0x140/0x1f0 fs/open.c:1463
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7f26bb3171a4
> Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c
> 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
> RSP: 002b:00007ffdb19f8290 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000555698ac1590 RCX: 00007f26bb3171a4
> RDX: 0000000000080802 RSI: 0000555698af7f50 RDI: 00000000ffffff9c
> RBP: 0000555698af7f50 R08: 0000000000000000 R09: ffffffffffffff01
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080802
> R13: 00000000fffffffa R14: 0000555698ac5eb0 R15: 0000000000000002
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.608 msecs
> ```
> 
> If you have any questions, please contact us.
> 
> Reported by Yue Sun <samsun1006219@gmail.com>
> Reported by xingwei lee <xrivendell7@gmail.com>
> 
> Best Regards,
> Yue

	syz-executor111/8108			syz-executor111/8113:
	 #2: ffff888019fd5e88 (kn->active#63)
						 #2: ffff88801c280190 (&dev->mutex)
						 #3: ffff888019fd5e88 (kn->active#63)
	 #3: ffff88801c280190 (&dev->mutex)

	deadlock behind task hung cause of dev->mutex, another case of
	known issue [1].

[1] https://lore.kernel.org/lkml/d314e471-0251-461e-988d-70add0c6ebf6@I-love.SAKURA.ne.jp/

