Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909B17BF73D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjJJJYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjJJJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:24:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34EE0B9;
        Tue, 10 Oct 2023 02:24:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0EF71FB;
        Tue, 10 Oct 2023 02:24:42 -0700 (PDT)
Received: from [10.34.100.114] (e126645.nice.arm.com [10.34.100.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2543F762;
        Tue, 10 Oct 2023 02:24:00 -0700 (PDT)
Message-ID: <70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com>
Date:   Tue, 10 Oct 2023 11:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.6-rc4-rt7
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20231004160655.0D-7XFo_@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231004160655.0D-7XFo_@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am seeing various splats (see below) while running a PREEMPT_RT
kernel on an arm64 Juno board. The branch used is based on v6.6-rc4-rt8.
The following command is run, and a splat appear around ~1/2 minutes later:
   rtla timerlat hist
but if waiting long enough, a splat can appear without any command run.
(The issue is not related to the rtla tool, this is just to share the
method to trigger the issue.)

The issue seems to be related to this patchset:
https://lore.kernel.org/all/20230112194314.845371875@infradead.org/
but as I was unable to really diagnose the issue, it might aswell be
something else.

It seems the memory/registers get corrupted, cf the recurring error
messages:
- Undefined instruction
- Unable to handle kernel paging request at virtual address
- Mem abort info
Splats seem to happen while taking IRQs while going out of idle or
when handling a syscall. More splat variations could be generated,
but 5 should be enough I believe.

When running a non-PREEMPT_RT kernel, splats don't appear, so the issue
might be related to the way locks are handled in PREEMPT_RT. I don't
deeply understand the relation between rcu/irq/tracing so far, if someone
has an idea of what could happen, this would be helpful :)

Regards,
Pierre

Splats:
[splat-1]
[...] Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT_RT SMP
[...] Modules linked in:
[...] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.6.0-rc4-rt8-00102-g97b0e2d47443 #1193
[...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct  4 2023
[...] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[...] pc : trace_irq_noise (./include/trace/events/osnoise.h:63)
[...] lr : trace_irqexit_callback (kernel/trace/trace_osnoise.c:756 kernel/trace/trace_osnoise.c:952 kernel/trace/trace_osnoise.c:974)
[...] sp : ffff800084efbee0
[...] x29: ffff800084efbee0 x28: ffff000800828000 x27: 0000000000000001
[...] x26: 0000000000000000 x25: ffff000805764898 x24: ffff800083cee000
[...] x23: ffff800083c76ab0 x22: ffff8000821a415c x21: 0000000000000438
[...] x20: 0000000000000002 x19: ffff00097ef09a18 x18: 071c71c71c71c71c
[...] x17: ffff800084d74000 x16: ffff8000843b4bf0 x15: 0000000000000000
[...] x14: 0000000000000000 x13: 0000000000000006 x12: 00000004c2bb1498
[...] x11: 0000000000000015 x10: 0000000002800000 x9 : 0000000000082b49
[...] x8 : 0000005f37319994 x7 : ffff80008018e1a8 x6 : 0000000000000000
[...] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000438
[...] x2 : 0000005f37319944 x1 : ffff8000821a415c x0 : 0000000000000002
[...] Call trace:
[...] trace_irq_noise (./include/trace/events/osnoise.h:63)
[...] __traceiter_irq_handler_exit (./include/trace/events/irq.h:83)
[...] trace_irq_handler_exit (./arch/arm64/include/asm/preempt.h:62 ./include/trace/events/irq.h:83)
[...] handle_percpu_devid_irq (kernel/irq/chip.c:955)
[...] generic_handle_domain_irq (kernel/irq/irqdesc.c:? kernel/irq/irqdesc.c:728)
[...] gic_handle_irq (./arch/arm64/include/asm/io.h:75 ./include/asm-generic/io.h:335 drivers/irqchip/irq-gic.c:344)
[...] call_on_irq_stack (arch/arm64/kernel/entry.S:888)
[...] el1_interrupt (arch/arm64/kernel/entry-common.c:? arch/arm64/kernel/entry-common.c:502 arch/arm64/kernel/entry-common.c:517)
[...] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:523)
[...] el1h_64_irq (arch/arm64/kernel/entry.S:587)
[...] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
[...] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
[...] cpuidle_idle_call (kernel/sched/idle.c:134 kernel/sched/idle.c:215)
[...] do_idle (kernel/sched/idle.c:?)
[...] cpu_startup_entry (kernel/sched/idle.c:379)
[...] secondary_start_kernel (./arch/arm64/include/asm/atomic_ll_sc.h:95 ./arch/arm64/include/asm/atomic.h:28 ./include/linux/atomic/atomic-arch-fallback.h:533 ./include/linux/atomic/atomic-arch-fallback.h:981 ./include/linux/atomic/atomic-instrumented.h:436 ./include/linux/sched/mm.h:36 arch/arm64/kernel/smp.c:206)
[...] __secondary_switched (arch/arm64/kernel/head.S:682)
[...] Code: a8c47bfd d50323bf d65f03c0 d503201f (d503233f)
All code
========
    0:   a8c47bfd        ldp     x29, x30, [sp], #64
    4:   d50323bf        autiasp
    8:   d65f03c0        ret
    c:   d503201f        nop
   10:*  d503233f        paciasp         <-- trapping instruction

Code starting with the faulting instruction
===========================================
    0:   d503233f        paciasp
[...] ---[ end trace 0000000000000000 ]---
[...] Kernel panic - not syncing: Oops - Undefined instruction: Fatal exception in interrupt
[...] SMP: stopping secondary CPUs
[...] Kernel Offset: disabled
[...] CPU features: 0x8000020c,2c020000,0000421b
[...] Memory Limit: none

[splat-2]
[...] Unable to handle kernel paging request at virtual address 001c71c71c71d434
[...] Mem abort info:
[...]   ESR = 0x0000000096000044
[...]   EC = 0x25: DABT (current EL), IL = 32 bits
[...]   SET = 0, FnV = 0
[...]   EA = 0, S1PTW = 0
[...]   FSC = 0x04: level 0 translation fault
[...] Data abort info:
[...]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[...]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[...]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[...] [001c71c71c71d434] address between user and kernel address ranges
[...] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
[...] Modules linked in:
[...] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0-rc4-rt8-00102-g97b0e2d47443 #1193
[...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct  4 2023
[...] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[...] pc : ttwu_do_activate (kernel/sched/core.c:3855)
[...] lr : ttwu_do_activate (kernel/sched/sched.h:1363 kernel/sched/sched.h:1507 kernel/sched/core.c:3846)
[...] sp : ffff80008000bc80
[...] x29: ffff80008000bc80 x28: 0000000000000001 x27: ffff8000801e3b88
[...] x26: ffff8008fb265000 x25: ffff800083c79bc0 x24: ffff800083cee000
[...] x23: 0000000000000009 x22: ffff00097eedebd8 x21: ffff000800840000
[...] x20: ffff80008000bcd8 x19: ffff00097eedebc0 x18: 071c71c71c71c71c
[...] x17: ffff800084d74000 x16: ffff8000843b4bf0 x15: 00000000a0987f40
[...] x14: 000000006a667d56 x13: 0000000098508a0a x12: 000000001c2fd96a
[...] x11: 00000000000f4240 x10: 00000000000d1be7 x9 : 000000010001b9a6
[...] x8 : 00000000000645ab x7 : ffff800080149d58 x6 : 0000000000000000
[...] x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
[...] x2 : d123e8dc2efa2772 x1 : ffff00097eedebd8 x0 : 0000000000000001
[...] Call trace:
[...] ttwu_do_activate (kernel/sched/core.c:3855)
[...] try_to_wake_up (kernel/sched/sched.h:1622 kernel/sched/sched.h:1705 kernel/sched/core.c:4072 kernel/sched/core.c:4388)
[...] wake_up_process (kernel/sched/core.c:4520)
[...] invoke_rcu_core_kthread (./arch/arm64/include/asm/alternative-macros.h:250 ./arch/arm64/include/asm/irqflags.h:27 ./arch/arm64/include/asm/irqflags.h:121 kernel/rcu/tree.c:2443)
[...] rcu_sched_clock_irq (kernel/rcu/tree.c:2242)
[...] update_process_times (./arch/arm64/include/asm/preempt.h:13 kernel/time/timer.c:2080)
[...] tick_sched_timer (kernel/time/tick-sched.c:255 kernel/time/tick-sched.c:1492)
[...] __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752)
[...] hrtimer_interrupt (kernel/time/hrtimer.c:605 kernel/time/hrtimer.c:1817)
[...] arch_timer_handler_phys (drivers/clocksource/arm_arch_timer.c:? drivers/clocksource/arm_arch_timer.c:692)
[...] handle_percpu_devid_irq (kernel/irq/chip.c:942)
[...] generic_handle_domain_irq (kernel/irq/irqdesc.c:? kernel/irq/irqdesc.c:728)
[...] gic_handle_irq (./arch/arm64/include/asm/io.h:75 ./include/asm-generic/io.h:335 drivers/irqchip/irq-gic.c:344)
[...] call_on_irq_stack (arch/arm64/kernel/entry.S:888)
[...] el1_interrupt (arch/arm64/kernel/entry-common.c:? arch/arm64/kernel/entry-common.c:502 arch/arm64/kernel/entry-common.c:517)
[...] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:523)
[...] el1h_64_irq (arch/arm64/kernel/entry.S:587)
[...] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291)
[...] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
[...] cpuidle_idle_call (kernel/sched/idle.c:134 kernel/sched/idle.c:215)
[...] do_idle (kernel/sched/idle.c:?)
[...] cpu_startup_entry (kernel/sched/idle.c:379)
[...] secondary_start_kernel (./arch/arm64/include/asm/atomic_ll_sc.h:95 ./arch/arm64/include/asm/atomic.h:28 ./include/linux/atomic/atomic-arch-fallback.h:533 ./include/linux/atomic/atomic-arch-fallback.h:981 ./include/linux/atomic/atomic-instrumented.h:436 ./include/linux/sched/mm.h:36 arch/arm64/kernel/smp.c:206)
[...] __secondary_switched (arch/arm64/kernel/head.S:682)
[...] Code: f001dd89 f9068668 f9418129 d341fd08 (f9068e68)
All code
========
    0:   f001dd89        adrp    x9, 0x3bb3000
    4:   f9068668        str     x8, [x19, #3336]
    8:   f9418129        ldr     x9, [x9, #768]
    c:   d341fd08        lsr     x8, x8, #1
   10:*  f9068e68        str     x8, [x19, #3352]                <-- trapping instruction

Code starting with the faulting instruction
===========================================
    0:   f9068e68        str     x8, [x19, #3352]
[...] ---[ end trace 0000000000000000 ]---
[...] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[...] SMP: stopping secondary CPUs
[...] Kernel Offset: disabled
[...] CPU features: 0x8000020c,2c020000,0000421b
[...] Memory Limit: none

[splat-3]
[...] Mem abort info:
[...]   ESR = 0x0000000096000045
[...]   EC = 0x25: DABT (current EL), IL = 32 bits
[...]   SET = 0, FnV = 0
[...]   EA = 0, S1PTW = 0
[...]   FSC = 0x05: level 1 translation fault
[...] Data abort info:
[...]   ISV = 0, ISS = 0x00000045, ISS2 = 0x00000000
[...]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[...]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[...] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000ed344000
[...] [ffff800886adb8b8] pgd=10000009fffff003, p4d=10000009fffff003, pud=0000000000000000
[...] Internal error: Oops: 0000000096000045 [#1] PREEMPT_RT SMP
[...] Modules linked in:
[...] CPU: 1 PID: 264 Comm: rtla-static Not tainted 6.6.0-rc4-rt8-00102-g97b0e2d47443 #1193
[...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct  4 2023
[...] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[...] pc : rcu_is_watching (kernel/rcu/tree.c:695)
[...] lr : trace_irq_disable (./include/trace/events/preemptirq.h:36)
[...] sp : ffff800086adb8d0
[...] x29: ffff800086adb8e0 x28: ffff0008062a4ec0 x27: 0000000000000030
[...] x26: ffff000800d95560 x25: 0000000000000010 x24: ffff000800442468
[...] x23: 0000000000000000 x22: 0000000000000000 x21: ffff800083c719f0
[...] x20: ffff0008062a4ec0 x19: ffff8000815300c8 x18: 0000000000000000
[...] x17: ffff800084d74000 x16: ffff8000843b4bf0 x15: 00000000ffd5937b
[...] x14: 00000000be9552e3 x13: 0000000045cfb2f8 x12: ffff800086ad8000
[...] x11: 128b911a6b1c6000 x10: ffff800083cece88 x9 : 000000000000003f
[...] x8 : 000000000000001f x7 : ffff8000807e8190 x6 : 0000000000000000
[...] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800086adb960
[...] x2 : ffff0008062a4ec0 x1 : ffff800081529334 x0 : ffff8000815300c8
[...] Call trace:
[...] rcu_is_watching (kernel/rcu/tree.c:695)
[...] trace_hardirqs_off (kernel/trace/trace_preemptirq.c:94)
[...] _raw_spin_lock_irqsave (./arch/arm64/include/asm/current.h:19 ./arch/arm64/include/asm/preempt.h:47 ./include/linux/spinlock_api_smp.h:109 kernel/locking/spinlock.c:162)
[...] rt_spin_lock (kernel/locking/rtmutex.c:1859 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57)
[...] lockref_get (lib/lockref.c:51)
[...] traverse_mounts (fs/namei.c:1402 fs/namei.c:1443)
[...] step_into (fs/namei.c:1547 fs/namei.c:1839)
[...] walk_component (fs/namei.c:?)
[...] link_path_walk (fs/namei.c:2330)
[...] path_lookupat (fs/namei.c:2481)
[...] filename_lookup (fs/namei.c:2511)
[...] vfs_statx (fs/stat.c:240)
[...] vfs_fstatat (fs/stat.c:295)
[...] __arm64_sys_newfstatat (fs/stat.c:460 fs/stat.c:453 fs/stat.c:453)
[...] invoke_syscall (arch/arm64/kernel/syscall.c:? arch/arm64/kernel/syscall.c:51)
[...] el0_svc_common (./include/linux/thread_info.h:127 arch/arm64/kernel/syscall.c:144)
[...] do_el0_svc (arch/arm64/kernel/syscall.c:156)
[...] el0_svc (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:679)
[...] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:?)
[...] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[...] Code: 54fffb61 17ffffe4 d503201f d503233f (a9be7bfd)
All code
========
    0:   54fffb61        b.ne    0xffffffffffffff6c  // b.any
    4:   17ffffe4        b       0xffffffffffffff94
    8:   d503201f        nop
    c:   d503233f        paciasp
   10:*  a9be7bfd        stp     x29, x30, [sp, #-32]!           <-- trapping instruction

Code starting with the faulting instruction
===========================================
    0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
[...] ---[ end trace 0000000000000000 ]---


[splat-4]
[...] Mem abort info:
[...]   ESR = 0x0000000096000045
[...]   EC = 0x25: DABT (current EL), IL = 32 bits
[...]   SET = 0, FnV = 0
[...]   EA = 0, S1PTW = 0
[...]   FSC = 0x05: level 1 translation fault
[...] Data abort info:
[...]   ISV = 0, ISS = 0x00000045, ISS2 = 0x00000000
[...]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[...]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[...] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000ed344000
[...] [ffff800886adb8b8] pgd=10000009fffff003, p4d=10000009fffff003, pud=0000000000000000
[...] Internal error: Oops: 0000000096000045 [#1] PREEMPT_RT SMP
[...] Modules linked in:
[...] CPU: 1 PID: 264 Comm: rtla-static Not tainted 6.6.0-rc4-rt8-00102-g97b0e2d47443 #1193
[...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct  4 2023
[...] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[...] pc : rcu_is_watching (kernel/rcu/tree.c:695)
[...] lr : trace_irq_disable (./include/trace/events/preemptirq.h:36)
[...] sp : ffff800086adb8d0
[...] x29: ffff800086adb8e0 x28: ffff0008062a4ec0 x27: 0000000000000030
[...] x26: ffff000800d95560 x25: 0000000000000010 x24: ffff000800442468
[...] x23: 0000000000000000 x22: 0000000000000000 x21: ffff800083c719f0
[...] x20: ffff0008062a4ec0 x19: ffff8000815300c8 x18: 0000000000000000
[...] x17: ffff800084d74000 x16: ffff8000843b4bf0 x15: 00000000ffd5937b
[...] x14: 00000000be9552e3 x13: 0000000045cfb2f8 x12: ffff800086ad8000
[...] x11: 128b911a6b1c6000 x10: ffff800083cece88 x9 : 000000000000003f
[...] x8 : 000000000000001f x7 : ffff8000807e8190 x6 : 0000000000000000
[...] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff800086adb960
[...] x2 : ffff0008062a4ec0 x1 : ffff800081529334 x0 : ffff8000815300c8
[...] Call trace:
[...] rcu_is_watching (kernel/rcu/tree.c:695)
[...] trace_hardirqs_off (kernel/trace/trace_preemptirq.c:94)
[...] _raw_spin_lock_irqsave (./arch/arm64/include/asm/current.h:19 ./arch/arm64/include/asm/preempt.h:47 ./include/linux/spinlock_api_smp.h:109 kernel/locking/spinlock.c:162)
[...] rt_spin_lock (kernel/locking/rtmutex.c:1859 kernel/locking/spinlock_rt.c:43 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57)
[...] lockref_get (lib/lockref.c:51)
[...] traverse_mounts (fs/namei.c:1402 fs/namei.c:1443)
[...] step_into (fs/namei.c:1547 fs/namei.c:1839)
[...] walk_component (fs/namei.c:?)
[...] link_path_walk (fs/namei.c:2330)
[...] path_lookupat (fs/namei.c:2481)
[...] filename_lookup (fs/namei.c:2511)
[...] vfs_statx (fs/stat.c:240)
[...] vfs_fstatat (fs/stat.c:295)
[...] __arm64_sys_newfstatat (fs/stat.c:460 fs/stat.c:453 fs/stat.c:453)
[...] invoke_syscall (arch/arm64/kernel/syscall.c:? arch/arm64/kernel/syscall.c:51)
[...] el0_svc_common (./include/linux/thread_info.h:127 arch/arm64/kernel/syscall.c:144)
[...] do_el0_svc (arch/arm64/kernel/syscall.c:156)
[...] el0_svc (./arch/arm64/include/asm/daifflags.h:28 arch/arm64/kernel/entry-common.c:133 arch/arm64/kernel/entry-common.c:144 arch/arm64/kernel/entry-common.c:679)
[...] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:?)
[...] el0t_64_sync (arch/arm64/kernel/entry.S:591)
[...] Code: 54fffb61 17ffffe4 d503201f d503233f (a9be7bfd)
All code
========
    0:   54fffb61        b.ne    0xffffffffffffff6c  // b.any
    4:   17ffffe4        b       0xffffffffffffff94
    8:   d503201f        nop
    c:   d503233f        paciasp
   10:*  a9be7bfd        stp     x29, x30, [sp, #-32]!           <-- trapping instruction

Code starting with the faulting instruction
===========================================
    0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
[...] ---[ end trace 0000000000000000 ]---

[splat-5]
[...] Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT_RT SMP
[...] Modules linked in:
[...] CPU: 2 PID: 40 Comm: rcuc/2 Not tainted 6.6.0-rc4-rt8-00102-g97b0e2d47443 #1194
[...] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct  4 2023
[...] pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[...] pc : trace_pelt_irq_tp (./include/trace/events/sched.h:?)
[...] lr : irqtime_account_irq (kernel/sched/cputime.c:64)
[...] sp : ffff8000851d3ce0
[...] x29: ffff8000851d3ce0 x28: 0000000000000020 x27: ffff800083ce4e80
[...] x26: ffff800083d46180 x25: 000000000000000a x24: 0000000000000000
[...] x23: 0000000000000007 x22: 0000000000000000 x21: ffff00097eeebf50
[...] x20: 0000000000002a08 x19: ffff00080092b480 x18: ffff8000850fd038
[...] x17: ffff800084e05000 x16: ffff800084445bf0 x15: 0000000008a87beb
[...] x14: 000000003bb0a251 x13: 0000000000000006 x12: 0000000934346b33
[...] x11: 0000000100000000 x10: 0000000000000001 x9 : 0000000014443054
[...] x8 : ffff00097eeebeb0 x7 : ffff80008012d608 x6 : 0000000000000000
[...] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000851d3d80
[...] x2 : ffff00080092b480 x1 : 0000000000000000 x0 : 000000b814aa1780
[...] Call trace:
[...] trace_pelt_irq_tp (./include/trace/events/sched.h:?)
[...] __do_softirq (./include/linux/vtime.h:? kernel/softirq.c:593)
[...] __local_bh_enable_ip (kernel/softirq.c:?)
[...] local_bh_enable (./include/linux/bottom_half.h:34)
[...] rcu_cpu_kthread (kernel/rcu/tree.c:2493)
[...] smpboot_thread_fn (kernel/smpboot.c:?)
[...] kthread (kernel/kthread.c:389)
[...] ret_from_fork (arch/arm64/kernel/entry.S:854)
[...] Code: 17ffffc2 d4210000 17ffffe4 d503201f (819e3608)
All code
========
    0:   17ffffc2        b       0xffffffffffffff08
    4:   d4210000        brk     #0x800
    8:   17ffffe4        b       0xffffffffffffff98
    c:   d503201f        nop
   10:*  819e3608        .inst   0x819e3608 ; undefined          <-- trapping instruction

Code starting with the faulting instruction
===========================================
    0:   819e3608        .inst   0x819e3608 ; undefined
[...] ---[ end trace 0000000000000000 ]---
[...] Kernel panic - not syncing: Oops - Undefined instruction: Fatal exception in interrupt
[...] SMP: stopping secondary CPUs
[...] Kernel Offset: disabled
[...] CPU features: 0x8000020c,2c020000,0000421b
[...] Memory Limit: none
