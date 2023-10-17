Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4097CCF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbjJQVXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjJQVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B02CC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:28 -0700 (PDT)
Message-ID: <20231017211722.111059491@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cOWd3mA0/NpSnoGliA9lY2CUL6yFVz+hcd1BXCQ4PjQ=;
        b=4z2f2xNcj3NtihmzLmZArpBNxGNWvuTEf+iUyBSxKFKld0Nn5qeupZNDk6+ZU/YNVW8J+U
        9gnP2DRtZ9OKuS0NQsH7rVOeVn/ZksL5a0ApewfCOxM5NwrLTManyci63DRkbILZlCbXm9
        VRNltETVhr89O08E3VE7vELk7jts29azYlGe973X8KDZOn333hcvTL9fG8yrOiPA4N0GJY
        kScdibz5iP+3R1LtOF9FEjxhVgvwXqIxIg9uL5mCHCpr3jy03vYTC4Nq80e/EK4j9XhSFJ
        dXA2psJKmZ1HeAWCEjBhl0sactAG6IHgZRsI5TZOkquAr6vGvvzLRYP54Ylwbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cOWd3mA0/NpSnoGliA9lY2CUL6yFVz+hcd1BXCQ4PjQ=;
        b=fV85nwipkJR6owvvmejqZlePAbTYJ4adrIAS/INqHoVmWOk0q6D5uZ3CRvFEWpg+hj2L6i
        LoNVAnivz+6Jd3CA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 03/39] x86/boot/32: De-uglify the 2/3 level paging
 difference in mk_early_pgtbl_32()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:26 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the ifdeffery out of the function and use proper typedefs to make it
work for both 2 and 3 level paging.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 arch/x86/kernel/head32.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -71,39 +71,43 @@ asmlinkage __visible void __init __noret
  */
 void __init mk_early_pgtbl_32(void);
 
+#ifdef CONFIG_X86_PAE
+typedef pmd_t			pl2_t;
+#define pl2_base		initial_pg_pmd
+#define SET_PL2(val)		{ .pmd = (val), }
+#else
+typedef pgd_t			pl2_t;
+#define pl2_base		initial_page_table
+#define SET_PL2(val)		{ .pgd = (val), }
+#endif
+
 void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
-	pte_t pte, *ptep;
-	int i;
-	unsigned long *ptr;
 	/* Enough space to fit pagetables for the low memory linear map */
 	const unsigned long limit = __pa_nodebug(_end) +
 		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
-#ifdef CONFIG_X86_PAE
-	pmd_t pl2, *pl2p = (pmd_t *)__pa_nodebug(initial_pg_pmd);
-#define SET_PL2(pl2, val)    { (pl2).pmd = (val); }
-#else
-	pgd_t pl2, *pl2p = (pgd_t *)__pa_nodebug(initial_page_table);
-#define SET_PL2(pl2, val)   { (pl2).pgd = (val); }
-#endif
+	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
+	unsigned long *ptr;
+	int i;
 
-	ptep = (pte_t *)__pa_nodebug(__brk_base);
 	pte.pte = PTE_IDENT_ATTR;
 
 	while ((pte.pte & PTE_PFN_MASK) < limit) {
+		pl2_t pl2 = SET_PL2((unsigned long)ptep | PDE_IDENT_ATTR);
 
-		SET_PL2(pl2, (unsigned long)ptep | PDE_IDENT_ATTR);
 		*pl2p = pl2;
-#ifndef CONFIG_X86_PAE
-		/* Kernel PDE entry */
-		*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
-#endif
+
+		if (!IS_ENABLED(CONFIG_X86_PAE)) {
+			/* Kernel PDE entry */
+			*(pl2p +  ((PAGE_OFFSET >> PGDIR_SHIFT))) = pl2;
+		}
+
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			*ptep = pte;
 			pte.pte += PAGE_SIZE;
 			ptep++;
 		}
-
 		pl2p++;
 	}
 

