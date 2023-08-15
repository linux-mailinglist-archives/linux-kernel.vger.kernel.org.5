Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BF77D148
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbjHORqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbjHORpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE91BDB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FD056311D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85167C433C8;
        Tue, 15 Aug 2023 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692121529;
        bh=cQQOsmSmkcdwqO0nuWMTDvqAksn3FxogI+D4roU8Hxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJm+L8gqxK/LkIh7FMi4ywq79rfw3MsfU3ClEx/uzthZ/xmYUKmsEYazIVOrRi6AN
         zdOrhpS8V8+8tpp/kdx9Uz/REwnJm31tJM7/tHvKK9CL9BgEum1JfM73w0riSwWySO
         XdBglHwmgUeOxuXuMCf7IrcTyxu+5eUludkW6GOGEqYenklJvPaerjqtMdU/h2WFOX
         1k6/MmIUCIxtBux/IAIeSc/NO0Epzk+pSAyRDxhWo25min6uFnsRvlsiJ0CLrlZUor
         LnbNXPgoClUbda0sIoeuWTPSnqevBiULAejL0zBLaqQaQdKjNPc6pAhGHDv6Q47lFA
         j15W9MbSLQN/g==
Date:   Tue, 15 Aug 2023 10:45:28 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Subject: Re: [PATCH 1/2] mm/page_alloc: remove track of active PCP lists
 range in bulk free
Message-ID: <ZNu5uHhYI4QxR4au@google.com>
References: <20230809100754.3094517-1-shikemeng@huaweicloud.com>
 <20230809100754.3094517-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809100754.3094517-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kemeng,

Can you confirm this patch has no intended functional change?

I have a patch sitting in my tree for a while related to this
count vs pcp->count.  The BPF function hook can potentially change
pcp->count and make count out of sync with pcp->count which causes
a dead loop.

Maybe I can send my out alone side with yours for discussion?
I don't mind my patch combined with yours.

Your change looks fine to me. There is more can be done
on the clean up.

Chris

On Wed, Aug 09, 2023 at 06:07:53PM +0800, Kemeng Shi wrote:
> After commit fd56eef258a17 ("mm/page_alloc: simplify how many pages are
> selected per pcp list during bulk free"), we will drain all pages in
> selected pcp list. And we ensured passed count is < pcp->count. Then,
> the search will finish before wrap-around and track of active PCP lists
> range intended for wrap-around case is no longer needed.

> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/page_alloc.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 96b7c1a7d1f2..1ddcb2707d05 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1207,8 +1207,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  					int pindex)
>  {
>  	unsigned long flags;
> -	int min_pindex = 0;
> -	int max_pindex = NR_PCP_LISTS - 1;
>  	unsigned int order;
>  	bool isolated_pageblocks;
>  	struct page *page;
> @@ -1231,17 +1229,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  
>  		/* Remove pages from lists in a round-robin fashion. */
>  		do {
> -			if (++pindex > max_pindex)
> -				pindex = min_pindex;
> +			if (++pindex > NR_PCP_LISTS - 1)
> +				pindex = 0;
>  			list = &pcp->lists[pindex];
> -			if (!list_empty(list))
> -				break;
> -
> -			if (pindex == max_pindex)
> -				max_pindex--;
> -			if (pindex == min_pindex)
> -				min_pindex++;
> -		} while (1);
> +		} while (list_empty(list));
>  
>  		order = pindex_to_order(pindex);
>  		nr_pages = 1 << order;
> -- 
> 2.30.0
> 
