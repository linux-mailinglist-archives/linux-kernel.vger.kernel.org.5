Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4199177A24A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjHLUBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjHLUBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:01:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AF035A0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:00:54 -0700 (PDT)
Message-ID: <20230812195728.418426203@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+y22VMR8WT7f2YLl6Of8CzpgJMFOpBS1tGm9UJbVhvM=;
        b=3qkG7O9du49WCwiZWAE/U8r2Ob044whhIMYDue7i2qa1KaxhYg5JsWiA4nLTAcd92GcYyV
        TLQ89bLg+s8bYLIi0sixWqTcd3An2plDXov7FQ2LNIfzOakTb+DPa/k+a26vFJOAPOGKFK
        uWiaofo37Jujvjvh6u+RytfjYH2yWIFBDHiJklgbBqlgVta/m5PZzzBozDsFnNvdsg7FdN
        aF4Q6b553bYSP0ZnoChZPBRxy6vyO4jS4uNQnSP+ud75AHBC8Op4YWYctok3T/fo2vw+G4
        fEh4X/Q505XEA651BQKu/WWucfUeKZwsxIYRncYhdYBR3MGP1QGu8fWEh7B2fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+y22VMR8WT7f2YLl6Of8CzpgJMFOpBS1tGm9UJbVhvM=;
        b=SAu5UDCd3BfMexoasNfhtAHe1JuqVk2/ZLkMGc5RHxk3Rnx4fa+1QtmoZ981iQDkao+mGH
        G/OHdGSF9uceRxDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 15/37] x86/microcode/intel: Save the microcode only after a
 successful late-load
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:59 +0200 (CEST)
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
@@ -541,12 +542,9 @@ static enum ucode_state apply_microcode_
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
@@ -666,15 +664,7 @@ static enum ucode_state read_ucode_intel
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
 
@@ -731,10 +721,20 @@ static enum ucode_state request_microcod
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

