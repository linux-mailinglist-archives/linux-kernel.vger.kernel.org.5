Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B3787FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjHYGOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbjHYGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:14:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629F8269E;
        Thu, 24 Aug 2023 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692944036; x=1724480036;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LGBmzNZqpwqCz34Hf+ae1Pc+wHX56AyAU5nG1wmV35Q=;
  b=dZJoitGjClC7a7TCA6GDeHuJp99WaOHchRcZ/8WlyCJ29oZU3mSo36Ck
   ViPaOGUR/chfHUW9+GBKVbMYmFcocSju6pz3WWtemTlt68pCY+o98eWYU
   IhdPwN7gFDp/A8RzZv2KG4VTEWYJzyTVaEekybAOTZtjeqZoZheZvJzaA
   pgx9qHO0Zn6fE7BDxQDg1wGx3/KtW0N1VjBVrWaurMoubem16hB1NQG8I
   F4uYTFguu6MK/Nl0os2yShw7HJDEEKLhQr3SWY67vHcRrfTcIECnH0pWz
   64NCogVbCXrPGzD+6gLnhuzltJXW/tShTmwqKMMDnTJVPj4kBj0l/3fjT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359636888"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359636888"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:13:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851831176"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="851831176"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.213.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:13:33 -0700
Message-ID: <90d877df-523e-6277-717e-9d63f2efccc5@intel.com>
Date:   Fri, 25 Aug 2023 09:13:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v6 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-5-yangjihong1@huawei.com>
 <CAP-5=fXZXQryyfjzSYRv6zqmttt7rt4gUc0KPudu0qtSc1XPow@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fXZXQryyfjzSYRv6zqmttt7rt4gUc0KPudu0qtSc1XPow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/23 08:17, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> User space tasks can migrate between CPUs, we need to track side-band
>> events for all CPUs.
>>
>> The specific scenarios are as follows:
>>
>>          CPU0                                 CPU1
>>   perf record -C 0 start
>>                               taskA starts to be created and executed
>>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>                                    events only deliver to CPU1
>>                               ......
>>                                 |
>>                           migrate to CPU0
>>                                 |
>>   Running on CPU0    <----------/
>>   ...
>>
>>   perf record -C 0 stop
>>
>> Now perf samples the PC of taskA. However, perf does not record the
>> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
>> Therefore, the comm and symbols of taskA cannot be parsed.
>>
>> The solution is to record sideband events for all CPUs when tracing
>> selected CPUs. Because this modifies the default behavior, add related
>> comments to the perf record man page.
>>
>> The sys_perf_event_open invoked is as follows:
>>
>>   # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>   <SNIP>
>>   Opening: cpu-clock
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             1 (PERF_TYPE_SOFTWARE)
>>     size                             136
>>     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>     { sample_period, sample_freq }   4000
>>     sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>     read_format                      ID|LOST
>>     disabled                         1
>>     inherit                          1
>>     freq                             1
>>     sample_id_all                    1
>>     exclude_guest                    1
>>   ------------------------------------------------------------
>>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>   Opening: dummy:u
>>   ------------------------------------------------------------
>>   perf_event_attr:
>>     type                             1 (PERF_TYPE_SOFTWARE)
>>     size                             136
>>     config                           0x9 (PERF_COUNT_SW_DUMMY)
>>     { sample_period, sample_freq }   1
>>     sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>     read_format                      ID|LOST
>>     inherit                          1
>>     exclude_kernel                   1
>>     exclude_hv                       1
>>     mmap                             1
>>     comm                             1
>>     task                             1
>>     sample_id_all                    1
>>     exclude_guest                    1
>>     mmap2                            1
>>     comm_exec                        1
>>     ksymbol                          1
>>     bpf_event                        1
>>   ------------------------------------------------------------
>>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>   <SNIP>
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt |  3 ++
>>  tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index d5217be012d7..1889f66addf2 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -374,6 +374,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>>  In per-thread mode with inheritance mode on (default), samples are captured only when
>>  the thread executes on the designated CPUs. Default is to monitor all CPUs.
>>
>> +User space tasks can migrate between CPUs, so when tracing selected CPUs,
>> +a dummy event is created to track sideband for all CPUs.
>> +
>>  -B::
>>  --no-buildid::
>>  Do not save the build ids of binaries in the perf.data files. This skips
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 4ee94058028f..ae2e21b945fa 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -906,10 +906,44 @@ static int record__config_off_cpu(struct record *rec)
>>         return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>  }
>>
>> +static bool record__tracking_system_wide(struct record *rec)
> 
> I think this would be better named something like:
> record__need_system_wide_dummy_event

Please no.  The tracking event is a perf tool invention identified
by evsel->tracking and used in evsel__config(). Please don't
confuse it with dummy events.  Just because the tracking event
*might* be a dummy event does not mean a dummy event is the
tracking event.

> 
> Thanks,
> Ian
> 
>> +{
>> +       struct record_opts *opts = &rec->opts;
>> +       struct evlist *evlist = rec->evlist;
>> +       struct evsel *evsel;
>> +
>> +       /*
>> +        * If all (non-dummy) evsel have exclude_user,
>> +        * system_wide is not needed.
>> +        *
>> +        * all_kernel and all_user will overwrite exclude_kernel and
>> +        * exclude_user of attr in evsel__config(), here need to check
>> +        * all the three items.
>> +        *
>> +        * Sideband system wide if one of the following conditions is met:
>> +        *
>> +        *   - all_user is set, and there is a non-dummy event
>> +        *   - all_user and all_kernel are not set, and there is
>> +        *     a non-dummy event without exclude_user
>> +        */
>> +       if (opts->all_kernel)
>> +               return false;
>> +
>> +       evlist__for_each_entry(evlist, evsel) {
>> +               if (!evsel__is_dummy_event(evsel)) {
>> +                       if (opts->all_user || !evsel->core.attr.exclude_user)
>> +                               return true;
>> +               }
>> +       }
>> +
>> +       return false;
>> +}
>> +
>>  static int record__config_tracking_events(struct record *rec)
>>  {
>>         struct record_opts *opts = &rec->opts;
>>         struct evlist *evlist = rec->evlist;
>> +       bool system_wide = false;
>>         struct evsel *evsel;
>>
>>         /*
>> @@ -919,7 +953,15 @@ static int record__config_tracking_events(struct record *rec)
>>          */
>>         if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>>             perf_pmus__num_core_pmus() > 1) {
>> -               evsel = evlist__findnew_tracking_event(evlist, false);
>> +
>> +               /*
>> +                * User space tasks can migrate between CPUs, so when tracing
>> +                * selected CPUs, sideband for all CPUs is still needed.
>> +                */
>> +               if (!!opts->target.cpu_list && record__tracking_system_wide(rec))
>> +                       system_wide = true;
>> +
>> +               evsel = evlist__findnew_tracking_event(evlist, system_wide);
>>                 if (!evsel)
>>                         return -ENOMEM;
>>
>> --
>> 2.30.GIT
>>

