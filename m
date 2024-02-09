Return-Path: <linux-kernel+bounces-58947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C82C84EF00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ED81F28871
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89532525E;
	Fri,  9 Feb 2024 02:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yp4Ke0Xp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BD5224
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446782; cv=none; b=lyX9Q8Tys/Z2hlghAIWJVkyqBk8NXxpIFvu3AhjmmxzP1k39JthEt0Ul7SafHvZ3iD5yzH2wsKQf6UQBU1CHdNbl208dsSreWgsdx7/wywiUBuPIPmWdo/Vp0PL76RG77X2wVti/ji1DLCc4CTlUM90rbsS74PB5i5W3Ncgc2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446782; c=relaxed/simple;
	bh=TX6xbDNR+VhiOrMf9aaMf+IlEioElh0ZJt0LW9ypZd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdPz0WOGRLQbpY1mT0eLzzlNEaBjTksQ1P7pqdAN02hUlTqJgu2+wfsAHbvdiRRGQq3PO8Uh8SXeTUsGx8ag9NgSP6gV+yofaj57s/x8rNsiNUIDPermUhLg9VOhbk3VRwAOqS+FTTWZi/87IvFbfaaq7yOiUuaBRf5+oTcCYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yp4Ke0Xp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707446781; x=1738982781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TX6xbDNR+VhiOrMf9aaMf+IlEioElh0ZJt0LW9ypZd8=;
  b=Yp4Ke0XpMDfK+Ofs2eRPXOzr+V75Izd6N5rBhJVJ6yHUTIRlBIjEFC/U
   koyN2uFQxgU//Cm72GeOOsfqhusbf7Xq3b4spBRuVXsY6iVCiLlz4SebV
   dTUePESLiAB9ZBI7dN25PN+K3ZbzOV8aNeS/UPZfGG3kBHXBmV6ixpSxR
   eAaZZzz2EKkmOt39yJK+j05Zs59HxEeYxP3wSU2gLSC++Y1K0ASdPTZ6s
   LNvtQUOPUpluZWrQCE734fxzu0GLpy8NLM66SUK6t/CXSfU1dIdFZQPGo
   6+kRR3O8T/CQRw+ebIIyWZAfYq/FtvgP7TndTa5PE7pdixyLKUm/6RvLq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="26812795"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="26812795"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="2138368"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:46:20 -0800
Date: Thu, 8 Feb 2024 18:47:37 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20240209024737.GA10494@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-3-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207034704.935774-3-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Feb 07, 2024 at 11:47:03AM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> sched_use_asym_prio() sched_asym_prefer() are used together in various

s/prio() sched/prio() and sched/

> places. Consolidate them into a single function sched_asym().
> 
> The existing sched_group_asym() is only used when collecting statistics
> of a scheduling group. Rename it as sched_group_asym().
> This makes the code easier to read. No functional changes.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/fair.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 607dc310b355..942b6358f683 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9746,8 +9746,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>  }
>  
> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
> +{
> +	/*
> +	 * First check if @dst_cpu can do asym_packing load balance. Only do it
> +	 * if it has higher priority than @src_cpu.
> +	 */
> +	return sched_use_asym_prio(sd, dst_cpu) &&
> +		sched_asym_prefer(dst_cpu, src_cpu);
> +}
> +
>  /**
> - * sched_asym - Check if the destination CPU can do asym_packing load balance
> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
>   * @env:	The load balancing environment
>   * @sgs:	Load-balancing statistics of the candidate busiest group
>   * @group:	The candidate busiest group

After renaming and changing this function now its documentation has become
obsolete. Can you update it?
 

