Return-Path: <linux-kernel+bounces-153234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01988ACB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC051C20BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C2146A9B;
	Mon, 22 Apr 2024 10:49:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149414430B;
	Mon, 22 Apr 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782986; cv=none; b=o3neGfAaY2KSjE10J9RuXBWHU4v8z63YNB7ZQPOcioCL7KUNn41k3YwgaLSsQTSVWBoVx/5T7Mi9iSSZAw/VYm/V5MxjI1/ruRu2N15mWUTX+F62HfhFj/QsDVMeKMpg4hW7tAbanertBPSaTMA1LzzTZLka3wt4YOGRuE+yTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782986; c=relaxed/simple;
	bh=m+SmtbuOXbxQXWB/pl6e09Xr7+eW1EW7GI1DlSpYm6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bndt5pGfAYdT1iBKDJWeuYK94BstS0okiSDO+0L+oNrah+TjW285aqhTHh7oxlsBWYZhTXZrvNK+PMcF/tKbX7v6+x5pSdNZ+az0ITgVblvoOKjBVvjNCECXnO/Xfq/77LhwdsBZnsxf8HdPjFEcMHD6HfI1KDVkwu3s4Zzj8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5A4150C;
	Mon, 22 Apr 2024 03:50:12 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E1393F7BD;
	Mon, 22 Apr 2024 03:49:41 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [RFC PATCH v2 3/4] tools/perf: Modify event parser to support alt-period term
Date: Mon, 22 Apr 2024 11:49:28 +0100
Message-ID: <20240422104929.264241-4-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422104929.264241-1-ben.gainey@arm.com>
References: <20240422104929.264241-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse-events is modified, adding the "alt-period" term which can be used
to specify the alternative sampling period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/include/uapi/linux/perf_event.h             |  3 +++
 tools/perf/tests/attr.c                           |  1 +
 tools/perf/tests/attr.py                          |  1 +
 tools/perf/tests/attr/base-record                 |  3 ++-
 tools/perf/tests/attr/base-record-spe             |  1 +
 tools/perf/tests/attr/base-stat                   |  3 ++-
 tools/perf/tests/attr/system-wide-dummy           |  3 ++-
 tools/perf/tests/attr/test-record-alt-period-term | 11 +++++++++++
 tools/perf/tests/attr/test-record-dummy-C0        |  3 ++-
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c         |  1 +
 13 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-alt-period-term

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3a64499b0f5d..5c1701d091cf 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: alternative_sample_period */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -522,6 +523,8 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u64	alternative_sample_period;
 };
 
 /*
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 97e1bdd6ec0e..956b58c7ba8f 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -139,6 +139,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(branch_sample_type, "llu");
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
+	WRITE_ASS(alternative_sample_period,  "llu");
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index e890c261ad26..75c4527393f9 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -91,6 +91,7 @@ class Event(dict):
         'branch_sample_type',
         'sample_regs_user',
         'sample_stack_user',
+        'alternative_sample_period',
     ]
 
     def add(self, data):
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index b44e4e6e4443..403de2e2c891 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=136
+size=144
 config=0|1
 sample_period=*
 sample_type=263
@@ -39,3 +39,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
\ No newline at end of file
diff --git a/tools/perf/tests/attr/base-record-spe b/tools/perf/tests/attr/base-record-spe
index 08fa96b59240..db528d7d8b73 100644
--- a/tools/perf/tests/attr/base-record-spe
+++ b/tools/perf/tests/attr/base-record-spe
@@ -38,3 +38,4 @@ config2=*
 branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
+alternative_sample_period=0
\ No newline at end of file
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index fccd8ec4d1b0..27ef0fa1386f 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=136
+size=144
 config=0
 sample_period=0
 sample_type=65536
@@ -39,3 +39,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index a1e1d6a263bf..5c4d2a60931d 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=1
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
@@ -50,3 +50,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
diff --git a/tools/perf/tests/attr/test-record-alt-period-term b/tools/perf/tests/attr/test-record-alt-period-term
new file mode 100644
index 000000000000..ccbebfcbd194
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-alt-period-term
@@ -0,0 +1,11 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,alt-period=2/ -- kill >/dev/null 2>&1
+ret     = 1
+
+[event-10:base-record]
+sample_period=3
+alternative_sample_period=2
+
+freq=0
+sample_type=7
\ No newline at end of file
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 576ec48b3aaf..d4f0546e02b6 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -10,7 +10,7 @@ cpu=0
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=4000
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
@@ -53,3 +53,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f8b0fa17689..d516d84fa1ee 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -773,6 +773,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD]	= "alt-period",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -801,6 +802,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -945,6 +947,16 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		CHECK_TYPE_VAL(NUM);
+		if (term->val.num == 0) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected a non-zero value"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->alternative_sample_period = term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1071,6 +1083,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1201,6 +1214,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 		default:
 			break;
 		}
@@ -1254,6 +1268,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 809359e8544e..06e7ce8a29ef 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,7 +79,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index e86c45675e1d..312a4f1837b9 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -246,6 +246,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+alt-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 8f04d3b7f3ec..61acd99e08f5 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -323,6 +323,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
+	PRINT_ATTRf(alternative_sample_period, p_unsigned);
 
 	return ret;
 }
-- 
2.44.0


