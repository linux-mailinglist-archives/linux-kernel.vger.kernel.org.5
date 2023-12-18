Return-Path: <linux-kernel+bounces-3384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E8816BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D1928413D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCD381CD;
	Mon, 18 Dec 2023 10:52:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D1F37D20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 384F71FB;
	Mon, 18 Dec 2023 02:52:57 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF4F3F7C5;
	Mon, 18 Dec 2023 02:52:09 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yu Zhao <yuzhao@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/16] arm64/mm: Implement new helpers to optimize fork()
Date: Mon, 18 Dec 2023 10:50:59 +0000
Message-Id: <20231218105100.172635-16-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218105100.172635-1-ryan.roberts@arm.com>
References: <20231218105100.172635-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the core-mm changes in place to batch-copy ptes during fork, we can
take advantage of this in arm64 to greatly reduce the number of tlbis we
have to issue, and recover the lost fork performance incured when adding
support for transparent contiguous ptes.

This optimization covers 2 cases:

2) The memory being CoWed is contpte-sized (or bigger) folios. We set
   wrprotect in the parent and set the ptes in the child for a whole
   contpte block in one hit. This means we can operate on the whole
   block and don't need to unfold/fold.

1) The memory being CoWed is all order-0 folios. No folding or unfolding
   occurs here, but the added cost of checking if we need to fold on
   every pte adds up. Given we are forking, we are just copying the ptes
   already in the parent, so we should be maintaining the single/contpte
   state into the child anyway, and any check for folding will always be
   false. Therefore, we can elide the fold check in set_ptes_full() and
   ptep_set_wrprotects() when full=1.

The optimization to wrprotect a whole contpte block without unfolding is
possible thanks to the tightening of the Arm ARM in respect to the
definition and behaviour when 'Misprogramming the Contiguous bit'. See
section D21194 at https://developer.arm.com/documentation/102105/latest/

The following microbenchmark results demonstate the recovered (and
overall improved) fork performance for large pte-mapped folios once this
patch is applied. Fork is called in a tight loop in a process with 1G of
populated memory and the time for the function to execute is measured.
100 iterations per run, 8 runs performed on both Apple M2 (VM) and
Ampere Altra (bare metal). Tests performed for case where 1G memory is
comprised of pte-mapped order-9 folios. Negative is faster, positive is
slower, compared to baseline upon which the series is based:

| fork          |    Apple M2 VM    |    Ampere Altra   |
| order-9       |-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    1.2% |    0.0% |    0.1% |
| before-change |  541.5% |    2.8% | 3654.4% |    0.0% |
| after-change  |  -25.4% |    1.9% |   -6.7% |    0.1% |

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 97 ++++++++++++++++++++++++++------
 arch/arm64/mm/contpte.c          | 47 ++++++++++++++++
 2 files changed, 128 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e64120452301..d4805f73b9db 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -966,16 +966,12 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
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
@@ -984,6 +980,26 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
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
+static inline void __ptep_set_wrprotects(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep,
+					unsigned int nr, int full)
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
@@ -1139,6 +1155,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
+extern void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr, int full);
 extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep,
 				pte_t entry, int dirty);
@@ -1170,6 +1188,17 @@ static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 		__contpte_try_unfold(mm, addr, ptep, pte);
 }
 
+#define pte_batch_remaining pte_batch_remaining
+static inline unsigned int pte_batch_remaining(pte_t pte, unsigned long addr,
+					unsigned long end)
+{
+	if (!pte_valid_cont(pte))
+		return 1;
+
+	return min(CONT_PTES - ((addr >> PAGE_SHIFT) & (CONT_PTES - 1)),
+		   (end - addr) >> PAGE_SHIFT);
+}
+
 /*
  * The below functions constitute the public API that arm64 presents to the
  * core-mm to manipulate PTE entries within their page tables (or at least this
@@ -1219,20 +1248,30 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 	__set_pte(ptep, pte_mknoncont(pte));
 }
 
-#define set_ptes set_ptes
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte, unsigned int nr)
+#define set_ptes_full set_ptes_full
+static inline void set_ptes_full(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, unsigned int nr,
+				int full)
 {
 	pte = pte_mknoncont(pte);
 
 	if (nr == 1) {
-		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		if (!full)
+			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
 		__set_ptes(mm, addr, ptep, pte, 1);
-		contpte_try_fold(mm, addr, ptep, pte);
+		if (!full)
+			contpte_try_fold(mm, addr, ptep, pte);
 	} else
 		contpte_set_ptes(mm, addr, ptep, pte, nr);
 }
 
+#define set_ptes set_ptes
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	set_ptes_full(mm, addr, ptep, pte, nr, false);
+}
+
 static inline void pte_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
@@ -1272,13 +1311,38 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return contpte_ptep_clear_flush_young(vma, addr, ptep);
 }
 
+#define ptep_set_wrprotects ptep_set_wrprotects
+static inline void ptep_set_wrprotects(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep,
+				unsigned int nr, int full)
+{
+	if (nr == 1) {
+		/*
+		 * Optimization: ptep_set_wrprotects() can only be called for
+		 * present ptes so we only need to check contig bit as condition
+		 * for unfold, and we can remove the contig bit from the pte we
+		 * read to avoid re-reading. This speeds up fork() with is very
+		 * sensitive for order-0 folios. Should be equivalent to
+		 * contpte_try_unfold() for this case.
+		 */
+		pte_t orig_pte = __ptep_get(ptep);
+
+		if (unlikely(pte_cont(orig_pte))) {
+			__contpte_try_unfold(mm, addr, ptep, orig_pte);
+			orig_pte = pte_mknoncont(orig_pte);
+		}
+		___ptep_set_wrprotect(mm, addr, ptep, orig_pte);
+		if (!full)
+			contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
+	} else
+		contpte_set_wrprotects(mm, addr, ptep, nr, full);
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
 {
-	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
-	__ptep_set_wrprotect(mm, addr, ptep);
-	contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
+	ptep_set_wrprotects(mm, addr, ptep, 1, false);
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
@@ -1310,6 +1374,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define ptep_clear_flush_young			__ptep_clear_flush_young
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define ptep_set_wrprotect			__ptep_set_wrprotect
+#define ptep_set_wrprotects			__ptep_set_wrprotects
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags			__ptep_set_access_flags
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 69c36749dd98..72e672024785 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -339,6 +339,53 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
 
+void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
+					pte_t *ptep, unsigned int nr, int full)
+{
+	unsigned long next;
+	unsigned long end;
+
+	if (!mm_is_user(mm))
+		return __ptep_set_wrprotects(mm, addr, ptep, nr, full);
+
+	end = addr + (nr << PAGE_SHIFT);
+
+	do {
+		next = pte_cont_addr_end(addr, end);
+		nr = (next - addr) >> PAGE_SHIFT;
+
+		/*
+		 * If wrprotecting an entire contig range, we can avoid
+		 * unfolding. Just set wrprotect and wait for the later
+		 * mmu_gather flush to invalidate the tlb. Until the flush, the
+		 * page may or may not be wrprotected. After the flush, it is
+		 * guarranteed wrprotected. If its a partial range though, we
+		 * must unfold, because we can't have a case where CONT_PTE is
+		 * set but wrprotect applies to a subset of the PTEs; this would
+		 * cause it to continue to be unpredictable after the flush.
+		 */
+		if (nr != CONT_PTES)
+			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+		__ptep_set_wrprotects(mm, addr, ptep, nr, full);
+
+		addr = next;
+		ptep += nr;
+
+		/*
+		 * If applying to a partial contig range, the change could have
+		 * made the range foldable. Use the last pte in the range we
+		 * just set for comparison, since contpte_try_fold() only
+		 * triggers when acting on the last pte in the contig range.
+		 */
+		if (nr != CONT_PTES)
+			contpte_try_fold(mm, addr - PAGE_SIZE, ptep - 1,
+					 __ptep_get(ptep - 1));
+
+	} while (addr != end);
+}
+EXPORT_SYMBOL(contpte_set_wrprotects);
+
 int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep,
 					pte_t entry, int dirty)
-- 
2.25.1


