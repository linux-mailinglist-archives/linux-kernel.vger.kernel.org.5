Return-Path: <linux-kernel+bounces-93718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4901A8733BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468081F21664
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA095FDBF;
	Wed,  6 Mar 2024 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tFVn4nnE"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B55DF2A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720022; cv=none; b=L3GNhTQkp/A3QBslBH4+ZVTvPJKP3yU325pxrqPnfz2PwR2YHskfjHY52B+NDtrN5BtlZZ/1JIwC/BLgdKdi/wwbPRdJyjomR/ZlCJ8uMGqponm8vig9Djp+B/nbTwnMdWuU0mIRhdVoyrvoOhsTs5rbU7VujR7YZ02rurrz0ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720022; c=relaxed/simple;
	bh=ps8Ct8bM4ZsoshX0BfG0h/DF5MKG2ATlnihQD4CCqFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U74o0kzvklN1B3ZSkiYYve5clUgcYV6LGkpih20O1BeLaIDoEOxK908BDViwbSweRtHcrJybio+ErU1q9Wa6pfQcBX7f7/zKrpLobAVDNgmoMWKvCxyd87Zg5AnATlpbplWS2wGgpN3uU0cQ5h8cpPQtgcYYZo7Du0c6kkQA1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tFVn4nnE; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709720017; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gufctVT71MgKLODZg/m+qbYkjQYb/SdtD29jbaLsG7s=;
	b=tFVn4nnEcPcUONtzfEm4oQIPNW8CqMzvD6hvd+I9vjjDYaUZ8ALyw8/wVEtk46zvsFHpkSVzy1DBWiy/GAhUf/txfof2Bx6oyLJj7BpyBimtDzV9CgYv06p0GMEn5IEgrQTEVjHv4NiFzRBMzQ+0gG9xKu0ENyMzdqgFBHCHQEE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1xFr15_1709720016;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1xFr15_1709720016)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:13:37 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	mhocko@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mm: hugetlb: make the hugetlb migration strategy consistent
Date: Wed,  6 Mar 2024 18:13:27 +0800
Message-Id: <3519fcd41522817307a05b40fb551e2e17e68101.1709719720.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1709719720.git.baolin.wang@linux.alibaba.com>
References: <cover.1709719720.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in previous thread [1], there is an inconsistency when handing
hugetlb migration. When handling the migration of freed hugetlb, it prevents
fallback to other NUMA nodes in alloc_and_dissolve_hugetlb_folio(). However,
when dealing with in-use hugetlb, it allows fallback to other NUMA nodes in
alloc_hugetlb_folio_nodemask(), which can break the per-node hugetlb pool
and might result in unexpected failures when node bound workloads doesn't get
what is asssumed available.

To make hugetlb migration strategy more clear, we should list all the scenarios
of hugetlb migration and analyze whether allocation fallback is permitted:
1) Memory offline: will call dissolve_free_huge_pages() to free the freed hugetlb,
and call do_migrate_range() to migrate the in-use hugetlb. Both can break the
per-node hugetlb pool, but as this is an explicit offlining operation, no better
choice. So should allow the hugetlb allocation fallback.
2) Memory failure: same as memory offline. Should allow fallback to a different node
might be the only option to handle it, otherwise the impact of poisoned memory can
be amplified.
3) Longterm pinning: will call migrate_longterm_unpinnable_pages() to migrate in-use
and not-longterm-pinnable hugetlb, which can break the per-node pool. But we should
fail to longterm pinning if can not allocate on current node to avoid breaking the
per-node pool.
4) Syscalls (mbind, migrate_pages, move_pages): these are explicit users operation
to move pages to other nodes, so fallback to other nodes should not be prohibited.
5) alloc_contig_range: used by CMA allocation and virtio-mem fake-offline to allocate
given range of pages. Now the freed hugetlb migration is not allowed to fallback, to
keep consistency, the in-use hugetlb migration should be also not allowed to fallback.
6) alloc_contig_pages: used by kfence, pgtable_debug etc. The strategy should be
consistent with that of alloc_contig_range().

Based on the analysis of the various scenarios above, introducing a new helper to
determine whether fallback is permitted according to the migration reason..

[1] https://lore.kernel.org/all/6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h | 35 +++++++++++++++++++++++++++++++++--
 mm/hugetlb.c            | 14 ++++++++++++--
 mm/mempolicy.c          |  3 ++-
 mm/migrate.c            |  3 ++-
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 77b30a8c6076..e6723aaadc09 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -747,7 +747,8 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask, gfp_t gfp_mask);
+				nodemask_t *nmask, gfp_t gfp_mask,
+				bool allow_alloc_fallback);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
@@ -970,6 +971,30 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return modified_mask;
 }
 
+static inline bool htlb_allow_alloc_fallback(int reason)
+{
+	bool allowed_fallback = false;
+
+	/*
+	 * Note: the memory offline, memory failure and migration syscalls will
+	 * be allowed to fallback to other nodes due to lack of a better chioce,
+	 * that might break the per-node hugetlb pool. While other cases will
+	 * set the __GFP_THISNODE to avoid breaking the per-node hugetlb pool.
+	 */
+	switch (reason) {
+	case MR_MEMORY_HOTPLUG:
+	case MR_MEMORY_FAILURE:
+	case MR_SYSCALL:
+	case MR_MEMPOLICY_MBIND:
+		allowed_fallback = true;
+		break;
+	default:
+		break;
+	}
+
+	return allowed_fallback;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
@@ -1065,7 +1090,8 @@ static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 static inline struct folio *
 alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-			nodemask_t *nmask, gfp_t gfp_mask)
+			nodemask_t *nmask, gfp_t gfp_mask,
+			bool allow_alloc_fallback)
 {
 	return NULL;
 }
@@ -1181,6 +1207,11 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
 	return 0;
 }
 
+static inline bool htlb_allow_alloc_fallback(int reason)
+{
+	return false;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 418d66953224..071218141fb2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2621,7 +2621,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 
 /* folio migration callback function */
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, bool allow_alloc_fallback)
 {
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
@@ -2636,6 +2636,10 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
+	/* We cannot fallback to other nodes, as we could break the per-node pool. */
+	if (!allow_alloc_fallback)
+		gfp_mask |= __GFP_THISNODE;
+
 	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
@@ -6653,7 +6657,13 @@ static struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
+	/*
+	 * This is used to allocate a temporary hugetlb to hold the copied
+	 * content, which will then be copied again to the final hugetlb
+	 * consuming a reservation. Set the alloc_fallback to false to indicate
+	 * that breaking the per-node hugetlb pool is not allowed in this case.
+	 */
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask, false);
 	mpol_cond_put(mpol);
 
 	return folio;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 98ceb12e0e17..fe853452db9f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1228,7 +1228,8 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 		h = folio_hstate(src);
 		gfp = htlb_alloc_mask(h);
 		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
-		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
+		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp,
+				htlb_allow_alloc_fallback(MR_MEMPOLICY_MBIND));
 	}
 
 	if (folio_test_large(src))
diff --git a/mm/migrate.c b/mm/migrate.c
index bde63010a3cf..ab9856f5931b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2022,7 +2022,8 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_hugetlb_folio_nodemask(h, nid,
-						mtc->nmask, gfp_mask);
+						mtc->nmask, gfp_mask,
+						htlb_allow_alloc_fallback(mtc->reason));
 	}
 
 	if (folio_test_large(src)) {
-- 
2.39.3


