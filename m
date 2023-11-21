Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D857F32EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjKUP6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjKUP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:58:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E8194
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700582291; x=1732118291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DjA8ybvbX9oN+w8ThlFiP/OaUK0tHMEq/VogDID2pM8=;
  b=X7xCk6iGgxsYyzkiODAQgw04ivM8hTdyfgmI090lDbbEM1D5RWtvYhVc
   8qHLECJoILMLPsrd/lcz2Qgt6BEaFXLpeF5+VzKmqMthzth6w1iw0TOaS
   YYyQ41PPSO+lHm488TXPvcmeyIqg3tFfHrCWw0Og6sBnjuyNSqzscNFS1
   F1yE26jCu6pKSodj3Bk2AzNSI5nJ3BdgdVC1faik7g0ZhWx5tsbYI+UKJ
   9lFatTT7grFfGtUw/nS71h52e/cJr6ImHXwZz+8LHYeHeAD3rW+pU1rDr
   QeutqjhoCJMwL+5d1N9esU/6fxCw5S3Lg31G2Hahdbpy4BKA/HPE/OzAz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="458361988"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="458361988"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857363606"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="857363606"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:57:55 -0800
Received: from [10.209.157.143] (kliang2-mobl1.ccr.corp.intel.com [10.209.157.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7E052580689;
        Tue, 21 Nov 2023 07:57:54 -0800 (PST)
Message-ID: <d1117d48-2e3e-4e8e-bc47-d5f182dac928@linux.intel.com>
Date:   Tue, 21 Nov 2023 10:57:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf/core: Reduce PMU access to adjust sample freq
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
 <20231120221932.213710-2-namhyung@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231120221932.213710-2-namhyung@kernel.org>
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
> For throttled events, it first starts the event and then stop
> unnecessarily.  As it's already stopped, it can directly adjust
> the frequency and then move on.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  kernel/events/core.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 53e2ad73102d..fd3449e4d081 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4119,10 +4119,15 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		if (hwc->interrupts == MAX_INTERRUPTS) {
>  			hwc->interrupts = 0;
>  			perf_log_throttle(event, 1);
> -			event->pmu->start(event, 0);
> -		}
>  
> -		if (!event->attr.freq || !event->attr.sample_freq)
> +			if (!event->attr.freq || !event->attr.sample_freq) {
> +				delta = 0;
> +				goto next;
> +			}
> +
> +			if (event->hw.state & PERF_HES_STOPPED)
> +				goto adjust;
> +		} else if (!event->attr.freq || !event->attr.sample_freq)
>  			continue;
>  
>  		/*
> @@ -4130,6 +4135,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		 */
>  		event->pmu->stop(event, PERF_EF_UPDATE);
>  
> +adjust:
>  		now = local64_read(&event->count);
>  		delta = now - hwc->freq_count_stamp;
>  		hwc->freq_count_stamp = now;
> @@ -4144,6 +4150,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		if (delta > 0)
>  			perf_adjust_period(event, period, delta, false);
>  
> +next:
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>  	}
>  }
