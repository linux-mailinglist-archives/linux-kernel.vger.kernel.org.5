Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3F782828
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjHULpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHULpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:45:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EDE2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:45:38 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTrDW04YzzNnSZ;
        Mon, 21 Aug 2023 19:42:03 +0800 (CST)
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
Subject: [PATCH v2 7/8] mm: migrate: remove PageHead() check for HugeTLB in add_page_for_migration()
Date:   Mon, 21 Aug 2023 19:56:23 +0800
Message-ID: <20230821115624.158759-8-wangkefeng.wang@huawei.com>
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

There is some different between hugeTLB and THP behave when passed the
address of a tail page, for THP, it will migrate the entire THP page,
but for HugeTLB, it will return -EACCES, or -ENOENT before commit
e66f17ff7177 ("mm/hugetlb: take page table lock in follow_huge_pmd()"),

  -EACCES The page is mapped by multiple processes and can be moved
	  only if MPOL_MF_MOVE_ALL is specified.
  -ENOENT The page is not present.

But when check manual[1], both of the two errnos are not suitable, it
is better to keep the same behave between hugetlb and THP when passed
the address of a tail page, so let's just remove the PageHead() check
for HugeTLB.

[1] https://man7.org/linux/man-pages/man2/move_pages.2.html

Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/migrate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 73572d5a5cd4..e8c3fb8974f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2093,10 +2093,8 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 		goto out_putfolio;
 
 	if (folio_test_hugetlb(folio)) {
-		if (PageHead(page)) {
-			isolated = isolate_hugetlb(folio, pagelist);
-			err = isolated ? 1 : -EBUSY;
-		}
+		isolated = isolate_hugetlb(folio, pagelist);
+		err = isolated ? 1 : -EBUSY;
 	} else {
 		isolated = folio_isolate_lru(folio);
 		if (!isolated) {
-- 
2.41.0

