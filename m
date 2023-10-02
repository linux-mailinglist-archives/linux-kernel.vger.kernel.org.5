Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381A7B5204
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjJBMBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjJBMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD710C7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:00:06 -0700 (PDT)
Message-ID: <20231002115903.489900814@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696248005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8hntDVXvdbfrMrv3R4oy13cuwBY//aEeCSC8iMVq/cg=;
        b=j1UdRNLK1BzsW8/YnZsbunhSovPs9xWF+qMh5by7nrG3qVyqBUEqvGgW/63Dsv40LyJg8/
        mM6r9lCX5j3QPMwML5DLzfvi7o08Chjtj0UCazreAJP7/6wsBWwqO15awKq1t0fBGiSFAW
        KsyEVMXj7vECRuHJonQvjAiy0/20KZk/sfcbIY+0QAuW5gkGJwMpiKXPkmHtvHl/q7dZmQ
        d8U4k/vxPH9+aRymuQliBIb5thukLtXk9ay5a2+pU5quvXi+MDocKphUYDzG1EC6I901yD
        WSUa/oIHcG9YIt8RiZD4+fGuKrvy1EoePazSXnOd8goE8byR6ElAx70b+Fvx0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696248005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=8hntDVXvdbfrMrv3R4oy13cuwBY//aEeCSC8iMVq/cg=;
        b=o0UcQCf96Lr4FjTVJMozT4xtO11RnpwsSfO/yqwXmwXPs4BYCotXryB1HAvIvZzaYwVBFx
        hyrgHrNMy2ZMfXCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 25/30] x86/microcode: Rendezvous and load in NMI
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 14:00:05 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The late loader enables the static branch before stop_machine() is
invoked. Each CPU has an nmi_enable in its control structure which
indicates whether the CPU should go into the update routine.

This is required to bridge the gap between enabling the branch and actually
being at the point where it is required to enter the loader wait loop.

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
@@ -70,4 +70,16 @@ static inline u32 intel_get_microcode_re
 }
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
@@ -294,8 +296,10 @@ struct microcode_ctrl {
 	enum sibling_ctrl	ctrl;
 	enum ucode_state	result;
 	unsigned int		ctrl_cpu;
+	bool			nmi_enabled;
 };
 
+DEFINE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
 static atomic_t late_cpus_in;
 
@@ -311,7 +315,8 @@ static bool wait_for_cpus(atomic_t *cnt)
 
 		udelay(1);
 
-		if (!(timeout % USEC_PER_MSEC))
+		/* If invoked directly, tickle the NMI watchdog */
+		if (!microcode_ops->use_nmi && !(timeout % USEC_PER_MSEC))
 			touch_nmi_watchdog();
 	}
 	/* Prevent the late comers from making progress and let them time out */
@@ -327,7 +332,8 @@ static bool wait_for_ctrl(void)
 		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
 			return true;
 		udelay(1);
-		if (!(timeout % 1000))
+		/* If invoked directly, tickle the NMI watchdog */
+		if (!microcode_ops->use_nmi && !(timeout % 1000))
 			touch_nmi_watchdog();
 	}
 	return false;
@@ -403,7 +409,7 @@ static void load_primary(unsigned int cp
 	}
 }
 
-static int load_cpus_stopped(void *unused)
+static bool microcode_update_handler(void)
 {
 	unsigned int cpu = smp_processor_id();
 
@@ -412,7 +418,29 @@ static int load_cpus_stopped(void *unuse
 	else
 		load_secondary(cpu);
 
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
+static int load_cpus_stopped(void *unused)
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
 
@@ -433,8 +461,14 @@ static int load_late_stop_cpus(void)
 	 */
 	store_cpu_caps(&prev_info);
 
+	if (microcode_ops->use_nmi)
+		static_branch_enable_cpuslocked(&microcode_nmi_handler_enable);
+
 	stop_machine_cpuslocked(load_cpus_stopped, NULL, cpu_online_mask);
 
+	if (microcode_ops->use_nmi)
+		static_branch_disable_cpuslocked(&microcode_nmi_handler_enable);
+
 	/* Analyze the results */
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
 		switch (per_cpu(ucode_ctrl.result, cpu)) {
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -601,6 +601,7 @@ static struct microcode_ops microcode_in
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

