Return-Path: <linux-kernel+bounces-86344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5139286C42D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DDE1F230B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8254BFB;
	Thu, 29 Feb 2024 08:50:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA021653
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196657; cv=none; b=aA2Q/YiMgOZTLjLswL+EdbsM6M965AJhKonXII3RPwEdDYbmk9CVLTQ0QNZJ/vln9txHDPWuKL9NIxRPPhJXQxO5zXHno+aCnXQNnVZfKkW/9le7SaYa3WWeOgpppe3OH0iYSyTMNVx6Gs0LtHA18Kpa6Ux1BoGKBRVa+1uEE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196657; c=relaxed/simple;
	bh=5rlgcxDPhKqZeRqHfQaPrlIL9d7kPJMeYXLnijzxSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxg1Rh7vBNJJOXcRn2GBg+tQKlnYllXBQk+dauE4Qq4F7Y3+Ool54SmZJiiQV5A0EjQ0UrZ2SqZVI+nsetmi/4qP3OvaUt+Uso9DJyQD/gKQdvt32T4y89iKaZC35+Bh8cuPkRXRKJ4cdLR9fdQUEyrbZXnVK6HVGMY7q3EhMEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ed-65e045690d75
Date: Thu, 29 Feb 2024 17:50:44 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
Message-ID: <20240229085044.GB64252@system.software.com>
References: <20240223054407.14829-1-byungchul@sk.com>
 <ZdyM1nS8a8UR1dw_@tiehlicka>
 <20240228223601.GA53666@cmpxchg.org>
 <87jzmndc4k.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240229083938.GA64252@system.software.com>
 <871q8vd5n5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q8vd5n5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsXC9ZZnkW6m64NUgxmXNSzmrF/DZrF6k6/F
	5V1z2CzurfnPajH53TNGi/t9DhazG/sYLU7Omsxi8W7CF1YHTo/Db94zeyzYVOqxeM9LJo9N
	nyaxe5yY8ZvFY/2WqyweZxYcYffYfLra4/MmuQDOKC6blNSczLLUIn27BK6MCweaWQt+R1dc
	PP6evYFxhUsXIyeHhICJxLT5h9hg7P/PfzGC2CwCqhL/v05iAbHZBNQlbtz4yQxiiwhoSHxa
	uJy9i5GLg1mgnUmi7fA0sCJhgXCJjrm7WUFsXgELiU87+thAioQEJjFJfH52hAkiIShxcuYT
	sAZmAS2JG/9eAsU5gGxpieX/OEDCnAJ2Evde7QI7SFRAWeLAtuNMIHMkBG6zSSy9foUZ4lJJ
	iYMrbrBMYBSYhWTsLCRjZyGMXcDIvIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMCaW1f6J3sH4
	6ULwIUYBDkYlHt4Em/upQqyJZcWVuYcYJTiYlUR4ZQTvpgrxpiRWVqUW5ccXleakFh9ilOZg
	URLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgZDSQVK+weHtRl9P7VtGrhkm3tdfIp65UfnSG
	zzzQ8OwXywUrTm4Wcl/l2+T55wbjMsn27X1XAyfaCDbeLOVrfhjOPdfunreLSfoKvi7ZxH+v
	3Ep8py4u2fL92aTp2xd4KTdEPD9TzBOg1C72rupGMFNUT1vM8ogXG10nXpzhP32tzcW8HUKC
	SizFGYmGWsxFxYkAt6QMTYUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXC5WfdrJvp+iDV4ON7GYs569ewWaze5Gtx
	eO5JVovLu+awWdxb85/VYvK7Z4wW9/scLGY39jFanJw1mcXi3YQvrA5cHoffvGf2WLCp1GPx
	npdMHps+TWL3ODHjN4vH4hcfmDzWb7nK4nFmwRF2j82nqz0+b5IL4IrisklJzcksSy3St0vg
	yrhwoJm14Hd0xcXj79kbGFe4dDFyckgImEj8f/6LEcRmEVCV+P91EguIzSagLnHjxk9mEFtE
	QEPi08Ll7F2MXBzMAu1MEm2Hp4EVCQuES3TM3c0KYvMKWEh82tHHBlIkJDCJSeLzsyNMEAlB
	iZMzn4A1MAtoSdz49xIozgFkS0ss/8cBEuYUsJO492oXG4gtKqAscWDbcaYJjLyzkHTPQtI9
	C6F7ASPzKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMAAX1b7Z+IOxi+X3Q8xCnAwKvHwJtjc
	TxViTSwrrsw9xCjBwawkwisjeDdViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6Yklq
	dmpqQWoRTJaJg1OqgdHA5EnfzqPSs4IkZ/m5bN14dMbJ9T/FHPPnGYe9NlXjerDqYHzFRua9
	z3/HX5Naq2+d/nEpy2f5l4v6/jn0ZV/cEOM/7yrXPcWZCheDs/oUGtYclqq6Gr2ulD3V9+j3
	fYlVdXGi6fJxkhanE56GnenaqaDAfGALz57wNqsdn6JjJ1mWrn/9860SS3FGoqEWc1FxIgDh
	zAb+bAIAAA==
X-CFilter-Loop: Reflected

On Thu, Feb 29, 2024 at 04:41:18PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Thu, Feb 29, 2024 at 02:21:15PM +0800, Huang, Ying wrote:
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> 
> >> > On Mon, Feb 26, 2024 at 02:06:30PM +0100, Michal Hocko wrote:
> >> >> [CC Mel, Vlastimil and Johannes for awareness]
> >> >> 
> >> >> On Fri 23-02-24 14:44:07, Byungchul Park wrote:
> >> >> > Changes from v2:
> >> >> > 	1. Change the condition to stop cache_trim_mode.
> >> >> > 
> >> >> > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> >> >> > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> >> >> > 	          the mode didn't work in the previous turn.
> >> >> > 
> >> >> > 	   (feedbacked by Huang Ying)
> >> >> > 
> >> >> > 	2. Change the test result in the commit message after testing
> >> >> > 	   with the new logic.
> >> >> > 
> >> >> > Changes from v1:
> >> >> > 	1. Add a comment describing why this change is necessary in code
> >> >> > 	   and rewrite the commit message with how to reproduce and what
> >> >> > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> >> >> > 	   Yu Zhao)
> >> >> > 	2. Change the condition to avoid cache_trim_mode from
> >> >> > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> >> >> > 	   where the priority goes to zero all the way. (feedbacked by
> >> >> > 	   Yu Zhao)
> >> >> > 
> >> >> > --->8---
> >> >> > >From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> >> >> > From: Byungchul Park <byungchul@sk.com>
> >> >> > Date: Fri, 23 Feb 2024 13:47:16 +0900
> >> >> > Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
> >> >> > 
> >> >> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> >> > pages.  However, it should be more careful to turn on the mode because
> >> >> > it's going to prevent anon pages from being reclaimed even if there are
> >> >> > a huge number of anon pages that are cold and should be reclaimed.  Even
> >> >> > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> >> > stopping kswapd from functioning until direct reclaim eventually works
> >> >> > to resume kswapd.
> >> >> > 
> >> >> > So do not turn on cache_trim_mode if the mode doesn't work, especially
> >> >> > while the sytem is struggling against reclaim.
> >> >> > 
> >> >> > The problematic behavior can be reproduced by:
> >> >> > 
> >> >> >    CONFIG_NUMA_BALANCING enabled
> >> >> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> >> >    numa node0 (8GB local memory, 16 CPUs)
> >> >> >    numa node1 (8GB slow tier memory, no CPUs)
> >> >> > 
> >> >> >    Sequence:
> >> >> > 
> >> >> >    1) echo 3 > /proc/sys/vm/drop_caches
> >> >> >    2) To emulate the system with full of cold memory in local DRAM, run
> >> >> >       the following dummy program and never touch the region:
> >> >> > 
> >> >> >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> >> >> > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >> >> > 
> >> >> >    3) Run any memory intensive work e.g. XSBench.
> >> >> >    4) Check if numa balancing is working e.i. promotion/demotion.
> >> >> >    5) Iterate 1) ~ 4) until numa balancing stops.
> >> >> > 
> >> >> > With this, you could see that promotion/demotion are not working because
> >> >> > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> >> > 
> >> >> > Interesting vmstat delta's differences between before and after are like:
> >> >> > 
> >> >> >    +-----------------------+-------------------------------+
> >> >> >    | interesting vmstat	   | before	   | after	   |
> >> >> >    +-----------------------+-------------------------------+
> >> >> >    | nr_inactive_anon	   | 321935	   | 1636737	   |
> >> >> >    | nr_active_anon	   | 1780700	   | 465913	   |
> >> >> >    | nr_inactive_file	   | 30425	   | 35711	   |
> >> >> >    | nr_active_file	   | 14961	   | 8698	   |
> >> >> >    | pgpromote_success	   | 356	   | 1267785	   |
> >> >> >    | pgpromote_candidate   | 21953245	   | 1745631	   |
> >> >> >    | pgactivate		   | 1844523	   | 3309867	   |
> >> >> >    | pgdeactivate	   | 50634	   | 1545041	   |
> >> >> >    | pgfault		   | 31100294	   | 6411036	   |
> >> >> >    | pgdemote_kswapd	   | 30856	   | 2267467	   |
> >> >> >    | pgscan_kswapd	   | 1861981	   | 7729231	   |
> >> >> >    | pgscan_anon	   | 1822930	   | 7667544	   |
> >> >> >    | pgscan_file	   | 39051	   | 61687	   |
> >> >> >    | pgsteal_anon	   | 386	   | 2227217	   |
> >> >> >    | pgsteal_file	   | 30470	   | 40250	   |
> >> >> >    | pageoutrun		   | 30		   | 457	   |
> >> >> >    | numa_hint_faults	   | 27418279	   | 2752289	   |
> >> >> >    | numa_pages_migrated   | 356	   | 1267785 	   |
> >> >> >    +-----------------------+-------------------------------+
> >> >> > 
> >> >> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> >> > ---
> >> >> >  mm/vmscan.c | 24 +++++++++++++++++++-----
> >> >> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >> >> > 
> >> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> >> > index bba207f41b14..f7312d831fed 100644
> >> >> > --- a/mm/vmscan.c
> >> >> > +++ b/mm/vmscan.c
> >> >> > @@ -127,6 +127,9 @@ struct scan_control {
> >> >> >  	/* One of the zones is ready for compaction */
> >> >> >  	unsigned int compaction_ready:1;
> >> >> >  
> >> >> > +	/* If the last try was reclaimable */
> >> >> > +	unsigned int reclaimable:1;
> >> >> > +
> >> >> >  	/* There is easily reclaimable cold cache in the current node */
> >> >> >  	unsigned int cache_trim_mode:1;
> >> >> >  
> >> >> > @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> >> >  	 * If we have plenty of inactive file pages that aren't
> >> >> >  	 * thrashing, try to reclaim those first before touching
> >> >> >  	 * anonymous pages.
> >> >> > +	 *
> >> >> > +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> >> >> > +	 * is not working while struggling against reclaim. So do not
> >> >> > +	 * turn it on if so. Note the highest priority of kswapd is 1.
> >> >> >  	 */
> >> >> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> >> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> >> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >> >> > +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
> >> >> >  		sc->cache_trim_mode = 1;
> >> >> >  	else
> >> >> >  		sc->cache_trim_mode = 0;
> >> >
> >> > The overall goal makes sense to me.
> >> >
> >> > file >> priority is just a heuristic that there are enough potential
> >> > candidate pages, not a guarantee that any forward progress will
> >> > happen. So it makes sense to retry without before failing.
> >> >
> >> > The way you wrote this conditional kind of hurts my head,
> >> > though. Please don't write negations of complex terms like this.
> >> >
> >> > It expands to this:
> >> >
> >> > 	!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1
> >> >
> >> > which I'm not sure makes sense. Surely it should be something like
> >> >
> >> > 	!sc->cache_trim_mode && sc->reclaimable && sc->priority > 1
> >> >
> >> > instead?
> >> >
> >> > Also
> >> >
> >> > 	if (!sc->cache_trim_mode)
> >> > 		sc->cache_trim_mode = 1
> >> > 	else
> >> > 		sc->cache_trim_mode = 0
> >> >
> >> > will toggle on every loop. So if direct reclaim runs through a
> >> > zonelist, it'll cache trim every other numa node...?
> >> >
> >> >> > @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >> >  {
> >> >> >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> >> >> >  	struct lruvec *target_lruvec;
> >> >> > -	bool reclaimable = false;
> >> >> >  
> >> >> >  	if (lru_gen_enabled() && root_reclaim(sc)) {
> >> >> >  		lru_gen_shrink_node(pgdat, sc);
> >> >> > @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >> >  	nr_reclaimed = sc->nr_reclaimed;
> >> >> >  	nr_scanned = sc->nr_scanned;
> >> >> >  
> >> >> > +	/*
> >> >> > +	 * Reset to the default values at the start.
> >> >> > +	 */
> >> >> > +	if (sc->priority == DEF_PRIORITY) {
> >> >> > +		sc->reclaimable = 1;
> >> >> > +		sc->cache_trim_mode = 0;
> >> >> > +	}
> >> >> > +
> >> >> >  	prepare_scan_control(pgdat, sc);
> >> >> >  
> >> >> >  	shrink_node_memcgs(pgdat, sc);
> >> >> > @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >> >  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> >> >> >  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
> >> >> >  
> >> >> > -	if (nr_node_reclaimed)
> >> >> > -		reclaimable = true;
> >> >> > +	sc->reclaimable = !!nr_node_reclaimed;
> >> >
> >> > The scope of this doesn't quite make sense. If direct reclaim scans
> >> > multiple nodes, reclaim failure on the first node would disable cache
> >> > trim mode on the second node, which is totally unrelated.
> >> >
> >> > I think it needs separate paths for direct reclaim and kswapd. For
> >> > direct reclaim, the retry should be before these similar retry catches
> >> > in do_try_to_free_pages(), after all zones have been considered:
> >> >
> >> > 	/*
> >> > 	 * We make inactive:active ratio decisions based on the node's
> >> > 	 * composition of memory, but a restrictive reclaim_idx or a
> >> > 	 * memory.low cgroup setting can exempt large amounts of
> >> > 	 * memory from reclaim. Neither of which are very common, so
> >> > 	 * instead of doing costly eligibility calculations of the
> >> > 	 * entire cgroup subtree up front, we assume the estimates are
> >> > 	 * good, and retry with forcible deactivation if that fails.
> >> > 	 */
> >> > 	if (sc->skipped_deactivate) {
> >> > 		sc->priority = initial_priority;
> >> > 		sc->force_deactivate = 1;
> >> > 		sc->skipped_deactivate = 0;
> >> > 		goto retry;
> >> > 	}
> >> >
> >> > 	/* Untapped cgroup reserves?  Don't OOM, retry. */
> >> > 	if (sc->memcg_low_skipped) {
> >> > 		sc->priority = initial_priority;
> >> > 		sc->force_deactivate = 0;
> >> > 		sc->memcg_low_reclaim = 1;
> >> > 		sc->memcg_low_skipped = 0;
> >> > 		goto retry;
> >> > 	}
> >> 
> >> In get_scan_count(), we have
> >> 
> >> 	if (!sc->priority && swappiness) {
> >> 		scan_balance = SCAN_EQUAL;
> >> 		goto out;
> >> 	}
> >
> > Even though this can mitigate the issue for direct reclaim, it's still
> > suffering from the problem while direct reclaim goes from DEF_PRIORITY
> > to 1. What we need is not a mitigation but making things right.
> 
> Whether does it cause issue for you?  IMHO, it's the first step to prove
> this is a real problem.

I'm not strongly arguing. It'd be still okay to fix the real problem
that I faced with kswapd.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > Thoughts?
> >
> > 	Byungchul
> >
> >> So, we don't really need the heuristics in direct reclaim path.  So, one
> >> choice is to constrain this in kswapd reclaim only.
> >> 
> >> --
> >> Best Regards,
> >> Huang, Ying
> >> 
> >> 
> >> > and for kswapd it looks like it should be in balance_pgdat(), after
> >> > the priority loop, before increasing kswapd_failures.
> >> >
> >> > Instead of sc->reclaimable, which is very broad, it would be better to
> >> > call it sc->may_cache_trim_mode. This is in line with a bunch of other
> >> > such mechanisms in scan_control.

