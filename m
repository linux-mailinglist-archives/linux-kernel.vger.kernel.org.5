Return-Path: <linux-kernel+bounces-559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE208142EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45CBB23DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9F134C2;
	Fri, 15 Dec 2023 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IxDRwih5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E75107A0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702626146; x=1734162146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5yeRH864DCWoHH5VGhWvjXrR53z9cs1Wa1o3OaEo9mk=;
  b=IxDRwih5Vr5xVWl2Gden+BorlRxBFQwqYF5XzAGAj/FSawxmSfPp2W0d
   kok4zNeVDRJxzxpB76swHa1oOeEcNWki+tMKwgteWf0oz1+BShvYjo+h6
   UrwfJzMVsjuA//OG0o8JEPGD8YK14mZfIEFxab9jmWlFitLH3AaKgXWfz
   JpbOSlOwOh9st9MJ6UyFbRMNFdltbVpWvj8oTJxdAhO/sz0P5mXdbKXE7
   roZ/v1oSOZAs9/jXIew0x5wJDwCRpGBuj5/MJilNM4Ay6qln0FZA2HQav
   t2u+EDIiFq+E9fARLBAPtde7NMrilFc7svUUfGp70ve4VpWLiyUFzM3xZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385660899"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="385660899"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:42:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808877437"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="808877437"
Received: from adr-par-inspur1.iind.intel.com ([10.223.93.209])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:42:22 -0800
From: Aravinda Prasad <aravinda.prasad@intel.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	linux-kernel@vger.kernel.org
Cc: aravinda.prasad@intel.com,
	s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com,
	ying.huang@intel.com,
	dave.hansen@intel.com,
	dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com,
	antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com,
	Alan Nair <alan.nair@intel.com>
Subject: mm/DAMON: Profiling enhancements for DAMON
Date: Fri, 15 Dec 2023 13:16:19 +0530
Message-Id: <20231215074619.173787-1-aravinda.prasad@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DAMON randomly samples one or more pages in every region and tracks
accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
When the region size is large (e.g., several GBs), which is common
for large footprint applications, detecting whether the region is
accessed or not completely depends on whether the pages that are
actively accessed in the region are picked during random sampling.
If such pages are not picked for sampling, DAMON fails to identify
the region as accessed. However, increasing the sampling rate or
increasing the number of regions increases CPU overheads of kdamond.

This patch proposes profiling different levels of the application’s
page table tree to detect whether a region is accessed or not. This
patch is based on the observation that, when the accessed bit for a
page is set, the accessed bits at the higher levels of the page table
tree (PMD/PUD/PGD) corresponding to the path of the page table walk
are also set. Hence, it is efficient to  check the accessed bits at
the higher levels of the page table tree to detect whether a region
is accessed or not. For example, if the access bit for a PUD entry
is set, then one or more pages in the 1GB PUD subtree is accessed as
each PUD entry covers 1GB mapping. Hence, instead of sampling
thousands of 4K/2M pages to detect accesses in a large region, 
sampling at the higher level of page table tree is faster and efficient.

This patch is based on 6.6.3 kernel.

TODO: Support 5-level page table tree

Evaluation:

- MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
  and 5TB with 10GB hot data.
- DAMON: 5ms sampling, 200ms aggregation interval. Rest all
  parameters set to default value.
- DAMON+PTP: Page table profiling applied to DAMON with the above
  parameters.

Profiling efficiency in detecting hot data [1]:

Footprint	1GB	10GB	100GB	5TB
---------------------------------------------
DAMON		>90%	<50%	 ~0%	  0%
DAMON+PTP	>90%	>90%	>90%	>90%

CPU overheads (in billion cycles) for kdamond:

Footprint	1GB	10GB	100GB	5TB
---------------------------------------------
DAMON		1.15	19.53	3.52	9.55
DAMON+PTP	0.83	 3.20	1.27	2.55

A detailed explanation and evaluation can be found in the arXiv paper:
[1] https://arxiv.org/pdf/2311.10275.pdf

Regards,
Aravinda

Signed-off-by: Alan Nair <alan.nair@intel.com>
Signed-off-by: Sandeep Kumar <sandeep4.kumar@intel.com>
Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
---
 arch/x86/include/asm/pgtable.h |   17 +++++
 include/linux/damon.h          |   13 ++++
 include/linux/pgtable.h        |   31 ++++++++
 mm/damon/core.c                |   28 ++++++++
 mm/damon/vaddr.c               |  146 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 223 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e02b179ec..accdabb95 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -169,6 +169,11 @@ static inline int pud_young(pud_t pud)
 	return pud_flags(pud) & _PAGE_ACCESSED;
 }
 
+static inline int pgd_young(pgd_t pgd)
+{
+	return pgd_flags(pgd) & _PAGE_ACCESSED;
+}
+
 static inline int pte_write(pte_t pte)
 {
 	/*
@@ -681,6 +686,18 @@ static inline pud_t pud_mkwrite(pud_t pud)
 	return pud_clear_saveddirty(pud);
 }
 
+static inline pgd_t pgd_clear_flags(pgd_t pgd, pgdval_t clear)
+{
+	pgdval_t v = native_pgd_val(pgd);
+
+	return native_make_pgd(v & ~clear);
+}
+
+static inline pgd_t pgd_mkold(pgd_t pgd)
+{
+	return pgd_clear_flags(pgd, _PAGE_ACCESSED);
+}
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline int pte_soft_dirty(pte_t pte)
 {
diff --git a/include/linux/damon.h b/include/linux/damon.h
index c70cca8a8..8521a62ec 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -19,6 +19,14 @@
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
+/* DAMON profiling levels */
+enum damon_profile_level {
+	PTE_LEVEL,
+	PMD_LEVEL,
+	PUD_LEVEL,
+	PGD_LEVEL,
+};
+
 /* Get a random number in [l, r) */
 static inline unsigned long damon_rand(unsigned long l, unsigned long r)
 {
@@ -57,6 +65,8 @@ struct damon_region {
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	/* Page table profiling level */
+	enum damon_profile_level profile_level;
 };
 
 /**
@@ -656,6 +666,9 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
 
+enum damon_profile_level pick_profile_level(unsigned long start,
+		unsigned long end, unsigned long addr);
+
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index af7639c3b..82d5f67ea 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -935,6 +935,37 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
 #endif
 
+/*
+ * When walking page tables, get the address of the current/passed boundary,
+ * or the start address of the range if that comes earlier.
+ */
+
+#define pgd_addr_start(addr, start)			\
+({	unsigned long __boundary = (addr) & PGDIR_MASK;	\
+	(__boundary > start) ? __boundary : (start);	\
+})
+
+#ifndef p4d_addr_start
+#define p4d_addr_start(addr, start)			\
+({	unsigned long __boundary = (addr) & P4D_MASK;	\
+	(__boundary > start) ? __boundary : (start);	\
+})
+#endif
+
+#ifndef pud_addr_start
+#define pud_addr_start(addr, start)			\
+({	unsigned long __boundary = (addr) & PUD_MASK;	\
+	(__boundary > start) ? __boundary : (start);	\
+})
+#endif
+
+#ifndef pmd_addr_start
+#define pmd_addr_start(addr, start)			\
+({	unsigned long __boundary = (addr) & PMD_MASK;	\
+	(__boundary > start) ? __boundary : (start);	\
+})
+#endif
+
 /*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fd5be73f6..2a7d5c041 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -31,6 +31,33 @@ static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
 static struct kmem_cache *damon_region_cache __ro_after_init;
 
+/* Pick the highest possible page table profiling level for the
+ * region corresponding to addr
+ */
+enum damon_profile_level pick_profile_level(unsigned long start,
+	unsigned long end, unsigned long addr)
+{
+	enum damon_profile_level level = PTE_LEVEL;
+
+	if (pmd_addr_start(addr, (start) - 1) < start
+		|| pmd_addr_end(addr, (end) + 1) > end)
+		goto out;
+	level = PMD_LEVEL;
+
+	if (pud_addr_start(addr, (start) - 1) < start
+		|| pud_addr_end(addr, (end) + 1) > end)
+		goto out;
+	level = PUD_LEVEL;
+
+	if (pgd_addr_start(addr, (start) - 1) < start
+		|| pgd_addr_end(addr, (end) + 1) > end)
+		goto out;
+	level = PGD_LEVEL;
+
+out:
+	return level;
+}
+
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
 static bool __damon_is_registered_ops(enum damon_ops_id id)
 {
@@ -132,6 +159,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 
 	region->age = 0;
 	region->last_nr_accesses = 0;
+	region->profile_level = PTE_LEVEL;
 
 	return region;
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index cf8a9fc5c..b71221b3e 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -387,16 +387,76 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_mkold_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_mkold_ops = {
-	.pmd_entry = damon_mkold_pmd_entry,
+static int damon_mkold_pmd(pmd_t *pmd, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+
+	if (!pmd_present(*pmd) || pmd_none(*pmd))
+		goto out;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	if (pmd_young(*pmd))
+		*pmd = pmd_mkold(*pmd);
+
+	spin_unlock(ptl);
+
+out:
+	return 0;
+}
+
+static int damon_mkold_pud(pud_t *pud, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+
+	if (!pud_present(*pud) || pud_none(*pud))
+		goto out;
+
+	ptl = pud_lock(walk->mm, pud);
+	if (pud_young(*pud))
+		*pud = pud_mkold(*pud);
+
+	spin_unlock(ptl);
+
+out:
+	return 0;
+}
+
+static int damon_mkold_pgd(pgd_t *pgd, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+
+	if (!pgd_present(*pgd) || pgd_none(*pgd))
+		goto out;
+
+	spin_lock(&pgd_lock);
+	if (pgd_young(*pgd))
+		*pgd = pgd_mkold(*pgd);
+
+	spin_unlock(&pgd_lock);
+
+out:
+	return 0;
+}
+
+static const struct mm_walk_ops damon_mkold_ops[] = {
+	{.pmd_entry = damon_mkold_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
-	.walk_lock = PGWALK_RDLOCK,
+	.walk_lock = PGWALK_RDLOCK},
+	{.pmd_entry = damon_mkold_pmd},
+	{.pud_entry = damon_mkold_pud},
+	{.pgd_entry = damon_mkold_pgd},
 };
 
-static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+static void damon_va_mkold(struct mm_struct *mm, struct damon_region *r)
 {
+	unsigned long addr = r->sampling_addr;
+
+	r->profile_level = pick_profile_level(r->ar.start, r->ar.end, addr);
+
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
+	walk_page_range(mm, addr, addr + 1, damon_mkold_ops + r->profile_level, NULL);
 	mmap_read_unlock(mm);
 }
 
@@ -409,7 +469,7 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_va_mkold(mm, r->sampling_addr);
+	damon_va_mkold(mm, r);
 }
 
 static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
@@ -531,22 +591,84 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_young_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_young_ops = {
-	.pmd_entry = damon_young_pmd_entry,
+static int damon_young_pmd(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!pmd_present(*pmd) || pmd_none(*pmd))
+		goto out;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	if (pmd_young(*pmd) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << PMD_SHIFT);
+	spin_unlock(ptl);
+out:
+	return 0;
+}
+
+static int damon_young_pud(pud_t *pud, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!pud_present(*pud) || pud_none(*pud))
+		goto out;
+
+	ptl = pud_lock(walk->mm, pud);
+	if (pud_young(*pud) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << PUD_SHIFT);
+
+	spin_unlock(ptl);
+out:
+	return 0;
+}
+
+static int damon_young_pgd(pgd_t *pgd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!pgd_present(*pgd) || pgd_none(*pgd))
+		goto out;
+
+	spin_lock(&pgd_lock);
+	if (pgd_young(*pgd) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << PGDIR_SHIFT);
+
+	spin_unlock(&pgd_lock);
+out:
+	return 0;
+}
+
+static const struct mm_walk_ops damon_young_ops[] = {
+	{.pmd_entry = damon_young_pmd_entry,
 	.hugetlb_entry = damon_young_hugetlb_entry,
-	.walk_lock = PGWALK_RDLOCK,
+	.walk_lock = PGWALK_RDLOCK},
+	{.pmd_entry = damon_young_pmd},
+	{.pud_entry = damon_young_pud},
+	{.pgd_entry = damon_young_pgd},
 };
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
+static bool damon_va_young(struct mm_struct *mm, struct damon_region *r,
 		unsigned long *folio_sz)
 {
+	unsigned long addr = r->sampling_addr;
 	struct damon_young_walk_private arg = {
 		.folio_sz = folio_sz,
 		.young = false,
 	};
 
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
+	walk_page_range(mm, addr, addr + 1, damon_young_ops + r->profile_level, &arg);
 	mmap_read_unlock(mm);
 	return arg.young;
 }
@@ -572,7 +694,7 @@ static void __damon_va_check_access(struct mm_struct *mm,
 		return;
 	}
 
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
+	last_accessed = damon_va_young(mm, r, &last_folio_sz);
 	if (last_accessed)
 		r->nr_accesses++;
 

