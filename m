Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9816C79B05D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjIKV6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbjIKNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:24:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E9AE12A;
        Mon, 11 Sep 2023 06:24:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B530BD75;
        Mon, 11 Sep 2023 06:24:59 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB0F3F766;
        Mon, 11 Sep 2023 06:24:20 -0700 (PDT)
Message-ID: <04823db9-ed6c-0695-b9de-5a63bfa0aa5a@arm.com>
Date:   Mon, 11 Sep 2023 14:24:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] perf cs-etm: Fix kernel timestamp handling
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
References: <20230910092413.53538-1-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
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
In-Reply-To: <20230910092413.53538-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2023 10:24, Leo Yan wrote:
> The timestamp can originate from two sources: the kernel timestamp,
> which is recorded in the event PERF_RECORD_AUX, and the Arm CoreSight
> hardware trace data.  On some Arm platforms, CoreSight trace data fails
> to support timestamp tracing.  This can be due to either a missed
> connection between the timer counter and Arm CoreSight or the absence
> of support for the virtual timestamp.  If Arm CoreSight fails to support
> hardware timestamp tracing, we need to fall back on using the kernel
> timestamp.
> 
> The current code can support both timestamp sources when synthesizing
> samples. However, the decoding flow only relies on the hardware
> timestamp.  If the hardware timestamp is zero, it becomes impossible to
> decode the trace data.  Consequently, in this case, the commands below
> won't output any samples:
> 
>     perf record -e cs_etm// --per-thread --timestamp -- ls
>     perf script

Hi Leo,

I couldn't reproduce this issue, even when hard coding the hardware
timestamp to zero in cs_etm_decoder__do_hard_timestamp() like this:

 converted_timestamp = 0;

I'm not sure why this would result in no samples being generated either,
because we don't actually use the timestamps for anything yet [1]. We
always wait until the very end of the file before decoding to ensure
that all of the mmaps are loaded. And the timestamp is just assigned to
the samples, but they shouldn't affect whether they are generated or not.

Unless there is something else I'm missing?

Also, in cs_etm__queue_first_cs_timestamp(), cs_timestamp is used for
sorting the decoding order between CPUs, but if the hardware timestamp
is 0, then it's 0 on all trace. So the sorting would be the same if you
change that to be the kernel timestamp. They're all still the same
static number, but just a different number (because we wait until the
end of the file, 'latest_kernel_timestamp' is always the timestamp of
the last AUX event in the file).

[1]: I still plan to change the decoding to decode up to the current
time in the file, rather than waiting for the end of the file before
starting. That way decoding trace when there were overlapping mmap
regions in time will be more accurate.

Thanks
James

> 
> To fix this issue, this patch unifies the method of resolving time:
> 
> 1) It renames cs_etm__resolve_sample_time() to the more general name
>    cs_etm__resolve_time();
> 2) It changes the function argument type from 'cs_etm_traceid_queue' to
>    'cs_etm_packet_queue';
> 3) In the end, both the decoding flow and the assignment of timestamps
>    to samples call cs_etm__resolve_time() to obtain timestamp.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 9729d006550d..fa88e731933d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -400,6 +400,17 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>  	etmq->pending_timestamp_chan_id = trace_chan_id;
>  }
>  
> +static u64 cs_etm__resolve_time(struct cs_etm_queue *etmq,
> +				struct cs_etm_packet_queue *packet_queue)
> +{
> +	struct cs_etm_auxtrace *etm = etmq->etm;
> +
> +	if (!etm->timeless_decoding && etm->has_virtual_ts)
> +		return packet_queue->cs_timestamp;
> +	else
> +		return etm->latest_kernel_timestamp;
> +}
> +
>  static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
>  				      u8 *trace_chan_id)
>  {
> @@ -419,8 +430,7 @@ static u64 converted_timestamp = 0;(struct cs_etm_queue *etmq,
>  	/* Acknowledge pending status */
>  	etmq->pending_timestamp_chan_id = 0;
>  
> -	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
> -	return packet_queue->cs_timestamp;
> +	return cs_etm__resolve_time(etmq, packet_queue);
>  }
>  
>  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
> @@ -1434,18 +1444,6 @@ u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
>  		return cs_timestamp;
>  }
>  
> -static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
> -					       struct cs_etm_traceid_queue *tidq)
> -{
> -	struct cs_etm_auxtrace *etm = etmq->etm;
> -	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
> -
> -	if (!etm->timeless_decoding && etm->has_virtual_ts)
> -		return packet_queue->cs_timestamp;
> -	else
> -		return etm->latest_kernel_timestamp;
> -}
> -
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  					    struct cs_etm_traceid_queue *tidq,
>  					    u64 addr, u64 period)
> @@ -1454,13 +1452,14 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	struct cs_etm_auxtrace *etm = etmq->etm;
>  	union perf_event *event = tidq->event_buf;
>  	struct perf_sample sample = {.ip = 0,};
> +	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
>  
>  	event->sample.header.type = PERF_RECORD_SAMPLE;
>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr, tidq->el);
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
>  	/* Set time field based on etm auxtrace config. */
> -	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
> +	sample.time = cs_etm__resolve_time(etmq, packet_queue);
>  
>  	sample.ip = addr;
>  	sample.pid = thread__pid(tidq->thread);
> @@ -1505,6 +1504,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	struct cs_etm_auxtrace *etm = etmq->etm;
>  	struct perf_sample sample = {.ip = 0,};
>  	union perf_event *event = tidq->event_buf;
> +	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
>  	struct dummy_branch_stack {
>  		u64			nr;
>  		u64			hw_idx;
> @@ -1520,7 +1520,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>  	event->sample.header.size = sizeof(struct perf_event_header);
>  
>  	/* Set time field based on etm auxtrace config. */
> -	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
> +	sample.time = cs_etm__resolve_time(etmq, packet_queue);
>  
>  	sample.ip = ip;
>  	sample.pid = thread__pid(tidq->prev_packet_thread);
