Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD27FD44A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjK2Kem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK2JyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:54:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F23D2123;
        Wed, 29 Nov 2023 01:53:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CAD2F4;
        Wed, 29 Nov 2023 01:54:30 -0800 (PST)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986C23F5A1;
        Wed, 29 Nov 2023 01:53:40 -0800 (PST)
Message-ID: <c63808b2-2049-da18-f0af-5dff2bc87cd2@arm.com>
Date:   Wed, 29 Nov 2023 09:53:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 2/3] perf/x86/intel/pt: Add support for pause_resume()
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20231123121851.10826-1-adrian.hunter@intel.com>
 <20231123121851.10826-3-adrian.hunter@intel.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20231123121851.10826-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2023 12:18, Adrian Hunter wrote:
> Prevent tracing to start if aux_paused.
> 
> Implement pause_resume() callback. When aux_paused, stop tracing. When
> not aux_paused, only start tracing if it isn't currently meant to be
> stopped.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/events/intel/pt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 42a55794004a..aa883b64814a 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -418,6 +418,9 @@ static void pt_config_start(struct perf_event *event)
>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>  	u64 ctl = event->hw.config;
>  
> +	if (event->aux_paused)
> +		return;
> +
>  	ctl |= RTIT_CTL_TRACEEN;
>  	if (READ_ONCE(pt->vmx_on))
>  		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
> @@ -1563,6 +1566,14 @@ EXPORT_SYMBOL_GPL(intel_pt_handle_vmx);
>   * PMU callbacks
>   */
>  
> +static void pt_event_pause_resume(struct perf_event *event)
> +{
> +	if (event->aux_paused)
> +		pt_config_stop(event);
> +	else if (!event->hw.state)
> +		pt_config_start(event);
> +}

It seems like having a single pause/resume callback rather than separate
pause and resume ones pushes some of the event state management into the
individual drivers and would be prone to code duplication and divergent
behavior.

Would it be possible to move the conditions from here into the core code
and call separate functions instead?

> +
>  static void pt_event_start(struct perf_event *event, int mode)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> @@ -1798,6 +1809,7 @@ static __init int pt_init(void)
>  	pt_pmu.pmu.del			 = pt_event_del;
>  	pt_pmu.pmu.start		 = pt_event_start;
>  	pt_pmu.pmu.stop			 = pt_event_stop;
> +	pt_pmu.pmu.pause_resume		 = pt_event_pause_resume;

The general idea seems ok to me. Is there a reason to not use the
existing start() stop() callbacks, rather than adding a new one?

I assume it's intended to be something like an optimisation where you
can turn it on and off without having to do the full setup, teardown and
emit an AUX record because you know the process being traced never gets
switched out?

Could you make it so that it works out of the box, with the option of
later optimisation if you do something like this (not here but something
like this in events/core.c):

  /* Use specialised pause/resume if it exists, otherwise use more
   * expensive start/stop.
   */
  if (pmu->pause_resume)
	pmu->pause_resume(...)
  else
        pmu->stop(...)


>  	pt_pmu.pmu.snapshot_aux		 = pt_event_snapshot_aux;
>  	pt_pmu.pmu.read			 = pt_event_read;
>  	pt_pmu.pmu.setup_aux		 = pt_buffer_setup_aux;
