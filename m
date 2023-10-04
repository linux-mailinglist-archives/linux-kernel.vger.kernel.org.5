Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4E7B8AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbjJDSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbjJDSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6469AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444848; x=1727980848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YPCb3UVxzQi3LOX5bsn01xtni3WlRDWfQuY+rkCih3E=;
  b=aHgtyEw/rIcKFCJhkmjOXwr2T/Q4SZH0nvgKByeWV4SErY+P12JOS1H7
   dk9Cw74UOGIH2BU+atPEwpqgKl5cmv56FJ0gvfOFcV7czIOlDsJMaL5ld
   /IN+Rdz8d8TrCSbVQizrLq8Uq66gd7LUbG5PlNAS/oEOoazsKeg5tePtE
   SRVB6DWybMZkUA/eF4A8JBBhCiHo5ToCun3XUKQ69wWRu8LagIBCq69YC
   W5r/EDQn4nsqRWqFo9kjVYj7a+cFYxzTfZK8F8VmRrKofY1gpG5Vth0bK
   PIJIMf97Lqy4w0TIEaJhDpmM0Bg90ks3wKuNpPa6uiTbQntnMA8SJv6oX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469537715"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469537715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786626048"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786626048"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 11:40:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 7/7] perf tools: Add branch counter knob
Date:   Wed,  4 Oct 2023 11:40:44 -0700
Message-Id: <20231004184044.3062788-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231004184044.3062788-1-kan.liang@linux.intel.com>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a new branch filter, "counter", for the branch counter option. It is
used to mark the events which should be logged in the branch. If it is
applied with the -j option, the counters of all the events should be
logged in the branch. If the legacy kernel doesn't support the new
branch sample type, switching off the branch counter filter.

The stored counter values in each branch are displayed right after the
regular branch stack information via perf report -D.

Usage examples:

perf record -e "{branch-instructions,branch-misses}:S" -j any,counter

Only the first event, branch-instructions, collect the LBR. Both
branch-instructions and branch-misses are marked as logged events.
The occurrences information of them can be found in the branch stack
extension space of each branch.

perf record -e "{cpu/branch-instructions,branch_type=any/,
cpu/branch-misses,branch_type=counter/}"

Only the first event, branch-instructions, collect the LBR. Only the
branch-misses event is marked as a logged event.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Rename the filter name to "counter".
- Dump the "branch_counter_nr" and "branch_counter_width" in perf report
- Support PERF_SAMPLE_BRANCH_COUNTERS

 tools/perf/Documentation/perf-record.txt  |  4 +++
 tools/perf/util/evsel.c                   | 31 ++++++++++++++++++++++-
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/parse-branch-options.c    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  1 +
 tools/perf/util/session.c                 | 15 +++++++++--
 7 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d5217be012d7..b6afe7cc948d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -442,6 +442,10 @@ following filters are defined:
 		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
 		     when the taken branch stack sampling is enabled.
 	- priv: save privilege state during sampling in case binary is not available later
+	- counter: save occurrences of the event since the last branch entry. Currently, the
+		   feature is only supported by a newer CPU, e.g., Intel Sierra Forest and
+		   later platforms. An error out is expected if it's used on the unsupported
+		   kernel or CPUs.
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a8a5ff87cc1f..58a9b8c82790 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1831,6 +1831,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.branch_counters)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
 	if (perf_missing_features.read_lost)
 		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
@@ -1884,7 +1886,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.read_lost &&
+	if (!perf_missing_features.branch_counters &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
+		perf_missing_features.branch_counters = true;
+		pr_debug2("switching off branch counters support\n");
+		return true;
+	} else if (!perf_missing_features.read_lost &&
 	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
 		perf_missing_features.read_lost = true;
 		pr_debug2("switching off PERF_FORMAT_LOST support\n");
@@ -2344,6 +2351,18 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 	return new_val;
 }
 
+static inline bool evsel__has_branch_counters(const struct evsel *evsel)
+{
+	struct evsel *cur, *leader = evsel__leader(evsel);
+
+	evlist__for_each_entry(evsel->evlist, cur) {
+		if ((leader == evsel__leader(cur)) &&
+		    (cur->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS))
+			return true;
+	}
+	return false;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -2577,6 +2596,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
+
+		if (evsel__has_branch_counters(evsel)) {
+			OVERFLOW_CHECK_u64(array);
+
+			data->branch_stack_cntr = (u64 *)array;
+			sz = data->branch_stack->nr * sizeof(u64);
+
+			OVERFLOW_CHECK(array, sz, max_size);
+			array = (void *)array + sz;
+		}
 	}
 
 	if (type & PERF_SAMPLE_REGS_USER) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 848534ec74fa..85f24c986392 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -191,6 +191,7 @@ struct perf_missing_features {
 	bool code_page_size;
 	bool weight_struct;
 	bool read_lost;
+	bool branch_counters;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index fd67d204d720..f7f7aff3d85a 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -36,6 +36,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
 	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
+	BRANCH_OPT("counter", PERF_SAMPLE_BRANCH_COUNTERS),
 	BRANCH_END
 };
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 2247991451f3..8f04d3b7f3ec 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -55,6 +55,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
 		bit_name(TYPE_SAVE), bit_name(HW_INDEX), bit_name(PRIV_SAVE),
+		bit_name(COUNTERS),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index c92ad0f51ecd..70b2c3135555 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -113,6 +113,7 @@ struct perf_sample {
 	void *raw_data;
 	struct ip_callchain *callchain;
 	struct branch_stack *branch_stack;
+	u64 *branch_stack_cntr;
 	struct regs_dump  user_regs;
 	struct regs_dump  intr_regs;
 	struct stack_dump user_stack;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1e9aa8ed15b6..4a094ab0362b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1150,9 +1150,13 @@ static void callchain__printf(struct evsel *evsel,
 		       i, callchain->ips[i]);
 }
 
-static void branch_stack__printf(struct perf_sample *sample, bool callstack)
+static void branch_stack__printf(struct perf_sample *sample,
+				 struct evsel *evsel)
 {
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	bool callstack = evsel__has_branch_callstack(evsel);
+	u64 *branch_stack_cntr = sample->branch_stack_cntr;
+	struct perf_env *env = evsel__env(evsel);
 	uint64_t i;
 
 	if (!callstack) {
@@ -1194,6 +1198,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 			}
 		}
 	}
+
+	if (branch_stack_cntr) {
+		printf("... branch stack counters: nr:%" PRIu64 " (counter width: %u max counter nr:%u)\n",
+			sample->branch_stack->nr, env->br_cntr_width, env->br_cntr_nr);
+		for (i = 0; i < sample->branch_stack->nr; i++)
+			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, branch_stack_cntr[i]);
+	}
 }
 
 static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
@@ -1355,7 +1366,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		callchain__printf(evsel, sample);
 
 	if (evsel__has_br_stack(evsel))
-		branch_stack__printf(sample, evsel__has_branch_callstack(evsel));
+		branch_stack__printf(sample, evsel);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		regs_user__printf(sample, arch);
-- 
2.35.1

