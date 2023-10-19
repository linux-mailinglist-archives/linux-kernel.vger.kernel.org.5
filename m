Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078167CF636
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjJSLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjJSLJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:09:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB1BFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+vf3GRhxElhOefU10A2zyojxMhOvckiy0GEpif8588=; b=XLn0N6oVsyDI0ghr2Sm3vr3xFG
        zXf4ZAY57dPwkNV/xo6o4oHTAcGJm1f25PMY7lx+AZPOOoChcVJ7zM9g2dfoteTPprJIY8iT89qKZ
        Rjw7ENETpvxDiaY/1oTyLJjwijazZPLmMuVxCh077pBw2ppLTm1zxkD0YIGcQAuF8szI5d9HTOgUa
        VF/Z44PdrWFN5VYTvnWe7trwlffYjO+iM0tapX8CIOaxQVuQhXe0ab43PdB0BIdFJc6uUysygEqhP
        6YETI1vjTqwBX8TdgHV59DtVs1CfkkBDHw5zuf4tnjGrcoVGDGYDBIrnUVM9lTkwyI1c1DgdPUvqn
        CwqFTFPQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtQu0-009odH-0Q;
        Thu, 19 Oct 2023 11:09:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04735300392; Thu, 19 Oct 2023 13:09:18 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:09:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019110917.GI36211@noisy.programming.kicks-ass.net>
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

> @@ -3905,6 +3915,44 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	if (needs_branch_stack(event) && is_sampling_event(event))
>  		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>  
> +	if (branch_sample_counters(event)) {
> +		struct perf_event *leader, *sibling;
> +
> +		if (!(x86_pmu.flags & PMU_FL_LBR_EVENT) ||
> +		    (event->attr.config & ~INTEL_ARCH_EVENT_MASK))
> +			return -EINVAL;
> +
> +		/*
> +		 * The event logging is not supported in the call stack mode
> +		 * yet, since we cannot simply flush the LBR during e.g.,
> +		 * multiplexing. Also, there is no obvious usage with the call
> +		 * stack mode. Simply forbids it for now.
> +		 *
> +		 * If any events in the group enable the LBR event logging
> +		 * feature, the group is treated as a LBR event logging group,
> +		 * which requires the extra space to store the counters.
> +		 */
> +		leader = event->group_leader;
> +		if (branch_sample_call_stack(leader))
> +			return -EINVAL;
> +		leader->hw.flags  |= PERF_X86_EVENT_BRANCH_COUNTERS;

(superfluous whitespace before operator)

> +
> +		for_each_sibling_event(sibling, leader) {
> +			if (branch_sample_call_stack(sibling))
> +				return -EINVAL;
> +		}
> +
> +		/*
> +		 * Only applying the PERF_SAMPLE_BRANCH_COUNTERS doesn't
> +		 * require any branch stack setup.
> +		 * Clear the bit to avoid unnecessary branch stack setup.
> +		 */
> +		if (0 == (event->attr.branch_sample_type &
> +			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
> +			    PERF_SAMPLE_BRANCH_COUNTERS)))
> +			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +	}

Does this / should this check the number of group members vs supported
number of lbr counters?
