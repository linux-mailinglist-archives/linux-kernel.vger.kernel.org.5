Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7484979E427
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbjIMJwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbjIMJwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:52:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13501BC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:52:01 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rlwcw06PkzMlGs;
        Wed, 13 Sep 2023 17:48:32 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 13 Sep 2023 17:51:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 2/8] mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
Date:   Wed, 13 Sep 2023 17:51:25 +0800
Message-ID: <20230913095131.2426871-3-wangkefeng.wang@huawei.com>
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

The check of THP mapped by multiple processes was introduced by commit
04fa5d6a6547 ("mm: migrate: check page_count of THP before migrating")
and refactor by commit 340ef3902cf2 ("mm: numa: cleanup flow of transhuge
page migration"), which is out of date, since migrate_misplaced_page()
is now using the standard migrate_pages() for small pages and THPs, the
reference count checking is in folio_migrate_mapping(), so let's remove
the special check for THP.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
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
2.27.0

