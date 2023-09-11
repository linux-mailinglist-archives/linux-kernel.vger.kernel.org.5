Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4355479B5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjIKUsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbjIKTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:04:22 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B807D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:04:17 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Rkx2S1C5Yz9vRw;
        Mon, 11 Sep 2023 21:03:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J4CUCMGXtp55; Mon, 11 Sep 2023 21:03:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Rkx280M00z9vS6;
        Mon, 11 Sep 2023 21:03:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E012E8B763;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p6HzJ61lXVpf; Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 411BA8B7A9;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38BJ3ICg3544209
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:03:18 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38BJ3IRL3544208;
        Mon, 11 Sep 2023 21:03:18 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 06/19] powerpc: Refactor update_mmu_cache_range()
Date:   Mon, 11 Sep 2023 21:03:12 +0200
Message-ID: <65afd59b863fa0e7fd2b9750786ca500dd6d76e4.1694443576.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694443576.git.christophe.leroy@csgroup.eu>
References: <cover.1694443576.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694458986; l=5071; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Kx22YyTZem2vbxzWlpjNJB7++od0JUgK10WU/wXhdSw=; b=YLL8saLRAniQD23OphU7SZapKmUrUQBiMuwGgllp5i7GPHXMVEQprHJpbnZTcCdIsU7Tlc7a6 +6ccMY/kbrLDpS9W3uja7tPk5nzpiYGlXx3FekpqmSJx35mVumhfW12
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On nohash, this function voids except for E500 with hugepages.

Take the book3s version and include that exception in the logic
and rename E500 update_mmu_cache_range() as __update_mmu_cache()
which gets called by update_mmu_cache_range().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/pgtable.h | 24 -----------------------
 arch/powerpc/include/asm/nohash/pgtable.h | 15 --------------
 arch/powerpc/include/asm/pgtable.h        | 22 +++++++++++++++++++++
 arch/powerpc/mm/nohash/e500_hugetlbpage.c |  3 +--
 4 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/pgtable.h b/arch/powerpc/include/asm/book3s/pgtable.h
index 6f4578daea6c..f42d68c6b314 100644
--- a/arch/powerpc/include/asm/book3s/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/pgtable.h
@@ -8,28 +8,4 @@
 #include <asm/book3s/32/pgtable.h>
 #endif
 
-#ifndef __ASSEMBLY__
-void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
-
-/*
- * This gets called at the end of handling a page fault, when
- * the kernel has put a new PTE into the page table for the process.
- * We use it to ensure coherency between the i-cache and d-cache
- * for the page which has just been mapped in.
- * On machines which use an MMU hash table, we use this to put a
- * corresponding HPTE into the hash table ahead of time, instead of
- * waiting for the inevitable extra hash-table miss exception.
- */
-static inline void update_mmu_cache_range(struct vm_fault *vmf,
-		struct vm_area_struct *vma, unsigned long address,
-		pte_t *ptep, unsigned int nr)
-{
-	if (IS_ENABLED(CONFIG_PPC32) && !mmu_has_feature(MMU_FTR_HPTE_TABLE))
-		return;
-	if (radix_enabled())
-		return;
-	__update_mmu_cache(vma, address, ptep);
-}
-
-#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 5b6647fb398b..a9056f4fad48 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -259,20 +259,5 @@ static inline int pud_huge(pud_t pud)
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
-/*
- * This gets called at the end of handling a page fault, when
- * the kernel has put a new PTE into the page table for the process.
- * We use it to ensure coherency between the i-cache and d-cache
- * for the page which has just been mapped in.
- */
-#if defined(CONFIG_PPC_E500) && defined(CONFIG_HUGETLB_PAGE)
-void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep, unsigned int nr);
-#else
-static inline void update_mmu_cache_range(struct vm_fault *vmf,
-		struct vm_area_struct *vma, unsigned long address,
-		pte_t *ptep, unsigned int nr) {}
-#endif
-
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index bcdbdeda65d3..2b4489bb7d99 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -119,6 +119,28 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
+void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep);
+
+/*
+ * This gets called at the end of handling a page fault, when
+ * the kernel has put a new PTE into the page table for the process.
+ * We use it to ensure coherency between the i-cache and d-cache
+ * for the page which has just been mapped in.
+ * On machines which use an MMU hash table, we use this to put a
+ * corresponding HPTE into the hash table ahead of time, instead of
+ * waiting for the inevitable extra hash-table miss exception.
+ */
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
+{
+	if (IS_ENABLED(CONFIG_PPC32) && !mmu_has_feature(MMU_FTR_HPTE_TABLE) &&
+	    !(IS_ENABLED(CONFIG_PPC_E500) && IS_ENABLED(CONFIG_HUGETLB_PAGE)))
+		return;
+	if (radix_enabled())
+		return;
+	__update_mmu_cache(vma, address, ptep);
+}
 
 /*
  * When used, PTE_FRAG_NR is defined in subarch pgtable.h
diff --git a/arch/powerpc/mm/nohash/e500_hugetlbpage.c b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
index 6b30e40d4590..a134d28a0e4d 100644
--- a/arch/powerpc/mm/nohash/e500_hugetlbpage.c
+++ b/arch/powerpc/mm/nohash/e500_hugetlbpage.c
@@ -178,8 +178,7 @@ book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea, pte_t pte)
  *
  * This must always be called with the pte lock held.
  */
-void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep, unsigned int nr)
+void __update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
 {
 	if (is_vm_hugetlb_page(vma))
 		book3e_hugetlb_preload(vma, address, *ptep);
-- 
2.41.0

