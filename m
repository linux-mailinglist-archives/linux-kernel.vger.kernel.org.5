Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C87F2FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjKUNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:52:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA5D6F;
        Tue, 21 Nov 2023 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700574752; x=1732110752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nKvIk90rjbpOesN0GkWDLTjTMmHVHeY5G6qeYk14C4g=;
  b=ME5CypEpdwocmfxswsfCjeuCszy/yPaDWFAQdbnmCN0xzrqEWNNvhxzx
   Qnd9wEiEXbnWbWYQFFYnIgWJd5KOajoOzIarQmbQCfzu0m4H+EPKNI2+N
   yEtvdM+QeTMUoj4DHDrrRb2MYukWRJgodwBNv2mepjnD9eZymzd41AVCF
   HfcUYRsA4aphbH1kJqjjf7fieok7OGHYL53HMtvFS8OAXr3spMy3Pwbgg
   4WEgECDX5qQEaG6KTzN0Tg4Z/U2+jAWq1nRFA7Jv43GkwRmktOPIEev/y
   HASwGQDqDGSrAz4/lnLsszaCFpWYuka6ylcmyfDEefUo5lomKdgacjh0l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="456176834"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="456176834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 05:52:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801531928"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="801531928"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 05:52:32 -0800
Received: from [10.209.157.143] (smittai-mobl1.amr.corp.intel.com [10.209.157.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 29919580689;
        Tue, 21 Nov 2023 05:52:31 -0800 (PST)
Message-ID: <d409d76f-cbd9-42ba-a492-c0cdd23e88da@linux.intel.com>
Date:   Tue, 21 Nov 2023 08:52:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Correct wrong 'or' operation for pmu
 capabilities
Content-Language: en-US
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@intel.com>, stable@vger.kernel.org
References: <20231121014628.729989-1-dapeng1.mi@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231121014628.729989-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-20 8:46 p.m., Dapeng Mi wrote:
> When running perf-stat command on Intel hybrid platform, perf-stat
> reports the following errors.
> 
> sudo taskset -c 7 ./perf stat -vvvv -e cpu_atom/instructions/ sleep 1
> 
> Opening: cpu/cycles/:HG
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   config                           0xa00000000
>   disabled                         1
> ------------------------------------------------------------
> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -16
> 
>  Performance counter stats for 'sleep 1':
> 
>      <not counted>      cpu_atom/instructions/
> 
> It looks the cpu_atom/instructions/ event can't be enabled on atom pmu
> even the process is pinned on atom core. The investigation shows that
> exclusive_event_init() helper always returns -EBUSY error in the perf
> event creation. That's strange since the atom pmu should not be a
> exclusive PMU.
> 
> Further investigation shows the issue is introduced by commit 97588df87b56
> ("perf/x86/intel: Add common intel_pmu_init_hybrid()"). The commit
> originally intents to clear the bit PERF_PMU_CAP_AUX_OUTPUT from pmu
> capabilities if intel_cap.pebs_output_pt_available is not set, but it
> incorrectly uses 'or' operation and leads to all pmu capabilities bits
> are set to 1 except bit PERF_PMU_CAP_AUX_OUTPUT.
> 
> Testing this fix on Intel hybrid platforms, the observed issues
> disappear.
> 
> Fixes: 97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a08f794a0e79..ce1c777227b4 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4660,7 +4660,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
>  	if (pmu->intel_cap.pebs_output_pt_available)
>  		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
>  	else
> -		pmu->pmu.capabilities |= ~PERF_PMU_CAP_AUX_OUTPUT;
> +		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
>  
>  	intel_pmu_check_event_constraints(pmu->event_constraints,
>  					  pmu->num_counters,
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
