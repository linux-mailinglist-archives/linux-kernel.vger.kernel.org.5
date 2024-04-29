Return-Path: <linux-kernel+bounces-162409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77668B5AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415DF1F22B92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9EE7BAFE;
	Mon, 29 Apr 2024 14:02:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF33DB8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399343; cv=none; b=koWdxbEXWNXGUGUMlcrJCnoEoU0eXAIMsGxQPSQFDkPiBaAgr0cLJD2fik7ct8xKK+7oATjsmO6jaOPCq35ZTSAFQpjVxXguURJiGjajJnDeADX+tAaDrm0c1q/ih2Yq+P2KRtN1B/vPrhS2HR/KY8CsMVdw73rfDNtwcr7ikHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399343; c=relaxed/simple;
	bh=rwIrzOdVSI/en4rtgoExxd0zcC9SugENgWBIIW43Pog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWtm9kOHzKc1uBb2pSZGD/wQ882PWvq+51Mvr9vZ20n7pqWPNz5aWaxCq5hFFdLgr3MdsqnNApvMgbq3Sd0rqkGfSSkSOeZVCFq32Nlnk9bErXLoSpg26Vz0VlVI3eJ9e00KTY4tn8mxN8mrrGDmauYOV16NiYysmebNTulyh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DD0F339;
	Mon, 29 Apr 2024 07:02:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F35653F793;
	Mon, 29 Apr 2024 07:02:18 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and PTE_PROT_NONE bits
Date: Mon, 29 Apr 2024 15:02:05 +0100
Message-Id: <20240429140208.238056-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429140208.238056-1-ryan.roberts@arm.com>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the PMD_PRESENT_INVALID and PTE_PROT_NONE functionality
explicitly occupy 2 bits in the PTE when PTE_VALID/PMD_SECT_VALID is
clear. This has 2 significant consequences:

  - PTE_PROT_NONE consumes a precious SW PTE bit that could be used for
    other things.
  - The swap pte layout must reserve those same 2 bits and ensure they
    are both always zero for a swap pte. It would be nice to reclaim at
    least one of those bits.

Note that while PMD_PRESENT_INVALID technically only applies to pmds,
the swap pte layout is common to ptes and pmds so we are currently
effectively reserving that bit at both levels.

Let's replace PMD_PRESENT_INVALID with a more generic PTE_INVALID bit,
which occupies the same position (bit 59) but applies uniformly to
page/block descriptors at any level. This bit is only interpretted when
PTE_VALID is clear. If it is set, then the pte is still considered
present; pte_present() returns true and all the fields in the pte follow
the HW interpretation (e.g. SW can safely call pte_pfn(), etc). But
crucially, the HW treats the pte as invalid and will fault if it hits.

With this in place, we can remove PTE_PROT_NONE entirely and instead
represent PROT_NONE as a present but invalid pte (PTE_VALID=0,
PTE_INVALID=1) with PTE_USER=0 and PTE_UXN=1. This is a unique
combination that is not used anywhere else.

The net result is a clearer, simpler, more generic encoding scheme that
applies uniformly to all levels. Additionally we free up a PTE SW bit a
swap pte bit (bit 58 in both cases).

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 11 ++------
 arch/arm64/include/asm/pgtable.h      | 38 ++++++++++++---------------
 2 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index dd9ee67d1d87..de62e6881154 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,14 +18,7 @@
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
-#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
-
-/*
- * This bit indicates that the entry is present i.e. pmd_page()
- * still points to a valid huge page in memory even if the pmd
- * has been invalidated.
- */
-#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
+#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
 
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
@@ -103,7 +96,7 @@ static inline bool __pure lpa2_is_enabled(void)
 		__val;							\
 	 })
 
-#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_INVALID | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
 #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..8dd4637d6b56 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 /*
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
-#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
+#define pte_present(pte)	(pte_valid(pte) || pte_invalid(pte))
 #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
@@ -132,6 +132,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
 #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
+#define pte_invalid(pte)	((pte_val(pte) & (PTE_VALID | PTE_INVALID)) == PTE_INVALID)
 /*
  * Execute-only user mappings do not have the PTE_USER bit set. All valid
  * kernel mappings have the PTE_UXN bit set.
@@ -261,6 +262,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_VALID));
 }
 
+static inline pte_t pte_mkinvalid(pte_t pte)
+{
+	pte = set_pte_bit(pte, __pgprot(PTE_INVALID));
+	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
+	return pte;
+}
+
 static inline pmd_t pmd_mkcont(pmd_t pmd)
 {
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
@@ -469,7 +477,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
+	return pte_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
 }
 
 static inline int pmd_protnone(pmd_t pmd)
@@ -478,12 +486,7 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
-#define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
-
-static inline int pmd_present(pmd_t pmd)
-{
-	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
-}
+#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 
 /*
  * THP definitions.
@@ -508,14 +511,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
-
-static inline pmd_t pmd_mkinvalid(pmd_t pmd)
-{
-	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
-	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
-
-	return pmd;
-}
+#define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
 
 #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
 
@@ -1027,7 +1023,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
 	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
+			      PTE_INVALID | PTE_VALID | PTE_WRITE | PTE_GP |
 			      PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
@@ -1076,17 +1072,17 @@ static inline int pgd_devmap(pgd_t pgd)
 #ifdef CONFIG_PAGE_TABLE_CHECK
 static inline bool pte_user_accessible_page(pte_t pte)
 {
-	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
+	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
 }
 
 static inline bool pmd_user_accessible_page(pmd_t pmd)
 {
-	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
+	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
 }
 
 static inline bool pud_user_accessible_page(pud_t pud)
 {
-	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
+	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
 }
 #endif
 
@@ -1250,7 +1246,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  *	bits 2:		remember PG_anon_exclusive
  *	bits 3-7:	swap type
  *	bits 8-57:	swap offset
- *	bit  58:	PTE_PROT_NONE (must be zero)
+ *	bit  59:	PTE_INVALID (must be zero)
  */
 #define __SWP_TYPE_SHIFT	3
 #define __SWP_TYPE_BITS		5
-- 
2.25.1


