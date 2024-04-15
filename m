Return-Path: <linux-kernel+bounces-144450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E238A468F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA182281E79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887F6FCA;
	Mon, 15 Apr 2024 01:32:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347F4A24
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713144725; cv=none; b=oclOzu87VK3n8xxa4VZyZwJZ3u19U7ueux0PucKcw/LllWFEGnp4DOJG5Z0HFjEeeDUOv189eBQn3yYkbf02mUQKdhD8e0OSuB46u4si9S5d1k3PY3UKmmLK1KVanErr7LxwXuWiy3leIiAZsfs/dGK+0cxuHD5uuM4ZRvzd9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713144725; c=relaxed/simple;
	bh=4app7uW5C+AZdEmvre507nvf0tBqEJXnWplx+j/P7pw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wydl+Yrqzujgnd1uBHc2yoQnWMJNxetcWE6raSeUNSzTShH3KmMsm6oJrZu1dcJhv5fTDZ3MJYkw7ck9an2ctp01cPAoj91HweMYnxQjrwoMeFcopwkwEm0t2+e5xPgd6tbsJ5QhhwtOO9sWndQml9PnG7OzfUyvfzFpdkeN+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d096c4d663so372159039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 18:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713144723; x=1713749523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3dKXCfDZHDkW33t8PG1Lkd75VAnYC1PtPpMT6ewqFA=;
        b=xFUVHk7StQBAabRx3ChWROzage8+cGedHE2yTZ4vObGId5zXoxFzoyfytnWAD1koUT
         0Vb6asTKJGethgTduc6Ad4EqISO6YkOnsfDspOs2TiswZr9WL1p0aHysX0qjiNUJdy48
         3kWcmSz2eXJIREHjj0Z8owgHLoXat+1bz2PT+lXA8jOJQ/nAMc5kkiyBRjBZI2kpKj0y
         MMNUnNlZ6MS4X9D533amqRPh+rmoZ8JvcQkogP5vt5O6HfHsGuy4/amkYt0h/yU7yENq
         jOLAmIp9aoSXzwvyIbEGUu79yLuLOUUQS3cvHxhgUeNRvAVZNU2f0v5/5kDW9BfRMlEh
         Ol0Q==
X-Gm-Message-State: AOJu0YyZm/2TT278bwWBYywcPYFR/UO/YS62eyFIzQ5h5YdhuY1VNpya
	3ESXP/dVbMFfGtkrNQh5BjEyGcL1GkVenLdz2r4xVrMQ6l4XrsYHDFm+tzgu1Mb7HeiVUyzkHDm
	Qf3LDYh57tQtbG/CYsVPAFmcAhLkKrbIjMB2sEu09+bDPnPHRBHDkiUM=
X-Google-Smtp-Source: AGHT+IF8SFbjDxHNiS5vxZWQzrZXxb6OtsJ20wqTQv+QznChouJi86LSK2QFWhIcKNmMvNMYXm5XdgsFLnerMLUs1EyiWWmC+VT7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4126:b0:482:f7c9:c175 with SMTP id
 ay38-20020a056638412600b00482f7c9c175mr258233jab.4.1713144723353; Sun, 14 Apr
 2024 18:32:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 18:32:03 -0700
In-Reply-To: <20240415011339.1405027-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af43210616189677@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in block_invalidate_folio

INFO: task kworker/2:1H:120 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/2:1H    state:D stack:27488 pid:120   tgid:120   ppid:2      flags:0x00004000
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
INFO: task syz-executor.0:5412 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:23600 pid:5412  tgid:5412  ppid:1      flags:0x00004006
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
RIP: 0033:0x7fa977e7f197
RSP: 002b:00007fffe3d88ff8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fa977e7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffe3d890b0
RBP: 00007fffe3d890b0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffe3d8a170
R13: 00007fa977ec93b9 R14: 000000000001375d R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by kworker/2:1H/120:
 #0: ffff8880166e9948 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3229
 #1: ffffc9000280fd80 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3230
2 locks held by getty/4982:
 #0: ffff8880162d30a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fce2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.0/5412:
 #0: ffff88801e6960e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88801e6960e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88801e6960e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504

=============================================

NMI backtrace for cpu 3
CPU: 3 PID: 39 Comm: khungtaskd Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
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
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 0
CPU: 0 PID: 4668 Comm: klogd Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:61 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x39/0x1a0 mm/kasan/generic.c:189
Code: f8 41 54 44 0f b6 c2 48 01 f0 55 53 0f 82 c6 00 00 00 48 b8 ff ff ff ff ff 7f ff ff 48 39 f8 0f 83 b3 00 00 00 4c 8d 54 37 ff <48> 89 fd 48 b8 00 00 00 00 00 fc ff df 4d 89 d1 48 c1 ed 03 49 c1
RSP: 0018:ffffc9000f4d7b40 EFLAGS: 00000083
RAX: ffff7fffffffffff RBX: ffff8880194a3640 RCX: ffffffff816c57e3
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880194a3640
RBP: 0000000000000282 R08: 0000000000000000 R09: fffffbfff1f3e002
R10: ffff8880194a3643 R11: 0000000000000000 R12: ffff888024329980
R13: ffff8880194a3640 R14: 1ffff92001e9af86 R15: ffff888024329800
FS:  00007fcbb3e86500(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d46340d028 CR3: 000000002c3e8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 queued_spin_is_locked include/asm-generic/qspinlock.h:57 [inline]
 debug_spin_unlock kernel/locking/spinlock_debug.c:101 [inline]
 do_raw_spin_unlock+0x53/0x230 kernel/locking/spinlock_debug.c:141
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_unlock_irqrestore+0x22/0x80 kernel/locking/spinlock.c:194
 sock_def_readable+0x160/0x7a0 net/core/sock.c:3354
 unix_dgram_sendmsg+0xff6/0x1b10 net/unix/af_unix.c:2159
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcbb3fe89b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd9ba7e3f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcbb3fe89b5
RDX: 0000000000000053 RSI: 000055d46340b020 RDI: 0000000000000003
RBP: 000055d4634042c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007fcbb4176212 R14: 00007ffd9ba7e4f8 R15: 0000000000000000
 </TASK>
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742
NMI backtrace for cpu 2 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xf/0x20 arch/x86/kernel/process.c:742


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=100d81b3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1335deeb180000


