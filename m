Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5BA7AEB88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjIZLeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIZLeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:34:17 -0400
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523F10C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:34:10 -0700 (PDT)
Date:   Tue, 26 Sep 2023 20:34:00 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695728049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V1Lv5ygjIdfYcg2pYP2e94liPI9xdNlRrRgi5N60Glk=;
        b=unSpPMfA6OzGbEBKAz9P2uMNnIfzrNqXyWbyjum1Zld4KNv2bPBzS42xsTyWdIzU2P4Khu
        ukdYtfCX3N6fRihn4osw927C/lWXcvBPaqHiuBTuvZHlU6qi6dv8p/iurRU3RHZ1I+Hf2k
        Fww53fDaGvdaxZdj+s+DUMngnu5rWDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        naoya.horiguchi@nec.com, osalvador@suse.de
Subject: Re: [PATCH v2 2/3] mm/page_alloc: remove unnecessary check in
 break_down_buddy_pages
Message-ID: <20230926113400.GB1539169@ik1-406-35019.vs.sakura.ne.jp>
References: <20230826154745.4019371-1-shikemeng@huaweicloud.com>
 <20230826154745.4019371-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230826154745.4019371-3-shikemeng@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:47:44PM +0800, Kemeng Shi wrote:
> 1. We always have target in range started with next_page and full free
> range started with current_buddy.
> 2. The last splited range size is 1 << low and low should be >= 0, then

s/splited/split/

> size >= 1, then page + size and page will not interleave.

I'm not sure the meaning of "interleave" here, maybe simply meaning
"page + size != page is always true (because size > 0)".

> As summary, current_page will not equal to target page.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

But I agree with the summary. So with updating description...

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
>  mm/page_alloc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 88c5f5aea9b0..bb74b40dc195 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6510,10 +6510,8 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>  		if (set_page_guard(zone, current_buddy, high, migratetype))
>  			continue;
>  
> -		if (current_buddy != target) {
> -			add_to_free_list(current_buddy, zone, high, migratetype);
> -			set_buddy_order(current_buddy, high);
> -		}
> +		add_to_free_list(current_buddy, zone, high, migratetype);
> +		set_buddy_order(current_buddy, high);
>  	}
>  }
>  
> -- 
> 2.30.0
> 
> 
> 
