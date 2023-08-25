Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A55C787F87
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbjHYGF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjHYGFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:05:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97531BC7;
        Thu, 24 Aug 2023 23:05:22 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RX8TS6QW7ztSBH;
        Fri, 25 Aug 2023 14:01:16 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 14:05:02 +0800
Subject: Re: [PATCH v6 3/7] perf record: Move setting dummy tracking before
 record__init_thread_masks()
To:     Ian Rogers <irogers@google.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230821012734.18241-1-yangjihong1@huawei.com>
 <20230821012734.18241-4-yangjihong1@huawei.com>
 <CAP-5=fW1zRmx4xxHLUySJ6jJ7NO5BTCcufN_=27gMak8bu6LMg@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <56127eee-6fdc-8f77-59e0-23fbed311af8@huawei.com>
Date:   Fri, 25 Aug 2023 14:05:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fW1zRmx4xxHLUySJ6jJ7NO5BTCcufN_=27gMak8bu6LMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/25 13:10, Ian Rogers wrote:
> On Sun, Aug 20, 2023 at 6:30 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> User space tasks can migrate between CPUs, so when tracing selected CPUs,
>> sideband for all CPUs is needed. In this case set the cpu map of the evsel
>> to all online CPUs. This may modify the original cpu map of the evlist.
>> Therefore, need to check whether the preceding scenario exists before
>> record__init_thread_masks().
>> Dummy tracking has been set in record__open(), move it before
>> record__init_thread_masks() and add a helper for unified processing.
> 
> I have a hard time understanding this commit message. Let me have a go:
> 
> In order to set cpu maps correctly on dummy events they need to set up
> later. Factor out the dummy event initialization from record__open and
> move it to its own function record__setup_dummy_event. Move the call
> to the record__setup_dummy to before the call to
> record__init_thread_masks in cmd_record.
Yes, as you said above, for that purpose

> 
>> The sys_perf_event_open invoked is as follows:
>>
>>    # perf --debug verbose=3 record -e cpu-clock -D 100 true
>>    <SNIP>
>>    Opening: cpu-clock
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1 (PERF_TYPE_SOFTWARE)
>>      size                             136
>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER
>>      read_format                      ID|LOST
>>      disabled                         1
>>      inherit                          1
>>      freq                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 = 7
>>    sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 = 12
>>    sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 = 13
>>    Opening: dummy:u
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1 (PERF_TYPE_SOFTWARE)
>>      size                             136
>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
>>      { sample_period, sample_freq }   1
>>      sample_type                      IP|TID|TIME|IDENTIFIER
>>      read_format                      ID|LOST
>>      disabled                         1
>>      inherit                          1
>>      exclude_kernel                   1
>>      exclude_hv                       1
>>      mmap                             1
>>      comm                             1
>>      enable_on_exec                   1
>>      task                             1
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      mmap2                            1
>>      comm_exec                        1
>>      ksymbol                          1
>>      bpf_event                        1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 = 14
>>    sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 = 15
>>    sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 = 16
>>    sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 = 17
>>    sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 = 18
>>    sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 = 19
>>    sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 = 20
>>    sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 = 21
>>    <SNIP>
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   tools/perf/builtin-record.c | 59 +++++++++++++++++++++++--------------
>>   1 file changed, 37 insertions(+), 22 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 12edad8392cc..4ee94058028f 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -906,6 +906,37 @@ static int record__config_off_cpu(struct record *rec)
>>          return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>   }
>>
>> +static int record__config_tracking_events(struct record *rec)
>> +{
>> +       struct record_opts *opts = &rec->opts;
>> +       struct evlist *evlist = rec->evlist;
>> +       struct evsel *evsel;
>> +
>> +       /*
>> +        * For initial_delay, system wide or a hybrid system, we need to add a
>> +        * dummy event so that we can track PERF_RECORD_MMAP to cover the delay
> 
> This code is explicitly talking about dummy events but the function is
> now renamed to call it a tracking event. I think the code should be
> consistent.
> 
>> +        * of waiting or event synthesis.
>> +        */
>> +       if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
>> +           perf_pmus__num_core_pmus() > 1) {
>> +               evsel = evlist__findnew_tracking_event(evlist, false);
>> +               if (!evsel)
>> +                       return -ENOMEM;
>> +
>> +               /*
>> +                * Enable the dummy event when the process is forked for
> 
> Dummy again.
> 
This comment directly copies the original content.
I can change to "tracking event" in the next version.

Thanks,
Yang
