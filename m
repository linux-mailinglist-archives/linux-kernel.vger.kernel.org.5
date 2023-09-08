Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90779865D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbjIHLUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjIHLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:20:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E7F1BF6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 04:20:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A228C433C9;
        Fri,  8 Sep 2023 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694172029;
        bh=ir8Mb1Y8thF7Si5+XmY0etkU/3vWu6EkvoiVlDTeqRA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o2/4u4xPcg3eqRLuoewCahfZxIhrOP51aZapwP0+hBPMfxigUPaNxHS2wFx9vyUxE
         Em0ERbosArWnqUAAZvgYYvzA/xFlPIzh6Ouy3Zl/osKGjaRktcOIAPji/+x9A3cIJQ
         y648bay2IRMzZ56pXon7L+U91+8sdLxoNTwYH4hpIQI0LHaPr23bJ+GscnnceW2/Lv
         YxiAdO9zVWHv5sEEVkN296OsgEc30xO91rlCPVReuhmtSA851GxRZKYr5Y6YHWoBFR
         hXywe5kICu8lp8rZVOmFc3AB39a+1Vh2rKaEm4++2tmUYYDPzMAEYP7kVw7PY8DdYI
         d6ZDucuG3Ng6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 064DFCE0FF4; Fri,  8 Sep 2023 04:20:29 -0700 (PDT)
Date:   Fri, 8 Sep 2023 04:20:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.08.24a] [EXP qspinlock] 3d22d912bd:
 UBSAN:array-index-out-of-bounds_in_kernel/locking/qspinlock.c
Message-ID: <07830e28-83da-4fe9-99b7-5036a762fb6c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202309081258.8d57032f-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309081258.8d57032f-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 12:54:10PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_kernel/locking/qspinlock.c" on:
> 
> commit: 3d22d912bd0373dd479764644b8c0c81ec4bcc61 ("EXP qspinlock: Dump lock state, add call from locktorture")
> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.24a
> 
> in testcase: boot
> 
> compiler: gcc-9
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202309081258.8d57032f-oliver.sang@intel.com
> 
> 
> [ 1660.539448][    C0] UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.c:712:8
> [ 1660.539448][    C0] index -1 is out of range for type 'long unsigned int [64]'

Oooh...  Good catch, fix in progress, thank you!

							Thanx, Paul

> [ 1660.539448][    C0] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       TN 6.5.0-rc1-00129-g3d22d912bd03 #1
> [ 1660.539448][    C0] Call Trace:
> [ 1660.539448][    C0]  <IRQ>
> [ 1660.539448][ C0] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
> [ 1660.539448][ C0] dump_stack (lib/dump_stack.c:114) 
> [ 1660.539448][ C0] ubsan_epilogue (lib/ubsan.c:218) 
> [ 1660.539448][ C0] __ubsan_handle_out_of_bounds (lib/ubsan.c:349) 
> [ 1660.539448][ C0] spinlock_dump (kernel/locking/qspinlock.c:712) 
> [ 1660.539448][ C0] torture_spin_lock_dump (kernel/locking/locktorture.c:289) 
> [ 1660.539448][ C0] notifier_call_chain (kernel/notifier.c:93) 
> [ 1660.539448][ C0] atomic_notifier_call_chain (kernel/notifier.c:231) 
> [ 1660.539448][ C0] rcu_stall_notifier_call_chain (kernel/rcu/tree_stall.h:1101) 
> [ 1660.539448][ C0] rcu_sched_clock_irq (kernel/rcu/tree_stall.h:775 kernel/rcu/tree.c:3863 kernel/rcu/tree.c:2241) 
> [ 1660.539448][ C0] update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
> [ 1660.539448][ C0] tick_sched_handle+0x45/0x54 
> [ 1660.539448][ C0] tick_sched_timer (kernel/time/tick-sched.c:1492) 
> [ 1660.539448][ C0] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479) 
> [ 1660.539448][ C0] __hrtimer_run_queues (kernel/time/hrtimer.c:1690 kernel/time/hrtimer.c:1752) 
> [ 1660.539448][ C0] hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
> [ 1660.539448][ C0] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1116) 
> [ 1660.539448][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1109 (discriminator 14)) 
> [ 1660.539448][    C0]  </IRQ>
> [ 1660.539448][    C0]  <TASK>
> [ 1660.539448][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
> [ 1660.539448][ C0] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
> [ 1660.539448][ C0] Code: 5e 12 ff 81 e3 00 02 00 00 74 05 e8 12 96 1a ff 9c 58 0f ba e0 09 73 05 e8 97 4a ff ff 48 85 db 74 01 fb 65 ff 0d d3 c8 17 7e <75> 05 0f 1f 44 00 00 5b 41 5c 5d c3 f3 0f 1e fa 55 48 89 e5 53 48
> All code
> ========
>    0:	5e                   	pop    %rsi
>    1:	12 ff                	adc    %bh,%bh
>    3:	81 e3 00 02 00 00    	and    $0x200,%ebx
>    9:	74 05                	je     0x10
>    b:	e8 12 96 1a ff       	callq  0xffffffffff1a9622
>   10:	9c                   	pushfq 
>   11:	58                   	pop    %rax
>   12:	0f ba e0 09          	bt     $0x9,%eax
>   16:	73 05                	jae    0x1d
>   18:	e8 97 4a ff ff       	callq  0xffffffffffff4ab4
>   1d:	48 85 db             	test   %rbx,%rbx
>   20:	74 01                	je     0x23
>   22:	fb                   	sti    
>   23:	65 ff 0d d3 c8 17 7e 	decl   %gs:0x7e17c8d3(%rip)        # 0x7e17c8fd
>   2a:*	75 05                	jne    0x31		<-- trapping instruction
>   2c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   31:	5b                   	pop    %rbx
>   32:	41 5c                	pop    %r12
>   34:	5d                   	pop    %rbp
>   35:	c3                   	retq   
>   36:	f3 0f 1e fa          	endbr64 
>   3a:	55                   	push   %rbp
>   3b:	48 89 e5             	mov    %rsp,%rbp
>   3e:	53                   	push   %rbx
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	75 05                	jne    0x7
>    2:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    7:	5b                   	pop    %rbx
>    8:	41 5c                	pop    %r12
>    a:	5d                   	pop    %rbp
>    b:	c3                   	retq   
>    c:	f3 0f 1e fa          	endbr64 
>   10:	55                   	push   %rbp
>   11:	48 89 e5             	mov    %rsp,%rbp
>   14:	53                   	push   %rbx
>   15:	48                   	rex.W
> [ 1660.539448][    C0] RSP: 0000:ffff88810038fb20 EFLAGS: 00000246
> [ 1660.539448][    C0] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 000001829fdcdc01
> [ 1660.539448][    C0] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff82075cdb
> [ 1660.539448][    C0] RBP: ffff88810038fb30 R08: 000001829fdce0a9 R09: 00000000bf076f6e
> [ 1660.539448][    C0] R10: 0000000071314968 R11: 0000000068a51dbd R12: ffffffff837adc28
> [ 1660.539448][    C0] R13: ffff88810038fb78 R14: ffff88810038fc34 R15: 0000000000000004
> [ 1660.539448][ C0] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
> [ 1660.539448][ C0] crng_make_state (drivers/char/random.c:343) 
> [ 1660.539448][ C0] _get_random_bytes (drivers/char/random.c:386) 
> [ 1660.539448][ C0] get_random_u32 (drivers/char/random.c:532 (discriminator 13)) 
> [ 1660.539448][ C0] __get_random_u32_below (drivers/char/random.c:557) 
> [ 1660.539448][ C0] get_random_u32_below (include/linux/random.h:91) 
> [ 1660.539448][ C0] get_rcw_we (lib/reed_solomon/test_rslib.c:187 (discriminator 1)) 
> [ 1660.539448][ C0] ex_rs_helper (lib/reed_solomon/test_rslib.c:277 lib/reed_solomon/test_rslib.c:331) 
> [ 1660.539448][ C0] ? vprintk_emit (kernel/printk/printk.c:2312 (discriminator 3)) 
> [ 1660.539448][ C0] test_rslib_init (lib/reed_solomon/test_rslib.c:360 lib/reed_solomon/test_rslib.c:475 lib/reed_solomon/test_rslib.c:494) 
> [ 1660.539448][ C0] ? crc64_rocksoft_mod_init (lib/reed_solomon/test_rslib.c:488) 
> [ 1660.539448][ C0] do_one_initcall (init/main.c:1232) 
> [ 1660.539448][ C0] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1546) 
> [ 1660.539448][ C0] ? rest_init (init/main.c:1429) 
> [ 1660.539448][ C0] kernel_init (init/main.c:1439) 
> [ 1660.539448][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
> [ 1660.539448][    C0]  </TASK>
> [ 1660.539448][    C0] ================================================================================
> [ 1660.539448][    C0] spinlock_dump: End of queue.
> [ 1660.539448][    C0] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1660.539448][    C0] rcu: 	(detected by 0, t=105002 jiffies, g=47729, q=35 ncpus=2)
> [ 1660.539448][    C0] rcu: All QSes seen, last rcu_preempt kthread activity 105002 (4296327522-4296222520), jiffies_till_next_fqs=3, root ->qsmask 0x0
> [ 1660.539448][    C0] rcu: rcu_preempt kthread starved for 105002 jiffies! g47729 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [ 1660.539448][    C0] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> [ 1660.539448][    C0] rcu: RCU grace-period kthread stack dump:
> [ 1660.539448][    C0] task:rcu_preempt     state:R  running task     stack:14320 pid:12    ppid:2      flags:0x00004000
> [ 1660.539448][    C0] Call Trace:
> [ 1660.539448][    C0]  <TASK>
> [ 1660.539448][ C0] __schedule (kernel/sched/core.c:5381 kernel/sched/core.c:6710) 
> [ 1660.539448][ C0] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6787 (discriminator 1)) 
> [ 1660.539448][ C0] schedule_timeout (include/linux/timer.h:200 kernel/time/timer.c:2168) 
> [ 1660.539448][ C0] ? __next_timer_interrupt (kernel/time/timer.c:2091) 
> [ 1660.539448][ C0] rcu_gp_fqs_loop (kernel/rcu/tree.c:1613 (discriminator 13)) 
> [ 1660.539448][ C0] rcu_gp_kthread (kernel/rcu/tree.c:1815) 
> [ 1660.539448][ C0] ? rcu_gp_fqs_loop (kernel/rcu/tree.c:1787) 
> [ 1660.539448][ C0] kthread (kernel/kthread.c:391) 
> [ 1660.539448][ C0] ? kthread_complete_and_exit (kernel/kthread.c:342) 
> [ 1660.539448][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
> [ 1660.539448][    C0]  </TASK>
> [ 1660.539448][    C0] rcu: Stack dump where RCU GP kthread last ran:
> [ 1660.539448][    C0] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       TN 6.5.0-rc1-00129-g3d22d912bd03 #1
> [ 1660.539448][ C0] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
> [ 1660.539448][ C0] Code: 5e 12 ff 81 e3 00 02 00 00 74 05 e8 12 96 1a ff 9c 58 0f ba e0 09 73 05 e8 97 4a ff ff 48 85 db 74 01 fb 65 ff 0d d3 c8 17 7e <75> 05 0f 1f 44 00 00 5b 41 5c 5d c3 f3 0f 1e fa 55 48 89 e5 53 48
> All code
> ========
>    0:	5e                   	pop    %rsi
>    1:	12 ff                	adc    %bh,%bh
>    3:	81 e3 00 02 00 00    	and    $0x200,%ebx
>    9:	74 05                	je     0x10
>    b:	e8 12 96 1a ff       	callq  0xffffffffff1a9622
>   10:	9c                   	pushfq 
>   11:	58                   	pop    %rax
>   12:	0f ba e0 09          	bt     $0x9,%eax
>   16:	73 05                	jae    0x1d
>   18:	e8 97 4a ff ff       	callq  0xffffffffffff4ab4
>   1d:	48 85 db             	test   %rbx,%rbx
>   20:	74 01                	je     0x23
>   22:	fb                   	sti    
>   23:	65 ff 0d d3 c8 17 7e 	decl   %gs:0x7e17c8d3(%rip)        # 0x7e17c8fd
>   2a:*	75 05                	jne    0x31		<-- trapping instruction
>   2c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   31:	5b                   	pop    %rbx
>   32:	41 5c                	pop    %r12
>   34:	5d                   	pop    %rbp
>   35:	c3                   	retq   
>   36:	f3 0f 1e fa          	endbr64 
>   3a:	55                   	push   %rbp
>   3b:	48 89 e5             	mov    %rsp,%rbp
>   3e:	53                   	push   %rbx
>   3f:	48                   	rex.W
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	75 05                	jne    0x7
>    2:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    7:	5b                   	pop    %rbx
>    8:	41 5c                	pop    %r12
>    a:	5d                   	pop    %rbp
>    b:	c3                   	retq   
>    c:	f3 0f 1e fa          	endbr64 
>   10:	55                   	push   %rbp
>   11:	48 89 e5             	mov    %rsp,%rbp
>   14:	53                   	push   %rbx
>   15:	48                   	rex.W
> [ 1660.539448][    C0] RSP: 0000:ffff88810038fb20 EFLAGS: 00000246
> [ 1660.539448][    C0] RAX: 0000000000000002 RBX: 0000000000000200 RCX: 000001829fdcdc01
> [ 1660.539448][    C0] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffffffff82075cdb
> [ 1660.539448][    C0] RBP: ffff88810038fb30 R08: 000001829fdce0a9 R09: 00000000bf076f6e
> [ 1660.539448][    C0] R10: 0000000071314968 R11: 0000000068a51dbd R12: ffffffff837adc28
> [ 1660.539448][    C0] R13: ffff88810038fb78 R14: ffff88810038fc34 R15: 0000000000000004
> [ 1660.539448][    C0] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
> [ 1660.539448][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1660.539448][    C0] CR2: ffff88843ffff000 CR3: 000000000323b000 CR4: 00000000000406f0
> [ 1660.539448][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1660.539448][    C0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1660.539448][    C0] Call Trace:
> [ 1660.539448][    C0]  <IRQ>
> [ 1660.539448][ C0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
> [ 1660.539448][ C0] ? dump_cpu_task (kernel/sched/core.c:11472) 
> [ 1660.539448][ C0] ? rcu_check_gp_kthread_starvation (kernel/rcu/tree_stall.h:549) 
> [ 1660.539448][ C0] ? print_other_cpu_stall (kernel/rcu/tree_stall.h:652 (discriminator 3)) 
> [ 1660.539448][ C0] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:783 kernel/rcu/tree.c:3863 kernel/rcu/tree.c:2241) 
> [ 1660.539448][ C0] ? update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
> [ 1660.539448][ C0] ? tick_sched_handle+0x45/0x54 
> [ 1660.539448][ C0] ? tick_sched_timer (kernel/time/tick-sched.c:1492) 
> [ 1660.539448][ C0] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479) 
> [ 1660.539448][ C0] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1690 kernel/time/hrtimer.c:1752) 
> [ 1660.539448][ C0] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
> [ 1660.539448][ C0] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1116) 
> [ 1660.539448][ C0] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1109 (discriminator 14)) 
> [ 1660.539448][    C0]  </IRQ>
> [ 1660.539448][    C0]  <TASK>
> [ 1660.539448][ C0] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
> [ 1660.539448][ C0] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
> [ 1660.539448][ C0] ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
> [ 1660.539448][ C0] crng_make_state (drivers/char/random.c:343) 
> [ 1660.539448][ C0] _get_random_bytes (drivers/char/random.c:386) 
> [ 1660.539448][ C0] get_random_u32 (drivers/char/random.c:532 (discriminator 13)) 
> [ 1660.539448][ C0] __get_random_u32_below (drivers/char/random.c:557) 
> [ 1660.539448][ C0] get_random_u32_below (include/linux/random.h:91) 
> [ 1660.539448][ C0] get_rcw_we (lib/reed_solomon/test_rslib.c:187 (discriminator 1)) 
> [ 1660.539448][ C0] ex_rs_helper (lib/reed_solomon/test_rslib.c:277 lib/reed_solomon/test_rslib.c:331) 
> [ 1660.539448][ C0] ? vprintk_emit (kernel/printk/printk.c:2312 (discriminator 3)) 
> [ 1660.539448][ C0] test_rslib_init (lib/reed_solomon/test_rslib.c:360 lib/reed_solomon/test_rslib.c:475 lib/reed_solomon/test_rslib.c:494) 
> [ 1660.539448][ C0] ? crc64_rocksoft_mod_init (lib/reed_solomon/test_rslib.c:488) 
> [ 1660.539448][ C0] do_one_initcall (init/main.c:1232) 
> [ 1660.539448][ C0] kernel_init_freeable (init/main.c:1293 init/main.c:1310 init/main.c:1329 init/main.c:1546) 
> [ 1660.539448][ C0] ? rest_init (init/main.c:1429) 
> [ 1660.539448][ C0] kernel_init (init/main.c:1439) 
> [ 1660.539448][ C0] ret_from_fork (arch/x86/entry/entry_64.S:314) 
> [ 1660.539448][    C0]  </TASK>
> [ 1661.397796][    T1]   Testing with caller provided syndrome...
> [ 1673.580986][    T1]   Testing in-place interface...
> [ 1686.021233][    T1] Testing beyond error correction capacity...
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230908/202309081258.8d57032f-oliver.sang@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
