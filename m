Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F747D0F12
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjJTLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377345AbjJTLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:48:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D11BD3;
        Fri, 20 Oct 2023 04:39:00 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBNE+8EPMj7eww5j+hq/3gwOlbiHLUHfMYuWVrgielU=;
        b=UMmf+KxW4YZ5I2DQsBX2LALSvD0LhPKIS1ltOkbrJtESZdUqCuiz4NATGdulj0NR5T4ak2
        s7A7W3XAN21iU7AdNYKS8go0/FERCj+VTKLjQvg5mVGCqXTKbVaOEAyTNJRtkSFH/kjLmr
        A2O/oCb9hQAQYkdhl7AGN0+Z5F4mjbV3jXNgmE0HbbLo3h86qgmGsX9L38GI182nCtVYpz
        57WyxDZiYjW5YHBcOeWBIqZxLOzNlnNx5h5ApegTpqp9DPK/toOdDJuq+1L66C/Ez+MWev
        pZxK4gLEX77ifOH8f0HeHz+sIexz7tN5hf5KyF6qy21jbJC9Qeb9W5cUf53axQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pBNE+8EPMj7eww5j+hq/3gwOlbiHLUHfMYuWVrgielU=;
        b=/U2+wDzdWQBxx+FLKZbGA8DkOYq2bCdrriTvfDUa3JYIMOXfg5lzOBqBJPUHwDbfqpy5+r
        lP+tZm0vC/er2hBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/boot: Use __pa_nodebug() in mk_early_pgtbl_32()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211722.051625827@linutronix.de>
References: <20231017211722.051625827@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188542.3135.3956115458219517841.tip-bot2@tip-bot2>
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

Commit-ID:     1e2dd572d2b773b5b8882aae66e5f0328d562aa9
Gitweb:        https://git.kernel.org/tip/1e2dd572d2b773b5b8882aae66e5f0328d562aa9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:23:25 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Oct 2023 11:24:37 +02:00

x86/boot: Use __pa_nodebug() in mk_early_pgtbl_32()

Use the existing macro instead of undefining and redefining __pa().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211722.051625827@linutronix.de
---
 arch/x86/kernel/head32.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index bf678d6..8fe0dd3 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -73,25 +73,21 @@ void __init mk_early_pgtbl_32(void);
 
 void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
-#ifdef __pa
-#undef __pa
-#endif
-#define __pa(x)  ((unsigned long)(x) - PAGE_OFFSET)
 	pte_t pte, *ptep;
 	int i;
 	unsigned long *ptr;
 	/* Enough space to fit pagetables for the low memory linear map */
-	const unsigned long limit = __pa(_end) +
+	const unsigned long limit = __pa_nodebug(_end) +
 		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
 #ifdef CONFIG_X86_PAE
-	pmd_t pl2, *pl2p = (pmd_t *)__pa(initial_pg_pmd);
+	pmd_t pl2, *pl2p = (pmd_t *)__pa_nodebug(initial_pg_pmd);
 #define SET_PL2(pl2, val)    { (pl2).pmd = (val); }
 #else
-	pgd_t pl2, *pl2p = (pgd_t *)__pa(initial_page_table);
+	pgd_t pl2, *pl2p = (pgd_t *)__pa_nodebug(initial_page_table);
 #define SET_PL2(pl2, val)   { (pl2).pgd = (val); }
 #endif
 
-	ptep = (pte_t *)__pa(__brk_base);
+	ptep = (pte_t *)__pa_nodebug(__brk_base);
 	pte.pte = PTE_IDENT_ATTR;
 
 	while ((pte.pte & PTE_PFN_MASK) < limit) {
@@ -111,11 +107,11 @@ void __init __no_stack_protector mk_early_pgtbl_32(void)
 		pl2p++;
 	}
 
-	ptr = (unsigned long *)__pa(&max_pfn_mapped);
+	ptr = (unsigned long *)__pa_nodebug(&max_pfn_mapped);
 	/* Can't use pte_pfn() since it's a call with CONFIG_PARAVIRT */
 	*ptr = (pte.pte & PTE_PFN_MASK) >> PAGE_SHIFT;
 
-	ptr = (unsigned long *)__pa(&_brk_end);
+	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
 }
 
