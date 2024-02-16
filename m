Return-Path: <linux-kernel+bounces-68431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40E857A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F98CB24E35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C89208D6;
	Fri, 16 Feb 2024 10:16:33 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B83208D3
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078592; cv=none; b=KBp9ia9hJ1WxRHluX1XNpCfjrQfeWnbW6U6pbD/9ogYc56ekmsgIXKUuSxIindVP/vbIzc6Bp7SbiH41/3s6fjM3MJaKNeMSurQwotUBWc8JMSc4Q2NgiZR57+VNjbuUQETFzVd2PYnrxtJF4Hi09G4u4MoYxe7dw8OdD3gx2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078592; c=relaxed/simple;
	bh=8DXc+eR4+MDmbwNPaRZNUUgicrihZ6NZ62h5dkNeecM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okgwig05amOtbOcQSSWEskf1/H2f/g/FmWBAZ4h85gIixbVSYk12lcJV6LNEpPWbiGo9q1dD4Zin5CekimIeFhxPgOEVWpluz3SVQ0cbueDTmsBGgHTakjQPwSOlAmHrEgt/HigXMs7yi54/zNE/zZI4Y21GlN8PnhKuGKOkCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Tbns91g6Fz9syV;
	Fri, 16 Feb 2024 11:16:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKJEwzsnBl-x; Fri, 16 Feb 2024 11:16:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Tbns90bL7z9syQ;
	Fri, 16 Feb 2024 11:16:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 10A0A8B786;
	Fri, 16 Feb 2024 11:16:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5nLgxRzYTWhR; Fri, 16 Feb 2024 11:16:28 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.102])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A2FCA8B765;
	Fri, 16 Feb 2024 11:16:28 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Handle error in mark_rodata_ro() and mark_initmem_nx()
Date: Fri, 16 Feb 2024 11:16:26 +0100
Message-ID: <836f75710daef12dfea55f8fb6055d7fdaf716e3.1708078577.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708078587; l=7919; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=8DXc+eR4+MDmbwNPaRZNUUgicrihZ6NZ62h5dkNeecM=; b=nB684azzkWBlqDDpVJ+y3tjWrC+3GnSHEEgj9lO6nwuI6NED2GL+evpXtYRygjPLncmFQhmYC U/Mm8GxE9jQBE4AtRBqB3gYB8TzdA82/0axTjdy5j5xAi/owJSdAhgW
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

mark_rodata_ro() and mark_initmem_nx() use functions that can
fail like set_memory_nx() and set_memory_ro(), leading to a not
protected kernel.

In case of failure, panic.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/mmu.c |  7 ++++--
 arch/powerpc/mm/mmu_decl.h     |  8 +++----
 arch/powerpc/mm/nohash/8xx.c   | 33 +++++++++++++++++-----------
 arch/powerpc/mm/nohash/e500.c  | 10 ++++++---
 arch/powerpc/mm/pgtable_32.c   | 39 ++++++++++++++++++++++++----------
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 5445587bfe84..100f999871bc 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -193,7 +193,7 @@ static bool is_module_segment(unsigned long addr)
 	return true;
 }
 
-void mmu_mark_initmem_nx(void)
+int mmu_mark_initmem_nx(void)
 {
 	int nb = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
 	int i;
@@ -230,9 +230,10 @@ void mmu_mark_initmem_nx(void)
 
 		mtsr(mfsr(i << 28) | 0x10000000, i << 28);
 	}
+	return 0;
 }
 
-void mmu_mark_rodata_ro(void)
+int mmu_mark_rodata_ro(void)
 {
 	int nb = mmu_has_feature(MMU_FTR_USE_HIGH_BATS) ? 8 : 4;
 	int i;
@@ -245,6 +246,8 @@ void mmu_mark_rodata_ro(void)
 	}
 
 	update_bats();
+
+	return 0;
 }
 
 /*
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 72341b9fb552..6107e4944509 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -160,11 +160,11 @@ static inline unsigned long p_block_mapped(phys_addr_t pa) { return 0; }
 #endif
 
 #if defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_E500)
-void mmu_mark_initmem_nx(void);
-void mmu_mark_rodata_ro(void);
+int mmu_mark_initmem_nx(void);
+int mmu_mark_rodata_ro(void);
 #else
-static inline void mmu_mark_initmem_nx(void) { }
-static inline void mmu_mark_rodata_ro(void) { }
+static inline int mmu_mark_initmem_nx(void) { return 0; }
+static inline int mmu_mark_rodata_ro(void) { return 0; }
 #endif
 
 #ifdef CONFIG_PPC_8xx
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 6be6421086ed..43d4842bb1c7 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -119,23 +119,26 @@ void __init mmu_mapin_immr(void)
 				    PAGE_KERNEL_NCG, MMU_PAGE_512K, true);
 }
 
-static void mmu_mapin_ram_chunk(unsigned long offset, unsigned long top,
-				pgprot_t prot, bool new)
+static int mmu_mapin_ram_chunk(unsigned long offset, unsigned long top,
+			       pgprot_t prot, bool new)
 {
 	unsigned long v = PAGE_OFFSET + offset;
 	unsigned long p = offset;
+	int err = 0;
 
 	WARN_ON(!IS_ALIGNED(offset, SZ_512K) || !IS_ALIGNED(top, SZ_512K));
 
-	for (; p < ALIGN(p, SZ_8M) && p < top; p += SZ_512K, v += SZ_512K)
-		__early_map_kernel_hugepage(v, p, prot, MMU_PAGE_512K, new);
-	for (; p < ALIGN_DOWN(top, SZ_8M) && p < top; p += SZ_8M, v += SZ_8M)
-		__early_map_kernel_hugepage(v, p, prot, MMU_PAGE_8M, new);
-	for (; p < ALIGN_DOWN(top, SZ_512K) && p < top; p += SZ_512K, v += SZ_512K)
-		__early_map_kernel_hugepage(v, p, prot, MMU_PAGE_512K, new);
+	for (; p < ALIGN(p, SZ_8M) && p < top && !err; p += SZ_512K, v += SZ_512K)
+		err = __early_map_kernel_hugepage(v, p, prot, MMU_PAGE_512K, new);
+	for (; p < ALIGN_DOWN(top, SZ_8M) && p < top && !err; p += SZ_8M, v += SZ_8M)
+		err = __early_map_kernel_hugepage(v, p, prot, MMU_PAGE_8M, new);
+	for (; p < ALIGN_DOWN(top, SZ_512K) && p < top && !err; p += SZ_512K, v += SZ_512K)
+		err = __early_map_kernel_hugepage(v, p, prot, MMU_PAGE_512K, new);
 
 	if (!new)
 		flush_tlb_kernel_range(PAGE_OFFSET + v, PAGE_OFFSET + top);
+
+	return err;
 }
 
 unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
@@ -166,27 +169,33 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	return top;
 }
 
-void mmu_mark_initmem_nx(void)
+int mmu_mark_initmem_nx(void)
 {
 	unsigned long etext8 = ALIGN(__pa(_etext), SZ_8M);
 	unsigned long sinittext = __pa(_sinittext);
 	unsigned long boundary = strict_kernel_rwx_enabled() ? sinittext : etext8;
 	unsigned long einittext8 = ALIGN(__pa(_einittext), SZ_8M);
+	int err = 0;
 
 	if (!debug_pagealloc_enabled_or_kfence())
-		mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
+		err = mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
 
 	mmu_pin_tlb(block_mapped_ram, false);
+
+	return err;
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void mmu_mark_rodata_ro(void)
+int mmu_mark_rodata_ro(void)
 {
 	unsigned long sinittext = __pa(_sinittext);
+	int err;
 
-	mmu_mapin_ram_chunk(0, sinittext, PAGE_KERNEL_ROX, false);
+	err = mmu_mapin_ram_chunk(0, sinittext, PAGE_KERNEL_ROX, false);
 	if (IS_ENABLED(CONFIG_PIN_TLB_DATA))
 		mmu_pin_tlb(block_mapped_ram, true);
+
+	return err;
 }
 #endif
 
diff --git a/arch/powerpc/mm/nohash/e500.c b/arch/powerpc/mm/nohash/e500.c
index 921c3521ec11..266fb22131fc 100644
--- a/arch/powerpc/mm/nohash/e500.c
+++ b/arch/powerpc/mm/nohash/e500.c
@@ -285,19 +285,23 @@ void __init adjust_total_lowmem(void)
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void mmu_mark_rodata_ro(void)
+int mmu_mark_rodata_ro(void)
 {
 	unsigned long remapped;
 
 	remapped = map_mem_in_cams(__max_low_memory, CONFIG_LOWMEM_CAM_NUM, false, false);
 
-	WARN_ON(__max_low_memory != remapped);
+	if (WARN_ON(__max_low_memory != remapped))
+		return -EINVAL;
+
+	return 0;
 }
 #endif
 
-void mmu_mark_initmem_nx(void)
+int mmu_mark_initmem_nx(void)
 {
 	/* Everything is done in mmu_mark_rodata_ro() */
+	return 0;
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 5c02fd08d61e..e94919853ca3 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -130,32 +130,41 @@ void __init mapin_ram(void)
 	}
 }
 
-void mark_initmem_nx(void)
+static int __mark_initmem_nx(void)
 {
 	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
 				 PFN_DOWN((unsigned long)_sinittext);
+	int err;
 
-	mmu_mark_initmem_nx();
+	err = mmu_mark_initmem_nx();
 
 	if (!v_block_mapped((unsigned long)_sinittext)) {
-		set_memory_nx((unsigned long)_sinittext, numpages);
-		set_memory_rw((unsigned long)_sinittext, numpages);
+		err = set_memory_nx((unsigned long)_sinittext, numpages);
+		if (err)
+			return err;
+		err = set_memory_rw((unsigned long)_sinittext, numpages);
 	}
+	return err;
+}
+
+void mark_initmem_nx(void)
+{
+	int err = __mark_initmem_nx();
+
+	if (err)
+		panic("%s() failed, err = %d\n", __func__, err);
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void mark_rodata_ro(void)
+static int __mark_rodata_ro(void)
 {
 	unsigned long numpages;
 
 	if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX) && mmu_has_feature(MMU_FTR_HPTE_TABLE))
 		pr_warn("This platform has HASH MMU, STRICT_MODULE_RWX won't work\n");
 
-	if (v_block_mapped((unsigned long)_stext + 1)) {
-		mmu_mark_rodata_ro();
-		ptdump_check_wx();
-		return;
-	}
+	if (v_block_mapped((unsigned long)_stext + 1))
+		return mmu_mark_rodata_ro();
 
 	/*
 	 * mark text and rodata as read only. __end_rodata is set by
@@ -165,7 +174,15 @@ void mark_rodata_ro(void)
 	numpages = PFN_UP((unsigned long)__end_rodata) -
 		   PFN_DOWN((unsigned long)_stext);
 
-	set_memory_ro((unsigned long)_stext, numpages);
+	return set_memory_ro((unsigned long)_stext, numpages);
+}
+
+void mark_rodata_ro(void)
+{
+	int err = __mark_rodata_ro();
+
+	if (err)
+		panic("%s() failed, err = %d\n", __func__, err);
 
 	// mark_initmem_nx() should have already run by now
 	ptdump_check_wx();
-- 
2.43.0


