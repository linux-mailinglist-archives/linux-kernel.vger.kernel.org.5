Return-Path: <linux-kernel+bounces-17847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CA825385
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB821C22762
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0F22D612;
	Fri,  5 Jan 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2Fvg8e/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1A2D602;
	Fri,  5 Jan 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704459472; x=1735995472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/ONlmIj+I+ON03UVYVmeBsOko0ziG2wBt1EFzW6p0No=;
  b=D2Fvg8e/AmVXAOKQ89M59R5xh6K4ZnSBy4InYU0iDqkg/cKrBnlZWEeB
   +w2Op/zBnoXNfpsAofUBmrOw7X7SonyUDTHTBlWXZtehSDbHJd2Msz8La
   7mJSIXNpezkCkgTFzFSm+KGsJTmw110zLwITi0oaz80yrY8bkdJM+oQyk
   SruQVq4EgQGfEwRRuNmAqgiTtMPuNjVOJX5kdhaXugMS/7GXs5akWV0Z4
   2xyKzOQH1ctMOxRU9VxetxCBBjtnnimOgWnTDtu2SNC/ZYsgIcfqNQvkc
   ONtAWWH3anS8YTDqFsOvzOhTPaBx/yRd1ROq1mW/TGaQp6a+2AbpEXQWQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="16118660"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="16118660"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 04:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="851134406"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="851134406"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.83])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 04:57:45 -0800
Message-ID: <4ca142a7-f46e-4bf0-b32d-99b7955fc012@intel.com>
Date: Fri, 5 Jan 2024 14:57:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V2 1/4] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20231208172449.35444-1-adrian.hunter@intel.com>
 <20231208172449.35444-2-adrian.hunter@intel.com>
 <7023e9fb-0bde-4a17-aa9e-e29e6b8b4bf1@arm.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7023e9fb-0bde-4a17-aa9e-e29e6b8b4bf1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/12/23 19:41, Suzuki K Poulose wrote:
> On 08/12/2023 17:24, Adrian Hunter wrote:
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> Add ability for an event to "pause" or "resume" AUX area tracing.
>>
>> Add aux_pause bit to perf_event_attr to indicate that, if the event
>> happens, the associated AUX area tracing should be paused. Ditto
>> aux_resume. Do not allow aux_pause and aux_resume to be set together.
>>
>> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
>> event that it should start in a "paused" state.
>>
>> Add aux_paused to struct perf_event for AUX area events to keep track of
>> the "paused" state. aux_paused is initialized to aux_start_paused.
>>
>> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
>> callbacks. Call as needed, during __perf_event_output(). Add
>> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
>> handler. Pause/resume in NMI context will miss out if it coincides with
>> another pause/resume.
>>
>> To use aux_pause or aux_resume, an event must be in a group with the AUX
>> area event as the group leader.
>>
>> Example (requires Intel PT and tools patches also):
>>
>>   $ perf record --kcore -e '{intel_pt/aux-start-paused/k,syscalls:sys_enter_newuname/aux-resume/,syscalls:sys_exit_newuname/aux-pause/}' uname
>>   Linux
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.041 MB perf.data ]
>>   $ perf script --call-trace
>>   uname    5712 [007]    83.855580930: name: 0x7ffd9dcebec0
>>   uname    5712 [007]    83.855582518:  psb offs: 0
>>   uname    5712 [007]    83.855582518:  cbr: 42 freq: 4205 MHz (150%)
>>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])    debug_smp_processor_id
>>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])    __x64_sys_newuname
>>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])        down_read
>>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])            __cond_resched
>>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])            preempt_count_add
>>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])                in_lock_functions
>>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])            preempt_count_sub
>>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])        up_read
>>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])            preempt_count_add
>>   uname    5712 [007]    83.855583348: ([kernel.kallsyms])                in_lock_functions
>>   uname    5712 [007]    83.855583348: ([kernel.kallsyms])            preempt_count_sub
>>   uname    5712 [007]    83.855583348: ([kernel.kallsyms])        _copy_to_user
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])    syscall_exit_to_user_mode
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])        syscall_exit_work
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])            perf_syscall_exit
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                debug_smp_processor_id
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                perf_trace_buf_alloc
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    perf_swevent_get_recursion_context
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                        debug_smp_processor_id
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    debug_smp_processor_id
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                perf_tp_event
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    perf_trace_buf_update
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                        tracing_gen_ctx_irq_test
>>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    perf_swevent_event
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                        __perf_event_account_interrupt
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                            __this_cpu_preempt_check
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                        perf_event_output_forward
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                            perf_event_aux_pause
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                ring_buffer_get
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    __rcu_read_lock
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    __rcu_read_unlock
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                pt_event_stop
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    debug_smp_processor_id
>>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    debug_smp_processor_id
>>   uname    5712 [007]    83.855583973: ([kernel.kallsyms])                                    native_write_msr
>>   uname    5712 [007]    83.855583973: ([kernel.kallsyms])                                    native_write_msr
>>   uname    5712 [007]    83.855584175: 0x0
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>   include/linux/perf_event.h      | 15 +++++++
>>   include/uapi/linux/perf_event.h | 11 ++++-
>>   kernel/events/core.c            | 72 +++++++++++++++++++++++++++++++--
>>   kernel/events/internal.h        |  1 +
>>   4 files changed, 95 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index e85cd1c0eaf3..252c4aac3b79 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -291,6 +291,7 @@ struct perf_event_pmu_context;
>>   #define PERF_PMU_CAP_NO_EXCLUDE            0x0040
>>   #define PERF_PMU_CAP_AUX_OUTPUT            0x0080
>>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE        0x0100
>> +#define PERF_PMU_CAP_AUX_PAUSE            0x0200
>>     struct perf_output_handle;
>>   @@ -363,6 +364,8 @@ struct pmu {
>>   #define PERF_EF_START    0x01        /* start the counter when adding    */
>>   #define PERF_EF_RELOAD    0x02        /* reload the counter when starting */
>>   #define PERF_EF_UPDATE    0x04        /* update the counter when stopping */
>> +#define PERF_EF_PAUSE    0x08        /* AUX area event, pause tracing */
>> +#define PERF_EF_RESUME    0x10        /* AUX area event, resume tracing */
>>         /*
>>        * Adds/Removes a counter to/from the PMU, can be done inside a
>> @@ -402,6 +405,15 @@ struct pmu {
>>        *
>>        * ->start() with PERF_EF_RELOAD will reprogram the counter
>>        *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
>> +     *
>> +     * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
>> +     * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
>> +     * PERF_EF_RESUME.
>> +     *
>> +     * ->start() with PERF_EF_RESUME will start as simply as possible but
>> +     * only if the counter is not otherwise stopped. Will not overlap
>> +     * another ->start() with PERF_EF_RESUME nor ->stop() with
>> +     * PERF_EF_PAUSE.
>>        */
>>       void (*start)            (struct perf_event *event, int flags);
>>       void (*stop)            (struct perf_event *event, int flags);
>> @@ -797,6 +809,9 @@ struct perf_event {
>>       /* for aux_output events */
>>       struct perf_event        *aux_event;
>>   +    /* for AUX area events */
>> +    unsigned int            aux_paused;
>> +
>>       void (*destroy)(struct perf_event *);
>>       struct rcu_head            rcu_head;
>>   diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 39c6a250dd1b..437bc2a8d50c 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -507,7 +507,16 @@ struct perf_event_attr {
>>       __u16    sample_max_stack;
>>       __u16    __reserved_2;
>>       __u32    aux_sample_size;
>> -    __u32    __reserved_3;
>> +
>> +    union {
>> +        __u32    aux_output_cfg;
>> +        struct {
>> +            __u64    aux_pause        :  1, /* on overflow, pause AUX area tracing */
> 
> Did you mean __u32 ? Otherwise look good to me.

True, thanks!


