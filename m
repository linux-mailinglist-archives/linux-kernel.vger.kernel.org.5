Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD57CC0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjJQKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343689AbjJQKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:38:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D5106
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:38:23 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39HAbpMq089318;
        Tue, 17 Oct 2023 19:37:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 17 Oct 2023 19:37:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39HAbpqO089315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Oct 2023 19:37:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
Date:   Tue, 17 Oct 2023 19:37:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <878r826xys.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/17 6:47, Thomas Gleixner wrote:
> Something like the uncompiled/untested below should cure it for real. It
> really does not matter whether the TSC unstable event happens a bit
> later. The system is unhappy no matter what.

Thank you. That patch fixes the lockdep warning.

But I'm hitting something different (but might be timer/scheduler related) problem.
What config option would cause taking more than 2 minutes to bring up only 8 CPUs?
(This environment is Oracle VM VirtualBox on Windows 11 host.)

Before:
----------------------------------------
[    0.871340] Callback from call_rcu_tasks_trace() invoked.
[    0.872337] rcu: 	Max phase no-delay instances is 400.
[    0.875815] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.877552] smp: Bringing up secondary CPUs ...
[    0.879599] smpboot: x86: Booting SMP configuration:
[    0.881333] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.892319] TSC synchronization [CPU#0 -> CPU#1]:
[    0.892319] Measured 66852 cycles TSC warp between CPUs, turning off TSC clock.
[    0.892319] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    1.108337] 
[    1.109319] ================================
[    1.109319] WARNING: inconsistent lock state
[    1.109319] 6.6.0-rc5+ #7 Not tainted
[    1.109319] --------------------------------
[    1.109319] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[    1.109319] rcu_tasks_kthre/13 [HC0[0]:SC1[1]:HE1:SE0] takes:
[    1.109319] ffffffff86a85818 (watchdog_lock){?.-.}-{2:2}, at: clocksource_watchdog+0x26/0x620
[    1.109319] {IN-HARDIRQ-W} state was registered at:
[    1.109319]   lock_acquire+0xca/0x2d0
[    1.109319]   _raw_spin_lock_irqsave+0x4f/0x70
[    1.109319]   clocksource_mark_unstable+0x20/0xa0
[    1.109319]   mark_tsc_unstable+0x4a/0x70
[    1.109319]   check_tsc_sync_source+0x169/0x1d0
[    1.109319]   __flush_smp_call_function_queue+0x16d/0x590
[    1.109319]   generic_smp_call_function_single_interrupt+0x17/0x20
[    1.109319]   __sysvec_call_function_single+0x3a/0x110
[    1.109319]   sysvec_call_function_single+0x7f/0x90
[    1.109319]   asm_sysvec_call_function_single+0x1f/0x30
[    1.109319]   pv_native_safe_halt+0xf/0x20
[    1.109319]   arch_cpu_idle+0xd/0x20
[    1.109319]   default_idle_call+0x83/0x180
[    1.109319]   do_idle+0x21a/0x260
[    1.109319]   cpu_startup_entry+0x31/0x40
[    1.109319]   rest_init+0x10f/0x200
[    1.109319]   arch_call_rest_init+0x12/0x50
[    1.109319]   start_kernel+0x80b/0xa30
[    1.109319]   x86_64_start_reservations+0x1c/0x30
[    1.109319]   x86_64_start_kernel+0xbf/0x110
[    1.109319]   secondary_startup_64_no_verify+0x17d/0x18b
[    1.109319] irq event stamp: 232
[    1.109319] hardirqs last  enabled at (232): [<ffffffff850c93ac>] _raw_spin_unlock_irq+0x2c/0x60
[    1.109319] hardirqs last disabled at (231): [<ffffffff850c9081>] _raw_spin_lock_irq+0x61/0x70
[    1.109319] softirqs last  enabled at (88): [<ffffffff841c200f>] rcu_tasks_invoke_cbs+0xff/0x2f0
[    1.109319] softirqs last disabled at (173): [<ffffffff840ece40>] __irq_exit_rcu+0x80/0xb0
[    1.109319] 
[    1.109319] other info that might help us debug this:
[    1.109319]  Possible unsafe locking scenario:
[    1.109319] 
[    1.109319]        CPU0
[    1.109319]        ----
[    1.109319]   lock(watchdog_lock);
[    1.109319]   <Interrupt>
[    1.109319]     lock(watchdog_lock);
[    1.109319] 
[    1.109319]  *** DEADLOCK ***
[    1.109319] 
[    1.109319] 3 locks held by rcu_tasks_kthre/13:
[    1.109319]  #0: ffffffff869d6730 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x361/0x510
[    1.109319]  #1: ffffffff86a7ceb8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x43c/0x510
[    1.109319]  #2: ffffb67680003e68 ((&watchdog_timer)){+.-.}-{0:0}, at: call_timer_fn+0x7b/0x240
[    1.109319] 
[    1.109319] stack backtrace:
[    1.109319] CPU: 0 PID: 13 Comm: rcu_tasks_kthre Not tainted 6.6.0-rc5+ #7
[    1.109319] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[    1.109319] Call Trace:
[    1.109319]  <IRQ>
[    1.109319]  dump_stack_lvl+0x60/0xa0
[    1.109319]  dump_stack+0x14/0x20
[    1.109319]  print_usage_bug.part.0+0x25c/0x350
[    1.109319]  mark_lock.part.0+0x72f/0xa00
[    1.109319]  __lock_acquire+0x390/0x24f0
[    1.109319]  ? lockdep_unlock+0x56/0xc0
[    1.109319]  lock_acquire+0xca/0x2d0
[    1.109319]  ? clocksource_watchdog+0x26/0x620
[    1.109319]  ? __pfx_clocksource_watchdog+0x10/0x10
[    1.109319]  _raw_spin_lock+0x34/0x50
[    1.109319]  ? clocksource_watchdog+0x26/0x620
[    1.109319]  clocksource_watchdog+0x26/0x620
[    1.109319]  ? lock_acquire+0xca/0x2d0
[    1.109319]  ? __pfx_clocksource_watchdog+0x10/0x10
[    1.109319]  call_timer_fn+0xa4/0x240
[    1.109319]  ? __pfx_clocksource_watchdog+0x10/0x10
[    1.109319]  __run_timers.part.0+0x207/0x2d0
[    1.109319]  run_timer_softirq+0x2e/0x60
[    1.109319]  __do_softirq+0xc6/0x446
[    1.109319]  __irq_exit_rcu+0x80/0xb0
[    1.109319]  irq_exit_rcu+0x12/0x20
[    1.109319]  sysvec_apic_timer_interrupt+0x84/0x90
[    1.109319]  </IRQ>
[    1.109319]  <TASK>
[    1.109319]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
[    1.109319] RIP: 0010:_flat_send_IPI_mask+0x5d/0x70
[    1.109319] Code: f8 c9 c3 cc cc cc cc 89 75 f4 e8 ae 24 20 00 8b 75 f4 ba 00 08 00 00 44 89 e7 e8 ae 63 ff ff e8 c9 23 20 00 fb 0f 1f 44 00 00 <4c> 8b 65 f8 c9 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90
[    1.109319] RSP: 0000:ffffb67680073ac0 EFLAGS: 00010202
[    1.109319] RAX: 0000000000000073 RBX: 0000000000000000 RCX: 0000000000000040
[    1.109319] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff840a4357
[    1.109319] RBP: ffffb67680073ad0 R08: 0000000000000001 R09: 0000000000000001
[    1.109319] R10: 0000000000000002 R11: 0000000000000000 R12: 0000000000000020
[    1.109319] R13: 00000000000000fb R14: 000000000000001f R15: ffffffff869da348
[    1.109319]  ? _flat_send_IPI_mask+0x57/0x70
[    1.109319]  flat_send_IPI_mask+0x15/0x20
[    1.109319]  default_send_IPI_single+0x44/0x60
[    1.109319]  native_send_call_func_single_ipi+0x17/0x20
[    1.109319]  __smp_call_single_queue+0xd1/0x1c0
[    1.109319]  generic_exec_single+0x3a/0x1e0
[    1.109319]  smp_call_function_single+0xc2/0x140
[    1.109319]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[    1.109319]  __sync_rcu_exp_select_node_cpus+0x284/0x500
[    1.109319]  sync_rcu_exp_select_cpus+0x232/0x550
[    1.109319]  synchronize_rcu_expedited+0x44e/0x510
[    1.109319]  ? lock_is_held_type+0xaf/0x120
[    1.109319]  synchronize_rcu+0x1ad/0x1e0
[    1.109319]  ? __mutex_lock+0x9b/0xd30
[    1.109319]  ? __mutex_lock+0xa86/0xd30
[    1.109319]  ? lock_acquire+0xca/0x2d0
[    1.109319]  ? find_held_lock+0x31/0x90
[    1.109319]  rcu_tasks_pregp_step+0x12/0x20
[    1.109319]  rcu_tasks_wait_gp+0x5c/0x430
[    1.109319]  rcu_tasks_one_gp+0x49f/0x510
[    1.109319]  ? rcu_tasks_one_gp+0x75/0x510
[    1.109319]  ? __pfx_rcu_tasks_kthread+0x10/0x10
[    1.109319]  rcu_tasks_kthread+0xb4/0xe0
[    1.109319]  kthread+0x109/0x140
[    1.109319]  ? __pfx_kthread+0x10/0x10
[    1.109319]  ret_from_fork+0x3d/0x60
[    1.109319]  ? __pfx_kthread+0x10/0x10
[    1.109319]  ret_from_fork_asm+0x1b/0x30
[    1.109319]  </TASK>
[   40.748350] smp: Brought up 1 node, 8 CPUs
[   48.744332] smpboot: Max logical packages: 1
[   57.896327] tasks_rcu_exit_srcu_stall: rcu_tasks grace period number 5 (since boot) gp_state: RTGS_POST_SCAN_TASKLIST is 11129 jiffies old.
[   69.324322] Please check any exiting tasks stuck between calls to exit_tasks_rcu_start() and exit_tasks_rcu_finish()
[   83.516363] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
[  103.157341] Callback from call_rcu_tasks_rude() invoked.
[  105.961362] rcu_tasks_wait_gp: rcu_tasks grace period number 5 (since boot) is 104910 jiffies old.
[  137.781409] rcu_tasks_wait_gp: rcu_tasks grace period number 5 (since boot) is 136730 jiffies old.
[  142.589347] Callback from call_rcu_tasks() invoked.
----------------------------------------

After:
----------------------------------------
[    0.000000] Linux version 6.6.0-rc5+ (root@ubuntu) (gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38) #8 SMP PREEMPT_DYNAMIC Tue Oct 17 09:56:49 UTC 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.6.0-rc5+ root=UUID=a2500e32-bbc8-4f32-bf86-94a6ae160b4b ro console=ttyS0,115200n8 console=tty0
(...snipped...)
[    0.340002] Dynamic Preempt: full
[    0.340209] Running RCU self tests
[    0.340210] Running RCU synchronous self tests
[    0.340214] rcu: Preemptible hierarchical RCU implementation.
[    0.340215] rcu: 	RCU lockdep checking is enabled.
[    0.340215] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
[    0.340217] 	Trampoline variant of Tasks RCU enabled.
[    0.340217] 	Rude variant of Tasks RCU enabled.
[    0.340218] 	Tracing variant of Tasks RCU enabled.
[    0.340219] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.340219] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.340275] Running RCU synchronous self tests
[    0.343652] NR_IRQS: 524544, nr_irqs: 488, preallocated irqs: 16
[    0.344029] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.376872] Console: colour VGA+ 80x25
[    0.376893] printk: console [tty0] enabled
[    0.585051] printk: console [ttyS0] enabled
[    0.807871] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.812562] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.814986] ... MAX_LOCK_DEPTH:          48
[    0.817368] ... MAX_LOCKDEP_KEYS:        8192
[    0.819835] ... CLASSHASH_SIZE:          4096
[    0.822452] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.825290] ... MAX_LOCKDEP_CHAINS:      65536
[    0.827689] ... CHAINHASH_SIZE:          32768
[    0.830278]  memory used by lock dependency info: 6493 kB
[    0.833130]  memory used for stack traces: 4224 kB
[    0.836051]  per task-struct memory footprint: 1920 bytes
[    0.838946] ACPI: Core revision 20230628
[    0.841933] APIC: Switch to symmetric I/O mode setup
[    0.855141] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.858422] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x25a39815946, max_idle_ns: 440795282683 ns
[    0.863903] Calibrating delay loop (skipped) preset value.. 5222.41 BogoMIPS (lpj=2611208)
[    0.864890] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.864890] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.864890] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.864890] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
[    0.864890] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.864890] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.864903] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.866894] RETBleed: Mitigation: Enhanced IBRS
[    0.868893] Speculative Store Bypass: Vulnerable
[    0.870902] x86/fpu: x87 FPU will use FXSAVE
[    0.896596] Freeing SMP alternatives memory: 40K
[    0.897898] pid_max: default: 32768 minimum: 301
[    0.900001] LSM: initializing lsm=capability,bpf
[    0.901913] LSM support for eBPF active
[    0.904221] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.907152] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.910834] Running RCU synchronous self tests
[    0.911894] Running RCU synchronous self tests
[    1.029893] APIC calibration not consistent with PM-Timer: 148ms instead of 100ms
[    1.030890] APIC delta adjusted to PM-Timer: 6288407 (9311079)
[    1.031135] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1255U (family: 0x6, model: 0x9a, stepping: 0x4)
[    1.031890] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    1.031890] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    1.031890] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1.
[    1.031890] Running RCU-tasks wait API self tests
[    1.136395] Performance Events: unsupported p6 CPU model 154 no PMU driver, software events only.
[    1.138894] signal: max sigframe size: 1440
[    1.141093] rcu: Hierarchical SRCU implementation.
[    1.142904] Callback from call_rcu_tasks_trace() invoked.
[    1.144897] rcu: 	Max phase no-delay instances is 400.
[    1.148535] NMI watchdog: Perf NMI watchdog permanently disabled
[    1.150496] smp: Bringing up secondary CPUs ...
[    1.153270] smpboot: x86: Booting SMP configuration:
[    1.154900] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    1.163890] TSC synchronization [CPU#0 -> CPU#1]:
[    1.163890] Measured 66840 cycles TSC warp between CPUs, turning off TSC clock.
[    1.163890] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[   26.569928] rcu_tasks_wait_gp: rcu_tasks grace period number 5 (since boot) is 25133 jiffies old.
[   78.872032] Callback from call_rcu_tasks() invoked.
[   91.327971] smp: Brought up 1 node, 8 CPUs
[   96.402957] smpboot: Max logical packages: 1
[  119.253936] Callback from call_rcu_tasks_rude() invoked.
[  127.412964] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)
----------------------------------------

