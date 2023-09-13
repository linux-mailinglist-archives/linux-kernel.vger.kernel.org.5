Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03179E429
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbjIMJwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbjIMJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:52:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF301BCF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:52:02 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rlwdj18sgzVkgC;
        Wed, 13 Sep 2023 17:49:13 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 17:52:00 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 4/8] mm: migrate: convert migrate_misplaced_page() to migrate_misplaced_folio()
Date:   Wed, 13 Sep 2023 17:51:27 +0800
Message-ID: <20230913095131.2426871-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230913095131.2426871-1-wangkefeng.wang@huawei.com>
References: <20230913095131.2426871-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, numa balance only support base page and PMD-mapped THP,
but we will expand to support to migrate large folio/pte-mapped THP
in the future, it is better to make migrate_misplaced_page() to take
a folio instead of a page, and rename it to migrate_misplaced_folio(),
it is a preparation, also this remove several compound_head() calls.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/migrate.h |  4 ++--
 mm/huge_memory.c        |  2 +-
 mm/memory.c             |  2 +-
 mm/migrate.c            | 39 +++++++++++++++++++++------------------
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 711dd9412561..2ce13e8a309b 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -142,10 +142,10 @@ const struct movable_operations *page_movable_ops(struct page *page)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
-int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
+int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 			   int node);
 #else
-static inline int migrate_misplaced_page(struct page *page,
+static inline int migrate_misplaced_folio(struct folio *folio,
 					 struct vm_area_struct *vma, int node)
 {
 	return -EAGAIN; /* can't migrate now */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3e9443082035..36075e428a37 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1540,7 +1540,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 	writable = false;
 
-	migrated = migrate_misplaced_page(page, vma, target_nid);
+	migrated = migrate_misplaced_folio(page_folio(page), vma, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
diff --git a/mm/memory.c b/mm/memory.c
index 4c9e6fc2dcf7..983a40f8ee62 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4815,7 +4815,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	writable = false;
 
 	/* Migrate to the requested node */
-	if (migrate_misplaced_page(page, vma, target_nid)) {
+	if (migrate_misplaced_folio(page_folio(page), vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
diff --git a/mm/migrate.c b/mm/migrate.c
index 281eafdf8e63..caf60b58b44c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2513,55 +2513,58 @@ static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 }
 
 /*
- * Attempt to migrate a misplaced page to the specified destination
+ * Attempt to migrate a misplaced folio to the specified destination
  * node. Caller is expected to have an elevated reference count on
- * the page that will be dropped by this function before returning.
+ * the folio that will be dropped by this function before returning.
  */
-int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
-			   int node)
+int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
+			    int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
-	int nr_pages = thp_nr_pages(page);
+	int nr_pages = folio_nr_pages(folio);
 
 	/*
-	 * Don't migrate file pages that are mapped in multiple processes
+	 * Don't migrate file folios that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
+	 * To check if the folio is shared, ideally we want to make sure
+	 * every page is mapped to the same process. Doing that is very
+	 * expensive, so check the estimated mapcount of the folio instead.
 	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	if (folio_estimated_sharers(folio) != 1 && folio_is_file_lru(folio) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
 	/*
-	 * Also do not migrate dirty pages as not all filesystems can move
-	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
+	 * Also do not migrate dirty folios as not all filesystems can move
+	 * dirty folios in MIGRATE_ASYNC mode which is a waste of cycles.
 	 */
-	if (page_is_file_lru(page) && PageDirty(page))
+	if (folio_is_file_lru(folio) && folio_test_dirty(folio))
 		goto out;
 
-	isolated = numamigrate_isolate_folio(pgdat, page_folio(page));
+	isolated = numamigrate_isolate_folio(pgdat, folio);
 	if (!isolated)
 		goto out;
 
-	list_add(&page->lru, &migratepages);
+	list_add(&folio->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
 				     NULL, node, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED, &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
-			list_del(&page->lru);
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -nr_pages);
-			putback_lru_page(page);
+			list_del(&folio->lru);
+			node_stat_mod_folio(folio, NR_ISOLATED_ANON +
+					folio_is_file_lru(folio), -nr_pages);
+			folio_putback_lru(folio);
 		}
 		isolated = 0;
 	}
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
-		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
 			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
 					    nr_succeeded);
 	}
@@ -2569,7 +2572,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	return isolated;
 
 out:
-	put_page(page);
+	folio_put(folio);
 	return 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-- 
2.27.0

