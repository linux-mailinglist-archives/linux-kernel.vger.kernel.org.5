Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA997F32E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjKUP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjKUP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:57:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934E139
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700582252; x=1732118252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMXSOw1Tlz4fFt+3gazcD/G08h/FvUpyW6nMRPXwiFs=;
  b=GVzMbo4O2uOXwjPdvP5KRIxJHJGfg4WOVIIRgZL2JZE4AgKI1pf8WSAl
   C1Zq2LZuNn0JxWh0BtT3JXBTQ42Pxe7eEdBfKqBgMSen+Amv8ON/g0Mlq
   Br1MFjsq23Vf/flekVuGY4a9FnUh8/0GxTOAGMaLA07/I8+8Irpi6x0DF
   PuQtg6EteYhloelW2NM9xoCSo1gODRi1H5Ez6FsA+BDwIHtfVeiukDwfm
   Ins0aZ/3BIQNvOe8ZFgMTbGJoF3tasAR7FzKor0Z59hxAYvpDdfym04GU
   ch7DTzx2OPEbL3sFAS9aEx5FW9oIPRM2YdAO/87eRwwi3pvlcdrLaHT5s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="395791732"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="395791732"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:57:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743087677"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="743087677"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:57:31 -0800
Received: from [10.209.157.143] (kliang2-mobl1.ccr.corp.intel.com [10.209.157.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D6A53580BB9;
        Tue, 21 Nov 2023 07:57:29 -0800 (PST)
Message-ID: <46b5cc1b-d703-4ffb-847f-bc14d7884cfa@linux.intel.com>
Date:   Tue, 21 Nov 2023 10:57:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Mingwei Zhang <mizhang@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231120221932.213710-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-20 5:19 p.m., Namhyung Kim wrote:
> It was unnecessarily disabling and enabling PMUs for each event.  It
> should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> at each PMU.  As pmu context has separate active lists for pinned group
> and flexible group, factor out a new function to do the job.
> 
> Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> even if it needs to unthrottle sampling events.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 68 +++++++++++++++++++++++---------------
>  2 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0367d748fae0..3eb17dc89f5e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -879,6 +879,7 @@ struct perf_event_pmu_context {
>  
>  	unsigned int			nr_events;
>  	unsigned int			nr_cgroups;
> +	unsigned int			nr_freq;
>  
>  	atomic_t			refcount; /* event <-> epc */
>  	struct rcu_head			rcu_head;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3eb26c2c6e65..53e2ad73102d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2275,8 +2275,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
>  
>  	if (!is_software_event(event))
>  		cpc->active_oncpu--;
> -	if (event->attr.freq && event->attr.sample_freq)
> +	if (event->attr.freq && event->attr.sample_freq) {
>  		ctx->nr_freq--;
> +		epc->nr_freq--;
> +	}
>  	if (event->attr.exclusive || !cpc->active_oncpu)
>  		cpc->exclusive = 0;
>  
> @@ -2531,9 +2533,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>  
>  	if (!is_software_event(event))
>  		cpc->active_oncpu++;
> -	if (event->attr.freq && event->attr.sample_freq)
> +	if (event->attr.freq && event->attr.sample_freq) {
>  		ctx->nr_freq++;
> -
> +		epc->nr_freq++;
> +	}
>  	if (event->attr.exclusive)
>  		cpc->exclusive = 1;
>  
> @@ -4096,30 +4099,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
>  	}
>  }
>  
> -/*
> - * combine freq adjustment with unthrottling to avoid two passes over the
> - * events. At the same time, make sure, having freq events does not change
> - * the rate of unthrottling as that would introduce bias.
> - */
> -static void
> -perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> +static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  {
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
>  	u64 now, period = TICK_NSEC;
>  	s64 delta;
>  
> -	/*
> -	 * only need to iterate over all events iff:
> -	 * - context have events in frequency mode (needs freq adjust)
> -	 * - there are events to unthrottle on this cpu
> -	 */
> -	if (!(ctx->nr_freq || unthrottle))
> -		return;
> -
> -	raw_spin_lock(&ctx->lock);
> -
> -	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> +	list_for_each_entry(event, event_list, active_list) {
>  		if (event->state != PERF_EVENT_STATE_ACTIVE)
>  			continue;
>  
> @@ -4127,8 +4114,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		if (!event_filter_match(event))
>  			continue;
>  
> -		perf_pmu_disable(event->pmu);
> -
>  		hwc = &event->hw;
>  
>  		if (hwc->interrupts == MAX_INTERRUPTS) {
> @@ -4138,7 +4123,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		}
>  
>  		if (!event->attr.freq || !event->attr.sample_freq)
> -			goto next;
> +			continue;
>  
>  		/*
>  		 * stop the event and update event->count
> @@ -4160,8 +4145,39 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  			perf_adjust_period(event, period, delta, false);
>  
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> -	next:
> -		perf_pmu_enable(event->pmu);
> +	}
> +}
> +
> +/*
> + * combine freq adjustment with unthrottling to avoid two passes over the
> + * events. At the same time, make sure, having freq events does not change
> + * the rate of unthrottling as that would introduce bias.
> + */
> +static void
> +perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> +{
> +	struct perf_event_pmu_context *pmu_ctx;
> +
> +	/*
> +	 * only need to iterate over all events iff:
> +	 * - context have events in frequency mode (needs freq adjust)
> +	 * - there are events to unthrottle on this cpu
> +	 */
> +	if (!(ctx->nr_freq || unthrottle))
> +		return;
> +
> +	raw_spin_lock(&ctx->lock);
> +
> +	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +		if (!(pmu_ctx->nr_freq || unthrottle))
> +			continue;
> +		if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
> +			continue;
> +
> +		perf_pmu_disable(pmu_ctx->pmu);
> +		perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> +		perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> +		perf_pmu_enable(pmu_ctx->pmu);
>  	}
>  
>  	raw_spin_unlock(&ctx->lock);
