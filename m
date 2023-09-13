Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181279E42F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbjIMJw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239500AbjIMJwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:52:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B974819B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:52:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7427C21886;
        Wed, 13 Sep 2023 09:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694598727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLF6GZwuLdJAYewv2K0H7ivS3KZGBykkISQrVkKlD0c=;
        b=hStFLr33s9zHIjhsYNxqafNInd6wpqArRszU0xS0nKPvzhnB/j+9WNFSywlw6II7CgAqL2
        /YsNDTghRTb7mkR3ARpjBv4iTIE+XEu4YR63O4gntyONvs3kNKiT0kLlDOkylYQMdE5IBk
        JtqZ+kFK44Mty1mPIqfzJwf3yrFQbnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694598727;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLF6GZwuLdJAYewv2K0H7ivS3KZGBykkISQrVkKlD0c=;
        b=hZ+qFD8APWzAAl/cEAe3jFyMAI33bNaz0/65aTq24WsCbXZB1nsepSJwt18bd7G2e4sz32
        dEbYbZY/0DNDHUDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 596F113582;
        Wed, 13 Sep 2023 09:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HCxBFUeGAWV+UQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 09:52:07 +0000
Message-ID: <65752939-3fc6-200e-24ba-0df9aee7c521@suse.cz>
Date:   Wed, 13 Sep 2023 11:52:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/6] mm: page_alloc: fix up block types when merging
 compatible blocks
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-3-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230911195023.247694-3-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:41, Johannes Weiner wrote:
> The buddy allocator coalesces compatible blocks during freeing, but it
> doesn't update the types of the subblocks to match. When an allocation
> later breaks the chunk down again, its pieces will be put on freelists
> of the wrong type. This encourages incompatible page mixing (ask for
> one type, get another), and thus long-term fragmentation.

Yeah why not. Sould be pretty rare as this only affects >=pageblock_order,
but then also the overhead in the otherwise hot function is limited to its
colder part.

> Update the subblocks when merging a larger chunk, such that a later
> expand() will maintain freelist type hygiene.
> 
> v2:
> - remove spurious change_pageblock_range() move (Zi Yan)
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e3f1c777feed..3db405414174 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -783,10 +783,17 @@ static inline void __free_one_page(struct page *page,
>  			 */
>  			int buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
>  
> -			if (migratetype != buddy_mt
> -					&& (!migratetype_is_mergeable(migratetype) ||
> -						!migratetype_is_mergeable(buddy_mt)))
> -				goto done_merging;
> +			if (migratetype != buddy_mt) {
> +				if (!migratetype_is_mergeable(migratetype) ||
> +				    !migratetype_is_mergeable(buddy_mt))
> +					goto done_merging;
> +				/*
> +				 * Match buddy type. This ensures that
> +				 * an expand() down the line puts the
> +				 * sub-blocks on the right freelists.
> +				 */
> +				set_pageblock_migratetype(buddy, migratetype);
> +			}
>  		}
>  
>  		/*

