Return-Path: <linux-kernel+bounces-141370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD35E8A1E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A18CB24BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8E1D4296;
	Thu, 11 Apr 2024 17:03:40 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7274F21D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855019; cv=none; b=TIQkwLOhS/YROI7YVzkP8JzUtT4mxt1rvMe6uPmlvPbUkABQ+wicoE0VQuSIeLFbsbsNIiaxerJWUxzvilyD5YCtMCWYY4hV29wqV5HO3FSdVJI6VL36fQXeqSKLGrICl0ADbNW5oE5fLXp1Yxmm9Xhx56BG3rJyklc7KHY6zN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855019; c=relaxed/simple;
	bh=dnaM3GqXhEndWfy7lmeLBcJFLVPFM0ewZGwnnAppOoo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tmp8PuiU1ktLZphGNTOVWRkjEQCNRegDpM2McaNhndJrSh2SpHubbwu9vX+jejxLafaLZUn9PhMeHmbAg9ojbH4+ZeRqHmBoL6NgKsHKeI4v50M9DHdv1YNs4Z7fMgV3QAmRfjsBj+r4cuL/SikrG2IY2JItKx0i7TqxQ2lfNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a1ab65a52so789245ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855017; x=1713459817;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LD4Dej9wVib/8Ke490DpdvB28vLogXA7Za+Vfqj32gg=;
        b=ET3ZeIgS9A2eY8ZaOFN4J4O3wnxpy5JpAh6Qzy8IHLBIt/EJNoPaKWAkE2nZ3LsPCw
         LBGnNSzHtX6o3+7JUXIRSkJBb/PWSzq6sT85HcUaflo6roSO38xVuv8p0vQfCHJwGDyw
         RR/lk2mGwD/wLEqZPGy6jg6FqATN9nBZz0ViDT1a2Ysnk9H7Oxek64k81Im3yG2wwqor
         TG+wOgHF5YB7/i31Q3HvEmhKajl+5sFLyZd/cMm1GZXdOoKhfnvaHAShhuWRK83sweFb
         +MgcEl/fAxeEnpH4jrZhwMiilP4c/sgFKEC9EP2cgcgInJsB0vbU/UMWCignN3+8Sqr+
         Naig==
X-Gm-Message-State: AOJu0YwM07ROfL3MwzgpBzah8vM2CClmlHdMgUyO/B0Ipyh4p8kHhaOu
	TzoQXQRZc5oYG0WgM6K6Uypli6ItGEo5jxPZ6bRW6dg/2esQKcw8QUPC12NTkCGUOQPgr2UbhKB
	9RjNI6cqUpww39OJyo6Oanf9Ghkqp+TQ1EfVBmdkDpc1fwTgiLNSYSPg=
X-Google-Smtp-Source: AGHT+IFhOpaGIuYKeU+rjQv1gh2el87cA+XCD5vcAIwpZ5uvqwNODSZd2Sqydxkz77a9kHk6BB4Rcf6oqnGXlO33QhPWBxriAvNO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:36a:3615:33e4 with SMTP id
 j13-20020a92ca0d000000b0036a361533e4mr3698ils.4.1712855017321; Thu, 11 Apr
 2024 10:03:37 -0700 (PDT)
Date: Thu, 11 Apr 2024 10:03:37 -0700
In-Reply-To: <0000000000000c4ce90615d48234@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc09110615d5224e@google.com>
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_timer_interrupt (3)
From: syzbot <syzbot+0a26629966fddb6d4760@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121359f3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=0a26629966fddb6d4760
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108019d5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17274c85180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a26629966fddb6d4760@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
swapper/1/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff888029e8d948 (&timer->lock){+.?.}-{2:2}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
ffff888029e8d948 (&timer->lock){+.?.}-{2:2}, at: snd_timer_interrupt.part.0+0x31/0xd80 sound/core/timer.c:818
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
irq event stamp: 171005
hardirqs last  enabled at (171004): [<ffffffff8ad60263>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (171004): [<ffffffff8ad60263>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (171005): [<ffffffff8ad60002>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (171005): [<ffffffff8ad60002>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (170994): [<ffffffff8ad63156>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (170994): [<ffffffff8ad63156>] __do_softirq+0x596/0x8de kernel/softirq.c:583
softirqs last disabled at (171001): [<ffffffff8151a149>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (171001): [<ffffffff8151a149>] __irq_exit_rcu kernel/softirq.c:633 [inline]
softirqs last disabled at (171001): [<ffffffff8151a149>] irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&timer->lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

1 lock held by swapper/1/0:
 #0: ffffc90000a08cb0 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0x11a/0x5b0 kernel/time/timer.c:1789

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
RSP: 0018:ffffc90000197d58 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8ad255f9
RDX: 0000000000000001 RSI: ffff88801bef0800 RDI: ffff88801bef0864
RBP: ffff88801bef0864 R08: 0000000000000001 R09: ffffed10172a6fdd
R10: ffff8880b9537eeb R11: 0000000000000000 R12: ffff888017bbe000
R13: ffffffff8e31fbc0 R14: 0000000000000001 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x85/0x510 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x313/0x3f0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
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
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

