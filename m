Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF4E7AEFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjIZPhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjIZPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:37:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C7EB;
        Tue, 26 Sep 2023 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742628; x=1727278628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zm/WtMH0gBH+Qk8t0cKJRISjMzFaGPN4OMKfBuDgs90=;
  b=YGaEM/+DXdfybhY4yjm/dyJmh7A8eMRuXKq2QftctvnoVGBbwQwdR7Lq
   V+VU5bmD7c2nXr0ApllyeW27aOjxTW43+N/+h+dffCIzol4wZznGXYHlD
   96Uv7DLkNCIYo0HFIZ9p64aND2q6Mav9zWRzmY3PQJj239wY/8bC2NOLh
   Ci9sPB258Ran+Y5/3D1x5mGaNJdDEDp1nPbC1bwR4Uxlcul+mATL6/0ng
   ARyNpPh3DuDwcBRciTXPk0JnQ4CuN2f3r6fDP1pWiqWgZMvQnMvRl8g4x
   f9LmZkHLLJ0qAfhcX4SD/1asdId3q03A+cwZ0dMNCgBDfgvj48XAyHAXB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385441673"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="385441673"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725465724"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="725465724"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:37:07 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2C17C580BBE;
        Tue, 26 Sep 2023 08:37:05 -0700 (PDT)
Message-ID: <29468aec-427b-8b44-f9e9-151f01778a8b@linux.intel.com>
Date:   Tue, 26 Sep 2023 11:37:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 08/25] perf stat: Add functions to get counter info
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
 <20230925061824.3818631-9-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-9-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Add data structure metricgroup__pmu_counters to represent hardware counters
> available in the system.
> 
> Add functions to parse pmu-events and create the list of pmu_info_list to
> hold the counter information of the system.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 59 +++++++++++++++++++++++++++++++++--
>  tools/perf/util/metricgroup.h | 15 +++++++++
>  tools/perf/util/pmu.c         |  5 +++
>  tools/perf/util/pmu.h         |  1 +
>  4 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 7f2c1b017..feb5dab26 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1598,8 +1598,8 @@ static int get_metricgroup_events(const char *full_id,
>  			.event_name = id,
>  			.event_id = full_id,
>  		};
> -		ret = pmu_events_table_for_each_event(table,
> -				metricgroup__add_metric_event_callback, &data);
> +		ret = pmu_events_table__for_each_event(table, /*pmu=*/NULL,
> +						      metricgroup__add_metric_event_callback, &data);
>  		if (ret)
>  			goto out;
>  	}
> @@ -1609,6 +1609,56 @@ static int get_metricgroup_events(const char *full_id,
>  	return ret;
>  }
>  
> +static struct metricgroup__pmu_counters *pmu_layout__new(const struct pmu_layout *pl)
> +{
> +	struct metricgroup__pmu_counters *l;
> +	l = zalloc(sizeof(*l));
> +
> +	if (!l)
> +		return NULL;
> +
> +	l->name = pl->pmu;
> +	l->size = pl->size;
> +	l->fixed_size = pl->fixed_size;
> +	pr_debug("create new pmu_layout: [pmu]=%s, [gp_size]=%ld, [fixed_size]=%ld\n",
> +		l->name, l->size, l->fixed_size);
> +	return l;
> +}
> +
> +static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
> +						void *data)
> +{
> +	struct metricgroup__pmu_counters *pmu;
> +	struct list_head *d = data;
> +	int ret = 0;
> +
> +	pmu = pmu_layout__new(pl);
> +	if (!pmu)
> +		return -ENOMEM;
> +	list_add(&pmu->nd, d);
> +	return ret;
> +}
> +
> +/**
> + * get_pmu_counter_layouts - Find counter info of the architecture from
> + * the pmu_layouts table
> + * @pmu_info_list: the list that the new counter info of a pmu is added to.
> + * @table: pmu_layouts table that is searched for counter info.
> + */
> +static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
> +				   const struct pmu_layouts_table
> +				   *table)
> +{
> +	LIST_HEAD(list);
> +	int ret;
> +
> +	ret = pmu_layouts_table__for_each_layout(table,
> +						metricgroup__add_pmu_layout_callback, &list);
> +
> +	list_splice(&list, pmu_info_list);
> +	return ret;
> +}
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -1627,6 +1677,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>  	LIST_HEAD(event_info_list);
>  	size_t bkt;
>  	const struct pmu_events_table *etable = pmu_events_table__find();
> +	const struct pmu_layouts_table *ltable = pmu_layouts_table__find();
>  
>  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
>  	hashmap__for_each_entry(ctx->ids, cur, bkt) {
> @@ -1638,6 +1689,10 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>  		if (ret)
>  			return ret;
>  	}
> +	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
> +	if (ret)
> +		return ret;
> +
>  
>  	return ret;
>  #undef RETURN_IF_NON_ZERO
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index e493f6965..8ee7b434e 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -85,6 +85,21 @@ struct metricgroup__event_info {
>  	DECLARE_BITMAP(counters, NR_COUNTERS);
>  };
>  
> +/**
> + * A node is the counter availability of a pmu.
> + * This info is built up at the beginning from JSON file and
> + * used as a reference in metric grouping process.
> +*/
> +struct metricgroup__pmu_counters {
> +	struct list_head nd;
> +	/** The name of the pmu the event collected on. */
> +	const char *name;
> +	//DECLARE_BITMAP(counter_bits, NR_COUNTERS);
> +	/** The number of gp counters in the pmu. */
> +	size_t size;
> +	size_t fixed_size;
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index cde33e019..af4056a88 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -813,6 +813,11 @@ __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
>  	return perf_pmu__find_metrics_table(NULL);
>  }
>  
> +__weak const struct pmu_layouts_table *pmu_layouts_table__find(void)

Why __weak? Is there any other ARCHs use the function?

Thanks,
Kan
> +{
> +	return perf_pmu__find_layouts_table(NULL);
> +}
> +
>  /**
>   * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring any
>   *                                   trailing suffix? The Suffix must be in form
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 6a4e170c6..3e9243e00 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
>  char *perf_pmu__getcpuid(struct perf_pmu *pmu);
>  const struct pmu_events_table *pmu_events_table__find(void);
>  const struct pmu_metrics_table *pmu_metrics_table__find(void);
> +const struct pmu_layouts_table *pmu_layouts_table__find(void);
>  
>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>  
