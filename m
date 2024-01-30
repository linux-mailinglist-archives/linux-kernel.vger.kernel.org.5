Return-Path: <linux-kernel+bounces-44077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF91841D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8AAB221EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94F55E64;
	Tue, 30 Jan 2024 07:55:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01255E52
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601306; cv=none; b=UrTtaA5QJX6eK0CB+3jKj/OpoPkKOjNZmxb499JyEB5iA2PTbKXodJJN+tAiUU2IBJJ+SCPn9OKt+a4Yx3QKYYjAtzXmtsPSnN5Thv6oOQDTDfsNqkYqV3obb+P1fnnCnzl78zsKzxphyPfBbEBFri+wg1FtlwAN2Zi519T8iO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601306; c=relaxed/simple;
	bh=u9rZorO3bB+7FvRpflTR6xVxv819s1RoYh67OrcCwuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AR4wewrUYpbBYdNgI3+1lK/CNo1TPF00b83NOssY97XG5eYiA/Aoy7xskIPkvQqS2s2k1FW6lXu3JemROwzchZhQZwUuEOY0M6TAYfruq8Aarzmw31CIkIABXkp0cqw5a8sQPv2XlwXfudFGe0U2U3blctVWbgimOcYf7axEYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bfed339137so88756339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706601303; x=1707206103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v4mONQYNVCLTmiYup4XaQal7dUKAA8mGqaKpmD3vkY=;
        b=spsQ1DRY1GtlOLqhL8WeXQWxehNx7UejDl2x9LybcN4XNZTFbgzUiBUmAWlxS09dPI
         VYptu3poRRkMgezzWEe/QB9R1EL2RRe8qEmhsMM+y1WyKthahvHc6EMxTwcVg/Rcpb4X
         6l9LhVC71pL71NW3SMmnpkAVLKiZFWQSJVJQpq2zKS0mKARC4IaBl4OxTZsapzVTtnde
         +Dgrb1Unyp4LJ3Ctcts+0lITRNT4G5qd6i/r6NM719gbmMCpsyecyhdm4/L9rhDFObyc
         wHOwhXNUW65MyrtJ3sqLNPxn04x2KdA30JuHWInAKwPW6efPTs9MhfAWZEBzVnWIonX1
         TY5g==
X-Gm-Message-State: AOJu0YxanJdcFWKA3Sr9G9+EoYpDAV6qC0oVkwwrd0bQV49BKhcZgi5c
	m51yl9M44hntISMtMEFtH/8qJ9QApiNanDCXC66FktfNtOlnDiaXBjvFR3PKtIxLoUFeCGaSIqY
	8XOr5EG/oQu+LaybpyDBybKVSu/yBJQiKSQL1eg3ZwC3AVL0lO1HEVww=
X-Google-Smtp-Source: AGHT+IG3zJ7FcycEqe/ydo4Y55puJBw0ecgxEjafok6E0aoQBUha8PdW2gjQ4hOpmwNjAaJadELQpNab8YE09n5anibLsa03cPlK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:f015:0:b0:7c0:72e:f9b0 with SMTP id
 w21-20020a6bf015000000b007c0072ef9b0mr7725ioc.2.1706601303286; Mon, 29 Jan
 2024 23:55:03 -0800 (PST)
Date: Mon, 29 Jan 2024 23:55:03 -0800
In-Reply-To: <tencent_A9BA7DBB1A33069E111B6F4BF91B38255B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074ab180610251441@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in relay_close

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5647, name: syz-executor.2
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor.2/5647:
 #0: ffff8880293260e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff8880293260e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff8880293260e0 (&type->s_umount_key#46){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:509
 #1: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #1: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5647 Comm: syz-executor.2 Not tainted 6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10176
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0xe2/0x9d0 kernel/locking/mutex.c:752
 relay_close kernel/relay.c:760 [inline]
 relay_close+0x36/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 d6 85 d6 f6 48 89 df e8 ce fd d6 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 c5 9d c8 f6 65 8b 05 e6 d2 71 75 85 c0 74 12 5b
RSP: 0018:ffffc90009927658 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff92c1b680 RCX: 1ffffffff2436810
RDX: 0000000000000000 RSI: ffffffff8accb000 RDI: ffffffff8b2fdc00
RBP: 0000000000000202 R08: 0000000000000001 R09: fffffbfff242b005
R10: ffffffff9215802f R11: ffffffff8ace3420 R12: 0000000000000001
R13: ffff88801c40a000 R14: 1ffff92001324ed2 R15: ffffffff92c1b678
 debug_object_activate+0x349/0x540 lib/debugobjects.c:726
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common.constprop.0+0x2c/0x7b0 kernel/rcu/tree.c:2700
 security_inode_free+0x9e/0xc0 security/security.c:1616
 __destroy_inode+0x1f8/0x740 fs/inode.c:285
 destroy_inode+0x91/0x1b0 fs/inode.c:308
 iput_final fs/inode.c:1739 [inline]
 iput.part.0+0x560/0x7b0 fs/inode.c:1765
 iput+0x5c/0x80 fs/inode.c:1755
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:400
 __dentry_kill+0x1ca/0x5f0 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 shrink_dcache_parent+0xe2/0x530 fs/dcache.c:1509
 do_one_tree fs/dcache.c:1538 [inline]
 shrink_dcache_for_umount+0x79/0x390 fs/dcache.c:1555
 generic_shutdown_super+0x76/0x3d0 fs/super.c:624
 kill_anon_super fs/super.c:1230 [inline]
 kill_litter_super+0x70/0xa0 fs/super.c:1240
 binderfs_kill_super+0x3b/0xa0 drivers/android/binderfs.c:781
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 get_signal+0x23b5/0x2790 kernel/signal.c:2893
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x156/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe0/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f403447cda9
Code: Unable to access opcode bytes at 0x7f403447cd7f.
RSP: 002b:00007f40352b20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f40345ac050 RCX: 00007f403447cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f40344c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f40345ac050 R15: 00007fff753e8318
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.8.0-rc2-syzkaller-g861c0981648f-dirty #0 Tainted: G        W         
-----------------------------
syz-executor.2/5647 is trying to lock:
ffffffff8d21c348 (relay_channels_mutex){+.+.}-{3:3}, at: relay_close kernel/relay.c:760 [inline]
ffffffff8d21c348 (relay_channels_mutex){+.+.}-{3:3}, at: relay_close+0x36/0x5d0 kernel/relay.c:752
other info that might help us debug this:
context-{2:2}
2 locks held by syz-executor.2/5647:
 #0: ffff8880293260e0 (&type->s_umount_key#46){+.+.}-{3:3}
, at: __super_lock fs/super.c:56 [inline]
, at: __super_lock_excl fs/super.c:71 [inline]
, at: deactivate_super+0xd6/0x100 fs/super.c:509
 #1: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2184 [inline]
 #1: ffffffff8d1acac0 (rcu_callback){....}-{0:0}, at: rcu_core+0x7bd/0x1680 kernel/rcu/tree.c:2465
stack backtrace:
CPU: 0 PID: 5647 Comm: syz-executor.2 Tainted: G        W          6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4751 [inline]
 check_wait_context kernel/locking/lockdep.c:4821 [inline]
 __lock_acquire+0x821/0x3b30 kernel/locking/lockdep.c:5087
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9d0 kernel/locking/mutex.c:752
 relay_close kernel/relay.c:760 [inline]
 relay_close+0x36/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 d6 85 d6 f6 48 89 df e8 ce fd d6 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 c5 9d c8 f6 65 8b 05 e6 d2 71 75 85 c0 74 12 5b
RSP: 0018:ffffc90009927658 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff92c1b680 RCX: 1ffffffff2436810
RDX: 0000000000000000 RSI: ffffffff8accb000 RDI: ffffffff8b2fdc00
RBP: 0000000000000202 R08: 0000000000000001 R09: fffffbfff242b005
R10: ffffffff9215802f R11: ffffffff8ace3420 R12: 0000000000000001
R13: ffff88801c40a000 R14: 1ffff92001324ed2 R15: ffffffff92c1b678
 debug_object_activate+0x349/0x540 lib/debugobjects.c:726
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common.constprop.0+0x2c/0x7b0 kernel/rcu/tree.c:2700
 security_inode_free+0x9e/0xc0 security/security.c:1616
 __destroy_inode+0x1f8/0x740 fs/inode.c:285
 destroy_inode+0x91/0x1b0 fs/inode.c:308
 iput_final fs/inode.c:1739 [inline]
 iput.part.0+0x560/0x7b0 fs/inode.c:1765
 iput+0x5c/0x80 fs/inode.c:1755
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:400
 __dentry_kill+0x1ca/0x5f0 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 shrink_dcache_parent+0xe2/0x530 fs/dcache.c:1509
 do_one_tree fs/dcache.c:1538 [inline]
 shrink_dcache_for_umount+0x79/0x390 fs/dcache.c:1555
 generic_shutdown_super+0x76/0x3d0 fs/super.c:624
 kill_anon_super fs/super.c:1230 [inline]
 kill_litter_super+0x70/0xa0 fs/super.c:1240
 binderfs_kill_super+0x3b/0xa0 drivers/android/binderfs.c:781
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 get_signal+0x23b5/0x2790 kernel/signal.c:2893
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x156/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe0/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f403447cda9
Code: Unable to access opcode bytes at 0x7f403447cd7f.
RSP: 002b:00007f40352b20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f40345ac050 RCX: 00007f403447cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f40344c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f40345ac050 R15: 00007fff753e8318
 </TASK>
BUG: sleeping function called from invalid context at kernel/irq_work.c:289
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5647, name: syz-executor.2
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5647 Comm: syz-executor.2 Tainted: G        W          6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 __might_resched+0x3c3/0x5e0 kernel/sched/core.c:10176
 irq_work_sync+0x8e/0x2f0 kernel/irq_work.c:289
 relay_close_buf+0x53/0x1b0 kernel/relay.c:428
 relay_close kernel/relay.c:766 [inline]
 relay_close+0x3a8/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 d6 85 d6 f6 48 89 df e8 ce fd d6 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 c5 9d c8 f6 65 8b 05 e6 d2 71 75 85 c0 74 12 5b
RSP: 0018:ffffc90009927658 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff92c1b680 RCX: 1ffffffff2436810
RDX: 0000000000000000 RSI: ffffffff8accb000 RDI: ffffffff8b2fdc00
RBP: 0000000000000202 R08: 0000000000000001 R09: fffffbfff242b005
R10: ffffffff9215802f R11: ffffffff8ace3420 R12: 0000000000000001
R13: ffff88801c40a000 R14: 1ffff92001324ed2 R15: ffffffff92c1b678
 debug_object_activate+0x349/0x540 lib/debugobjects.c:726
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common.constprop.0+0x2c/0x7b0 kernel/rcu/tree.c:2700
 security_inode_free+0x9e/0xc0 security/security.c:1616
 __destroy_inode+0x1f8/0x740 fs/inode.c:285
 destroy_inode+0x91/0x1b0 fs/inode.c:308
 iput_final fs/inode.c:1739 [inline]
 iput.part.0+0x560/0x7b0 fs/inode.c:1765
 iput+0x5c/0x80 fs/inode.c:1755
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:400
 __dentry_kill+0x1ca/0x5f0 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 shrink_dcache_parent+0xe2/0x530 fs/dcache.c:1509
 do_one_tree fs/dcache.c:1538 [inline]
 shrink_dcache_for_umount+0x79/0x390 fs/dcache.c:1555
 generic_shutdown_super+0x76/0x3d0 fs/super.c:624
 kill_anon_super fs/super.c:1230 [inline]
 kill_litter_super+0x70/0xa0 fs/super.c:1240
 binderfs_kill_super+0x3b/0xa0 drivers/android/binderfs.c:781
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 get_signal+0x23b5/0x2790 kernel/signal.c:2893
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x156/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe0/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f403447cda9
Code: Unable to access opcode bytes at 0x7f403447cd7f.
RSP: 002b:00007f40352b20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f40345ac050 RCX: 00007f403447cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f40344c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f40345ac050 R15: 00007fff753e8318
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:2864!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5647 Comm: syz-executor.2 Tainted: G        W          6.8.0-rc2-syzkaller-g861c0981648f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:vunmap+0x77/0xa0 mm/vmalloc.c:2864
Code: 48 89 ef e8 bb fb ff ff 48 85 c0 48 89 c3 74 1c e8 ce d4 b4 ff 48 89 df e8 36 97 02 00 5b 5d e9 bf d4 b4 ff e8 ba d4 b4 ff 90 <0f> 0b e8 b2 d4 b4 ff 90 48 c7 c7 80 ec d9 8a 48 89 ee e8 d2 c5 7a
RSP: 0018:ffffc90000007d18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff81d350c4
RDX: ffff888026f91dc0 RSI: ffffffff81d35116 RDI: 0000000000000005
RBP: ffffc9000dc01000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: ffffffff8a92184a R12: ffff88807c7770a8
R13: fffffbfff1e76003 R14: ffffed1005294888 R15: ffff8880294a4400
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0014eb360 CR3: 000000007a583000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 relay_destroy_buf+0x6e/0x3e0 kernel/relay.c:199
 relay_remove_buf kernel/relay.c:221 [inline]
 kref_put include/linux/kref.h:65 [inline]
 relay_close_buf+0x153/0x1b0 kernel/relay.c:430
 relay_close kernel/relay.c:766 [inline]
 relay_close+0x3a8/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x190 kernel/trace/blktrace.c:316
 blk_trace_rcu_free+0x22/0x30 kernel/trace/blktrace.c:388
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2465
 __do_softirq+0x21a/0x8de kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xb7/0x120 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x70 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 d6 85 d6 f6 48 89 df e8 ce fd d6 f6 f7 c5 00 02 00 00 75 1f 9c 58 f6 c4 02 75 2f <bf> 01 00 00 00 e8 c5 9d c8 f6 65 8b 05 e6 d2 71 75 85 c0 74 12 5b
RSP: 0018:ffffc90009927658 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff92c1b680 RCX: 1ffffffff2436810
RDX: 0000000000000000 RSI: ffffffff8accb000 RDI: ffffffff8b2fdc00
RBP: 0000000000000202 R08: 0000000000000001 R09: fffffbfff242b005
R10: ffffffff9215802f R11: ffffffff8ace3420 R12: 0000000000000001
R13: ffff88801c40a000 R14: 1ffff92001324ed2 R15: ffffffff92c1b678
 debug_object_activate+0x349/0x540 lib/debugobjects.c:726
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common.constprop.0+0x2c/0x7b0 kernel/rcu/tree.c:2700
 security_inode_free+0x9e/0xc0 security/security.c:1616
 __destroy_inode+0x1f8/0x740 fs/inode.c:285
 destroy_inode+0x91/0x1b0 fs/inode.c:308
 iput_final fs/inode.c:1739 [inline]
 iput.part.0+0x560/0x7b0 fs/inode.c:1765
 iput+0x5c/0x80 fs/inode.c:1755
 dentry_unlink_inode+0x292/0x430 fs/dcache.c:400
 __dentry_kill+0x1ca/0x5f0 fs/dcache.c:603
 shrink_kill fs/dcache.c:1048 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
 shrink_dcache_parent+0xe2/0x530 fs/dcache.c:1509
 do_one_tree fs/dcache.c:1538 [inline]
 shrink_dcache_for_umount+0x79/0x390 fs/dcache.c:1555
 generic_shutdown_super+0x76/0x3d0 fs/super.c:624
 kill_anon_super fs/super.c:1230 [inline]
 kill_litter_super+0x70/0xa0 fs/super.c:1240
 binderfs_kill_super+0x3b/0xa0 drivers/android/binderfs.c:781
 deactivate_locked_super+0xbc/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa8a/0x2ad0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 get_signal+0x23b5/0x2790 kernel/signal.c:2893
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x156/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe0/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f403447cda9
Code: Unable to access opcode bytes at 0x7f403447cd7f.
RSP: 002b:00007f40352b20c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f40345ac050 RCX: 00007f403447cda9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f40344c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f40345ac050 R15: 00007fff753e8318
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vunmap+0x77/0xa0 mm/vmalloc.c:2864
Code: 48 89 ef e8 bb fb ff ff 48 85 c0 48 89 c3 74 1c e8 ce d4 b4 ff 48 89 df e8 36 97 02 00 5b 5d e9 bf d4 b4 ff e8 ba d4 b4 ff 90 <0f> 0b e8 b2 d4 b4 ff 90 48 c7 c7 80 ec d9 8a 48 89 ee e8 d2 c5 7a
RSP: 0018:ffffc90000007d18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff81d350c4
RDX: ffff888026f91dc0 RSI: ffffffff81d35116 RDI: 0000000000000005
RBP: ffffc9000dc01000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: ffffffff8a92184a R12: ffff88807c7770a8
R13: fffffbfff1e76003 R14: ffffed1005294888 R15: ffff8880294a4400
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0014eb360 CR3: 000000007a583000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 d6 85 d6 f6       	call   0xf6d685e9
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 ce fd d6 f6       	call   0xf6d6fde9
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 1f                	jne    0x42
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 2f                	jne    0x59
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 c5 9d c8 f6       	call   0xf6c89df9
  34:	65 8b 05 e6 d2 71 75 	mov    %gs:0x7571d2e6(%rip),%eax        # 0x7571d321
  3b:	85 c0                	test   %eax,%eax
  3d:	74 12                	je     0x51
  3f:	5b                   	pop    %rbx


Tested on:

commit:         861c0981 Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1562e290180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101a1d5be80000


