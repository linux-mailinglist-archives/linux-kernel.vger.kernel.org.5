Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAC7546D4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGOEX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGOEXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:23:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1635A9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aZOTevyyG/oq7Dcb/mDg4h3vECd5Czx9C+nnro/i/yI=; b=PrC2Q5i1RZUQ3NoWBymN8xdsDw
        VN9bzJ75Grrvkb2F/xMhSInJJKrjHYSrDiJu9Xz/AD/RyXELC58gEjFJHB7ADGAX8Tnys8yOuV2bM
        rfGZ4Lxfxnvu/yaz+Gx5bDS54gJNSJ1nA/CirJF8hbPtLQY4p3WMbWLdnOssESTuhpz5rCCKPj46f
        yu9xO+DnTP0rAlinUHRpeJ102wP6g7teVzOnYWub18YqnzON7d4UeG1hqCCuU5vuAZZyIy97m2TP9
        XbUwm9tLEeZywDy7frHNsQXCf/HZi8bjPWB2O1fMmqwoGpZNoJ8u6m17dNfXibTmPDs85K7YUopTG
        QAzbF+Kw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKWos-001p3q-EK; Sat, 15 Jul 2023 04:23:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vitaly.wool@konsulko.com, cerasuolodomenico@gmail.com,
        nphamcs@gmail.com, hch@infradead.org, yosryahmed@google.com,
        akpm@linux-foundation.org
Subject: [PATCH 2/5] zswap: Make zswap_store() take a folio
Date:   Sat, 15 Jul 2023 05:23:40 +0100
Message-Id: <20230715042343.434588-3-willy@infradead.org>
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
in; convert back to struct page for the majority of it.  This does
remove a few hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/zswap.h |  4 ++--
 mm/page_io.c          |  2 +-
 mm/zswap.c            | 13 +++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 850c377d9b6d..9f318c8bc367 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -10,7 +10,7 @@ extern atomic_t zswap_stored_pages;
 
 #ifdef CONFIG_ZSWAP
 
-bool zswap_store(struct page *page);
+bool zswap_store(struct folio *folio);
 bool zswap_load(struct page *page);
 void zswap_invalidate(int type, pgoff_t offset);
 void zswap_swapon(int type);
@@ -18,7 +18,7 @@ void zswap_swapoff(int type);
 
 #else
 
-static inline bool zswap_store(struct page *page)
+static inline bool zswap_store(struct folio *folio)
 {
 	return false;
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index 32afc2a52982..b9fda7fb4e75 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -198,7 +198,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return ret;
 	}
-	if (zswap_store(&folio->page)) {
+	if (zswap_store(folio)) {
 		folio_start_writeback(folio);
 		folio_unlock(folio);
 		folio_end_writeback(folio);
diff --git a/mm/zswap.c b/mm/zswap.c
index f6a78e085479..ba50b186ee27 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1201,11 +1201,12 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
-bool zswap_store(struct page *page)
+bool zswap_store(struct folio *folio)
 {
-	swp_entry_t swp = { .val = page_private(page), };
+	swp_entry_t swp = folio_swap_entry(folio);
 	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
+	struct page *page = &folio->page;
 	struct zswap_tree *tree = zswap_trees[type];
 	struct zswap_entry *entry, *dupentry;
 	struct scatterlist input, output;
@@ -1219,11 +1220,11 @@ bool zswap_store(struct page *page)
 	gfp_t gfp;
 	int ret;
 
-	VM_WARN_ON_ONCE(!PageLocked(page));
-	VM_WARN_ON_ONCE(!PageSwapCache(page));
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
-	/* THP isn't supported */
-	if (PageTransHuge(page))
+	/* Large folios aren't supported */
+	if (folio_test_large(folio))
 		return false;
 
 	if (!zswap_enabled || !tree)
-- 
2.39.2

