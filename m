Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E9810650
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378096AbjLMAO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378076AbjLMAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:10 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15119E;
        Tue, 12 Dec 2023 16:13:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so38279105ad.1;
        Tue, 12 Dec 2023 16:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426427; x=1703031227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfai8ZdPoFkOghSjq9znXjq6BNqecnfi+Uhs1ECso1A=;
        b=D5DrRpXu+zfsX4V3yLUVs3Kul6DMLqDVJEtiqcXuhfTcLYEV+kaUlp/TX2Yh8Pv2wv
         SeV9Ah1Iy5sNPj6zKTkwb2ZYiBidtG5ySzegpSRiR16AkduK0P0D0qOcDCxOd/slBxEK
         vhkEixmWWmGiOWosX6dkbklRkikRrBg9HH7MaaECBCRcK0yB65xI7SfwrTsc7EDbCfei
         qNZ2XWAmUy0d0kFY8t51OR8AP/XwD1ibiwR9cIzB1dZiRpN7c67PsHsS/IdZeaHWeKb1
         7Fwy1q/YfQANMREGQBW80mkzzZolAjzxt8whZn7MTaqaj6prmPSaK0Kw1aBYRoYnok+c
         SEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426427; x=1703031227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pfai8ZdPoFkOghSjq9znXjq6BNqecnfi+Uhs1ECso1A=;
        b=n5QGPf58e0PZmaiuDbOgWvuUxsmNqNbYttEdP4nca8ce1okW01snUHjnykU56kXbYU
         zL6cpbGbHl/3o8yV6UzUAGebbDrssb3O07afIHiH2kxgbVWE8FCYA90dWsM2nP2xd+IH
         E0h/AUJLHgZhNzJTtVThZMGKN6xAswxeciZi/JzYfyO/laB2f3joAZwYVhUPZqter0Ap
         4QVFc+hFv/Jmz3QnBt9in2OwMvQsI0OqXG/6VDBfIKCnCZoW3FmGD38E2mHZErPRwsAO
         glNFo8wgh2Jhr5hdMj8LZpC7mwzxhSan8cRQFYFzz9K1Q020x5eNtx8LpXVciSZPHzoU
         iRWQ==
X-Gm-Message-State: AOJu0Yy+V4N/JMbqwJm6hrx11Lky5nfsInmPJaBF0HSw83j2E8i99yMj
        8YJLYbFHxbPNxHwZ3BVZx/0=
X-Google-Smtp-Source: AGHT+IEQv/3O/pCqDYWfxLwO4ADDBR5X/wzQSIYVsEkjv/f+oLsDr55MjfGukHUMFYLubX4r99wccg==
X-Received: by 2002:a17:903:11cd:b0:1d3:2e0e:c889 with SMTP id q13-20020a17090311cd00b001d32e0ec889mr2318864plh.62.1702426427405;
        Tue, 12 Dec 2023 16:13:47 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:46 -0800 (PST)
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
Subject: [PATCH 12/17] perf report: Add 'typeoff' sort key
Date:   Tue, 12 Dec 2023 16:13:18 -0800
Message-ID: <20231213001323.718046-13-namhyung@kernel.org>
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
index 6747779ecef8..f966e8f83c5e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3716,6 +3716,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 						    op_loc->offset,
 						    he->stat.nr_events,
 						    he->stat.period);
+		he->mem_type_off = op_loc->offset;
 		return mem_type;
 	}
 	return NULL;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 7ebbf427b1ea..18128a49309e 100644
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
2.43.0.472.g3155946c3a-goog

