Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5413F79B3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357444AbjIKWFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbjIKTEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:04:15 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC2BD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:04:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Rkx2Q1NrXz9vQY;
        Mon, 11 Sep 2023 21:03:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z-SxkzyFekqo; Mon, 11 Sep 2023 21:03:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Rkx280WJzz9vS7;
        Mon, 11 Sep 2023 21:03:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E784E8B79F;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dPvBU07TRZVK; Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 819E28B77D;
        Mon, 11 Sep 2023 21:03:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38BJ3JnI3544253
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:03:19 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38BJ3JXT3544252;
        Mon, 11 Sep 2023 21:03:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 17/19] powerpc/nohash: Deduplicate ptep_set_wrprotect() and ptep_get_and_clear()
Date:   Mon, 11 Sep 2023 21:03:23 +0200
Message-ID: <a2227b6f5a72e50d1b2ac6da253ceaf38e650875.1694443576.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694443576.git.christophe.leroy@csgroup.eu>
References: <cover.1694443576.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694458987; l=3551; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=UwJY7kIn36EgPdbQz+ruitzz1rwjNd+yo0YQOtGn4lU=; b=IGFdrqMtJhyC5t8i2Jqzxe0Jo/WKKKYHQf5RvNDzulxB1ClJhOz0w/KSFILymwQkbGId3oZz8 wWmRhBwt/XKBDZJ7vN0hxEGEGm8aRy/gaiAKBEkElC8e8JNBOWNiDr9
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptep_set_wrprotect() and ptep_get_and_clear are identical for
nohash/32 and nohash/64.

Make them common.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 16 ----------------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 15 ---------------
 arch/powerpc/include/asm/nohash/pgtable.h    | 16 ++++++++++++++++
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index b7605000bd91..0be464af4cb1 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -164,22 +164,6 @@ static inline void pmd_clear(pmd_t *pmdp)
 	*pmdp = __pmd(0);
 }
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-				       pte_t *ptep)
-{
-	return __pte(pte_update(mm, addr, ptep, ~0, 0, 0));
-}
-
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-#ifndef ptep_set_wrprotect
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pte_t *ptep)
-{
-	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
-}
-#endif
-
 #ifndef __ptep_set_access_flags
 static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   pte_t *ptep, pte_t entry,
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 56041036fa34..dc6e35c3a53f 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -145,13 +145,6 @@ static inline void p4d_set(p4d_t *p4dp, unsigned long val)
 	*p4dp = __p4d(val);
 }
 
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
-				      pte_t *ptep)
-{
-	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
-}
-
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
@@ -166,14 +159,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	__young;							\
 })
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long addr, pte_t *ptep)
-{
-	unsigned long old = pte_update(mm, addr, ptep, ~0UL, 0, 0);
-	return __pte(old);
-}
-
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t * ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 2b043b72f642..7e810a84ac15 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -80,6 +80,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 }
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 
+#ifndef ptep_set_wrprotect
+static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
+				      pte_t *ptep)
+{
+	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
+}
+#endif
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				       pte_t *ptep)
+{
+	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 0));
+}
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+
 /* Generic accessors to PTE bits */
 #ifndef pte_mkwrite_novma
 static inline pte_t pte_mkwrite_novma(pte_t pte)
-- 
2.41.0

