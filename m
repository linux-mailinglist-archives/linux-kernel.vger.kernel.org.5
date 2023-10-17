Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF97CCF25
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjJQVYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbjJQVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0044129
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:38 -0700 (PDT)
Message-ID: <20231017211722.517552303@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=boldlZsu3iXRBUur5KXLfTWW2rgpdymImyUkM2N8NEs=;
        b=ZN0wB1Sa3PhA3W/8di2L5k23vnAsdRL/uAdcWAyMg5lpX5uasXVvBXxjW939++yM9IKIiV
        YJadtQvxxot3QsHrmTkZpd5cLzeqR4bw5Qh8Y5qywBjisNcAQ+9YxU3xsJywo1PrSwnZfV
        0aPn2D3556zMp5DKC9OuDprK46vMq/Qju4mBaD3BCP4SzwlBBLFYS5juL8F4BO0Uj8ZR4O
        41A8fBQhtMMUsIRRva6OBnT1t1Cnqu1eaMv62RIFxxTiygmVI4+Kw1ft2VC0yFwvF0WypX
        qSKZ0oWvxHWrbjnqMtpWCjJamPOrZAHdrm7bOIG31Tw3rFyJSV0XEaLaOvJ26w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=boldlZsu3iXRBUur5KXLfTWW2rgpdymImyUkM2N8NEs=;
        b=+n2LCZfCJidgtFyJOpagqxmlTf7NeiRt2sSo7JIoCqBxGZkWF/Jr44VE7JIidvGpqb7oDH
        l4T/AF7BsLStLEBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 10/39] x86/microcode/intel: Simplify and rename
 generic_load_microcode()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:36 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

so it becomes less obfuscated and rename it because there is nothing
generic about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/intel.c | 47 +++++++++++++-----------------------
 1 file changed, 17 insertions(+), 30 deletions(-)
---
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 24dd4835d544..60862f6c0ded 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -240,19 +240,6 @@ int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type)
 }
 EXPORT_SYMBOL_GPL(intel_microcode_sanity_check);
 
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
-static int has_newer_microcode(void *mc, unsigned int csig, int cpf, int new_rev)
-{
-	struct microcode_header_intel *mc_hdr = mc;
-
-	if (mc_hdr->rev <= new_rev)
-		return 0;
-
-	return intel_find_matching_signature(mc, csig, cpf);
-}
-
 static void save_microcode_patch(void *data, unsigned int size)
 {
 	struct microcode_header_intel *p;
@@ -561,14 +548,12 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
+static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
-	enum ucode_state ret = UCODE_OK;
-	int new_rev = uci->cpu_sig.rev;
+	int cur_rev = uci->cpu_sig.rev;
 	u8 *new_mc = NULL, *mc = NULL;
-	unsigned int csig, cpf;
 
 	while (iov_iter_count(iter)) {
 		struct microcode_header_intel mc_header;
@@ -585,6 +570,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 			pr_err("error! Bad data in microcode data file (totalsize too small)\n");
 			break;
 		}
+
 		data_size = mc_size - sizeof(mc_header);
 		if (data_size > iov_iter_count(iter)) {
 			pr_err("error! Bad data in microcode data file (truncated file?)\n");
@@ -607,16 +593,17 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 			break;
 		}
 
-		csig = uci->cpu_sig.sig;
-		cpf = uci->cpu_sig.pf;
-		if (has_newer_microcode(mc, csig, cpf, new_rev)) {
-			vfree(new_mc);
-			new_rev = mc_header.rev;
-			new_mc  = mc;
-			new_mc_size = mc_size;
-			mc = NULL;	/* trigger new vmalloc */
-			ret = UCODE_NEW;
-		}
+		if (cur_rev >= mc_header.rev)
+			continue;
+
+		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
+			continue;
+
+		vfree(new_mc);
+		cur_rev = mc_header.rev;
+		new_mc  = mc;
+		new_mc_size = mc_size;
+		mc = NULL;
 	}
 
 	vfree(mc);
@@ -636,9 +623,9 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 	save_microcode_patch(new_mc, new_mc_size);
 
 	pr_debug("CPU%d found a matching microcode update with version 0x%x (current=0x%x)\n",
-		 cpu, new_rev, uci->cpu_sig.rev);
+		 cpu, cur_rev, uci->cpu_sig.rev);
 
-	return ret;
+	return UCODE_NEW;
 }
 
 static bool is_blacklisted(unsigned int cpu)
@@ -687,7 +674,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, firmware->size);
-	ret = generic_load_microcode(cpu, &iter);
+	ret = parse_microcode_blobs(cpu, &iter);
 
 	release_firmware(firmware);
 

