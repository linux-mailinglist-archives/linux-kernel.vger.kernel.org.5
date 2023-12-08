Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7687F80AAB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574481AbjLHRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574474AbjLHRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:25:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683CD10E6;
        Fri,  8 Dec 2023 09:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702056319; x=1733592319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6YX0WodqbjyJ5jO9FJZ3AtIO7LVa6j00EG3qTDrAnw=;
  b=PKewKbT581rYaTYa6rFSxwKSHf1Xbw6bXAc/IZI6NNVyc6EIvAqBfhj6
   qlaxM7WA/Q7RXMcecfCZyRk+LdvUG2c+qlg9VT5FbUsPS6VCHQA4tiqHb
   O9TE1MfKe0P4XpnB626xQV0NzyGA4c6Yw2C0sXYn8jVs2hmyaF6Y2jlci
   G18CycOerT/0gaoshBc2WX+CGVPxz+YL4YNQZNdwVRk2b5RK29moNAkfn
   XY/gPM/DVVXLyYkiECQflC1zjR7TTdVQRUAmyin8k9m7bA+C6d2QsVKxS
   OkYmjFeUOZKZ3G3GouMMSIjkA83W89+NuBdU4Nv0JwuVxWRKxuRVXDv9A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="379432410"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="379432410"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772201616"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="772201616"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.34.218])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 09:25:12 -0800
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
Subject: [PATCH RFC V2 2/4] perf/x86/intel/pt: Add support for pause / resume
Date:   Fri,  8 Dec 2023 19:24:47 +0200
Message-Id: <20231208172449.35444-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208172449.35444-1-adrian.hunter@intel.com>
References: <20231208172449.35444-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 42a55794004a..692b51849d1c 100644
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
@@ -1507,6 +1523,7 @@ void intel_pt_interrupt(void)
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
 			event->hw.state = PERF_HES_STOPPED;
+			pt->resume_allowed = 0;
 			return;
 		}
 
@@ -1515,6 +1532,7 @@ void intel_pt_interrupt(void)
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
 			perf_aux_output_end(&pt->handle, 0);
+			pt->resume_allowed = 0;
 			return;
 		}
 
@@ -1569,6 +1587,26 @@ static void pt_event_start(struct perf_event *event, int mode)
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
@@ -1597,6 +1635,16 @@ static void pt_event_stop(struct perf_event *event, int mode)
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
@@ -1655,8 +1703,12 @@ static long pt_event_snapshot_aux(struct perf_event *event,
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
@@ -1673,8 +1725,11 @@ static long pt_event_snapshot_aux(struct perf_event *event,
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
@@ -1790,7 +1845,9 @@ static __init int pt_init(void)
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

