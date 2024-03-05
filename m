Return-Path: <linux-kernel+bounces-92376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6721871F32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EB81F26849
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F445B5C3;
	Tue,  5 Mar 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xY7Xrtnv"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AD5C91B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641665; cv=none; b=B3E7XL5okWGcDJwhGcu0zNpuLC30kJ8shwZl6lMO2QO0iYReq/haBwEPwZtyytcbKh0/tIHjlTf5Ozhk71BQ/+9eZBpYmDlhszNcOUDO5Hsm8QnbkwYYqbr4YLeobsLbnnURqYiPIlSBUQiK7HCvVxxqy5WnKv8SrM3f04jHHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641665; c=relaxed/simple;
	bh=JROBvwxaCncZY1QiHIe/9VYS5VsBpAFkP88vFwlbf1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2EfmqaczbAIgkghWvoHbsJAlgCv4b8qNPIRL8ArPnMyjeV6ouU9gvEIpMX74I22QeNxZY5gYtBziu7Vd/IV5UUcqqQ4k5f3I/3PEz39GpSguzGgVXPmE2jx0iUbDtTcsHeAixic6/Zz6c96az8/3lA3UnXSl2kjNlx1oWq4uUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=xY7Xrtnv; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68facd7ea4bso25407816d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709641661; x=1710246461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7npW07XKr/sesNCzlyCaetoylOj6MEy8Wtjk01mzD8=;
        b=xY7XrtnvSkMW6tSrg72LRy+IcjQ+8yZt6lx8HfFwYjUdANZcJR3IhdLU+nrlIRyYHK
         /tQxLj5FIFK+p3pf2eZKPjut33jFM+bkiCJO6d5DjVf9ovB0qXhgV4fOgbOJ4EbTc2kO
         wOt1I0tRuCXHwuIj53UM+VafU/pC3OQM4DgBnxfu+qqLyJMA2oiFFK3VcQLw091VZ7hb
         TDGR5vSwbqq/XltWP6zOmOVdh4EItPQgaYMwOf80G+pPL8bbeuFUvbvX2EtZVo0x/0Dt
         YsQz2sYQ9GDe2qTCDK+vuiKAeisZN1GY0Kk3zdU2VVlg09mSu/fNpgKGIT+U1H3rgUGf
         y2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641661; x=1710246461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7npW07XKr/sesNCzlyCaetoylOj6MEy8Wtjk01mzD8=;
        b=X93YsPhdMtH23/oOOrvMhAP8OGhFcr7xj/h3buabZ4IRVvQgNtlJcnF2amu255WS9L
         w94K81xFFShgSNozTfs7u37mNXTjbNcmIn8md6hlcigVIoSlSDDpnt96BQIaGsGtC+c5
         IsGhHKjiyNzVchFsCVfZVhQNTEyF6m61DtrnCUNgBRP/r0bvJ6oyg0MExR43fLJzdo8b
         Om+y0ay3LYTW+9s9U75aPRzKGguTLOgG5oCxi4G7rf/JvY/abhEZ3q0R1LzAQiuonYJj
         gpzDlsd8XKOxXmCpWxdlcf8j//cXtULHVHdf4mTbcMPHqu5e/69ULvyvPRi26ct7yu+5
         nCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgXfCfucNEiNmMvj/uM+z6R1feUg214DUOS9u5utpWTnoTEMxtHNRcoqD96nJzqO58AfudTvktwVn22cq9qdrLa8tayuVDq3u28NPw
X-Gm-Message-State: AOJu0Yw1X+Ntd+I5qxiZNVF+FoYmu2yWPu4gB5XL/qN3tHGmB1a95kxJ
	KNtk9YOMj3YTuiqfAES1qzceAVZ9uNkbxPB69mPCKvTvmhjFslSm5eSvZSgDtWc=
X-Google-Smtp-Source: AGHT+IHghBjyUrmV51cbLk6o3bUSckLkjnzydvcaxZIGH5inyNDZCVMIeiMuQ2kr7qeZxtOHL7SOLg==
X-Received: by 2002:ad4:5306:0:b0:690:681d:47a0 with SMTP id y6-20020ad45306000000b00690681d47a0mr1768297qvr.34.1709641660730;
        Tue, 05 Mar 2024 04:27:40 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id a19-20020a0ce353000000b00690314356a4sm6115399qvm.80.2024.03.05.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:27:39 -0800 (PST)
Date: Tue, 5 Mar 2024 07:27:38 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Byungchul Park <byungchul@sk.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, yuzhao@google.com
Subject: Re: [PATCH v6] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240305122738.GA1491027@cmpxchg.org>
References: <87zfvda1f8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305023708.GA60719@system.software.com>
 <20240305024345.GB60719@system.software.com>
 <20240305040930.GA21107@system.software.com>
 <87le6x9p6u.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305065846.GA37850@system.software.com>
 <87cys99n1r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305071232.GB37850@system.software.com>
 <874jdl9lmg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240305075538.GA3152@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305075538.GA3152@system.software.com>

On Tue, Mar 05, 2024 at 04:55:38PM +0900, Byungchul Park wrote:
> On Tue, Mar 05, 2024 at 03:35:35PM +0800, Huang, Ying wrote:
> > Byungchul Park <byungchul@sk.com> writes:
> > 
> > > On Tue, Mar 05, 2024 at 03:04:48PM +0800, Huang, Ying wrote:
> > >> Byungchul Park <byungchul@sk.com> writes:
> > >> 
> > >> > On Tue, Mar 05, 2024 at 02:18:33PM +0800, Huang, Ying wrote:
> > >> >> Byungchul Park <byungchul@sk.com> writes:
> > >> >> 
> > >> >> > On Tue, Mar 05, 2024 at 11:43:45AM +0900, Byungchul Park wrote:
> > >> >> >> On Tue, Mar 05, 2024 at 11:37:08AM +0900, Byungchul Park wrote:
> > >> >> >> > On Tue, Mar 05, 2024 at 09:54:19AM +0800, Huang, Ying wrote:
> > >> >> >> > > Byungchul Park <byungchul@sk.com> writes:
> > >> >> >> > > 
> > >> >> >> > > > Changes from v5:
> > >> >> >> > > > 	1. Make it retry the kswapd's scan priority loop with
> > >> >> >> > > > 	   cache_trim_mode off *only if* the mode didn't work in the
> > >> >> >> > > > 	   previous loop. (feedbacked by Huang Ying)
> > >> >> >> > > > 	2. Take into account 'break's from the priority loop when making
> > >> >> >> > > > 	   the decision whether to retry. (feedbacked by Huang Ying)
> > >> >> >> > > > 	3. Update the test result in the commit message.
> > >> >> >> > > >
> > >> >> >> > > > Changes from v4:
> > >> >> >> > > > 	1. Make other scans start with may_cache_trim_mode = 1.
> > >> >> >> > > >
> > >> >> >> > > > Changes from v3:
> > >> >> >> > > > 	1. Update the test result in the commit message with v4.
> > >> >> >> > > > 	2. Retry the whole priority loop with cache_trim_mode off again,
> > >> >> >> > > > 	   rather than forcing the mode off at the highest priority,
> > >> >> >> > > > 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> > >> >> >> > > >
> > >> >> >> > > > Changes from v2:
> > >> >> >> > > > 	1. Change the condition to stop cache_trim_mode.
> > >> >> >> > > >
> > >> >> >> > > > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> > >> >> >> > > > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> > >> >> >> > > > 	          the mode didn't work in the previous turn.
> > >> >> >> > > >
> > >> >> >> > > > 	   (feedbacked by Huang Ying)
> > >> >> >> > > >
> > >> >> >> > > > 	2. Change the test result in the commit message after testing
> > >> >> >> > > > 	   with the new logic.
> > >> >> >> > > >
> > >> >> >> > > > Changes from v1:
> > >> >> >> > > > 	1. Add a comment describing why this change is necessary in code
> > >> >> >> > > > 	   and rewrite the commit message with how to reproduce and what
> > >> >> >> > > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> > >> >> >> > > > 	   Yu Zhao)
> > >> >> >> > > > 	2. Change the condition to avoid cache_trim_mode from
> > >> >> >> > > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> > >> >> >> > > > 	   where the priority goes to zero all the way. (feedbacked by
> > >> >> >> > > > 	   Yu Zhao)
> > >> >> >> > > >
> > >> >> >> > > > --->8---
> > >> >> >> > > > From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
> > >> >> >> > > > From: Byungchul Park <byungchul@sk.com>
> > >> >> >> > > > Date: Mon, 4 Mar 2024 15:27:37 +0900
> > >> >> >> > > > Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> > >> >> >> > > >
> > >> >> >> > > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > >> >> >> > > > pages.  However, it should be more careful to use the mode because it's
> > >> >> >> > > > going to prevent anon pages from being reclaimed even if there are a
> > >> >> >> > > > huge number of anon pages that are cold and should be reclaimed.  Even
> > >> >> >> > > > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> > >> >> >> > > > stopping kswapd from functioning until direct reclaim eventually works
> > >> >> >> > > > to resume kswapd.
> > >> >> >> > > >
> > >> >> >> > > > So kswapd needs to retry its scan priority loop with cache_trim_mode
> > >> >> >> > > > off again if the mode doesn't work for reclaim.
> > >> >> >> > > >
> > >> >> >> > > > The problematic behavior can be reproduced by:
> > >> >> >> > > >
> > >> >> >> > > >    CONFIG_NUMA_BALANCING enabled
> > >> >> >> > > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > >> >> >> > > >    numa node0 (8GB local memory, 16 CPUs)
> > >> >> >> > > >    numa node1 (8GB slow tier memory, no CPUs)
> > >> >> >> > > >
> > >> >> >> > > >    Sequence:
> > >> >> >> > > >
> > >> >> >> > > >    1) echo 3 > /proc/sys/vm/drop_caches
> > >> >> >> > > >    2) To emulate the system with full of cold memory in local DRAM, run
> > >> >> >> > > >       the following dummy program and never touch the region:
> > >> >> >> > > >
> > >> >> >> > > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> > >> >> >> > > >               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> > >> >> >> > > >
> > >> >> >> > > >    3) Run any memory intensive work e.g. XSBench.
> > >> >> >> > > >    4) Check if numa balancing is working e.i. promotion/demotion.
> > >> >> >> > > >    5) Iterate 1) ~ 4) until numa balancing stops.
> > >> >> >> > > >
> > >> >> >> > > > With this, you could see that promotion/demotion are not working because
> > >> >> >> > > > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> > >> >> >> > > >
> > >> >> >> > > > Interesting vmstat delta's differences between before and after are like:
> > >> >> >> > > >
> > >> >> >> > > >    +-----------------------+-------------------------------+
> > >> >> >> > > >    | interesting vmstat    | before        | after         |
> > >> >> >> > > >    +-----------------------+-------------------------------+
> > >> >> >> > > >    | nr_inactive_anon      | 321935        | 1664772       |
> > >> >> >> > > >    | nr_active_anon        | 1780700       | 437834        |
> > >> >> >> > > >    | nr_inactive_file      | 30425         | 40882         |
> > >> >> >> > > >    | nr_active_file        | 14961         | 3012          |
> > >> >> >> > > >    | pgpromote_success     | 356           | 1293122       |
> > >> >> >> > > >    | pgpromote_candidate   | 21953245      | 1824148       |
> > >> >> >> > > >    | pgactivate            | 1844523       | 3311907       |
> > >> >> >> > > >    | pgdeactivate          | 50634         | 1554069       |
> > >> >> >> > > >    | pgfault               | 31100294      | 6518806       |
> > >> >> >> > > >    | pgdemote_kswapd       | 30856         | 2230821       |
> > >> >> >> > > >    | pgscan_kswapd         | 1861981       | 7667629       |
> > >> >> >> > > >    | pgscan_anon           | 1822930       | 7610583       |
> > >> >> >> > > >    | pgscan_file           | 39051         | 57046         |
> > >> >> >> > > >    | pgsteal_anon          | 386           | 2192033       |
> > >> >> >> > > >    | pgsteal_file          | 30470         | 38788         |
> > >> >> >> > > >    | pageoutrun            | 30            | 412           |
> > >> >> >> > > >    | numa_hint_faults      | 27418279      | 2875955       |
> > >> >> >> > > >    | numa_pages_migrated   | 356           | 1293122       |
> > >> >> >> > > >    +-----------------------+-------------------------------+
> > >> >> >> > > >
> > >> >> >> > > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > >> >> >> > > > ---
> > >> >> >> > > >  mm/vmscan.c | 21 ++++++++++++++++++++-
> > >> >> >> > > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > >> >> >> > > >
> > >> >> >> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > >> >> >> > > > index bba207f41b14..6fe45eca7766 100644
> > >> >> >> > > > --- a/mm/vmscan.c
> > >> >> >> > > > +++ b/mm/vmscan.c
> > >> >> >> > > > @@ -108,6 +108,12 @@ struct scan_control {
> > >> >> >> > > >  	/* Can folios be swapped as part of reclaim? */
> > >> >> >> > > >  	unsigned int may_swap:1;
> > >> >> >> > > >  
> > >> >> >> > > > +	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
> > >> >> >> > > > +	unsigned int no_cache_trim_mode:1;
> > >> >> >> > > > +
> > >> >> >> > > > +	/* Has cache_trim_mode failed at least once? */
> > >> >> >> > > > +	unsigned int cache_trim_mode_failed:1;
> > >> >> >> > > > +
> > >> >> >> > > >  	/* Proactive reclaim invoked by userspace through memory.reclaim */
> > >> >> >> > > >  	unsigned int proactive:1;
> > >> >> >> > > >  
> > >> >> >> > > > @@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> > >> >> >> > > >  	 * anonymous pages.
> > >> >> >> > > >  	 */
> > >> >> >> > > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > >> >> >> > > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > >> >> >> > > > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> > >> >> >> > > > +	    !sc->no_cache_trim_mode)
> > >> >> >> > > >  		sc->cache_trim_mode = 1;
> > >> >> >> > > >  	else
> > >> >> >> > > >  		sc->cache_trim_mode = 0;
> > >> >> >> > > > @@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >> >> >> > > >  	 */
> > >> >> >> > > >  	if (reclaimable)
> > >> >> >> > > >  		pgdat->kswapd_failures = 0;
> > >> >> >> > > > +	else if (sc->cache_trim_mode)
> > >> >> >> > > > +		sc->cache_trim_mode_failed = 1;
> > >> >> >> > > >  }
> > >> >> >> > > >  
> > >> >> >> > > >  /*
> > >> >> >> > > > @@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> > >> >> >> > > >  			sc.priority--;
> > >> >> >> > > >  	} while (sc.priority >= 1);
> > >> >> >> > > >  
> > >> >> >> > > > +	/*
> > >> >> >> > > > +	 * Restart only if it went through the priority loop all the way,
> > >> >> >> > > > +	 * but cache_trim_mode didn't work.
> > >> >> >> > > > +	 */
> > >> >> >> > > > +	if (!sc.nr_reclaimed && sc.priority < 1 &&
> > >> >> >> > > > +	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
> > >> >> >> > > 
> > >> >> >> > > Can we just use sc.cache_trim_mode (instead of
> > >> >> >> > > sc.cache_trim_mode_failed) here?  That is, if cache_trim_mode is enabled
> > >> >> >> > 
> > >> >> >> > As Johannes mentioned, within a priority scan, all the numa nodes are
> > >> >> >> > scanned each with its own value of cache_trim_mode. So we cannot use
> > >> >> >> > cache_trim_mode for that purpose.
> > >> >> >> 
> > >> >> >> Ah, okay. Confining to kswapd, that might make sense. I will apply it if
> > >> >> >> there's no objection to it. Thanks.
> > >> >> >
> > >> >> > I didn't want to introduce two additional flags either, but it was
> > >> >> > possible to make it do exactly what we want it to do thanks to the flags.
> > >> >> > I'd like to keep this version if possible unless there are any other
> > >> >> > objections on it.
> > >> >> 
> > >> >> Sorry, I'm confused.  Whether does "cache_trim_mode == 1" do the trick?
> > >> >> If so, why not?  If not, why?
> > >> >
> > >> > kswapd might happen to go through:
> > >> >
> > >> > priority 12(== DEF_PRIORITY) + cache_trim_mode on -> fail
> > >> > priority 11 + cache_trim_mode on -> fail
> > >> > priority 10 + cache_trim_mode on -> fail
> > >> > priority 9 + cache_trim_mode on -> fail
> > >> > priority 8 + cache_trim_mode on -> fail
> > >> > priority 7 + cache_trim_mode on -> fail
> > >> > priority 6 + cache_trim_mode on -> fail
> > >> > priority 5 + cache_trim_mode on -> fail
> > >> > priority 4 + cache_trim_mode on -> fail
> > >> > priority 3 + cache_trim_mode on -> fail
> > >> > priority 2 + cache_trim_mode on -> fail
> > >> > priority 1 + cache_trim_mode off -> fail
> > >> >
> > >> > I'd like to retry even in this case. 
> > >> 
> > >> I don't think that we should retry in this case.  If the following case
> > >> fails,
> > >> 
> > >> > priority 1 + cache_trim_mode off -> fail
> > >> 
> > >> Why will we succeed after retrying?
> > >
> > > At priority 1, anon pages will be partially scanned. However, there
> > > might be anon pages that have never been scanned but can be reclaimed.
> > >
> > > Do I get it wrong?
> > 
> > Yes.  In theory, that's possible.  But do you think that will be some
> > practical issue?  So that, pgdat->kswapd_failures will reach max value?
> 
> v6 is based on what Johannes suggested. I thought it's more right way to
> fix the issue.
> 
> Yeah, I also think checking cache_trim_mode only at the kswapd's highest
> priorty would manage to work for the issue.
> 
> I'd like to listen to Johannes's opinion or others.

I slightly prefer the extra flag because it more closely matches the
pattern we have for skipped_deactivate and memcg_low_skipped. IMO
repeating the pattern is better than inventing something new, and this
patch as-is is simple enough.

There is also the thought that we might expand this to direct reclaim
in the future, right? I know your immediate problem at hand is with
kswapd but at least in theory this should apply to direct reclaim as
well unless, I'm missing something. So keeping it generic and easily
reusable seems like a good idea.

Just my 2c.


