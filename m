Return-Path: <linux-kernel+bounces-7358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECA981A681
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B1DB24378
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881747F5F;
	Wed, 20 Dec 2023 17:41:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED9A47A67;
	Wed, 20 Dec 2023 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543901FB;
	Wed, 20 Dec 2023 09:41:56 -0800 (PST)
Received: from [10.57.46.64] (unknown [10.57.46.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C155C3F64C;
	Wed, 20 Dec 2023 09:41:08 -0800 (PST)
Message-ID: <7023e9fb-0bde-4a17-aa9e-e29e6b8b4bf1@arm.com>
Date: Wed, 20 Dec 2023 17:41:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V2 1/4] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Content-Language: en-GB
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
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
 linux-perf-users@vger.kernel.org
References: <20231208172449.35444-1-adrian.hunter@intel.com>
 <20231208172449.35444-2-adrian.hunter@intel.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231208172449.35444-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2023 17:24, Adrian Hunter wrote:
> Hardware traces, such as instruction traces, can produce a vast amount of
> trace data, so being able to reduce tracing to more specific circumstances
> can be useful.
> 
> The ability to pause or resume tracing when another event happens, can do
> that.
> 
> Add ability for an event to "pause" or "resume" AUX area tracing.
> 
> Add aux_pause bit to perf_event_attr to indicate that, if the event
> happens, the associated AUX area tracing should be paused. Ditto
> aux_resume. Do not allow aux_pause and aux_resume to be set together.
> 
> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
> event that it should start in a "paused" state.
> 
> Add aux_paused to struct perf_event for AUX area events to keep track of
> the "paused" state. aux_paused is initialized to aux_start_paused.
> 
> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
> callbacks. Call as needed, during __perf_event_output(). Add
> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
> handler. Pause/resume in NMI context will miss out if it coincides with
> another pause/resume.
> 
> To use aux_pause or aux_resume, an event must be in a group with the AUX
> area event as the group leader.
> 
> Example (requires Intel PT and tools patches also):
> 
>   $ perf record --kcore -e '{intel_pt/aux-start-paused/k,syscalls:sys_enter_newuname/aux-resume/,syscalls:sys_exit_newuname/aux-pause/}' uname
>   Linux
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.041 MB perf.data ]
>   $ perf script --call-trace
>   uname    5712 [007]    83.855580930: name: 0x7ffd9dcebec0
>   uname    5712 [007]    83.855582518:  psb offs: 0
>   uname    5712 [007]    83.855582518:  cbr: 42 freq: 4205 MHz (150%)
>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])    debug_smp_processor_id
>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])    __x64_sys_newuname
>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])        down_read
>   uname    5712 [007]    83.855582723: ([kernel.kallsyms])            __cond_resched
>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])            preempt_count_add
>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])                in_lock_functions
>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])            preempt_count_sub
>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])        up_read
>   uname    5712 [007]    83.855582932: ([kernel.kallsyms])            preempt_count_add
>   uname    5712 [007]    83.855583348: ([kernel.kallsyms])                in_lock_functions
>   uname    5712 [007]    83.855583348: ([kernel.kallsyms])            preempt_count_sub
>   uname    5712 [007]    83.855583348: ([kernel.kallsyms])        _copy_to_user
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])    syscall_exit_to_user_mode
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])        syscall_exit_work
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])            perf_syscall_exit
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                debug_smp_processor_id
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                perf_trace_buf_alloc
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    perf_swevent_get_recursion_context
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                        debug_smp_processor_id
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    debug_smp_processor_id
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                perf_tp_event
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    perf_trace_buf_update
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                        tracing_gen_ctx_irq_test
>   uname    5712 [007]    83.855583557: ([kernel.kallsyms])                    perf_swevent_event
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                        __perf_event_account_interrupt
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                            __this_cpu_preempt_check
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                        perf_event_output_forward
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                            perf_event_aux_pause
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                ring_buffer_get
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    __rcu_read_lock
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    __rcu_read_unlock
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                pt_event_stop
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    debug_smp_processor_id
>   uname    5712 [007]    83.855583765: ([kernel.kallsyms])                                    debug_smp_processor_id
>   uname    5712 [007]    83.855583973: ([kernel.kallsyms])                                    native_write_msr
>   uname    5712 [007]    83.855583973: ([kernel.kallsyms])                                    native_write_msr
>   uname    5712 [007]    83.855584175: 0x0
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   include/linux/perf_event.h      | 15 +++++++
>   include/uapi/linux/perf_event.h | 11 ++++-
>   kernel/events/core.c            | 72 +++++++++++++++++++++++++++++++--
>   kernel/events/internal.h        |  1 +
>   4 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e85cd1c0eaf3..252c4aac3b79 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -291,6 +291,7 @@ struct perf_event_pmu_context;
>   #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
>   #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
> +#define PERF_PMU_CAP_AUX_PAUSE			0x0200
>   
>   struct perf_output_handle;
>   
> @@ -363,6 +364,8 @@ struct pmu {
>   #define PERF_EF_START	0x01		/* start the counter when adding    */
>   #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
>   #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
> +#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
> +#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
>   
>   	/*
>   	 * Adds/Removes a counter to/from the PMU, can be done inside a
> @@ -402,6 +405,15 @@ struct pmu {
>   	 *
>   	 * ->start() with PERF_EF_RELOAD will reprogram the counter
>   	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
> +	 *
> +	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
> +	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
> +	 * PERF_EF_RESUME.
> +	 *
> +	 * ->start() with PERF_EF_RESUME will start as simply as possible but
> +	 * only if the counter is not otherwise stopped. Will not overlap
> +	 * another ->start() with PERF_EF_RESUME nor ->stop() with
> +	 * PERF_EF_PAUSE.
>   	 */
>   	void (*start)			(struct perf_event *event, int flags);
>   	void (*stop)			(struct perf_event *event, int flags);
> @@ -797,6 +809,9 @@ struct perf_event {
>   	/* for aux_output events */
>   	struct perf_event		*aux_event;
>   
> +	/* for AUX area events */
> +	unsigned int			aux_paused;
> +
>   	void (*destroy)(struct perf_event *);
>   	struct rcu_head			rcu_head;
>   
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 39c6a250dd1b..437bc2a8d50c 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -507,7 +507,16 @@ struct perf_event_attr {
>   	__u16	sample_max_stack;
>   	__u16	__reserved_2;
>   	__u32	aux_sample_size;
> -	__u32	__reserved_3;
> +
> +	union {
> +		__u32	aux_output_cfg;
> +		struct {
> +			__u64	aux_pause        :  1, /* on overflow, pause AUX area tracing */

Did you mean __u32 ? Otherwise look good to me.

Suzuki

> +				aux_resume       :  1, /* on overflow, resume AUX area tracing */
> +				aux_start_paused :  1, /* start AUX area tracing paused */
> +				__reserved_3     : 29;
> +		};
> +	};
>   
>   	/*
>   	 * User provided data if sigtrap=1, passed back to user via
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..c1e11884d06e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2060,7 +2060,8 @@ static void perf_put_aux_event(struct perf_event *event)
>   
>   static bool perf_need_aux_event(struct perf_event *event)
>   {
> -	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
> +	return event->attr.aux_output || event->attr.aux_sample_size ||
> +	       event->attr.aux_pause || event->attr.aux_resume;
>   }
>   
>   static int perf_get_aux_event(struct perf_event *event,
> @@ -2085,6 +2086,10 @@ static int perf_get_aux_event(struct perf_event *event,
>   	    !perf_aux_output_match(event, group_leader))
>   		return 0;
>   
> +	if ((event->attr.aux_pause || event->attr.aux_resume) &&
> +	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
> +		return 0;
> +
>   	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
>   		return 0;
>   
> @@ -7773,6 +7778,47 @@ void perf_prepare_header(struct perf_event_header *header,
>   	WARN_ON_ONCE(header->size & 7);
>   }
>   
> +static void __perf_event_aux_pause(struct perf_event *event, bool pause)
> +{
> +	if (pause) {
> +		if (!READ_ONCE(event->aux_paused)) {
> +			WRITE_ONCE(event->aux_paused, 1);
> +			event->pmu->stop(event, PERF_EF_PAUSE);
> +		}
> +	} else {
> +		if (READ_ONCE(event->aux_paused)) {
> +			WRITE_ONCE(event->aux_paused, 0);
> +			event->pmu->start(event, PERF_EF_RESUME);
> +		}
> +	}
> +}
> +
> +static void perf_event_aux_pause(struct perf_event *event, bool pause)
> +{
> +	struct perf_buffer *rb;
> +	unsigned long flags;
> +
> +	if (WARN_ON_ONCE(!event))
> +		return;
> +
> +	rb = ring_buffer_get(event);
> +	if (!rb)
> +		return;
> +
> +	local_irq_save(flags);
> +	/* Guard against NMI, NMI loses here */
> +	if (READ_ONCE(rb->aux_in_pause_resume))
> +		goto out_restore;
> +	WRITE_ONCE(rb->aux_in_pause_resume, 1);
> +	barrier();
> +	__perf_event_aux_pause(event, pause);
> +	barrier();
> +	WRITE_ONCE(rb->aux_in_pause_resume, 0);
> +out_restore:
> +	local_irq_restore(flags);
> +	ring_buffer_put(rb);
> +}
> +
>   static __always_inline int
>   __perf_event_output(struct perf_event *event,
>   		    struct perf_sample_data *data,
> @@ -7786,6 +7832,9 @@ __perf_event_output(struct perf_event *event,
>   	struct perf_event_header header;
>   	int err;
>   
> +	if (event->attr.aux_pause)
> +		perf_event_aux_pause(event->aux_event, true);
> +
>   	/* protect the callchain buffers */
>   	rcu_read_lock();
>   
> @@ -7802,6 +7851,10 @@ __perf_event_output(struct perf_event *event,
>   
>   exit:
>   	rcu_read_unlock();
> +
> +	if (event->attr.aux_resume)
> +		perf_event_aux_pause(event->aux_event, false);
> +
>   	return err;
>   }
>   
> @@ -11941,10 +11994,23 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>   	}
>   
>   	if (event->attr.aux_output &&
> -	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
> +	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
> +	     event->attr.aux_pause || event->attr.aux_resume)) {
> +		err = -EOPNOTSUPP;
> +		goto err_pmu;
> +	}
> +
> +	if (event->attr.aux_pause && event->attr.aux_resume) {
> +		err = -EINVAL;
> +		goto err_pmu;
> +	}
> +
> +	if (event->attr.aux_start_paused &&
> +	    !(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
>   		err = -EOPNOTSUPP;
>   		goto err_pmu;
>   	}
> +	event->aux_paused = event->attr.aux_start_paused;
>   
>   	if (cgroup_fd != -1) {
>   		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
> @@ -12741,7 +12807,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
>   	 * Grouping is not supported for kernel events, neither is 'AUX',
>   	 * make sure the caller's intentions are adjusted.
>   	 */
> -	if (attr->aux_output)
> +	if (attr->aux_output || attr->aux_output_cfg)
>   		return ERR_PTR(-EINVAL);
>   
>   	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index 5150d5f84c03..3320f78117dc 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -51,6 +51,7 @@ struct perf_buffer {
>   	void				(*free_aux)(void *);
>   	refcount_t			aux_refcount;
>   	int				aux_in_sampling;
> +	int				aux_in_pause_resume;
>   	void				**aux_pages;
>   	void				*aux_priv;
>   


