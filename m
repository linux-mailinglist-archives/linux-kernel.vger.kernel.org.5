Return-Path: <linux-kernel+bounces-55750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B984C130
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FEEB24A23
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3AF3D71;
	Wed,  7 Feb 2024 00:07:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F3EC2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264451; cv=none; b=LamTqIEJnuC891K4gS10iVUiG4E1ypBeZbJAM5eJBCoV4q/TSBSU2VerEKT+nbbgKPkxgqpHQCJmybTwwtVyJ/zVcq1Li2j0Ef29ejq+hsRNbBkGCBT9p1e/fmNPogs0qRaqXv8U273QpU8jIMYt3cA9gu2JsZHstjq4WEgwvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264451; c=relaxed/simple;
	bh=e/wWgvLaH6Xms95KzTm+BykT06sEDTluKljxtlhBtXI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D8Ftrk3r5Q5WPZBdB+wSOZP/OcfDw3q8UKi0nUw7G23LPJp9AiSKToSuqm5CuGVvI6bqD97x0n0OuJYJfQP3UiMVgymItPfoqgmvWX9wV9TcJRQQhhbpyZQRG1rluzrWzZhWlOCbNYH4utqSV3CdnAhCZwBAXqcK+a9pc6PLfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bec4b24a34so6050439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 16:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264449; x=1707869249;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOJdGbNsb2xZMjmIcHRBPA6EHTzqMxcGC265Oe/VtXQ=;
        b=sHYsctzh7WrjGGsip0WT+LU+FFZIEltlNFrTrA4CjxFVb40A8dYgu0rUD5XJL7+xPY
         6f9vFG7KPNiq9l0gerGNjKFt/PXjl2EwVLLe9VCf4tog47j7ttJQ1csx6BTDYSwk6enx
         PYc2910jA+34mngz3OpwvkJM8Is0k8CkuwSe7GUQCeo52oQx5RhQvAVT55v/y3nxBuNU
         pmBQ4IzfUSFaHY5brNAB2O7rsbGAKcXeP81gm03n9Z4lpK1WKeybivMaartguI1FtO6Q
         I9O8euyKJsMjKx2hK8EqhVgRljNrixLsf8aI4dLGmXq6XIQ6XleEZ+l/2xw0dpXgdgfw
         wP4Q==
X-Gm-Message-State: AOJu0Yz5mBKSrkaswpjMo8Y1CRtJss9mf3XxATKLBUST7kJjjXjZuoob
	wUaCITeoTILAvBTVzL1si3HAzEW2DpnmY1fmsnNBILAc2lzemd/pb1hUxRBJcugFzemMcDft9kU
	HY9jCBmUeW5ULwRUQ5ImhmQyah5BM+ntO61S0QV10XVIopYjQR8c6S/Y=
X-Google-Smtp-Source: AGHT+IECQAH95uwwoZT2xXecLlAiaAZKlLjmj+ILu0JYJftbR1DCmNvqqTkOv/6pC1tOdsPDbpfYakYPJ+K2tbW6FtoiL6T5rIJF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:ad08:0:b0:471:2650:2b10 with SMTP id
 s8-20020a02ad08000000b0047126502b10mr29438jan.6.1707264448991; Tue, 06 Feb
 2024 16:07:28 -0800 (PST)
Date: Tue, 06 Feb 2024 16:07:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000051d4b0610bf7b20@google.com>
Subject: [syzbot] [bluetooth?] INFO: task hung in hci_release_dev
From: syzbot <syzbot+83da23da6243e55b4670@syzkaller.appspotmail.com>
To: jiangshanlai@gmail.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155f1540180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=83da23da6243e55b4670
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1181463fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105dfab7e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz

The issue was bisected to:

commit dd6c3c5441263723305a9c52c5ccc899a4653000
Author: Tejun Heo <tj@kernel.org>
Date:   Mon Jan 29 18:11:24 2024 +0000

    workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b9456c180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16b9456c180000
console output: https://syzkaller.appspot.com/x/log.txt?x=12b9456c180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83da23da6243e55b4670@syzkaller.appspotmail.com
Fixes: dd6c3c544126 ("workqueue: Move pwq_dec_nr_in_flight() to the end of work item handling")

INFO: task syz-executor108:5074 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor108 state:D stack:25360 pid:5074  tgid:5074  ppid:5064   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17df/0x4a40 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x355/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3617
 drain_workqueue+0xc9/0x390 kernel/workqueue.c:3730
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5319
 hci_release_dev+0x136/0x1670 net/bluetooth/hci_core.c:2807
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f5/0x430 lib/kobject.c:733
 hci_uart_tty_close+0x1c1/0x290 drivers/bluetooth/hci_ldisc.c:552
 tty_ldisc_kill+0xa3/0x1a0 drivers/tty/tty_ldisc.c:607
 tty_ldisc_release+0x174/0x200 drivers/tty/tty_ldisc.c:775
 tty_release_struct+0x2b/0xe0 drivers/tty/tty_io.c:1696
 tty_release+0xd0c/0x12c0 drivers/tty/tty_io.c:1867
 __fput+0x429/0x8a0 fs/file_table.c:376
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f08333d3309
RSP: 002b:00007ffd1b9835d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f08333d3309
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f0833453390 R08: ffffffffffffffb8 R09: 0000555556c61610
R10: 000000000000000e R11: 0000000000000246 R12: 00007f0833453390
R13: 0000000000000000 R14: 00007f0833454e60 R15: 00007f08333a42f0
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/u4:0/10:
1 lock held by khungtaskd/29:
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4817:
 #0: ffff88802afa30a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor108/5074:
 #0: ffff88807a68e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:289 [inline]
 #0: ffff88807a68e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock_pair_timeout drivers/tty/tty_ldisc.c:352 [inline]
 #0: ffff88807a68e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock_pair drivers/tty/tty_ldisc.c:366 [inline]
 #0: ffff88807a68e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_release+0x110/0x200 drivers/tty/tty_ldisc.c:774

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 10 Comm: kworker/u4:0 Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:can_migrate_task+0x4ef/0x960 kernel/sched/fair.c:8991
Code: c1 e8 03 42 0f b6 04 20 84 c0 0f 85 fa 01 00 00 44 3b 7d 00 76 6c 83 fb 01 75 0a 0f 1f 44 00 00 0f 1f 44 00 00 b9 01 00 00 00 <89> c8 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 48
RSP: 0018:ffffc900000f6f70 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff88801969bc34 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88801969c028
RBP: 0000000000000001 R08: ffff88801969c02f R09: 1ffff110032d3805
R10: dffffc0000000000 R11: ffffed10032d3806 R12: ffffc900000f7580
R13: ffff88801969bc00 R14: dffffc0000000000 R15: ffff88801969c018
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b598263448 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 detach_tasks kernel/sched/fair.c:9088 [inline]
 load_balance+0x5480/0x8920 kernel/sched/fair.c:11335
 newidle_balance+0x6be/0x1080 kernel/sched/fair.c:12363
 pick_next_task_fair+0x27a/0xde0 kernel/sched/fair.c:8502
 __pick_next_task+0xb0/0x2c0 kernel/sched/core.c:6021
 pick_next_task kernel/sched/core.c:6111 [inline]
 __schedule+0x729/0x4a40 kernel/sched/core.c:6691
 __schedule_loop kernel/sched/core.c:6804 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6819
 toggle_allocation_gate+0x16a/0x250 mm/kfence/core.c:828
 process_one_work kernel/workqueue.c:3049 [inline]
 process_scheduled_works+0x913/0x14f0 kernel/workqueue.c:3125
 worker_thread+0xa60/0x1000 kernel/workqueue.c:3206
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.335 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

