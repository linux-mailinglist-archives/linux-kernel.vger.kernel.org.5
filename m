Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647F7CA24E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjJPIsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjJPIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:48:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E149DE;
        Mon, 16 Oct 2023 01:48:40 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S89gQ0Z6bzrTd6;
        Mon, 16 Oct 2023 16:45:54 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 16:48:34 +0800
Subject: Re: [PATCH v2 6/7] perf pmu-events: Remember the perf_events_map for
 a PMU
To:     Ian Rogers <irogers@google.com>
References: <20231012175645.1849503-1-irogers@google.com>
 <20231012175645.1849503-7-irogers@google.com>
From:   Yang Jihong <yangjihong1@huawei.com>
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
Message-ID: <be81569d-85f8-19db-28d1-7d48cf719c2e@huawei.com>
Date:   Mon, 16 Oct 2023 16:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20231012175645.1849503-7-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/10/13 1:56, Ian Rogers wrote:
> strcmp_cpuid_str performs regular expression comparisons and so per
> CPUID linear searches over the perf_events_map are expensive. Add a
> helper function called map_for_pmu that does the search but also
> caches the map specific to a PMU. As the PMU may differ, also cache
> the CPUID string so that PMUs with the same CPUID string don't require
> the linear search and regular expression comparisons. This speeds
> loading PMUs as the search is done once per PMU to find the
> appropriate tables.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/jevents.py | 109 ++++++++++++++++++++-----------
>   1 file changed, 70 insertions(+), 39 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 96dc74c90b20..3c091ab75305 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -976,68 +976,99 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
>           return 0;
>   }
>   
> -const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
> +static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
>   {
> -        const struct pmu_events_table *table = NULL;
> -        char *cpuid = perf_pmu__getcpuid(pmu);
> +        static struct {
> +                const struct pmu_events_map *map;
> +                struct perf_pmu *pmu;
> +        } last_result;
> +        static struct {
> +                const struct pmu_events_map *map;
> +                char *cpuid;
> +        } last_map_search;
> +        static bool has_last_result, has_last_map_search;
> +        const struct pmu_events_map *map = NULL;
> +        char *cpuid = NULL;
>           size_t i;
>   
> -        /* on some platforms which uses cpus map, cpuid can be NULL for
> +        if (has_last_result && last_result.pmu == pmu)
> +                return last_result.map;
> +
Currently, perf_pmu__find_events_table() is invoked only by 
perf_pmu__lookup(). Because the `pmu` is alloc memory each time (see 
perf_pmu__lookup()), the `pmu` is different each time when calling 
perf_pmu__find_events_table(). Therefore, the condition is false.

IIUC, has_last_result is introduced to avoid reading cpuid every time. 
 From the above, this variable does not work. Therefore, can we remove it?

In addition to the above questions, the patch is already being tested:
Tested-by: Yang Jihong <yangjihong1@huawei.com>


Thanks,
Yang
