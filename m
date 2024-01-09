Return-Path: <linux-kernel+bounces-20244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD93F827C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D27E1F242BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8610E4;
	Tue,  9 Jan 2024 01:04:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB46818;
	Tue,  9 Jan 2024 01:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F7EC433F1;
	Tue,  9 Jan 2024 01:04:03 +0000 (UTC)
Date: Mon, 8 Jan 2024 20:04:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ubisectech Sirius" <bugreport@ubisectech.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-trace-kernel"
 <linux-trace-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 linux-perf-users@vger.kernel.org
Subject: Re: possible deadlock in __perf_install_in_context
Message-ID: <20240108200459.609062c2@gandalf.local.home>
In-Reply-To: <628e1f19-2f16-476c-9530-81f9ff155d75.bugreport@ubisectech.com>
References: <8099844e-e08f-400a-b548-925928a303ee.bugreport@ubisectech.com>
	<628e1f19-2f16-476c-9530-81f9ff155d75.bugreport@ubisectech.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


This is related to perf not tracing.

-- Steve


On Tue, 09 Jan 2024 08:34:15 +0800
"Ubisectech Sirius" <bugreport@ubisectech.com> wrote:

> Dear concerned.
> Greetings!
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7.0-g0dd3ee311255.
> technical details:
> 1. Issue Description: possible deadlock in __perf_install_in_context
> 2. Stack Dump: 
> [ 158.488994][ T8029] Call Trace:
> [ 158.489411][ T8029] <TASK>
> arch/x86/events/intel/../perf_event.h:1166 arch/x86/events/intel/core.c:2799)
> [ 158.498427][ T8029] x86_pmu_start (arch/x86/events/core.c:1516)
> [ 158.499034][ T8029] x86_pmu_enable (arch/x86/events/core.c:1331 (discriminator 2))
> [ 158.499601][ T8029] perf_ctx_enable (kernel/events/core.c:703 (discriminator 2))
> [ 158.500171][ T8029] ctx_resched (kernel/events/core.c:2741)
> [ 158.500733][ T8029] __perf_install_in_context (kernel/events/core.c:2807)
> [ 158.502106][ T8029] remote_function (kernel/events/core.c:92 kernel/events/core.c:72)
> [ 158.503364][ T8029] generic_exec_single (kernel/smp.c:134 (discriminator 3) kernel/smp.c:404 (discriminator 3))
> [ 158.503995][ T8029] smp_call_function_single (kernel/smp.c:647)
> (./arch/x86/include/asm/irqflags.h:42 ./arch/x86/include/asm/irqflags.h:77 ./arch/x86/include/asm/irqflags.h:135 lib/percpu_counter.c:102)
> [ 158.512958][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.515717][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.518483][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.519281][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.519991][ T8029] RIP: 0033:0x7f04a0c9cf29
> [ 158.520536][ T8029] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
> All code
> ========
>  0: 00 c3 add %al,%bl
>  2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>  9: 00 00 00
>  c: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
>  11: 48 89 f8 mov %rdi,%rax
>  14: 48 89 f7 mov %rsi,%rdi
>  17: 48 89 d6 mov %rdx,%rsi
>  1a: 48 89 ca mov %rcx,%rdx
>  1d: 4d 89 c2 mov %r8,%r10
>  20: 4d 89 c8 mov %r9,%r8
>  23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
>  28: 0f 05 syscall
>  2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instruction
>  30: 73 01 jae 0x33
>  32: c3 ret
>  33: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f71
>  3a: f7 d8 neg %eax
>  3c: 64 89 01 mov %eax,%fs:(%rcx)
>  3f: 48 rex.W
> Code starting with the faulting instruction
> ===========================================
>  0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
>  6: 73 01 jae 0x9
>  8: c3 ret
>  9: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f47
>  10: f7 d8 neg %eax
>  12: 64 89 01 mov %eax,%fs:(%rcx)
>  15: 48 rex.W
> [ 158.522837][ T8029] RSP: 002b:00007ffe5f1174b8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 158.523848][ T8029] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04a0c9cf29
> [ 158.524797][ T8029] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020004740
> [ 158.525738][ T8029] RBP: 00007ffe5f1174c0 R08: 0000000000000000 R09: 00007ffe5f1174f0
> [ 158.526717][ T8029] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005597d067d180
> [ 158.527661][ T8029] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 158.528611][ T8029] </TASK>
> [ 158.530059][ T8029]
> [ 158.530364][ T8029] ======================================================
> [ 158.531146][ T8029] WARNING: possible circular locking dependency detected
> [ 158.531881][ T8029] 6.7.0-g0dd3ee311255 #6 Not tainted
> [ 158.532457][ T8029] ------------------------------------------------------
> [ 158.533256][ T8029] poc/8029 is trying to acquire lock:
> [ 158.533880][ T8029] ffff88801ca53018 (&ctx->lock){....}-{2:2}, at: __perf_event_task_sched_out (kernel/events/core.c:3573 kernel/events/core.c:3676)
> [ 158.535067][ T8029]
> [ 158.535067][ T8029] but task is already holding lock:
> [ 158.535925][ T8029] ffff88802d23c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:574)
> [ 158.537001][ T8029]
> [ 158.537001][ T8029] which lock already depends on the new lock.
> [ 158.537001][ T8029]
> [ 158.538196][ T8029]
> [ 158.538196][ T8029] the existing dependency chain (in reverse order) is:
> [ 158.539200][ T8029]
> [ 158.539200][ T8029] -> #3 (&rq->__lock){-.-.}-{2:2}:
> [ 158.540081][ T8029] _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
> [ 158.540772][ T8029] raw_spin_rq_lock_nested (kernel/sched/core.c:574)
> [ 158.541471][ T8029] task_fork_fair (kernel/sched/sched.h:1222 kernel/sched/sched.h:1581 kernel/sched/sched.h:1664 kernel/sched/fair.c:12586)
> [ 158.542092][ T8029] sched_cgroup_fork (kernel/sched/core.c:4814)
> [ 158.542772][ T8029] copy_process (./include/linux/timekeeping.h:154 kernel/fork.c:2619)
> [ 158.543413][ T8029] kernel_clone (./include/linux/random.h:26 kernel/fork.c:2908)
> [ 158.544017][ T8029] user_mode_thread (kernel/fork.c:2976)
> [ 158.544648][ T8029] rest_init (init/main.c:695)
> [ 158.545223][ T8029] arch_call_rest_init+0x13/0x30
> [ 158.545874][ T8029] start_kernel (init/main.c:1023 (discriminator 1))
> [ 158.546503][ T8029] x86_64_start_reservations (arch/x86/kernel/head64.c:543)
> [ 158.547244][ T8029] x86_64_start_kernel (./arch/x86/include/asm/page_64.h:26 arch/x86/kernel/head64.c:326 arch/x86/kernel/head64.c:492)
> [ 158.547901][ T8029] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:448)
> [ 158.548696][ T8029]
> [ 158.548696][ T8029] -> #2 (&p->pi_lock){-.-.}-{2:2}:
> [ 158.549576][ T8029] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 158.550281][ T8029] try_to_wake_up (kernel/sched/core.c:4049 kernel/sched/core.c:4228)
> [ 158.550914][ T8029] up (kernel/locking/semaphore.c:192)
> [ 158.551412][ T8029] console_unlock (kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038)
> [ 158.552055][ T8029] vga_remove_vgacon (drivers/pci/vgaarb.c:188 drivers/pci/vgaarb.c:167)
> [ 158.552697][ T8029] aperture_remove_conflicting_pci_devices (drivers/video/aperture.c:331 drivers/video/aperture.c:374)
> [ 158.553573][ T8029] bochs_pci_probe (drivers/gpu/drm/tiny/bochs.c:652)
> [ 158.554202][ T8029] local_pci_probe (drivers/pci/pci-driver.c:325)
> [ 158.554857][ T8029] pci_device_probe (drivers/pci/pci-driver.c:392 drivers/pci/pci-driver.c:417 drivers/pci/pci-driver.c:460)
> [ 158.555510][ T8029] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
> [ 158.556123][ T8029] __driver_probe_device (drivers/base/dd.c:800)
> [ 158.556829][ T8029] driver_probe_device (drivers/base/dd.c:831)
> [ 158.557499][ T8029] __driver_attach (drivers/base/dd.c:1217)
> [ 158.558136][ T8029] bus_for_each_dev (drivers/base/bus.c:367)
> [ 158.558788][ T8029] bus_add_driver (drivers/base/bus.c:674)
> [ 158.559410][ T8029] driver_register (drivers/base/driver.c:247)
> [ 158.560040][ T8029] bochs_pci_driver_init (./include/drm/drm_module.h:69 drivers/gpu/drm/tiny/bochs.c:735)
> [ 158.560701][ T8029] do_one_initcall (init/main.c:1236)
> [ 158.561337][ T8029] kernel_init_freeable (init/main.c:1297 init/main.c:1314 init/main.c:1333 init/main.c:1551)
> [ 158.562031][ T8029] kernel_init (init/main.c:1443)
> [ 158.562638][ T8029] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 158.563246][ T8029] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [ 158.563890][ T8029]
> [ 158.563890][ T8029] -> #1 ((console_sem).lock){-...}-{2:2}:
> [ 158.564853][ T8029] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 158.565559][ T8029] down_trylock (kernel/locking/semaphore.c:140)
> [ 158.566152][ T8029] __down_trylock_console_sem (kernel/printk/printk.c:323)
> [ 158.566924][ T8029] console_trylock (kernel/printk/printk.c:2659 kernel/printk/printk.c:2654)
> [ 158.567564][ T8029] vprintk_emit (kernel/printk/printk.c:1923 kernel/printk/printk.c:2302)
> [ 158.568171][ T8029] vprintk (kernel/printk/printk_safe.c:45)
> [ 158.568714][ T8029] _printk (kernel/printk/printk.c:2323)
> [ 158.569258][ T8029] ex_handler_msr (arch/x86/mm/extable.c:180 (discriminator 9))
> [ 158.569890][ T8029] fixup_exception (arch/x86/mm/extable.c:283)
> [ 158.570540][ T8029] gp_try_fixup_and_notify.constprop.0 (arch/x86/kernel/traps.c:616)
> [ 158.571389][ T8029] exc_general_protection (arch/x86/kernel/traps.c:676 arch/x86/kernel/traps.c:642)
> [ 158.572110][ T8029] asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:564)
> [ 158.572839][ T8029] intel_pmu_enable_event (./arch/x86/include/asm/msr.h:94 ./arch/x86/include/asm/msr.h:145 ./arch/x86/include/asm/msr.h:262 arch/x86/events/intel/../perf_event.h:1166 arch/x86/events/intel/core.c:2799)
> [ 158.573546][ T8029] x86_pmu_start (arch/x86/events/core.c:1516)
> [ 158.574171][ T8029] x86_pmu_enable (arch/x86/events/core.c:1331 (discriminator 2))
> [ 158.574815][ T8029] perf_ctx_enable (kernel/events/core.c:703 (discriminator 2))
> [ 158.575456][ T8029] ctx_resched (kernel/events/core.c:2741)
> [ 158.576066][ T8029] __perf_install_in_context (kernel/events/core.c:2807)
> [ 158.576808][ T8029] remote_function (kernel/events/core.c:92 kernel/events/core.c:72)
> [ 158.577436][ T8029] generic_exec_single (kernel/smp.c:134 (discriminator 3) kernel/smp.c:404 (discriminator 3))
> [ 158.578101][ T8029] smp_call_function_single (kernel/smp.c:647)
> [ 158.578830][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.579492][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.580214][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.580959][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.581579][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.582351][ T8029]
> [ 158.582351][ T8029] -> #0 (&ctx->lock){....}-{2:2}:
> [ 158.583241][ T8029] __lock_acquire (kernel/locking/lockdep.c:3135 kernel/locking/lockdep.c:3253 kernel/locking/lockdep.c:3869 kernel/locking/lockdep.c:5137)
> [ 158.583894][ T8029] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
> [ 158.584526][ T8029] _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 158.585149][ T8029] __perf_event_task_sched_out (kernel/events/core.c:3573 kernel/events/core.c:3676)
> [ 158.585907][ T8029] __schedule (./include/linux/perf_event.h:1487 kernel/sched/core.c:5180 kernel/sched/core.c:5323 kernel/sched/core.c:6688)
> [ 158.586497][ T8029] preempt_schedule_common (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/linux/thread_info.h:184 ./include/linux/sched.h:2263 kernel/sched/core.c:6873)
> [ 158.587239][ T8029] preempt_schedule_thunk (arch/x86/entry/thunk_64.S:45)
> [ 158.587916][ T8029] smp_call_function_single (kernel/smp.c:652 (discriminator 1))
> [ 158.588639][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.589292][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.590011][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.590784][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.591396][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.592162][ T8029]
> [ 158.592162][ T8029] other info that might help us debug this:
> [ 158.592162][ T8029]
> [ 158.593338][ T8029] Chain exists of:
> [ 158.593338][ T8029] &ctx->lock --> &p->pi_lock --> &rq->__lock
> [ 158.593338][ T8029]
> [ 158.594749][ T8029] Possible unsafe locking scenario:
> [ 158.594749][ T8029]
> [ 158.595614][ T8029] CPU0 CPU1
> [ 158.596252][ T8029] ---- ----
> [ 158.596886][ T8029] lock(&rq->__lock);
> [ 158.597394][ T8029] lock(&p->pi_lock);
> [ 158.598194][ T8029] lock(&rq->__lock);
> [ 158.598992][ T8029] lock(&ctx->lock);
> [ 158.599485][ T8029]
> [ 158.599485][ T8029] *** DEADLOCK ***
> [ 158.599485][ T8029]
> [ 158.600436][ T8029] 3 locks held by poc/8029:
> [ 158.600984][ T8029] #0: ffff8880130270a0 (&sig->exec_update_lock){++++}-{3:3}, at: __do_sys_perf_event_open (kernel/events/core.c:12538)
> [ 158.602327][ T8029] #1: ffff88801ca530a8 (&ctx->mutex){+.+.}-{3:3}, at: __do_sys_perf_event_open (kernel/events/core.c:12563)
> [ 158.603589][ T8029] #2: ffff88802d23c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:574)
> [ 158.604791][ T8029]
> [ 158.604791][ T8029] stack backtrace:
> [ 158.605497][ T8029] CPU: 0 PID: 8029 Comm: poc Not tainted 6.7.0-g0dd3ee311255 #6
> [ 158.606410][ T8029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [ 158.607495][ T8029] Call Trace:
> [ 158.607906][ T8029] <TASK>
> [ 158.608265][ T8029] dump_stack_lvl (lib/dump_stack.c:107)
> [ 158.608830][ T8029] check_noncircular (kernel/locking/lockdep.c:2187)
> [ 158.612990][ T8029] __lock_acquire (kernel/locking/lockdep.c:3135 kernel/locking/lockdep.c:3253 kernel/locking/lockdep.c:3869 kernel/locking/lockdep.c:5137)
> [ 158.614337][ T8029] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
> [ 158.618163][ T8029] _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 158.619483][ T8029] __perf_event_task_sched_out (kernel/events/core.c:3573 kernel/events/core.c:3676)
> [ 158.621454][ T8029] __schedule (./include/linux/perf_event.h:1487 kernel/sched/core.c:5180 kernel/sched/core.c:5323 kernel/sched/core.c:6688)
> [ 158.625012][ T8029] preempt_schedule_common (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/linux/thread_info.h:184 ./include/linux/sched.h:2263 kernel/sched/core.c:6873)
> [ 158.625654][ T8029] preempt_schedule_thunk (arch/x86/entry/thunk_64.S:45)
> [ 158.627659][ T8029] smp_call_function_single (kernel/smp.c:652 (discriminator 1))
> [ 158.633418][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.635669][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.638010][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.640419][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.640903][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.641502][ T8029] RIP: 0033:0x7f04a0c9cf29
> [ 158.641956][ T8029] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
> All code
> ========
>  0: 00 c3 add %al,%bl
>  2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>  9: 00 00 00
>  c: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
>  11: 48 89 f8 mov %rdi,%rax
>  14: 48 89 f7 mov %rsi,%rdi
>  17: 48 89 d6 mov %rdx,%rsi
>  1a: 48 89 ca mov %rcx,%rdx
>  1d: 4d 89 c2 mov %r8,%r10
>  20: 4d 89 c8 mov %r9,%r8
>  23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
>  28: 0f 05 syscall
>  2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instruction
>  30: 73 01 jae 0x33
>  32: c3 ret
>  33: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f71
>  3a: f7 d8 neg %eax
>  3c: 64 89 01 mov %eax,%fs:(%rcx)
>  3f: 48 rex.W
> Code starting with the faulting instruction
> ===========================================
>  0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
>  6: 73 01 jae 0x9
>  8: c3 ret
>  9: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f47
>  10: f7 d8 neg %eax
>  12: 64 89 01 mov %eax,%fs:(%rcx)
>  15: 48 rex.W
> [ 158.644020][ T8029] RSP: 002b:00007ffe5f1174b8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 158.644916][ T8029] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04a0c9cf29
> [ 158.645760][ T8029] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020004740
> [ 158.646592][ T8029] RBP: 00007ffe5f1174c0 R08: 0000000000000000 R09: 00007ffe5f1174f0
> [ 158.647474][ T8029] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005597d067d180
> [ 158.648341][ T8029] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 158.649159][ T8029] </TASK>
> root@test-h2-pc:~/1900/workdir/new_zero_day_crashes/4c1dceb01dec061b63593f149cf10429fa012309# vi out
> root@test-h2-pc:~/1900/workdir/new_zero_day_crashes/4c1dceb01dec061b63593f149cf10429fa012309# cat out
> [ 158.488994][ T8029] Call Trace:
> [ 158.489411][ T8029] <TASK>
> [ 158.498427][ T8029] x86_pmu_start (arch/x86/events/core.c:1516)
> [ 158.499034][ T8029] x86_pmu_enable (arch/x86/events/core.c:1331 (discriminator 2))
> [ 158.499601][ T8029] perf_ctx_enable (kernel/events/core.c:703 (discriminator 2))
> [ 158.500171][ T8029] ctx_resched (kernel/events/core.c:2741)
> [ 158.500733][ T8029] __perf_install_in_context (kernel/events/core.c:2807)
> [ 158.502106][ T8029] remote_function (kernel/events/core.c:92 kernel/events/core.c:72)
> [ 158.503364][ T8029] generic_exec_single (kernel/smp.c:134 (discriminator 3) kernel/smp.c:404 (discriminator 3))
> [ 158.503995][ T8029] smp_call_function_single (kernel/smp.c:647)
> [ 158.510408][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.512958][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.515717][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.518483][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.519281][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.519991][ T8029] RIP: 0033:0x7f04a0c9cf29
> [ 158.520536][ T8029] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
> All code
> ========
>  0: 00 c3 add %al,%bl
>  2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>  9: 00 00 00
>  c: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
>  11: 48 89 f8 mov %rdi,%rax
>  14: 48 89 f7 mov %rsi,%rdi
>  17: 48 89 d6 mov %rdx,%rsi
>  1a: 48 89 ca mov %rcx,%rdx
>  1d: 4d 89 c2 mov %r8,%r10
>  20: 4d 89 c8 mov %r9,%r8
>  23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
>  28: 0f 05 syscall
>  2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instruction
>  30: 73 01 jae 0x33
>  32: c3 ret
>  33: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f71
>  3a: f7 d8 neg %eax
>  3c: 64 89 01 mov %eax,%fs:(%rcx)
>  3f: 48 rex.W
> Code starting with the faulting instruction
> ===========================================
>  0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
>  6: 73 01 jae 0x9
>  8: c3 ret
>  9: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f47
>  10: f7 d8 neg %eax
>  12: 64 89 01 mov %eax,%fs:(%rcx)
>  15: 48 rex.W
> [ 158.522837][ T8029] RSP: 002b:00007ffe5f1174b8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 158.523848][ T8029] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04a0c9cf29
> [ 158.524797][ T8029] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020004740
> [ 158.525738][ T8029] RBP: 00007ffe5f1174c0 R08: 0000000000000000 R09: 00007ffe5f1174f0
> [ 158.526717][ T8029] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005597d067d180
> [ 158.527661][ T8029] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 158.528611][ T8029] </TASK>
> [ 158.530059][ T8029]
> [ 158.530364][ T8029] ======================================================
> [ 158.531146][ T8029] WARNING: possible circular locking dependency detected
> [ 158.531881][ T8029] 6.7.0-g0dd3ee311255 #6 Not tainted
> [ 158.532457][ T8029] ------------------------------------------------------
> [ 158.533256][ T8029] poc/8029 is trying to acquire lock:
> [ 158.533880][ T8029] ffff88801ca53018 (&ctx->lock){....}-{2:2}, at: __perf_event_task_sched_out (kernel/events/core.c:3573 kernel/events/core.c:3676)
> [ 158.535067][ T8029]
> [ 158.535067][ T8029] but task is already holding lock:
> [ 158.535925][ T8029] ffff88802d23c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:574)
> [ 158.537001][ T8029]
> [ 158.537001][ T8029] which lock already depends on the new lock.
> [ 158.537001][ T8029]
> [ 158.538196][ T8029]
> [ 158.538196][ T8029] the existing dependency chain (in reverse order) is:
> [ 158.539200][ T8029]
> [ 158.539200][ T8029] -> #3 (&rq->__lock){-.-.}-{2:2}:
> [ 158.540081][ T8029] _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
> [ 158.540772][ T8029] raw_spin_rq_lock_nested (kernel/sched/core.c:574)
> [ 158.541471][ T8029] task_fork_fair (kernel/sched/sched.h:1222 kernel/sched/sched.h:1581 kernel/sched/sched.h:1664 kernel/sched/fair.c:12586)
> [ 158.542092][ T8029] sched_cgroup_fork (kernel/sched/core.c:4814)
> [ 158.542772][ T8029] copy_process (./include/linux/timekeeping.h:154 kernel/fork.c:2619)
> [ 158.543413][ T8029] kernel_clone (./include/linux/random.h:26 kernel/fork.c:2908)
> [ 158.544017][ T8029] user_mode_thread (kernel/fork.c:2976)
> [ 158.544648][ T8029] rest_init (init/main.c:695)
> [ 158.545223][ T8029] arch_call_rest_init+0x13/0x30
> [ 158.545874][ T8029] start_kernel (init/main.c:1023 (discriminator 1))
> [ 158.546503][ T8029] x86_64_start_reservations (arch/x86/kernel/head64.c:543)
> [ 158.547244][ T8029] x86_64_start_kernel (./arch/x86/include/asm/page_64.h:26 arch/x86/kernel/head64.c:326 arch/x86/kernel/head64.c:492)
> [ 158.547901][ T8029] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:448)
> [ 158.548696][ T8029]
> [ 158.548696][ T8029] -> #2 (&p->pi_lock){-.-.}-{2:2}:
> [ 158.549576][ T8029] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 158.550281][ T8029] try_to_wake_up (kernel/sched/core.c:4049 kernel/sched/core.c:4228)
> [ 158.550914][ T8029] up (kernel/locking/semaphore.c:192)
> [ 158.551412][ T8029] console_unlock (kernel/printk/printk.c:341 kernel/printk/printk.c:2706 kernel/printk/printk.c:3038)
> [ 158.552055][ T8029] vga_remove_vgacon (drivers/pci/vgaarb.c:188 drivers/pci/vgaarb.c:167)
> [ 158.552697][ T8029] aperture_remove_conflicting_pci_devices (drivers/video/aperture.c:331 drivers/video/aperture.c:374)
> [ 158.553573][ T8029] bochs_pci_probe (drivers/gpu/drm/tiny/bochs.c:652)
> [ 158.554202][ T8029] local_pci_probe (drivers/pci/pci-driver.c:325)
> [ 158.554857][ T8029] pci_device_probe (drivers/pci/pci-driver.c:392 drivers/pci/pci-driver.c:417 drivers/pci/pci-driver.c:460)
> [ 158.555510][ T8029] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
> [ 158.556123][ T8029] __driver_probe_device (drivers/base/dd.c:800)
> [ 158.556829][ T8029] driver_probe_device (drivers/base/dd.c:831)
> [ 158.557499][ T8029] __driver_attach (drivers/base/dd.c:1217)
> [ 158.558136][ T8029] bus_for_each_dev (drivers/base/bus.c:367)
> [ 158.558788][ T8029] bus_add_driver (drivers/base/bus.c:674)
> [ 158.559410][ T8029] driver_register (drivers/base/driver.c:247)
> [ 158.560040][ T8029] bochs_pci_driver_init (./include/drm/drm_module.h:69 drivers/gpu/drm/tiny/bochs.c:735)
> [ 158.560701][ T8029] do_one_initcall (init/main.c:1236)
> [ 158.561337][ T8029] kernel_init_freeable (init/main.c:1297 init/main.c:1314 init/main.c:1333 init/main.c:1551)
> [ 158.562031][ T8029] kernel_init (init/main.c:1443)
> [ 158.562638][ T8029] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 158.563246][ T8029] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [ 158.563890][ T8029]
> [ 158.563890][ T8029] -> #1 ((console_sem).lock){-...}-{2:2}:
> [ 158.564853][ T8029] _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
> [ 158.565559][ T8029] down_trylock (kernel/locking/semaphore.c:140)
> [ 158.566152][ T8029] __down_trylock_console_sem (kernel/printk/printk.c:323)
> [ 158.566924][ T8029] console_trylock (kernel/printk/printk.c:2659 kernel/printk/printk.c:2654)
> [ 158.567564][ T8029] vprintk_emit (kernel/printk/printk.c:1923 kernel/printk/printk.c:2302)
> [ 158.568171][ T8029] vprintk (kernel/printk/printk_safe.c:45)
> [ 158.568714][ T8029] _printk (kernel/printk/printk.c:2323)
> [ 158.569258][ T8029] ex_handler_msr (arch/x86/mm/extable.c:180 (discriminator 9))
> [ 158.569890][ T8029] fixup_exception (arch/x86/mm/extable.c:283)
> [ 158.570540][ T8029] gp_try_fixup_and_notify.constprop.0 (arch/x86/kernel/traps.c:616)
> [ 158.571389][ T8029] exc_general_protection (arch/x86/kernel/traps.c:676 arch/x86/kernel/traps.c:642)
> [ 158.572110][ T8029] asm_exc_general_protection (./arch/x86/include/asm/idtentry.h:564)
> [ 158.572839][ T8029] intel_pmu_enable_event (./arch/x86/include/asm/msr.h:94 ./arch/x86/include/asm/msr.h:145 ./arch/x86/include/asm/msr.h:262 arch/x86/events/intel/../perf_event.h:1166 arch/x86/events/intel/core.c:2799)
> [ 158.573546][ T8029] x86_pmu_start (arch/x86/events/core.c:1516)
> [ 158.574171][ T8029] x86_pmu_enable (arch/x86/events/core.c:1331 (discriminator 2))
> [ 158.574815][ T8029] perf_ctx_enable (kernel/events/core.c:703 (discriminator 2))
> [ 158.575456][ T8029] ctx_resched (kernel/events/core.c:2741)
> [ 158.576066][ T8029] __perf_install_in_context (kernel/events/core.c:2807)
> [ 158.576808][ T8029] remote_function (kernel/events/core.c:92 kernel/events/core.c:72)
> [ 158.577436][ T8029] generic_exec_single (kernel/smp.c:134 (discriminator 3) kernel/smp.c:404 (discriminator 3))
> [ 158.578101][ T8029] smp_call_function_single (kernel/smp.c:647)
> [ 158.578830][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.579492][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.580214][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.580959][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.581579][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.582351][ T8029]
> [ 158.582351][ T8029] -> #0 (&ctx->lock){....}-{2:2}:
> [ 158.583241][ T8029] __lock_acquire (kernel/locking/lockdep.c:3135 kernel/locking/lockdep.c:3253 kernel/locking/lockdep.c:3869 kernel/locking/lockdep.c:5137)
> [ 158.583894][ T8029] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
> [ 158.584526][ T8029] _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 158.585149][ T8029] __perf_event_task_sched_out (kernel/events/core.c:3573 kernel/events/core.c:3676)
> [ 158.585907][ T8029] __schedule (./include/linux/perf_event.h:1487 kernel/sched/core.c:5180 kernel/sched/core.c:5323 kernel/sched/core.c:6688)
> [ 158.586497][ T8029] preempt_schedule_common (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/linux/thread_info.h:184 ./include/linux/sched.h:2263 kernel/sched/core.c:6873)
> [ 158.587239][ T8029] preempt_schedule_thunk (arch/x86/entry/thunk_64.S:45)
> [ 158.587916][ T8029] smp_call_function_single (kernel/smp.c:652 (discriminator 1))
> [ 158.588639][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.589292][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.590011][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.590784][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.591396][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.592162][ T8029]
> [ 158.592162][ T8029] other info that might help us debug this:
> [ 158.592162][ T8029]
> [ 158.593338][ T8029] Chain exists of:
> [ 158.593338][ T8029] &ctx->lock --> &p->pi_lock --> &rq->__lock
> [ 158.593338][ T8029]
> [ 158.594749][ T8029] Possible unsafe locking scenario:
> [ 158.594749][ T8029]
> [ 158.595614][ T8029] CPU0 CPU1
> [ 158.596252][ T8029] ---- ----
> [ 158.596886][ T8029] lock(&rq->__lock);
> [ 158.597394][ T8029] lock(&p->pi_lock);
> [ 158.598194][ T8029] lock(&rq->__lock);
> [ 158.598992][ T8029] lock(&ctx->lock);
> [ 158.599485][ T8029]
> [ 158.599485][ T8029] *** DEADLOCK ***
> [ 158.599485][ T8029]
> [ 158.600436][ T8029] 3 locks held by poc/8029:
> [ 158.600984][ T8029] #0: ffff8880130270a0 (&sig->exec_update_lock){++++}-{3:3}, at: __do_sys_perf_event_open (kernel/events/core.c:12538)
> [ 158.602327][ T8029] #1: ffff88801ca530a8 (&ctx->mutex){+.+.}-{3:3}, at: __do_sys_perf_event_open (kernel/events/core.c:12563)
> [ 158.603589][ T8029] #2: ffff88802d23c758 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested (kernel/sched/core.c:574)
> [ 158.604791][ T8029]
> [ 158.604791][ T8029] stack backtrace:
> [ 158.605497][ T8029] CPU: 0 PID: 8029 Comm: poc Not tainted 6.7.0-g0dd3ee311255 #6
> [ 158.606410][ T8029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [ 158.607495][ T8029] Call Trace:
> [ 158.607906][ T8029] <TASK>
> [ 158.608265][ T8029] dump_stack_lvl (lib/dump_stack.c:107)
> [ 158.608830][ T8029] check_noncircular (kernel/locking/lockdep.c:2187)
> [ 158.612990][ T8029] __lock_acquire (kernel/locking/lockdep.c:3135 kernel/locking/lockdep.c:3253 kernel/locking/lockdep.c:3869 kernel/locking/lockdep.c:5137)
> [ 158.614337][ T8029] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
> [ 158.618163][ T8029] _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 158.619483][ T8029] __perf_event_task_sched_out (kernel/events/core.c:3573 kernel/events/core.c:3676)
> [ 158.621454][ T8029] __schedule (./include/linux/perf_event.h:1487 kernel/sched/core.c:5180 kernel/sched/core.c:5323 kernel/sched/core.c:6688)
> [ 158.625012][ T8029] preempt_schedule_common (./arch/x86/include/asm/bitops.h:206 ./arch/x86/include/asm/bitops.h:238 ./include/linux/thread_info.h:184 ./include/linux/sched.h:2263 kernel/sched/core.c:6873)
> [ 158.625654][ T8029] preempt_schedule_thunk (arch/x86/entry/thunk_64.S:45)
> [ 158.627659][ T8029] smp_call_function_single (kernel/smp.c:652 (discriminator 1))
> [ 158.633418][ T8029] task_function_call (kernel/events/core.c:122)
> [ 158.635669][ T8029] perf_install_in_context (kernel/events/core.c:2909 (discriminator 1))
> [ 158.638010][ T8029] __do_sys_perf_event_open (kernel/events/core.c:1443 kernel/events/core.c:12747)
> [ 158.640419][ T8029] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
> [ 158.640903][ T8029] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> [ 158.641502][ T8029] RIP: 0033:0x7f04a0c9cf29
> [ 158.641956][ T8029] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
> All code
> ========
>  0: 00 c3 add %al,%bl
>  2: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
>  9: 00 00 00
>  c: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
>  11: 48 89 f8 mov %rdi,%rax
>  14: 48 89 f7 mov %rsi,%rdi
>  17: 48 89 d6 mov %rdx,%rsi
>  1a: 48 89 ca mov %rcx,%rdx
>  1d: 4d 89 c2 mov %r8,%r10
>  20: 4d 89 c8 mov %r9,%r8
>  23: 4c 8b 4c 24 08 mov 0x8(%rsp),%r9
>  28: 0f 05 syscall
>  2a:* 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax <-- trapping instruction
>  30: 73 01 jae 0x33
>  32: c3 ret
>  33: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f71
>  3a: f7 d8 neg %eax
>  3c: 64 89 01 mov %eax,%fs:(%rcx)
>  3f: 48 rex.W
> Code starting with the faulting instruction
> ===========================================
>  0: 48 3d 01 f0 ff ff cmp $0xfffffffffffff001,%rax
>  6: 73 01 jae 0x9
>  8: c3 ret
>  9: 48 8b 0d 37 8f 0d 00 mov 0xd8f37(%rip),%rcx # 0xd8f47
>  10: f7 d8 neg %eax
>  12: 64 89 01 mov %eax,%fs:(%rcx)
>  15: 48 rex.W
> [ 158.644020][ T8029] RSP: 002b:00007ffe5f1174b8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> [ 158.644916][ T8029] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04a0c9cf29
> [ 158.645760][ T8029] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020004740
> [ 158.646592][ T8029] RBP: 00007ffe5f1174c0 R08: 0000000000000000 R09: 00007ffe5f1174f0
> [ 158.647474][ T8029] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005597d067d180
> [ 158.648341][ T8029] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 158.649159][ T8029] </TASK>
> 3. Attachment description: Attached to the email were a POC file of the vulnerability and a configuration my Linux kernel.
> Thank you for taking the time to read this email and we look forward to working with you further.
>  Ubisectech Sirius Team
>  Web: www.ubisectech.com
>  Email: bugreport@ubisectech.com


