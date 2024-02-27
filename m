Return-Path: <linux-kernel+bounces-83356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529A886946F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7668E1C24B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC275145B15;
	Tue, 27 Feb 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kg/SiZf2"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6178145FE2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041967; cv=none; b=BGjcyjTjLTBa8YaIuom4/Nr/0JI86omLO+tpdFqR4nFEFAduYc26Dt3D13BTLzTrJOst5tg0kYOqGG6o+f2QxE8xlcoEQeZGVgt/K5ug/xVxstFJopsQUlHjyNw8tHIk+hhdHQCnjnFAIlrYoGpyik8dCoElOM6RGgba4FWanWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041967; c=relaxed/simple;
	bh=H6GuExzJk+Z6cg9yaI81LGGUCrhHBi+gq30dR6i0HWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VfsQ6Ew8iEM+hE2ZDkN7bOI2gnNJB5BzQVOEeo+39Qri8f/riM0NR+8xv0A+uixJdxyElhO3RS/oB9mnkXhaIdbgSVvDOVHkVWX3+R5Qv8+/MF1+yhcMn5EiR8FSI0ga0f/puKLqjYHnVdjIoOlu2MdQG85keskiljF2wyPHBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kg/SiZf2; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709041957; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KTx0R6BPzRbPHHXux5hHxOtyW6q21tS4nAQfi/BVpWw=;
	b=Kg/SiZf23lS4yDTRuJvpuC9JVjUivT/Yqw5FhawV7FrnW/YhQupRgEOSUa/eKGRnTHK1DroTRfWABW5Pb2KnKJN5lRnF+QEWJ8der1hIcOUqRGIKqghsOdRjEpx8oZUJbwboswoZ2fukomAFWheCUdJ1HemEwn8TXnBdMGR7ceI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W1MvL.U_1709041956;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W1MvL.U_1709041956)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 21:52:36 +0800
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
Subject: [PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy consistent
Date: Tue, 27 Feb 2024 21:52:26 +0800
Message-Id: <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
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

Based on the analysis of the various scenarios above, determine whether fallback is
permitted according to the migration reason in alloc_migrate_hugetlb_folio().

[1] https://lore.kernel.org/all/6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 39 +++++++++++++++++++++++++++++++++++----
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 77b30a8c6076..fa122dc509cf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -747,7 +747,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-				nodemask_t *nmask, gfp_t gfp_mask);
+				nodemask_t *nmask, gfp_t gfp_mask, int reason);
 int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping,
 			pgoff_t idx);
 void restore_reserve_on_error(struct hstate *h, struct vm_area_struct *vma,
@@ -1065,7 +1065,7 @@ static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 static inline struct folio *
 alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-			nodemask_t *nmask, gfp_t gfp_mask)
+			nodemask_t *nmask, gfp_t gfp_mask, int reason)
 {
 	return NULL;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 418d66953224..e8eb08bbc688 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2567,13 +2567,38 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 }
 
 static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
-				     int nid, nodemask_t *nmask)
+				     int nid, nodemask_t *nmask, int reason)
 {
 	struct folio *folio;
+	bool allowed_fallback = false;
 
 	if (hstate_is_gigantic(h))
 		return NULL;
 
+	if (gfp_mask & __GFP_THISNODE)
+		goto alloc_new;
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
+	if (!allowed_fallback)
+		gfp_mask |= __GFP_THISNODE;
+
+alloc_new:
 	folio = alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask, NULL);
 	if (!folio)
 		return NULL;
@@ -2621,7 +2646,7 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 
 /* folio migration callback function */
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, int reason)
 {
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
@@ -2636,7 +2661,7 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
-	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
+	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask, reason);
 }
 
 /*
@@ -6653,7 +6678,13 @@ static struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
+	/*
+	 * This is used to allocate a temporary hugetlb to hold the copied
+	 * content, which will then be copied again to the final hugetlb
+	 * consuming a reservation. Set the migrate reason to -1 to indicate
+	 * that breaking the per-node hugetlb pool is not allowed in this case.
+	 */
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask, -1);
 	mpol_cond_put(mpol);
 
 	return folio;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 98ceb12e0e17..436e817eeaeb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1228,7 +1228,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 		h = folio_hstate(src);
 		gfp = htlb_alloc_mask(h);
 		nodemask = policy_nodemask(gfp, pol, ilx, &nid);
-		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp);
+		return alloc_hugetlb_folio_nodemask(h, nid, nodemask, gfp, MR_MEMPOLICY_MBIND);
 	}
 
 	if (folio_test_large(src))
diff --git a/mm/migrate.c b/mm/migrate.c
index bde63010a3cf..0c2b70800da3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2022,7 +2022,7 @@ struct folio *alloc_migration_target(struct folio *src, unsigned long private)
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
 		return alloc_hugetlb_folio_nodemask(h, nid,
-						mtc->nmask, gfp_mask);
+						mtc->nmask, gfp_mask, mtc->reason);
 	}
 
 	if (folio_test_large(src)) {
-- 
2.39.3


