Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1A67B51F7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjJBMAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjJBMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5861AE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:52 -0700 (PDT)
Message-ID: <20231002115902.797820205@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Edjc5SXneM2Y7YATZhugxt5CD7O42zD0vvyDzGON3Qo=;
        b=FYWBqoSY5GXWUA06qH9KUcKD01kDPSrjc80iVMpJrUfvNQEP/c+ZB3FgehcCdrXTzy1ElL
        1n9Yh1UKCYr8UhVFAmA2pnUoArRGg9g1NziyayhhBCj0MRzVAk8bR5nFMkj41fjwEIlHuy
        UpNWvNjhb/E3nLXwRvL3G/NkjX0zHtxEvSpKTKvjYARyUjA3TBiWU8hZgPKVIiE064o7uM
        PAVZZ5hQyC/S4cQC0VdRgLrQHi/2IhtD5KytwArIYpeHkk6Zwn0VOtB+/wqY5ZswTYcc49
        LOZhux9cHgACTKuNoQaEuR1nke17mqkcyYQE8kxcRrT0qMQmDU1VKZdbKZwRIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Edjc5SXneM2Y7YATZhugxt5CD7O42zD0vvyDzGON3Qo=;
        b=k/iqOT8qBEo9Y7t90O1resES/FxwmjKxD73vqLztEXcR+99XCAF05HAcDqOfdLEHuMa+cu
        QqHIucSVXLyxw2AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 13/30] x86/microcode/intel: Rework
 intel_find_matching_signature()
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:50 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take a cpu_signature argument and work from there. Move the match() helper
next to the callsite as there is no point for having it in a header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/cpu.h            |   16 +---------------
 arch/x86/kernel/cpu/microcode/intel.c |   31 +++++++++++++++++++------------
 drivers/platform/x86/intel/ifs/load.c |    2 +-
 3 files changed, 21 insertions(+), 28 deletions(-)

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
@@ -502,7 +509,7 @@ static enum ucode_state parse_microcode_
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

