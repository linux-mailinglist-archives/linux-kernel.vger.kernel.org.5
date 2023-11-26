Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9A87F90A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjKZBdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:33:00 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11289102
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 17:33:06 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cfa28b5895so21332465ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 17:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700962385; x=1701567185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMcZmfUYm/9ylT6jwdHAdXqFoXb7FOib9oaS3Ke4x0A=;
        b=oNA8kZEVRgmQcl1NXEcpP95IhKoAnadWNNQDqq3mmisu7wrOWRUOotcXQBcGFG0CGd
         w3Ov9XCdBv1oZk66UKKoNqWHzwlDdRn0GD3k/3wklZsxBit4aiVSstUcW3F9PtjJB50a
         J4U25Cm7837SZpch6AkIX7trgNRhCole4TAfOF4Mu+tsgFkXfB1+2ji/Era9E0uhxGf0
         O5BZkpM24dswAsH8GX3UgXGUfftLo0iPDpdT3XjmDJHrQBZhplDycK93pq6pjN/Kp3pR
         +ISIaqb1rwFlw5OVWhgJfBewIOTEWOozL3L9WGTeWD6zUEBi62m4NA2wKK14pc6m1hYi
         J1qA==
X-Gm-Message-State: AOJu0YzrM473G4OHe6W1YdgwoPaU2chVdQuhh0CsABZubfPLNv4W422q
        VVkypzQosgYoMkSp/YO/hfTHWziLlT2CaT8d52UijUDMoEFX
X-Google-Smtp-Source: AGHT+IF9cBfJwsGW2jyqgTQ7AmQ2DK3JqXjCf59siHnCQxNbUqNyBGmUwjGsv//pXLrqhhG0+lTvSNaKTRRVVHJN1eKVd6shZY0Q
MIME-Version: 1.0
X-Received: by 2002:a17:902:c40d:b0:1cf:8819:a986 with SMTP id
 k13-20020a170902c40d00b001cf8819a986mr1697724plk.8.1700962385657; Sat, 25 Nov
 2023 17:33:05 -0800 (PST)
Date:   Sat, 25 Nov 2023 17:33:05 -0800
In-Reply-To: <20231126011259.821-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c604ad060b042ad8@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in sch_direct_xmit (2)
From:   syzbot <syzbot+e18ac85757292b7baf96@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: bad unlock balance in __dev_queue_xmit

=====================================
WARNING: bad unlock balance detected!
6.7.0-rc2-syzkaller-00206-gb46ae77f6787-dirty #0 Not tainted
-------------------------------------
swapper/1/0 is trying to release lock (_xmit_ETHER) at:
[<ffffffff8854284e>] spin_unlock include/linux/spinlock.h:391 [inline]
[<ffffffff8854284e>] __netif_tx_unlock include/linux/netdevice.h:4441 [inline]
[<ffffffff8854284e>] __dev_queue_xmit+0x1ece/0x3950 net/core/dev.c:4354
but there are no more locks to release!

other info that might help us debug this:
3 locks held by swapper/1/0:
 #0: ffffc900001f0c00 ((&lapb->t1timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x5e0 kernel/time/timer.c:1697
 #1: ffff8880274dbdc0 (&lapb->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff8880274dbdc0 (&lapb->lock){+.-.}-{2:2}, at: lapb_t1timer_expiry+0x33/0xb20 net/lapb/lapb_timer.c:99
 #2: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #2: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:799 [inline]
 #2: ffffffff8cb25c00 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x23e/0x3950 net/core/dev.c:4272

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.7.0-rc2-syzkaller-00206-gb46ae77f6787-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_unlock_imbalance_bug+0x252/0x2c0 kernel/locking/lockdep.c:5193
 lock_release+0x59d/0x9d0 kernel/locking/lockdep.c:5430
 _raw_spin_unlock+0x16/0x40 include/linux/spinlock_api_smp.h:141
 spin_unlock include/linux/spinlock.h:391 [inline]
 __netif_tx_unlock include/linux/netdevice.h:4441 [inline]
 __dev_queue_xmit+0x1ece/0x3950 net/core/dev.c:4354
 lapb_data_transmit+0x89/0xa0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0x168/0x1f0 net/lapb/lapb_out.c:149
 lapb_t1timer_expiry+0x6b8/0xb20
 call_timer_fn+0x17a/0x5e0 kernel/time/timer.c:1700
 __run_timers+0x64f/0x860 kernel/time/timer.c:1751
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
 __do_softirq+0x2bf/0x93a kernel/softirq.c:553
 __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:427
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x20/0x30 drivers/acpi/processor_idle.c:113
Code: 7f 04 eb 36 66 0f 1f 44 00 00 65 48 8b 05 68 a8 96 75 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 36 d4 97 00 f3 0f 1e fa fb f4 <fa> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 89 fa ec 48 8b 05
RSP: 0018:ffffc90000187d08 EFLAGS: 00000246
RAX: ffff88801641bb80 RBX: ffff888016b8a064 RCX: 00000000003c8e21
RDX: 0000000000000001 RSI: ffff888016b8a000 RDI: ffff888016b8a064
RBP: 0000000000038e38 R08: ffff8880b9b36c0b R09: 1ffff11017366d81
R10: dffffc0000000000 R11: ffffed1017366d82 R12: ffff888017e39000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8d236d60
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x10e/0x470 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0x90 drivers/cpuidle/cpuidle.c:388
 do_idle+0x374/0x5c0 kernel/sched/idle.c:134
 cpu_startup_entry+0x41/0x60 kernel/sched/idle.c:380
 start_secondary+0xee/0xf0 arch/x86/kernel/smpboot.c:336
 secondary_startup_64_no_verify+0x167/0x16b
 </TASK>
------------[ cut here ]------------
pvqspinlock: lock 0xffff888025c150c0 has corrupted value 0x0!
WARNING: CPU: 1 PID: 0 at kernel/locking/qspinlock_paravirt.h:510 __pv_queued_spin_unlock_slowpath+0x23b/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.7.0-rc2-syzkaller-00206-gb46ae77f6787-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__pv_queued_spin_unlock_slowpath+0x23b/0x2f0 kernel/locking/qspinlock_paravirt.h:508
Code: e8 0a 70 71 f7 4c 89 f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 9a 00 00 00 41 8b 16 48 c7 c7 40 c6 aa 8a 4c 89 f6 e8 45 19 db f6 <0f> 0b eb 95 44 89 f1 80 e1 07 38 c1 0f 8c 2e ff ff ff 4c 89 f7 e8
RSP: 0018:ffffc900001f0778 EFLAGS: 00010246
RAX: 9cb7c89c3804c300 RBX: dffffc0000000000 RCX: ffff88801641bb80
RDX: 0000000000000502 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff81524a02 R09: 1ffff9200003e044
R10: dffffc0000000000 R11: fffff5200003e045 R12: 1ffff11004b82a1a
R13: ffff888025c150d0 R14: ffff888025c150c0 R15: ffff888025c150c0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020004540 CR3: 000000000c930000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __raw_callee_save___pv_queued_spin_unlock_slowpath+0x15/0x30
 .slowpath+0x9/0x1a
 do_raw_spin_unlock+0x13b/0x8b0 arch/x86/include/asm/paravirt.h:591
 _raw_spin_unlock+0x1e/0x40 include/linux/spinlock_api_smp.h:142
 spin_unlock include/linux/spinlock.h:391 [inline]
 __netif_tx_unlock include/linux/netdevice.h:4441 [inline]
 __dev_queue_xmit+0x1ece/0x3950 net/core/dev.c:4354
 lapb_data_transmit+0x89/0xa0 net/lapb/lapb_iface.c:447
 lapb_transmit_buffer+0x168/0x1f0 net/lapb/lapb_out.c:149
 lapb_t1timer_expiry+0x6b8/0xb20
 call_timer_fn+0x17a/0x5e0 kernel/time/timer.c:1700
 __run_timers+0x64f/0x860 kernel/time/timer.c:1751
 run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2035
 __do_softirq+0x2bf/0x93a kernel/softirq.c:553
 __irq_exit_rcu+0xf1/0x1b0 kernel/softirq.c:427
 irq_exit_rcu+0x9/0x20 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x20/0x30 drivers/acpi/processor_idle.c:113
Code: 7f 04 eb 36 66 0f 1f 44 00 00 65 48 8b 05 68 a8 96 75 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 36 d4 97 00 f3 0f 1e fa fb f4 <fa> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 89 fa ec 48 8b 05
RSP: 0018:ffffc90000187d08 EFLAGS: 00000246
RAX: ffff88801641bb80 RBX: ffff888016b8a064 RCX: 00000000003c8e21
RDX: 0000000000000001 RSI: ffff888016b8a000 RDI: ffff888016b8a064
RBP: 0000000000038e38 R08: ffff8880b9b36c0b R09: 1ffff11017366d81
R10: dffffc0000000000 R11: ffffed1017366d82 R12: ffff888017e39000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8d236d60
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x10e/0x470 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0x90 drivers/cpuidle/cpuidle.c:388
 do_idle+0x374/0x5c0 kernel/sched/idle.c:134
 cpu_startup_entry+0x41/0x60 kernel/sched/idle.c:380
 start_secondary+0xee/0xf0 arch/x86/kernel/smpboot.c:336
 secondary_startup_64_no_verify+0x167/0x16b
 </TASK>
----------------
Code disassembly (best guess):
   0:	7f 04                	jg     0x6
   2:	eb 36                	jmp    0x3a
   4:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
   a:	65 48 8b 05 68 a8 96 	mov    %gs:0x7596a868(%rip),%rax        # 0x7596a87a
  11:	75
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d 36 d4 97 00 	verw   0x97d436(%rip)        # 0x97d45a
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  33:	00 00 00
  36:	0f 1f 40 00          	nopl   0x0(%rax)
  3a:	89 fa                	mov    %edi,%edx
  3c:	ec                   	in     (%dx),%al
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	05                   	.byte 0x5


Tested on:

commit:         b46ae77f Merge tag 'xfs-6.7-fixes-3' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=162a21c8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3813bb4934ffb745
dashboard link: https://syzkaller.appspot.com/bug?extid=e18ac85757292b7baf96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cd35a4e80000

