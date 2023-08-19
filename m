Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827C781928
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjHSK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHSK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:56:02 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5A38E61
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:52:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vq56wHJ_1692442364;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq56wHJ_1692442364)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 18:52:45 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm: migrate: change migrate_misplaced_page() to support multiple pages migration
Date:   Sat, 19 Aug 2023 18:52:36 +0800
Message-Id: <2aa06e6f1addbfeb8784b4c282f1d4e4eee3f560.1692440586.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
References: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expanding the migrate_misplaced_page() function to allow passing in a list
to support multiple pages migration as a preparation to support batch migration
for NUMA balancing.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/migrate.h |  9 +++++----
 mm/huge_memory.c        |  4 +++-
 mm/memory.c             |  4 +++-
 mm/migrate.c            | 26 ++++++++++----------------
 4 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 7c5189043707..2599f95d6c9e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -142,12 +142,13 @@ const struct movable_operations *page_movable_ops(struct page *page)
 }
 
 #ifdef CONFIG_NUMA_BALANCING
-int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
-			   int node);
+int migrate_misplaced_page(struct list_head *migratepages, struct vm_area_struct *vma,
+			   int source_nid, int target_nid);
 int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page);
 #else
-static inline int migrate_misplaced_page(struct page *page,
-					 struct vm_area_struct *vma, int node)
+static inline int migrate_misplaced_page(struct list_head *migratepages,
+					 struct vm_area_struct *vma,
+					 int source_nid, int target_nid)
 {
 	return -EAGAIN; /* can't migrate now */
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b7cc6828ce9e..53a9d63cfb1e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1498,6 +1498,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	int flags = 0;
 	pg_data_t *pgdat;
 	int isolated;
+	LIST_HEAD(migratepages);
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
@@ -1549,7 +1550,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		goto isolate_fail;
 	}
 
-	migrated = migrate_misplaced_page(page, vma, target_nid);
+	list_add(&page->lru, &migratepages);
+	migrated = migrate_misplaced_page(&migratepages, vma, page_nid, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
diff --git a/mm/memory.c b/mm/memory.c
index 01b1980d4fb7..973403a83797 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4781,6 +4781,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int flags = 0;
 	pg_data_t *pgdat;
 	int isolated;
+	LIST_HEAD(migratepages);
 
 	/*
 	 * The "pte" at this point cannot be used safely without
@@ -4858,8 +4859,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto isolate_fail;
 	}
 
+	list_add(&page->lru, &migratepages);
 	/* Migrate to the requested node */
-	if (migrate_misplaced_page(page, vma, target_nid)) {
+	if (migrate_misplaced_page(&migratepages, vma, page_nid, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
diff --git a/mm/migrate.c b/mm/migrate.c
index 5eeeb2cda21c..93d359471b95 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2519,36 +2519,30 @@ int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
  * node. Caller is expected to have an elevated reference count on
  * the page that will be dropped by this function before returning.
  */
-int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
-			   int node)
+int migrate_misplaced_page(struct list_head *migratepages, struct vm_area_struct *vma,
+			   int source_nid, int target_nid)
 {
-	pg_data_t *pgdat = NODE_DATA(node);
+	pg_data_t *pgdat = NODE_DATA(target_nid);
 	int migrated = 1;
 	int nr_remaining;
 	unsigned int nr_succeeded;
-	LIST_HEAD(migratepages);
-	int nr_pages = thp_nr_pages(page);
 
-	list_add(&page->lru, &migratepages);
-	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
-				     NULL, node, MIGRATE_ASYNC,
+	nr_remaining = migrate_pages(migratepages, alloc_misplaced_dst_folio,
+				     NULL, target_nid, MIGRATE_ASYNC,
 				     MR_NUMA_MISPLACED, &nr_succeeded);
 	if (nr_remaining) {
-		if (!list_empty(&migratepages)) {
-			list_del(&page->lru);
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -nr_pages);
-			putback_lru_page(page);
-		}
+		if (!list_empty(migratepages))
+			putback_movable_pages(migratepages);
+
 		migrated = 0;
 	}
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
-		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+		if (!node_is_toptier(source_nid) && node_is_toptier(target_nid))
 			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
 					    nr_succeeded);
 	}
-	BUG_ON(!list_empty(&migratepages));
+	BUG_ON(!list_empty(migratepages));
 	return migrated;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-- 
2.39.3

