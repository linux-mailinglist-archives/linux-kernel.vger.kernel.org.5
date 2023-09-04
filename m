Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20326791A91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjIDPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIDPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:23:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E91AB10F2;
        Mon,  4 Sep 2023 08:23:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6F25143D;
        Mon,  4 Sep 2023 08:24:22 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D903F738;
        Mon,  4 Sep 2023 08:23:42 -0700 (PDT)
Message-ID: <8eb9b2c0-1dbb-8a93-fc4e-463a6daadb9c@arm.com>
Date:   Mon, 4 Sep 2023 16:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] perf cs-etm: Validate timestamp tracing in
 per-thread mode
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20230827133557.112494-1-leo.yan@linaro.org>
 <20230827133557.112494-2-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230827133557.112494-2-leo.yan@linaro.org>
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



On 27/08/2023 14:35, Leo Yan wrote:
> So far, it's impossible to validate timestamp trace in Arm CoreSight when
> the perf is in the per-thread mode.  E.g. for the command:
> 
>   perf record -e cs_etm/timestamp/ --per-thread -- ls
> 
> The command enables config 'timestamp' for 'cs_etm' event in the
> per-thread mode.  In this case, the function cs_etm_validate_config()
> directly bails out and skips validation.
> 
> Given profiled process can be scheduled on any CPUs in the per-thread
> mode, this patch validates timestamp tracing for all CPUs when detect
> the CPU map is empty.

There is an edge case where the profiled process is known by the user to
be pinned to a specific CPU, rather than possibly running on all CPUs,
so this isn't always true.

But I think that can be worked around by changing it to a per-cpu
session to get around the new error. Given that this validation was only
supposed to be best effort information and not get in the way you could
say to not make it more restrictive.

But it's quite a small edge case so either way:

Reviewed-by: James Clark <james.clark@arm.com>

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b8d6a953fd74..cf9ef9ba800b 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -205,8 +205,17 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
>  	for (i = 0; i < cpu__max_cpu().cpu; i++) {
>  		struct perf_cpu cpu = { .cpu = i, };
>  
> -		if (!perf_cpu_map__has(event_cpus, cpu) ||
> -		    !perf_cpu_map__has(online_cpus, cpu))
> +		/*
> +		 * In per-cpu case, do the validation for CPUs to work with.
> +		 * In per-thread case, the CPU map is empty.  Since the traced
> +		 * program can run on any CPUs in this case, thus don't skip
> +		 * validation.
> +		 */
> +		if (!perf_cpu_map__empty(event_cpus) &&
> +		    !perf_cpu_map__has(event_cpus, cpu))
> +			continue;
> +
> +		if (!perf_cpu_map__has(online_cpus, cpu))
>  			continue;
>  
>  		err = cs_etm_validate_context_id(itr, evsel, i);
