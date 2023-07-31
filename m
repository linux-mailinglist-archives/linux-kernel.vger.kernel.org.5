Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA6769980
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGaO2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjGaO2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:28:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE21B6;
        Mon, 31 Jul 2023 07:28:09 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RF0qz0JL1ztRjT;
        Mon, 31 Jul 2023 22:24:47 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 22:28:06 +0800
Subject: Re: [PATCH v3 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <tmricht@linux.ibm.com>, <ak@linux.intel.com>,
        <anshuman.khandual@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230722093219.174898-1-yangjihong1@huawei.com>
 <20230722093219.174898-5-yangjihong1@huawei.com>
 <4ec5cf9e-130d-4259-420f-420508186858@intel.com>
 <095df85c-e44e-9ff0-ad28-c3473a9a01e4@huawei.com>
 <25b32870-12e1-b237-648a-3c6fd9678bb9@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <8c62094a-921c-2f3a-2130-3f083f4ac178@huawei.com>
Date:   Mon, 31 Jul 2023 22:28:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <25b32870-12e1-b237-648a-3c6fd9678bb9@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/7/31 21:01, Adrian Hunter wrote:
> On 31/07/23 15:38, Yang Jihong wrote:
>> Hello,
>>
>> On 2023/7/31 19:08, Adrian Hunter wrote:
>>> On 22/07/23 12:32, Yang Jihong wrote:
>>>> User space tasks can migrate between CPUs, we need to track side-band
>>>> events for all CPUs.
>>>>
>>>> The specific scenarios are as follows:
>>>>
>>>>            CPU0                                 CPU1
>>>>     perf record -C 0 start
>>>>                                 taskA starts to be created and executed
>>>>                                   -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>>>                                      events only deliver to CPU1
>>>>                                 ......
>>>>                                   |
>>>>                             migrate to CPU0
>>>>                                   |
>>>>     Running on CPU0    <----------/
>>>>     ...
>>>>
>>>>     perf record -C 0 stop
>>>>
>>>> Now perf samples the PC of taskA. However, perf does not record the
>>>> PERF_RECORD_COMM and PERF_RECORD_MMAP events of taskA.
>>>> Therefore, the comm and symbols of taskA cannot be parsed.
>>>>
>>>> The solution is to record sideband events for all CPUs when tracing
>>>> selected CPUs. Because this modifies the default behavior, add related
>>>> comments to the perf record man page.
>>>>
>>>> The sys_perf_event_open invoked is as follows:
>>>>
>>>>     # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>>>     <SNIP>
>>>>     Opening: cpu-clock
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             1 (PERF_TYPE_SOFTWARE)
>>>>       size                             136
>>>>       config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>>>       { sample_period, sample_freq }   4000
>>>>       sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>       read_format                      ID|LOST
>>>>       disabled                         1
>>>>       inherit                          1
>>>>       freq                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>>>     Opening: dummy:u
>>>>     ------------------------------------------------------------
>>>>     perf_event_attr:
>>>>       type                             1 (PERF_TYPE_SOFTWARE)
>>>>       size                             136
>>>>       config                           0x9 (PERF_COUNT_SW_DUMMY)
>>>>       { sample_period, sample_freq }   1
>>>>       sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>>       read_format                      ID|LOST
>>>>       inherit                          1
>>>>       exclude_kernel                   1
>>>>       exclude_hv                       1
>>>>       mmap                             1
>>>>       comm                             1
>>>>       task                             1
>>>>       sample_id_all                    1
>>>>       exclude_guest                    1
>>>>       mmap2                            1
>>>>       comm_exec                        1
>>>>       ksymbol                          1
>>>>       bpf_event                        1
>>>>     ------------------------------------------------------------
>>>>     sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>>     sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>>>     sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>>>     sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>>>     sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>>>     sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>>>     sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>>>     sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>>>     <SNIP>
>>>>
>>>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>>>> ---
>>>>    tools/perf/Documentation/perf-record.txt |  3 +++
>>>>    tools/perf/builtin-record.c              | 14 +++++++++++++-
>>>>    2 files changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>>>> index 680396c56bd1..dac53ece51ab 100644
>>>> --- a/tools/perf/Documentation/perf-record.txt
>>>> +++ b/tools/perf/Documentation/perf-record.txt
>>>> @@ -388,6 +388,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>>>>    In per-thread mode with inheritance mode on (default), samples are captured only when
>>>>    the thread executes on the designated CPUs. Default is to monitor all CPUs.
>>>>    +User space tasks can migrate between CPUs, so when tracing selected CPUs,
>>>> +a dummy event is created to track sideband for all CPUs.
>>>> +
>>>>    -B::
>>>>    --no-buildid::
>>>>    Do not save the build ids of binaries in the perf.data files. This skips
>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>> index 3ff9d972225e..4e8e97928f05 100644
>>>> --- a/tools/perf/builtin-record.c
>>>> +++ b/tools/perf/builtin-record.c
>>>> @@ -912,6 +912,7 @@ static int record__config_tracking_events(struct record *rec)
>>>>    {
>>>>        struct record_opts *opts = &rec->opts;
>>>>        struct evlist *evlist = rec->evlist;
>>>> +    bool system_wide = false;
>>>>        struct evsel *evsel;
>>>>          /*
>>>> @@ -921,7 +922,18 @@ static int record__config_tracking_events(struct record *rec)
>>>>         */
>>>>        if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>>>>            perf_pmus__num_core_pmus() > 1) {
>>>> -        evsel = evlist__findnew_tracking_event(evlist, false);
>>>> +
>>>> +        /*
>>>> +         * User space tasks can migrate between CPUs, so when tracing
>>>> +         * selected CPUs, sideband for all CPUs is still needed.
>>>> +         *
>>>> +         * If all (non-dummy) evsel have exclude_user,
>>>> +         * system_wide is not needed.
>>>> +         */
>>>> +        if (!!opts->target.cpu_list && !opts->all_kernel)
>>>
>>> Not everyone uses all-kernel.  Can we check the evsels are either dummy
>>> or exclude_user?
>> For perf_record, exclude_user of all evsels is set in evsel__config(), and record__config_tracking_events() is before evsel__config().
>>
>> Uh..., it seems that only opts->all_kernel can be used to check exclude_user of evsels.
>>
>> void evsel__config()
>> {
>>    ...
>>    if (opts->all_kernel) {
>>      attr->exclude_kernel = 0;
>>      attr->exclude_user   = 1;
>>    }
>>    ...
>> }
> 
> The parser updates attr in accordance with ":k" etc.  I guess
Yes, the ":k" situation also needs to be considered.

> opts->all_kernel or opts->all_user override that as well.
Yes, opts->all_kernel and opts->all_user will overwrite the original 
attr, see [1].

may need to check all_user, all_kernel and non-dummy exclude_user at the 
same time:

if ((all_user && one_non_dummy_exist) ||
     (!all_user && !all_kernel && one_non_dummy_without_exclude_user)) {
     system_wide = true;
}

[1]
# perf --debug verbose=2 record -e cpu-clock:u --all-kernel true
<SNIP>
------------------------------------------------------------
perf_event_attr:
   type                             1 (PERF_TYPE_SOFTWARE)
   size                             136
   config                           0 (PERF_COUNT_SW_CPU_CLOCK)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   exclude_user                     1
   exclude_hv                       1
   mmap                             1
   comm                             1
   freq                             1
   enable_on_exec                   1
   task                             1
   sample_id_all                    1
   exclude_guest                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
<SNIP>

Thanks,
Yang
