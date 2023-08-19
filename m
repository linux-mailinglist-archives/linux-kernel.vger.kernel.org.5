Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1ED781927
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjHSK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjHSKz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:55:58 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0703768F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:52:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vq58.SR_1692442363;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq58.SR_1692442363)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 18:52:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
Date:   Sat, 19 Aug 2023 18:52:35 +0800
Message-Id: <b80a1d7bdaf5d555eb0ab8485ec8e0bbc09073e4.1692440586.git.baolin.wang@linux.alibaba.com>
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

Move the numamigrate_isolate_page() into do_numa_page() to simplify the
migrate_misplaced_page(), which now only focuses on page migration, and
it also serves as a preparation for supporting batch migration for NUMA
balancing.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/migrate.h |  6 ++++++
 mm/huge_memory.c        | 10 ++++++++++
 mm/memory.c             | 10 ++++++++++
 mm/migrate.c            | 16 ++++------------
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 711dd9412561..7c5189043707 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -144,12 +144,18 @@ const struct movable_operations *page_movable_ops(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			   int node);
+int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page);
 #else
 static inline int migrate_misplaced_page(struct page *page,
 					 struct vm_area_struct *vma, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
+
+static inline int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
+{
+	return -EAGAIN;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cb4432792b88..b7cc6828ce9e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1496,6 +1496,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false, writable = false;
 	int flags = 0;
+	pg_data_t *pgdat;
+	int isolated;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
@@ -1540,11 +1542,19 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 	writable = false;
 
+	pgdat = NODE_DATA(target_nid);
+	isolated = numamigrate_isolate_page(pgdat, page);
+	if (!isolated) {
+		put_page(page);
+		goto isolate_fail;
+	}
+
 	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
 	} else {
+isolate_fail:
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
diff --git a/mm/memory.c b/mm/memory.c
index bee9b1e86ef0..01b1980d4fb7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4779,6 +4779,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int target_nid;
 	pte_t pte, old_pte;
 	int flags = 0;
+	pg_data_t *pgdat;
+	int isolated;
 
 	/*
 	 * The "pte" at this point cannot be used safely without
@@ -4849,11 +4851,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	writable = false;
 
+	pgdat = NODE_DATA(target_nid);
+	isolated = numamigrate_isolate_page(pgdat, page);
+	if (!isolated) {
+		put_page(page);
+		goto isolate_fail;
+	}
+
 	/* Migrate to the requested node */
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
+isolate_fail:
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					       vmf->address, &vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 9cc98fb1d6ec..5eeeb2cda21c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2478,7 +2478,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
+int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
@@ -2523,16 +2523,12 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			   int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
-	int isolated;
+	int migrated = 1;
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
 	int nr_pages = thp_nr_pages(page);
 
-	isolated = numamigrate_isolate_page(pgdat, page);
-	if (!isolated)
-		goto out;
-
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
 				     NULL, node, MIGRATE_ASYNC,
@@ -2544,7 +2540,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 					page_is_file_lru(page), -nr_pages);
 			putback_lru_page(page);
 		}
-		isolated = 0;
+		migrated = 0;
 	}
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
@@ -2553,11 +2549,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 					    nr_succeeded);
 	}
 	BUG_ON(!list_empty(&migratepages));
-	return isolated;
-
-out:
-	put_page(page);
-	return 0;
+	return migrated;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
-- 
2.39.3

