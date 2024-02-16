Return-Path: <linux-kernel+bounces-68332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20C8578DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47931C228EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243081BC2F;
	Fri, 16 Feb 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO//ygtb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBA1BC23;
	Fri, 16 Feb 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075911; cv=none; b=tDhTIFiGg/+t/bX3Od/gNrZJFudKzRAI6jswNABymHNC82fSaECio+C4rPrQDdXDZLmBAqpCSN4z41yy9RJJQ3HAwD06eS/onqRFNlvKIUXrRXrPv9Lc/lWXeiTSEczEKyiCmMp2oVBmQ7cKYiHuUxLGlzMR8qQKtgeispd4zw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075911; c=relaxed/simple;
	bh=BcxKMsxSrGKWzLGxNTqxIYjXJptoEYAbh8nekZm1kSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGvd7/29xgCw0WtDk3nx/nsJIUFts6PJCGJsqcwWN+/QU2xmCUCZ+PxuCGISV4AY0+L7fbJfOWXi1b4gt9TRjoMRyUkgn9sIOBwW/Ho7cCZtt3BFh6cTZoITz8LfZ28Qzazt87QXTKL69LUM0YOQqJNLR/IXZGW6mp338+MEYYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO//ygtb; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708075908; x=1739611908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcxKMsxSrGKWzLGxNTqxIYjXJptoEYAbh8nekZm1kSI=;
  b=CO//ygtbPQaisqvwrjbvEhVp+Z6m45KFtqJwjmQY93UA8Vfesg9FEggQ
   l+M2MfZDEP151JMQ36gdLC4FVG4Q73yK1oCKPqwbx3z71vQ/lOt0c4RhY
   QW9rkVHlDpzmQap2b1soPnRXYa33MY0+tpe/EMZ5Wnu6QOwOchQAwGEB1
   Y6jQNaTsREIX6rpZVxP1g6CuqZKQlO00J7DpHunmoKJ84Eb7qp//X/kKD
   zX7Rleuuc26g06yLUpe0UewEMQpzXrizpAvZXqtYpiBSAcjfqzhEIJf26
   cVXtu6gn5PX/AMs/zbi7mJewBkgDz+YPfCEN4ocpMBSod8x+jBM/iySCn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="19720156"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="19720156"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="26945784"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.220.122])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:31:41 -0800
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
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V6] perf/core: Add aux_pause, aux_resume, aux_start_paused
Date: Fri, 16 Feb 2024 11:31:28 +0200
Message-Id: <20240216093128.77452-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <05ac66fc-ddda-46ff-b08d-c15943c16bc1@intel.com>
References: <05ac66fc-ddda-46ff-b08d-c15943c16bc1@intel.com>
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
Acked-by: James Clark <james.clark@arm.com>
---


Changes in V6:
	Removed READ/WRITE_ONCEfrom __perf_event_aux_pause()
	Expanded comment about guarding against NMI

Changes in V5:
	Added James' Ack

Changes in V4:
	Rename aux_output_cfg -> aux_action
	Reorder aux_action bits from:
		aux_pause, aux_resume, aux_start_paused
	to:
		aux_start_paused, aux_pause, aux_resume
	Fix aux_action bits __u64 -> __u32


 include/linux/perf_event.h      | 15 +++++++
 include/uapi/linux/perf_event.h | 11 ++++-
 kernel/events/core.c            | 76 +++++++++++++++++++++++++++++++--
 kernel/events/internal.h        |  1 +
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..6c1600b9bdb3 100644
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
index 3a64499b0f5d..0c557f0a17b3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
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
index f0f0f71213a1..c7ed4e64f1d8 100644
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
 
@@ -7854,6 +7859,51 @@ void perf_prepare_header(struct perf_event_header *header,
 	WARN_ON_ONCE(header->size & 7);
 }
 
+static void __perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	if (pause) {
+		if (!event->aux_paused) {
+			event->aux_paused = 1;
+			event->pmu->stop(event, PERF_EF_PAUSE);
+		}
+	} else {
+		if (event->aux_paused) {
+			event->aux_paused = 0;
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
+	/*
+	 * Guard against NMI, NMI loses here. The critical setion is demarked by
+	 * rb->aux_in_pause_resume == 1. An NMI in the critical section will not
+	 * process a pause/resume.
+	 */
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
@@ -7867,6 +7917,9 @@ __perf_event_output(struct perf_event *event,
 	struct perf_event_header header;
 	int err;
 
+	if (event->attr.aux_pause)
+		perf_event_aux_pause(event->aux_event, true);
+
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
@@ -7883,6 +7936,10 @@ __perf_event_output(struct perf_event *event,
 
 exit:
 	rcu_read_unlock();
+
+	if (event->attr.aux_resume)
+		perf_event_aux_pause(event->aux_event, false);
+
 	return err;
 }
 
@@ -12036,10 +12093,23 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
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
@@ -12836,7 +12906,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
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


