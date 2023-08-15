Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6DE77D145
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbjHORnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbjHORnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:43:13 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F177A1BCC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:43:08 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RQJWv4Jdkz9sdG;
        Tue, 15 Aug 2023 19:43:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IZVCe-XhqlZn; Tue, 15 Aug 2023 19:43:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RQJWv3LQ2z9sdF;
        Tue, 15 Aug 2023 19:43:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 674EE8B76C;
        Tue, 15 Aug 2023 19:43:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zilZFmMOT9hc; Tue, 15 Aug 2023 19:43:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.223])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 294F48B763;
        Tue, 15 Aug 2023 19:43:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37FHgvT1130058
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 19:42:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37FHguwX130055;
        Tue, 15 Aug 2023 19:42:56 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/32s: Cleanup the mess in __set_pte_at()
Date:   Tue, 15 Aug 2023 19:42:40 +0200
Message-ID: <2322dd08217bccab25456fe8b189edf0e6a8b6dd.1692121353.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692121359; l=4791; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=fGlvVuOrCBi+lhcfv7DJG1AIL9OtHrWZ3x+zLBhy878=; b=5mdamyP7SLVUjlj9979DJHQ8KXiaufcu1xrbOCQ9us+tjEtuQMcxotkHeU+mTCo/bAi2DN9um KrK2TiGkhZrAUkjEvrrlqgInT0s+sxiyiKJp3X+u4PfIo8TM9xKcLVT
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

__set_pte_at() handles 3 main cases with #ifdefs plus the 'percpu'
subcase which leads to code duplication.

Rewrite the function using IS_ENABLED() to minimise the total number
of cases and remove duplicated code.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Reorganise comments, first case becomes third and third become first.
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 77 ++++++++------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 7bf1fe7297c6..d49c2a9d4ffe 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -541,58 +541,43 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 
 /* This low level function performs the actual PTE insertion
- * Setting the PTE depends on the MMU type and other factors. It's
- * an horrible mess that I'm not going to try to clean up now but
- * I'm keeping it in one place rather than spread around
+ * Setting the PTE depends on the MMU type and other factors.
+ *
+ * First case is 32-bit in UP mode with 32-bit PTEs, we need to preserve
+ * the _PAGE_HASHPTE bit since we may not have invalidated the previous
+ * translation in the hash yet (done in a subsequent flush_tlb_xxx())
+ * and see we need to keep track that this PTE needs invalidating.
+ *
+ * Second case is 32-bit with 64-bit PTE.  In this case, we
+ * can just store as long as we do the two halves in the right order
+ * with a barrier in between. This is possible because we take care,
+ * in the hash code, to pre-invalidate if the PTE was already hashed,
+ * which synchronizes us with any concurrent invalidation.
+ * In the percpu case, we fallback to the simple update preserving
+ * the hash bits (ie, same as the non-SMP case).
+ *
+ * Third case is 32-bit in SMP mode with 32-bit PTEs. We use the
+ * helper pte_update() which does an atomic update. We need to do that
+ * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
+ * per-CPU PTE such as a kmap_atomic, we also do a simple update preserving
+ * the hash bits instead.
  */
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
-#if defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
-	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
-	 * helper pte_update() which does an atomic update. We need to do that
-	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
-	 * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
-	 * the hash bits instead (ie, same as the non-SMP case)
-	 */
-	if (percpu)
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
-	else
-		pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, pte_val(pte), 0);
+	if ((!IS_ENABLED(CONFIG_SMP) && !IS_ENABLED(CONFIG_PTE_64BIT)) || percpu) {
+		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE) |
+			      (pte_val(pte) & ~_PAGE_HASHPTE));
+	} else if (IS_ENABLED(CONFIG_PTE_64BIT)) {
+		if (pte_val(*ptep) & _PAGE_HASHPTE)
+			flush_hash_entry(mm, ptep, addr);
 
-#elif defined(CONFIG_PTE_64BIT)
-	/* Second case is 32-bit with 64-bit PTE.  In this case, we
-	 * can just store as long as we do the two halves in the right order
-	 * with a barrier in between. This is possible because we take care,
-	 * in the hash code, to pre-invalidate if the PTE was already hashed,
-	 * which synchronizes us with any concurrent invalidation.
-	 * In the percpu case, we also fallback to the simple update preserving
-	 * the hash bits
-	 */
-	if (percpu) {
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
-		return;
+		asm volatile("stw%X0 %2,%0; eieio; stw%X1 %L2,%1" :
+			     "=m" (*ptep), "=m" (*((unsigned char *)ptep+4)) :
+			     "r" (pte) : "memory");
+	} else {
+		pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, pte_val(pte), 0);
 	}
-	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(mm, ptep, addr);
-	__asm__ __volatile__("\
-		stw%X0 %2,%0\n\
-		eieio\n\
-		stw%X1 %L2,%1"
-	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
-	: "r" (pte) : "memory");
-
-#else
-	/* Third case is 32-bit hash table in UP mode, we need to preserve
-	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
-	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
-	 * and see we need to keep track that this PTE needs invalidating
-	 */
-	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-#endif
 }
 
 /*
-- 
2.41.0

