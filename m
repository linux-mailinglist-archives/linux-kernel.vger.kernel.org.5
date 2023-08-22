Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59C978371E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHVAyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjHVAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:54:13 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE26184
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:54:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VqK0DP4_1692665648;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqK0DP4_1692665648)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 08:54:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] mm: migrate: factor out migration validation into numa_page_can_migrate()
Date:   Tue, 22 Aug 2023 08:53:49 +0800
Message-Id: <6e1c5a86b8d960294582a1221a1a20eb66e53b37.1692665449.git.baolin.wang@linux.alibaba.com>
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

Now there are several places will validate if a page can migrate or not,
so factoring out these validation into a new function to make them more
maintainable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/huge_memory.c |  6 ++++++
 mm/internal.h    |  1 +
 mm/memory.c      | 30 ++++++++++++++++++++++++++++++
 mm/migrate.c     | 19 -------------------
 4 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4465915711c3..4a9b34a89854 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1540,11 +1540,17 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 	writable = false;
 
+	if (!numa_page_can_migrate(vma, page)) {
+		put_page(page);
+		goto migrate_fail;
+	}
+
 	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
 	} else {
+migrate_fail:
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
 		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
diff --git a/mm/internal.h b/mm/internal.h
index f59a53111817..1e00b8a30910 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -933,6 +933,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end);
 
 int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
+bool numa_page_can_migrate(struct vm_area_struct *vma, struct page *page);
 
 void free_zone_device_page(struct page *page);
 int migrate_device_coherent_page(struct page *page);
diff --git a/mm/memory.c b/mm/memory.c
index 12647d139a13..fc6f6b7a70e1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4735,6 +4735,30 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 	return mpol_misplaced(page, vma, addr);
 }
 
+bool numa_page_can_migrate(struct vm_area_struct *vma, struct page *page)
+{
+	/*
+	 * Don't migrate file pages that are mapped in multiple processes
+	 * with execute permissions as they are probably shared libraries.
+	 */
+	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	    (vma->vm_flags & VM_EXEC))
+		return false;
+
+	/*
+	 * Also do not migrate dirty pages as not all filesystems can move
+	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
+	 */
+	if (page_is_file_lru(page) && PageDirty(page))
+		return false;
+
+	/* Do not migrate THP mapped by multiple processes */
+	if (PageTransHuge(page) && total_mapcount(page) > 1)
+		return false;
+
+	return true;
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -4815,11 +4839,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	writable = false;
 
+	if (!numa_page_can_migrate(vma, page)) {
+		put_page(page);
+		goto migrate_fail;
+	}
+
 	/* Migrate to the requested node */
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else {
+migrate_fail:
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					       vmf->address, &vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index e21d5a7e7447..9cc98fb1d6ec 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2485,10 +2485,6 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
 
 	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
 
-	/* Do not migrate THP mapped by multiple processes */
-	if (PageTransHuge(page) && total_mapcount(page) > 1)
-		return 0;
-
 	/* Avoid migrating to a node that is nearly full */
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
 		int z;
@@ -2533,21 +2529,6 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	LIST_HEAD(migratepages);
 	int nr_pages = thp_nr_pages(page);
 
-	/*
-	 * Don't migrate file pages that are mapped in multiple processes
-	 * with execute permissions as they are probably shared libraries.
-	 */
-	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
-	    (vma->vm_flags & VM_EXEC))
-		goto out;
-
-	/*
-	 * Also do not migrate dirty pages as not all filesystems can move
-	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
-	 */
-	if (page_is_file_lru(page) && PageDirty(page))
-		goto out;
-
 	isolated = numamigrate_isolate_page(pgdat, page);
 	if (!isolated)
 		goto out;
-- 
2.39.3

