Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92F7D0EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377189AbjJTLlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377466AbjJTLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:40:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B456E10CB;
        Fri, 20 Oct 2023 04:39:00 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATsUGzvnesAyW0GiLV/+K8CQ+agfx0W24nsA90MKCak=;
        b=IodEItzd361aRjvd1F2E9A+hUkwlnhzKJ+rmCsAF94tVeAZFvr3Pgu/TQMfZ/qX5IcxuGV
        BM4koP4WrRWOSm3pJvTaABjxEugGMEPpzD7n4ZuLr2FcFKoHhpAnGFn0h5ps178BWEdjoR
        r4qpoRxdDjv1valQ2YQ+IpTCzh7vugrBbWlKDqbkaqdeT/1b9NrnsbGjOAcgCO6cRCfii6
        MR6pMnb38+L/r9f06TCOloAWWBYiL4dKhBCYCCNdaQfr+rPKjQSImQRozM8+I47qOb95tq
        8OSb7ZQMthyO1Qw7ixSHLyF0CYFv5ZTHEQIs1ho6qqVglcaMSccNDJRsmRuANQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATsUGzvnesAyW0GiLV/+K8CQ+agfx0W24nsA90MKCak=;
        b=VrF0BoCK8vcxAqAfM/x2xldMLjuyam8w//Vsy+emZZvrjxUDq52gxzyN6tn1zlbdL5sCz+
        nzqOBkE5AL942ADQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/boot/32: De-uglify the 2/3 level paging
 difference in mk_early_pgtbl_32()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.111059491@linutronix.de>
References: <20231017211722.111059491@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188492.3135.16075004518464321952.tip-bot2@tip-bot2>
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

Commit-ID:     a62f4ca106fd250e9247decd100f3905131fc1fe
Gitweb:        https://git.kernel.org/tip/a62f4ca106fd250e9247decd100f3905131fc1fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:26 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Oct 2023 18:27:30 +02:00

x86/boot/32: De-uglify the 2/3 level paging difference in mk_early_pgtbl_32()

Move the ifdeffery out of the function and use proper typedefs to make it
work for both 2 and 3 level paging.

No functional change.

  [ bp: Move mk_early_pgtbl_32() declaration into a header. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.111059491@linutronix.de
---
 arch/x86/include/asm/setup.h |  1 +-
 arch/x86/kernel/head32.c     | 38 ++++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f349562..bf483fc 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -126,6 +126,7 @@ void clear_bss(void);
 #ifdef __i386__
 
 asmlinkage void __init __noreturn i386_start_kernel(void);
+void __init mk_early_pgtbl_32(void);
 
 #else
 asmlinkage void __init __noreturn x86_64_start_kernel(char *real_mode);
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 8fe0dd3..2b65998 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -69,41 +69,43 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  * to the first kernel PMD. Note the upper half of each PMD or PTE are
  * always zero at this stage.
  */
-void __init mk_early_pgtbl_32(void);
+#ifdef CONFIG_X86_PAE
+typedef pmd_t			pl2_t;
+#define pl2_base		initial_pg_pmd
+#define SET_PL2(val)		{ .pmd = (val), }
+#else
+typedef pgd_t			pl2_t;
+#define pl2_base		initial_page_table
+#define SET_PL2(val)		{ .pgd = (val), }
+#endif
 
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
 
