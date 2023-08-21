Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC18782DED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjHUQKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbjHUQKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDDD11F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692634146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdnFUGqNF8uC/Mhnd72wov++fKDyb2cH73FrJqKy4cQ=;
        b=e3JNvKtoQghdCsspwNPKLI95sboueYhn/r7/VOHRgcn7kQ3IaXGyiwAiPm9gM8Mj/WNs5U
        IzUuNNKvwEVrBKnnG+U8HXSRh40bvwzZS/TLmd5XmHRF/Hr+tSNg94Zg4XKnAREQHg4ZxV
        lxIS09ET667vXTzTTeNvM9yGYCjNixE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-L421dwfjPouKmahmihEKAA-1; Mon, 21 Aug 2023 12:09:02 -0400
X-MC-Unique: L421dwfjPouKmahmihEKAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBFE01875842;
        Mon, 21 Aug 2023 16:09:01 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9873492C13;
        Mon, 21 Aug 2023 16:08:59 +0000 (UTC)
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
Subject: [PATCH mm-unstable v1 3/4] mm/swap: inline folio_set_swap_entry() and folio_swap_entry()
Date:   Mon, 21 Aug 2023 18:08:48 +0200
Message-ID: <20230821160849.531668-4-david@redhat.com>
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

Let's simply work on the folio directly and remove the helpers.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h | 12 +-----------
 mm/memory.c          |  2 +-
 mm/shmem.c           |  6 +++---
 mm/swap_state.c      |  7 +++----
 mm/swapfile.c        |  2 +-
 mm/util.c            |  2 +-
 mm/vmscan.c          |  2 +-
 mm/zswap.c           |  4 ++--
 8 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 82859a1944f5..603acf813873 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -333,25 +333,15 @@ struct swap_info_struct {
 					   */
 };
 
-static inline swp_entry_t folio_swap_entry(struct folio *folio)
-{
-	return folio->swap;
-}
-
 static inline swp_entry_t page_swap_entry(struct page *page)
 {
 	struct folio *folio = page_folio(page);
-	swp_entry_t entry = folio_swap_entry(folio);
+	swp_entry_t entry = folio->swap;
 
 	entry.val += page - &folio->page;
 	return entry;
 }
 
-static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
-{
-	folio->swap = entry;
-}
-
 /* linux/mm/workingset.c */
 bool workingset_test_recent(void *shadow, bool file, bool *workingset);
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
diff --git a/mm/memory.c b/mm/memory.c
index ff13242c1589..c51800dbfa9b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3831,7 +3831,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				folio_add_lru(folio);
 
 				/* To provide entry to swap_readpage() */
-				folio_set_swap_entry(folio, entry);
+				folio->swap = entry;
 				swap_readpage(page, true, NULL);
 				folio->private = NULL;
 			}
diff --git a/mm/shmem.c b/mm/shmem.c
index 7a0c1e19d9f8..fc1afe9dfcfe 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1657,7 +1657,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	int error;
 
 	old = *foliop;
-	entry = folio_swap_entry(old);
+	entry = old->swap;
 	swap_index = swp_offset(entry);
 	swap_mapping = swap_address_space(entry);
 
@@ -1678,7 +1678,7 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	__folio_set_locked(new);
 	__folio_set_swapbacked(new);
 	folio_mark_uptodate(new);
-	folio_set_swap_entry(new, entry);
+	new->swap = entry;
 	folio_set_swapcache(new);
 
 	/*
@@ -1800,7 +1800,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if (!folio_test_swapcache(folio) ||
-	    folio_swap_entry(folio).val != swap.val ||
+	    folio->swap.val != swap.val ||
 	    !shmem_confirm_swap(mapping, index, swap)) {
 		error = -EEXIST;
 		goto unlock;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2f2417810052..b3b14bd0dd64 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -100,7 +100,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 
 	folio_ref_add(folio, nr);
 	folio_set_swapcache(folio);
-	folio_set_swap_entry(folio, entry);
+	folio->swap = entry;
 
 	do {
 		xas_lock_irq(&xas);
@@ -156,8 +156,7 @@ void __delete_from_swap_cache(struct folio *folio,
 		VM_BUG_ON_PAGE(entry != folio, entry);
 		xas_next(&xas);
 	}
-	entry.val = 0;
-	folio_set_swap_entry(folio, entry);
+	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
 	address_space->nrpages -= nr;
 	__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
@@ -233,7 +232,7 @@ bool add_to_swap(struct folio *folio)
  */
 void delete_from_swap_cache(struct folio *folio)
 {
-	swp_entry_t entry = folio_swap_entry(folio);
+	swp_entry_t entry = folio->swap;
 	struct address_space *address_space = swap_address_space(entry);
 
 	xa_lock_irq(&address_space->i_pages);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bd9d904671b9..e52f486834eb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1536,7 +1536,7 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 
 static bool folio_swapped(struct folio *folio)
 {
-	swp_entry_t entry = folio_swap_entry(folio);
+	swp_entry_t entry = folio->swap;
 	struct swap_info_struct *si = _swap_info_get(entry);
 
 	if (!si)
diff --git a/mm/util.c b/mm/util.c
index cde229b05eb3..f31e2ca62cfa 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -764,7 +764,7 @@ struct address_space *folio_mapping(struct folio *folio)
 		return NULL;
 
 	if (unlikely(folio_test_swapcache(folio)))
-		return swap_address_space(folio_swap_entry(folio));
+		return swap_address_space(folio->swap);
 
 	mapping = folio->mapping;
 	if ((unsigned long)mapping & PAGE_MAPPING_FLAGS)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c7c149cb8d66..6f13394b112e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1423,7 +1423,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	}
 
 	if (folio_test_swapcache(folio)) {
-		swp_entry_t swap = folio_swap_entry(folio);
+		swp_entry_t swap = folio->swap;
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
diff --git a/mm/zswap.c b/mm/zswap.c
index 7300b98d4a03..412b1409a0d7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1190,7 +1190,7 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 
 bool zswap_store(struct folio *folio)
 {
-	swp_entry_t swp = folio_swap_entry(folio);
+	swp_entry_t swp = folio->swap;
 	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
@@ -1370,7 +1370,7 @@ bool zswap_store(struct folio *folio)
 
 bool zswap_load(struct folio *folio)
 {
-	swp_entry_t swp = folio_swap_entry(folio);
+	swp_entry_t swp = folio->swap;
 	int type = swp_type(swp);
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
-- 
2.41.0

