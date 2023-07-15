Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7737546D5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGOEX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGOEXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:23:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9335AC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fL+qL8EnlaO5FW8JSNM7sOc38PnS7TUvxqQRKH9FEK4=; b=KdxGJ59ODR0MgZlSXyaTqvQyF4
        7ewg/KBwST6gTXXAsH7ACpre9ad3A+U7bgyBk0hqzsfD3VHiM0rxdlQ0W2ZFd8YXWw754UwlITjQh
        BtNGe0HFIwa1zZp4FyAYu4hp9pIetp7C8cpc06hqhkZFKpFVOK4AOjJow3Fi6Xg+ZJmHmVyX4fjfq
        3bjbYTtej6eqoovTtbe2+nVLe/BpyCB0xFZZfrASsxtvYEykZ1yA6j9Jy0MXdsa+4RTJDJ8ADJll7
        qv65m2Ja06vW2zHDiMkywAX9xLFCa+dtKnaZXFpi5Ah+Gq5Wrx0qfdn7vJqjgDCGgsflhigwNPXMc
        3owfFJdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWos-001p3w-LO; Sat, 15 Jul 2023 04:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vitaly.wool@konsulko.com, cerasuolodomenico@gmail.com,
        nphamcs@gmail.com, hch@infradead.org, yosryahmed@google.com,
        akpm@linux-foundation.org
Subject: [PATCH 5/5] zswap: Make zswap_load() take a folio
Date:   Sat, 15 Jul 2023 05:23:43 +0100
Message-Id: <20230715042343.434588-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230715042343.434588-1-willy@infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <20230715042343.434588-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only convert a few easy parts of this function to use the folio passed
in; convert back to struct page for the majority of it.  Removes three
hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/zswap.h |  4 ++--
 mm/page_io.c          |  2 +-
 mm/zswap.c            | 11 ++++++-----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 9f318c8bc367..2a60ce39cfde 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -11,7 +11,7 @@ extern atomic_t zswap_stored_pages;
 #ifdef CONFIG_ZSWAP
 
 bool zswap_store(struct folio *folio);
-bool zswap_load(struct page *page);
+bool zswap_load(struct folio *folio);
 void zswap_invalidate(int type, pgoff_t offset);
 void zswap_swapon(int type);
 void zswap_swapoff(int type);
@@ -23,7 +23,7 @@ static inline bool zswap_store(struct folio *folio)
 	return false;
 }
 
-static inline bool zswap_load(struct page *page)
+static inline bool zswap_load(struct folio *folio)
 {
 	return false;
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index e5b6f1402506..8741d3a0d48a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -516,7 +516,7 @@ void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (zswap_load(page)) {
+	if (zswap_load(folio)) {
 		folio_mark_uptodate(folio);
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
diff --git a/mm/zswap.c b/mm/zswap.c
index 69d097d14255..4287f8551841 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1381,11 +1381,12 @@ bool zswap_store(struct folio *folio)
 	goto reject;
 }
 
-bool zswap_load(struct page *page)
+bool zswap_load(struct folio *folio)
 {
-	swp_entry_t swp = { .val = page_private(page), };
+	swp_entry_t swp = folio_swap_entry(folio);
 	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
+	struct page *page = &folio->page;
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry;
 	struct scatterlist input, output;
@@ -1394,8 +1395,8 @@ bool zswap_load(struct page *page)
 	unsigned int dlen;
 	bool ret;
 
-	VM_WARN_ON_ONCE(!PageLocked(page));
-	VM_WARN_ON_ONCE(!PageSwapCache(page));
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
 	/* find */
 	spin_lock(&tree->lock);
@@ -1457,7 +1458,7 @@ bool zswap_load(struct page *page)
 	spin_lock(&tree->lock);
 	if (ret && zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);
-		SetPageDirty(page);
+		folio_mark_dirty(folio);
 	} else if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
 		list_move(&entry->lru, &entry->pool->lru);
-- 
2.39.2

