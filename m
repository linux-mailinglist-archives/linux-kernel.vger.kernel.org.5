Return-Path: <linux-kernel+bounces-41513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914983F304
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CDEB222C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DA2CA4;
	Sun, 28 Jan 2024 02:31:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC81870
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706409066; cv=none; b=nUQV2sk2Mhm82MMPpNYC9HNGJkA7CaoiQkAcbU9FtCQB6AxSzUeg/nZltZfE0f7epiuZwEgRfvzRz+8eBhEiokVjkJPpYlaXUKBiS9N1kKnF9AqYk305jvtIbQxqRhwoWpy2HNeiheB/2SHPkntjrXoqVaXWyQ+85EKEGZN/7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706409066; c=relaxed/simple;
	bh=9+kbmVpHUlGsSxXRiBjq1W8fezdVTHIyEXuJlGeG8mY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZtcxNRXinHroLDd+ZAoxTKUeUWl8VHL9CKrNumF957kJeVZ4BpLhrQVBbYWhCpcsVwcU0VYmBtCpiciEVDd6P7wm/ZuSv1LljeO5ajJJ9XVe1q/0AAX9H5r2HxKzsgQPw3pJfSd8jhmAcWF6XQyGnOWfcwZHZ+kg8+Xp16WwPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef5e512b6so117785439f.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706409063; x=1707013863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSY5gv8IVMSW8VEja74zYCb05fjIi9MIplNS8r2Jtbs=;
        b=gJ61J7XLjU+MQBYa3+edG3YVX+HpFp1bfXu4/SJdKyouPNqyKQz2FqrEzMBhlawbFM
         p0ZgDggdV9Hz7ufzNDbmPkbsI949TYaiuD1Dve4F640pngFfFOE9LEXTana0EVaKnZf4
         CHi0MNMima2myVZk4qCYj2sIWqVoQXopfkJiSJN7kWvjUPKjm+HN3sDXnBh/7kL+Ca1g
         sLADlQjpNdsCvbQWOKwl0vUBWkl7hCnbDa4zlVtW7jfGHnWst++Jy/fDGUa2oamjcFsv
         pm+mEKUiK9Zw/0J9VPdRAoEn4AfH/IVk6S97+JWwatTzXCeHltCSdABL6ZauNXyxP7Rn
         S6+A==
X-Gm-Message-State: AOJu0Yz8W+a4mpNmNYM4PlM8dlKQX/q5ETEkd9DqSbqjCv3ZIKg1Qi2x
	2xjf691hksIkmCThgdzolyX9CU62vwKwu+bNLnkRMOEHILp0v0il8tXfO9nKMqfASEPtvqDpHjj
	eV71Bn/ivGPofHLtCaIccNImRGaT0YRiBiAy/0n5cbFP8p6LzCuTvsFA=
X-Google-Smtp-Source: AGHT+IHxqR64b4QCR0pPEqeUnCgLlkDJjSxZS2VT/HtGhSJQpbimwsfChkcoJgkzxqISX1QqQYBDULSBM1XMY7wOcBAlcrf/pAYA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:363:757c:cc78 with SMTP id
 j11-20020a056e02154b00b00363757ccc78mr186152ilu.2.1706409063686; Sat, 27 Jan
 2024 18:31:03 -0800 (PST)
Date: Sat, 27 Jan 2024 18:31:03 -0800
In-Reply-To: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001529bf060ff852b9@google.com>
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
From: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in hci_conn_failed

INFO: task kworker/u5:2:5062 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc1-syzkaller-g8a696a29c690-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u5:2    state:D stack:27840 pid:5062  tgid:5062  ppid:2      flags:0x00004000
Workqueue: hci5 hci_cmd_sync_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x7f8/0xb70 net/bluetooth/hci_sync.c:5356
 abort_conn_sync+0x187/0x390 net/bluetooth/hci_conn.c:2988
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:306
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:1/9:
2 locks held by kworker/u4:0/11:
 #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000107d80 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
3 locks held by kworker/1:1/27:
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
6 locks held by kworker/u5:0/51:
 #0: ffff88802a730d38 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000bc7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888020989060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888020988078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
3 locks held by kworker/1:2/779:
 #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffffc900038c7d80 ((work_completion)(&aux->work)#2){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888052984c80 (&aux->poke_mutex){+.+.}-{3:3}, at: __fd_array_map_delete_elem+0x125/0x2f0 kernel/bpf/arraymap.c:884
2 locks held by kworker/u4:7/2797:
2 locks held by kworker/u4:9/2812:
 #0: ffff888013089938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc9000a05fd80 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
5 locks held by kworker/u5:1/4456:
 #0: ffff888021b4a138 ((wq_completion)hci0){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc9000d7dfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff88806a001060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff88806a000078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #4: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
3 locks held by udevd/4512:
2 locks held by getty/4813:
 #0: ffff88802e7980a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
5 locks held by kworker/u5:2/5062:
 #0: ffff88802271a938 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc900041cfd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888019ff1060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888019ff0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
2 locks held by kworker/0:3/5070:
2 locks held by kworker/1:4/5071:
 #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffff8880b9928a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
3 locks held by kworker/1:5/5493:
3 locks held by kworker/1:6/5497:
3 locks held by kworker/0:6/5520:
2 locks held by kworker/0:8/5525:
 #0: ffff8880b983ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffff8880b9828a08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
1 lock held by dhcpcd/20169:
 #0: ffff8880581ba130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
 #0: ffff8880581ba130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
1 lock held by syz-executor.0/21114:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc1-syzkaller-g8a696a29c690-dirty #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 21128 Comm: syz-executor.4 Not tainted 6.8.0-rc1-syzkaller-g8a696a29c690-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:get_current arch/x86/include/asm/current.h:42 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x4/0x60 kernel/kcov.c:206
Code: 66 0f 1f 44 00 00 f3 0f 1e fa 48 8b be b0 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa <65> 48 8b 14 25 80 c2 03 00 65 8b 05 b4 9e 7b 7e a9 00 01 ff 00 48
RSP: 0018:ffffc9000433fa10 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff824e81f8
RDX: ffff88807efe5940 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88801ea65000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffff888010bb03f0 R12: ffff8880625f1f68
R13: ffff88807e228b40 R14: ffff88814960b000 R15: ffff8880625f1f8c
FS:  0000555556c83480(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f925bd01404 CR3: 000000004b197000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 bh2jh include/linux/jbd2.h:338 [inline]
 jbd2_journal_dirty_metadata+0x85/0xd60 fs/jbd2/transaction.c:1514
 __ext4_handle_dirty_metadata+0x16e/0x8e0 fs/ext4/ext4_jbd2.c:354
 __ext4_new_inode+0x1bed/0x5200 fs/ext4/ialloc.c:1234
 ext4_symlink+0x5d7/0xa20 fs/ext4/namei.c:3396
 vfs_symlink fs/namei.c:4480 [inline]
 vfs_symlink+0x3e4/0x620 fs/namei.c:4464
 do_symlinkat+0x25f/0x310 fs/namei.c:4506
 __do_sys_symlinkat fs/namei.c:4522 [inline]
 __se_sys_symlinkat fs/namei.c:4519 [inline]
 __x64_sys_symlinkat+0x97/0xc0 fs/namei.c:4519
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f925bc7c527
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0a 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb3e6e518 EFLAGS: 00000202 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007fffb3e6e5e0 RCX: 00007f925bc7c527
RDX: 00007f925bcc951b RSI: 00000000ffffff9c RDI: 00007f925bcc850e
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 </TASK>


Tested on:

commit:         8a696a29 Merge tag 'platform-drivers-x86-v6.8-2' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10300d80180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=a984066a63e9c1e62662
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1609e64be80000


