Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2E57CCF21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbjJQVXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbjJQVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F152BC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:29 -0700 (PDT)
Message-ID: <20231017211722.175910753@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/Fup+VDAYBco9fVZ163AiwHqyzSBNFBZQllA3x1jvOc=;
        b=Y1/Hubca5qv1by3FanlczuXuft9wkvbELw+hPuI/XupeD8OjEvlq22ectfJ8+4Su0NyBrQ
        ONAeYHZ3DX3vnIk74h59foe9eA9p4CUNXNs7UHvCzKrgXIDf6HB7+PEW0zo3YW2vL4yRnD
        sVnvPFU92d5KYQs/UctkSlR8/OduYtbrms1BHRhdVHBS3E9JFlyN/FgCeFtLtVywFjiP5Z
        HsNoyqpHugWLI9dR5fKepTd78h0+fV2w+mkO6hWpJPR8Jo0eFejy1i/BWyHZh8Dmt1EI8W
        YvVvInj/GEv4RVUn0pW8+Elvbrw/eGW2+FHsg0BCGPtSAFxS7LAc/OWz0y7f4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/Fup+VDAYBco9fVZ163AiwHqyzSBNFBZQllA3x1jvOc=;
        b=aS9i++kSJbA+FSxu8KZU33DP4E1pbRN8wLmpsNSokyiXAYUnyNAeqMkr6KI54KUonI9I9I
        jkVDeP6Wt6NWt7Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 04/39] x86/boot/32: Restructure mk_early_pgtbl_32()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:28 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Prepare it for adding a temporary initrd mapping by splitting out the
actual map loop.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 arch/x86/kernel/head32.c |   42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)
---
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -81,35 +81,40 @@ typedef pgd_t			pl2_t;
 #define SET_PL2(val)		{ .pgd = (val), }
 #endif
 
-void __init __no_stack_protector mk_early_pgtbl_32(void)
+static __init __no_stack_protector pte_t init_map(pte_t pte, pte_t **ptep, pl2_t **pl2p,
+						  const unsigned long limit)
 {
-	/* Enough space to fit pagetables for the low memory linear map */
-	const unsigned long limit = __pa_nodebug(_end) +
-		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
-	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
-	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
-	unsigned long *ptr;
-	int i;
-
-	pte.pte = PTE_IDENT_ATTR;
-
 	while ((pte.pte & PTE_PFN_MASK) < limit) {
-		pl2_t pl2 = SET_PL2((unsigned long)ptep | PDE_IDENT_ATTR);
-
-		*pl2p = pl2;
+		pl2_t pl2 = SET_PL2((unsigned long)*ptep | PDE_IDENT_ATTR);
+		int i;
 
+		**pl2p = pl2;
 		if (!IS_ENABLED(CONFIG_X86_PAE)) {
 			/* Kernel PDE entry */
-			*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
+			*(*pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
 		}
 
 		for (i = 0; i < PTRS_PER_PTE; i++) {
-			*ptep = pte;
+			**ptep = pte;
 			pte.pte += PAGE_SIZE;
-			ptep++;
+			(*ptep)++;
 		}
-		pl2p++;
+		(*pl2p)++;
 	}
+	return pte;
+}
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
+{
+	/* Enough space to fit pagetables for the low memory linear map */
+	const unsigned long limit = __pa_nodebug(_end) +
+		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
+	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
+	unsigned long *ptr;
+
+	pte.pte = PTE_IDENT_ATTR;
+	pte = init_map(pte, &ptep, &pl2p, limit);
 
 	ptr = (unsigned long *)__pa_nodebug(&max_pfn_mapped);
 	/* Can't use pte_pfn() since it's a call with CONFIG_PARAVIRT */
@@ -118,4 +123,3 @@ void __init __no_stack_protector mk_earl
 	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
 }
-

