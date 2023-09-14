Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B7A79FD37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjINH3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:29:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E8AF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 00:29:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1751D21842;
        Thu, 14 Sep 2023 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694676549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDEA/X6zv4BDt+KQZpV3IhgSyRZdkJ8Xl7rT59OeU9o=;
        b=qM+agAQcoGoG66TpgqQ/00ummhfZFJjyuf9auoNoJBdRSwbshdxxMny+b4tGQo+9GbBrvq
        HdzViv3j84jNx4OTjcyHFXYZNLdytBXHbBYRAQNPxdpMgQtEeuwoKCtRGRiU0wV1Xn7A5m
        vqVTI1+AGw5VvPdVY6w25o9SxnRqQKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694676549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XDEA/X6zv4BDt+KQZpV3IhgSyRZdkJ8Xl7rT59OeU9o=;
        b=hSbb1oUopQsNq2T/IPs37CTwU5bzOKXgVp4nvlLlH4K2WW79N0gTtAmcCyZtrerenZYqsn
        6WRXb31jU8CWS9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E335E139DB;
        Thu, 14 Sep 2023 07:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0+XGNkS2AmUECwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 14 Sep 2023 07:29:08 +0000
Message-ID: <dbdece9a-9963-c425-f67f-01432ad5b271@suse.cz>
Date:   Thu, 14 Sep 2023 09:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] mm: page_alloc: remove pcppage migratetype caching
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-2-hannes@cmpxchg.org>
 <a389d846-c19a-42d3-6206-0a1c80e40b37@suse.cz>
 <20230912150320.GB3228@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230912150320.GB3228@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 17:03, Johannes Weiner wrote:
> On Tue, Sep 12, 2023 at 03:47:45PM +0200, Vlastimil Babka wrote:
>> I think after this change we should [...]
> 
> Speaking of follow-ups, AFAICS we no longer need those either:

Seems so, but the comments do talk about races, so once those are sorted out :)

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9cad31de1bf5..bea499fbca58 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1751,13 +1751,6 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>  
>  	old_block_type = get_pageblock_migratetype(page);
>  
> -	/*
> -	 * This can happen due to races and we want to prevent broken
> -	 * highatomic accounting.
> -	 */
> -	if (is_migrate_highatomic(old_block_type))
> -		goto single_page;
> -
>  	/* Take ownership for orders >= pageblock_order */
>  	if (current_order >= pageblock_order) {
>  		change_pageblock_range(page, current_order, start_type);
> @@ -1926,24 +1919,15 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  				continue;
>  
>  			/*
> -			 * In page freeing path, migratetype change is racy so
> -			 * we can counter several free pages in a pageblock
> -			 * in this loop although we changed the pageblock type
> -			 * from highatomic to ac->migratetype. So we should
> -			 * adjust the count once.
> +			 * It should never happen but changes to
> +			 * locking could inadvertently allow a per-cpu
> +			 * drain to add pages to MIGRATE_HIGHATOMIC
> +			 * while unreserving so be safe and watch for
> +			 * underflows.
>  			 */
> -			if (is_migrate_highatomic_page(page)) {
> -				/*
> -				 * It should never happen but changes to
> -				 * locking could inadvertently allow a per-cpu
> -				 * drain to add pages to MIGRATE_HIGHATOMIC
> -				 * while unreserving so be safe and watch for
> -				 * underflows.
> -				 */
> -				zone->nr_reserved_highatomic -= min(
> -						pageblock_nr_pages,
> -						zone->nr_reserved_highatomic);
> -			}
> +			zone->nr_reserved_highatomic -= min(
> +				pageblock_nr_pages,
> +				zone->nr_reserved_highatomic);
>  
>  			/*
>  			 * Convert to ac->migratetype and avoid the normal
> 
> I think they were only in place because we could change the highatomic
> status of pages on the pcplist, and those pages would then end up on
> some other freelist due to the stale pcppage cache.
> 
> I replaced them locally with WARNs and ran an hour or so of kernel
> builds under pressure. It didn't trigger. So I would send a follow up
> to remove them.
> 
> Unless you point me to a good reason why they're definitely still
> needed - in which case this is a moot proposal - but then we should
> make the comments more specific.

