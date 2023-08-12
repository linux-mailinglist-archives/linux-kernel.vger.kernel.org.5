Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE077A241
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHLUCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjHLUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:02:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119933596
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:02:03 -0700 (PDT)
Message-ID: <20230812195729.388848949@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jIHJGcyGY0V0aJcaBH+xFPGYAym+5j4xuz0uER+GG98=;
        b=DqQ3dPW4vR/kyCueRRFx5V/ufBf+tMf8lRFxoKHqDGLDf+a1iSJ7EQYWbdoBHDggzDkTpq
        bEojKksXggvMMgAha7xGBtPzKnrx7NJWbBQQB2M558gp86Yh7SxKsNUecsQNCAF+HpuMbm
        2lboB9CstC03A3PdLFAfoJqQl2bVfpnl/Rui74ucjqJw2jMohfQ6W4hdm1UDDHSqforTjy
        JdqQEB2wvDhXZ6D+uY8UhXMCXFwk8fVUXp7NtErQeDYzgw4giIgc8BJ2WfV+q5BOAURgEF
        V5AO2FP2sQJxGDGmjwbXdnabl3EkrDBMmIVWShe5lYV85PsCFOv/7UqLC1dsSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=jIHJGcyGY0V0aJcaBH+xFPGYAym+5j4xuz0uER+GG98=;
        b=0mYywXzLhpqF3hICRyPLcikSeAXXvspXxB0pmDisC/jNMWV0YUQxUr7bXmKAvuTHI0t3qc
        NWL42u12zqKOT3Cg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 32/37] x86/microcode: Rendezvous and load in NMI
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:26 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

stop_machine() does not prevent the spin-waiting sibling from handling an
NMI, which is obviously violating the whole concept of rendezvous.

Implement a static branch right in the beginning of the NMI handler which
is NOOPed except when enabled by the late loading mechanism.

The later loader enables the static branch before stop_machine() is
invoked. Each CPU has an nmi_enable in its control structure which
indicates whether the CPU should go into the update routine.

This is required to bridge the gap between enabling the branch and actually
being at the point where it makes sense.

Each CPU which arrives in the stopper thread function sets that flag and
issues a self NMI right after that. If the NMI function sees the flag
clear, it returns. If it's set it clears the flag and enters the rendezvous.

This is safe against a real NMI which hits in between setting the flag and
sending the NMI to itself. The real NMI will be swallowed by the microcode
update and the self NMI will then let stuff continue. Otherwise this would
end up with a spurious NMI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/microcode.h         |   12 ++++++++
 arch/x86/kernel/cpu/microcode/core.c     |   42 ++++++++++++++++++++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c    |    1 
 arch/x86/kernel/cpu/microcode/internal.h |    3 +-
 arch/x86/kernel/nmi.c                    |    4 ++
 5 files changed, 57 insertions(+), 5 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -75,4 +75,16 @@ void show_ucode_info_early(void);
 static inline void show_ucode_info_early(void) { }
 #endif /* !CONFIG_CPU_SUP_INTEL */
 
+bool microcode_nmi_handler(void);
+
+#ifdef CONFIG_MICROCODE_LATE_LOADING
+DECLARE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
+static __always_inline bool microcode_nmi_handler_enabled(void)
+{
+	return static_branch_unlikely(&microcode_nmi_handler_enable);
+}
+#else
+static __always_inline bool microcode_nmi_handler_enabled(void) { return false; }
+#endif
+
 #endif /* _ASM_X86_MICROCODE_H */
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -23,6 +23,7 @@
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
 #include <linux/firmware.h>
+#include <linux/cpumask.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -31,6 +32,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 
+#include <asm/apic.h>
 #include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
 #include <asm/processor.h>
@@ -334,8 +336,10 @@ struct ucode_ctrl {
 	enum sibling_ctrl	ctrl;
 	enum ucode_state	result;
 	unsigned int		ctrl_cpu;
+	bool			nmi_enabled;
 };
 
+DEFINE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
 static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
 static atomic_t late_cpus_in;
 
@@ -349,7 +353,8 @@ static bool wait_for_cpus(atomic_t *cnt)
 		if (!atomic_read(cnt))
 			return true;
 		udelay(1);
-		if (!(timeout % 1000))
+		/* If invoked directly, tickle the NMI watchdog */
+		if (!microcode_ops->use_nmi && !(timeout % 1000))
 			touch_nmi_watchdog();
 	}
 	/* Prevent the late comers to make progress and let them time out */
@@ -365,7 +370,8 @@ static bool wait_for_ctrl(void)
 		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
 			return true;
 		udelay(1);
-		if (!(timeout % 1000))
+		/* If invoked directly, tickle the NMI watchdog */
+		if (!microcode_ops->use_nmi && !(timeout % 1000))
 			touch_nmi_watchdog();
 	}
 	return false;
@@ -443,7 +449,7 @@ static void ucode_load_primary(unsigned
 	}
 }
 
-static int ucode_load_cpus_stopped(void *unused)
+static bool microcode_update_handler(void)
 {
 	unsigned int cpu = smp_processor_id();
 
@@ -452,7 +458,29 @@ static int ucode_load_cpus_stopped(void
 	else
 		ucode_load_secondary(cpu);
 
-	/* No point to wait here. The CPUs will all wait in stop_machine(). */
+	touch_nmi_watchdog();
+	return true;
+}
+
+bool microcode_nmi_handler(void)
+{
+	if (!this_cpu_read(ucode_ctrl.nmi_enabled))
+		return false;
+
+	this_cpu_write(ucode_ctrl.nmi_enabled, false);
+	return microcode_update_handler();
+}
+
+static int ucode_load_cpus_stopped(void *unused)
+{
+	if (microcode_ops->use_nmi) {
+		/* Enable the NMI handler and raise NMI */
+		this_cpu_write(ucode_ctrl.nmi_enabled, true);
+		apic->send_IPI(smp_processor_id(), NMI_VECTOR);
+	} else {
+		/* Just invoke the handler directly */
+		microcode_update_handler();
+	}
 	return 0;
 }
 
@@ -473,8 +501,14 @@ static int ucode_load_late_stop_cpus(voi
 	 */
 	store_cpu_caps(&prev_info);
 
+	if (microcode_ops->use_nmi)
+		static_branch_enable_cpuslocked(&microcode_nmi_handler_enable);
+
 	stop_machine_cpuslocked(ucode_load_cpus_stopped, NULL, cpu_online_mask);
 
+	if (microcode_ops->use_nmi)
+		static_branch_disable_cpuslocked(&microcode_nmi_handler_enable);
+
 	/* Analyze the results */
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
 		switch (per_cpu(ucode_ctrl.result, cpu)) {
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -688,6 +688,7 @@ static struct microcode_ops microcode_in
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
 static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,7 +31,8 @@ struct microcode_ops {
 	enum ucode_state	(*apply_microcode)(int cpu);
 	int			(*collect_cpu_info)(int cpu, struct cpu_signature *csig);
 	void			(*finalize_late_load)(int result);
-	unsigned int		nmi_safe	: 1;
+	unsigned int		nmi_safe	: 1,
+				use_nmi		: 1;
 };
 
 extern struct ucode_cpu_info ucode_cpu_info[];
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -33,6 +33,7 @@
 #include <asm/reboot.h>
 #include <asm/cache.h>
 #include <asm/nospec-branch.h>
+#include <asm/microcode.h>
 #include <asm/sev.h>
 
 #define CREATE_TRACE_POINTS
@@ -343,6 +344,9 @@ static noinstr void default_do_nmi(struc
 
 	instrumentation_begin();
 
+	if (microcode_nmi_handler_enabled() && microcode_nmi_handler())
+		goto out;
+
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
 	if (handled) {

