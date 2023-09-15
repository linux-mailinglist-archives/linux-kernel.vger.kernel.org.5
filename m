Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDA7A1D44
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjIOLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:18:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55C89101;
        Fri, 15 Sep 2023 04:18:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C241FB;
        Fri, 15 Sep 2023 04:18:47 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD0133F5A1;
        Fri, 15 Sep 2023 04:18:07 -0700 (PDT)
Message-ID: <b269f9d0-9d7a-4d06-a897-c173e1eb2d0e@arm.com>
Date:   Fri, 15 Sep 2023 12:17:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/3] perf pmus: Simplify perf_pmus__find_core_pmu()
Content-Language: en-US
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230913153355.138331-1-james.clark@arm.com>
 <20230913153355.138331-3-james.clark@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230913153355.138331-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/2023 16:33, James Clark wrote:
> Currently the while loop always either exits on the first iteration with
> a core PMU, or exits with NULL on heterogeneous systems or when not all
> CPUs are online.
> 
> Both of the latter behaviors are undesirable for platforms other than
> Arm so simplify it to always return the first core PMU, or NULL if none
> exist.
> 
> This behavior was depended on by the Arm version of
> pmu_metrics_table__find(), so the logic has been moved there instead.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Turns out the "Simple expression parser" test is failing on
heterogeneous arm systems without this patch. I didn't realise there was
a dependency and should have put the commits the other way round. I will
leave the error message here in case someone bumps into it, but no fix
is required apart from applying the remaining patches in this set:

 $ perf test expr -v
  4: Simple expression parser                                        :
 --- start ---
 test child forked, pid 4902
 Using CPUID 0x00000000410fd070
 FAILED tests/expr.c:83 get_cpuid
 test child finished with -1
 ---- end ----
 Simple expression parser: FAILED!


> ---
>  tools/perf/arch/arm64/util/pmu.c |  8 +++++++-
>  tools/perf/util/pmus.c           | 14 +-------------
>  2 files changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> index 3d9330feebd2..3099f5f448ba 100644
> --- a/tools/perf/arch/arm64/util/pmu.c
> +++ b/tools/perf/arch/arm64/util/pmu.c
> @@ -10,8 +10,14 @@
>  
>  const struct pmu_metrics_table *pmu_metrics_table__find(void)
>  {
> -	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
> +	struct perf_pmu *pmu;
> +
> +	/* Metrics aren't currently supported on heterogeneous Arm systems */
> +	if (perf_pmus__num_core_pmus() > 1)
> +		return NULL;
>  
> +	/* Doesn't matter which one here because they'll all be the same */
> +	pmu = perf_pmus__find_core_pmu();
>  	if (pmu)
>  		return perf_pmu__find_metrics_table(pmu);
>  
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index cec869cbe163..64e798e68a2d 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -596,17 +596,5 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
>  
>  struct perf_pmu *perf_pmus__find_core_pmu(void)
>  {
> -	struct perf_pmu *pmu = NULL;
> -
> -	while ((pmu = perf_pmus__scan_core(pmu))) {
> -		/*
> -		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
> -		 * not support some events or have different event IDs.
> -		 */
> -		if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
> -			return NULL;
> -
> -		return pmu;
> -	}
> -	return NULL;
> +	return perf_pmus__scan_core(NULL);
>  }
