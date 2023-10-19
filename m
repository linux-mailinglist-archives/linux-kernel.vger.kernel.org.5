Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD97CF562
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjJSKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345286AbjJSKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:31:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2604CFA;
        Thu, 19 Oct 2023 03:31:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 567752F4;
        Thu, 19 Oct 2023 03:32:04 -0700 (PDT)
Received: from [10.57.67.150] (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25EDC3F5A1;
        Thu, 19 Oct 2023 03:31:18 -0700 (PDT)
Message-ID: <1bef7744-78ef-f673-a33b-6f8fb00e033b@arm.com>
Date:   Thu, 19 Oct 2023 11:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] perf auxtrace: Add 'T' itrace option for timestamp
 trace
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
 <20231014074513.1668000-2-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231014074513.1668000-2-leo.yan@linaro.org>
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
> An AUX trace can contain timestamp, but in some situations, the hardware
> trace module (e.g. Arm CoreSight) cannot decide the traced timestamp is
> the same source with CPU's time, thus the decoder can not use the
> timestamp trace for samples.
> 
> This patch introduces 'T' itrace option. If users know the platforms
> they are working on have the same time counter with CPUs, users can
> use this new option to tell a decoder for using timestamp trace as
> kernel time.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/Documentation/itrace.txt | 1 +
>  tools/perf/util/auxtrace.c          | 3 +++
>  tools/perf/util/auxtrace.h          | 3 +++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> index a97f95825b14..19cc179be9a7 100644
> --- a/tools/perf/Documentation/itrace.txt
> +++ b/tools/perf/Documentation/itrace.txt
> @@ -25,6 +25,7 @@
>  		q	quicker (less detailed) decoding
>  		A	approximate IPC
>  		Z	prefer to ignore timestamps (so-called "timeless" decoding)
> +		T	use the timestamp trace as kernel time
>  

Maybe "Treat hardware timestamps as kernel time (trace and CPU time use
same clock source)" would be clearer.

And another point, although this isn't really related to this patch, but
why do we have the single letter arguments for itrace? It seems like it
massively restricts the available options and makes the command lines
hard to read because they don't have long forms. Why not just have them
as normal arguments?

If it's a backwards compatibility thing, would there be any objection to
adding this new option as a normal one rather than an itrace one?

>  	The default is all events i.e. the same as --itrace=iybxwpe,
>  	except for perf script where it is --itrace=ce
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a0368202a746..f528c4364d23 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1638,6 +1638,9 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>  		case 'Z':
>  			synth_opts->timeless_decoding = true;
>  			break;
> +		case 'T':
> +			synth_opts->use_timestamp = true;
> +			break;
>  		case ' ':
>  		case ',':
>  			break;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 29eb82dff574..55702215a82d 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -99,6 +99,7 @@ enum itrace_period_type {
>   * @remote_access: whether to synthesize remote access events
>   * @mem: whether to synthesize memory events
>   * @timeless_decoding: prefer "timeless" decoding i.e. ignore timestamps
> + * @use_timestamp: use the timestamp trace as kernel time
>   * @vm_time_correlation: perform VM Time Correlation
>   * @vm_tm_corr_dry_run: VM Time Correlation dry-run
>   * @vm_tm_corr_args:  VM Time Correlation implementation-specific arguments
> @@ -146,6 +147,7 @@ struct itrace_synth_opts {
>  	bool			remote_access;
>  	bool			mem;
>  	bool			timeless_decoding;
> +	bool			use_timestamp;

And then this one could be like "hw_time_is_kernel_time", but I'm
stuggling to think of something shorter. Maybe your one is fine along
with the comment.

