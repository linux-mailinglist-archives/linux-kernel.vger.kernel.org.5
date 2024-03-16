Return-Path: <linux-kernel+bounces-105166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E187D9E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B2B213F2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A317BAF;
	Sat, 16 Mar 2024 11:18:29 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3961798C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587909; cv=none; b=tInTvoUJmaa24anZ4d2/zze/zWM2LL7qEePTaQXlufvNwdXNm3lbnxJ/YkoSubrW1ryzZoPcHpBi+Di7BRMbr6zPNxDWwlcTD3N1TzZP9bRSY7kw5qSyt3/hh9DQNpUlbE2FtjekUYWEGAGhKpDozD+qaw7jvGX7wZtvZNe3d+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587909; c=relaxed/simple;
	bh=YZudm0mc7oieHhIoGo6jmZA09xujHbMs3Vj+6U3O8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tk6K1zuPetDuTMnyAQyqetYCHDm4lRW03eigfcBVc8kv6YqONwozmkV9C/o41Pm5CwyWlpt/G3qknhAyqg01HaEPBqrVOQo21dwOhsmnhw75mnJoJ6YpB1of6VwEuhQ2cq2bIJoeFxDyu85Dl7/uO4q0Qbhf8uHnSGhu/KGYEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TxdsF1HmZz9sgJ;
	Sat, 16 Mar 2024 12:18:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AmImxgpwDZLg; Sat, 16 Mar 2024 12:18:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TxdsF07B0z9s2l;
	Sat, 16 Mar 2024 12:18:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EB7708B768;
	Sat, 16 Mar 2024 12:18:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 0q9Spab6pB2M; Sat, 16 Mar 2024 12:18:24 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO18731.IDSI0.si.c-s.fr [192.168.233.183])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8638E8B764;
	Sat, 16 Mar 2024 12:18:24 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Handle error in mark_rodata_ro() and mark_initmem_nx()
Date: Sat, 16 Mar 2024 12:18:21 +0100
Message-ID: <b16329611deb89e1af505d43f0e2a91310584d26.1710587887.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710587902; l=8098; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=YZudm0mc7oieHhIoGo6jmZA09xujHbMs3Vj+6U3O8yY=; b=8AixODopzd1V5xuUB+A8j1/mGniaweXfE/AdYMEt140Qd/QjIR/kpvwP+/GGbrvsSYTRbKUGp AvO+WkahkqjCPuqQI7tMM52QWSXPRvqUwE/seWehdsdIr5LbPEyMwbu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

mark_rodata_ro() and mark_initmem_nx() use functions that can
fail like set_memory_nx() and set_memory_ro(), leading to a not
protected kernel.

In case of failure, panic.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/836f75710daef12dfea55f8fb6055d7fdaf716e3.1708078577.git.christophe.leroy@csgroup.eu
---
v2: Rebased on top of 6388eaa7f116 ("Automatic merge of 'master' into merge (2024-03-16 10:18)")
---
 arch/powerpc/mm/book3s32/mmu.c |  7 +++++--
 arch/powerpc/mm/mmu_decl.h     |  8 +++----
 arch/powerpc/mm/nohash/8xx.c   | 33 ++++++++++++++++++-----------
 arch/powerpc/mm/nohash/e500.c  | 10 ++++++---
 arch/powerpc/mm/pgtable_32.c   | 38 +++++++++++++++++++++++++---------
 5 files changed, 65 insertions(+), 31 deletions(-)

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
index 8e84bc214d13..6949c2c937e7 100644
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
index face94977cb2..cfd622ebf774 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -130,31 +130,41 @@ void __init mapin_ram(void)
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
-		return;
-	}
+	if (v_block_mapped((unsigned long)_stext + 1))
+		return mmu_mark_rodata_ro();
 
 	/*
 	 * mark text and rodata as read only. __end_rodata is set by
@@ -164,6 +174,14 @@ void mark_rodata_ro(void)
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
 }
 #endif
-- 
2.43.0


