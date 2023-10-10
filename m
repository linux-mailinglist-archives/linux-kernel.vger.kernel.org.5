Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D967BF34B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442326AbjJJGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442275AbjJJGrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:47:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3436A9E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:47:08 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4RCp2SByztT2f;
        Tue, 10 Oct 2023 14:42:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 14:47:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 2/7] mm: mprotect: use a folio in change_pte_range()
Date:   Tue, 10 Oct 2023 14:45:39 +0800
Message-ID: <20231010064544.4162286-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

