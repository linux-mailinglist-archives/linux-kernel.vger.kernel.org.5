Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA407AF0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjIZQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:35:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636FB3;
        Tue, 26 Sep 2023 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695746113; x=1727282113;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n2EDZfzwz5FaS81/kpTL4P4/rziwTRRBI8J4VETShc8=;
  b=HeuiRZmtP9Odx1owNO89hqh4hcyHenDYSm8w988Ue4sR7/vSdFf+zhtG
   GvqcPP/4e2nbH+0mHyGm8IVLewmsbvcc90/mEpeuZFzU4FRPQUkGmZxld
   M8KASBqVqkb5Qos88UDA4WCFxIPG5cPjAVHImssNk7FNhdyHGbmvE6bdD
   fV5496D0iZMNUqn1J0KOpncGE3jAtP/xDN3FAoDUYGiz8IJNGyX2k7tqW
   XMJdJ4PAk2l2/fL/5tpXNBfoi07wFo4L220jLEldONeYnRSPQr5mMTKGt
   9Xa/cblGBmztD3aBI5wKjFYV7N5v1+9S+EMkRbv/WQctHDiVvRw6I+A4J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448103760"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="448103760"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922486940"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="922486940"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:35:12 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EDA40580BBE;
        Tue, 26 Sep 2023 09:35:10 -0700 (PDT)
Message-ID: <db0135bb-6548-07f8-2707-ec13a7aae8b6@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:35:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 22/25] perf stat: Add TSC support in hardware-grouping
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
 <20230925061824.3818631-23-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-23-weilin.wang@intel.com>
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
> Add TSC check and create new event for it the same way as how we handle
> topdown-* for now since it is not listed in an event json file either. Need
> TSC to support TopdownL4-L5.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/util/metricgroup.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index d10f6afb0..07a82fa21 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -321,6 +321,14 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
>  		}
>  	}
>  	if (matched_events < ids_size) {
> +		struct hashmap_entry *cur;
> +		size_t bkt;
> +
> +		hashmap__for_each_entry(ids, cur, bkt) {
> +			const char *id = cur->pkey;
> +
> +			pr_debug("Need event %s\n", id);
> +		}

Is it just for the debug purpose?
If so, please only traverse the hashmap in debug.

>  		free(metric_events);
>  		return -EINVAL;
>  	}
> @@ -2106,11 +2114,16 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
>  #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
>  	hashmap__for_each_entry(ctx->ids, cur, bkt) {
>  		const char *id = cur->pkey;
> -		const char *special_pattern = "topdown-";
> +		const char *pattern1 = "topdown-";
> +		const char *pattern2 = "TSC";
>  
>  		pr_debug("found event %s\n", id);
> -		if (!strncmp(id, special_pattern, strlen(special_pattern))) {
> +		if (!strncmp(id, pattern1, strlen(pattern1)) ||
> +		    !strncmp(id, pattern2, strlen(pattern2))) {

I guess there may be more patterns later. It's better to add a dedicated
function to the check.

Thanks,
Kan

>  			struct metricgroup__event_info *event;
> +			/* topdown-* and TSC use dedicated registers, set as free
> +			 * counter here for grouping
> +			 */
>  			event = event_info__new(id, "default_core", "0", false,
>  						/*free_counter=*/true);
>  			if (!event) {
> @@ -2602,8 +2615,10 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
>  		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
>  			    metric_no_threshold, user_requested_cpu_list, system_wide,
>  			    /*fake_pmu=*/NULL, metric_events, table);
> -		if (!ret)
> +		if (!ret) {
> +			pr_info("Hardware aware grouping completed\n");
>  			return 0;
> +		}
>  	}
>  
>  	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
