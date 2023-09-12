Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFC79D973
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjILTS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjILTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:18:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E7FC1;
        Tue, 12 Sep 2023 12:18:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38188C433C8;
        Tue, 12 Sep 2023 19:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546334;
        bh=OITpLtQ4al9uXlZ9wlLgOEDSs4UNoAkK/SHtaEiAm68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW1/u2Nrd3m0/SyPTnCSvag/nRVYHtR2K1WTX6TBVry7siEFCFb0+whyVyESatu8L
         G949bVT5+6Q+966HsR23oIX2yGnWxG5CjRAiM1TIGG+zjz2XygrxO+TTXSY4q0PvV4
         VrGOTDRJURpNPN9LMx89f11av3CRWAm/4Z4ZBvuE/L4XzKFiBY2fmRN0Gg+cTas91d
         gcKQJGpstDMJjX8YDmL0kE3yUl2e89maTFyCI0uSvXTxnC3LlPqoApeMUif0dR7aSQ
         jxqf3LFYAI6Qg1JoSkaUAm5x+6NeC29iuUOVEjeYbGbc9Q8x4gpiIDRI7a7Jt/QuAy
         75nCj3IxZaN4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C6C3C403F4; Tue, 12 Sep 2023 16:18:50 -0300 (-03)
Date:   Tue, 12 Sep 2023 16:18:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf list: Avoid a hardcoded cpu PMU name
Message-ID: <ZQC5mmDtasr5/vDH@kernel.org>
References: <20230906234416.3472339-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906234416.3472339-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 06, 2023 at 04:44:15PM -0700, Ian Rogers escreveu:
> Use the first core PMU instead.
> 
> On a Raspberry Pi, before:
> ```
> $ perf list
> ...
>   cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
>        [(see 'man perf-list' on how to encode it)]
> ...
> ```
> After:
> ```
> 
> $ perf list
> ...
>   armv8_cortex_a72/t1=v1[,t2=v2,t3 ...]/modifier     [Raw hardware event descriptor]
>        [(see 'man perf-list' on how to encode it)]
> ...
> ```

Thanks, applied the two patches.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/print-events.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index a7566edc86a3..b0fc48be623f 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -395,6 +395,8 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
>   */
>  void print_events(const struct print_callbacks *print_cb, void *print_state)
>  {
> +	char *tmp;
> +
>  	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
>  			event_symbols_hw, PERF_COUNT_HW_MAX);
>  	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
> @@ -418,17 +420,21 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
>  			/*long_desc=*/NULL,
>  			/*encoding_desc=*/NULL);
>  
> -	print_cb->print_event(print_state,
> -			/*topic=*/NULL,
> -			/*pmu_name=*/NULL,
> -			"cpu/t1=v1[,t2=v2,t3 ...]/modifier",
> -			/*event_alias=*/NULL,
> -			/*scale_unit=*/NULL,
> -			/*deprecated=*/false,
> -			event_type_descriptors[PERF_TYPE_RAW],
> -			"(see 'man perf-list' on how to encode it)",
> -			/*long_desc=*/NULL,
> -			/*encoding_desc=*/NULL);
> +	if (asprintf(&tmp, "%s/t1=v1[,t2=v2,t3 ...]/modifier",
> +		     perf_pmus__scan_core(/*pmu=*/NULL)->name) > 0) {
> +		print_cb->print_event(print_state,
> +				/*topic=*/NULL,
> +				/*pmu_name=*/NULL,
> +				tmp,
> +				/*event_alias=*/NULL,
> +				/*scale_unit=*/NULL,
> +				/*deprecated=*/false,
> +				event_type_descriptors[PERF_TYPE_RAW],
> +				"(see 'man perf-list' on how to encode it)",
> +				/*long_desc=*/NULL,
> +				/*encoding_desc=*/NULL);
> +		free(tmp);
> +	}
>  
>  	print_cb->print_event(print_state,
>  			/*topic=*/NULL,
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 

-- 

- Arnaldo
