Return-Path: <linux-kernel+bounces-111795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E03887112
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6101F21E74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DB6025F;
	Fri, 22 Mar 2024 16:42:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FD85FDDD;
	Fri, 22 Mar 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125777; cv=none; b=S2DgJGkrLuona9Sbtp5RDIyUv4xaTSJi73FTBwdd/x8biO7bQTpkV1s/tyFmqxwD5L5i0IWav5i+jzWspYn+BMPS5rnAo8wTFTz0ki6lPk6HuHIH8pOK72CJ4oLOKhRCdshtMHddPMBhqr1LVBdcWREKQxmPj0lLTGqM7yUSPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125777; c=relaxed/simple;
	bh=X45+6Et3bMjkkIBCb2MS1DoUmaZQ0uQN0xJ8G0oOWpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPSDc0cP67J/LHJbyxghtc1Idw1+ut4GC69CumTZo4HQubH6pCooND6m0HgE0XhK3KJ/40WPaB/ZK6DunFqg4wx1PhZ9PIUr4liBmWns+dG++TgRnO5W38BUUaia8Tt7gRkb+CkFraRPhemuFes23BkPE915DV9ErhS3oZBSjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73CE91063;
	Fri, 22 Mar 2024 09:43:29 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 849003F762;
	Fri, 22 Mar 2024 09:42:53 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v4 4/4] tools/perf: Allow inherit + inherit_stat + PERF_SAMPLE_READ when opening events
Date: Fri, 22 Mar 2024 16:42:37 +0000
Message-ID: <20240322164237.203358-5-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322164237.203358-1-ben.gainey@arm.com>
References: <20240322164237.203358-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates evsel to allow the combination of inherit
and PERF_SAMPLE_READ.

A fallback is implemented for kernel versions where this feature is not
supported.

The user must pass --stat option to perf record to opt into this new
behaviour.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 .../test-record-group-sampling-inherit-stat   | 62 ++++++++++++++
 tools/perf/util/evsel.c                       | 82 ++++++++++++++++++-
 tools/perf/util/evsel.h                       |  1 +
 3 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling-inherit-stat

diff --git a/tools/perf/tests/attr/test-record-group-sampling-inherit-stat b/tools/perf/tests/attr/test-record-group-sampling-inherit-stat
new file mode 100644
index 000000000000..281a17acb6ae
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group-sampling-inherit-stat
@@ -0,0 +1,62 @@
+[config]
+command = record
+args    = --stat --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+ret     = 1
+
+[event-1:base-record]
+fd=1
+group_fd=-1
+
+# cycles
+type=0
+config=0
+
+# default | PERF_SAMPLE_READ
+sample_type=87
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=31
+task=1
+mmap=1
+comm=1
+enable_on_exec=1
+disabled=1
+
+# inherit is enabled for group sampling, as is inherit_stat
+inherit=1
+inherit_stat=1
+
+# sampling disabled
+sample_freq=0
+sample_period=10000
+freq=0
+write_backward=0
+
+[event-2:base-record]
+fd=2
+group_fd=1
+
+# cache-misses
+type=0
+config=3
+
+# default | PERF_SAMPLE_READ
+sample_type=87
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=31
+task=0
+mmap=0
+comm=0
+enable_on_exec=0
+disabled=0
+
+# inherit is enabled for group sampling, as is inherit_stat
+inherit=1
+inherit_stat=1
+
+# sampling disabled
+sample_freq=0
+sample_period=0
+freq=0
+write_backward=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d7c9c58a9bc..aec6b4f5264e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1097,6 +1097,64 @@ static bool evsel__is_offcpu_event(struct evsel *evsel)
 	return evsel__is_bpf_output(evsel) && evsel__name_is(evsel, OFFCPU_EVENT);
 }
 
+static bool evsel__has_term_type(struct evsel *evsel, enum evsel_term_type type)
+{
+	return __evsel__get_config_term(evsel, type) != NULL;
+}
+
+/*
+ * Determine whether or not an evsel can support inherit+inherit_stat+PERF_SAMPLE_READ.
+ *
+ * In order not to break existing command line behaviour, this configuration
+ * will only be enabled if certain specific requirements are met:
+ *
+ * 1) When making a system-wide capture, there is no need to support this
+ *    configuration. Likewise, if the user disables inherit, or does not request
+ *    inherit_stat, then the configuration is not supported.
+ * 2) If the user explicitly specifies 'freq' as a config term, then do not
+ *    support this feature, as frequency counters are not compatible.
+ * 3) If the user explicitly specifies 'period' as a config term, then the
+ *    feature is compatible with that event.
+ * 4) If neither was explicitly set, and the event is part of a group, then
+ *    base the decision on the leader.
+ * 5) Otherwise base the decision on whether or not the user specified a period
+ *    or frequency on the command line (which includes the default frequency
+ *    setting).
+ */
+static bool evsel__compat_with_inherit_sample_read(struct record_opts *opts,
+						   struct evsel *leader,
+						   struct evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+
+	if (opts->target.system_wide)
+		return false;
+
+	if (opts->no_inherit_set || !opts->inherit_stat)
+		return false;
+
+	if (evsel__has_term_type(evsel, EVSEL__CONFIG_TERM_FREQ))
+		return false;
+
+	if (evsel__has_term_type(evsel, EVSEL__CONFIG_TERM_PERIOD))
+		return true;
+
+	if (leader && (leader != evsel)) {
+		struct perf_event_attr *ldr_att = &leader->core.attr;
+
+		if (evsel__has_term_type(leader, EVSEL__CONFIG_TERM_FREQ))
+			return false;
+
+		if (evsel__has_term_type(leader, EVSEL__CONFIG_TERM_PERIOD))
+			return true;
+
+		if (ldr_att->freq)
+			return false;
+	}
+
+	return (!attr->freq && !opts->freq);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1133,6 +1191,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	int track = evsel->tracking;
 	bool per_cpu = opts->target.default_per_cpu && !opts->target.per_thread;
 
+	bool allow_inherit_stat_sample_read = evsel__compat_with_inherit_sample_read(
+		opts, leader, evsel);
+
 	attr->sample_id_all = perf_missing_features.sample_id_all ? 0 : 1;
 	attr->inherit	    = !opts->no_inherit;
 	attr->write_backward = opts->overwrite ? 1 : 0;
@@ -1156,7 +1217,17 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		 */
 		if (leader->core.nr_members > 1) {
 			attr->read_format |= PERF_FORMAT_GROUP;
-			attr->inherit = 0;
+			if (!allow_inherit_stat_sample_read)
+				attr->inherit = 0;
+		}
+
+		/*
+		 * Inherit + READ requires inherit_stat, but only if freq is
+		 * not set as the two are incompatible
+		 */
+		if (attr->inherit && allow_inherit_stat_sample_read) {
+			attr->inherit_stat = 1;
+			evsel__set_sample_bit(evsel, TID);
 		}
 	}
 
@@ -1832,6 +1903,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.inherit_sample_read)
+		evsel->core.attr.inherit = 0;
 	if (perf_missing_features.branch_counters)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
 	if (perf_missing_features.read_lost)
@@ -1887,7 +1960,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.inherit_sample_read &&
+	    evsel->core.attr.inherit && (evsel->core.attr.sample_type & PERF_SAMPLE_READ)) {
+		perf_missing_features.inherit_sample_read = true;
+		pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
+		return true;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index efbb6e848287..11cc9b8bee27 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -192,6 +192,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool inherit_sample_read;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.44.0


