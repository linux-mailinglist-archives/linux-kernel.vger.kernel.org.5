Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D176579E48B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbjIMKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbjIMKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:05:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE151986
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2uYk474/2dy22kIvYnZbSOm6RcEuwDrN7aN2t6DJjLg=; b=bNhF8iH4gJvfQSRaDGqDwBEund
        vm2J4zFMVa61SXPDtEuBFxdEmL4UE37pbFPQwLAeRSW7FXGIAQm7TU6xOJvkazlBDCxnQUFowO94I
        Ijp7vJvJu19owRVKshsm/1mjeJc84cj85U6iwCRYE9xKJQv8LkaFV7rvpN9z8anZJZ+HSmwFjegKa
        BFgAI6GP0owx1BavaDnw7V3lALcUzRIpUdXdtQ/+o65VzGxppuNaekjqwGkEfWPqojGM/bEQhF/fj
        ZqmOkCN2UsNeyRRlU0R4718bxXdxvySUu23MSHSyb+FJRyeUHBMJg5He4kAAZTdiu4hnxWYv68Ucj
        PKOInzXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgMkY-00DAxs-17; Wed, 13 Sep 2023 10:05:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD8E0300348; Wed, 13 Sep 2023 12:05:33 +0200 (CEST)
Date:   Wed, 13 Sep 2023 12:05:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        mairacanal@riseup.net, hamohammed.sa@gmail.com, daniel@ffwll.ch,
        airlied@gmail.com
Subject: Re: BUG: soft lockup in smp_call_function
Message-ID: <20230913100533.GD692@noisy.programming.kicks-ass.net>
References: <BL0PR11MB310606A8674B391DEA659089E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB310606A8674B391DEA659089E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:02:56PM +0000, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.3.0-next-20230426
> Kernel Config: https://drive.google.com/file/d/1WSUEWrith9-539qo6xRqmwy4LfDtmKpp/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1pN6FfcjuUs6Wx94g1gufuYGjRbMMgiZ4/view?usp=sharing
> Thank you!

AFAICT the thing is stuck in DRM somewhere...

> watchdog: BUG: soft lockup - CPU#5 stuck for 26s! [kworker/u16:1:12]
> Modules linked in:
> irq event stamp: 192794
> hardirqs last  enabled at (192793): [<ffffffff89a0140a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> hardirqs last disabled at (192794): [<ffffffff89975d4f>] sysvec_apic_timer_interrupt+0xf/0xc0 arch/x86/kernel/apic/apic.c:1106
> softirqs last  enabled at (187764): [<ffffffff814b94bd>] invoke_softirq kernel/softirq.c:445 [inline]
> softirqs last  enabled at (187764): [<ffffffff814b94bd>] __irq_exit_rcu+0x11d/0x190 kernel/softirq.c:650
> softirqs last disabled at (187671): [<ffffffff814b94bd>] invoke_softirq kernel/softirq.c:445 [inline]
> softirqs last disabled at (187671): [<ffffffff814b94bd>] __irq_exit_rcu+0x11d/0x190 kernel/softirq.c:650
> CPU: 5 PID: 12 Comm: kworker/u16:1 Not tainted 6.3.0-next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: events_unbound toggle_allocation_gate
> RIP: 0010:csd_lock_wait kernel/smp.c:294 [inline]
> RIP: 0010:smp_call_function_many_cond+0x5bd/0x1020 kernel/smp.c:828
> Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 b5 07 0b 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 46 08 00 00 8b 43 08 31
> RSP: 0018:ffffc900000cf9e8 EFLAGS: 00000293
> RAX: 0000000000000000 RBX: ffff888119cc4d80 RCX: 0000000000000000
> RDX: ffff888100325940 RSI: ffffffff8176807b RDI: 0000000000000005
> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffed10233989b1
> R13: 0000000000000001 R14: ffff888119cc4d88 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff888119e80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555556a6cc88 CR3: 000000000bb73000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:996
>  on_each_cpu include/linux/smp.h:71 [inline]
>  text_poke_sync arch/x86/kernel/alternative.c:1770 [inline]
>  text_poke_bp_batch+0x237/0x770 arch/x86/kernel/alternative.c:1970
>  text_poke_flush arch/x86/kernel/alternative.c:2161 [inline]
>  text_poke_flush arch/x86/kernel/alternative.c:2158 [inline]
>  text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2168
>  arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
>  jump_label_update+0x321/0x400 kernel/jump_label.c:829
>  static_key_enable_cpuslocked+0x1b5/0x270 kernel/jump_label.c:205
>  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
>  toggle_allocation_gate mm/kfence/core.c:831 [inline]
>  toggle_allocation_gate+0xf4/0x220 mm/kfence/core.c:823
>  process_one_work+0x993/0x15e0 kernel/workqueue.c:2405
>  worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>  kthread+0x33e/0x440 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>

Right, so this is waiting for an IPI to be processed.. while #1 has IRQs
disabled

> Sending NMI from CPU 5 to CPUs 0-4,6-7:
> NMI backtrace for cpu 1
> CPU: 1 PID: 20602 Comm: syz-executor.3 Not tainted 6.3.0-next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:hlock_class kernel/locking/lockdep.c:228 [inline]
> RIP: 0010:check_wait_context kernel/locking/lockdep.c:4747 [inline]
> RIP: 0010:__lock_acquire+0x489/0x5d00 kernel/locking/lockdep.c:5024
> Code: 41 81 e5 ff 1f 45 0f b7 ed be 08 00 00 00 4c 89 e8 48 c1 e8 06 48 8d 3c c5 00 6b 2c 90 e8 5f 90 6e 00 4c 0f a3 2d d7 35 c9 0e <0f> 83 5c 0c 00 00 4f 8d 6c 6d 00 49 c1 e5 06 49 81 c5 20 6f 2c 90
> RSP: 0018:ffffc90002aa7350 EFLAGS: 00000047
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff81633521
> RDX: fffffbfff2058d62 RSI: 0000000000000008 RDI: ffffffff902c6b08
> RBP: ffff888042995940 R08: 0000000000000000 R09: ffffffff902c6b0f
> R10: fffffbfff2058d61 R11: 0000000000000001 R12: ffff888119e2b818
> R13: 0000000000000063 R14: 0000000000000002 R15: ffff888042996598
> FS:  00007fdaad065700(0000) GS:ffff888119c80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b30623000 CR3: 0000000101969000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  lock_acquire kernel/locking/lockdep.c:5691 [inline]
>  lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>  lock_hrtimer_base kernel/time/hrtimer.c:173 [inline]
>  hrtimer_try_to_cancel kernel/time/hrtimer.c:1331 [inline]
>  hrtimer_try_to_cancel+0xa9/0x2e0 kernel/time/hrtimer.c:1316
>  hrtimer_cancel+0x17/0x40 kernel/time/hrtimer.c:1443

And this is trying to cancel a hrtimer which is ran on CPU4 and won't be
making much progress.

>  __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]

So we're here, holding vbl_lock, vblank_time_lock one of which is what
#4 is waiting on.

This also has IRQs disabled, which is what #1 is waiting on.

>  drm_vblank_disable_and_save+0x282/0x3d0 drivers/gpu/drm/drm_vblank.c:478
>  drm_crtc_vblank_off+0x312/0x970 drivers/gpu/drm/drm_vblank.c:1366
>  disable_outputs+0x7c7/0xbb0 drivers/gpu/drm/drm_atomic_helper.c:1202
>  drm_atomic_helper_commit_modeset_disables+0x1d/0x40 drivers/gpu/drm/drm_atomic_helper.c:1397
>  vkms_atomic_commit_tail+0x51/0x240 drivers/gpu/drm/vkms/vkms_drv.c:71
>  commit_tail+0x288/0x420 drivers/gpu/drm/drm_atomic_helper.c:1812
>  drm_atomic_helper_commit drivers/gpu/drm/drm_atomic_helper.c:2052 [inline]
>  drm_atomic_helper_commit+0x306/0x390 drivers/gpu/drm/drm_atomic_helper.c:1985
>  drm_atomic_commit+0x20a/0x2d0 drivers/gpu/drm/drm_atomic.c:1503
>  drm_client_modeset_commit_atomic+0x698/0x7e0 drivers/gpu/drm/drm_client_modeset.c:1045
>  drm_client_modeset_dpms+0x174/0x200 drivers/gpu/drm/drm_client_modeset.c:1226
>  drm_fb_helper_dpms drivers/gpu/drm/drm_fb_helper.c:323 [inline]
>  drm_fb_helper_blank+0xd1/0x260 drivers/gpu/drm/drm_fb_helper.c:356
>  fb_blank+0x105/0x190 drivers/video/fbdev/core/fbmem.c:1088
>  do_fb_ioctl+0x390/0x760 drivers/video/fbdev/core/fbmem.c:1180
>  fb_ioctl+0xeb/0x150 drivers/video/fbdev/core/fbmem.c:1204
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdaabe8edcd
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdaad064bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fdaabfbbf80 RCX: 00007fdaabe8edcd
> RDX: 0000000000000004 RSI: 0000000000004611 RDI: 0000000000000003
> RBP: 00007fdaabefc59c R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffdadeffe9f R14: 00007ffdadf00040 R15: 00007fdaad064d80
>  </TASK>



> CPU: 4 PID: 20623 Comm: syz-executor.6 Not tainted 6.3.0-next-20230426 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:kvm_wait+0xb7/0x110 arch/x86/kernel/kvm.c:1064
> Code: 40 38 c6 74 1b 48 83 c4 10 c3 c3 e8 93 d3 50 00 eb 07 0f 00 2d 4a 04 92 08 fb f4 48 83 c4 10 c3 eb 07 0f 00 2d 3a 04 92 08 f4 <48> 83 c4 10 c3 89 74 24 0c 48 89 3c 24 e8 d7 d4 50 00 8b 74 24 0c
> RSP: 0018:ffffc90000300b50 EFLAGS: 00000046
> RAX: 0000000000000003 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88810b0803d8
> RBP: ffff88810b0803d8 R08: 0000000000000001 R09: ffff88810b0803d8
> R10: ffffed102161007b R11: ffffc90000300ff8 R12: 0000000000000000
> R13: ffffed102161007b R14: 0000000000000001 R15: ffff888119e3d3c0
> FS:  0000000000000000(0000) GS:ffff888119e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f28183bd0b0 CR3: 000000000bb73000 CR4: 0000000000350ee0
> Call Trace:
>  <IRQ>
>  pv_wait arch/x86/include/asm/paravirt.h:598 [inline]
>  pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
>  __pv_queued_spin_lock_slowpath+0x8e4/0xb80 kernel/locking/qspinlock.c:511
>  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:586 [inline]
>  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
>  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>  do_raw_spin_lock+0x20d/0x2b0 kernel/locking/spinlock_debug.c:115
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
>  _raw_spin_lock_irqsave+0x45/0x60 kernel/locking/spinlock.c:162
>  drm_handle_vblank+0x11e/0xb80 drivers/gpu/drm/drm_vblank.c:1986

stuck on a spinlock held by #5

>  vkms_vblank_simulate+0xe8/0x3e0 drivers/gpu/drm/vkms/vkms_crtc.c:29
>  __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
>  __hrtimer_run_queues+0x599/0xa30 kernel/time/hrtimer.c:1749
>  hrtimer_interrupt+0x320/0x7b0 kernel/time/hrtimer.c:1811
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1095 [inline]
>  __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1112
>  sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1106
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:645
> RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> RIP: 0010:__sanitizer_cov_trace_pc+0x11/0x70 kernel/kcov.c:207
> Code: a8 01 00 00 e8 b0 ff ff ff 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 65 8b 05 0d 33 82 7e 89 c1 48 8b 34 24 <81> e1 00 01 00 00 65 48 8b 14 25 40 bb 03 00 a9 00 01 ff 00 74 0e
> RSP: 0018:ffffc90002be76d8 EFLAGS: 00000286
> RAX: 0000000080000001 RBX: 0000000000000001 RCX: 0000000080000001
> RDX: 00007f2817c77000 RSI: ffffffff81bcd756 RDI: ffffc90002be7ad8
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea00014fc480
> R13: 0000000000000000 R14: dffffc0000000000 R15: 8000000053f12007
>  zap_drop_file_uffd_wp mm/memory.c:1352 [inline]
>  zap_install_uffd_wp_if_needed mm/memory.c:1371 [inline]
>  zap_pte_range mm/memory.c:1417 [inline]
>  zap_pmd_range mm/memory.c:1564 [inline]
>  zap_pud_range mm/memory.c:1593 [inline]
>  zap_p4d_range mm/memory.c:1614 [inline]
>  unmap_page_range+0x1046/0x4470 mm/memory.c:1635
>  unmap_single_vma+0x19a/0x2b0 mm/memory.c:1681
>  unmap_vmas+0x234/0x380 mm/memory.c:1720
>  exit_mmap+0x190/0x930 mm/mmap.c:3111
>  __mmput+0x128/0x4c0 kernel/fork.c:1351
>  mmput+0x60/0x70 kernel/fork.c:1373
>  exit_mm kernel/exit.c:564 [inline]
>  do_exit+0x9d1/0x29f0 kernel/exit.c:858
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
>  get_signal+0x2311/0x25c0 kernel/signal.c:2874
>  arch_do_signal_or_restart+0x79/0x5a0 arch/x86/kernel/signal.c:307
>  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>  exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>  syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
>  do_syscall_64+0x46/0x80 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f281828edcd
> Code: Unable to access opcode bytes at 0x7f281828eda3.
> RSP: 002b:00007f28194c0c98 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007f28183bbf80 RCX: 00007f281828edcd
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f28183bbf88
> RBP: 00007f28183bbf88 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f28183bbf8c
> R13: 00007ffd5038e1ef R14: 00007ffd5038e390 R15: 00007f28194c0d80
>  </TASK>


