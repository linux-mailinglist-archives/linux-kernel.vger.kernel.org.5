Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B01D7E2EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjKFVMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjKFVMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:12:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE0AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:12:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A7EC433C7;
        Mon,  6 Nov 2023 21:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699305148;
        bh=4FfF6FSoLzUKkH7FfpBirtFkvFkbBq8zo79wC88C5tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWPW6jofDuVjfYHlUYRkdq5N9sLOcuHq9uXkomd2dlACnm0/4PcS9lKTIEvU+OiBW
         13uaKqEK2ntMsmrHSK1PN+94wYJW8OfHXxHtU6iPpftCU3Nh3ati3LpOCUUsMQIj1E
         uLmah2vdP6Ou5yPIzI71EzKmN06c2MncNt+ickiUaC6AOsXjHeVqmNAKShQNbH6Mtc
         O5c1R2mvYd8YmyymL1Anlmau1sDTjq/X8eEpK4EIk1Z6+lDRAN6555Ab1TF87ffYsW
         nsEJXeZmatCgEDpK5hAVAiOmD+uylQnc3+UqM4GFOPNd6msg76PlD6/Knq3ryeB1tw
         20ClMg7aC/p5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B8084035D; Mon,  6 Nov 2023 18:12:25 -0300 (-03)
Date:   Mon, 6 Nov 2023 18:12:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V5 2/8] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK
 flag
Message-ID: <ZUlWuROfYcYJlRn4@kernel.org>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
 <20231025201626.3000228-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025201626.3000228-2-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 25, 2023 at 01:16:20PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Currently, branch_sample_type !=0 is used to check whether a branch
> stack setup is required. But it doesn't check the sample type,
> unnecessary branch stack setup may be done for a counting event. E.g.,
> perf record -e "{branch-instructions,branch-misses}:S" -j any
> Also, the event only with the new PERF_SAMPLE_BRANCH_COUNTERS branch
> sample type may not require a branch stack setup either.
> 
> Add a new flag NEEDS_BRANCH_STACK to indicate whether the event requires
> a branch stack setup. Replace the needs_branch_stack() by checking the
> new flag.
> 
> The counting event check is implemented here. The later patch will take
> the new PERF_SAMPLE_BRANCH_COUNTERS into account.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> No changes since V4

So I saw this on tip/perf/urgent, I'm picking the tools bits then.

- Arnaldo
 
>  arch/x86/events/intel/core.c       | 14 +++++++++++---
>  arch/x86/events/perf_event_flags.h |  1 +
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 41a164764a84..a99449c0d77c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2527,9 +2527,14 @@ static void intel_pmu_assign_event(struct perf_event *event, int idx)
>  		perf_report_aux_output_id(event, idx);
>  }
>  
> +static __always_inline bool intel_pmu_needs_branch_stack(struct perf_event *event)
> +{
> +	return event->hw.flags & PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +}
> +
>  static void intel_pmu_del_event(struct perf_event *event)
>  {
> -	if (needs_branch_stack(event))
> +	if (intel_pmu_needs_branch_stack(event))
>  		intel_pmu_lbr_del(event);
>  	if (event->attr.precise_ip)
>  		intel_pmu_pebs_del(event);
> @@ -2820,7 +2825,7 @@ static void intel_pmu_add_event(struct perf_event *event)
>  {
>  	if (event->attr.precise_ip)
>  		intel_pmu_pebs_add(event);
> -	if (needs_branch_stack(event))
> +	if (intel_pmu_needs_branch_stack(event))
>  		intel_pmu_lbr_add(event);
>  }
>  
> @@ -3897,7 +3902,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  			x86_pmu.pebs_aliases(event);
>  	}
>  
> -	if (needs_branch_stack(event)) {
> +	if (needs_branch_stack(event) && is_sampling_event(event))
> +		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> +
> +	if (intel_pmu_needs_branch_stack(event)) {
>  		ret = intel_pmu_setup_lbr_filter(event);
>  		if (ret)
>  			return ret;
> diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
> index 1dc19b9b4426..a1685981c520 100644
> --- a/arch/x86/events/perf_event_flags.h
> +++ b/arch/x86/events/perf_event_flags.h
> @@ -20,3 +20,4 @@ PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
>  PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
>  PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
>  PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
> +PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
> -- 
> 2.35.1
> 

-- 

- Arnaldo
