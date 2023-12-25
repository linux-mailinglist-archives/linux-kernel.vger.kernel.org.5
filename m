Return-Path: <linux-kernel+bounces-10866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A195881DD94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F061C21595
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 02:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFC9A4C;
	Mon, 25 Dec 2023 02:31:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3C804
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7fdc371f7so388133039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 18:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703471464; x=1704076264;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uT00usmickWVASaiNf01UIttSMrp/tjBgn2LC5lwk6c=;
        b=qgYUfDChJiJ8nQWO7h0ZPk81HFibEUBe12tWE6rXDypNsoC9ETRoIIf9jyUBwSriOY
         EOpSgP4ydL5dtIod6Y3rxTWDnHgWB991KqVEMfsnU/XHKsur7xmIuJA2uhkNPRfcAwxL
         qofrCcoM8T8y2/9ZJ+pWOqVoVBIdE3sI92KtcdmJ3u+5G4w7iMafxT8wqpC69ApcTBxm
         yqlxIr+e55k8nLfP9Sr/ttfZaknib9b9Q2vs9KwmqWs2V2rzSQHE8RfFVcYHxm8E6I7I
         LijlWiAWSvimYWRxAeKRaIwxYHGDVO0yLAgVyR4rDJENBWCrQP/YOYZLdynGpd7Ssyp5
         vsrA==
X-Gm-Message-State: AOJu0YwQLlEbxzr6nI5fy9o8IWkp3QZh/YDvo6tob5pO98PpD/aZ3Wpm
	y9JQP11uD0kQE4F1fGnOdRngyxZAcxz7WXMXlDrC4LyWRSG8en0=
X-Google-Smtp-Source: AGHT+IEeD+tKikghTZlVI6LBVJXAam44kPZMdO1JlMkHlHs+SDhV0sGfKR0KLhdY/roQpXyq/J+Wc5i0XXcgUIR6wPADyScJLb6a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3586:b0:46b:6ffc:cb79 with SMTP id
 v6-20020a056638358600b0046b6ffccb79mr181392jal.3.1703471464335; Sun, 24 Dec
 2023 18:31:04 -0800 (PST)
Date: Sun, 24 Dec 2023 18:31:04 -0800
In-Reply-To: <20231225015451.2518934-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084539f060d4c5b09@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
From: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
inconsistent lock state in unlink_file_vma

================================
WARNING: inconsistent lock state
6.7.0-rc5-syzkaller-00042-g88035e5694a8-dirty #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.0/5423 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff888071f79078
 (timekeeper_lock
){?.-.}-{2:2}
, at: i_mmap_lock_write include/linux/fs.h:512 [inline]
, at: unlink_file_vma+0x81/0x120 mm/mmap.c:128
{IN-HARDIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:162
  timekeeping_advance+0x82/0xf10 kernel/time/timekeeping.c:2159
  update_wall_time+0x11/0x40 kernel/time/timekeeping.c:2231
  tick_periodic+0x18b/0x230 kernel/time/tick-common.c:97
  tick_handle_periodic+0x45/0x120 kernel/time/tick-common.c:112
  timer_interrupt+0x48/0x70 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x22a/0x750 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x261/0xcf0 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xdb/0x240 arch/x86/kernel/irq.c:257
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
  console_flush_all+0xa0e/0xd60 kernel/printk/printk.c:2973
  console_unlock+0x10c/0x260 kernel/printk/printk.c:3036
  vprintk_emit+0x17f/0x5f0 kernel/printk/printk.c:2303
  vprintk+0x7b/0x90 kernel/printk/printk_safe.c:45
  _printk+0xc8/0x100 kernel/printk/printk.c:2328
  setup_umip arch/x86/kernel/cpu/common.c:379 [inline]
  identify_cpu+0xcfe/0x2390 arch/x86/kernel/cpu/common.c:1878
  identify_boot_cpu arch/x86/kernel/cpu/common.c:1980 [inline]
  arch_cpu_finalize_init+0x11/0x160 arch/x86/kernel/cpu/common.c:2343
  start_kernel+0x32c/0x480 init/main.c:1039
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
  secondary_startup_64_no_verify+0x166/0x16b
irq event stamp: 165397
hardirqs last  enabled at (165397): [<ffffffff81de4612>] kasan_quarantine_put+0x102/0x230 mm/kasan/quarantine.c:242
hardirqs last disabled at (165396): [<ffffffff81de45ba>] kasan_quarantine_put+0xaa/0x230 mm/kasan/quarantine.c:215
softirqs last  enabled at (165306): [<ffffffff8130d599>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (165306): [<ffffffff8130d599>] fpregs_unlock arch/x86/include/asm/fpu/api.h:80 [inline]
softirqs last  enabled at (165306): [<ffffffff8130d599>] fpu__clear_user_states+0xf9/0x1e0 arch/x86/kernel/fpu/core.c:771
softirqs last disabled at (165304): [<ffffffff8130d4d9>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (165304): [<ffffffff8130d4d9>] fpregs_lock arch/x86/include/asm/fpu/api.h:72 [inline]
softirqs last disabled at (165304): [<ffffffff8130d4d9>] fpu__clear_user_states+0x39/0x1e0 arch/x86/kernel/fpu/core.c:745

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(
timekeeper_lock);
  <Interrupt>
    lock(timekeeper_lock
);

 *** DEADLOCK ***

1 lock held by syz-executor.0/5423:
 #0: ffff888016694420
 (&mm->mmap_lock
){++++}-{3:3}
, at: mmap_write_lock include/linux/mmap_lock.h:108 [inline]
, at: exit_mmap+0x1ef/0xa70 mm/mmap.c:3316

stack backtrace:
CPU: 0 PID: 5423 Comm: syz-executor.0 Not tainted 6.7.0-rc5-syzkaller-00042-g88035e5694a8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x91a/0xc50 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4587 [inline]
 __lock_acquire+0x931/0x3b20 kernel/locking/lockdep.c:5091
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1ae/0x520 kernel/locking/lockdep.c:5719
 down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
 i_mmap_lock_write include/linux/fs.h:512 [inline]
 unlink_file_vma+0x81/0x120 mm/mmap.c:128
 free_pgtables+0x311/0x800 mm/memory.c:401
 exit_mmap+0x383/0xa70 mm/mmap.c:3319
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2ae0 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f8e26c7cba9
Code: Unable to access opcode bytes at 0x7f8e26c7cb7f.
RSP: 002b:00007ffc0e242a78 EFLAGS: 00000246
 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f8e26c7cba9
RDX: 00007f8e26ca7fb5 RSI: 0000000000000000 RDI: 000000000000000b
RBP: 00007ffc0e24314c R08: 0000000000000001 R09: 000000000000000b
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000014683 R14: 0000000000014581 R15: 0000000000000000
 </TASK>


Tested on:

commit:         88035e56 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157106d9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a3981d3c93cde53224be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138e1e16e80000


