Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367BD757092
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGQXgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGQXgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EFD170D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:35:56 -0700 (PDT)
Message-ID: <20230717223225.937554398@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iCsxfuqhz4Fo6ZGAppoqBTBjAoRzkGry7KPBD+0gZyY=;
        b=yrod9RYFIU1ubI925w14spnCcuCVMcCr4iYLMcuitbmxUYOOCOL1ggyXrpJaVe7OSOMQV/
        GyS0JsyZWVl6ksXYnahXR0Abzz8mTq3oAX2/kMtA9s4gTg2OgmczD3ebZ6HweOQJSy4DVw
        /sS/a0TuD3wO8u31cQBUUkm/fY5WAp7bo3gnXOanrquEecXvFw/NauyD/bId89VhPlG5jI
        zPmYqfr3lduc60VMumb0j2KVEUxgqwAj/EpHExbehPyLMhIsT7U4yVHRnXNPSIOkQgWHRs
        ljZca4pdokvOkv89cmNk9aqmAef14s+HdbZI6zAVu+QFL1iCAjLPAh76XVjZsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iCsxfuqhz4Fo6ZGAppoqBTBjAoRzkGry7KPBD+0gZyY=;
        b=KgbgIgIjJ3pCo5ngii+ou3DNwDmhvHcKKy4N4E2rxsuUk4EIhVLtXI3Pph1+1f7vZUrpxD
        k3gVibrpUT4OIKBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 48/58] x86/apic: Nuke ack_APIC_irq()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another wrapper of a wrapper gone along with the outdated comment
that this compiles to a single instruction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/hyperv/hv_init.c           |    2 +-
 arch/x86/include/asm/apic.h         |   10 ----------
 arch/x86/kernel/apic/apic.c         |   10 +++++-----
 arch/x86/kernel/apic/io_apic.c      |    4 ++--
 arch/x86/kernel/apic/vector.c       |    4 ++--
 arch/x86/kernel/cpu/acrn.c          |    2 +-
 arch/x86/kernel/cpu/mce/amd.c       |    2 +-
 arch/x86/kernel/cpu/mce/threshold.c |    2 +-
 arch/x86/kernel/cpu/mshyperv.c      |    4 ++--
 arch/x86/kernel/irq.c               |   14 +++++++-------
 arch/x86/kernel/irq_work.c          |    2 +-
 arch/x86/kernel/kvm.c               |    2 +-
 arch/x86/kernel/smp.c               |    8 ++++----
 arch/x86/xen/enlighten_hvm.c        |    2 +-
 14 files changed, 29 insertions(+), 39 deletions(-)

--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -161,7 +161,7 @@ static inline bool hv_reenlightenment_av
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_reenlightenment)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(irq_hv_reenlightenment_count);
 	schedule_delayed_work(&hv_reenlightenment_work, HZ/10);
 }
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -402,16 +402,6 @@ static inline void apic_set_eoi(void (*e
 
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
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1076,7 +1076,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_apic_timer
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	ack_APIC_irq();
+	apic_eoi();
 	trace_local_timer_entry(LOCAL_TIMER_VECTOR);
 	local_apic_timer_interrupt();
 	trace_local_timer_exit(LOCAL_TIMER_VECTOR);
@@ -1480,7 +1480,7 @@ static bool apic_check_and_ack(union api
 		 * per set bit.
 		 */
 		for_each_set_bit(bit, isr->map, APIC_IR_BITS)
-			ack_APIC_irq();
+			apic_eoi();
 		return true;
 	}
 
@@ -1492,7 +1492,7 @@ static bool apic_check_and_ack(union api
  * interrupt from previous kernel might still have ISR bit set.
  *
  * Most probably by now the CPU has serviced that pending interrupt and it
- * might not have done the ack_APIC_irq() because it thought, interrupt
+ * might not have done the apic_eoi() because it thought, interrupt
  * came from i8259 as ExtInt. LAPIC did not get EOI so it does not clear
  * the ISR bit and cpu thinks it has already serviced the interrupt. Hence
  * a vector might get locked. It was noticed for timer irq (vector
@@ -2146,7 +2146,7 @@ static noinline void handle_spurious_int
 	if (v & (1 << (vector & 0x1f))) {
 		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
 			vector, smp_processor_id());
-		ack_APIC_irq();
+		apic_eoi();
 	} else {
 		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
 			vector, smp_processor_id());
@@ -2197,7 +2197,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_error_inte
 	if (lapic_get_maxlvt() > 3)	/* Due to the Pentium erratum 3AP. */
 		apic_write(APIC_ESR, 0);
 	v = apic_read(APIC_ESR);
-	ack_APIC_irq();
+	apic_eoi();
 	atomic_inc(&irq_err_count);
 
 	apic_printk(APIC_DEBUG, KERN_DEBUG "APIC error on CPU%d: %02x",
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1823,7 +1823,7 @@ static void ioapic_ack_level(struct irq_
 	 * We must acknowledge the irq before we move it or the acknowledge will
 	 * not propagate properly.
 	 */
-	ack_APIC_irq();
+	apic_eoi();
 
 	/*
 	 * Tail end of clearing remote IRR bit (either by delivering the EOI
@@ -2046,7 +2046,7 @@ static void unmask_lapic_irq(struct irq_
 
 static void ack_lapic_irq(struct irq_data *data)
 {
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 static struct irq_chip lapic_chip __read_mostly = {
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -885,7 +885,7 @@ static int apic_retrigger_irq(struct irq
 void apic_ack_irq(struct irq_data *irqd)
 {
 	irq_move_irq(irqd);
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 void apic_ack_edge(struct irq_data *irqd)
@@ -940,7 +940,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_irq_move_c
 	struct apic_chip_data *apicd;
 	struct hlist_node *tmp;
 
-	ack_APIC_irq();
+	apic_eoi();
 	/* Prevent vectors vanishing under us */
 	raw_spin_lock(&vector_lock);
 
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -51,7 +51,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_ca
 	 * will block the interrupt whose vector is lower than
 	 * HYPERVISOR_CALLBACK_VECTOR.
 	 */
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(irq_hv_callback_count);
 
 	if (acrn_intr_handler)
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -759,7 +759,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_e
 	inc_irq_stat(irq_deferred_error_count);
 	deferred_error_int_vector();
 	trace_deferred_error_apic_exit(DEFERRED_ERROR_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 }
 
 /*
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -27,5 +27,5 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 	inc_irq_stat(irq_threshold_count);
 	mce_threshold_vector();
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 }
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -119,7 +119,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_cal
 		vmbus_handler();
 
 	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
-		ack_APIC_irq();
+		apic_eoi();
 
 	set_irq_regs(old_regs);
 }
@@ -147,7 +147,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_sti
 	if (hv_stimer0_handler)
 		hv_stimer0_handler();
 	add_interrupt_randomness(HYPERV_STIMER0_VECTOR);
-	ack_APIC_irq();
+	apic_eoi();
 
 	set_irq_regs(old_regs);
 }
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
@@ -280,7 +280,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_x86_platfo
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
-	ack_APIC_irq();
+	apic_eoi();
 	trace_x86_platform_ipi_entry(X86_PLATFORM_IPI_VECTOR);
 	inc_irq_stat(x86_platform_ipis);
 	if (x86_platform_ipi_callback)
@@ -310,7 +310,7 @@ EXPORT_SYMBOL_GPL(kvm_set_posted_intr_wa
  */
 DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(kvm_posted_intr_ipis);
 }
 
@@ -319,7 +319,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted_intr_wakeup_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	inc_irq_stat(kvm_posted_intr_wakeup_ipis);
 	kvm_posted_intr_wakeup_handler();
 }
@@ -329,7 +329,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_posted
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
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -291,7 +291,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_kvm_asyncp
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	u32 token;
 
-	ack_APIC_irq();
+	apic_eoi();
 
 	inc_irq_stat(irq_hv_callback_count);
 
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -135,7 +135,7 @@ static int smp_stop_nmi_callback(unsigne
  */
 DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	cpu_emergency_disable_virtualization();
 	stop_this_cpu(NULL);
 }
@@ -268,7 +268,7 @@ static void native_stop_other_cpus(int w
  */
 DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_reschedule_ipi)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_reschedule_entry(RESCHEDULE_VECTOR);
 	inc_irq_stat(irq_resched_count);
 	scheduler_ipi();
@@ -277,7 +277,7 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_res
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_call_function_entry(CALL_FUNCTION_VECTOR);
 	inc_irq_stat(irq_call_count);
 	generic_smp_call_function_interrupt();
@@ -286,7 +286,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_call_funct
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_call_function_single)
 {
-	ack_APIC_irq();
+	apic_eoi();
 	trace_call_function_single_entry(CALL_FUNCTION_SINGLE_VECTOR);
 	inc_irq_stat(irq_call_count);
 	generic_smp_call_function_single_interrupt();
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -132,7 +132,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_ca
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if (xen_percpu_upcall)
-		ack_APIC_irq();
+		apic_eoi();
 
 	inc_irq_stat(irq_hv_callback_count);
 

