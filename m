Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480887CCF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjJQVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344339AbjJQVYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:24:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED70D61
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:47 -0700 (PDT)
Message-ID: <20231017211722.851573238@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=in5lcKaTOq2HRl8ZSeTrcUYrMkDHoeYPGl+VTJIKes4=;
        b=gWD0lue8AJsGoo3Y/f9fKOe0tceQEpea/1nTuArLacGMnesihAdO3oOm6hbY2k7UCXSo5O
        tV86JDLIc9/qUDMMPbyI+3Qr73vazqBoQr6tnD08uX4GUStQkhdNsBIXYwUiCCu10ANNqr
        w+H658VpJGBvIvCHC4aL2UdPmTkcCAOtFQO++A09MZVXhWvDWM2enfP+7HsNEIhZPwzDOF
        5F11jKkItXBrnBKxbb6tmL1uoidWITzgFzFnpMI7y1LxqHrGvpPkW6EQL5xKzJm1nvd1Rh
        egDmjXI4ZtuSFk5cupFw3+nC7C2aE6eU30xnILmvchyFqsOsx+tRqrTJP8uoJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=in5lcKaTOq2HRl8ZSeTrcUYrMkDHoeYPGl+VTJIKes4=;
        b=NSMFh03MLvfkQPxlPk3XwByCUecGsitnqZV1otjx6vAWvGjq2wtB12X9b+Tr75RY2IeAYU
        gJUP07pTGbBiY6Bw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 16/39] x86/microcode/intel: Rework intel_cpu_collect_info()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:45 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Nothing needs struct ucode_cpu_info. Make it take struct cpu_signature,
let it return a boolean and simplify the implementation. Rename it now
that the silly name clash with collect_cpu_info() is gone.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu.h            |    4 ++--
 arch/x86/kernel/cpu/microcode/intel.c |   33 +++++++++------------------------
 drivers/platform/x86/intel/ifs/load.c |    8 +++-----
 3 files changed, 14 insertions(+), 31 deletions(-)
---
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
@@ -378,7 +363,7 @@ static __init struct microcode_intel *ge
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

