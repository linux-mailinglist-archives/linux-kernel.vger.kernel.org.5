Return-Path: <linux-kernel+bounces-78022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFAC860E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24A11F26907
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D315C8F9;
	Fri, 23 Feb 2024 09:35:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FBD22067
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680902; cv=none; b=iqYVr2Qdm2ccVjk6DtNMO/Oamvp5DPW+2f/GqBGhHHsje/aJPBBQd3r6rDvJLYDJQi9ehXhvT1PEUnFBhthg2DYNqaIArFyJg/J7JoAfq6ohs5s2RNgAsowoiL8S4PGrrJf1sITCYsN8XC09/APKXchB1/3ZPaQkT60SGO4zMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680902; c=relaxed/simple;
	bh=J3NqzqoAHq2OWVYdWyWTXQx4OoRWAJnnJAB0ik8r76Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0cogbINezqYKjUqy1yMw2/1YuVreh0+Sv6FJngYnTxmGa64hWSo+BNnWOH97u6gNcvGIBEHzi25Q9ftwM7za9oBayox04ApL8NEfHu0/stcuTGmUC8RSVzXZ+AN7de3SzZ6KtQx3vXns0aNUWBfYuYFdZUlCIWwwezgzkC4d64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-de-65d866b65faa
Date: Fri, 23 Feb 2024 18:34:41 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
Message-ID: <20240223093441.GA1612@system.software.com>
References: <20240223054407.14829-1-byungchul@sk.com>
 <87o7c7h6ql.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7c7h6ql.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXC9ZZnke62tBupBrtmGVjMWb+GzeLyrjls
	FvfW/Ge1ODlrMovFuwlfWB1YPRZsKvVYvOclk8emT5PYPU7M+M3i8XmTXABrFJdNSmpOZllq
	kb5dAlfGjTfXWQqeWlf8XjmHsYHxjE4XIyeHhICJxNxp19i7GDnA7I2vpUFMFgFViRVn4kEq
	2ATUJW7c+MkMYosIaEh8WricHcRmFqiVeHxnJhuILSwQLtExdzcriM0rYC6xt3kFWI2QQKZE
	y8XdzBBxQYmTM5+wQPRqSdz495IJZBWzgLTE8n8cIGFOATuJX9NvMoLYogLKEge2HQcq4QI6
	bA6bxO+FD9ghLpaUOLjiBssERoFZSMbOQjJ2FsLYBYzMqxiFMvPKchMzc0z0MirzMiv0kvNz
	NzECA3hZ7Z/oHYyfLgQfYhTgYFTi4S1IvJ4qxJpYVlyZe4hRgoNZSYSXpfxKqhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGDiHuR8daHjzd80HYe++R
	m74HcwI0leMvfk95v5dzjaWvcYKfyORIlWkWk7MLlcVTYvdmqe5/zzn/QOn8qCXePyfzrlS8
	tkZa+RPr76sOi2PC3CwUu25c+Hz7T/W3o56JnAsNa9IuH/BInRQVPDnhZ6BQRZH7ey5WmSMT
	zFfmOTUwSDV26hsqsRRnJBpqMRcVJwIAH5/Y51wCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsXC5WfdrLst7Uaqwf89mhZz1q9hszg89ySr
	xeVdc9gs7q35z2pxctZkFot3E76wOrB5LNhU6rF4z0smj02fJrF7nJjxm8Vj8YsPTB6fN8kF
	sEVx2aSk5mSWpRbp2yVwZdx4c52l4Kl1xe+VcxgbGM/odDFycEgImEhsfC0NYrIIqEqsOBPf
	xcjJwSagLnHjxk9mEFtEQEPi08Ll7CA2s0CtxOM7M9lAbGGBcImOubtZQWxeAXOJvc0rwGqE
	BDIlWi7uZoaIC0qcnPmEBaJXS+LGv5dMIKuYBaQllv/jAAlzCthJ/Jp+kxHEFhVQljiw7TjT
	BEbeWUi6ZyHpnoXQvYCReRWjSGZeWW5iZo6pXnF2RmVeZoVecn7uJkZgOC6r/TNxB+OXy+6H
	GAU4GJV4eAsSr6cKsSaWFVfmHmKU4GBWEuFlKb+SKsSbklhZlVqUH19UmpNafIhRmoNFSZzX
	Kzw1QUggPbEkNTs1tSC1CCbLxMEp1cC4KnClRe43Hiv/wD/VvbqhMzYwWF+9Jdifs9l0ttip
	BV8u1d7o7k6Xfb1ffV9s5wenTav2nuJbdLa35nENyzfzSsUYlm/KfZ+eb2NPUgk481Tx2T+b
	b/9iJ71g3Mex/F/GN+3LX3sPmTbMCDuqrladXhThG/y7WfSC/Q3DdgHBn5OuFt34IHlZiaU4
	I9FQi7moOBEAoRs+N0MCAAA=
X-CFilter-Loop: Reflected

On Fri, Feb 23, 2024 at 05:25:54PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Changes from v2:
> > 	1. Change the condition to stop cache_trim_mode.
> >
> > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> > 	          the mode didn't work in the previous turn.
> >
> > 	   (feedbacked by Huang Ying)
> >
> > 	2. Change the test result in the commit message after testing
> > 	   with the new logic.
> >
> > Changes from v1:
> > 	1. Add a comment describing why this change is necessary in code
> > 	   and rewrite the commit message with how to reproduce and what
> > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> > 	   Yu Zhao)
> > 	2. Change the condition to avoid cache_trim_mode from
> > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> > 	   where the priority goes to zero all the way. (feedbacked by
> > 	   Yu Zhao)
> >
> > --->8---
> > From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Fri, 23 Feb 2024 13:47:16 +0900
> > Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
> >
> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > pages.  However, it should be more careful to turn on the mode because
> > it's going to prevent anon pages from being reclaimed even if there are
> > a huge number of anon pages that are cold and should be reclaimed.  Even
> > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> > stopping kswapd from functioning until direct reclaim eventually works
> > to resume kswapd.
> >
> > So do not turn on cache_trim_mode if the mode doesn't work, especially
> > while the sytem is struggling against reclaim.
> >
> > The problematic behavior can be reproduced by:
> >
> >    CONFIG_NUMA_BALANCING enabled
> >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >    numa node0 (8GB local memory, 16 CPUs)
> >    numa node1 (8GB slow tier memory, no CPUs)
> >
> >    Sequence:
> >
> >    1) echo 3 > /proc/sys/vm/drop_caches
> >    2) To emulate the system with full of cold memory in local DRAM, run
> >       the following dummy program and never touch the region:
> >
> >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >
> >    3) Run any memory intensive work e.g. XSBench.
> >    4) Check if numa balancing is working e.i. promotion/demotion.
> >    5) Iterate 1) ~ 4) until numa balancing stops.
> >
> > With this, you could see that promotion/demotion are not working because
> > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> >
> > Interesting vmstat delta's differences between before and after are like:
> >
> >    +-----------------------+-------------------------------+
> >    | interesting vmstat	   | before	   | after	   |
> >    +-----------------------+-------------------------------+
> >    | nr_inactive_anon	   | 321935	   | 1636737	   |
> >    | nr_active_anon	   | 1780700	   | 465913	   |
> >    | nr_inactive_file	   | 30425	   | 35711	   |
> >    | nr_active_file	   | 14961	   | 8698	   |
> >    | pgpromote_success	   | 356	   | 1267785	   |
> >    | pgpromote_candidate   | 21953245	   | 1745631	   |
> >    | pgactivate		   | 1844523	   | 3309867	   |
> >    | pgdeactivate	   | 50634	   | 1545041	   |
> >    | pgfault		   | 31100294	   | 6411036	   |
> >    | pgdemote_kswapd	   | 30856	   | 2267467	   |
> >    | pgscan_kswapd	   | 1861981	   | 7729231	   |
> >    | pgscan_anon	   | 1822930	   | 7667544	   |
> >    | pgscan_file	   | 39051	   | 61687	   |
> >    | pgsteal_anon	   | 386	   | 2227217	   |
> >    | pgsteal_file	   | 30470	   | 40250	   |
> >    | pageoutrun		   | 30		   | 457	   |
> >    | numa_hint_faults	   | 27418279	   | 2752289	   |
> >    | numa_pages_migrated   | 356	   | 1267785 	   |
> >    +-----------------------+-------------------------------+
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  mm/vmscan.c | 24 +++++++++++++++++++-----
> >  1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bba207f41b14..f7312d831fed 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -127,6 +127,9 @@ struct scan_control {
> >  	/* One of the zones is ready for compaction */
> >  	unsigned int compaction_ready:1;
> >  
> > +	/* If the last try was reclaimable */
> > +	unsigned int reclaimable:1;
> > +
> >  	/* There is easily reclaimable cold cache in the current node */
> >  	unsigned int cache_trim_mode:1;
> >  
> > @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * If we have plenty of inactive file pages that aren't
> >  	 * thrashing, try to reclaim those first before touching
> >  	 * anonymous pages.
> > +	 *
> > +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> > +	 * is not working while struggling against reclaim. So do not
> > +	 * turn it on if so. Note the highest priority of kswapd is 1.
> >  	 */
> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> > +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
> 
> It's a little hard to digest the logic above for me, is it better to use
> the following logic?
> 
> 	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> 	    (!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1))

Looks fine to me. Thanks.

	Byungchul

> Otherwise, this looks good to me, feel free to add,
> 
> Acked-by: "Huang, Ying" <ying.huang@intel.com>
> 
> >  		sc->cache_trim_mode = 1;
> >  	else
> >  		sc->cache_trim_mode = 0;
> > @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  {
> >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> >  	struct lruvec *target_lruvec;
> > -	bool reclaimable = false;
> >  
> >  	if (lru_gen_enabled() && root_reclaim(sc)) {
> >  		lru_gen_shrink_node(pgdat, sc);
> > @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	nr_reclaimed = sc->nr_reclaimed;
> >  	nr_scanned = sc->nr_scanned;
> >  
> > +	/*
> > +	 * Reset to the default values at the start.
> > +	 */
> > +	if (sc->priority == DEF_PRIORITY) {
> > +		sc->reclaimable = 1;
> > +		sc->cache_trim_mode = 0;
> > +	}
> > +
> >  	prepare_scan_control(pgdat, sc);
> >  
> >  	shrink_node_memcgs(pgdat, sc);
> > @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> >  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
> >  
> > -	if (nr_node_reclaimed)
> > -		reclaimable = true;
> > +	sc->reclaimable = !!nr_node_reclaimed;
> >  
> >  	if (current_is_kswapd()) {
> >  		/*
> > @@ -5965,7 +5979,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * sleep. On reclaim progress, reset the failure counter. A
> >  	 * successful direct reclaim run will revive a dormant kswapd.
> >  	 */
> > -	if (reclaimable)
> > +	if (sc->reclaimable)
> >  		pgdat->kswapd_failures = 0;
> >  }
> 
> --
> Best Regards,
> Huang, Ying

