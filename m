Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FAE7F74FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbjKXN1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345366AbjKXN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:27:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F57E1BE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700832424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWu/0kIJvur5UANFtettn6VuzgBBSt2XXjypdyFb6aY=;
        b=E1drljMPaYYgsDkAyRrgoAZQkECwwlQYnT824exfvTCspKDlxc3StsNHa8adqhYAlYpmiU
        eid3XrLsNm5/42r01WqszDEYY/Es3nDR9VaKOGIVMaNHlEq7HXv6ToEtkjO+kJtwYMu7Ea
        9kAw1Maz+Oyx9y25DIErl4EqdiRozMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-57hRR764P9m-_xbjczRUpw-1; Fri, 24 Nov 2023 08:27:01 -0500
X-MC-Unique: 57hRR764P9m-_xbjczRUpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCBB085A5BD;
        Fri, 24 Nov 2023 13:26:59 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 003162166B2A;
        Fri, 24 Nov 2023 13:26:56 +0000 (UTC)
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
Subject: [PATCH WIP v1 08/20] mm: pass MM to folio_mapped_shared()
Date:   Fri, 24 Nov 2023 14:26:13 +0100
Message-ID: <20231124132626.235350-9-david@redhat.com>
In-Reply-To: <20231124132626.235350-1-david@redhat.com>
References: <20231124132626.235350-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll need the MM next to make a better decision regarding
partially-mappable folios (e.g., PTE-mapped THP) using per-MM rmap IDs.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  4 +++-
 mm/huge_memory.c   |  2 +-
 mm/madvise.c       |  6 +++---
 mm/memory.c        |  2 +-
 mm/mempolicy.c     | 14 +++++++-------
 mm/migrate.c       |  2 +-
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 17dac913f367..765e688690f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2117,6 +2117,7 @@ static inline size_t folio_size(struct folio *folio)
  * folio_mapped_shared - Report if a folio is certainly mapped by
  *			 multiple entities in their page tables
  * @folio: The folio.
+ * @mm: The mm the folio is mapped into.
  *
  * This function checks if a folio is certainly *currently* mapped by
  * multiple entities in their page table ("mapped shared") or if the folio
@@ -2153,7 +2154,8 @@ static inline size_t folio_size(struct folio *folio)
  *
  * Return: Whether the folio is certainly mapped by multiple entities.
  */
-static inline bool folio_mapped_shared(struct folio *folio)
+static inline bool folio_mapped_shared(struct folio *folio,
+		struct mm_struct *mm)
 {
 	unsigned int total_mapcount;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0228b04c4053..fd7251923557 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1639,7 +1639,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (folio_mapped_shared(folio))
+	if (folio_mapped_shared(folio, mm))
 		goto out;
 
 	if (!folio_trylock(folio))
diff --git a/mm/madvise.c b/mm/madvise.c
index 1a82867c8c2e..e3e4f3ea5f6d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -365,7 +365,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio = pfn_folio(pmd_pfn(orig_pmd));
 
 		/* Do not interfere with other mappings of this folio */
-		if (folio_mapped_shared(folio))
+		if (folio_mapped_shared(folio, mm))
 			goto huge_unlock;
 
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
@@ -441,7 +441,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapped_shared(folio))
+			if (folio_mapped_shared(folio, mm))
 				break;
 			if (pageout_anon_only_filter && !folio_test_anon(folio))
 				break;
@@ -665,7 +665,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_large(folio)) {
 			int err;
 
-			if (folio_mapped_shared(folio))
+			if (folio_mapped_shared(folio, mm))
 				break;
 			if (!folio_trylock(folio))
 				break;
diff --git a/mm/memory.c b/mm/memory.c
index 14416d05e1b6..5048d58d6174 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4848,7 +4848,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Flag if the folio is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
 	 */
-	if (folio_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
+	if (folio_mapped_shared(folio, vma->vm_mm) && (vma->vm_flags & VM_SHARED))
 		flags |= TNF_SHARED;
 
 	nid = folio_nid(folio);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0492113497cc..bd0243da26bf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -418,7 +418,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 };
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
-				unsigned long flags);
+		struct mm_struct *mm, unsigned long flags);
 static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 				pgoff_t ilx, int *nid);
 
@@ -481,7 +481,7 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma) ||
-	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
+	    !migrate_folio_add(folio, qp->pagelist, walk->mm, qp->flags))
 		qp->nr_failed++;
 }
 
@@ -561,7 +561,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 		if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 		    !vma_migratable(vma) ||
-		    !migrate_folio_add(folio, qp->pagelist, flags)) {
+		    !migrate_folio_add(folio, qp->pagelist, walk->mm, flags)) {
 			qp->nr_failed++;
 			if (strictly_unmovable(flags))
 				break;
@@ -609,7 +609,7 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	 * easily detect if a folio is shared.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) ||
-	    (!folio_mapped_shared(folio) && !hugetlb_pmd_shared(pte)))
+	    (!folio_mapped_shared(folio, walk->mm) && !hugetlb_pmd_shared(pte)))
 		if (!isolate_hugetlb(folio, qp->pagelist))
 			qp->nr_failed++;
 unlock:
@@ -981,7 +981,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 
 #ifdef CONFIG_MIGRATION
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
-				unsigned long flags)
+		struct mm_struct *mm, unsigned long flags)
 {
 	/*
 	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared folio.
@@ -990,7 +990,7 @@ static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	 * See folio_mapped_shared() on possible imprecision when we cannot
 	 * easily detect if a folio is shared.
 	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || !folio_mapped_shared(folio)) {
+	if ((flags & MPOL_MF_MOVE_ALL) || !folio_mapped_shared(folio, mm)) {
 		if (folio_isolate_lru(folio)) {
 			list_add_tail(&folio->lru, foliolist);
 			node_stat_mod_folio(folio,
@@ -1195,7 +1195,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 #else
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
-				unsigned long flags)
+		struct mm_struct *mm, unsigned long flags)
 {
 	return false;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 341a84c3e8e4..8a1d75ff2dc6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2559,7 +2559,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	 * every page is mapped to the same process. Doing that is very
 	 * expensive, so check the estimated mapcount of the folio instead.
 	 */
-	if (folio_mapped_shared(folio) && folio_is_file_lru(folio) &&
+	if (folio_mapped_shared(folio, vma->vm_mm) && folio_is_file_lru(folio) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
-- 
2.41.0

