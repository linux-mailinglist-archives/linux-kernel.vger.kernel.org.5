Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CDA7CF3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjJSJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345034AbjJSJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:26:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB526106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UlxhvUEUF3jyB3xsMCTtxKubVCjk9HjCcypqzOC3zrM=; b=PIMGnUSv9gxzl+YwuJSeyVfXtq
        N3a+gPgY4M49fvWiariT6/2tZ6wjPoG0dc9Vt1U9sDm9LLUxYSyNEPzOI4fj0enRZPvL6CV0wgPdK
        w/WXE884xeJMm5gDtw0ddV5Oy9A3LG32HhTtN2HNv+Rgs261t07eI1VrxDIRlKOF0BWvRivEvf/cb
        YccBQ2CCb06GHBhKB581+ynnCHXMxGw9LtfrlbpHFwWBLqL1VF4lSC4Rke7LiGkanK22b8A89Spbj
        ecw5AxGVzn8+S6+VjfePpn4Ck9s2nSvqmn1+htAW5cVKMsn1iycG4goYMWkTSxc7oOjcz+H/L3S8M
        XF86vp5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtPFm-009kcL-0r;
        Thu, 19 Oct 2023 09:25:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E53E300585; Thu, 19 Oct 2023 11:23:41 +0200 (CEST)
Date:   Thu, 19 Oct 2023 11:23:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019092341.GE36211@noisy.programming.kicks-ass.net>
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

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index c3b0d15a9841..1e80a551a4c2 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -676,6 +676,21 @@ void intel_pmu_lbr_del(struct perf_event *event)
>  	WARN_ON_ONCE(cpuc->lbr_users < 0);
>  	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
>  	perf_sched_cb_dec(event->pmu);
> +
> +	/*
> +	 * The logged occurrences information is only valid for the
> +	 * current LBR group. If another LBR group is scheduled in
> +	 * later, the information from the stale LBRs will be wrongly
> +	 * interpreted. Reset the LBRs here.
> +	 * For the context switch, the LBR will be unconditionally
> +	 * flushed when a new task is scheduled in. If both the new task
> +	 * and the old task are monitored by a LBR event group. The
> +	 * reset here is redundant. But the extra reset doesn't impact
> +	 * the functionality. It's hard to distinguish the above case.
> +	 * Keep the unconditionally reset for a LBR event group for now.
> +	 */

I found this really hard to read, also should this not rely on
!cpuc->lbr_users ?

As is, you'll reset the lbr for every event in the group.

> +	if (is_branch_counters_group(event))
> +		intel_pmu_lbr_reset();
>  }
