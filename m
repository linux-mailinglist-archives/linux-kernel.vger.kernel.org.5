Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3928F7BCD8B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344554AbjJHJgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJHJgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:36:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A141BB6;
        Sun,  8 Oct 2023 02:36:17 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S3H4h31CJzRhp3;
        Sun,  8 Oct 2023 17:32:20 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sun, 8 Oct 2023 17:36:14 +0800
Subject: Re: [PATCH v1 6/7] perf pmu-events: Remember the events and metrics
 table
To:     Ian Rogers <irogers@google.com>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231007021326.4156714-1-irogers@google.com>
 <20231007021326.4156714-7-irogers@google.com>
 <39b28ad5-8086-76ed-a4c6-bfc8271d226b@huawei.com>
 <CAP-5=fV3NO-3Q=7YQ0S6RNJUX1dWfszX-paFSPwniNhSokYRew@mail.gmail.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <ae8fae39-8585-c692-9200-80a551b30eb5@huawei.com>
Date:   Sun, 8 Oct 2023 17:36:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fV3NO-3Q=7YQ0S6RNJUX1dWfszX-paFSPwniNhSokYRew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/10/8 13:49, Ian Rogers wrote:
> On Sat, Oct 7, 2023 at 8:39 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Hello,
>>
>> On 2023/10/7 10:13, Ian Rogers wrote:
>>> strcmp_cpuid_str performs regular expression comparisons. Avoid
>>> repeated computation of the table by remembering the table in a
>>> static.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++-------------
>>>    1 file changed, 28 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>> index fd009752b427..8d8d5088c53c 100755
>>> --- a/tools/perf/pmu-events/jevents.py
>>> +++ b/tools/perf/pmu-events/jevents.py
>>> @@ -978,28 +978,32 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
>>>
>>>    const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
>>>    {
>>> -        const struct pmu_events_table *table = NULL;
>>> -        char *cpuid = perf_pmu__getcpuid(pmu);
>>> +        static const struct pmu_events_table *table;
>>>            size_t i;
>>>
>>> -        /* on some platforms which uses cpus map, cpuid can be NULL for
>>> -         * PMUs other than CORE PMUs.
>>> -         */
>>> -        if (!cpuid)
>>> -                return NULL;
>>> -
>>> -        i = 0;
>>> -        for (;;) {
>>> -                const struct pmu_events_map *map = &pmu_events_map[i++];
>>> -                if (!map->arch)
>>> -                        break;
>>> -
>>> -                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
>>> -                        table = &map->event_table;
>>> -                        break;
>>> +        if (!table) {
>> If there is no matched table in pmu_events_map,
>> perf_pmu__find_events_table() will enter this branch for repeated search
>> each time.
>> Or do we need to use another variable to indicate whether the search has
>> been performed?
> 
> Agreed, the behavior will match the existing behavior. Longer term I
> want to remove this code. Do you have a scenario we should optimize
> for here?
> 

Yes, the CPU of the environment I'm using is "AuthenticAMD-15-6B-1" (not 
in the pmu_events_map).
As a result, the search is repeated every time.
(If `perf record true` is executed once, the search is repeated for 6 
times.)

This commit avoids repeated lookups to improve performance,
so if it's feasible, is it best to consider improving performance in 
this case as well?

Thanks,
Yang
