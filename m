Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4877AF030
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjIZQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIZQCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:02:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4310A;
        Tue, 26 Sep 2023 09:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695744153; x=1727280153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6sXIgOcpoohE96pvYGTLRHkFpmlvI9s9PdhHsWJoYo4=;
  b=Q1u7JYNcaE4WM4iXc3D4j317FOSya44YNt5RKkhE1rxXnqSlkpFsTT2y
   yql23Z28rc5rpEM9pckJmwaHVxYNPYqicV2GDgVW63Sh2l+HnCCt1yn51
   Uz1BMNA2za5eqDAw/DIEZeImg7i31dQ9RiPrmOIQu7Hyb3eie6WGUhpPL
   hVJGels2V0Qa+mpyBU1ba4kShDbQKfMW6q+CfSTp2IWrNCbpzOypvdfvZ
   dvQjkG921HewFFXo8JSpT65UFhZ1cgSmgvHdqRlz5vQ3UJE8wJHEZbZKa
   xXrqS9yXW8v+/nflKDRCeso6JIbBlQjQrG1raL6RrETktKwHdeKkvcrml
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378879085"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378879085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1079753426"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="1079753426"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:02:30 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 56612580BBE;
        Tue, 26 Sep 2023 09:02:28 -0700 (PDT)
Message-ID: <cad87493-6d21-f8eb-e316-ab0db958ca3d@linux.intel.com>
Date:   Tue, 26 Sep 2023 12:02:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 11/25] perf stat: Add utility functions to
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
 <20230925061824.3818631-12-weilin.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230925061824.3818631-12-weilin.wang@intel.com>
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
> Add functions to handle counter bitmaps. Add functions do find and insert
> operations to handle inserting event into groups.
> 
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/lib/bitmap.c            |  20 ++++++
>  tools/perf/util/metricgroup.c | 115 +++++++++++++++++++++++++++++++++-
>  2 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
> index c3e487196..a96dbf001 100644
> --- a/tools/lib/bitmap.c
> +++ b/tools/lib/bitmap.c
> @@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>  			return true;
>  	return false;
>  }
> +
> +void bitmap_clear(unsigned long *map, unsigned int start, int len)
> +{
> +	unsigned long *p = map + BIT_WORD(start);
> +	const unsigned int size = start + len;
> +	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
> +	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
> +
> +	while (len - bits_to_clear >= 0) {
> +		*p &= ~mask_to_clear;
> +		len -= bits_to_clear;
> +		bits_to_clear = BITS_PER_LONG;
> +		mask_to_clear = ~0UL;
> +		p++;
> +	}
> +	if (len) {
> +		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
> +		*p &= ~mask_to_clear;
> +	}
> +}
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index de6a6a1d7..68d56087b 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1450,6 +1450,27 @@ static int set_counter_bitmap(int pos, unsigned long *bitmap)
>  	return 0;
>  }
>  
> +static int find_counter_bitmap(unsigned long *addr1,
> +			      unsigned long *addr2,
> +			      unsigned long *bit)
> +{
> +	unsigned long find_bit = find_next_and_bit(addr1, addr2, NR_COUNTERS, 0);
> +
> +	if (find_bit == NR_COUNTERS)
> +		return -ERANGE;
> +	*bit = find_bit;
> +	return 0;
> +}
> +
> +static int use_counter_bitmap(unsigned long *bitmap,
> +			     unsigned long find_bit)
> +{
> +	if (find_bit >= NR_COUNTERS)
> +		return -EINVAL;
> +	bitmap_clear(bitmap, find_bit, 1);
> +	return 0;
> +}
> +
>  static int parse_fixed_counter(const char *counter,
>  			      unsigned long *bitmap,
>  			      bool *fixed)
> @@ -1681,12 +1702,102 @@ static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
>  	return ret;
>  }
>  
> +/**
> + * Find if there is a counter available for event e in current_group. If a
> + * counter is available, use this counter by fill the bit in the correct counter
> + * bitmap. Otherwise, return error (-ERANGE).
> + */
> +static int find_and_set_counters(struct metricgroup__event_info *e,
> +				struct metricgroup__group *current_group)
> +{
> +	int ret;
> +	unsigned long find_bit = 0;
> +
> +	if (e->free_counter)
> +		return 0;
> +	if (e->fixed_counter) {
> +		ret = find_counter_bitmap(current_group->fixed_counters, e->counters,
> +					 &find_bit);
> +		if (ret)
> +			return ret;
> +		pr_debug("found counter for [event]=%s [e->fixed_counters]=%lu\n",
> +			e->name, *current_group->fixed_counters);
> +		ret = use_counter_bitmap(current_group->fixed_counters, find_bit);
> +	} else {
> +		ret = find_counter_bitmap(current_group->gp_counters, e->counters,
> +					 &find_bit);
> +		if (ret)
> +			return ret;
> +		pr_debug("found counter for [event]=%s [e->gp_counters]=%lu\n",
> +			e->name, *current_group->gp_counters);
> +		ret = use_counter_bitmap(current_group->gp_counters, find_bit);
> +	}
> +	return ret;
> +}
> +
> +static int _insert_event(struct metricgroup__event_info *e,
> +			struct metricgroup__group *group)
> +{
> +	struct metricgroup__group_events *event = malloc(sizeof(struct metricgroup__group_events));
> +
> +	if (!event)
> +		return -ENOMEM;
> +	event->event_name = e->name;
> +	if (e->fixed_counter)
> +		list_add(&event->nd, &group->event_head);
> +	else
> +		list_add_tail(&event->nd, &group->event_head);
> +	return 0;
> +}
> +
> +/**
> + * Insert event e into a group capable to include it
> + *
> + */
> +static int insert_event_to_group(struct metricgroup__event_info *e,
> +				struct metricgroup__pmu_group_list *pmu_group_head)
> +{
> +	struct metricgroup__group *g;
> +	int ret;
> +	//struct list_head *head;
> +
> +	list_for_each_entry(g, &pmu_group_head->group_head, nd) {
> +		ret = find_and_set_counters(e, g);
> +		if (!ret) { /* return if successfully find and set counter*/
> +			ret = _insert_event(e, g);
> +			return ret;
> +		}
> +	}
> +	/*
> +	 * We were not able to find an existing group to insert this event.
> +	 * Continue to create a new group and insert the event in it.
> +	 */
> +	{

What's the {} for?

> +		struct metricgroup__group *current_group = malloc(sizeof(struct metricgroup__group));
> +		if (!current_group)
> +			return -ENOMEM;
> +		pr_debug("create_new_group for [event] %s\n", e->name);
> +
> +		//head = &pmu_group_head->group_head;
> +		//ret = create_new_group(head, current_group, pmu_group_head->size,
> +		//			pmu_group_head->fixed_size);
> +		if (ret)
> +			return ret;

Please completely delete the useless code.

> +		ret = find_and_set_counters(e, current_group);
> +		if (ret)
> +			return ret;
> +		ret = _insert_event(e, current_group);
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * assign_event_grouping - Assign an event into a group. If existing group
>   * cannot include it, create a new group and insert the event to it.
>   */
>  static int assign_event_grouping(struct metricgroup__event_info *e,
> -				struct list_head *pmu_info_list __maybe_unused,
> +				struct list_head *pmu_info_list,
>  				struct list_head *groups)
>  {
>  	int ret = 0;
> @@ -1717,7 +1828,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
>  		list_add_tail(&pmu_group_head->nd, groups);
>  	}
>  
> -	//ret = insert_event_to_group(e, pmu_group_head, pmu_info_list);
> +	ret = insert_event_to_group(e, pmu_group_head);

It's better re-organize the whole series. You cannot just uncomments the
line to introduce a new function.

Thanks,
Kan

>  	return ret;
>  }
>  
