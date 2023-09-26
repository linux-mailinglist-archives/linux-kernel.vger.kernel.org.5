Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8367AF098
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjIZQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjIZQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:22:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E811F;
        Tue, 26 Sep 2023 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745313; x=1727281313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hhnhfS38ZgKucCnA9mX/+vZ/cMiuEyg2xb5xDjHZ6Rk=;
  b=Uxfqb+162p1/8M0R8BS6pUtUY8sFKrUvkm1N0MuSwcvzFjqFI9vHe7ee
   ZQkH2uMFBN80x7W1L09uS1B+kKG2wsvDsUEmfdJA0p8njXC81mQtPS5TK
   MS1GtZgT9Ray+608+OUqgZGvDPUhKcA/F4ZKv45UW39wUu4O31JIzM4Um
   rE7GT52ThkRFauuZknBQkYqjYzFEwYDDZh5aPRpmKWZIF0CLDP/nON4IH
   BhaZKpVXwHREU7M8tsqUSU2GxiW2/t8ncAZKKllhpFZNvr4HMgPawe1JJ
   39FNOEbXSzdL/tJJTNeNtxWij8YwiEijFnlJi9GXIPUsTx0PFctunQnGz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445739291"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445739291"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725489437"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="725489437"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:21:36 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 53773580D9B;
        Tue, 26 Sep 2023 09:21:34 -0700 (PDT)
Message-ID: <fb66a030-fb36-6db1-1493-f8793817f0e6@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:21:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 14/25] perf stat: Add build string function and
 topdown events handling in hardware-grouping
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
 <20230925061824.3818631-15-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-15-weilin.wang@intel.com>
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
> Add the function to generate final grouping strings. This function is
> very similar to the existing metricgroup__build_event_string() function.
> The difference is that the input data includes a list of grouping lists.
> 
> Topdown events need special handling because they are not included in the
> pmu-event JSON file. This should be a temporary solution to group topdown
> events. Better solution could be using JSON files to cover these events.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 106 +++++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4b1b0470d..797f831e1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1895,6 +1895,95 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
>  	return ret;
>  }
>  
> +static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs,
> +					   const char *modifier,
> +					   struct list_head *groups)
> +{
> +	struct metricgroup__pmu_group_list *p;
> +	struct metricgroup__group *g;
> +	struct metricgroup__group_events *ge;
> +	bool no_group = true;
> +	int ret = 0;
> +
> +#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
> +
> +	list_for_each_entry(p, groups, nd) {
> +		list_for_each_entry(g, &p->group_head, nd) {
> +			struct strbuf *events;
> +			struct metricgroup__group_strs *new_group_str = malloc(sizeof(struct metricgroup__group_strs));
> +
> +			if (!new_group_str)
> +				return -ENOMEM;
> +			strbuf_init(&new_group_str->grouping_str, 0);
> +			events = &new_group_str->grouping_str;
> +			ret = strbuf_addch(events, '{');
> +			RETURN_IF_NON_ZERO(ret);
> +			no_group = true;
> +			list_for_each_entry(ge, &g->event_head, nd) {
> +				const char *sep, *rsep, *id = ge->event_name;
> +
> +				pr_debug("found event %s\n", id);
> +
> +				/* Separate events with commas and open the group if necessary. */
> +				if (!no_group) {
> +					ret = strbuf_addch(events, ',');
> +					RETURN_IF_NON_ZERO(ret);
> +				}
> +				/*
> +				 * Encode the ID as an event string. Add a qualifier for
> +				 * metric_id that is the original name except with characters
> +				 * that parse-events can't parse replaced. For example,
> +				 * 'msr@tsc@' gets added as msr/tsc,metric-id=msr!3tsc!3/
> +				 */
> +				sep = strchr(id, '@');
> +				if (sep) {
> +					ret = strbuf_add(events, id, sep - id);
> +					RETURN_IF_NON_ZERO(ret);
> +					ret = strbuf_addch(events, '/');
> +					RETURN_IF_NON_ZERO(ret);
> +					rsep = strrchr(sep, '@');
> +					ret = strbuf_add(events, sep + 1, rsep - sep - 1);
> +					RETURN_IF_NON_ZERO(ret);
> +					ret = strbuf_addstr(events, ",metric-id=");
> +					RETURN_IF_NON_ZERO(ret);
> +					sep = rsep;
> +				} else {
> +					sep = strchr(id, ':');
> +					if (sep) {
> +						ret = strbuf_add(events, id, sep - id);
> +						RETURN_IF_NON_ZERO(ret);
> +					} else {
> +						ret = strbuf_addstr(events, id);
> +						RETURN_IF_NON_ZERO(ret);
> +					}
> +					ret = strbuf_addstr(events, "/metric-id=");
> +					RETURN_IF_NON_ZERO(ret);
> +				}
> +				ret = encode_metric_id(events, id);
> +				RETURN_IF_NON_ZERO(ret);
> +				ret = strbuf_addstr(events, "/");
> +				RETURN_IF_NON_ZERO(ret);
> +
> +				if (sep) {
> +					ret = strbuf_addstr(events, sep + 1);
> +					RETURN_IF_NON_ZERO(ret);
> +				}
> +				if (modifier) {
> +					ret = strbuf_addstr(events, modifier);
> +					RETURN_IF_NON_ZERO(ret);
> +				}
> +				no_group = false;
> +			}
> +			ret = strbuf_addf(events, "}:W");

We may not need :W, since the counter information has already considered
in the method.

Thanks,
Kan


> +			RETURN_IF_NON_ZERO(ret);
> +			pr_debug("events-buf: %s\n", events->buf);
> +			list_add_tail(&new_group_str->nd, group_strs);
> +		}
> +	}
> +	return ret;
> +#undef RETURN_IF_NON_ZERO
> +}
> +
>  /**
>   * create_grouping - Create a list of groups and place all the events of
>   * event_info_list into these groups.
> @@ -1906,8 +1995,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
>   */
>  static int create_grouping(struct list_head *pmu_info_list,
>  			  struct list_head *event_info_list,
> -			  struct list_head *groupings __maybe_unused,
> -			  const char *modifier __maybe_unused)
> +			  struct list_head *groupings,
> +			  const char *modifier)
>  {
>  	int ret = 0;
>  	struct metricgroup__event_info *e;
> @@ -1923,6 +2012,7 @@ static int create_grouping(struct list_head *pmu_info_list,
>  		if (ret)
>  			goto out;
>  	}
> +	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
>  out:
>  	metricgroup__free_group_list(&groups);
>  	return ret;
> @@ -1951,9 +2041,19 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
>  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
>  	hashmap__for_each_entry(ctx->ids, cur, bkt) {
>  		const char *id = cur->pkey;
> +		const char *special_pattern = "topdown-";
>  
>  		pr_debug("found event %s\n", id);
> -
> +		if (!strncmp(id, special_pattern, strlen(special_pattern))) {
> +			struct metricgroup__event_info *event;
> +			event = event_info__new(id, "core", "0", true);
> +			if (!event) {
> +				ret = -ENOMEM;
> +				goto err_out;
> +			}
> +			list_add(&event->nd, &event_info_list);
> +			continue;
> +		}
>  		ret = get_metricgroup_events(id, etable, &event_info_list);
>  		if (ret)
>  			goto err_out;
