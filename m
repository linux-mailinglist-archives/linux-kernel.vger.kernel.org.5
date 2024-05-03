Return-Path: <linux-kernel+bounces-167789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBC8BAF35
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C351F22D2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439F45BEF;
	Fri,  3 May 2024 14:46:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA824F60D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747585; cv=none; b=kys3JN9lxw2X0Z7DpVIgiZZQ4qZ0wxVDCwLhwtauaHxDrwa13ZT57h560VGG9Uy3aTi150aC36Gu+QYP6XjjEwRRGTkKkZKSRFAz+gjHWEcBm4FVCEcdVPKxZphejmWPjaNOFZQH66Cqz5LzGGcDDa6/+YQUMaCV8o/kxsJDjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747585; c=relaxed/simple;
	bh=rqDoo2cucSxnf+KUF/BGKQ/qMT4ww2vZxyGa7U/Y9So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndkp+fUY1HIQVwImb+LD3CEWPLF6kFh//VdQdb2FNJq+2QuWyw63QVC+dRDho2vRWlfvJMzX2oTjpb6bgNQrtoSsIkvebwuUunL4JLx64JAMS+PFGJ/ZHK8Sk7ocAv5ziISU5iS4SaQnOrtYFXUV1td4BGfZ9lkGdFcw+BaDQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFA5F13D5;
	Fri,  3 May 2024 07:46:48 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F035A3F73F;
	Fri,  3 May 2024 07:46:21 -0700 (PDT)
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
Subject: [PATCH v4 2/4] arm64/mm: Remove PTE_PROT_NONE bit
Date: Fri,  3 May 2024 15:46:00 +0100
Message-ID: <20240503144604.151095-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503144604.151095-1-ryan.roberts@arm.com>
References: <20240503144604.151095-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the PTE_PRESENT_INVALID and PTE_PROT_NONE functionality
explicitly occupy 2 bits in the PTE when PTE_VALID/PMD_SECT_VALID is
clear. This has 2 significant consequences:

  - PTE_PROT_NONE consumes a precious SW PTE bit that could be used for
    other things.
  - The swap pte layout must reserve those same 2 bits and ensure they
    are both always zero for a swap pte. It would be nice to reclaim at
    least one of those bits.

But PTE_PRESENT_INVALID, which since the previous patch, applies
uniformly to page/block descriptors at any level when PTE_VALID is
clear, can already give us most of what PTE_PROT_NONE requires: If it is
set, then the pte is still considered present; pte_present() returns
true and all the fields in the pte follow the HW interpretation (e.g. SW
can safely call pte_pfn(), etc). But crucially, the HW treats the pte as
invalid and will fault if it hits.

So let's remove PTE_PROT_NONE entirely and instead represent PROT_NONE
as a present but invalid pte (PTE_VALID=0, PTE_PRESENT_INVALID=1) with
PTE_USER=0 and PTE_UXN=1. This is a unique combination that is not used
anywhere else.

The net result is a clearer, simpler, more generic encoding scheme that
applies uniformly to all levels. Additionally we free up a PTE SW bit
and a swap pte bit (bit 58 in both cases).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  3 +--
 arch/arm64/include/asm/pgtable.h      | 31 +++++++++++++++------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index cdbf51eef7a6..81f07b44f7b8 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,7 +18,6 @@
 #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
-#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
 /*
  * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
@@ -103,7 +102,7 @@ static inline bool __pure lpa2_is_enabled(void)
 		__val;							\
 	 })
 
-#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
+#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PRESENT_INVALID | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
 /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
 #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
 #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7156c940ac4f..c0f4471423db 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 /*
  * The following only work if pte_present(). Undefined behaviour otherwise.
  */
-#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
+#define pte_present(pte)	(pte_valid(pte) || pte_present_invalid(pte))
 #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
@@ -478,7 +478,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
+	/*
+	 * pte_present_invalid() tells us that the pte is invalid from HW
+	 * perspective but present from SW perspective, so the fields are to be
+	 * interpretted as per the HW layout. The second 2 checks are the unique
+	 * encoding that we use for PROT_NONE. It is insufficient to only use
+	 * the first check because we share the same encoding scheme with pmds
+	 * which support pmd_mkinvalid(), so can be present-invalid without
+	 * being PROT_NONE.
+	 */
+	return pte_present_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
 }
 
 static inline int pmd_protnone(pmd_t pmd)
@@ -487,12 +496,7 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
-#define pmd_present_invalid(pmd)	pte_present_invalid(pmd_pte(pmd))
-
-static inline int pmd_present(pmd_t pmd)
-{
-	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
-}
+#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 
 /*
  * THP definitions.
@@ -1029,8 +1033,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
 	 */
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
-			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
-			      PTE_ATTRINDX_MASK;
+			      PTE_PRESENT_INVALID | PTE_VALID | PTE_WRITE |
+			      PTE_GP | PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
 		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
@@ -1078,17 +1082,17 @@ static inline int pgd_devmap(pgd_t pgd)
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
 
@@ -1252,7 +1256,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  *	bits 2:		remember PG_anon_exclusive
  *	bits 3-7:	swap type
  *	bits 8-57:	swap offset
- *	bit  58:	PTE_PROT_NONE (must be zero)
  *	bit  59:	PTE_PRESENT_INVALID (must be zero)
  */
 #define __SWP_TYPE_SHIFT	3
-- 
2.43.0


