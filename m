Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B087CFC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbjJSO0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346083AbjJSO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:26:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D8184
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697725566; x=1729261566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rt26PZjYnhYHypuMIJpKr6LQFndtnUTqnn7wgqP2D8k=;
  b=NWewB2MFjw2ChB8T0CMcKOaAk8sWOGvTPE8h971cwFDzd7haxmFiK9iY
   oaUPSa+DIeOWAHZpN8asOZYzKA0DG1qyhGnaTdMABpKKu8EsyrqDi/Q5p
   pOij1HaPlCZfFHDy6qmy5xioSQa19V8acvAX4rO3cSDlxuQQH+ZNHAIOk
   rCXKK7IVFAt4IaVqDxiMapyaI4/OUwm2iSUGZAMpmJpzaQ2IiiZXtd7K9
   LBKs2B2AoFuCtd/HsR0Yf+XxdCUXq00lj1IQNssvWJi/0h14logEIBBnF
   Wf5eRNy4mC5R+njRMoVVtGBBxC8HijqwML/jpnXxRO8D6ZdZa63BGIgjv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="383485037"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="383485037"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760659258"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760659258"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:26:04 -0700
Received: from [10.212.5.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.5.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DDF1C580E30;
        Thu, 19 Oct 2023 07:26:02 -0700 (PDT)
Message-ID: <c23fa9e8-1b37-4d44-a554-f8f0508968b0@linux.intel.com>
Date:   Thu, 19 Oct 2023 10:26:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
 <20231019105231.GG36211@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231019105231.GG36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-19 6:52 a.m., Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +#define ARCH_LBR_EVENT_LOG_WIDTH	2
>> +#define ARCH_LBR_EVENT_LOG_MASK		0x3
> 
> event log ?

That's the name in the Intel spec. I will change it to the name used in
Linux and add a comment to map the name event log to the name branch
counter.

> 
> 
>> +static __always_inline void intel_pmu_update_lbr_event(u64 *lbr_events, int idx, int pos)
>> +{
>> +	u64 logs = *lbr_events >> (LBR_INFO_EVENTS_OFFSET +
>> +				   idx * ARCH_LBR_EVENT_LOG_WIDTH);
>> +
>> +	logs &= ARCH_LBR_EVENT_LOG_MASK;
>> +	*lbr_events |= logs << (pos * ARCH_LBR_EVENT_LOG_WIDTH);
>> +}
>> +
>> +/*
>> + * The enabled order may be different from the counter order.
>> + * Update the lbr_events with the enabled order.
>> + */
>> +static void intel_pmu_lbr_event_reorder(struct cpu_hw_events *cpuc,
>> +					struct perf_event *event)
>> +{
>> +	int i, j, pos = 0, enabled[X86_PMC_IDX_MAX];
>> +	struct perf_event *leader, *sibling;
>> +
>> +	leader = event->group_leader;
>> +	if (branch_sample_counters(leader))
>> +		enabled[pos++] = leader->hw.idx;
>> +
>> +	for_each_sibling_event(sibling, leader) {
>> +		if (!branch_sample_counters(sibling))
>> +			continue;
>> +		enabled[pos++] = sibling->hw.idx;
>> +	}
> 
> Ok, so far so good: enabled[x] = y, is a mapping of hardware index (y)
> to group order (x).
> 
> Although I would perhaps name that order[] instead of enabled[].

Sure

> 
>> +
>> +	if (!pos)
>> +		return;
> 
> How would we ever get here if this is the case?

It should be a bug. I will use a WARN_ON_ONCE() to replace it.

> 
>> +
>> +	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
>> +		for (j = 0; j < pos; j++)
>> +			intel_pmu_update_lbr_event(&cpuc->lbr_events[i], enabled[j], j);
> 
> But this confuses me... per that function it:
> 
>  - extracts counter value for enabled[j] and,
>  - or's it into the same variable at j
> 
> But what if j is already taken by something else?
> 
> That is, suppose enabled[] = {3,2,1,0}, and lbr_events = 11 10 01 00
> 
> Then: for (j) intel_pmu_update_lbt_event(&lbr_event, enabled[j], j);
> 
> 0: 3->0, 11 10 01 00 -> 11 10 01 11
> 1: 2->1, 11 10 01 11 -> 11 10 11 11
> 2: 1->2, 11 10 11 11 -> 11 11 11 11
> 
> 
> 
>> +
>> +		/* Clear the original counter order */
>> +		cpuc->lbr_events[i] &= ~LBR_INFO_EVENTS;
>> +	}
>> +}
> 
> Would not something like:
> 
> 	src = lbr_events[i];
> 	dst = 0;
> 	for (j = 0; j < pos; j++) {
> 		cnt = (src >> enabled[j]*2) & 3;
> 		dst |= cnt << j*2
> 	}
> 	lbr_events[i] = dst;
> 
> be *FAR* clearer, and actually work?

The original LBR event data is saved at offset 32 of LBR_INFO register.
In get_lbr_events(), the data was simply copied to the offset 32 of
cpuc->lbr_events.

The intel_pmu_update_lbr_event() reorders the value and saves it
starting from the offset 0.

I agree it's hard to read since it combines the src and dst into the
same variable.

I will use the suggested code and also update the get_lbr_events().

	cpuc->lbr_events[i] = (info >> 32) & LBR_INFO_EVENTS;

Thanks,
Kan
