Return-Path: <linux-kernel+bounces-106160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C197487EA03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C45282BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2F48CC6;
	Mon, 18 Mar 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIErSYoa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3448CFC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768259; cv=none; b=GtjyeLszEb7GeVLM4PsYF6RWJNRI1HCc/A354KujeHkippxqlhs62Ab5ijvvt8F9d8QfA3fku1WETIbA8uJNYtSIC4DwlWdoD+qXUaPKsWJ8e4dRM3Wnjr4NDhSTNa/bw0fKLhS4OD5nFpPowCfb+2drT5nvw6OKALuxGv3sDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768259; c=relaxed/simple;
	bh=/VuJKYILT3YfCYMBoMhHCBG0ry/0kkaiuCo4GcM3XUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2uGSHda6fbu8LcQROvbu/lQzdKxdTQQa4vntBaLnKQOZVKihWiO/p7T4THYLLVxYI2phr1rIiutFyptz74lnmhPLYnyTYfHvKLDJ8oTQve4FNy2FBcvQFxija2GD2yo06ykcdR0FmkrCPP/h+mKMzZw9Ofd2OU89gL/FSZdqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIErSYoa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710768257; x=1742304257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/VuJKYILT3YfCYMBoMhHCBG0ry/0kkaiuCo4GcM3XUM=;
  b=iIErSYoavemJ8s4uRbYC9Ss1phBm0bUXixntazvO/BKYXfuCiN8eh3d3
   eu4e4wDjF0E78ImcTVaLrMn4mBDowsOr1QyO2UW5Rg3G8Uvbmk3sbGclZ
   9jklzrJjwbBd7hJRwASPnzVlUTBAQZKT3wpD6weqY8VJlyaiwuYjyl9oV
   AyrM0ngLiZ26TdmQX9fYGAhKzRSDZHMD0VvUJDc9TCFJK2CZioosaZB2Y
   UU+L0dL+nlQsmwF6bl7VoofRsfd/AUR4Xxbw8e2e5+uMhYVZMvdbEnaFn
   yHpDYNTfMLPGnt63C+7ELWJu34a9i+I92gz/ZUCf3qBCJClajs8IZalhK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23037926"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23037926"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14102734"
Received: from adr-par-inspur1.iind.intel.com ([10.223.93.209])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:24:14 -0700
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
Subject: [PATCH v2 1/3] mm/damon: mm infrastructure support
Date: Mon, 18 Mar 2024 18:58:46 +0530
Message-Id: <20240318132848.82686-2-aravinda.prasad@intel.com>
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

This patch adds mm infrastructure support to set and test
access bits at different levels of the page table tree.

The patch also adds support to check if a give address
is in the PMD/PUD/PGD address range.

Signed-off-by: Alan Nair <alan.nair@intel.com>
Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
---
 arch/x86/include/asm/pgtable.h | 20 +++++++++
 arch/x86/mm/pgtable.c          | 28 +++++++++++-
 include/linux/mmu_notifier.h   | 36 ++++++++++++++++
 include/linux/pgtable.h        | 79 ++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7621a5acb13e..b8d505194282 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -164,11 +164,24 @@ static inline bool pud_dirty(pud_t pud)
 	return pud_flags(pud) & _PAGE_DIRTY_BITS;
 }
 
+#define pud_young pud_young
 static inline int pud_young(pud_t pud)
 {
 	return pud_flags(pud) & _PAGE_ACCESSED;
 }
 
+#define p4d_young p4d_young
+static inline int p4d_young(p4d_t p4d)
+{
+	return p4d_flags(p4d) & _PAGE_ACCESSED;
+}
+
+#define pgd_young pgd_young
+static inline int pgd_young(pgd_t pgd)
+{
+	return pgd_flags(pgd) & _PAGE_ACCESSED;
+}
+
 static inline int pte_write(pte_t pte)
 {
 	/*
@@ -1329,10 +1342,17 @@ extern int pudp_set_access_flags(struct vm_area_struct *vma,
 				 pud_t entry, int dirty);
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
+#define pudp_test_and_clear_young pudp_test_and_clear_young
+#define p4dp_test_and_clear_young p4dp_test_and_clear_young
+#define pgdp_test_and_clear_young pgdp_test_and_clear_young
 extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long addr, pmd_t *pmdp);
 extern int pudp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long addr, pud_t *pudp);
+extern int p4dp_test_and_clear_young(struct vm_area_struct *vma,
+				     unsigned long addr, p4d_t *p4dp);
+extern int pgdp_test_and_clear_young(struct vm_area_struct *vma,
+				     unsigned long addr, pgd_t *pgdp);
 
 #define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
 extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ff690ddc2334..9f8e08326b43 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -578,9 +578,7 @@ int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int pudp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long addr, pud_t *pudp)
 {
@@ -594,6 +592,32 @@ int pudp_test_and_clear_young(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
+int p4dp_test_and_clear_young(struct vm_area_struct *vma,
+			      unsigned long addr, p4d_t *p4dp)
+{
+	int ret = 0;
+
+	if (p4d_young(*p4dp))
+		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
+					 (unsigned long *)p4dp);
+
+	return ret;
+}
+
+int pgdp_test_and_clear_young(struct vm_area_struct *vma,
+			      unsigned long addr, pgd_t *pgdp)
+{
+	int ret = 0;
+
+	if (pgd_young(*pgdp))
+		ret = test_and_clear_bit(_PAGE_BIT_ACCESSED,
+					 (unsigned long *)pgdp);
+
+	return ret;
+}
+#endif
+
 int ptep_clear_flush_young(struct vm_area_struct *vma,
 			   unsigned long address, pte_t *ptep)
 {
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index f349e08a9dfe..ec7fc170882e 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -581,6 +581,39 @@ static inline void mmu_notifier_range_init_owner(
 	__young;							\
 })
 
+#define pudp_clear_young_notify(__vma, __address, __pudp)		\
+({									\
+	int __young;							\
+	struct vm_area_struct *___vma = __vma;				\
+	unsigned long ___address = __address;				\
+	__young = pudp_test_and_clear_young(___vma, ___address, __pudp);\
+	__young |= mmu_notifier_clear_young(___vma->vm_mm, ___address,	\
+					    ___address + PUD_SIZE);	\
+	__young;							\
+})
+
+#define p4dp_clear_young_notify(__vma, __address, __p4dp)		\
+({									\
+	int __young;							\
+	struct vm_area_struct *___vma = __vma;				\
+	unsigned long ___address = __address;				\
+	__young = p4dp_test_and_clear_young(___vma, ___address, __p4dp);\
+	__young |= mmu_notifier_clear_young(___vma->vm_mm, ___address,	\
+					    ___address + P4D_SIZE);	\
+	__young;							\
+})
+
+#define pgdp_clear_young_notify(__vma, __address, __pgdp)		\
+({									\
+	int __young;							\
+	struct vm_area_struct *___vma = __vma;				\
+	unsigned long ___address = __address;				\
+	__young = pgdp_test_and_clear_young(___vma, ___address, __pgdp);\
+	__young |= mmu_notifier_clear_young(___vma->vm_mm, ___address,	\
+					    ___address + PGDIR_SIZE);	\
+	__young;							\
+})
+
 /*
  * set_pte_at_notify() sets the pte _after_ running the notifier.
  * This is safe to start by updating the secondary MMUs, because the primary MMU
@@ -690,6 +723,9 @@ static inline void mmu_notifier_subscriptions_destroy(struct mm_struct *mm)
 #define pmdp_clear_flush_young_notify pmdp_clear_flush_young
 #define ptep_clear_young_notify ptep_test_and_clear_young
 #define pmdp_clear_young_notify pmdp_test_and_clear_young
+#define pudp_clear_young_notify pudp_test_and_clear_young
+#define p4dp_clear_young_notify p4dp_test_and_clear_young
+#define pgdp_clear_young_notify pgdp_test_and_clear_young
 #define	ptep_clear_flush_notify ptep_clear_flush
 #define pmdp_huge_clear_flush_notify pmdp_huge_clear_flush
 #define pudp_huge_clear_flush_notify pudp_huge_clear_flush
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..09c3e8bb11bf 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -184,6 +184,27 @@ static inline int pmd_young(pmd_t pmd)
 }
 #endif
 
+#ifndef pud_young
+static inline int pud_young(pud_t pud)
+{
+	return 0;
+}
+#endif
+
+#ifndef p4d_young
+static inline int p4d_young(p4d_t p4d)
+{
+	return 0;
+}
+#endif
+
+#ifndef pgd_young
+static inline int pgd_young(pgd_t pgd)
+{
+	return 0;
+}
+#endif
+
 #ifndef pmd_dirty
 static inline int pmd_dirty(pmd_t pmd)
 {
@@ -386,6 +407,33 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
 #endif
 
+#ifndef pudp_test_and_clear_young
+static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pud_t *pudp)
+{
+	return 0;
+}
+#endif
+
+#ifndef p4dp_test_and_clear_young
+static inline int p4dp_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    p4d_t *p4dp)
+{
+	return 0;
+}
+#endif
+
+#ifndef pgdp_test_and_clear_young
+static inline int pgdp_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address,
+					    pgd_t *pgdp)
+{
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 int ptep_clear_flush_young(struct vm_area_struct *vma,
 			   unsigned long address, pte_t *ptep);
@@ -1090,6 +1138,37 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
 #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
 #endif
 
+/*
+ * When walking page tables, get the address of the current boundary,
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
-- 
2.21.3


