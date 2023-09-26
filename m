Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD77AE318
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjIZAxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjIZAxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB8410A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:11 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rvh286hNcztT42;
        Tue, 26 Sep 2023 08:48:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:08 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 2/9] mm: mprotect: use a folio in change_pte_range()
Date:   Tue, 26 Sep 2023 08:52:47 +0800
Message-ID: <20230926005254.2861577-3-wangkefeng.wang@huawei.com>
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

Use a folio in change_pte_range() to save three compound_head() calls.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/mprotect.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b94fbb45d5c7..459daa987131 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -114,7 +114,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 			 * pages. See similar comment in change_huge_pmd.
 			 */
 			if (prot_numa) {
-				struct page *page;
+				struct folio *folio;
 				int nid;
 				bool toptier;
 
@@ -122,13 +122,14 @@ static long change_pte_range(struct mmu_gather *tlb,
 				if (pte_protnone(oldpte))
 					continue;
 
-				page = vm_normal_page(vma, addr, oldpte);
-				if (!page || is_zone_device_page(page) || PageKsm(page))
+				folio = vm_normal_folio(vma, addr, oldpte);
+				if (!folio || folio_is_zone_device(folio) ||
+				    folio_test_ksm(folio))
 					continue;
 
 				/* Also skip shared copy-on-write pages */
 				if (is_cow_mapping(vma->vm_flags) &&
-				    page_count(page) != 1)
+				    folio_ref_count(folio) != 1)
 					continue;
 
 				/*
@@ -136,14 +137,15 @@ static long change_pte_range(struct mmu_gather *tlb,
 				 * it cannot move them all from MIGRATE_ASYNC
 				 * context.
 				 */
-				if (page_is_file_lru(page) && PageDirty(page))
+				if (folio_is_file_lru(folio) &&
+				    folio_test_dirty(folio))
 					continue;
 
 				/*
 				 * Don't mess with PTEs if page is already on the node
 				 * a single-threaded process is running on.
 				 */
-				nid = page_to_nid(page);
+				nid = folio_nid(folio);
 				if (target_node == nid)
 					continue;
 				toptier = node_is_toptier(nid);
@@ -157,7 +159,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 					continue;
 				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 				    !toptier)
-					xchg_page_access_time(page,
+					xchg_page_access_time(&folio->page,
 						jiffies_to_msecs(jiffies));
 			}
 
-- 
2.27.0

