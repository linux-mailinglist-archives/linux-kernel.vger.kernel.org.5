Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4543F7AEB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjIZLeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjIZLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:34:34 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEABE9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:34:27 -0700 (PDT)
Date:   Tue, 26 Sep 2023 20:34:17 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695728064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kv/5WOx9N5B1dqruu3Q4PkYxR2DInkjefc4aFtr6og4=;
        b=Qrx/QnkZQGfXIkhBZBe6eDBSBCXWexz182W9bgLDO1MX45X2k526Da5Cfs04sx+iIILAUH
        DtklC93OrDBMufIRyggeoZrh/sUcf/gtN2mPvHnCD6Fo969lE3RNK/rO0jjOl2JjZyqnrD
        fwQfDzdagGFqRgk2lbTrLwOrQcm2YZ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Subject: Re: [PATCH v2 3/3] mm/page_alloc: remove unnecessary next_page in
 break_down_buddy_pages
Message-ID: <20230926113417.GC1539169@ik1-406-35019.vs.sakura.ne.jp>
References: <20230826154745.4019371-1-shikemeng@huaweicloud.com>
 <20230826154745.4019371-4-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230826154745.4019371-4-shikemeng@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:47:45PM +0800, Kemeng Shi wrote:
> The next_page is only used to forward page in case target is in second
> harf range. Move forward page directly to remove unnecessary next_page.

s/harf/half/

> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
>  mm/page_alloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bb74b40dc195..1c35ee022dde 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6492,20 +6492,18 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>  				   int migratetype)
>  {
>  	unsigned long size = 1 << high;
> -	struct page *current_buddy, *next_page;
> +	struct page *current_buddy;
>  
>  	while (high > low) {
>  		high--;
>  		size >>= 1;
>  
>  		if (target >= &page[size]) {
> -			next_page = page + size;
>  			current_buddy = page;
> +			page = page + size;
>  		} else {
> -			next_page = page;
>  			current_buddy = page + size;
>  		}
> -		page = next_page;
>  
>  		if (set_page_guard(zone, current_buddy, high, migratetype))
>  			continue;
> -- 
> 2.30.0
> 
> 
> 
