Return-Path: <linux-kernel+bounces-168170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D933C8BB4B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422F41F240DB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6F1591F5;
	Fri,  3 May 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxxvf/zp"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141C158D7F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767543; cv=none; b=I36zuhM5mLgxnmrEEvj8beJ1RZpjg/OgzELY2GKYqFicuiHFt0HHeg5oTFX9oHJMcAJEHl45hklXtOqs6qpJGpWuwtNy/4sve7oh1Dplod/CUGBWe3vV2TlBkoaQZ45IrAkDgmNxnfBoHOY+aGcSWXYc9E1VQ/HZPy6BBSMs1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767543; c=relaxed/simple;
	bh=OHTcWYSeuLcZkmWaZreFvCN1umQOFYROpDNn7uELxl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1b0C0R2pZSEXDWDmOZedNshP0RD4y6VnlsCNcZgyLTREGOaYm2AZHxzEp4gWZ9msx6XHS53tisBln2x2HEWJneJ/U1DmJUTuU8GveWEr4H3ZS53HoHKV8QngEUOuAgpXEGkOfqvxWmROVkH5sFRycPJ5ifqY30zNQF3+Kb04jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxxvf/zp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714767537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jN2GakKMUHZ5NNyqqtiBaOcCQqTeR81Og76XTBZi9vk=;
	b=gxxvf/zp1tqPvMotsbFEbWbUDM3ILANJlqp6tBrt5riXrDPWneRNmz+UN5tnW9G21XwfB2
	S0vNIykfLJonQQXqM3SawDj45SnSVTABrwKCjJtbTlf9CVIHf9NdOj2/QHB8On5PCZ41fu
	u/2CgPWc9gKBPCjCQDwYcsf7QjZJfbA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 2/4] mm: memcg: merge multiple page_counters into a single structure
Date: Fri,  3 May 2024 13:18:33 -0700
Message-ID: <20240503201835.2969707-3-roman.gushchin@linux.dev>
In-Reply-To: <20240503201835.2969707-1-roman.gushchin@linux.dev>
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Struct page_counter is used by memory and hugetlb cgroups to track
the resource usage. Memory cgroups are using up to four different
counters (on cgroup v1). Hugetlb cgroups are using 2 * HUGE_MAX_HSTATE
counters.

Every page_counter structure (except the one belonging to the root
cgroup) contains a pointer to the corresponding parent structure.
It's obviously wasteful because for each cgroup there are several
similar chains of page_counter structures. It's not particularly
cache-effective too.

Also every page_counter structure contains fields required for
tracking the usage of the memory protection, while it's used only
for the main ("memory") counter and only by memory cgroups.

To address these issues let's make page_counter structures to support
N counters and use a single page_counter structure per memory or
hugetlb cgroup. N is determined at the compile time depending on
the configuration and HUGE_MAX_HSTATE value. HUGE_MAX_HSTATE is
relatively small on all existing platforms (max is 5 on sparc),
so it's not too far from 4 memcg memory types.

Memory min/low functionality is supported only for the first counter.

Memory savings (on x86_64):
original:
  memcg:
    /* size: 2112, cachelines: 33, members: 46 */
    /* sum members: 1987, holes: 8, sum holes: 117 */
    /* padding: 8 */
    /* paddings: 3, sum paddings: 72 */
    /* forced alignments: 7, forced holes: 2, sum forced holes: 96 */
  hugetlb:
    /* size: 1280, cachelines: 20, members: 8 */
    /* sum members: 1224, holes: 1, sum holes: 56 */
    /* forced alignments: 3, forced holes: 1, sum forced holes: 56 */

patched:
  memcg:
    /* size: 1664, cachelines: 26, members: 43 */
    /* sum members: 1539, holes: 8, sum holes: 117 */
    /* padding: 8 */
    /* paddings: 1, sum paddings: 40 */
    /* forced alignments: 4, forced holes: 2, sum forced holes: 96 */
  hugetlb:
    /* size: 832, cachelines: 13, members: 7 */
    /* sum members: 776, holes: 1, sum holes: 56 */
    /* paddings: 1, sum paddings: 40 */
    /* forced alignments: 2, forced holes: 1, sum forced holes: 56 */

So it's 20-35% reduction in the number of cache lines.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/hugetlb.h        |   4 +-
 include/linux/hugetlb_cgroup.h |   9 +-
 include/linux/memcontrol.h     |  15 +-
 include/linux/page_counter.h   |  72 +++++++--
 mm/hugetlb.c                   |  14 +-
 mm/hugetlb_cgroup.c            | 150 +++++++-----------
 mm/memcontrol.c                | 272 ++++++++++++++-------------------
 mm/page_counter.c              |  61 +++++---
 8 files changed, 277 insertions(+), 320 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 68244bb3637a..32aeb2b53bc7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -67,9 +67,9 @@ struct resv_map {
 	 * here. If these fields are 0, then either the mapping is shared, or
 	 * cgroup accounting is disabled for this resv_map.
 	 */
-	struct page_counter *reservation_counter;
 	unsigned long pages_per_hpage;
 	struct cgroup_subsys_state *css;
+	int counter_idx;
 #endif
 };
 
@@ -102,8 +102,8 @@ struct file_region {
 	 * file_region in resv_map. These fields hold the info needed to
 	 * uncharge each reservation.
 	 */
-	struct page_counter *reservation_counter;
 	struct cgroup_subsys_state *css;
+	int counter_idx;
 #endif
 };
 
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index e5d64b8b59c2..7f9ec65494ec 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -36,14 +36,9 @@ struct hugetlb_cgroup {
 	struct cgroup_subsys_state css;
 
 	/*
-	 * the counter to account for hugepages from hugetlb.
+	 * resource counters for hugepages and hugepage reservations
 	 */
-	struct page_counter hugepage[HUGE_MAX_HSTATE];
-
-	/*
-	 * the counter to account for hugepage reservations from hugetlb.
-	 */
-	struct page_counter rsvd_hugepage[HUGE_MAX_HSTATE];
+	struct page_counter res;
 
 	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
 	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..bbb99f029bc1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -187,16 +187,7 @@ struct mem_cgroup {
 	struct mem_cgroup_id id;
 
 	/* Accounted resources */
-	struct page_counter memory;		/* Both v1 & v2 */
-
-	union {
-		struct page_counter swap;	/* v2 only */
-		struct page_counter memsw;	/* v1 only */
-	};
-
-	/* Legacy consumer-oriented counters */
-	struct page_counter kmem;		/* v1 only */
-	struct page_counter tcpmem;		/* v1 only */
+	struct page_counter memory;
 
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
@@ -652,7 +643,7 @@ static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
 		return false;
 
 	return READ_ONCE(memcg->memory.elow) >=
-		page_counter_read(&memcg->memory);
+		page_counter_read(&memcg->memory, MCT_MEMORY);
 }
 
 static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
@@ -662,7 +653,7 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 		return false;
 
 	return READ_ONCE(memcg->memory.emin) >=
-		page_counter_read(&memcg->memory);
+		page_counter_read(&memcg->memory, MCT_MEMORY);
 }
 
 void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 2486f98a0c71..ae6cc080b78b 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -7,12 +7,35 @@
 #include <linux/limits.h>
 #include <asm/page.h>
 
+/*
+ * Page counters are used by memory and hugetlb cgroups.
+ * Memory cgroups are using up to 4 separate counters:
+ * memory, swap (memory + swap on cgroup v1), kmem and tcpmem.
+ * Hugetlb cgroups are using 2 * HUGE_MAX_HSTATE separate
+ * counters: for tracking the usage and reservations of each
+ * supported hugepage size.
+ */
+
+#ifdef CONFIG_CGROUP_HUGETLB
+#ifdef HUGE_MAX_HSTATE
+#define __MCT_HUGETLB_MAX (HUGE_MAX_HSTATE * 2 - 1)
+#else
+#define __MCT_HUGETLB_MAX 1
+#endif
+#endif /* CONFIG_CGROUP_HUGETLB */
+
 enum mem_counter_type {
+#ifdef CONFIG_MEMCG
 	MCT_MEMORY,		/* cgroup v1 and v2 */
 	MCT_SWAP,		/* cgroup v2 only */
 	MCT_MEMSW = MCT_SWAP,	/* cgroup v1 only */
 	MCT_KMEM,		/* cgroup v1 only */
 	MCT_TCPMEM,		/* cgroup v1 only */
+#endif
+#ifdef CONFIG_CGROUP_HUGETLB
+	MCT_HUGETLB_MAX = __MCT_HUGETLB_MAX,
+#endif
+	__MCT_NR_ITEMS,
 };
 
 struct page_counter {
@@ -20,7 +43,7 @@ struct page_counter {
 	 * Make sure 'usage' does not share cacheline with any other field. The
 	 * memcg->memory.usage is a hot member of struct mem_cgroup.
 	 */
-	atomic_long_t usage;
+	atomic_long_t usage[__MCT_NR_ITEMS];
 	CACHELINE_PADDING(_pad1_);
 
 	/* effective memory.min and memory.min usage tracking */
@@ -33,16 +56,16 @@ struct page_counter {
 	atomic_long_t low_usage;
 	atomic_long_t children_low_usage;
 
-	unsigned long watermark;
-	unsigned long failcnt;
+	unsigned long watermark[__MCT_NR_ITEMS];
+	unsigned long failcnt[__MCT_NR_ITEMS];
 
 	/* Keep all the read most fields in a separete cacheline. */
 	CACHELINE_PADDING(_pad2_);
 
 	unsigned long min;
 	unsigned long low;
-	unsigned long high;
-	unsigned long max;
+	unsigned long high[__MCT_NR_ITEMS];
+	unsigned long max[__MCT_NR_ITEMS];
 	struct page_counter *parent;
 } ____cacheline_internodealigned_in_smp;
 
@@ -55,38 +78,55 @@ struct page_counter {
 static inline void page_counter_init(struct page_counter *counter,
 				     struct page_counter *parent)
 {
-	atomic_long_set(&counter->usage, 0);
-	counter->max = PAGE_COUNTER_MAX;
+	int i;
+
+	for (i = 0; i < __MCT_NR_ITEMS; i++) {
+		atomic_long_set(&counter->usage[i], 0);
+		counter->max[i] = PAGE_COUNTER_MAX;
+	}
+
 	counter->parent = parent;
 }
 
-static inline unsigned long page_counter_read(struct page_counter *counter)
+static inline unsigned long page_counter_read(struct page_counter *counter,
+	enum mem_counter_type id)
 {
-	return atomic_long_read(&counter->usage);
+	return atomic_long_read(&counter->usage[id]);
 }
 
-void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages);
-void page_counter_charge(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_cancel(struct page_counter *counter,
+			 enum mem_counter_type id,
+			 unsigned long nr_pages);
+void page_counter_charge(struct page_counter *counter,
+			 enum mem_counter_type id,
+			 unsigned long nr_pages);
 bool page_counter_try_charge(struct page_counter *counter,
+			     enum mem_counter_type id,
 			     unsigned long nr_pages,
 			     struct page_counter **fail);
-void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_uncharge(struct page_counter *counter,
+			   enum mem_counter_type id,
+			   unsigned long nr_pages);
 void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
 
 static inline void page_counter_set_high(struct page_counter *counter,
+					 enum mem_counter_type id,
 					 unsigned long nr_pages)
 {
-	WRITE_ONCE(counter->high, nr_pages);
+	WRITE_ONCE(counter->high[id], nr_pages);
 }
 
-int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages);
+int page_counter_set_max(struct page_counter *counter,
+			 enum mem_counter_type id,
+			 unsigned long nr_pages);
 int page_counter_memparse(const char *buf, const char *max,
 			  unsigned long *nr_pages);
 
-static inline void page_counter_reset_watermark(struct page_counter *counter)
+static inline void page_counter_reset_watermark(struct page_counter *counter,
+						enum mem_counter_type id)
 {
-	counter->watermark = page_counter_read(counter);
+	counter->watermark[id] = page_counter_read(counter, id);
 }
 
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33d175add044..45dccf0df5ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -455,7 +455,7 @@ static void copy_hugetlb_cgroup_uncharge_info(struct file_region *nrg,
 					      struct file_region *rg)
 {
 #ifdef CONFIG_CGROUP_HUGETLB
-	nrg->reservation_counter = rg->reservation_counter;
+	nrg->counter_idx = rg->counter_idx;
 	nrg->css = rg->css;
 	if (rg->css)
 		css_get(rg->css);
@@ -470,8 +470,6 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 {
 #ifdef CONFIG_CGROUP_HUGETLB
 	if (h_cg) {
-		nrg->reservation_counter =
-			&h_cg->rsvd_hugepage[hstate_index(h)];
 		nrg->css = &h_cg->css;
 		/*
 		 * The caller will hold exactly one h_cg->css reference for the
@@ -484,6 +482,7 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 		 * untouched.
 		 */
 		css_get(&h_cg->css);
+		nrg->counter_idx = hstate_index(h);
 		if (!resv->pages_per_hpage)
 			resv->pages_per_hpage = pages_per_huge_page(h);
 		/* pages_per_hpage should be the same for all entries in
@@ -491,8 +490,8 @@ static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
 		 */
 		VM_BUG_ON(resv->pages_per_hpage != pages_per_huge_page(h));
 	} else {
-		nrg->reservation_counter = NULL;
 		nrg->css = NULL;
+		nrg->counter_idx = 0;
 	}
 #endif
 }
@@ -509,7 +508,7 @@ static bool has_same_uncharge_info(struct file_region *rg,
 				   struct file_region *org)
 {
 #ifdef CONFIG_CGROUP_HUGETLB
-	return rg->reservation_counter == org->reservation_counter &&
+	return rg->counter_idx == org->counter_idx &&
 	       rg->css == org->css;
 
 #else
@@ -1068,14 +1067,13 @@ resv_map_set_hugetlb_cgroup_uncharge_info(struct resv_map *resv_map,
 {
 #ifdef CONFIG_CGROUP_HUGETLB
 	if (!h_cg || !h) {
-		resv_map->reservation_counter = NULL;
 		resv_map->pages_per_hpage = 0;
 		resv_map->css = NULL;
+		resv_map->counter_idx = 0;
 	} else {
-		resv_map->reservation_counter =
-			&h_cg->rsvd_hugepage[hstate_index(h)];
 		resv_map->pages_per_hpage = pages_per_huge_page(h);
 		resv_map->css = &h_cg->css;
+		resv_map->counter_idx = hstate_index(h);
 	}
 #endif
 }
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index e20339a346b9..069c7f164dc5 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -29,25 +29,14 @@
 
 static struct hugetlb_cgroup *root_h_cgroup __read_mostly;
 
-static inline struct page_counter *
-__hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx,
-				     bool rsvd)
-{
-	if (rsvd)
-		return &h_cg->rsvd_hugepage[idx];
-	return &h_cg->hugepage[idx];
-}
-
-static inline struct page_counter *
-hugetlb_cgroup_counter_from_cgroup(struct hugetlb_cgroup *h_cg, int idx)
-{
-	return __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, false);
-}
-
-static inline struct page_counter *
-hugetlb_cgroup_counter_from_cgroup_rsvd(struct hugetlb_cgroup *h_cg, int idx)
+/*
+ * There are at least 2 * HUGE_MAX_HSTATE counters.
+ * First HUGE_MAX_HSTATE counters are usage counters.
+ * Second HUGE_MAX_HSTATE counters are reservation counters.
+ */
+static inline int counter_idx(int idx, bool rsvd)
 {
-	return __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, true);
+	return rsvd ? HUGE_MAX_HSTATE + idx : idx;
 }
 
 static inline
@@ -78,8 +67,7 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 	struct hstate *h;
 
 	for_each_hstate(h) {
-		if (page_counter_read(
-		    hugetlb_cgroup_counter_from_cgroup(h_cg, hstate_index(h))))
+		if (page_counter_read(&h_cg->res, hstate_index(h)))
 			return true;
 	}
 	return false;
@@ -90,35 +78,23 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 {
 	int idx;
 
+	page_counter_init(&h_cgroup->res,
+			  parent_h_cgroup ? &parent_h_cgroup->res : NULL);
+
 	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
-		struct page_counter *fault_parent = NULL;
-		struct page_counter *rsvd_parent = NULL;
 		unsigned long limit;
 		int ret;
 
-		if (parent_h_cgroup) {
-			fault_parent = hugetlb_cgroup_counter_from_cgroup(
-				parent_h_cgroup, idx);
-			rsvd_parent = hugetlb_cgroup_counter_from_cgroup_rsvd(
-				parent_h_cgroup, idx);
-		}
-		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
-								     idx),
-				  fault_parent);
-		page_counter_init(
-			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			rsvd_parent);
-
 		limit = round_down(PAGE_COUNTER_MAX,
 				   pages_per_huge_page(&hstates[idx]));
 
-		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup(h_cgroup, idx),
-			limit);
+		/* hugepages */
+		ret = page_counter_set_max(&h_cgroup->res, counter_idx(idx, false),
+					   limit);
 		VM_BUG_ON(ret);
-		ret = page_counter_set_max(
-			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			limit);
+		/* hugepage reservations */
+		ret = page_counter_set_max(&h_cgroup->res, counter_idx(idx, true),
+					   limit);
 		VM_BUG_ON(ret);
 	}
 }
@@ -188,7 +164,6 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 				       struct page *page)
 {
 	unsigned int nr_pages;
-	struct page_counter *counter;
 	struct hugetlb_cgroup *page_hcg;
 	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
 	struct folio *folio = page_folio(page);
@@ -206,11 +181,10 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
 	if (!parent) {
 		parent = root_h_cgroup;
 		/* root has no limit */
-		page_counter_charge(&parent->hugepage[idx], nr_pages);
+		page_counter_charge(&parent->res, idx, nr_pages);
 	}
-	counter = &h_cg->hugepage[idx];
 	/* Take the pages off the local counter */
-	page_counter_cancel(counter, nr_pages);
+	page_counter_cancel(&h_cg->res, idx, nr_pages);
 
 	set_hugetlb_cgroup(folio, parent);
 out:
@@ -271,9 +245,8 @@ static int __hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 	}
 	rcu_read_unlock();
 
-	if (!page_counter_try_charge(
-		    __hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
-		    nr_pages, &counter)) {
+	if (!page_counter_try_charge(&h_cg->res, counter_idx(idx, rsvd),
+				     nr_pages, &counter)) {
 		ret = -ENOMEM;
 		hugetlb_event(h_cg, idx, HUGETLB_MAX);
 		css_put(&h_cg->css);
@@ -353,9 +326,7 @@ static void __hugetlb_cgroup_uncharge_folio(int idx, unsigned long nr_pages,
 		return;
 	__set_hugetlb_cgroup(folio, NULL, rsvd);
 
-	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
-								   rsvd),
-			      nr_pages);
+	page_counter_uncharge(&h_cg->res, counter_idx(idx, rsvd), nr_pages);
 
 	if (rsvd)
 		css_put(&h_cg->css);
@@ -391,9 +362,7 @@ static void __hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
 	if (hugetlb_cgroup_disabled() || !h_cg)
 		return;
 
-	page_counter_uncharge(__hugetlb_cgroup_counter_from_cgroup(h_cg, idx,
-								   rsvd),
-			      nr_pages);
+	page_counter_uncharge(&h_cg->res, counter_idx(idx, rsvd), nr_pages);
 
 	if (rsvd)
 		css_put(&h_cg->css);
@@ -414,11 +383,11 @@ void hugetlb_cgroup_uncharge_cgroup_rsvd(int idx, unsigned long nr_pages,
 void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
 				     unsigned long end)
 {
-	if (hugetlb_cgroup_disabled() || !resv || !resv->reservation_counter ||
-	    !resv->css)
+	if (hugetlb_cgroup_disabled() || !resv || !resv->css)
 		return;
 
-	page_counter_uncharge(resv->reservation_counter,
+	page_counter_uncharge(&hugetlb_cgroup_from_css(resv->css)->res,
+			      resv->counter_idx,
 			      (end - start) * resv->pages_per_hpage);
 	css_put(resv->css);
 }
@@ -431,9 +400,9 @@ void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
 	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
 		return;
 
-	if (rg->reservation_counter && resv->pages_per_hpage &&
-	    !resv->reservation_counter) {
-		page_counter_uncharge(rg->reservation_counter,
+	if (rg->css && resv->pages_per_hpage && !resv->css) {
+		page_counter_uncharge(&hugetlb_cgroup_from_css(rg->css)->res,
+				      rg->counter_idx,
 				      nr_pages * resv->pages_per_hpage);
 		/*
 		 * Only do css_put(rg->css) when we delete the entire region
@@ -485,7 +454,7 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
 	 * counter, so use that.
 	 */
 	seq_printf(seq, "%stotal=%lu", legacy ? "hierarchical_" : "",
-		   page_counter_read(&h_cg->hugepage[idx]) * PAGE_SIZE);
+		   page_counter_read(&h_cg->res, idx) * PAGE_SIZE);
 
 	/*
 	 * For each node, transverse the css tree to obtain the hierarchical
@@ -511,30 +480,26 @@ static int hugetlb_cgroup_read_numa_stat(struct seq_file *seq, void *dummy)
 static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 				   struct cftype *cft)
 {
-	struct page_counter *counter;
-	struct page_counter *rsvd_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);
-
-	counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
-	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(cft->private)];
+	int idx = MEMFILE_IDX(cft->private);
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
-		return (u64)page_counter_read(counter) * PAGE_SIZE;
+		return (u64)page_counter_read(&h_cg->res, counter_idx(idx, false)) * PAGE_SIZE;
 	case RES_RSVD_USAGE:
-		return (u64)page_counter_read(rsvd_counter) * PAGE_SIZE;
+		return (u64)page_counter_read(&h_cg->res, counter_idx(idx, true)) * PAGE_SIZE;
 	case RES_LIMIT:
-		return (u64)counter->max * PAGE_SIZE;
+		return (u64)h_cg->res.max[counter_idx(idx, false)] * PAGE_SIZE;
 	case RES_RSVD_LIMIT:
-		return (u64)rsvd_counter->max * PAGE_SIZE;
+		return (u64)h_cg->res.max[counter_idx(idx, true)] * PAGE_SIZE;
 	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
+		return (u64)h_cg->res.watermark[counter_idx(idx, false)] * PAGE_SIZE;
 	case RES_RSVD_MAX_USAGE:
-		return (u64)rsvd_counter->watermark * PAGE_SIZE;
+		return (u64)h_cg->res.watermark[counter_idx(idx, true)] * PAGE_SIZE;
 	case RES_FAILCNT:
-		return counter->failcnt;
+		return (u64)h_cg->res.failcnt[counter_idx(idx, false)];
 	case RES_RSVD_FAILCNT:
-		return rsvd_counter->failcnt;
+		return (u64)h_cg->res.failcnt[counter_idx(idx, true)];
 	default:
 		BUG();
 	}
@@ -542,32 +507,29 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
 
 static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
 {
-	int idx;
 	u64 val;
 	struct cftype *cft = seq_cft(seq);
 	unsigned long limit;
-	struct page_counter *counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
-
-	idx = MEMFILE_IDX(cft->private);
-	counter = &h_cg->hugepage[idx];
+	int idx = MEMFILE_IDX(cft->private);
+	bool rsvd = false;
 
 	limit = round_down(PAGE_COUNTER_MAX,
 			   pages_per_huge_page(&hstates[idx]));
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_RSVD_USAGE:
-		counter = &h_cg->rsvd_hugepage[idx];
+		rsvd = true;
 		fallthrough;
 	case RES_USAGE:
-		val = (u64)page_counter_read(counter);
+		val = (u64)page_counter_read(&h_cg->res, counter_idx(idx, rsvd));
 		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
 		break;
 	case RES_RSVD_LIMIT:
-		counter = &h_cg->rsvd_hugepage[idx];
+		rsvd = true;
 		fallthrough;
 	case RES_LIMIT:
-		val = (u64)counter->max;
+		val = (u64)h_cg->res.max[counter_idx(idx, rsvd)];
 		if (val == limit)
 			seq_puts(seq, "max\n");
 		else
@@ -586,9 +548,10 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off,
 				    const char *max)
 {
-	int ret, idx;
+	int ret;
 	unsigned long nr_pages;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
+	int idx = MEMFILE_IDX(of_cft(of)->private);
 	bool rsvd = false;
 
 	if (hugetlb_cgroup_is_root(h_cg)) /* Can't set limit on root */
@@ -599,7 +562,6 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 	if (ret)
 		return ret;
 
-	idx = MEMFILE_IDX(of_cft(of)->private);
 	nr_pages = round_down(nr_pages, pages_per_huge_page(&hstates[idx]));
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
@@ -608,9 +570,8 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
 		fallthrough;
 	case RES_LIMIT:
 		mutex_lock(&hugetlb_limit_mutex);
-		ret = page_counter_set_max(
-			__hugetlb_cgroup_counter_from_cgroup(h_cg, idx, rsvd),
-			nr_pages);
+		ret = page_counter_set_max(&h_cg->res, counter_idx(idx, rsvd),
+					   nr_pages);
 		mutex_unlock(&hugetlb_limit_mutex);
 		break;
 	default:
@@ -636,24 +597,21 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
 	int ret = 0;
-	struct page_counter *counter, *rsvd_counter;
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
-
-	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
-	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
+	int idx = MEMFILE_IDX(of_cft(of)->private);
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
+		page_counter_reset_watermark(&h_cg->res, counter_idx(idx, false));
 		break;
 	case RES_RSVD_MAX_USAGE:
-		page_counter_reset_watermark(rsvd_counter);
+		page_counter_reset_watermark(&h_cg->res, counter_idx(idx, true));
 		break;
 	case RES_FAILCNT:
-		counter->failcnt = 0;
+		h_cg->res.failcnt[counter_idx(idx, false)] = 0;
 		break;
 	case RES_RSVD_FAILCNT:
-		rsvd_counter->failcnt = 0;
+		h_cg->res.failcnt[counter_idx(idx, true)] = 0;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 894e5b6fe468..f4511506ef1f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -465,7 +465,7 @@ static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
 
 static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 {
-	unsigned long nr_pages = page_counter_read(&memcg->memory);
+	unsigned long nr_pages = page_counter_read(&memcg->memory, MCT_MEMORY);
 	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
 	unsigned long excess = 0;
 
@@ -1631,14 +1631,14 @@ static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
 	unsigned long count;
 	unsigned long limit;
 
-	count = page_counter_read(&memcg->memory);
-	limit = READ_ONCE(memcg->memory.max);
+	count = page_counter_read(&memcg->memory, MCT_MEMORY);
+	limit = READ_ONCE(memcg->memory.max[MCT_MEMORY]);
 	if (count < limit)
 		margin = limit - count;
 
 	if (do_memsw_account()) {
-		count = page_counter_read(&memcg->memsw);
-		limit = READ_ONCE(memcg->memsw.max);
+		count = page_counter_read(&memcg->memory, MCT_MEMSW);
+		limit = READ_ONCE(memcg->memory.max[MCT_MEMSW]);
 		if (count < limit)
 			margin = min(margin, limit - count);
 		else
@@ -1896,19 +1896,23 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	lockdep_assert_held(&oom_lock);
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
-		K((u64)page_counter_read(&memcg->memory)),
-		K((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
+		K((u64)page_counter_read(&memcg->memory, MCT_MEMORY)),
+		K((u64)READ_ONCE(memcg->memory.max[MCT_MEMORY])),
+		memcg->memory.failcnt[MCT_MEMORY]);
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->swap)),
-			K((u64)READ_ONCE(memcg->swap.max)), memcg->swap.failcnt);
+			K((u64)page_counter_read(&memcg->memory, MCT_SWAP)),
+			K((u64)READ_ONCE(memcg->memory.max[MCT_SWAP])),
+			memcg->memory.failcnt[MCT_SWAP]);
 	else {
 		pr_info("memory+swap: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->memsw)),
-			K((u64)memcg->memsw.max), memcg->memsw.failcnt);
+			K((u64)page_counter_read(&memcg->memory, MCT_MEMSW)),
+			K((u64)memcg->memory.max[MCT_MEMSW]),
+			memcg->memory.failcnt[MCT_MEMSW]);
 		pr_info("kmem: usage %llukB, limit %llukB, failcnt %lu\n",
-			K((u64)page_counter_read(&memcg->kmem)),
-			K((u64)memcg->kmem.max), memcg->kmem.failcnt);
+			K((u64)page_counter_read(&memcg->memory, MCT_KMEM)),
+			K((u64)memcg->memory.max[MCT_KMEM]),
+			memcg->memory.failcnt[MCT_KMEM]);
 	}
 
 	pr_info("Memory cgroup stats for ");
@@ -1924,18 +1928,18 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
  */
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 {
-	unsigned long max = READ_ONCE(memcg->memory.max);
+	unsigned long max = READ_ONCE(memcg->memory.max[MCT_MEMORY]);
 
 	if (do_memsw_account()) {
 		if (mem_cgroup_swappiness(memcg)) {
 			/* Calculate swap excess capacity from memsw limit */
-			unsigned long swap = READ_ONCE(memcg->memsw.max) - max;
+			unsigned long swap = READ_ONCE(memcg->memory.max[MCT_MEMSW]) - max;
 
 			max += min(swap, (unsigned long)total_swap_pages);
 		}
 	} else {
 		if (mem_cgroup_swappiness(memcg))
-			max += min(READ_ONCE(memcg->swap.max),
+			max += min(READ_ONCE(memcg->memory.max[MCT_SWAP]),
 				   (unsigned long)total_swap_pages);
 	}
 	return max;
@@ -1943,7 +1947,7 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 
 unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
 {
-	return page_counter_read(&memcg->memory);
+	return page_counter_read(&memcg->memory, MCT_MEMORY);
 }
 
 static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
@@ -2497,9 +2501,9 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		return;
 
 	if (stock_pages) {
-		page_counter_uncharge(&old->memory, stock_pages);
+		page_counter_uncharge(&old->memory, MCT_MEMORY, stock_pages);
 		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock_pages);
+			page_counter_uncharge(&old->memory, MCT_MEMSW, stock_pages);
 
 		WRITE_ONCE(stock->nr_pages, 0);
 	}
@@ -2625,8 +2629,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 	do {
 		unsigned long pflags;
 
-		if (page_counter_read(&memcg->memory) <=
-		    READ_ONCE(memcg->memory.high))
+		if (page_counter_read(&memcg->memory, MCT_MEMORY) <=
+		    READ_ONCE(memcg->memory.high[MCT_MEMORY]))
 			continue;
 
 		memcg_memory_event(memcg, MEMCG_HIGH);
@@ -2727,8 +2731,8 @@ static u64 mem_find_max_overage(struct mem_cgroup *memcg)
 	u64 overage, max_overage = 0;
 
 	do {
-		overage = calculate_overage(page_counter_read(&memcg->memory),
-					    READ_ONCE(memcg->memory.high));
+		overage = calculate_overage(page_counter_read(&memcg->memory, MCT_MEMORY),
+					    READ_ONCE(memcg->memory.high[MCT_MEMORY]));
 		max_overage = max(overage, max_overage);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
@@ -2741,8 +2745,8 @@ static u64 swap_find_max_overage(struct mem_cgroup *memcg)
 	u64 overage, max_overage = 0;
 
 	do {
-		overage = calculate_overage(page_counter_read(&memcg->swap),
-					    READ_ONCE(memcg->swap.high));
+		overage = calculate_overage(page_counter_read(&memcg->memory, MCT_SWAP),
+					    READ_ONCE(memcg->memory.high[MCT_SWAP]));
 		if (overage)
 			memcg_memory_event(memcg, MEMCG_SWAP_HIGH);
 		max_overage = max(overage, max_overage);
@@ -2905,16 +2909,15 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		return 0;
 
 	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, batch, &counter))
+	    page_counter_try_charge(&memcg->memory, MCT_MEMSW, batch, &counter)) {
+		if (page_counter_try_charge(&memcg->memory, MCT_MEMORY, batch, &counter))
 			goto done_restock;
 		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, batch);
-		mem_over_limit = mem_cgroup_from_counter(counter, memory);
+			page_counter_uncharge(&memcg->memory, MCT_MEMSW, batch);
 	} else {
-		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
 	}
+	mem_over_limit = mem_cgroup_from_counter(counter, memory);
 
 	if (batch > nr_pages) {
 		batch = nr_pages;
@@ -3016,9 +3019,9 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * being freed very soon.  Allow memory usage go over the limit
 	 * temporarily by force charging it.
 	 */
-	page_counter_charge(&memcg->memory, nr_pages);
+	page_counter_charge(&memcg->memory, MCT_MEMORY, nr_pages);
 	if (do_memsw_account())
-		page_counter_charge(&memcg->memsw, nr_pages);
+		page_counter_charge(&memcg->memory, MCT_MEMSW, nr_pages);
 
 	return 0;
 
@@ -3038,10 +3041,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	do {
 		bool mem_high, swap_high;
 
-		mem_high = page_counter_read(&memcg->memory) >
-			READ_ONCE(memcg->memory.high);
-		swap_high = page_counter_read(&memcg->swap) >
-			READ_ONCE(memcg->swap.high);
+		mem_high = page_counter_read(&memcg->memory, MCT_MEMORY) >
+			READ_ONCE(memcg->memory.high[MCT_MEMORY]);
+		swap_high = page_counter_read(&memcg->memory, MCT_SWAP) >
+			READ_ONCE(memcg->memory.high[MCT_SWAP]);
 
 		/* Don't bother a random interrupted task */
 		if (!in_task()) {
@@ -3101,9 +3104,9 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (mem_cgroup_is_root(memcg))
 		return;
 
-	page_counter_uncharge(&memcg->memory, nr_pages);
+	page_counter_uncharge(&memcg->memory, MCT_MEMORY, nr_pages);
 	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
+		page_counter_uncharge(&memcg->memory, MCT_MEMSW, nr_pages);
 }
 
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
@@ -3373,9 +3376,9 @@ static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		if (nr_pages > 0)
-			page_counter_charge(&memcg->kmem, nr_pages);
+			page_counter_charge(&memcg->memory, MCT_KMEM, nr_pages);
 		else
-			page_counter_uncharge(&memcg->kmem, -nr_pages);
+			page_counter_uncharge(&memcg->memory, MCT_KMEM, -nr_pages);
 	}
 }
 
@@ -3877,7 +3880,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	bool drained = false;
 	int ret;
 	bool limits_invariant;
-	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
+	enum mem_counter_type id = memsw ? MCT_MEMSW : MCT_MEMORY;
 
 	do {
 		if (signal_pending(current)) {
@@ -3888,18 +3891,18 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		mutex_lock(&memcg_max_mutex);
 		/*
 		 * Make sure that the new limit (memsw or memory limit) doesn't
-		 * break our basic invariant rule memory.max <= memsw.max.
+		 * break our basic invariant rule max[MCT_MEMORY] <= max[MCT_MEMSW].
 		 */
-		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
-					   max <= memcg->memsw.max;
+		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max[MCT_MEMORY]) :
+					   max <= memcg->memory.max[MCT_MEMSW];
 		if (!limits_invariant) {
 			mutex_unlock(&memcg_max_mutex);
 			ret = -EINVAL;
 			break;
 		}
-		if (max > counter->max)
+		if (max > memcg->memory.max[id])
 			enlarge = true;
-		ret = page_counter_set_max(counter, max);
+		ret = page_counter_set_max(&memcg->memory, id, max);
 		mutex_unlock(&memcg_max_mutex);
 
 		if (!ret)
@@ -4021,7 +4024,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 	drain_all_stock(memcg);
 
 	/* try to free all pages in this cgroup */
-	while (nr_retries && page_counter_read(&memcg->memory)) {
+	while (nr_retries && page_counter_read(&memcg->memory, MCT_MEMORY)) {
 		if (signal_pending(current))
 			return -EINTR;
 
@@ -4077,10 +4080,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 		if (swap)
 			val += total_swap_pages - get_nr_swap_pages();
 	} else {
-		if (!swap)
-			val = page_counter_read(&memcg->memory);
-		else
-			val = page_counter_read(&memcg->memsw);
+		val = page_counter_read(&memcg->memory, swap ? MCT_MEMSW : MCT_MEMORY);
 	}
 	return val;
 }
@@ -4097,38 +4097,22 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-	struct page_counter *counter;
-
-	switch (MEMFILE_TYPE(cft->private)) {
-	case MCT_MEMORY:
-		counter = &memcg->memory;
-		break;
-	case MCT_MEMSW:
-		counter = &memcg->memsw;
-		break;
-	case MCT_KMEM:
-		counter = &memcg->kmem;
-		break;
-	case MCT_TCPMEM:
-		counter = &memcg->tcpmem;
-		break;
-	default:
-		BUG();
-	}
+	enum mem_counter_type id = MEMFILE_TYPE(cft->private);
 
 	switch (MEMFILE_ATTR(cft->private)) {
 	case RES_USAGE:
-		if (counter == &memcg->memory)
+		if (id == MCT_MEMORY)
 			return (u64)mem_cgroup_usage(memcg, false) * PAGE_SIZE;
-		if (counter == &memcg->memsw)
+		else if (id == MCT_MEMSW)
 			return (u64)mem_cgroup_usage(memcg, true) * PAGE_SIZE;
-		return (u64)page_counter_read(counter) * PAGE_SIZE;
+		else
+			return (u64)page_counter_read(&memcg->memory, id) * PAGE_SIZE;
 	case RES_LIMIT:
-		return (u64)counter->max * PAGE_SIZE;
+		return memcg->memory.max[id] * PAGE_SIZE;
 	case RES_MAX_USAGE:
-		return (u64)counter->watermark * PAGE_SIZE;
+		return memcg->memory.watermark[id] * PAGE_SIZE;
 	case RES_FAILCNT:
-		return counter->failcnt;
+		return memcg->memory.failcnt[id];
 	case RES_SOFT_LIMIT:
 		return (u64)READ_ONCE(memcg->soft_limit) * PAGE_SIZE;
 	default:
@@ -4213,7 +4197,7 @@ static int memcg_update_tcp_max(struct mem_cgroup *memcg, unsigned long max)
 
 	mutex_lock(&memcg_max_mutex);
 
-	ret = page_counter_set_max(&memcg->tcpmem, max);
+	ret = page_counter_set_max(&memcg->memory, MCT_TCPMEM, max);
 	if (ret)
 		goto out;
 
@@ -4299,31 +4283,14 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
 				size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	struct page_counter *counter;
-
-	switch (MEMFILE_TYPE(of_cft(of)->private)) {
-	case MCT_MEMORY:
-		counter = &memcg->memory;
-		break;
-	case MCT_MEMSW:
-		counter = &memcg->memsw;
-		break;
-	case MCT_KMEM:
-		counter = &memcg->kmem;
-		break;
-	case MCT_TCPMEM:
-		counter = &memcg->tcpmem;
-		break;
-	default:
-		BUG();
-	}
+	enum mem_counter_type id = MEMFILE_TYPE(of_cft(of)->private);
 
 	switch (MEMFILE_ATTR(of_cft(of)->private)) {
 	case RES_MAX_USAGE:
-		page_counter_reset_watermark(counter);
+		page_counter_reset_watermark(&memcg->memory, id);
 		break;
 	case RES_FAILCNT:
-		counter->failcnt = 0;
+		memcg->memory.failcnt[id] = 0;
 		break;
 	default:
 		BUG();
@@ -4531,8 +4498,8 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
 	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
-		memory = min(memory, READ_ONCE(mi->memory.max));
-		memsw = min(memsw, READ_ONCE(mi->memsw.max));
+		memory = min(memory, READ_ONCE(mi->memory.max[MCT_MEMORY]));
+		memsw = min(memsw, READ_ONCE(mi->memory.max[MCT_MEMSW]));
 	}
 	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
 		       (u64)memory * PAGE_SIZE);
@@ -5016,9 +4983,9 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 
 	*pheadroom = PAGE_COUNTER_MAX;
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
-					    READ_ONCE(memcg->memory.high));
-		unsigned long used = page_counter_read(&memcg->memory);
+		unsigned long ceiling = min(READ_ONCE(memcg->memory.max[MCT_MEMORY]),
+					    READ_ONCE(memcg->memory.high[MCT_MEMORY]));
+		unsigned long used = page_counter_read(&memcg->memory, MCT_MEMORY);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
 		memcg = parent;
@@ -5783,30 +5750,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (IS_ERR(memcg))
 		return ERR_CAST(memcg);
 
-	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, MCT_MEMORY, PAGE_COUNTER_MAX);
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback,
 		!parent || READ_ONCE(parent->zswap_writeback));
 #endif
-	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->memory, MCT_SWAP, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
-
 		page_counter_init(&memcg->memory, &parent->memory);
-		page_counter_init(&memcg->swap, &parent->swap);
-		page_counter_init(&memcg->kmem, &parent->kmem);
-		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL);
-		page_counter_init(&memcg->swap, NULL);
-		page_counter_init(&memcg->kmem, NULL);
-		page_counter_init(&memcg->tcpmem, NULL);
-
 		root_mem_cgroup = memcg;
 		return &memcg->css;
 	}
@@ -5949,16 +5908,17 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-
-	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
-	page_counter_set_min(&memcg->memory, 0);
-	page_counter_set_low(&memcg->memory, 0);
-	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	struct page_counter *c = &memcg->memory;
+
+	page_counter_set_max(c, MCT_MEMORY, PAGE_COUNTER_MAX);
+	page_counter_set_max(c, MCT_SWAP, PAGE_COUNTER_MAX);
+	page_counter_set_max(c, MCT_KMEM, PAGE_COUNTER_MAX);
+	page_counter_set_max(c, MCT_TCPMEM, PAGE_COUNTER_MAX);
+	page_counter_set_min(c, 0);
+	page_counter_set_low(c, 0);
+	page_counter_set_high(c, MCT_MEMORY, PAGE_COUNTER_MAX);
 	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
-	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
+	page_counter_set_high(c, MCT_SWAP, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
 
@@ -6529,7 +6489,7 @@ static void __mem_cgroup_clear_mc(void)
 	if (mc.moved_swap) {
 		/* uncharge swap account from the old cgroup */
 		if (!mem_cgroup_is_root(mc.from))
-			page_counter_uncharge(&mc.from->memsw, mc.moved_swap);
+			page_counter_uncharge(&mc.from->memory, MCT_MEMSW, mc.moved_swap);
 
 		mem_cgroup_id_put_many(mc.from, mc.moved_swap);
 
@@ -6538,7 +6498,7 @@ static void __mem_cgroup_clear_mc(void)
 		 * should uncharge to->memory.
 		 */
 		if (!mem_cgroup_is_root(mc.to))
-			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
+			page_counter_uncharge(&mc.to->memory, MCT_MEMORY, mc.moved_swap);
 
 		mc.moved_swap = 0;
 	}
@@ -6906,7 +6866,7 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
+	return (u64)page_counter_read(&memcg->memory, MCT_MEMORY) * PAGE_SIZE;
 }
 
 static u64 memory_peak_read(struct cgroup_subsys_state *css,
@@ -6914,7 +6874,7 @@ static u64 memory_peak_read(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	return (u64)memcg->memory.watermark * PAGE_SIZE;
+	return (u64)memcg->memory.watermark[MCT_MEMORY] * PAGE_SIZE;
 }
 
 static int memory_min_show(struct seq_file *m, void *v)
@@ -6966,7 +6926,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 static int memory_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->memory.high));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.high[MCT_MEMORY]));
 }
 
 static ssize_t memory_high_write(struct kernfs_open_file *of,
@@ -6983,10 +6943,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_high(&memcg->memory, high);
+	page_counter_set_high(&memcg->memory, MCT_MEMORY, high);
 
 	for (;;) {
-		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long nr_pages = page_counter_read(&memcg->memory, MCT_MEMORY);
 		unsigned long reclaimed;
 
 		if (nr_pages <= high)
@@ -7015,7 +6975,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 static int memory_max_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->memory.max));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.max[MCT_MEMORY]));
 }
 
 static ssize_t memory_max_write(struct kernfs_open_file *of,
@@ -7032,10 +6992,10 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	xchg(&memcg->memory.max, max);
+	xchg(&memcg->memory.max[MCT_MEMORY], max);
 
 	for (;;) {
-		unsigned long nr_pages = page_counter_read(&memcg->memory);
+		unsigned long nr_pages = page_counter_read(&memcg->memory, MCT_MEMORY);
 
 		if (nr_pages <= max)
 			break;
@@ -7541,7 +7501,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	if (memcg == root)
 		return;
 
-	usage = page_counter_read(&memcg->memory);
+	usage = page_counter_read(&memcg->memory, MCT_MEMORY);
 	if (!usage)
 		return;
 
@@ -7553,7 +7513,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 		return;
 	}
 
-	parent_usage = page_counter_read(&parent->memory);
+	parent_usage = page_counter_read(&parent->memory, MCT_MEMORY);
 
 	WRITE_ONCE(memcg->memory.emin, effective_protection(usage, parent_usage,
 			READ_ONCE(memcg->memory.min),
@@ -7713,9 +7673,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	unsigned long flags;
 
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
+		page_counter_uncharge(&ug->memcg->memory, MCT_MEMORY, ug->nr_memory);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+			page_counter_uncharge(&ug->memcg->memory, MCT_MEMSW, ug->nr_memory);
 		if (ug->nr_kmem)
 			memcg_account_kmem(ug->memcg, -ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
@@ -7854,9 +7814,9 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 
 	/* Force-charge the new page. The old one will be freed soon */
 	if (!mem_cgroup_is_root(memcg)) {
-		page_counter_charge(&memcg->memory, nr_pages);
+		page_counter_charge(&memcg->memory, MCT_MEMORY, nr_pages);
 		if (do_memsw_account())
-			page_counter_charge(&memcg->memsw, nr_pages);
+			page_counter_charge(&memcg->memory, MCT_MEMSW, nr_pages);
 	}
 
 	css_get(&memcg->css);
@@ -7964,13 +7924,13 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
 		struct page_counter *fail;
 
-		if (page_counter_try_charge(&memcg->tcpmem, nr_pages, &fail)) {
+		if (page_counter_try_charge(&memcg->memory, MCT_TCPMEM, nr_pages, &fail)) {
 			memcg->tcpmem_pressure = 0;
 			return true;
 		}
 		memcg->tcpmem_pressure = 1;
 		if (gfp_mask & __GFP_NOFAIL) {
-			page_counter_charge(&memcg->tcpmem, nr_pages);
+			page_counter_charge(&memcg->memory, MCT_TCPMEM, nr_pages);
 			return true;
 		}
 		return false;
@@ -7992,7 +7952,7 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
-		page_counter_uncharge(&memcg->tcpmem, nr_pages);
+		page_counter_uncharge(&memcg->memory, MCT_TCPMEM, nr_pages);
 		return;
 	}
 
@@ -8126,12 +8086,12 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
-		page_counter_uncharge(&memcg->memory, nr_entries);
+		page_counter_uncharge(&memcg->memory, MCT_MEMORY, nr_entries);
 
 	if (memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
-			page_counter_charge(&swap_memcg->memsw, nr_entries);
-		page_counter_uncharge(&memcg->memsw, nr_entries);
+			page_counter_charge(&swap_memcg->memory, MCT_MEMSW, nr_entries);
+		page_counter_uncharge(&memcg->memory, MCT_MEMSW, nr_entries);
 	}
 
 	/*
@@ -8181,7 +8141,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	memcg = mem_cgroup_id_get_online(memcg);
 
 	if (!mem_cgroup_is_root(memcg) &&
-	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
+	    !page_counter_try_charge(&memcg->memory, MCT_SWAP, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
@@ -8214,9 +8174,9 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	if (memcg) {
 		if (!mem_cgroup_is_root(memcg)) {
 			if (do_memsw_account())
-				page_counter_uncharge(&memcg->memsw, nr_pages);
+				page_counter_uncharge(&memcg->memory, MCT_MEMSW, nr_pages);
 			else
-				page_counter_uncharge(&memcg->swap, nr_pages);
+				page_counter_uncharge(&memcg->memory, MCT_SWAP, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
 		mem_cgroup_id_put_many(memcg, nr_pages);
@@ -8232,8 +8192,8 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
-				      READ_ONCE(memcg->swap.max) -
-				      page_counter_read(&memcg->swap));
+				      READ_ONCE(memcg->memory.max[MCT_SWAP]) -
+				      page_counter_read(&memcg->memory, MCT_SWAP));
 	return nr_swap_pages;
 }
 
@@ -8253,10 +8213,10 @@ bool mem_cgroup_swap_full(struct folio *folio)
 		return false;
 
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
-		unsigned long usage = page_counter_read(&memcg->swap);
+		unsigned long usage = page_counter_read(&memcg->memory, MCT_SWAP);
 
-		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
+		if (usage * 2 >= READ_ONCE(memcg->memory.high[MCT_SWAP]) ||
+		    usage * 2 >= READ_ONCE(memcg->memory.max[MCT_SWAP]))
 			return true;
 	}
 
@@ -8281,7 +8241,7 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
+	return (u64)page_counter_read(&memcg->memory, MCT_SWAP) * PAGE_SIZE;
 }
 
 static u64 swap_peak_read(struct cgroup_subsys_state *css,
@@ -8289,13 +8249,13 @@ static u64 swap_peak_read(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
-	return (u64)memcg->swap.watermark * PAGE_SIZE;
+	return (u64)memcg->memory.watermark[MCT_SWAP] * PAGE_SIZE;
 }
 
 static int swap_high_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->swap.high));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.high[MCT_SWAP]));
 }
 
 static ssize_t swap_high_write(struct kernfs_open_file *of,
@@ -8310,7 +8270,7 @@ static ssize_t swap_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_high(&memcg->swap, high);
+	page_counter_set_high(&memcg->memory, MCT_SWAP, high);
 
 	return nbytes;
 }
@@ -8318,7 +8278,7 @@ static ssize_t swap_high_write(struct kernfs_open_file *of,
 static int swap_max_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
-		READ_ONCE(mem_cgroup_from_seq(m)->swap.max));
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.max[MCT_SWAP]));
 }
 
 static ssize_t swap_max_write(struct kernfs_open_file *of,
@@ -8333,7 +8293,7 @@ static ssize_t swap_max_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	xchg(&memcg->swap.max, max);
+	xchg(&memcg->memory.max[MCT_SWAP], max);
 
 	return nbytes;
 }
diff --git a/mm/page_counter.c b/mm/page_counter.c
index db20d6452b71..b6ca3adbc226 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -44,18 +44,21 @@ static void propagate_protected_usage(struct page_counter *c,
 /**
  * page_counter_cancel - take pages out of the local counter
  * @counter: counter
+ * @id: memory resource type
  * @nr_pages: number of pages to cancel
  */
-void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_cancel(struct page_counter *counter,
+			 enum mem_counter_type id,
+			 unsigned long nr_pages)
 {
 	long new;
 
-	new = atomic_long_sub_return(nr_pages, &counter->usage);
+	new = atomic_long_sub_return(nr_pages, &counter->usage[id]);
 	/* More uncharges than charges? */
 	if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
 		      new, nr_pages)) {
 		new = 0;
-		atomic_long_set(&counter->usage, new);
+		atomic_long_set(&counter->usage[id], new);
 	}
 	propagate_protected_usage(counter, new);
 }
@@ -63,31 +66,35 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 /**
  * page_counter_charge - hierarchically charge pages
  * @counter: counter
+ * @id: memory resource type
  * @nr_pages: number of pages to charge
  *
  * NOTE: This does not consider any configured counter limits.
  */
-void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_charge(struct page_counter *counter,
+			 enum mem_counter_type id,
+			 unsigned long nr_pages)
 {
 	struct page_counter *c;
 
 	for (c = counter; c; c = c->parent) {
 		long new;
 
-		new = atomic_long_add_return(nr_pages, &c->usage);
+		new = atomic_long_add_return(nr_pages, &c->usage[id]);
 		propagate_protected_usage(c, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
 		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->watermark[id]))
+			WRITE_ONCE(c->watermark[id], new);
 	}
 }
 
 /**
  * page_counter_try_charge - try to hierarchically charge pages
  * @counter: counter
+ * @id: memory resource type
  * @nr_pages: number of pages to charge
  * @fail: points first counter to hit its limit, if any
  *
@@ -95,6 +102,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
  * of its ancestors has hit its configured limit.
  */
 bool page_counter_try_charge(struct page_counter *counter,
+			     enum mem_counter_type id,
 			     unsigned long nr_pages,
 			     struct page_counter **fail)
 {
@@ -116,15 +124,15 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * we either see the new limit or the setter sees the
 		 * counter has changed and retries.
 		 */
-		new = atomic_long_add_return(nr_pages, &c->usage);
-		if (new > c->max) {
-			atomic_long_sub(nr_pages, &c->usage);
+		new = atomic_long_add_return(nr_pages, &c->usage[id]);
+		if (new > c->max[id]) {
+			atomic_long_sub(nr_pages, &c->usage[id]);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt which is only used
 			 * to report stats.
 			 */
-			data_race(c->failcnt++);
+			data_race(c->failcnt[id]++);
 			*fail = c;
 			goto failed;
 		}
@@ -133,14 +141,14 @@ bool page_counter_try_charge(struct page_counter *counter,
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
 		 */
-		if (new > READ_ONCE(c->watermark))
-			WRITE_ONCE(c->watermark, new);
+		if (new > READ_ONCE(c->watermark[id]))
+			WRITE_ONCE(c->watermark[id], new);
 	}
 	return true;
 
 failed:
 	for (c = counter; c != *fail; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+		page_counter_cancel(c, id, nr_pages);
 
 	return false;
 }
@@ -148,19 +156,23 @@ bool page_counter_try_charge(struct page_counter *counter,
 /**
  * page_counter_uncharge - hierarchically uncharge pages
  * @counter: counter
+ * @id: memory resource type
  * @nr_pages: number of pages to uncharge
  */
-void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_uncharge(struct page_counter *counter,
+			   enum mem_counter_type id,
+			   unsigned long nr_pages)
 {
 	struct page_counter *c;
 
 	for (c = counter; c; c = c->parent)
-		page_counter_cancel(c, nr_pages);
+		page_counter_cancel(c, id, nr_pages);
 }
 
 /**
  * page_counter_set_max - set the maximum number of pages allowed
  * @counter: counter
+ * @id: memory resource type
  * @nr_pages: limit to set
  *
  * Returns 0 on success, -EBUSY if the current number of pages on the
@@ -168,7 +180,9 @@ void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages)
  *
  * The caller must serialize invocations on the same counter.
  */
-int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
+int page_counter_set_max(struct page_counter *counter,
+			 enum mem_counter_type id,
+			 unsigned long nr_pages)
 {
 	for (;;) {
 		unsigned long old;
@@ -185,17 +199,18 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 		 * the limit, so if it sees the old limit, we see the
 		 * modified counter and retry.
 		 */
-		usage = page_counter_read(counter);
+		usage = page_counter_read(counter, id);
 
 		if (usage > nr_pages)
 			return -EBUSY;
 
-		old = xchg(&counter->max, nr_pages);
+		old = xchg(&counter->max[id], nr_pages);
 
-		if (page_counter_read(counter) <= usage || nr_pages >= old)
+		if (page_counter_read(counter, id) <= usage ||
+		    nr_pages >= old)
 			return 0;
 
-		counter->max = old;
+		counter->max[id] = old;
 		cond_resched();
 	}
 }
@@ -214,7 +229,7 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
 	WRITE_ONCE(counter->min, nr_pages);
 
 	for (c = counter; c; c = c->parent)
-		propagate_protected_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage[0]));
 }
 
 /**
@@ -231,7 +246,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 	WRITE_ONCE(counter->low, nr_pages);
 
 	for (c = counter; c; c = c->parent)
-		propagate_protected_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage[0]));
 }
 
 /**
-- 
2.43.2


