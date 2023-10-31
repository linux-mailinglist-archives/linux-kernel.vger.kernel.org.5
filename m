Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AACB7DCE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjJaNnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344596AbjJaNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:43:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48718F3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 06:43:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E43D921882;
        Tue, 31 Oct 2023 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698759825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0u3vJpP3NYEU8SD2U2RYUepPyGcet77QqQr9UO7B1Q=;
        b=Ifvo63kgrto9KNMFSrrvl8g23j3xzU+Ey8C6BHqTh9zBU3PaGcLQBRM0mjTf7q3qtOdl3A
        wrF4X/mWNVwa4Bawa339VnVFP86ET0HDJtqhYw6ZnhXMdE/Sk8f9ZLlO5ChFB0N2+AwfIT
        +97TQGda8ZBI5gIJ71JQonk3KZC4zIs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2CA6138EF;
        Tue, 31 Oct 2023 13:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imqdLJEEQWUoeQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 31 Oct 2023 13:43:45 +0000
Date:   Tue, 31 Oct 2023 14:43:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: unreserve highatomic page blocks before
 oom
Message-ID: <b4tb2mj3jr5aiiwtyim6jl4occgicv4xzphhqxk2cxijsw5l2w@gjsp4vn7vw7p>
References: <1698669590-3193-1-git-send-email-quic_charante@quicinc.com>
 <gtya2g2pdbsonelny6vpfwj5vsxdrzhi6wzkpcrke33mr3q2hf@j4ramnjmfx52>
 <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0d2dd8-562c-fec7-e3ac-0bd955643e16@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-10-23 18:43:55, Charan Teja Kalla wrote:
> Thanks Michal/Pavan!!
> 
> On 10/31/2023 1:44 PM, Michal Hocko wrote:
> > On Mon 30-10-23 18:09:50, Charan Teja Kalla wrote:
> >> __alloc_pages_direct_reclaim() is called from slowpath allocation where
> >> high atomic reserves can be unreserved after there is a progress in
> >> reclaim and yet no suitable page is found. Later should_reclaim_retry()
> >> gets called from slow path allocation to decide if the reclaim needs to
> >> be retried before OOM kill path is taken.
> >>
> >> should_reclaim_retry() checks the available(reclaimable + free pages)
> >> memory against the min wmark levels of a zone and returns:
> >> a)  true, if it is above the min wmark so that slow path allocation will
> >> do the reclaim retries.
> >> b) false, thus slowpath allocation takes oom kill path.
> >>
> >> should_reclaim_retry() can also unreserves the high atomic reserves
> >> **but only after all the reclaim retries are exhausted.**
> >>
> >> In a case where there are almost none reclaimable memory and free pages
> >> contains mostly the high atomic reserves but allocation context can't
> >> use these high atomic reserves, makes the available memory below min
> >> wmark levels hence false is returned from should_reclaim_retry() leading
> >> the allocation request to take OOM kill path. This is an early oom kill
> >> because high atomic reserves are holding lot of free memory and 
> >> unreserving of them is not attempted.
> > 
> > OK, I see. So we do not release those reserved pages because OOM hits
> > too early. 
> > 
> >> (early)OOM is encountered on a machine in the below state(excerpt from
> >> the oom kill logs):
> >> [  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
> >> high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
> >> active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
> >> present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
> >> local_pcp:492kB free_cma:0kB
> >> [  295.998656] lowmem_reserve[]: 0 32
> >> [  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
> >> 33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
> >> 0*4096kB = 7752kB
> > 
> > OK, this is quite interesting as well. The system is really tiny and 8MB
> > of reserved memory is indeed really high. How come those reservations
> > have grown that high?
> 
> Actually it is a VM running on the Linux kernel.
> 
> Regarding the reservations, I think it is because of the 'max_managed '
> calculations in the below:
> static void reserve_highatomic_pageblock(struct page *page, ....) {
>     ....
>   /*
>    * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
>    * Check is race-prone but harmless.
>    */
>     max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
> 
>     if (zone->nr_reserved_highatomic >= max_managed)
>             goto out;
> 
>     zone->nr_reserved_highatomic += pageblock_nr_pages;
>     set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>     move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> out:
> }
> 
> Since we are always appending the 1% of zone managed pages count to
> pageblock_nr_pages, the minimum it is turning into 2 pageblocks as the
> 'nr_reserved_highatomic' is incremented/decremented in pageblock size
> granules.
> 
> And for my case the 8M out of ~50M is turned out to be 16%, which is high.
> 
> If the below looks fine to you, I can raise this as a separate change:

Yes, please. Having a full page block (4MB) sounds still too much for
such a tiny system. Maybe there shouldn't be any reservation. But
definitely worth a separate patch.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2a2536d..41441ced 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1886,7 +1886,9 @@ static void reserve_highatomic_pageblock(struct
> page *page, struct zone *zone)
>          * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
>          * Check is race-prone but harmless.
>          */
> -       max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
> +       max_managed = max_t(unsigned long,
> +                       ALIGN(zone_managed_pages(zone) / 100,
> pageblock_nr_pages),
> +                       pageblock_nr_pages);
>         if (zone->nr_reserved_highatomic >= max_managed)
>                 return;
> 
> >>
> >> Per above log, the free memory of ~7MB exist in the high atomic
> >> reserves is not freed up before falling back to oom kill path.
> >>
> >> This fix includes unreserving these atomic reserves in the OOM path
> >> before going for a kill. The side effect of unreserving in oom kill path
> >> is that these free pages are checked against the high wmark. If
> >> unreserved from should_reclaim_retry()/__alloc_pages_direct_reclaim(),
> >> they are checked against the min wmark levels.
> > 
> > I do not like the fix much TBH. I think the logic should live in
> 
> yeah, This code looks way too cleaner to me. Let me know If I can raise
> V2 with the below, suggested-by you.

Sure, go ahead.
 
> I think another thing system is missing here is draining the pcp lists.
> min:804kB low:1004kB high:1204kB free_pcp:688kB

Yes, but this seems like negligible even under a small system like that.
Does it actually help to keep system in balance? I would expect that the
OOM is just imminent no matter the draining. Anyway if this makes any
difference then just make it a separate patch please.
-- 
Michal Hocko
SUSE Labs
