Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9C77C54DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjJKNIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjJKNIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:08:31 -0400
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E1E0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:08:26 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id D3687FB1CE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:08:24 +0100 (IST)
Received: (qmail 26269 invoked from network); 11 Oct 2023 13:08:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 11 Oct 2023 13:08:24 -0000
Date:   Wed, 11 Oct 2023 14:08:22 +0100
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
Subject: Re: [PATCH 08/10] mm, pcp: decrease PCP high if free pages < high
 watermark
Message-ID: <20231011130822.dmz4nuidfyk7w34q@techsingularity.net>
References: <20230920061856.257597-1-ying.huang@intel.com>
 <20230920061856.257597-9-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230920061856.257597-9-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:18:54PM +0800, Huang Ying wrote:
> One target of PCP is to minimize pages in PCP if the system free pages
> is too few.  To reach that target, when page reclaiming is active for
> the zone (ZONE_RECLAIM_ACTIVE), we will stop increasing PCP high in
> allocating path, decrease PCP high and free some pages in freeing
> path.  But this may be too late because the background page reclaiming
> may introduce latency for some workloads.  So, in this patch, during
> page allocation we will detect whether the number of free pages of the
> zone is below high watermark.  If so, we will stop increasing PCP high
> in allocating path, decrease PCP high and free some pages in freeing
> path.  With this, we can reduce the possibility of the premature
> background page reclaiming caused by too large PCP.
> 
> The high watermark checking is done in allocating path to reduce the
> overhead in hotter freeing path.
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
>  mm/page_alloc.c        | 22 ++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d6cfb5023f3e..8a19e2af89df 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1006,6 +1006,7 @@ enum zone_flags {
>  					 * Cleared when kswapd is woken.
>  					 */
>  	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
> +	ZONE_BELOW_HIGH,		/* zone is below high watermark. */
>  };
>  
>  static inline unsigned long zone_managed_pages(struct zone *zone)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 225abe56752c..3f8c7dfeed23 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2409,7 +2409,13 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
>  		return min(batch << 2, pcp->high);
>  	}
>  
> -	if (pcp->count >= high && high_min != high_max) {
> +	if (high_min == high_max)
> +		return high;
> +
> +	if (test_bit(ZONE_BELOW_HIGH, &zone->flags)) {
> +		pcp->high = max(high - (batch << pcp->free_factor), high_min);
> +		high = max(pcp->count, high_min);
> +	} else if (pcp->count >= high) {
>  		int need_high = (batch << pcp->free_factor) + batch;
>  
>  		/* pcp->high should be large enough to hold batch freed pages */
> @@ -2459,6 +2465,10 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
>  	if (pcp->count >= high) {
>  		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
>  				   pcp, pindex);
> +		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
> +		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
> +				      ZONE_MOVABLE, 0))
> +			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
>  	}
>  }
>  
> @@ -2765,7 +2775,7 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
>  	 * If we had larger pcp->high, we could avoid to allocate from
>  	 * zone.
>  	 */
> -	if (high_min != high_max && !test_bit(ZONE_RECLAIM_ACTIVE, &zone->flags))
> +	if (high_min != high_max && !test_bit(ZONE_BELOW_HIGH, &zone->flags))
>  		high = pcp->high = min(high + batch, high_max);
>  
>  	if (!order) {
> @@ -3226,6 +3236,14 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			}
>  		}
>  
> +		mark = high_wmark_pages(zone);
> +		if (zone_watermark_fast(zone, order, mark,
> +					ac->highest_zoneidx, alloc_flags,
> +					gfp_mask))
> +			goto try_this_zone;
> +		else if (!test_bit(ZONE_BELOW_HIGH, &zone->flags))
> +			set_bit(ZONE_BELOW_HIGH, &zone->flags);
> +

This absolutely needs a comment explaning why because superficially a
consequence of this is that allocator performance is slightly degraded
when below the high watermark. Being below the high watermark is
completely harmless and can persist indefinitely until something wakes
kswapd.

-- 
Mel Gorman
SUSE Labs
