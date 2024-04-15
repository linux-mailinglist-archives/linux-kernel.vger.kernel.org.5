Return-Path: <linux-kernel+bounces-144485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20F8A46E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BA31C2117F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27C1C697;
	Mon, 15 Apr 2024 02:23:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B31BF2B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147785; cv=none; b=YmXGEKofftTVnDRWUqFY1IbAuSIMUdz73Vdk5Z4+8rNIOsPNmi9qR+L8/SJEV9HKXcr8cNQHrNE4hMv3IuFBImAPoPvHCOtE6/nES1VKT2Bqu8brtfXtqEzPPlShfr2BzKVb99v5MykJhlErH8jOC2vSC4J2c5VqTv/UvW8fKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147785; c=relaxed/simple;
	bh=dK9AGNb4TDZKL3GplujMKRZ1C2Qk8pW7qavvmrAmtDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RdmB8elw44U/znHnz0ySsL9crX8QggUve8RDlkF83dJ/bS9Eru4p2d3vZGgg/hp5HqFgDFkohu23evqSsiEFBlcI2S6Bkmk08zQbXSejFSCAPmOuB/aP3Ve2p0iJZqvVXVjAmkS7uJVnp69gFxsIYtRvNXWL6JtCmhE5m14tvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5e2b1d05aso316526039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 19:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713147783; x=1713752583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q84OwZWa4gGaIQlJs5I/cCn9rS+LDfEgXqYwLeuBUmQ=;
        b=QBzAfnRldHkLCQBH24N33/Fv9y1x2yH+Q+M8ws9AixNv1EKbrv0ysbtih9Etw+r0It
         1jXunLuFVREkJCDLrcZWJIOAmzIqLf7xz5EjELUmskpBHeY9rjevZYDHWPIrvZzU4h2l
         BBqppaPN3VTI8bUmc+Vdpgu35NthCr+9EitMmzQdmpRmQWudbfOo9zuodjIlqyRxVZ2Z
         VVtQgEoFuUSQC13xoEf04OcUHg5IX20UqUqDOe6Z0cl3eolrtxeAqqR+M1cWWTq43brO
         z/V+FdLVTcQQGI7ouOqZW+wzFbtVOG/fG2zBL307XIgdLK3haiIIcQVtmkrzXFPSGzbR
         X/8g==
X-Gm-Message-State: AOJu0YyAG/KpiVeWkVJDvsKF9aEfltcJvd0wKfebbNWNFdcaXJ6umuE9
	6jShswZQLhd0KWe6yOmCnH9THAbzoZ07Ut66I2cs1eoZsO++N3LJXgF42JwmyusJ+tD4hig6a4v
	oFXGKUuAnUU3hFdj9qPmaUAxitBjyN3j9sMYTrR0kMhIw0Ply+aPEgZE=
X-Google-Smtp-Source: AGHT+IGkDnn1M52UC/PX2txitbFXHVaa05ghM1p/FAj5Moltj9dPMBK6CkdY/Ewvj9KfppfZp/wlNaJeR/olhSboevJeLko1yksP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1682:b0:482:83aa:16be with SMTP id
 f2-20020a056638168200b0048283aa16bemr396912jat.5.1713147782920; Sun, 14 Apr
 2024 19:23:02 -0700 (PDT)
Date: Sun, 14 Apr 2024 19:23:02 -0700
In-Reply-To: <20240415020448.1876694-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c8d530616194d53@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in block_invalidate_folio

INFO: task kworker/3:1H:1222 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/3:1H    state:D stack:26784 pid:1222  tgid:1222  ppid:2      flags:0x00004000
Workqueue: glock_workqueue glock_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 io_schedule+0xbf/0x130 kernel/sched/core.c:9044
 bit_wait_io+0x15/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit_lock+0x112/0x1a0 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0xda/0x110 kernel/sched/wait_bit.c:117
 wait_on_bit_lock_io include/linux/wait_bit.h:208 [inline]
 __lock_buffer fs/buffer.c:71 [inline]
 lock_buffer include/linux/buffer_head.h:401 [inline]
 discard_buffer fs/buffer.c:1565 [inline]
 block_invalidate_folio+0x54d/0x5e0 fs/buffer.c:1622
 folio_invalidate mm/truncate.c:158 [inline]
 truncate_cleanup_folio+0x2ac/0x3e0 mm/truncate.c:178
 truncate_inode_pages_range+0x271/0xe90 mm/truncate.c:358
 rgrp_go_inval+0x15b/0x1c0 fs/gfs2/glops.c:236
 do_xmote+0x7ca/0xe00 fs/gfs2/glock.c:750
 run_queue+0x2fb/0x650 fs/gfs2/glock.c:861
 glock_work_func+0x103/0x390 fs/gfs2/glock.c:1093
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.0:5432 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:23168 pid:5432  tgid:5432  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2558
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __flush_work+0x5c4/0xb10 kernel/workqueue.c:4205
 gfs2_clear_rgrpd+0x28d/0x330 fs/gfs2/rgrp.c:731
 gfs2_put_super+0x4a6/0x760 fs/gfs2/super.c:643
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a83e7f197
RSP: 002b:00007ffc270ab458 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6a83e7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc270ab510
RBP: 00007ffc270ab510 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc270ac5d0
R13: 00007f6a83ec93b9 R14: 0000000000012eb3 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by kworker/3:1H/1222:
 #0: ffff88801bf74148 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3229
 #1: ffffc9000956fd80 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3230
2 locks held by getty/4998:
 #0: ffff8880162d60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000009b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.0/5432:
 #0: ffff88801fc3c0e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88801fc3c0e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88801fc3c0e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504

=============================================

NMI backtrace for cpu 2
CPU: 2 PID: 39 Comm: khungtaskd Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf86/0x1240 kernel/hung_task.c:380
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 2 to CPUs 0-1,3:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 3 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=173e4c93180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b101eb180000


