Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF97ADED7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjIYSdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjIYScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:32:39 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4F7CED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:32:26 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWgB4BDmz9v6d;
        Mon, 25 Sep 2023 20:31:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7gh6P-1qF3oe; Mon, 25 Sep 2023 20:31:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg11ZHjz9v8v;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32BBF8B790;
        Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v7F8ZKbPl6Dl; Mon, 25 Sep 2023 20:31:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 74C608B79C;
        Mon, 25 Sep 2023 20:31:40 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVXgf1499167
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:33 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVXEP1499166;
        Mon, 25 Sep 2023 20:31:33 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 09/37] powerpc/nohash: Refactor declaration of {map/unmap}_kernel_page()
Date:   Mon, 25 Sep 2023 20:31:23 +0200
Message-ID: <7fec5f3288cf0d0eac61b1b3f48c3ea54eb80cad.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666674; l=3056; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=74UwaaMH04ujta7XH+ONjo0l1oOFOl+HKRAnrkXYv/M=; b=u4AptwQvpm6zoY/cZ3KR0UJ0lGehG3/U+SZ7B/f1CPS+IWSeKow3JZEnfZXlJ8L9f3l2fzb9p n2S2/GNimtuBmSiLGCHsafQRskGyetot4ilRdv7LfAe4BOawKaWkTVz
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

map_kernel_page() and unmap_kernel_page() have the same prototypes
on nohash/32 and nohash/64, keep only one declaration.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 8 --------
 arch/powerpc/include/asm/nohash/64/pgtable.h | 2 --
 arch/powerpc/include/asm/nohash/pgtable.h    | 3 +++
 arch/powerpc/mm/nohash/book3e_pgtable.c      | 2 +-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index c8311ee08811..26289e4e767c 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -58,14 +58,6 @@ extern int icache_44x_need_flush;
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-#ifndef __ASSEMBLY__
-
-int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
-void unmap_kernel_page(unsigned long va);
-
-#endif /* !__ASSEMBLY__ */
-
-
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
  * value (for now) on others, from where we can start layout kernel
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index dee3fc654d40..f5a8e8a9dba4 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -309,8 +309,6 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 /* We borrow MSB 56 (LSB 7) to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	0x80
 
-int map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot);
-void unmap_kernel_page(unsigned long va);
 extern int __meminit vmemmap_create_mapping(unsigned long start,
 					    unsigned long page_size,
 					    unsigned long phys);
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index ab26af2b421a..3d684b500fe6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -242,5 +242,8 @@ static inline int pud_huge(pud_t pud)
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
+int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
+void unmap_kernel_page(unsigned long va);
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/nohash/book3e_pgtable.c b/arch/powerpc/mm/nohash/book3e_pgtable.c
index b80fc4a91a53..1c5e4ecbebeb 100644
--- a/arch/powerpc/mm/nohash/book3e_pgtable.c
+++ b/arch/powerpc/mm/nohash/book3e_pgtable.c
@@ -71,7 +71,7 @@ static void __init *early_alloc_pgtable(unsigned long size)
  * map_kernel_page adds an entry to the ioremap page table
  * and adds an entry to the HPT, possibly bolting it
  */
-int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
+int __ref map_kernel_page(unsigned long ea, phys_addr_t pa, pgprot_t prot)
 {
 	pgd_t *pgdp;
 	p4d_t *p4dp;
-- 
2.41.0

