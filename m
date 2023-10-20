Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154507D0EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377355AbjJTLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377268AbjJTLl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:41:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FD10EC;
        Fri, 20 Oct 2023 04:38:28 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Dde4zQ3N/+PNnijr4WGccMsGnFczmEgJNtPZcysd20=;
        b=swWCGNZss8KdC2DKljEGc/8aEksVCUTxqR/fSprUr5h8EtveZZ50wOX+LOAsOUf8XxxdeE
        5NqjlPGdGE7bGUR2VXobTBCnZRSssyGF0gZXY60B5avTgy4fShq35PVvW8zC/vCT168Dbo
        Z5vIhcj+ARsDBWoQFKaHIuxJDG+oiJaOvXkFS2gQ3kF89efZM0JNJ/BJf7pCNOBuYJre9j
        r5Ml6abzImRXm9Pa/CvSfeaFYTUw90i+n1zcGz/8DIf9QBvHjvfn/x/JjaVOSSlW22d/lH
        73zryMro7H8/PxFt2+1zwMdBmuGNAcRVHOVLkb03D76mM+OMTsLZOVrJtq56Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801877;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Dde4zQ3N/+PNnijr4WGccMsGnFczmEgJNtPZcysd20=;
        b=I9Jdf8y8snit8GKfGNsqpcjO4/BGYC1tQJrymtsna2UCS+5qK7454YhdkqatT7NEU1O5uz
        4byu5/9/rD0VmHDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Rework
 intel_find_matching_signature()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.797820205@linutronix.de>
References: <20231002115902.797820205@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187677.3135.561295708089872377.tip-bot2@tip-bot2>
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

Commit-ID:     50b58fd4678dec0b1c948f9e9172d2f30e43b93f
Gitweb:        https://git.kernel.org/tip/50b58fd4678dec0b1c948f9e9172d2f30e43b93f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:35:57 +02:00

x86/microcode/intel: Rework intel_find_matching_signature()

Take a cpu_signature argument and work from there. Move the match()
helper next to the callsite as there is no point for having it in
a header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.797820205@linutronix.de
---
 arch/x86/include/asm/cpu.h            | 16 +-------------
 arch/x86/kernel/cpu/microcode/intel.c | 31 +++++++++++++++-----------
 drivers/platform/x86/intel/ifs/load.c |  2 +-
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 068a07e..fecc4fe 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -75,22 +75,8 @@ struct cpu_signature;
 
 void intel_collect_cpu_info(struct cpu_signature *sig);
 
-static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
-					      unsigned int s2, unsigned int p2)
-{
-	if (s1 != s2)
-		return false;
-
-	/* Processor flags are either both 0 ... */
-	if (!p1 && !p2)
-		return true;
-
-	/* ... or they intersect. */
-	return p1 & p2;
-}
-
 extern u64 x86_read_arch_cap_msr(void);
-int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
+bool intel_find_matching_signature(void *mc, struct cpu_signature *sig);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
 extern struct cpumask cpus_stop_mask;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 134df28..9dffb0c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -82,29 +82,36 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 }
 EXPORT_SYMBOL_GPL(intel_collect_cpu_info);
 
-/*
- * Returns 1 if update has been found, 0 otherwise.
- */
-int intel_find_matching_signature(void *mc, unsigned int csig, int cpf)
+static inline bool cpu_signatures_match(struct cpu_signature *s1, unsigned int sig2,
+					unsigned int pf2)
+{
+	if (s1->sig != sig2)
+		return false;
+
+	/* Processor flags are either both 0 or they intersect. */
+	return ((!s1->pf && !pf2) || (s1->pf & pf2));
+}
+
+bool intel_find_matching_signature(void *mc, struct cpu_signature *sig)
 {
 	struct microcode_header_intel *mc_hdr = mc;
-	struct extended_sigtable *ext_hdr;
 	struct extended_signature *ext_sig;
+	struct extended_sigtable *ext_hdr;
 	int i;
 
-	if (intel_cpu_signatures_match(csig, cpf, mc_hdr->sig, mc_hdr->pf))
-		return 1;
+	if (cpu_signatures_match(sig, mc_hdr->sig, mc_hdr->pf))
+		return true;
 
 	/* Look for ext. headers: */
 	if (get_totalsize(mc_hdr) <= intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE)
-		return 0;
+		return false;
 
 	ext_hdr = mc + intel_microcode_get_datasize(mc_hdr) + MC_HEADER_SIZE;
 	ext_sig = (void *)ext_hdr + EXT_HEADER_SIZE;
 
 	for (i = 0; i < ext_hdr->count; i++) {
-		if (intel_cpu_signatures_match(csig, cpf, ext_sig->sig, ext_sig->pf))
-			return 1;
+		if (cpu_signatures_match(sig, ext_sig->sig, ext_sig->pf))
+			return true;
 		ext_sig++;
 	}
 	return 0;
@@ -265,7 +272,7 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
-		if (!intel_find_matching_signature(data, uci->cpu_sig.sig, uci->cpu_sig.pf))
+		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
 
 		/* Check whether there is newer microcode */
@@ -496,7 +503,7 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
 		if (cur_rev >= mc_header.rev)
 			continue;
 
-		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
+		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
 		kvfree(new_mc);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 61174bd..3e1880f 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -242,7 +242,7 @@ static int image_sanity_check(struct device *dev, const struct microcode_header_
 
 	intel_collect_cpu_info(&sig);
 
-	if (!intel_find_matching_signature((void *)data, sig.sig, sig.pf)) {
+	if (!intel_find_matching_signature((void *)data, &sig)) {
 		dev_err(dev, "cpu signature, processor flags not matching\n");
 		return -EINVAL;
 	}
