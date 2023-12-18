Return-Path: <linux-kernel+bounces-3385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033ED816BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C10F1C229DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1B3984A;
	Mon, 18 Dec 2023 10:52:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B1B37D10
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D081E1424;
	Mon, 18 Dec 2023 02:53:00 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00DE33F738;
	Mon, 18 Dec 2023 02:52:12 -0800 (PST)
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
Subject: [PATCH v4 16/16] arm64/mm: Implement clear_ptes() to optimize exit, munmap, dontneed
Date: Mon, 18 Dec 2023 10:51:00 +0000
Message-Id: <20231218105100.172635-17-ryan.roberts@arm.com>
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

With the core-mm changes in place to batch-clear ptes during
zap_pte_range(), we can take advantage of this in arm64 to greatly
reduce the number of tlbis we have to issue, and recover the lost
performance in exit, munmap and madvise(DONTNEED) incured when adding
support for transparent contiguous ptes.

If we are clearing a whole contpte range, we can elide first unfolding
that range and save the tlbis. We just clear the whole range.

The following microbenchmark results demonstate the effect of this
change on madvise(DONTNEED) performance for large pte-mapped folios.
madvise(dontneed) is called for each page of a 1G populated mapping and
the total time is measured. 100 iterations per run, 8 runs performed on
both Apple M2 (VM) and Ampere Altra (bare metal). Tests performed for
case where 1G memory is comprised of pte-mapped order-9 folios. Negative
is faster, positive is slower, compared to baseline upon which the
series is based:

| dontneed      |    Apple M2 VM    |    Ampere Altra   |
| order-9       |-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    7.9% |    0.0% |    0.0% |
| before-change |   -1.3% |    7.0% |   13.0% |    0.0% |
| after-change  |   -9.9% |    0.9% |   14.1% |    0.0% |

The memory is initially all contpte-mapped and has to be unfolded (which
requires tlbi for the whole block) when the first page is touched (since
the test is madvise-ing 1 page at a time). Ampere Altra has high cost
for tlbi; this is why cost increases there.

The following microbenchmark results demonstate the recovery (and
overall improvement) of munmap performance for large pte-mapped folios.
munmap is called for a 1G populated mapping and the function runtime is
measured. 100 iterations per run, 8 runs performed on both Apple M2 (VM)
and Ampere Altra (bare metal). Tests performed for case where 1G memory
is comprised of pte-mapped order-9 folios. Negative is faster, positive
is slower, compared to baseline upon which the series is based:

| munmap        |    Apple M2 VM    |    Ampere Altra   |
| order-9       |-------------------|-------------------|
| (pte-map)     |    mean |   stdev |    mean |   stdev |
|---------------|---------|---------|---------|---------|
| baseline      |    0.0% |    6.4% |    0.0% |    0.1% |
| before-change |   43.3% |    1.9% |  375.2% |    0.0% |
| after-change  |   -6.0% |    1.4% |   -0.6% |    0.2% |

Tested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 42 +++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          | 45 ++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d4805f73b9db..f5bf059291c3 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -953,6 +953,29 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
+static inline pte_t __clear_ptes(struct mm_struct *mm,
+				 unsigned long address, pte_t *ptep,
+				 unsigned int nr, int full)
+{
+	pte_t orig_pte = __ptep_get_and_clear(mm, address, ptep);
+	unsigned int i;
+	pte_t pte;
+
+	for (i = 1; i < nr; i++) {
+		address += PAGE_SIZE;
+		ptep++;
+		pte = __ptep_get_and_clear(mm, address, ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return orig_pte;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
@@ -1151,6 +1174,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
 extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, unsigned int nr);
+extern pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, unsigned int nr, int full);
 extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
@@ -1279,6 +1304,22 @@ static inline void pte_clear(struct mm_struct *mm,
 	__pte_clear(mm, addr, ptep);
 }
 
+#define clear_ptes clear_ptes
+static inline pte_t clear_ptes(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep,
+				unsigned int nr, int full)
+{
+	pte_t pte;
+
+	if (nr == 1) {
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+		pte = __ptep_get_and_clear(mm, addr, ptep);
+	} else
+		pte = contpte_clear_ptes(mm, addr, ptep, nr, full);
+
+	return pte;
+}
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pte_t *ptep)
@@ -1366,6 +1407,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 #define set_pte					__set_pte
 #define set_ptes				__set_ptes
 #define pte_clear				__pte_clear
+#define clear_ptes				__clear_ptes
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear			__ptep_get_and_clear
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 72e672024785..6f2a15ac5163 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -293,6 +293,51 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(contpte_set_ptes);
 
+pte_t contpte_clear_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+					unsigned int nr, int full)
+{
+	/*
+	 * If we cover a partial contpte block at the beginning or end of the
+	 * batch, unfold if currently folded. This makes it safe to clear some
+	 * of the entries while keeping others. contpte blocks in the middle of
+	 * the range, which are fully covered don't need to be unfolded because
+	 * we will clear the full block.
+	 */
+
+	unsigned int i;
+	pte_t pte;
+	pte_t tail;
+
+	if (!mm_is_user(mm))
+		return __clear_ptes(mm, addr, ptep, nr, full);
+
+	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
+		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
+
+	if (ptep + nr != contpte_align_down(ptep + nr))
+		contpte_try_unfold(mm, addr + PAGE_SIZE * (nr - 1),
+				   ptep + nr - 1,
+				   __ptep_get(ptep + nr - 1));
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+
+	for (i = 1; i < nr; i++) {
+		addr += PAGE_SIZE;
+		ptep++;
+
+		tail = __ptep_get_and_clear(mm, addr, ptep);
+
+		if (pte_dirty(tail))
+			pte = pte_mkdirty(pte);
+
+		if (pte_young(tail))
+			pte = pte_mkyoung(pte);
+	}
+
+	return pte;
+}
+EXPORT_SYMBOL(contpte_clear_ptes);
+
 int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 					unsigned long addr, pte_t *ptep)
 {
-- 
2.25.1


