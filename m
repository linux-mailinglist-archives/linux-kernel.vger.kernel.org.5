Return-Path: <linux-kernel+bounces-141307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2F98A1C56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FED283853
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A216C848;
	Thu, 11 Apr 2024 16:18:42 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FDC160792
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852321; cv=none; b=RgE95VYRWMPCuSdL3DLyiOU4/35abieonuvRNJd5gYiM6XKAcDbQooTCIcwX9bQQeMFzmGAsLq6fDwKGOpB97f0X/4gJI4v1TDEr6AOnohPLjypLS8VK9nS8DjijV29EjfCaCwygZWmJ9SYc7JvBTIr7kuBdxixrzgrfpDxtF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852321; c=relaxed/simple;
	bh=3nxBTAZ+BaxIGyTjMpqWV8SrwIAV+GyPtfUqXeHvXWk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OjOrrXAEgk0zYjzHnrXhCvwlNrtK/EMdfTKyPLhEzs5WUR8948Lj2yHjObl2KbIl2x0WJtHF0NM2LYGKBj0Gc2cLnBV/QqbiFgnrkPrlBvnmQu2OazYX7Cd8ubQIoZ01JVHZs5cz0IZKzfOmYTW9lr0sURYXVoXV/EBgsWIGM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d667dd202cso76033339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852319; x=1713457119;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B88FGiGh75cNg0TAHxbVEKdoV/J0ixZDMdwTkBdvEKc=;
        b=F1e/Nb9Yg86WB/BQkxgfC9u1V0wtbs4nJL6pnTYUEMN1WIWdZlci2A6c0PPGLiNe8E
         J8Kt+Es6f64nzN9MqzdZphPh9Gun1XklFo40mbHbcTchP2BZESgZUqE3O930+Ux0suJ7
         vP3mYno6MmE8wen7Xse6mSV6n/DZlUS2PWDwmTu3cEXFbRRmhVhsp8bp/nGvsnUnV5l+
         gAckeRLYSnb/FrcR//YM7smQPCieFo3OgoOqAfJeBY2Qz+lNxnIaM+qGFqiJBDc+TAfZ
         MaQqUZVi9yaKzMwtrEt30ewoUMl4bWYlIkYOW3LmV0MQ797W4hZ9wl50OntpgCR8irS2
         ry4Q==
X-Gm-Message-State: AOJu0YwN0hll6K5HzIU/Z6Z6bVRNv5Sw1e4WEYi/vpNYm/BGOuKdiPjG
	EIjto3sve4e3d9VD6ZU8dDEIT5zeaAt/i3xaKg2vM33FlUEo9hG7YqxY+z24qEQVhwCF8Jeyq/M
	x5GB77rmc0QUcIYhSvCBiRr08+y7GzkYihNN30Fe4XpUMTvkqo99SEwQ=
X-Google-Smtp-Source: AGHT+IFERoBRdmKftfm+fRa0MUHdmJ/GLwiwQMish07N+W/mdzpwPlElMeOA3XoTmzgM8KydHTZz6JkrLvebEaaLs9BAwHNbaPSx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d05:b0:482:cedf:44cb with SMTP id
 he5-20020a0566386d0500b00482cedf44cbmr16651jab.1.1712852319352; Thu, 11 Apr
 2024 09:18:39 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:18:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c4ce90615d48234@google.com>
Subject: [syzbot] [sound?] inconsistent lock state in snd_timer_interrupt (3)
From: syzbot <syzbot+0a26629966fddb6d4760@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108c0033180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=0a26629966fddb6d4760
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

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
syz-executor.0/6231 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff888029d3e948 (&timer->lock){+.?.}-{2:2}, at: class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
ffff888029d3e948 (&timer->lock){+.?.}-{2:2}, at: snd_timer_interrupt.part.0+0x31/0xd80 sound/core/timer.c:818
{SOFTIRQ-ON-W} state was registered at:
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
  snd_seq_queue_client_leave+0x37/0x1a0 sound/core/seq/seq_queue.c:543
  seq_free_client1.part.0+0x10a/0x260 sound/core/seq/seq_clientmgr.c:285
  seq_free_client1 sound/core/seq/seq_clientmgr.c:278 [inline]
  seq_free_client+0x74/0x170 sound/core/seq/seq_clientmgr.c:306
  snd_seq_release+0x50/0xe0 sound/core/seq/seq_clientmgr.c:387
  __fput+0x270/0xb80 fs/file_table.c:422
  __fput_sync+0x47/0x50 fs/file_table.c:507
  __do_sys_close fs/open.c:1556 [inline]
  __se_sys_close fs/open.c:1541 [inline]
  __x64_sys_close+0x86/0x100 fs/open.c:1541
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x6d/0x75
irq event stamp: 557067
hardirqs last  enabled at (557066): [<ffffffff8ad60263>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (557066): [<ffffffff8ad60263>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (557067): [<ffffffff8ad60002>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (557067): [<ffffffff8ad60002>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (556564): [<ffffffff893d57bc>] tcp_close+0x3c/0xc0 net/ipv4/tcp.c:2933
softirqs last disabled at (557063): [<ffffffff8151a149>] invoke_softirq kernel/softirq.c:428 [inline]
softirqs last disabled at (557063): [<ffffffff8151a149>] __irq_exit_rcu kernel/softirq.c:633 [inline]
softirqs last disabled at (557063): [<ffffffff8151a149>] irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&timer->lock);
  <Interrupt>
    lock(&timer->lock);

 *** DEADLOCK ***

8 locks held by syz-executor.0/6231:
 #0: ffffffff8d8b9030 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap kernel/fork.c:637 [inline]
 #0: ffffffff8d8b9030 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1687 [inline]
 #0: ffffffff8d8b9030 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm kernel/fork.c:1736 [inline]
 #0: ffffffff8d8b9030 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x67cb/0x9160 kernel/fork.c:2389
 #1: ffff88807c1481a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:124 [inline]
 #1: ffff88807c1481a0 (&mm->mmap_lock){++++}-{3:3}, at: dup_mmap kernel/fork.c:638 [inline]
 #1: ffff88807c1481a0 (&mm->mmap_lock){++++}-{3:3}, at: dup_mm kernel/fork.c:1687 [inline]
 #1: ffff88807c1481a0 (&mm->mmap_lock){++++}-{3:3}, at: copy_mm kernel/fork.c:1736 [inline]
 #1: ffff88807c1481a0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x67f1/0x9160 kernel/fork.c:2389
 #2: ffff88801dce8b20 (&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:115 [inline]
 #2: ffff88801dce8b20 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:647 [inline]
 #2: ffff88801dce8b20 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mm kernel/fork.c:1687 [inline]
 #2: ffff88801dce8b20 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_mm kernel/fork.c:1736 [inline]
 #2: ffff88801dce8b20 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x6851/0x9160 kernel/fork.c:2389
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #3: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __pte_offset_map+0x42/0x540 mm/pgtable-generic.c:285
 #4: ffff88807af29d98 (ptlock_ptr(ptdesc)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff88807af29d98 (ptlock_ptr(ptdesc)#2){+.+.}-{2:2}, at: __pte_offset_map_lock+0xf1/0x300 mm/pgtable-generic.c:373
 #5: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #5: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #5: ffffffff8d7b08e0 (rcu_read_lock){....}-{1:2}, at: __pte_offset_map+0x42/0x540 mm/pgtable-generic.c:285
 #6: ffff88807af29078 (ptlock_ptr(ptdesc)#2/1){+.+.}-{2:2}, at: copy_pte_range mm/memory.c:1059 [inline]
 #6: ffff88807af29078 (ptlock_ptr(ptdesc)#2/1){+.+.}-{2:2}, at: copy_pmd_range mm/memory.c:1187 [inline]
 #6: ffff88807af29078 (ptlock_ptr(ptdesc)#2/1){+.+.}-{2:2}, at: copy_pud_range mm/memory.c:1224 [inline]
 #6: ffff88807af29078 (ptlock_ptr(ptdesc)#2/1){+.+.}-{2:2}, at: copy_p4d_range mm/memory.c:1248 [inline]
 #6: ffff88807af29078 (ptlock_ptr(ptdesc)#2/1){+.+.}-{2:2}, at: copy_page_range+0xd1c/0x3d10 mm/memory.c:1346
 #7: ffffc90000007cb0 ((&priv->tlist)){+.-.}-{0:0}, at: call_timer_fn+0x11a/0x5b0 kernel/time/timer.c:1789

stack backtrace:
CPU: 0 PID: 6231 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
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
RIP: 0010:_compound_head+0x2f/0x140 include/linux/page-flags.h:249
Code: 89 fb e8 34 0e bd ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f0 00 00 00 4c 8b 63 08 <31> ff 4c 89 e5 83 e5 01 48 89 ee e8 11 09 bd ff 48 85 ed 0f 85 b8
RSP: 0018:ffffc90003f5f7c0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffffea00019f14c0 RCX: ffffffff81d07ea4
RDX: 1ffffd400033e299 RSI: ffffffff81cfea7c RDI: ffffea00019f14c8
RBP: ffffea00019f14c0 R08: 0000000000000006 R09: 000000000023ffff
R10: 0000000000067c53 R11: 0000000000000007 R12: 0000000000000000
R13: 0000000000000028 R14: dffffc0000000000 R15: ffff88805b271b48
 copy_present_pte mm/memory.c:950 [inline]
 copy_pte_range mm/memory.c:1102 [inline]
 copy_pmd_range mm/memory.c:1187 [inline]
 copy_pud_range mm/memory.c:1224 [inline]
 copy_p4d_range mm/memory.c:1248 [inline]
 copy_page_range+0xee1/0x3d10 mm/memory.c:1346
 dup_mmap kernel/fork.c:747 [inline]
 dup_mm kernel/fork.c:1687 [inline]
 copy_mm kernel/fork.c:1736 [inline]
 copy_process+0x81bf/0x9160 kernel/fork.c:2389
 kernel_clone+0xfd/0x940 kernel/fork.c:2796
 __do_sys_clone+0xba/0x100 kernel/fork.c:2939
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f4dfb27ae93
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffd2aa8b288 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4dfb27ae93
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 00005555670ea750 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 fb                	mov    %edi,%ebx
   2:	e8 34 0e bd ff       	call   0xffbd0e3b
   7:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
   b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  12:	fc ff df
  15:	48 89 fa             	mov    %rdi,%rdx
  18:	48 c1 ea 03          	shr    $0x3,%rdx
  1c:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  20:	0f 85 f0 00 00 00    	jne    0x116
  26:	4c 8b 63 08          	mov    0x8(%rbx),%r12
* 2a:	31 ff                	xor    %edi,%edi <-- trapping instruction
  2c:	4c 89 e5             	mov    %r12,%rbp
  2f:	83 e5 01             	and    $0x1,%ebp
  32:	48 89 ee             	mov    %rbp,%rsi
  35:	e8 11 09 bd ff       	call   0xffbd094b
  3a:	48 85 ed             	test   %rbp,%rbp
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	b8                   	.byte 0xb8


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

