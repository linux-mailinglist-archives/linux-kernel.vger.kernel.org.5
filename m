Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB8782824
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjHULps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjHULpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192FEFD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:36 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTrDS2k1tzNnSV;
        Mon, 21 Aug 2023 19:42:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 19:45:33 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/8] mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
Date:   Mon, 21 Aug 2023 19:56:18 +0800
Message-ID: <20230821115624.158759-3-wangkefeng.wang@huawei.com>
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

The check of THP mapped by multiple processes was introduced by commit
04fa5d6a6547 ("mm: migrate: check page_count of THP before migrating")
and refactor by commit 340ef3902cf2 ("mm: numa: cleanup flow of transhuge
page migration"), which is out of date, since migrate_misplaced_page()
is now using the standard migrate_pages() for small pages and THPs, the
reference count checking is in folio_migrate_mapping(), so let's remove
the special check for THP.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 646d8ee7f102..f2d86dfd8423 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2483,10 +2483,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
 
-	/* Do not migrate THP mapped by multiple processes */
-	if (PageTransHuge(page) && total_mapcount(page) > 1)
-		return 0;
-
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
 		int z;
-- 
2.41.0

