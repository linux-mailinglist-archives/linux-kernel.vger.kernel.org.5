Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1417AF011
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjIZPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIZPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:55:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD53011D;
        Tue, 26 Sep 2023 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695743737; x=1727279737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pOF6yVH9TBFu3hnX6Ts/AEAB3/YNEJyRFK1e0Rc/yc0=;
  b=kX1ovpw/yDKz1DUogqH10uq4WffwYI/Am26DidCw0mKkS93HRKk+Wp9q
   /zvStPq0cA6mretHNUKjzZdBL6CDfFUm5pz27tCs0NmA5TpynU6NiNJ82
   1ogLA5pLLY1yHaFDx7GTfvzyfm9Ql8/tvDJTPJhLM8s2P2HysIdTT6Rmk
   +eoP79aIVXTzl1cbQiYYp9gIjaZE8+CCH+mbNnhqfrMmW8na46ZqwuP4G
   jKO5rdV2ue/rJyHme3oRbKWbMtsYPjAZ6IUPTJ/uybDdClF/NYh2cdU6Z
   hDKmC9VQqvu7BklsDL0ofULojgXmKUSu0uAqrx6PUDcLcFNlsf8Wl9m/i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="371932057"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="371932057"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="864450630"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="864450630"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:55:28 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7E0AC580D9B;
        Tue, 26 Sep 2023 08:55:26 -0700 (PDT)
Message-ID: <ab8a8ffb-47d8-3899-9d8f-f5dd7baa61cb@linux.intel.com>
Date:   Tue, 26 Sep 2023 11:55:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 10/25] perf stat: Add helper functions to
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
 <20230925061824.3818631-11-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-11-weilin.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-09-25 2:18 a.m., weilin.wang@intel.com wrote:
> From: Weilin Wang <weilin.wang@intel.com>
> 
> Add struct metricgroup__pmu_group_list to hold the lists of groups from
> different PMUs. Each PMU has one separate list.
> 
> Add struct metricgroup__group as one node (one group in the grouping
> result) of the metricgroup__pmu_group_list. It uses two bitmaps to log
> counter availabilities(gp counters and fixed counters).
> 
> Add functions to create group and assign event into the groups based on the
> event restrictions (struct metricgroup__event_info) and counter
> availability (pmu_info_list and bitmaps). New group is inserted into the
> list groups.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 72 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h | 37 ++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 0ca885a42..de6a6a1d7 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1681,6 +1681,76 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
>  	return ret;
>  }
>  
> +/**
> + * assign_event_grouping - Assign an event into a group. If existing group
> + * cannot include it, create a new group and insert the event to it.
> + */
> +static int assign_event_grouping(struct metricgroup__event_info *e,
> +				struct list_head *pmu_info_list __maybe_unused,
> +				struct list_head *groups)
> +{
> +	int ret = 0;
> +
> +	struct metricgroup__pmu_group_list *g = NULL;
> +	struct metricgroup__pmu_group_list *pmu_group_head = NULL;
> +
> +	list_for_each_entry(g, groups, nd) {
> +		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
> +			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
> +			pmu_group_head = g;
> +			break;
> +		}
> +	}
> +	if (!pmu_group_head) {
> +		struct metricgroup__pmu_counters *p;
> +
> +		pmu_group_head = malloc(sizeof(struct metricgroup__pmu_group_list));
> +		INIT_LIST_HEAD(&pmu_group_head->group_head);
> +		pr_debug("create new group for event %s in pmu %s ", e->name, e->pmu_name);
> +		pmu_group_head->pmu_name = e->pmu_name;
> +		list_for_each_entry(p, pmu_info_list, nd) {
> +			if (!strcasecmp(p->name, e->pmu_name)) {
> +				pmu_group_head->size = p->size;
> +				pmu_group_head->fixed_size = p->fixed_size;

Just need to fill the size and fixed_size once. Break if the PMU is found.

Thanks,
Kan

> +			}
> +		}
> +		list_add_tail(&pmu_group_head->nd, groups);
> +	}
> +
> +	//ret = insert_event_to_group(e, pmu_group_head, pmu_info_list);
> +	return ret;
> +}
> +
> +/**
> + * create_grouping - Create a list of groups and place all the events of
> + * event_info_list into these groups.
> + * @pmu_info_list: the list of PMU units info based on pmu-events data, used for
> + * creating new groups.
> + * @event_info_list: the list of events to be grouped.
> + * @groupings: the list of groups with events placed in.
> + * @modifier: any modifiers added to the events.
> + */
> +static int create_grouping(struct list_head *pmu_info_list,
> +			  struct list_head *event_info_list,
> +			  struct list_head *groupings __maybe_unused,
> +			  const char *modifier __maybe_unused)
> +{
> +	int ret = 0;
> +	struct metricgroup__event_info *e;
> +	LIST_HEAD(groups);
> +	char *bit_buf = malloc(NR_COUNTERS);
> +
> +	//TODO: for each new core group, we should consider to add events that uses fixed counters
> +	list_for_each_entry(e, event_info_list, nd) {
> +		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
> +		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
> +			e->pmu_name, bit_buf);
> +		ret = assign_event_grouping(e, pmu_info_list, &groups);
> +	}
> +
> +	return ret;
> +};
> +
>  /**
>   * hw_aware_build_grouping - Build event groupings by reading counter
>   * requirement of the events and counter available on the system from
> @@ -1714,6 +1784,8 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>  	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
>  	if (ret)
>  		goto err_out;
> +	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
> +			     modifier);
>  
>  err_out:
>  	metricgroup__free_event_info(&event_info_list);
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 8ee7b434e..f9f8b7498 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -100,6 +100,43 @@ struct metricgroup__pmu_counters {
>  	size_t fixed_size;
>  };
>  
> +/**
> + * A list of groups for this pmu.
> + * This is updated during the grouping.
> + */
> +struct metricgroup__pmu_group_list {
> +	struct list_head nd;
> +	/** The name of the pmu(/core) the events collected on. */
> +	const char *pmu_name;
> +	/** The number of gp counters in the pmu(/core). */
> +	size_t size;
> +	/** The number of fixed counters in the pmu(/core) if applicable. */
> +	size_t fixed_size;
> +	/** Head to the list of groups using this pmu(/core)*/
> +	struct list_head group_head;
> +};
> +
> +/**
> + * This is one node in the metricgroup__pmu_group_list.
> + * It represents on group.
> + */
> +struct metricgroup__group {
> +	struct list_head nd;
> +	/** The bitmaps represent availability of the counters.
> +	 *  They are updated once the corresponding counter is used by
> +	 *  an event (event inserted into the group).
> +	 */
> +	DECLARE_BITMAP(gp_counters, NR_COUNTERS);
> +	DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
> +	/** Head to the list of event names in this group*/
> +	struct list_head event_head;
> +};
> +
> +struct metricgroup__group_events {
> +	struct list_head nd;
> +	const char *event_name;
> +};
> +
>  /**
>   * Each group is one node in the group string list.
>   */
