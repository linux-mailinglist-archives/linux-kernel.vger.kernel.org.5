Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9AF7DBFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjJ3SaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3SaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:30:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B5C1;
        Mon, 30 Oct 2023 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698690614; x=1730226614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4HbE7+pI3nVZQ/2i4nki9aT3RMSseitiI/9E95mTiFw=;
  b=Tt9bdLNAN9AuHdtd86HCT+NWYbGmDE5na92gL29xy4P0ET+GlZl6fRQJ
   MXx2Y/F/lVz5shNVpzYE9KSbBJdL4bXIMIqqonhN/zqwfcvMHjJoKASIq
   E+XXOwJR6C6vry4yxFvA/HdF+ci3toQGSmAs4U0xQROPpA1nVjH6RK9qe
   OKxjmbswuqdFteouLE8XMj4Y+DPFeMJpHVr2FEDvcA0LRmrtTNUuawicq
   lwhgnKrxrUdURm8HE7CbcuHv+1yOaOXnZCM2nWzpFU/0fRJ+crzTQJGUh
   QsRrp0wAIKeVl5/0U5PihvArXS2iRa5KpM62wfDoFB+A3kwpTJCRhtr/N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1008952"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="1008952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="760367344"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="760367344"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 11:30:11 -0700
Received: from [10.212.90.12] (kliang2-mobl1.ccr.corp.intel.com [10.212.90.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EA6BA580699;
        Mon, 30 Oct 2023 11:30:08 -0700 (PDT)
Message-ID: <b8139aff-4de6-4291-99de-2383d5aa3656@linux.intel.com>
Date:   Mon, 30 Oct 2023 14:30:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/17] perf stat: Add functions to set counter
 bitmaps for hardware-grouping method
Content-Language: en-US
To:     "Wang, Weilin" <weilin.wang@intel.com>,
        "Rogers, Ian" <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
 <20231014015202.1175377-8-weilin.wang@intel.com>
 <ba847510-bdc4-4298-8d9c-10933023e712@linux.intel.com>
 <CO6PR11MB56357BB9FFED934E2ED52E36EEA1A@CO6PR11MB5635.namprd11.prod.outlook.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CO6PR11MB56357BB9FFED934E2ED52E36EEA1A@CO6PR11MB5635.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-30 1:46 p.m., Wang, Weilin wrote:
> 
> 
>> -----Original Message-----
>> From: Liang, Kan <kan.liang@linux.intel.com>
>> Sent: Monday, October 30, 2023 8:32 AM
>> To: Wang, Weilin <weilin.wang@intel.com>; Rogers, Ian
>> <irogers@google.com>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
>> <mingo@redhat.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
>> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
>> <jolsa@kernel.org>; Namhyung Kim <namhyung@kernel.org>; Hunter, Adrian
>> <adrian.hunter@intel.com>
>> Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,
>> Perry <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>;
>> Biggers, Caleb <caleb.biggers@intel.com>; Mark Rutland
>> <mark.rutland@arm.com>; Yang Jihong <yangjihong1@huawei.com>
>> Subject: Re: [RFC PATCH v2 07/17] perf stat: Add functions to set counter
>> bitmaps for hardware-grouping method
>>
>>
>>
>> On 2023-10-13 9:51 p.m., weilin.wang@intel.com wrote:
>>> From: Weilin Wang <weilin.wang@intel.com>
>>>
>>> Add metricgroup__event_info data structure to represent an event in the
>>> metric grouping context; the list of counters and the PMU name an event
>>> should be collected with.
>>>
>>> Add functions to parse event counter info from pmu-events and generate a
>>> list of metricgroup__event_info data to prepare grouping.
>>>
>>> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
>>> ---
>>>  tools/perf/util/metricgroup.c | 196
>> +++++++++++++++++++++++++++++++++-
>>>  tools/perf/util/metricgroup.h |  27 +++++
>>>  2 files changed, 220 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>>> index 8d4e29eb1..6af8a7341 100644
>>> --- a/tools/perf/util/metricgroup.c
>>> +++ b/tools/perf/util/metricgroup.c
>>> @@ -1432,6 +1432,182 @@ static int build_combined_expr_ctx(const
>> struct list_head *metric_list,
>>>  	return ret;
>>>  }
>>>
>>> +/**
>>> + * set_counter_bitmap - The counter bit mapping: [8-15,0-7], e.g. the GP0
>> is the
>>> + * 8th bit and GP7 is the 1st bit in this 16-bits bitmap. It is helpful for
>>> + * assigning GP4-7 before GP0-3 because some events can be collected
>> using GP0-3
>>> + * only on some platforms.
>>
>> The bitmap looks weird. Can we use the normal bitmap and always search
>> from the last set bit to find the available counter?
>>
>>
> 
> Hi Kan,
> 
> Yes, I just want to ensure to start using the highest indexed counter first. 
> Could you please let me know what is the best way to search from the last set bit?
>

I didn't find any existing helper that does reverse search from the last
set bit. But it should not be hard to implement one.

An alternative way would start the search from the middle, e.g.,
for_each_set_bit_wrap(), which should be what you try to achieve here.

Thanks,
Kan
> Thanks,
> Weilin
> 
> 
>>> + */
>>> +static int set_counter_bitmap(int pos, unsigned long *bitmap)
>>> +{
>>> +	if (pos >= NR_COUNTERS || pos < 0)
>>> +		return -EINVAL;
>>> +	if (pos <= 7)
>>> +		pos = TRANSFER_FIRST_BYTE(pos);
>>> +	else
>>> +		pos = TRANSFER_SEC_BYTE(pos);
>>> +	*bitmap |= 1ul << pos;
>>> +	return 0;
>>> +}
>>> +
>>> +static int parse_fixed_counter(const char *counter,
>>> +			      unsigned long *bitmap,
>>> +			      bool *fixed)
>>> +{
>>> +	int ret = -ENOENT;
>>> +	//TODO: this pattern is different on some other platforms
>>> +	const char *pattern = "Fixed counter ";
>>> +	int pos = 0;
>>> +
>>> +	if (!strncmp(counter, pattern, strlen(pattern))) {
>>> +		pos = atoi(counter + strlen(pattern));
>>> +		ret = set_counter_bitmap(pos, bitmap);
>>> +		if (ret)
>>> +			return ret;
>>> +		*fixed = true;
>>> +		return 0;
>>> +	}
>>> +	return ret;
>>> +}
>>> +
>>> +/**
>>> + * parse_counter - Parse event counter info from pmu-events and set up
>> bitmap
>>> + * accordingly.
>>> + *
>>> + * @counter: counter info string to be parsed.
>>> + * @bitmap: bitmap to set based on counter info parsed.
>>> + * @fixed: is set to true if the event uses fixed counter.
>>> + */
>>> +static int parse_counter(const char *counter,
>>> +			unsigned long *bitmap,
>>> +			bool *fixed)
>>> +{
>>> +	int ret = 0;
>>> +	char *p;
>>> +	char *tok;
>>> +	int pos = 0;
>>> +
>>> +	ret = parse_fixed_counter(counter, bitmap, fixed);
>>> +	// ret==0 means matched with fixed counter
>>
>> Move the comments to the above of parse_fixed_counter().
>> Uses /**/.
>>
>>> +	if (ret == 0)
>>> +		return ret;
>>> +
>>> +	p = strdup(counter);
>>> +	tok = strtok(p, ",");
>>> +	if (!tok)
>>> +		return -ENOENT;
>>> +
>>> +	while (tok) {
>>> +		pos = atoi(tok);
>>> +		ret = set_counter_bitmap(pos, bitmap);
>>> +		if (ret)
>>> +			return ret;
>>> +		tok = strtok(NULL, ",");
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +static struct metricgroup__event_info *event_info__new(const char
>> *name,
>>> +						      const char *pmu_name,
>>> +						      const char *counter,
>>> +						      bool free_counter)
>>> +{
>>> +	int ret = 0;
>>> +	char *bit_buf = malloc(NR_COUNTERS);
>>> +	bool fixed_counter = false;
>>> +	struct metricgroup__event_info *e;
>>> +
>>> +	e = zalloc(sizeof(*e));
>>> +	if (!e)
>>> +		return NULL;
>>> +	if (!pmu_name)
>>> +		pmu_name = "core";
>>> +
>>> +	e->name = name;
>>> +	e->free_counter = free_counter;
>>> +	e->pmu_name = strdup(pmu_name);
>>> +	if (free_counter) {
>>> +		ret = set_counter_bitmap(0, e->counters);
>>> +		if (ret)
>>> +			return NULL;
>>> +	} else {
>>> +		ret = parse_counter(counter, e->counters, &fixed_counter);
>>> +		if (ret)
>>> +			return NULL;
>>> +		e->fixed_counter = fixed_counter;
>>> +	}
>>> +
>>> +	bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf,
>> NR_COUNTERS);
>>> +	pr_debug("Event %s requires pmu %s counter: %s bitmap %s,
>> [pmu=%s]\n",
>>> +		e->name, e->pmu_name, counter, bit_buf, pmu_name);
>>> +
>>> +	return e;
>>> +}
>>> +
>>> +struct metricgroup__add_metric_event_data {
>>> +	struct list_head *list;
>>> +	/* pure event name, exclude umask and other info*/
>>> +	const char *event_name;
>>> +	/* event name and umask if applicable*/
>>> +	const char *event_id;
>>> +};
>>> +
>>> +static int metricgroup__add_metric_event_callback(const struct pmu_event
>> *pe,
>>> +						 const struct
>> pmu_events_table *table __maybe_unused,
>>> +						 void *data)
>>> +{
>>> +	struct metricgroup__event_info *event;
>>> +	struct metricgroup__add_metric_event_data *d = data;
>>> +
>>> +	if (!strcasecmp(pe->name, d->event_name)) {
>>> +		event = event_info__new(d->event_id, pe->pmu, pe->counter,
>> /*free_counter=*/false);
>>> +		if (!event)
>>> +			return -ENOMEM;
>>> +		list_add(&event->nd, d->list);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * get_metricgroup_events - Find counter requirement of events from the
>>> + * pmu_events table
>>> + * @full_id: the full event identifiers.
>>> + * @table: pmu_events table that is searched for event data.
>>> + * @event_info_list: the list that the new event counter info added to.
>>> + */
>>> +static int get_metricgroup_events(const char *full_id,
>>> +				 const struct pmu_events_table *table,
>>> +				 struct list_head *event_info_list)
>>> +{
>>> +	LIST_HEAD(list);
>>> +	int ret = 0;
>>> +	const char *id;
>>> +	const char *rsep, *sep = strchr(full_id, '@');
>>> +
>>> +	if (sep) {
>>> +		rsep = strchr(full_id, ',');
>>> +		id = strndup(sep + 1, rsep - sep - 1);
>>> +		if (ret)
>>> +			goto out;
>>> +	} else {
>>> +		id = full_id;
>>> +	}
>>> +	{
>>> +		struct metricgroup__add_metric_event_data data = {
>>> +			.list = &list,
>>> +			.event_name = id,
>>> +			.event_id = full_id,
>>> +		};
>>> +		ret = pmu_events_table_for_each_event(table,
>>> +				metricgroup__add_metric_event_callback,
>> &data);
>>> +	}
>>
>> Please remove the useless {}
>>
>> Thanks,
>> Kan
>>> +
>>> +out:
>>> +	list_splice(&list, event_info_list);
>>> +	return ret;
>>> +}
>>> +
>>>  /**
>>>   * hw_aware_build_grouping - Build event groupings by reading counter
>>>   * requirement of the events and counter available on the system from
>>> @@ -1445,9 +1621,25 @@ static int hw_aware_build_grouping(struct
>> expr_parse_ctx *ctx __maybe_unused,
>>>  				  const char *modifier __maybe_unused)
>>>  {
>>>  	int ret = 0;
>>> +	struct hashmap_entry *cur;
>>> +	LIST_HEAD(pmu_info_list);
>>> +	LIST_HEAD(event_info_list);
>>> +	size_t bkt;
>>> +	const struct pmu_events_table *etable = pmu_events_table__find();
>>> +
>>> +#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
>>> +	hashmap__for_each_entry(ctx->ids, cur, bkt) {
>>> +		const char *id = cur->pkey;
>>> +
>>> +		pr_debug("found event %s\n", id);
>>> +
>>> +		ret = get_metricgroup_events(id, etable, &event_info_list);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>>
>>> -	pr_debug("This is a placeholder\n");
>>>  	return ret;
>>> +#undef RETURN_IF_NON_ZERO
>>>  }
>>>
>>>  static void group_str_free(struct metricgroup__group_strs *g)
>>> @@ -1521,8 +1713,6 @@ static int hw_aware_parse_ids(struct perf_pmu
>> *fake_pmu,
>>>  	*out_evlist = parsed_evlist;
>>>  	parsed_evlist = NULL;
>>>  err_out:
>>> -	parse_events_error__exit(&parse_error);
>>> -	evlist__delete(parsed_evlist);
>>>  	metricgroup__free_grouping_strs(&groupings);
>>>  	return ret;
>>>  }
>>> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
>>> index 89809df85..3704545c9 100644
>>> --- a/tools/perf/util/metricgroup.h
>>> +++ b/tools/perf/util/metricgroup.h
>>> @@ -5,6 +5,7 @@
>>>  #include <linux/list.h>
>>>  #include <linux/rbtree.h>
>>>  #include <stdbool.h>
>>> +#include <linux/bitmap.h>
>>>  #include "pmu-events/pmu-events.h"
>>>  #include "strbuf.h"
>>>
>>> @@ -67,6 +68,32 @@ struct metric_expr {
>>>  	int runtime;
>>>  };
>>>
>>> +/* Maximum number of counters per PMU*/
>>> +#define NR_COUNTERS	16
>>> +/*
>>> + * Transfer bit position in the bitmap to ensure start assigning counter from
>>> + * the last GP counter to the first.
>>> + * bit15 <---> bit0
>>> + * [GP8-GP15] [GP0-GP7]
>>> + */
>>> +#define TRANSFER_FIRST_BYTE(pos) (7 - pos)
>>> +#define TRANSFER_SEC_BYTE(pos) (23 - pos)
>>> +
>>> +/**
>>> + * An event used in a metric. This info is for metric grouping.
>>> + */
>>> +struct metricgroup__event_info {
>>> +	struct list_head nd;
>>> +	/** The name of the event. */
>>> +	const char *name;
>>> +	/** The name of the pmu the event be collected on. */
>>> +	const char *pmu_name;
>>> +	bool fixed_counter;
>>> +	bool free_counter;
>>> +	/** The counters the event allowed to be collected on. */
>>> +	DECLARE_BITMAP(counters, NR_COUNTERS);
>>> +};
>>> +
>>>  /**
>>>   * Each group is one node in the group string list.
>>>   */
