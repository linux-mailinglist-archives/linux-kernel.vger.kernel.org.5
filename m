Return-Path: <linux-kernel+bounces-16249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AA823BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FE01C24C52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBFE18B00;
	Thu,  4 Jan 2024 05:05:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8EF154AD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.178])
	by sina.com (172.16.235.24) with ESMTP
	id 65963C85000057B2; Thu, 4 Jan 2024 13:05:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3914745089410
X-SMAIL-UIID: C8DB516FDAEF42099E75FA5FAE883757-20240104-130513-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>
Cc: krzysztof.kozlowski@linaro.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
Date: Thu,  4 Jan 2024 13:05:00 +0800
Message-Id: <20240104050501.2766-1-hdanton@sina.com>
In-Reply-To: <00000000000026100c060e143e5a@google.com>
References: <00000000000026100c060e143e5a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 03 Jan 2024 16:59:25 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=141bc48de80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6ed2cada0823/disk-453f5db0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1fa106f79073/vmlinux-453f5db0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c75ff5078c5c/bzImage-453f5db0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
> 
> INFO: task kworker/u4:93:7607 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u4:93   state:D stack:20248 pid:7607  tgid:7607  ppid:2      flags:0x00004000
> Workqueue: nfc2_nci_rx_wq nci_rx_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
>  device_lock include/linux/device.h:992 [inline]
>  nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
>  nci_ntf_packet+0x4431/0x4f40
>  nci_rx_work+0x14c/0x2b0 net/nfc/nci/core.c:1522
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
>  kthread+0x2d3/0x370 kernel/kthread.c:388
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: task kworker/0:1:11541 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:1     state:D stack:23280 pid:11541 tgid:11541 ppid:2      flags:0x00004000
> Workqueue: events nfc_urelease_event_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6778
>  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
>  __mutex_lock_common kernel/locking/mutex.c:679 [inline]
>  __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
>  nci_request net/nfc/nci/core.c:149 [inline]
>  nci_stop_poll+0x123/0x480 net/nfc/nci/core.c:873
>  nfc_stop_poll+0xea/0x220 net/nfc/core.c:259
>  nfc_urelease_event_work+0x160/0x2f0 net/nfc/netlink.c:1852
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
>  kthread+0x2d3/0x370 kernel/kthread.c:388
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: task syz-executor.1:27827 blocked for more than 143 seconds.
>       Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.1  state:D stack:25392 pid:27827 tgid:27824 ppid:27038  flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5376 [inline]
>  __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
>  __schedule_loop kernel/sched/core.c:6763 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6778
>  schedule_timeout+0xb0/0x300 kernel/time/timer.c:2143
>  do_wait_for_common kernel/sched/completion.c:95 [inline]
>  __wait_for_common kernel/sched/completion.c:116 [inline]
>  wait_for_common kernel/sched/completion.c:127 [inline]
>  wait_for_completion+0x354/0x620 kernel/sched/completion.c:148
>  __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3192
>  nci_close_device+0x193/0x600 net/nfc/nci/core.c:579
>  nci_unregister_device+0x40/0x240 net/nfc/nci/core.c:1297
>  virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:168
>  __fput+0x3cc/0x9e0 fs/file_table.c:394
>  task_work_run+0x24a/0x300 kernel/task_work.c:180
>  get_signal+0x166e/0x1840 kernel/signal.c:2680
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
>  exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
>  exit_to_user_mode_prepare+0xb1/0x150 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x69/0x2a0 kernel/entry/common.c:296
>  do_syscall_64+0x52/0x110 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fab9d07cce9
> RSP: 002b:00007fab9ddde0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: fffffffffffffff2 RBX: 00007fab9d19bf80 RCX: 00007fab9d07cce9
> RDX: 0000000000000064 RSI: 0000000020000500 RDI: 0000000000000003
> RBP: 00007fab9d0c947a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fab9d19bf80 R15: 00007ffe08b6c548
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
>  #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
>  #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 2 locks held by getty/4825:
>  #0: ffff88802a6320a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
> 3 locks held by kworker/u4:93/7607:
>  #0: ffff8880368b3938 ((wq_completion)nfc2_nci_rx_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #0: ffff8880368b3938 ((wq_completion)nfc2_nci_rx_wq){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #1: ffffc900156b7d20 ((work_completion)(&ndev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #1: ffffc900156b7d20 ((work_completion)(&ndev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #2: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
>  #2: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
> 6 locks held by kworker/0:1/11541:
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #1: ffffc90004a6fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #1: ffffc90004a6fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
>  #3: ffff88802bed5508 (&genl_data->genl_data_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0x111/0x2f0 net/nfc/netlink.c:1849
>  #4: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
>  #4: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: nfc_stop_poll+0x3c/0x220 net/nfc/core.c:247
>  #5: ffff88802bed4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_request net/nfc/nci/core.c:149 [inline]
>  #5: ffff88802bed4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_stop_poll+0x123/0x480 net/nfc/nci/core.c:873
> 3 locks held by kworker/1:2/16113:
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #1: ffffc9000322fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #1: ffffc9000322fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
> 3 locks held by kworker/1:9/17613:
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #1: ffffc9000d927d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #1: ffffc9000d927d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
> 3 locks held by kworker/0:5/22239:
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #1: ffffc90014e57d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #1: ffffc90014e57d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
> 3 locks held by kworker/1:0/23072:
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #1: ffffc9000a5afd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
>  #1: ffffc9000a5afd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
>  #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
> 1 lock held by syz-executor.1/27827:
>  #0: ffff88802bed4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_close_device+0x10a/0x600 net/nfc/nci/core.c:561
> 2 locks held by syz-executor.1/27953:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
>  #1: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_register_device+0x3c/0x320 net/nfc/core.c:1116
> 1 lock held by syz-executor.5/27976:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
> 1 lock held by syz-executor.5/27979:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
> 1 lock held by syz-executor.5/27981:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
> 1 lock held by syz-executor.5/27984:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
> 1 lock held by syz-executor.5/27986:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
> 1 lock held by syz-executor.1/28013:
>  #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
> 
> =============================================

	syz-executor.1:27827		kworker/u4:93/7607	kworker/0:1/11541
	===				===			===
	nci_close_device()		nci_rx_work()		nfc_urelease_event_work()
	mutex_lock(&ndev->req_lock)				device_lock()
	flush_workqueue(ndev->rx_wq)				mutex_lock(&ndev->req_lock)
					device_lock()

Looks like lockdep failed to detect deadlock once more because of device_lock().

