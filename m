Return-Path: <linux-kernel+bounces-66873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0F88562F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA081C21C0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819512CD9C;
	Thu, 15 Feb 2024 12:18:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF712BF18
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999491; cv=none; b=ty2nw6D8KBbRzM/7iOLuuHQvynwR/CUjO0mRVemo/zIGKAMle7gZ8v9SGjGlUDlgAPPbPkMpWZHidMczUrcPtB+ugpVqrbZyvQYUMc/FxMYRIQ0eBW8s1mrNJAqc0OrGw3QliYjmrVj8jgHXs4bDwQPKY3epUaNcw4nqJWNkmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999491; c=relaxed/simple;
	bh=3HoTIqHBsoYmtmbX/YO4jZ7nHqPVAeaeLJeXivTjHog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWsvrUE7NXG9dqUSFD5WhHSztDLBjjLM4diH2TdaiXlkI8AXZ2E+22a4u8sLxQpFo0fFxQaocP00repr645pUaDz4gl9TpLxhNCDidgiRpAWo+0f7zRqDAk5GvHnM8wC0258HNY1KoptJb8x/AqC4NxOpILxIeSwtABVVeDFtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA08EDA7;
	Thu, 15 Feb 2024 04:18:48 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9A03F766;
	Thu, 15 Feb 2024 04:18:06 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/4] mm: Introduce ptep_get_lockless_norecency()
Date: Thu, 15 Feb 2024 12:17:53 +0000
Message-Id: <20240215121756.2734131-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215121756.2734131-1-ryan.roberts@arm.com>
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of contpte mapping support for arm64, that
architecture's implementation of ptep_get_lockless() has become very
complex due to the need to gather access and dirty bits from across all
of the ptes in the contpte block. This requires careful implementation
to ensure the returned value is consistent (because its not possible to
read all ptes atomically), but even in the common case when there is no
racing modification, we have to read all ptes, which gives an ~O(n^2)
cost if the core-mm is iterating over a range, and performing a
ptep_get_lockless() on each pte.

Solve this by introducing ptep_get_lockless_norecency(), which does not
make any guarantees about access and dirty bits. Therefore it can simply
read the single target pte.

At the same time, convert all call sites that previously used
ptep_get_lockless() but don't care about access and dirty state.

We may want to do something similar for ptep_get() (i.e.
ptep_get_norecency()) in future; it doesn't suffer from the consistency
problem because the PTL serializes it with any modifications, but does
suffer the same O(n^2) cost.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/pgtable.h | 37 ++++++++++++++++++++++++++++++++++---
 kernel/events/core.c    |  2 +-
 mm/hugetlb.c            |  2 +-
 mm/khugepaged.c         |  2 +-
 mm/memory.c             |  2 +-
 mm/swap_state.c         |  2 +-
 mm/swapfile.c           |  2 +-
 7 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a36cf4e124b0..9dd40fdbd825 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -528,16 +528,47 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 #endif /* CONFIG_PGTABLE_LEVELS > 2 */
 #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */

-/*
- * We require that the PTE can be read atomically.
- */
 #ifndef ptep_get_lockless
+/**
+ * ptep_get_lockless - Get a pte without holding the page table lock. Young and
+ *                     dirty bits are guaranteed to accurately reflect the state
+ *                     of the pte at the time of the call.
+ * @ptep: Page table pointer for pte to get.
+ *
+ * If young and dirty information is not required, use
+ * ptep_get_lockless_norecency() which can be faster on some architectures.
+ *
+ * May be overridden by the architecture; otherwise, implemented using
+ * ptep_get(), on the assumption that it is atomic.
+ *
+ * Context: Any.
+ */
 static inline pte_t ptep_get_lockless(pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
 #endif

+#ifndef ptep_get_lockless_norecency
+/**
+ * ptep_get_lockless_norecency - Get a pte without holding the page table lock.
+ *				 Young and dirty bits may not be accurate.
+ * @ptep: Page table pointer for pte to get.
+ *
+ * Prefer this over ptep_get_lockless() when young and dirty information is not
+ * required since it can be faster on some architectures.
+ *
+ * May be overridden by the architecture; otherwise, implemented using the more
+ * precise ptep_get_lockless().
+ *
+ * Context: Any.
+ */
+static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
+{
+	return ptep_get_lockless(ptep);
+}
+#endif
+
 #ifndef pmdp_get_lockless
 static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..27991312d635 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7583,7 +7583,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 	if (!ptep)
 		goto again;

-	pte = ptep_get_lockless(ptep);
+	pte = ptep_get_lockless_norecency(ptep);
 	if (pte_present(pte))
 		size = pte_leaf_size(pte);
 	pte_unmap(ptep);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 68283e54c899..41dc44eb8454 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7517,7 +7517,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	}

 	if (pte) {
-		pte_t pteval = ptep_get_lockless(pte);
+		pte_t pteval = ptep_get_lockless_norecency(pte);

 		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
 	}
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2771fc043b3b..1a6c9ed8237a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1019,7 +1019,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 			}
 		}

-		vmf.orig_pte = ptep_get_lockless(pte);
+		vmf.orig_pte = ptep_get_lockless_norecency(pte);
 		if (!is_swap_pte(vmf.orig_pte))
 			continue;

diff --git a/mm/memory.c b/mm/memory.c
index 4dd8e35b593a..8e65fa1884f1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4353,7 +4353,7 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
 	int i;

 	for (i = 0; i < nr_pages; i++) {
-		if (!pte_none(ptep_get_lockless(pte + i)))
+		if (!pte_none(ptep_get_lockless_norecency(pte + i)))
 			return false;
 	}

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2f540748f7c0..061c6c16c7ff 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -837,7 +837,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			if (!pte)
 				break;
 		}
-		pentry = ptep_get_lockless(pte);
+		pentry = ptep_get_lockless_norecency(pte);
 		if (!is_swap_pte(pentry))
 			continue;
 		entry = pte_to_swp_entry(pentry);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d1bd8d1e17bd..c414dd238814 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1857,7 +1857,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				break;
 		}

-		ptent = ptep_get_lockless(pte);
+		ptent = ptep_get_lockless_norecency(pte);

 		if (!is_swap_pte(ptent))
 			continue;
--
2.25.1


