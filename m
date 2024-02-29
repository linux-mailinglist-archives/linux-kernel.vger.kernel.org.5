Return-Path: <linux-kernel+bounces-86316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4BF86C3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A98528A94F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B25103E;
	Thu, 29 Feb 2024 08:39:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DF220312
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195994; cv=none; b=f6QRrU9bvCyOVVuRIStx0tAFaqc2fFunsXCfCvJ4/wYXkuDRKw84k6tGSdq5eMwKcRpS/zuWyZELqzn2xScDgLYZImgnFHNDJNhnM5MyT/vdGz5MJct7LX/OJaTsYBuAmbRx3UE4+KH7VllT4zow+rgGVhUHpXzSvRuXnkDPVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195994; c=relaxed/simple;
	bh=604IGTIxaYnzAyaioDKRybKbiYiflPnAAtCmXCF2X+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbQZMqEB7AUAbaVVVm4+OYHraK0wrKEjeCEXWrrymcpHWzOk+DOg00aNtSn0hy32kXvubbEorIicv+7oWCDPwKdpeeutMzDfERGPKTGS30B+Fkx4uaOVFK9l4n55mkkmOJVn2WEOhHfqykbgr/dmtp4GPNazhxYjVk+mFAVs+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-28-65e042d11ed9
Date: Thu, 29 Feb 2024 17:39:38 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
Message-ID: <20240229083938.GA64252@system.software.com>
References: <20240223054407.14829-1-byungchul@sk.com>
 <ZdyM1nS8a8UR1dw_@tiehlicka>
 <20240228223601.GA53666@cmpxchg.org>
 <87jzmndc4k.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzmndc4k.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC9ZZnke5FpwepBoceSVjMWb+GzWL1Jl+L
	y7vmsFncW/Of1WLyu2eMFvf7HCxmN/YxWpycNZnF4t2EL6wOnB6H37xn9liwqdRj8Z6XTB6b
	Pk1i9zgx4zeLx/otV1k8ziw4wu6x+XS1x+dNcgGcUVw2Kak5mWWpRfp2CVwZFyesZi/oD664
	PL2DtYFxml0XIyeHhICJxNM9ncww9pMfV9hAbBYBVYkHV3+xg9hsAuoSN278BKsREdCQ+LRw
	OVCci4NZoJ1Jou3wNBaQhLBAuETH3N2sIDavgIXEjI1nWUGKhATWM0p09i1hhEgISpyc+QSs
	gVlAS+LGv5dMXYwcQLa0xPJ/HCBhTgE7iZbeJUwgtqiAssSBbceZQOZICFxnk1h0bQ07xKWS
	EgdX3GCZwCgwC8nYWUjGzkIYu4CReRWjUGZeWW5iZo6JXkZlXmaFXnJ+7iZGYEwsq/0TvYPx
	04XgQ4wCHIxKPLwJNvdThVgTy4orcw8xSnAwK4nwygjeTRXiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAaH9K+7DPI/5V/0U+Txd9ZGJmt0Vb1/XL8wRP
	kVmvLOJ4WNxfLGdeKDyp/uS3wgvGjTuLlxQc4JknNMvvvdVmo5uCKfwXtYrCt5wKFXD3Unb7
	lCl05arI+815D7Y8bKr9clvs1hemIrnJ84okW5hUN1o9PSEZ33DC4cKaklcTLDqDQzvsp8iq
	KLEUZyQaajEXFScCAL6g2IWFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC5WfdrHvR6UGqwbo7/BZz1q9hs1i9ydfi
	8NyTrBaXd81hs7i35j+rxeR3zxgt7vc5WMxu7GO0ODlrMovFuwlfWB24PA6/ec/ssWBTqcfi
	PS+ZPDZ9msTucWLGbxaPxS8+MHms33KVxePMgiPsHptPV3t83iQXwBXFZZOSmpNZllqkb5fA
	lXFxwmr2gv7gisvTO1gbGKfZdTFyckgImEg8+XGFDcRmEVCVeHD1FzuIzSagLnHjxk9mEFtE
	QEPi08LlQHEuDmaBdiaJtsPTWEASwgLhEh1zd7OC2LwCFhIzNp5lBSkSEljPKNHZt4QRIiEo
	cXLmE7AGZgEtiRv/XjJ1MXIA2dISy/9xgIQ5BewkWnqXMIHYogLKEge2HWeawMg7C0n3LCTd
	sxC6FzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/dxAgM8GW1fybuYPxy2f0QowAHoxIPb4LN
	/VQh1sSy4srcQ4wSHMxKIrwygndThXhTEiurUovy44tKc1KLDzFKc7AoifN6hacmCAmkJ5ak
	ZqemFqQWwWSZODilGhjjKsR5U+qZmPZWfQ7nUWhz7p+f+f+TgpZ1Yt5blruPpMv93s8wrTLK
	yq35VqXRc+z9r7VeQm3eWuwM7o7rhc8dmCL12PKOkKCyohIbx7Wpn7+nej+esMHCXS3UcqXO
	p6DSgne2epssZ/ju2it2eMNrQWXO7rIEsQ4zi1NT2LUyeY9bTk9pVmIpzkg01GIuKk4EALrF
	GAdsAgAA
X-CFilter-Loop: Reflected

On Thu, Feb 29, 2024 at 02:21:15PM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > On Mon, Feb 26, 2024 at 02:06:30PM +0100, Michal Hocko wrote:
> >> [CC Mel, Vlastimil and Johannes for awareness]
> >> 
> >> On Fri 23-02-24 14:44:07, Byungchul Park wrote:
> >> > Changes from v2:
> >> > 	1. Change the condition to stop cache_trim_mode.
> >> > 
> >> > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> >> > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> >> > 	          the mode didn't work in the previous turn.
> >> > 
> >> > 	   (feedbacked by Huang Ying)
> >> > 
> >> > 	2. Change the test result in the commit message after testing
> >> > 	   with the new logic.
> >> > 
> >> > Changes from v1:
> >> > 	1. Add a comment describing why this change is necessary in code
> >> > 	   and rewrite the commit message with how to reproduce and what
> >> > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> >> > 	   Yu Zhao)
> >> > 	2. Change the condition to avoid cache_trim_mode from
> >> > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> >> > 	   where the priority goes to zero all the way. (feedbacked by
> >> > 	   Yu Zhao)
> >> > 
> >> > --->8---
> >> > >From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> >> > From: Byungchul Park <byungchul@sk.com>
> >> > Date: Fri, 23 Feb 2024 13:47:16 +0900
> >> > Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
> >> > 
> >> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> > pages.  However, it should be more careful to turn on the mode because
> >> > it's going to prevent anon pages from being reclaimed even if there are
> >> > a huge number of anon pages that are cold and should be reclaimed.  Even
> >> > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> > stopping kswapd from functioning until direct reclaim eventually works
> >> > to resume kswapd.
> >> > 
> >> > So do not turn on cache_trim_mode if the mode doesn't work, especially
> >> > while the sytem is struggling against reclaim.
> >> > 
> >> > The problematic behavior can be reproduced by:
> >> > 
> >> >    CONFIG_NUMA_BALANCING enabled
> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> >    numa node0 (8GB local memory, 16 CPUs)
> >> >    numa node1 (8GB slow tier memory, no CPUs)
> >> > 
> >> >    Sequence:
> >> > 
> >> >    1) echo 3 > /proc/sys/vm/drop_caches
> >> >    2) To emulate the system with full of cold memory in local DRAM, run
> >> >       the following dummy program and never touch the region:
> >> > 
> >> >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> >> > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >> > 
> >> >    3) Run any memory intensive work e.g. XSBench.
> >> >    4) Check if numa balancing is working e.i. promotion/demotion.
> >> >    5) Iterate 1) ~ 4) until numa balancing stops.
> >> > 
> >> > With this, you could see that promotion/demotion are not working because
> >> > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> > 
> >> > Interesting vmstat delta's differences between before and after are like:
> >> > 
> >> >    +-----------------------+-------------------------------+
> >> >    | interesting vmstat	   | before	   | after	   |
> >> >    +-----------------------+-------------------------------+
> >> >    | nr_inactive_anon	   | 321935	   | 1636737	   |
> >> >    | nr_active_anon	   | 1780700	   | 465913	   |
> >> >    | nr_inactive_file	   | 30425	   | 35711	   |
> >> >    | nr_active_file	   | 14961	   | 8698	   |
> >> >    | pgpromote_success	   | 356	   | 1267785	   |
> >> >    | pgpromote_candidate   | 21953245	   | 1745631	   |
> >> >    | pgactivate		   | 1844523	   | 3309867	   |
> >> >    | pgdeactivate	   | 50634	   | 1545041	   |
> >> >    | pgfault		   | 31100294	   | 6411036	   |
> >> >    | pgdemote_kswapd	   | 30856	   | 2267467	   |
> >> >    | pgscan_kswapd	   | 1861981	   | 7729231	   |
> >> >    | pgscan_anon	   | 1822930	   | 7667544	   |
> >> >    | pgscan_file	   | 39051	   | 61687	   |
> >> >    | pgsteal_anon	   | 386	   | 2227217	   |
> >> >    | pgsteal_file	   | 30470	   | 40250	   |
> >> >    | pageoutrun		   | 30		   | 457	   |
> >> >    | numa_hint_faults	   | 27418279	   | 2752289	   |
> >> >    | numa_pages_migrated   | 356	   | 1267785 	   |
> >> >    +-----------------------+-------------------------------+
> >> > 
> >> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> > ---
> >> >  mm/vmscan.c | 24 +++++++++++++++++++-----
> >> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >> > 
> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > index bba207f41b14..f7312d831fed 100644
> >> > --- a/mm/vmscan.c
> >> > +++ b/mm/vmscan.c
> >> > @@ -127,6 +127,9 @@ struct scan_control {
> >> >  	/* One of the zones is ready for compaction */
> >> >  	unsigned int compaction_ready:1;
> >> >  
> >> > +	/* If the last try was reclaimable */
> >> > +	unsigned int reclaimable:1;
> >> > +
> >> >  	/* There is easily reclaimable cold cache in the current node */
> >> >  	unsigned int cache_trim_mode:1;
> >> >  
> >> > @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> >  	 * If we have plenty of inactive file pages that aren't
> >> >  	 * thrashing, try to reclaim those first before touching
> >> >  	 * anonymous pages.
> >> > +	 *
> >> > +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> >> > +	 * is not working while struggling against reclaim. So do not
> >> > +	 * turn it on if so. Note the highest priority of kswapd is 1.
> >> >  	 */
> >> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >> > +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
> >> >  		sc->cache_trim_mode = 1;
> >> >  	else
> >> >  		sc->cache_trim_mode = 0;
> >
> > The overall goal makes sense to me.
> >
> > file >> priority is just a heuristic that there are enough potential
> > candidate pages, not a guarantee that any forward progress will
> > happen. So it makes sense to retry without before failing.
> >
> > The way you wrote this conditional kind of hurts my head,
> > though. Please don't write negations of complex terms like this.
> >
> > It expands to this:
> >
> > 	!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1
> >
> > which I'm not sure makes sense. Surely it should be something like
> >
> > 	!sc->cache_trim_mode && sc->reclaimable && sc->priority > 1
> >
> > instead?
> >
> > Also
> >
> > 	if (!sc->cache_trim_mode)
> > 		sc->cache_trim_mode = 1
> > 	else
> > 		sc->cache_trim_mode = 0
> >
> > will toggle on every loop. So if direct reclaim runs through a
> > zonelist, it'll cache trim every other numa node...?
> >
> >> > @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >  {
> >> >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> >> >  	struct lruvec *target_lruvec;
> >> > -	bool reclaimable = false;
> >> >  
> >> >  	if (lru_gen_enabled() && root_reclaim(sc)) {
> >> >  		lru_gen_shrink_node(pgdat, sc);
> >> > @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >  	nr_reclaimed = sc->nr_reclaimed;
> >> >  	nr_scanned = sc->nr_scanned;
> >> >  
> >> > +	/*
> >> > +	 * Reset to the default values at the start.
> >> > +	 */
> >> > +	if (sc->priority == DEF_PRIORITY) {
> >> > +		sc->reclaimable = 1;
> >> > +		sc->cache_trim_mode = 0;
> >> > +	}
> >> > +
> >> >  	prepare_scan_control(pgdat, sc);
> >> >  
> >> >  	shrink_node_memcgs(pgdat, sc);
> >> > @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> >> >  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
> >> >  
> >> > -	if (nr_node_reclaimed)
> >> > -		reclaimable = true;
> >> > +	sc->reclaimable = !!nr_node_reclaimed;
> >
> > The scope of this doesn't quite make sense. If direct reclaim scans
> > multiple nodes, reclaim failure on the first node would disable cache
> > trim mode on the second node, which is totally unrelated.
> >
> > I think it needs separate paths for direct reclaim and kswapd. For
> > direct reclaim, the retry should be before these similar retry catches
> > in do_try_to_free_pages(), after all zones have been considered:
> >
> > 	/*
> > 	 * We make inactive:active ratio decisions based on the node's
> > 	 * composition of memory, but a restrictive reclaim_idx or a
> > 	 * memory.low cgroup setting can exempt large amounts of
> > 	 * memory from reclaim. Neither of which are very common, so
> > 	 * instead of doing costly eligibility calculations of the
> > 	 * entire cgroup subtree up front, we assume the estimates are
> > 	 * good, and retry with forcible deactivation if that fails.
> > 	 */
> > 	if (sc->skipped_deactivate) {
> > 		sc->priority = initial_priority;
> > 		sc->force_deactivate = 1;
> > 		sc->skipped_deactivate = 0;
> > 		goto retry;
> > 	}
> >
> > 	/* Untapped cgroup reserves?  Don't OOM, retry. */
> > 	if (sc->memcg_low_skipped) {
> > 		sc->priority = initial_priority;
> > 		sc->force_deactivate = 0;
> > 		sc->memcg_low_reclaim = 1;
> > 		sc->memcg_low_skipped = 0;
> > 		goto retry;
> > 	}
> 
> In get_scan_count(), we have
> 
> 	if (!sc->priority && swappiness) {
> 		scan_balance = SCAN_EQUAL;
> 		goto out;
> 	}

Even though this can mitigate the issue for direct reclaim, it's still
suffering from the problem while direct reclaim goes from DEF_PRIORITY
to 1. What we need is not a mitigation but making things right.

Thoughts?

	Byungchul

> So, we don't really need the heuristics in direct reclaim path.  So, one
> choice is to constrain this in kswapd reclaim only.
> 
> --
> Best Regards,
> Huang, Ying
> 
> 
> > and for kswapd it looks like it should be in balance_pgdat(), after
> > the priority loop, before increasing kswapd_failures.
> >
> > Instead of sc->reclaimable, which is very broad, it would be better to
> > call it sc->may_cache_trim_mode. This is in line with a bunch of other
> > such mechanisms in scan_control.

