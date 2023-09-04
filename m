Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ACE791A93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbjIDPZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIDPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:25:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D6F2132;
        Mon,  4 Sep 2023 08:25:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D5B6143D;
        Mon,  4 Sep 2023 08:26:18 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99AD3F738;
        Mon,  4 Sep 2023 08:25:37 -0700 (PDT)
Message-ID: <2a7f6d40-6502-d389-f691-488e3d9b9005@arm.com>
Date:   Mon, 4 Sep 2023 16:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 2/2] perf cs-etm: Respect timestamp option
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20230827133557.112494-1-leo.yan@linaro.org>
 <20230827133557.112494-3-leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230827133557.112494-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/08/2023 14:35, Leo Yan wrote:
> When users pass the option '--timestamp' or '-T' in the record command,
> all events will set the PERF_SAMPLE_TIME bit in the attribution.  In
> this case, the AUX event will record the kernel timestamp, but it
> doesn't mean Arm CoreSight enables timestamp packets in its hardware
> tracing.
> 
> If the option '--timestamp' or '-T' is set, this patch always enables
> Arm CoreSight timestamp, as a result, the bit 28 in event's config is to
> be set.
> 
> Before:
> 
>   # perf record -e cs_etm// --per-thread --timestamp -- ls
>   # perf script --header-only
>   ...
>   # event : name = cs_etm//, , id = { 69 }, type = 12, size = 136,
>   config = 0, { sample_period, sample_freq } = 1,
>   sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
>   disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
>   ...
> 
> After:
> 
>   # perf record -e cs_etm// --per-thread --timestamp -- ls
>   # perf script --header-only
>   ...
>   # event : name = cs_etm//, , id = { 49 }, type = 12, size = 136,
>   config = 0x10000000, { sample_period, sample_freq } = 1,
>   sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
>   disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
>   ...
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: James Clark <james.clark@arm.com>

> ---
>  tools/perf/arch/arm/util/cs-etm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index cf9ef9ba800b..58c506e9788d 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -442,6 +442,15 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  					   "contextid", 1);
>  	}
>  
> +	/*
> +	 * When the option '--timestamp' or '-T' is enabled, the PERF_SAMPLE_TIME
> +	 * bit is set for all events.  In this case, always enable Arm CoreSight
> +	 * timestamp tracing.
> +	 */
> +	if (opts->sample_time_set)
> +		evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
> +					   "timestamp", 1);
> +
>  	/* Add dummy event to keep tracking */
>  	err = parse_event(evlist, "dummy:u");
>  	if (err)
