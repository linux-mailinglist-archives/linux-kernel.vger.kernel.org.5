Return-Path: <linux-kernel+bounces-91757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177B871621
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673F5B241D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9A7BAE1;
	Tue,  5 Mar 2024 06:59:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03F045C14
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621941; cv=none; b=HDUpVlpFbdLsHztjWzOWtkIWvzG2k2HObccqeqLT8NpyK4GPX4CLMBYhLBELOWTskbJLgjfrv8wV950GA+ACkjL8j/zjZ6y+JL6UMPXQNZ7kLOxMpAaRBuA+9V6kdLOkLJX6dwSNvpZFtD4Bvqxegbrr1xrm2caSEwCf/wUko9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621941; c=relaxed/simple;
	bh=sKhWbAWwexP35uloJYqgDGzEQ9uRRYSWXLgPqTIpW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRlIP8VdXWOtxb0Ztgn8APGkbvhWaqUrr0FWkDgJoBGWYm9KZFwwb2FEVirc3Sry6iMdJKcBjo8fMtOqw2dl2/dXgjocn/d7KCKdAw13HkG2e7lAy+yriW2k0+3VhHAEnUUY8dRt1OPftm3vZcxHRVAZC672joyDVjmBhNdrJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-83-65e6c2ab3ec6
Date: Tue, 5 Mar 2024 15:58:46 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH v6] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240305065846.GA37850@system.software.com>
References: <20240304033611.GD13332@system.software.com>
 <20240304082118.20499-1-byungchul@sk.com>
 <87zfvda1f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305023708.GA60719@system.software.com>
 <20240305024345.GB60719@system.software.com>
 <20240305040930.GA21107@system.software.com>
 <87le6x9p6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le6x9p6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke7qQ89SDa72a1rMWb+GzWL1Jl+L
	y7vmsFncW/Of1eLkrMksFu8mfGF1YPM4/OY9s8eCTaUei/e8ZPLY9GkSu8eJGb9ZPD5vkgtg
	i+KySUnNySxLLdK3S+DKOLT8DXNBa1DFxdv72RoYV1l1MXJySAiYSPw6MoUdxv7X2c3YxcjB
	wSKgItG6JxckzCagLnHjxk9mEFtEQEPi08LlQOVcHMwCkxklnu1fwwKSEBZIk3h17DNYEa+A
	hcSslq/MIEVCAjeZJH6eXsUEkRCUODnzCVgDs4CWxI1/L5lAljELSEss/8cBEuYUsJNoOPgX
	7B5RAWWJA9uOM4HMkRDYwiZxpvE/G8ShkhIHV9xgmcAoMAvJ2FlIxs5CGLuAkXkVo1BmXllu
	YmaOiV5GZV5mhV5yfu4mRmBgL6v9E72D8dOF4EOMAhyMSjy8J/Y9TRViTSwrrsw9xCjBwawk
	wlvz60mqEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalFMFkmDk6pBkZr
	Za4ft6Iq15z84njH7FiCVg7zrQi1nDVs7fc7MpXyBHkTu/4G+89QaFv+gFslo6howhmTS4y2
	D5Ze8b6RalvwQOWd9TUbbb6HFaH/tk54vHLxQo6cpLYtfllBy149PPTv2ud7mxi4d1hbJJd7
	fJc5bH8obWWc8Yk1X18xZubUmNtk3HQyOKLEUpyRaKjFXFScCAB4dC4haAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrLv60LNUg1/tshZz1q9hs1i9ydfi
	8NyTrBaXd81hs7i35j+rxclZk1ks3k34wurA7nH4zXtmjwWbSj0W73nJ5LHp0yR2jxMzfrN4
	LH7xgcnj8ya5APYoLpuU1JzMstQifbsEroxDy98wF7QGVVy8vZ+tgXGVVRcjJ4eEgInEv85u
	xi5GDg4WARWJ1j25IGE2AXWJGzd+MoPYIgIaEp8WLmfvYuTiYBaYzCjxbP8aFpCEsECaxKtj
	n8GKeAUsJGa1fGUGKRISuMkk8fP0KiaIhKDEyZlPwBqYBbQkbvx7yQSyjFlAWmL5Pw6QMKeA
	nUTDwb/sILaogLLEgW3HmSYw8s5C0j0LSfcshO4FjMyrGEUy88pyEzNzTPWKszMq8zIr9JLz
	czcxAsN0We2fiTsYv1x2P8QowMGoxMN74ejTVCHWxLLiytxDjBIczEoivDW/nqQK8aYkVlal
	FuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MBoLL+YwKvvZtNI/7MvT
	w/vMarin6Uxb8j6v39iar+rPpCvBqmv7e+Tn2a+vOFz9U6ZQSiboWeqCmtNPWMuq7QOavwdu
	Sftn431o5qo2ye3OdrOPxl//PcGU877GvtitH5X+3cs4e/Cc6t59s1de2rR73R51gy8TFwvk
	pi9Z0Kj8tEyPw07t1nQlluKMREMt5qLiRAAGMRjtTwIAAA==
X-CFilter-Loop: Reflected

On Tue, Mar 05, 2024 at 02:18:33PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Mar 05, 2024 at 11:43:45AM +0900, Byungchul Park wrote:
> >> On Tue, Mar 05, 2024 at 11:37:08AM +0900, Byungchul Park wrote:
> >> > On Tue, Mar 05, 2024 at 09:54:19AM +0800, Huang, Ying wrote:
> >> > > Byungchul Park <byungchul@sk.com> writes:
> >> > > 
> >> > > > Changes from v5:
> >> > > > 	1. Make it retry the kswapd's scan priority loop with
> >> > > > 	   cache_trim_mode off *only if* the mode didn't work in the
> >> > > > 	   previous loop. (feedbacked by Huang Ying)
> >> > > > 	2. Take into account 'break's from the priority loop when making
> >> > > > 	   the decision whether to retry. (feedbacked by Huang Ying)
> >> > > > 	3. Update the test result in the commit message.
> >> > > >
> >> > > > Changes from v4:
> >> > > > 	1. Make other scans start with may_cache_trim_mode = 1.
> >> > > >
> >> > > > Changes from v3:
> >> > > > 	1. Update the test result in the commit message with v4.
> >> > > > 	2. Retry the whole priority loop with cache_trim_mode off again,
> >> > > > 	   rather than forcing the mode off at the highest priority,
> >> > > > 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> >> > > >
> >> > > > Changes from v2:
> >> > > > 	1. Change the condition to stop cache_trim_mode.
> >> > > >
> >> > > > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> >> > > > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> >> > > > 	          the mode didn't work in the previous turn.
> >> > > >
> >> > > > 	   (feedbacked by Huang Ying)
> >> > > >
> >> > > > 	2. Change the test result in the commit message after testing
> >> > > > 	   with the new logic.
> >> > > >
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
> >> > > > From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
> >> > > > From: Byungchul Park <byungchul@sk.com>
> >> > > > Date: Mon, 4 Mar 2024 15:27:37 +0900
> >> > > > Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> >> > > >
> >> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> > > > pages.  However, it should be more careful to use the mode because it's
> >> > > > going to prevent anon pages from being reclaimed even if there are a
> >> > > > huge number of anon pages that are cold and should be reclaimed.  Even
> >> > > > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> > > > stopping kswapd from functioning until direct reclaim eventually works
> >> > > > to resume kswapd.
> >> > > >
> >> > > > So kswapd needs to retry its scan priority loop with cache_trim_mode
> >> > > > off again if the mode doesn't work for reclaim.
> >> > > >
> >> > > > The problematic behavior can be reproduced by:
> >> > > >
> >> > > >    CONFIG_NUMA_BALANCING enabled
> >> > > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
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
> >> > > >               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >> > > >
> >> > > >    3) Run any memory intensive work e.g. XSBench.
> >> > > >    4) Check if numa balancing is working e.i. promotion/demotion.
> >> > > >    5) Iterate 1) ~ 4) until numa balancing stops.
> >> > > >
> >> > > > With this, you could see that promotion/demotion are not working because
> >> > > > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> > > >
> >> > > > Interesting vmstat delta's differences between before and after are like:
> >> > > >
> >> > > >    +-----------------------+-------------------------------+
> >> > > >    | interesting vmstat    | before        | after         |
> >> > > >    +-----------------------+-------------------------------+
> >> > > >    | nr_inactive_anon      | 321935        | 1664772       |
> >> > > >    | nr_active_anon        | 1780700       | 437834        |
> >> > > >    | nr_inactive_file      | 30425         | 40882         |
> >> > > >    | nr_active_file        | 14961         | 3012          |
> >> > > >    | pgpromote_success     | 356           | 1293122       |
> >> > > >    | pgpromote_candidate   | 21953245      | 1824148       |
> >> > > >    | pgactivate            | 1844523       | 3311907       |
> >> > > >    | pgdeactivate          | 50634         | 1554069       |
> >> > > >    | pgfault               | 31100294      | 6518806       |
> >> > > >    | pgdemote_kswapd       | 30856         | 2230821       |
> >> > > >    | pgscan_kswapd         | 1861981       | 7667629       |
> >> > > >    | pgscan_anon           | 1822930       | 7610583       |
> >> > > >    | pgscan_file           | 39051         | 57046         |
> >> > > >    | pgsteal_anon          | 386           | 2192033       |
> >> > > >    | pgsteal_file          | 30470         | 38788         |
> >> > > >    | pageoutrun            | 30            | 412           |
> >> > > >    | numa_hint_faults      | 27418279      | 2875955       |
> >> > > >    | numa_pages_migrated   | 356           | 1293122       |
> >> > > >    +-----------------------+-------------------------------+
> >> > > >
> >> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> > > > ---
> >> > > >  mm/vmscan.c | 21 ++++++++++++++++++++-
> >> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> > > > index bba207f41b14..6fe45eca7766 100644
> >> > > > --- a/mm/vmscan.c
> >> > > > +++ b/mm/vmscan.c
> >> > > > @@ -108,6 +108,12 @@ struct scan_control {
> >> > > >  	/* Can folios be swapped as part of reclaim? */
> >> > > >  	unsigned int may_swap:1;
> >> > > >  
> >> > > > +	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
> >> > > > +	unsigned int no_cache_trim_mode:1;
> >> > > > +
> >> > > > +	/* Has cache_trim_mode failed at least once? */
> >> > > > +	unsigned int cache_trim_mode_failed:1;
> >> > > > +
> >> > > >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> >> > > >  	unsigned int proactive:1;
> >> > > >  
> >> > > > @@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> > > >  	 * anonymous pages.
> >> > > >  	 */
> >> > > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> > > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> > > > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >> > > > +	    !sc->no_cache_trim_mode)
> >> > > >  		sc->cache_trim_mode = 1;
> >> > > >  	else
> >> > > >  		sc->cache_trim_mode = 0;
> >> > > > @@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> > > >  	 */
> >> > > >  	if (reclaimable)
> >> > > >  		pgdat->kswapd_failures = 0;
> >> > > > +	else if (sc->cache_trim_mode)
> >> > > > +		sc->cache_trim_mode_failed = 1;
> >> > > >  }
> >> > > >  
> >> > > >  /*
> >> > > > @@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >> > > >  			sc.priority--;
> >> > > >  	} while (sc.priority >= 1);
> >> > > >  
> >> > > > +	/*
> >> > > > +	 * Restart only if it went through the priority loop all the way,
> >> > > > +	 * but cache_trim_mode didn't work.
> >> > > > +	 */
> >> > > > +	if (!sc.nr_reclaimed && sc.priority < 1 &&
> >> > > > +	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
> >> > > 
> >> > > Can we just use sc.cache_trim_mode (instead of
> >> > > sc.cache_trim_mode_failed) here?  That is, if cache_trim_mode is enabled
> >> > 
> >> > As Johannes mentioned, within a priority scan, all the numa nodes are
> >> > scanned each with its own value of cache_trim_mode. So we cannot use
> >> > cache_trim_mode for that purpose.
> >> 
> >> Ah, okay. Confining to kswapd, that might make sense. I will apply it if
> >> there's no objection to it. Thanks.
> >
> > I didn't want to introduce two additional flags either, but it was
> > possible to make it do exactly what we want it to do thanks to the flags.
> > I'd like to keep this version if possible unless there are any other
> > objections on it.
> 
> Sorry, I'm confused.  Whether does "cache_trim_mode == 1" do the trick?
> If so, why not?  If not, why?

kswapd might happen to go through:

priority 12(== DEF_PRIORITY) + cache_trim_mode on -> fail
priority 11 + cache_trim_mode on -> fail
priority 10 + cache_trim_mode on -> fail
priority 9 + cache_trim_mode on -> fail
priority 8 + cache_trim_mode on -> fail
priority 7 + cache_trim_mode on -> fail
priority 6 + cache_trim_mode on -> fail
priority 5 + cache_trim_mode on -> fail
priority 4 + cache_trim_mode on -> fail
priority 3 + cache_trim_mode on -> fail
priority 2 + cache_trim_mode on -> fail
priority 1 + cache_trim_mode off -> fail

I'd like to retry even in this case. 

Am I missing something?

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > 	Byungchul
> >
> >> 	Byungchul
> >> > 
> >> > 	Byungchul
> >> > 
> >> > > for priority == 1 and failed to reclaim, we will restart.  If this
> >> > > works, we can avoid to add another flag.
> >> > > 
> >> > > > +		sc.no_cache_trim_mode = 1;
> >> > > > +		goto restart;
> >> > > > +	}
> >> > > > +
> >> > > >  	if (!sc.nr_reclaimed)
> >> > > >  		pgdat->kswapd_failures++;
> >> > > 
> >> > > --
> >> > > Best Regards,
> >> > > Huang, Ying

