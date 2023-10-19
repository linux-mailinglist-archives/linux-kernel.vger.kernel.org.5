Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFE77CF57A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjJSKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:39:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F31BFA;
        Thu, 19 Oct 2023 03:39:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E7802F4;
        Thu, 19 Oct 2023 03:39:44 -0700 (PDT)
Received: from [10.57.67.150] (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4E63F5A1;
        Thu, 19 Oct 2023 03:38:59 -0700 (PDT)
Message-ID: <dd55c313-632e-cf18-161a-50ac6632feb4@arm.com>
Date:   Thu, 19 Oct 2023 11:38:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 2/2] perf cs-etm: Enable itrace option 'T'
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
References: <20231014074513.1668000-1-leo.yan@linaro.org>
 <20231014074513.1668000-3-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231014074513.1668000-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/2023 08:45, Leo Yan wrote:
> Prior to Armv8.4, the feature FEAT_TRF is not supported by Arm CPUs.
> Consequently, the sysfs node 'ts_source' will not be set as 1 by the
> CoreSight ETM driver.  On the other hand, the perf tool relies on the
> 'ts_source' node to determine whether the kernel timestamp is traced.
> Since the 'ts_source' is not set for Arm CPUs prior to Armv8.4,
> platforms in this case cannot utilize the traced timestamp as the kernel
> time.
> 
> This patch enables the 'T' itrace option, which forcibly utilizes the
> traced timestamp as the kernel time.  If users are aware that their
> working platform's Arm CoreSight shares the same counter with the kernel
> time, they can specify 'T' option to decode the traced timestamp as the
> kernel time.
> 
> An usage example is:
> 
>   # perf record -e cs_etm// -- test_program
>   # perf script --itrace=i10ibT
>   # perf report --itrace=i10ibT
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 9729d006550d..4a37fdeb1795 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3322,12 +3322,27 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	etm->metadata = metadata;
>  	etm->auxtrace_type = auxtrace_info->type;
>  
> -	/* Use virtual timestamps if all ETMs report ts_source = 1 */
> -	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
> +	if (etm->synth_opts.use_timestamp)
> +		/*
> +		 * Prior to Armv8.4, Arm CPUs don't support FEAT_TRF feature,
> +		 * therefore the decoder cannot know if the timestamp trace is
> +		 * same with the kernel time.
> +		 *
> +		 * If a user has knowledge for the working platform and can
> +		 * specify itrace option 'T' to tell decoder to forcely use the
> +		 * traced timestamp as the kernel time.
> +		 */
> +		etm->has_virtual_ts = true;
> +	else
> +		/* Use virtual timestamps if all ETMs report ts_source = 1 */
> +		etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
>  
>  	if (!etm->has_virtual_ts)
>  		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n"
> -			    "The time field of the samples will not be set accurately.\n\n");
> +			    "The time field of the samples will not be set accurately.\n"
> +			    "For Arm CPUs prior to Armv8.4 or without support FEAT_TRF,\n"
> +			    "you can specify the itrace option 'T' for timestamp decoding\n"
> +			    "if the Coresight timestamp on the platform is same with the kernel time.\n\n");
>  
>  	etm->auxtrace.process_event = cs_etm__process_event;
>  	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;

Reviewed-by: James Clark <james.clark@arm.com>
