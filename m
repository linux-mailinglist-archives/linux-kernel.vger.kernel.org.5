Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685881344A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573749AbjLNPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573664AbjLNPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:11:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56845D49;
        Thu, 14 Dec 2023 07:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702566667; x=1734102667;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=zYZ+WoQdZiwn9W+G6vQS09KFd/oMW6fzrJc6u7vXV0k=;
  b=O+U27j6uQPbsOuT5z7JT4Et85rxvzvBdpWKmb9l+5/+8vEXqwXn29b3z
   u3DOb/390CJSpeI773nrds5aWT1SaC2hFHc+YTnCysCa0rNR3ky7OUw2Y
   Rk4jTN+vK3DEs027VFHfyErCTxfxN0gBhWTaYszd8mAHtNXoBKobxVGqZ
   1UxdrnMZ8fvWj1VqAd7/CAHKeVqaAzYis+t0UJPzcwfXgMfenLB2cfwKX
   LbtSw2eIBWoRKt9AMIIEZVZ7rs3RHUTyBIEa0rrfOnvGr7VRIXHwolCo2
   H1HVzKl/w1KudVbruwz/8L0yU3p9Zxus8o+F4J2pvg9pIoVyryMbIbDPt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="397914539"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="397914539"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892501890"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892501890"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 07:11:01 -0800
Received: from [10.213.191.138] (kliang2-mobl1.ccr.corp.intel.com [10.213.191.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 456DD580919;
        Thu, 14 Dec 2023 07:10:59 -0800 (PST)
Message-ID: <cd3c9e63-1ae8-4106-b4ed-e1332b29a4ce@linux.intel.com>
Date:   Thu, 14 Dec 2023 10:10:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf stat: Combine the -A/--no-aggr and --no-merge
 options
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kaige Ye <ye@kaige.org>, James Clark <james.clark@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231214060256.2094017-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231214060256.2094017-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-14 1:02 a.m., Ian Rogers wrote:
> The -A or --no-aggr option disables aggregation of core events:
> ```
> $ perf stat -A -e cycles,data_total -a true
> 
>  Performance counter stats for 'system wide':
> 
> CPU0            1,287,665      cycles
> CPU1            1,831,681      cycles
> CPU2           27,345,998      cycles
> CPU3            1,964,799      cycles
> CPU4              236,174      cycles
> CPU5            3,302,825      cycles
> CPU6            9,201,446      cycles
> CPU7            1,403,043      cycles
> CPU0               110.90 MiB  data_total
> 
>        0.008961761 seconds time elapsed
> ```
> 
> The --no-merge option disables the aggregation of uncore events:
> ```
> $ perf stat --no-merge -e cycles,data_total -a true
> 
>  Performance counter stats for 'system wide':
> 
>         38,482,778      cycles
>              15.04 MiB  data_total [uncore_imc_free_running_1]
>              15.00 MiB  data_total [uncore_imc_free_running_0]
> 
>        0.005915155 seconds time elapsed
> ```
> 
> Having two options confuses users who generally don't appreciate the
> difference in PMUs. Keep all the options but make it so they all
> disable aggregation both of core and uncore events:
> ```
> $ perf stat -A -e cycles,data_total -a true
> 
>  Performance counter stats for 'system wide':
> 
> CPU0               85,878      cycles
> CPU1               88,179      cycles
> CPU2               60,872      cycles
> CPU3            3,265,567      cycles
> CPU4               82,357      cycles
> CPU5               83,383      cycles
> CPU6               84,156      cycles
> CPU7              220,803      cycles
> CPU0                 2.38 MiB  data_total [uncore_imc_free_running_0]
> CPU0                 2.38 MiB  data_total [uncore_imc_free_running_1]
> 
>        0.001397205 seconds time elapsed
> ```
> 
> Update the relevant perf-stat man page information.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/Documentation/perf-stat.txt | 52 ++++++++++++++------------
>  tools/perf/builtin-stat.c              |  5 ++-
>  tools/perf/util/stat-display.c         |  2 +-
>  tools/perf/util/stat.c                 |  2 +-
>  tools/perf/util/stat.h                 |  1 -
>  5 files changed, 33 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 8f789fa1242e..5af2e432b54f 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -422,7 +422,34 @@ See perf list output for the possible metrics and metricgroups.
>  
>  -A::
>  --no-aggr::
> -Do not aggregate counts across all monitored CPUs.
> +--no-merge::
> +Do not aggregate/merge counts across monitored CPUs or PMUs.
> +
> +When multiple events are created from a single event specification,
> +stat will, by default, aggregate the event counts and show the result
> +in a single row. This option disables that behavior and shows the
> +individual events and counts.
> +
> +Multiple events are created from a single event specification when:
> +
> +1. PID monitoring isn't requested and the system has more than one
> +   CPU. For example, a system with 8 SMT threads will have one event
> +   opened on each thread and aggregation is performed across them.
> +
> +2. Prefix or glob wildcard matching is used for the PMU name. For
> +   example, multiple memory controller PMUs may exist typically with a
> +   suffix of _0, _1, etc. By default the event counts will all be
> +   combined if the PMU is specified without the suffix such as
> +   uncore_imc rather than uncore_imc_0.
> +
> +3. Aliases, which are listed immediately after the Kernel PMU events
> +   by perf list, are used.
> +
> +--hybrid-merge::
> +Merge core event counts from all core PMUs. In hybrid or big.LITTLE
> +systems by default each core PMU will report its count
> +separately. This option forces core PMU counts to be combined to give
> +a behavior closer to having a single CPU type in the system.
>  
>  --topdown::
>  Print top-down metrics supported by the CPU. This allows to determine
> @@ -475,29 +502,6 @@ highlight 'tma_frontend_bound'. This metric may be drilled into with
>  
>  Error out if the input is higher than the supported max level.
>  
> ---no-merge::
> -Do not merge results from same PMUs.
> -
> -When multiple events are created from a single event specification,
> -stat will, by default, aggregate the event counts and show the result
> -in a single row. This option disables that behavior and shows
> -the individual events and counts.
> -
> -Multiple events are created from a single event specification when:
> -1. Prefix or glob matching is used for the PMU name.
> -2. Aliases, which are listed immediately after the Kernel PMU events
> -   by perf list, are used.
> -
> ---hybrid-merge::
> -Merge the hybrid event counts from all PMUs.
> -
> -For hybrid events, by default, the stat aggregates and reports the event
> -counts per PMU. But sometimes, it's also useful to aggregate event counts
> -from all PMUs. This option enables that behavior and reports the counts
> -without PMUs.
> -
> -For non-hybrid events, it should be no effect.
> -
>  --smi-cost::
>  Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index bda020c0b9d5..5fe9abc6a524 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1204,8 +1204,9 @@ static struct option stat_options[] = {
>  	OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
>  		    "list of cpus to monitor in system-wide"),
>  	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
> -		    "disable CPU count aggregation", AGGR_NONE),
> -	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
> +		    "disable aggregation across CPUs or PMUs", AGGR_NONE),
> +	OPT_SET_UINT(0, "no-merge", &stat_config.aggr_mode,
> +		    "disable aggregation the same as -A or -no-aggr", AGGR_NONE),
>  	OPT_BOOLEAN(0, "hybrid-merge", &stat_config.hybrid_merge,
>  		    "Merge identical named hybrid events"),
>  	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index afe6db8e7bf4..8c61f8627ebc 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -898,7 +898,7 @@ static bool hybrid_uniquify(struct evsel *evsel, struct perf_stat_config *config
>  
>  static void uniquify_counter(struct perf_stat_config *config, struct evsel *counter)
>  {
> -	if (config->no_merge || hybrid_uniquify(counter, config))
> +	if (config->aggr_mode == AGGR_NONE || hybrid_uniquify(counter, config))
>  		uniquify_event_name(counter);
>  }
>  
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 012c4946b9c4..b0bcf92f0f9c 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -592,7 +592,7 @@ void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *ev
>  {
>  	struct evsel *evsel;
>  
> -	if (config->no_merge)
> +	if (config->aggr_mode == AGGR_NONE)
>  		return;
>  
>  	evlist__for_each_entry(evlist, evsel)
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 325d0fad1842..4357ba114822 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -76,7 +76,6 @@ struct perf_stat_config {
>  	bool			 null_run;
>  	bool			 ru_display;
>  	bool			 big_num;
> -	bool			 no_merge;
>  	bool			 hybrid_merge;
>  	bool			 walltime_run_table;
>  	bool			 all_kernel;
