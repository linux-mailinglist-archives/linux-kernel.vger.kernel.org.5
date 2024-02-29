Return-Path: <linux-kernel+bounces-86163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F5386C09C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60D3B21222
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683123EA88;
	Thu, 29 Feb 2024 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fi7q9jLh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728B3C697
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187668; cv=none; b=GLzk9x4sApXZsdyBLG9XVnLpX05juI287pOPsRPyXUp4UyKq1u2YStHp+FtucDK/8fg6R2b9fszBUsOZkXwKNS2Omq4qvthTcuJNvcHi8sTgAw3wSQVYw4LdJN5j1kg/955xo8c+ZDX3JBtwuQ8dmNqLEu21JDOweaQL+lzbbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187668; c=relaxed/simple;
	bh=lyXhQGaTLrbv4R0vVY7BLOJQmOM4hjtnKL1TAyehyXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=psAjXC8PSPOJ4Os4an6gGwJUk8tB9pWEbNX67Z685STvF2j9eH+L/tZiLYTbN9OCaC4hejtX9VeaqFIzo17bXC667q/CcGuIBMtbWWsdgWP4O3pSB4A4yqbjVFqSpIdAypmxGa/Madgj0vcqgwn6YEMwVBVgdFDZWrdxwtsKoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fi7q9jLh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709187666; x=1740723666;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lyXhQGaTLrbv4R0vVY7BLOJQmOM4hjtnKL1TAyehyXY=;
  b=fi7q9jLhnymwSXXvQ7LFRrSq2OqwO6eTBBFx4eg0BhRYQ407nH/zXF7j
   O7PF/DB8UNE0+48ev1zSsbZSn1lNuWuvJ4pRS226IGCDVVl5mkrtm7mS/
   82u1JupNmAZNsia4IWbAx1YY25lXmu83fSZeUoltDD51w0+VgTQsrdUmi
   4FpZN4LZ3U52MNL/HbNE05OKjSmw2H4c+pi0qHqzi82VpBT8xL/Q2PmHH
   0mAOHVpey4CtgMjlqdgnVPwiqFRBsZ/jIsv7nK9zIZGLNLStdJGXG9pPz
   9bWP/jhXEQxGDAPEOYMpAf+ita//eVwuZDFizOloTa7q1H6n5L04tZuQo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14786032"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="14786032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 22:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="38548903"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 22:21:02 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@suse.com>,
  <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,  <yuzhao@google.com>,
  "Mel Gorman" <mgorman@suse.de>,  Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
In-Reply-To: <20240229061056.GA72813@system.software.com> (Byungchul Park's
	message of "Thu, 29 Feb 2024 15:10:56 +0900")
References: <20240223054407.14829-1-byungchul@sk.com>
	<ZdyM1nS8a8UR1dw_@tiehlicka> <20240228223601.GA53666@cmpxchg.org>
	<20240229061056.GA72813@system.software.com>
Date: Thu, 29 Feb 2024 14:19:07 +0800
Message-ID: <87o7bzdc84.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Wed, Feb 28, 2024 at 05:36:01PM -0500, Johannes Weiner wrote:
>> On Mon, Feb 26, 2024 at 02:06:30PM +0100, Michal Hocko wrote:
>> > [CC Mel, Vlastimil and Johannes for awareness]
>> > 
>> > On Fri 23-02-24 14:44:07, Byungchul Park wrote:
>> > > Changes from v2:
>> > > 	1. Change the condition to stop cache_trim_mode.
>> > > 
>> > > 	   From - Stop it if it's at high scan priorities, 0 or 1.
>> > > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
>> > > 	          the mode didn't work in the previous turn.
>> > > 
>> > > 	   (feedbacked by Huang Ying)
>> > > 
>> > > 	2. Change the test result in the commit message after testing
>> > > 	   with the new logic.
>> > > 
>> > > Changes from v1:
>> > > 	1. Add a comment describing why this change is necessary in code
>> > > 	   and rewrite the commit message with how to reproduce and what
>> > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
>> > > 	   Yu Zhao)
>> > > 	2. Change the condition to avoid cache_trim_mode from
>> > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
>> > > 	   where the priority goes to zero all the way. (feedbacked by
>> > > 	   Yu Zhao)
>> > > 
>> > > --->8---
>> > > >From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
>> > > From: Byungchul Park <byungchul@sk.com>
>> > > Date: Fri, 23 Feb 2024 13:47:16 +0900
>> > > Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
>> > > 
>> > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
>> > > pages.  However, it should be more careful to turn on the mode because
>> > > it's going to prevent anon pages from being reclaimed even if there are
>> > > a huge number of anon pages that are cold and should be reclaimed.  Even
>> > > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
>> > > stopping kswapd from functioning until direct reclaim eventually works
>> > > to resume kswapd.
>> > > 
>> > > So do not turn on cache_trim_mode if the mode doesn't work, especially
>> > > while the sytem is struggling against reclaim.
>> > > 
>> > > The problematic behavior can be reproduced by:
>> > > 
>> > >    CONFIG_NUMA_BALANCING enabled
>> > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>> > >    numa node0 (8GB local memory, 16 CPUs)
>> > >    numa node1 (8GB slow tier memory, no CPUs)
>> > > 
>> > >    Sequence:
>> > > 
>> > >    1) echo 3 > /proc/sys/vm/drop_caches
>> > >    2) To emulate the system with full of cold memory in local DRAM, run
>> > >       the following dummy program and never touch the region:
>> > > 
>> > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
>> > > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
>> > > 
>> > >    3) Run any memory intensive work e.g. XSBench.
>> > >    4) Check if numa balancing is working e.i. promotion/demotion.
>> > >    5) Iterate 1) ~ 4) until numa balancing stops.
>> > > 
>> > > With this, you could see that promotion/demotion are not working because
>> > > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
>> > > 
>> > > Interesting vmstat delta's differences between before and after are like:
>> > > 
>> > >    +-----------------------+-------------------------------+
>> > >    | interesting vmstat	   | before	   | after	   |
>> > >    +-----------------------+-------------------------------+
>> > >    | nr_inactive_anon	   | 321935	   | 1636737	   |
>> > >    | nr_active_anon	   | 1780700	   | 465913	   |
>> > >    | nr_inactive_file	   | 30425	   | 35711	   |
>> > >    | nr_active_file	   | 14961	   | 8698	   |
>> > >    | pgpromote_success	   | 356	   | 1267785	   |
>> > >    | pgpromote_candidate   | 21953245	   | 1745631	   |
>> > >    | pgactivate		   | 1844523	   | 3309867	   |
>> > >    | pgdeactivate	   | 50634	   | 1545041	   |
>> > >    | pgfault		   | 31100294	   | 6411036	   |
>> > >    | pgdemote_kswapd	   | 30856	   | 2267467	   |
>> > >    | pgscan_kswapd	   | 1861981	   | 7729231	   |
>> > >    | pgscan_anon	   | 1822930	   | 7667544	   |
>> > >    | pgscan_file	   | 39051	   | 61687	   |
>> > >    | pgsteal_anon	   | 386	   | 2227217	   |
>> > >    | pgsteal_file	   | 30470	   | 40250	   |
>> > >    | pageoutrun		   | 30		   | 457	   |
>> > >    | numa_hint_faults	   | 27418279	   | 2752289	   |
>> > >    | numa_pages_migrated   | 356	   | 1267785 	   |
>> > >    +-----------------------+-------------------------------+
>> > > 
>> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > > ---
>> > >  mm/vmscan.c | 24 +++++++++++++++++++-----
>> > >  1 file changed, 19 insertions(+), 5 deletions(-)
>> > > 
>> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > > index bba207f41b14..f7312d831fed 100644
>> > > --- a/mm/vmscan.c
>> > > +++ b/mm/vmscan.c
>> > > @@ -127,6 +127,9 @@ struct scan_control {
>> > >  	/* One of the zones is ready for compaction */
>> > >  	unsigned int compaction_ready:1;
>> > >  
>> > > +	/* If the last try was reclaimable */
>> > > +	unsigned int reclaimable:1;
>> > > +
>> > >  	/* There is easily reclaimable cold cache in the current node */
>> > >  	unsigned int cache_trim_mode:1;
>> > >  
>> > > @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>> > >  	 * If we have plenty of inactive file pages that aren't
>> > >  	 * thrashing, try to reclaim those first before touching
>> > >  	 * anonymous pages.
>> > > +	 *
>> > > +	 * It doesn't make sense to keep cache_trim_mode on if the mode
>> > > +	 * is not working while struggling against reclaim. So do not
>> > > +	 * turn it on if so. Note the highest priority of kswapd is 1.
>> > >  	 */
>> > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
>> > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
>> > > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
>> > > +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
>> > >  		sc->cache_trim_mode = 1;
>> > >  	else
>> > >  		sc->cache_trim_mode = 0;
>> 
>> The overall goal makes sense to me.
>> 
>> file >> priority is just a heuristic that there are enough potential
>> candidate pages, not a guarantee that any forward progress will
>> happen. So it makes sense to retry without before failing.
>> 
>> The way you wrote this conditional kind of hurts my head,
>> though. Please don't write negations of complex terms like this.
>
> Okay. I won't.
>
>> It expands to this:
>> 
>> 	!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1
>> 
>> which I'm not sure makes sense. Surely it should be something like
>> 
>> 	!sc->cache_trim_mode && sc->reclaimable && sc->priority > 1
>
> It's a totally different condition as you know.
>
>> instead?
>> 
>> Also
>> 
>> 	if (!sc->cache_trim_mode)
>> 		sc->cache_trim_mode = 1
>> 	else
>> 		sc->cache_trim_mode = 0
>> 
>> will toggle on every loop. So if direct reclaim runs through a
>> zonelist, it'll cache trim every other numa node...?
>
> No way to toggle on every loop.
>
> What I tried was that:
>
> 	1. Don't turn it on again if it didn't work in the previous try.
> 	2. Let it go as it was if the priority is not that high though,
> 	   to keep the code as conservatively as possible.
>
> So again, the following condition is needed.
>
> 	(the original condition) &&
> 	(!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1)
>
>> > > @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>> > >  {
>> > >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
>> > >  	struct lruvec *target_lruvec;
>> > > -	bool reclaimable = false;
>> > >  
>> > >  	if (lru_gen_enabled() && root_reclaim(sc)) {
>> > >  		lru_gen_shrink_node(pgdat, sc);
>> > > @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>> > >  	nr_reclaimed = sc->nr_reclaimed;
>> > >  	nr_scanned = sc->nr_scanned;
>> > >  
>> > > +	/*
>> > > +	 * Reset to the default values at the start.
>> > > +	 */
>> > > +	if (sc->priority == DEF_PRIORITY) {
>
> This might need to be fixed if reclaim happens to start with other than
> DEF_PRIORITY. For now, reclaim always starts with the priority though.
>
>> > > +		sc->reclaimable = 1;
>> > > +		sc->cache_trim_mode = 0;
>> > > +	}
>
> For each shrink_node(), initialize all the variable at the start.
>
>> > > +
>> > >  	prepare_scan_control(pgdat, sc);
>> > >  
>> > >  	shrink_node_memcgs(pgdat, sc);
>> > > @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>> > >  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
>> > >  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
>> > >  
>> > > -	if (nr_node_reclaimed)
>> > > -		reclaimable = true;
>> > > +	sc->reclaimable = !!nr_node_reclaimed;
>> 
>> The scope of this doesn't quite make sense. If direct reclaim scans
>> multiple nodes, reclaim failure on the first node would disable cache
>> trim mode on the second node, which is totally unrelated.
>
> As I mentioned, reclaim for every node would start with an initialized
> value because *each node is totally unrelated to another*.

No.  Please take a look at do_try_to_free_pages(), for each priority, it
will iterate every node.  But fortunately, we may not need this
heuristics for direct reclaiming.

--
Best Regards,
Huang, Ying


