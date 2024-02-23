Return-Path: <linux-kernel+bounces-77617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D8C86081F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC22842CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F39470;
	Fri, 23 Feb 2024 01:11:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D6B8F51
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650686; cv=none; b=AYaHsOD/sBKehvmDZuKv/moJED1wG5CpGLRhdY5JqH+xm+yj46T0kBX9NztaOPILfoKy52V2dIp6a5RRbDDUC99IDbSPZr+Qc4W8C+vf/3FJ5R0ubmshRyUJZrrCdIf3iTfvz0PD0LHcrspKYi2mGixapmVXU3FzjkvJmlp8m84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650686; c=relaxed/simple;
	bh=SmKfIYBTm4swIgKIl3Cr2iUXbUjQBb4wpLZ4f+ma8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tM7RlhVZxERjyQ6aKyLH0Mi5WA7ysKcTYNePao4b5kqVVuhdQL+Q1dGwCwpmPIZZlVkX2PDe0QrXAade05M4EwsBn3x8tz4zknuo3AKO/C1MonqJme+du4xp40bH6iIZUWQA3shUot1lp/2OArw1lUe+5oNPm7D5x/hPWZvwUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-6a-65d7f0b6eec8
Date: Fri, 23 Feb 2024 10:11:12 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high
 scan priorities
Message-ID: <20240223011112.GA45352@system.software.com>
References: <20240222070817.70515-1-byungchul@sk.com>
 <87sf1kj3nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240222092042.GA33967@system.software.com>
 <20240222094900.GA13076@system.software.com>
 <20240222100129.GB13076@system.software.com>
 <87o7c8htzo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7c8htzo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke62D9dTDSZd47KYs34Nm8XlXXPY
	LO6t+c9qMfndM0aLk7Mms1i8m/CF1YHNY8GmUo/Fe14yeWz6NInd48SM3ywem09Xe3zeJBfA
	FsVlk5Kak1mWWqRvl8CVMeuYeME554qVza+ZGhhnGnUxcnJICJhItK/5yQxj/26azAJiswio
	Snw7vpYVxGYTUJe4cQOiRkRAQ+LTwuXsXYxcHMwCExglul9NYwNJCAtES7R8+8gOYvMKWEg0
	r/zGBFIkJLCKSeLoyROsEAlBiZMzn4BtYBbQkrjx7yVQEQeQLS2x/B8HiMkpYCdxdV4BSIWo
	gLLEgW3HwcZICKxhk/j8dz07xKGSEgdX3GCZwCgwC8nUWUimzkKYuoCReRWjUGZeWW5iZo6J
	XkZlXmaFXnJ+7iZGYFgvq/0TvYPx04XgQ4wCHIxKPLwFiddThVgTy4orcw8xSnAwK4nwspRf
	SRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAWKhw6LWA
	puja2b9ef7KXiGl8VhN9tO7hmxPhnQtEN37ha/Ftai7sZ5j0bfe/prdLI5ynHbctt//8Z3+6
	s9nct3VRbKa7Gc9XcXMd0/n+TL5ZmuGLuWV+bTe36Ptj1YLMB5VOGO1kzBU1X6ittP7WOsVP
	X483hbkdrP6fdPx/5M2zit5nbgr4KbEUZyQaajEXFScCAFyxor5nAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLvtw/VUg0VXGC3mrF/DZnF47klW
	i8u75rBZ3Fvzn9Vi8rtnjBYnZ01msXg34QurA7vHgk2lHov3vGTy2PRpErvHiRm/WTwWv/jA
	5LH5dLXH501yAexRXDYpqTmZZalF+nYJXBmzjokXnHOuWNn8mqmBcaZRFyMnh4SAicTvpsks
	IDaLgKrEt+NrWUFsNgF1iRs3fjKD2CICGhKfFi5n72Lk4mAWmMAo0f1qGhtIQlggWqLl20d2
	EJtXwEKieeU3JpAiIYFVTBJHT55ghUgISpyc+QRsA7OAlsSNfy+BijiAbGmJ5f84QExOATuJ
	q/MKQCpEBZQlDmw7zjSBkXcWkuZZSJpnITQvYGRexSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJ
	ERiky2r/TNzB+OWy+yFGAQ5GJR7egsTrqUKsiWXFlbmHGCU4mJVEeFnKr6QK8aYkVlalFuXH
	F5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MPI8Fn5pafTnYgdz6s2e584f
	Vjbctn1eOiNZtvatdtWSMpnEdI9PF5lMGZb3Tbc8XLZnW/DW6M286jHhAldbDN8aHdYw81wb
	93vXIzPGu/0BKt39+WcXpMlt5n7yrr7Czibt5/qU01ksbhLuR2/KH3WZ8bpji7aRqofd4kv8
	q9sk9MxkV2xapsRSnJFoqMVcVJwIAE/IwOFOAgAA
X-CFilter-Loop: Reflected

On Fri, Feb 23, 2024 at 09:03:39AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Thu, Feb 22, 2024 at 06:49:00PM +0900, Byungchul Park wrote:
> >> On Thu, Feb 22, 2024 at 06:20:42PM +0900, Byungchul Park wrote:
> >> > On Thu, Feb 22, 2024 at 04:37:16PM +0800, Huang, Ying wrote:
> >> > > Byungchul Park <byungchul@sk.com> writes:
> >> > > 
> >> > > > Changes from v1:
> >> > > > 	1. Add a comment describing why this change is necessary in code
> >> > > > 	   and rewrite the commit message with how to reproduce and what
> >> > > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> >> > > > 	   Yu Zhao)
> >> > > > 	2. Change the condition to avoid cache_trim_mode from
> >> > > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> >> > > > 	   where the priority goes to zero all the way. (feedbacked by
> >> > > > 	   Yu Zhao)
> >> > > >
> >> > > > --->8---
> >> > > > From 07e0baab368160e50b6ca35d95745168aa60e217 Mon Sep 17 00:00:00 2001
> >> > > > From: Byungchul Park <byungchul@sk.com>
> >> > > > Date: Thu, 22 Feb 2024 14:50:17 +0900
> >> > > > Subject: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high scan priorities
> >> > > >
> >> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> > > > pages.  However, it should be more careful to turn on the mode because
> >> > > > it's going to prevent anon pages from being reclaimed even if there are
> >> > > > a huge number of anon pages that are cold and should be reclaimed.  Even
> >> > > > worse, that can lead kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> > > > stopping kswapd until direct reclaim eventually works to resume kswapd.
> >> > > > So this is more like a bug fix than a performance improvement.
> >> > > >
> >> > > > The problematic behavior can be reproduced by:
> >> > > >
> >> > > >    CONFIG_NUMA_BALANCING enabled
> >> > > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> > > >
> >> > > >    numa node0 (8GB local memory, 16 CPUs)
> >> > > >    numa node1 (8GB slow tier memory, no CPUs)
> >> > > >
> >> > > >    Sequence:
> >> > > >
> >> > > >    1) echo 3 > /proc/sys/vm/drop_caches
> >> > > >    2) To emulate the system with full of cold memory in local DRAM, run
> >> > > >       the following dummy program and never touch the region:
> >> > > >
> >> > > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> >> > > > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >> > > >
> >> > > >    3) Run any memory intensive work e.g. XSBench.
> >> > > >    4) Check if numa balancing is working e.i. promotion/demotion.
> >> > > >    5) Iterate 1) ~ 4) until kswapd stops.
> >> > > >
> >> > > > With this, you could eventually see that promotion/demotion are not
> >> > > > working because kswapd has stopped due to ->kswapd_failures >=
> >> > > > MAX_RECLAIM_RETRIES.
> >> > > >
> >> > > > Interesting vmstat delta's differences between before and after are like:
> >> > > >
> >> > > >    -nr_inactive_anon 321935
> >> > > >    -nr_active_anon 1780700
> >> > > >    -nr_inactive_file 30425
> >> > > >    -nr_active_file 14961
> >> > > >    -pgpromote_success 356
> >> > > >    -pgpromote_candidate 21953245
> >> > > >    -pgactivate 1844523
> >> > > >    -pgdeactivate 50634
> >> > > >    -pgfault 31100294
> >> > > >    -pgdemote_kswapd 30856
> >> > > >    -pgscan_kswapd 1861981
> >> > > >    -pgscan_anon 1822930
> >> > > >    -pgscan_file 39051
> >> > > >    -pgsteal_anon 386
> >> > > >    -pgsteal_file 30470
> >> > > >    -pageoutrun 30
> >> > > >    -numa_hint_faults 27418279
> >> > > >    -numa_pages_migrated 356
> >> > > >
> >> > > >    +nr_inactive_anon 1662306
> >> > > >    +nr_active_anon 440303
> >> > > >    +nr_inactive_file 27669
> >> > > >    +nr_active_file 1654
> >> > > >    +pgpromote_success 1314102
> >> > > >    +pgpromote_candidate 1892525
> >> > > >    +pgactivate 3284457
> >> > > >    +pgdeactivate 1527504
> >> > > >    +pgfault 6847775
> >> > > >    +pgdemote_kswapd 2142047
> >> > > >    +pgscan_kswapd 7496588
> >> > > >    +pgscan_anon 7462488
> >> > > >    +pgscan_file 34100
> >> > > >    +pgsteal_anon 2115661
> >> > > >    +pgsteal_file 26386
> >> > > >    +pageoutrun 378
> >> > > >    +numa_hint_faults 3220891
> >> > > >    +numa_pages_migrated 1314102
> >> > > >
> >> > > >    where -: before this patch, +: after this patch
> >> > > >
> >> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> > > > ---
> >> > > >  mm/vmscan.c | 10 +++++++++-
> >> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > > > index bba207f41b14..6eda59fce5ee 100644
> >> > > > --- a/mm/vmscan.c
> >> > > > +++ b/mm/vmscan.c
> >> > > > @@ -2266,9 +2266,17 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> > > >  	 * If we have plenty of inactive file pages that aren't
> >> > > >  	 * thrashing, try to reclaim those first before touching
> >> > > >  	 * anonymous pages.
> >> > > > +	 *
> >> > > > +	 * However, the condition 'sc->cache_trim_mode == 1' all through
> >> > > > +	 * the scan priorties might lead reclaim failure. If it keeps
> >> > > > +	 * MAX_RECLAIM_RETRIES times, then kswapd would get stopped even
> >> > > > +	 * if there are still plenty anon pages to reclaim, which is not
> >> > > > +	 * desirable. So do not use cache_trim_mode when reclaim is not
> >> > > > +	 * smooth e.i. high scan priority.
> >> > > >  	 */
> >> > > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> > > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> > > > +	if (sc->priority > 1 && file >> sc->priority &&
> >> > > > +	    !(sc->may_deactivate & DEACTIVATE_FILE))
> >> > > >  		sc->cache_trim_mode = 1;
> >> > > >  	else
> >> > > >  		sc->cache_trim_mode = 0;
> >> > > 
> >> > > In get_scan_count(), there's following code,
> >> > > 
> >> > > 	/*
> >> > > 	 * Do not apply any pressure balancing cleverness when the
> >> > > 	 * system is close to OOM, scan both anon and file equally
> >> > > 	 * (unless the swappiness setting disagrees with swapping).
> >> > > 	 */
> >> > > 	if (!sc->priority && swappiness) {
> >> > > 		scan_balance = SCAN_EQUAL;
> >> > > 		goto out;
> >> > > 	}
> >> > > 
> >> > > So, swappiness is 0 in you system?  Please check it.  If it's not 0,
> >> > > please check why this doesn't help.
> >> > 
> >> > Nice information! Then the change should be:
> >> > 
> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > index bba207f41b14..91f9bab86e92 100644
> >> > --- a/mm/vmscan.c
> >> > +++ b/mm/vmscan.c
> >> > @@ -2357,7 +2357,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> >> >  	 * system is close to OOM, scan both anon and file equally
> >> >  	 * (unless the swappiness setting disagrees with swapping).
> >> >  	 */
> >> > -	if (!sc->priority && swappiness) {
> >> > +	if (sc->priority <= 1 && swappiness) {
> >> >  		scan_balance = SCAN_EQUAL;
> >> >  		goto out;
> >> >  	}
> >> 
> >> Or:
> >> 
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index bba207f41b14..c54371a398b1 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -6896,7 +6896,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >>  
> >>  		if (raise_priority || !nr_reclaimed)
> >>  			sc.priority--;
> >> -	} while (sc.priority >= 1);
> >> +	} while (sc.priority >= 0);
> >>  
> >>  	if (!sc.nr_reclaimed)
> >>  		pgdat->kswapd_failures++;
> >
> > +cc Mel Gorman
> >
> > I just found this was intended. See commit 9aa41348a8d11 ("mm: vmscan:
> > do not allow kswapd to scan at maximum priority"). Mel Gorman didn't want
> > to make kswapd too much aggressive. However, does it make sense to stop
> > kswapd even if there are plenty cold anon pages to reclaim and make the
> > system wait for direct reclaim?
> 
> Maybe we can play with cache_trim_mode, for example, if sc.nr_reclaimed
> == 0 and sc.cache_trim_mode == true, force disabling cache_trim_mode in
> the next round?

Looks reasonable to me. I will try.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > Thoughts?
> >
> > 	Byungchul
> >
> >> ---
> >> 
> >> 	Byungchul
> >> 
> >> > Worth noting that the priority goes from DEF_PRIORITY to 1 in
> >> > balance_pgdat() of kswapd. I will change how to fix to this if this
> >> > looks more reasonable.
> >> > 
> >> > 	Byungchul

