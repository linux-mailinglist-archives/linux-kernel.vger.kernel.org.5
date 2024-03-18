Return-Path: <linux-kernel+bounces-106161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E987EA08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A74C1F2283D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC80A4CB30;
	Mon, 18 Mar 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjppUe35"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF24CB20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768267; cv=none; b=YxYvRnZux3CYb9N06oOEW59gRo/q75ifwIzDrv6eeLh6I1ngtpQOopzxaXqrX88McYf33e25KzbD+96qIer9LfpQ/eq5/TM3Hjs6w5ejDT1rer2jAzY4//FVlR1fmIvHHy51tTv/aGYFOd2JzcVm+Dr9fhyXHTo3LfiYLp2PhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768267; c=relaxed/simple;
	bh=snDYfeLbVNxVF6bzeLRakha46vIlLpVRETc5gZIsPWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PC2qMv6XiZN1UTYcJt+fxdO1yKhgNNDp88XKqT6tvvM77JcRw/FnHxzir4Mx48c56W3jbowxI0Iu9pPNvwWCDJJweXUngRR3dHvIwT4UlDpaS76vMVIMq99WXFRxy1JLxYYo5bUpK7Ed5t7No7vEE3Yn7pLYyY5XnwJMZX3AFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjppUe35; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710768264; x=1742304264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=snDYfeLbVNxVF6bzeLRakha46vIlLpVRETc5gZIsPWM=;
  b=KjppUe35BAFTSra2PDnQcQ5dZMH7HZOrGQZEi4GDd+uaX6UmB7GO2otY
   q/wP3f9UNuxqJ8U20DNvUJZK+VhszfFDD/UNtFW7bFW/tzexJZwrtMZLQ
   DRx/rZKi6tc3pG86/5WLfyHpqUOAS33tjS314ipPDCw5GSUZvf3SohzW1
   Sqh2ilgIvS627o7wXeh5FW9aOvb+Ka0FTYixHX3xdQsqLhbsRyxvsyFvA
   VwzdvNH5RuZ7XOVPonVRjZFPWEr0STPG9G+1EXqeZPDOl3PnWb48NoX2O
   6VfVaU794ZyoPlPpk6RcD8X5SQjlBnXAKZ3cZzL5OqI4JRvXVpJEDMuzu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23037946"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23037946"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14102758"
Received: from adr-par-inspur1.iind.intel.com ([10.223.93.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:21 -0700
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
	alexander.kanevskiy@intel.com
Subject: [PATCH v2 2/3] mm/damon: profiling enhancement
Date: Mon, 18 Mar 2024 18:58:47 +0530
Message-Id: <20240318132848.82686-3-aravinda.prasad@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20240318132848.82686-1-aravinda.prasad@intel.com>
References: <20240318132848.82686-1-aravinda.prasad@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds profiling enhancement for DAMON.
Given the sampling_addr and its region bounds,
this patch picks the highest possible page table
tree level such that the address range covered by
the picked page table level (P*D) is within the
region's bounds. Once a page table level is picked,
access bit setting and checking is done at that level.
As the higher levels of the page table tree covers
a larger address space, any accessed bit set implies
one or more pages in the given region is accessed.
This helps in quickly identifying hot regions when
the region size is large (e.g., several GBs), which
is common for large footprint applications.

Signed-off-by: Alan Nair <alan.nair@intel.com>
Signed-off-by: Sandeep Kumar <sandeep4.kumar@intel.com>
Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
---
 mm/damon/vaddr.c | 233 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 221 insertions(+), 12 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 381559e4a1fa..daa1a2aedab6 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -52,6 +52,53 @@ static struct mm_struct *damon_get_mm(struct damon_target *t)
 	return mm;
 }
 
+/* Pick the highest possible page table profiling level for addr
+ * in the region defined by start and end
+ */
+static int pick_profile_level(unsigned long start, unsigned long end,
+		unsigned long addr)
+{
+	/* Start with PTE and check if higher levels can be picked */
+	int level = 0;
+
+	if (!arch_has_hw_nonleaf_pmd_young())
+		return level;
+
+	/* Check if PMD or higher can be picked, else use PTE */
+	if (pmd_addr_start(addr, (start) - 1) < start
+			|| pmd_addr_end(addr, (end) + 1) > end)
+		return level;
+
+	level++;
+	/* Check if PUD or higher can be picked, else use PMD */
+	if (pud_addr_start(addr, (start) - 1) < start
+			|| pud_addr_end(addr, (end) + 1) > end)
+		return level;
+
+	if (pgtable_l5_enabled()) {
+		level++;
+		/* Check if P4D or higher can be picked, else use PUD */
+		if (p4d_addr_start(addr, (start) - 1) < start
+				|| p4d_addr_end(addr, (end) + 1) > end)
+			return level;
+	}
+
+	level++;
+	/* Check if PGD can be picked, else return PUD level */
+	if (pgd_addr_start(addr, (start) - 1) < start
+			|| pgd_addr_end(addr, (end) + 1) > end)
+		return level;
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	/* Do not pick PGD level if PTI is enabled */
+	if (static_cpu_has(X86_FEATURE_PTI))
+		return level;
+#endif
+
+	/* Return PGD level */
+	return ++level;
+}
+
 /*
  * Functions for the initial monitoring target regions construction
  */
@@ -387,16 +434,90 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_mkold_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_mkold_ops = {
-	.pmd_entry = damon_mkold_pmd_entry,
+
+#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
+static int damon_mkold_pmd(pmd_t *pmd, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+
+	if (!pmd_present(*pmd))
+		return 0;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	pmdp_clear_young_notify(walk->vma, addr, pmd);
+	spin_unlock(ptl);
+
+	return 0;
+}
+
+static int damon_mkold_pud(pud_t *pud, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+
+	if (!pud_present(*pud))
+		return 0;
+
+	ptl = pud_lock(walk->mm, pud);
+	pudp_clear_young_notify(walk->vma, addr, pud);
+	spin_unlock(ptl);
+
+	return 0;
+}
+
+static int damon_mkold_p4d(p4d_t *p4d, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+
+	if (!p4d_present(*p4d))
+		return 0;
+
+	spin_lock(&mm->page_table_lock);
+	p4dp_clear_young_notify(walk->vma, addr, p4d);
+	spin_unlock(&mm->page_table_lock);
+
+	return 0;
+}
+
+static int damon_mkold_pgd(pgd_t *pgd, unsigned long addr,
+	unsigned long next, struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+
+	if (!pgd_present(*pgd))
+		return 0;
+
+	spin_lock(&mm->page_table_lock);
+	pgdp_clear_young_notify(walk->vma, addr, pgd);
+	spin_unlock(&mm->page_table_lock);
+
+	return 0;
+}
+#endif
+
+static const struct mm_walk_ops damon_mkold_ops[] = {
+	{.pmd_entry = damon_mkold_pmd_entry,
 	.hugetlb_entry = damon_mkold_hugetlb_entry,
-	.walk_lock = PGWALK_RDLOCK,
+	.walk_lock = PGWALK_RDLOCK},
+#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
+	{.pmd_entry = damon_mkold_pmd},
+	{.pud_entry = damon_mkold_pud},
+	{.p4d_entry = damon_mkold_p4d},
+	{.pgd_entry = damon_mkold_pgd},
+#endif
 };
 
-static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
+static void damon_va_mkold(struct mm_struct *mm, struct damon_region *r)
 {
+	unsigned long addr = r->sampling_addr;
+	int profile_level;
+
+	profile_level = pick_profile_level(r->ar.start, r->ar.end, addr);
+
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
+	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops[profile_level], NULL);
 	mmap_read_unlock(mm);
 }
 
@@ -409,7 +530,7 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
 {
 	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
 
-	damon_va_mkold(mm, r->sampling_addr);
+	damon_va_mkold(mm, r);
 }
 
 static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
@@ -531,22 +652,110 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
 #define damon_young_hugetlb_entry NULL
 #endif /* CONFIG_HUGETLB_PAGE */
 
-static const struct mm_walk_ops damon_young_ops = {
-	.pmd_entry = damon_young_pmd_entry,
+
+#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
+static int damon_young_pmd(pmd_t *pmd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!pmd_present(*pmd))
+		return 0;
+
+	ptl = pmd_lock(walk->mm, pmd);
+	if (pmd_young(*pmd) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << PMD_SHIFT);
+	spin_unlock(ptl);
+
+	return 0;
+}
+
+static int damon_young_pud(pud_t *pud, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	spinlock_t *ptl;
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!pud_present(*pud))
+		return 0;
+
+	ptl = pud_lock(walk->mm, pud);
+	if (pud_young(*pud) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << PUD_SHIFT);
+	spin_unlock(ptl);
+
+	return 0;
+}
+
+static int damon_young_p4d(p4d_t *p4d, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!p4d_present(*p4d))
+		return 0;
+
+	spin_lock(&mm->page_table_lock);
+	if (p4d_young(*p4d) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << P4D_SHIFT);
+	spin_unlock(&mm->page_table_lock);
+
+	return 0;
+}
+
+static int damon_young_pgd(pgd_t *pgd, unsigned long addr,
+		unsigned long next, struct mm_walk *walk)
+{
+	struct damon_young_walk_private *priv = walk->private;
+
+	if (!pgd_present(*pgd))
+		return 0;
+
+	spin_lock(&pgd_lock);
+	if (pgd_young(*pgd) || mmu_notifier_test_young(walk->mm, addr))
+		priv->young = true;
+
+	*priv->folio_sz = (1UL << PGDIR_SHIFT);
+	spin_unlock(&pgd_lock);
+
+	return 0;
+}
+#endif
+
+static const struct mm_walk_ops damon_young_ops[] = {
+	{.pmd_entry = damon_young_pmd_entry,
 	.hugetlb_entry = damon_young_hugetlb_entry,
-	.walk_lock = PGWALK_RDLOCK,
+	.walk_lock = PGWALK_RDLOCK},
+#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
+	{.pmd_entry = damon_young_pmd},
+	{.pud_entry = damon_young_pud},
+	{.p4d_entry = damon_young_p4d},
+	{.pgd_entry = damon_young_pgd},
+#endif
 };
 
-static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
+static bool damon_va_young(struct mm_struct *mm, struct damon_region *r,
 		unsigned long *folio_sz)
 {
+	unsigned long addr = r->sampling_addr;
+	int profile_level;
 	struct damon_young_walk_private arg = {
 		.folio_sz = folio_sz,
 		.young = false,
 	};
 
+	profile_level = pick_profile_level(r->ar.start, r->ar.end, addr);
+
 	mmap_read_lock(mm);
-	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
+	walk_page_range(mm, addr, addr + 1, &damon_young_ops[profile_level], &arg);
 	mmap_read_unlock(mm);
 	return arg.young;
 }
@@ -577,7 +786,7 @@ static void __damon_va_check_access(struct mm_struct *mm,
 		return;
 	}
 
-	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
+	last_accessed = damon_va_young(mm, r, &last_folio_sz);
 	damon_update_region_access_rate(r, last_accessed, attrs);
 
 	last_addr = r->sampling_addr;
-- 
2.21.3


