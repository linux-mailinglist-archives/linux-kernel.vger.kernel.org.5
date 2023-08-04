Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851F76F710
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 03:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjHDBnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHDBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 21:43:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087B10C7;
        Thu,  3 Aug 2023 18:42:58 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RH7j12jkZzVjvb;
        Fri,  4 Aug 2023 09:41:09 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:42:55 +0800
Subject: Re: [PATCH v4 4/7] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <tmricht@linux.ibm.com>, <ak@linux.intel.com>,
        <anshuman.khandual@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230802074948.136468-1-yangjihong1@huawei.com>
 <20230802074948.136468-5-yangjihong1@huawei.com>
 <bbfd8e23-db63-61fc-4f9e-25e993345b57@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <a1eedb1d-ea92-0e66-1013-874c06861682@huawei.com>
Date:   Fri, 4 Aug 2023 09:42:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <bbfd8e23-db63-61fc-4f9e-25e993345b57@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/8/3 14:28, Adrian Hunter wrote:
> On 2/08/23 10:49, Yang Jihong wrote:
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
>> ---
>>   tools/perf/Documentation/perf-record.txt |  3 ++
>>   tools/perf/builtin-record.c              | 45 +++++++++++++++++++++++-
>>   2 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 680396c56bd1..dac53ece51ab 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -388,6 +388,9 @@ comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-
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
>> index 3ff9d972225e..468afeaac52d 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -908,10 +908,45 @@ static int record__config_off_cpu(struct record *rec)
>>   	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>>   }
>>   
>> +static bool record__tracking_system_wide(struct record *rec)
>> +{
>> +	struct record_opts *opts = &rec->opts;
>> +	struct evlist *evlist = rec->evlist;
>> +	struct evsel *evsel;
>> +
>> +	/*
>> +	 * If all (non-dummy) evsel have exclude_user,
>> +	 * system_wide is not needed.
>> +	 *
>> +	 * all_kernel and all_user will overwrite exclude_kernel and
>> +	 * exclude_user of attr in evsel__config(), here need to check
>> +	 * all the three items.
>> +	 *
>> +	 * Sideband system wide if one of the following conditions is met:
>> +	 *
>> +	 *   - all_user is set, and there is a non-dummy event
>> +	 *   - all_user and all_kernel are not set, and there is
>> +	 *     a non-dummy event without exclude_user
>> +	 */
> 
> Could start with:
> 
> 	if (opts->all_kernel)
> 		return false;
> 
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		if (!evsel__is_dummy_event(evsel)) {
>> +			if (opts->all_user)
>> +				return true;
>> +
>> +			if (!opts->all_user && !opts->all_kernel &&
> 
> !opts->all_user is always true here
> 
>> +			    !evsel->core.attr.exclude_user)
>> +				return true;
> 
> So then this could simply be:
> 
> 			if (opts->all_user || !evsel->core.attr.exclude_user)
> 				return true;
> 
> 
Thanks for correction. It will be modified in the next version according 
to the above.

Thanks,
Yang
