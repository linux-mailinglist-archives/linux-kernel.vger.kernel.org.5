Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A097AE31D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjIZAxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjIZAxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:53:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913DD9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:53:13 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rvh4f4Jj7z15NQw;
        Tue, 26 Sep 2023 08:50:58 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 08:53:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        Zi Yan <ziy@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 7/9] mm: convert page_cpupid_xchg_last() to folio_cpupid_xchg_last()
Date:   Tue, 26 Sep 2023 08:52:52 +0800
Message-ID: <20230926005254.2861577-8-wangkefeng.wang@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make page_cpupid_xchg_last() to take a folio, and rename it to
olio_cpupid_xchg_last() since all callers with a folio.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h  | 14 +++++++-------
 kernel/sched/fair.c |  2 +-
 mm/huge_memory.c    |  2 +-
 mm/memory.c         |  2 +-
 mm/migrate.c        |  4 ++--
 mm/mmzone.c         |  6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9933f6345e66..a6f4b55bf469 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1683,9 +1683,9 @@ static inline bool __cpupid_match_pid(pid_t task_pid, int cpupid)
 
 #define cpupid_match_pid(task, cpupid) __cpupid_match_pid(task->pid, cpupid)
 #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
-static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
+static inline int folio_cpupid_xchg_last(struct folio *folio, int cpupid)
 {
-	return xchg(&page->_last_cpupid, cpupid & LAST_CPUPID_MASK);
+	return xchg(&folio->_last_cpupid, cpupid & LAST_CPUPID_MASK);
 }
 
 static inline int folio_cpupid_last(struct folio *folio)
@@ -1702,7 +1702,7 @@ static inline int folio_cpupid_last(struct folio *folio)
 	return (folio->flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 }
 
-extern int page_cpupid_xchg_last(struct page *page, int cpupid);
+extern int folio_cpupid_xchg_last(struct folio *folio, int cpupid);
 
 static inline void page_cpupid_reset_last(struct page *page)
 {
@@ -1714,8 +1714,8 @@ static inline int xchg_folio_access_time(struct folio *folio, int time)
 {
 	int last_time;
 
-	last_time = page_cpupid_xchg_last(&folio->page,
-					  time >> PAGE_ACCESS_TIME_BUCKETS);
+	last_time = folio_cpupid_xchg_last(folio,
+					   time >> PAGE_ACCESS_TIME_BUCKETS);
 	return last_time << PAGE_ACCESS_TIME_BUCKETS;
 }
 
@@ -1729,9 +1729,9 @@ static inline void vma_set_access_pid_bit(struct vm_area_struct *vma)
 	}
 }
 #else /* !CONFIG_NUMA_BALANCING */
-static inline int page_cpupid_xchg_last(struct page *page, int cpupid)
+static inline int folio_cpupid_xchg_last(struct folio *folio, int cpupid)
 {
-	return page_to_nid(page); /* XXX */
+	return folio_nid(folio); /* XXX */
 }
 
 static inline int xchg_folio_access_time(struct folio *folio, int time)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index afb9dc98a8ee..dca1546aa9c1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1810,7 +1810,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
-	last_cpupid = page_cpupid_xchg_last(&folio->page, this_cpupid);
+	last_cpupid = folio_cpupid_xchg_last(folio, this_cpupid);
 
 	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
 	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 93981a759daf..89e65ff46ad4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2508,7 +2508,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 	if (page_is_idle(head))
 		set_page_idle(page_tail);
 
-	page_cpupid_xchg_last(page_tail, folio_cpupid_last(folio));
+	folio_cpupid_xchg_last(new_folio, folio_cpupid_last(folio));
 
 	/*
 	 * always add to the tail because some iterators expect new
diff --git a/mm/memory.c b/mm/memory.c
index 119c40e4465e..bf07ebdc24a0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3030,7 +3030,7 @@ static inline void wp_page_reuse(struct vm_fault *vmf, struct folio *folio)
 		 * information potentially belongs to a now completely
 		 * unrelated process.
 		 */
-		page_cpupid_xchg_last(vmf->page, (1 << LAST_CPUPID_SHIFT) - 1);
+		folio_cpupid_xchg_last(folio, (1 << LAST_CPUPID_SHIFT) - 1);
 	}
 
 	flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
diff --git a/mm/migrate.c b/mm/migrate.c
index 7d1804c4a5d9..d41139ccbd3f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -588,7 +588,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	 * Copy NUMA information to the new page, to prevent over-eager
 	 * future migrations of this same page.
 	 */
-	cpupid = page_cpupid_xchg_last(&folio->page, -1);
+	cpupid = folio_cpupid_xchg_last(folio, -1);
 	/*
 	 * For memory tiering mode, when migrate between slow and fast
 	 * memory node, reset cpupid, because that is used to record
@@ -601,7 +601,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 		if (f_toptier != t_toptier)
 			cpupid = -1;
 	}
-	page_cpupid_xchg_last(&newfolio->page, cpupid);
+	folio_cpupid_xchg_last(newfolio, cpupid);
 
 	folio_migrate_ksm(newfolio, folio);
 	/*
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 68e1511be12d..cd473f82b647 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -93,19 +93,19 @@ void lruvec_init(struct lruvec *lruvec)
 }
 
 #if defined(CONFIG_NUMA_BALANCING) && !defined(LAST_CPUPID_NOT_IN_PAGE_FLAGS)
-int page_cpupid_xchg_last(struct page *page, int cpupid)
+int folio_cpupid_xchg_last(struct folio *folio, int cpupid)
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

