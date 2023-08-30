Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490B178DEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbjH3UMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbjH3UMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:12:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD725713;
        Wed, 30 Aug 2023 13:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F81614F4;
        Wed, 30 Aug 2023 20:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0812C433C8;
        Wed, 30 Aug 2023 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693425946;
        bh=Eu3JeiLn+FdyhYJ/++T3ZVdqOXcLMXgLEZgEz6BHieA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqYDMw/MCglscuBHNP78cT02H+fs6j1JpxS65Cj3ODCLBe36rO9JckrsJunt0Qacu
         AO/apusZwQJSTYpQ/IMbVXDDTpGD5dUR8BYcCL9Z3DsSqrKlbrSwzB1Wh8iEvCuUV8
         pJIjrkuiXALYEIUzIJkA9taf01+R1ipl682TJq/cM0W4+b8DUPTIPFEe66YprEk8r/
         Zxighd+54d8kHL6uJPchjuhyLA8Sfrw+xbas4qmXwQn2O1fhppG085uXl3/HVFunLT
         lX+ZprecWin2GWYrltPe4U5VPi6tiZnrOe3pWxHozm7X71HupiRVpp4oO9BYnEUeHS
         AWca8XgTxGnRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA5B540722; Wed, 30 Aug 2023 17:05:42 -0300 (-03)
Date:   Wed, 30 Aug 2023 17:05:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1] perf vendor events intel: Fix modifier in
 tma_info_system_mem_parallel_reads
Message-ID: <ZO+hFsYc3rYd5rDM@kernel.org>
References: <20230830175543.1911892-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830175543.1911892-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 30, 2023 at 10:55:43AM -0700, Ian Rogers escreveu:
> The metric is using the wrong format encoding. This fix is in the
> converter script PR: https://github.com/intel/perfmon/pull/101

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> index 94cb38540b5a..2795a404bb58 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
> @@ -923,7 +923,7 @@
>      },
>      {
>          "BriefDescription": "Average number of parallel data read requests to external memory",
> -        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ@thresh\\=1@",
> +        "MetricExpr": "UNC_ARB_TRK_OCCUPANCY.DATA_READ / UNC_ARB_TRK_OCCUPANCY.DATA_READ@cmask\\=1@",
>          "MetricGroup": "Mem;MemoryBW;SoC",
>          "MetricName": "tma_info_system_mem_parallel_reads",
>          "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches"
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 

-- 

- Arnaldo
