Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58107AEFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjIZP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjIZP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:29:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7F12A;
        Tue, 26 Sep 2023 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742138; x=1727278138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g603Biic2j932FarM5lM/WmT7PGI08aI9E+17AeFtcw=;
  b=Zt1CY0NnCMPfyV1l/siQHSnCoE2S58Ic4ej5wrGO80yo2qcW5UMCrcB2
   QkmmU6yJC2uZG5y9b7loMmFCj1N/By2nYyzKPgv/1tP1t+GWCGLXUkdyo
   gPw9QAwSD0nSZGY2Xr0qC/ClVgry5pYW41m866pcO7NxwzTy2Sn7I/N6A
   /l/sBb1X6Jp+ySxeozfJkhwpTeMEoCOVj9PFLaa6ohYzIm0cfMkf3wbPe
   elI31njYL39j41ULW9IqslqI5+tcVgE8GXgTV8sh0xqogC80RGnVr/5Yv
   U1OeXKNMr/M4F989s9YDGVQGRUVQbanZB3pK6eT4dGU94nBFg+2i9N2p/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378871457"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378871457"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725460956"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="725460956"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:28:58 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0FA9B580BBE;
        Tue, 26 Sep 2023 08:28:55 -0700 (PDT)
Message-ID: <f6805f28-9083-1369-3886-a9aeca2908c0@linux.intel.com>
Date:   Tue, 26 Sep 2023 11:28:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 07/25] perf stat: Add helper functions for
 hardware-grouping method
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
 <20230925061824.3818631-8-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-8-weilin.wang@intel.com>
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
> Add metricgroup__event_info data structure to represent an event in the
> metric grouping context; the list of counters and the PMU name an event
> should be collected with.
> 
> Add functions to parse event counter info from pmu-events and generate a
> list of metricgroup__event_info data to prepare grouping.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 197 +++++++++++++++++++++++++++++++++-
>  tools/perf/util/metricgroup.h |  18 ++++
>  2 files changed, 212 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 063c92c71..7f2c1b017 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1432,6 +1432,183 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>  	return ret;
>  }
>  
> +/**
> + * set_counter_bitmap - The counter bit mapping: [8-15,0-7], e.g. the GP0 is the
> + * 8th bit and GP7 is the 1st bit in this 16-bits bitmap. The is helpful to
> + * assign GP4-7 before GP0-3 because some events can be collected using GP0-3
> + * only on some platforms.
> + */
> +static int set_counter_bitmap(int pos, unsigned long *bitmap)
> +{
> +	if (pos >= NR_COUNTERS || pos < 0)
> +		return -EINVAL;
> +	if (pos <= 7)
> +		pos = 7 - pos;
> +	else
> +		pos = 23 - pos;

What's 23? Please use macro to replace all the magic number.

Maybe it's easier to always assign from the last available counter. The
first several counters are usually the special counters.

> +	*bitmap |= 1ul << pos;
> +	return 0;
> +}
> +
> +static int parse_fixed_counter(const char *counter,
> +			      unsigned long *bitmap,
> +			      bool *fixed)
> +{
> +	int ret = -ENOENT;
> +	//TODO: this pattern is different on some other platforms
> +	const char *pattern = "Fixed counter ";
> +	int pos = 0;
> +
> +	if (!strncmp(counter, pattern, strlen(pattern))) {
> +		pos = atoi(counter + strlen(pattern));
> +		ret = set_counter_bitmap(pos, bitmap);


The fixed counter, e.g., cycles, instructions, ref-cycles (after SPR),
are usually expanded to GP counters as well in the kernel. You may want
to set both fixed counter and GP counter for them.

Thanks,
Kan

> +		if (ret)
> +			return ret;
> +		*fixed = true;
> +		return 0;
> +	}
> +	return ret;
> +}
> +
> +/**
> + * parse_counter - Parse event counter info from pmu-events and set up bitmap
> + * accordingly.
> + *
> + * @counter: counter info string to be parsed.
> + * @bitmap: bitmap to set based on counter info parsed.
> + * @fixed: is set to true if the event uses fixed counter.
> + */
> +static int parse_counter(const char *counter,
> +			unsigned long *bitmap,
> +			bool *fixed)
> +{
> +	int ret = 0;
> +	char *p;
> +	char *tok;
> +	int pos = 0;
> +
> +	ret = parse_fixed_counter(counter, bitmap, fixed);
> +	// ret==0 means matched with fixed counter
> +	if (ret == 0)
> +		return ret;
> +
> +	p = strdup(counter);
> +	tok = strtok(p, ",");
> +	if (!tok)
> +		return -ENOENT;
> +
> +	while (tok) {
> +		pos = atoi(tok);
> +		ret = set_counter_bitmap(pos, bitmap);
> +		if (ret)
> +			return ret;
> +		tok = strtok(NULL, ",");
> +	}
> +	return 0;
> +}
> +
> +static struct metricgroup__event_info *event_info__new(const char *name,
> +						      const char *pmu_name,
> +						      const char *counter,
> +						      bool free_counter)
> +{
> +	int ret = 0;
> +	char *bit_buf = malloc(NR_COUNTERS);
> +	bool fixed_counter = false;
> +	struct metricgroup__event_info *e;
> +	e = zalloc(sizeof(*e));
> +	if (!e)
> +		return NULL;
> +	if (!pmu_name) {
> +		pmu_name = "core";
> +	}
> +	e->name = name;
> +	e->free_counter = free_counter;
> +	e->pmu_name = strdup(pmu_name);
> +	if (free_counter) {
> +		ret = set_counter_bitmap(0, e->counters);
> +		if (ret)
> +			return NULL;
> +	} else {
> +		ret = parse_counter(counter, e->counters, &fixed_counter);
> +		if (ret)
> +			return NULL;
> +		e->fixed_counter = fixed_counter;
> +	}
> +
> +	bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
> +	pr_debug("Event %s requires pmu %s counter: %s bitmap %s, [pmu=%s]\n",
> +		e->name, e->pmu_name, counter, bit_buf, pmu_name);
> +
> +	return e;
> +}
> +
> +struct metricgroup__add_metric_event_data {
> +	struct list_head *list;
> +	/* pure event name, exclude umask and other info*/
> +	const char *event_name;
> +	/* event name and umask if applicable*/
> +	const char *event_id;
> +};
> +
> +static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
> +						 const struct pmu_events_table *table __maybe_unused,
> +						 void *data)
> +{
> +	struct metricgroup__event_info *event;
> +	struct metricgroup__add_metric_event_data *d = data;
> +
> +	if (!strcasecmp(pe->name, d->event_name)) {
> +		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
> +		if (!event)
> +			return -ENOMEM;
> +		list_add(&event->nd, d->list);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * get_metricgroup_events - Find counter requirement of events from the
> + * pmu_events table
> + * @full_id: the full event identifiers.
> + * @table: pmu_events table that is searched for event data.
> + * @event_info_list: the list that the new event counter info added to.
> + */
> +static int get_metricgroup_events(const char *full_id,
> +				 const struct pmu_events_table *table,
> +				 struct list_head *event_info_list)
> +{
> +	LIST_HEAD(list);
> +	int ret = 0;
> +	const char *id;
> +	const char *rsep, *sep = strchr(full_id, '@');
> +
> +	if (sep) {
> +		rsep = strchr(full_id, ',');
> +		id = strndup(sep + 1, rsep - sep - 1);
> +		if (ret)
> +			goto out;
> +	} else {
> +		id = full_id;
> +	}
> +	{
> +		struct metricgroup__add_metric_event_data data = {
> +			.list = &list,
> +			.event_name = id,
> +			.event_id = full_id,
> +		};
> +		ret = pmu_events_table_for_each_event(table,
> +				metricgroup__add_metric_event_callback, &data);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	list_splice(&list, event_info_list);
> +	return ret;
> +}
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -1445,9 +1622,25 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>  				  const char *modifier __maybe_unused)
>  {
>  	int ret = 0;
> +	struct hashmap_entry *cur;
> +	LIST_HEAD(pmu_info_list);
> +	LIST_HEAD(event_info_list);
> +	size_t bkt;
> +	const struct pmu_events_table *etable = pmu_events_table__find();
> +
> +#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> +	hashmap__for_each_entry(ctx->ids, cur, bkt) {
> +		const char *id = cur->pkey;
> +
> +		pr_debug("found event %s\n", id);
> +
> +		ret = get_metricgroup_events(id, etable, &event_info_list);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	pr_debug("This is a placeholder\n");
>  	return ret;
> +#undef RETURN_IF_NON_ZERO
>  }
>  
>  static void group_str_free(struct metricgroup__group_strs *g)
> @@ -1521,8 +1714,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
>  	*out_evlist = parsed_evlist;
>  	parsed_evlist = NULL;
>  err_out:
> -	parse_events_error__exit(&parse_error);
> -	evlist__delete(parsed_evlist);
>  	metricgroup__free_grouping_strs(&groupings);
>  	return ret;
>  }
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 89809df85..e493f6965 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -5,6 +5,7 @@
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  #include <stdbool.h>
> +#include <linux/bitmap.h>
>  #include "pmu-events/pmu-events.h"
>  #include "strbuf.h"
>  
> @@ -67,6 +68,23 @@ struct metric_expr {
>  	int runtime;
>  };
>  
> +/* Maximum number of counters per PMU*/
> +#define NR_COUNTERS	16
> +/**
> + * An event used in a metric. This info is for metric grouping.
> + */
> +struct metricgroup__event_info {
> +	struct list_head nd;
> +	/** The name of the event. */
> +	const char *name;
> +	/** The name of the pmu the event be collected on. */
> +	const char *pmu_name;
> +	bool fixed_counter;
> +	bool free_counter;
> +	/** The counters the event allowed to be collected on. */
> +	DECLARE_BITMAP(counters, NR_COUNTERS);
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
