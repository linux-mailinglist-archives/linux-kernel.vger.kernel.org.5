Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0AE79C8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjILH6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjILH6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A56B1722
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:02 -0700 (PDT)
Message-ID: <20230912065501.467154157@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mwSPC6sBO3Mtax7VG/Ayowc5WMyDJfVT9RHyC3osMGE=;
        b=oA2gkW5v4GuBzi/G26ehen714YPvWpaKoetk19ENGTJzeoY/VYc//e6lekJylSeeDH3FH1
        pr2dURiPAk2SjSeG/00Tc2BKsjpOZv+TAvAA14CCTl2pYQqzocyNfcY0b9mBrwXLaJlBzp
        UFW0HbY4xd86eu7IO6mHhq05GSupWYOtaeKYgNzkvtvFutoEqEilCIkZTKag7mXcmqNnnS
        RKk85lkmYNFzUqECEoCdHXwp229FhdDUN0jXCmd/jhZOiGSo0LHKKc5LWHcLszOetzcf9g
        Xi6uHFOGlm3bI66asn1201rPioAbb+ZPTzg7H9yKS1XSHN9T055lJzQ0kfTayw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=mwSPC6sBO3Mtax7VG/Ayowc5WMyDJfVT9RHyC3osMGE=;
        b=bM5+0jXDtcvIORAXYZkEd+WvG4sNwRIP71gTU+S6h950zXuQ3l4L8m6asxopwEAmugncTD
        x1yLfgAc1yxRnoCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 11/30] x86/microcode/intel: Rework intel_cpu_collect_info()
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:00 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing needs struct ucode_cpu_info. Make it take struct cpu_signature, let
it return a boolean and simplify the implementation. Rename it now that the
silly name clash with collect_cpu_info() is gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/cpu.h            |    4 ++--
 arch/x86/kernel/cpu/microcode/intel.c |   33 +++++++++------------------------
 drivers/platform/x86/intel/ifs/load.c |    8 +++-----
 3 files changed, 14 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -73,9 +73,9 @@ static inline void init_ia32_feat_ctl(st
 
 extern __noendbr void cet_disable(void);
 
-struct ucode_cpu_info;
+struct cpu_signature;
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci);
+void intel_collect_cpu_info(struct cpu_signature *sig);
 
 static inline bool intel_cpu_signatures_match(unsigned int s1, unsigned int p1,
 					      unsigned int s2, unsigned int p2)
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -66,36 +66,21 @@ static inline unsigned int exttable_size
 	return et->count * EXT_SIGNATURE_SIZE + EXT_HEADER_SIZE;
 }
 
-int intel_cpu_collect_info(struct ucode_cpu_info *uci)
+void intel_collect_cpu_info(struct cpu_signature *sig)
 {
-	unsigned int val[2];
-	unsigned int family, model;
-	struct cpu_signature csig = { 0 };
-	unsigned int eax, ebx, ecx, edx;
+	sig->sig = cpuid_eax(1);
+	sig->pf = 0;
+	sig->rev = intel_get_microcode_revision();
 
-	memset(uci, 0, sizeof(*uci));
+	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+		unsigned int val[2];
 
-	eax = 0x00000001;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	csig.sig = eax;
-
-	family = x86_family(eax);
-	model  = x86_model(eax);
-
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
@@ -381,7 +366,7 @@ static __init struct microcode_intel *ge
 	if (!(cp.data && cp.size))
 		return NULL;
 
-	intel_cpu_collect_info(uci);
+	intel_collect_cpu_info(&uci->cpu_sig);
 
 	return scan_microcode(cp.data, cp.size, uci);
 }
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -227,7 +227,7 @@ static int scan_chunks_sanity_check(stru
 
 static int image_sanity_check(struct device *dev, const struct microcode_header_intel *data)
 {
-	struct ucode_cpu_info uci;
+	struct cpu_signature sig;
 
 	/* Provide a specific error message when loading an older/unsupported image */
 	if (data->hdrver != MC_HEADER_TYPE_IFS) {
@@ -240,11 +240,9 @@ static int image_sanity_check(struct dev
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

