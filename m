Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D47E6833
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjKIKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:33:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FEC1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:33:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A6AE1F8B4;
        Thu,  9 Nov 2023 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699526005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1CqYEUJwt6aLzQ4KOZXFVSUAM01BociElAUc+Y4eAbY=;
        b=FbxcXiJw8xkFgGCLOChcBWLVobGdIZIh1K+hR2SNpiMSYo9HggQG/vDsyz4xxEoLPKHDFK
        IkYrbpfkDCKDuA2UEF49mCGBX13QuPIwb27R5NHwmSlI+DZgdsaxatEqyvOyGv0zM8AAmU
        rIHQThZiA0UeS6uw78ZJpnW7miAHne4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3683E13524;
        Thu,  9 Nov 2023 10:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wi81DXW1TGXEdgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 10:33:25 +0000
Date:   Thu, 9 Nov 2023 11:33:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
Message-ID: <ZUy1dNvbvHc6gquo@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05-11-23 18:20:50, Charan Teja Kalla wrote:
> pcp lists are drained from __alloc_pages_direct_reclaim(), only if some
> progress is made in the attempt.
> 
> struct page *__alloc_pages_direct_reclaim() {
>     .....
>    *did_some_progress = __perform_reclaim(gfp_mask, order, ac);
>    if (unlikely(!(*did_some_progress)))
>       goto out;
> retry:
>     page = get_page_from_freelist();
>     if (!page && !drained) {
>         drain_all_pages(NULL);
>         drained = true;
>         goto retry;
>     }
> out:
> }
> 
> After the above, allocation attempt can fallback to
> should_reclaim_retry() to decide reclaim retries. If it too return
> false, allocation request will simply fallback to oom kill path without
> even attempting the draining of the pcp pages that might help the
> allocation attempt to succeed.
> 
> VM system running with ~50MB of memory shown the below stats during OOM
> kill:
> Normal free:760kB boost:0kB min:768kB low:960kB high:1152kB
> reserved_highatomic:0KB managed:49152kB free_pcp:460kB
> 
> Though in such system state OOM kill is imminent, but the current kill
> could have been delayed if the pcp is drained as pcp + free is even
> above the high watermark.

TBH I am not sure this is really worth it. Does it really reduce the
risk of the OOM in any practical situation?

> Fix this missing drain of pcp list in should_reclaim_retry() along with
> unreserving the high atomic page blocks, like it is done in
> __alloc_pages_direct_reclaim().
> 
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b91c99e..8eee292 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3857,8 +3857,10 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  		cond_resched();
>  out:
>  	/* Before OOM, exhaust highatomic_reserve */
> -	if (!ret)
> -		return unreserve_highatomic_pageblock(ac, true);
> +	if (!ret) {
> +		ret =  unreserve_highatomic_pageblock(ac, true);
> +		drain_all_pages(NULL);
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
