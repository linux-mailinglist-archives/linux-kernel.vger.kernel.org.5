Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0577E3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343703AbjHPOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbjHPOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:36:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D125C2712
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692196606; x=1723732606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5ehCu/UnoLKemmz7dCtH+67qXqwmgu+HAINdk3HhGM=;
  b=eVEtDb2EhGeePQ8dLlqUXyY/e0ST9hJ6r15LuSHslw+OGa/UFJWMH0DP
   ANXQrCjxaNAJYqNP4+jwC4DSl8XzzZbLJCj98sVRyspsYwBZU3LJ2glfP
   Adt8TVYEFwKOugPDhl3iPh066+8it8KPK2hAGrDYLOh29igbgPbsvEUV2
   nXKyb/zpXSBhVWNCBKYn1HfDbe5ozunwhxGw7Jq7ikYroMFQnbcE6fECh
   dtPOdvTHwcL0dIYHei01Q5VoPs5+D2ZQRIvVGSGeWU/oN4apGi4j/y9KC
   HNqnqc3nkdWRe9l0ZTF8vIlYmO+xa6cPSLVSQbrjlOr+ahWRouzT8awCc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352138664"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352138664"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980758858"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980758858"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:36:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 6/6] perf tools: Add branch event knob
Date:   Wed, 16 Aug 2023 07:36:28 -0700
Message-Id: <20230816143628.1885281-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816143628.1885281-1-kan.liang@linux.intel.com>
References: <20230816143628.1885281-1-kan.liang@linux.intel.com>
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

Add a new branch filter, "event", for the branch event option. It is
used to mark the events which should be logged in the branch. If it is
applied with the -j option, all the events should be logged in the
branch. If the legacy kernel doesn't support the new branch sample type,
switching off the branch event filter.

The branch event requires extra space. If the "event" branch filter is
detected, the PERF_SAMPLE_BRANCH_EXTRA is applied automatically for the
entire group.

The new extra space of each branch is dumped right after the regular
branch stack information via perf report -D.

Usage examples:

perf record -e "{branch-instructions,branch-misses}:S" -j any,event

Only the first event, branch-instructions, collect the LBR. Both
branch-instructions and branch-misses are marked as logged events.
The occurrences information of them can be found in the branch stack
extension space of each branch.

perf record -e "{cpu/branch-instructions,branch_type=any/,
cpu/branch-misses,branch_type=event/}"

Only the first event, branch-instructions, collect the LBR. Only the
branch-misses event is marked as a logged event.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V2:
- Drop the new bit in struct perf_branch_entry
- Support PERF_SAMPLE_BRANCH_EXTRA

 tools/perf/Documentation/perf-record.txt  |  4 ++++
 tools/perf/arch/x86/util/evsel.c          | 17 ++++++++++++++-
 tools/perf/util/evsel.c                   | 26 ++++++++++++++++++++++-
 tools/perf/util/evsel.h                   | 12 +++++++++++
 tools/perf/util/parse-branch-options.c    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  1 +
 tools/perf/util/session.c                 |  8 +++++++
 8 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 680396c56bd1..91a77fae11bb 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -456,6 +456,10 @@ following filters are defined:
 		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
 		     when the taken branch stack sampling is enabled.
 	- priv: save privilege state during sampling in case binary is not available later
+	- event: save occurrences of the event since the last branch entry. Currently, the
+		 feature is only supported by a newer CPU, e.g., Intel Sierra Forest and
+		 later platforms. An error out is expected if it's used on the unsupported
+		 kernel or CPUs.
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 81d22657922a..038c3454d76f 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -9,6 +9,7 @@
 #include "evsel.h"
 #include "util/debug.h"
 #include "env.h"
+#include "../../../util/evlist.h"
 
 #define IBS_FETCH_L3MISSONLY   (1ULL << 59)
 #define IBS_OP_L3MISSONLY      (1ULL << 16)
@@ -80,9 +81,23 @@ void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr *attr)
 	struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
 	static int warned_once;
 
-	if (warned_once || !x86__is_amd_cpu())
+	if (warned_once)
 		return;
 
+	if (!x86__is_amd_cpu()) {
+		if (evsel__has_branch_evt_cntrs(evsel)) {
+			struct evsel *cur, *leader = evsel__leader(evsel);
+
+			/* The extra space is required for the LBR event group */
+			evlist__for_each_entry(evsel->evlist, cur) {
+				if (leader == evsel__leader(cur))
+					cur->core.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_EXTRA;
+			}
+		}
+
+		return;
+	}
+
 	evsel_pmu = evsel__find_pmu(evsel);
 	if (!evsel_pmu)
 		return;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 762e2b2634a5..a70007beab14 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1828,6 +1828,10 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.branch_extra)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_EXTRA;
+	if (perf_missing_features.branch_event)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_EVT_CNTRS;
 	if (perf_missing_features.read_lost)
 		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
@@ -1881,7 +1885,17 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.read_lost &&
+	if (!perf_missing_features.branch_extra &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EXTRA)) {
+		perf_missing_features.branch_extra = true;
+		pr_debug2("switching off branch extra space support\n");
+		return true;
+	} else if (!perf_missing_features.branch_event &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS)) {
+		perf_missing_features.branch_event = true;
+		pr_debug2("switching off branch event support\n");
+		return true;
+	} else if (!perf_missing_features.read_lost &&
 	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
 		perf_missing_features.read_lost = true;
 		pr_debug2("switching off PERF_FORMAT_LOST support\n");
@@ -2574,6 +2588,16 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
+
+		if (evsel__has_branch_extra(evsel)) {
+			OVERFLOW_CHECK_u64(array);
+
+			data->branch_stack_ext = (u64 *)array;
+			sz = data->branch_stack->nr * sizeof(u64);
+
+			OVERFLOW_CHECK(array, sz, max_size);
+			array = (void *)array + sz;
+		}
 	}
 
 	if (type & PERF_SAMPLE_REGS_USER) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 848534ec74fa..f476dd68bb4c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -191,6 +191,8 @@ struct perf_missing_features {
 	bool code_page_size;
 	bool weight_struct;
 	bool read_lost;
+	bool branch_event;
+	bool branch_extra;
 };
 
 extern struct perf_missing_features perf_missing_features;
@@ -499,6 +501,16 @@ static inline bool evsel__has_branch_hw_idx(const struct evsel *evsel)
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
 }
 
+static inline bool evsel__has_branch_evt_cntrs(const struct evsel *evsel)
+{
+	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
+}
+
+static inline bool evsel__has_branch_extra(const struct evsel *evsel)
+{
+	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EXTRA;
+}
+
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
 	/*
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index fd67d204d720..ab5d6dabe659 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -36,6 +36,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
 	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
+	BRANCH_OPT("event", PERF_SAMPLE_BRANCH_EVT_CNTRS),
 	BRANCH_END
 };
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 2247991451f3..7c9fdd62d920 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -55,6 +55,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
 		bit_name(TYPE_SAVE), bit_name(HW_INDEX), bit_name(PRIV_SAVE),
+		bit_name(EVT_CNTRS), bit_name(EXTRA),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index c92ad0f51ecd..3abe892aae60 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -113,6 +113,7 @@ struct perf_sample {
 	void *raw_data;
 	struct ip_callchain *callchain;
 	struct branch_stack *branch_stack;
+	u64 *branch_stack_ext;
 	struct regs_dump  user_regs;
 	struct regs_dump  intr_regs;
 	struct stack_dump user_stack;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 00d18c74c090..b58cfef5d767 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1153,6 +1153,7 @@ static void callchain__printf(struct evsel *evsel,
 static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 {
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	u64 *branch_stack_ext = sample->branch_stack_ext;
 	uint64_t i;
 
 	if (!callstack) {
@@ -1194,6 +1195,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 			}
 		}
 	}
+
+	if (branch_stack_ext) {
+		printf("... branch stack extra: nr:%" PRIu64 "\n", sample->branch_stack->nr);
+		for (i = 0; i < sample->branch_stack->nr; i++) {
+			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, branch_stack_ext[i]);
+		}
+	}
 }
 
 static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
-- 
2.35.1

