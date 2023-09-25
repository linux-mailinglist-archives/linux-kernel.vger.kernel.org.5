Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFCC7ADEE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjIYSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjIYSdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:33:52 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A15E58
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:33:22 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWgL1H8Pz9v9N;
        Mon, 25 Sep 2023 20:31:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IPQbXrAP4KBd; Mon, 25 Sep 2023 20:31:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg12Wflz9v9p;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52D428B78D;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ice6QaI7JaIx; Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 932CD8B7A9;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVYc81499207
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:35 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVY9Y1499206;
        Mon, 25 Sep 2023 20:31:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 19/37] powerpc/nohash: Refactor __ptep_set_access_flags()
Date:   Mon, 25 Sep 2023 20:31:33 +0200
Message-ID: <e296885df46289d3e5f4cb51efeefe593f76ef24.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666675; l=3503; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GQ0/DYaX0gwK87V/+BgDwtKJXzY9yJiuS0RRcinUoIc=; b=WrkJRIn+h/a+K/hjpZgOF9jHOHqeda4Q7SJD2Ex8egWbsmAhwbsVz56/GQ1mgcjgmecV8sI9F Zkqdwx2GzqaBYnmMZg05JIEYyzFP6PdeYodSaaYtvtOlh4F6VwfgBxu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nohash/32 version of __ptep_set_access_flags() does the same
as nohash/64 version, the only difference is that nohash/32
version is more complete and uses pte_update().

Make it common and remove the nohash/64 version.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 16 ----------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 15 ---------------
 arch/powerpc/include/asm/nohash/pgtable.h    | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 481594097f46..9164a9e41b02 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -161,22 +161,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
-#ifndef __ptep_set_access_flags
-static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
-					   pte_t *ptep, pte_t entry,
-					   unsigned long address,
-					   int psize)
-{
-	unsigned long set = pte_val(entry) &
-			    (_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
-	int huge = psize > mmu_virtual_psize ? 1 : 0;
-
-	pte_update(vma->vm_mm, address, ptep, 0, set, huge);
-
-	flush_tlb_page(vma, address);
-}
-#endif
-
 /*
  * Note that on Book E processors, the pmd contains the kernel virtual
  * (lowmem) address of the pte page.  The physical address is less useful
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index b59fbf754f82..36b9bad428cc 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -159,21 +159,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	__young;							\
 })
 
-/* Set the dirty and/or accessed bits atomically in a linux PTE */
-static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
-					   pte_t *ptep, pte_t entry,
-					   unsigned long address,
-					   int psize)
-{
-	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
-
-	unsigned long old = pte_val(*ptep);
-	*ptep = __pte(old | bits);
-
-	flush_tlb_page(vma, address);
-}
-
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
 #define pgd_ERROR(e) \
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 464eb771db82..1493f0b09ae9 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -102,6 +102,23 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 	pte_update(mm, addr, ptep, ~0UL, 0, 0);
 }
 
+/* Set the dirty and/or accessed bits atomically in a linux PTE */
+#ifndef __ptep_set_access_flags
+static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
+					   pte_t *ptep, pte_t entry,
+					   unsigned long address,
+					   int psize)
+{
+	unsigned long set = pte_val(entry) &
+			    (_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
+	int huge = psize > mmu_virtual_psize ? 1 : 0;
+
+	pte_update(vma->vm_mm, address, ptep, 0, set, huge);
+
+	flush_tlb_page(vma, address);
+}
+#endif
+
 /* Generic accessors to PTE bits */
 #ifndef pte_mkwrite_novma
 static inline pte_t pte_mkwrite_novma(pte_t pte)
-- 
2.41.0

