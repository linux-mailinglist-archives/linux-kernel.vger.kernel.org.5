Return-Path: <linux-kernel+bounces-91855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF81C87177C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54DA2888AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B97FBBD;
	Tue,  5 Mar 2024 07:55:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AE7FBBC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625352; cv=none; b=Zygpwko7Q2z/ohg/PuBFNYhbX3xJGxP40wv6xbsoEIQqbbcow4pjZRzP5Y0q2Z9g2KGN+JAUBRDrOs4GCuUGE/Quq+N99mZPLuUSVHx2tOilE5sT0J4WBOiHQwb3Q1tF3UsYHdLEFBmyGyXP0yu1hU1CFC2DX3G4JaAKvzjyufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625352; c=relaxed/simple;
	bh=1E/IfKH2A3lgM+728lj9ds4enFnCifk/dm3OElADO4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoBAqJjg4x7ynHuawG71wpUXg9vRtf3ETZT8mH2+5n+QLNkSuvKNXxipPB903XRcliberL0TS44jxk2P74O71HpQ1FiDJME1yAUT2y4dIrI9FyubeZ2SbNRsvfW7XWv6PclAc1n1GJDYc1k0pV/ZO2BDSnoICziLqS7MowVgTSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-80-65e6cfff1bfb
Date: Tue, 5 Mar 2024 16:55:38 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>, hannes@cmpxchg.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com
Subject: Re: [PATCH v6] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240305075538.GA3152@system.software.com>
References: <20240304082118.20499-1-byungchul@sk.com>
 <87zfvda1f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305023708.GA60719@system.software.com>
 <20240305024345.GB60719@system.software.com>
 <20240305040930.GA21107@system.software.com>
 <87le6x9p6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305065846.GA37850@system.software.com>
 <87cys99n1r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305071232.GB37850@system.software.com>
 <874jdl9lmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jdl9lmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoe7/889SDS63aVjMWb+GzWL1Jl+L
	y7vmsFncW/Of1eLkrMksFu8mfGF1YPM4/OY9s8eCTaUei/e8ZPLY9GkSu8eJGb9ZPD5vkgtg
	i+KySUnNySxLLdK3S+DKuLmqg7ngbWrFzuV/2RsYV3l0MXJySAiYSMy+s5YZxr56ZT8riM0i
	oCIx7cxyNhCbTUBd4saNn0A1HBwiAjYSG/aEgYSZBWolHt+ZCVYiLJAm8erYZ7ASXgFzif3r
	tboYuTiEBD4wS9xY2cUCUsMrIChxcuYTFoheLYkb/14ygdQzC0hLLP/HARLmFLCT+Dp1Kdg1
	ogLKEge2HWcCmSMhsIFNovXlXKgzJSUOrrjBMoFRYBaSsbOQjJ2FMHYBI/MqRqHMvLLcxMwc
	E72MyrzMCr3k/NxNjMCgXlb7J3oH46cLwYcYBTgYlXh4T+x7mirEmlhWXJl7iFGCg1lJhLfm
	15NUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYyyDXH3
	tKcw77TdOyEs91aixJZLE5y3TikW4L+wkKFdbHl2bW7w/Al8on9Obnp2dS7XblerVx6iB0qP
	Br9gl/jSeNmd5cL/NfsOcXwNa5gs8Wz5+w81yonPzMw8XSel6grw1f958mq1stKcwqZHqsEH
	nr398LzZuUr0+gynK5EVivOSmzZ6zL6qxFKckWioxVxUnAgAfiSfiGYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrPv//LNUg0N/RS3mrF/DZrF6k6/F
	4bknWS0u75rDZnFvzX9Wi5OzJrNYvJvwhdWB3ePwm/fMHgs2lXos3vOSyWPTp0nsHidm/Gbx
	WPziA5PH501yAexRXDYpqTmZZalF+nYJXBk3V3UwF7xNrdi5/C97A+Mqjy5GTg4JAROJq1f2
	s4LYLAIqEtPOLGcDsdkE1CVu3PjJ3MXIwSEiYCOxYU8YSJhZoFbi8Z2ZYCXCAmkSr459Bivh
	FTCX2L9eq4uRi0NI4AOzxI2VXSwgNbwCghInZz5hgejVkrjx7yUTSD2zgLTE8n8cIGFOATuJ
	r1OXMoPYogLKEge2HWeawMg7C0n3LCTdsxC6FzAyr2IUycwry03MzDHVK87OqMzLrNBLzs/d
	xAgM0WW1fybuYPxy2f0QowAHoxIP74WjT1OFWBPLiitzDzFKcDArifDW/HqSKsSbklhZlVqU
	H19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cB4tf/lWzVr3aD/HkuWHQnb
	aDDn/cP9n8490lwXyNkq8q5/56+Lsx4aipcwrFz2OMiNkX8ry0Klpw2+jvdLEv+vWsjftr72
	d8iqO3zlTr3MvHWP38/K/jL70Y+yDZGLbL8o/DzJte59iTaDisqj7JlnOD2aJDiX9Pm4cp3g
	ubPjMvvZiOoq9t3flFiKMxINtZiLihMBrjfy+00CAAA=
X-CFilter-Loop: Reflected

On Tue, Mar 05, 2024 at 03:35:35PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Mar 05, 2024 at 03:04:48PM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Tue, Mar 05, 2024 at 02:18:33PM +0800, Huang, Ying wrote:
> >> >> Byungchul Park <byungchul@sk.com> writes:
> >> >> 
> >> >> > On Tue, Mar 05, 2024 at 11:43:45AM +0900, Byungchul Park wrote:
> >> >> >> On Tue, Mar 05, 2024 at 11:37:08AM +0900, Byungchul Park wrote:
> >> >> >> > On Tue, Mar 05, 2024 at 09:54:19AM +0800, Huang, Ying wrote:
> >> >> >> > > Byungchul Park <byungchul@sk.com> writes:
> >> >> >> > > 
> >> >> >> > > > Changes from v5:
> >> >> >> > > > 	1. Make it retry the kswapd's scan priority loop with
> >> >> >> > > > 	   cache_trim_mode off *only if* the mode didn't work in the
> >> >> >> > > > 	   previous loop. (feedbacked by Huang Ying)
> >> >> >> > > > 	2. Take into account 'break's from the priority loop when making
> >> >> >> > > > 	   the decision whether to retry. (feedbacked by Huang Ying)
> >> >> >> > > > 	3. Update the test result in the commit message.
> >> >> >> > > >
> >> >> >> > > > Changes from v4:
> >> >> >> > > > 	1. Make other scans start with may_cache_trim_mode = 1.
> >> >> >> > > >
> >> >> >> > > > Changes from v3:
> >> >> >> > > > 	1. Update the test result in the commit message with v4.
> >> >> >> > > > 	2. Retry the whole priority loop with cache_trim_mode off again,
> >> >> >> > > > 	   rather than forcing the mode off at the highest priority,
> >> >> >> > > > 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> >> >> >> > > >
> >> >> >> > > > Changes from v2:
> >> >> >> > > > 	1. Change the condition to stop cache_trim_mode.
> >> >> >> > > >
> >> >> >> > > > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> >> >> >> > > > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> >> >> >> > > > 	          the mode didn't work in the previous turn.
> >> >> >> > > >
> >> >> >> > > > 	   (feedbacked by Huang Ying)
> >> >> >> > > >
> >> >> >> > > > 	2. Change the test result in the commit message after testing
> >> >> >> > > > 	   with the new logic.
> >> >> >> > > >
> >> >> >> > > > Changes from v1:
> >> >> >> > > > 	1. Add a comment describing why this change is necessary in code
> >> >> >> > > > 	   and rewrite the commit message with how to reproduce and what
> >> >> >> > > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> >> >> >> > > > 	   Yu Zhao)
> >> >> >> > > > 	2. Change the condition to avoid cache_trim_mode from
> >> >> >> > > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> >> >> >> > > > 	   where the priority goes to zero all the way. (feedbacked by
> >> >> >> > > > 	   Yu Zhao)
> >> >> >> > > >
> >> >> >> > > > --->8---
> >> >> >> > > > From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
> >> >> >> > > > From: Byungchul Park <byungchul@sk.com>
> >> >> >> > > > Date: Mon, 4 Mar 2024 15:27:37 +0900
> >> >> >> > > > Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> >> >> >> > > >
> >> >> >> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> >> >> > > > pages.  However, it should be more careful to use the mode because it's
> >> >> >> > > > going to prevent anon pages from being reclaimed even if there are a
> >> >> >> > > > huge number of anon pages that are cold and should be reclaimed.  Even
> >> >> >> > > > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> >> >> > > > stopping kswapd from functioning until direct reclaim eventually works
> >> >> >> > > > to resume kswapd.
> >> >> >> > > >
> >> >> >> > > > So kswapd needs to retry its scan priority loop with cache_trim_mode
> >> >> >> > > > off again if the mode doesn't work for reclaim.
> >> >> >> > > >
> >> >> >> > > > The problematic behavior can be reproduced by:
> >> >> >> > > >
> >> >> >> > > >    CONFIG_NUMA_BALANCING enabled
> >> >> >> > > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> >> >> > > >    numa node0 (8GB local memory, 16 CPUs)
> >> >> >> > > >    numa node1 (8GB slow tier memory, no CPUs)
> >> >> >> > > >
> >> >> >> > > >    Sequence:
> >> >> >> > > >
> >> >> >> > > >    1) echo 3 > /proc/sys/vm/drop_caches
> >> >> >> > > >    2) To emulate the system with full of cold memory in local DRAM, run
> >> >> >> > > >       the following dummy program and never touch the region:
> >> >> >> > > >
> >> >> >> > > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> >> >> >> > > >               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >> >> >> > > >
> >> >> >> > > >    3) Run any memory intensive work e.g. XSBench.
> >> >> >> > > >    4) Check if numa balancing is working e.i. promotion/demotion.
> >> >> >> > > >    5) Iterate 1) ~ 4) until numa balancing stops.
> >> >> >> > > >
> >> >> >> > > > With this, you could see that promotion/demotion are not working because
> >> >> >> > > > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> >> >> > > >
> >> >> >> > > > Interesting vmstat delta's differences between before and after are like:
> >> >> >> > > >
> >> >> >> > > >    +-----------------------+-------------------------------+
> >> >> >> > > >    | interesting vmstat    | before        | after         |
> >> >> >> > > >    +-----------------------+-------------------------------+
> >> >> >> > > >    | nr_inactive_anon      | 321935        | 1664772       |
> >> >> >> > > >    | nr_active_anon        | 1780700       | 437834        |
> >> >> >> > > >    | nr_inactive_file      | 30425         | 40882         |
> >> >> >> > > >    | nr_active_file        | 14961         | 3012          |
> >> >> >> > > >    | pgpromote_success     | 356           | 1293122       |
> >> >> >> > > >    | pgpromote_candidate   | 21953245      | 1824148       |
> >> >> >> > > >    | pgactivate            | 1844523       | 3311907       |
> >> >> >> > > >    | pgdeactivate          | 50634         | 1554069       |
> >> >> >> > > >    | pgfault               | 31100294      | 6518806       |
> >> >> >> > > >    | pgdemote_kswapd       | 30856         | 2230821       |
> >> >> >> > > >    | pgscan_kswapd         | 1861981       | 7667629       |
> >> >> >> > > >    | pgscan_anon           | 1822930       | 7610583       |
> >> >> >> > > >    | pgscan_file           | 39051         | 57046         |
> >> >> >> > > >    | pgsteal_anon          | 386           | 2192033       |
> >> >> >> > > >    | pgsteal_file          | 30470         | 38788         |
> >> >> >> > > >    | pageoutrun            | 30            | 412           |
> >> >> >> > > >    | numa_hint_faults      | 27418279      | 2875955       |
> >> >> >> > > >    | numa_pages_migrated   | 356           | 1293122       |
> >> >> >> > > >    +-----------------------+-------------------------------+
> >> >> >> > > >
> >> >> >> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> >> >> > > > ---
> >> >> >> > > >  mm/vmscan.c | 21 ++++++++++++++++++++-
> >> >> >> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> >> >> >> > > >
> >> >> >> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> >> >> > > > index bba207f41b14..6fe45eca7766 100644
> >> >> >> > > > --- a/mm/vmscan.c
> >> >> >> > > > +++ b/mm/vmscan.c
> >> >> >> > > > @@ -108,6 +108,12 @@ struct scan_control {
> >> >> >> > > >  	/* Can folios be swapped as part of reclaim? */
> >> >> >> > > >  	unsigned int may_swap:1;
> >> >> >> > > >  
> >> >> >> > > > +	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
> >> >> >> > > > +	unsigned int no_cache_trim_mode:1;
> >> >> >> > > > +
> >> >> >> > > > +	/* Has cache_trim_mode failed at least once? */
> >> >> >> > > > +	unsigned int cache_trim_mode_failed:1;
> >> >> >> > > > +
> >> >> >> > > >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> >> >> >> > > >  	unsigned int proactive:1;
> >> >> >> > > >  
> >> >> >> > > > @@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> >> >> > > >  	 * anonymous pages.
> >> >> >> > > >  	 */
> >> >> >> > > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> >> >> > > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> >> >> > > > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >> >> >> > > > +	    !sc->no_cache_trim_mode)
> >> >> >> > > >  		sc->cache_trim_mode = 1;
> >> >> >> > > >  	else
> >> >> >> > > >  		sc->cache_trim_mode = 0;
> >> >> >> > > > @@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >> >> > > >  	 */
> >> >> >> > > >  	if (reclaimable)
> >> >> >> > > >  		pgdat->kswapd_failures = 0;
> >> >> >> > > > +	else if (sc->cache_trim_mode)
> >> >> >> > > > +		sc->cache_trim_mode_failed = 1;
> >> >> >> > > >  }
> >> >> >> > > >  
> >> >> >> > > >  /*
> >> >> >> > > > @@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >> >> >> > > >  			sc.priority--;
> >> >> >> > > >  	} while (sc.priority >= 1);
> >> >> >> > > >  
> >> >> >> > > > +	/*
> >> >> >> > > > +	 * Restart only if it went through the priority loop all the way,
> >> >> >> > > > +	 * but cache_trim_mode didn't work.
> >> >> >> > > > +	 */
> >> >> >> > > > +	if (!sc.nr_reclaimed && sc.priority < 1 &&
> >> >> >> > > > +	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
> >> >> >> > > 
> >> >> >> > > Can we just use sc.cache_trim_mode (instead of
> >> >> >> > > sc.cache_trim_mode_failed) here?  That is, if cache_trim_mode is enabled
> >> >> >> > 
> >> >> >> > As Johannes mentioned, within a priority scan, all the numa nodes are
> >> >> >> > scanned each with its own value of cache_trim_mode. So we cannot use
> >> >> >> > cache_trim_mode for that purpose.
> >> >> >> 
> >> >> >> Ah, okay. Confining to kswapd, that might make sense. I will apply it if
> >> >> >> there's no objection to it. Thanks.
> >> >> >
> >> >> > I didn't want to introduce two additional flags either, but it was
> >> >> > possible to make it do exactly what we want it to do thanks to the flags.
> >> >> > I'd like to keep this version if possible unless there are any other
> >> >> > objections on it.
> >> >> 
> >> >> Sorry, I'm confused.  Whether does "cache_trim_mode == 1" do the trick?
> >> >> If so, why not?  If not, why?
> >> >
> >> > kswapd might happen to go through:
> >> >
> >> > priority 12(== DEF_PRIORITY) + cache_trim_mode on -> fail
> >> > priority 11 + cache_trim_mode on -> fail
> >> > priority 10 + cache_trim_mode on -> fail
> >> > priority 9 + cache_trim_mode on -> fail
> >> > priority 8 + cache_trim_mode on -> fail
> >> > priority 7 + cache_trim_mode on -> fail
> >> > priority 6 + cache_trim_mode on -> fail
> >> > priority 5 + cache_trim_mode on -> fail
> >> > priority 4 + cache_trim_mode on -> fail
> >> > priority 3 + cache_trim_mode on -> fail
> >> > priority 2 + cache_trim_mode on -> fail
> >> > priority 1 + cache_trim_mode off -> fail
> >> >
> >> > I'd like to retry even in this case. 
> >> 
> >> I don't think that we should retry in this case.  If the following case
> >> fails,
> >> 
> >> > priority 1 + cache_trim_mode off -> fail
> >> 
> >> Why will we succeed after retrying?
> >
> > At priority 1, anon pages will be partially scanned. However, there
> > might be anon pages that have never been scanned but can be reclaimed.
> >
> > Do I get it wrong?
> 
> Yes.  In theory, that's possible.  But do you think that will be some
> practical issue?  So that, pgdat->kswapd_failures will reach max value?

v6 is based on what Johannes suggested. I thought it's more right way to
fix the issue.

Yeah, I also think checking cache_trim_mode only at the kswapd's highest
priorty would manage to work for the issue.

I'd like to listen to Johannes's opinion or others.

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > 	Byungchul
> >
> >> --
> >> Best Regards,
> >> Huang, Ying
> >> 
> >> > Am I missing something?
> >> >
> >> > 	Byungchul
> >> >
> >> >> --
> >> >> Best Regards,
> >> >> Huang, Ying
> >> >> 
> >> >> > 	Byungchul
> >> >> >
> >> >> >> 	Byungchul
> >> >> >> > 
> >> >> >> > 	Byungchul
> >> >> >> > 
> >> >> >> > > for priority == 1 and failed to reclaim, we will restart.  If this
> >> >> >> > > works, we can avoid to add another flag.
> >> >> >> > > 
> >> >> >> > > > +		sc.no_cache_trim_mode = 1;
> >> >> >> > > > +		goto restart;
> >> >> >> > > > +	}
> >> >> >> > > > +
> >> >> >> > > >  	if (!sc.nr_reclaimed)
> >> >> >> > > >  		pgdat->kswapd_failures++;
> >> >> >> > > 
> >> >> >> > > --
> >> >> >> > > Best Regards,
> >> >> >> > > Huang, Ying

