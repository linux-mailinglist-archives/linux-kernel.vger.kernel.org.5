Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA87ADED1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjIYScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjIYScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:32:12 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA19B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:32:05 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWg52SQRz9vBX;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pXv9jLBhc9WL; Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg10x4vz9v8C;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BA808B78C;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TrXN58cqm1tB; Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F41F8B799;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVYq21499191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVYTK1499190;
        Mon, 25 Sep 2023 20:31:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 15/37] powerpc/nohash: Deduplicate pte helpers
Date:   Mon, 25 Sep 2023 20:31:29 +0200
Message-ID: <485f3cbafaa948143f92692e17ca652dfed68da2.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666674; l=4616; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=7Nj78NI8w1zn6IUFHsjJFgSVFFWBM7nNkBOO0XrdP0o=; b=EVRnELOHIvSJC1ZDX111o8ogzeJSEyidQho/FODqYBoJFcg35mnl54NnH7y0oPipp9Pru/lEP 4ofT7q/457EBYfGXikx0Ael5kYcZTU5deu7f43cglZgdSyBtzwBhc4B
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

Deduplicate following helpers that are identical on
nohash/32 and nohash/64:
  pte_mkwrite_novma()
  pte_mkdirty()
  pte_mkyoung()
  pte_wrprotect()
  pte_mkexec()
  pte_young()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 36 --------------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 25 --------------
 arch/powerpc/include/asm/nohash/pgtable.h    | 36 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a39ecd498084..de51f78449a0 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -156,37 +156,6 @@
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(mm, addr, ptep, ~0, 0, 0); } while (0)
 
-#ifndef pte_mkwrite_novma
-static inline pte_t pte_mkwrite_novma(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_RW);
-}
-#endif
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
-}
-
-#ifndef pte_wrprotect
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_RW);
-}
-#endif
-
-#ifndef pte_mkexec
-static inline pte_t pte_mkexec(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_EXEC);
-}
-#endif
-
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
@@ -238,11 +207,6 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 }
 #endif
 
-static inline int pte_young(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_ACCESSED;
-}
-
 /*
  * Note that on Book E processors, the pmd contains the kernel virtual
  * (lowmem) address of the pte page.  The physical address is less useful
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 34a518a1c04d..e8bbc6ec1084 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -80,26 +80,6 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
-static inline pte_t pte_mkwrite_novma(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_RW);
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
-}
-
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_RW);
-}
-
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
@@ -165,11 +145,6 @@ static inline void p4d_set(p4d_t *p4dp, unsigned long val)
 	*p4dp = __p4d(val);
 }
 
-static inline int pte_young(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_ACCESSED;
-}
-
 static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index c64a040f4a6a..21f232d2e34f 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -70,6 +70,37 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 #endif
 
 /* Generic accessors to PTE bits */
+#ifndef pte_mkwrite_novma
+static inline pte_t pte_mkwrite_novma(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+#endif
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+#ifndef pte_wrprotect
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RW);
+}
+#endif
+
+#ifndef pte_mkexec
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+#endif
+
 #ifndef pte_write
 static inline int pte_write(pte_t pte)
 {
@@ -96,6 +127,11 @@ static inline bool pte_hw_valid(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
+static inline int pte_young(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_ACCESSED;
+}
+
 /*
  * Don't just check for any non zero bits in __PAGE_USER, since for book3e
  * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
-- 
2.41.0

