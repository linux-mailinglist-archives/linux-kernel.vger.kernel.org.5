Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5567CE222
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjJRQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjJRQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:05:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F396119;
        Wed, 18 Oct 2023 09:05:48 -0700 (PDT)
Date:   Wed, 18 Oct 2023 18:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697645147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kPS7vqJrG1zsSuDa3E+/tqTfqVm88dsw5sqsN2hPa+c=;
        b=u7hvKJibbZWTSU2ab2RFHMI0AWxCnR3x+BGbBNL/Tvy/ag7hfnnwaYnkS5ZQWlFJ40EKbH
        deQeatwVER7cACzUDn7+DxJwYssa/U1JZuzv0Dox+XUqgOTuSgTTiw72gg+8fFUOuuHN5J
        jTBThFtGk/hCDiGaSBSE4Mg4lPvwKHiQq3LGNTqbv0/8pbzKtwwwnrrQOQ8bW+DRXrYkuO
        7g0ef/LcNYd3gPmQNjvDV5seX+G5K2y0/3U3C89tqfjO/LhGZSm3QeGNaOEEpGiq1oWnLu
        KHXl0vfiANZgpdWnS9xaH8J8ST0kBY+WlRz0JfP91WTAFdcON0CoRCyruqRd6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697645147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=kPS7vqJrG1zsSuDa3E+/tqTfqVm88dsw5sqsN2hPa+c=;
        b=SwGfpFvpYq+5YljwKookIruD9CTBpfshurWsbwFteeapWapLuNGBDY3zjli5BGFSaWEtYO
        siWQElOFRsnVCQCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rc6-rt10
Message-ID: <20231018160545.RpXB8Ns_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rc6-rt10 patch set. 

Changes since v6.6-rc6-rt9:

  - A small update to the printk code. It addresses issues raised by the
    robot and adds a change to the atomic console driver to be closed to
    what we had before. Provided by John Ogness.

  - Replace PREEMPT_LAZY with PREEMPT_AUTO. PREEMPT_AUTO is an attempt
    to simplify various preemption models and making the kernel more
    preemtible. There is currently a discussion upstream.
    This requires CONFIG_GENERIC_ENTRY which restricts it to X86 while
    LAZY_PREEMPT was also supported by ARM* and PowerPC*.
    Patch by Thomas Gleixner.

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6-rc6-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rc6-rt9-rt10.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc6-rt10

The RT patch against v6.6-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc6-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc6-rt10.tar.xz

Sebastian

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45b3b77caf80e..ebd0dee6b1624 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -120,7 +120,6 @@ config ARM
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
-	select HAVE_PREEMPT_LAZY
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 17c259f187234..943ffcf069d29 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -63,7 +63,6 @@ struct cpu_context_save {
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int			preempt_count;	/* 0 => preemptable, <0 => bug */
-	int			preempt_lazy_count; /* 0 => preemptable, <0 => bug */
 	__u32			cpu;		/* cpu */
 	__u32			cpu_domain;	/* cpu domain */
 	struct cpu_context_save	cpu_context;	/* cpu context */
@@ -145,7 +144,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_UPROBE		3	/* breakpointed or singlestepping */
 #define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
-#define TIF_NEED_RESCHED_LAZY	5
 
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -165,7 +163,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 
 /* Checks for any syscall work in entry-common.S */
@@ -175,8 +172,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 /*
  * Change these and you break ASM code in entry-common.S
  */
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
-				 _TIF_SIGPENDING | \
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_NOTIFY_SIGNAL)
 
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index ae9d500ceee31..219cbc7e5d134 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -43,7 +43,6 @@ int main(void)
   BLANK();
   DEFINE(TI_FLAGS,		offsetof(struct thread_info, flags));
   DEFINE(TI_PREEMPT,		offsetof(struct thread_info, preempt_count));
-  DEFINE(TI_PREEMPT_LAZY,	offsetof(struct thread_info, preempt_lazy_count));
   DEFINE(TI_CPU,		offsetof(struct thread_info, cpu));
   DEFINE(TI_CPU_DOMAIN,		offsetof(struct thread_info, cpu_domain));
   DEFINE(TI_CPU_SAVE,		offsetof(struct thread_info, cpu_context));
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1a9c941af8c10..6150a716828c3 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -222,18 +222,11 @@ ENDPROC(__dabt_svc)
 
 #ifdef CONFIG_PREEMPTION
 	ldr	r8, [tsk, #TI_PREEMPT]		@ get preempt count
-	teq	r8, #0				@ if preempt count != 0
-	bne	1f				@ return from exeption
 	ldr	r0, [tsk, #TI_FLAGS]		@ get flags
-	tst	r0, #_TIF_NEED_RESCHED		@ if NEED_RESCHED is set
-	blne	svc_preempt			@ preempt!
-
-	ldr	r8, [tsk, #TI_PREEMPT_LAZY]	@ get preempt lazy count
-	teq	r8, #0				@ if preempt lazy count != 0
+	teq	r8, #0				@ if preempt count != 0
 	movne	r0, #0				@ force flags to 0
-	tst	r0, #_TIF_NEED_RESCHED_LAZY
+	tst	r0, #_TIF_NEED_RESCHED
 	blne	svc_preempt
-1:
 #endif
 
 	svc_exit r5, irq = 1			@ return from exception
@@ -248,14 +241,8 @@ ENDPROC(__irq_svc)
 1:	bl	preempt_schedule_irq		@ irq en/disable is done inside
 	ldr	r0, [tsk, #TI_FLAGS]		@ get new tasks TI_FLAGS
 	tst	r0, #_TIF_NEED_RESCHED
-	bne	1b
-	tst	r0, #_TIF_NEED_RESCHED_LAZY
 	reteq	r8				@ go again
-	ldr	r0, [tsk, #TI_PREEMPT_LAZY]	@ get preempt lazy count
-	teq	r0, #0				@ if preempt lazy count != 0
-	beq	1b
-	ret	r8				@ go again
-
+	b	1b
 #endif
 
 __und_fault:
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 056ab90df2eb9..79a6730fa0eb7 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -608,8 +608,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 	 */
 	trace_hardirqs_off();
 	do {
-		if (likely(thread_flags & (_TIF_NEED_RESCHED |
-					   _TIF_NEED_RESCHED_LAZY))) {
+		if (likely(thread_flags & _TIF_NEED_RESCHED)) {
 			schedule();
 		} else {
 			if (unlikely(!user_mode(regs)))
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 16e58fa99a16f..651229d99165a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -224,7 +224,6 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_PREEMPT_LAZY
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select MMU_GATHER_RCU_TABLE_FREE
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index a5486918e5eeb..0159b625cc7f0 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -71,36 +71,13 @@ static inline bool __preempt_count_dec_and_test(void)
 	 * interrupt occurring between the non-atomic READ_ONCE/WRITE_ONCE
 	 * pair.
 	 */
-	if (!pc || !READ_ONCE(ti->preempt_count))
-		return true;
-#ifdef CONFIG_PREEMPT_LAZY
-	if ((pc & ~PREEMPT_NEED_RESCHED))
-		return false;
-	if (current_thread_info()->preempt_lazy_count)
-		return false;
-	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-#else
-	return false;
-#endif
+	return !pc || !READ_ONCE(ti->preempt_count);
 }
 
 static inline bool should_resched(int preempt_offset)
 {
-#ifdef CONFIG_PREEMPT_LAZY
-	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
-	if (pc == preempt_offset)
-		return true;
-
-	if ((pc & ~PREEMPT_NEED_RESCHED) != preempt_offset)
-		return false;
-
-	if (current_thread_info()->preempt_lazy_count)
-		return false;
-	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-#else
 	u64 pc = READ_ONCE(current_thread_info()->preempt_count);
 	return pc == preempt_offset;
-#endif
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 14eb6fef29cff..553d1bc559c60 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -26,7 +26,6 @@ struct thread_info {
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	u64			ttbr0;		/* saved TTBR0_EL1 */
 #endif
-	int			preempt_lazy_count;	/* 0 => preemptable, <0 => bug */
 	union {
 		u64		preempt_count;	/* 0 => preemptible, <0 => bug */
 		struct {
@@ -65,7 +64,6 @@ void arch_setup_new_exec(void);
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
-#define TIF_NEED_RESCHED_LAZY	7
 #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
@@ -98,10 +96,8 @@ void arch_setup_new_exec(void);
 #define _TIF_SVE		(1 << TIF_SVE)
 #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | \
-				 _TIF_SIGPENDING | \
+#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
 				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
 				 _TIF_NOTIFY_SIGNAL)
@@ -110,8 +106,6 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_SYSCALL_EMU)
 
-#define _TIF_NEED_RESCHED_MASK	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
-
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 23f08c3f543b4..5ff1942b04fcf 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -33,7 +33,6 @@ int main(void)
   DEFINE(TSK_TI_CPU,		offsetof(struct task_struct, thread_info.cpu));
   DEFINE(TSK_TI_FLAGS,		offsetof(struct task_struct, thread_info.flags));
   DEFINE(TSK_TI_PREEMPT,	offsetof(struct task_struct, thread_info.preempt_count));
-  DEFINE(TSK_TI_PREEMPT_LAZY,	offsetof(struct task_struct, thread_info.preempt_lazy_count));
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
   DEFINE(TSK_TI_TTBR0,		offsetof(struct task_struct, thread_info.ttbr0));
 #endif
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 888acc049e581..0e8beb3349ea2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1281,7 +1281,7 @@ static void do_signal(struct pt_regs *regs)
 void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 {
 	do {
-		if (thread_flags & _TIF_NEED_RESCHED_MASK) {
+		if (thread_flags & _TIF_NEED_RESCHED) {
 			/* Unmask Debug and SError for the next task */
 			local_daif_restore(DAIF_PROCCTX_NOIRQ);
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c169f313ef1cb..a590b19191456 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -267,7 +267,6 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_PREEMPT_LAZY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK	if !KVM
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1ca7cc28b0bfb..bf5dde1a41147 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -54,8 +54,6 @@
 struct thread_info {
 	int		preempt_count;		/* 0 => preemptable,
 						   <0 => BUG */
-	int		preempt_lazy_count;	/* 0 => preemptable,
-						   <0 => BUG */
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
@@ -80,7 +78,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
-	.preempt_lazy_count = 0,		\
 	.flags =	0,			\
 }
 
@@ -106,7 +103,6 @@ void arch_setup_new_exec(void);
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
-#define TIF_NEED_RESCHED_LAZY	9	/* lazy rescheduling necessary */
 #define TIF_SECCOMP		10	/* secure computing */
 #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
 #define TIF_NOERROR		12	/* Force successful syscall return */
@@ -122,7 +118,6 @@ void arch_setup_new_exec(void);
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
 
-
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
@@ -134,7 +129,6 @@ void arch_setup_new_exec(void);
 #define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
@@ -148,12 +142,10 @@ void arch_setup_new_exec(void);
 				 _TIF_SYSCALL_EMU)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-				 _TIF_NEED_RESCHED_LAZY | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
 				 _TIF_NOTIFY_SIGNAL)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
-#define _TIF_NEED_RESCHED_MASK	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
 
 /* Bits in local_flags */
 /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 9f144588b3364..c4f6d3c69ba9d 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -184,7 +184,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
-		if (ti_flags & _TIF_NEED_RESCHED_MASK) {
+		if (ti_flags & _TIF_NEED_RESCHED) {
 			schedule();
 		} else {
 			/*
@@ -395,15 +395,11 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 		/* Returning to a kernel context with local irqs enabled. */
 		WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+		if (IS_ENABLED(CONFIG_PREEMPT)) {
 			/* Return to preemptible kernel context */
 			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
 					preempt_schedule_irq();
-			} else if (unlikely(current_thread_info()->flags & _TIF_NEED_RESCHED_LAZY)) {
-				if ((preempt_count() == 0) &&
-				    (current_thread_info()->preempt_lazy_count == 0))
-					preempt_schedule_irq();
 			}
 		}
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index afba6a6d688cd..203b51f183c7a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -259,7 +259,6 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_PREEMPT_LAZY
 	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
 	select MMU_GATHER_MERGE_VMAS
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
@@ -273,6 +272,7 @@ config X86
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
+	select HAVE_PREEMPT_AUTO
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 5b096893f6a21..2d13f25b1bd8f 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -90,49 +90,18 @@ static __always_inline void __preempt_count_sub(int val)
  * a decrement which hits zero means we have no preempt_count and should
  * reschedule.
  */
-static __always_inline bool ____preempt_count_dec_and_test(void)
+static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	return GEN_UNARY_RMWcc("decl", pcpu_hot.preempt_count, e,
 			       __percpu_arg([var]));
 }
 
-static __always_inline bool __preempt_count_dec_and_test(void)
-{
-	if (____preempt_count_dec_and_test())
-		return true;
-#ifdef CONFIG_PREEMPT_LAZY
-	if (preempt_count())
-		return false;
-	if (current_thread_info()->preempt_lazy_count)
-		return false;
-	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-#else
-	return false;
-#endif
-}
-
 /*
  * Returns true when we need to resched and can (barring IRQ state).
  */
 static __always_inline bool should_resched(int preempt_offset)
 {
-#ifdef CONFIG_PREEMPT_LAZY
-	u32 tmp;
-	tmp = raw_cpu_read_4(pcpu_hot.preempt_count);
-	if (tmp == preempt_offset)
-		return true;
-
-	/* preempt count == 0 ? */
-	tmp &= ~PREEMPT_NEED_RESCHED;
-	if (tmp != preempt_offset)
-		return false;
-	/* XXX PREEMPT_LOCK_OFFSET */
-	if (current_thread_info()->preempt_lazy_count)
-		return false;
-	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-#else
 	return unlikely(raw_cpu_read_4(pcpu_hot.preempt_count) == preempt_offset);
-#endif
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2de8ec3020ae1..1ff38ebbd5880 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -57,8 +57,6 @@ struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 	u32			status;		/* thread synchronous flags */
-	int			preempt_lazy_count;	/* 0 => lazy preemptable
-							  <0 => BUG */
 #ifdef CONFIG_SMP
 	u32			cpu;		/* current CPU */
 #endif
@@ -67,7 +65,6 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)			\
 {						\
 	.flags		= 0,			\
-	.preempt_lazy_count	= 0,		\
 }
 
 #else /* !__ASSEMBLY__ */
@@ -84,8 +81,9 @@ struct thread_info {
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
+#define TIF_ARCH_RESCHED_LAZY	4	/* Lazy rescheduling */
+#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
+#define TIF_SSBD		6	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -95,7 +93,6 @@ struct thread_info {
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
-#define TIF_NEED_RESCHED_LAZY	19	/* lazy rescheduling necessary */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
@@ -108,6 +105,7 @@ struct thread_info {
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_ARCH_RESCHED_LAZY	(1 << TIF_ARCH_RESCHED_LAZY)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
@@ -119,7 +117,6 @@ struct thread_info {
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 3a34a8c425fe4..1a69f082833ef 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -108,7 +108,7 @@ static const struct dmi_system_id processor_power_dmi_table[] = {
  */
 static void __cpuidle acpi_safe_halt(void)
 {
-	if (!tif_need_resched()) {
+	if (!need_resched()) {
 		raw_safe_halt();
 		raw_local_irq_disable();
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ed29d840070ee..8c5f8bb16bd39 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3498,10 +3498,6 @@ bool serial8250_console_write_atomic(struct uart_8250_port *up,
 	if (up->em485)
 		return false;
 
-	/* Atomic console does not support handling modem control. */
-	if (up->msr_saved_flags)
-		return false;
-
 	touch_nmi_watchdog();
 
 	if (!nbcon_enter_unsafe(wctxt))
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 3dc3704a3cdbb..8b3ab0cc1334d 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -57,16 +57,10 @@
 # define ARCH_EXIT_TO_USER_MODE_WORK		(0)
 #endif
 
-#ifdef CONFIG_PREEMPT_LAZY
-# define _TIF_NEED_RESCHED_MASK	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
-#else
-# define _TIF_NEED_RESCHED_MASK	(_TIF_NEED_RESCHED)
-#endif
-
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED_MASK | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
+	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb2..674a622c91be2 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -18,7 +18,7 @@
 
 #define XFER_TO_GUEST_MODE_WORK						\
 	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
-	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
+	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)
 
 struct kvm_vcpu;
 
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 3c56b6f38354d..2c4daa4033e76 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -197,20 +197,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_LAZY
-#define add_preempt_lazy_count(val)	do { preempt_lazy_count() += (val); } while (0)
-#define sub_preempt_lazy_count(val)	do { preempt_lazy_count() -= (val); } while (0)
-#define inc_preempt_lazy_count()	add_preempt_lazy_count(1)
-#define dec_preempt_lazy_count()	sub_preempt_lazy_count(1)
-#define preempt_lazy_count()		(current_thread_info()->preempt_lazy_count)
-#else
-#define add_preempt_lazy_count(val)	do { } while (0)
-#define sub_preempt_lazy_count(val)	do { } while (0)
-#define inc_preempt_lazy_count()	do { } while (0)
-#define dec_preempt_lazy_count()	do { } while (0)
-#define preempt_lazy_count()		(0)
-#endif
-
 #ifdef CONFIG_PREEMPT_COUNT
 
 #define preempt_disable() \
@@ -219,12 +205,6 @@ do { \
 	barrier(); \
 } while (0)
 
-#define preempt_lazy_disable() \
-do { \
-	inc_preempt_lazy_count(); \
-	barrier(); \
-} while (0)
-
 #define sched_preempt_enable_no_resched() \
 do { \
 	barrier(); \
@@ -262,18 +242,6 @@ do { \
 		__preempt_schedule(); \
 } while (0)
 
-/*
- * open code preempt_check_resched() because it is not exported to modules and
- * used by local_unlock() or bpf_enable_instrumentation().
- */
-#define preempt_lazy_enable() \
-do { \
-	dec_preempt_lazy_count(); \
-	barrier(); \
-	if (should_resched(0)) \
-		__preempt_schedule(); \
-} while (0)
-
 #else /* !CONFIG_PREEMPTION */
 #define preempt_enable() \
 do { \
@@ -281,12 +249,6 @@ do { \
 	preempt_count_dec(); \
 } while (0)
 
-#define preempt_lazy_enable() \
-do { \
-	dec_preempt_lazy_count(); \
-	barrier(); \
-} while (0)
-
 #define preempt_enable_notrace() \
 do { \
 	barrier(); \
@@ -327,9 +289,6 @@ do { \
 #define preempt_enable_notrace()		barrier()
 #define preemptible()				0
 
-#define preempt_lazy_disable()			barrier()
-#define preempt_lazy_enable()			barrier()
-
 #endif /* CONFIG_PREEMPT_COUNT */
 
 #ifdef MODULE
@@ -348,7 +307,7 @@ do { \
 } while (0)
 #define preempt_fold_need_resched() \
 do { \
-	if (tif_need_resched_now()) \
+	if (tif_need_resched()) \
 		set_preempt_need_resched(); \
 } while (0)
 
@@ -464,15 +423,8 @@ extern void migrate_enable(void);
 
 #else
 
-static inline void migrate_disable(void)
-{
-	preempt_lazy_disable();
-}
-
-static inline void migrate_enable(void)
-{
-	preempt_lazy_enable();
-}
+static inline void migrate_disable(void) { }
+static inline void migrate_enable(void) { }
 
 #endif /* CONFIG_SMP */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4d492433f86e7..c02fd12b49dc6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2050,17 +2050,17 @@ static inline void update_tsk_thread_flag(struct task_struct *tsk, int flag,
 	update_ti_thread_flag(task_thread_info(tsk), flag, value);
 }
 
-static inline int test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_set_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_set_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_and_clear_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_and_clear_ti_thread_flag(task_thread_info(tsk), flag);
 }
 
-static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
+static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
 {
 	return test_ti_thread_flag(task_thread_info(tsk), flag);
 }
@@ -2073,50 +2073,15 @@ static inline void set_tsk_need_resched(struct task_struct *tsk)
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
 	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
+	if (IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO))
+		clear_tsk_thread_flag(tsk, TIF_NEED_RESCHED_LAZY);
 }
 
-static inline int test_tsk_need_resched(struct task_struct *tsk)
+static inline bool test_tsk_need_resched(struct task_struct *tsk)
 {
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
-#ifdef CONFIG_PREEMPT_LAZY
-static inline void set_tsk_need_resched_lazy(struct task_struct *tsk)
-{
-	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED_LAZY);
-}
-
-static inline void clear_tsk_need_resched_lazy(struct task_struct *tsk)
-{
-	clear_tsk_thread_flag(tsk,TIF_NEED_RESCHED_LAZY);
-}
-
-static inline int test_tsk_need_resched_lazy(struct task_struct *tsk)
-{
-	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED_LAZY));
-}
-
-static inline int need_resched_lazy(void)
-{
-	return test_thread_flag(TIF_NEED_RESCHED_LAZY);
-}
-
-static inline int need_resched_now(void)
-{
-	return test_thread_flag(TIF_NEED_RESCHED);
-}
-
-#else
-static inline void clear_tsk_need_resched_lazy(struct task_struct *tsk) { }
-static inline int need_resched_lazy(void) { return 0; }
-
-static inline int need_resched_now(void)
-{
-	return test_thread_flag(TIF_NEED_RESCHED);
-}
-
-#endif
-
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
@@ -2293,7 +2258,7 @@ static inline int rwlock_needbreak(rwlock_t *lock)
 
 static __always_inline bool need_resched(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(tif_need_resched_lazy() || tif_need_resched());
 }
 
 /*
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e1..719416fe8ddc0 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -63,7 +63,7 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
@@ -76,7 +76,7 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 
 #else
@@ -85,11 +85,11 @@ static inline void __current_clr_polling(void) { }
 
 static inline bool __must_check current_set_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 static inline bool __must_check current_clr_polling_and_test(void)
 {
-	return unlikely(tif_need_resched());
+	return unlikely(need_resched());
 }
 #endif
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 00a01d50a3a9e..5ded1450ac1a1 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -59,6 +59,16 @@ enum syscall_work_bit {
 
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_PREEMPT_BUILD_AUTO
+# define TIF_NEED_RESCHED_LAZY		TIF_ARCH_RESCHED_LAZY
+# define _TIF_NEED_RESCHED_LAZY		_TIF_ARCH_RESCHED_LAZY
+# define TIF_NEED_RESCHED_LAZY_OFFSET	(TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
+#else
+# define TIF_NEED_RESCHED_LAZY		TIF_NEED_RESCHED
+# define _TIF_NEED_RESCHED_LAZY		_TIF_NEED_RESCHED
+# define TIF_NEED_RESCHED_LAZY_OFFSET	0
+#endif
+
 #ifdef __KERNEL__
 
 #ifndef arch_set_restart_data
@@ -178,26 +188,6 @@ static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti
 #endif /* !CONFIG_GENERIC_ENTRY */
 
 #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
-# ifdef CONFIG_PREEMPT_LAZY
-
-static __always_inline bool tif_need_resched(void)
-{
-	return read_thread_flags() & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY);
-}
-
-static __always_inline bool tif_need_resched_now(void)
-{
-	return arch_test_bit(TIF_NEED_RESCHED,
-			     (unsigned long *)(&current_thread_info()->flags));
-}
-
-static __always_inline bool tif_need_resched_lazy(void)
-{
-	return arch_test_bit(TIF_NEED_RESCHED_LAZY,
-			     (unsigned long *)(&current_thread_info()->flags));
-}
-
-# else /* !CONFIG_PREEMPT_LAZY */
 
 static __always_inline bool tif_need_resched(void)
 {
@@ -205,38 +195,14 @@ static __always_inline bool tif_need_resched(void)
 			     (unsigned long *)(&current_thread_info()->flags));
 }
 
-static __always_inline bool tif_need_resched_now(void)
-{
-	return tif_need_resched();
-}
-
 static __always_inline bool tif_need_resched_lazy(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) &&
+		arch_test_bit(TIF_NEED_RESCHED_LAZY,
+			      (unsigned long *)(&current_thread_info()->flags));
 }
 
-# endif /* CONFIG_PREEMPT_LAZY */
-#else /* !_ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
-# ifdef CONFIG_PREEMPT_LAZY
-
-static __always_inline bool tif_need_resched(void)
-{
-	return read_thread_flags() & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY);
-}
-
-static __always_inline bool tif_need_resched_now(void)
-{
-	return test_bit(TIF_NEED_RESCHED,
-			(unsigned long *)(&current_thread_info()->flags));
-}
-
-static __always_inline bool tif_need_resched_lazy(void)
-{
-	return test_bit(TIF_NEED_RESCHED_LAZY,
-			(unsigned long *)(&current_thread_info()->flags));
-}
-
-# else /* !CONFIG_PREEMPT_LAZY */
+#else
 
 static __always_inline bool tif_need_resched(void)
 {
@@ -244,17 +210,13 @@ static __always_inline bool tif_need_resched(void)
 			(unsigned long *)(&current_thread_info()->flags));
 }
 
-static __always_inline bool tif_need_resched_now(void)
-{
-	return tif_need_resched();
-}
-
 static __always_inline bool tif_need_resched_lazy(void)
 {
-	return false;
+	return IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) &&
+		test_bit(TIF_NEED_RESCHED_LAZY,
+			 (unsigned long *)(&current_thread_info()->flags));
 }
 
-# endif /* !CONFIG_PREEMPT_LAZY */
 #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 206625a2ce56c..b3e05de5e419e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -81,7 +81,6 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
-	unsigned char		preempt_lazy_count;
 };
 
 #define TRACE_EVENT_TYPE_MAX						\
@@ -170,27 +169,20 @@ static inline void tracing_generic_entry_update(struct trace_entry *entry,
 						unsigned int trace_ctx)
 {
 	entry->preempt_count		= trace_ctx & 0xff;
-	entry->preempt_lazy_count	= (trace_ctx >> 16) & 0xff;
 	entry->pid			= current->pid;
 	entry->type			= type;
-	entry->flags			= trace_ctx >> 24;
+	entry->flags =			trace_ctx >> 16;
 }
 
 unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
 
 enum trace_flag_type {
 	TRACE_FLAG_IRQS_OFF		= 0x01,
-	TRACE_FLAG_IRQS_NOSUPPORT	= 0x02,
-	TRACE_FLAG_NEED_RESCHED		= 0x04,
+	TRACE_FLAG_NEED_RESCHED		= 0x02,
+	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
 	TRACE_FLAG_HARDIRQ		= 0x08,
 	TRACE_FLAG_SOFTIRQ		= 0x10,
-#ifdef CONFIG_PREEMPT_LAZY
-	TRACE_FLAG_PREEMPT_RESCHED	= 0x00,
-	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x20,
-#else
-	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x00,
 	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
-#endif
 	TRACE_FLAG_NMI			= 0x40,
 	TRACE_FLAG_BH_OFF		= 0x80,
 };
@@ -213,11 +205,11 @@ static inline unsigned int tracing_gen_ctx(void)
 
 static inline unsigned int tracing_gen_ctx_flags(unsigned long irqflags)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 static inline unsigned int tracing_gen_ctx(void)
 {
-	return tracing_gen_ctx_irq_test(TRACE_FLAG_IRQS_NOSUPPORT);
+	return tracing_gen_ctx_irq_test(0);
 }
 #endif
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 260c08efeb486..0f3d4c2a41cb7 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -1,11 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config HAVE_PREEMPT_LAZY
-	bool
-
-config PREEMPT_LAZY
-	def_bool y if HAVE_PREEMPT_LAZY && PREEMPT_RT
-
 config PREEMPT_NONE_BUILD
 	bool
 
@@ -17,6 +11,13 @@ config PREEMPT_BUILD
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
 
+config PREEMPT_BUILD_AUTO
+	bool
+	select PREEMPT_BUILD
+
+config HAVE_PREEMPT_AUTO
+	bool
+
 choice
 	prompt "Preemption Model"
 	default PREEMPT_NONE
@@ -73,9 +74,17 @@ config PREEMPT
 	  embedded system with latency requirements in the milliseconds
 	  range.
 
+config PREEMPT_AUTO
+	bool "Automagic preemption mode with runtime tweaking support"
+	depends on HAVE_PREEMPT_AUTO
+	select PREEMPT_BUILD_AUTO
+	help
+	  Add some sensible blurb here
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
+	select PREEMPT_BUILD_AUTO if HAVE_PREEMPT_AUTO
 	select PREEMPTION
 	help
 	  This option turns the kernel into a real-time kernel by replacing
@@ -101,7 +110,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT && !PREEMPT_AUTO
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index b9f08f6d364cd..c1f706038637c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -155,7 +155,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED_MASK)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
@@ -385,7 +385,7 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (should_resched(0))
+		if (test_tsk_need_resched(current))
 			preempt_schedule_irq();
 	}
 }
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd1..d952fa5ee8801 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -13,7 +13,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 			return -EINTR;
 		}
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 81ecec963423b..8f2b52996568c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }
@@ -459,7 +461,7 @@ static int __read_mostly suppress_panic_printk;
 
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
-DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
+static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
 
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9c755e73233f..21b50e61d0014 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -898,14 +898,15 @@ static inline void hrtick_rq_init(struct rq *rq)
 
 #if defined(CONFIG_SMP) && defined(TIF_POLLING_NRFLAG)
 /*
- * Atomically set TIF_NEED_RESCHED and test for TIF_POLLING_NRFLAG,
+ * Atomically set TIF_NEED_RESCHED[_LAZY] and test for TIF_POLLING_NRFLAG,
  * this avoids any races wrt polling state changes and thereby avoids
  * spurious IPIs.
  */
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, int tif_bit)
 {
 	struct thread_info *ti = task_thread_info(p);
-	return !(fetch_or(&ti->flags, _TIF_NEED_RESCHED) & _TIF_POLLING_NRFLAG);
+
+	return !(fetch_or(&ti->flags, 1 << tif_bit) & _TIF_POLLING_NRFLAG);
 }
 
 /*
@@ -922,7 +923,7 @@ static bool set_nr_if_polling(struct task_struct *p)
 	for (;;) {
 		if (!(val & _TIF_POLLING_NRFLAG))
 			return false;
-		if (val & _TIF_NEED_RESCHED)
+		if (val & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			return true;
 		if (try_cmpxchg(&ti->flags, &val, val | _TIF_NEED_RESCHED))
 			break;
@@ -931,9 +932,9 @@ static bool set_nr_if_polling(struct task_struct *p)
 }
 
 #else
-static inline bool set_nr_and_not_polling(struct task_struct *p)
+static inline bool set_nr_and_not_polling(struct task_struct *p, int tif_bit)
 {
-	set_tsk_need_resched(p);
+	set_tsk_thread_flag(p, tif_bit);
 	return true;
 }
 
@@ -1038,69 +1039,48 @@ void wake_up_q(struct wake_q_head *head)
  * might also involve a cross-CPU call to trigger the scheduler on
  * the target CPU.
  */
-void resched_curr(struct rq *rq)
+static void __resched_curr(struct rq *rq, int lazy)
 {
+	int cpu, tif_bit = TIF_NEED_RESCHED + lazy;
 	struct task_struct *curr = rq->curr;
-	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
-	if (test_tsk_need_resched(curr))
+	if (unlikely(test_tsk_thread_flag(curr, tif_bit)))
 		return;
 
 	cpu = cpu_of(rq);
 
 	if (cpu == smp_processor_id()) {
-		set_tsk_need_resched(curr);
-		set_preempt_need_resched();
+		set_tsk_thread_flag(curr, tif_bit);
+		if (!lazy)
+			set_preempt_need_resched();
 		return;
 	}
 
-	if (set_nr_and_not_polling(curr))
-		smp_send_reschedule(cpu);
-	else
+	if (set_nr_and_not_polling(curr, tif_bit)) {
+		if (!lazy)
+			smp_send_reschedule(cpu);
+	} else {
 		trace_sched_wake_idle_without_ipi(cpu);
+	}
 }
 
-#ifdef CONFIG_PREEMPT_LAZY
-
-static int tsk_is_polling(struct task_struct *p)
+void resched_curr(struct rq *rq)
 {
-#ifdef TIF_POLLING_NRFLAG
-	return test_tsk_thread_flag(p, TIF_POLLING_NRFLAG);
-#else
-	return 0;
-#endif
+	__resched_curr(rq, 0);
 }
 
 void resched_curr_lazy(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	int cpu;
+	int lazy = IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) && !sched_feat(FORCE_NEED_RESCHED) ?
+		TIF_NEED_RESCHED_LAZY_OFFSET : 0;
 
-	if (!sched_feat(PREEMPT_LAZY)) {
-		resched_curr(rq);
-		return;
-	}
-
-	if (test_tsk_need_resched(curr))
+	if (lazy && unlikely(test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED)))
 		return;
 
-	if (test_tsk_need_resched_lazy(curr))
-		return;
-
-	set_tsk_need_resched_lazy(curr);
-
-	cpu = cpu_of(rq);
-	if (cpu == smp_processor_id())
-		return;
-
-	/* NEED_RESCHED_LAZY must be visible before we test polling */
-	smp_mb();
-	if (!tsk_is_polling(curr))
-		smp_send_reschedule(cpu);
+	__resched_curr(rq, lazy);
 }
-#endif
 
 void resched_cpu(int cpu)
 {
@@ -1172,7 +1152,7 @@ static void wake_up_idle_cpu(int cpu)
 	if (cpu == smp_processor_id())
 		return;
 
-	if (set_nr_and_not_polling(rq->idle))
+	if (set_nr_and_not_polling(rq->idle, TIF_NEED_RESCHED))
 		smp_send_reschedule(cpu);
 	else
 		trace_sched_wake_idle_without_ipi(cpu);
@@ -2460,7 +2440,6 @@ void migrate_disable(void)
 	preempt_disable();
 	this_rq()->nr_pinned++;
 	p->migration_disabled = 1;
-	preempt_lazy_disable();
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
@@ -2496,7 +2475,6 @@ void migrate_enable(void)
 	barrier();
 	p->migration_disabled = 0;
 	this_rq()->nr_pinned--;
-	preempt_lazy_enable();
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
@@ -4823,9 +4801,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->on_cpu = 0;
 #endif
 	init_task_preempt_count(p);
-#ifdef CONFIG_HAVE_PREEMPT_LAZY
-	task_thread_info(p)->preempt_lazy_count = 0;
-#endif
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
@@ -6703,7 +6678,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	next = pick_next_task(rq, prev, &rf);
 	clear_tsk_need_resched(prev);
-	clear_tsk_need_resched_lazy(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
@@ -6930,30 +6904,6 @@ static void __sched notrace preempt_schedule_common(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_PREEMPT_LAZY
-/*
- * If TIF_NEED_RESCHED is then we allow to be scheduled away since this is
- * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
- * preempt_lazy_count counter >0.
- */
-static __always_inline int preemptible_lazy(void)
-{
-	if (test_thread_flag(TIF_NEED_RESCHED))
-		return 1;
-	if (current_thread_info()->preempt_lazy_count)
-		return 0;
-	return 1;
-}
-
-#else
-
-static inline int preemptible_lazy(void)
-{
-	return 1;
-}
-
-#endif
-
 #ifdef CONFIG_PREEMPTION
 /*
  * This is the entry point to schedule() from in-kernel preemption
@@ -6967,8 +6917,6 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
-	if (!preemptible_lazy())
-		return;
 	preempt_schedule_common();
 }
 NOKPROBE_SYMBOL(preempt_schedule);
@@ -7016,9 +6964,6 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 	if (likely(!preemptible()))
 		return;
 
-	if (!preemptible_lazy())
-		return;
-
 	do {
 		/*
 		 * Because the function tracer can trace preempt_count_sub()
@@ -8985,7 +8930,6 @@ static void __init preempt_dynamic_init(void)
 		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
 		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
 	}									 \
-	EXPORT_SYMBOL_GPL(preempt_model_##mode)
 
 PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
@@ -9434,9 +9378,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 
 	/* Set the preempt count _outside_ the spinlocks! */
 	init_idle_preempt_count(idle, cpu);
-#ifdef CONFIG_HAVE_PREEMPT_LAZY
-	task_thread_info(idle)->preempt_lazy_count = 0;
-#endif
+
 	/*
 	 * The idle tasks have their own, simple scheduling class:
 	 */
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4c3d0d9f3db63..63e19b89c8c32 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,6 +333,23 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
+static ssize_t sched_hog_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	unsigned long end = jiffies + 60 * HZ;
+
+	for (; time_before(jiffies, end) && !signal_pending(current);)
+		cpu_relax();
+
+	return cnt;
+}
+
+static const struct file_operations sched_hog_fops = {
+	.write		= sched_hog_write,
+	.open		= simple_open,
+	.llseek		= default_llseek,
+};
+
 static struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
@@ -374,6 +391,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_create_file("hog", 0200, debugfs_sched, NULL, &sched_hog_fops);
+
 	return 0;
 }
 late_initcall(sched_init_debug);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 205346fdfa3d3..386a8b0d946ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1016,8 +1016,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se, bool tick)
 {
+	struct rq *rq = rq_of(cfs_rq);
+
 	if ((s64)(se->vruntime - se->deadline) < 0)
 		return;
 
@@ -1036,10 +1038,19 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	/*
 	 * The task has consumed its request, reschedule.
 	 */
-	if (cfs_rq->nr_running > 1) {
-		resched_curr_lazy(rq_of(cfs_rq));
-		clear_buddies(cfs_rq, se);
+	if (cfs_rq->nr_running < 2)
+		return;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_BUILD_AUTO) || sched_feat(FORCE_NEED_RESCHED)) {
+		resched_curr(rq);
+	} else {
+		/* Did the task ignore the lazy reschedule request? */
+		if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
+			resched_curr(rq);
+		else
+			resched_curr_lazy(rq);
 	}
+	clear_buddies(cfs_rq, se);
 }
 
 #include "pelt.h"
@@ -1147,7 +1158,7 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 /*
  * Update the current task's runtime statistics.
  */
-static void update_curr(struct cfs_rq *cfs_rq)
+static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
@@ -1174,7 +1185,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	update_deadline(cfs_rq, curr, tick);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -1188,6 +1199,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
+static inline void update_curr(struct cfs_rq *cfs_rq)
+{
+	__update_curr(cfs_rq, false);
+}
+
 static void update_curr_fair(struct rq *rq)
 {
 	update_curr(cfs_rq_of(&rq->curr->se));
@@ -5308,7 +5324,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	update_curr(cfs_rq);
+	__update_curr(cfs_rq, true);
 
 	/*
 	 * Ensure that runnable average is periodically updated.
@@ -5728,7 +5744,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
-		resched_curr(rq);
+		resched_curr_lazy(rq);
 }
 
 #ifdef CONFIG_SMP
@@ -8086,7 +8102,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (need_resched())
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
@@ -12279,7 +12295,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 */
 	if (rq->core->core_forceidle_count && rq->cfs.nr_running == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
-		resched_curr(rq);
+		resched_curr_lazy(rq);
 }
 
 /*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 2c0ffe158193f..dd8b35f67fedb 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -37,9 +37,6 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
 
 #ifdef CONFIG_PREEMPT_RT
 SCHED_FEAT(TTWU_QUEUE, false)
-# ifdef CONFIG_PREEMPT_LAZY
-SCHED_FEAT(PREEMPT_LAZY, true)
-# endif
 #else
 
 /*
@@ -92,3 +89,5 @@ SCHED_FEAT(UTIL_EST_FASTUP, true)
 SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(HZ_BW, true)
+
+SCHED_FEAT(FORCE_NEED_RESCHED, false)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5007b25c5bc65..95e1b3df14000 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -57,8 +57,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_cpuidle_enter();
 
 	raw_local_irq_enable();
-	while (!tif_need_resched() &&
-	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
+	while (!need_resched() && (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 	raw_local_irq_disable();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e9cf4da914d4d..c4307934af6bc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2435,16 +2435,8 @@ extern void init_sched_fair_class(void);
 extern void reweight_task(struct task_struct *p, int prio);
 
 extern void resched_curr(struct rq *rq);
-extern void resched_cpu(int cpu);
-
-#ifdef CONFIG_PREEMPT_LAZY
 extern void resched_curr_lazy(struct rq *rq);
-#else
-static inline void resched_curr_lazy(struct rq *rq)
-{
-	resched_curr(rq);
-}
-#endif
+extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
 extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f00ad98e4601a..fc8b82b880d04 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2720,19 +2720,13 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
 	if (softirq_count() >> (SOFTIRQ_SHIFT + 1))
 		trace_flags |= TRACE_FLAG_BH_OFF;
 
-	if (tif_need_resched_now())
+	if (tif_need_resched())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED;
-#ifdef CONFIG_PREEMPT_LAZY
-	/* Run out of bits. Share the LAZY and PREEMPT_RESCHED */
-	if (need_resched_lazy())
+	if (tif_need_resched_lazy())
 		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
-#else
 	if (test_preempt_need_resched())
 		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
-#endif
-
-	return (trace_flags << 24) | (min_t(unsigned int, pc & 0xff, 0xf)) |
-		(preempt_lazy_count() & 0xff) << 16 |
+	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
 		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
 }
 
@@ -4325,17 +4319,15 @@ unsigned long trace_total_entries(struct trace_array *tr)
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                    _--------=> CPU#            \n"
-		    "#                   / _-------=> irqs-off/BH-disabled\n"
-		    "#                  | / _------=> need-resched    \n"
-		    "#                  || / _-----=> need-resched-lazy\n"
-		    "#                  ||| / _----=> hardirq/softirq \n"
-		    "#                  |||| / _---=> preempt-depth   \n"
-		    "#                  ||||| / _--=> preempt-lazy-depth\n"
-		    "#                  |||||| / _-=> migrate-disable \n"
-		    "#                  ||||||| /     delay           \n"
-		    "#  cmd     pid     |||||||| time  |   caller     \n"
-		    "#     \\   /        ||||||||  \\    |    /       \n");
+	seq_puts(m, "#                    _------=> CPU#            \n"
+		    "#                   / _-----=> irqs-off/BH-disabled\n"
+		    "#                  | / _----=> need-resched    \n"
+		    "#                  || / _---=> hardirq/softirq \n"
+		    "#                  ||| / _--=> preempt-depth   \n"
+		    "#                  |||| / _-=> migrate-disable \n"
+		    "#                  ||||| /     delay           \n"
+		    "#  cmd     pid     |||||| time  |   caller     \n"
+		    "#     \\   /        ||||||  \\    |    /       \n");
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -4369,16 +4361,14 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                            %.*s  _-------=> irqs-off/BH-disabled\n", prec, space);
-	seq_printf(m, "#                            %.*s / _------=> need-resched\n", prec, space);
-	seq_printf(m, "#                            %.*s| / _-----=> need-resched-lazy\n", prec, space);
-	seq_printf(m, "#                            %.*s|| / _----=> hardirq/softirq\n", prec, space);
-	seq_printf(m, "#                            %.*s||| / _---=> preempt-depth\n", prec, space);
-	seq_printf(m, "#                            %.*s|||| / _--=> preempt-lazy-depth\n", prec, space);
-	seq_printf(m, "#                            %.*s||||| / _-=> migrate-disable\n", prec, space);
-	seq_printf(m, "#                            %.*s|||||| /     delay\n", prec, space);
-	seq_printf(m, "#           TASK-PID  %.*s CPU#  |||||||  TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
-	seq_printf(m, "#              | |    %.*s   |   |||||||      |         |\n", prec, "       |    ");
+	seq_printf(m, "#                            %.*s  _-----=> irqs-off/BH-disabled\n", prec, space);
+	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
+	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
+	seq_printf(m, "#                            %.*s||| / _-=> migrate-disable\n", prec, space);
+	seq_printf(m, "#                            %.*s|||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  |||||  TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   |||||     |         |\n", prec, "       |    ");
 }
 
 void
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4999ddf7da52b..f49d6ddb63425 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -210,7 +210,6 @@ static int trace_define_common_fields(void)
 	/* Holds both preempt_count and migrate_disable */
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
-	__common_field(unsigned char, preempt_lazy_count);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 6e1b552fd9b94..c251a44ad8ac2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -445,7 +445,6 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 {
 	char hardsoft_irq;
 	char need_resched;
-	char need_resched_lazy;
 	char irqs_off;
 	int hardirq;
 	int softirq;
@@ -461,32 +460,37 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		(entry->flags & TRACE_FLAG_IRQS_OFF && bh_off) ? 'D' :
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
 		bh_off ? 'b' :
-		(entry->flags & TRACE_FLAG_IRQS_NOSUPPORT) ? 'X' :
+		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
 		'.';
 
-	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
+	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
 				TRACE_FLAG_PREEMPT_RESCHED)) {
-#ifndef CONFIG_PREEMPT_LAZY
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'B';
+		break;
 	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'N';
 		break;
-#endif
+	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
+		need_resched = 'L';
+		break;
+	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'b';
+		break;
 	case TRACE_FLAG_NEED_RESCHED:
 		need_resched = 'n';
 		break;
-#ifndef CONFIG_PREEMPT_LAZY
+	case TRACE_FLAG_NEED_RESCHED_LAZY:
+		need_resched = 'l';
+		break;
 	case TRACE_FLAG_PREEMPT_RESCHED:
 		need_resched = 'p';
 		break;
-#endif
 	default:
 		need_resched = '.';
 		break;
 	}
 
-	need_resched_lazy =
-		(entry->flags & TRACE_FLAG_NEED_RESCHED_LAZY) ? 'L' : '.';
-
 	hardsoft_irq =
 		(nmi && hardirq)     ? 'Z' :
 		nmi                  ? 'z' :
@@ -495,20 +499,14 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 		softirq              ? 's' :
 		                       '.' ;
 
-	trace_seq_printf(s, "%c%c%c%c",
-			 irqs_off, need_resched, need_resched_lazy,
-			 hardsoft_irq);
+	trace_seq_printf(s, "%c%c%c",
+			 irqs_off, need_resched, hardsoft_irq);
 
 	if (entry->preempt_count & 0xf)
 		trace_seq_printf(s, "%x", entry->preempt_count & 0xf);
 	else
 		trace_seq_putc(s, '.');
 
-	if (entry->preempt_lazy_count)
-		trace_seq_printf(s, "%x", entry->preempt_lazy_count);
-	else
-		trace_seq_putc(s, '.');
-
 	if (entry->preempt_count & 0xf0)
 		trace_seq_printf(s, "%x", entry->preempt_count >> 4);
 	else
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
