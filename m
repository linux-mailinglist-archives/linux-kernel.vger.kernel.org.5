Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1677ADECC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjIYScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjIYScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:32:00 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F067B192
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:31:52 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWg23ys8z9vB3;
        Mon, 25 Sep 2023 20:31:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gm2YNQbS0yuz; Mon, 25 Sep 2023 20:31:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg05ZpLz9v6s;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BADC68B7AD;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8FtEjI7eRIpO; Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58E858B78D;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVXcl1499179
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:33 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVXKl1499178;
        Mon, 25 Sep 2023 20:31:33 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 12/37] powerpc/nohash: Refactor pte_update()
Date:   Mon, 25 Sep 2023 20:31:26 +0200
Message-ID: <e01cb630cad42f645915ce7702d23985241b71fc.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666674; l=5130; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=xkkBzed2zZJkZITyMdV9FKsj7P96yTZeDIXATjlEXm8=; b=3iEbmq8633PTNmPLX7/okHtSNW/snXwvx2AZniFSj27Pj5cCnCChTz1l+DonMya3H033LpjIt xGfeHboEKnrBbyBDd0Hhz8LCBbHwey51C3C47DK/AgYJyj0+tOBIAM6
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

pte_update() is similar.

Take the nohash/32 version which works on nohash/64 and add the debug
call to assert_pte_locked() which is only on nohash/64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 33 ---------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 17 --------
 arch/powerpc/include/asm/nohash/pgtable.h    | 42 ++++++++++++++++++++
 3 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a74476de1ef6..ae7f3c8afd4f 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -9,8 +9,6 @@
 #include <linux/threads.h>
 #include <asm/mmu.h>			/* For sub-arch specific PPC_PIN_SIZE */
 
-extern int icache_44x_need_flush;
-
 #endif /* __ASSEMBLY__ */
 
 #define PTE_INDEX_SIZE	PTE_SHIFT
@@ -203,37 +201,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
-/*
- * PTE updates. This function is called whenever an existing
- * valid PTE is updated. This does -not- include set_pte_at()
- * which nowadays only sets a new PTE.
- *
- * Depending on the type of MMU, we may need to use atomic updates
- * and the PTE may be either 32 or 64 bit wide. In the later case,
- * when using atomic updates, only the low part of the PTE is
- * accessed atomically.
- *
- * In addition, on 44x, we also maintain a global flag indicating
- * that an executable user mapping was modified, which is needed
- * to properly flush the virtually tagged instruction cache of
- * those implementations.
- */
-#ifndef pte_update
-static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
-				     unsigned long clr, unsigned long set, int huge)
-{
-	pte_basic_t old = pte_val(*p);
-	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
-
-	*p = __pte(new);
-
-	if (IS_ENABLED(CONFIG_44x) && (old & _PAGE_USER) && (old & _PAGE_EXEC))
-		icache_44x_need_flush = 1;
-
-	return old;
-}
-#endif
-
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 					      unsigned long addr, pte_t *ptep)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index f5a8e8a9dba4..b149a39f2685 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -171,23 +171,6 @@ static inline void p4d_set(p4d_t *p4dp, unsigned long val)
 	*p4dp = __p4d(val);
 }
 
-/* Atomic PTE updates */
-static inline unsigned long pte_update(struct mm_struct *mm,
-				       unsigned long addr,
-				       pte_t *ptep, unsigned long clr,
-				       unsigned long set,
-				       int huge)
-{
-	unsigned long old = pte_val(*ptep);
-	*ptep = __pte((old & ~clr) | set);
-
-	/* huge pages use the old page table lock */
-	if (!huge)
-		assert_pte_locked(mm, addr);
-
-	return old;
-}
-
 static inline int pte_young(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_ACCESSED;
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 3d684b500fe6..bd5c3a4baabd 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_POWERPC_NOHASH_PGTABLE_H
 #define _ASM_POWERPC_NOHASH_PGTABLE_H
 
+#ifndef __ASSEMBLY__
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+				     unsigned long clr, unsigned long set, int huge);
+#endif
+
 #if defined(CONFIG_PPC64)
 #include <asm/nohash/64/pgtable.h>
 #else
@@ -18,6 +23,43 @@
 
 #ifndef __ASSEMBLY__
 
+extern int icache_44x_need_flush;
+
+/*
+ * PTE updates. This function is called whenever an existing
+ * valid PTE is updated. This does -not- include set_pte_at()
+ * which nowadays only sets a new PTE.
+ *
+ * Depending on the type of MMU, we may need to use atomic updates
+ * and the PTE may be either 32 or 64 bit wide. In the later case,
+ * when using atomic updates, only the low part of the PTE is
+ * accessed atomically.
+ *
+ * In addition, on 44x, we also maintain a global flag indicating
+ * that an executable user mapping was modified, which is needed
+ * to properly flush the virtually tagged instruction cache of
+ * those implementations.
+ */
+#ifndef pte_update
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+				     unsigned long clr, unsigned long set, int huge)
+{
+	pte_basic_t old = pte_val(*p);
+	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
+
+	*p = __pte(new);
+
+	if (IS_ENABLED(CONFIG_44x) && (old & _PAGE_USER) && (old & _PAGE_EXEC))
+		icache_44x_need_flush = 1;
+
+	/* huge pages use the old page table lock */
+	if (!huge)
+		assert_pte_locked(mm, addr);
+
+	return old;
+}
+#endif
+
 /* Generic accessors to PTE bits */
 #ifndef pte_write
 static inline int pte_write(pte_t pte)
-- 
2.41.0

