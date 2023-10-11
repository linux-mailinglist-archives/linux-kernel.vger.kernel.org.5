Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724997C566A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbjJKOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjJKOKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:10:00 -0400
Received: from outbound-smtp44.blacknight.com (outbound-smtp44.blacknight.com [46.22.136.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B5990
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 07:09:57 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 2B48CF867E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:09:53 +0100 (IST)
Received: (qmail 27907 invoked from network); 11 Oct 2023 14:09:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2023 14:09:51 -0000
Date:   Wed, 11 Oct 2023 15:09:49 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 09/10] mm, pcp: avoid to reduce PCP high unnecessarily
Message-ID: <20231011140949.rwsqfb57vyuub6va@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-10-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230920061856.257597-10-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:18:55PM +0800, Huang Ying wrote:
> In PCP high auto-tuning algorithm, to minimize idle pages in PCP, in
> periodic vmstat updating kworker (via refresh_cpu_vm_stats()), we will
> decrease PCP high to try to free possible idle PCP pages.  One issue
> is that even if the page allocating/freeing depth is larger than
> maximal PCP high, we may reduce PCP high unnecessarily.
> 
> To avoid the above issue, in this patch, we will track the minimal PCP
> page count.  And, the periodic PCP high decrement will not more than
> the recent minimal PCP page count.  So, only detected idle pages will
> be freed.
> 
> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
> one socket with `make -j 112`.  With the patch, The number of pages
> allocated from zone (instead of from PCP) decreases 25.8%.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <jweiner@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christoph Lameter <cl@linux.com>
> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        | 15 ++++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8a19e2af89df..35b78c7522a7 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -682,6 +682,7 @@ enum zone_watermarks {
>  struct per_cpu_pages {
>  	spinlock_t lock;	/* Protects lists field */
>  	int count;		/* number of pages in the list */
> +	int count_min;		/* minimal number of pages in the list recently */
>  	int high;		/* high watermark, emptying needed */
>  	int high_min;		/* min high watermark */
>  	int high_max;		/* max high watermark */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3f8c7dfeed23..77e9b7b51688 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2166,19 +2166,20 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>   */
>  int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
>  {
> -	int high_min, to_drain, batch;
> +	int high_min, decrease, to_drain, batch;
>  	int todo = 0;
>  
>  	high_min = READ_ONCE(pcp->high_min);
>  	batch = READ_ONCE(pcp->batch);
>  	/*
> -	 * Decrease pcp->high periodically to try to free possible
> -	 * idle PCP pages.  And, avoid to free too many pages to
> -	 * control latency.
> +	 * Decrease pcp->high periodically to free idle PCP pages counted
> +	 * via pcp->count_min.  And, avoid to free too many pages to
> +	 * control latency.  This caps pcp->high decrement too.
>  	 */
>  	if (pcp->high > high_min) {
> +		decrease = min(pcp->count_min, pcp->high / 5);

Not directly related to this patch but why 20%, it seems a bit
arbitrary. While this is not an fast path, using a divide rather than a
shift seems unnecessarily expensive.

>  		pcp->high = max3(pcp->count - (batch << PCP_BATCH_SCALE_MAX),
> -				 pcp->high * 4 / 5, high_min);
> +				 pcp->high - decrease, high_min);
>  		if (pcp->high > high_min)
>  			todo++;
>  	}
> @@ -2191,6 +2192,8 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
>  		todo++;
>  	}
>  
> +	pcp->count_min = pcp->count;
> +
>  	return todo;
>  }
>  
> @@ -2828,6 +2831,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  		page = list_first_entry(list, struct page, pcp_list);
>  		list_del(&page->pcp_list);
>  		pcp->count -= 1 << order;
> +		if (pcp->count < pcp->count_min)
> +			pcp->count_min = pcp->count;

While the accounting for this is in a relatively fast path.

At the moment I don't have a better suggestion but I'm not as keen on
this patch. It seems like it would have been more appropriate to decay if
there was no recent allocation activity tracked via pcp->flags.  The major
caveat there is tracking a bit and clearing it may very well be in a fast
path unless it was tried to refills but that is subject to timing issues
and the allocation request stream :(

While you noted the difference in buddy allocations which may tie into
lock contention issues, how much difference to it make to the actual
performance of the workload?

-- 
Mel Gorman
SUSE Labs
