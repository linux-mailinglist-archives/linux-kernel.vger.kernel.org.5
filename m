Return-Path: <linux-kernel+bounces-91778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25212871674
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653ADB255B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22357E786;
	Tue,  5 Mar 2024 07:12:46 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C0B7D3E8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622766; cv=none; b=vGCI827Ei/GC7YjdQ5whFUI1oudDyMudLXLpIZeOvAc9hP0vEL2dO/qTpmIBLAuJ+Fqu374CA+QmxU3AzMoVJqPw/iunsCiMrK/EOT7dl1c++Ub4FnrVvEyiiFUoDGg1Py2H7YGd/MMlAogV13r5YhShH1/qcZTz+QM6wge3/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622766; c=relaxed/simple;
	bh=asXHNKtmC1JAF/qBeybMADStlhTLErDP8PUX2cgTWtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCWyUfqZadXzYwzTFKzuZqIKHL2LJf82qrbLX1LSrIaVF+lQgezlo1QpFeTgWV0ZbB1c/92hNyjQnJpepMC1rTljeCC6q0yxHPQaZYAXbhg7RhnjRZZA1G1xvsRVAu6YJL9ClFiKIpkvVWXCu9LEc3g1hy9hB0iFYf4d029dwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-dc-65e6c5e6c5e3
Date: Tue, 5 Mar 2024 16:12:32 +0900
From: Byungchul Park <byungchul@sk.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, yuzhao@google.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH v6] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240305071232.GB37850@system.software.com>
References: <20240304033611.GD13332@system.software.com>
 <20240304082118.20499-1-byungchul@sk.com>
 <87zfvda1f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305023708.GA60719@system.software.com>
 <20240305024345.GB60719@system.software.com>
 <20240305040930.GA21107@system.software.com>
 <87le6x9p6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305065846.GA37850@system.software.com>
 <87cys99n1r.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cys99n1r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsXC9ZZnke6zo89SDe42cFjMWb+GzWL1Jl+L
	y7vmsFncW/Of1eLkrMksFu8mfGF1YPM4/OY9s8eCTaUei/e8ZPLY9GkSu8eJGb9ZPD5vkgtg
	i+KySUnNySxLLdK3S+DK+DzhC3PB7uiKfde2MzcwfnboYuTkkBAwkXi5+yxbFyMHmL3kWxBI
	mEVAReL2p5OsIDabgLrEjRs/mUFsEQENiU8Ll7N3MXJxMAtMZpR4tn8NC0hCWCBN4tWxz2BF
	vAIWEkev7QMrEhLYwyxxePJWdoiEoMTJmU/AGpgFtCRu/HvJBLKYWUBaYvk/DpAwp4CdxKum
	L2wgtqiAssSBbceZQOZICGxhk1hyaAoLxNGSEgdX3GCZwCgwC8nYWUjGzkIYu4CReRWjUGZe
	WW5iZo6JXkZlXmaFXnJ+7iZGYGAvq/0TvYPx04XgQ4wCHIxKPLwn9j1NFWJNLCuuzD3EKMHB
	rCTCW/PrSaoQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkG
	xuK5An6zLR82CPHd58zKcvV4GyLSYKD2+rG8nsmKXZt/XeXkDJ4S35X69ZOqtXze9WuvzjLd
	futbLSlY3z9v72EXtRKDww4Pm8LeXDFXYg5IvGq0eqJJ1q4D298YWJ1wXjMzrvPgRedTvX6R
	S/vrPRzCtUwULjJ3XgteNss+IWKzUMhOhuW+SizFGYmGWsxFxYkAVL/8OmgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsXC5WfdrPv06LNUg61rLS3mrF/DZrF6k6/F
	4bknWS0u75rDZnFvzX9Wi5OzJrNYvJvwhdWB3ePwm/fMHgs2lXos3vOSyWPTp0nsHidm/Gbx
	WPziA5PH501yAexRXDYpqTmZZalF+nYJXBmfJ3xhLtgdXbHv2nbmBsbPDl2MHBwSAiYSS74F
	dTFycrAIqEjc/nSSFcRmE1CXuHHjJzOILSKgIfFp4XL2LkYuDmaByYwSz/avYQFJCAukSbw6
	9hmsiFfAQuLotX1gRUICe5glDk/eyg6REJQ4OfMJWAOzgJbEjX8vmUAWMwtISyz/xwES5hSw
	k3jV9IUNxBYVUJY4sO040wRG3llIumch6Z6F0L2AkXkVo0hmXlluYmaOqV5xdkZlXmaFXnJ+
	7iZGYJguq/0zcQfjl8vuhxgFOBiVeHgvHH2aKsSaWFZcmXuIUYKDWUmEt+bXk1Qh3pTEyqrU
	ovz4otKc1OJDjNIcLErivF7hqQlCAumJJanZqakFqUUwWSYOTqkGxpQVH7tP8vMaqc9cnrNu
	+3zz/Nq592bp2dzhtfSdsyfC9nqFlJ2idOh7dR2xd/KTJ66uXm52Ou2l8UHHJ0cP1BxLXdfe
	tjotyUq/pfCZQUlfY6jk063bM578uSBTJbxl+c0f22rtD1yJt0w+Mr3it+2yg07b1qw/1j17
	drVz8tf6GA4ju9PH5iixFGckGmoxFxUnAgC08Av3TwIAAA==
X-CFilter-Loop: Reflected

On Tue, Mar 05, 2024 at 03:04:48PM +0800, Huang, Ying wrote:
> Byungchul Park <byungchul@sk.com> writes:
> 
> > On Tue, Mar 05, 2024 at 02:18:33PM +0800, Huang, Ying wrote:
> >> Byungchul Park <byungchul@sk.com> writes:
> >> 
> >> > On Tue, Mar 05, 2024 at 11:43:45AM +0900, Byungchul Park wrote:
> >> >> On Tue, Mar 05, 2024 at 11:37:08AM +0900, Byungchul Park wrote:
> >> >> > On Tue, Mar 05, 2024 at 09:54:19AM +0800, Huang, Ying wrote:
> >> >> > > Byungchul Park <byungchul@sk.com> writes:
> >> >> > > 
> >> >> > > > Changes from v5:
> >> >> > > > 	1. Make it retry the kswapd's scan priority loop with
> >> >> > > > 	   cache_trim_mode off *only if* the mode didn't work in the
> >> >> > > > 	   previous loop. (feedbacked by Huang Ying)
> >> >> > > > 	2. Take into account 'break's from the priority loop when making
> >> >> > > > 	   the decision whether to retry. (feedbacked by Huang Ying)
> >> >> > > > 	3. Update the test result in the commit message.
> >> >> > > >
> >> >> > > > Changes from v4:
> >> >> > > > 	1. Make other scans start with may_cache_trim_mode = 1.
> >> >> > > >
> >> >> > > > Changes from v3:
> >> >> > > > 	1. Update the test result in the commit message with v4.
> >> >> > > > 	2. Retry the whole priority loop with cache_trim_mode off again,
> >> >> > > > 	   rather than forcing the mode off at the highest priority,
> >> >> > > > 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> >> >> > > >
> >> >> > > > Changes from v2:
> >> >> > > > 	1. Change the condition to stop cache_trim_mode.
> >> >> > > >
> >> >> > > > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> >> >> > > > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> >> >> > > > 	          the mode didn't work in the previous turn.
> >> >> > > >
> >> >> > > > 	   (feedbacked by Huang Ying)
> >> >> > > >
> >> >> > > > 	2. Change the test result in the commit message after testing
> >> >> > > > 	   with the new logic.
> >> >> > > >
> >> >> > > > Changes from v1:
> >> >> > > > 	1. Add a comment describing why this change is necessary in code
> >> >> > > > 	   and rewrite the commit message with how to reproduce and what
> >> >> > > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> >> >> > > > 	   Yu Zhao)
> >> >> > > > 	2. Change the condition to avoid cache_trim_mode from
> >> >> > > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> >> >> > > > 	   where the priority goes to zero all the way. (feedbacked by
> >> >> > > > 	   Yu Zhao)
> >> >> > > >
> >> >> > > > --->8---
> >> >> > > > From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
> >> >> > > > From: Byungchul Park <byungchul@sk.com>
> >> >> > > > Date: Mon, 4 Mar 2024 15:27:37 +0900
> >> >> > > > Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> >> >> > > >
> >> >> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> >> >> > > > pages.  However, it should be more careful to use the mode because it's
> >> >> > > > going to prevent anon pages from being reclaimed even if there are a
> >> >> > > > huge number of anon pages that are cold and should be reclaimed.  Even
> >> >> > > > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> >> >> > > > stopping kswapd from functioning until direct reclaim eventually works
> >> >> > > > to resume kswapd.
> >> >> > > >
> >> >> > > > So kswapd needs to retry its scan priority loop with cache_trim_mode
> >> >> > > > off again if the mode doesn't work for reclaim.
> >> >> > > >
> >> >> > > > The problematic behavior can be reproduced by:
> >> >> > > >
> >> >> > > >    CONFIG_NUMA_BALANCING enabled
> >> >> > > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> >> >> > > >    numa node0 (8GB local memory, 16 CPUs)
> >> >> > > >    numa node1 (8GB slow tier memory, no CPUs)
> >> >> > > >
> >> >> > > >    Sequence:
> >> >> > > >
> >> >> > > >    1) echo 3 > /proc/sys/vm/drop_caches
> >> >> > > >    2) To emulate the system with full of cold memory in local DRAM, run
> >> >> > > >       the following dummy program and never touch the region:
> >> >> > > >
> >> >> > > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> >> >> > > >               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> >> >> > > >
> >> >> > > >    3) Run any memory intensive work e.g. XSBench.
> >> >> > > >    4) Check if numa balancing is working e.i. promotion/demotion.
> >> >> > > >    5) Iterate 1) ~ 4) until numa balancing stops.
> >> >> > > >
> >> >> > > > With this, you could see that promotion/demotion are not working because
> >> >> > > > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> >> >> > > >
> >> >> > > > Interesting vmstat delta's differences between before and after are like:
> >> >> > > >
> >> >> > > >    +-----------------------+-------------------------------+
> >> >> > > >    | interesting vmstat    | before        | after         |
> >> >> > > >    +-----------------------+-------------------------------+
> >> >> > > >    | nr_inactive_anon      | 321935        | 1664772       |
> >> >> > > >    | nr_active_anon        | 1780700       | 437834        |
> >> >> > > >    | nr_inactive_file      | 30425         | 40882         |
> >> >> > > >    | nr_active_file        | 14961         | 3012          |
> >> >> > > >    | pgpromote_success     | 356           | 1293122       |
> >> >> > > >    | pgpromote_candidate   | 21953245      | 1824148       |
> >> >> > > >    | pgactivate            | 1844523       | 3311907       |
> >> >> > > >    | pgdeactivate          | 50634         | 1554069       |
> >> >> > > >    | pgfault               | 31100294      | 6518806       |
> >> >> > > >    | pgdemote_kswapd       | 30856         | 2230821       |
> >> >> > > >    | pgscan_kswapd         | 1861981       | 7667629       |
> >> >> > > >    | pgscan_anon           | 1822930       | 7610583       |
> >> >> > > >    | pgscan_file           | 39051         | 57046         |
> >> >> > > >    | pgsteal_anon          | 386           | 2192033       |
> >> >> > > >    | pgsteal_file          | 30470         | 38788         |
> >> >> > > >    | pageoutrun            | 30            | 412           |
> >> >> > > >    | numa_hint_faults      | 27418279      | 2875955       |
> >> >> > > >    | numa_pages_migrated   | 356           | 1293122       |
> >> >> > > >    +-----------------------+-------------------------------+
> >> >> > > >
> >> >> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> >> >> > > > ---
> >> >> > > >  mm/vmscan.c | 21 ++++++++++++++++++++-
> >> >> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> >> >> > > >
> >> >> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> >> > > > index bba207f41b14..6fe45eca7766 100644
> >> >> > > > --- a/mm/vmscan.c
> >> >> > > > +++ b/mm/vmscan.c
> >> >> > > > @@ -108,6 +108,12 @@ struct scan_control {
> >> >> > > >  	/* Can folios be swapped as part of reclaim? */
> >> >> > > >  	unsigned int may_swap:1;
> >> >> > > >  
> >> >> > > > +	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
> >> >> > > > +	unsigned int no_cache_trim_mode:1;
> >> >> > > > +
> >> >> > > > +	/* Has cache_trim_mode failed at least once? */
> >> >> > > > +	unsigned int cache_trim_mode_failed:1;
> >> >> > > > +
> >> >> > > >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> >> >> > > >  	unsigned int proactive:1;
> >> >> > > >  
> >> >> > > > @@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> >> >> > > >  	 * anonymous pages.
> >> >> > > >  	 */
> >> >> > > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> >> >> > > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> >> >> > > > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> >> >> > > > +	    !sc->no_cache_trim_mode)
> >> >> > > >  		sc->cache_trim_mode = 1;
> >> >> > > >  	else
> >> >> > > >  		sc->cache_trim_mode = 0;
> >> >> > > > @@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >> >> > > >  	 */
> >> >> > > >  	if (reclaimable)
> >> >> > > >  		pgdat->kswapd_failures = 0;
> >> >> > > > +	else if (sc->cache_trim_mode)
> >> >> > > > +		sc->cache_trim_mode_failed = 1;
> >> >> > > >  }
> >> >> > > >  
> >> >> > > >  /*
> >> >> > > > @@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >> >> > > >  			sc.priority--;
> >> >> > > >  	} while (sc.priority >= 1);
> >> >> > > >  
> >> >> > > > +	/*
> >> >> > > > +	 * Restart only if it went through the priority loop all the way,
> >> >> > > > +	 * but cache_trim_mode didn't work.
> >> >> > > > +	 */
> >> >> > > > +	if (!sc.nr_reclaimed && sc.priority < 1 &&
> >> >> > > > +	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
> >> >> > > 
> >> >> > > Can we just use sc.cache_trim_mode (instead of
> >> >> > > sc.cache_trim_mode_failed) here?  That is, if cache_trim_mode is enabled
> >> >> > 
> >> >> > As Johannes mentioned, within a priority scan, all the numa nodes are
> >> >> > scanned each with its own value of cache_trim_mode. So we cannot use
> >> >> > cache_trim_mode for that purpose.
> >> >> 
> >> >> Ah, okay. Confining to kswapd, that might make sense. I will apply it if
> >> >> there's no objection to it. Thanks.
> >> >
> >> > I didn't want to introduce two additional flags either, but it was
> >> > possible to make it do exactly what we want it to do thanks to the flags.
> >> > I'd like to keep this version if possible unless there are any other
> >> > objections on it.
> >> 
> >> Sorry, I'm confused.  Whether does "cache_trim_mode == 1" do the trick?
> >> If so, why not?  If not, why?
> >
> > kswapd might happen to go through:
> >
> > priority 12(== DEF_PRIORITY) + cache_trim_mode on -> fail
> > priority 11 + cache_trim_mode on -> fail
> > priority 10 + cache_trim_mode on -> fail
> > priority 9 + cache_trim_mode on -> fail
> > priority 8 + cache_trim_mode on -> fail
> > priority 7 + cache_trim_mode on -> fail
> > priority 6 + cache_trim_mode on -> fail
> > priority 5 + cache_trim_mode on -> fail
> > priority 4 + cache_trim_mode on -> fail
> > priority 3 + cache_trim_mode on -> fail
> > priority 2 + cache_trim_mode on -> fail
> > priority 1 + cache_trim_mode off -> fail
> >
> > I'd like to retry even in this case. 
> 
> I don't think that we should retry in this case.  If the following case
> fails,
> 
> > priority 1 + cache_trim_mode off -> fail
> 
> Why will we succeed after retrying?

At priority 1, anon pages will be partially scanned. However, there
might be anon pages that have never been scanned but can be reclaimed.

Do I get it wrong?

	Byungchul

> --
> Best Regards,
> Huang, Ying
> 
> > Am I missing something?
> >
> > 	Byungchul
> >
> >> --
> >> Best Regards,
> >> Huang, Ying
> >> 
> >> > 	Byungchul
> >> >
> >> >> 	Byungchul
> >> >> > 
> >> >> > 	Byungchul
> >> >> > 
> >> >> > > for priority == 1 and failed to reclaim, we will restart.  If this
> >> >> > > works, we can avoid to add another flag.
> >> >> > > 
> >> >> > > > +		sc.no_cache_trim_mode = 1;
> >> >> > > > +		goto restart;
> >> >> > > > +	}
> >> >> > > > +
> >> >> > > >  	if (!sc.nr_reclaimed)
> >> >> > > >  		pgdat->kswapd_failures++;
> >> >> > > 
> >> >> > > --
> >> >> > > Best Regards,
> >> >> > > Huang, Ying

