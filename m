Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B5796F04
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjIGCk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjIGCk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:40:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A801997;
        Wed,  6 Sep 2023 19:40:52 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rh3LJ54FwzMlBb;
        Thu,  7 Sep 2023 10:37:28 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 10:40:48 +0800
Subject: Re: [PATCH v8 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20230904023340.12707-1-yangjihong1@huawei.com>
 <ZPij6XjhdUW3nIqU@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <31449397-cbee-5c51-859d-887b6455c886@huawei.com>
Date:   Thu, 7 Sep 2023 10:40:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ZPij6XjhdUW3nIqU@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/9/7 0:08, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 04, 2023 at 02:33:34AM +0000, Yang Jihong escreveu:
>> User space tasks can migrate between CPUs, track sideband events for all
>> CPUs.
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
>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
>> Therefore, the comm and symbols of taskA cannot be parsed.
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
>> Changes since_v7:
>>   - The condition for requiring system_wide sideband is changed to
>>     "as long as a non-dummy event exists" (patch4).
>>   - Modify the corresponding test case to record only dummy event (patch6).
>>   - Thanks to tested-by tag from Ravi, but because the solution is modified,
>>     the tested-by tag of Ravi is not added to this version.
>>
>> Changes since_v6:
>>   - Patch1:
>>      1. No change.
>>      2. Keep Acked-by tag from Adrian.
>>   - Patch2:
>>      1. Update commit message as suggested by Ian.
>>      2. Keep Acked-by tag from Adrian because code is not modified.
>>   - Patch3:
>>      1. Update comment as suggested by Ian.
>>      2. Merge original patch5 ("perf test: Update base-record & system-wide-dummy attr") as suggested by Ian.
>>      3. Only merge commit, keep Acked-by tag from Adrian.
>>   - Patch4:
>>      1. No change. Because Adrian recommends not changing the function name.
>>      2. Keep Acked-by tag from Adrian.
>>   - Patch5:
>>      1. Add cleanup on trap function as suggested by Ian.
>>      2. Remove Tested-by tag from Adrian because the script is modified.
>>   - Patch6:
>>      1. Add Reviewed-by tag from Ian.
> 
> I'm in doubt about these Acked-by/Reviewed-by tags, do they still stand? They are
> not in the latest series, can you please check?

Uh, uh. Because several reviewers have different opinions on the 
solution,  I modified it several times.
Now v8 patchset is different from the previous versions.
I only keep the  Acked-by/Reviewed-by tags of patches that are not 
modified. For patches that have modified the code, I remove the tags.
Therefore, please refer to the v8 series for Acked-by/Reviewed-by tags.
This version needs to be confirmed by reviewers.

Thanks,
Yang
