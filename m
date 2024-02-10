Return-Path: <linux-kernel+bounces-60301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E311C8502DE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B873AB21CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C18200BA;
	Sat, 10 Feb 2024 07:03:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B116435
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548586; cv=none; b=YKUwrVMrKHLQP/rkmip9TUtTWFaEXIY4tyi2pUzeP7ild3TM+ghA0x53SiAsbBbjyEqtvlY505uraw2Zm2boP9bTayrS9q0uRYEQYgIfLy2ETlyVD7S2Zvm5ck1m9wCQkbOuUuj6+Y4w8kqDyIsVCyjNvti32tHZBUBzXRC7fzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548586; c=relaxed/simple;
	bh=W7O6wookQUcchsJb/9gfc7hri/yAlyxMqCBXBq6tVj4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mIQ1xAqvemlxdYcobdnL14lMHL4Gxcoh5vjLXcWsrF938J5A8UAO/Kh6x83WxAbCCh+fqRRZdJLSPh3XXg8qCXEFV5w5t1hCc/B6D8nb0uOwDigQkLByU0EycDWaB9/3+Hza48buX4TVm5dV9JqiYCMxmUdtxWT27oK6D0Ho+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363b6ee24d3so13628125ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548584; x=1708153384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MYiKOk5JqC/HD8bNI5dj9VGNKLoVj4E55c4sDtUEMY=;
        b=cxKjoW+hn4WaUx0si8mIFqyivF9pVLNHTf9kXI9sK+PgrnfEA9IVjaqGE0LNHx0kKh
         CqUHohcQ2DA9vajvUuEdtAWqtlWm/lPmzJhuXRcoNxnHJv7kxHaxRLpWpToI4h77QOC+
         7o5GJf6FqNRz44fK3WzfVDa2xm3g/hS0ZZlV0henMlv2646mi7jkOCTmOZSlPHssRheC
         e6Sx1/BA3eAoD/mLEcRJKl4EQPuOvDJUQfw1QkiUmDmbd4l2fDbazWR8hWVmtCoueC/j
         3D8WA4chEBkhw76lkNP3Rs4WbgcqDXMkLqPGz5L81yoIY/8i+fUNCM3tUjdh/OAVGMum
         XZXg==
X-Forwarded-Encrypted: i=1; AJvYcCVLNjN8nxapAX3kFAa27PPSx479sPCav1UvoXyvQfmvodysfto2Li4HfivWTTNojRuWG+CjSsQ6pvkVBP3O0YaApd6dtg/qJL5nRZGe
X-Gm-Message-State: AOJu0YyQtX47hXa5hNNBQ158a0fJarVD6ttc1DKLlg8mw7Cu6qZXS9i1
	mOmWy23qnVC/mCiLySuCy6DSAIQ3N/Vrlhwo0epeGUzMbJK9mAeuonAdQ9EDRPKOtatUpuOtnnR
	W8qUGBbX4/9UNuNw8lOBwEQV98EjZxF1S/DNesgnlrlRd8kLPfq5umLI=
X-Google-Smtp-Source: AGHT+IHZ1zzOaLWcOTBsvVKMLnUie701tGg7yN602iUT6GSW/Zad5Yc1Zb3TnpOKu/nEvYkFpQ9tTnC5nmKuzWQ/GpP5v9fogbBu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:363:c002:719f with SMTP id
 g6-20020a92cda6000000b00363c002719fmr90914ild.6.1707548583849; Fri, 09 Feb
 2024 23:03:03 -0800 (PST)
Date: Fri, 09 Feb 2024 23:03:03 -0800
In-Reply-To: <20240210063527.792-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6f405061101a2cc@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
From: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in unix_stream_sendmsg

INFO: task syz-executor.0:7136 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc3-syzkaller-00811-gb63cc73341e0-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:25200 pid:7136  tgid:7135  ppid:5423   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_timeout+0xb0/0x310 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x354/0x620 kernel/sched/completion.c:148
 __flush_work+0x950/0xad0 kernel/workqueue.c:3410
 unix_stream_sendmsg+0x1c3/0xe60 net/unix/af_unix.c:2264
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f5b08e7dda9
RSP: 002b:00007f5b09cb70c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5b08fabf80 RCX: 00007f5b08e7dda9
RDX: 0000000020004005 RSI: 0000000020000280 RDI: 0000000000000004
RBP: 00007f5b08eca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5b08fabf80 R15: 00007fffbd0155e8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130ae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u4:7/2789:
2 locks held by getty/4819:
 #0: ffff88802a9d20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002efe2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc3-syzkaller-00811-gb63cc73341e0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 132 Comm: kworker/u4:5 Not tainted 6.8.0-rc3-syzkaller-00811-gb63cc73341e0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: bat_events batadv_nc_worker
RIP: 0010:lockdep_hardirqs_on+0x71/0x140 kernel/locking/lockdep.c:4409
Code: c0 75 74 65 8b 05 c7 28 9b 74 85 c0 75 69 83 3d 04 35 e1 08 00 75 2e 48 c7 04 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 <75> 67 83 3d e6 34 e1 08 00 75 10 48 8b 83 98 0a 00 00 48 3b 83 b0
RSP: 0018:ffffc90002d57a18 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff88801cf7bb80 RCX: ffffffff8171840a
RDX: dffffc0000000000 RSI: ffffffff8baac760 RDI: ffffffff81592108
RBP: ffffc90002d57af0 R08: ffffffff92c914f7 R09: 1ffffffff259229e
R10: dffffc0000000000 R11: fffffbfff259229f R12: dffffc0000000000
R13: 1ffff920005aaf50 R14: ffffffff81592108 R15: 0000000000000201
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f210bda80c0 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __local_bh_enable_ip+0x168/0x200 kernel/softirq.c:386
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x30f/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         b63cc733 net: phy: realtek: use generic MDIO helpers t..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=16d4bd20180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac1116e4986e7570
dashboard link: https://syzkaller.appspot.com/bug?extid=5a630f8ca0120ab43f55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e9e3a2180000


