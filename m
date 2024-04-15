Return-Path: <linux-kernel+bounces-144747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA798A4A26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B466A28295E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B64D9EC;
	Mon, 15 Apr 2024 08:15:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9C3F9D6;
	Mon, 15 Apr 2024 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168908; cv=none; b=B6f6sCEm57oPNPc+VbY7gCr65q0JgrFVoYO/IO/sMZRsjwYL2/GGhGD1ZB95soOPvrrnQJZ6ihIlJ1RRY+x7BdbHD6QUkLcId6w7xhBqDQ0dmopC/6IpixWZ2cVMGfXn+kWxnC2pvRfns5IJYJ0KYvkeUXyHKpsEGdS+hKqmRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168908; c=relaxed/simple;
	bh=3gjzfTH+4fjds3uBhK81w63Ko4AfYzNDlr1/LBHgbmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzkefMQA2GYAVIBhu290r2kCypuuw9Mh9DhczYC1Xrl9ntV0+nDyzYb9vijX5i+nEwKPj1U2EQJURq/luX5PI1JlT5bnlxE3FL7WKDQvZK1onDQM2H8c04dFsxIuhYqlR3JqfwBDFyutL0m+4MlG7SsN7QVcYzUYGnvF91l0CGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE581DA7;
	Mon, 15 Apr 2024 01:15:33 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB85F3F64C;
	Mon, 15 Apr 2024 01:15:03 -0700 (PDT)
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
Subject: [PATCH v5 4/4] tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events
Date: Mon, 15 Apr 2024 09:14:48 +0100
Message-ID: <20240415081448.123789-5-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415081448.123789-1-ben.gainey@arm.com>
References: <20240415081448.123789-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tool will now default to this new mode if the user specifies a
sampling group when not in system-wide mode, and when --no-inherit
is not specified.

This change updates evsel to allow the combination of inherit
and PERF_SAMPLE_READ.

A fallback is implemented for kernel versions where this feature is not
supported.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/perf/tests/attr/README                  |  2 +
 .../tests/attr/test-record-group-sampling     | 39 ------------
 .../tests/attr/test-record-group-sampling1    | 50 ++++++++++++++++
 .../tests/attr/test-record-group-sampling2    | 60 +++++++++++++++++++
 tools/perf/tests/attr/test-record-group2      |  9 +--
 tools/perf/util/evsel.c                       | 19 +++++-
 tools/perf/util/evsel.h                       |  1 +
 7 files changed, 135 insertions(+), 45 deletions(-)
 delete mode 100644 tools/perf/tests/attr/test-record-group-sampling
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling2

diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index 4066fec7180a..67c4ca76b85d 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -51,6 +51,8 @@ Following tests are defined (with perf commands):
   perf record --call-graph fp kill              (test-record-graph-fp-aarch64)
   perf record -e '{cycles,instructions}' kill   (test-record-group1)
   perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
+  perf record -e '{cycles,cache-misses}:S' kill (test-record-group-sampling1)
+  perf record -c 10000 -e '{cycles,cache-misses}:S' kill (test-record-group-sampling2)
   perf record -D kill                           (test-record-no-delay)
   perf record -i kill                           (test-record-no-inherit)
   perf record -n kill                           (test-record-no-samples)
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
deleted file mode 100644
index 97e7e64a38f0..000000000000
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ /dev/null
@@ -1,39 +0,0 @@
-[config]
-command = record
-args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
-ret     = 1
-
-[event-1:base-record]
-fd=1
-group_fd=-1
-sample_type=343
-read_format=12|28
-inherit=0
-
-[event-2:base-record]
-fd=2
-group_fd=1
-
-# cache-misses
-type=0
-config=3
-
-# default | PERF_SAMPLE_READ
-sample_type=343
-
-# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
-read_format=12|28
-task=0
-mmap=0
-comm=0
-enable_on_exec=0
-disabled=0
-
-# inherit is disabled for group sampling
-inherit=0
-
-# sampling disabled
-sample_freq=0
-sample_period=0
-freq=0
-write_backward=0
diff --git a/tools/perf/tests/attr/test-record-group-sampling1 b/tools/perf/tests/attr/test-record-group-sampling1
new file mode 100644
index 000000000000..9b8730626632
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group-sampling1
@@ -0,0 +1,50 @@
+[config]
+command = record
+args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
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
+sample_type=343
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=28|31
+task=1
+mmap=1
+comm=1
+enable_on_exec=1
+disabled=1
+
+# inherit is enabled for group sampling
+inherit=1
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
+sample_type=343
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=28|31
+task=0
+mmap=0
+comm=0
+enable_on_exec=0
+disabled=0
+freq=0
+
+# inherit is enabled for group sampling
+inherit=1
+
diff --git a/tools/perf/tests/attr/test-record-group-sampling2 b/tools/perf/tests/attr/test-record-group-sampling2
new file mode 100644
index 000000000000..8e29fc13f666
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group-sampling2
@@ -0,0 +1,60 @@
+[config]
+command = record
+args    = --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
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
+read_format=28|31
+task=1
+mmap=1
+comm=1
+enable_on_exec=1
+disabled=1
+
+# inherit is enabled for group sampling
+inherit=1
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
+read_format=28|31
+task=0
+mmap=0
+comm=0
+enable_on_exec=0
+disabled=0
+
+# inherit is enabled for group sampling
+inherit=1
+
+# sampling disabled
+sample_freq=0
+sample_period=0
+freq=0
+write_backward=0
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
index cebdaa8e64e4..785892a54d9e 100644
--- a/tools/perf/tests/attr/test-record-group2
+++ b/tools/perf/tests/attr/test-record-group2
@@ -9,8 +9,9 @@ group_fd=-1
 config=0|1
 sample_period=1234000
 sample_type=87
-read_format=12|28
-inherit=0
+read_format=28|31
+disabled=1
+inherit=1
 freq=0
 
 [event-2:base-record]
@@ -19,9 +20,9 @@ group_fd=1
 config=0|1
 sample_period=6789000
 sample_type=87
-read_format=12|28
+read_format=28|31
 disabled=0
-inherit=0
+inherit=1
 mmap=0
 comm=0
 freq=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..557d409c53d6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1156,7 +1156,15 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		 */
 		if (leader->core.nr_members > 1) {
 			attr->read_format |= PERF_FORMAT_GROUP;
-			attr->inherit = 0;
+		}
+
+		/*
+		 * Inherit + SAMPLE_READ requires SAMPLE_TID in the read_format
+		 */
+		if (attr->inherit) {
+			evsel__set_sample_bit(evsel, TID);
+			evsel->core.attr.read_format |=
+				PERF_FORMAT_ID;
 		}
 	}
 
@@ -1832,6 +1840,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.inherit_sample_read)
+		evsel->core.attr.inherit = 0;
 	if (perf_missing_features.branch_counters)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
 	if (perf_missing_features.read_lost)
@@ -1887,7 +1897,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
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
index 517cff431de2..21b8b7e70e75 100644
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


