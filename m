Return-Path: <linux-kernel+bounces-153235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E71558ACB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBEFB238DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F41474A2;
	Mon, 22 Apr 2024 10:49:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBCF146A93;
	Mon, 22 Apr 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782988; cv=none; b=OFIBz1ya+8ptsO/zyVxOD9dUoFe9asye86GVzp4f9R/E2p7iciQngPkeZ7HV1hz/wLGNb6oOcnn4vfeeN6QCgBoGf1F2jKKa/9YtIASmyQR/iKppZBcQcFLtCMF35R/cePY3K3h0dlfFJE5kUKpKpH8PYlQDvz4znsvYVqwauTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782988; c=relaxed/simple;
	bh=On1b5DkttpFIhWrjyN3UO9TvEDQ5gy9BpjHBe0K+pQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFip90dsTT+ZKmXfpdMvMWUW6WlIZ6u1EcwRc/sZu9lfbMMKYpyZpX7QKSUVT0kj7j9s30F4mwY4MccKit4WM0fNeZE5CR8svaKvH8nlZpvdET3EulV1F8L7Ndsb4hZttpLdVQKErhabnwWMkpoMujBiB8gSaI3oCINWcwAt17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99FDC339;
	Mon, 22 Apr 2024 03:50:14 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49DFC3F7BD;
	Mon, 22 Apr 2024 03:49:44 -0700 (PDT)
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
Subject: [RFC PATCH v2 4/4] tools/perf: Modify event parser to support alt-period-jitter term
Date: Mon, 22 Apr 2024 11:49:29 +0100
Message-ID: <20240422104929.264241-5-ben.gainey@arm.com>
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

parse-events is modified, adding the "alt-period-jitter" term which
can be used to enable random jitter of the alternative sample
period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/include/uapi/linux/perf_event.h             |  3 ++-
 tools/perf/tests/attr.c                           |  1 +
 tools/perf/tests/attr.py                          |  1 +
 tools/perf/tests/attr/base-record                 |  3 ++-
 tools/perf/tests/attr/base-record-spe             |  3 ++-
 tools/perf/tests/attr/base-stat                   |  1 +
 tools/perf/tests/attr/system-wide-dummy           |  1 +
 .../tests/attr/test-record-alt-period-jitter-term | 12 ++++++++++++
 tools/perf/tests/attr/test-record-dummy-C0        |  1 +
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 12 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-alt-period-jitter-term

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 5c1701d091cf..dd3697a4b300 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -461,7 +461,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				jitter_alternate_period : 1, /* add a limited amount of jitter on each alternate period */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 956b58c7ba8f..7fb5d1d0b0ab 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -140,6 +140,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
 	WRITE_ASS(alternative_sample_period,  "llu");
+	WRITE_ASS(jitter_alternate_period,  "d");
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 75c4527393f9..ecab8e69418f 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -92,6 +92,7 @@ class Event(dict):
         'sample_regs_user',
         'sample_stack_user',
         'alternative_sample_period',
+        'jitter_alternate_period',
     ]
 
     def add(self, data):
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 403de2e2c891..39a7228612c2 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -39,4 +39,5 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
-alternative_sample_period=0
\ No newline at end of file
+alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/base-record-spe b/tools/perf/tests/attr/base-record-spe
index db528d7d8b73..b228cd98cfa1 100644
--- a/tools/perf/tests/attr/base-record-spe
+++ b/tools/perf/tests/attr/base-record-spe
@@ -38,4 +38,5 @@ config2=*
 branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
-alternative_sample_period=0
\ No newline at end of file
+alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index 27ef0fa1386f..d9057d780262 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -40,3 +40,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index 5c4d2a60931d..4d80542c3a68 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -51,3 +51,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/tests/attr/test-record-alt-period-jitter-term b/tools/perf/tests/attr/test-record-alt-period-jitter-term
new file mode 100644
index 000000000000..65f7c06c26e9
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-alt-period-jitter-term
@@ -0,0 +1,12 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,alt-period=2,jitter_alternate_period/ -- kill >/dev/null 2>&1
+ret     = 1
+
+[event-10:base-record]
+sample_period=3
+alternative_sample_period=2
+jitter_alternate_period=1
+
+freq=0
+sample_type=7
\ No newline at end of file
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index d4f0546e02b6..0f3360c35a5e 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -54,3 +54,4 @@ branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
 alternative_sample_period=0
+jitter_alternate_period=0
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d516d84fa1ee..9821e3cd26a4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -774,6 +774,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
 		[PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD]	= "alt-period",
+		[PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER]	= "alt-period-jitter",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -803,6 +804,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -957,6 +959,16 @@ do {									   \
 		}
 		attr->alternative_sample_period = term->val.num;
 		break;
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
+		CHECK_TYPE_VAL(NUM);
+		if ((unsigned int)term->val.num > 1) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected 0 or 1"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->jitter_alternate_period = (term->val.num != 0);
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1084,6 +1096,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1215,6 +1228,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 		default:
 			break;
 		}
@@ -1269,6 +1283,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		case PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 06e7ce8a29ef..2b02c5a6a5f3 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -80,7 +80,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
 	PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD + 1)
+	PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 312a4f1837b9..f5587dff596c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -247,6 +247,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
 alt-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD); }
+alt-period-jitter	{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_PERIOD_JITTER); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-- 
2.44.0


