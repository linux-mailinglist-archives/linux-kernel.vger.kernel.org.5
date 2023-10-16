Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4867CA1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJPImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:42:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9037BA1;
        Mon, 16 Oct 2023 01:42:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86BB1FB;
        Mon, 16 Oct 2023 01:42:50 -0700 (PDT)
Received: from [10.57.1.186] (unknown [10.57.1.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3C63F5A1;
        Mon, 16 Oct 2023 01:42:07 -0700 (PDT)
Message-ID: <ace45602-2d25-77fe-6cc6-08d43c6bc671@arm.com>
Date:   Mon, 16 Oct 2023 09:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 RESEND 2/2] perf cs-etm: Respect timestamp option
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231014074159.1667880-1-leo.yan@linaro.org>
 <20231014074159.1667880-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231014074159.1667880-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2023 08:41, Leo Yan wrote:
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
>    # perf record -e cs_etm// --per-thread --timestamp -- ls
>    # perf script --header-only
>    ...
>    # event : name = cs_etm//, , id = { 69 }, type = 12, size = 136,
>    config = 0, { sample_period, sample_freq } = 1,
>    sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
>    disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
>    ...
> 
> After:
> 
>    # perf record -e cs_etm// --per-thread --timestamp -- ls
>    # perf script --header-only
>    ...
>    # event : name = cs_etm//, , id = { 49 }, type = 12, size = 136,
>    config = 0x10000000, { sample_period, sample_freq } = 1,
>    sample_type = IP|TID|TIME|CPU|IDENTIFIER, read_format = ID|LOST,
>    disabled = 1, enable_on_exec = 1, sample_id_all = 1, exclude_guest = 1
>    ...
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   tools/perf/arch/arm/util/cs-etm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index cf9ef9ba800b..58c506e9788d 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -442,6 +442,15 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>   					   "contextid", 1);
>   	}
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
>   	/* Add dummy event to keep tracking */
>   	err = parse_event(evlist, "dummy:u");
>   	if (err)

