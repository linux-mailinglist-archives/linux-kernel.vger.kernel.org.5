Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE99E77E703
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbjHPQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbjHPQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2C26A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692204818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nP1yvcFoUSjocobGMT8TsvesAgsQPHKxOU/GCOmoPFY=;
        b=Z5dp7rs8A1XrMV58N69zOOBPApYPv3WUyAplKXQIDm0GykobnjR2h2UcmurvYUJgzydOAB
        PA/2o1UGi68bfXAY9k/ktPwLNs1H0fa7heEohm1dIbGyZ1wHRwyxOwRLtHhK7FfwulcXe4
        3vsSy3D29/CdmHsnms5V6rQ+8lQ91pw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-P7NenyvBNSG7yG1WYyZ2dA-1; Wed, 16 Aug 2023 12:53:36 -0400
X-MC-Unique: P7NenyvBNSG7yG1WYyZ2dA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a797c82fb2so2443640b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692204816; x=1692809616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP1yvcFoUSjocobGMT8TsvesAgsQPHKxOU/GCOmoPFY=;
        b=T3MdSi3dgK/ADTkDE3MaEOfgkpKqVKf3HQNMb1qWqnn9Z2ov2BCs722qsi7hebcx8H
         Y39O3vrCpkFKLT1zUDrfKjOU3jgexWzS/Jk+5zpFnbPQMzv7NlzCq6Dsmfx9LdumgUU7
         VlGDVrhN7z/8mLfnSN6klejRPFkcfiHsaI/Y4sD8PnSeveG61IUN0Vv4a7Yt8bSUgTGP
         S5iX4WsmeW+gcZurzCi0XPuvVm1NIV+qIWxfRCl5CeBksBEE/LFZAU6Wn5z/Yw9+F+WE
         j2Uj43pr57IDzTqYFKSilCDcA1m/7MSza5/YA/NXk41Xc7tqjqxfHkZaihjWwfEOpNu4
         g81w==
X-Gm-Message-State: AOJu0YyaFq3swccAur0F5DSoV8BBhS8xO65JHUwEAgxnER8rMuocerjG
        EYj8JBNoIhkLmq19x9pNeqDBLVTjgHYS2SJ2nX9ZJVsI7221K+BCoK/5AjXr+vdSTnA/d9LPvhg
        xIzszwAA5A0IWMAW5CXi4sMsB
X-Received: by 2002:a05:6359:b8f:b0:137:7bde:6a26 with SMTP id gf15-20020a0563590b8f00b001377bde6a26mr1706621rwb.0.1692204816030;
        Wed, 16 Aug 2023 09:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQX90X51+YkqxGKzp1b1N2RwseMinAHdfFxTFyt2dvJI3iPopyAH+YSTynq5xv4sEeScXiqA==
X-Received: by 2002:a05:6359:b8f:b0:137:7bde:6a26 with SMTP id gf15-20020a0563590b8f00b001377bde6a26mr1706604rwb.0.1692204815698;
        Wed, 16 Aug 2023 09:53:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id bb6-20020a05622a1b0600b00403bf34266csm4610050qtb.30.2023.08.16.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:53:35 -0700 (PDT)
Date:   Wed, 16 Aug 2023 12:53:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH RFC v3] mm: Proper document tail pages fields for folio
Message-ID: <ZNz/DtyWS1ol8xAY@x1n>
References: <20230815212547.431693-1-peterx@redhat.com>
 <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b887e764-ffa3-55ee-3c44-69cb15f8a115@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:33:30PM +0200, David Hildenbrand wrote:
> On 15.08.23 23:25, Peter Xu wrote:
> > Tail page struct reuse is over-comlicated.  Not only because we have
> 
> It is complicated, agreed.
> 
> With the ->private for THP_SWAP gone, we would have to document less.
> Stating that 4*4byte / 4*8 byte are available after flags+head would
> be sufficient and I'd even drop the table.
> 
> 
> > implicit uses of tail page fields (mapcounts, or private for thp swap
> > support, etc., that we may still use in the page structs,
> 
> Instead of documenting that thp swap should no longer touch the private
> field of tail pages, maybe we can indeed fix that quite easily.
> 
> My simple tests passed so far. If there isn't something obvious missing,
> I can do more testing and send this as an official patch.

It'll be definitely good to fix it rather than document if possible.

Nothing wrong I spot quickly, you may just need a more complete cc list for
swap. One trivial comment below.

> 
> 
> From ec0f8b0dd8fb81c316b6a4c5fc9ae7563e625404 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 16 Aug 2023 13:14:45 +0200
> Subject: [PATCH] mm/swap: stop using page->private on tail pages for THP_SWAP
> 
> Let's stop using page->private on tail pages, making it possible to
> just unconditionally reuse that field in the tail pages of large folios.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/mm/mteswap.c |  5 +++--
>  include/linux/swap.h    |  9 +++++++++
>  mm/huge_memory.c        | 15 ++++++---------
>  mm/memory.c             |  2 +-
>  mm/rmap.c               |  2 +-
>  mm/swap_state.c         |  4 ++--
>  mm/swapfile.c           |  4 ++--
>  7 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index cd508ba80ab1..a31833e3ddc5 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -33,8 +33,9 @@ int mte_save_tags(struct page *page)
>  	mte_save_page_tags(page_address(page), tag_storage);
> -	/* page_private contains the swap entry.val set in do_swap_page */
> -	ret = xa_store(&mte_pages, page_private(page), tag_storage, GFP_KERNEL);
> +	/* lookup the swap entry.val from the page */
> +	ret = xa_store(&mte_pages, page_swap_entry(page).val, tag_storage,
> +		       GFP_KERNEL);
>  	if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
>  		mte_free_tag_storage(tag_storage);
>  		return xa_err(ret);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bb5adc604144..84fe0e94f5cd 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -339,6 +339,15 @@ static inline swp_entry_t folio_swap_entry(struct folio *folio)
>  	return entry;
>  }
> +static inline swp_entry_t page_swap_entry(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	swp_entry_t entry = folio_swap_entry(folio);
> +
> +	entry.val += page - &folio->page;
> +	return entry;
> +}
> +
>  static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
>  {
>  	folio->private = (void *)entry.val;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0b709d2c46c6..f7e04cbcb063 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2451,18 +2451,15 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  	page_tail->index = head->index + tail;
>  	/*
> -	 * page->private should not be set in tail pages with the exception
> -	 * of swap cache pages that store the swp_entry_t in tail pages.
> -	 * Fix up and warn once if private is unexpectedly set.
> -	 *
> -	 * What of 32-bit systems, on which folio->_pincount overlays
> -	 * head[1].private?  No problem: THP_SWAP is not enabled on 32-bit, and
> -	 * pincount must be 0 for folio_ref_freeze() to have succeeded.
> +	 * page->private should not be set in tail pages. Fix up and warn once
> +	 * if private is unexpectedly set.
>  	 */
> -	if (!folio_test_swapcache(page_folio(head))) {
> -		VM_WARN_ON_ONCE_PAGE(page_tail->private != 0, page_tail);
> +	if (unlikely(page_tail->private)) {
> +		VM_WARN_ON_ONCE_PAGE(true, page_tail);
>  		page_tail->private = 0;
>  	}
> +	if (PageSwapCache(head))
> +		set_page_private(page_tail, (unsigned long)head->private + tail);
>  	/* Page flags must be visible before we make the page non-compound. */
>  	smp_wmb();
> diff --git a/mm/memory.c b/mm/memory.c
> index d003076b218d..ff13242c1589 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3882,7 +3882,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		 * changed.
>  		 */
>  		if (unlikely(!folio_test_swapcache(folio) ||
> -			     page_private(page) != entry.val))
> +			     page_swap_entry(page).val != entry.val))
>  			goto out_page;
>  		/*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1f04debdc87a..ec7f8e6c9e48 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1647,7 +1647,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  			dec_mm_counter(mm, mm_counter(&folio->page));
>  		} else if (folio_test_anon(folio)) {
> -			swp_entry_t entry = { .val = page_private(subpage) };
> +			swp_entry_t entry = page_swap_entry(subpage);
>  			pte_t swp_pte;
>  			/*
>  			 * Store the swap location in the pte.
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 01f15139b7d9..450819934e34 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -100,6 +100,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
>  	folio_ref_add(folio, nr);
>  	folio_set_swapcache(folio);
> +	folio_set_swap_entry(folio, entry);
>  	do {
>  		xas_lock_irq(&xas);
> @@ -113,7 +114,6 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
>  				if (shadowp)
>  					*shadowp = old;
>  			}
> -			set_page_private(folio_page(folio, i), entry.val + i);
>  			xas_store(&xas, folio);
>  			xas_next(&xas);
>  		}
> @@ -154,9 +154,9 @@ void __delete_from_swap_cache(struct folio *folio,
>  	for (i = 0; i < nr; i++) {
>  		void *entry = xas_store(&xas, shadow);
>  		VM_BUG_ON_PAGE(entry != folio, entry);
> -		set_page_private(folio_page(folio, i), 0);
>  		xas_next(&xas);
>  	}
> +	folio->private = 0;

I'd rather remove all direct reference to "private" for swap alongside, if
this would be the last spot (perhaps folio_set_swap_entry()).

>  	folio_clear_swapcache(folio);
>  	address_space->nrpages -= nr;
>  	__node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d46933adf789..bd9d904671b9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3369,7 +3369,7 @@ struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  struct swap_info_struct *page_swap_info(struct page *page)
>  {
> -	swp_entry_t entry = { .val = page_private(page) };
> +	swp_entry_t entry = page_swap_entry(page);
>  	return swp_swap_info(entry);
>  }
> @@ -3384,7 +3384,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
>  pgoff_t __page_file_index(struct page *page)
>  {
> -	swp_entry_t swap = { .val = page_private(page) };
> +	swp_entry_t swap = page_swap_entry(page);
>  	return swp_offset(swap);
>  }
>  EXPORT_SYMBOL_GPL(__page_file_index);
> -- 
> 2.41.0
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu

