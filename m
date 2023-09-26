Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29C7AEEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjIZOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjIZOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:02:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3349EE9;
        Tue, 26 Sep 2023 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695736935; x=1727272935;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dqAsD4YwmO63PA4EBl0Q7yGf2RDjmodakBpSYqm7jyo=;
  b=HB5LexjJKj7wpv3Dl5+0lq53T6DpdsDtxmTjzxij46EoxXiVqwSESSXa
   UcYYB5EkWTVY00Kp6ZRcU65Vnl9CsDXYm7VPCyQYePcJxg/9YP/OjhlsC
   u+2Hzqw0E12ro0srjGfywnQaFPX14+fqto1vyDsGcOgNfeH/jPU5W5VZt
   /5J9JKkOCnvxMFvXhpRIhPwRjAMF+d8ALzL1K2+RNcR25f7vQYCFobO1Z
   HqbIqE7HMSDdoZs5c/2HToI2pRMtxzZkzbWZMrHozMTCdlgZhG1nHwGvo
   kXurHI2MiXnPWey0zLfCVJlK3We0HsL7Waqw4PloKVTtpKfkPLqybH839
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445700650"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445700650"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="157280"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 07:01:40 -0700
Received: from [10.209.130.196] (kliang2-mobl1.ccr.corp.intel.com [10.209.130.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DB55F580DAC;
        Tue, 26 Sep 2023 07:02:08 -0700 (PDT)
Message-ID: <f4b23e81-9a49-a3ba-d666-4b8f90e9720c@linux.intel.com>
Date:   Tue, 26 Sep 2023 10:02:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] perf vendor events intel: Fix broadwellde
 tma_info_system_dram_bw_use metric
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
References: <20230926031034.1201145-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230926031034.1201145-1-irogers@google.com>
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



On 2023-09-25 11:10 p.m., Ian Rogers wrote:
> Broadwell-de has a consumer core and server uncore. 

Besides this one, compared with the bdx-metrics.json, there is one
uncore metrics missed in the bdwde-metrics.json, uncore_frequency.

> The uncore_arb PMU
> isn't present and the broadwellx style cbox PMU should be used
> instead. Fix the tma_info_system_dram_bw_use metric to use the server
> metric rather than client.>
> The associated converter script fix is in:
> https://github.com/intel/perfmon/pull/111
> 
> Fixes: 7d124303d620 ("perf vendor events intel: Update broadwell variant events/metrics")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>  tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> index 8fc62b8f667d..d0ef46c9bb61 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> @@ -652,7 +652,7 @@
>      },
>      {
>          "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> -        "MetricExpr": "64 * (arb@event\\=0x81\\,umask\\=0x1@ + arb@event\\=0x84\\,umask\\=0x1@) / 1e6 / duration_time / 1e3",
> +        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e9 / duration_time",
>          "MetricGroup": "HPC;Mem;MemoryBW;SoC;tma_issueBW",
>          "MetricName": "tma_info_system_dram_bw_use",
>          "PublicDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth, tma_sq_full"
