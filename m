Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6177B7C99
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjJDJuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjJDJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:50:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD6AF;
        Wed,  4 Oct 2023 02:50:13 -0700 (PDT)
Date:   Wed, 04 Oct 2023 09:50:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696413011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+Hquq4p9x5aU18uy3nvOYLY3cLkgZsdcVdkLw4Pmvc=;
        b=AmTeh0pNThgF31T8RU01UwSp6ZLT91zGMgzSndYYyAr1qUSqBOahJxXnVMsuZEFS7A4Est
        kr1O3psxDHF8LGP+rzVlLq3peTgi14h0HrNIOECBxsiahmHpdruyD2AC9nk5y3CCJPt7OF
        YXlOXCUzvtfmROzfukdOdYDyNic1Ph4FdZwbmMc4SO5yj1wV99sZaUaQte9vhFw3h58ilU
        BOKH593NIzIl+h2tn+75dWLcmLgIMHKt3KGS+dOw9Kr+J2Xpt3v3qriLLupfI1NhWFN3zN
        MqViFPGMTXHxjNzhoxxSBDFPNL2KkRL2fyxk07m6Oqj0jfE8HCo8a4JAKkh/bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696413011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+Hquq4p9x5aU18uy3nvOYLY3cLkgZsdcVdkLw4Pmvc=;
        b=VxaVp3KJARiRU9KSud2bU7TFz10lgnsL3WvRFmUDdHRHsFpvkC+jd36rGTd45QV/D1YfWn
        h02tBCqMQmM8dqBw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Use the GHCB protocol when available for
 SNP CPUID requests
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca5856fa1ebe3879de91a8f6298b6bbd901c61881=2E16905?=
 =?utf-8?q?78565=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ca5856fa1ebe3879de91a8f6298b6bbd901c61881=2E169057?=
 =?utf-8?q?8565=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169641301078.3135.2798822136072186603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6bc6f7d9d7ac3cdbe9e8b0495538b4a0cc11f032
Gitweb:        https://git.kernel.org/tip/6bc6f7d9d7ac3cdbe9e8b0495538b4a0cc11f032
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Fri, 28 Jul 2023 16:09:26 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Oct 2023 14:55:39 +02:00

x86/sev: Use the GHCB protocol when available for SNP CPUID requests

SNP retrieves the majority of CPUID information from the SNP CPUID page.
But there are times when that information needs to be supplemented by the
hypervisor, for example, obtaining the initial APIC ID of the vCPU from
leaf 1.

The current implementation uses the MSR protocol to retrieve the data from
the hypervisor, even when a GHCB exists. The problem arises when an NMI
arrives on return from the VMGEXIT. The NMI will be immediately serviced
and may generate a #VC requiring communication with the hypervisor.

Since a GHCB exists in this case, it will be used. As part of using the
GHCB, the #VC handler will write the GHCB physical address into the GHCB
MSR and the #VC will be handled.

When the NMI completes, processing resumes at the site of the VMGEXIT
which is expecting to read the GHCB MSR and find a CPUID MSR protocol
response. Since the NMI handling overwrote the GHCB MSR response, the
guest will see an invalid reply from the hypervisor and self-terminate.

Fix this problem by using the GHCB when it is available. Any NMI
received is properly handled because the GHCB contents are copied into
a backup page and restored on NMI exit, thus preserving the active GHCB
request or result.

  [ bp: Touchups. ]

Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/sev-shared.c | 69 +++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 2eabccd..dcf325b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -256,7 +256,7 @@ static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
 	return 0;
 }
 
-static int sev_cpuid_hv(struct cpuid_leaf *leaf)
+static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
 {
 	int ret;
 
@@ -279,6 +279,45 @@ static int sev_cpuid_hv(struct cpuid_leaf *leaf)
 	return ret;
 }
 
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	u32 cr4 = native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #UD - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax = ghcb->save.rax;
+	leaf->ebx = ghcb->save.rbx;
+	leaf->ecx = ghcb->save.rcx;
+	leaf->edx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
+		    : __sev_cpuid_hv_msr(leaf);
+}
+
 /*
  * This may be called early while still running on the initial identity
  * mapping. Use RIP-relative addressing to obtain the correct address
@@ -388,19 +427,20 @@ snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
 	return false;
 }
 
-static void snp_cpuid_hv(struct cpuid_leaf *leaf)
+static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
-	if (sev_cpuid_hv(leaf))
+	if (sev_cpuid_hv(ghcb, ctxt, leaf))
 		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
 }
 
-static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
+static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 struct cpuid_leaf *leaf)
 {
 	struct cpuid_leaf leaf_hv = *leaf;
 
 	switch (leaf->fn) {
 	case 0x1:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* initial APIC ID */
 		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
@@ -419,7 +459,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 		break;
 	case 0xB:
 		leaf_hv.subfn = 0;
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->edx = leaf_hv.edx;
@@ -467,7 +507,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
 		}
 		break;
 	case 0x8000001E:
-		snp_cpuid_hv(&leaf_hv);
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
 
 		/* extended APIC ID */
 		leaf->eax = leaf_hv.eax;
@@ -488,7 +528,7 @@ static int snp_cpuid_postprocess(struct cpuid_leaf *leaf)
  * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
  * should be treated as fatal by caller.
  */
-static int snp_cpuid(struct cpuid_leaf *leaf)
+static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
 
@@ -522,7 +562,7 @@ static int snp_cpuid(struct cpuid_leaf *leaf)
 			return 0;
 	}
 
-	return snp_cpuid_postprocess(leaf);
+	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
 }
 
 /*
@@ -544,14 +584,14 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(NULL, NULL, &leaf);
 	if (!ret)
 		goto cpuid_done;
 
 	if (ret != -EOPNOTSUPP)
 		goto fail;
 
-	if (sev_cpuid_hv(&leaf))
+	if (__sev_cpuid_hv_msr(&leaf))
 		goto fail;
 
 cpuid_done:
@@ -848,14 +888,15 @@ static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	return ret;
 }
 
-static int vc_handle_cpuid_snp(struct pt_regs *regs)
+static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
+	struct pt_regs *regs = ctxt->regs;
 	struct cpuid_leaf leaf;
 	int ret;
 
 	leaf.fn = regs->ax;
 	leaf.subfn = regs->cx;
-	ret = snp_cpuid(&leaf);
+	ret = snp_cpuid(ghcb, ctxt, &leaf);
 	if (!ret) {
 		regs->ax = leaf.eax;
 		regs->bx = leaf.ebx;
@@ -874,7 +915,7 @@ static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
 	enum es_result ret;
 	int snp_cpuid_ret;
 
-	snp_cpuid_ret = vc_handle_cpuid_snp(regs);
+	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
 	if (!snp_cpuid_ret)
 		return ES_OK;
 	if (snp_cpuid_ret != -EOPNOTSUPP)
