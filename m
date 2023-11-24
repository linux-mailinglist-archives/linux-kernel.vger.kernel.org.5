Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63CD7F74EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjKXN1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345265AbjKXN0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7810C6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NG++BiHeM5ZPoN7pJxd4ztX7J63H+nPZ6vnmgIm1VTs=;
        b=OylzUnkJL6FYu3Btmdy0zUw1R1cv0f54gxDEhntt2B3N3j/XH+YD8SaeA0dZZFEPNFLgCa
        qpwsi4c9Q8S7x8buln12N0uGRmR6PINAIqN2v4UOn31dPGjm8e6tYlq7pIGCH99V7nGdTq
        70/DFohTmolUdY7h+KBf5SSvi2IVkOw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-ZJGKa9ZtNFmIPA6BX8h3SQ-1; Fri,
 24 Nov 2023 08:26:43 -0500
X-MC-Unique: ZJGKa9ZtNFmIPA6BX8h3SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0023E2806052;
        Fri, 24 Nov 2023 13:26:43 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 476F32166B2A;
        Fri, 24 Nov 2023 13:26:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH WIP v1 03/20] mm: convert folio_estimated_sharers() to folio_mapped_shared() and improve it
Date:   Fri, 24 Nov 2023 14:26:08 +0100
Message-ID: <20231124132626.235350-4-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Callers of folio_estimated_sharers() only care about "mapped shared vs.
mapped exclusively". Let's rename the function and improve our detection
for partially-mappable folios (i.e., PTE-mapped THPs).

For now we can only implement, based on our guess, "certainly mapped
shared vs. maybe mapped exclusively". Ideally, we'd have something like
"maybe mapped shared vs. certainly mapped exclusive" -- or even better
"certainly mapped shared vs. certainly mapped exclusively" instead. But
these semantics are currently impossible using our guess-based heuristic
we apply for partially-mappable folios.

Naming the function "folio_certainly_mapped_shared" could be possible,
but let's just keep it simple an call it "folio_mapped_shared" and
document the fuzziness that applies for now.

As we can now read the total mapcount of large folios very efficiently,
use that to improve our implementation, falling back to making a guess only
in case the folio is not "obviously mapped shared".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 68 +++++++++++++++++++++++++++++++++++++++-------
 mm/huge_memory.c   |  2 +-
 mm/madvise.c       |  6 ++--
 mm/memory.c        |  2 +-
 mm/mempolicy.c     | 14 ++++------
 mm/migrate.c       |  2 +-
 6 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fe91aaefa3db..17dac913f367 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2114,21 +2114,69 @@ static inline size_t folio_size(struct folio *folio)
 }
 
 /**
- * folio_estimated_sharers - Estimate the number of sharers of a folio.
+ * folio_mapped_shared - Report if a folio is certainly mapped by
+ *			 multiple entities in their page tables
  * @folio: The folio.
  *
- * folio_estimated_sharers() aims to serve as a function to efficiently
- * estimate the number of processes sharing a folio. This is done by
- * looking at the precise mapcount of the first subpage in the folio, and
- * assuming the other subpages are the same. This may not be true for large
- * folios. If you want exact mapcounts for exact calculations, look at
- * page_mapcount() or folio_mapcount().
+ * This function checks if a folio is certainly *currently* mapped by
+ * multiple entities in their page table ("mapped shared") or if the folio
+ * may be mapped exclusively by a single entity ("mapped exclusively").
  *
- * Return: The estimated number of processes sharing a folio.
+ * Usually, we consider a single entity to be a single MM. However, some
+ * folios (KSM, pagecache) can be mapped multiple times into the same MM.
+ *
+ * For KSM folios, each individual page table mapping is considered a
+ * separate entity. So if a KSM folio is mapped multiple times into the
+ * same process, it is considered "mapped shared".
+ *
+ * For pagecache folios that are entirely mapped multiple times into the
+ * same MM (i.e., multiple VMAs in the same MM cover the same
+ * file range), we traditionally (and for simplicity) consider them,
+ * "mapped shared". For partially-mapped folios (e..g, PTE-mapped THP), we
+ * might detect them either as "mapped shared" or "mapped exclusively" --
+ * whatever is simpler.
+ *
+ * For small folios and entirely mapped large folios (e.g., hugetlb,
+ * PMD-mapped PMD-sized THP), the result will be exactly correct.
+ *
+ * For all other (partially-mappable) folios, such as PTE-mapped THP, the
+ * return value is partially fuzzy: true is not fuzzy, because it means
+ * "certainly mapped shared", but false means "maybe mapped exclusively".
+ *
+ * Note that this function only considers *current* page table mappings
+ * tracked via rmap -- that properly adjusts the folio mapcount(s) -- and
+ * does not consider:
+ * (1) any way the folio might get mapped in the (near) future (e.g.,
+ *     swapcache, pagecache, temporary unmapping for migration).
+ * (2) any way a folio might be mapped besides using the rmap (PFN mappings).
+ * (3) any form of page table sharing.
+ *
+ * Return: Whether the folio is certainly mapped by multiple entities.
  */
-static inline int folio_estimated_sharers(struct folio *folio)
+static inline bool folio_mapped_shared(struct folio *folio)
 {
-	return page_mapcount(folio_page(folio, 0));
+	unsigned int total_mapcount;
+
+	if (likely(!folio_test_large(folio)))
+		return atomic_read(&folio->page._mapcount) != 0;
+	total_mapcount = folio_total_mapcount(folio);
+
+	/* A single mapping implies "mapped exclusively". */
+	if (total_mapcount == 1)
+		return false;
+
+	/* If there is an entire mapping, it must be the only mapping. */
+	if (folio_entire_mapcount(folio) || unlikely(folio_test_hugetlb(folio)))
+		return total_mapcount != 1;
+	/*
+	 * Partially-mappable folios are tricky ... but some are "obviously
+	 * mapped shared": if we have more (PTE) mappings than we have pages
+	 * in the folio, some other entity is certainly involved.
+	 */
+	if (total_mapcount > folio_nr_pages(folio))
+		return true;
+	/* ... guess based on the mapcount of the first page of the folio. */
+	return atomic_read(&folio->page._mapcount) > 0;
 }
 
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f31f02472396..874eeeb90e0b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1638,7 +1638,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (folio_estimated_sharers(folio) != 1)
+	if (folio_mapped_shared(folio))
 		goto out;
 
 	if (!folio_trylock(folio))
diff --git a/mm/madvise.c b/mm/madvise.c
index cf4d694280e9..1a82867c8c2e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -365,7 +365,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_estimated_sharers(folio) != 1)
+		if (folio_mapped_shared(folio))
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -441,7 +441,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_estimated_sharers(folio) != 1)
+			if (folio_mapped_shared(folio))
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
@@ -665,7 +665,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_estimated_sharers(folio) != 1)
+			if (folio_mapped_shared(folio))
 				break;
 			if (!folio_trylock(folio))
 				break;
diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..6bcfa763a146 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4848,7 +4848,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Flag if the folio is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
 	 */
-	if (folio_estimated_sharers(folio) > 1 && (vma->vm_flags & VM_SHARED))
+	if (folio_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..0492113497cc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -605,12 +605,11 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
-	 * To check if the folio is shared, ideally we want to make sure
-	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated sharers of the folio instead.
+	 * See folio_mapped_shared() on possible imprecision when we cannot
+	 * easily detect if a folio is shared.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
-	    (folio_estimated_sharers(folio) == 1 && !hugetlb_pmd_shared(pte)))
+	    (!folio_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
 		if (!isolate_hugetlb(folio, qp->pagelist))
 			qp->nr_failed++;
 unlock:
@@ -988,11 +987,10 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
 	 * Choosing not to migrate a shared folio is not counted as a failure.
 	 *
-	 * To check if the folio is shared, ideally we want to make sure
-	 * every page is mapped to the same process. Doing that is very
-	 * expensive, so check the estimated sharers of the folio instead.
+	 * See folio_mapped_shared() on possible imprecision when we cannot
+	 * easily detect if a folio is shared.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
+	if ((flags & MPOL_MF_MOVE_ALL) || !folio_mapped_shared(folio)) {
 		if (folio_isolate_lru(folio)) {
 			list_add_tail(&folio->lru, foliolist);
 			node_stat_mod_folio(folio,
diff --git a/mm/migrate.c b/mm/migrate.c
index 35a88334bb3c..fda41bc09903 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2559,7 +2559,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	 * every page is mapped to the same process. Doing that is very
 	 * expensive, so check the estimated mapcount of the folio instead.
 	 */
-	if (folio_estimated_sharers(folio) != 1 && folio_is_file_lru(folio) &&
+	if (folio_mapped_shared(folio) && folio_is_file_lru(folio) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
-- 
2.41.0

