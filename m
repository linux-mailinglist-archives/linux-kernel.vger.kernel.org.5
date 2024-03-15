Return-Path: <linux-kernel+bounces-104237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BD87CB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106F2B235B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA2182A7;
	Fri, 15 Mar 2024 10:00:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CD18E28
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496834; cv=none; b=NaEvtn1mou279qe0QtY54bIikSZyqfA7XSRLcq/xsoWeKBJs20KdEmkLWB2Sno37ypeL+7kHsnCNvzHJ9AttBa6HkDTQ37noEB08I5eAkYHoH0JX5E3AgciQOj9CtzzM+FdepRPBi33aZxYZkZwImvaD6/xeetKfaIfC+0zlR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496834; c=relaxed/simple;
	bh=8XIQQk4A1xQ8daGhJHBIVKYgvYcBRRaNvcc+i/Bm1jQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=glb/Z/jFJeAmERymFcVSOsiEe6uh2Xdpz+Fhykh5ou1Wt9cn2SCnBgJDX2cmmkCEATtmACEpwrG41Ce4luB/s/8DcCf2UD+cnvHHYoD7aAeXtXmyfNq+Ynbsk5wGEOJqWi1mZXU5q1MTy/egY8EcMPBaU1Am8PO/nZC9WoUXsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3667a84b02cso23649195ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710496831; x=1711101631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htHH/XcV0MoFmBdyyb9j6BwGQlWD0PfWpk+v3wEvnZg=;
        b=rBTg72u8vBvnMGuAsFA0L7ukORuzKIp3X2BCD2Jf65SoqKV1SoKa2TbaYzCu3mX1QD
         G3PTkgSZzqwooLBAI2Xyr7azmr9YkIHSxGjjI0IHvSN3X/3qMtjxEGfsOAEFy07O1C8Y
         VyIHMZqCIM3+eznVEoGi2Ed0QDIvyyAyg/s+3HL6UYK49B1/+p+BqyXUbiBBqz6JizOV
         p/dKtwZNR5zq8v3VgUXO2UdHGaW/0PLxyxDpheaVS0qqwL14ZgiRE0iCs8Dz9GMjNNEa
         DYuJKi+a464t/mK8/qxJ5Bs3wX+knPtASmjGWQ+6KGeOGNkq5K1rlEZdpNYHiTxpLOJr
         QjrQ==
X-Gm-Message-State: AOJu0YxWZKsOI4mXg73tI8+O4P/GjSt1gD1gP5aF/pb/szeLSNZ8NzsV
	hhaAlplYp4VWlsjbuIlCBAPx/BtgeW1Maq+OFADMTeGS2ghz6FR0POGueiw2VSt1BdC/BYIaufD
	5PrHcvbAwH4YiHMXfaQJ7HprverSYeTFSNpa82vflH0R5/UKr9CR3s0qu7w==
X-Google-Smtp-Source: AGHT+IGth9dXoLJgF1v3NVM3wmn29ioO+vVb0QNa0smYHcboKOwtJi/mHA6J1N4PiC3wJxzKKzt8tOL3vuuSCRNx6bi7hW4/4nCy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c8:b0:366:8f75:3ea6 with SMTP id
 8-20020a056e0220c800b003668f753ea6mr59847ilq.0.1710496831736; Fri, 15 Mar
 2024 03:00:31 -0700 (PDT)
Date: Fri, 15 Mar 2024 03:00:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b9a510613b0145f@google.com>
Subject: [syzbot] [sound?] possible deadlock in snd_pcm_period_elapsed (4)
From: syzbot <syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14edc2be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=28c1a5a5b041a754b947
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14835185180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1132fbfa180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28c1a5a5b041a754b947@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------------------------------
swapper/1/0 just changed the state of lock:
ffff8880298e6110 (&group->lock#2){..-.}-{2:2}, at: class_pcm_stream_lock_irqsave_constructor include/sound/pcm.h:669 [inline]
ffff8880298e6110 (&group->lock#2){..-.}-{2:2}, at: snd_pcm_period_elapsed+0x21/0x50 sound/core/pcm_lib.c:1904
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
  }
  ... key      at: [<ffffffff9485efe0>] snd_timer_new.__key+0x0/0x20
  ... acquired at:
   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
   class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
   snd_timer_notify+0x103/0x3d0 sound/core/timer.c:1040
   snd_pcm_action sound/core/pcm_native.c:1370 [inline]
   snd_pcm_start+0x3fa/0x4c0 sound/core/pcm_native.c:1478
   __snd_pcm_lib_xfer+0x18bf/0x1e30 sound/core/pcm_lib.c:2371
   snd_pcm_oss_write3+0x1c4/0x350 sound/core/oss/pcm_oss.c:1242
   snd_pcm_plug_write_transfer+0x2ff/0x530 sound/core/oss/pcm_plugin.c:630
   snd_pcm_oss_write2 sound/core/oss/pcm_oss.c:1374 [inline]
   snd_pcm_oss_sync1+0x2fe/0x7b0 sound/core/oss/pcm_oss.c:1616
   snd_pcm_oss_sync+0x7cd/0xc30 sound/core/oss/pcm_oss.c:1681
   snd_pcm_oss_release+0x11e/0x280 sound/core/oss/pcm_oss.c:2575
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
                    __pfx_ap_starting+0x0/0x10 arch/x86/kernel/smpboot.c:313
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
                   snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1405 [inline]
                   snd_pcm_oss_write+0x2d5/0x11f0 sound/core/oss/pcm_oss.c:2796
                   vfs_write+0x2a4/0xcb0 fs/read_write.c:588
                   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
                   do_syscall_64+0xfb/0x240
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff9485f200>] snd_pcm_group_init.__key+0x0/0x20
 ... acquired at:
   mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
   __lock_acquire+0xbcd/0x1fd0 kernel/locking/lockdep.c:5091
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
   __pfx_ap_starting+0x0/0x10 arch/x86/kernel/smpboot.c:313
   common_startup_64+0x13e/0x147


stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 mark_lock_irq+0x80c/0xc20 kernel/locking/lockdep.c:4243
 mark_lock+0x223/0x350 kernel/locking/lockdep.c:4678
 __lock_acquire+0xbcd/0x1fd0 kernel/locking/lockdep.c:5091
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
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 40 d0 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 95 ec 9b 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197d08 EFLAGS: 00000246
RAX: ffff8880172b5a00 RBX: ffff88801bae3064 RCX: 0000000000011741
RDX: 0000000000000001 RSI: ffff88801bae3000 RDI: ffff88801bae3064
RBP: 000000000003a0f8 R08: ffff8880b9537d0b R09: 1ffff110172a6fa1
R10: dffffc0000000000 R11: ffffffff8b6bc600 R12: ffff88801c310000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8e8948a0
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:332
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
   9:	65 48 8b 04 25 40 d0 	mov    %gs:0x3d040,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d 95 ec 9b 00 	verw   0x9bec95(%rip)        # 0x9becb9
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
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

