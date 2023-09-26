Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2C7AE31A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjIZAxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjIZAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4111D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:12 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvh4c62kfzrSw6;
        Tue, 26 Sep 2023 08:50:56 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 5/9] mm: convert page_cpupid_last() to folio_cpupid_last()
Date:   Tue, 26 Sep 2023 08:52:50 +0800
Message-ID: <20230926005254.2861577-6-wangkefeng.wang@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make page_cpupid_last() to take a folio, and rename it to
folio_cpupid_last() since all callers with a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 12 ++++++------
 mm/huge_memory.c   |  4 ++--
 mm/memory.c        |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 49b9fa383e7d..aa7fdda1b56c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1689,18 +1689,18 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
 }
 
-static inline int page_cpupid_last(struct page *page)
+static inline int folio_cpupid_last(struct folio *folio)
 {
-	return page->_last_cpupid;
+	return folio->_last_cpupid;
 }
 static inline void page_cpupid_reset_last(struct page *page)
 {
 	page->_last_cpupid = -1 & LAST_CPUPID_MASK;
 }
 #else
-static inline int page_cpupid_last(struct page *page)
+static inline int folio_cpupid_last(struct folio *folio)
 {
-	return (page->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
+	return (folio->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 }
 
 extern int page_cpupid_xchg_last(struct page *page, int cpupid);
@@ -1740,9 +1740,9 @@ static inline int xchg_folio_access_time(struct folio *folio, int time)
 	return 0;
 }
 
-static inline int page_cpupid_last(struct page *page)
+static inline int folio_cpupid_last(struct folio *folio)
 {
-	return page_to_nid(page); /* XXX */
+	return folio_nid(folio); /* XXX */
 }
 
 static inline int cpupid_to_nid(int cpupid)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c4f4951615fd..93981a759daf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1555,7 +1555,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * to record page access time.  So use default value.
 	 */
 	if (node_is_toptier(nid))
-		last_cpupid = page_cpupid_last(&folio->page);
+		last_cpupid = folio_cpupid_last(folio);
 	target_nid = numa_migrate_prep(folio, vma, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
@@ -2508,7 +2508,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 	if (page_is_idle(head))
 		set_page_idle(page_tail);
 
-	page_cpupid_xchg_last(page_tail, page_cpupid_last(head));
+	page_cpupid_xchg_last(page_tail, folio_cpupid_last(folio));
 
 	/*
 	 * always add to the tail because some iterators expect new
diff --git a/mm/memory.c b/mm/memory.c
index 29c5618c91e5..5ab6e8d45a7d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4814,7 +4814,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	    !node_is_toptier(nid))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
-		last_cpupid = page_cpupid_last(&folio->page);
+		last_cpupid = folio_cpupid_last(folio);
 	target_nid = numa_migrate_prep(folio, vma, vmf->address, nid, &flags);
 	if (target_nid == NUMA_NO_NODE) {
 		folio_put(folio);
-- 
2.27.0

