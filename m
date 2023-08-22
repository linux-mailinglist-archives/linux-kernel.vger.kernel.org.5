Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCF78371F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjHVAy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjHVAyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:54:14 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8AAD1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:54:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VqK0DPh_1692665649;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqK0DPh_1692665649)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 08:54:10 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
Date:   Tue, 22 Aug 2023 08:53:50 +0800
Message-Id: <9ff2a9e3e644103a08b9b84b76b39bbd4c60020b.1692665449.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
References: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
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
it also serves as a preparation for supporting batch migration for
migrate_misplaced_page().

While we are at it, change the numamigrate_isolate_page() to boolean
type to make the return value more clear.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/migrate.h |  6 ++++++
 mm/huge_memory.c        |  7 +++++++
 mm/memory.c             |  7 +++++++
 mm/migrate.c            | 22 +++++++---------------
 4 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 711dd9412561..ddcd62ec2c12 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -144,12 +144,18 @@ const struct movable_operations *page_movable_ops(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			   int node);
+bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page);
 #else
 static inline int migrate_misplaced_page(struct page *page,
 					 struct vm_area_struct *vma, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
+
+static inline bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
+{
+	return false;
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_MIGRATION
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4a9b34a89854..07149ead11e4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1496,6 +1496,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
 	bool migrated = false, writable = false;
 	int flags = 0;
+	pg_data_t *pgdat;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
@@ -1545,6 +1546,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		goto migrate_fail;
 	}
 
+	pgdat = NODE_DATA(target_nid);
+	if (!numamigrate_isolate_page(pgdat, page)) {
+		put_page(page);
+		goto migrate_fail;
+	}
+
 	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
diff --git a/mm/memory.c b/mm/memory.c
index fc6f6b7a70e1..4e451b041488 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4769,6 +4769,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	int target_nid;
 	pte_t pte, old_pte;
 	int flags = 0;
+	pg_data_t *pgdat;
 
 	/*
 	 * The "pte" at this point cannot be used safely without
@@ -4844,6 +4845,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		goto migrate_fail;
 	}
 
+	pgdat = NODE_DATA(target_nid);
+	if (!numamigrate_isolate_page(pgdat, page)) {
+		put_page(page);
+		goto migrate_fail;
+	}
+
 	/* Migrate to the requested node */
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
diff --git a/mm/migrate.c b/mm/migrate.c
index 9cc98fb1d6ec..0b2b69a2a7ab 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2478,7 +2478,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
 	return __folio_alloc_node(gfp, order, nid);
 }
 
-static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
+bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 {
 	int nr_pages = thp_nr_pages(page);
 	int order = compound_order(page);
@@ -2496,11 +2496,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 				break;
 		}
 		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
-		return 0;
+		return false;
 	}
 
 	if (!isolate_lru_page(page))
-		return 0;
+		return false;
 
 	mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON + page_is_file_lru(page),
 			    nr_pages);
@@ -2511,7 +2511,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 	 * disappearing underneath us during migration.
 	 */
 	put_page(page);
-	return 1;
+	return true;
 }
 
 /*
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

