Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7876C9C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjHBJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjHBJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:45:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841682D5F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:45:22 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RG6WQ4xLDz1GDP2;
        Wed,  2 Aug 2023 17:44:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:45:20 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 3/4] mm: migrate: make migrate_misplaced_page() to take a folio
Date:   Wed, 2 Aug 2023 17:53:45 +0800
Message-ID: <20230802095346.87449-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make migrate_misplaced_page() to take a folio and use folio API
to save compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 39e0d35bccb3..4be61f944cac 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2525,17 +2525,18 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			   int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
+	struct folio *folio = page_folio(page);
 	int isolated;
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
-	int nr_pages = thp_nr_pages(page);
+	int nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * Don't migrate file pages that are mapped in multiple processes
 	 * with execute permissions as they are probably shared libraries.
 	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	if (folio_estimated_sharers(folio) != 1 && folio_is_file_lru(folio) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
@@ -2543,29 +2544,29 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * Also do not migrate dirty pages as not all filesystems can move
 	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
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
@@ -2573,7 +2574,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	return isolated;
 
 out:
-	put_page(page);
+	folio_put(folio);
 	return 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-- 
2.41.0

