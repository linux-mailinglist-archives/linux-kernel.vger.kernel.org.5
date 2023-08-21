Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B6783484
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjHUUpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjHUUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7B1735
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iQ6N/LjQx+6o+U2nCa8DzMMTkBWW+AcF6vFCml2CAOc=; b=rzIBTvDK8Pk0RQceRRAl76K1f9
        NGnTg9B59ZUz3WjY2SEsQN+m8Ucg8weTeTcBwjS+CUceeWIDduR1Uv06uxGl4vMDlBCMPZYE7ttcK
        I8/EnoTTyv2Yecui/H62M7nREHC7USK/BGSjwK1g0OmGOC8sY6BDa/DZDN/FXIRm2kWdH/2REfwlb
        1GpgRBuCB96Y6mXA8kGAsI3rKNCe3ypQKbyqd/Hwnak8ALNLQLemvTNd0E89YYvNo2mI9KVVuI5AA
        wMp4XqKQc8qbpgEKwqe92Zi3pQCOXXB0/KOHbnviyd69XPXsDkpom+BUzOJW4t+5HrAk11gyRQE3m
        T1bYbKjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlE-00CL04-22; Mon, 21 Aug 2023 20:44:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/7] mm: Make folios_put() the basis of release_pages()
Date:   Mon, 21 Aug 2023 21:44:19 +0100
Message-Id: <20230821204425.2940496-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
References: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By making release_pages() call folios_put(), we can get rid of the calls
to compound_head() for the callers that already know they have folios.
We can also get rid of the lock_batch tracking as we know the size of
the batch is limited by folio_batch.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 19 ++----------
 mm/mlock.c         |  2 +-
 mm/swap.c          | 77 +++++++++++++++++++++++++++-------------------
 3 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 85568e2b2556..c1fc81da8dff 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -36,6 +36,7 @@ struct anon_vma;
 struct anon_vma_chain;
 struct user_struct;
 struct pt_regs;
+struct folio_batch;
 
 extern int sysctl_page_lock_unfairness;
 
@@ -1497,23 +1498,7 @@ typedef union {
 } release_pages_arg __attribute__ ((__transparent_union__));
 
 void release_pages(release_pages_arg, int nr);
-
-/**
- * folios_put - Decrement the reference count on an array of folios.
- * @folios: The folios.
- * @nr: How many folios there are.
- *
- * Like folio_put(), but for an array of folios.  This is more efficient
- * than writing the loop yourself as it will optimise the locks which
- * need to be taken if the folios are freed.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folios_put(struct folio **folios, unsigned int nr)
-{
-	release_pages(folios, nr);
-}
+void folios_put(struct folio_batch *folios);
 
 static inline void put_page(struct page *page)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index 0a0c996c5c21..67ec840cf5f1 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -206,7 +206,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	if (lruvec)
 		unlock_page_lruvec_irq(lruvec);
-	folios_put(fbatch->folios, folio_batch_count(fbatch));
+	folios_put(fbatch);
 	folio_batch_reinit(fbatch);
 }
 
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..11ca25d4843f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -221,7 +221,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
-	folios_put(fbatch->folios, folio_batch_count(fbatch));
+	folios_put(fbatch);
 	folio_batch_reinit(fbatch);
 }
 
@@ -946,41 +946,25 @@ void lru_cache_disable(void)
 }
 
 /**
- * release_pages - batched put_page()
- * @arg: array of pages to release
- * @nr: number of pages
+ * folios_put - Decrement the reference count on a batch of folios.
+ * @folios: The folios.
  *
- * Decrement the reference count on all the pages in @arg.  If it
- * fell to zero, remove the page from the LRU and free it.
+ * Like folio_put(), but for a batch of folios.  This is more efficient
+ * than writing the loop yourself as it will optimise the locks which
+ * need to be taken if the folios are freed.
  *
- * Note that the argument can be an array of pages, encoded pages,
- * or folio pointers. We ignore any encoded bits, and turn any of
- * them into just a folio that gets free'd.
+ * Context: May be called in process or interrupt context, but not in NMI
+ * context.  May be called while holding a spinlock.
  */
-void release_pages(release_pages_arg arg, int nr)
+void folios_put(struct folio_batch *folios)
 {
 	int i;
-	struct encoded_page **encoded = arg.encoded_pages;
 	LIST_HEAD(pages_to_free);
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
-	unsigned int lock_batch;
 
-	for (i = 0; i < nr; i++) {
-		struct folio *folio;
-
-		/* Turn any of the argument types into a folio */
-		folio = page_folio(encoded_page_ptr(encoded[i]));
-
-		/*
-		 * Make sure the IRQ-safe lock-holding time does not get
-		 * excessive with a continuous string of pages from the
-		 * same lruvec. The lock is held only if lruvec != NULL.
-		 */
-		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
-			unlock_page_lruvec_irqrestore(lruvec, flags);
-			lruvec = NULL;
-		}
+	for (i = 0; i < folios->nr; i++) {
+		struct folio *folio = folios->folios[i];
 
 		if (is_huge_zero_page(&folio->page))
 			continue;
@@ -1010,13 +994,8 @@ void release_pages(release_pages_arg arg, int nr)
 		}
 
 		if (folio_test_lru(folio)) {
-			struct lruvec *prev_lruvec = lruvec;
-
 			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
 									&flags);
-			if (prev_lruvec != lruvec)
-				lock_batch = 0;
-
 			lruvec_del_folio(lruvec, folio);
 			__folio_clear_lru_flags(folio);
 		}
@@ -1041,6 +1020,40 @@ void release_pages(release_pages_arg arg, int nr)
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
 }
+EXPORT_SYMBOL(folios_put);
+
+/**
+ * release_pages - batched put_page()
+ * @arg: array of pages to release
+ * @nr: number of pages
+ *
+ * Decrement the reference count on all the pages in @arg.  If it
+ * fell to zero, remove the page from the LRU and free it.
+ *
+ * Note that the argument can be an array of pages, encoded pages,
+ * or folio pointers. We ignore any encoded bits, and turn any of
+ * them into just a folio that gets free'd.
+ */
+void release_pages(release_pages_arg arg, int nr)
+{
+	struct folio_batch fbatch;
+	struct encoded_page **encoded = arg.encoded_pages;
+	int i;
+
+	folio_batch_init(&fbatch);
+	for (i = 0; i < nr; i++) {
+		/* Turn any of the argument types into a folio */
+		struct folio *folio = page_folio(encoded_page_ptr(encoded[i]));
+
+		if (folio_batch_add(&fbatch, folio) > 0)
+			continue;
+		folios_put(&fbatch);
+		fbatch.nr = 0;
+	}
+
+	if (fbatch.nr)
+		folios_put(&fbatch);
+}
 EXPORT_SYMBOL(release_pages);
 
 /*
-- 
2.40.1

