Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C357E757C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjKJACD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbjKJABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8435046AF;
        Thu,  9 Nov 2023 16:00:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28023eadc70so1292033a91.2;
        Thu, 09 Nov 2023 16:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574449; x=1700179249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRCqm2GnkYmrLuCjylP2f18LqkR0iX6lcZ1rY/e/O1s=;
        b=PTNZoxaOyGrU5x78JhEZOBreSu3Mmec4esEkMB3tzF0WLY3CA6CyCI0CSUXwt+8DYG
         d2w81TTF1g6Gim826PtHRdP92j4tAP9W7FeZkfR2Fnfcdk5FvLhsxdRUyHxAmof3Z/90
         V8eRhxFOWL/086LQvX9JD/aATq/8J0mg3A7eyLwoHiq+AKmJ7jFKBav3PI+FVAxvH+5a
         V75DTQ65cR1liphkop3iCsAQKqgcx8fE2ejfSTIlLj3cPEt5TOI1+ElBER+nSCE6kkbH
         QdwDANyzwTFKQ7KPsW1O50svYwtXuGCZ+LsmAQD84mESl2iRY3QwUOz+qQ+clwrZKMra
         fC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574449; x=1700179249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BRCqm2GnkYmrLuCjylP2f18LqkR0iX6lcZ1rY/e/O1s=;
        b=ZU6jDnzlSKiS3UG0Wwu8OnmnG2VDAHEFkEe4ScFxxCPkLrUegmL4egPxkoDF4sI9HT
         aUOUZdjTZKChM2EmS3paRhVJEfzmZTrZnH3iSmbRDOa5nKC4UzsA7IAKprE69/wZJOD3
         1M0fqpNn35WuiiFHRB3By3hdEQP15SCiLxZSocrMZtvaptYIejTFac9h1JgZD+1/DRje
         YDdxlKP3gRd6gk109uHF07DFtxhzENiqNbzi3EcFpP/Zeyt1nubQOsjuZmx8jaD8qiPN
         FhC/qC7k7Yb0ndhNirUVUW41BC35W6lIYmO2TZKajH3a52EjCc7u9WQ0D+hDCa63p1Ll
         BZKA==
X-Gm-Message-State: AOJu0Ywn8Ief9G6pkOxj1pW2N5m3YUfu9JQFPfo3M8qQEo4jDZR29pev
        EngEO65aQjaUh6GjYJwkO1U=
X-Google-Smtp-Source: AGHT+IHFO55iZ4g4+DQZGg2ugAkjYW64pdtPH/chbAneIr2uFKK/XwoLQZTAEl1uS5FbFituC7sNDQ==
X-Received: by 2002:a17:90b:4b12:b0:27d:882f:e6c5 with SMTP id lx18-20020a17090b4b1200b0027d882fe6c5mr3317267pjb.9.1699574448539;
        Thu, 09 Nov 2023 16:00:48 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:47 -0800 (PST)
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
Subject: [PATCH 22/52] perf report: Add 'typeoff' sort key
Date:   Thu,  9 Nov 2023 15:59:41 -0800
Message-ID: <20231110000012.3538610-23-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The typeoff sort key shows the data type name, offset and the name of
the field.  This is useful to see which field in the struct is accessed
most frequently.

  $ perf report -s type,typeoff --hierarchy --stdio
  ...
  #     Overhead  Data Type / Data Type Offset
  # ............  ............................
  #
  ...
        1.23%     struct cfs_rq
           0.19%    struct cfs_rq +404 (throttle_count)
           0.19%    struct cfs_rq +0 (load.weight)
           0.19%    struct cfs_rq +336 (leaf_cfs_rq_list.next)
           0.09%    struct cfs_rq +272 (propagate)
           0.09%    struct cfs_rq +196 (removed.nr)
           0.09%    struct cfs_rq +80 (curr)
           0.09%    struct cfs_rq +544 (lt_b_children_throttled)
           0.06%    struct cfs_rq +320 (rq)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/annotate.c               |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 83 +++++++++++++++++++++++-
 tools/perf/util/sort.h                   |  2 +
 5 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index aec34417090b..b57eb51b47aa 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -119,6 +119,7 @@ OPTIONS
 	  to the previous instruction in cycles. And currently supported only on X86
 	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
 	- type: Data type of sample memory access.
+	- typeoff: Offset in the data type of sample memory access.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 049d6ba394bd..76309f1e6e39 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3717,6 +3717,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 						    op_loc->offset,
 						    he->stat.nr_events,
 						    he->stat.period);
+		he->mem_type_off = op_loc->offset;
 		return mem_type;
 	}
 	return NULL;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 9bfed867f288..941176afcebc 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -83,6 +83,7 @@ enum hist_column {
 	HISTC_ADDR,
 	HISTC_SIMD,
 	HISTC_TYPE,
+	HISTC_TYPE_OFFSET,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a41209e242ae..d78e680d3988 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2153,8 +2153,10 @@ static void sort__type_init(struct hist_entry *he)
 		return;
 
 	he->mem_type = hist_entry__get_data_type(he);
-	if (he->mem_type == NULL)
+	if (he->mem_type == NULL) {
 		he->mem_type = &unknown_type;
+		he->mem_type_off = 0;
+	}
 }
 
 static int64_t
@@ -2198,6 +2200,84 @@ struct sort_entry sort_type = {
 	.se_width_idx	= HISTC_TYPE,
 };
 
+/* --sort typeoff */
+
+static int64_t
+sort__typeoff_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	struct annotated_data_type *left_type = left->mem_type;
+	struct annotated_data_type *right_type = right->mem_type;
+	int64_t ret;
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
+	ret = strcmp(left_type->self.type_name, right_type->self.type_name);
+	if (ret)
+		return ret;
+	return left->mem_type_off - right->mem_type_off;
+}
+
+static void fill_member_name(char *buf, size_t sz, struct annotated_member *m,
+			     int offset, bool first)
+{
+	struct annotated_member *child;
+
+	if (list_empty(&m->children))
+		return;
+
+	list_for_each_entry(child, &m->children, node) {
+		if (child->offset <= offset && offset < child->offset + child->size) {
+			int len = 0;
+
+			/* It can have anonymous struct/union members */
+			if (child->var_name) {
+				len = scnprintf(buf, sz, "%s%s",
+						first ? "" : ".", child->var_name);
+				first = false;
+			}
+
+			fill_member_name(buf + len, sz - len, child, offset, first);
+			return;
+		}
+	}
+}
+
+static int hist_entry__typeoff_snprintf(struct hist_entry *he, char *bf,
+				     size_t size, unsigned int width __maybe_unused)
+{
+	struct annotated_data_type *he_type = he->mem_type;
+	char buf[4096];
+
+	buf[0] = '\0';
+	if (list_empty(&he_type->self.children))
+		snprintf(buf, sizeof(buf), "no field");
+	else
+		fill_member_name(buf, sizeof(buf), &he_type->self,
+				 he->mem_type_off, true);
+	buf[4095] = '\0';
+
+	return repsep_snprintf(bf, size, "%s %+d (%s)", he_type->self.type_name,
+			       he->mem_type_off, buf);
+}
+
+struct sort_entry sort_type_offset = {
+	.se_header	= "Data Type Offset",
+	.se_cmp		= sort__type_cmp,
+	.se_collapse	= sort__typeoff_sort,
+	.se_sort	= sort__typeoff_sort,
+	.se_init	= sort__type_init,
+	.se_snprintf	= hist_entry__typeoff_snprintf,
+	.se_width_idx	= HISTC_TYPE_OFFSET,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -2254,6 +2334,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
 	DIM(SORT_SIMD, "simd", sort_simd),
 	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
+	DIM(SORT_ANNOTATE_DATA_TYPE_OFFSET, "typeoff", sort_type_offset),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index aabf0b8331a3..d806adcc1e1e 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -113,6 +113,7 @@ struct hist_entry {
 	u64			p_stage_cyc;
 	u8			cpumode;
 	u8			depth;
+	int			mem_type_off;
 	struct simd_flags	simd_flags;
 
 	/* We are added by hists__add_dummy_entry. */
@@ -247,6 +248,7 @@ enum sort_type {
 	SORT_GLOBAL_RETIRE_LAT,
 	SORT_SIMD,
 	SORT_ANNOTATE_DATA_TYPE,
+	SORT_ANNOTATE_DATA_TYPE_OFFSET,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.42.0.869.gea05f2083d-goog

