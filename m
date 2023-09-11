Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F44C79B5DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjIKVEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244086AbjIKTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:04:01 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C30FD8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:03:55 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Rkx2J2pptz9vR2;
        Mon, 11 Sep 2023 21:03:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LQTn5VySAKTr; Mon, 11 Sep 2023 21:03:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Rkx276fYyz9vRq;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A689F8B78B;
        Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ifxxd5HdZocg; Mon, 11 Sep 2023 21:03:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.38])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 094638B798;
        Mon, 11 Sep 2023 21:03:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38BJ3JWo3544241
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 21:03:19 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38BJ3J8R3544240;
        Mon, 11 Sep 2023 21:03:19 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 14/19] powerpc/nohash: Deduplicate _PAGE_CHG_MASK
Date:   Mon, 11 Sep 2023 21:03:20 +0200
Message-ID: <9dd4475709331d77fb5eead9f5bdca2b4a3501f6.1694443576.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694443576.git.christophe.leroy@csgroup.eu>
References: <cover.1694443576.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694458987; l=2710; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CEvu7MiVClOPYgfZwMUkviTENwq0dKPuXrMNnmw/pxA=; b=z+u2MUghJvBNWCYST4sWAOXwajIRFxggoKCofeOusmRFUpE1ymo6i8POg0xcuL4dX9iDghW91 VGbIcuey5I5BDl1QYxo08c489wdydWQMT8ddUXrKt7RcE+mnmuv3UEf
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_PAGE_CHG_MASK is identical between nohash/32 and nohash/64,
deduplicate it.

While at it, clean the #ifdef for PTE_RPN_MASK in nohash/32 as
it is already CONFIG_PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 8 +-------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 6 ------
 arch/powerpc/include/asm/nohash/pgtable.h    | 6 ++++++
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index ae7f3c8afd4f..a39ecd498084 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -143,7 +143,7 @@
  * The mask covered by the RPN must be a ULL on 32-bit platforms with
  * 64-bit PTEs.
  */
-#if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#ifdef CONFIG_PTE_64BIT
 #define PTE_RPN_MASK	(~((1ULL << PTE_RPN_SHIFT) - 1))
 #define MAX_POSSIBLE_PHYSMEM_BITS 36
 #else
@@ -151,12 +151,6 @@
 #define MAX_POSSIBLE_PHYSMEM_BITS 32
 #endif
 
-/*
- * _PAGE_CHG_MASK masks of bits that are to be preserved across
- * pgprot changes.
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
-
 #ifndef __ASSEMBLY__
 
 #define pte_clear(mm, addr, ptep) \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index cba08a62c52c..34a518a1c04d 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -75,12 +75,6 @@
 
 #define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
 
-/*
- * _PAGE_CHG_MASK masks of bits that are to be preserved across
- * pgprot changes.
- */
-#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
-
 #define H_PAGE_4K_PFN 0
 
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 8adaacbbdd1d..c64a040f4a6a 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -13,6 +13,12 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 #include <asm/nohash/32/pgtable.h>
 #endif
 
+/*
+ * _PAGE_CHG_MASK masks of bits that are to be preserved across
+ * pgprot changes.
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_SPECIAL)
+
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
 #define PAGE_KERNEL_NC	__pgprot(_PAGE_BASE_NC | _PAGE_KERNEL_RW | _PAGE_NO_CACHE)
-- 
2.41.0

