Return-Path: <linux-kernel+bounces-143970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E428A402E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87483B212B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7191C696;
	Sun, 14 Apr 2024 04:05:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8E1799D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067523; cv=none; b=H4+4Cziyoev24+Zh1Vo0PcKn9F8sLy97gEpD3l1S9w251AEq75eQxw/h2zHb3x0123gn8loEoJznKFnzGtxVuW/aggDNem4mXksvZkzuE/FgwMKraUpq+qExsn35wWc8OdaMTiKKiR2FW58soRV+M9MooXxwrKM7zaajCgIgi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067523; c=relaxed/simple;
	bh=PHnpQ9knWgdkL/CpEkqASiglkPLjzFNaWTFjn9IJnL8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=abNbNx8TLN8dMrE/T9EeI9SB5zRr++o0CkmR46QAQsdDeuPycUNmIuHWMwvTucyl2tya0w7Bf89bMnFbbSGMXSb6RHxKBis4otlbQl/ANRqKDfdiMj4QsE9cLazHkrCkoEPETbu9wIqs/S9rHJ3mswHk4RSJunAXy+yxEjJEEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369f9e8863dso17629785ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713067520; x=1713672320;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lFbF74IzAUC3Ucgr2e173mfHWYrtMomivw/RCYbuEpM=;
        b=vbovG0PI08WAbCJcxldpjgMJGJW1cyM31p6wUWxrzD4locmKbn3NWjNM9PqzWkHkFy
         3SsB+tD/NMbwECFJkR4o79OwxbdSuUVzTfM2JpOgm/5vG2Ij2fNx9EDygtcb6XxEBbEg
         1pSu5POdpm4zpZO6hXC7u6DAUdbCBkEyA91cDVURGpjDtMGCEJvTyOsasn2emlJGos1Q
         OCd5m+2LSzmJRvY3bz+YVnxUJ9TRPUWRyfyn7JB5tgF1d6JwIQSBqR8c8bz9sjWvkp6+
         iA1pXgU6jnxind6EzHIBE6nEeLuHaxRYOOkP7orJIMUTYekdCqRW/qBjj/IMbNrCEMlD
         FS7A==
X-Gm-Message-State: AOJu0YyspSSPnL4m+zd+D1XK8ptoSERlNWEK3tl9YC0V8Us5zcm5xypx
	NIZqzpV07RzKQaccNUBt3nUGg/36TxQwyI9LNWwEAab+R1jQp4CgjQeZjZqJFlsg41PsF+A+dBW
	51f/Pd6zag9QEOHoMap0J3JLPFkEehjcdIiz96MibYWtyIbqvb8aA85w=
X-Google-Smtp-Source: AGHT+IGxMqYgXMlxoShhddIYijbqoNeftFpNBKTDr9MplfZ0fMrxuvrjYmEBnlFN+UgIEVbyvmeA6aQGeAdnh12Maw8zUzEkhU8Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0d:b0:36b:f8:e87e with SMTP id
 l13-20020a056e021c0d00b0036b00f8e87emr508517ilh.1.1713067520622; Sat, 13 Apr
 2024 21:05:20 -0700 (PDT)
Date: Sat, 13 Apr 2024 21:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b0bf30616069d1e@google.com>
Subject: [syzbot] [sound?] inconsistent lock state in snd_hrtimer_callback (2)
From: syzbot <syzbot+8933e1c7c07fe8f2dcd3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131723e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=8933e1c7c07fe8f2dcd3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124ffb75180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160df5cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8933e1c7c07fe8f2dcd3@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
syz-executor390/5221 [HC1[1]:SC0[0]:HE0:SE1] takes:
ffff8880294bb948 (&timer->lock){?.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff8880294bb948 (&timer->lock){?.+.}-{2:2}, at: class_spinlock_constructor include/linux/spinlock.h:561 [inline]
ffff8880294bb948 (&timer->lock){?.+.}-{2:2}, at: snd_hrtimer_callback+0x4d/0x420 sound/core/hrtimer.c:38
{HARDIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  class_spinlock_constructor include/linux/spinlock.h:561 [inline]
  snd_timer_close_locked+0x65/0xbd0 sound/core/timer.c:412
  snd_timer_close+0x8b/0xf0 sound/core/timer.c:464
  snd_seq_timer_close+0xa4/0x100 sound/core/seq/seq_timer.c:302
  queue_delete+0x49/0xa0 sound/core/seq/seq_queue.c:126
  snd_seq_queue_delete+0x45/0x60 sound/core/seq/seq_queue.c:188
  snd_seq_kernel_client_ctl+0x107/0x1c0 sound/core/seq/seq_clientmgr.c:2526
  delete_seq_queue.isra.0+0xc8/0x150 sound/core/seq/oss/seq_oss_init.c:371
  odev_release+0x52/0x80 sound/core/seq/oss/seq_oss.c:144
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
irq event stamp: 1534
hardirqs last  enabled at (1533): [<ffffffff8ad602f2>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1533): [<ffffffff8ad602f2>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
hardirqs last disabled at (1534): [<ffffffff8ad239ae>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1043
softirqs last  enabled at (1258): [<ffffffff8ad63156>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (1258): [<ffffffff8ad63156>] __do_softirq+0x596/0x8de kernel/softirq.c:583
softirqs last disabled at (1231): [<ffffffff8151a149>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (1231): [<ffffffff8151a149>] __irq_exit_rcu kernel/softirq.c:633 [inline]
softirqs last disabled at (1231): [<ffffffff8151a149>] irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&timer->lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

2 locks held by syz-executor390/5221:
 #0: ffffffff8f1daaa8 (register_mutex#4){+.+.}-{3:3}, at: odev_release+0x4a/0x80 sound/core/seq/oss/seq_oss.c:143
 #1: ffff8880290321d0 (&client->ioctl_mutex){+.+.}-{3:3}, at: snd_seq_client_ioctl_lock+0x36/0x50 sound/core/seq/seq_clientmgr.c:182

stack backtrace:
CPU: 0 PID: 5221 Comm: syz-executor390 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4564 [inline]
 __lock_acquire+0x1359/0x3b30 kernel/locking/lockdep.c:5091
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 class_spinlock_constructor include/linux/spinlock.h:561 [inline]
 snd_hrtimer_callback+0x4d/0x420 sound/core/hrtimer.c:38
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 a6 3f 95 f6 48 89 df e8 0e bb 95 f6 f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 95 08 87 f6 65 8b 05 e6 d0 2d 75 85 c0 74 16 5b
RSP: 0018:ffffc90004507ac8 EFLAGS: 00000246
RAX: 0000000000000002 RBX: ffffffff8f1d9240 RCX: 1ffffffff27bef1a
RDX: 0000000000000000 RSI: ffffffff8b0cb740 RDI: ffffffff8b6e88a0
RBP: 0000000000000293 R08: 0000000000000001 R09: fffffbfff27b4e49
R10: ffffffff93da724f R11: 0000000000000002 R12: 0000000000000293
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000000000f
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 class_spinlock_irqsave_destructor include/linux/spinlock.h:574 [inline]
 queueptr+0x9a/0xd0 sound/core/seq/seq_queue.c:201
 snd_seq_queue_remove_cells+0x104/0x230 sound/core/seq/seq_queue.c:589
 snd_seq_ioctl_remove_events+0xf3/0x1b0 sound/core/seq/seq_clientmgr.c:1939
 snd_seq_kernel_client_ctl+0x107/0x1c0 sound/core/seq/seq_clientmgr.c:2526
 snd_seq_oss_control sound/core/seq/oss/seq_oss_device.h:148 [inline]
 snd_seq_oss_writeq_clear+0x11b/0x270 sound/core/seq/oss/seq_oss_writeq.c:73
 snd_seq_oss_reset+0x1fc/0x290 sound/core/seq/oss/seq_oss_init.c:442
 snd_seq_oss_release+0x7c/0x180 sound/core/seq/oss/seq_oss_init.c:407
 odev_release+0x52/0x80 sound/core/seq/oss/seq_oss.c:144
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
RIP: 0033:0x7f97adaa1b89
Code: Unable to access opcode bytes at 0x7f97adaa1b5f.
RSP: 002b:00007fff3831ad88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f97adaa1b89
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f97adb1c290 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f97adb1c290
R13: 0000000000000000 R14: 00007f97adb1cce0 R15: 00007f97ada72dd0
 </TASK>
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
   7:	48 89 fb             	mov    %rdi,%rbx
   a:	48 83 c7 18          	add    $0x18,%rdi
   e:	e8 a6 3f 95 f6       	call   0xf6953fb9
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 0e bb 95 f6       	call   0xf695bb29
  1b:	f7 c5 00 02 00 00    	test   $0x200,%ebp
  21:	75 23                	jne    0x46
  23:	9c                   	pushf
  24:	58                   	pop    %rax
  25:	f6 c4 02             	test   $0x2,%ah
  28:	75 37                	jne    0x61
* 2a:	bf 01 00 00 00       	mov    $0x1,%edi <-- trapping instruction
  2f:	e8 95 08 87 f6       	call   0xf68708c9
  34:	65 8b 05 e6 d0 2d 75 	mov    %gs:0x752dd0e6(%rip),%eax        # 0x752dd121
  3b:	85 c0                	test   %eax,%eax
  3d:	74 16                	je     0x55
  3f:	5b                   	pop    %rbx


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

