Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B067D51AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343525AbjJXNX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbjJXNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:22:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7411721;
        Tue, 24 Oct 2023 06:21:10 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698153668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RT1+0kU05/586+93A6K9akABUi1K/NeShAB9w46Uwo=;
        b=xtY8xsSL52B2LPZIrBWPyaT5+lyTGS7VQQznoEQiYDBOJD6Zy1nVfXiznvMx4fNQmjuxpL
        LnG1c8DbnJpXevfds92qf7IV6Slr5F0icxKSNj39gZzcX6n/iISE8p3+9Heuxw8ve/812O
        7hWLrHzLadiBuUB/mRlf1+SkpY7R9+578zNZKhWdp14nHoE27+7uq8INqoYEYNhr9rjAms
        88e8pM/lmXjgSsLe9b+FTPQnlKd+rNGLN2tvx4wyY+sSe12C3EyBz1QtkIt/vgKUeNGMlt
        4bzMQ3hf0XJJ0XDbS2NFc8I5f8Zs/igvy5rBiteCHvParMzw1mzeq/bpL1uo3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698153668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3RT1+0kU05/586+93A6K9akABUi1K/NeShAB9w46Uwo=;
        b=OxOPkvAcno+GNCHxIFkuxN+ZeMCMvUKOTVSAcb0tWcZo5v9pKwWbU8sida1aViTXVpp0YK
        xgO8hyf9O/20qUBw==
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
Message-ID: <169815366759.3135.9884743289182643408.tip-bot2@tip-bot2>
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

Commit-ID:     2a1dada3d1cf8f80a27663653a371d99dbf5d540
Gitweb:        https://git.kernel.org/tip/2a1dada3d1cf8f80a27663653a371d99dbf5d540
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:44 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 24 Oct 2023 15:05:53 +02:00

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
index de3eb97..2b742fe 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -397,6 +397,10 @@ static int microcode_reload_late(void)
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
index 9b66144..076133b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -36,6 +36,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
+static struct microcode_intel *ucode_patch_late __read_mostly;
 
 /* last level cache size per core */
 static unsigned int llc_size_per_core __ro_after_init;
@@ -470,12 +471,9 @@ static enum ucode_state apply_microcode_intel(int cpu)
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
@@ -594,15 +592,7 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
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
 
@@ -659,10 +649,20 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
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
index 1cfc6ec..32f6ad5 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -31,6 +31,7 @@ struct microcode_ops {
 	 */
 	enum ucode_state (*apply_microcode)(int cpu);
 	int (*collect_cpu_info)(int cpu, struct cpu_signature *csig);
+	void (*finalize_late_load)(int result);
 };
 
 extern struct ucode_cpu_info ucode_cpu_info[];
