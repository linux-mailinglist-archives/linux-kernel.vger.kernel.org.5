Return-Path: <linux-kernel+bounces-23201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CF82A8EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AD428772B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48867F512;
	Thu, 11 Jan 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIMqEiq2"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7127EAEA;
	Thu, 11 Jan 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704961180; x=1736497180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dfTBIiFpANJlz5aBagh7IAvClVgFJ19Fw8e6sothvfM=;
  b=UIMqEiq2u4TSL6FCnZCTDrJ+cRLjYk8hpfzqifsRzR30DOdxeQcfk1XZ
   M5fNwnZ+S3TvsgO/hPR3pUH7CW2yh8BHdWvM/Chix7UuoqoDP3vJUoDgH
   s7Bd9sI1CFIWyE56xi9EfQ7TcznncaRx/oJnqrSTIgN9eABGJtFfrAIhm
   dic2Yqhkgy8gLaW5zUONYtRd0uJUt+jjqjU71zf47QcrQd8nhFOxBI/AR
   nx61juNM0GV+iBFfJz1kVFHqnouwf4Y1csKQSXjHgJ1So7vkFKVCP0enr
   NgtfuZj6rz5y4MiojroTy2SCJC+Q2BnzH60n4epBn9mWGZo3yYgwftdCI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="465166348"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="465166348"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 00:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925923020"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="925923020"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.52.224])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 00:19:35 -0800
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
Subject: [PATCH V4 02/11] perf/x86/intel/pt: Add support for pause / resume
Date: Thu, 11 Jan 2024 10:19:05 +0200
Message-Id: <20240111081914.3123-3-adrian.hunter@intel.com>
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

Prevent tracing to start if aux_paused.

Implement support for PERF_EF_PAUSE / PERF_EF_RESUME. When aux_paused, stop
tracing. When not aux_paused, only start tracing if it isn't currently
meant to be stopped.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/events/intel/pt.c | 63 ++++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/pt.h |  4 +++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a12235e62..b6e838f2c6d5 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -418,6 +418,9 @@ static void pt_config_start(struct perf_event *event)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 ctl = event->hw.config;
 
+	if (READ_ONCE(event->aux_paused))
+		return;
+
 	ctl |= RTIT_CTL_TRACEEN;
 	if (READ_ONCE(pt->vmx_on))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
@@ -534,7 +537,20 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.config = reg;
+
+	/*
+	 * Allow resume before starting so as not to overwrite a value set by a
+	 * PMI.
+	 */
+	WRITE_ONCE(pt->resume_allowed, 1);
+
 	pt_config_start(event);
+
+	/*
+	 * Allow pause after starting so its pt_config_stop() doesn't race with
+	 * pt_config_start().
+	 */
+	WRITE_ONCE(pt->pause_allowed, 1);
 }
 
 static void pt_config_stop(struct perf_event *event)
@@ -1511,6 +1527,7 @@ void intel_pt_interrupt(void)
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
 			event->hw.state = PERF_HES_STOPPED;
+			pt->resume_allowed = 0;
 			return;
 		}
 
@@ -1519,6 +1536,7 @@ void intel_pt_interrupt(void)
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
 			perf_aux_output_end(&pt->handle, 0);
+			pt->resume_allowed = 0;
 			return;
 		}
 
@@ -1573,6 +1591,26 @@ static void pt_event_start(struct perf_event *event, int mode)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	struct pt_buffer *buf;
 
+	if (mode & PERF_EF_RESUME) {
+		if (READ_ONCE(pt->resume_allowed)) {
+			u64 status;
+
+			/*
+			 * Only if the trace is not active and the error and
+			 * stopped bits are clear, is it safe to start, but a
+			 * PMI might have just cleared these, so resume_allowed
+			 * must be checked again also.
+			 */
+			rdmsrl(MSR_IA32_RTIT_STATUS, status);
+			if (!(status & (RTIT_STATUS_TRIGGEREN |
+					RTIT_STATUS_ERROR |
+					RTIT_STATUS_STOPPED)) &&
+			   READ_ONCE(pt->resume_allowed))
+				pt_config_start(event);
+		}
+		return;
+	}
+
 	buf = perf_aux_output_begin(&pt->handle, event);
 	if (!buf)
 		goto fail_stop;
@@ -1601,6 +1639,16 @@ static void pt_event_stop(struct perf_event *event, int mode)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 
+	if (mode & PERF_EF_PAUSE) {
+		if (READ_ONCE(pt->pause_allowed))
+			pt_config_stop(event);
+		return;
+	}
+
+	/* Protect against racing */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+
 	/*
 	 * Protect against the PMI racing with disabling wrmsr,
 	 * see comment in intel_pt_interrupt().
@@ -1659,8 +1707,12 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	/*
 	 * Here, handle_nmi tells us if the tracing is on
 	 */
-	if (READ_ONCE(pt->handle_nmi))
+	if (READ_ONCE(pt->handle_nmi)) {
+		/* Protect against racing */
+		WRITE_ONCE(pt->pause_allowed, 0);
+		WRITE_ONCE(pt->resume_allowed, 0);
 		pt_config_stop(event);
+	}
 
 	pt_read_offset(buf);
 	pt_update_head(pt);
@@ -1677,8 +1729,11 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	 * Compiler barrier not needed as we couldn't have been
 	 * preempted by anything that touches pt->handle_nmi.
 	 */
-	if (pt->handle_nmi)
+	if (pt->handle_nmi) {
+		WRITE_ONCE(pt->resume_allowed, 1);
 		pt_config_start(event);
+		WRITE_ONCE(pt->pause_allowed, 1);
+	}
 
 	return ret;
 }
@@ -1794,7 +1849,9 @@ static __init int pt_init(void)
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
 
-	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
+	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_PAUSE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..b9527205e028 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -117,6 +117,8 @@ struct pt_filters {
  * @filters:		last configured filters
  * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
  * @vmx_on:		1 if VMX is ON on this cpu
+ * @pause_allowed:	PERF_EF_PAUSE is allowed to stop tracing
+ * @resume_allowed:	PERF_EF_RESUME is allowed to start tracing
  * @output_base:	cached RTIT_OUTPUT_BASE MSR value
  * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
  */
@@ -125,6 +127,8 @@ struct pt {
 	struct pt_filters	filters;
 	int			handle_nmi;
 	int			vmx_on;
+	int			pause_allowed;
+	int			resume_allowed;
 	u64			output_base;
 	u64			output_mask;
 };
-- 
2.34.1


