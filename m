Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3580FC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377890AbjLMAN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377971AbjLMANp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:13:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0ECCD;
        Tue, 12 Dec 2023 16:13:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d05199f34dso37900225ad.3;
        Tue, 12 Dec 2023 16:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426420; x=1703031220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bFmAjroOIJW8gdT6fLbn3F46nSM2wYTcYmNZQVrmkQ=;
        b=Kef5QH4oS9yhs5VVjwMGSemrTwtwPDBS/WiRyNzVSPhfLS4t9GftqD02YBauw1DEeP
         N+kesqOHHxFOXX0zpGLjug5rT7QISFeFmrjqHcXQnRM1H6aaXpKmE1xNfVSzVKyUoWu2
         JTFivk/ss2mRTwdwLvU7bNlhE3eTL8Hi3dvwiIOc0Z/a+ahsy4J7VWyc4gIrJC0Nqc4S
         Fef3JNCLRnNPJXTiOZgNK9hT0pPXP5jfcDHVIvU5CPnhcC/gYLOnOSK6zV3zwa7nm5Rl
         Gg7n4tomY74ctxMtV5XPNQpb1l5ZzBEFpsoeGXJORb4Hi3dm/TPeVFXON2oyhUzrlyt6
         fTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426420; x=1703031220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7bFmAjroOIJW8gdT6fLbn3F46nSM2wYTcYmNZQVrmkQ=;
        b=Maben6gu514kKUHXhW6/vOouErO/J95151fRh4F/prmiuGDSd79buig07JVCFnt6SC
         isGPAUadD3PGuuppVkDTeXV/EpNhQXGgkbmlAfUa8IsELfjHPKxYmTVJpBVE5cXGomdg
         m+DU6inppmC/1E6fpd+TK2g/syzOL770Oi0XvtHpJ3ZH0erpo0pittR3q2D9LDfjp78X
         RVWrp9rIki8QCsjzgQVs6km3p2ZAHwVQo/PimMHaPJhC3U+QHCJJDI/b/qOK5dhNUXfl
         pwUicBK1GKpB+v8Hh8T+DsS9LR+2Zpweu5qvsUjPZi6V7XjDvUCIuUaMSWPUjHhvdafe
         P+UA==
X-Gm-Message-State: AOJu0YzwPjlaxmHB1mXbOby1Cm781wz/uefbdShe6lYpkqq3MHlVZlIo
        LdxyDJEsy2UwySXbG2fnv11h8HK9viT7TQ==
X-Google-Smtp-Source: AGHT+IEWq2y2PoqSbiSJb+JJgQnf6aBhOcpE0bUST8K3cq/wuj8rE77y9cUQrwPWD3NZzeYkV7rM9Q==
X-Received: by 2002:a17:902:e882:b0:1d0:a146:f859 with SMTP id w2-20020a170902e88200b001d0a146f859mr4510764plg.114.1702426420115;
        Tue, 12 Dec 2023 16:13:40 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:39 -0800 (PST)
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
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 08/17] perf report: Add 'type' sort key
Date:   Tue, 12 Dec 2023 16:13:14 -0800
Message-ID: <20231213001323.718046-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 5d0db96609df..7ebbf427b1ea 100644
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
2.43.0.472.g3155946c3a-goog

