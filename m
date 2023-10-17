Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1657CCF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjJQVXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJQVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448CC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:27 -0700 (PDT)
Message-ID: <20231017211722.051625827@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lbJOYYfEHtT/va9V68vAJRypxMhoPgp+vUtRehmb5+s=;
        b=EQh3GyX9g7Y8vF1WVmwq4aQgerLtDVxxz/+4S2qGYSj2DsH/T2UtPZc2fGFYOF96J9aaTA
        eTAZ1H+lI+z29H/KrUegQa1EHm6TCqs0wcFTdRdAJJ8xiQa6wdYi0eEnwzVErQrkkpUo0L
        SUArvNPviOJYtQuHlFYg8NcLTvr9oCActlvj6Os3aUwaz7PVF5/KSkEn5z6WMWCKy9ItiR
        mabn7a0cvkdySD6lj0CvTXxkVEVjdfOP2Ajutu4Qv+F2mRP8ORAE7QXp9H3ghx3PYKXczg
        Ye7Mlqk2Xs+vb6XhV+BJhLvLX6aWquHNPuSjgyLxnVkuvHpazP8RxI3Ch83Wyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lbJOYYfEHtT/va9V68vAJRypxMhoPgp+vUtRehmb5+s=;
        b=67HZHtdltjEhaIOOD9sxR+Wliq7Q+U+4SYN5vz0MHpLwaJTks1GZqalBKv0Na+rTvPHy31
        +KwwSiOD53zr1tAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 02/39] x86/boot: Use __pa_nodebug() in mk_early_pgtbl_32()
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:25 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Use the existing macro instead of undefining and redefining __pa().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 arch/x86/kernel/head32.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)
---
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
@@ -111,11 +107,11 @@ void __init __no_stack_protector mk_earl
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
 

