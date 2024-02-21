Return-Path: <linux-kernel+bounces-74404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295A85D38D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC797280A72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D93F9CB;
	Wed, 21 Feb 2024 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N8dnYYs4"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC43D97A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507696; cv=none; b=dwwe7Lnp4EZI+JxJF1WJchKKcpuM+dVELrIryUtyrnkVyYFkfTrv4lfY9rvXRlPVQjzFcjVRd7A8ADv+9ute+ZbXO4GxfdNn9ohRXPu/lS7sP+ktXwqBaFdkyluSp1P8dXrjGUAFAAXBwJ1AHVMu3Ba/53u4v/xTKImF19I0kAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507696; c=relaxed/simple;
	bh=XYc4TdVvWWJquVpA+tfkNKBtu2+qh+Pphd2uWChX58M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXHZj6nWkz8WYXC4PnHl3P8LXLkXhkZnOTyOgaUbFUUsSljfK+IQKwaB4Pogf4Hkpdj8TG77ZYn+3YgBvIveZePZFFrnTJtsuqk1kqaQXJ1024Q7VTY/cdJYBN/i6M5ufIDkbimchaIlMo+wut3W8/H0EYB7hRQsHMViIAomXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N8dnYYs4; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708507686; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ImWD/LFam8uPK216oOawCtCWE3yiiD0csaC4SgFveA8=;
	b=N8dnYYs4/RxkmL95EU9cddIr52GZltuM1MHI6/tbV4RPoxPXk9YywsZeJpvCq+yb+h+GRpBqbYGz0eOfRhOoOK4DZoYPDa3SlNqtFT0iQgtTOpcc2tV/1WQy7vIwK1QQ+b4NrsPOQ3rv4egKD2VaQ+Kdtn+92jFwoAlKI90t/iU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W0zUu6x_1708507684;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W0zUu6x_1708507684)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 17:28:05 +0800
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
Subject: [RFC PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy consistent
Date: Wed, 21 Feb 2024 17:27:54 +0800
Message-Id: <0514e5139b17ecf3cd9e09d86c93e586c56688dc.1708507022.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
References: <cover.1708507022.git.baolin.wang@linux.alibaba.com>
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
permitted according to the migration reason in alloc_hugetlb_folio_nodemask().

[1] https://lore.kernel.org/all/6f26ce22d2fcd523418a085f2c588fe0776d46e7.1706794035.git.baolin.wang@linux.alibaba.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 28 ++++++++++++++++++++++++++--
 mm/mempolicy.c          |  2 +-
 mm/migrate.c            |  2 +-
 4 files changed, 30 insertions(+), 6 deletions(-)

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
index 68283e54c899..a55cfc7844bc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2621,8 +2621,10 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 
 /* folio migration callback function */
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
-		nodemask_t *nmask, gfp_t gfp_mask)
+		nodemask_t *nmask, gfp_t gfp_mask, int reason)
 {
+	bool allowed_fallback = false;
+
 	spin_lock_irq(&hugetlb_lock);
 	if (available_huge_pages(h)) {
 		struct folio *folio;
@@ -2636,6 +2638,28 @@ struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
+	if (gfp_mask & __GFP_THISNODE)
+		goto alloc_new;
+
+	/*
+	 * Note: the memory offline, memory failure and migration syscalls can break
+	 * the per-node hugetlb pool. Other cases can not allocate new hugetlb on
+	 * other nodes.
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
+alloc_new:
 	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
@@ -6666,7 +6690,7 @@ static struct folio *alloc_hugetlb_folio_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
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


