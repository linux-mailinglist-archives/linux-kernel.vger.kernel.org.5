Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84587CF905
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345623AbjJSMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345439AbjJSMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:33:16 -0400
Received: from outbound-smtp24.blacknight.com (outbound-smtp24.blacknight.com [81.17.249.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101329B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:33:13 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 6484CC0DAA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:33:12 +0100 (IST)
Received: (qmail 23318 invoked from network); 19 Oct 2023 12:33:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.199.31])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Oct 2023 12:33:12 -0000
Date:   Thu, 19 Oct 2023 13:33:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH -V3 8/9] mm, pcp: decrease PCP high if free pages < high
 watermark
Message-ID: <20231019123310.pirier6sk6iaqr3n@techsingularity.net>
References: <20231016053002.756205-1-ying.huang@intel.com>
 <20231016053002.756205-9-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231016053002.756205-9-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:30:01PM +0800, Huang Ying wrote:
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
>  mm/page_alloc.c        | 33 +++++++++++++++++++++++++++++++--
>  2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ec3f7daedcc7..c88770381aaf 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1018,6 +1018,7 @@ enum zone_flags {
>  					 * Cleared when kswapd is woken.
>  					 */
>  	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
> +	ZONE_BELOW_HIGH,		/* zone is below high watermark. */
>  };
>  
>  static inline unsigned long zone_managed_pages(struct zone *zone)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8382ad2cdfd4..253fc7d0498e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2407,7 +2407,13 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
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
> @@ -2457,6 +2463,10 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
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

This is a relatively fast path and freeing pages should not need to check
watermarks. While the overhead is mitigated because it applies only when
the watermark is below high, that is also potentially an unbounded condition
if a workload is sized precisely enough. Why not clear this bit when kswapd
is going to sleep after reclaiming enough pages in a zone?

If you agree then a follow-up patch classed as a micro-optimisation is
sufficient to avoid redoing all the results again. For most of your
tests, it should be performance-neutral or borderline noise.

-- 
Mel Gorman
SUSE Labs
