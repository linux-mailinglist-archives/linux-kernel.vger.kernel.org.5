Return-Path: <linux-kernel+bounces-23200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D722A82A8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29031C23605
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D933EAD9;
	Thu, 11 Jan 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAWFHrE/"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2B4E556;
	Thu, 11 Jan 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704961176; x=1736497176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqalGc7Qf23jcRlg6XrmUM+Xf41s8gI3cs0RQHKIaP4=;
  b=CAWFHrE/K+S+JF/qvXbS2pbaBdQaSAYt1fqQzLGz9c4g9RAHcScQaZup
   juOEQcxk5BM4HxB6ZoS+o/PdTrLTemKRqzRD25/hd+23nsSh0H2xDISCO
   KKOU8lPxi1xDRWsjIrtZNpYtJkXLzL7mTma6y3jZw518idNtkCF+RF8nK
   PpoHyRpL8E3P8pYk7JXYxnCA+AXlhNpIKxoAKFCOlKrQT4J44Noqvg3s0
   1GUjFtQGQ12e8NX3K47lhuUOLOTm/mzG1fgvDjIerSDJs2CsJfxqESMOP
   Dhzmgm9Yj5OWw4cfM766Isb+er9LwHXjSfSRY1uXaxB9uRqeGm9Mlm7iF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="465166328"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="465166328"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 00:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925923011"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="925923011"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.224])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 00:19:30 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V4 01/11] perf/core: Add aux_pause, aux_resume, aux_start_paused
Date: Thu, 11 Jan 2024 10:19:04 +0200
Message-Id: <20240111081914.3123-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111081914.3123-1-adrian.hunter@intel.com>
References: <20240111081914.3123-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

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

Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
callbacks. Call as needed, during __perf_event_output(). Add
aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
handler. Pause/resume in NMI context will miss out if it coincides with
another pause/resume.

To use aux_pause or aux_resume, an event must be in a group with the AUX
area event as the group leader.

Example (requires Intel PT and tools patches also):

 $ perf record --kcore -e intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/ uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.043 MB perf.data ]
 $ perf script --call-trace
 uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
 uname   30805 [000] 24001.058784424:  psb offs: 0
 uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_smp_processor_id
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sys_newuname
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down_read
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                __cond_resched
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                    in_lock_functions
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_sub
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_read
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    in_lock_functions
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                preempt_count_sub
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _copy_to_user
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_exit_to_user_mode
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            syscall_exit_work
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                perf_syscall_exit
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_trace_buf_alloc
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_tp_event
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_trace_buf_update
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_event
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            __perf_event_account_interrupt
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                __this_cpu_preempt_check
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            perf_event_output_forward
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                perf_event_aux_pause
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                    ring_buffer_get
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_lock
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_unlock
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                    pt_event_stop
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        native_write_msr
 uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                                        native_write_msr
 uname   30805 [000] 24001.058785639: 0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V4:
	Rename aux_output_cfg -> aux_action
	Reorder aux_action bits from:
		aux_pause, aux_resume, aux_start_paused
	to:
		aux_start_paused, aux_pause, aux_resume
	Fix aux_action bits __u64 -> __u32


 include/linux/perf_event.h      | 15 +++++++
 include/uapi/linux/perf_event.h | 11 ++++-
 kernel/events/core.c            | 72 +++++++++++++++++++++++++++++++--
 kernel/events/internal.h        |  1 +
 4 files changed, 95 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5547ba68e6e4..342879168269 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -291,6 +291,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
+#define PERF_PMU_CAP_AUX_PAUSE			0x0200
 
 struct perf_output_handle;
 
@@ -363,6 +364,8 @@ struct pmu {
 #define PERF_EF_START	0x01		/* start the counter when adding    */
 #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
 #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
+#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
+#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
 
 	/*
 	 * Adds/Removes a counter to/from the PMU, can be done inside a
@@ -402,6 +405,15 @@ struct pmu {
 	 *
 	 * ->start() with PERF_EF_RELOAD will reprogram the counter
 	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
+	 *
+	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
+	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
+	 * PERF_EF_RESUME.
+	 *
+	 * ->start() with PERF_EF_RESUME will start as simply as possible but
+	 * only if the counter is not otherwise stopped. Will not overlap
+	 * another ->start() with PERF_EF_RESUME nor ->stop() with
+	 * PERF_EF_PAUSE.
 	 */
 	void (*start)			(struct perf_event *event, int flags);
 	void (*stop)			(struct perf_event *event, int flags);
@@ -798,6 +810,9 @@ struct perf_event {
 	/* for aux_output events */
 	struct perf_event		*aux_event;
 
+	/* for AUX area events */
+	unsigned int			aux_paused;
+
 	void (*destroy)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 39c6a250dd1b..5f6b3b494184 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -507,7 +507,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_action;
+		struct {
+			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
+				aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9efd0d7775e7..dc9ec2443ac9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2097,7 +2097,8 @@ static void perf_put_aux_event(struct perf_event *event)
 
 static bool perf_need_aux_event(struct perf_event *event)
 {
-	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
+	return event->attr.aux_output || event->attr.aux_sample_size ||
+	       event->attr.aux_pause || event->attr.aux_resume;
 }
 
 static int perf_get_aux_event(struct perf_event *event,
@@ -2122,6 +2123,10 @@ static int perf_get_aux_event(struct perf_event *event,
 	    !perf_aux_output_match(event, group_leader))
 		return 0;
 
+	if ((event->attr.aux_pause || event->attr.aux_resume) &&
+	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
+		return 0;
+
 	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
@@ -7846,6 +7851,47 @@ void perf_prepare_header(struct perf_event_header *header,
 	WARN_ON_ONCE(header->size & 7);
 }
 
+static void __perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	if (pause) {
+		if (!READ_ONCE(event->aux_paused)) {
+			WRITE_ONCE(event->aux_paused, 1);
+			event->pmu->stop(event, PERF_EF_PAUSE);
+		}
+	} else {
+		if (READ_ONCE(event->aux_paused)) {
+			WRITE_ONCE(event->aux_paused, 0);
+			event->pmu->start(event, PERF_EF_RESUME);
+		}
+	}
+}
+
+static void perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	struct perf_buffer *rb;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(!event))
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
+	__perf_event_aux_pause(event, pause);
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
@@ -7859,6 +7905,9 @@ __perf_event_output(struct perf_event *event,
 	struct perf_event_header header;
 	int err;
 
+	if (event->attr.aux_pause)
+		perf_event_aux_pause(event->aux_event, true);
+
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
@@ -7875,6 +7924,10 @@ __perf_event_output(struct perf_event *event,
 
 exit:
 	rcu_read_unlock();
+
+	if (event->attr.aux_resume)
+		perf_event_aux_pause(event->aux_event, false);
+
 	return err;
 }
 
@@ -12014,10 +12067,23 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
+	if (event->attr.aux_start_paused &&
+	    !(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
 		err = -EOPNOTSUPP;
 		goto err_pmu;
 	}
+	event->aux_paused = event->attr.aux_start_paused;
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
@@ -12814,7 +12880,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	 * Grouping is not supported for kernel events, neither is 'AUX',
 	 * make sure the caller's intentions are adjusted.
 	 */
-	if (attr->aux_output)
+	if (attr->aux_output || attr->aux_action)
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


