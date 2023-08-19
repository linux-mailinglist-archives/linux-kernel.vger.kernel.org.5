Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3489781926
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjHSKz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHSKzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:55:55 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33AF36A2C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:52:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vq58.Rv_1692442362;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq58.Rv_1692442362)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 18:52:43 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: migrate: move migration validation into numa_migrate_prep()
Date:   Sat, 19 Aug 2023 18:52:34 +0800
Message-Id: <a37b13dd91bd3eadcd56a08cb3c839616f8457e7.1692440586.git.baolin.wang@linux.alibaba.com>
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

Now there are 3 places will validate if a page can mirate or not, and
some validations are performed later, which will waste some CPU to call
numa_migrate_prep().

Thus we can move all the migration validation into numa_migrate_prep(),
which is more maintainable as well as saving some CPU resources. Another
benefit is that it can serve as a preparation for supporting batch migration
in do_numa_page() in future.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c  | 19 +++++++++++++++++++
 mm/migrate.c | 19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d003076b218d..bee9b1e86ef0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4747,6 +4747,25 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		*flags |= TNF_FAULT_LOCAL;
 	}
 
+	/*
+	 * Don't migrate file pages that are mapped in multiple processes
+	 * with execute permissions as they are probably shared libraries.
+	 */
+	if (page_mapcount(page) != 1 && page_is_file_lru(page) &&
+	    (vma->vm_flags & VM_EXEC))
+		return NUMA_NO_NODE;
+
+	/*
+	 * Also do not migrate dirty pages as not all filesystems can move
+	 * dirty pages in MIGRATE_ASYNC mode which is a waste of cycles.
+	 */
+	if (page_is_file_lru(page) && PageDirty(page))
+		return NUMA_NO_NODE;
+
+	/* Do not migrate THP mapped by multiple processes */
+	if (PageTransHuge(page) && total_mapcount(page) > 1)
+		return NUMA_NO_NODE;
+
 	return mpol_misplaced(page, vma, addr);
 }
 
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

