Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F379F262
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjIMTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:52:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C1B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:52:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03BAF218E3;
        Wed, 13 Sep 2023 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694634738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lN7bSKVF5Ye4MzDY2kf7YVJd7wa8KQ9puGZkU8cNug=;
        b=tfquWEGbNzaMBuutCxOGon4c6Z4Z11vxMfYQGdhjLgyCbwC9kFZ8RrIKmZjOLWe8yrrGje
        58QY9l/1fsW4YUXkKU2ySYBxweNWko2KKDHjxpLXdWSSWiOz11XwOhcNlVMyOwcVWbekKr
        Ubip/TpNiYAWFGAx1QL7TW29WE4wjVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694634738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lN7bSKVF5Ye4MzDY2kf7YVJd7wa8KQ9puGZkU8cNug=;
        b=zU+u4kIJebrTdhHmOFo9DkQOHnLA6gK6lkd/jxL5PDvs4PIp1nZaY8COsu9AY9nqpQjJDD
        8BTbhk7+tVe4JkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6C8813440;
        Wed, 13 Sep 2023 19:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dQi8M/ESAmUhdwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 19:52:17 +0000
Message-ID: <5911bf29-b2a0-9016-7071-68334e7d680d@suse.cz>
Date:   Wed, 13 Sep 2023 21:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] mm: page_alloc: fix freelist movement during block
 conversion
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-6-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230911195023.247694-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:41, Johannes Weiner wrote:
> Currently, page block type conversion during fallbacks, atomic
> reservations and isolation can strand various amounts of free pages on
> incorrect freelists.
> 
> For example, fallback stealing moves free pages in the block to the
> new type's freelists, but then may not actually claim the block for
> that type if there aren't enough compatible pages already allocated.
> 
> In all cases, free page moving might fail if the block straddles more
> than one zone, in which case no free pages are moved at all, but the
> block type is changed anyway.
> 
> This is detrimental to type hygiene on the freelists. It encourages
> incompatible page mixing down the line (ask for one type, get another)
> and thus contributes to long-term fragmentation.
> 
> Split the process into a proper transaction: check first if conversion
> will happen, then try to move the free pages, and only if that was
> successful convert the block to the new type.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

<snip>

> @@ -1638,26 +1629,62 @@ static int move_freepages(struct zone *zone,
>  	return pages_moved;
>  }
>  
> -int move_freepages_block(struct zone *zone, struct page *page,
> -				int migratetype, int *num_movable)
> +static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> +				      unsigned long *start_pfn,
> +				      unsigned long *end_pfn,
> +				      int *num_free, int *num_movable)
>  {
> -	unsigned long start_pfn, end_pfn, pfn;
> -
> -	if (num_movable)
> -		*num_movable = 0;
> +	unsigned long pfn, start, end;
>  
>  	pfn = page_to_pfn(page);
> -	start_pfn = pageblock_start_pfn(pfn);
> -	end_pfn = pageblock_end_pfn(pfn) - 1;
> +	start = pageblock_start_pfn(pfn);
> +	end = pageblock_end_pfn(pfn) - 1;

>  	/* Do not cross zone boundaries */
> -	if (!zone_spans_pfn(zone, start_pfn))
> -		start_pfn = zone->zone_start_pfn;
> -	if (!zone_spans_pfn(zone, end_pfn))
> -		return 0;
> +	if (!zone_spans_pfn(zone, start))
> +		start = zone->zone_start_pfn;
> +	if (!zone_spans_pfn(zone, end))
> +		return false;

This brings me back to my previous suggestion - if we update the end, won't
the whole "block straddles >1 zones" situation to check for go away?

Hm or is it actually done because we have a problem by representing
pageblock migratetype with multiple zones, since there's a single
pageblock_bitmap entry per the respective pageblock range of pfn's, so one
zone's migratetype could mess with other's? And now it matters if we want
100% match of freelist vs pageblock migratetype?
(I think even before this series it could have mattered for
MIGRATETYPE_ISOLATE, is it broken in those corner cases?)

But in that case we might not be detecting the situation properly for the
later of the two zones in a pageblock, because if start_pfn is not spanned
we adjust it and continue? Hmm...


