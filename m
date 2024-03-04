Return-Path: <linux-kernel+bounces-89997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6086F8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05567B20F65
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C02CA4;
	Mon,  4 Mar 2024 03:04:27 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200617C9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521466; cv=none; b=XmhTpVP62rjXyFsaypxh9TTT+UFBK3mzA7wFUW5+zTiGaVmmaAnnUn+pDQbDAlTLU+3PJhVrSST1/tUvEAOYyKz8hIK3+UzLMWRp7qF6s3exB5AFat+xQp/DgwlP1cPW/2PKupmqd3jgUI1hRlOfdo+PA8LXnS6NseRWYuZoK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521466; c=relaxed/simple;
	bh=6Uka+WO+/g4mEckWbgAamcXS+TEJ7EI3UVLdtAKbQys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPw44qqGjqg9JrHAQOKh3VkVD3VXok0RmvH67HqxKKFJmD1N7ySBG1I/0zHY1+cuWaDgQ1QH1orYD9igBtTESCM/siGHHkm235fAcop5DYCWQlW18hW9XOYFzwMyNemC8Zej/VY8ik+Rlhp6UFOlghRo5DmxLEcXRNYMm1s1Fn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c3-65e53a321a4b
Date: Mon, 4 Mar 2024 12:04:13 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH v5] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240304030413.GC13332@system.software.com>
References: <20240304023018.69705-1-byungchul@sk.com>
 <87bk7ubtd4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk7ubtd4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnka6R1dNUg5kbLSzmrF/DZrF6k6/F
	5V1z2CzurfnPanFy1mQWi3cTvrA6sHkcfvOe2WPBplKPxXteMnls+jSJ3ePEjN8sHp83yQWw
	RXHZpKTmZJalFunbJXBlHL79lqmg37/i0RyXBsZXFl2MnBwSAiYS187tZoOxj5+5xgpiswio
	SJzqOM0MYrMJqEvcuPETzBYR0JD4tHA5excjFwezwGRGiWf717CAJIQF0iRmfGwBK+IVsJD4
	uOAXE4gtJJApsfbkBFaIuKDEyZlPwOqZBbQkbvx7CVTDAWRLSyz/xwES5hSwk9j0rosRxBYV
	UJY4sO04E8guCYEVbBJNs36wQxwqKXFwxQ2WCYwCs5CMnYVk7CyEsQsYmVcxCmXmleUmZuaY
	6GVU5mVW6CXn525iBIb1sto/0TsYP10IPsQowMGoxMOb0fkkVYg1say4MvcQowQHs5IIb80v
	oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbG9gQNe/0N
	v641vhHOsGR9IlefK5Eywf3q23NWQlHTe1X+XFh4+NThLW+0XV4IbrniPePM4k4FpR1tO58L
	5r/sZ5sU7lax8vDdsyt1jwevCd9ZuePQ/CVdn078PsL7W2lC1qtM7/s/mc/wrE/tYRPeebhz
	9rQGR6XS+rJ1zpumK7Jumi/S21GqqcRSnJFoqMVcVJwIADZ2Vo5nAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrGtk9TTV4MoUHYs569ewWaze5Gtx
	eO5JVovLu+awWdxb85/V4uSsySwW7yZ8YXVg9zj85j2zx4JNpR6L97xk8tj0aRK7x4kZv1k8
	Fr/4wOTxeZNcAHsUl01Kak5mWWqRvl0CV8bh22+ZCvr9Kx7NcWlgfGXRxcjJISFgInH8zDVW
	EJtFQEXiVMdpZhCbTUBd4saNn2C2iICGxKeFy9m7GLk4mAUmM0o827+GBSQhLJAmMeNjC1gR
	r4CFxMcFv5hAbCGBTIm1JyewQsQFJU7OfAJWzyygJXHj30ugGg4gW1pi+T8OkDCngJ3Epndd
	jCC2qICyxIFtx5kmMPLOQtI9C0n3LITuBYzMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKD
	dFntn4k7GL9cdj/EKMDBqMTDO2HNk1Qh1sSy4srcQ4wSHMxKIrw1v4BCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjGlWl84z2yVVl9/iOxwpOkPmT5ju
	T0X/2X/X6m77mPO8Oc7EaPmuAzoit8s961/L65ZapGjrXdGZ+2P2lUWrY2Jf7F8pV70toWb+
	VVFWuXsqBZd8p/1x++/57+Oa/sc9rJNjexIPbZbSNshYX293wM5ov4+BQNC9gt1MxcxbH29y
	sf1cfJRJW4mlOCPRUIu5qDgRAOnet+lOAgAA
X-CFilter-Loop: Reflected

On Mon, Mar 04, 2024 at 10:53:11AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > Sorry for noise. I should've applied v5's change in v4.
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
> > --->8---
> > From 58f1a0e41b9feea72d7fd4bd7bed1ace592e6e4c Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Mon, 4 Mar 2024 11:24:40 +0900
> > Subject: [PATCH v5] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
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
> >    | nr_inactive_anon      | 321935        | 1646193       |
> >    | nr_active_anon        | 1780700       | 456388        |
> >    | nr_inactive_file      | 30425         | 27836         |
> >    | nr_active_file        | 14961         | 1217          |
> >    | pgpromote_success     | 356           | 1310120       |
> >    | pgpromote_candidate   | 21953245      | 1736872       |
> >    | pgactivate            | 1844523       | 3292443       |
> >    | pgdeactivate          | 50634         | 1526701       |
> >    | pgfault               | 31100294      | 6715375       |
> >    | pgdemote_kswapd       | 30856         | 1954199       |
> >    | pgscan_kswapd         | 1861981       | 7100099       |
> >    | pgscan_anon           | 1822930       | 7061135       |
> >    | pgscan_file           | 39051         | 38964         |
> >    | pgsteal_anon          | 386           | 1925214       |
> >    | pgsteal_file          | 30470         | 28985         |
> >    | pageoutrun            | 30            | 500           |
> >    | numa_hint_faults      | 27418279      | 3090773       |
> >    | numa_pages_migrated   | 356           | 1310120       |
> >    +-----------------------+-------------------------------+
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  mm/vmscan.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bba207f41b14..77948b0f8b5b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -108,6 +108,9 @@ struct scan_control {
> >  	/* Can folios be swapped as part of reclaim? */
> >  	unsigned int may_swap:1;
> >  
> > +	/* Can cache_trim_mode be turned on as part of reclaim? */
> > +	unsigned int may_cache_trim_mode:1;
> > +
> 
> Although it's generally not good to use negative logic, I think that
> it's better to name the flag as something like "no_cache_trim_mode" to
> make it easier to initialize the flag to its default value ("0").

No preference to me. But don't think it's better to use another of may_*
in scan_control as Johannes Weiner suggested?

> >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> >  	unsigned int proactive:1;
> >  
> > @@ -1500,6 +1503,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> >  	struct scan_control sc = {
> >  		.gfp_mask = GFP_KERNEL,
> >  		.may_unmap = 1,
> > +		.may_cache_trim_mode = 1,
> >  	};
> >  	struct reclaim_stat stat;
> >  	unsigned int nr_reclaimed;
> > @@ -2094,6 +2098,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
> >  		.may_writepage = 1,
> >  		.may_unmap = 1,
> >  		.may_swap = 1,
> > +		.may_cache_trim_mode = 1,
> >  		.no_demotion = 1,
> >  	};
> >  
> > @@ -2268,7 +2273,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * anonymous pages.
> >  	 */
> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> > +	    sc->may_cache_trim_mode)
> >  		sc->cache_trim_mode = 1;
> >  	else
> >  		sc->cache_trim_mode = 0;
> > @@ -5435,6 +5441,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
> >  		.may_writepage = true,
> >  		.may_unmap = true,
> >  		.may_swap = true,
> > +		.may_cache_trim_mode = 1,
> >  		.reclaim_idx = MAX_NR_ZONES - 1,
> >  		.gfp_mask = GFP_KERNEL,
> >  	};
> > @@ -6394,6 +6401,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >  		.may_writepage = !laptop_mode,
> >  		.may_unmap = 1,
> >  		.may_swap = 1,
> > +		.may_cache_trim_mode = 1,
> >  	};
> >  
> >  	/*
> > @@ -6439,6 +6447,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >  		.may_unmap = 1,
> >  		.reclaim_idx = MAX_NR_ZONES - 1,
> >  		.may_swap = !noswap,
> > +		.may_cache_trim_mode = 1,
> >  	};
> >  
> >  	WARN_ON_ONCE(!current->reclaim_state);
> > @@ -6482,6 +6491,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >  		.may_writepage = !laptop_mode,
> >  		.may_unmap = 1,
> >  		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
> > +		.may_cache_trim_mode = 1,
> >  		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> >  	};
> >  	/*
> > @@ -6744,6 +6754,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >  		.gfp_mask = GFP_KERNEL,
> >  		.order = order,
> >  		.may_unmap = 1,
> > +		.may_cache_trim_mode = 1,
> >  	};
> >  
> >  	set_task_reclaim_state(current, &sc.reclaim_state);
> > @@ -6898,8 +6909,14 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >  			sc.priority--;
> >  	} while (sc.priority >= 1);
> >  
> > -	if (!sc.nr_reclaimed)
> > +	if (!sc.nr_reclaimed) {
> > +		if (sc.may_cache_trim_mode) {
> 
> sc.may_cache_trim_mode && cache_trim_mode ?

I don't think so. cache_trim_mode has a chance to switch every
prepare_scan_control() like:

   if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
       sc->may_cache_trim_mode)                                          
	sc->cache_trim_mode = 1;                                      
   else                                                                  
	sc->cache_trim_mode = 0;                                      

So referring to the last value is not a good idea.

	Byungchul

> > +			sc.may_cache_trim_mode = 0;
> > +			goto restart;
> > +		}
> > +
> >  		pgdat->kswapd_failures++;
> > +	}
> >  
> >  out:
> >  	clear_reclaim_active(pgdat, highest_zoneidx);
> > @@ -7202,6 +7219,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
> >  		.may_writepage = 1,
> >  		.may_unmap = 1,
> >  		.may_swap = 1,
> > +		.may_cache_trim_mode = 1,
> >  		.hibernation_mode = 1,
> >  	};
> >  	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
> > @@ -7360,6 +7378,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >  		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
> >  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
> >  		.may_swap = 1,
> > +		.may_cache_trim_mode = 1,
> >  		.reclaim_idx = gfp_zone(gfp_mask),
> >  	};
> >  	unsigned long pflags;
> 
> --
> Best Regards,
> Huang, Ying

