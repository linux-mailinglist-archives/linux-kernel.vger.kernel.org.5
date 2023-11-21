Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B997F32F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjKUP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjKUP7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:59:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D9139
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700582347; x=1732118347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P6HcNX+jdIWSaxjwmIVYFvKSrRGelBv2vGjlF+Zi26g=;
  b=LbbMfYQv+/nDO71S7boA2sYPZpkWRZGjJVp1nNIboacyGoN36AYjzvrt
   yhfvxN3s9clYieGkPLdnr1KnWlwN+F+AIxEm4CzYLGrnrJ54BjQT/nARC
   U/Wx9NyTu8naRJj9EPPTLsRHIy2D459PunrwCQ14m9fonxOPGoCpB5Tsz
   UOjoyPpbG1k2yxdCMCvPDCLIvGNW//SkOF4r4/PPbmmZOC2xqhLy+G//G
   8Cq+G1U7jVDF8CEaAIswffcyXuCELrp/wtSdE3ZTazpFqx3eLM6sXj5BI
   LqDRmpOd2jb+1DON4F/YgEQQm/SoeX5QqWPN1qfqH21tLcsNTyBKYhPWF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="456202067"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="456202067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="14556196"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 07:59:07 -0800
Received: from [10.209.157.143] (kliang2-mobl1.ccr.corp.intel.com [10.209.157.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 485AF580689;
        Tue, 21 Nov 2023 07:59:06 -0800 (PST)
Message-ID: <66f74af2-21b6-477b-ada1-a8816ee115dc@linux.intel.com>
Date:   Tue, 21 Nov 2023 10:59:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/x86: Add CAP_NO_INTERRUPT for uncore PMUs
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Mingwei Zhang <mizhang@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
 <20231120221932.213710-3-namhyung@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231120221932.213710-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-20 5:19 p.m., Namhyung Kim wrote:
> It doesn't support sampling in uncore PMU events.  While it's
> technically possible to generate interrupts, let's treat it as if it
> has no interrupt in order to skip the freq adjust/unthrottling logic
> in the timer handler which is only meaningful to sampling events.
> 
> Also remove the sampling event check because it'd be done in the general
> code in the perf_event_open syscall.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/x86/events/intel/uncore.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 69043e02e8a7..f7e6228bd1b1 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -744,10 +744,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
>  	if (pmu->func_id < 0)
>  		return -ENOENT;
>  
> -	/* Sampling not supported yet */
> -	if (hwc->sample_period)
> -		return -EINVAL;
> -
>  	/*
>  	 * Place all uncore events for a particular physical package
>  	 * onto a single cpu
> @@ -919,7 +915,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>  			.stop		= uncore_pmu_event_stop,
>  			.read		= uncore_pmu_event_read,
>  			.module		= THIS_MODULE,
> -			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			/*
> +			 * It doesn't allow sampling for uncore events, let's
> +			 * treat the PMU has no interrupts to skip them in the
> +			 * perf_adjust_freq_unthr_context().
> +			 */
> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
>  			.attr_update	= pmu->type->attr_update,
>  		};


There is a special customized uncore PMU which needs the flag as well.

diff --git a/arch/x86/events/intel/uncore_snb.c
b/arch/x86/events/intel/uncore_snb.c
index 7fd4334e12a1..46a63e291975 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1013,7 +1013,7 @@ static struct pmu snb_uncore_imc_pmu = {
        .start          = uncore_pmu_event_start,
        .stop           = uncore_pmu_event_stop,
        .read           = uncore_pmu_event_read,
-       .capabilities   = PERF_PMU_CAP_NO_EXCLUDE,
+       .capabilities   = PERF_PMU_CAP_NO_EXCLUDE |
PERF_PMU_CAP_NO_INTERRUPT,
 };

 static struct intel_uncore_ops snb_uncore_imc_ops = {


Thanks,
Kan
>  	} else {
