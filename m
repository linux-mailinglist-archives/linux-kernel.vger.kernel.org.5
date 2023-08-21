Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F499782827
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjHULpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjHULps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAFDF3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:38 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTrDV3ZNWzNnSY;
        Mon, 21 Aug 2023 19:42:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 19:45:35 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 6/8] mm: migrate: use a folio in add_page_for_migration()
Date:   Mon, 21 Aug 2023 19:56:22 +0800
Message-ID: <20230821115624.158759-7-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a folio in add_page_for_migration() to save compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b715cd59bdec..73572d5a5cd4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2057,6 +2057,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	struct vm_area_struct *vma;
 	unsigned long addr;
 	struct page *page;
+	struct folio *folio;
 	int err;
 	bool isolated;
 
@@ -2079,45 +2080,42 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	if (!page)
 		goto out;
 
-	if (is_zone_device_page(page))
-		goto out_putpage;
+	folio = page_folio(page);
+	if (folio_is_zone_device(folio))
+		goto out_putfolio;
 
 	err = 0;
-	if (page_to_nid(page) == node)
-		goto out_putpage;
+	if (folio_nid(folio) == node)
+		goto out_putfolio;
 
 	err = -EACCES;
 	if (page_mapcount(page) > 1 && !migrate_all)
-		goto out_putpage;
+		goto out_putfolio;
 
-	if (PageHuge(page)) {
+	if (folio_test_hugetlb(folio)) {
 		if (PageHead(page)) {
-			isolated = isolate_hugetlb(page_folio(page), pagelist);
+			isolated = isolate_hugetlb(folio, pagelist);
 			err = isolated ? 1 : -EBUSY;
 		}
 	} else {
-		struct page *head;
-
-		head = compound_head(page);
-		isolated = isolate_lru_page(head);
+		isolated = folio_isolate_lru(folio);
 		if (!isolated) {
 			err = -EBUSY;
-			goto out_putpage;
+			goto out_putfolio;
 		}
 
 		err = 1;
-		list_add_tail(&head->lru, pagelist);
-		mod_node_page_state(page_pgdat(head),
-			NR_ISOLATED_ANON + page_is_file_lru(head),
-			thp_nr_pages(head));
+		list_add_tail(&folio->lru, pagelist);
+		node_stat_mod_folio(folio,
+			NR_ISOLATED_ANON + folio_is_file_lru(folio),
+			folio_nr_pages(folio));
 	}
-out_putpage:
+out_putfolio:
 	/*
-	 * Either remove the duplicate refcount from
-	 * isolate_lru_page() or drop the page ref if it was
-	 * not isolated.
+	 * Either remove the duplicate refcount from folio_isolate_lru()
+	 * or drop the folio ref if it was not isolated.
 	 */
-	put_page(page);
+	folio_put(folio);
 out:
 	mmap_read_unlock(mm);
 	return err;
-- 
2.41.0

