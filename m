Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701067A2F02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjIPJYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjIPJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:24:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A801985;
        Sat, 16 Sep 2023 02:24:00 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RnlrN3dXmztSRG;
        Sat, 16 Sep 2023 17:19:48 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 16 Sep 2023 17:23:57 +0800
Subject: Re: [PATCH v8 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Ravi Bangoria <ravi.bangoria@amd.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <james.clark@arm.com>,
        <tmricht@linux.ibm.com>, <ak@linux.intel.com>,
        <anshuman.khandual@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230904023340.12707-1-yangjihong1@huawei.com>
 <453bd95c-932d-c60a-bd7b-96f87bc7779a@amd.com> <ZQDK4kZhwyZL/8tx@kernel.org>
 <CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <c9f60c53-191c-e323-e641-bcdcd5b61c38@huawei.com>
Date:   Sat, 16 Sep 2023 17:23:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2023/9/16 8:14, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Sep 12, 2023 at 1:32 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Tue, Sep 12, 2023 at 02:41:56PM +0530, Ravi Bangoria escreveu:
>>> On 04-Sep-23 8:03 AM, Yang Jihong wrote:
>>>> User space tasks can migrate between CPUs, track sideband events for all
>>>> CPUs.
>>>>
>>>> The specific scenarios are as follows:
>>>>
>>>>           CPU0                                 CPU1
>>>>    perf record -C 0 start
>>>>                                taskA starts to be created and executed
>>>>                                  -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>>>>                                     events only deliver to CPU1
>>>>                                ......
>>>>                                  |
>>>>                            migrate to CPU0
>>>>                                  |
>>>>    Running on CPU0    <----------/
>>>>    ...
>>>>
>>>>    perf record -C 0 stop
>>>>
>>>> Now perf samples the PC of taskA. However, perf does not record the
>>>> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
>>>> Therefore, the comm and symbols of taskA cannot be parsed.
>>>>
>>>> The sys_perf_event_open invoked is as follows:
>>>>
>>>>    # perf --debug verbose=3 record -e cpu-clock -C 1 true
>>>>    <SNIP>
>>>>    Opening: cpu-clock
>>>>    ------------------------------------------------------------
>>>>    perf_event_attr:
>>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>>      size                             136
>>>>      config                           0 (PERF_COUNT_SW_CPU_CLOCK)
>>>>      { sample_period, sample_freq }   4000
>>>>      sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
>>>>      read_format                      ID|LOST
>>>>      disabled                         1
>>>>      inherit                          1
>>>>      freq                             1
>>>>      sample_id_all                    1
>>>>      exclude_guest                    1
>>>>    ------------------------------------------------------------
>>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>>>>    Opening: dummy:u
>>>>    ------------------------------------------------------------
>>>>    perf_event_attr:
>>>>      type                             1 (PERF_TYPE_SOFTWARE)
>>>>      size                             136
>>>>      config                           0x9 (PERF_COUNT_SW_DUMMY)
>>>>      { sample_period, sample_freq }   1
>>>>      sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>>>>      read_format                      ID|LOST
>>>>      inherit                          1
>>>>      exclude_kernel                   1
>>>>      exclude_hv                       1
>>>>      mmap                             1
>>>>      comm                             1
>>>>      task                             1
>>>>      sample_id_all                    1
>>>>      exclude_guest                    1
>>>>      mmap2                            1
>>>>      comm_exec                        1
>>>>      ksymbol                          1
>>>>      bpf_event                        1
>>>>    ------------------------------------------------------------
>>>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>>>>    sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>>>>    sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>>>>    sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>>>>    sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>>>>    sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>>>>    sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>>>>    sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>>>>    <SNIP>
>>>>
>>>> Changes since_v7:
>>>>   - The condition for requiring system_wide sideband is changed to
>>>>     "as long as a non-dummy event exists" (patch4).
>>>>   - Modify the corresponding test case to record only dummy event (patch6).
>>>>   - Thanks to tested-by tag from Ravi, but because the solution is modified,
>>>>     the tested-by tag of Ravi is not added to this version.
>>>
>>> I've re-tested v8 with my simple test.
>>>
>>> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>
>>
>> Thanks, applied to the csets that were still sitting in an umpublished
>> perf-tools-next local branch, soon public.
> 
> Now I'm seeing a perf test failure on perf-tools-next.

Uh.. the kernel I was using before didn't support PERF_FORMAT_LOST, so 
forget about supporting PERF_FORMAT_LOST. I've updated the kernel and 
retested it.

The link to the fixed patch is as follows:
https://lore.kernel.org/all/20230916091641.776031-1-yangjihong1@huawei.com/

Thanks,
Yang
