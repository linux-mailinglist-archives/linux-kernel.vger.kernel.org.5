Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10683769703
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjGaNCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjGaNCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:02:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCD31992;
        Mon, 31 Jul 2023 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690808525; x=1722344525;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=MmC9xGoejms+ISOBYAaX9CSOU1cYHJNvJ9GhMdQWQUs=;
  b=eLbqx/ZiveI5aSG9R0zK8zXJec0gWOITCAOB7QDSItVAVKpAS9jVgJpH
   4Da4mlSLrvp6laBWYrTO1UJYimLC2vOlL5ir7IgUCAhiyW7hVKJ7zwq/F
   xzM9n1X8dkWScwugGJ65PLaI/PZDjQ/4ux5TvteIGTncExB1tf85jJbi4
   rp3NYYAawY6/vcUTgzVqflJHhl1201J2WlOc49k74Ytbtgo9kYmrcM089
   vKqG7u4n6amfT1McG1P9DV18vCArosKjkK5YDb6y+Pgv9G2Yh/gL0j3SG
   pOAF4GoZ7+mfo6APhDHZtNqB/Fubzg7i5DDQJ7hn7LlpDqqYb4Av5uG6c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349313820"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="349313820"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852023939"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="852023939"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 06:01:59 -0700
Message-ID: <25b32870-12e1-b237-648a-3c6fd9678bb9@intel.com>
Date:   Mon, 31 Jul 2023 16:01:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v3 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230722093219.174898-1-yangjihong1@huawei.com>
 <20230722093219.174898-5-yangjihong1@huawei.com>
 <4ec5cf9e-130d-4259-420f-420508186858@intel.com>
 <095df85c-e44e-9ff0-ad28-c3473a9a01e4@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <095df85c-e44e-9ff0-ad28-c3473a9a01e4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/23 15:38, Yang Jihong wrote:
> Hello,
> 
> On 2023/7/31 19:08, Adrian Hunter wrote:
>> On 22/07/23 12:32, Yang Jihong wrote:
>>> User space tasks can migrate between CPUs, we need to track side-band
>>> events for all CPUs.
>>>
>>> The specific scenarios are as follows:
>>>
>>>           CPU0                                 CPU1
>>>    perf record -C 0 start
>>>                                taskA starts to be created and executed
>>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>>                                     events only deliver to CPU1
>>>                                ......
>>>                                  |
>>>                            migrate to CPU0
>>>                                  |
>>>    Running on CPU0    <----------/
>>>    ...
>>>
>>>    perf record -C 0 stop
>>>
>>> Now perf samples the PC of taskA. However, perf does not record the
>>> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
>>> Therefore, the comm and symbols of taskA cannot be parsed.
>>>
>>> The solution is to record sideband events for all CPUs when tracing
>>> selected CPUs. Because this modifies the default behavior, add related
>>> comments to the perf record man page.
>>>
>>> The sys_perf_event_open invoked is as follows:
>>>
>>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>>    <SNIP>
>>>    Opening: cpu-clock
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>      size                             136
>>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>>      { sample_period, sample_freq }   4000
>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>      read_format                      ID|LOST
>>>      disabled                         1
>>>      inherit                          1
>>>      freq                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>>    Opening: dummy:u
>>>    ------------------------------------------------------------
>>>    perf_event_attr:
>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>      size                             136
>>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
>>>      { sample_period, sample_freq }   1
>>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>      read_format                      ID|LOST
>>>      inherit                          1
>>>      exclude_kernel                   1
>>>      exclude_hv                       1
>>>      mmap                             1
>>>      comm                             1
>>>      task                             1
>>>      sample_id_all                    1
>>>      exclude_guest                    1
>>>      mmap2                            1
>>>      comm_exec                        1
>>>      ksymbol                          1
>>>      bpf_event                        1
>>>    ------------------------------------------------------------
>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>>    <SNIP>
>>>
>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>> ---
>>>   tools/perf/Documentation/perf-record.txt |  3 +++
>>>   tools/perf/builtin-record.c              | 14 +++++++++++++-
>>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>> index 680396c56bd1..dac53ece51ab 100644
>>> --- a/tools/perf/Documentation/perf-record.txt
>>> +++ b/tools/perf/Documentation/perf-record.txt
>>> @@ -388,6 +388,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>>>   In per-thread mode with inheritance mode on (default), samples are captured only when
>>>   the thread executes on the designated CPUs. Default is to monitor all CPUs.
>>>   +User space tasks can migrate between CPUs, so when tracing selected CPUs,
>>> +a dummy event is created to track sideband for all CPUs.
>>> +
>>>   -B::
>>>   --no-buildid::
>>>   Do not save the build ids of binaries in the perf.data files. This skips
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index 3ff9d972225e..4e8e97928f05 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -912,6 +912,7 @@ static int record__config_tracking_events(struct record *rec)
>>>   {
>>>       struct record_opts *opts = &rec->opts;
>>>       struct evlist *evlist = rec->evlist;
>>> +    bool system_wide = false;
>>>       struct evsel *evsel;
>>>         /*
>>> @@ -921,7 +922,18 @@ static int record__config_tracking_events(struct record *rec)
>>>        */
>>>       if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>>>           perf_pmus__num_core_pmus() > 1) {
>>> -        evsel = evlist__findnew_tracking_event(evlist, false);
>>> +
>>> +        /*
>>> +         * User space tasks can migrate between CPUs, so when tracing
>>> +         * selected CPUs, sideband for all CPUs is still needed.
>>> +         *
>>> +         * If all (non-dummy) evsel have exclude_user,
>>> +         * system_wide is not needed.
>>> +         */
>>> +        if (!!opts->target.cpu_list && !opts->all_kernel)
>>
>> Not everyone uses all-kernel.  Can we check the evsels are either dummy
>> or exclude_user?
> For perf_record, exclude_user of all evsels is set in evsel__config(), and record__config_tracking_events() is before evsel__config().
> 
> Uh..., it seems that only opts->all_kernel can be used to check exclude_user of evsels.
> 
> void evsel__config()
> {
>   ...
>   if (opts->all_kernel) {
>     attr->exclude_kernel = 0;
>     attr->exclude_user   = 1;
>   }
>   ...
> }

The parser updates attr in accordance with ":k" etc.  I guess 
opts->all_kernel or opts->all_user override that as well.



