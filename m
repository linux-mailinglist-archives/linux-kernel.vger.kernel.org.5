Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE17E7578
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjKJABr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbjKJABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:11 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94114C06;
        Thu,  9 Nov 2023 16:00:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc37fb1310so12618705ad.1;
        Thu, 09 Nov 2023 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574442; x=1700179242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXLxCqlf5n/qGCc38OHpbFSGlVUS7JYGwpo/0dfoHnw=;
        b=ZjhkiPhsBgb/eM8CYz4uidGdm41senxyeojOwtVV6S61p3GUCZuGt+sVTpvmhP114y
         upFHxBZedhVOtX6iMbOiyFnXwcBLGH+YrdxOn/wkHNp4eF3BmrwQP1tgQplQ4OIUpypl
         ry2p4daj3tyAtHj1U86OV7xmWJ7MOi3jdNDUezI7KJVACxJ9pLKUUBAJ9KTLPjp+fi3L
         D0DFgeT2AFswcEeDQfYcLhsgyZa3kCEu0CvtkRj0D0NZRQOTXr/sll0+QF6luiiMeK2+
         NuU3qHiOAYBO6dWtDpjOS84JoSUJI9dPAB2r6Jifx9qPVOy2pAMqb5Z9bXk/ld5K2H9q
         XM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574442; x=1700179242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hXLxCqlf5n/qGCc38OHpbFSGlVUS7JYGwpo/0dfoHnw=;
        b=IwLvmckZLxJ3PcClPOap7G0px8PxYpScIPT/UC1DrdpRsIYl+tG6cacNJLuraojqor
         lDbvbm8kXw2RbU+Lla2YeWk3/TvfeHz8/3WbC8b+EuKY13FBVj9JVBA7eDXVG9V2VJF0
         SR35Im6dpaSMTe3pOSRA2lgadzUb4FwWu86wqGkPIGyNvAL3xz5bAZkE99YVjvsgnWCS
         E2onjb3iM9wpezttpftWR/+H2ycpT8XjuEGfhBtIHuBrmEILz+BvgeTjpd5jpQCJpKms
         7pc/+4Ru4al+cSH9QIIXObl3Rcrv7APm1IXfsblGl3a75PmWzNfmIG3yUfh682OOAi9a
         g8+g==
X-Gm-Message-State: AOJu0Yxpy9PUUSbjOK1oMlOE7N8nKPfHAWt1aM38FvgCbv8NlrBpMwm1
        GFCMXJXVWAzaGvMu810uiiE=
X-Google-Smtp-Source: AGHT+IE16tVXtAfG+JAkRRQbICcGiKDpJUVAfqRLG851iGqVR8Ue7V3A3rwDhdd36iRyTcv+m9YncQ==
X-Received: by 2002:a17:90a:b96:b0:280:3911:adfe with SMTP id 22-20020a17090a0b9600b002803911adfemr2935461pjr.39.1699574442116;
        Thu, 09 Nov 2023 16:00:42 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:41 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 18/52] perf report: Add 'type' sort key
Date:   Thu,  9 Nov 2023 15:59:37 -0800
Message-ID: <20231110000012.3538610-19-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'type' sort key is to aggregate hist entries by data type they
access.  Add mem_type field to hist_entry struct to save the type.
If hist_entry__get_data_type() returns NULL, it'd use the
'unknown_type' instance.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/annotate-data.h          |  2 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 69 +++++++++++++++++++++++-
 tools/perf/util/sort.h                   |  4 ++
 5 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index af068b4f1e5a..aec34417090b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -118,6 +118,7 @@ OPTIONS
 	- retire_lat: On X86, this reports pipeline stall of this instruction compared
 	  to the previous instruction in cycles. And currently supported only on X86
 	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
+	- type: Data type of sample memory access.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ab9f187bd7f1..6efdd7e21b28 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -22,6 +22,8 @@ struct annotated_data_type {
 	int type_size;
 };
 
+extern struct annotated_data_type unknown_type;
+
 #ifdef HAVE_DWARF_SUPPORT
 
 /* Returns data type at the location (ip, reg, offset) */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index afc9f1c7f4dc..9bfed867f288 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -82,6 +82,7 @@ enum hist_column {
 	HISTC_ADDR_TO,
 	HISTC_ADDR,
 	HISTC_SIMD,
+	HISTC_TYPE,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 27b123ccd2d1..e647f0117bb5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -24,6 +24,7 @@
 #include "strbuf.h"
 #include "mem-events.h"
 #include "annotate.h"
+#include "annotate-data.h"
 #include "event.h"
 #include "time-utils.h"
 #include "cgroup.h"
@@ -2094,7 +2095,7 @@ struct sort_entry sort_dso_size = {
 	.se_width_idx	= HISTC_DSO_SIZE,
 };
 
-/* --sort dso_size */
+/* --sort addr */
 
 static int64_t
 sort__addr_cmp(struct hist_entry *left, struct hist_entry *right)
@@ -2131,6 +2132,69 @@ struct sort_entry sort_addr = {
 	.se_width_idx	= HISTC_ADDR,
 };
 
+/* --sort type */
+
+struct annotated_data_type unknown_type = {
+	.type_name = (char *)"(unknown)",
+};
+
+static int64_t
+sort__type_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__addr_cmp(left, right);
+}
+
+static void sort__type_init(struct hist_entry *he)
+{
+	if (he->mem_type)
+		return;
+
+	he->mem_type = hist_entry__get_data_type(he);
+	if (he->mem_type == NULL)
+		he->mem_type = &unknown_type;
+}
+
+static int64_t
+sort__type_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	struct annotated_data_type *left_type = left->mem_type;
+	struct annotated_data_type *right_type = right->mem_type;
+
+	if (!left_type) {
+		sort__type_init(left);
+		left_type = left->mem_type;
+	}
+
+	if (!right_type) {
+		sort__type_init(right);
+		right_type = right->mem_type;
+	}
+
+	return strcmp(left_type->type_name, right_type->type_name);
+}
+
+static int64_t
+sort__type_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__type_collapse(left, right);
+}
+
+static int hist_entry__type_snprintf(struct hist_entry *he, char *bf,
+				     size_t size, unsigned int width)
+{
+	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->type_name);
+}
+
+struct sort_entry sort_type = {
+	.se_header	= "Data Type",
+	.se_cmp		= sort__type_cmp,
+	.se_collapse	= sort__type_collapse,
+	.se_sort	= sort__type_sort,
+	.se_init	= sort__type_init,
+	.se_snprintf	= hist_entry__type_snprintf,
+	.se_width_idx	= HISTC_TYPE,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -2185,7 +2249,8 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_ADDR, "addr", sort_addr),
 	DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
-	DIM(SORT_SIMD, "simd", sort_simd)
+	DIM(SORT_SIMD, "simd", sort_simd),
+	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index ecfb7f1359d5..aabf0b8331a3 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -15,6 +15,7 @@
 
 struct option;
 struct thread;
+struct annotated_data_type;
 
 extern regex_t parent_regex;
 extern const char *sort_order;
@@ -34,6 +35,7 @@ extern struct sort_entry sort_dso_to;
 extern struct sort_entry sort_sym_from;
 extern struct sort_entry sort_sym_to;
 extern struct sort_entry sort_srcline;
+extern struct sort_entry sort_type;
 extern const char default_mem_sort_order[];
 extern bool chk_double_cl;
 
@@ -154,6 +156,7 @@ struct hist_entry {
 	struct perf_hpp_list	*hpp_list;
 	struct hist_entry	*parent_he;
 	struct hist_entry_ops	*ops;
+	struct annotated_data_type *mem_type;
 	union {
 		/* this is for hierarchical entry structure */
 		struct {
@@ -243,6 +246,7 @@ enum sort_type {
 	SORT_LOCAL_RETIRE_LAT,
 	SORT_GLOBAL_RETIRE_LAT,
 	SORT_SIMD,
+	SORT_ANNOTATE_DATA_TYPE,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.42.0.869.gea05f2083d-goog

