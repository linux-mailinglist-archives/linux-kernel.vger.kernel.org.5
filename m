Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B30776A23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbjHIUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHIUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E1D2111;
        Wed,  9 Aug 2023 13:36:05 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=10xVeKgGz6YKQn0qdGwKl/qAZKHxF39iiIyGOuGmioQ=;
        b=vfwW5q4yAzmhXe6VzEzy55ogFgVNWo1u7yIjLALv/+Jo7MK9/KBqZoi+OOILxfw56LsrMq
        AN0b/sEg/r8xogT3pCYHi3a0p0I6dDvm/oAmL760DMS9oHODl6f38Y9h0E5/3RZWI73zfP
        NFtu+c/LQNzR12snnWyjMPraaOp67RkGN3vw+ZUmr4obgim6mFiapUgOgb8GzZJpXoT7ux
        cxXmQR5wMZbmI8VhwNt8YM0+aop+K0Ih6t5+EIrjzOQKRzk2j7P0V+vdROTV/whzLXlvH+
        WpYAU9BPFL86CTBy/Wg8Wiit1uML6ILIRsP+bdrdsa49EKS7WDh5zgUL4gJorg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=10xVeKgGz6YKQn0qdGwKl/qAZKHxF39iiIyGOuGmioQ=;
        b=DBENGK2hkiEVciKXNYi0hlfYB9FfiAlPk+Ye9rbng6NOCjrmeQ/F9RQK5VGKUc6Ua6ipQ9
        eVak4VLD85Qf6vCA==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Wrap IPI calls into helper functions
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336393.27769.1185833441912348120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     28b8235238fa39a1b5c5820e7f5b14e7f104aac0
Gitweb:        https://git.kernel.org/tip/28b8235238fa39a1b5c5820e7f5b14e7f104aac0
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 09 Aug 2023 08:21:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 12:00:55 -07:00

x86/apic: Wrap IPI calls into helper functions

Move them to one place so the static call conversion gets simpler.

No functional change.

[ dhansen: merge against recent x86/apic changes ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/hyperv/hv_spinlock.c    |  2 +-
 arch/x86/include/asm/apic.h      | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c      |  2 +-
 arch/x86/kernel/apic/hw_nmi.c    |  4 +++-
 arch/x86/kernel/apic/ipi.c       | 16 ++++++++--------
 arch/x86/kernel/apic/vector.c    |  2 +-
 arch/x86/kernel/cpu/mce/inject.c |  3 +--
 arch/x86/kernel/irq_work.c       |  2 +-
 arch/x86/kernel/nmi_selftest.c   |  2 +-
 arch/x86/kernel/smp.c            |  2 +-
 arch/x86/kvm/vmx/posted_intr.c   |  2 +-
 arch/x86/kvm/vmx/vmx.c           |  2 +-
 arch/x86/platform/uv/uv_nmi.c    |  2 +-
 13 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 91cfe69..737d6f7 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -20,7 +20,7 @@ static bool __initdata hv_pvspin = true;
 
 static void hv_qlock_kick(int cpu)
 {
-	apic->send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
+	__apic_send_IPI(cpu, X86_PLATFORM_IPI_VECTOR);
 }
 
 static void hv_qlock_wait(u8 *byte, u8 val)
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 28192a2..62471e2 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -401,6 +401,36 @@ static __always_inline void apic_icr_write(u32 low, u32 high)
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
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 55f2b96..760adac 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -502,7 +502,7 @@ static int lapic_timer_set_oneshot(struct clock_event_device *evt)
 static void lapic_timer_broadcast(const struct cpumask *mask)
 {
 #ifdef CONFIG_SMP
-	apic->send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
+	__apic_send_IPI_mask(mask, LOCAL_TIMER_VECTOR);
 #endif
 }
 
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 34a992e..07a3dd1 100644
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
@@ -31,7 +33,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 #ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
-	apic->send_IPI_mask(mask, NMI_VECTOR);
+	__apic_send_IPI_mask(mask, NMI_VECTOR);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 460df02..b54b2a6 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -54,9 +54,9 @@ void apic_send_IPI_allbutself(unsigned int vector)
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
@@ -87,14 +87,14 @@ void native_send_call_func_ipi(const struct cpumask *mask)
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
@@ -221,7 +221,7 @@ void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
  */
 void default_send_IPI_single(int cpu, int vector)
 {
-	apic->send_IPI_mask(cpumask_of(cpu), vector);
+	__apic_send_IPI_mask(cpumask_of(cpu), vector);
 }
 
 void default_send_IPI_allbutself(int vector)
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 4a262c6..319448d 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -898,7 +898,7 @@ static int apic_retrigger_irq(struct irq_data *irqd)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	apic->send_IPI(apicd->cpu, apicd->vector);
+	__apic_send_IPI(apicd->cpu, apicd->vector);
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
 
 	return 1;
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 12cf2e7..4d8d4bc 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -270,8 +270,7 @@ static void __maybe_unused raise_mce(struct mce *m)
 					mce_irq_ipi, NULL, 0);
 				preempt_enable();
 			} else if (m->inject_flags & MCJ_NMI_BROADCAST)
-				apic->send_IPI_mask(mce_inject_cpumask,
-						NMI_VECTOR);
+				__apic_send_IPI_mask(mce_inject_cpumask, NMI_VECTOR);
 		}
 		start = jiffies;
 		while (!cpumask_empty(mce_inject_cpumask)) {
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index ee53419..b0a24de 100644
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
diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.c
index a1a96df..e93a854 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -75,7 +75,7 @@ static void __init test_nmi_ipi(struct cpumask *mask)
 	/* sync above data before sending NMI */
 	wmb();
 
-	apic->send_IPI_mask(mask, NMI_VECTOR);
+	__apic_send_IPI_mask(mask, NMI_VECTOR);
 
 	/* Don't wait longer than a second */
 	timeout = USEC_PER_SEC;
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 6299bf8..6eb06d0 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -237,7 +237,7 @@ static void native_stop_other_cpus(int wait)
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
-				apic->send_IPI(cpu, NMI_VECTOR);
+				__apic_send_IPI(cpu, NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 94c38be..af66231 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -175,7 +175,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 	 * scheduled out).
 	 */
 	if (pi_test_on(&new))
-		apic->send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
+		__apic_send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
 
 	local_irq_restore(flags);
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index df461f3..b483a8b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4179,7 +4179,7 @@ static inline void kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
 		 */
 
 		if (vcpu != kvm_get_running_vcpu())
-			apic->send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
+			__apic_send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
 		return;
 	}
 #endif
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af02..85f9aa0 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -601,7 +601,7 @@ static void uv_nmi_nr_cpus_ping(void)
 	for_each_cpu(cpu, uv_nmi_cpu_mask)
 		uv_cpu_nmi_per(cpu).pinging = 1;
 
-	apic->send_IPI_mask(uv_nmi_cpu_mask, APIC_DM_NMI);
+	__apic_send_IPI_mask(uv_nmi_cpu_mask, APIC_DM_NMI);
 }
 
 /* Clean up flags for CPU's that ignored both NMI and ping */
