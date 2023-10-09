Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B87BDBF0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376374AbjJIMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376365AbjJIM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195099;
        Mon,  9 Oct 2023 05:29:48 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=110FOAg7u0jIfscfrSJJkdKxv2EEQsYa7hGr4AHWH4Q=;
        b=eq+xm8TeoeoISWN7tGntDDxHwjwguuGfeRaWlyjaNTPmEpQK77KcIsgcQkKM24pqypUEM0
        9eiFmVEFnbCEUYzI3YQMYLWQ5T6nUTFzNJJ4Bq4STldSn6TwgEQGjENZqten8yay8YYJrM
        aOCqIhG/mpwAiiR3Sl30UsPpu3e6DC7JE+kHx7TpoM3OYIxm3v2W45R04qe7g5gCsGQ5LE
        D6RFMF4fg9MZwH689wFADyG321TzHf69Z+SZO00CS9/S6IrYNIfD1PTFq5lrFb/ZVgZc/u
        FOsjOS4b0kuN2K+bjYmuT4T8jvzg1yEim8R+2r+kJ1xHpwwrQp96G4K1vW9Wgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=110FOAg7u0jIfscfrSJJkdKxv2EEQsYa7hGr4AHWH4Q=;
        b=wZDvbbB+RlaJww1czscrE1lukDCa0CfM2FfFGcSEip277pFv0B28DdQ8lXJ4/eCrfxpVVn
        9Mlaf+WJNHtkgMDQ==
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
Message-ID: <169685458548.3135.16488160326632297844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     0d834131052b702d74ed93c86678f76cc5ad6a62
Gitweb:        https://git.kernel.org/tip/0d834131052b702d74ed93c86678f76cc5ad6a62
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:24 +02:00

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
index 65ac490..48520fd 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -70,4 +70,16 @@ static inline u32 intel_get_microcode_revision(void)
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
index ae23214..083bca8 100644
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
@@ -403,7 +409,7 @@ static void load_primary(unsigned int cpu)
 	}
 }
 
-static int load_cpus_stopped(void *unused)
+static bool microcode_update_handler(void)
 {
 	unsigned int cpu = smp_processor_id();
 
@@ -412,7 +418,29 @@ static int load_cpus_stopped(void *unused)
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
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index ef699da..8d03ad5 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -602,6 +602,7 @@ static struct microcode_ops microcode_intel_ops = {
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_late,
 	.finalize_late_load	= finalize_late_load,
+	.use_nmi		= IS_ENABLED(CONFIG_X86_64),
 };
 
 static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index f89bbac..f49e6c7 100644
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
