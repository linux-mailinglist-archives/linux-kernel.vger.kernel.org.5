Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD481792AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjIEQpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354099AbjIEJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:37:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E21A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52A141F74D;
        Tue,  5 Sep 2023 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693906651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgzA2lkGR7u9l38VxfCRahVcWaK6R2rDt/8GaK7WDyY=;
        b=fLO/cA3Q41goLiXCtiWpMCNqpPoUbpG74GhGUMBole12sj9+OHoTrvQ8FhAmNGddh1MInY
        7u7PO7jJ0FSu5cWxQ//jTrT7ScpvFeZJAwJNUWQguwGDX6CWTk11XXV2yjdFyajCAc5zZh
        rgJkccwlq213/iygP5NcEeYzzU0jd4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693906651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgzA2lkGR7u9l38VxfCRahVcWaK6R2rDt/8GaK7WDyY=;
        b=cTTm2fRdVBhqKaHX/O1EvhxZYdYT3wKoglxZQvpY21cYFrLJDbWZhy3GwNtilDhUAABtb3
        vc38Tyi5ZNzHpFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2450513911;
        Tue,  5 Sep 2023 09:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4khQCNv29mQdNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Sep 2023 09:37:31 +0000
Message-ID: <bf16a7ea-22db-700b-7194-c4fa1d943baa@suse.cz>
Date:   Tue, 5 Sep 2023 11:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue
 fallback
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nsaenzju@redhat.com, yj.chiang@mediatek.com,
        Mark-pk Tsai <mark-pk.tsai@mediatek.com>,
        Joe Liu <joe.liu@mediatek.com>
References: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
 <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 11:09, Mel Gorman wrote:
> On Wed, Aug 30, 2023 at 07:13:33PM +0800, Lecopzer Chen wrote:
>> commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a
>> spinlock") fallback freeing page to free_one_page() if pcp trylock
>> failed. This make MIGRATE_CMA be able to fallback and be stolen
>> whole pageblock by MIGRATE_UNMOVABLE in the page allocation.
>> 
>> PCP free is fine because free_pcppages_bulk() will always get
>> migratetype again before freeing the page, thus this only happen when
>> someone tried to put CMA page in to other MIGRATE_TYPE's freelist.
>> 
>> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
>> Reported-by: Joe Liu <joe.liu@mediatek.com>
>> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
>> Cc: Mark-pk Tsai <mark-pk.tsai@mediatek.com>
>> Cc: Joe Liu <joe.liu@mediatek.com>
> 
> Sorry for the long delay and thanks Lecopzer for the patch.
> 
> This changelog is difficult to parse but the fix may also me too specific
> and could be more robust against types other than CMA. It is true that
> a failed PCP acquire may return a !is_migrate_isolate page to the wrong
> list but it's more straight-forward to unconditionally lookup the PCP
> migratetype of the spinlock is not acquired.
> 
> How about this? It unconditionally looks up the PCP migratetype after
> spinlock contention. It's build tested only
> 
> --8<--
> mm: page_alloc: Free pages to correct buddy list after PCP lock contention
> 
> Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> returns pages to the buddy list on PCP lock contention. However, for
> migratetypes that are not MIGRATE_PCPTYPES, the migratetype may have
> been clobbered already for pages that are not being isolated. In
> practice, this means that CMA pages may be returned to the wrong
> buddy list. While this might be harmless in some cases as it is
> MIGRATE_MOVABLE, the pageblock could be reassigned in rmqueue_fallback
> and prevent a future CMA allocation. Lookup the PCP migratetype
> against unconditionally if the PCP lock is contended.
> 
> [lecopzer.chen@mediatek.com: CMA-specific fix]
> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")

I think we should Cc: stable for the sake of 6.1 LTS?

> Reported-by: Joe Liu <joe.liu@mediatek.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 452459836b71..4053c377fee8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2428,7 +2428,13 @@ void free_unref_page(struct page *page, unsigned int order)
>  		free_unref_page_commit(zone, pcp, page, migratetype, order);
>  		pcp_spin_unlock(pcp);
>  	} else {
> -		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
> +		/*
> +		 * The page migratetype may have been clobbered for types
> +		 * (type >= MIGRATE_PCPTYPES && !is_migrate_isolate) so
> +		 * must be rechecked.
> +		 */
> +		free_one_page(zone, page, pfn, order,
> +			      get_pcppage_migratetype(page), FPI_NONE);
>  	}
>  	pcp_trylock_finish(UP_flags);
>  }

