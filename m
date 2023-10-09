Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9C7BDBFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376446AbjJIMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376366AbjJIM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251A9F2;
        Mon,  9 Oct 2023 05:29:54 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxFLrT/S6xYeBv+YJUuHfdRiVJpHNvMfpQo6g2ftEjg=;
        b=WNIu727ILvqCqNVqvc/MBxVKzCYq8MBvm3DKdkDFrtIsZvq0kLFh/GT+j1U8dyVdsM5vuq
        ow1sz2UvkY1UqQSCELCAOFWsN10J7TZ67iP9M1g+SUkw7rZno+V81mQ2m/69RTf5xaTBrP
        TLs7dmWtyc+Dzu8X5BvyYOiLDkkHp0KUMuUH0GyIk8Mq/lNflsLBlYP6qwoc4zOmJ0+trw
        xdGALffTREgU1p/HZfBcteFihY92MfV6Jhf23MEDluwBxORqdsX+/h1Glqf1c/DhHhwwEE
        70x4tokLuBj/VKmXPDLC1MLPC9ERa1d17PX8Jru3MKWqv8rQo8rNEkxN/0hi5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wxFLrT/S6xYeBv+YJUuHfdRiVJpHNvMfpQo6g2ftEjg=;
        b=7JVpaHXR/oUtnuZ/1TRQELAqo8q9IIlyrS+80pfZdvAtZSpYu5/K5v35JVG+steYNBrmwx
        +1xjQBT0+JkMj7DQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Rework intel_cpu_collect_info()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.684026662@linutronix.de>
References: <20231002115902.684026662@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685459197.3135.3993869808951318732.tip-bot2@tip-bot2>
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

Commit-ID:     38ab73d770143460b1b85d01ead39cd6eeb857c8
Gitweb:        https://git.kernel.org/tip/38ab73d770143460b1b85d01ead39cd6eeb857c8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:47 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 03 Oct 2023 16:06:07 +02:00

x86/microcode/intel: Rework intel_cpu_collect_info()

Nothing needs struct ucode_cpu_info. Make it take struct cpu_signature,
let it return a boolean and simplify the implementation. Rename it now
that the silly name clash with collect_cpu_info() is gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.684026662@linutronix.de
---
 arch/x86/include/asm/cpu.h            |  4 +--
 arch/x86/kernel/cpu/microcode/intel.c | 33 +++++++-------------------
 drivers/platform/x86/intel/ifs/load.c |  8 ++----
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 3a233eb..4066dd3 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -73,9 +73,9 @@ static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 
 extern __noendbr void cet_disable(void);
 
-struct ucode_cpu_info;
+struct cpu_signature;
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci);
+void intel_collect_cpu_info(struct cpu_signature *sig);
 
 static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 					      unsigned int s2, unsigned int p2)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 84d6edf..fd97cc1 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -66,36 +66,21 @@ static inline unsigned int exttable_size(struct extended_sigtable *et)
 	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
 }
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci)
+void intel_collect_cpu_info(struct cpu_signature *sig)
 {
-	unsigned int val[2];
-	unsigned int family, model;
-	struct cpu_signature csig = { 0 };
-	unsigned int eax, ebx, ecx, edx;
-
-	memset(uci, 0, sizeof(*uci));
-
-	eax = 0x00000001;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	csig.sig = eax;
+	sig->sig = cpuid_eax(1);
+	sig->pf = 0;
+	sig->rev = intel_get_microcode_revision();
 
-	family = x86_family(eax);
-	model  = x86_model(eax);
+	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+		unsigned int val[2];
 
-	if (model >= 5 || family > 6) {
 		/* get processor flags from MSR 0x17 */
 		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
-		csig.pf = 1 << ((val[1] >> 18) & 7);
+		sig->pf = 1 << ((val[1] >> 18) & 7);
 	}
-
-	csig.rev = intel_get_microcode_revision();
-
-	uci->cpu_sig = csig;
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_cpu_collect_info);
+EXPORT_SYMBOL_GPL(intel_collect_cpu_info);
 
 /*
  * Returns 1 if update has been found, 0 otherwise.
@@ -378,7 +363,7 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_cpu_collect_info(uci);
+	intel_collect_cpu_info(&uci->cpu_sig);
 
 	return scan_microcode(cp.data, cp.size, uci);
 }
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index cefd0d8..61174bd 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -227,7 +227,7 @@ out:
 
 static int image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
 {
-	struct ucode_cpu_info uci;
+	struct cpu_signature sig;
 
 	/* Provide a specific error message when loading an older/unsupported image */
 	if (data->hdrver != MC_HEADER_TYPE_IFS) {
@@ -240,11 +240,9 @@ static int image_sanity_check(struct device *dev, const struct microcode_header_
 		return -EINVAL;
 	}
 
-	intel_cpu_collect_info(&uci);
+	intel_collect_cpu_info(&sig);
 
-	if (!intel_find_matching_signature((void *)data,
-					   uci.cpu_sig.sig,
-					   uci.cpu_sig.pf)) {
+	if (!intel_find_matching_signature((void *)data, sig.sig, sig.pf)) {
 		dev_err(dev, "cpu signature, processor flags not matching\n");
 		return -EINVAL;
 	}
