Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31A27A4726
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbjIRKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbjIRKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:33:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D817B122
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:32:48 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq1HK2n1xzNnfv;
        Mon, 18 Sep 2023 18:29:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 18:32:46 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/6] sched/numa, mm: make numa migrate functions to take a folio
Date:   Mon, 18 Sep 2023 18:32:08 +0800
Message-ID: <20230918103213.4166210-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
References: <20230918103213.4166210-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

The cpuid(or access time) is stored in the head page for THP, so it is
safely to make should_numa_migrate_memory() and numa_hint_fault_latency()
to take a folio. This is in preparation for large folio numa balancing.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/sched/numa_balancing.h |  4 ++--
 kernel/sched/fair.c                  | 12 ++++++------
 mm/mempolicy.c                       |  3 ++-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 3988762efe15..a38528c28665 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -20,7 +20,7 @@ extern void task_numa_fault(int last_node, int node, int pages, int flags);
 extern pid_t task_numa_group_id(struct task_struct *p);
 extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
-extern bool should_numa_migrate_memory(struct task_struct *p, struct page *page,
+extern bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 					int src_nid, int dst_cpu);
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
@@ -38,7 +38,7 @@ static inline void task_numa_free(struct task_struct *p, bool final)
 {
 }
 static inline bool should_numa_migrate_memory(struct task_struct *p,
-				struct page *page, int src_nid, int dst_cpu)
+				struct folio *folio, int src_nid, int dst_cpu)
 {
 	return true;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb225921bbca..683cc1e417d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1722,12 +1722,12 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
  * The smaller the hint page fault latency, the higher the possibility
  * for the page to be hot.
  */
-static int numa_hint_fault_latency(struct page *page)
+static int numa_hint_fault_latency(struct folio *folio)
 {
 	int last_time, time;
 
 	time = jiffies_to_msecs(jiffies);
-	last_time = xchg_page_access_time(page, time);
+	last_time = xchg_page_access_time(&folio->page, time);
 
 	return (time - last_time) & PAGE_ACCESS_TIME_MASK;
 }
@@ -1784,7 +1784,7 @@ static void numa_promotion_adjust_threshold(struct pglist_data *pgdat,
 	}
 }
 
-bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
+bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu)
 {
 	struct numa_group *ng = deref_curr_numa_group(p);
@@ -1814,16 +1814,16 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
 		numa_promotion_adjust_threshold(pgdat, rate_limit, def_th);
 
 		th = pgdat->nbp_threshold ? : def_th;
-		latency = numa_hint_fault_latency(page);
+		latency = numa_hint_fault_latency(folio);
 		if (latency >= th)
 			return false;
 
 		return !numa_promotion_rate_limit(pgdat, rate_limit,
-						  thp_nr_pages(page));
+						  folio_nr_pages(folio));
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
-	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
+	last_cpupid = page_cpupid_xchg_last(&folio->page, this_cpupid);
 
 	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
 	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42b5567e3773..39584dc25c84 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2642,7 +2642,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 	if (pol->flags & MPOL_F_MORON) {
 		polnid = thisnid;
 
-		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
+		if (!should_numa_migrate_memory(current, page_folio(page),
+						curnid, thiscpu))
 			goto out;
 	}
 
-- 
2.27.0

