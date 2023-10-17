Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B006D7CCF45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbjJQV2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjJQV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:28:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92518B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:24:16 -0700 (PDT)
Message-ID: <20231017211724.023973386@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MMisw33zmF+VluqK8COR66jdwehytciBcDcDKBkX0pQ=;
        b=dQlvfZ3ly2Uukq4DAJK4g9ZTXp9HdRaNE83B6M9DNgjJaIdLS3CBcZLEd0lfMcSLVmUaXI
        Jm4FxE/eW418S3fTAgz7M+SoIBT9Djkk6AspyBbC/oDgzdRggjZUs/bip5Eyl4ufatyaYq
        qo82zP63d6ZP4lX5fLDKrXc14kuqTYR7qSKOvZDrsP5B6rvl0/ojcZZzSvEafrMSyae1yQ
        oQuK0LNA3oR5tdKu6RrDI3p4uwvBwzhIkgTHbeJ8no58gxAuTQnwZV1rDzGXdmVNQT8J3i
        iCvN2Uhj9KRC6ytnFRckHNMZZJFnUQwDFRuY8tcR8S6lnHgHVLr3VoFjuE08Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MMisw33zmF+VluqK8COR66jdwehytciBcDcDKBkX0pQ=;
        b=DEgzrGcVBjqAM5hPcuavbwBpVhSXOgCLioetZsh2kNaQveaQlWq2C5KsI/639jlC3sKoYj
        Idur3RI6/usNDfDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 37/39] x86/microcode: Handle "offline" CPUs correctly
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:24:14 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Offline CPUs need to be parked in a safe loop when microcode update is
in progress on the primary CPU. Currently, offline CPUs are parked in
mwait_play_dead(), and for Intel CPUs, its not a safe instruction,
because the MWAIT instruction can be patched in the new microcode update
that can cause instability.

  - Add a new microcode state 'UCODE_OFFLINE' to report status on per-CPU
  basis.
  - Force NMI on the offline CPUs.

Wake up offline CPUs while the update is in progress and then return
them back to mwait_play_dead() after microcode update is complete.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/microcode.h         |    1 
 arch/x86/kernel/cpu/microcode/core.c     |  112 +++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/microcode/internal.h |    1 
 arch/x86/kernel/nmi.c                    |    5 +
 4 files changed, 113 insertions(+), 6 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -73,6 +73,7 @@ static inline u32 intel_get_microcode_re
 #endif /* !CONFIG_CPU_SUP_INTEL */
 
 bool microcode_nmi_handler(void);
+void microcode_offline_nmi_handler(void);
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 DECLARE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -272,8 +272,9 @@ struct microcode_ctrl {
 
 DEFINE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
+static atomic_t late_cpus_in, offline_in_nmi;
 static unsigned int loops_per_usec;
-static atomic_t late_cpus_in;
+static cpumask_t cpu_offline_mask;
 
 static noinstr bool wait_for_cpus(atomic_t *cnt)
 {
@@ -381,7 +382,7 @@ static noinstr void load_secondary(unsig
 	instrumentation_end();
 }
 
-static void load_primary(unsigned int cpu)
+static void __load_primary(unsigned int cpu)
 {
 	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
 	enum sibling_ctrl ctrl;
@@ -416,6 +417,67 @@ static void load_primary(unsigned int cp
 	}
 }
 
+static bool kick_offline_cpus(unsigned int nr_offl)
+{
+	unsigned int cpu, timeout;
+
+	for_each_cpu(cpu, &cpu_offline_mask) {
+		/* Enable the rendezvous handler and send NMI */
+		per_cpu(ucode_ctrl.nmi_enabled, cpu) = true;
+		apic_send_nmi_to_offline_cpu(cpu);
+	}
+
+	/* Wait for them to arrive */
+	for (timeout = 0; timeout < (USEC_PER_SEC / 2); timeout++) {
+		if (atomic_read(&offline_in_nmi) == nr_offl)
+			return true;
+		udelay(1);
+	}
+	/* Let the others time out */
+	return false;
+}
+
+static void release_offline_cpus(void)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, &cpu_offline_mask)
+		per_cpu(ucode_ctrl.ctrl, cpu) = SCTRL_DONE;
+}
+
+static void load_primary(unsigned int cpu)
+{
+	unsigned int nr_offl = cpumask_weight(&cpu_offline_mask);
+	bool proceed = true;
+
+	/* Kick soft-offlined SMT siblings if required */
+	if (!cpu && nr_offl)
+		proceed = kick_offline_cpus(nr_offl);
+
+	/* If the soft-offlined CPUs did not respond, abort */
+	if (proceed)
+		__load_primary(cpu);
+
+	/* Unconditionally release soft-offlined SMT siblings if required */
+	if (!cpu && nr_offl)
+		release_offline_cpus();
+}
+
+/*
+ * Minimal stub rendezvous handler for soft-offlined CPUs which participate
+ * in the NMI rendezvous to protect against a concurrent NMI on affected
+ * CPUs.
+ */
+void noinstr microcode_offline_nmi_handler(void)
+{
+	if (!raw_cpu_read(ucode_ctrl.nmi_enabled))
+		return;
+	raw_cpu_write(ucode_ctrl.nmi_enabled, false);
+	raw_cpu_write(ucode_ctrl.result, UCODE_OFFLINE);
+	raw_atomic_inc(&offline_in_nmi);
+	wait_for_ctrl();
+}
+
 static noinstr bool microcode_update_handler(void)
 {
 	unsigned int cpu = raw_smp_processor_id();
@@ -472,6 +534,7 @@ static int load_cpus_stopped(void *unuse
 static int load_late_stop_cpus(void)
 {
 	unsigned int cpu, updated = 0, failed = 0, timedout = 0, siblings = 0;
+	unsigned int nr_offl, offline = 0;
 	int old_rev = boot_cpu_data.microcode;
 	struct cpuinfo_x86 prev_info;
 
@@ -479,6 +542,7 @@ static int load_late_stop_cpus(void)
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
+	atomic_set(&offline_in_nmi, 0);
 	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
 
 	/*
@@ -501,6 +565,7 @@ static int load_late_stop_cpus(void)
 		case UCODE_UPDATED:	updated++; break;
 		case UCODE_TIMEOUT:	timedout++; break;
 		case UCODE_OK:		siblings++; break;
+		case UCODE_OFFLINE:	offline++; break;
 		default:		failed++; break;
 		}
 	}
@@ -512,6 +577,13 @@ static int load_late_stop_cpus(void)
 		/* Nothing changed. */
 		if (!failed && !timedout)
 			return 0;
+
+		nr_offl = cpumask_weight(&cpu_offline_mask);
+		if (offline < nr_offl) {
+			pr_warn("%u offline siblings did not respond.\n",
+				nr_offl - atomic_read(&offline_in_nmi));
+			return -EIO;
+		}
 		pr_err("update failed: %u CPUs failed %u CPUs timed out\n",
 		       failed, timedout);
 		return -EIO;
@@ -545,19 +617,49 @@ static int load_late_stop_cpus(void)
  *    modern CPUs uses MWAIT, which is also not guaranteed to be safe
  *    against a microcode update which affects MWAIT.
  *
- * 2) Initialize the per CPU control structure
+ *    As soft-offlined CPUs still react on NMIs, the SMT sibling
+ *    restriction can be lifted when the vendor driver signals to use NMI
+ *    for rendezvous and the APIC provides a mechanism to send an NMI to a
+ *    soft-offlined CPU. The soft-offlined CPUs are then able to
+ *    participate in the rendezvous in a trivial stub handler.
+ *
+ * 2) Initialize the per CPU control structure and create a cpumask
+ *    which contains "offline"; secondary threads, so they can be handled
+ *    correctly by a control CPU.
  */
 static bool setup_cpus(void)
 {
 	struct microcode_ctrl ctrl = { .ctrl = SCTRL_WAIT, .result = -1, };
+	bool allow_smt_offline;
 	unsigned int cpu;
 
+	allow_smt_offline = microcode_ops->nmi_safe ||
+		(microcode_ops->use_nmi && apic->nmi_to_offline_cpu);
+
+	cpumask_clear(&cpu_offline_mask);
+
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
+		/*
+		 * Offline CPUs sit in one of the play_dead() functions
+		 * with interrupts disabled, but they still react on NMIs
+		 * and execute arbitrary code. Also MWAIT being updated
+		 * while the offline CPU sits there is not necessarily safe
+		 * on all CPU variants.
+		 *
+		 * Mark them in the offline_cpus mask which will be handled
+		 * by CPU0 later in the update process.
+		 *
+		 * Ensure that the primary thread is online so that it is
+		 * guaranteed that all cores are updated.
+		 */
 		if (!cpu_online(cpu)) {
-			if (topology_is_primary_thread(cpu) || !microcode_ops->nmi_safe) {
-				pr_err("CPU %u not online\n", cpu);
+			if (topology_is_primary_thread(cpu) || !allow_smt_offline) {
+				pr_err("CPU %u not online, loading aborted\n", cpu);
 				return false;
 			}
+			cpumask_set_cpu(cpu, &cpu_offline_mask);
+			per_cpu(ucode_ctrl, cpu) = ctrl;
+			continue;
 		}
 
 		/*
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -17,6 +17,7 @@ enum ucode_state {
 	UCODE_NFOUND,
 	UCODE_ERROR,
 	UCODE_TIMEOUT,
+	UCODE_OFFLINE,
 };
 
 struct microcode_ops {
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -502,8 +502,11 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU))
 		raw_atomic_long_inc(&nsp->idt_calls);
 
-	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id()))
+	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id())) {
+		if (microcode_nmi_handler_enabled())
+			microcode_offline_nmi_handler();
 		return;
+	}
 
 	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
 		this_cpu_write(nmi_state, NMI_LATCHED);

