Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F27CF5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjJSKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjJSKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:52:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EA11F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vtw7iS5ybnuf3tWFyPSgek/0AivXJUZ6JlioE4W5z+w=; b=WLOUI8ATAS5Y2XvI4uA276nop/
        Ax9s9EwnBoap3xsP1I+W7JRfwBw7Ps9UAoq480POOKRN/VRDi/jhzYkFkB9Di0VDBpx/psFcufCNk
        5CKjK4UCpZN/SpkhPAoQSZHufhA+E7cJDJRh4NjTngfiVkftYW6N9AKSqFNzTZ55ylerBJoPJzBxR
        nL/xDWb5V5xyA/cxBey1hPlbpkr5OLeuqtyrDjzubIrsxTJQpT821BMr02wpzmnxUbIT9pJmEkrB+
        7v+j6hl1zXHRZTDPtJChJLRx7yPR3ta8IvCAcX3Sg3sKfGaF1LGVGSNxC7V3lGvF6j/Z75GlMjg7M
        AdCD/gow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtQdk-009n6n-0K;
        Thu, 19 Oct 2023 10:52:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE51C300338; Thu, 19 Oct 2023 12:52:31 +0200 (CEST)
Date:   Thu, 19 Oct 2023 12:52:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019105231.GG36211@noisy.programming.kicks-ass.net>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004184044.3062788-4-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:

> +#define ARCH_LBR_EVENT_LOG_WIDTH	2
> +#define ARCH_LBR_EVENT_LOG_MASK		0x3

event log ?


> +static __always_inline void intel_pmu_update_lbr_event(u64 *lbr_events, int idx, int pos)
> +{
> +	u64 logs = *lbr_events >> (LBR_INFO_EVENTS_OFFSET +
> +				   idx * ARCH_LBR_EVENT_LOG_WIDTH);
> +
> +	logs &= ARCH_LBR_EVENT_LOG_MASK;
> +	*lbr_events |= logs << (pos * ARCH_LBR_EVENT_LOG_WIDTH);
> +}
> +
> +/*
> + * The enabled order may be different from the counter order.
> + * Update the lbr_events with the enabled order.
> + */
> +static void intel_pmu_lbr_event_reorder(struct cpu_hw_events *cpuc,
> +					struct perf_event *event)
> +{
> +	int i, j, pos = 0, enabled[X86_PMC_IDX_MAX];
> +	struct perf_event *leader, *sibling;
> +
> +	leader = event->group_leader;
> +	if (branch_sample_counters(leader))
> +		enabled[pos++] = leader->hw.idx;
> +
> +	for_each_sibling_event(sibling, leader) {
> +		if (!branch_sample_counters(sibling))
> +			continue;
> +		enabled[pos++] = sibling->hw.idx;
> +	}

Ok, so far so good: enabled[x] = y, is a mapping of hardware index (y)
to group order (x).

Although I would perhaps name that order[] instead of enabled[].

> +
> +	if (!pos)
> +		return;

How would we ever get here if this is the case?

> +
> +	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
> +		for (j = 0; j < pos; j++)
> +			intel_pmu_update_lbr_event(&cpuc->lbr_events[i], enabled[j], j);

But this confuses me... per that function it:

 - extracts counter value for enabled[j] and,
 - or's it into the same variable at j

But what if j is already taken by something else?

That is, suppose enabled[] = {3,2,1,0}, and lbr_events = 11 10 01 00

Then: for (j) intel_pmu_update_lbt_event(&lbr_event, enabled[j], j);

0: 3->0, 11 10 01 00 -> 11 10 01 11
1: 2->1, 11 10 01 11 -> 11 10 11 11
2: 1->2, 11 10 11 11 -> 11 11 11 11



> +
> +		/* Clear the original counter order */
> +		cpuc->lbr_events[i] &= ~LBR_INFO_EVENTS;
> +	}
> +}

Would not something like:

	src = lbr_events[i];
	dst = 0;
	for (j = 0; j < pos; j++) {
		cnt = (src >> enabled[j]*2) & 3;
		dst |= cnt << j*2
	}
	lbr_events[i] = dst;

be *FAR* clearer, and actually work?
