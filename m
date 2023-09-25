Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ACE7ADED5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjIYScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjIYScY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:32:24 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD0110C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:32:17 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWg81GPFz9v53;
        Mon, 25 Sep 2023 20:31:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bb5OnT154Klb; Mon, 25 Sep 2023 20:31:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg11RKlz9v8l;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 297B48B78C;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cUptVpPZHDql; Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B5FC8B79E;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVXN11499183
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVXLi1499182;
        Mon, 25 Sep 2023 20:31:33 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/37] powerpc/nohash: Refactor checking of no-change in pte_update()
Date:   Mon, 25 Sep 2023 20:31:27 +0200
Message-ID: <076563e611c2b51036686a8d378bfd5ef1726341.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666674; l=2126; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=p5ytnpgPn5IRxm6fsCWGPJWttaZhRdH4cRGH2fJc71c=; b=T3dZv/BwV8PDj7RvAELx9Hw6TyHMaBTjcUNSB5KWSddKrLFuYytH/V7XXgsmxlLzel3nydmna 7HH/jnjTzHDA+oUTS2UBErMUzHqTnITqVgSTwBHcH3WnIwzH7s/epbg
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

On nohash/64, a few callers of pte_update() check if there is
really a change in order to avoid an unnecessary write.

Refactor that inside pte_update().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 9 ---------
 arch/powerpc/include/asm/nohash/pgtable.h    | 3 +++
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index b149a39f2685..cba08a62c52c 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -181,8 +181,6 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if (!pte_young(*ptep))
-		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
 }
@@ -198,10 +196,6 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-
-	if ((pte_val(*ptep) & _PAGE_RW) == 0)
-		return;
-
 	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
 }
 
@@ -209,9 +203,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	if ((pte_val(*ptep) & _PAGE_RW) == 0)
-		return;
-
 	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
 }
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index bd5c3a4baabd..8adaacbbdd1d 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -47,6 +47,9 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 	pte_basic_t old = pte_val(*p);
 	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
 
+	if (new == old)
+		return old;
+
 	*p = __pte(new);
 
 	if (IS_ENABLED(CONFIG_44x) && (old & _PAGE_USER) && (old & _PAGE_EXEC))
-- 
2.41.0

