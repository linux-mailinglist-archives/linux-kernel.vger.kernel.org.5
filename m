Return-Path: <linux-kernel+bounces-143971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDC8A4030
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC3B2821FC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6151CA82;
	Sun, 14 Apr 2024 04:05:24 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E117993
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713067523; cv=none; b=bmXGsSrFzPuuuM/WkEqrnur2tTmjhr/rPL9EHLaBZGtqoQfiJgj9S5vzvrtLbuWHh0e5fCoS9VdWpgHbZdOCkJ5db14rh2fiADoJJ5ZMmTS5ExmQEGgEvmvvvmYGMsX1TFjYblAj9A2Yj/Q7u6Gv5WgPlBRdnQLnJJlkpkO5Vtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713067523; c=relaxed/simple;
	bh=LAdV84CIs/17qtthcoMOBc/hot1QZliAuA09Eeo3NnA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WY2Pq34LlQSGCT3aVdjmcRrDCp2vM7otwfW6sBnrGzngA8ByVlQy7gCINc4RJgzDEyagUGgtDTjRkoUpjHyqE65UCXKkgwJyv2EkD5ktBEm6JYi8Zgwz0zkaoZBXp65Ugc1elBgzT/dnZMBwIDPsQeQ5cXH8SQIW0EOjnMxkY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d63c6a2559so159214739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 21:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713067520; x=1713672320;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/S/Zx+oBZbvubpAGGOxCK0Y424gDxRXXQF+zZD4OVs8=;
        b=NJyyDjuLTuNIb44wKdULdLTg6qE7WVQODaw01lgXrQryG/YwZM+DqEFsDWqwCCGNTT
         sMYFToVx3nRyA8Y2OMrO3dXuDa//qj0UKUYqHzraf1o4tna0/0Wr8xFfot6aOQwJs4P9
         rGfhYh0SoE8IYk7UNaAecwX+VfjGMytH3ExpBmgJYgYtTVa9M5ZM23RRHPRHOFcUHAEE
         9Fm8sVvw42yZ4PcoGiPhtqAuv6gMs+3DvQ9+lyf9EOf+K2PGoRCM5lzY4TtS60mZt0tS
         lh29LPzGdhoLjggNOjG25oPgz1LaVRq45VmvMTbFZoXaTC8svQ54h6vMeIDdvyAYJaTF
         FY7A==
X-Gm-Message-State: AOJu0YyuwbAoskagmF9Y3a20nGV9OZbVrrzU3mnu0lLhJqZHnahm6Pu/
	OgfpQSZMgsXspR8tQ0bdc1nxKF9MnVgV+R5aYNG55PqTnwcAIrHfNd4ZMSrtqBkDPXudBdTO5OG
	rOjwkzWG2gGcHXEmmfVVq8vBQwoxwGH9k+xn1vq2HfaukDREN3TZ6Eko=
X-Google-Smtp-Source: AGHT+IGkAmSGphKHGxfAltuXniCcUFg7VsdX0GTdK+taYH1L78fBjASDRXyahnOytm2Iwnxqj3vQ02zOVc1i0rAD2wSIogWKucyZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2720:b0:482:dafb:95b7 with SMTP id
 m32-20020a056638272000b00482dafb95b7mr242006jav.2.1713067520406; Sat, 13 Apr
 2024 21:05:20 -0700 (PDT)
Date: Sat, 13 Apr 2024 21:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007c58c0616069d0e@google.com>
Subject: [syzbot] [sound?] possible deadlock in snd_timer_close_locked (2)
From: syzbot <syzbot+19df3985ca9ea18a8fdf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15fa3f8d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=19df3985ca9ea18a8fdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170d5d29180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e19bd3180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/bzImage-fe46a7dd.xz

The issue was bisected to:

commit beb45974dd49068b24788bbfc2abe20d50503761
Author: Takashi Iwai <tiwai@suse.de>
Date:   Tue Feb 27 08:52:45 2024 +0000

    ALSA: timer: Use guard() for locking

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1505004d180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1705004d180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1305004d180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+19df3985ca9ea18a8fdf@syzkaller.appspotmail.com
Fixes: beb45974dd49 ("ALSA: timer: Use guard() for locking")

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------------------------------
syz-executor641/5063 just changed the state of lock:
ffff888029a72948 (&timer->lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888029a72948 (&timer->lock){+.+.}-{2:2}, at: class_spinlock_constructor include/linux/spinlock.h:561 [inline]
ffff888029a72948 (&timer->lock){+.+.}-{2:2}, at: snd_timer_close_locked+0x53/0x8d0 sound/core/timer.c:412
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

3 locks held by syz-executor641/5063:
 #0: ffffffff8f2d3228 (register_mutex#4){+.+.}-{3:3}, at: odev_release+0x4e/0x80 sound/core/seq/oss/seq_oss.c:143
 #1: ffff88801a37ad78 (&q->timer_mutex){+.+.}-{3:3}, at: queue_delete sound/core/seq/seq_queue.c:124 [inline]
 #1: ffff88801a37ad78 (&q->timer_mutex){+.+.}-{3:3}, at: snd_seq_queue_delete+0x5b/0xf0 sound/core/seq/seq_queue.c:188
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
CPU: 0 PID: 5063 Comm: syz-executor641 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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
RIP: 0033:0x7f4d2af16c79
Code: Unable to access opcode bytes at 0x7f4d2af16c4f.
RSP: 002b:00007ffd402f0ee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda


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

