Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B082278DF71
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbjH3TWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjH3Jup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:50:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08682CCB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:50:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB9DFEC;
        Wed, 30 Aug 2023 02:51:19 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A5003F64C;
        Wed, 30 Aug 2023 02:50:37 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm: Refector release_pages()
Date:   Wed, 30 Aug 2023 10:50:10 +0100
Message-Id: <20230830095011.1228673-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830095011.1228673-1-ryan.roberts@arm.com>
References: <20230830095011.1228673-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for implementing folios_put_refs() in the next patch,
refactor release_pages() into a set of helper functions, which can be
reused. The primary difference between release_pages() and
folios_put_refs() is how they iterate over the set of folios. The
per-folio actions are identical.

No functional change intended.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/swap.c | 167 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 97 insertions(+), 70 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index b05cce475202..5d3e35668929 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -945,6 +945,98 @@ void lru_cache_disable(void)
 #endif
 }
 
+struct folios_put_refs_ctx {
+	struct list_head pages_to_free;
+	struct lruvec *lruvec;
+	unsigned long flags;
+	unsigned int lock_batch;
+};
+
+static void __folios_put_refs_init(struct folios_put_refs_ctx *ctx)
+{
+	*ctx = (struct folios_put_refs_ctx) {
+		.pages_to_free = LIST_HEAD_INIT(ctx->pages_to_free),
+		.lruvec = NULL,
+		.flags = 0,
+	};
+}
+
+static void __folios_put_refs_complete(struct folios_put_refs_ctx *ctx)
+{
+	if (ctx->lruvec)
+		unlock_page_lruvec_irqrestore(ctx->lruvec, ctx->flags);
+
+	mem_cgroup_uncharge_list(&ctx->pages_to_free);
+	free_unref_page_list(&ctx->pages_to_free);
+}
+
+static void __folios_put_refs_do_one(struct folios_put_refs_ctx *ctx,
+					struct folio *folio, int refs)
+{
+	/*
+	 * Make sure the IRQ-safe lock-holding time does not get
+	 * excessive with a continuous string of pages from the
+	 * same lruvec. The lock is held only if lruvec != NULL.
+	 */
+	if (ctx->lruvec && ++ctx->lock_batch == SWAP_CLUSTER_MAX) {
+		unlock_page_lruvec_irqrestore(ctx->lruvec, ctx->flags);
+		ctx->lruvec = NULL;
+	}
+
+	if (is_huge_zero_page(&folio->page))
+		return;
+
+	if (folio_is_zone_device(folio)) {
+		if (ctx->lruvec) {
+			unlock_page_lruvec_irqrestore(ctx->lruvec, ctx->flags);
+			ctx->lruvec = NULL;
+		}
+		if (put_devmap_managed_page_refs(&folio->page, refs))
+			return;
+		if (folio_ref_sub_and_test(folio, refs))
+			free_zone_device_page(&folio->page);
+		return;
+	}
+
+	if (!folio_ref_sub_and_test(folio, refs))
+		return;
+
+	if (folio_test_large(folio)) {
+		if (ctx->lruvec) {
+			unlock_page_lruvec_irqrestore(ctx->lruvec, ctx->flags);
+			ctx->lruvec = NULL;
+		}
+		__folio_put_large(folio);
+		return;
+	}
+
+	if (folio_test_lru(folio)) {
+		struct lruvec *prev_lruvec = ctx->lruvec;
+
+		ctx->lruvec = folio_lruvec_relock_irqsave(folio, ctx->lruvec,
+								&ctx->flags);
+		if (prev_lruvec != ctx->lruvec)
+			ctx->lock_batch = 0;
+
+		lruvec_del_folio(ctx->lruvec, folio);
+		__folio_clear_lru_flags(folio);
+	}
+
+	/*
+	 * In rare cases, when truncation or holepunching raced with
+	 * munlock after VM_LOCKED was cleared, Mlocked may still be
+	 * found set here.  This does not indicate a problem, unless
+	 * "unevictable_pgs_cleared" appears worryingly large.
+	 */
+	if (unlikely(folio_test_mlocked(folio))) {
+		__folio_clear_mlocked(folio);
+		zone_stat_sub_folio(folio, NR_MLOCK);
+		count_vm_event(UNEVICTABLE_PGCLEARED);
+	}
+
+	list_add(&folio->lru, &ctx->pages_to_free);
+}
+
 /**
  * release_pages - batched put_page()
  * @arg: array of pages to release
@@ -959,10 +1051,9 @@ void release_pages(release_pages_arg arg, int nr)
 {
 	int i;
 	struct page **pages = arg.pages;
-	LIST_HEAD(pages_to_free);
-	struct lruvec *lruvec = NULL;
-	unsigned long flags = 0;
-	unsigned int lock_batch;
+	struct folios_put_refs_ctx ctx;
+
+	__folios_put_refs_init(&ctx);
 
 	for (i = 0; i < nr; i++) {
 		struct folio *folio;
@@ -970,74 +1061,10 @@ void release_pages(release_pages_arg arg, int nr)
 		/* Turn any of the argument types into a folio */
 		folio = page_folio(pages[i]);
 
-		/*
-		 * Make sure the IRQ-safe lock-holding time does not get
-		 * excessive with a continuous string of pages from the
-		 * same lruvec. The lock is held only if lruvec != NULL.
-		 */
-		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
-			unlock_page_lruvec_irqrestore(lruvec, flags);
-			lruvec = NULL;
-		}
-
-		if (is_huge_zero_page(&folio->page))
-			continue;
-
-		if (folio_is_zone_device(folio)) {
-			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-				lruvec = NULL;
-			}
-			if (put_devmap_managed_page(&folio->page))
-				continue;
-			if (folio_put_testzero(folio))
-				free_zone_device_page(&folio->page);
-			continue;
-		}
-
-		if (!folio_put_testzero(folio))
-			continue;
-
-		if (folio_test_large(folio)) {
-			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-				lruvec = NULL;
-			}
-			__folio_put_large(folio);
-			continue;
-		}
-
-		if (folio_test_lru(folio)) {
-			struct lruvec *prev_lruvec = lruvec;
-
-			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
-									&flags);
-			if (prev_lruvec != lruvec)
-				lock_batch = 0;
-
-			lruvec_del_folio(lruvec, folio);
-			__folio_clear_lru_flags(folio);
-		}
-
-		/*
-		 * In rare cases, when truncation or holepunching raced with
-		 * munlock after VM_LOCKED was cleared, Mlocked may still be
-		 * found set here.  This does not indicate a problem, unless
-		 * "unevictable_pgs_cleared" appears worryingly large.
-		 */
-		if (unlikely(folio_test_mlocked(folio))) {
-			__folio_clear_mlocked(folio);
-			zone_stat_sub_folio(folio, NR_MLOCK);
-			count_vm_event(UNEVICTABLE_PGCLEARED);
-		}
-
-		list_add(&folio->lru, &pages_to_free);
+		__folios_put_refs_do_one(&ctx, folio, 1);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
 
-	mem_cgroup_uncharge_list(&pages_to_free);
-	free_unref_page_list(&pages_to_free);
+	__folios_put_refs_complete(&ctx);
 }
 EXPORT_SYMBOL(release_pages);
 
-- 
2.25.1

