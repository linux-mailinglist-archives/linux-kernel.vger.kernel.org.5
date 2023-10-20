Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1587D0F10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377330AbjJTLsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377319AbjJTLr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:47:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB111BDA;
        Fri, 20 Oct 2023 04:39:00 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogWOc8nXy0B5JyaUqFU72tNs/meYtmlK87PTwtl39Bw=;
        b=WYVR0ZBIjb+MabpddnPRH4Jrir+4YOdH9ff72XMudWT22btvX2hqJbsw0yRcQ+Pi8gKQ03
        2YwbJAhnTgR8FrVkshwPjF63xLJwH5z+DlXQSpNfnbEkw1bQEbvB0PzQuTIU2hdOw1q8BM
        wCZwnjqGbq5Jnt0V+wR+49VFG/yLf+zoVxv00YKjkt2agyUF6fmEY2ghR1PACrGbup+Xrq
        xrnAjawvakHs5kXwHqw9+DqAsddrT26TD4SXjdY6/Nm3NOu1XaNcx5K9W8KcUsKvMxRibU
        QDVint3rp0Xyp/c489rKFXeVtnaATJyC+2wELwx/t9wgW1Q4iqLnGL8OKU9Xtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogWOc8nXy0B5JyaUqFU72tNs/meYtmlK87PTwtl39Bw=;
        b=88Rn4HLujFztxKig4LLnELHRApk4DxI65kTKPaZVzyCCFo9o0dRRarbXNov2mfAPQi4VMO
        iEDmESpYHxa5EVDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/boot/32: Restructure mk_early_pgtbl_32()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.175910753@linutronix.de>
References: <20231017211722.175910753@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188436.3135.10743660899507135319.tip-bot2@tip-bot2>
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

Commit-ID:     69ba866db281c768d5ecca909361ea4c4e71d57e
Gitweb:        https://git.kernel.org/tip/69ba866db281c768d5ecca909361ea4c4e71d57e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:28 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Oct 2023 18:28:41 +02:00

x86/boot/32: Restructure mk_early_pgtbl_32()

Prepare it for adding a temporary initrd mapping by splitting out the
actual map loop.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.175910753@linutronix.de
---
 arch/x86/kernel/head32.c | 42 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 2b65998..bdce632 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -79,35 +79,40 @@ typedef pgd_t			pl2_t;
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
@@ -116,4 +121,3 @@ void __init __no_stack_protector mk_early_pgtbl_32(void)
 	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
 }
-
