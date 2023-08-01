Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC276B261
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjHAKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjHAKv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:51:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7082D7E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:49:17 -0700 (PDT)
Message-ID: <20230801103818.323365244@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MV6Y606SVssEQVKgDvP1PL7mW4j5AtallYXi4hZ7gRY=;
        b=DJ8JAggRX/Hvv8LNjmaZdpahjhMu7DzUBhptK0aCQziOudl8cXcyjNoRy4LHeo5mOpDMq/
        9Cy60YdqgnLS4/h+fepsQt53U0xe4PmiXW4OhbMA3gjJ5lNa/BQZM+2kUalUb0y/dItN8i
        CMZ8SJLa+gPE2f4rSoGtHK+Fsj9XKDEphjnMdaBvisPsMV6NEStR8OKGY2D2hkrsBY8HX0
        E4gdOh4Zop5thlUCak/nKOyvVZKnmcvI3dmFioy18Kidtvpn77bpkgesS8lkA1ky8figcg
        DDxzw+voGTsM+tnWBgpOETJzC76NYKAfM1vFAdGInHUh8DQJYz1juBmrlDdJWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MV6Y606SVssEQVKgDvP1PL7mW4j5AtallYXi4hZ7gRY=;
        b=CA0UwZXJQOCCLU9SJtcb5J0QLmKkoXkRLXRsGygKmv5bqayI5dPOI73ukegFCLsFnfGJA1
        TbRlGf8JprhvFdBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V3 58/60] x86/apic: Wrap IPI calls into helper functions
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move them to one place so the static call conversion gets simpler.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/hyperv/hv_spinlock.c    |    2 +-
 arch/x86/include/asm/apic.h      |   30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c      |    2 +-
 arch/x86/kernel/apic/hw_nmi.c    |    4 +++-
 arch/x86/kernel/apic/ipi.c       |   16 ++++++++--------
 arch/x86/kernel/apic/vector.c    |    6 +++---
 arch/x86/kernel/cpu/mce/inject.c |    3 +--
 arch/x86/kernel/irq_work.c       |    2 +-
 arch/x86/kernel/nmi_selftest.c   |    2 +-
 arch/x86/kernel/smp.c            |    2 +-
 arch/x86/kvm/vmx/posted_intr.c   |    2 +-
 arch/x86/kvm/vmx/vmx.c           |    2 +-
 arch/x86/platform/uv/uv_nmi.c    |    2 +-
 13 files changed, 53 insertions(+), 22 deletions(-)

--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -20,7 +20,7 @@ static bool __initdata hv_pvspin = true;
 
 static void hv_qlock_kick(int cpu)
 {
-	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
+	__apic_send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
 }
 
 static void hv_qlock_wait(u8 *byte, u8 val)
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -401,6 +401,36 @@ static __always_inline void apic_icr_wri
 	apic->icr_write(low, high);
 }
 
+static __always_inline void __apic_send_IPI(int cpu, int vector)
+{
+	apic->send_IPI(cpu, vector);
+}
+
+static __always_inline void __apic_send_IPI_mask(const struct cpumask *mask, int vector)
+{
+	apic->send_IPI_mask(mask, vector);
+}
+
+static __always_inline void __apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
+{
+	apic->send_IPI_mask_allbutself(mask, vector);
+}
+
+static __always_inline void __apic_send_IPI_allbutself(int vector)
+{
+	apic->send_IPI_allbutself(vector);
+}
+
+static __always_inline void __apic_send_IPI_all(int vector)
+{
+	apic->send_IPI_all(vector);
+}
+
+static __always_inline void __apic_send_IPI_self(int vector)
+{
+	apic->send_IPI_self(vector);
+}
+
 static __always_inline void apic_wait_icr_idle(void)
 {
 	if (apic->wait_icr_idle)
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -502,7 +502,7 @@ static int lapic_timer_set_oneshot(struc
 static void lapic_timer_broadcast(const struct cpumask *mask)
 {
 #ifdef CONFIG_SMP
-	apic->send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
+	__apic_send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
 #endif
 }
 
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -21,6 +21,8 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 
+#include "local.h"
+
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh)
 {
@@ -31,7 +33,7 @@ u64 hw_nmi_get_sample_period(int watchdo
 #ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
-	apic->send_IPI_mask(mask, NMI_VECTOR);
+	__apic_send_IPI_mask(mask, NMI_VECTOR);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -54,9 +54,9 @@ void apic_send_IPI_allbutself(unsigned i
 		return;
 
 	if (static_branch_likely(&apic_use_ipi_shorthand))
-		apic->send_IPI_allbutself(vector);
+		__apic_send_IPI_allbutself(vector);
 	else
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+		__apic_send_IPI_mask_allbutself(cpu_online_mask, vector);
 }
 
 /*
@@ -70,12 +70,12 @@ void native_smp_send_reschedule(int cpu)
 		WARN(1, "sched: Unexpected reschedule of offline CPU#%d!\n", cpu);
 		return;
 	}
-	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
+	__apic_send_IPI(cpu, RESCHEDULE_VECTOR);
 }
 
 void native_send_call_func_single_ipi(int cpu)
 {
-	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
+	__apic_send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
 }
 
 void native_send_call_func_ipi(const struct cpumask *mask)
@@ -87,14 +87,14 @@ void native_send_call_func_ipi(const str
 			goto sendmask;
 
 		if (cpumask_test_cpu(cpu, mask))
-			apic->send_IPI_all(CALL_FUNCTION_VECTOR);
+			__apic_send_IPI_all(CALL_FUNCTION_VECTOR);
 		else if (num_online_cpus() > 1)
-			apic->send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+			__apic_send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 		return;
 	}
 
 sendmask:
-	apic->send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
+	__apic_send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 }
 
 #endif /* CONFIG_SMP */
@@ -221,7 +221,7 @@ void default_send_IPI_mask_allbutself_ph
  */
 void default_send_IPI_single(int cpu, int vector)
 {
-	apic->send_IPI_mask(cpumask_of(cpu), vector);
+	__apic_send_IPI_mask(cpumask_of(cpu), vector);
 }
 
 void default_send_IPI_allbutself(int vector)
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -876,7 +876,7 @@ static int apic_retrigger_irq(struct irq
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	apic->send_IPI(apicd->cpu, apicd->vector);
+	__apic_send_IPI(apicd->cpu, apicd->vector);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
 
 	return 1;
@@ -958,7 +958,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_c
 		 */
 		irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
 		if (irr & (1U << (vector % 32))) {
-			apic->send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
+			__apic_send_IPI_self(IRQ_MOVE_CLEANUP_VECTOR);
 			continue;
 		}
 		free_moved_vector(apicd);
@@ -976,7 +976,7 @@ static void __send_cleanup_vector(struct
 	cpu = apicd->prev_cpu;
 	if (cpu_online(cpu)) {
 		hlist_add_head(&apicd->clist, per_cpu_ptr(&cleanup_list, cpu));
-		apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
+		__apic_send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
 	} else {
 		apicd->prev_vector = 0;
 	}
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -270,8 +270,7 @@ static void __maybe_unused raise_mce(str
 					mce_irq_ipi, NULL, 0);
 				preempt_enable();
 			} else if (m->inject_flags & MCJ_NMI_BROADCAST)
-				apic->send_IPI_mask(mce_inject_cpumask,
-						NMI_VECTOR);
+				__apic_send_IPI_mask(mce_inject_cpumask, NMI_VECTOR);
 		}
 		start = jiffies;
 		while (!cpumask_empty(mce_inject_cpumask)) {
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -28,7 +28,7 @@ void arch_irq_work_raise(void)
 	if (!arch_irq_work_has_interrupt())
 		return;
 
-	apic->send_IPI_self(IRQ_WORK_VECTOR);
+	__apic_send_IPI_self(IRQ_WORK_VECTOR);
 	apic_wait_icr_idle();
 }
 #endif
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -75,7 +75,7 @@ static void __init test_nmi_ipi(struct c
 	/* sync above data before sending NMI */
 	wmb();
 
-	apic->send_IPI_mask(mask, NMI_VECTOR);
+	__apic_send_IPI_mask(mask, NMI_VECTOR);
 
 	/* Don't wait longer than a second */
 	timeout = USEC_PER_SEC;
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -237,7 +237,7 @@ static void native_stop_other_cpus(int w
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
-				apic->send_IPI(cpu, NMI_VECTOR);
+				__apic_send_IPI(cpu, NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -175,7 +175,7 @@ static void pi_enable_wakeup_handler(str
 	 * scheduled out).
 	 */
 	if (pi_test_on(&new))
-		apic->send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
+		__apic_send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
 
 	local_irq_restore(flags);
 }
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4144,7 +4144,7 @@ static inline void kvm_vcpu_trigger_post
 		 */
 
 		if (vcpu != kvm_get_running_vcpu())
-			apic->send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
+			__apic_send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
 		return;
 	}
 #endif
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -601,7 +601,7 @@ static void uv_nmi_nr_cpus_ping(void)
 	for_each_cpu(cpu, uv_nmi_cpu_mask)
 		uv_cpu_nmi_per(cpu).pinging = 1;
 
-	apic->send_IPI_mask(uv_nmi_cpu_mask, APIC_DM_NMI);
+	__apic_send_IPI_mask(uv_nmi_cpu_mask, APIC_DM_NMI);
 }
 
 /* Clean up flags for CPU's that ignored both NMI and ping */

