Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A667C6D77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378610AbjJLL40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378605AbjJLLzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:55:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B146B2;
        Thu, 12 Oct 2023 04:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697111632; x=1728647632;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=QA1p18R7UDwNmgDTB/KVX0W8rktazNm38PC98o9ymH4=;
  b=dA4CtIKTonuRwIjaaDsWYzJjw/yxBiFN3CdtQmriAHwxm0eIy44erwIV
   aPvlLN06+qUVJoVIs8YqggXmBofDO/SGwlUXjCHmZmJu8bJBJQYBx/peP
   b+eLAGx34hzwM+sazuPkFSW31bpj3is2mvC3w/qaw5pWMH984YRLMl6IV
   KgGlsMjR0LPi4wAyIb91/ODa2orW5wOTK2ykbNO8opOgXHODmrxC8J8un
   Q3qTLkaeq3Qabq3PwEouDT+jEFJB0VIJq6K3QDoxcHiPUIqGVuZmyJ2WR
   4cCZ/BGHRzCc4oU6Xa7vehFBCE16TBP6ZxBs4xgKAmQoymZodIoY71haz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415949597"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415949597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:53:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870545759"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="870545759"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.41.84])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:53:20 -0700
Message-ID: <ebdd9eac-410e-4b66-84ff-d5756f5c9b55@intel.com>
Date:   Thu, 12 Oct 2023 14:53:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] perf pmu-events: Remember the events and metrics
 table
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231007021326.4156714-1-irogers@google.com>
 <20231007021326.4156714-7-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231007021326.4156714-7-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 05:13, Ian Rogers wrote:
> strcmp_cpuid_str performs regular expression comparisons. Avoid
> repeated computation of the table by remembering the table in a
> static.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index fd009752b427..8d8d5088c53c 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -978,28 +978,32 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
>  
>  const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
>  {
> -        const struct pmu_events_table *table = NULL;
> -        char *cpuid = perf_pmu__getcpuid(pmu);
> +        static const struct pmu_events_table *table;
>          size_t i;
>  
> -        /* on some platforms which uses cpus map, cpuid can be NULL for
> -         * PMUs other than CORE PMUs.
> -         */
> -        if (!cpuid)
> -                return NULL;
> -
> -        i = 0;
> -        for (;;) {
> -                const struct pmu_events_map *map = &pmu_events_map[i++];
> -                if (!map->arch)
> -                        break;
> -
> -                if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> -                        table = &map->event_table;
> -                        break;
> +        if (!table) {
> +                char *cpuid = perf_pmu__getcpuid(pmu);

Seems to assume the function is never called with a pmu
that would give a different result for perf_pmu__getcpuid(pmu)

> +
> +                /*
> +                 * On some platforms which uses cpus map, cpuid can be NULL for
> +                 * PMUs other than CORE PMUs.
> +                 */
> +                if (!cpuid)
> +                        return NULL;
> +
> +                i = 0;
> +                for (;;) {
> +                        const struct pmu_events_map *map = &pmu_events_map[i++];
> +                        if (!map->arch)
> +                                break;
> +
> +                        if (!strcmp_cpuid_str(map->cpuid, cpuid)) {
> +                                table = &map->event_table;
> +                                break;
> +                        }
>                  }
> +                free(cpuid);
>          }
> -        free(cpuid);
>          if (!pmu)
>                  return table;
>  
> @@ -1015,13 +1019,17 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
>  
>  const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
>  {
> -        const struct pmu_metrics_table *table = NULL;
> -        char *cpuid = perf_pmu__getcpuid(pmu);
> +        static const struct pmu_metrics_table *table;
> +        char *cpuid;
>          int i;
>  
> +        if (table)
> +                return table;

Ditto

> +
>          /* on some platforms which uses cpus map, cpuid can be NULL for
>           * PMUs other than CORE PMUs.
>           */
> +        cpuid = perf_pmu__getcpuid(pmu);
>          if (!cpuid)
>                  return NULL;
>  

