Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184EF79EB46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbjIMOkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMOky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:40:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4D190
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:40:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC2961F390;
        Wed, 13 Sep 2023 14:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694616048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QLGLoGaoJqwtkP43V8jHsqGgwi0QsZKKA9ML65E+YI=;
        b=dX3aadPxf0mtrLufngP6Nm7bvtk2PYtr1KMPLbqHC/br37fSwMRzQZDUZM1sfql2T9RvJw
        pbO5i9nyfWOF8A3SZHiBngKeMb2kA8eLbAgMjl3WJwkQ3kuo0NrjzO3TZvR+x++jhxr/SG
        gnxOUtbbeBbDHVVycJkhDFDQpSKbibM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694616048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6QLGLoGaoJqwtkP43V8jHsqGgwi0QsZKKA9ML65E+YI=;
        b=9tVGc6sxkBE7pIho30f1Y7ryQfZgQBxvWnU2KzxRSjzDpjYoEr7RM6U5FsOju6Mkq9dE71
        E8hRVMGxByQf58Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C968813440;
        Wed, 13 Sep 2023 14:40:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id URtqMPDJAWWkaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 13 Sep 2023 14:40:48 +0000
Message-ID: <2f2985f0-f1a7-f085-fd18-107f3fba9478@suse.cz>
Date:   Wed, 13 Sep 2023 16:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/6] mm: page_alloc: fix move_freepages_block() range
 error
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-5-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230911195023.247694-5-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 21:41, Johannes Weiner wrote:
> When a block is partially outside the zone of the cursor page, the
> function cuts the range to the pivot page instead of the zone
> start. This can leave large parts of the block behind, which
> encourages incompatible page mixing down the line (ask for one type,
> get another), and thus long-term fragmentation.
> 
> This triggers reliably on the first block in the DMA zone, whose
> start_pfn is 1. The block is stolen, but everything before the pivot
> page (which was often hundreds of pages) is left on the old list.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Note below:

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f6f658c3d394..5bbe5f3be5ad 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1652,7 +1652,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
>  
>  	/* Do not cross zone boundaries */
>  	if (!zone_spans_pfn(zone, start_pfn))
> -		start_pfn = pfn;
> +		start_pfn = zone->zone_start_pfn;
>  	if (!zone_spans_pfn(zone, end_pfn))
>  		return 0;

Culdn't we also adjust end_pfn to zone_end_pfn() so we don't just ignore the
last half-pageblock for no good reason? (or am I missing any?)
Also would stop treating end_pfn as inclusive here and in move_freepages(),
it's rather uncommon.

>  

