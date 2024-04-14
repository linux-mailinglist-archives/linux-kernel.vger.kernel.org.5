Return-Path: <linux-kernel+bounces-143969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBB58A402F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E51C20ADB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC91C6B9;
	Sun, 14 Apr 2024 04:05:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AA1758F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067522; cv=none; b=SpzIL0PuBrvFmimxA+Xh97hNrfMqe9Bm+KRoh+3mm7/vxxiC1S/bSZYmTx97MwraRQE8uYooiKS1/WnOCO6MUgbKC1ZEbzvZtXydALgonpNlGBhG9lcQoD+lFTkofSVv2TmMe6OexXTxwkS7O7Z68CF3laRCSTOxPvmV5hXBpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067522; c=relaxed/simple;
	bh=ljavr8sXlwIZtUDv+3aWj4gCCWsB0iPKsBAP1vS3qtM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uFRfOnNwi6uDbFkAwU+6J1EZezcysz/FXQdKK0EkaeaceW7fD2HXN6gSbqBjghOTMnYWKMns8g+NMPHNEgcJnOnwJKfDUDr6IWa/b5xxZq+oJVlGQuvbNir2FyuW9im9JtZzFOWSK/DUabLIrIUBKjvJeAQg5mGTq3vzdO4bfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36a38d56655so25085465ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713067520; x=1713672320;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExxhSt0YwV7n6DWdXH5CG3oMTBIhug8l15m2XyF9qV4=;
        b=EFEuUA2EXp0fRYd+NpMu2+76+b6m2XRCKo+j2VTUiMyPZ3N7OMrLgC6iAbnWchkZle
         4HFdbMAVR8ohDMnmODlJMOIyCgeZrQtLkLPy5fuD3yU9gz1RQk0OJVHJiASHGs+BwuZP
         ydf8nbFUi8ZaCgpPJ29W2CZujerWFt0srBd2x1ADHrkov3CND6bDIGTqC11M/CMJqocv
         UnNg6+N5ynZU7uw2SF5jZKVfM460xII3pdq7b2uvYwCIvaj+e3tmKyPQjaxJU3k0a6iH
         CAh3KyOLD5AyGTXO+o7FqsWJYUCyEp41yhafpTYYwd/eNA8+bxIrHL+7KWLL3ukC5YNi
         dP2w==
X-Gm-Message-State: AOJu0YyVygbWywoCK4wMubfED6fCyn+DT4EHLF+aN2zJSPMv+nUGLx7O
	x8ZZA/tQhW2KKboVnD0+ZXtT9K3+yKbpi3LIufExJ54D7EQvsbePUbUAeEeeoGTmDmj4oLnJJZr
	OwmObVTGJzoHhwWUiEVSiCIyt64L0kEP0GNmY4YQDtEvXz6LpVqttw2c=
X-Google-Smtp-Source: AGHT+IEp7bOV8LIcNOB/CUR1071VYo3o3Q3cpaqhmfdyaAJpo1TAT7l8iGkxVYUkiHM9+5ewkUKuTcTFsY0gJjeIMlUx/1305KSe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe2:b0:36a:1132:8bc5 with SMTP id
 dt2-20020a056e021fe200b0036a11328bc5mr600979ilb.3.1713067520181; Sat, 13 Apr
 2024 21:05:20 -0700 (PDT)
Date: Sat, 13 Apr 2024 21:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000457ff0616069d07@google.com>
Subject: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (5)
From: syzbot <syzbot+faf0acea764965b3e59e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=136825a1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=faf0acea764965b3e59e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133f3d6b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10431e13180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+faf0acea764965b3e59e@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------------------------------
swapper/1/0 just changed the state of lock:
ffff888029f59110 (&group->lock#2){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&timer->lock){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&timer->lock);
                               local_irq_disable();
                               lock(&group->lock#2);
                               lock(&timer->lock);
  <Interrupt>
    lock(&group->lock#2);

 *** DEADLOCK ***

no locks held by swapper/1/0.

the shortest dependencies between 2nd lock and 1st lock:
 -> (&timer->lock){+.+.}-{2:2} {
    HARDIRQ-ON-W at:
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
                      __fput+0x273/0xb80 fs/file_table.c:422
                      task_work_run+0x151/0x250 kernel/task_work.c:180
                      exit_task_work include/linux/task_work.h:38 [inline]
                      do_exit+0xa7d/0x2be0 kernel/exit.c:878
                      do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
                      __do_sys_exit_group kernel/exit.c:1038 [inline]
                      __se_sys_exit_group kernel/exit.c:1036 [inline]
                      __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
                      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                      do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
                      entry_SYSCALL_64_after_hwframe+0x6d/0x75
    SOFTIRQ-ON-W at:
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
                      __fput+0x273/0xb80 fs/file_table.c:422
                      task_work_run+0x151/0x250 kernel/task_work.c:180
                      exit_task_work include/linux/task_work.h:38 [inline]
                      do_exit+0xa7d/0x2be0 kernel/exit.c:878
                      do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
                      __do_sys_exit_group kernel/exit.c:1038 [inline]
                      __se_sys_exit_group kernel/exit.c:1036 [inline]
                      __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
                      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                      do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
                      entry_SYSCALL_64_after_hwframe+0x6d/0x75
    INITIAL USE at:
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
                     __fput+0x273/0xb80 fs/file_table.c:422
                     task_work_run+0x151/0x250 kernel/task_work.c:180
                     exit_task_work include/linux/task_work.h:38 [inline]
                     do_exit+0xa7d/0x2be0 kernel/exit.c:878
                     do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
                     __do_sys_exit_group kernel/exit.c:1038 [inline]
                     __se_sys_exit_group kernel/exit.c:1036 [inline]
                     __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
                     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                     do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
                     entry_SYSCALL_64_after_hwframe+0x6d/0x75
  }
  ... key      at: [<ffffffff949c4860>] __key.6+0x0/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
   class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
   snd_timer_notify+0x111/0x3e0 sound/core/timer.c:1040
   snd_pcm_timer_notify sound/core/pcm_native.c:622 [inline]
   snd_pcm_post_start+0x272/0x350 sound/core/pcm_native.c:1459
   snd_pcm_action_single+0x10d/0x150 sound/core/pcm_native.c:1289
   snd_pcm_action+0x70/0x90 sound/core/pcm_native.c:1370
   __snd_pcm_lib_xfer+0x13f5/0x1ea0 sound/core/pcm_lib.c:2371
   snd_pcm_oss_write3+0xd5/0x1e0 sound/core/oss/pcm_oss.c:1242
   snd_pcm_oss_write2+0x31b/0x3f0 sound/core/oss/pcm_oss.c:1382
   snd_pcm_oss_sync1+0x1bf/0x510 sound/core/oss/pcm_oss.c:1616
   snd_pcm_oss_sync+0x617/0x7f0 sound/core/oss/pcm_oss.c:1692
   snd_pcm_oss_release+0x291/0x320 sound/core/oss/pcm_oss.c:2575
   __fput+0x273/0xb80 fs/file_table.c:422
   task_work_run+0x151/0x250 kernel/task_work.c:180
   exit_task_work include/linux/task_work.h:38 [inline]
   do_exit+0xa7d/0x2be0 kernel/exit.c:878
   do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
   __do_sys_exit_group kernel/exit.c:1038 [inline]
   __se_sys_exit_group kernel/exit.c:1036 [inline]
   __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> (&group->lock#2){..-.}-{2:2} {
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
                    class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:669 [inline]
                    snd_pcm_period_elapsed+0x20/0x50 sound/core/pcm_lib.c:1904
                    dummy_hrtimer_callback+0x9d/0x1c0 sound/drivers/dummy.c:385
                    __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                    __hrtimer_run_queues+0x20f/0xc20 kernel/time/hrtimer.c:1756
                    hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
                    __do_softirq+0x21b/0x8de kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
                    acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
                    cpuidle_enter_state+0x88/0x510 drivers/cpuidle/cpuidle.c:267
                    cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                    cpuidle_idle_call kernel/sched/idle.c:236 [inline]
                    do_idle+0x313/0x3f0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                    start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
                    common_startup_64+0x13e/0x148
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                   snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                   class_pcm_stream_lock_irq_constructor include/sound/pcm.h:666 [inline]
                   snd_pcm_hw_params+0x151/0x1a30 sound/core/pcm_native.c:740
                   snd_pcm_kernel_ioctl+0x147/0x2d0 sound/core/pcm_native.c:3434
                   snd_pcm_oss_change_params_locked+0x146c/0x3aa0 sound/core/oss/pcm_oss.c:965
                   snd_pcm_oss_make_ready_locked+0xb7/0x130 sound/core/oss/pcm_oss.c:1187
                   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1405 [inline]
                   snd_pcm_oss_write+0x4af/0xa10 sound/core/oss/pcm_oss.c:2796
                   vfs_write+0x29b/0x1100 fs/read_write.c:588
                   ksys_write+0x12f/0x260 fs/read_write.c:643
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff949c4be0>] __key.5+0x0/0x40
 ... acquired at:
   mark_usage kernel/locking/lockdep.c:4567 [inline]
   __lock_acquire+0x13d4/0x3b30 kernel/locking/lockdep.c:5091
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
   _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
   class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:669 [inline]
   snd_pcm_period_elapsed+0x20/0x50 sound/core/pcm_lib.c:1904
   dummy_hrtimer_callback+0x9d/0x1c0 sound/drivers/dummy.c:385
   __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
   __hrtimer_run_queues+0x20f/0xc20 kernel/time/hrtimer.c:1756
   hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
   __do_softirq+0x21b/0x8de kernel/softirq.c:554
   invoke_softirq kernel/softirq.c:428 [inline]
   __irq_exit_rcu kernel/softirq.c:633 [inline]
   irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
   sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
   native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
   acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
   acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
   cpuidle_enter_state+0x88/0x510 drivers/cpuidle/cpuidle.c:267
   cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
   cpuidle_idle_call kernel/sched/idle.c:236 [inline]
   do_idle+0x313/0x3f0 kernel/sched/idle.c:332
   cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
   start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
   common_startup_64+0x13e/0x148


stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_irq_inversion_bug.part.0+0x3e9/0x5a0 kernel/locking/lockdep.c:4080
 print_irq_inversion_bug kernel/locking/lockdep.c:4033 [inline]
 check_usage_forwards kernel/locking/lockdep.c:4111 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4243 [inline]
 mark_lock+0x574/0xc60 kernel/locking/lockdep.c:4678
 mark_usage kernel/locking/lockdep.c:4567 [inline]
 __lock_acquire+0x13d4/0x3b30 kernel/locking/lockdep.c:5091
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
 class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:669 [inline]
 snd_pcm_period_elapsed+0x20/0x50 sound/core/pcm_lib.c:1904
 dummy_hrtimer_callback+0x9d/0x1c0 sound/drivers/dummy.c:385
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x20f/0xc20 kernel/time/hrtimer.c:1756
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
 __do_softirq+0x21b/0x8de kernel/softirq.c:554
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
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 38 74 30 75 48 8b 00 a8 08 75 0c eb 07 0f 00 2d e8 b2 a6 00 fb f4 <fa> e9 00 c8 03 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197d58 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8ad342d9
RDX: 0000000000000001 RSI: ffff88801b6ae800 RDI: ffff88801b6ae864
RBP: ffff88801b6ae864 R08: 0000000000000001 R09: ffffed10172a6fdd
R10: ffff8880b9537eeb R11: 0000000000000000 R12: ffff8880183cf000
R13: ffffffff8e32a760 R14: 0000000000000001 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x88/0x510 drivers/cpuidle/cpuidle.c:267
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
  10:	65 48 8b 05 38 74 30 	mov    %gs:0x75307438(%rip),%rax        # 0x75307450
  17:	75
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	eb 07                	jmp    0x28
  21:	0f 00 2d e8 b2 a6 00 	verw   0xa6b2e8(%rip)        # 0xa6b310
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	e9 00 c8 03 00       	jmp    0x3c830
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

