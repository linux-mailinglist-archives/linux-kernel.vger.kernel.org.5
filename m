Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F77C7CDE72
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344998AbjJROKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbjJROJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:09:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88199120
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:09:13 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9XgG2pm6zRt5M;
        Wed, 18 Oct 2023 22:05:30 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 22:09:10 +0800
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
Subject: [PATCH v3 19/19] mm: remove page_cpupid_xchg_last()
Date:   Wed, 18 Oct 2023 22:08:06 +0800
Message-ID: <20231018140806.2783514-20-wangkefeng.wang@huawei.com>
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

Since all calls use folio_xchg_last_cpupid(), remove
page_cpupid_xchg_last().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 19 +++++++------------
 mm/mmzone.c        |  6 +++---
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 70eae2e7d5e5..287d52ace444 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1694,9 +1694,9 @@ static inline bool __cpupid_match_pid(pid_t task_pid, int cpupid)
 
 #define cpupid_match_pid(task, cpupid) __cpupid_match_pid(task->pid, cpupid)
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
-static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
+static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
-	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
+	return xchg(&folio->_last_cpupid, cpupid & LAST_CPUPID_MASK);
 }
 
 static inline int folio_last_cpupid(struct folio *folio)
@@ -1713,7 +1713,7 @@ static inline int folio_last_cpupid(struct folio *folio)
 	return (folio->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 }
 
-extern int page_cpupid_xchg_last(struct page *page, int cpupid);
+int folio_xchg_last_cpupid(struct folio *folio, int cpupid);
 
 static inline void page_cpupid_reset_last(struct page *page)
 {
@@ -1725,8 +1725,8 @@ static inline int folio_xchg_access_time(struct folio *folio, int time)
 {
 	int last_time;
 
-	last_time = page_cpupid_xchg_last(&folio->page,
-					  time >> PAGE_ACCESS_TIME_BUCKETS);
+	last_time = folio_xchg_last_cpupid(folio,
+					   time >> PAGE_ACCESS_TIME_BUCKETS);
 	return last_time << PAGE_ACCESS_TIME_BUCKETS;
 }
 
@@ -1740,9 +1740,9 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
-static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
+static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
-	return page_to_nid(page); /* XXX */
+	return folio_nid(folio); /* XXX */
 }
 
 static inline int folio_xchg_access_time(struct folio *folio, int time)
@@ -1794,11 +1794,6 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
-static inline int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
-{
-	return page_cpupid_xchg_last(&folio->page, cpupid);
-}
-
 #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
 
 /*
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..b594d3f268fe 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -93,19 +93,19 @@ void lruvec_init(struct lruvec *lruvec)
 }
 
 #if defined(CONFIG_NUMA_BALANCING) && !defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS)
-int page_cpupid_xchg_last(struct page *page, int cpupid)
+int folio_xchg_last_cpupid(struct folio *folio, int cpupid)
 {
 	unsigned long old_flags, flags;
 	int last_cpupid;
 
-	old_flags = READ_ONCE(page->flags);
+	old_flags = READ_ONCE(folio->flags);
 	do {
 		flags = old_flags;
 		last_cpupid = (flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 
 		flags &= ~(LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
 		flags |= (cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
-	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
+	} while (unlikely(!try_cmpxchg(&folio->flags, &old_flags, flags)));
 
 	return last_cpupid;
 }
-- 
2.27.0

