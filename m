Return-Path: <linux-kernel+bounces-106589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20187F0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7A81F23DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AE357862;
	Mon, 18 Mar 2024 19:59:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413A57326
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791971; cv=none; b=OcA6o3zOuzioSwZFcvzgKFmyMvxz+9l/n/DbXZ8oQ1s/oUX4x+IDsD4jmLKYDaA2Wn3A32iPW/4hpZIkmbmJ6IqCTlIxyE4UxsmFfRU4ZPpL8XeCUBB1tJMfNxEMSA079vGWkMQNq3u3pooz1XwUF97NLmW7Ks2y/RlbwGkIHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791971; c=relaxed/simple;
	bh=n4GOJssW9htrAt2qj3UItiRM3xvaxsZj8GicMVPUnBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bA8v/hrLhhwOn4bSopohAV4WeuihWp8CQiwPEtagG4GH07n6YCCwCMlZZtjcbIqlhCN3eSJ0XY9VrJhIH7l1rNYRCERQFd7AUaCjU1f/V1z6A9JiyCPvE3P/PhUFl9rmf4+fGSajR6NSdYH9IhSHyXqG3hqorxyaMic3R/BdEMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so222655039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710791969; x=1711396769;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0WigHktlG78sb4V5P/wI4Vc1in5rLqUIZiwUh4DVIU=;
        b=ufcFA5+J00pwnhx8jPINSBpf6yjJVmYT+qn/96ch2ub67I0CkCo+7m2bhSBXy/dxnr
         xUYQE5Rj4tiUHjIdrMfTnMbGhza2FhSWl5yq7+6BY/jQdMavtoeh6MiJEad+IWegCcHO
         GlCgKV7qrU68c3fSFV3uKFpdu0h0z2Nc2HIJ4z26QTSMua1Ti2ynB8ehkO3pCNh61xqI
         12j822zF1sng6zRmcQNPWwE5YAWio8LJA3u9JcsRnKYZ7hUJvfez7jjwL6odBpaS19k6
         KCji4Omn78vxCbG2S0Z8tb/hNmfQxxXUuEZd5TT4ZotnZeaMXYF3s/IhTPh5P+bhM/UN
         VshA==
X-Gm-Message-State: AOJu0YwHASOXcW5Dob1m2Nh6I8CkJf2Ps5QC68ju2UmsjXp+X51ZblYL
	VakiTR/O+Dm7BE9vvdkhe1TXy+lcD3MuZBotYReMNh27KCF08M6u/jrEs/S+aX7bGbIUFhjHRaV
	EYzTstswE9IhNjTOfu3ajbgSCmNLff2F6Ej+ouLc3xl1pHiKLQX3mYqF/dQ==
X-Google-Smtp-Source: AGHT+IENStZXDAutp8Yo2znIohzNWvZpry46VtNRUZl1FPV1yAu0yj5cRbQo/3NYCIsIO89MWfRp4SIl2UKR/8KJJGM0G662MjEa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3408:b0:7c8:56ec:ac1 with SMTP id
 n8-20020a056602340800b007c856ec0ac1mr22506ioz.2.1710791968869; Mon, 18 Mar
 2024 12:59:28 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:59:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096e5980613f4cb96@google.com>
Subject: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (4)
From: syzbot <syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1169a081180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=18840ef96e57b83b7fea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e5fae180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11271311180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13635dbe3b05/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf54eeb6380c/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com

========================================================
WARNING: possible irq lock inversion dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------------------------------
swapper/2/0 just changed the state of lock:
ffff88802a304110 (&group->lock#2){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
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

no locks held by swapper/2/0.

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
  }
  ... key      at: [<ffffffff949babc0>] __key.6+0x0/0x40
  ... acquired at:
   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
   _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
   class_spinlock_irqsave_constructor include/linux/spinlock.h:574 [inline]
   snd_timer_notify+0x111/0x3e0 sound/core/timer.c:1040
   snd_pcm_timer_notify sound/core/pcm_native.c:622 [inline]
   snd_pcm_post_start+0x272/0x350 sound/core/pcm_native.c:1459
   snd_pcm_action_single+0x10a/0x150 sound/core/pcm_native.c:1289
   snd_pcm_action+0x70/0x90 sound/core/pcm_native.c:1370
   __snd_pcm_lib_xfer+0x13f5/0x1ea0 sound/core/pcm_lib.c:2371
   snd_pcm_oss_write3+0xd5/0x1e0 sound/core/oss/pcm_oss.c:1242
   io_playback_transfer+0x273/0x300 sound/core/oss/io.c:47
   snd_pcm_plug_write_transfer+0x2cd/0x410 sound/core/oss/pcm_plugin.c:630
   snd_pcm_oss_write2+0x24f/0x3f0 sound/core/oss/pcm_oss.c:1374
   snd_pcm_oss_sync1+0x1bf/0x510 sound/core/oss/pcm_oss.c:1616
   snd_pcm_oss_sync+0x617/0x7f0 sound/core/oss/pcm_oss.c:1692
   snd_pcm_oss_release+0x291/0x320 sound/core/oss/pcm_oss.c:2575
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
                    __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
                    hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
                    __do_softirq+0x218/0x8de kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    default_idle+0xf/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:191 [inline]
                    do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
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
                   vfs_write+0x298/0x1100 fs/read_write.c:588
                   ksys_write+0x12f/0x260 fs/read_write.c:643
                   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
                   do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
                   entry_SYSCALL_64_after_hwframe+0x6d/0x75
 }
 ... key      at: [<ffffffff949baf40>] __key.5+0x0/0x40
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
   __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
   hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
   __do_softirq+0x218/0x8de kernel/softirq.c:554
   invoke_softirq kernel/softirq.c:428 [inline]
   __irq_exit_rcu kernel/softirq.c:633 [inline]
   irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
   sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
   native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
   arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
   default_idle+0xf/0x20 arch/x86/kernel/process.c:742
   default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
   cpuidle_idle_call kernel/sched/idle.c:191 [inline]
   do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
   cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
   start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
   common_startup_64+0x13e/0x148


stack backtrace:
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
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
 __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
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
RIP: 0010:default_idle+0xf/0x20 arch/x86/kernel/process.c:743
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d e3 41 34 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffc90000187e08 EFLAGS: 00000242
RAX: 0000000000025cab RBX: 0000000000000002 RCX: ffffffff8ad255f9
RDX: 0000000000000000 RSI: ffffffff8b0cb740 RDI: ffffffff8b6e88a0
RBP: ffffed1002f52910 R08: 0000000000000001 R09: ffffed100d686fdd
R10: ffff88806b437eeb R11: 0000000000000000 R12: 0000000000000002
R13: ffff888017a94880 R14: ffffffff8f9e6f90 R15: 0000000000000000
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x148
 </TASK>
----------------
Code disassembly (best guess):
   0:	4c 01 c7             	add    %r8,%rdi
   3:	4c 29 c2             	sub    %r8,%rdx
   6:	e9 72 ff ff ff       	jmp    0xffffff7d
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d e3 41 34 00 	verw   0x3441e3(%rip)        # 0x34420b
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  37:	00 00 00 00
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

