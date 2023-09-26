Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399D7AE31E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjIZAxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjIZAxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A0010A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:14 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rvh2z45FGzMlpj;
        Tue, 26 Sep 2023 08:49:31 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:12 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 9/9] mm: convert page_cpupid_reset_last() to folio_cpupid_reset_last()
Date:   Tue, 26 Sep 2023 08:52:54 +0800
Message-ID: <20230926005254.2861577-10-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
References: <20230926005254.2861577-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't need to fill the default cpupid value for all the struct
page, since cpupid is only used for numa balancing, and the pages
for numa balancing are all from buddy, page_cpupid_reset_last()
is already called by free_pages_prepare() to initialize it, so
let's drop the page_cpupid_reset_last() in __init_single_page(),
then make page_cpupid_reset_last() to take a folio and rename it
to folio_cpupid_reset_last().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 10 +++++-----
 mm/mm_init.c       |  1 -
 mm/page_alloc.c    |  2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a6f4b55bf469..ca66a05eb2ed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1692,9 +1692,9 @@ static inline int folio_cpupid_last(struct folio *folio)
 {
 	return folio->_last_cpupid;
 }
-static inline void page_cpupid_reset_last(struct page *page)
+static inline void folio_cpupid_reset_last(struct folio *folio)
 {
-	page->_last_cpupid = -1 & LAST_CPUPID_MASK;
+	folio->_last_cpupid = -1 & LAST_CPUPID_MASK;
 }
 #else
 static inline int folio_cpupid_last(struct folio *folio)
@@ -1704,9 +1704,9 @@ static inline int folio_cpupid_last(struct folio *folio)
 
 extern int folio_cpupid_xchg_last(struct folio *folio, int cpupid);
 
-static inline void page_cpupid_reset_last(struct page *page)
+static inline void folio_cpupid_reset_last(struct folio *folio)
 {
-	page->flags |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
+	folio->flags |= LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT;
 }
 #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
 
@@ -1769,7 +1769,7 @@ static inline bool cpupid_pid_unset(int cpupid)
 	return true;
 }
 
-static inline void page_cpupid_reset_last(struct page *page)
+static inline void folio_cpupid_reset_last(struct folio *folio)
 {
 }
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 06a72c223bce..74c0dc27fbf1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -563,7 +563,6 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
-	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
 
 	INIT_LIST_HEAD(&page->lru);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a888b9d57751..852fc78ddb34 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1126,7 +1126,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			return false;
 	}
 
-	page_cpupid_reset_last(page);
+	folio_cpupid_reset_last(folio);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
-- 
2.27.0

