Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941AD7AEE9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjIZOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjIZOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:50:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8281E6;
        Tue, 26 Sep 2023 07:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695739827; x=1727275827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EaC+E5WtUrEntaMZCFrRvq9qil+NxXA1WnqwgDHAFHo=;
  b=TWUJlyu7N6MRXXpwyqj8GpvU4JK/FB/i8GojH69Beg6ki2HKeLX7Jnq+
   VCW7VB6fkLa/oGEum3G3VoDKJL4NtumYJTta+5sxwMCEfFWYAsrHHXlzZ
   amuwdlGHQvpzTKT4Q/+Ceid7ut8LD6sDYjKCS8LCuYNfLLRv4PQ78juAw
   DFepJTYiGQwJ6iOmXG5NoSCR7b7vqrxstiWiB/b2u+Mwi1J8o3RWNYuWd
   VomVnCsMcJ4KfkgC3AESidiydWIgw83PLHIcecoi3uFqX9S3ov/zYAuqw
   5eVBEZLLp7e7w3IAPpXwq1j64HHUlI08sqxRaLpcq/AnmW3nc2L0SpiEg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445712691"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445712691"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814506892"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814506892"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:50:25 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 08799580D9B;
        Tue, 26 Sep 2023 07:50:22 -0700 (PDT)
Message-ID: <52b13a04-2d14-5011-01c9-0989aa47d40d@linux.intel.com>
Date:   Tue, 26 Sep 2023 10:50:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 01/25] perf stat: Add hardware-grouping cmd option to
 perf stat
Content-Language: en-US
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <20230925061824.3818631-2-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-2-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Hardware counter and event information could be used to help creating event
> groups that better utilize hardware counters and improve multiplexing.
> 
> Add a cmd option to allow user to choose this new metric grouping method.
>

It's better to mention this option is only available with -M.

> $ perf stat -M TopdownL1 -a --hardware-grouping
>

I think it should be counter aware grouping. Hardware grouping sounds
like the group is created by hardware.

Eventually we should make it default and let the default grouping code
take the counter information into account.

Thanks,
Kan

> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c     | 7 +++++++
>  tools/perf/util/metricgroup.c | 5 +++++
>  tools/perf/util/metricgroup.h | 1 +
>  tools/perf/util/stat.h        | 1 +
>  4 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 07b48f6df..1a7dbfff5 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1256,6 +1256,8 @@ static struct option stat_options[] = {
>  		       "don't try to share events between metrics in a group"),
>  	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
>  		       "don't try to share events between metrics in a group  "),
> +	OPT_BOOLEAN(0, "hardware-grouping", &stat_config.hardware_aware_grouping,
> +		   "Use hardware aware metric grouping method"),
>  	OPT_BOOLEAN(0, "topdown", &topdown_run,
>  			"measure top-down statistics"),
>  	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> @@ -2061,6 +2063,7 @@ static int add_default_attributes(void)
>  						stat_config.metric_no_threshold,
>  						stat_config.user_requested_cpu_list,
>  						stat_config.system_wide,
> +						stat_config.hardware_aware_grouping,
>  						&stat_config.metric_events);
>  	}
>  
> @@ -2094,6 +2097,7 @@ static int add_default_attributes(void)
>  						stat_config.metric_no_threshold,
>  						stat_config.user_requested_cpu_list,
>  						stat_config.system_wide,
> +						stat_config.hardware_aware_grouping,
>  						&stat_config.metric_events);
>  	}
>  
> @@ -2128,6 +2132,7 @@ static int add_default_attributes(void)
>  						/*metric_no_threshold=*/true,
>  						stat_config.user_requested_cpu_list,
>  						stat_config.system_wide,
> +						stat_config.hardware_aware_grouping,
>  						&stat_config.metric_events) < 0)
>  			return -1;
>  	}
> @@ -2169,6 +2174,7 @@ static int add_default_attributes(void)
>  							/*metric_no_threshold=*/true,
>  							stat_config.user_requested_cpu_list,
>  							stat_config.system_wide,
> +							stat_config.hardware_aware_grouping,
>  							&stat_config.metric_events) < 0)
>  				return -1;
>  
> @@ -2702,6 +2708,7 @@ int cmd_stat(int argc, const char **argv)
>  					stat_config.metric_no_threshold,
>  					stat_config.user_requested_cpu_list,
>  					stat_config.system_wide,
> +					stat_config.hardware_aware_grouping,
>  					&stat_config.metric_events);
>  		zfree(&metrics);
>  	}
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 6231044a4..b08af6860 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      bool metric_no_threshold,
>  			      const char *user_requested_cpu_list,
>  			      bool system_wide,
> +			      bool hardware_aware_grouping,
>  			      struct rblist *metric_events)
>  {
>  	const struct pmu_metrics_table *table = pmu_metrics_table__find();
>  
>  	if (!table)
>  		return -EINVAL;
> +	if (hardware_aware_grouping) {
> +		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
> +	}
> +
>  
>  	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
>  			    metric_no_threshold, user_requested_cpu_list, system_wide,
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index d5325c6ec..779f6ede1 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -77,6 +77,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  			      bool metric_no_threshold,
>  			      const char *user_requested_cpu_list,
>  			      bool system_wide,
> +			      bool hardware_aware_grouping,
>  			      struct rblist *metric_events);
>  int metricgroup__parse_groups_test(struct evlist *evlist,
>  				   const struct pmu_metrics_table *table,
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 325d0fad1..f97d6282b 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -87,6 +87,7 @@ struct perf_stat_config {
>  	bool			 metric_no_group;
>  	bool			 metric_no_merge;
>  	bool			 metric_no_threshold;
> +	bool			 hardware_aware_grouping;
>  	bool			 stop_read_counter;
>  	bool			 iostat_run;
>  	char			 *user_requested_cpu_list;
