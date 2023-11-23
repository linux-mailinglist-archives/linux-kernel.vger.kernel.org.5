Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251AD7F5EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbjKWMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345278AbjKWMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:19:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B9A1B6;
        Thu, 23 Nov 2023 04:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700741958; x=1732277958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eVm6Qcu6ibP2mSqWgj5H5xz5zeq8ashdLYRfy2nUaY=;
  b=jkvIP56D2K7LP0vKWZ1iNWBNkgSbpPEPl3NlkPsC6WSs8KGNODmZcZP+
   5koHWbPWBN2YY0EjRYSfOFIlI/JZlykRMCCBWm6KrOqkXwV66WHSZXSfI
   nVVX2zx0xnKMDIcAN9VfJBCPZsks1T5GLVVe1ayqgXyOIEmsmW9HsOsyG
   1sZMPm3XiDdWE3rTiuXvRoQyCsMKrgJpIOnxZ9lLVkfhRpAiyt7SYdYbx
   3cCV7XKRdRmXbjHqNV/ZvcnJWuqsApxBgDKcWf8TqdkZE5c0p2r0inMLp
   5xNBKW5to407GqI7jieUoBqbQAfzN3blSBrfmmHtcmxzIhTEhnBVIkbdi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478456339"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="478456339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="890774787"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="890774787"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:19:12 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH RFC 1/3] perf/core: Add aux_pause, aux_resume, aux_start_paused
Date:   Thu, 23 Nov 2023 14:18:49 +0200
Message-Id: <20231123121851.10826-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123121851.10826-1-adrian.hunter@intel.com>
References: <20231123121851.10826-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

Add ability for an event to "pause" or "resume" AUX area tracing.

Add aux_pause bit to perf_event_attr to indicate that, if the event
happens, the associated AUX area tracing should be paused. Ditto
aux_resume. Do not allow aux_pause and aux_resume to be set together.

Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
event that it should start in a "paused" state.

Add aux_paused to struct perf_event for AUX area events to keep track of
the "paused" state. aux_paused is initialized to aux_start_paused.

Add pause_resume() callback to struct pmu to perform a pause or resume.
Whether to pause or resume is indicated by aux_paused. Call pause_resume()
as needed, during __perf_event_output(). Add aux_in_pause_resume to
struct perf_buffer to prevent races with the NMI handler. Pause/resume in
NMI context will miss out if it coinicides with another pause/resume.

To use aux_pause or aux_resume, an event must be in a group with the AUX
area event as the group leader.

Example (requires Intel PT and tools patches also):

 $ perf record --kcore -e '{intel_pt/aux-start-paused/k,syscalls:sys_enter_newuname/aux-resume/,syscalls:sys_exit_newuname/aux-pause/}' uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.041 MB perf.data ]
 $ perf script --call-trace
 uname    8866 [003]  1549.674345648: name: 0x7fff01491a90
 uname    8866 [003]  1549.674347393:  psb offs: 0
 uname    8866 [003]  1549.674347393:  cbr: 47 freq: 4705 MHz (168%)
 uname    8866 [003]  1549.674347556: ([kernel.kallsyms])        debug_smp_processor_id
 uname    8866 [003]  1549.674347556: ([kernel.kallsyms])        __x64_sys_newuname
 uname    8866 [003]  1549.674347556: ([kernel.kallsyms])            down_read
 uname    8866 [003]  1549.674347556: ([kernel.kallsyms])                __cond_resched
 uname    8866 [003]  1549.674347764: ([kernel.kallsyms])                preempt_count_add
 uname    8866 [003]  1549.674347764: ([kernel.kallsyms])                    in_lock_functions
 uname    8866 [003]  1549.674347764: ([kernel.kallsyms])                preempt_count_sub
 uname    8866 [003]  1549.674347764: ([kernel.kallsyms])            up_read
 uname    8866 [003]  1549.674347764: ([kernel.kallsyms])                preempt_count_add
 uname    8866 [003]  1549.674348181: ([kernel.kallsyms])                    in_lock_functions
 uname    8866 [003]  1549.674348181: ([kernel.kallsyms])                preempt_count_sub
 uname    8866 [003]  1549.674348181: ([kernel.kallsyms])            _copy_to_user
 uname    8866 [003]  1549.674348181: ([kernel.kallsyms])        syscall_exit_to_user_mode
 uname    8866 [003]  1549.674348181: ([kernel.kallsyms])            syscall_exit_work
 uname    8866 [003]  1549.674348181: ([kernel.kallsyms])                perf_syscall_exit
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                    debug_smp_processor_id
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                    perf_trace_buf_alloc
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                            debug_smp_processor_id
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                        debug_smp_processor_id
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                    perf_tp_event
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                        perf_trace_buf_update
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                        perf_swevent_event
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                            __perf_event_account_interrupt
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                __this_cpu_preempt_check
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                            perf_event_output_forward
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                perf_event_aux_pause.part.0
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                    ring_buffer_get
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                        __rcu_read_lock
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                        __rcu_read_unlock
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                    pt_event_pause_resume
 uname    8866 [003]  1549.674348389: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname    8866 [003]  1549.674348598: ([kernel.kallsyms])                                        native_write_msr
 uname    8866 [003]  1549.674348598: ([kernel.kallsyms])                                        native_write_msr
 uname    8866 [003]  1549.674348869: 0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/perf_event.h      |  9 +++++
 include/uapi/linux/perf_event.h | 13 ++++++-
 kernel/events/core.c            | 65 +++++++++++++++++++++++++++++++--
 kernel/events/internal.h        |  1 +
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e85cd1c0eaf3..1e09d537ff77 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -540,6 +540,12 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Pause or resume tracing. Used for AUX area tracing. event->aux_paused
+	 * indicates whether tracing should be paused, or otherwise resumed.
+	 */
+	void (*pause_resume)		(struct perf_event *event); /* optional */
 };
 
 enum perf_addr_filter_action_t {
@@ -797,6 +803,9 @@ struct perf_event {
 	/* for aux_output events */
 	struct perf_event		*aux_event;
 
+	/* for AUX area events */
+	unsigned int			aux_paused;
+
 	void (*destroy)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 39c6a250dd1b..1232e70adfba 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -456,7 +456,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				aux_start_paused :  1, /* start AUX area tracing paused */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -507,7 +508,15 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_output_cfg;
+		struct {
+			__u64	aux_pause      :  1, /* on overflow, pause AUX area tracing */
+				aux_resume     :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3   : 30;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c72a41f11af..8ec72f9153b7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2060,7 +2060,13 @@ static void perf_put_aux_event(struct perf_event *event)
 
 static bool perf_need_aux_event(struct perf_event *event)
 {
-	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
+	return event->attr.aux_output || event->attr.aux_output_cfg ||
+	       event->attr.aux_sample_size;
+}
+
+static bool has_aux_pause_resume(struct perf_event *event)
+{
+	return has_aux(event) && event->pmu->pause_resume;
 }
 
 static int perf_get_aux_event(struct perf_event *event,
@@ -2085,6 +2091,10 @@ static int perf_get_aux_event(struct perf_event *event,
 	    !perf_aux_output_match(event, group_leader))
 		return 0;
 
+	if ((event->attr.aux_pause || event->attr.aux_resume) &&
+	    !has_aux_pause_resume(group_leader))
+		return 0;
+
 	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
@@ -7773,6 +7783,36 @@ void perf_prepare_header(struct perf_event_header *header,
 	WARN_ON_ONCE(header->size & 7);
 }
 
+static void perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	struct perf_buffer *rb;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(!event))
+		return;
+
+	if ((pause && event->aux_paused) || (!pause && !event->aux_paused))
+		return;
+
+	rb = ring_buffer_get(event);
+	if (!rb)
+		return;
+
+	local_irq_save(flags);
+	/* Guard against NMI, NMI loses here */
+	if (READ_ONCE(rb->aux_in_pause_resume))
+		goto out_restore;
+	WRITE_ONCE(rb->aux_in_pause_resume, 1);
+	barrier();
+	event->aux_paused = pause;
+	event->pmu->pause_resume(event);
+	barrier();
+	WRITE_ONCE(rb->aux_in_pause_resume, 0);
+out_restore:
+	local_irq_restore(flags);
+	ring_buffer_put(rb);
+}
+
 static __always_inline int
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
@@ -7786,6 +7826,9 @@ __perf_event_output(struct perf_event *event,
 	struct perf_event_header header;
 	int err;
 
+	if (event->attr.aux_pause)
+		perf_event_aux_pause(event->aux_event, true);
+
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
@@ -7802,6 +7845,10 @@ __perf_event_output(struct perf_event *event,
 
 exit:
 	rcu_read_unlock();
+
+	if (event->attr.aux_resume)
+		perf_event_aux_pause(event->aux_event, false);
+
 	return err;
 }
 
@@ -11941,10 +11988,22 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (event->attr.aux_output &&
-	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
+	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
+	     event->attr.aux_pause || event->attr.aux_resume)) {
+		err = -EOPNOTSUPP;
+		goto err_pmu;
+	}
+
+	if (event->attr.aux_pause && event->attr.aux_resume) {
+		err = -EINVAL;
+		goto err_pmu;
+	}
+
+	if (event->attr.aux_start_paused && !has_aux_pause_resume(event)) {
 		err = -EOPNOTSUPP;
 		goto err_pmu;
 	}
+	event->aux_paused = event->attr.aux_start_paused;
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
@@ -12741,7 +12800,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	 * Grouping is not supported for kernel events, neither is 'AUX',
 	 * make sure the caller's intentions are adjusted.
 	 */
-	if (attr->aux_output)
+	if (attr->aux_output || attr->aux_output_cfg)
 		return ERR_PTR(-EINVAL);
 
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c03..3320f78117dc 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -51,6 +51,7 @@ struct perf_buffer {
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
 	int				aux_in_sampling;
+	int				aux_in_pause_resume;
 	void				**aux_pages;
 	void				*aux_priv;
 
-- 
2.34.1

