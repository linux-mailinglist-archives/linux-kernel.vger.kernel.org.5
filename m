Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15C177E2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbjHPNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbjHPNeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:34:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D349E123
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692192815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sa0+x7EXRi4IXTjVM59CpmyQzx6tOI8j4jqQQJalqrw=;
        b=c1DlE0+KGDHAhEmM8N7LoWG+/8FjLxlcErXnnrLMGiYyyB08fuDdQ0791ZBFmpJWypmk2w
        V/CtSEE7oe1eGt6wAnGRPFXWQmMLzOhyrNSmZyaSYXeck3bNx7PndK/AzyyMzI/CwOv2RR
        m27grtfLKKMtrqZJ+ADT8rNB24oByPA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-kJjlMdEhNbmqVq7pER1EUA-1; Wed, 16 Aug 2023 09:33:34 -0400
X-MC-Unique: kJjlMdEhNbmqVq7pER1EUA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe1cdf2024so40144095e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192813; x=1692797613;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sa0+x7EXRi4IXTjVM59CpmyQzx6tOI8j4jqQQJalqrw=;
        b=DJD1w6mnvd2H8dYfqXURqQCOes+9SFLLRZ+77XFXGP35eja3avs5SIi/76uq9lRQ6/
         sLYdgH3o2cUE7XkZw3ysnpa0CJG45SCTano+40QX2xZokGWbysPGMY8Ty2vg0XYVW2pI
         MoPqmqGCKldvnc0OFDvb4wPeJTu6t/5gwbp3n86QvCSuCs+TuJdcejJUF4AiX9CSQQgE
         YT7nNiIuVlkOjlOTZi8jZ+EtqSSgRp3d5nKNew77RJu4to77EDWi8ZkHeLJlA7qfr1rh
         yWCj5JvXDsOLNRlPWfgmjQwW5TsaUuNwIET2WapLq+Wq6nfBtwgValnqUTYM+E13cO3p
         k9pQ==
X-Gm-Message-State: AOJu0YwnLwwjUOHo5JWmfXCCU6+Cs81bwhIS2e1zu4PJ1uLWu6ZCBYQK
        O0UCphnW4eApRwbN/SR1iwW5lcYnZEiThBeTZw2l6yaZbMFwKztwg/KJ9CADv3zl1DjYA/OUjbO
        D0pQKYI1Zf373EUMEJ6Xf6KWq
X-Received: by 2002:a05:600c:3784:b0:3fb:dbd0:a7ea with SMTP id o4-20020a05600c378400b003fbdbd0a7eamr1465990wmr.37.1692192813396;
        Wed, 16 Aug 2023 06:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjNJST7TXDwcOWPe2Ad/HweRVZ3L40JuHAZHXd+y6Yqt71pQM3nkvyNCJOZx/ehNZO6aLqqw==
X-Received: by 2002:a05:600c:3784:b0:3fb:dbd0:a7ea with SMTP id o4-20020a05600c378400b003fbdbd0a7eamr1465966wmr.37.1692192812977;
        Wed, 16 Aug 2023 06:33:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:8b00:5520:fa3c:c527:592f? (p200300cbc74b8b005520fa3cc527592f.dip0.t-ipconnect.de. [2003:cb:c74b:8b00:5520:fa3c:c527:592f])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c290900b003fe539b83f2sm24286719wmd.42.2023.08.16.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 06:33:32 -0700 (PDT)
Message-ID: <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
Date:   Wed, 16 Aug 2023 15:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
References: <20230815212547.431693-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
In-Reply-To: <20230815212547.431693-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.23 23:25, Peter Xu wrote:
> Tail page struct reuse is over-comlicated.  Not only because we have

It is complicated, agreed.

With the ->private for THP_SWAP gone, we would have to document less.
Stating that 4*4byte / 4*8 byte are available after flags+head would
be sufficient and I'd even drop the table.


> implicit uses of tail page fields (mapcounts, or private for thp swap
> support, etc., that we may still use in the page structs, 

Instead of documenting that thp swap should no longer touch the private
field of tail pages, maybe we can indeed fix that quite easily.

My simple tests passed so far. If there isn't something obvious missing,
I can do more testing and send this as an official patch.


 From ec0f8b0dd8fb81c316b6a4c5fc9ae7563e625404 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 16 Aug 2023 13:14:45 +0200
Subject: [PATCH] mm/swap: stop using page->private on tail pages for THP_SWAP

Let's stop using page->private on tail pages, making it possible to
just unconditionally reuse that field in the tail pages of large folios.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  arch/arm64/mm/mteswap.c |  5 +++--
  include/linux/swap.h    |  9 +++++++++
  mm/huge_memory.c        | 15 ++++++---------
  mm/memory.c             |  2 +-
  mm/rmap.c               |  2 +-
  mm/swap_state.c         |  4 ++--
  mm/swapfile.c           |  4 ++--
  7 files changed, 24 insertions(+), 17 deletions(-)

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
index 0b709d2c46c6..f7e04cbcb063 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2451,18 +2451,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
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
index 01f15139b7d9..450819934e34 100644
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
@@ -154,9 +154,9 @@ void __delete_from_swap_cache(struct folio *folio,
  	for (i = 0; i < nr; i++) {
  		void *entry = xas_store(&xas, shadow);
  		VM_BUG_ON_PAGE(entry != folio, entry);
-		set_page_private(folio_page(folio, i), 0);
  		xas_next(&xas);
  	}
+	folio->private = 0;
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


-- 
Cheers,

David / dhildenb

