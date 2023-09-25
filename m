Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7743C7ADB05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjIYPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjIYPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:10:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0E197
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C99C433C7;
        Mon, 25 Sep 2023 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695654644;
        bh=RSzIWUOnE7T8XNeVBMrB6XLnBz1gFcQH4H/BZEvdBF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r+oxEIY58+50ytAKbsVPV0M2wse/nGBiBuuL5gcaM9mUUq7mqFXP7UPdZd0BkYs8h
         I+MIOej3TQU05+ddc47d8Joo9ZsnGYZ2fmXKUhjhM5DLrab+9YhUjJU3M+ZahA6Zdv
         15ZV9Skb0m37hBV8ibemCTIIGMllW5UTHktJ5KOo=
Date:   Mon, 25 Sep 2023 08:10:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     rppt@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: pass page count and reserved to
 __init_single_page
Message-Id: <20230925081043.b4256d18f150e54ee7cb9c99@linux-foundation.org>
In-Reply-To: <20230925072150.386880-2-yajun.deng@linux.dev>
References: <20230925072150.386880-1-yajun.deng@linux.dev>
        <20230925072150.386880-2-yajun.deng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 15:21:49 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> When we init a single page, we need to mark this page reserved if it
> does. And some pages may not need to set page count, such as compound
> pages.
> 
> Introduce INIT_PAGE_COUNT and INIT_PAGE_RESERVED, let the caller
> decide if it needs to set page count and mark page reserved or not.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3196,7 +3196,7 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
>  	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_single_page(page, pfn, zone, nid);
> +		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>  		prep_compound_tail((struct page *)folio, pfn - head_pfn);
>  		ret = page_ref_freeze(page, 1);
>  		VM_BUG_ON(!ret);
> diff --git a/mm/internal.h b/mm/internal.h
> index 7a961d12b088..e9366cce461c 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1209,8 +1209,14 @@ struct vma_prepare {
>  	struct vm_area_struct *remove2;
>  };
>  
> +enum {
> +	INIT_PAGE_COUNT    = (1 << 0),
> +	INIT_PAGE_RESERVED = (1 << 1),
> +};

It would be neater to give this enum a name

>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> -				unsigned long zone, int nid);
> +				  unsigned long zone, int nid,
> +				  unsigned int flags);

Then use this enum for `flags'.


