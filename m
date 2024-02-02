Return-Path: <linux-kernel+bounces-49429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2033B846A46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5CF4B23B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669E48CD2;
	Fri,  2 Feb 2024 08:09:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC0487B3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861360; cv=none; b=sP3SLULRfSh4QpOdQ0QS+vp4UE58Ss2QtkqmOFDWA9tcq40dRQrUPCkAMOyMwQquNYe6+hI3uIMhoOzoLejRJhhjEB6Jq9WR3q6Pi+epnABpe+zyocnJv5W/angcI3grgjpF3+g6uov+kdMCPtQxjZNcthc6QCLyqDBvSx4iAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861360; c=relaxed/simple;
	bh=hFfYP9KENb9rMHRp0685ZgXed0sztaJk1+kn5wN++FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDWishRlD0kkvwYUxqT2E1wjwcGisqmPYRSelwgKuDHqUJYIH3hfTfeWxknU8YW55TzNG1VleVRa+La6PZGYhXccXggHg9G6cTu+q09JGzNp0pihD5Kxk0udDC/jcKAmLgkA0+9udFhy9XCbzRFLDPAZxIcDMB8Omy0oAbXa1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD2351BA8;
	Fri,  2 Feb 2024 00:09:59 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C16503F5A1;
	Fri,  2 Feb 2024 00:09:13 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/25] arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
Date: Fri,  2 Feb 2024 08:07:47 +0000
Message-Id: <20240202080756.1453939-17-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new layer for the in-table PTE manipulation APIs. For now, The
existing API is prefixed with double underscore to become the
arch-private API and the public API is just a simple wrapper that calls
the private API.

The public API implementation will subsequently be used to transparently
manipulate the contiguous bit where appropriate. But since there are
already some contig-aware users (e.g. hugetlb, kernel mapper), we must
first ensure those users use the private API directly so that the future
contig-bit manipulations in the public API do not interfere with those
existing uses.

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 10 ++++++----
 arch/arm64/mm/fault.c            |  6 +++---
 arch/arm64/mm/hugetlbpage.c      |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 4c2d6c483390..fe27a3175618 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -312,7 +312,7 @@ static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
 
 	/*
 	 * Check for potential race with hardware updates of the pte
-	 * (ptep_set_access_flags safely changes valid ptes without going
+	 * (__ptep_set_access_flags safely changes valid ptes without going
 	 * through an invalid entry).
 	 */
 	VM_WARN_ONCE(!pte_young(pte),
@@ -854,8 +854,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
 }
 
-#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-extern int ptep_set_access_flags(struct vm_area_struct *vma,
+extern int __ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
 				 pte_t entry, int dirty);
 
@@ -865,7 +864,8 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp,
 					pmd_t entry, int dirty)
 {
-	return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
+	return __ptep_set_access_flags(vma, address, (pte_t *)pmdp,
+							pmd_pte(entry), dirty);
 }
 
 static inline int pud_devmap(pud_t pud)
@@ -1141,6 +1141,8 @@ void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
 #define ptep_clear_flush_young			__ptep_clear_flush_young
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define ptep_set_wrprotect			__ptep_set_wrprotect
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags			__ptep_set_access_flags
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 23d0dfc16686..dbbc06cfb848 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -209,9 +209,9 @@ static void show_pte(unsigned long addr)
  *
  * Returns whether or not the PTE actually changed.
  */
-int ptep_set_access_flags(struct vm_area_struct *vma,
-			  unsigned long address, pte_t *ptep,
-			  pte_t entry, int dirty)
+int __ptep_set_access_flags(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep,
+			    pte_t entry, int dirty)
 {
 	pteval_t old_pteval, pteval;
 	pte_t pte = READ_ONCE(*ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f6612f3e1c07..9949b80baac8 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -459,7 +459,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	pte_t orig_pte;
 
 	if (!pte_cont(pte))
-		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
 	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 	dpfn = pgsize >> PAGE_SHIFT;
-- 
2.25.1


