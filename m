Return-Path: <linux-kernel+bounces-106613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957987F0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44C81F23D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEB57865;
	Mon, 18 Mar 2024 20:09:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041958100
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792565; cv=none; b=SIrKZ00u0CzC9qfqif5Npa0di+sQU6i3XrOyPqHOhMV+Ok+DdEpd2Bp+6k9K2NM+CI+rDSZVIOPtE9lGDJDUR8NFSxuOvIcKulXMLVMECh/562zfeeJeD+caFfJ4KFj1+srhxk9V3vYoYTkaN8cxf47et/lhPYRQC6mwt2QMtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792565; c=relaxed/simple;
	bh=4ZvB0P1A9euRMXZ18Vxh7s6VsSarGosZC7A98PK7Mh0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pm8Lo4QcTDuWv9YxDqLQtr1LlnZdX0szNF4bZgOB2Ezscxa7O47fqVsxJZofRbMp/q6BtUI/hvw2y3bvnIrukMgRwi0r9Xg7WIHdB5B/bCPvesNKSC+wRIfU7f1c+zI273mEoZz4bD6K5wtGAakXlbQ+/80cxZ4rvTyJq0Hhqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8742bedd4so425936239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792563; x=1711397363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/iBbcB5+Py1tzqROnlNaTIxdElDFlDoRpvjKYNXpbM=;
        b=EgGg3brasoqbYZ3Kuh5m7zYpkeVqUrkQjKCAw9IkWPDwIIkf2xm5vnc1MedYtigMwQ
         6UFMuLqKekehwtaU6AVRU6+BAHU6u8HU1A27DjFjhix9qczVdN+ZwFExUKtL9/5KdtZn
         ccytyl/W4AhHm2/cPqC1aAMSKbW5yT4AZfHz/uvBrs+/PXJ7+1jEwvTErG9FXyl02g0q
         2LEh4KS5CLR9aEooiKcwC2y8Uv0bqGGffpfukuXV+CoKAKXp6lTlw60n80LV7EiGoGK3
         PS27FWr9kd98psxe8QgBstopULdUDP4iWBnp4VGuBsU9cgPNrEfBbz1s9wTFkLg/nso0
         vdjA==
X-Gm-Message-State: AOJu0YypU0X3lVDdnWT67UGMaiJ96fVAE6wZU0zGYSjHyMC4S1uhILGA
	UJPVlDhY/8Q1tja/CUYJ6Cy6JrCv2ySi5ypDGAO1hiCuQHxNB4AQPo1gQT7oi/ppVhJLYZGpDZ0
	Tmttymarp1Wy9pTPsQf81VUViBcmqNlFtdf6oIzN5u5WyUIE5JKC4InsMbQ==
X-Google-Smtp-Source: AGHT+IHkytdWU4VpiO3JrHz+BGduFNb9ep0mdS7Rs90pTEtDZJmxz8lOl/lq/P8gXyUAASlggdrQRwvWaWOkKUstZU7twzGDDApq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a9:b0:477:2080:50ec with SMTP id
 v41-20020a05663835a900b00477208050ecmr34919jal.3.1710792563259; Mon, 18 Mar
 2024 13:09:23 -0700 (PDT)
Date: Mon, 18 Mar 2024 13:09:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000048fbc0613f4eff0@google.com>
Subject: [syzbot] [sound?] inconsistent lock state in snd_timer_interrupt
From: syzbot <syzbot+d832e7bb0f8bf47217f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11bd6569180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=d832e7bb0f8bf47217f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165534f1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145cfbb6180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d832e7bb0f8bf47217f1@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/0/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff8880297a3148 (&timer->lock){+.?.}-{2:2}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
ffff8880297a3148 (&timer->lock){+.?.}-{2:2}, at: snd_timer_interrupt.part.0+0x31/0xd80 sound/core/timer.c:818
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  class_spinlock_constructor include/linux/spinlock.h:561 [inline]
  snd_timer_close_locked+0x65/0xbd0 sound/core/timer.c:412
  snd_timer_close+0x8b/0xf0 sound/core/timer.c:464
  snd_timer_user_release+0x91/0x260 sound/core/timer.c:1468
  __fput+0x270/0xb80 fs/file_table.c:422
  task_work_run+0x14e/0x250 kernel/task_work.c:180
  exit_task_work include/linux/task_work.h:38 [inline]
  do_exit+0xa7d/0x2be0 kernel/exit.c:878
  do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
  __do_sys_exit_group kernel/exit.c:1038 [inline]
  __se_sys_exit_group kernel/exit.c:1036 [inline]
  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75
irq event stamp: 526819
hardirqs last  enabled at (526818): [<ffffffff8ae0154a>] asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
hardirqs last disabled at (526819): [<ffffffff8ad60002>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (526819): [<ffffffff8ad60002>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (526756): [<ffffffff8ad63156>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (526756): [<ffffffff8ad63156>] __do_softirq+0x596/0x8de kernel/softirq.c:583
softirqs last disabled at (526813): [<ffffffff8151a149>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (526813): [<ffffffff8151a149>] __irq_exit_rcu kernel/softirq.c:633 [inline]
softirqs last disabled at (526813): [<ffffffff8151a149>] irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&timer->lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

1 lock held by swapper/0/0:
 #0: ffffc90000007cb0 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0x11a/0x5b0 kernel/time/timer.c:1789

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4567 [inline]
 __lock_acquire+0x13d4/0x3b30 kernel/locking/lockdep.c:5091
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
 snd_timer_interrupt.part.0+0x31/0xd80 sound/core/timer.c:818
 snd_timer_interrupt sound/core/timer.c:1107 [inline]
 snd_timer_s_function+0x14f/0x200 sound/core/timer.c:1107
 call_timer_fn+0x1a0/0x5b0 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers+0x74b/0xab0 kernel/time/timer.c:2408
 __run_timer_base kernel/time/timer.c:2419 [inline]
 __run_timer_base kernel/time/timer.c:2412 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2428
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2438
 __do_softirq+0x218/0x8de kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 d8 60 31 75 48 8b 00 a8 08 75 0c 66 90 0f 00 2d c8 73 a7 00 fb f4 <fa> c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8d407d68 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8ad255f9
RDX: 0000000000000001 RSI: ffff8880196e4000 RDI: ffff8880196e4064
RBP: ffff8880196e4064 R08: 0000000000000001 R09: ffffed1017286fdd
R10: ffff8880b9437eeb R11: 0000000000000000 R12: ffff8880151de800
R13: ffffffff8e31fbc0 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x85/0x510 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x313/0x3f0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x16f/0x2b0 init/main.c:730
 arch_call_rest_init+0x13/0x40 init/main.c:831
 start_kernel+0x3a3/0x490 init/main.c:1077
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
 common_startup_64+0x13e/0x148
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	65 48 8b 05 d8 60 31 	mov    %gs:0x753160d8(%rip),%rax        # 0x753160f0
  17:	75
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d c8 73 a7 00 	verw   0xa773c8(%rip)        # 0xa773f0
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

