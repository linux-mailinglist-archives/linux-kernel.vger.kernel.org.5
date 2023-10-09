Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B007BDC02
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376660AbjJIMbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376441AbjJIMaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:30:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F45BFF;
        Mon,  9 Oct 2023 05:29:55 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sz2ng7ugJ2McXeNm4hHr3Jvo6nokt73rbNPX1El6YdY=;
        b=GegtX2hSEfBLjE0sFBP+t3GQdTxDkVtT1T6BcDXuYb1CEs69Sk0V7E2sJgnZARRyTTukHe
        /X9/ilTJxf/uAJ6n1NE0dGcd1i8cmFWOdeNls7JlK63iDCyGLDWda2yCHfUDMuElTGMxQt
        B2a86/yv2V0umjwuoHGg87swsRfTEOWJaT1QAZepy74+3yyUGiZbLBJNe2D2a8i0ClEdTt
        ZbogifdFz3v8X3YwimQPi0IHqW6SBMpWZIsLxioeJG2mrmJsHFH36BUzGUAY15tjxXBf4T
        cptoCg53zsrvANsNBYu7gwP5BSyGY+noxSQGZiF1xAUCLQaCBvGP8v3hxbvipQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sz2ng7ugJ2McXeNm4hHr3Jvo6nokt73rbNPX1El6YdY=;
        b=jr5wrOnb8Ik6rWl1GLo8PvSS7UBT/n3B+0pE6Rdv3+pqffTBslZVlnb0gFG9oLxhnjcF2g
        je63AkqvBsqsptAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Save the microcode only
 after a successful late-load
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.505491309@linutronix.de>
References: <20231002115902.505491309@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459342.3135.578180378589368912.tip-bot2@tip-bot2>
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

Commit-ID:     ed1a85d984ac1543349da617dce65f4190839f9f
Gitweb:        https://git.kernel.org/tip/ed1a85d984ac1543349da617dce65f4190839f9f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:44 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 03 Oct 2023 15:58:25 +02:00

x86/microcode/intel: Save the microcode only after a successful late-load

There are situations where the late microcode is loaded into memory but
is not applied:

  1) The rendezvous fails
  2) The microcode is rejected by the CPUs

If any of this happens then the pointer which was updated at firmware
load time is stale and subsequent CPU hotplug operations either fail to
update or create inconsistent microcode state.

Save the loaded microcode in a separate pointer before the late load is
attempted and when successful, update the hotplug pointer accordingly
via a new microcode_ops callback.

Remove the pointless fallback in the loader to a microcode pointer which
is never populated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.505491309@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c     |  4 +++-
 arch/x86/kernel/cpu/microcode/intel.c    | 30 +++++++++++------------
 arch/x86/kernel/cpu/microcode/internal.h |  1 +-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 5d8ac8b..0d99d5e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -400,6 +400,10 @@ static int microcode_reload_late(void)
 	store_cpu_caps(&prev_info);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+
+	if (microcode_ops->finalize_late_load)
+		microcode_ops->finalize_late_load(ret);
+
 	if (!ret) {
 		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
 			old, boot_cpu_data.microcode);
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a80c019..2d88929 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -34,6 +34,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
+static struct microcode_intel *ucode_patch_late __read_mostly;
 
 /* last level cache size per core */
 static unsigned int llc_size_per_core __ro_after_init;
@@ -461,12 +462,9 @@ static enum ucode_state apply_microcode_intel(int cpu)
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
@@ -585,15 +583,7 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
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
 
@@ -650,10 +640,20 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
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
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 1033176..051b795 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,6 +31,7 @@ struct microcode_ops {
 	 */
 	enum ucode_state (*apply_microcode)(int cpu);
 	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
+	void (*finalize_late_load)(int result);
 };
 
 extern struct ucode_cpu_info ucode_cpu_info[];
