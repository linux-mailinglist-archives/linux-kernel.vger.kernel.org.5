Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84E678282A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjHULp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjHULpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E5F0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:37 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTrGw2d0Lz1L9R0;
        Mon, 21 Aug 2023 19:44:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 19:45:34 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 4/8] mm: migrate: use a folio in migrate_misplaced_page()
Date:   Mon, 21 Aug 2023 19:56:20 +0800
Message-ID: <20230821115624.158759-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio in migrate_misplaced_page() to save compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 281eafdf8e63..fc728f9a383f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2521,17 +2521,18 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
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
+	if (page_mapcount(page) != 1 && folio_is_file_lru(folio) &&
 	    (vma->vm_flags & VM_EXEC))
 		goto out;
 
@@ -2539,29 +2540,29 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
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
@@ -2569,7 +2570,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	return isolated;
 
 out:
-	put_page(page);
+	folio_put(folio);
 	return 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-- 
2.41.0

