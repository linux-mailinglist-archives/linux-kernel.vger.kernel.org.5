Return-Path: <linux-kernel+bounces-167788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFCD8BAF34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A5AB20CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D801509AB;
	Fri,  3 May 2024 14:46:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED73481B9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747584; cv=none; b=UrSTzX1g4txwervnagXNYoMofXHU3zGEAmUdPY7yik/Ii75oWTjHEw/KYmKNff+GbkXPfXt8Ueio2NSw9WOwVV49Idyd7+7Pba7UJwaWbcANwcZH0qa9EK0Ax74yDrOeHYuooNJLUpBMshmi1ds6H+qso/zznrdSh9njnpf4fvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747584; c=relaxed/simple;
	bh=kWqiep5rLwVcxJZx2krdYCSspIL0Q2oL4VTCAonzyTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjmh5g+rMEiQswaIG8gQeVjZjLA3h2e3zgvVh3SRBXsM13bjk6nWVS+Bg0xZiFMxJi1aR7UEBYu1aIR6hmbfgbzCTpyFYwpQ6cFYPMB9cxRgcnb/YagIkThG7/CJkk9CH8KK8OOm2BY2vsIJOuMWmmjAFgCR2Xep6lm0dLOWKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 020FB143D;
	Fri,  3 May 2024 07:46:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8FC3F8A4;
	Fri,  3 May 2024 07:46:20 -0700 (PDT)
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
Subject: [PATCH v4 1/4] arm64/mm: generalize PMD_PRESENT_INVALID for all levels
Date: Fri,  3 May 2024 15:45:59 +0100
Message-ID: <20240503144604.151095-2-ryan.roberts@arm.com>
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

As preparation for the next patch, which frees up the PTE_PROT_NONE
present pte and swap pte bit, generalize PMD_PRESENT_INVALID to
PTE_PRESENT_INVALID. This will then be used to mark PROT_NONE ptes (and
entries at any other level) in the next patch.

While we're at it, fix up the swap pte format comment to include
PTE_PRESENT_INVALID. This is not new, it just wasn't previously
documented.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable-prot.h |  8 ++++----
 arch/arm64/include/asm/pgtable.h      | 21 ++++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index dd9ee67d1d87..cdbf51eef7a6 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -21,11 +21,11 @@
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
 
 /*
- * This bit indicates that the entry is present i.e. pmd_page()
- * still points to a valid huge page in memory even if the pmd
- * has been invalidated.
+ * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
+ * interpreted according to the HW layout by SW but any attempted HW access to
+ * the address will result in a fault. pte_present() returns true.
  */
-#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
+#define PTE_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
 
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..7156c940ac4f 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -132,6 +132,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
 #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
+#define pte_present_invalid(pte) \
+	((pte_val(pte) & (PTE_VALID | PTE_PRESENT_INVALID)) == PTE_PRESENT_INVALID)
 /*
  * Execute-only user mappings do not have the PTE_USER bit set. All valid
  * kernel mappings have the PTE_UXN bit set.
@@ -261,6 +263,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_VALID));
 }
 
+static inline pte_t pte_mkinvalid(pte_t pte)
+{
+	pte = set_pte_bit(pte, __pgprot(PTE_PRESENT_INVALID));
+	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
+	return pte;
+}
+
 static inline pmd_t pmd_mkcont(pmd_t pmd)
 {
 	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
@@ -478,7 +487,7 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
-#define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
+#define pmd_present_invalid(pmd)	pte_present_invalid(pmd_pte(pmd))
 
 static inline int pmd_present(pmd_t pmd)
 {
@@ -508,14 +517,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
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
 
@@ -1251,6 +1253,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  *	bits 3-7:	swap type
  *	bits 8-57:	swap offset
  *	bit  58:	PTE_PROT_NONE (must be zero)
+ *	bit  59:	PTE_PRESENT_INVALID (must be zero)
  */
 #define __SWP_TYPE_SHIFT	3
 #define __SWP_TYPE_BITS		5
-- 
2.43.0


