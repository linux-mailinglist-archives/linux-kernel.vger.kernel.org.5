Return-Path: <linux-kernel+bounces-77605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08BD8607FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A61C20326
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FACAD27;
	Fri, 23 Feb 2024 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELtCNww0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09975AD22
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650340; cv=none; b=MLk6XFaHTLuhfqW13JfL3n/GdwuZ0ErCdo57wzqsnwy+8u2XyyZ4itqswNppRzJS7DAE2yZmfOUCIdOWo1yylNxtarZVXp7R80Rbx+xBtC6p7WDXs2Y7PDQYmTUZikSdW33BuCahazxjVW/xVB+j0JSiUZiqRR6m5tn8UtJm5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650340; c=relaxed/simple;
	bh=gB7mf/OyHTy5Fguvmc8J5o3drqi69mmOKqEonRSknBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qgHtLNvw3Wr3h+YL4Ft/6OSCaa1zIJtqbnWVQckOBYS1d2gON4eS5sv3gtlrCPlLqgc5oPeMfQ84mX+/+HHMra4fb4Ot2EqRd8Xr7lAQ8xfS8vfpZ5VXGW8grIpD+CPS7Iz8jARI0CBaEtR393145eDGB8vWtrRmCkH6NZS604E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELtCNww0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708650339; x=1740186339;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gB7mf/OyHTy5Fguvmc8J5o3drqi69mmOKqEonRSknBs=;
  b=ELtCNww05twGlY5BbovCuZO7giX3GsLwptN1CVomsTnSwWYXGHC6iyMD
   b8ZmB80cjUBsdwOm3q7IphMzcVrEYeLuzLD3FAjAZCIEfvgz3Ecb7jUvR
   M89/VjR2tHtXsCntQP5QgR84Wbh9OlUjbzd9XLddXmS/MKO6ejdfjJbn/
   kCMFuzjvJunITQRGBmzYo4U7oYSZzHR8CSrtu3kccMyfbeOjtXSjXLdIj
   qCA61oCYHPBoA7YR8mUZPEzXKRKNl/N3N3uK2wENceKk8xv+qWfSUafRl
   6bathzE4FhYF2PdAHphnaN4rCWc4AjlI+3xOWN+QCoym3eUb6vexocvBs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3106290"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3106290"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 17:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="827706957"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="827706957"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 17:05:35 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Byungchul Park <byungchul@sk.com>
Cc: <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <kernel_team@skhynix.com>,  <yuzhao@google.com>,
  <mgorman@suse.de>
Subject: Re: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high
 scan priorities
In-Reply-To: <20240222100129.GB13076@system.software.com> (Byungchul Park's
	message of "Thu, 22 Feb 2024 19:01:29 +0900")
References: <20240222070817.70515-1-byungchul@sk.com>
	<87sf1kj3nn.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240222092042.GA33967@system.software.com>
	<20240222094900.GA13076@system.software.com>
	<20240222100129.GB13076@system.software.com>
Date: Fri, 23 Feb 2024 09:03:39 +0800
Message-ID: <87o7c8htzo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Byungchul Park <byungchul@sk.com> writes:

> On Thu, Feb 22, 2024 at 06:49:00PM +0900, Byungchul Park wrote:
>> On Thu, Feb 22, 2024 at 06:20:42PM +0900, Byungchul Park wrote:
>> > On Thu, Feb 22, 2024 at 04:37:16PM +0800, Huang, Ying wrote:
>> > > Byungchul Park <byungchul@sk.com> writes:
>> > > 
>> > > > Changes from v1:
>> > > > 	1. Add a comment describing why this change is necessary in code
>> > > > 	   and rewrite the commit message with how to reproduce and what
>> > > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
>> > > > 	   Yu Zhao)
>> > > > 	2. Change the condition to avoid cache_trim_mode from
>> > > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
>> > > > 	   where the priority goes to zero all the way. (feedbacked by
>> > > > 	   Yu Zhao)
>> > > >
>> > > > --->8---
>> > > > From 07e0baab368160e50b6ca35d95745168aa60e217 Mon Sep 17 00:00:00 2001
>> > > > From: Byungchul Park <byungchul@sk.com>
>> > > > Date: Thu, 22 Feb 2024 14:50:17 +0900
>> > > > Subject: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high scan priorities
>> > > >
>> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
>> > > > pages.  However, it should be more careful to turn on the mode because
>> > > > it's going to prevent anon pages from being reclaimed even if there are
>> > > > a huge number of anon pages that are cold and should be reclaimed.  Even
>> > > > worse, that can lead kswapd_failures to reach MAX_RECLAIM_RETRIES and
>> > > > stopping kswapd until direct reclaim eventually works to resume kswapd.
>> > > > So this is more like a bug fix than a performance improvement.
>> > > >
>> > > > The problematic behavior can be reproduced by:
>> > > >
>> > > >    CONFIG_NUMA_BALANCING enabled
>> > > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>> > > >
>> > > >    numa node0 (8GB local memory, 16 CPUs)
>> > > >    numa node1 (8GB slow tier memory, no CPUs)
>> > > >
>> > > >    Sequence:
>> > > >
>> > > >    1) echo 3 > /proc/sys/vm/drop_caches
>> > > >    2) To emulate the system with full of cold memory in local DRAM, run
>> > > >       the following dummy program and never touch the region:
>> > > >
>> > > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
>> > > > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
>> > > >
>> > > >    3) Run any memory intensive work e.g. XSBench.
>> > > >    4) Check if numa balancing is working e.i. promotion/demotion.
>> > > >    5) Iterate 1) ~ 4) until kswapd stops.
>> > > >
>> > > > With this, you could eventually see that promotion/demotion are not
>> > > > working because kswapd has stopped due to ->kswapd_failures >=
>> > > > MAX_RECLAIM_RETRIES.
>> > > >
>> > > > Interesting vmstat delta's differences between before and after are like:
>> > > >
>> > > >    -nr_inactive_anon 321935
>> > > >    -nr_active_anon 1780700
>> > > >    -nr_inactive_file 30425
>> > > >    -nr_active_file 14961
>> > > >    -pgpromote_success 356
>> > > >    -pgpromote_candidate 21953245
>> > > >    -pgactivate 1844523
>> > > >    -pgdeactivate 50634
>> > > >    -pgfault 31100294
>> > > >    -pgdemote_kswapd 30856
>> > > >    -pgscan_kswapd 1861981
>> > > >    -pgscan_anon 1822930
>> > > >    -pgscan_file 39051
>> > > >    -pgsteal_anon 386
>> > > >    -pgsteal_file 30470
>> > > >    -pageoutrun 30
>> > > >    -numa_hint_faults 27418279
>> > > >    -numa_pages_migrated 356
>> > > >
>> > > >    +nr_inactive_anon 1662306
>> > > >    +nr_active_anon 440303
>> > > >    +nr_inactive_file 27669
>> > > >    +nr_active_file 1654
>> > > >    +pgpromote_success 1314102
>> > > >    +pgpromote_candidate 1892525
>> > > >    +pgactivate 3284457
>> > > >    +pgdeactivate 1527504
>> > > >    +pgfault 6847775
>> > > >    +pgdemote_kswapd 2142047
>> > > >    +pgscan_kswapd 7496588
>> > > >    +pgscan_anon 7462488
>> > > >    +pgscan_file 34100
>> > > >    +pgsteal_anon 2115661
>> > > >    +pgsteal_file 26386
>> > > >    +pageoutrun 378
>> > > >    +numa_hint_faults 3220891
>> > > >    +numa_pages_migrated 1314102
>> > > >
>> > > >    where -: before this patch, +: after this patch
>> > > >
>> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > > > ---
>> > > >  mm/vmscan.c | 10 +++++++++-
>> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > > > index bba207f41b14..6eda59fce5ee 100644
>> > > > --- a/mm/vmscan.c
>> > > > +++ b/mm/vmscan.c
>> > > > @@ -2266,9 +2266,17 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>> > > >  	 * If we have plenty of inactive file pages that aren't
>> > > >  	 * thrashing, try to reclaim those first before touching
>> > > >  	 * anonymous pages.
>> > > > +	 *
>> > > > +	 * However, the condition 'sc->cache_trim_mode == 1' all through
>> > > > +	 * the scan priorties might lead reclaim failure. If it keeps
>> > > > +	 * MAX_RECLAIM_RETRIES times, then kswapd would get stopped even
>> > > > +	 * if there are still plenty anon pages to reclaim, which is not
>> > > > +	 * desirable. So do not use cache_trim_mode when reclaim is not
>> > > > +	 * smooth e.i. high scan priority.
>> > > >  	 */
>> > > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
>> > > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
>> > > > +	if (sc->priority > 1 && file >> sc->priority &&
>> > > > +	    !(sc->may_deactivate & DEACTIVATE_FILE))
>> > > >  		sc->cache_trim_mode = 1;
>> > > >  	else
>> > > >  		sc->cache_trim_mode = 0;
>> > > 
>> > > In get_scan_count(), there's following code,
>> > > 
>> > > 	/*
>> > > 	 * Do not apply any pressure balancing cleverness when the
>> > > 	 * system is close to OOM, scan both anon and file equally
>> > > 	 * (unless the swappiness setting disagrees with swapping).
>> > > 	 */
>> > > 	if (!sc->priority && swappiness) {
>> > > 		scan_balance = SCAN_EQUAL;
>> > > 		goto out;
>> > > 	}
>> > > 
>> > > So, swappiness is 0 in you system?  Please check it.  If it's not 0,
>> > > please check why this doesn't help.
>> > 
>> > Nice information! Then the change should be:
>> > 
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index bba207f41b14..91f9bab86e92 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -2357,7 +2357,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>> >  	 * system is close to OOM, scan both anon and file equally
>> >  	 * (unless the swappiness setting disagrees with swapping).
>> >  	 */
>> > -	if (!sc->priority && swappiness) {
>> > +	if (sc->priority <= 1 && swappiness) {
>> >  		scan_balance = SCAN_EQUAL;
>> >  		goto out;
>> >  	}
>> 
>> Or:
>> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index bba207f41b14..c54371a398b1 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -6896,7 +6896,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>>  
>>  		if (raise_priority || !nr_reclaimed)
>>  			sc.priority--;
>> -	} while (sc.priority >= 1);
>> +	} while (sc.priority >= 0);
>>  
>>  	if (!sc.nr_reclaimed)
>>  		pgdat->kswapd_failures++;
>
> +cc Mel Gorman
>
> I just found this was intended. See commit 9aa41348a8d11 ("mm: vmscan:
> do not allow kswapd to scan at maximum priority"). Mel Gorman didn't want
> to make kswapd too much aggressive. However, does it make sense to stop
> kswapd even if there are plenty cold anon pages to reclaim and make the
> system wait for direct reclaim?

Maybe we can play with cache_trim_mode, for example, if sc.nr_reclaimed
== 0 and sc.cache_trim_mode == true, force disabling cache_trim_mode in
the next round?

--
Best Regards,
Huang, Ying

> Thoughts?
>
> 	Byungchul
>
>> ---
>> 
>> 	Byungchul
>> 
>> > Worth noting that the priority goes from DEF_PRIORITY to 1 in
>> > balance_pgdat() of kswapd. I will change how to fix to this if this
>> > looks more reasonable.
>> > 
>> > 	Byungchul

