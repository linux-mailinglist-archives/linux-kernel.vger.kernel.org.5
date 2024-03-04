Return-Path: <linux-kernel+bounces-90016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B851686F8EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCE71C20A18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5CE4696;
	Mon,  4 Mar 2024 03:36:28 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F52F35
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709523387; cv=none; b=Zo1EikWRGahkNHtk8TDO20p+BPiH9mgG/B0dJldrFOjAxfn13z+AwfQhpjXUucJxdH2bYDLdvf873tNnpu+mSNRAwpBupNXbPxaC5Hbf43seYU09GLFFJHLf13CJZTf5Z0qo/8YH47JqIn83bCFSWDdrputfFMRhQ1ifoxT+Bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709523387; c=relaxed/simple;
	bh=lRXmpPTb26GY+opS+BFfxmzwgdMsrMTwhYv2Ci1NF3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvMTDi4lXaynoPIQv68CuknJZSLtfFwDcIQhJq8TarRm3YORnyCVWjl1foMoHf6GP0JMJKqIlNAIWUJD0/g9xxUEOlga55Q8x5LQlVWFUjo59DQH5PE+mtPBAwJDV48DOjswo+Gyy+gatnhs8ZQOO1S4XXLQhmvAjzGVUJlC2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-e5-65e541b0c539
Date: Mon, 4 Mar 2024 12:36:11 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH v5] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240304033611.GD13332@system.software.com>
References: <20240304023018.69705-1-byungchul@sk.com>
 <87bk7ubtd4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240304030413.GC13332@system.software.com>
 <877ciibrp9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ciibrp9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke5Gx6epBut0LOasX8NmsXqTr8Xl
	XXPYLO6t+c9qcXLWZBaLdxO+sDqweRx+857ZY8GmUo/Fe14yeWz6NInd48SM3ywenzfJBbBF
	cdmkpOZklqUW6dslcGVcfX+RtWBBZEXn/QmMDYztDl2MnBwSAiYSSx7tYYGx90zZBGazCKhI
	bPi2hAnEZhNQl7hx4ycziC0ioCHxaeFy9i5GLg5mgcmMEs/2rwFrEBZIk5jxsQWsiFfAQuJg
	701WkCIhgTOMEoemLGODSAhKnJz5BKyBWUBL4sa/l0AbOIBsaYnl/zhAwpwCdhJr+r8zgtii
	AsoSB7YdZ4I4bg2bxJSN/BC2pMTBFTdYJjAKzEIydRaSqbMQpi5gZF7FKJSZV5abmJljopdR
	mZdZoZecn7uJERjWy2r/RO9g/HQh+BCjAAejEg9vRueTVCHWxLLiytxDjBIczEoivDW/gEK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYAx9/n7rLJtDZ
	+nRnE88axl2K394vC9HoC95paNiSOKkkacOKu8eevV7UndlzxCN6ypWHNeWHeQw9OeuFt8lP
	Z/y6In1TxaEJEzYc8T/0T/TK5W8vdizpVPqaFvXlbqlWQ3jUl+/miyYvY3X6lxp/5NeupQvy
	1zvWhDoH+idfjzdUYXW1Wqg/X4mlOCPRUIu5qDgRAJ3w7eBnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsXC5WfdrLvB8WmqwaMpRhZz1q9hs1i9ydfi
	8NyTrBaXd81hs7i35j+rxclZk1ks3k34wurA7nH4zXtmjwWbSj0W73nJ5LHp0yR2jxMzfrN4
	LH7xgcnj8ya5APYoLpuU1JzMstQifbsEroyr7y+yFiyIrOi8P4GxgbHdoYuRk0NCwERiz5RN
	LCA2i4CKxIZvS5hAbDYBdYkbN34yg9giAhoSnxYuZ+9i5OJgFpjMKPFs/xqwBmGBNIkZH1vA
	ingFLCQO9t5kBSkSEjjDKHFoyjI2iISgxMmZT8AamAW0JG78ewm0gQPIlpZY/o8DJMwpYCex
	pv87I4gtKqAscWDbcaYJjLyzkHTPQtI9C6F7ASPzKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxN
	jMBAXVb7Z+IOxi+X3Q8xCnAwKvHwTljzJFWINbGsuDL3EKMEB7OSCG/NL6AQb0piZVVqUX58
	UWlOavEhRmkOFiVxXq/w1AQhgfTEktTs1NSC1CKYLBMHp1QDo7RUicLvQItZESe8RMSNtAPm
	rS04p6WnOzFuy88LLXFRt92yHiaGdMT96RIpYLn55W9dzoyqzz5rTcWK0he9uZN3SrL8ImOw
	aktMh+1W9Y0dog2VDlNUxUQ9A0/yK6yZXHNCdhsbEx/zmk1/l60N45WMuM7hMzf+i5jP7vfL
	tHMeKM7Z9YRDiaU4I9FQi7moOBEAKOlJN1ACAAA=
X-CFilter-Loop: Reflected

On Mon, Mar 04, 2024 at 11:29:06AM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Mon, Mar 04, 2024 at 10:53:11AM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > Sorry for noise. I should've applied v5's change in v4.
> >> >
> >> > Changes from v4:
> >> > 	1. Make other scans start with may_cache_trim_mode = 1.
> >> >
> >> > Changes from v3:
> >> > 	1. Update the test result in the commit message with v4.
> >> > 	2. Retry the whole priority loop with cache_trim_mode off again,
> >> > 	   rather than forcing the mode off at the highest priority,
> >> > 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> >> >
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
> >> > --->8---
> >> > From 58f1a0e41b9feea72d7fd4bd7bed1ace592e6e4c Mon Sep 17 00:00:00 2001
> >> > From: Byungchul Park <byungchul@sk.com>
> >> > Date: Mon, 4 Mar 2024 11:24:40 +0900
> >> > Subject: [PATCH v5] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> >> >
> >> > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> > pages.  However, it should be more careful to use the mode because it's
> >> > going to prevent anon pages from being reclaimed even if there are a
> >> > huge number of anon pages that are cold and should be reclaimed.  Even
> >> > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> > stopping kswapd from functioning until direct reclaim eventually works
> >> > to resume kswapd.
> >> >
> >> > So kswapd needs to retry its scan priority loop with cache_trim_mode
> >> > off again if the mode doesn't work for reclaim.
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
> >> >               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
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
> >> >    | interesting vmstat    | before        | after         |
> >> >    +-----------------------+-------------------------------+
> >> >    | nr_inactive_anon      | 321935        | 1646193       |
> >> >    | nr_active_anon        | 1780700       | 456388        |
> >> >    | nr_inactive_file      | 30425         | 27836         |
> >> >    | nr_active_file        | 14961         | 1217          |
> >> >    | pgpromote_success     | 356           | 1310120       |
> >> >    | pgpromote_candidate   | 21953245      | 1736872       |
> >> >    | pgactivate            | 1844523       | 3292443       |
> >> >    | pgdeactivate          | 50634         | 1526701       |
> >> >    | pgfault               | 31100294      | 6715375       |
> >> >    | pgdemote_kswapd       | 30856         | 1954199       |
> >> >    | pgscan_kswapd         | 1861981       | 7100099       |
> >> >    | pgscan_anon           | 1822930       | 7061135       |
> >> >    | pgscan_file           | 39051         | 38964         |
> >> >    | pgsteal_anon          | 386           | 1925214       |
> >> >    | pgsteal_file          | 30470         | 28985         |
> >> >    | pageoutrun            | 30            | 500           |
> >> >    | numa_hint_faults      | 27418279      | 3090773       |
> >> >    | numa_pages_migrated   | 356           | 1310120       |
> >> >    +-----------------------+-------------------------------+
> >> >
> >> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> > ---
> >> >  mm/vmscan.c | 23 +++++++++++++++++++++--
> >> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > index bba207f41b14..77948b0f8b5b 100644
> >> > --- a/mm/vmscan.c
> >> > +++ b/mm/vmscan.c
> >> > @@ -108,6 +108,9 @@ struct scan_control {
> >> >  	/* Can folios be swapped as part of reclaim? */
> >> >  	unsigned int may_swap:1;
> >> >  
> >> > +	/* Can cache_trim_mode be turned on as part of reclaim? */
> >> > +	unsigned int may_cache_trim_mode:1;
> >> > +
> >> 
> >> Although it's generally not good to use negative logic, I think that
> >> it's better to name the flag as something like "no_cache_trim_mode" to
> >> make it easier to initialize the flag to its default value ("0").
> >
> > No preference to me. But don't think it's better to use another of may_*
> > in scan_control as Johannes Weiner suggested?
> >
> >> >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> >> >  	unsigned int proactive:1;
> >> >  
> >> > @@ -1500,6 +1503,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> >> >  	struct scan_control sc = {
> >> >  		.gfp_mask = GFP_KERNEL,
> >> >  		.may_unmap = 1,
> >> > +		.may_cache_trim_mode = 1,
> >> >  	};
> >> >  	struct reclaim_stat stat;
> >> >  	unsigned int nr_reclaimed;
> >> > @@ -2094,6 +2098,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
> >> >  		.may_writepage = 1,
> >> >  		.may_unmap = 1,
> >> >  		.may_swap = 1,
> >> > +		.may_cache_trim_mode = 1,
> >> >  		.no_demotion = 1,
> >> >  	};
> >> >  
> >> > @@ -2268,7 +2273,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> >  	 * anonymous pages.
> >> >  	 */
> >> >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >> > +	    sc->may_cache_trim_mode)
> >> >  		sc->cache_trim_mode = 1;
> >> >  	else
> >> >  		sc->cache_trim_mode = 0;
> >> > @@ -5435,6 +5441,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
> >> >  		.may_writepage = true,
> >> >  		.may_unmap = true,
> >> >  		.may_swap = true,
> >> > +		.may_cache_trim_mode = 1,
> >> >  		.reclaim_idx = MAX_NR_ZONES - 1,
> >> >  		.gfp_mask = GFP_KERNEL,
> >> >  	};
> >> > @@ -6394,6 +6401,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >> >  		.may_writepage = !laptop_mode,
> >> >  		.may_unmap = 1,
> >> >  		.may_swap = 1,
> >> > +		.may_cache_trim_mode = 1,
> >> >  	};
> >> >  
> >> >  	/*
> >> > @@ -6439,6 +6447,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >> >  		.may_unmap = 1,
> >> >  		.reclaim_idx = MAX_NR_ZONES - 1,
> >> >  		.may_swap = !noswap,
> >> > +		.may_cache_trim_mode = 1,
> >> >  	};
> >> >  
> >> >  	WARN_ON_ONCE(!current->reclaim_state);
> >> > @@ -6482,6 +6491,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >> >  		.may_writepage = !laptop_mode,
> >> >  		.may_unmap = 1,
> >> >  		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
> >> > +		.may_cache_trim_mode = 1,
> >> >  		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> >> >  	};
> >> >  	/*
> >> > @@ -6744,6 +6754,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >> >  		.gfp_mask = GFP_KERNEL,
> >> >  		.order = order,
> >> >  		.may_unmap = 1,
> >> > +		.may_cache_trim_mode = 1,
> >> >  	};
> >> >  
> >> >  	set_task_reclaim_state(current, &sc.reclaim_state);
> >> > @@ -6898,8 +6909,14 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >> >  			sc.priority--;
> >> >  	} while (sc.priority >= 1);
> >> >  
> >> > -	if (!sc.nr_reclaimed)
> >> > +	if (!sc.nr_reclaimed) {
> >> > +		if (sc.may_cache_trim_mode) {
> >> 
> >> sc.may_cache_trim_mode && cache_trim_mode ?
> >
> > I don't think so. cache_trim_mode has a chance to switch every
> > prepare_scan_control() like:
> >
> >    if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >        sc->may_cache_trim_mode)                                          
> > 	sc->cache_trim_mode = 1;                                      
> >    else                                                                  
> > 	sc->cache_trim_mode = 0;                                      
> >
> > So referring to the last value is not a good idea.
> 
> We should only restart without cache_trim_mode if cache_trim_mode causes
> issue.  If it isn't enabled with highest priority (lowest value), it
> doesn't help to disable cache_trim_mode.

Yes, right. Lemme think it more and apply the consideration.

> And, please take care of other "break" in the loop, for example, if
> kthread_should_stop(), etc.

I will. Thank you.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > 	Byungchul
> >
> >> > +			sc.may_cache_trim_mode = 0;
> >> > +			goto restart;
> >> > +		}
> >> > +
> >> >  		pgdat->kswapd_failures++;
> >> > +	}
> >> >  
> >> >  out:
> >> >  	clear_reclaim_active(pgdat, highest_zoneidx);
> >> > @@ -7202,6 +7219,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
> >> >  		.may_writepage = 1,
> >> >  		.may_unmap = 1,
> >> >  		.may_swap = 1,
> >> > +		.may_cache_trim_mode = 1,
> >> >  		.hibernation_mode = 1,
> >> >  	};
> >> >  	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
> >> > @@ -7360,6 +7378,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >> >  		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
> >> >  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
> >> >  		.may_swap = 1,
> >> > +		.may_cache_trim_mode = 1,
> >> >  		.reclaim_idx = gfp_zone(gfp_mask),
> >> >  	};
> >> >  	unsigned long pflags;
> >> 
> >> --
> >> Best Regards,
> >> Huang, Ying

