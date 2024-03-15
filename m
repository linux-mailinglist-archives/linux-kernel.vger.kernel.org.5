Return-Path: <linux-kernel+bounces-104317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561887CC1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614241F211A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7851B7F8;
	Fri, 15 Mar 2024 11:16:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720551B7E7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501390; cv=none; b=LPk/coZRFXqCkPWUb8vXAYKyap36Z9dcCHpn+/b9e366z/UsGmfjgrz2pBRPdfW+Nmsmt1EQYr52jYYqQK0O8jzsFnWiTlv+oBxWQ+Iuq5a1qz8k2An8UmemOLtoJSIgyfVqaYDiheLhjPvXgkTyz7bvSGl1YQ2gn8C3sSS+caM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501390; c=relaxed/simple;
	bh=cVBulf2bK5sFUwm4BlGidQuxxhIBZKmGS6AnoKNu1/Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uk1oZNETD03lW1mh+xnT1lOQS4lKkEZBhJspLoMV4FEteC32JhxiaD18vqi24igvVCVweCLuV6CI6nUtDJTu/T2xJWT6cUUtzboYo7qzNUB0HCiTWpSJTNn/54YouFBKucGPOm63EFgcYUSoXaHnqfxyBsxUOYDeJUsEsSiSCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3667ad344b5so18198955ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501387; x=1711106187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eED6+hhVmbyV40fDhuII56oZcM9Wt3D2c8IjqhdUME=;
        b=AS+654lPC9cheHXKjni5tR09MgUiNyCetiQpv4FiyxpHgZtWFmXkd8aSxM6jwCG9nz
         lvC4pD1D63VZkAt+AE/00/d8Cidj9/opBP6a7jBFNidNtDJMcSb+VQeL/VHWLFpBjlW6
         rQG6/bNo3JfiGEGbh26rWpWozldO87a5bZgU/sUwhtr+xihq7sdXOOdl5TZhkH0iX8Nf
         SxqZR6mrwdGxHkZ+hV4UAGgZlkMlQWa5AVvxAGKiO6y2FxBNJIsk+qxTYI3gkVB+k1T2
         TsBd+JA0mbsejoYs59awmAeqHL5Hz/zLVUUR7z6/AyNLsIm+qugWCTXI+Fw/i4ppOtJJ
         Tp9Q==
X-Gm-Message-State: AOJu0YzQFZULviUNXiW9w3yQBI9K7StPplYChxtbhcnFnNKH8E+/gTy6
	Pa3Apf3usuDyeDEpHbQx91IWfclV16lF52Lk0BLLXTi71i/+H1t9dRrmjTh8riyrxVvwmu5fmOi
	1YqouiI7VIfuMsQaN5B09zsSvwvhcuvnDZHZIDEmwJbm5fO2+xBGbd1jTmQ==
X-Google-Smtp-Source: AGHT+IGu3K5ztHndmoSBrcPDvZyBRlxvzXwBlMQXWxzfN5Z8g0rREwdEvZ3woMcl/bH7+2Lknl27/bT/fm+coqsvJ4DvOu8ZSR4O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0f:b0:366:97fc:b9cf with SMTP id
 i15-20020a056e021d0f00b0036697fcb9cfmr30923ila.0.1710501387681; Fri, 15 Mar
 2024 04:16:27 -0700 (PDT)
Date: Fri, 15 Mar 2024 04:16:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099d9850613b12348@google.com>
Subject: [syzbot] [sound?] possible deadlock in snd_timer_close_locked
From: syzbot <syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14cd9bd6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=f3bc6f8108108010a03d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149b2e86180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a304a5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

The issue was bisected to:

commit beb45974dd49068b24788bbfc2abe20d50503761
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Feb 27 08:52:45 2024 +0000

    ALSA: timer: Use guard() for locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100427b6180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=120427b6180000
console output: https://syzkaller.appspot.com/x/log.txt?x=140427b6180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com
Fixes: beb45974dd49 ("ALSA: timer: Use guard() for locking")

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------------------------------
syz-executor504/5058 just changed the state of lock:
ffff8880293a4148 (&timer->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff8880293a4148 (&timer->lock){+.+.}-{2:2}, at: class_spinlock_constructor include/linux/spinlock.h:561 [inline]
ffff8880293a4148 (&timer->lock){+.+.}-{2:2}, at: snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412
but this lock was taken by another, SOFTIRQ-safe lock in the past:
 (&group->lock#2){..-.}-{2:2}


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

3 locks held by syz-executor504/5058:
 #0: ffffffff8f2d3228 (register_mutex#4){+.+.}-{3:3}, at: odev_release+0x4e/0x80 sound/core/seq/oss/seq_oss.c:143
 #1: ffff88801f38f978 (&q->timer_mutex){+.+.}-{3:3}, at: queue_delete sound/core/seq/seq_queue.c:124 [inline]
 #1: ffff88801f38f978 (&q->timer_mutex){+.+.}-{3:3}, at: snd_seq_queue_delete+0x5b/0xf0 sound/core/seq/seq_queue.c:188
 #2: ffffffff8f2c1a68 (register_mutex){+.+.}-{3:3}, at: class_mutex_constructor include/linux/mutex.h:169 [inline]
 #2: ffffffff8f2c1a68 (register_mutex){+.+.}-{3:3}, at: snd_timer_close+0xa3/0x130 sound/core/timer.c:463

the shortest dependencies between 2nd lock and 1st lock:
 -> (&group->lock#2){..-.}-{2:2} {
    IN-SOFTIRQ-W at:
                      lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                      __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                      _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                      class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:669 [inline]
                      snd_pcm_period_elapsed+0x21/0x50 sound/core/pcm_lib.c:1904
                      dummy_hrtimer_callback+0x7f/0x180 sound/drivers/dummy.c:385
                      __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
                      __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
                      hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1773
                      __do_softirq+0x2bc/0x943 kernel/softirq.c:554
                      invoke_softirq kernel/softirq.c:428 [inline]
                      __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
                      irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
                      instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                      sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
                      asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                      native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                      arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                      acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
                      acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
                      cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
                      cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
                      call_cpuidle kernel/sched/idle.c:155 [inline]
                      cpuidle_idle_call kernel/sched/idle.c:236 [inline]
                      do_idle+0x375/0x5d0 kernel/sched/idle.c:332
                      cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
                      rest_init+0x2e0/0x300 init/main.c:730
                      arch_call_rest_init+0xe/0x10 init/main.c:831
                      start_kernel+0x47a/0x500 init/main.c:1077
                      x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
                      x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
                      common_startup_64+0x13e/0x147
    INITIAL USE at:
                     lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                     __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                     _raw_spin_lock_irq+0xd3/0x120 kernel/locking/spinlock.c:170
                     spin_lock_irq include/linux/spinlock.h:376 [inline]
                     snd_pcm_group_lock_irq sound/core/pcm_native.c:97 [inline]
                     snd_pcm_stream_lock_irq sound/core/pcm_native.c:136 [inline]
                     class_pcm_stream_lock_irq_constructor include/sound/pcm.h:666 [inline]
                     snd_pcm_hw_params+0x201/0x1ea0 sound/core/pcm_native.c:740
                     snd_pcm_oss_change_params_locked+0x20d5/0x3e00 sound/core/oss/pcm_oss.c:965
                     snd_pcm_oss_make_ready_locked sound/core/oss/pcm_oss.c:1187 [inline]
                     snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1515 [inline]
                     snd_pcm_oss_read+0x24c/0x940 sound/core/oss/pcm_oss.c:2773
                     do_loop_readv_writev fs/read_write.c:761 [inline]
                     vfs_readv+0x68f/0xa50 fs/read_write.c:934
                     do_readv+0x1b1/0x350 fs/read_write.c:994
                     do_syscall_64+0xfb/0x240
                     entry_SYSCALL_64_after_hwframe+0x6d/0x75
  }
  ... key      at: [<ffffffff9485f200>] snd_pcm_group_init.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
   class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
   snd_timer_notify+0x103/0x3d0 sound/core/timer.c:1040
   snd_pcm_action sound/core/pcm_native.c:1370 [inline]
   snd_pcm_start+0x3fa/0x4c0 sound/core/pcm_native.c:1478
   __snd_pcm_lib_xfer+0x1af3/0x1e30 sound/core/pcm_lib.c:2301
   snd_pcm_oss_read3+0x3ea/0x600 sound/core/oss/pcm_oss.c:1281
   snd_pcm_plug_read_transfer+0x3a1/0x470 sound/core/oss/pcm_plugin.c:663
   snd_pcm_oss_read2+0x296/0x430 sound/core/oss/pcm_oss.c:1482
   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1520 [inline]
   snd_pcm_oss_read+0x45b/0x940 sound/core/oss/pcm_oss.c:2773
   do_loop_readv_writev fs/read_write.c:761 [inline]
   vfs_readv+0x68f/0xa50 fs/read_write.c:934
   do_readv+0x1b1/0x350 fs/read_write.c:994
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> (&timer->lock){+.+.}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:561 [inline]
                    snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412
                    snd_timer_close+0xae/0x130 sound/core/timer.c:464
                    snd_seq_timer_close+0xa9/0xe0 sound/core/seq/seq_timer.c:302
                    queue_delete sound/core/seq/seq_queue.c:126 [inline]
                    snd_seq_queue_delete+0x8f/0xf0 sound/core/seq/seq_queue.c:188
                    delete_seq_queue sound/core/seq/oss/seq_oss_init.c:371 [inline]
                    snd_seq_oss_release+0x1d3/0x310 sound/core/seq/oss/seq_oss_init.c:416
                    odev_release+0x56/0x80 sound/core/seq/oss/seq_oss.c:144
                    __fput+0x429/0x8a0 fs/file_table.c:422
                    task_work_run+0x24f/0x310 kernel/task_work.c:180
                    exit_task_work include/linux/task_work.h:38 [inline]
                    do_exit+0xa1b/0x27e0 kernel/exit.c:878
                    do_group_exit+0x207/0x2c0 kernel/exit.c:1027
                    __do_sys_exit_group kernel/exit.c:1038 [inline]
                    __se_sys_exit_group kernel/exit.c:1036 [inline]
                    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   SOFTIRQ-ON-W at:
                    lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
                    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
                    spin_lock include/linux/spinlock.h:351 [inline]
                    class_spinlock_constructor include/linux/spinlock.h:561 [inline]
                    snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412
                    snd_timer_close+0xae/0x130 sound/core/timer.c:464
                    snd_seq_timer_close+0xa9/0xe0 sound/core/seq/seq_timer.c:302
                    queue_delete sound/core/seq/seq_queue.c:126 [inline]
                    snd_seq_queue_delete+0x8f/0xf0 sound/core/seq/seq_queue.c:188
                    delete_seq_queue sound/core/seq/oss/seq_oss_init.c:371 [inline]
                    snd_seq_oss_release+0x1d3/0x310 sound/core/seq/oss/seq_oss_init.c:416
                    odev_release+0x56/0x80 sound/core/seq/oss/seq_oss.c:144
                    __fput+0x429/0x8a0 fs/file_table.c:422
                    task_work_run+0x24f/0x310 kernel/task_work.c:180
                    exit_task_work include/linux/task_work.h:38 [inline]
                    do_exit+0xa1b/0x27e0 kernel/exit.c:878
                    do_group_exit+0x207/0x2c0 kernel/exit.c:1027
                    __do_sys_exit_group kernel/exit.c:1038 [inline]
                    __se_sys_exit_group kernel/exit.c:1036 [inline]
                    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
                    do_syscall_64+0xfb/0x240
                    entry_SYSCALL_64_after_hwframe+0x6d/0x75
   INITIAL USE at:
                   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
                   snd_timer_notify+0x103/0x3d0 sound/core/timer.c:1040
                   snd_pcm_action sound/core/pcm_native.c:1370 [inline]
                   snd_pcm_start+0x3fa/0x4c0 sound/core/pcm_native.c:1478
                   __snd_pcm_lib_xfer+0x1af3/0x1e30 sound/core/pcm_lib.c:2301
                   snd_pcm_oss_read3+0x3ea/0x600 sound/core/oss/pcm_oss.c:1281
                   snd_pcm_plug_read_transfer+0x3a1/0x470 sound/core/oss/pcm_plugin.c:663
                   snd_pcm_oss_read2+0x296/0x430 sound/core/oss/pcm_oss.c:1482
                   snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1520 [inline]
                   snd_pcm_oss_read+0x45b/0x940 sound/core/oss/pcm_oss.c:2773
                   do_loop_readv_writev fs/read_write.c:761 [inline]
                   vfs_readv+0x68f/0xa50 fs/read_write.c:934
                   do_readv+0x1b1/0x350 fs/read_write.c:994
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff9485efe0>] snd_timer_new.__key+0x0/0x20
 ... acquired at:
   mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
   __lock_acquire+0x116e/0x1fd0 kernel/locking/lockdep.c:5091
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   class_spinlock_constructor include/linux/spinlock.h:561 [inline]
   snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412
   snd_timer_close+0xae/0x130 sound/core/timer.c:464
   snd_seq_timer_close+0xa9/0xe0 sound/core/seq/seq_timer.c:302
   queue_delete sound/core/seq/seq_queue.c:126 [inline]
   snd_seq_queue_delete+0x8f/0xf0 sound/core/seq/seq_queue.c:188
   delete_seq_queue sound/core/seq/oss/seq_oss_init.c:371 [inline]
   snd_seq_oss_release+0x1d3/0x310 sound/core/seq/oss/seq_oss_init.c:416
   odev_release+0x56/0x80 sound/core/seq/oss/seq_oss.c:144
   __fput+0x429/0x8a0 fs/file_table.c:422
   task_work_run+0x24f/0x310 kernel/task_work.c:180
   exit_task_work include/linux/task_work.h:38 [inline]
   do_exit+0xa1b/0x27e0 kernel/exit.c:878
   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
   __do_sys_exit_group kernel/exit.c:1038 [inline]
   __se_sys_exit_group kernel/exit.c:1036 [inline]
   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
   do_syscall_64+0xfb/0x240
   entry_SYSCALL_64_after_hwframe+0x6d/0x75


stack backtrace:
CPU: 0 PID: 5058 Comm: syz-executor504 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 mark_lock_irq+0x867/0xc20 kernel/locking/lockdep.c:4236
 mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
 __lock_acquire+0x116e/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 class_spinlock_constructor include/linux/spinlock.h:561 [inline]
 snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412
 snd_timer_close+0xae/0x130 sound/core/timer.c:464
 snd_seq_timer_close+0xa9/0xe0 sound/core/seq/seq_timer.c:302
 queue_delete sound/core/seq/seq_queue.c:126 [inline]
 snd_seq_queue_delete+0x8f/0xf0 sound/core/seq/seq_queue.c:188
 delete_seq_queue sound/core/seq/oss/seq_oss_init.c:371 [inline]
 snd_seq_oss_release+0x1d3/0x310 sound/core/seq/oss/seq_oss_init.c:416
 odev_release+0x56/0x80 sound/core/seq/oss/seq_oss.c:144
 __fput+0x429/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0910103b89
Code: Unable to access opcode bytes at 0x7f0910103b5f.
RSP: 002b:00007ffc7b2de668 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0910103b89
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f091017e290 R08: ffffffffffffffb8 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f091017e290
R13: 0000000000000000 R14: 00007f091017ece0 R15: 00007f09100d4df0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

