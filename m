Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199A0778068
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjHJSic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjHJSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBA2D6A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:54 -0700 (PDT)
Message-ID: <20230810160805.820089154@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oSYfLPVAEKLCJDbK3ZycsrF15tTYnGwu79YnPv4mZKw=;
        b=B/8KLpQbuMWO+LvmF9cNWuXYj1zGFG1HIP84of6JxLmX2E5zt93ZrSIuVTdeDr+aqgSavI
        +JgIidaZ6v5dXq54c67QieyPKAfP0GK6XsTDGZjgTrTivHMc2SlnuR3gf5OVs0yVnUUvUV
        Udh6KStg/tfbYaHBj1En6DoIWv2QjI4wjMBsGGpwu7yoOO8h0hEZQDtHyxhgY0lJthDf4t
        lFjborFKjLC3LYPbtmZcIpiouIPpjbDm00XCCcd3fGfJzm3yfS7BHTkSrI2roKnHCnDdIy
        brxaF+yfeB4A4mZZAjNPpjXXXSCFDqo0nen2Xbdmh16ZlkoJSgpWEE3lLH0Jrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oSYfLPVAEKLCJDbK3ZycsrF15tTYnGwu79YnPv4mZKw=;
        b=cf1Qav5FAt+S1+JW9szRZVMoitsJsAU4pksiWwmnm99/+JS44/EXVC1tcg1G7CbZ2TMdQ+
        HKNH4uHfNiiiAKDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 15/30] x86/microcode/intel: Save the microcode only after a
 successful late-load
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:48 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

There are situations where the late microcode is loaded into memory, but is
not applied:

  1) The rendevouz fails
  2) The microcode is rejected by the CPUs

If any of this happens then the pointer which was updated at firmware load
time is stale and subsequent CPU hotplug operations either fail to update
or create inconsistent microcode state.

Save the loaded microcode in a separate pointer from with the late load is
attempted and when successful, update the hotplug pointer accordingly via a
new micrcode_ops callback.

Remove the pointless fallback in the loader to a microcode pointer which is
never populated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c     |    4 ++++
 arch/x86/kernel/cpu/microcode/intel.c    |   30 +++++++++++++++---------------
 arch/x86/kernel/cpu/microcode/internal.h |    1 +
 3 files changed, 20 insertions(+), 15 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -443,6 +443,10 @@ static int microcode_reload_late(void)
 	store_cpu_caps(&prev_info);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+
+	if (microcode_ops->finalize_late_load)
+		microcode_ops->finalize_late_load(ret);
+
 	if (!ret) {
 		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
 			old, boot_cpu_data.microcode);
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -34,6 +34,7 @@ static const char ucode_path[] = "kernel
 
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
+static struct microcode_intel *ucode_patch_late __read_mostly;
 
 /* last level cache size per core */
 static unsigned int llc_size_per_core __ro_after_init;
@@ -517,12 +518,9 @@ static enum ucode_state apply_microcode_
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	mc = ucode_patch_va;
-	if (!mc) {
-		mc = uci->mc;
-		if (!mc)
-			return UCODE_NFOUND;
-	}
+	mc = ucode_patch_late;
+	if (!mc)
+		return UCODE_NFOUND;
 
 	/*
 	 * Save us the MSR write below - which is a particular expensive
@@ -642,15 +640,7 @@ static enum ucode_state read_ucode_intel
 	if (!new_mc)
 		return UCODE_NFOUND;
 
-	/* Save for CPU hotplug */
-	save_microcode_patch((struct microcode_intel *)new_mc);
-	uci->mc = ucode_patch_va;
-
-	vfree(new_mc);
-
-	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
-		 cpu, cur_rev, uci->cpu_sig.rev);
-
+	ucode_patch_late = (struct microcode_intel *)new_mc;
 	return UCODE_NEW;
 }
 
@@ -707,10 +697,20 @@ static enum ucode_state request_microcod
 	return ret;
 }
 
+static void finalize_late_load(int result)
+{
+	if (!result)
+		save_microcode_patch(ucode_patch_late);
+
+	vfree(ucode_patch_late);
+	ucode_patch_late = NULL;
+}
+
 static struct microcode_ops microcode_intel_ops = {
 	.request_microcode_fw	= request_microcode_fw,
 	.collect_cpu_info	= collect_cpu_info,
 	.apply_microcode	= apply_microcode_intel,
+	.finalize_late_load	= finalize_late_load,
 };
 
 static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,6 +31,7 @@ struct microcode_ops {
 	 */
 	enum ucode_state (*apply_microcode)(int cpu);
 	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
+	void (*finalize_late_load)(int result);
 };
 
 extern struct ucode_cpu_info ucode_cpu_info[];

