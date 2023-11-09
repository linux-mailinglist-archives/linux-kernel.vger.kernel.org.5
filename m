Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621737E681A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjKIK3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjKIK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:29:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3CC2D71
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:29:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 997091F8AF;
        Thu,  9 Nov 2023 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699525786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YuLoV2JyqsH4r5+2kBnsrDcvM5PpduhmNw67kT4f4c0=;
        b=cSNh2vwEnUeJUJ1PTxf5EMSGtUZ+VO4+qAcHcB7d486sitasKs2F9Q+YnTVJP+fHZOqzbu
        U6V621FqbBp2XWyZvlz5t+yB8N7mjJaDt7/4/UuHyoyXycYUE0XqFFDN5fnu3bV4YH/ad1
        FeJOiJ+xSOt7ft6Fq6q5pSTUwkF/pOI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA9F13524;
        Thu,  9 Nov 2023 10:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yoHKIZq0TGXIdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 10:29:46 +0000
Date:   Thu, 9 Nov 2023 11:29:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org,
        quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] mm: page_alloc: unreserve highatomic page blocks
 before oom
Message-ID: <ZUy0mj1frKoTebgX@tiehlicka>
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <301b193fcc3e1f91ef30f19ceca06dd6e00b35e1.1699104759.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301b193fcc3e1f91ef30f19ceca06dd6e00b35e1.1699104759.git.quic_charante@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05-11-23 18:20:48, Charan Teja Kalla wrote:
> __alloc_pages_direct_reclaim() is called from slowpath allocation where
> high atomic reserves can be unreserved after there is a progress in
> reclaim and yet no suitable page is found. Later should_reclaim_retry()
> gets called from slow path allocation to decide if the reclaim needs to
> be retried before OOM kill path is taken.
> 
> should_reclaim_retry() checks the available(reclaimable + free pages)
> memory against the min wmark levels of a zone and returns:
> a)  true, if it is above the min wmark so that slow path allocation will
> do the reclaim retries.
> b) false, thus slowpath allocation takes oom kill path.
> 
> should_reclaim_retry() can also unreserves the high atomic reserves
> **but only after all the reclaim retries are exhausted.**
> 
> In a case where there are almost none reclaimable memory and free pages
> contains mostly the high atomic reserves but allocation context can't
> use these high atomic reserves, makes the available memory below min
> wmark levels hence false is returned from should_reclaim_retry() leading
> the allocation request to take OOM kill path. This can turn into a early
> oom kill if high atomic reserves are holding lot of free memory and
> unreserving of them is not attempted.
> 
> (early)OOM is encountered on a VM with the below state:
> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
> local_pcp:492kB free_cma:0kB
> [  295.998656] lowmem_reserve[]: 0 32
> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
> 0*4096kB = 7752kB
> 
> Per above log, the free memory of ~7MB exist in the high atomic
> reserves is not freed up before falling back to oom kill path.
> 
> Fix it by trying to unreserve the high atomic reserves in
> should_reclaim_retry() before __alloc_pages_direct_reclaim() can
> fallback to oom kill path.
> 
> Fixes: 0aaa29a56e4f ("mm, page_alloc: reserve pageblocks for high-order atomic allocations on demand")
> Reported-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/page_alloc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 95546f3..e07a38f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3809,14 +3809,9 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  	else
>  		(*no_progress_loops)++;
>  
> -	/*
> -	 * Make sure we converge to OOM if we cannot make any progress
> -	 * several times in the row.
> -	 */
> -	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
> -		/* Before OOM, exhaust highatomic_reserve */
> -		return unreserve_highatomic_pageblock(ac, true);
> -	}
> +	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
> +		goto out;
> +
>  
>  	/*
>  	 * Keep reclaiming pages while there is a chance this will lead
> @@ -3859,6 +3854,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  		schedule_timeout_uninterruptible(1);
>  	else
>  		cond_resched();
> +out:
> +	/* Before OOM, exhaust highatomic_reserve */
> +	if (!ret)
> +		return unreserve_highatomic_pageblock(ac, true);
> +
>  	return ret;
>  }
>  
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
