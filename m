Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7D7C6378
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjJLDxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376949AbjJLDw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D59192;
        Wed, 11 Oct 2023 20:51:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5bf7871dcso4611945ad.1;
        Wed, 11 Oct 2023 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082700; x=1697687500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHmw97A1IWYhjKuWWW4L0EcNMYU+9RoJiaUerA0LE9w=;
        b=UFaw8n6RJO7CjSWokzA1IMHysCI1LIwdyiSzfr0VC1jQ+aQHFy5RXyFL/V9mKswVjA
         29pcWaQKmbx436DJSuSLlgcngBKWuEGR8nLiOo4u5hkX5PcgO6VhH48npqK5gVS0YiQI
         SsJFug+vucbzzgis41RZElnNdagFLqzsO6qieMaU/aA3T66eZQuIXpn4JBcfQzYC3i6T
         o5c5lSb1jqCM453FpBXa6cokO6a8OSjVe1BIhBT3JdWuYovB2gZRBhlSsZRhRL9RjOQi
         06J0z7IGk1QO8CIqACoVUXXZwrch05pINbN1BxwrxMpmSpl2y7TXjEafokim1WOOy5hk
         Y61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082700; x=1697687500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GHmw97A1IWYhjKuWWW4L0EcNMYU+9RoJiaUerA0LE9w=;
        b=lprHItjvbqnrcaQ6rO3h7JFlB3iWdQXQ7DGG2WRpWJa0Fr1z0wz3+s3bSrwg/l7GZ5
         TJJ/g34sz7CdM18ygH2v+21uwCUxs6d8mFUMvh/PQpubJ7mJLo/4aVxCaTtHCQAinhlv
         eopeQQZ3fPy22JLpAXTmZaMKTK/Lwo9ihKabcIYyoJT/uK06eGxBQC2tLtg/pkLGwbQZ
         YmLtdR2YDgXj5ymzNgKjd8TaDGWP0W+eW3liP5NjTWJ3XXkU9mNPhM8HxoTir8I9d1tJ
         JQXcO9kllzGaBt6whr1kIoPo3S4p/RIvgVZhC+0YdCUiJUUh5hlel+6ZHE14CjXirIET
         LPZA==
X-Gm-Message-State: AOJu0Yx6F5zudyNy3fVaN33GLx3M7boaFa69Mi6NuvPJsnqbOeiTT90x
        c9qKj45IyzjwbdeXDCc8xas=
X-Google-Smtp-Source: AGHT+IFT7BrXbhSOfJkEnU1yNeX4XrRXF4IzRri7PbcVmijktKEh3jTa/vXSUxvnQYUWzY/AXq30wg==
X-Received: by 2002:a17:902:ecc5:b0:1c6:e8d:29ea with SMTP id a5-20020a170902ecc500b001c60e8d29eamr24453456plh.60.1697082699795;
        Wed, 11 Oct 2023 20:51:39 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:39 -0700 (PDT)
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
Subject: [PATCH 19/48] perf report: Add 'typeoff' sort key
Date:   Wed, 11 Oct 2023 20:50:42 -0700
Message-ID: <20231012035111.676789-20-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index ab942331720d..49d5b61e19e6 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3679,6 +3679,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
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
index 01300831333e..98eafef282df 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -2146,8 +2146,10 @@ static void sort__type_init(struct hist_entry *he)
 		return;
 
 	he->mem_type = hist_entry__get_data_type(he);
-	if (he->mem_type == NULL)
+	if (he->mem_type == NULL) {
 		he->mem_type = &unknown_type;
+		he->mem_type_off = 0;
+	}
 }
 
 static int64_t
@@ -2191,6 +2193,84 @@ struct sort_entry sort_type = {
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
@@ -2247,6 +2327,7 @@ static struct sort_dimension common_sort_dimensions[] = {
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
2.42.0.655.g421f12c284-goog

