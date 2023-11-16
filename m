Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991C87EE3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345400AbjKPPNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjKPPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:13:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE56AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=97NVbJFHkGzfRJugC8tYjlWGr5M7YSVKky+4rAvCyfs=; b=jmsombTn7jlcHy0jFBpVavRj/f
        KbpD7jfBBayLrFPjwp5vRgw+lbrAabIepuxRGOYftqoLPVqUKc9UhqpaGVPVNDHz5o1GspMpwNXMc
        DKFPaV0XTnhpmnC5agJ3lNl4gRBLMNDiuOb8FcpF6oIf0DAm8muhLk6ovj7Zc/v5dTYqMZp25Xvf0
        etf4erWjE0fHSfUQq/gvtjzHIhQKiebtu+PKHAt1oBFSPapzSxfWdh7zY2CuPL2HTNg7gesbgr11m
        U5MmUfXF9Jr5c02+XRFPpyP1yoAVXxFki5HHtUcIfucBMSB4HaQJL0uBIAPhesg5jSG1KxgmJ6I3a
        IFmz7IBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3e3Q-003ghZ-Rz; Thu, 16 Nov 2023 15:13:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 861A83002BE; Thu, 16 Nov 2023 16:13:16 +0100 (CET)
Date:   Thu, 16 Nov 2023 16:13:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] x86: Remove __current_clr_polling() from mwait_idle()
Message-ID: <20231116151316.GH8262@noisy.programming.kicks-ass.net>
References: <20231115151325.6262-1-frederic@kernel.org>
 <20231115151325.6262-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115151325.6262-4-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:13:24AM -0500, Frederic Weisbecker wrote:
> mwait_idle() is only ever called through by cpuidle, either from
> default_idle_call() or from cpuidle_enter(). In any case
> cpuidle_idle_call() sets again TIF_NR_POLLING after calling it so there
> is no point for this atomic operation upon idle exit.
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/kernel/process.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index b6f4e8399fca..fc7a38084606 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -930,7 +930,6 @@ static __cpuidle void mwait_idle(void)
>  			raw_local_irq_disable();
>  		}
>  	}
> -	__current_clr_polling();
>  }
>  
>  void select_idle_routine(const struct cpuinfo_x86 *c)


Urgh at this and the next one... That is, yes we can do this, but it
makes these function asymmetric and doesn't actually solve the
underlying problem that all of the polling stuff is inside-out.

Idle loop sets polling, then clears polling because it assumes all
arch/driver idle loops are non-polling, then individual drivers re-set
polling, and to be symmetric (above) clear it again, for the generic
code to set it again, only to clear it again when leaving idle.

Follow that? ;-)

Anyway, drivers ought to tell up-front if they're polling and then we
can avoid the whole dance and everything is better.

Something like the very crude below.

---
 arch/x86/include/asm/mwait.h  |  3 +--
 arch/x86/kernel/process.c     |  3 +--
 drivers/acpi/processor_idle.c |  2 +-
 drivers/idle/intel_idle.c     |  3 +++
 include/linux/cpuidle.h       |  6 ++++++
 include/linux/sched/idle.h    |  7 ++++++-
 kernel/sched/idle.c           | 22 +++++++++++++++++-----
 7 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 778df05f8539..c0c60fde7a4d 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -107,7 +107,7 @@ static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
  */
 static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned long ecx)
 {
-	if (static_cpu_has_bug(X86_BUG_MONITOR) || !current_set_polling_and_test()) {
+	if (static_cpu_has_bug(X86_BUG_MONITOR) || !need_resched()) {
 		if (static_cpu_has_bug(X86_BUG_CLFLUSH_MONITOR)) {
 			mb();
 			clflush((void *)&current_thread_info()->flags);
@@ -118,7 +118,6 @@ static __always_inline void mwait_idle_with_hints(unsigned long eax, unsigned lo
 		if (!need_resched())
 			__mwait(eax, ecx);
 	}
-	current_clr_polling();
 }
 
 /*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b6f4e8399fca..73baa82584c2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -917,7 +917,7 @@ static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
  */
 static __cpuidle void mwait_idle(void)
 {
-	if (!current_set_polling_and_test()) {
+	if (!need_resched()) {
 		if (this_cpu_has(X86_BUG_CLFLUSH_MONITOR)) {
 			mb(); /* quirk */
 			clflush((void *)&current_thread_info()->flags);
@@ -930,7 +930,6 @@ static __cpuidle void mwait_idle(void)
 			raw_local_irq_disable();
 		}
 	}
-	__current_clr_polling();
 }
 
 void select_idle_routine(const struct cpuinfo_x86 *c)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 3a34a8c425fe..58765557b1b8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1219,7 +1219,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
 		state->target_residency = lpi->min_residency;
 		state->flags |= arch_get_idle_state_flags(lpi->arch_flags);
 		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
-			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
+			state->flags |= CPUIDLE_FLAG_RCU_IDLE | CPUIDLE_FLAG_NO_IPI;
 		state->enter = acpi_idle_lpi_enter;
 		drv->safe_state_index = i;
 	}
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index dcda0afecfc5..496b6a309f4f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1569,6 +1569,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 			state->target_residency *= 3;
 
 		state->flags = MWAIT2flg(cx->address);
+		state->flags |= CPUIDLE_FLAG_NO_IPI;
 		if (cx->type > ACPI_STATE_C2)
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 
@@ -1841,6 +1842,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 
 static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 {
+	state->flags |= CPUIDLE_FLAG_NO_IPI;
+
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
 		/*
 		 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3183aeb7f5b4..623d88bd7658 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -85,6 +85,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
 #define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
 #define CPUIDLE_FLAG_RCU_IDLE		BIT(6) /* idle-state takes care of RCU */
+#define CPUIDLE_FLAG_NO_IPI		BIT(7) /* has TIF_POLLING_NRFLAG */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
@@ -168,6 +169,11 @@ struct cpuidle_driver {
 };
 
 #ifdef CONFIG_CPU_IDLE
+bool cpuidle_state_needs_ipi(struct cpuidle_driver *drv, int state)
+{
+	return !(drv->states[state].flags & CPUIDLE_FLAG_NO_IPI);
+}
+
 extern void disable_cpuidle(void);
 extern bool cpuidle_not_available(struct cpuidle_driver *drv,
 				  struct cpuidle_device *dev);
diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 478084f9105e..24b29bb5d43b 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -68,6 +68,8 @@ static __always_inline bool __must_check current_set_polling_and_test(void)
 
 static __always_inline bool __must_check current_clr_polling_and_test(void)
 {
+	bool ret;
+
 	__current_clr_polling();
 
 	/*
@@ -76,7 +78,10 @@ static __always_inline bool __must_check current_clr_polling_and_test(void)
 	 */
 	smp_mb__after_atomic();
 
-	return unlikely(tif_need_resched());
+	bool ret = unlikely(tif_need_resched());
+	if (ret)
+		__current_set_polling();
+	return ret;
 }
 
 #else
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 565f8374ddbb..65e2474cb82b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -94,11 +94,12 @@ void __cpuidle default_idle_call(void)
 		stop_critical_timings();
 
 		ct_cpuidle_enter();
-		arch_cpu_idle();
+		arch_cpu_idle(); // XXX assumes !polling
 		ct_cpuidle_exit();
 
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+		__current_set_polling();
 	}
 	local_irq_enable();
 	instrumentation_end();
@@ -107,20 +108,27 @@ void __cpuidle default_idle_call(void)
 static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
 			       struct cpuidle_device *dev)
 {
+	int ret;
+
 	if (current_clr_polling_and_test())
 		return -EBUSY;
 
-	return cpuidle_enter_s2idle(drv, dev);
+	ret = cpuidle_enter_s2idle(drv, dev);
+	__current_set_polling();
+	return ret;
 }
 
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		      int next_state)
 {
+	bool need_ipi = cpuidle_state_needs_ipi(drv, next_state);
+	int ret;
+
 	/*
 	 * The idle task must be scheduled, it is pointless to go to idle, just
 	 * update no idle residency and return.
 	 */
-	if (current_clr_polling_and_test()) {
+	if (needs_ipi && current_clr_polling_and_test()) {
 		dev->last_residency_ns = 0;
 		local_irq_enable();
 		return -EBUSY;
@@ -131,7 +139,12 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * This function will block until an interrupt occurs and will take
 	 * care of re-enabling the local interrupts
 	 */
-	return cpuidle_enter(drv, dev, next_state);
+	ret = cpuidle_enter(drv, dev, next_state);
+
+	if (needs_ipi)
+		__current_set_polling();
+
+	return ret;
 }
 
 /**
@@ -220,7 +233,6 @@ static void cpuidle_idle_call(void)
 	}
 
 exit_idle:
-	__current_set_polling();
 
 	/*
 	 * It is up to the idle functions to reenable local interrupts
