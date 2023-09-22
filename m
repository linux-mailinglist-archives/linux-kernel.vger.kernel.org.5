Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C57ABA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjIVTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:46:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F00AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LJk+VfAgLq5Er8DOIN0yMWb5IfchGAilz48qexBmR74=; b=K/3YMhchXqHO+PC6JetrqrN8ga
        +1Ip2PdNgTvMh4vRTvOz/jcZF4UkmJ3nqzdu2lBGY5dDDo6beX0B7cOTr0La91OEUWpg5f5IjhGgA
        +lrgBf4LrnHAS5AeDT0VnyzHmSY6QeT34oX56mTws+3TT2cZpopOLBAmyug89SfytUfiSs66HjfF9
        EcOWUidfivMBdWkPKfxMHcK/e8pzV0REuSsOw+O46BKEYbasgkc3/B7xodPeLJ3mDvZdTQdgUUP65
        vs4hTgRRHWXEtxj1egkgHVPWGvjoXjTrOe5RfhxNVcA7Guv2qsd/RreW0BTTxHsPbbpb3r76hI0sK
        5BldWxEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjm6q-002WPC-Vq; Fri, 22 Sep 2023 19:46:41 +0000
Date:   Fri, 22 Sep 2023 20:46:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm/khugepaged: Convert
 __collapse_huge_page_isolate() to use folios
Message-ID: <ZQ3vIFWOTDFtJ0Wj@casper.infradead.org>
References: <20230922193639.10158-1-vishal.moola@gmail.com>
 <20230922193639.10158-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922193639.10158-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:36:38PM -0700, Vishal Moola (Oracle) wrote:
> This is in preparation for the removal of the khugepaged compound_pagelist.
> 
> Replaces 11 calls to compound_head() with 1, and removes 499 bytes of
> kernel text.

Looks good to me.

> @@ -634,32 +633,33 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		 * Isolate the page to avoid collapsing an hugepage
>  		 * currently in use by the VM.
>  		 */
> -		if (!isolate_lru_page(page)) {
> -			unlock_page(page);
> +		if (!folio_isolate_lru(folio)) {
> +			folio_unlock(folio);
>  			result = SCAN_DEL_PAGE_LRU;
>  			goto out;
>  		}
> -		mod_node_page_state(page_pgdat(page),
> -				NR_ISOLATED_ANON + page_is_file_lru(page),
> -				compound_nr(page));
> -		VM_BUG_ON_PAGE(!PageLocked(page), page);
> -		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		node_stat_mod_folio(folio,
> +				NR_ISOLATED_ANON + folio_is_file_lru(folio),
> +				folio_nr_pages(folio));
> +		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> +		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>  
> -		if (PageCompound(page))
> -			list_add_tail(&page->lru, compound_pagelist);
> +		if (folio_test_large(folio))
> +			list_add_tail(&folio->lru, compound_pagelist);
>  next:
>  		/*
>  		 * If collapse was initiated by khugepaged, check that there is
>  		 * enough young pte to justify collapsing the page
>  		 */
>  		if (cc->is_khugepaged &&
> -		    (pte_young(pteval) || page_is_young(page) ||
> -		     PageReferenced(page) || mmu_notifier_test_young(vma->vm_mm,
> +		    (pte_young(pteval) || folio_test_young(folio) ||
> +		     folio_test_referenced(folio) || mmu_notifier_test_young(vma->vm_mm,
>  								     address)))
>  			referenced++;
>  
>  		if (pte_write(pteval))
>  			writable = true;
> +

Spurious change here.  Other than that,

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
