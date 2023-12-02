Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76C4801AFA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 07:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjLBGQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 01:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBGQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 01:16:12 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB51B3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 22:16:18 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3580b94ac2eso11962405ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 22:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701497778; x=1702102578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ff7Rh7kC7gsqFHNzvF9iLLYB2RqTUiGRUVhPj2hnicw=;
        b=UqLO/EajhHGM1L5KFyqaOQBmuR/LQODtPVl8pv91LjcLDULpnZPU35EHzckYx4Sgss
         DxtCeQ1fnSTIFbo0sBGHk0iF1g70Q9veQbhAP6IAXSQyrp1ZqFfl+N/1+jcN2D15tGf7
         9c1/INTm1zA/OjG/wSFbWzxDtEO8JkiT8BPF7+NBdadYla3Kw8wCfngLKT7ADGFPDmy+
         e/dgiPhE5qL4IaapdhV/LF1HGagSiQV1ABec8ZtJQJ2es7V2cO5KBqfGsMEDrPwhk0wM
         20fFusHKtI9/jq8YWe23rDtUyK7k9BipV5viBRop0EQbO3c/qSHyWZhv3rkK8W/XQg8j
         Q5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701497778; x=1702102578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff7Rh7kC7gsqFHNzvF9iLLYB2RqTUiGRUVhPj2hnicw=;
        b=Do7lRQx/KoHInAfmMM6/S5UZTQOQEsw69Jthm2K30z6oWJghp/Badohqally1Biuvb
         Ddqi0W9pRd0KtgqW4UQRfyx2H8+JaysqRuSXVLsKoPNZbRb+W7mRu3P8zHcIzG/lVqh9
         mtvx089KzYeo511Ig+A9UnZ/yBItjDbPz0y9s9NqmmWyd21MxkWbHf3usuhoeenAwi04
         byrsuKke4Wpf8b0CQ/hgwOj23skFgM2EO0eVvBqiQ3PGyE4oLN0DKN/0hXhxPh63KdTM
         u/dMJHZaTvbrqurIQd8Hw+k/Gm7jhMHdaSxf0XyTWNKRohhWXum5U1LyAvDSQ4tPuUjj
         nglA==
X-Gm-Message-State: AOJu0YzHtnLucujSfpOoFmSv7j6uIJRLSx/ZBcmxHgsXloM3K4TZq318
        ZFKEU3S5jDbbJkUNad/r0GSs/rfLQvecHErudGmYZbkP
X-Google-Smtp-Source: AGHT+IGC27YbPgZR30pgcTVLFuKsudCiR/L+3ee6f2KEKOaXbvkwQ3dD3B1EDQyI+72Lyf/7+Xt8/w==
X-Received: by 2002:a92:c686:0:b0:35d:59a2:2d9 with SMTP id o6-20020a92c686000000b0035d59a202d9mr954448ilg.121.1701497777863;
        Fri, 01 Dec 2023 22:16:17 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902d2c700b001cf65d03cedsm4328203plc.32.2023.12.01.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 22:16:17 -0800 (PST)
Date:   Sat, 2 Dec 2023 06:16:13 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
Message-ID: <ZWrLrcsJ3_kFM8jd@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120221932.213710-1-namhyung@kernel.org>
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023, Namhyung Kim wrote:
> It was unnecessarily disabling and enabling PMUs for each event.  It
> should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> at each PMU.  As pmu context has separate active lists for pinned group
> and flexible group, factor out a new function to do the job.
> 
> Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> even if it needs to unthrottle sampling events.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Mingwei Zhang <mizhang@google.com>
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
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 
