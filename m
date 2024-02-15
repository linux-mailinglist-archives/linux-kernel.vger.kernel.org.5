Return-Path: <linux-kernel+bounces-66651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1D4855F83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E669D28FF40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49984128836;
	Thu, 15 Feb 2024 10:33:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307412FF87
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993186; cv=none; b=T2CPcUosqDn1nhRRZ+KjryazCJeOe0VX0Cr3SvqPc6KzS+Mi+Ee8Ztq/UGBzJ8JfkUtwyOXSAe7zL4oFdAFqESzUZZAjxEgnpV5PinfYcIMK0TWWERgvvi+izgebEmUU2zKnm2JBmBVmFFtFH9wjgmffXRcZcpVm3oj4/YrV9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993186; c=relaxed/simple;
	bh=s3rVu8Pm88GImVMzq9AF6tvBQ4XPr1Ygmvq1to5V4ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dAbkt/7B/W4LV8CHthX3WbiifimbI0A01mTg9uP05xEadFVQp6m6W++zAg7Bzu32/UJdLm/GAxjLGru0PGGq8SQYhkR/jZLoylN2g3DdbK2DSyM41/p106Jsx5AAARJ476AXIicNPNhcEa7hQsESlnCmEJPzlNwHC+hUy68zwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D79D1595;
	Thu, 15 Feb 2024 02:33:45 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B7C3F7B4;
	Thu, 15 Feb 2024 02:33:01 -0800 (PST)
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
Subject: [PATCH v6 13/18] arm64/mm: Implement new wrprotect_ptes() batch API
Date: Thu, 15 Feb 2024 10:32:00 +0000
Message-Id: <20240215103205.2607016-14-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215103205.2607016-1-ryan.roberts@arm.com>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the contpte implementation to fix some of the fork performance
regression introduced by the initial contpte commit. Subsequent patches
will solve it entirely.

During fork(), any private memory in the parent must be write-protected.
Previously this was done 1 PTE at a time. But the core-mm supports
batched wrprotect via the new wrprotect_ptes() API. So let's implement
that API and for fully covered contpte mappings, we no longer need to
unfold the contpte. This has 2 benefits:

  - reduced unfolding, reduces the number of tlbis that must be issued.
  - The memory remains contpte-mapped ("folded") in the parent, so it
    continues to benefit from the more efficient use of the TLB after
    the fork.

The optimization to wrprotect a whole contpte block without unfolding is
possible thanks to the tightening of the Arm ARM in respect to the
definition and behaviour when 'Misprogramming the Contiguous bit'. See
section D21194 at https://developer.arm.com/documentation/102105/ja-07/

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 61 ++++++++++++++++++++++++++------
 arch/arm64/mm/contpte.c          | 38 ++++++++++++++++++++
 2 files changed, 89 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 831099cfc96b..8643227c318b 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -978,16 +978,12 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-/*
- * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
- * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
- */
-static inline void __ptep_set_wrprotect(struct mm_struct *mm,
-					unsigned long address, pte_t *ptep)
+static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep,
+					pte_t pte)
 {
-	pte_t old_pte, pte;
+	pte_t old_pte;
 
-	pte = __ptep_get(ptep);
 	do {
 		old_pte = pte;
 		pte = pte_wrprotect(pte);
@@ -996,6 +992,25 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
 	} while (pte_val(pte) != pte_val(old_pte));
 }
 
+/*
+ * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
+ * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
+ */
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
+{
+	___ptep_set_wrprotect(mm, address, ptep, __ptep_get(ptep));
+}
+
+static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
+				pte_t *ptep, unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
+		__ptep_set_wrprotect(mm, address, ptep);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
@@ -1149,6 +1164,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
+extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr);
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
@@ -1268,12 +1285,35 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return contpte_ptep_clear_flush_young(vma, addr, ptep);
 }
 
+#define wrprotect_ptes wrprotect_ptes
+static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr)
+{
+	if (likely(nr == 1)) {
+		/*
+		 * Optimization: wrprotect_ptes() can only be called for present
+		 * ptes so we only need to check contig bit as condition for
+		 * unfold, and we can remove the contig bit from the pte we read
+		 * to avoid re-reading. This speeds up fork() which is sensitive
+		 * for order-0 folios. Equivalent to contpte_try_unfold().
+		 */
+		pte_t orig_pte = __ptep_get(ptep);
+
+		if (unlikely(pte_cont(orig_pte))) {
+			__contpte_try_unfold(mm, addr, ptep, orig_pte);
+			orig_pte = pte_mknoncont(orig_pte);
+		}
+		___ptep_set_wrprotect(mm, addr, ptep, orig_pte);
+	} else {
+		contpte_wrprotect_ptes(mm, addr, ptep, nr);
+	}
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-	__ptep_set_wrprotect(mm, addr, ptep);
+	wrprotect_ptes(mm, addr, ptep, 1);
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
@@ -1305,6 +1345,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define ptep_clear_flush_young			__ptep_clear_flush_young
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define ptep_set_wrprotect			__ptep_set_wrprotect
+#define wrprotect_ptes				__wrprotect_ptes
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 6d7f40667fa2..bedb58524535 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -26,6 +26,26 @@ static inline pte_t *contpte_align_down(pte_t *ptep)
 	return PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * CONT_PTES);
 }
 
+static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, unsigned int nr)
+{
+	/*
+	 * Unfold any partially covered contpte block at the beginning and end
+	 * of the range.
+	 */
+
+	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+	if (ptep + nr != contpte_align_down(ptep + nr)) {
+		unsigned long last_addr = addr + PAGE_SIZE * (nr - 1);
+		pte_t *last_ptep = ptep + nr - 1;
+
+		contpte_try_unfold(mm, last_addr, last_ptep,
+				   __ptep_get(last_ptep));
+	}
+}
+
 static void contpte_convert(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, pte_t pte)
 {
@@ -238,6 +258,24 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
 
+void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, unsigned int nr)
+{
+	/*
+	 * If wrprotecting an entire contig range, we can avoid unfolding. Just
+	 * set wrprotect and wait for the later mmu_gather flush to invalidate
+	 * the tlb. Until the flush, the page may or may not be wrprotected.
+	 * After the flush, it is guaranteed wrprotected. If it's a partial
+	 * range though, we must unfold, because we can't have a case where
+	 * CONT_PTE is set but wrprotect applies to a subset of the PTEs; this
+	 * would cause it to continue to be unpredictable after the flush.
+	 */
+
+	contpte_try_unfold_partial(mm, addr, ptep, nr);
+	__wrprotect_ptes(mm, addr, ptep, nr);
+}
+EXPORT_SYMBOL(contpte_wrprotect_ptes);
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
-- 
2.25.1


