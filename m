Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57898787F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbjHYGIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbjHYGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:07:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1111BCC;
        Thu, 24 Aug 2023 23:07:44 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RX8b60w4qz1L8xB;
        Fri, 25 Aug 2023 14:06:10 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 14:07:41 +0800
Subject: Re: [PATCH v6 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-5-yangjihong1@huawei.com>
 <CAP-5=fXZXQryyfjzSYRv6zqmttt7rt4gUc0KPudu0qtSc1XPow@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <e79fb6ea-98b2-9944-03c6-92b6e79fed82@huawei.com>
Date:   Fri, 25 Aug 2023 14:07:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXZXQryyfjzSYRv6zqmttt7rt4gUc0KPudu0qtSc1XPow@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/25 13:17, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> User space tasks can migrate between CPUs, we need to track side-band
>> events for all CPUs.
>>
>> The specific scenarios are as follows:
>>
>>           CPU0                                 CPU1
>>    perf record -C 0 start
>>                                taskA starts to be created and executed
>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>                                     events only deliver to CPU1
>>                                ......
>>                                  |
>>                            migrate to CPU0
>>                                  |
>>    Running on CPU0    <----------/
>>    ...
>>
>>    perf record -C 0 stop
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
>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>    <SNIP>
>>    Opening: cpu-clock
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1 (PERF_TYPE_SOFTWARE)
>>      size                             136
>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>      read_format                      ID|LOST
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>    Opening: dummy:u
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1 (PERF_TYPE_SOFTWARE)
>>      size                             136
>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>      read_format                      ID|LOST
>>      inherit                          1
>>      exclude_kernel                   1
>>      exclude_hv                       1
>>      mmap                             1
>>      comm                             1
>>      task                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      mmap2                            1
>>      comm_exec                        1
>>      ksymbol                          1
>>      bpf_event                        1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>    <SNIP>
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   tools/perf/Documentation/perf-record.txt |  3 ++
>>   tools/perf/builtin-record.c              | 44 +++++++++++++++++++++++-
>>   2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index d5217be012d7..1889f66addf2 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -374,6 +374,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
>>   In per-thread mode with inheritance mode on (default), samples are captured only when
>>   the thread executes on the designated CPUs. Default is to monitor all CPUs.
>>
>> +User space tasks can migrate between CPUs, so when tracing selected CPUs,
>> +a dummy event is created to track sideband for all CPUs.
>> +
>>   -B::
>>   --no-buildid::
>>   Do not save the build ids of binaries in the perf.data files. This skips
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 4ee94058028f..ae2e21b945fa 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -906,10 +906,44 @@ static int record__config_off_cpu(struct record *rec)
>>          return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>   }
>>
>> +static bool record__tracking_system_wide(struct record *rec)
> 
> I think this would be better named something like:
> record__need_system_wide_dummy_event
> 
Okay, it'll be modified in the next version.

Thanks,
Yang
