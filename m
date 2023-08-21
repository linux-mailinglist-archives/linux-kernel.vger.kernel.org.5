Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1656782DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjHUQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjHUQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308A5103
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692634142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSFFh/KLUGTq+zDQ/y6zlFb70l3lmZmKgiSBR+NyjZY=;
        b=MT2mNmXgc+vI20AhORo3Z/U/+lZIlvFiXxKuk/k+VoMSqkn0Le0qYfUZgp0TC0CHdEjVEn
        kcx2H6ct4qBwKv2cvbxn16WmQCwjX1ccdwQKL3S+FUjPcFRJvBb+BOFkW7Iz9Za2F8pbgm
        Mgw/yyPshAs6g+jq5HzH8YEdLMblF7c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-GEYiNV70OW-yfFc5WKiRKg-1; Mon, 21 Aug 2023 12:08:59 -0400
X-MC-Unique: GEYiNV70OW-yfFc5WKiRKg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E42CB187573F;
        Mon, 21 Aug 2023 16:08:55 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56E2C492C14;
        Mon, 21 Aug 2023 16:08:53 +0000 (UTC)
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
Subject: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on tail pages for THP_SWAP
Date:   Mon, 21 Aug 2023 18:08:46 +0200
Message-ID: <20230821160849.531668-2-david@redhat.com>
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

Let's stop using page->private on tail pages, making it possible to
just unconditionally reuse that field in the tail pages of large folios.

The remaining usage of the private field for THP_SWAP is in the THP
splitting code (mm/huge_memory.c), that we'll handle separately later.

Update the THP_SWAP documentation and sanity checks in mm_types.h and
__split_huge_page_tail().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/mm/mteswap.c  |  5 +++--
 include/linux/mm_types.h | 12 +-----------
 include/linux/swap.h     |  9 +++++++++
 mm/huge_memory.c         | 15 ++++++---------
 mm/memory.c              |  2 +-
 mm/rmap.c                |  2 +-
 mm/swap_state.c          |  5 +++--
 mm/swapfile.c            |  4 ++--
 8 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index cd508ba80ab1..a31833e3ddc5 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -33,8 +33,9 @@ int mte_save_tags(struct page *page)
 
 	mte_save_page_tags(page_address(page), tag_storage);
 
-	/* page_private contains the swap entry.val set in do_swap_page */
-	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
+	/* lookup the swap entry.val from the page */
+	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
+		       GFP_KERNEL);
 	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
 		mte_free_tag_storage(tag_storage);
 		return xa_err(ret);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b9b6c88875b9..61361f1750c3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -333,11 +333,8 @@ struct folio {
 			atomic_t _pincount;
 #ifdef CONFIG_64BIT
 			unsigned int _folio_nr_pages;
-			/* 4 byte gap here */
-	/* private: the union with struct page is transitional */
-			/* Fix THP_SWAP to not use tail->private */
-			unsigned long _private_1;
 #endif
+	/* private: the union with struct page is transitional */
 		};
 		struct page __page_1;
 	};
@@ -358,9 +355,6 @@ struct folio {
 	/* public: */
 			struct list_head _deferred_list;
 	/* private: the union with struct page is transitional */
-			unsigned long _avail_2a;
-			/* Fix THP_SWAP to not use tail->private */
-			unsigned long _private_2a;
 		};
 		struct page __page_2;
 	};
@@ -385,9 +379,6 @@ FOLIO_MATCH(memcg_data, memcg_data);
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_head, _head_1);
-#ifdef CONFIG_64BIT
-FOLIO_MATCH(private, _private_1);
-#endif
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
@@ -396,7 +387,6 @@ FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
 FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
-FOLIO_MATCH(private, _private_2a);
 #undef FOLIO_MATCH
 
 /**
diff --git a/include/linux/swap.h b/include/linux/swap.h
index bb5adc604144..84fe0e94f5cd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -339,6 +339,15 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
 	return entry;
 }
 
+static inline swp_entry_t page_swap_entry(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	swp_entry_t entry = folio_swap_entry(folio);
+
+	entry.val += page - &folio->page;
+	return entry;
+}
+
 static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
 {
 	folio->private = (void *)entry.val;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cc2f65f8cc62..c04702ae71d2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2446,18 +2446,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
 	page_tail->index = head->index + tail;
 
 	/*
-	 * page->private should not be set in tail pages with the exception
-	 * of swap cache pages that store the swp_entry_t in tail pages.
-	 * Fix up and warn once if private is unexpectedly set.
-	 *
-	 * What of 32-bit systems, on which folio->_pincount overlays
-	 * head[1].private?  No problem: THP_SWAP is not enabled on 32-bit, and
-	 * pincount must be 0 for folio_ref_freeze() to have succeeded.
+	 * page->private should not be set in tail pages. Fix up and warn once
+	 * if private is unexpectedly set.
 	 */
-	if (!folio_test_swapcache(page_folio(head))) {
-		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
+	if (unlikely(page_tail->private)) {
+		VM_WARN_ON_ONCE_PAGE(true, page_tail);
 		page_tail->private = 0;
 	}
+	if (PageSwapCache(head))
+		set_page_private(page_tail, (unsigned long)head->private + tail);
 
 	/* Page flags must be visible before we make the page non-compound. */
 	smp_wmb();
diff --git a/mm/memory.c b/mm/memory.c
index d003076b218d..ff13242c1589 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3882,7 +3882,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 * changed.
 		 */
 		if (unlikely(!folio_test_swapcache(folio) ||
-			     page_private(page) != entry.val))
+			     page_swap_entry(page).val != entry.val))
 			goto out_page;
 
 		/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 1f04debdc87a..ec7f8e6c9e48 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1647,7 +1647,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			dec_mm_counter(mm, mm_counter(&folio->page));
 		} else if (folio_test_anon(folio)) {
-			swp_entry_t entry = { .val = page_private(subpage) };
+			swp_entry_t entry = page_swap_entry(subpage);
 			pte_t swp_pte;
 			/*
 			 * Store the swap location in the pte.
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 01f15139b7d9..2f2417810052 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -100,6 +100,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 
 	folio_ref_add(folio, nr);
 	folio_set_swapcache(folio);
+	folio_set_swap_entry(folio, entry);
 
 	do {
 		xas_lock_irq(&xas);
@@ -113,7 +114,6 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 				if (shadowp)
 					*shadowp = old;
 			}
-			set_page_private(folio_page(folio, i), entry.val + i);
 			xas_store(&xas, folio);
 			xas_next(&xas);
 		}
@@ -154,9 +154,10 @@ void __delete_from_swap_cache(struct folio *folio,
 	for (i = 0; i < nr; i++) {
 		void *entry = xas_store(&xas, shadow);
 		VM_BUG_ON_PAGE(entry != folio, entry);
-		set_page_private(folio_page(folio, i), 0);
 		xas_next(&xas);
 	}
+	entry.val = 0;
+	folio_set_swap_entry(folio, entry);
 	folio_clear_swapcache(folio);
 	address_space->nrpages -= nr;
 	__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d46933adf789..bd9d904671b9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3369,7 +3369,7 @@ struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 
 struct swap_info_struct *page_swap_info(struct page *page)
 {
-	swp_entry_t entry = { .val = page_private(page) };
+	swp_entry_t entry = page_swap_entry(page);
 	return swp_swap_info(entry);
 }
 
@@ -3384,7 +3384,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
 
 pgoff_t __page_file_index(struct page *page)
 {
-	swp_entry_t swap = { .val = page_private(page) };
+	swp_entry_t swap = page_swap_entry(page);
 	return swp_offset(swap);
 }
 EXPORT_SYMBOL_GPL(__page_file_index);
-- 
2.41.0

