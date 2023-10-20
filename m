Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E17D0EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377343AbjJTLkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377218AbjJTLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:40:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2E2D50;
        Fri, 20 Oct 2023 04:38:33 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Z+Xf1HWij3PGSMHsuadRrHlnMgQr68v7RxfDYbFLiI=;
        b=Sk/P9pXtsIGKI4iKp1fuXqdGyYzDVwxgG09G1EOYDicNdrhIDKOYLEfbOF79+WMgQYyCXj
        EfoLMPaqvQCj6duED/Z8y1eGcOBc9wfEAfGucSUpNFiMcVH2LbjKbNZkl6CrbnH3gGJ5Uw
        VvTtvj9xNIj4o3JRBZIIUont4r8WJzXIFepbXSrOKIIM75qw+ptPgYtMG4xoB2w9XpzNpm
        aKPxfNE2LvjNCXNdJbvNfhALBETSAdoFXzUpVUg3PcEn9/WPDQPdNtkt2nPhHr4KBid4EJ
        fkhGGj8NvvyUg4uekz04bCckDrhr/c3yftO+pqMUbsapOOnFW1tA2TTb9IJh1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Z+Xf1HWij3PGSMHsuadRrHlnMgQr68v7RxfDYbFLiI=;
        b=g6XrqxK7F+omBPEcq9yLmWC/r9YCZ0X/h5y2BjE0M3/bGymbmK/r8u7eVLWCkwvzGMwQaN
        Em+Ced4itRzrXuCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Cleanup code further
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.389400871@linutronix.de>
References: <20231002115902.389400871@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188065.3135.7928004054471571540.tip-bot2@tip-bot2>
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

Commit-ID:     0177669ee61de4dc641f9ad86a3df6f22327cf6c
Gitweb:        https://git.kernel.org/tip/0177669ee61de4dc641f9ad86a3df6f22327cf6c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 14:10:50 +02:00

x86/microcode/intel: Cleanup code further

Sanitize the microcode scan loop, fixup printks and move the loading
function for builtin microcode next to the place where it is used and mark
it __init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.389400871@linutronix.de
---
 arch/x86/kernel/cpu/microcode/intel.c | 76 ++++++++++----------------
 1 file changed, 32 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 9463b14..d6ff6eb 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -36,7 +36,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 static struct microcode_intel *intel_ucode_patch __read_mostly;
 
 /* last level cache size per core */
-static int llc_size_per_core __ro_after_init;
+static unsigned int llc_size_per_core __ro_after_init;
 
 /* microcode format is extended from prescott processors */
 struct extended_signature {
@@ -294,29 +294,6 @@ static struct microcode_intel *scan_microcode(void *data, size_t size,
 	return patch;
 }
 
-static bool load_builtin_intel_microcode(struct cpio_data *cp)
-{
-	unsigned int eax = 1, ebx, ecx = 0, edx;
-	struct firmware fw;
-	char name[30];
-
-	if (IS_ENABLED(CONFIG_X86_32))
-		return false;
-
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	sprintf(name, "intel-ucode/%02x-%02x-%02x",
-		      x86_family(eax), x86_model(eax), x86_stepping(eax));
-
-	if (firmware_request_builtin(&fw, name)) {
-		cp->size = fw.size;
-		cp->data = (void *)fw.data;
-		return true;
-	}
-
-	return false;
-}
-
 static int apply_microcode_early(struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc;
@@ -360,6 +337,28 @@ static int apply_microcode_early(struct ucode_cpu_info *uci)
 	return 0;
 }
 
+static bool load_builtin_intel_microcode(struct cpio_data *cp)
+{
+	unsigned int eax = 1, ebx, ecx = 0, edx;
+	struct firmware fw;
+	char name[30];
+
+	if (IS_ENABLED(CONFIG_X86_32))
+		return false;
+
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	sprintf(name, "intel-ucode/%02x-%02x-%02x",
+		x86_family(eax), x86_model(eax), x86_stepping(eax));
+
+	if (firmware_request_builtin(&fw, name)) {
+		cp->size = fw.size;
+		cp->data = (void *)fw.data;
+		return true;
+	}
+	return false;
+}
+
 int __init save_microcode_in_initrd_intel(void)
 {
 	struct ucode_cpu_info uci;
@@ -432,25 +431,16 @@ void load_ucode_intel_ap(void)
 	apply_microcode_early(&uci);
 }
 
-/* Accessor for microcode pointer */
-static struct microcode_intel *ucode_get_patch(void)
-{
-	return intel_ucode_patch;
-}
-
 void reload_ucode_intel(void)
 {
-	struct microcode_intel *p;
 	struct ucode_cpu_info uci;
 
 	intel_cpu_collect_info(&uci);
 
-	p = ucode_get_patch();
-	if (!p)
+	uci.mc = intel_ucode_patch;
+	if (!uci.mc)
 		return;
 
-	uci.mc = p;
-
 	apply_microcode_early(&uci);
 }
 
@@ -488,8 +478,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	/* Look for a newer patch in our cache: */
-	mc = ucode_get_patch();
+	mc = intel_ucode_patch;
 	if (!mc) {
 		mc = uci->mc;
 		if (!mc)
@@ -680,18 +669,17 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 }
 
 static struct microcode_ops microcode_intel_ops = {
-	.request_microcode_fw             = request_microcode_fw,
-	.collect_cpu_info                 = collect_cpu_info,
-	.apply_microcode                  = apply_microcode_intel,
+	.request_microcode_fw	= request_microcode_fw,
+	.collect_cpu_info	= collect_cpu_info,
+	.apply_microcode	= apply_microcode_intel,
 };
 
-static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
+static __init void calc_llc_size_per_core(struct cpuinfo_x86 *c)
 {
 	u64 llc_size = c->x86_cache_size * 1024ULL;
 
 	do_div(llc_size, c->x86_max_cores);
-
-	return (int)llc_size;
+	llc_size_per_core = (unsigned int)llc_size;
 }
 
 struct microcode_ops * __init init_intel_microcode(void)
@@ -704,7 +692,7 @@ struct microcode_ops * __init init_intel_microcode(void)
 		return NULL;
 	}
 
-	llc_size_per_core = calc_llc_size_per_core(c);
+	calc_llc_size_per_core(c);
 
 	return &microcode_intel_ops;
 }
