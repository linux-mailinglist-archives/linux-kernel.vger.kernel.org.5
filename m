Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03467D1AC3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJUEdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUEdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 00:33:40 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6DED5F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 21:33:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VuYfkpw_1697862809;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuYfkpw_1697862809)
          by smtp.aliyun-inc.com;
          Sat, 21 Oct 2023 12:33:30 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, hughd@google.com, vbabka@suse.cz,
        ying.huang@intel.com, ziy@nvidia.com, fengwei.yin@intel.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: migrate: record the mlocked page status to remove unnecessary lru drain
Date:   Sat, 21 Oct 2023 12:33:22 +0800
Message-Id: <06e9153a7a4850352ec36602df3a3a844de45698.1697859741.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

When doing compaction, I found the lru_add_drain() is an obvious hotspot
when migrating pages. The distribution of this hotspot is as follows:
   - 18.75% compact_zone
      - 17.39% migrate_pages
         - 13.79% migrate_pages_batch
            - 11.66% migrate_folio_move
               - 7.02% lru_add_drain
                  + 7.02% lru_add_drain_cpu
               + 3.00% move_to_new_folio
                 1.23% rmap_walk
            + 1.92% migrate_folio_unmap
         + 3.20% migrate_pages_sync
      + 0.90% isolate_migratepages

The lru_add_drain() was added by commit c3096e6782b7 ("mm/migrate:
__unmap_and_move() push good newpage to LRU") to drain the newpage to LRU
immediately, to help to build up the correct newpage->mlock_count in
remove_migration_ptes() for mlocked pages. However, if there are no mlocked
pages are migrating, then we can avoid this lru drain operation, especailly
for the heavy concurrent scenarios.

So we can record the source pages' mlocked status in migrate_folio_unmap(),
and only drain the lru list when the mlocked status is set in migrate_folio_move().
In addition, the page was already isolated from lru when migrating, so checking
the mlocked status is stable by folio_test_mlocked() in migrate_folio_unmap().

After this patch, I can see the hotpot of the lru_add_drain() is gone:
   - 9.41% migrate_pages_batch
      - 6.15% migrate_folio_move
         - 3.64% move_to_new_folio
            + 1.80% migrate_folio_extra
            + 1.70% buffer_migrate_folio
         + 1.41% rmap_walk
         + 0.62% folio_add_lru
      + 3.07% migrate_folio_unmap

Meanwhile, the compaction latency shows some improvements when running
thpscale:
                            base                   patched
Amean     fault-both-1      1131.22 (   0.00%)     1112.55 *   1.65%*
Amean     fault-both-3      2489.75 (   0.00%)     2324.15 *   6.65%*
Amean     fault-both-5      3257.37 (   0.00%)     3183.18 *   2.28%*
Amean     fault-both-7      4257.99 (   0.00%)     4079.04 *   4.20%*
Amean     fault-both-12     6614.02 (   0.00%)     6075.60 *   8.14%*
Amean     fault-both-18    10607.78 (   0.00%)     8978.86 *  15.36%*
Amean     fault-both-24    14911.65 (   0.00%)    11619.55 *  22.08%*
Amean     fault-both-30    14954.67 (   0.00%)    14925.66 *   0.19%*
Amean     fault-both-32    16654.87 (   0.00%)    15580.31 *   6.45%*

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v2:
 - Use BIT() to define macros.
 - Simplify handing page_was_mapped and page_was_mlocked variables with
introducing old_page_state variable.

Changes from v1:
 - Use separate flags in __migrate_folio_record() to avoid to pack flags
in each call site per Ying.
---
 mm/migrate.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 125194f5af0f..35a88334bb3c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1027,22 +1027,28 @@ union migration_ptr {
 	struct anon_vma *anon_vma;
 	struct address_space *mapping;
 };
+
+enum {
+	PAGE_WAS_MAPPED = BIT(0),
+	PAGE_WAS_MLOCKED = BIT(1),
+};
+
 static void __migrate_folio_record(struct folio *dst,
-				   unsigned long page_was_mapped,
+				   unsigned long old_page_state,
 				   struct anon_vma *anon_vma)
 {
 	union migration_ptr ptr = { .anon_vma = anon_vma };
 	dst->mapping = ptr.mapping;
-	dst->private = (void *)page_was_mapped;
+	dst->private = (void *)old_page_state;
 }
 
 static void __migrate_folio_extract(struct folio *dst,
-				   int *page_was_mappedp,
+				   int *old_page_state,
 				   struct anon_vma **anon_vmap)
 {
 	union migration_ptr ptr = { .mapping = dst->mapping };
 	*anon_vmap = ptr.anon_vma;
-	*page_was_mappedp = (unsigned long)dst->private;
+	*old_page_state = (unsigned long)dst->private;
 	dst->mapping = NULL;
 	dst->private = NULL;
 }
@@ -1103,7 +1109,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
-	int page_was_mapped = 0;
+	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__folio_test_movable(src);
 	bool locked = false;
@@ -1157,6 +1163,8 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_lock(src);
 	}
 	locked = true;
+	if (folio_test_mlocked(src))
+		old_page_state |= PAGE_WAS_MLOCKED;
 
 	if (folio_test_writeback(src)) {
 		/*
@@ -1206,7 +1214,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	dst_locked = true;
 
 	if (unlikely(!is_lru)) {
-		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return MIGRATEPAGE_UNMAP;
 	}
 
@@ -1232,11 +1240,11 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
 		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
-		page_was_mapped = 1;
+		old_page_state |= PAGE_WAS_MAPPED;
 	}
 
 	if (!folio_mapped(src)) {
-		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return MIGRATEPAGE_UNMAP;
 	}
 
@@ -1248,7 +1256,8 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	if (rc == -EAGAIN)
 		ret = NULL;
 
-	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret);
+	migrate_folio_undo_src(src, old_page_state & PAGE_WAS_MAPPED,
+			       anon_vma, locked, ret);
 	migrate_folio_undo_dst(dst, dst_locked, put_new_folio, private);
 
 	return rc;
@@ -1261,12 +1270,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 			      struct list_head *ret)
 {
 	int rc;
-	int page_was_mapped = 0;
+	int old_page_state = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__folio_test_movable(src);
 	struct list_head *prev;
 
-	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
+	__migrate_folio_extract(dst, &old_page_state, &anon_vma);
 	prev = dst->lru.prev;
 	list_del(&dst->lru);
 
@@ -1287,10 +1296,10 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	 * isolated from the unevictable LRU: but this case is the easiest.
 	 */
 	folio_add_lru(dst);
-	if (page_was_mapped)
+	if (old_page_state & PAGE_WAS_MLOCKED)
 		lru_add_drain();
 
-	if (page_was_mapped)
+	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, false);
 
 out_unlock_both:
@@ -1322,11 +1331,12 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	 */
 	if (rc == -EAGAIN) {
 		list_add(&dst->lru, prev);
-		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		__migrate_folio_record(dst, old_page_state, anon_vma);
 		return rc;
 	}
 
-	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
+	migrate_folio_undo_src(src, old_page_state & PAGE_WAS_MAPPED,
+			       anon_vma, true, ret);
 	migrate_folio_undo_dst(dst, true, put_new_folio, private);
 
 	return rc;
@@ -1799,12 +1809,12 @@ static int migrate_pages_batch(struct list_head *from,
 	dst = list_first_entry(&dst_folios, struct folio, lru);
 	dst2 = list_next_entry(dst, lru);
 	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-		int page_was_mapped = 0;
+		int old_page_state = 0;
 		struct anon_vma *anon_vma = NULL;
 
-		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
-		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
-				       true, ret_folios);
+		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
+				       anon_vma, true, ret_folios);
 		list_del(&dst->lru);
 		migrate_folio_undo_dst(dst, true, put_new_folio, private);
 		dst = dst2;
-- 
2.39.3

