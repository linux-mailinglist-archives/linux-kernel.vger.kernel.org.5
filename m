Return-Path: <linux-kernel+bounces-60208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F512850171
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F051E289815
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78C20F1;
	Sat, 10 Feb 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CloOSgX/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E26121
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707527731; cv=none; b=hMCbr8F9pk/WA+Murl11EvLOcY0DmsoS0MnY/UW95d95aGftMyT6EudQYOPDAKWJY6u9XsET/RstUUKksZe14eSnDiJsz60Bd1Kii7MTPF8raULy20LhRrttb3mpjVvvJT6q5rFa6oenrEwVb/TJEEnm8CTxTMkgKJ5zknNb4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707527731; c=relaxed/simple;
	bh=JNXGB2zQQhnn/PrzqM1v1dfxZQ7EbUK4ulGfUSW4zno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEfqC6nfAbPdguZVfg3F2zO8p7SrcLhJgwfP/B/5LBNjysY/aWndHW605ZYGMRHX35sOKMUplEpiO5PPzQzSWqFou1MtezTf2xIIlDcNgtnBl6YBCG8REJrt4bYv2OVTtq7FcaoJgJoANGg2cdaMb1SxO+K+f/zNOXn23VdAlYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CloOSgX/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707527729; x=1739063729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JNXGB2zQQhnn/PrzqM1v1dfxZQ7EbUK4ulGfUSW4zno=;
  b=CloOSgX/RvtyskDosha8bRU1GrwZyyGriumeHzQc7voB1cIBe3v1Cle5
   cVjxRKQOscSOWzHxdSRhN//MvZ8ndBUz5ASQERvl1jmkUnTfDHi9doU26
   Ndt/acdLzTUakrqPlvQMTW5qMj+RN2oxrdbQpyDsLJha44o0jjjm1AHIu
   h8XGXMRysgfT0DwzQ9MP5CbyP9evixE0HIASKe8+e50hIqskEIXawBOw7
   imCPRw7XaHlR6Te5p+l7en7bvn45ARlpj/PDLEAxdzQ1q5kJynKK1hJl4
   U/WhXypPBSPGDtQ1Ml4N//s5k7MuU1kmRIQKeL1pVW4DMhXCK1ZzLcjKY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19036626"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="19036626"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 17:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="6834222"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 17:15:27 -0800
Date: Fri, 9 Feb 2024 17:16:43 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: kuiliang Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, yangyicong@hisilicon.com
Subject: Re: [PATCH v4 3/4] sched/fair: Rework sched_use_asym_prio() and
 sched_asym_prefer()
Message-ID: <20240210011643.GB28896@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-3-alexs@kernel.org>
 <20240209024737.GA10494@ranerica-svr.sc.intel.com>
 <44411da9-4cda-47ff-a73d-a66c63757930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44411da9-4cda-47ff-a73d-a66c63757930@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Feb 09, 2024 at 07:08:52PM +0800, kuiliang Shi wrote:
> 
> 
> On 2/9/24 10:47 AM, Ricardo Neri wrote:
> > On Wed, Feb 07, 2024 at 11:47:03AM +0800, alexs@kernel.org wrote:
> >> From: Alex Shi <alexs@kernel.org>
> >>
> >> sched_use_asym_prio() sched_asym_prefer() are used together in various
> > 
> > s/prio() sched/prio() and sched/
> 
> Will take it, Thanks!
> 
> > 
> >> places. Consolidate them into a single function sched_asym().
> >>
> >> The existing sched_group_asym() is only used when collecting statistics
> >> of a scheduling group. Rename it as sched_group_asym().
> >> This makes the code easier to read. No functional changes.
> >>
> >> Signed-off-by: Alex Shi <alexs@kernel.org>
> >> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >> To: Valentin Schneider <vschneid@redhat.com>
> >> To: Vincent Guittot <vincent.guittot@linaro.org>
> >> To: Peter Zijlstra <peterz@infradead.org>
> >> To: Ingo Molnar <mingo@redhat.com>
> >> ---
> >>  kernel/sched/fair.c | 37 ++++++++++++++++++++-----------------
> >>  1 file changed, 20 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 607dc310b355..942b6358f683 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -9746,8 +9746,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
> >>  	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
> >>  }
> >>  
> >> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
> >> +{
> >> +	/*
> >> +	 * First check if @dst_cpu can do asym_packing load balance. Only do it
> >> +	 * if it has higher priority than @src_cpu.
> >> +	 */
> >> +	return sched_use_asym_prio(sd, dst_cpu) &&
> >> +		sched_asym_prefer(dst_cpu, src_cpu);
> >> +}
> >> +
> >>  /**
> >> - * sched_asym - Check if the destination CPU can do asym_packing load balance
> >> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
> >>   * @env:	The load balancing environment
> >>   * @sgs:	Load-balancing statistics of the candidate busiest group
> >>   * @group:	The candidate busiest group
> > 
> > After renaming and changing this function now its documentation has become
> > obsolete. Can you update it?
> 
> Since the function sched_use_asym_prio() and sched_asym_prefer() both give detailed comments for their actions, as long as this function does, could we just remove the bit obsolete comments here?
> 
> 
> @@ -9765,14 +9765,6 @@ static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
>   * @env::dst_cpu can do asym_packing if it has higher priority than the
>   * preferred CPU of @group.
>   *
> - * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
> - * can do asym_packing balance only if all its SMT siblings are idle. Also, it
> - * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
> - * imbalances in the number of CPUS are dealt with in find_busiest_group().
> - *
> - * If we are balancing load within an SMT core, or at PKG domain level, always
> - * proceed.
> - *
>   * Return: true if @env::dst_cpu can do with asym_packing load balance. False
>   * otherwise.

Fine with me.

With this change,
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Tested on Alder Lake and Meteor Lake, which use asym_packing.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> >  

