Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F76D782829
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjHULp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjHULpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251CF9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:39 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTrGy70myz1L9Rn;
        Mon, 21 Aug 2023 19:44:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 19:45:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 8/8] mm: migrate: remove isolated variable in add_page_for_migration()
Date:   Mon, 21 Aug 2023 19:56:24 +0800
Message-ID: <20230821115624.158759-9-wangkefeng.wang@huawei.com>
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

Directly check the return of isolate_hugetlb() and folio_isolate_lru()
to remove isolated variable, also setup err = -EBUSY in advance before
isolation, and update err only when successfully queued for migration,
which could help us to unify and simplify code a bit.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index e8c3fb8974f9..9bbd9018ece7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2059,7 +2059,6 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	struct page *page;
 	struct folio *folio;
 	int err;
-	bool isolated;
 
 	mmap_read_lock(mm);
 	addr = (unsigned long)untagged_addr_remote(mm, p);
@@ -2092,15 +2091,13 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	if (page_mapcount(page) > 1 && !migrate_all)
 		goto out_putfolio;
 
+	err = -EBUSY;
 	if (folio_test_hugetlb(folio)) {
-		isolated = isolate_hugetlb(folio, pagelist);
-		err = isolated ? 1 : -EBUSY;
+		if (isolate_hugetlb(folio, pagelist))
+			err = 1;
 	} else {
-		isolated = folio_isolate_lru(folio);
-		if (!isolated) {
-			err = -EBUSY;
+		if (!folio_isolate_lru(folio))
 			goto out_putfolio;
-		}
 
 		err = 1;
 		list_add_tail(&folio->lru, pagelist);
-- 
2.41.0

