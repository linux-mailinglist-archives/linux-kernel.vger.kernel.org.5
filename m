Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3C1776A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjHIUgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjHIUgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:36:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05DD210D;
        Wed,  9 Aug 2023 13:36:10 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691613369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KXsQ0JunJmhEILsfuaFj/Rm3XHMEgou5uI3kmWnfOHE=;
        b=Lw3RrJzyoZl4QGKBe+dI+6hUT6Uu+YO20V/jPXV+B4JQhvo6yEXr+O30NSrZtx5zJkhiEg
        hzbHJVfBUAVnTeK4iYwi1SJ2Gr50HgmVF6lYygIH/ikABmGiaBkUtUD78wncU389NA7oYP
        rZNaWYJsaqDU0SgdgurDPRLhCl9HlzCcthQgWgH21nEsjGg0EWAWDIr0N6zD6eU+9o/hSN
        7aEfdPUd1TUPDurq2FoI6MnzdwJALQ858rX8zFoiJ6y2+MNioRwgZ8c/hqQ/WZ4sBuUSzD
        PUGgXqr6h3gF4qPWLuSLUYu+x2Qiey/EP74kDk3x+kbrFS0wqpQqlT+CeiOwDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691613369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KXsQ0JunJmhEILsfuaFj/Rm3XHMEgou5uI3kmWnfOHE=;
        b=YfMDGPFGV2zgFGjHj2KRRMmqbgukdYXdTYm2h/B6ajAZM0KpihEE3pFwESnGDJCQY68PGN
        JnIBblwMeUmxJBDQ==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Nuke ack_APIC_irq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169161336901.27769.5381986886968999187.tip-bot2@tip-bot2>
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

Commit-ID:     670c04add6e1a22de7c59e282c138ddcf6c9e5a2
Gitweb:        https://git.kernel.org/tip/670c04add6e1a22de7c59e282c138ddcf6c9e5a2
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 09 Aug 2023 08:16:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:34 -07:00

x86/apic: Nuke ack_APIC_irq()

Yet another wrapper of a wrapper gone along with the outdated comment
that this compiles to a single instruction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/hyperv/hv_init.c           |  2 +-
 arch/x86/include/asm/apic.h         | 10 ----------
 arch/x86/kernel/apic/apic.c         | 10 +++++-----
 arch/x86/kernel/apic/io_apic.c      |  4 ++--
 arch/x86/kernel/apic/vector.c       |  2 +-
 arch/x86/kernel/cpu/acrn.c          |  2 +-
 arch/x86/kernel/cpu/mce/amd.c       |  2 +-
 arch/x86/kernel/cpu/mce/threshold.c |  2 +-
 arch/x86/kernel/cpu/mshyperv.c      |  4 ++--
 arch/x86/kernel/irq.c               | 14 +++++++-------
 arch/x86/kernel/irq_work.c          |  2 +-
 arch/x86/kernel/kvm.c               |  2 +-
 arch/x86/kernel/smp.c               |  8 ++++----
 arch/x86/xen/enlighten_hvm.c        |  2 +-
 14 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6c04b52..fc56fc8 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -161,7 +161,7 @@ static inline bool hv_reenlightenment_available(void)
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(irq_hv_reenlightenment_count);
 	schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
 }
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 790f15d..6ad3574 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -402,16 +402,6 @@ static inline void apic_set_eoi_cb(void (*eoi)(void)) {}
 
 extern void apic_ack_irq(struct irq_data *data);
 
-static inline void ack_APIC_irq(void)
-{
-	/*
-	 * ack_APIC_irq() actually gets compiled as a single instruction
-	 * ... yummie.
-	 */
-	apic_eoi();
-}
-
-
 static inline bool lapic_vector_set_in_irr(unsigned int vector)
 {
 	u32 irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 33d5ed6..b8b801e 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1076,7 +1076,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer_interrupt)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	ack_APIC_irq();
+	apic_eoi();
 	trace_local_timer_entry(LOCAL_TIMER_VECTOR);
 	local_apic_timer_interrupt();
 	trace_local_timer_exit(LOCAL_TIMER_VECTOR);
@@ -1480,7 +1480,7 @@ static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
 		 * per set bit.
 		 */
 		for_each_set_bit(bit, isr->map, APIC_IR_BITS)
-			ack_APIC_irq();
+			apic_eoi();
 		return true;
 	}
 
@@ -1492,7 +1492,7 @@ static bool apic_check_and_ack(union apic_ir *irr, union apic_ir *isr)
  * interrupt from previous kernel might still have ISR bit set.
  *
  * Most probably by now the CPU has serviced that pending interrupt and it
- * might not have done the ack_APIC_irq() because it thought, interrupt
+ * might not have done the apic_eoi() because it thought, interrupt
  * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
  * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
  * a vector might get locked. It was noticed for timer irq (vector
@@ -2147,7 +2147,7 @@ static noinline void handle_spurious_interrupt(u8 vector)
 	if (v & (1 << (vector & 0x1f))) {
 		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
 			vector, smp_processor_id());
-		ack_APIC_irq();
+		apic_eoi();
 	} else {
 		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
 			vector, smp_processor_id());
@@ -2198,7 +2198,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_interrupt)
 	if (lapic_get_maxlvt() > 3)	/* Due to the Pentium erratum 3AP. */
 		apic_write(APIC_ESR, 0);
 	v = apic_read(APIC_ESR);
-	ack_APIC_irq();
+	apic_eoi();
 	atomic_inc(&irq_err_count);
 
 	apic_printk(APIC_DEBUG, KERN_DEBUG "APIC error on CPU%d: %02x",
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ff2d27e..00da6cf 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1823,7 +1823,7 @@ static void ioapic_ack_level(struct irq_data *irq_data)
 	 * We must acknowledge the irq before we move it or the acknowledge will
 	 * not propagate properly.
 	 */
-	ack_APIC_irq();
+	apic_eoi();
 
 	/*
 	 * Tail end of clearing remote IRR bit (either by delivering the EOI
@@ -2046,7 +2046,7 @@ static void unmask_lapic_irq(struct irq_data *data)
 
 static void ack_lapic_irq(struct irq_data *data)
 {
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 static struct irq_chip lapic_chip __read_mostly = {
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2ee3f5a..4a262c6 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -907,7 +907,7 @@ static int apic_retrigger_irq(struct irq_data *irqd)
 void apic_ack_irq(struct irq_data *irqd)
 {
 	irq_move_irq(irqd);
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 void apic_ack_edge(struct irq_data *irqd)
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 485441b..bfeb18f 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -51,7 +51,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_callback)
 	 * will block the interrupt whose vector is lower than
 	 * HYPERVISOR_CALLBACK_VECTOR.
 	 */
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(irq_hv_callback_count);
 
 	if (acrn_intr_handler)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c4ec4ca..c267f43 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -759,7 +759,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	inc_irq_stat(irq_deferred_error_count);
 	deferred_error_int_vector();
 	trace_deferred_error_apic_exit(DEFERRED_ERROR_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 6a059a0..ef4e7bb 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -27,5 +27,5 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 	inc_irq_stat(irq_threshold_count);
 	mce_threshold_vector();
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 }
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c7969e8..0100468 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -119,7 +119,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 		vmbus_handler();
 
 	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
-		ack_APIC_irq();
+		apic_eoi();
 
 	set_irq_regs(old_regs);
 }
@@ -147,7 +147,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_stimer0)
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
 	add_interrupt_randomness(HYPERV_STIMER0_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 
 	set_irq_regs(old_regs);
 }
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 9f668d2..11761c1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -49,7 +49,7 @@ void ack_bad_irq(unsigned int irq)
 	 * completely.
 	 * But only ack when the APIC is enabled -AK
 	 */
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 #define irq_stats(x)		(&per_cpu(irq_stat, x))
@@ -256,7 +256,7 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
 	} else {
-		ack_APIC_irq();
+		apic_eoi();
 
 		if (desc == VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
@@ -280,7 +280,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platform_ipi)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	ack_APIC_irq();
+	apic_eoi();
 	trace_x86_platform_ipi_entry(X86_PLATFORM_IPI_VECTOR);
 	inc_irq_stat(x86_platform_ipis);
 	if (x86_platform_ipi_callback)
@@ -310,7 +310,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wakeup_handler);
  */
 DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(kvm_posted_intr_ipis);
 }
 
@@ -319,7 +319,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_ipi)
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(kvm_posted_intr_wakeup_ipis);
 	kvm_posted_intr_wakeup_handler();
 }
@@ -329,7 +329,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
  */
 DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(kvm_posted_intr_nested_ipis);
 }
 #endif
@@ -401,6 +401,6 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
 	inc_irq_stat(irq_thermal_count);
 	smp_thermal_vector();
 	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 }
 #endif
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 890d477..ee53419 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -16,7 +16,7 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 DEFINE_IDTENTRY_SYSVEC(sysvec_irq_work)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_irq_work_entry(IRQ_WORK_VECTOR);
 	inc_irq_stat(apic_irq_work_irqs);
 	irq_work_run();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c2e3e7a..f5339e3 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -291,7 +291,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncpf_interrupt)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	u32 token;
 
-	ack_APIC_irq();
+	apic_eoi();
 
 	inc_irq_stat(irq_hv_callback_count);
 
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 7eb18ca..6299bf8 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -135,7 +135,7 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	cpu_emergency_disable_virtualization();
 	stop_this_cpu(NULL);
 }
@@ -268,7 +268,7 @@ done:
  */
 DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_reschedule_entry(RESCHEDULE_VECTOR);
 	inc_irq_stat(irq_resched_count);
 	scheduler_ipi();
@@ -277,7 +277,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi)
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_call_function_entry(CALL_FUNCTION_VECTOR);
 	inc_irq_stat(irq_call_count);
 	generic_smp_call_function_interrupt();
@@ -286,7 +286,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_call_function_single_entry(CALL_FUNCTION_SINGLE_VECTOR);
 	inc_irq_stat(irq_call_count);
 	generic_smp_call_function_single_interrupt();
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index a6820ca..9a192f5 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -132,7 +132,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if (xen_percpu_upcall)
-		ack_APIC_irq();
+		apic_eoi();
 
 	inc_irq_stat(irq_hv_callback_count);
 
