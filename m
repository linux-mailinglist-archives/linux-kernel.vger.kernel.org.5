Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA47CCF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjJQVYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjJQVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E472D72
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:50 -0700 (PDT)
Message-ID: <20231017211722.962868378@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qm9Kw9R9Buar+uEGcw+Q04P//kyP8Ip+yyin4VVf6fc=;
        b=XmHMtSnpUX+/XnUEeYwIHyeTSZ9XYlfLTtpQgfKubNGRb6zp8Gx6aQhapzfBHxjXKoXFgI
        SK7CZWlXN/cqANnwBNXgLJZ5i5cvZVhTY7pCXkVEuKw+6QNrN0O913KxgWNSVRDF0ysvJE
        Qo3mOPCzrKyjmOLIM5Rj+7qKHgYcALOhusz7rHMsdZYzFSxMtq2agEPIP92nl4Rjp8DMFZ
        aobLcIxXT1jIzQTkiqHb+z0pBZhOjPE2ya7G6/G7SU1gioskmKbPGWdJqOuBPdB8hqdjOT
        qTSLpMpYEqbJIEQ6T8Fi3h1a5OfGGjJUYG9YEB94Uj8nd74oHzQbZJrncV6Fow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=qm9Kw9R9Buar+uEGcw+Q04P//kyP8Ip+yyin4VVf6fc=;
        b=wHfhx4u9CZY37OArg4sSHzFlY019s+ETXT8sr+nMiIX6tT2W8fxFtb3yurRM4Kx2F5zFyo
        T2gjTNzWnkUREKCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 18/39] x86/microcode/intel: Rework
 intel_find_matching_signature()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:48 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Take a cpu_signature argument and work from there. Move the match()
helper next to the callsite as there is no point for having it in
a header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu.h            |   16 +---------------
 arch/x86/kernel/cpu/microcode/intel.c |   31 +++++++++++++++++++------------
 drivers/platform/x86/intel/ifs/load.c |    2 +-
 3 files changed, 21 insertions(+), 28 deletions(-)
---
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -77,22 +77,8 @@ struct cpu_signature;
 
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
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -82,29 +82,36 @@ void intel_collect_cpu_info(struct cpu_s
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
@@ -265,7 +272,7 @@ static __init struct microcode_intel *sc
 		    intel_microcode_sanity_check(data, false, MC_HEADER_TYPE_MICROCODE) < 0)
 			break;
 
-		if (!intel_find_matching_signature(data, uci->cpu_sig.sig, uci->cpu_sig.pf))
+		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
 
 		/* Check whether there is newer microcode */
@@ -496,7 +503,7 @@ static enum ucode_state parse_microcode_
 		if (cur_rev >= mc_header.rev)
 			continue;
 
-		if (!intel_find_matching_signature(mc, uci->cpu_sig.sig, uci->cpu_sig.pf))
+		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
 			continue;
 
 		kvfree(new_mc);
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -242,7 +242,7 @@ static int image_sanity_check(struct dev
 
 	intel_collect_cpu_info(&sig);
 
-	if (!intel_find_matching_signature((void *)data, sig.sig, sig.pf)) {
+	if (!intel_find_matching_signature((void *)data, &sig)) {
 		dev_err(dev, "cpu signature, processor flags not matching\n");
 		return -EINVAL;
 	}

