Return-Path: <linux-kernel+bounces-142715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F72C8A2F41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586281C21000
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8E84DED;
	Fri, 12 Apr 2024 13:19:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B1483A1D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927965; cv=none; b=Lswqkqce1qbkshEyVpqsWsM+qvggdcI3TfWsJJsaGpPB9XQTqefLSORu3CAFuVp8VPkZ54u1cM9Wsu1IBdc3DhSiZX8NI1gT9N3rJP4JQ09DxZk77cDQNagkAw24f13N2m1ACCtfbav8YvZgdSS6E/zOmCJ1viUYVLKXGa3+RTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927965; c=relaxed/simple;
	bh=WrWwUylMw9n+c2YUx9UoDASRMHnmhqUDxagQ8/rue4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbdRodbma1/xSqn1mWgHIFl1fVaPnsZT3Qj7AlyZn2fbSXAuJzvo/TIHjMKvKpF7/py65T37i2TogJRm5j7sniTpBPnSNDf8AScZReFyP28ubTlmGAo8Ubn7g1J1o9xfLAdb4B+JmkZX+Ex0/5y9N7Uw8V4rOUSs6dBZVfzLeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A70915A1;
	Fri, 12 Apr 2024 06:19:52 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 087523F766;
	Fri, 12 Apr 2024 06:19:21 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: [PATCH v3 3/3] arm64: mm: Don't remap pgtables for allocate vs populate
Date: Fri, 12 Apr 2024 14:19:08 +0100
Message-Id: <20240412131908.433043-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412131908.433043-1-ryan.roberts@arm.com>
References: <20240412131908.433043-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During linear map pgtable creation, each pgtable is fixmapped /
fixunmapped twice; once during allocation to zero the memory, and a
again during population to write the entries. This means each table has
2 TLB invalidations issued against it. Let's fix this so that each table
is only fixmapped/fixunmapped once, halving the number of TLBIs, and
improving performance.

Achieve this by separating allocation and initialization (zeroing) of
the page. The allocated page is now fixmapped directly by the walker and
initialized, before being populated and finally fixunmapped.

This approach keeps the change small, but has the side effect that late
allocations (using __get_free_page()) must also go through the generic
memory clearing routine. So let's tell __get_free_page() not to zero the
memory to avoid duplication.

Additionally this approach means that fixmap/fixunmap is still used for
late pgtable modifications. That's not technically needed since the
memory is all mapped in the linear map by that point. That's left as a
possible future optimization if found to be needed.

Execution time of map_mem(), which creates the kernel linear map page
tables, was measured on different machines with different RAM configs:

               | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
               | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
---------------|-------------|-------------|-------------|-------------
               |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
---------------|-------------|-------------|-------------|-------------
before         |   11   (0%) |  161   (0%) |  656   (0%) |  1654   (0%)
after          |   10 (-11%) |  104 (-35%) |  438 (-33%) |  1223 (-26%)

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/include/asm/pgtable.h |  2 +
 arch/arm64/mm/mmu.c              | 67 +++++++++++++++++---------------
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 105a95a8845c..92c9aed5e7af 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1010,6 +1010,8 @@ static inline p4d_t *p4d_offset_kimg(pgd_t *pgdp, u64 addr)
 
 static inline bool pgtable_l5_enabled(void) { return false; }
 
+#define p4d_index(addr)		(((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
+
 /* Match p4d_offset folding in <asm/generic/pgtable-nop4d.h> */
 #define p4d_set_fixmap(addr)		NULL
 #define p4d_set_fixmap_offset(p4dp, addr)	((p4d_t *)p4dp)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ac88b89770a6..c927e9312f10 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -109,28 +109,12 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 static phys_addr_t __init early_pgtable_alloc(int shift)
 {
 	phys_addr_t phys;
-	void *ptr;
 
 	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
 					 MEMBLOCK_ALLOC_NOLEAKTRACE);
 	if (!phys)
 		panic("Failed to allocate page table page\n");
 
-	/*
-	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
-	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
-	 * any level of table.
-	 */
-	ptr = pte_set_fixmap(phys);
-
-	memset(ptr, 0, PAGE_SIZE);
-
-	/*
-	 * Implicit barriers also ensure the zeroed page is visible to the page
-	 * table walker
-	 */
-	pte_clear_fixmap();
-
 	return phys;
 }
 
@@ -172,6 +156,14 @@ bool pgattr_change_is_safe(u64 old, u64 new)
 	return ((old ^ new) & ~mask) == 0;
 }
 
+static void init_clear_pgtable(void *table)
+{
+	clear_page(table);
+
+	/* Ensure the zeroing is observed by page table walks. */
+	dsb(ishst);
+}
+
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
@@ -214,12 +206,15 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			pmdval |= PMD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pte_phys = pgtable_alloc(PAGE_SHIFT);
+		ptep = pte_set_fixmap(pte_phys);
+		init_clear_pgtable(ptep);
+		ptep += pte_index(addr);
 		__pmd_populate(pmdp, pte_phys, pmdval);
-		pmd = READ_ONCE(*pmdp);
+	} else {
+		BUG_ON(pmd_bad(pmd));
+		ptep = pte_set_fixmap_offset(pmdp, addr);
 	}
-	BUG_ON(pmd_bad(pmd));
 
-	ptep = pte_set_fixmap_offset(pmdp, addr);
 	do {
 		pgprot_t __prot = prot;
 
@@ -298,12 +293,15 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			pudval |= PUD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pmd_phys = pgtable_alloc(PMD_SHIFT);
+		pmdp = pmd_set_fixmap(pmd_phys);
+		init_clear_pgtable(pmdp);
+		pmdp += pmd_index(addr);
 		__pud_populate(pudp, pmd_phys, pudval);
-		pud = READ_ONCE(*pudp);
+	} else {
+		BUG_ON(pud_bad(pud));
+		pmdp = pmd_set_fixmap_offset(pudp, addr);
 	}
-	BUG_ON(pud_bad(pud));
 
-	pmdp = pmd_set_fixmap_offset(pudp, addr);
 	do {
 		pgprot_t __prot = prot;
 
@@ -340,12 +338,15 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			p4dval |= P4D_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		pud_phys = pgtable_alloc(PUD_SHIFT);
+		pudp = pud_set_fixmap(pud_phys);
+		init_clear_pgtable(pudp);
+		pudp += pud_index(addr);
 		__p4d_populate(p4dp, pud_phys, p4dval);
-		p4d = READ_ONCE(*p4dp);
+	} else {
+		BUG_ON(p4d_bad(p4d));
+		pudp = pud_set_fixmap_offset(p4dp, addr);
 	}
-	BUG_ON(p4d_bad(p4d));
 
-	pudp = pud_set_fixmap_offset(p4dp, addr);
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);
 
@@ -395,12 +396,15 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			pgdval |= PGD_TABLE_PXN;
 		BUG_ON(!pgtable_alloc);
 		p4d_phys = pgtable_alloc(P4D_SHIFT);
+		p4dp = p4d_set_fixmap(p4d_phys);
+		init_clear_pgtable(p4dp);
+		p4dp += p4d_index(addr);
 		__pgd_populate(pgdp, p4d_phys, pgdval);
-		pgd = READ_ONCE(*pgdp);
+	} else {
+		BUG_ON(pgd_bad(pgd));
+		p4dp = p4d_set_fixmap_offset(pgdp, addr);
 	}
-	BUG_ON(pgd_bad(pgd));
 
-	p4dp = p4d_set_fixmap_offset(pgdp, addr);
 	do {
 		p4d_t old_p4d = READ_ONCE(*p4dp);
 
@@ -467,11 +471,10 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
 
 static phys_addr_t __pgd_pgtable_alloc(int shift)
 {
-	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
-	BUG_ON(!ptr);
+	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
+	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);
 
-	/* Ensure the zeroed page is visible to the page table walker */
-	dsb(ishst);
+	BUG_ON(!ptr);
 	return __pa(ptr);
 }
 
-- 
2.25.1


