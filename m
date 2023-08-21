Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904C782DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjHUQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbjHUQKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62580FE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692634152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/PlBgSOglEnVLTJqu2zbMYsJDvOn/SB34qHQ+lZyNk=;
        b=gP6Ft9YJ0vVj1169p7RdODEkACqQ6fb1lUmjqbzc5Bf6Uv+/gWA/2UU/NVwy/13yHenr2N
        to8ei6q5zAv9gItA8atSHTKNkrMYggDmY/OEtcj1UFY8jetnhJxoZQIkbz4leAR4B+KFaI
        emg2B5tFos25WPJFOJ3Dr/5JANFzz7U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-Afa7N3q2MaOpDmVf2OHBqA-1; Mon, 21 Aug 2023 12:09:09 -0400
X-MC-Unique: Afa7N3q2MaOpDmVf2OHBqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67DB9858EED;
        Mon, 21 Aug 2023 16:09:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 219E8492C13;
        Mon, 21 Aug 2023 16:09:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH mm-unstable v1 4/4] mm/huge_memory: work on folio->swap instead of page->private when splitting folio
Date:   Mon, 21 Aug 2023 18:08:49 +0200
Message-ID: <20230821160849.531668-5-david@redhat.com>
In-Reply-To: <20230821160849.531668-1-david@redhat.com>
References: <20230821160849.531668-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's work on folio->swap instead. While at it, use folio_test_anon() and
folio_test_swapcache() -- the original folio remains valid even after
splitting (but is then an order-0 folio).

We can probably convert a lot more to folios in that code, let's focus
on folio->swap handling only for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c04702ae71d2..4465915711c3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2401,10 +2401,16 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
 	}
 }
 
-static void __split_huge_page_tail(struct page *head, int tail,
+static void __split_huge_page_tail(struct folio *folio, int tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
+	struct page *head = &folio->page;
 	struct page *page_tail = head + tail;
+	/*
+	 * Careful: new_folio is not a "real" folio before we cleared PageTail.
+	 * Don't pass it around before clear_compound_head().
+	 */
+	struct folio *new_folio = (struct folio *)page_tail;
 
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) != -1, page_tail);
 
@@ -2453,8 +2459,8 @@ static void __split_huge_page_tail(struct page *head, int tail,
 		VM_WARN_ON_ONCE_PAGE(true, page_tail);
 		page_tail->private = 0;
 	}
-	if (PageSwapCache(head))
-		set_page_private(page_tail, (unsigned long)head->private + tail);
+	if (folio_test_swapcache(folio))
+		new_folio->swap.val = folio->swap.val + tail;
 
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
@@ -2500,11 +2506,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, nr);
 
-	if (PageAnon(head) && PageSwapCache(head)) {
-		swp_entry_t entry = { .val = page_private(head) };
-
-		offset = swp_offset(entry);
-		swap_cache = swap_address_space(entry);
+	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
+		offset = swp_offset(folio->swap);
+		swap_cache = swap_address_space(folio->swap);
 		xa_lock(&swap_cache->i_pages);
 	}
 
@@ -2514,7 +2518,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	ClearPageHasHWPoisoned(head);
 
 	for (i = nr - 1; i >= 1; i--) {
-		__split_huge_page_tail(head, i, lruvec, list);
+		__split_huge_page_tail(folio, i, lruvec, list);
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >= end) {
 			struct folio *tail = page_folio(head + i);
@@ -2559,11 +2563,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	remap_page(folio, nr);
 
-	if (PageSwapCache(head)) {
-		swp_entry_t entry = { .val = page_private(head) };
-
-		split_swap_cluster(entry);
-	}
+	if (folio_test_swapcache(folio))
+		split_swap_cluster(folio->swap);
 
 	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
-- 
2.41.0

