Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6CB7BF34A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442338AbjJJGrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442296AbjJJGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:47:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DAFA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:47:08 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S4RGC0pgcz1M9D3;
        Tue, 10 Oct 2023 14:44:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 14:47:06 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 4/7] mm: convert xchg_page_access_time to xchg_folio_access_time()
Date:   Tue, 10 Oct 2023 14:45:41 +0800
Message-ID: <20231010064544.4162286-5-wangkefeng.wang@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make xchg_page_access_time to take a folio, and rename it to
xchg_folio_access_time() since all callers with a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h  | 7 ++++---
 kernel/sched/fair.c | 2 +-
 mm/huge_memory.c    | 4 ++--
 mm/mprotect.c       | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a10b8774cc6f..13ca63efacf7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1711,11 +1711,12 @@ static inline void page_cpupid_reset_last(struct page *page)
 }
 #endif /* LAST_CPUPID_NOT_IN_PAGE_FLAGS */
 
-static inline int xchg_page_access_time(struct page *page, int time)
+static inline int xchg_folio_access_time(struct folio *folio, int time)
 {
 	int last_time;
 
-	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
+	last_time = page_cpupid_xchg_last(&folio->page,
+					  time >> PAGE_ACCESS_TIME_BUCKETS);
 	return last_time << PAGE_ACCESS_TIME_BUCKETS;
 }
 
@@ -1734,7 +1735,7 @@ static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
 	return page_to_nid(page); /* XXX */
 }
 
-static inline int xchg_page_access_time(struct page *page, int time)
+static inline int xchg_folio_access_time(struct folio *folio, int time)
 {
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682067c545d1..50b9f63099fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1722,7 +1722,7 @@ static int numa_hint_fault_latency(struct folio *folio)
 	int last_time, time;
 
 	time = jiffies_to_msecs(jiffies);
-	last_time = xchg_page_access_time(&folio->page, time);
+	last_time = xchg_folio_access_time(folio, time);
 
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 344c8db904e1..e85238ac1d5c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1912,8 +1912,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 		    !toptier)
-			xchg_page_access_time(&folio->page,
-					      jiffies_to_msecs(jiffies));
+			xchg_folio_access_time(folio,
+					       jiffies_to_msecs(jiffies));
 	}
 	/*
 	 * In case prot_numa, we are under mmap_read_lock(mm). It's critical
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 459daa987131..1c556651888a 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -159,7 +159,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 					continue;
 				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
 				    !toptier)
-					xchg_page_access_time(&folio->page,
+					xchg_folio_access_time(folio,
 						jiffies_to_msecs(jiffies));
 			}
 
-- 
2.27.0

