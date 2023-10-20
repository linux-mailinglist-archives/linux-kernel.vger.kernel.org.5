Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67F57D0ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbjJTLjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377225AbjJTLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6610DF;
        Fri, 20 Oct 2023 04:38:04 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqsrCiEYSGeCDn1ja0TvVqQlLDSZTHMm0bv3Pbnyo/k=;
        b=l24g0Y0mcULazRSOL17m0Rf743416j/+3Q781oV+IX1CDSlB/HNl5thiEUmt5lxuK3GwvM
        /ErLreamRpF/PGUMpFh3jrSItLbBXhQpl5K+NDPFgeKC/bqYSWtEv1u+CK3P87B0fXzGR2
        /jIvbIBub9wkgXS4L1gskYnsqMJM51qw4v69COx+P1tQ4P+3tVI0MSSJbp7PvDmnNm+slt
        JfTO0uTkK1J16rasoiatKHb9/1fX/umV/LzfIlMUMVQZexp2tReabpoozL8t58JuQacSlS
        5ftxjFYm0n4X8Jfp5aBo37ss0xmXsae1kdsbOUpx13gTX2Re8Ws4vnkNl0q5PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqsrCiEYSGeCDn1ja0TvVqQlLDSZTHMm0bv3Pbnyo/k=;
        b=BhGKHevD73Y7LQho+vk3/nDutfR14IGkRx1p6vD75xjq60aLH1C0ERYKaQhu4ER5+xe97L
        fVWCLQLMkvngyFAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Rendezvous and load in NMI
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.489900814@linutronix.de>
References: <20231002115903.489900814@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780186816.3135.11385598800295455799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     8858b12182058468542cb5d0a4587895f6ec473c
Gitweb:        https://git.kernel.org/tip/8858b12182058468542cb5d0a4587895f6ec473c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:59:38 +02:00

x86/microcode: Rendezvous and load in NMI

stop_machine() does not prevent the spin-waiting sibling from handling
an NMI, which is obviously violating the whole concept of rendezvous.

Implement a static branch right in the beginning of the NMI handler
which is nopped out except when enabled by the late loading mechanism.

The late loader enables the static branch before stop_machine() is
invoked. Each CPU has an nmi_enable in its control structure which
indicates whether the CPU should go into the update routine.

This is required to bridge the gap between enabling the branch and
actually being at the point where it is required to enter the loader
wait loop.

Each CPU which arrives in the stopper thread function sets that flag and
issues a self NMI right after that. If the NMI function sees the flag
clear, it returns. If it's set it clears the flag and enters the
rendezvous.

This is safe against a real NMI which hits in between setting the flag
and sending the NMI to itself. The real NMI will be swallowed by the
microcode update and the self NMI will then let stuff continue.
Otherwise this would end up with a spurious NMI.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.489900814@linutronix.de
---
 arch/x86/include/asm/microcode.h         | 12 +++++++-
 arch/x86/kernel/cpu/microcode/core.c     | 42 ++++++++++++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c    |  1 +-
 arch/x86/kernel/cpu/microcode/internal.h |  3 +-
 arch/x86/kernel/nmi.c                    |  4 ++-
 5 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 78f1eb2..8292482 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -72,4 +72,16 @@ static inline u32 intel_get_microcode_revision(void)
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
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 1c2710b..7b8ade5 100644
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
@@ -265,8 +267,10 @@ struct microcode_ctrl {
 	enum sibling_ctrl	ctrl;
 	enum ucode_state	result;
 	unsigned int		ctrl_cpu;
+	bool			nmi_enabled;
 };
 
+DEFINE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
 static atomic_t late_cpus_in;
 
@@ -282,7 +286,8 @@ static bool wait_for_cpus(atomic_t *cnt)
 
 		udelay(1);
 
-		if (!(timeout % USEC_PER_MSEC))
+		/* If invoked directly, tickle the NMI watchdog */
+		if (!microcode_ops->use_nmi && !(timeout % USEC_PER_MSEC))
 			touch_nmi_watchdog();
 	}
 	/* Prevent the late comers from making progress and let them time out */
@@ -298,7 +303,8 @@ static bool wait_for_ctrl(void)
 		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
 			return true;
 		udelay(1);
-		if (!(timeout % 1000))
+		/* If invoked directly, tickle the NMI watchdog */
+		if (!microcode_ops->use_nmi && !(timeout % 1000))
 			touch_nmi_watchdog();
 	}
 	return false;
@@ -374,7 +380,7 @@ static void load_primary(unsigned int cpu)
 	}
 }
 
-static int load_cpus_stopped(void *unused)
+static bool microcode_update_handler(void)
 {
 	unsigned int cpu = smp_processor_id();
 
@@ -383,7 +389,29 @@ static int load_cpus_stopped(void *unused)
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
 
@@ -404,8 +432,14 @@ static int load_late_stop_cpus(void)
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
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 9dffb0c..5c4c2b6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -595,6 +595,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
 static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index c699043..627d238 100644
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
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index a0c5518..a87d856 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -33,6 +33,7 @@
 #include <asm/reboot.h>
 #include <asm/cache.h>
 #include <asm/nospec-branch.h>
+#include <asm/microcode.h>
 #include <asm/sev.h>
 
 #define CREATE_TRACE_POINTS
@@ -343,6 +344,9 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 
 	instrumentation_begin();
 
+	if (microcode_nmi_handler_enabled() && microcode_nmi_handler())
+		goto out;
+
 	handled = nmi_handle(NMI_LOCAL, regs);
 	__this_cpu_add(nmi_stats.normal, handled);
 	if (handled) {
