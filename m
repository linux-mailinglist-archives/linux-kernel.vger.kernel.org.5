Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC126781923
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjHSKzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjHSKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:55:10 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4731C38E5B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:52:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vq58.Sy_1692442365;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq58.Sy_1692442365)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 18:52:46 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mm: migrate: change to return the number of pages migrated successfully
Date:   Sat, 19 Aug 2023 18:52:37 +0800
Message-Id: <ee51fd4effeb8c398566a766ada2da475320b400.1692440586.git.baolin.wang@linux.alibaba.com>
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

Change the migrate_misplaced_page() to return the number of pages migrated
successfully, which is used to calculate how many pages are failed to
migrate for batch migration.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c | 7 ++++---
 mm/memory.c      | 5 +++--
 mm/migrate.c     | 5 +----
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 53a9d63cfb1e..a9c454160984 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1494,11 +1494,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	int page_nid = NUMA_NO_NODE;
 	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
-	bool migrated = false, writable = false;
+	bool writable = false;
 	int flags = 0;
 	pg_data_t *pgdat;
 	int isolated;
 	LIST_HEAD(migratepages);
+	int nr_successed = 0;
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
@@ -1551,8 +1552,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	}
 
 	list_add(&page->lru, &migratepages);
-	migrated = migrate_misplaced_page(&migratepages, vma, page_nid, target_nid);
-	if (migrated) {
+	nr_successed = migrate_misplaced_page(&migratepages, vma, page_nid, target_nid);
+	if (nr_successed) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
 	} else {
diff --git a/mm/memory.c b/mm/memory.c
index 973403a83797..edfd2d528e7e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4780,7 +4780,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte_t pte, old_pte;
 	int flags = 0;
 	pg_data_t *pgdat;
-	int isolated;
+	int isolated, nr_succeeded;
 	LIST_HEAD(migratepages);
 
 	/*
@@ -4861,7 +4861,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	list_add(&page->lru, &migratepages);
 	/* Migrate to the requested node */
-	if (migrate_misplaced_page(&migratepages, vma, page_nid, target_nid)) {
+	nr_succeeded = migrate_misplaced_page(&migratepages, vma, page_nid, target_nid);
+	if (nr_succeeded) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
diff --git a/mm/migrate.c b/mm/migrate.c
index 93d359471b95..45f92376ba6f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2523,7 +2523,6 @@ int migrate_misplaced_page(struct list_head *migratepages, struct vm_area_struct
 			   int source_nid, int target_nid)
 {
 	pg_data_t *pgdat = NODE_DATA(target_nid);
-	int migrated = 1;
 	int nr_remaining;
 	unsigned int nr_succeeded;
 
@@ -2533,8 +2532,6 @@ int migrate_misplaced_page(struct list_head *migratepages, struct vm_area_struct
 	if (nr_remaining) {
 		if (!list_empty(migratepages))
 			putback_movable_pages(migratepages);
-
-		migrated = 0;
 	}
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
@@ -2543,7 +2540,7 @@ int migrate_misplaced_page(struct list_head *migratepages, struct vm_area_struct
 					    nr_succeeded);
 	}
 	BUG_ON(!list_empty(migratepages));
-	return migrated;
+	return nr_succeeded;
 }
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
-- 
2.39.3

