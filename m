Return-Path: <linux-kernel+bounces-55753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB1084C139
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84951F2545E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E4B8F70;
	Wed,  7 Feb 2024 00:08:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9183D76
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264517; cv=none; b=iaixXqy+gvla//gipYzvxYw7h98A2LPjzTnMrD3BtnjFoqbD7+fWwvj8zv96zD8KoP5cbhDoeuC+daD/RXzXdFAOeHml31c6Yqxql6/BT37ojO5rU8adyH47xS298begmZWj5WRtaSfacHREq3q+Uyd6PyjCrhkkfrX3s1OrbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264517; c=relaxed/simple;
	bh=RXeO4kqDXWO0Vxc7SsoVZhf+2nLb94kaPPVEScTdUiM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZUyfBPL0jikYz57NjKmSgha5i0sarGm8JpFATrkSD+h80iLRvIhhMEHCNo419fU0fLRDYkLhkYMENXf2HUAY5I13Gf4ajWvDHM3/mKXNU689ZOK8az5PdSg0mvSoJxIZJEHnbgveNmbHG6fqZ/FJnOiAkG24FkMKa57yABMBB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc6976630so434025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 16:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264514; x=1707869314;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKALtR+fep7lveDqROeWabCWH/kxrJFbUEirXD4lqck=;
        b=sBbfByAaAqvI2g0adFfzIay683Hhhxp8Hx+SNQ7FsGnl8WT/6fFoSX+vqkkheW8ocR
         i9pe65fGVzoSECSrrGd14+mPvnnv+gUcWtkOClp/7QSuZdzBVerTJMofMhG+N+x/9MFz
         4ugc5kMfbyR5mBhH0VKGP0RTJUK5xsP6LNj01GUS3xJ8MZOd0qZ9GEAEI23erJ2ujvjj
         cGPjax4Dq0t2y3lHn7Qkgol3vz76g6ifcYHgcB6LAQY13vJrLTymqQEaRrMvuK2sZ/tN
         z1N88iiBnVxXm1HXXa2QrWvmPsZH8rFmwRvyTb8xErVdqa+wAr+R8x9VI1EU2mLE5aVV
         mI8g==
X-Gm-Message-State: AOJu0Yx1NfAwXuUb+qG6+qHQ8Rl/VNYonfPg425CkjX8Ig95Ptl0gA6U
	3IwQ5QyjuXWtgzONHcVBROCgiOyvTZ/izVYJLccWTKuYpDwzYyr5vd0xplSqhkA1mJ0SpthkwVb
	p1e+WvUDbHwO6dD7pdsVoAlt+juAJ2uLkWp/p/lwd+gQoHFR5u+wv9pg=
X-Google-Smtp-Source: AGHT+IFFKgIWC5awZYawjv5AzaLuQHyzSUdhcllzHCYR3C68k2xueIwd7ihKNFZ9Q6ddkBoZtlSQpJnAOtfdSv51gf6mQVoVNeZb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2c:b0:363:7aed:f073 with SMTP id
 g12-20020a056e021a2c00b003637aedf073mr291602ile.0.1707264514210; Tue, 06 Feb
 2024 16:08:34 -0800 (PST)
Date: Tue, 06 Feb 2024 16:08:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e846ce0610bf7e53@google.com>
Subject: [syzbot] [net?] INFO: task hung in bond_destructor
From: syzbot <syzbot+543d079551e5c852bcf8@syzkaller.appspotmail.com>
To: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com, 
	j.vosburgh@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=151ee56c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
dashboard link: https://syzkaller.appspot.com/bug?extid=543d079551e5c852bcf8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dece45d1a4b5/disk-076d56d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4921e269b178/vmlinux-076d56d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a9156da9091/bzImage-076d56d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+543d079551e5c852bcf8@syzkaller.appspotmail.com

INFO: task kworker/u4:3:50 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:3    state:D stack:20280 pid:50    tgid:50    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
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
 bond_destructor+0x4d/0x80 drivers/net/bonding/bond_main.c:5846
 netdev_run_todo+0xd4f/0xf40 net/core/dev.c:10581
 default_device_exit_batch+0x975/0x9f0 net/core/dev.c:11625
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x775/0xb90 net/core/net_namespace.c:618
 process_one_work kernel/workqueue.c:3049 [inline]
 process_scheduled_works+0x913/0x14f0 kernel/workqueue.c:3125
 worker_thread+0xa60/0x1000 kernel/workqueue.c:3206
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/1:0/24:
 #0: ffff88801cec4548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #0: ffff88801cec4548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #1: ffffc900001e7d20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #1: ffffc900001e7d20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #2: ffff88802336a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #2: ffff88802336a190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5840
 #3: ffff88801c697190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #3: ffff88801c697190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #4: ffff888024a72160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff888024a72160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
 #5: ffff888080f9d098 (&hub->status_mutex){+.+.}-{3:3}, at: hub_hub_status+0x37/0x580 drivers/usb/core/hub.c:990
1 lock held by khungtaskd/29:
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130d60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/u4:3/50:
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #1: ffffc90000ba7d20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #1: ffffc90000ba7d20 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #2: ffffffff8f36da50 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xf5/0xb90 net/core/net_namespace.c:580
2 locks held by getty/4822:
 #0: ffff88802a8fa0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
6 locks held by kworker/1:4/15277:
 #0: ffff88801cec4548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #0: ffff88801cec4548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #1: ffffc900151dfd20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #1: ffffc900151dfd20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
 #2: ffff888023961190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #2: ffff888023961190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5840
 #3: ffff888023964510 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3198 [inline]
 #3: ffff888023964510 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5409 [inline]
 #3: ffff888023964510 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 #3: ffff888023964510 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5812 [inline]
 #3: ffff888023964510 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x25b6/0x5150 drivers/usb/core/hub.c:5894
 #4: ffff8880220f0e68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5410 [inline]
 #4: ffff8880220f0e68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5652 [inline]
 #4: ffff8880220f0e68 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5812 [inline]
 #4: ffff8880220f0e68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x25f4/0x5150 drivers/usb/core/hub.c:5894
 #5: ffff8880b943c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:567
2 locks held by kworker/u4:7/15663:
 #0: ffff8880b943c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:567
 #1: ffffc9000323fd20 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3024 [inline]
 #1: ffffc9000323fd20 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x14f0 kernel/workqueue.c:3125
2 locks held by syz-executor.1/13420:
3 locks held by syz-executor.3/13419:
1 lock held by syz-executor.4/13440:
 #0: ffffffff8e1360f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
 #0: ffffffff8e1360f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x39a/0x820 kernel/rcu/tree_exp.h:939

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
CPU: 0 PID: 3850 Comm: syz-executor.3 Not tainted 6.8.0-rc2-next-20240202-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:validate_chain+0x574/0x58e0 kernel/locking/lockdep.c:3876
Code: db 74 27 48 c7 c7 e0 c8 aa 8b 48 c7 c6 e0 e1 aa 8b e9 5c 04 00 00 e8 eb a3 2c 03 89 c3 e8 a4 fe fe ff 85 db 0f 85 3a 04 00 00 <48> c7 c0 6c ea 85 8f 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 5e 48
RSP: 0018:ffffc9001421f680 EFLAGS: 00000006
RAX: 0000000000048000 RBX: 00000000000480ae RCX: 1ffff92002843ef0
RDX: 0000000000000001 RSI: ffff888080f264d8 RDI: ffff888080f25a00
RBP: ffffc9001421f980 R08: ffffffff92ca3437 R09: 1ffffffff2594686
R10: dffffc0000000000 R11: fffffbfff2594687 R12: dffffc0000000000
R13: ffff888080f264f8 R14: 28476ec562981678 R15: ffff888080f25a00
FS:  000055555754e480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f83cbb7b978 CR3: 000000001110a000 CR4: 00000000003506f0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 sched_submit_work kernel/sched/core.c:6760 [inline]
 schedule+0xb0/0x320 kernel/sched/core.c:6818
 do_nanosleep+0x197/0x600 kernel/time/hrtimer.c:2048
 hrtimer_nanosleep+0x227/0x470 kernel/time/hrtimer.c:2101
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep+0x32b/0x3c0 kernel/time/posix-timers.c:1373
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fd75b6a91b5
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 b9 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f ba ff ff 48 8b 04 24 48 83 c4 28 f7 d8
RSP: 002b:00007ffdbc5661a0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 000000000000045c RCX: 00007fd75b6a91b5
RDX: 00007ffdbc5661e0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffdbc56626c R08: 0000000000000000 R09: 00007ffdbc56b0b0
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 00000000001c4bb3 R14: 00000000001c4bb3 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

