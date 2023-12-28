Return-Path: <linux-kernel+bounces-12711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99381F935
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8FDB23ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCECE575;
	Thu, 28 Dec 2023 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9Vmh9EZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FEE543
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703774832; x=1735310832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R8QRyL4A+F7o4LXsKsdczGaK2v3dQwDu3iOE7E6dq+0=;
  b=F9Vmh9EZ214MhZBvl1KKBtwLLfJC5OJl/DUoc9sUOmsiG5IVhceHd130
   HjkaEg2r4mmplWh0TWU34JKZgbFM6UBmY13DuYC3DnWb6yNCqXwA21nIC
   U6Sb/asARrMjRcP30Dg7D7NpQSRsvwIchJcZlJRvDnuH/EbWsUX+EjQtF
   F4ZvbFHkg42flwynJypZJMhkJ/j6me5TtE2lhjAPq2Pjg8Na4a1mS0yaM
   /ZKOdFI1RmsKGqbgzecaZKQExgwGtVNkjrjw9z7gp5UbJkX037xd6W52y
   S1rWOVDugrKuDy7R68FnW6YFbkZ+1+znIOw2tnd0We2oKbmEZU1yqkF0w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3385561"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="3385561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 06:47:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="844460963"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="844460963"
Received: from fjohanne-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.35.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 06:47:09 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 04D2310A536; Thu, 28 Dec 2023 17:47:07 +0300 (+03)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH, REBASED 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
Date: Thu, 28 Dec 2023 17:47:03 +0300
Message-ID: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NR_PAGE_ORDERS defines the number of page orders supported by the page
allocator, ranging from 0 to MAX_ORDER, MAX_ORDER + 1 in total.

NR_PAGE_ORDERS assists in defining arrays of page orders and allows for
more natural iteration over them.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          |  4 ++--
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  2 +-
 arch/sparc/kernel/traps_64.c                  |  2 +-
 drivers/gpu/drm/ttm/tests/ttm_device_test.c   |  2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                | 20 +++++++++----------
 include/drm/ttm/ttm_pool.h                    |  2 +-
 include/linux/mmzone.h                        |  6 ++++--
 kernel/crash_core.c                           |  2 +-
 lib/test_meminit.c                            |  2 +-
 mm/compaction.c                               |  2 +-
 mm/kmsan/init.c                               |  2 +-
 mm/page_alloc.c                               | 13 ++++++------
 mm/page_reporting.c                           |  2 +-
 mm/show_mem.c                                 |  8 ++++----
 mm/vmstat.c                                   | 12 +++++------
 15 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 78e4d2e7ba14..766b47ad8fb4 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -172,7 +172,7 @@ variables.
 Offset of the free_list's member. This value is used to compute the number
 of free pages.
 
-Each zone has a free_area structure array called free_area[MAX_ORDER + 1].
+Each zone has a free_area structure array called free_area[NR_PAGE_ORDERS].
 The free_list represents a linked list of free page blocks.
 
 (list_head, next|prev)
@@ -189,7 +189,7 @@ Offsets of the vmap_area's members. They carry vmalloc-specific
 information. Makedumpfile gets the start address of the vmalloc region
 from this.
 
-(zone.free_area, MAX_ORDER + 1)
+(zone.free_area, NR_PAGE_ORDERS)
 -------------------------------
 
 Free areas descriptor. User-space tools use this value to iterate the
diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
index fe5472a184a3..97c527ef53c2 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -16,7 +16,7 @@ struct hyp_pool {
 	 * API at EL2.
 	 */
 	hyp_spinlock_t lock;
-	struct list_head free_area[MAX_ORDER + 1];
+	struct list_head free_area[NR_PAGE_ORDERS];
 	phys_addr_t range_start;
 	phys_addr_t range_end;
 	unsigned short max_order;
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 08ffd17d5ec3..523a6e5ee925 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -897,7 +897,7 @@ void __init cheetah_ecache_flush_init(void)
 
 	/* Now allocate error trap reporting scoreboard. */
 	sz = NR_CPUS * (2 * sizeof(struct cheetah_err_info));
-	for (order = 0; order <= MAX_ORDER; order++) {
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		if ((PAGE_SIZE << order) >= sz)
 			break;
 	}
diff --git a/drivers/gpu/drm/ttm/tests/ttm_device_test.c b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
index b1b423b68cdf..19eaff22e6ae 100644
--- a/drivers/gpu/drm/ttm/tests/ttm_device_test.c
+++ b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
@@ -175,7 +175,7 @@ static void ttm_device_init_pools(struct kunit *test)
 
 	if (params->pools_init_expected) {
 		for (int i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
-			for (int j = 0; j <= MAX_ORDER; ++j) {
+			for (int j = 0; j < NR_PAGE_ORDERS; ++j) {
 				pt = pool->caching[i].orders[j];
 				KUNIT_EXPECT_PTR_EQ(test, pt.pool, pool);
 				KUNIT_EXPECT_EQ(test, pt.caching, i);
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index fe610a3cace0..d183bb97c526 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -65,11 +65,11 @@ module_param(page_pool_size, ulong, 0644);
 
 static atomic_long_t allocated_pages;
 
-static struct ttm_pool_type global_write_combined[MAX_ORDER + 1];
-static struct ttm_pool_type global_uncached[MAX_ORDER + 1];
+static struct ttm_pool_type global_write_combined[NR_PAGE_ORDERS];
+static struct ttm_pool_type global_uncached[NR_PAGE_ORDERS];
 
-static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER + 1];
-static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
+static struct ttm_pool_type global_dma32_write_combined[NR_PAGE_ORDERS];
+static struct ttm_pool_type global_dma32_uncached[NR_PAGE_ORDERS];
 
 static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
@@ -568,7 +568,7 @@ void ttm_pool_init(struct ttm_pool *pool, struct device *dev,
 
 	if (use_dma_alloc || nid != NUMA_NO_NODE) {
 		for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i)
-			for (j = 0; j <= MAX_ORDER; ++j)
+			for (j = 0; j < NR_PAGE_ORDERS; ++j)
 				ttm_pool_type_init(&pool->caching[i].orders[j],
 						   pool, i, j);
 	}
@@ -601,7 +601,7 @@ void ttm_pool_fini(struct ttm_pool *pool)
 
 	if (pool->use_dma_alloc || pool->nid != NUMA_NO_NODE) {
 		for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i)
-			for (j = 0; j <= MAX_ORDER; ++j)
+			for (j = 0; j < NR_PAGE_ORDERS; ++j)
 				ttm_pool_type_fini(&pool->caching[i].orders[j]);
 	}
 
@@ -656,7 +656,7 @@ static void ttm_pool_debugfs_header(struct seq_file *m)
 	unsigned int i;
 
 	seq_puts(m, "\t ");
-	for (i = 0; i <= MAX_ORDER; ++i)
+	for (i = 0; i < NR_PAGE_ORDERS; ++i)
 		seq_printf(m, " ---%2u---", i);
 	seq_puts(m, "\n");
 }
@@ -667,7 +667,7 @@ static void ttm_pool_debugfs_orders(struct ttm_pool_type *pt,
 {
 	unsigned int i;
 
-	for (i = 0; i <= MAX_ORDER; ++i)
+	for (i = 0; i < NR_PAGE_ORDERS; ++i)
 		seq_printf(m, " %8u", ttm_pool_type_count(&pt[i]));
 	seq_puts(m, "\n");
 }
@@ -776,7 +776,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
-	for (i = 0; i <= MAX_ORDER; ++i) {
+	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
 		ttm_pool_type_init(&global_write_combined[i], NULL,
 				   ttm_write_combined, i);
 		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
@@ -816,7 +816,7 @@ void ttm_pool_mgr_fini(void)
 {
 	unsigned int i;
 
-	for (i = 0; i <= MAX_ORDER; ++i) {
+	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
 		ttm_pool_type_fini(&global_write_combined[i]);
 		ttm_pool_type_fini(&global_uncached[i]);
 
diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
index 30a347e5aa11..4490d43c63e3 100644
--- a/include/drm/ttm/ttm_pool.h
+++ b/include/drm/ttm/ttm_pool.h
@@ -74,7 +74,7 @@ struct ttm_pool {
 	bool use_dma32;
 
 	struct {
-		struct ttm_pool_type orders[MAX_ORDER + 1];
+		struct ttm_pool_type orders[NR_PAGE_ORDERS];
 	} caching[TTM_NUM_CACHING_TYPES];
 };
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9db36e197712..553d0b873632 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -34,6 +34,8 @@
 
 #define IS_MAX_ORDER_ALIGNED(pfn) IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)
 
+#define NR_PAGE_ORDERS (MAX_ORDER + 1)
+
 /*
  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
  * costly to service.  That is between allocation orders which should
@@ -95,7 +97,7 @@ static inline bool migratetype_is_mergeable(int mt)
 }
 
 #define for_each_migratetype_order(order, type) \
-	for (order = 0; order <= MAX_ORDER; order++) \
+	for (order = 0; order < NR_PAGE_ORDERS; order++) \
 		for (type = 0; type < MIGRATE_TYPES; type++)
 
 extern int page_group_by_mobility_disabled;
@@ -947,7 +949,7 @@ struct zone {
 	CACHELINE_PADDING(_pad1_);
 
 	/* free areas of different sizes */
-	struct free_area	free_area[MAX_ORDER + 1];
+	struct free_area	free_area[NR_PAGE_ORDERS];
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	/* Pages to be accepted. All pages on the list are MAX_ORDER */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d4313b53837e..56cf4ad7abbb 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -802,7 +802,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_OFFSET(list_head, prev);
 	VMCOREINFO_OFFSET(vmap_area, va_start);
 	VMCOREINFO_OFFSET(vmap_area, list);
-	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
+	VMCOREINFO_LENGTH(zone.free_area, NR_PAGE_ORDERS);
 	log_buf_vmcoreinfo_setup();
 	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
 	VMCOREINFO_NUMBER(NR_FREE_PAGES);
diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 0ae35223d773..0dc173849a54 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -93,7 +93,7 @@ static int __init test_pages(int *total_failures)
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i <= MAX_ORDER; i++)
+	for (i = 0; i < NR_PAGE_ORDERS; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..6c8378653cb6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2226,7 +2226,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 
 	/* Direct compactor: Is a suitable page free? */
 	ret = COMPACT_NO_SUITABLE_PAGE;
-	for (order = cc->order; order <= MAX_ORDER; order++) {
+	for (order = cc->order; order < NR_PAGE_ORDERS; order++) {
 		struct free_area *area = &cc->zone->free_area[order];
 		bool can_steal;
 
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index ffedf4dbc49d..103e2e88ea03 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -96,7 +96,7 @@ void __init kmsan_init_shadow(void)
 struct metadata_page_pair {
 	struct page *shadow, *origin;
 };
-static struct metadata_page_pair held_back[MAX_ORDER + 1] __initdata;
+static struct metadata_page_pair held_back[NR_PAGE_ORDERS] __initdata;
 
 /*
  * Eager metadata allocation. When the memblock allocator is freeing pages to
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..8a9082a725ee 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1571,7 +1571,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 	struct page *page;
 
 	/* Find a page of the appropriate size in the preferred list */
-	for (current_order = order; current_order <= MAX_ORDER; ++current_order) {
+	for (current_order = order; current_order < NR_PAGE_ORDERS; ++current_order) {
 		area = &(zone->free_area[current_order]);
 		page = get_page_from_free_area(area, migratetype);
 		if (!page)
@@ -1941,7 +1941,7 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 			continue;
 
 		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order <= MAX_ORDER; order++) {
+		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &(zone->free_area[order]);
 
 			page = get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
@@ -2051,8 +2051,7 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 	return false;
 
 find_smallest:
-	for (current_order = order; current_order <= MAX_ORDER;
-							current_order++) {
+	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
 				start_migratetype, false, &can_steal);
@@ -3007,7 +3006,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 		return true;
 
 	/* For a high-order request, check at least one suitable page is free */
-	for (o = order; o <= MAX_ORDER; o++) {
+	for (o = order; o < NR_PAGE_ORDERS; o++) {
 		struct free_area *area = &z->free_area[o];
 		int mt;
 
@@ -6635,7 +6634,7 @@ bool is_free_buddy_page(struct page *page)
 	unsigned long pfn = page_to_pfn(page);
 	unsigned int order;
 
-	for (order = 0; order <= MAX_ORDER; order++) {
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
 
 		if (PageBuddy(page_head) &&
@@ -6690,7 +6689,7 @@ bool take_page_off_buddy(struct page *page)
 	bool ret = false;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	for (order = 0; order <= MAX_ORDER; order++) {
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		struct page *page_head = page - (pfn & ((1 << order) - 1));
 		int page_order = buddy_order(page_head);
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index b021f482a4cb..66369cc5279b 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -276,7 +276,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 		return err;
 
 	/* Process each free list starting from lowest order/mt */
-	for (order = page_reporting_order; order <= MAX_ORDER; order++) {
+	for (order = page_reporting_order; order < NR_PAGE_ORDERS; order++) {
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
diff --git a/mm/show_mem.c b/mm/show_mem.c
index ba0808d6917f..8dcfafbd283c 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -352,8 +352,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 
 	for_each_populated_zone(zone) {
 		unsigned int order;
-		unsigned long nr[MAX_ORDER + 1], flags, total = 0;
-		unsigned char types[MAX_ORDER + 1];
+		unsigned long nr[NR_PAGE_ORDERS], flags, total = 0;
+		unsigned char types[NR_PAGE_ORDERS];
 
 		if (zone_idx(zone) > max_zone_idx)
 			continue;
@@ -363,7 +363,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 		printk(KERN_CONT "%s: ", zone->name);
 
 		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order <= MAX_ORDER; order++) {
+		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &zone->free_area[order];
 			int type;
 
@@ -377,7 +377,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
-		for (order = 0; order <= MAX_ORDER; order++) {
+		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			printk(KERN_CONT "%lu*%lukB ",
 			       nr[order], K(1UL) << order);
 			if (nr[order])
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..fa7d93e97f7f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1059,7 +1059,7 @@ static void fill_contig_page_info(struct zone *zone,
 	info->free_blocks_total = 0;
 	info->free_blocks_suitable = 0;
 
-	for (order = 0; order <= MAX_ORDER; order++) {
+	for (order = 0; order < NR_PAGE_ORDERS; order++) {
 		unsigned long blocks;
 
 		/*
@@ -1475,7 +1475,7 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
 	int order;
 
 	seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
-	for (order = 0; order <= MAX_ORDER; ++order)
+	for (order = 0; order < NR_PAGE_ORDERS; ++order)
 		/*
 		 * Access to nr_free is lockless as nr_free is used only for
 		 * printing purposes. Use data_race to avoid KCSAN warning.
@@ -1504,7 +1504,7 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 					pgdat->node_id,
 					zone->name,
 					migratetype_names[mtype]);
-		for (order = 0; order <= MAX_ORDER; ++order) {
+		for (order = 0; order < NR_PAGE_ORDERS; ++order) {
 			unsigned long freecount = 0;
 			struct free_area *area;
 			struct list_head *curr;
@@ -1544,7 +1544,7 @@ static void pagetypeinfo_showfree(struct seq_file *m, void *arg)
 
 	/* Print header */
 	seq_printf(m, "%-43s ", "Free pages count per migrate type at order");
-	for (order = 0; order <= MAX_ORDER; ++order)
+	for (order = 0; order < NR_PAGE_ORDERS; ++order)
 		seq_printf(m, "%6d ", order);
 	seq_putc(m, '\n');
 
@@ -2180,7 +2180,7 @@ static void unusable_show_print(struct seq_file *m,
 	seq_printf(m, "Node %d, zone %8s ",
 				pgdat->node_id,
 				zone->name);
-	for (order = 0; order <= MAX_ORDER; ++order) {
+	for (order = 0; order < NR_PAGE_ORDERS; ++order) {
 		fill_contig_page_info(zone, order, &info);
 		index = unusable_free_index(order, &info);
 		seq_printf(m, "%d.%03d ", index / 1000, index % 1000);
@@ -2232,7 +2232,7 @@ static void extfrag_show_print(struct seq_file *m,
 	seq_printf(m, "Node %d, zone %8s ",
 				pgdat->node_id,
 				zone->name);
-	for (order = 0; order <= MAX_ORDER; ++order) {
+	for (order = 0; order < NR_PAGE_ORDERS; ++order) {
 		fill_contig_page_info(zone, order, &info);
 		index = __fragmentation_index(order, &info);
 		seq_printf(m, "%2d.%03d ", index / 1000, index % 1000);
-- 
2.41.0


