Return-Path: <linux-kernel+bounces-91563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03238713AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6AA1F23739
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF1E28684;
	Tue,  5 Mar 2024 02:37:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9524B52
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606248; cv=none; b=p1CcovitqE/bp6j9X25MbFEYHjTzCUpapI4oe29hp1lMrPd1KyPI8ImMMPXOLFp5XHsIRkQOy8EJWNJIUzVB7RVD0JsIYYQWPR6eDpGaOi/MEHNh3uM3iSUy/TZmgoMwLHNI8Z/faOaOcwrUbcY0jvW7a0B5Lm5ugj296V2mUro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606248; c=relaxed/simple;
	bh=rK8dOnCnddxrEeRZjsvpRViwu7JK52bkhY5puVfxrJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/2ZdJK5ElCcgS8878tmLmCLQDFY4ULu3lsfO9hqvXBr+85RtMcJ5CkN5uvGwhTeZ19kyvB30iV8oh94jW84z6diii1sCD/dKHfJwogovKKjM/kfvKX0l2RBmgCttds/h9+QeKkYLgfVxr6vUekcFFZp6oy+/6ISRJkbiFh826I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ec-65e68559f94a
Date: Tue, 5 Mar 2024 11:37:08 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH v6] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240305023708.GA60719@system.software.com>
References: <20240304033611.GD13332@system.software.com>
 <20240304082118.20499-1-byungchul@sk.com>
 <87zfvda1f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfvda1f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnoW5k67NUg2+3dSzmrF/DZrF6k6/F
	5V1z2CzurfnPanFy1mQWi3cTvrA6sHkcfvOe2WPBplKPxXteMnls+jSJ3ePEjN8sHp83yQWw
	RXHZpKTmZJalFunbJXBlHG1TLLhnU9F99jljA+ML7S5GTg4JAROJtYu6mWHs3Q9/sIDYLAIq
	EvMX/GIDsdkE1CVu3PgJViMioCHxaeFy9i5GLg5mgcmMEs/2rwFrEBZIk3h17DNYEa+AhcT0
	m22sIEVCAjMYJb7/nw+VEJQ4OfMJWAOzgJbEjX8vmboYOYBsaYnl/zhAwpwCdhI3/+wHKxcV
	UJY4sO04E8Rxa9gkjn+0hLAlJQ6uuMEygVFgFpKps5BMnYUwdQEj8ypGocy8stzEzBwTvYzK
	vMwKveT83E2MwLBeVvsnegfjpwvBhxgFOBiVeHhP7HuaKsSaWFZcmXuIUYKDWUmEt+bXk1Qh
	3pTEyqrUovz4otKc1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjGol/8zu+3q2
	TH8av/nth109oj+fTNqjJ/Jtr+7sCZ7Xr1kHaVV/Z33k1vzplkygaGGUSR7r1xcOBm/0lCd+
	1H11Nc8sw63xWcTPO9t+LXvItGIpx8HQJ1wHGx+E31+2vK/H6uX85gcbdZoLym9NfqJ6qsFl
	yxTes26KC9QOLzp5qOTl7hXZpzYrsRRnJBpqMRcVJwIAfoRaN2cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrBvZ+izVYPtkJYs569ewWaze5Gtx
	eO5JVovLu+awWdxb85/V4uSsySwW7yZ8YXVg9zj85j2zx4JNpR6L97xk8tj0aRK7x4kZv1k8
	Fr/4wOTxeZNcAHsUl01Kak5mWWqRvl0CV8bRNsWCezYV3WefMzYwvtDuYuTkkBAwkdj98AcL
	iM0ioCIxf8EvNhCbTUBd4saNn8wgtoiAhsSnhcvZuxi5OJgFJjNKPNu/BqxBWCBN4tWxz2BF
	vAIWEtNvtrGCFAkJzGCU+P5/PlRCUOLkzCdgDcwCWhI3/r1k6mLkALKlJZb/4wAJcwrYSdz8
	sx+sXFRAWeLAtuNMExh5ZyHpnoWkexZC9wJG5lWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiB
	Ybqs9s/EHYxfLrsfYhTgYFTi4b1w9GmqEGtiWXFl7iFGCQ5mJRHeml9PUoV4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYm7ZG2Ao3PfC7uc97skz9Et/7
	sjP2VSwX/B58hF97w1W+vwvj1mvIMahlHOgOuejwP7htZZNLdH1eyjo/Cc9p61y+LZLYxX/S
	KEgv4bvORplga7+rBS/Ydt/V6eE4oBvLPuNT8J2N5zp3bl6s3ZIyZVHR7yPvpaVifZ5xnqp4
	41z+MKojS9hViaU4I9FQi7moOBEAsg309U8CAAA=
X-CFilter-Loop: Reflected

On Tue, Mar 05, 2024 at 09:54:19AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Changes from v5:
> > 	1. Make it retry the kswapd's scan priority loop with
> > 	   cache_trim_mode off *only if* the mode didn't work in the
> > 	   previous loop. (feedbacked by Huang Ying)
> > 	2. Take into account 'break's from the priority loop when making
> > 	   the decision whether to retry. (feedbacked by Huang Ying)
> > 	3. Update the test result in the commit message.
> >
> > Changes from v4:
> > 	1. Make other scans start with may_cache_trim_mode = 1.
> >
> > Changes from v3:
> > 	1. Update the test result in the commit message with v4.
> > 	2. Retry the whole priority loop with cache_trim_mode off again,
> > 	   rather than forcing the mode off at the highest priority,
> > 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> >
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
> > From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Mon, 4 Mar 2024 15:27:37 +0900
> > Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> >
> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > pages.  However, it should be more careful to use the mode because it's
> > going to prevent anon pages from being reclaimed even if there are a
> > huge number of anon pages that are cold and should be reclaimed.  Even
> > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> > stopping kswapd from functioning until direct reclaim eventually works
> > to resume kswapd.
> >
> > So kswapd needs to retry its scan priority loop with cache_trim_mode
> > off again if the mode doesn't work for reclaim.
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
> >               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
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
> >    | interesting vmstat    | before        | after         |
> >    +-----------------------+-------------------------------+
> >    | nr_inactive_anon      | 321935        | 1664772       |
> >    | nr_active_anon        | 1780700       | 437834        |
> >    | nr_inactive_file      | 30425         | 40882         |
> >    | nr_active_file        | 14961         | 3012          |
> >    | pgpromote_success     | 356           | 1293122       |
> >    | pgpromote_candidate   | 21953245      | 1824148       |
> >    | pgactivate            | 1844523       | 3311907       |
> >    | pgdeactivate          | 50634         | 1554069       |
> >    | pgfault               | 31100294      | 6518806       |
> >    | pgdemote_kswapd       | 30856         | 2230821       |
> >    | pgscan_kswapd         | 1861981       | 7667629       |
> >    | pgscan_anon           | 1822930       | 7610583       |
> >    | pgscan_file           | 39051         | 57046         |
> >    | pgsteal_anon          | 386           | 2192033       |
> >    | pgsteal_file          | 30470         | 38788         |
> >    | pageoutrun            | 30            | 412           |
> >    | numa_hint_faults      | 27418279      | 2875955       |
> >    | numa_pages_migrated   | 356           | 1293122       |
> >    +-----------------------+-------------------------------+
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  mm/vmscan.c | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bba207f41b14..6fe45eca7766 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -108,6 +108,12 @@ struct scan_control {
> >  	/* Can folios be swapped as part of reclaim? */
> >  	unsigned int may_swap:1;
> >  
> > +	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
> > +	unsigned int no_cache_trim_mode:1;
> > +
> > +	/* Has cache_trim_mode failed at least once? */
> > +	unsigned int cache_trim_mode_failed:1;
> > +
> >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> >  	unsigned int proactive:1;
> >  
> > @@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * anonymous pages.
> >  	 */
> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> > +	    !sc->no_cache_trim_mode)
> >  		sc->cache_trim_mode = 1;
> >  	else
> >  		sc->cache_trim_mode = 0;
> > @@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	 */
> >  	if (reclaimable)
> >  		pgdat->kswapd_failures = 0;
> > +	else if (sc->cache_trim_mode)
> > +		sc->cache_trim_mode_failed = 1;
> >  }
> >  
> >  /*
> > @@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >  			sc.priority--;
> >  	} while (sc.priority >= 1);
> >  
> > +	/*
> > +	 * Restart only if it went through the priority loop all the way,
> > +	 * but cache_trim_mode didn't work.
> > +	 */
> > +	if (!sc.nr_reclaimed && sc.priority < 1 &&
> > +	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
> 
> Can we just use sc.cache_trim_mode (instead of
> sc.cache_trim_mode_failed) here?  That is, if cache_trim_mode is enabled

As Johannes mentioned, within a priority scan, all the numa nodes are
scanned each with its own value of cache_trim_mode. So we cannot use
cache_trim_mode for that purpose.

	Byungchul

> for priority == 1 and failed to reclaim, we will restart.  If this
> works, we can avoid to add another flag.
> 
> > +		sc.no_cache_trim_mode = 1;
> > +		goto restart;
> > +	}
> > +
> >  	if (!sc.nr_reclaimed)
> >  		pgdat->kswapd_failures++;
> 
> --
> Best Regards,
> Huang, Ying

