Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA797A4485
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjIRIW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjIRIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:15:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACA019A6;
        Mon, 18 Sep 2023 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024885; x=1726560885;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=UPb2e7T2NdnaKHr1MlH9VTFl3BDKTI9rhpg34SQOZRg=;
  b=WwDwa4/yOZHBHHlerMW2Q/H/F9sjonDuV7aPlTR3xdLG+wTA9OcVqvdO
   BBAwjTbwBssPwmYo8f0gSD+xzyo1dVsbK8X2tUD1mxgtRaLyx34atHMxh
   knlvjIFl2UBKd7hJDy3d+SeY7Lb5fiBuBzJVijOv7OtE8NLTg0Yq6AYY/
   GyqYvVujoeLd8ZZXtMyv4NnIhDQ2yoGnVuzbk7UyDWrg+zPLNMaIh6YPf
   1cmaiqBah04V9VTY9lqOkH/Ttu+9KUgU3tAmBjmnSAd8mdgXmteL7zFFW
   /gw5RUH3up5gsWvVRFz1mEUJFaRdo1JyUYvZRaNsgbGQTP6YslTmYJpUl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359848728"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359848728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="869472377"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="869472377"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:14:39 -0700
Message-ID: <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
Date:   Mon, 18 Sep 2023 11:14:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
References: <20230916040915.1075620-1-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230916040915.1075620-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/23 07:09, Ian Rogers wrote:
> Dummy events are created with an attribute where the period and freq
> are zero. evsel__config will then see the uninitialized values and
> initialize them in evsel__default_freq_period. As fequency mode is
> used by default the dummy event would be set to use frequency
> mode. However, this has no effect on the dummy event but does cause
> unnecessary timers/interrupts. Avoid this overhead by setting the
> period to 1 for dummy events.
> 
> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
> period=1. This isn't necessary after this change and so the setting is
> removed.
> 
> From Stephane:
> 
> The dummy event is not counting anything. It is used to collect mmap
> records and avoid a race condition during the synthesize mmap phase of
> perf record. As such, it should not cause any overhead during active
> profiling. Yet, it did. Because of a bug the dummy event was
> programmed as a sampling event in frequency mode. Events in that mode
> incur more kernel overheads because on timer tick, the kernel has to
> look at the number of samples for each event and potentially adjust
> the sampling period to achieve the desired frequency. The dummy event
> was therefore adding a frequency event to task and ctx contexts we may
> otherwise not have any, e.g., perf record -a -e
> cpu/event=0x3c,period=10000000/. On each timer tick the
> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> non-zero, then the kernel will loop over ALL the events of the context
> looking for frequency mode ones. In doing, so it locks the context,
> and enable/disable the PMU of each hw event. If all the events of the
> context are in period mode, the kernel will have to traverse the list for
> nothing incurring overhead. The overhead is multiplied by a very large
> factor when this happens in a guest kernel. There is no need for the
> dummy event to be in frequency mode, it does not count anything and
> therefore should not cause extra overhead for no reason.
> 
> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evlist.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 25c3ebe2c2f5..e36da58522ef 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
>  		.type	= PERF_TYPE_SOFTWARE,
>  		.config = PERF_COUNT_SW_DUMMY,
>  		.size	= sizeof(attr), /* to capture ABI version */
> +		/* Avoid frequency mode for dummy events to avoid associated timers. */
> +		.freq = 0,
> +		.sample_period = 1,
>  	};
>  
>  	return evsel__new_idx(&attr, evlist->core.nr_entries);
> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>  	evsel->core.attr.exclude_kernel = 1;
>  	evsel->core.attr.exclude_guest = 1;
>  	evsel->core.attr.exclude_hv = 1;
> -	evsel->core.attr.freq = 0;
> -	evsel->core.attr.sample_period = 1;
>  	evsel->core.system_wide = system_wide;
>  	evsel->no_aux_samples = true;
>  	evsel->name = strdup("dummy:u");

Note that evsel__config() will put it back to freq if -F is used.

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

