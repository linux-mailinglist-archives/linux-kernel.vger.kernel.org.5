Return-Path: <linux-kernel+bounces-135825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D76189CBD0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4021A1C21C46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBAE146585;
	Mon,  8 Apr 2024 18:40:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE83145356
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601612; cv=none; b=EhfeGUUnU+qiVqch/JlXondpnrlx/KPTLpHOFTST0nFKC0w/d6Yw9R0PpfQeMKPoSgmo4qCGI0ylbFyep7zaYZ4ADErcYuurKRV0uBJ+y4rCYV4ZW2f0SwmXhge6Y2EjJ2ywrcJ0Sq5ILuF8E+OvupcdbaXZ3DEm7E2eiUkzt8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601612; c=relaxed/simple;
	bh=JC5p1hM64uLVhgA2xiBNpbTKSx6Qsa8ZUeHJZ687VcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkRgoMl0czJSoUHzhx2r7tchlmy0FHeptGFHESR2o5NNNdVMsPg4pHEpuvgR6QzZzrradUbD4A0z5VHGx/XZbnPY1RlxTEwB8RveHyp2QsOiGz+A77SjP3oq5rJ+OeDt760216/RywWuszKKyI54f0bfE30YgZHEZ7VYuWwMfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D363DA7;
	Mon,  8 Apr 2024 11:40:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CC963F766;
	Mon,  8 Apr 2024 11:40:08 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/7] mm: swap: Update get_swap_pages() to take folio order
Date: Mon,  8 Apr 2024 19:39:43 +0100
Message-Id: <20240408183946.2991168-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408183946.2991168-1-ryan.roberts@arm.com>
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are about to allow swap storage of any mTHP size. To prepare for
that, let's change get_swap_pages() to take a folio order parameter
instead of nr_pages. This makes the interface self-documenting; a
power-of-2 number of pages must be provided. We will also need the order
internally so this simplifies accessing it.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  2 +-
 mm/swap_slots.c      |  6 +++---
 mm/swapfile.c        | 13 +++++++------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5e1e4f5bf0cb..b888e1080a94 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -471,7 +471,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
-extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
+extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 53abeaf1371d..13ab3b771409 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
 	cache->cur = 0;
 	if (swap_slot_cache_active)
 		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
-					   cache->slots, 1);
+					   cache->slots, 0);
 
 	return cache->nr;
 }
@@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 
 	if (folio_test_large(folio)) {
 		if (IS_ENABLED(CONFIG_THP_SWAP))
-			get_swap_pages(1, &entry, folio_nr_pages(folio));
+			get_swap_pages(1, &entry, folio_order(folio));
 		goto out;
 	}
 
@@ -343,7 +343,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 			goto out;
 	}
 
-	get_swap_pages(1, &entry, 1);
+	get_swap_pages(1, &entry, 0);
 out:
 	if (mem_cgroup_try_charge_swap(folio, entry)) {
 		put_swap_folio(folio, entry);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3f855475278..d2e3d3cd439f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -278,15 +278,15 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 #ifdef CONFIG_THP_SWAP
 #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
 
-#define swap_entry_size(size)	(size)
+#define swap_entry_order(order)	(order)
 #else
 #define SWAPFILE_CLUSTER	256
 
 /*
- * Define swap_entry_size() as constant to let compiler to optimize
+ * Define swap_entry_order() as constant to let compiler to optimize
  * out some code if !CONFIG_THP_SWAP
  */
-#define swap_entry_size(size)	1
+#define swap_entry_order(order)	0
 #endif
 #define LATENCY_LIMIT		256
 
@@ -1042,9 +1042,10 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
 
-int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
+int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 {
-	unsigned long size = swap_entry_size(entry_size);
+	int order = swap_entry_order(entry_order);
+	unsigned long size = 1 << order;
 	struct swap_info_struct *si, *next;
 	long avail_pgs;
 	int n_ret = 0;
@@ -1349,7 +1350,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	unsigned char *map;
 	unsigned int i, free_entries = 0;
 	unsigned char val;
-	int size = swap_entry_size(folio_nr_pages(folio));
+	int size = 1 << swap_entry_order(folio_order(folio));
 
 	si = _swap_info_get(entry);
 	if (!si)
-- 
2.25.1


