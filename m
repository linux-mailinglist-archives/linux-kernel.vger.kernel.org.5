Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646367ADEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjIYSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjIYSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:34:31 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DE10D4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 11:34:08 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RvWgc5fM5z9vBC;
        Mon, 25 Sep 2023 20:32:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ujfAmZUd7Tpt; Mon, 25 Sep 2023 20:32:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RvWg54J88z9vCD;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 909AC8B78C;
        Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id g7nyzPHMkcHR; Mon, 25 Sep 2023 20:31:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.137])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B64F8B79F;
        Mon, 25 Sep 2023 20:31:44 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 38PIVaCb1499244
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 20:31:36 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 38PIVaWw1499243;
        Mon, 25 Sep 2023 20:31:36 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 28/37] powerpc/nohash: Add _PAGE_WRITE to supplement _PAGE_RW
Date:   Mon, 25 Sep 2023 20:31:42 +0200
Message-ID: <1f79b88db54d030ada776dc9845e0e88345bfc28.1695659959.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695666676; l=9047; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=2URyayOXJxwAjVz1YyD96uDrNRN9jJ/Qi9M3TwsfurA=; b=bUzUB6qZbV2j6C/WbPx1uNwQasO7ysx83R1/yV3fNuRZZFOqTu+f7L7ltAaSQsfxa520owsAK e8FBSR151cDBECJ+FtsADBcVwp1aPYd8xUYHlot5yv/dtrIjV5d/5zA
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

Several places, _PAGE_RW maps to write permission and don't
always imply read. To make it more clear, do as book3s/64 in
commit c7d54842deb1 ("powerpc/mm: Use _PAGE_READ to indicate
Read access") and use _PAGE_WRITE when more relevant.

For the time being _PAGE_WRITE is equivalent to _PAGE_RW but that
will change when _PAGE_READ gets added in following patches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h  |  2 ++
 arch/powerpc/include/asm/nohash/32/pte-44x.h  |  2 ++
 arch/powerpc/include/asm/nohash/32/pte-85xx.h |  2 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h  |  2 +-
 arch/powerpc/include/asm/nohash/pgtable.h     |  9 ++++++---
 arch/powerpc/include/asm/nohash/pte-e500.h    |  2 ++
 arch/powerpc/kernel/head_40x.S                | 12 ++++++------
 arch/powerpc/kernel/head_44x.S                |  4 ++--
 arch/powerpc/kernel/head_85xx.S               |  2 +-
 arch/powerpc/mm/nohash/e500.c                 |  4 ++--
 10 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 0b4e5f8ce3e8..e28ef0f5781e 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -49,6 +49,8 @@
 #define _PAGE_EXEC	0x200	/* hardware: EX permission */
 #define _PAGE_ACCESSED	0x400	/* software: R: page referenced */
 
+#define _PAGE_WRITE	_PAGE_RW
+
 /* No page size encoding in the linux PTE */
 #define _PAGE_PSIZE		0
 
diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
index b7ed13cee137..fc0c075006ea 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
@@ -75,6 +75,8 @@
 #define _PAGE_NO_CACHE	0x00000400		/* H: I bit */
 #define _PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
+#define _PAGE_WRITE	_PAGE_RW
+
 /* No page size encoding in the linux PTE */
 #define _PAGE_PSIZE		0
 
diff --git a/arch/powerpc/include/asm/nohash/32/pte-85xx.h b/arch/powerpc/include/asm/nohash/32/pte-85xx.h
index 16451df5ddb0..462acf69e302 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-85xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-85xx.h
@@ -31,6 +31,8 @@
 #define _PAGE_WRITETHRU	0x00400	/* H: W bit */
 #define _PAGE_SPECIAL	0x00800 /* S: Special page */
 
+#define _PAGE_WRITE	_PAGE_RW
+
 #define _PAGE_KERNEL_RO		0
 #define _PAGE_KERNEL_ROX	_PAGE_EXEC
 #define _PAGE_KERNEL_RW		(_PAGE_DIRTY | _PAGE_RW)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 36b9bad428cc..2202c78730e8 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -149,7 +149,7 @@ static inline void p4d_set(p4d_t *p4dp, unsigned long val)
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 200f2dbf48e2..ee677162f9e6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -84,7 +84,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
+	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
 }
 #endif
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
@@ -123,6 +123,9 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 #ifndef pte_mkwrite_novma
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
+	/*
+	 * write implies read, hence set both
+	 */
 	return __pte(pte_val(pte) | _PAGE_RW);
 }
 #endif
@@ -140,7 +143,7 @@ static inline pte_t pte_mkyoung(pte_t pte)
 #ifndef pte_wrprotect
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_RW);
+	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 #endif
 
@@ -154,7 +157,7 @@ static inline pte_t pte_mkexec(pte_t pte)
 #ifndef pte_write
 static inline int pte_write(pte_t pte)
 {
-	return pte_val(pte) & _PAGE_RW;
+	return pte_val(pte) & _PAGE_WRITE;
 }
 #endif
 #ifndef pte_read
diff --git a/arch/powerpc/include/asm/nohash/pte-e500.h b/arch/powerpc/include/asm/nohash/pte-e500.h
index 9f9e3f02d414..b775c7d465a4 100644
--- a/arch/powerpc/include/asm/nohash/pte-e500.h
+++ b/arch/powerpc/include/asm/nohash/pte-e500.h
@@ -55,6 +55,8 @@
 #define _PAGE_KERNEL_ROX	(_PAGE_BAP_SR | _PAGE_BAP_SX)
 #define _PAGE_USER		(_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */
 
+#define _PAGE_WRITE	_PAGE_RW
+
 #define _PAGE_SPECIAL	_PAGE_SW0
 
 /* Base page size */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index b32e7b2ebdcf..9f92f5c5e6aa 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -316,9 +316,9 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	andc.	r9, r9, r11		/* Check permission */
 	bne	5f
 
-	rlwinm	r9, r11, 1, _PAGE_RW	/* dirty => rw */
-	and	r9, r9, r11		/* hwwrite = dirty & rw */
-	rlwimi	r11, r9, 0, _PAGE_RW	/* replace rw by hwwrite */
+	rlwinm	r9, r11, 1, _PAGE_WRITE	/* dirty => w */
+	and	r9, r9, r11		/* hwwrite = dirty & w */
+	rlwimi	r11, r9, 0, _PAGE_WRITE	/* replace w by hwwrite */
 
 	/* Create TLB tag.  This is the faulting address plus a static
 	 * set of bits.  These are size, valid, E, U0.
@@ -400,9 +400,9 @@ _ASM_NOKPROBE_SYMBOL(\name\()_virt)
 	andc.	r9, r9, r11		/* Check permission */
 	bne	5f
 
-	rlwinm	r9, r11, 1, _PAGE_RW	/* dirty => rw */
-	and	r9, r9, r11		/* hwwrite = dirty & rw */
-	rlwimi	r11, r9, 0, _PAGE_RW	/* replace rw by hwwrite */
+	rlwinm	r9, r11, 1, _PAGE_WRITE	/* dirty => w */
+	and	r9, r9, r11		/* hwwrite = dirty & w */
+	rlwimi	r11, r9, 0, _PAGE_WRITE	/* replace w by hwwrite */
 
 	/* Create TLB tag.  This is the faulting address plus a static
 	 * set of bits.  These are size, valid, E, U0.
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index a3197c9f721c..858dabf84432 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -342,7 +342,7 @@ interrupt_base:
 	mtspr	SPRN_MMUCR,r12
 
 	/* Mask of required permission bits. Note that while we
-	 * do copy ESR:ST to _PAGE_RW position as trying to write
+	 * do copy ESR:ST to _PAGE_WRITE position as trying to write
 	 * to an RO page is pretty common, we don't do it with
 	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
 	 * event so I'd rather take the overhead when it happens
@@ -586,7 +586,7 @@ finish_tlb_load_44x:
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
 
 	/* Mask of required permission bits. Note that while we
-	 * do copy ESR:ST to _PAGE_RW position as trying to write
+	 * do copy ESR:ST to _PAGE_WRITE position as trying to write
 	 * to an RO page is pretty common, we don't do it with
 	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
 	 * event so I'd rather take the overhead when it happens
diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
index 97e9ea0c7297..594756a62c8e 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -471,7 +471,7 @@ END_BTB_FLUSH_SECTION
 
 4:
 	/* Mask of required permission bits. Note that while we
-	 * do copy ESR:ST to _PAGE_RW position as trying to write
+	 * do copy ESR:ST to _PAGE_WRITE position as trying to write
 	 * to an RO page is pretty common, we don't do it with
 	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
 	 * event so I'd rather take the overhead when it happens
diff --git a/arch/powerpc/mm/nohash/e500.c b/arch/powerpc/mm/nohash/e500.c
index 5b7d7a932bfd..921c3521ec11 100644
--- a/arch/powerpc/mm/nohash/e500.c
+++ b/arch/powerpc/mm/nohash/e500.c
@@ -117,7 +117,7 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	TLBCAM[index].MAS2 |= (flags & _PAGE_ENDIAN) ? MAS2_E : 0;
 
 	TLBCAM[index].MAS3 = (phys & MAS3_RPN) | MAS3_SR;
-	TLBCAM[index].MAS3 |= (flags & _PAGE_RW) ? MAS3_SW : 0;
+	TLBCAM[index].MAS3 |= (flags & _PAGE_WRITE) ? MAS3_SW : 0;
 	if (mmu_has_feature(MMU_FTR_BIG_PHYS))
 		TLBCAM[index].MAS7 = (u64)phys >> 32;
 
@@ -125,7 +125,7 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	if (!is_kernel_addr(virt)) {
 		TLBCAM[index].MAS3 |= MAS3_UR;
 		TLBCAM[index].MAS3 |= (flags & _PAGE_EXEC) ? MAS3_UX : 0;
-		TLBCAM[index].MAS3 |= (flags & _PAGE_RW) ? MAS3_UW : 0;
+		TLBCAM[index].MAS3 |= (flags & _PAGE_WRITE) ? MAS3_UW : 0;
 	} else {
 		TLBCAM[index].MAS3 |= (flags & _PAGE_EXEC) ? MAS3_SX : 0;
 	}
-- 
2.41.0

