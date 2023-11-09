Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B1F7E757E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345488AbjKJACO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbjKJABi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:38 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F055146BB;
        Thu,  9 Nov 2023 16:00:50 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc394f4cdfso12438565ad.0;
        Thu, 09 Nov 2023 16:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574450; x=1700179250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZWD+Xm8A+pCVGPG3VW7Xs9+o4dQn/qSi3meRIUI+UM=;
        b=hn34fM5w5RmF8tqgc7sNsruH71/1aIVQzBW2Va0q9FbxSj55YmUJNbJyX3BQj+Kw45
         9aSPqfpBwJ4oEWMxsCUggIcTutC8gQDVx9pxJwWfBCBF40WuB0FHhXDnJJ9TNbJ5p8ja
         pF2xpQQU5bUq8W7vumKOvF+0xr+zovbrIwSCtHushRL+T2mFlKTgXCVKd5kJgfKo7w/a
         6lo9X6CyW70aYtc0VsdOwiFBi3TtoJYiQOjWfaT5KOJZut7pJz60JTO1TIGJCQXAJ7Pr
         dbKZzGQyuISMf2/mxLUyjE2Sk5mLoNhMcXKiorKIjci8cP8lAvZhvd/fb4/ho3pCUxZg
         YcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574450; x=1700179250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZWD+Xm8A+pCVGPG3VW7Xs9+o4dQn/qSi3meRIUI+UM=;
        b=XGE+EEiCP/Ffg6UmLigfr5aoDGVpJYsg5qx9ioGFx9lCvyHIv2p5DPinNoUyYmQZgR
         8kqeaJaoY84O5JIp+Zgk7KpCEsogA5eNXXgzrJS0gOa/bSAA0uNQw37oX0CJmBXmCQwr
         4bWkucmtdX+GmmtjybvTdnlcYACj85IIvvN5VhyDUvbza/YCt3H4CwXok4qJdIhAeQhN
         XPgs5Ba54bGV1rvpxRs8Oz7nUToarysD6te8r4WYgOXWravMt6errd/8IE1Ef/tIoB/D
         5Id9UptH4qcnTiYWm7DpUWIMPKqsYQS+Dv1MiO2uXO5oBhyQbgjGFcK5nOAJE/pCiLOz
         qfFA==
X-Gm-Message-State: AOJu0YzhlAEmSxgD88d6nTSGUzeRqRtLogJ2kLIu4MzLt/WTcb1hdhnw
        8Pl0nuthnYEqjwCyOtT309s=
X-Google-Smtp-Source: AGHT+IHQo/kRvhc5lrELJdyBLPwcI4/yzjO5UJkyDXIgoSSegO+ofnjbUFutrl06Gg0CDORkAkJNCA==
X-Received: by 2002:a17:90b:390b:b0:280:2652:d4e with SMTP id ob11-20020a17090b390b00b0028026520d4emr2895128pjb.29.1699574450352;
        Thu, 09 Nov 2023 16:00:50 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:49 -0800 (PST)
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
Subject: [PATCH 23/52] perf report: Add 'symoff' sort key
Date:   Thu,  9 Nov 2023 15:59:42 -0800
Message-ID: <20231110000012.3538610-24-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symoff sort key is to print symbol and offset of sample.  This is
useful for data type profiling to show exact instruction in the function
which refers the data.

  $ perf report -s type,sym,typeoff,symoff --hierarchy
  ...
  #       Overhead  Data Type / Symbol / Data Type Offset / Symbol Offset
  # ..............  .....................................................
  #
      1.23%         struct cfs_rq
        0.84%         update_blocked_averages
          0.19%         struct cfs_rq +336 (leaf_cfs_rq_list.next)
             0.19%         [k] update_blocked_averages+0x96
          0.19%         struct cfs_rq +0 (load.weight)
             0.14%         [k] update_blocked_averages+0x104
             0.04%         [k] update_blocked_averages+0x31c
          0.17%         struct cfs_rq +404 (throttle_count)
             0.12%         [k] update_blocked_averages+0x9d
             0.05%         [k] update_blocked_averages+0x1f9
          0.08%         struct cfs_rq +272 (propagate)
             0.07%         [k] update_blocked_averages+0x3d3
             0.02%         [k] update_blocked_averages+0x45b
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 47 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 4 files changed, 50 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index b57eb51b47aa..38f59ac064f7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -120,6 +120,7 @@ OPTIONS
 	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
 	- type: Data type of sample memory access.
 	- typeoff: Offset in the data type of sample memory access.
+	- symoff: Offset in the symbol.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 941176afcebc..1ce0ee262abe 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -84,6 +84,7 @@ enum hist_column {
 	HISTC_SIMD,
 	HISTC_TYPE,
 	HISTC_TYPE_OFFSET,
+	HISTC_SYMBOL_OFFSET,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d78e680d3988..0cbbd5ba8175 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -419,6 +419,52 @@ struct sort_entry sort_sym = {
 	.se_width_idx	= HISTC_SYMBOL,
 };
 
+/* --sort symoff */
+
+static int64_t
+sort__symoff_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	int64_t ret;
+
+	ret = sort__sym_cmp(left, right);
+	if (ret)
+		return ret;
+
+	return left->ip - right->ip;
+}
+
+static int64_t
+sort__symoff_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	int64_t ret;
+
+	ret = sort__sym_sort(left, right);
+	if (ret)
+		return ret;
+
+	return left->ip - right->ip;
+}
+
+static int
+hist_entry__symoff_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width)
+{
+	struct symbol *sym = he->ms.sym;
+
+	if (sym == NULL)
+		return repsep_snprintf(bf, size, "[%c] %-#.*llx", he->level, width - 4, he->ip);
+
+	return repsep_snprintf(bf, size, "[%c] %s+0x%llx", he->level, sym->name, he->ip - sym->start);
+}
+
+struct sort_entry sort_sym_offset = {
+	.se_header	= "Symbol Offset",
+	.se_cmp		= sort__symoff_cmp,
+	.se_sort	= sort__symoff_sort,
+	.se_snprintf	= hist_entry__symoff_snprintf,
+	.se_filter	= hist_entry__sym_filter,
+	.se_width_idx	= HISTC_SYMBOL_OFFSET,
+};
+
 /* --sort srcline */
 
 char *hist_entry__srcline(struct hist_entry *he)
@@ -2335,6 +2381,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_SIMD, "simd", sort_simd),
 	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
 	DIM(SORT_ANNOTATE_DATA_TYPE_OFFSET, "typeoff", sort_type_offset),
+	DIM(SORT_SYM_OFFSET, "symoff", sort_sym_offset),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d806adcc1e1e..6f6b4189a389 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -249,6 +249,7 @@ enum sort_type {
 	SORT_SIMD,
 	SORT_ANNOTATE_DATA_TYPE,
 	SORT_ANNOTATE_DATA_TYPE_OFFSET,
+	SORT_SYM_OFFSET,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.42.0.869.gea05f2083d-goog

