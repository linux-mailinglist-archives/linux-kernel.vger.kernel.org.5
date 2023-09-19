Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A237A59A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjISGAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISGAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:00:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC43102;
        Mon, 18 Sep 2023 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695103210; x=1726639210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+0+BOZGajX3/f4YT5PIAXOxOK+0h04eUBpzJ0BA8lWM=;
  b=nKQoFg++BpnfT7dE5z69j2XkwoUu1m+z+r52QFmdfHVy4TsH9D7sNzoN
   HV2uPmaLGzZiJMPpGOX9gxwwF0gdnK9X/rNsJypT5kIjDQJMLW8pcf/+M
   h02wZxJvTr+wNM5u10iHQBP30aMxDGg8Gwxi0skRYTcb3FmnbNInwK+3j
   k2wlPHREfWxPjoHTASN1CxvTkmykdfozdYcPy1aKBZEHq9drWLw3GxNr6
   yO+0Q+hYt8dfoYgsoP/u92zpMr0U0tipTKcUHA2ibERnTdAE74P+yBLSY
   PTtJqekAraiN+EXDDut34XWyj1mK1Dt0X/zgqI0VKeD36Jp0A1yQA+emI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443942603"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="443942603"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 22:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="836305448"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="836305448"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.132])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 22:59:14 -0700
Message-ID: <8086150e-3c6d-4001-b3cc-bb12ebe15928@intel.com>
Date:   Tue, 19 Sep 2023 08:59:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <08995efc-d5af-6ba6-831b-1a483daabef4@intel.com>
 <CAP-5=fW783G9fUEHrmzUu7UmvOm65Fp6vAQybCcNz2C0QRz26w@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fW783G9fUEHrmzUu7UmvOm65Fp6vAQybCcNz2C0QRz26w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/23 00:48, Ian Rogers wrote:
> On Mon, Sep 18, 2023 at 1:14 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 16/09/23 07:09, Ian Rogers wrote:
>>> Dummy events are created with an attribute where the period and freq
>>> are zero. evsel__config will then see the uninitialized values and
>>> initialize them in evsel__default_freq_period. As fequency mode is
>>> used by default the dummy event would be set to use frequency
>>> mode. However, this has no effect on the dummy event but does cause
>>> unnecessary timers/interrupts. Avoid this overhead by setting the
>>> period to 1 for dummy events.
>>>
>>> evlist__add_aux_dummy calls evlist__add_dummy then sets freq=0 and
>>> period=1. This isn't necessary after this change and so the setting is
>>> removed.
>>>
>>> From Stephane:
>>>
>>> The dummy event is not counting anything. It is used to collect mmap
>>> records and avoid a race condition during the synthesize mmap phase of
>>> perf record. As such, it should not cause any overhead during active
>>> profiling. Yet, it did. Because of a bug the dummy event was
>>> programmed as a sampling event in frequency mode. Events in that mode
>>> incur more kernel overheads because on timer tick, the kernel has to
>>> look at the number of samples for each event and potentially adjust
>>> the sampling period to achieve the desired frequency. The dummy event
>>> was therefore adding a frequency event to task and ctx contexts we may
>>> otherwise not have any, e.g., perf record -a -e
>>> cpu/event=0x3c,period=10000000/. On each timer tick the
>>> perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
>>> non-zero, then the kernel will loop over ALL the events of the context
>>> looking for frequency mode ones. In doing, so it locks the context,
>>> and enable/disable the PMU of each hw event. If all the events of the
>>> context are in period mode, the kernel will have to traverse the list for
>>> nothing incurring overhead. The overhead is multiplied by a very large
>>> factor when this happens in a guest kernel. There is no need for the
>>> dummy event to be in frequency mode, it does not count anything and
>>> therefore should not cause extra overhead for no reason.
>>>
>>> Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy constructor")
>>> Reported-by: Stephane Eranian <eranian@google.com>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/evlist.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>>> index 25c3ebe2c2f5..e36da58522ef 100644
>>> --- a/tools/perf/util/evlist.c
>>> +++ b/tools/perf/util/evlist.c
>>> @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct evlist *evlist)
>>>               .type   = PERF_TYPE_SOFTWARE,
>>>               .config = PERF_COUNT_SW_DUMMY,
>>>               .size   = sizeof(attr), /* to capture ABI version */
>>> +             /* Avoid frequency mode for dummy events to avoid associated timers. */
>>> +             .freq = 0,
>>> +             .sample_period = 1,
>>>       };
>>>
>>>       return evsel__new_idx(&attr, evlist->core.nr_entries);
>>> @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
>>>       evsel->core.attr.exclude_kernel = 1;
>>>       evsel->core.attr.exclude_guest = 1;
>>>       evsel->core.attr.exclude_hv = 1;
>>> -     evsel->core.attr.freq = 0;
>>> -     evsel->core.attr.sample_period = 1;
>>>       evsel->core.system_wide = system_wide;
>>>       evsel->no_aux_samples = true;
>>>       evsel->name = strdup("dummy:u");
>>
>> Note that evsel__config() will put it back to freq if -F is used.
> 
> Right, I was looking for a minimal fix in part for the sake of back
> porting. For the -F we could do:
> 
> ```
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d5363d23f5d3..806185a39e17 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1083,11 +1083,15 @@ void __weak arch__post_evsel_config(struct
> evsel *evsel __maybe_unused,
> static void evsel__set_default_freq_period(struct record_opts *opts,
>                                           struct perf_event_attr *attr)
> {
> -       if (opts->freq) {
> +       bool is_dummy = attr->type == PERF_TYPE_SOFTWARE &&
> +               attr->config == PERF_COUNT_SW_DUMMY;
> +
> +       if (opts->freq && !is_dummy) {
>                attr->freq = 1;
>                attr->sample_freq = opts->freq;
>        } else {
> -               attr->sample_period = opts->default_interval;
> +               attr->freq = 0;
> +               attr->sample_period = is_dummy ? 1 : opts->default_interval;
>        }
> }
> ```
> 
> But this felt like it could potentially have other side-effects.

Perhaps leave it alone, if the period has already been defined:

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d5363d23f5d3..ad3e12f5ec88 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1166,7 +1166,8 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if ((evsel->is_libpfm_event && !attr->sample_period) ||
 	    (!evsel->is_libpfm_event && (!attr->sample_period ||
 					 opts->user_freq != UINT_MAX ||
-					 opts->user_interval != ULLONG_MAX)))
+					 opts->user_interval != ULLONG_MAX) &&
+	     !(is_dummy && attr->sample_period)))
 		evsel__set_default_freq_period(opts, attr);
 
 	/*



> Software events like page faults have a period, but the
> dummy/side-band events appear never to check the period - but I could
> be wrong. We can add the patch above but perhaps without a fixes tag.
> 
> Thanks,
> Ian
> 
>> Nevertheless:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>

