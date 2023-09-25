Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5972A7ADED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjIYSc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjIYScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:32:16 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B91BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:32:09 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWg62FNdz9vCN;
        Mon, 25 Sep 2023 20:31:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yvk3jFB_1TWu; Mon, 25 Sep 2023 20:31:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg10z2hz9v8R;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 188DC8B790;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PxJEdygshCP8; Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A0938B796;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVYT81499195
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVYPn1499194;
        Mon, 25 Sep 2023 20:31:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/37] powerpc/nohash: Refactor ptep_test_and_clear_young()
Date:   Mon, 25 Sep 2023 20:31:30 +0200
Message-ID: <de90679ae169104fa3c98d0a8828d7ede228fc52.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666675; l=3614; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Y/C63pFT1rMMjtE9mWYVj4ITK7GX+xPbgdK4F4ZXVbk=; b=+utOFZwfhdjqBs9EwhdgwFu3pBpsuhFCiRiipX/trmJOJcecn8BLaU4CRzw0jaDFAOhmf7IuG hewoRSIPH8+AKUy1gAAB98L8mNCpMD+/p8+smkIHTRy8PoEbZKN7xS3
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

Remove ptep_test_and_clear_young() macro, make
__ptep_test_and_clear_young() common to nohash/32 and nohash/64
and change it to become ptep_test_and_clear_young()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 11 -----------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 19 +------------------
 arch/powerpc/include/asm/nohash/pgtable.h    | 11 +++++++++++
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index de51f78449a0..b7605000bd91 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -164,17 +164,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pte_t *ptep)
-{
-	unsigned long old;
-	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
-	return (old & _PAGE_ACCESSED) != 0;
-}
-#define ptep_test_and_clear_young(__vma, __addr, __ptep) \
-	__ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep)
-
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 				       pte_t *ptep)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index e8bbc6ec1084..56041036fa34 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -145,22 +145,6 @@ static inline void p4d_set(p4d_t *p4dp, unsigned long val)
 	*p4dp = __p4d(val);
 }
 
-static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
-					      unsigned long addr, pte_t *ptep)
-{
-	unsigned long old;
-
-	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
-	return (old & _PAGE_ACCESSED) != 0;
-}
-#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
-#define ptep_test_and_clear_young(__vma, __addr, __ptep)		   \
-({									   \
-	int __r;							   \
-	__r = __ptep_test_and_clear_young((__vma)->vm_mm, __addr, __ptep); \
-	__r;								   \
-})
-
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
@@ -178,8 +162,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young(__vma, __address, __ptep)		\
 ({									\
-	int __young = __ptep_test_and_clear_young((__vma)->vm_mm, __address, \
-						  __ptep);		\
+	int __young = ptep_test_and_clear_young(__vma, __address, __ptep);\
 	__young;							\
 })
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 21f232d2e34f..2b043b72f642 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -69,6 +69,17 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 }
 #endif
 
+static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep)
+{
+	unsigned long old;
+
+	old = pte_update(vma->vm_mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
+
+	return (old & _PAGE_ACCESSED) != 0;
+}
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+
 /* Generic accessors to PTE bits */
 #ifndef pte_mkwrite_novma
 static inline pte_t pte_mkwrite_novma(pte_t pte)
-- 
2.41.0

