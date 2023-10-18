Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2947CDE65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbjJROJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJROJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E467FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:07 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S9XhF6Tn5z15NWX;
        Wed, 18 Oct 2023 22:06:21 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 09/19] mm: mprotect: use a folio in change_pte_range()
Date:   Wed, 18 Oct 2023 22:07:56 +0800
Message-ID: <20231018140806.2783514-10-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
References: <20231018140806.2783514-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
Since now only normal and PMD-mapped page is handled by numa balancing,
it is enough to only update the entire folio's access time.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/mprotect.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index f1dc8f8c84ef..81991102f785 100644
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
+					folio_xchg_access_time(folio,
 						jiffies_to_msecs(jiffies));
 			}
 
-- 
2.27.0

