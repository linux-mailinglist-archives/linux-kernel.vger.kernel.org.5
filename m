Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567B76C9BF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjHBJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHBJpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:45:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C312D5B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:45:22 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RG6Vb57BczVk0q;
        Wed,  2 Aug 2023 17:43:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:45:19 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/4] mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()
Date:   Wed, 2 Aug 2023 17:53:44 +0800
Message-ID: <20230802095346.87449-3-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename numamigrate_isolate_page() to numamigrate_isolate_folio(), then
make it takes a folio and use folio API to save compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b0c318bc531c..39e0d35bccb3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2476,15 +2476,15 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
+static int numamigrate_isolate_folio(pg_data_t *pgdat, struct folio *folio)
 {
-	int nr_pages = thp_nr_pages(page);
-	int order = compound_order(page);
+	int nr_pages = folio_nr_pages(folio);
+	int order = folio_order(folio);
 
-	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
+	VM_BUG_ON_FOLIO(order && !folio_test_pmd_mappable(folio), folio);
 
 	/* Do not migrate THP mapped by multiple processes */
-	if (PageTransHuge(page) && total_mapcount(page) > 1)
+	if (folio_test_pmd_mappable(folio) && folio_estimated_sharers(folio) > 1)
 		return 0;
 
 	/* Avoid migrating to a node that is nearly full */
@@ -2501,18 +2501,18 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 		return 0;
 	}
 
-	if (!isolate_lru_page(page))
+	if (!folio_isolate_lru(folio))
 		return 0;
 
-	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
+	node_stat_mod_folio(folio, NR_ISOLATED_ANON + folio_is_file_lru(folio),
 			    nr_pages);
 
 	/*
-	 * Isolating the page has taken another reference, so the
-	 * caller's reference can be safely dropped without the page
+	 * Isolating the folio has taken another reference, so the
+	 * caller's reference can be safely dropped without the folio
 	 * disappearing underneath us during migration.
 	 */
-	put_page(page);
+	folio_put(folio);
 	return 1;
 }
 
@@ -2546,7 +2546,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	if (page_is_file_lru(page) && PageDirty(page))
 		goto out;
 
-	isolated = numamigrate_isolate_page(pgdat, page);
+	isolated = numamigrate_isolate_folio(pgdat, page_folio(page));
 	if (!isolated)
 		goto out;
 
-- 
2.41.0

