Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068E07C637B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376888AbjJLDxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377275AbjJLDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34B01A6;
        Wed, 11 Oct 2023 20:51:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c871a095ceso4550275ad.2;
        Wed, 11 Oct 2023 20:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082701; x=1697687501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4uGboMJlrvaP3U3hMpW0VIY9Dmref5aHpzwpfgI3EY=;
        b=mDxpf5rrWxTOp3ebB9sCQ//Ebi4iqYxePZMUwfWV6w/8poKc3f5g0X2xWerDdAu/og
         lvawdPXgpUQi4sdOsKdzvL62GSgKCWVH2LPZAVgp7TOQIz17B6yFMoz/TwEJ4NlNzY2M
         v63vS0Vq/tDDHu1PChCq9W6zTTFITkGtli4B0rUWHI2ZGkfgAsTeG95Q7PFddidyGNuz
         9V/nSU2DHVz5qkSPrSuBibhL8c+cznltToFnLK+s9bq+0spiiiiLa93WJFVoJJqyJ3Ts
         K72MR5h14Bp6GPQB8mfL7v5bnHMuRPGM+SPONm5kcJrUtCAOUIWMc/2z+1sLg/qhhQR3
         WQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082701; x=1697687501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4uGboMJlrvaP3U3hMpW0VIY9Dmref5aHpzwpfgI3EY=;
        b=Eudw4GN4u6O2HiH3/KA0Hf2lHNimHHMw12PtpBjI1l7+sI1DZGyjmxIAPPLdwiyj71
         wcAEo6ZlKZi+1Hmb0SSHMZ19CMrxZ1/4A5SxUuDcUxmYETtyUBRXm2nJmRm8fni/A+HX
         /wwE4b2uXfNP8inaInBoiA5Uou2GMUCN3wt7mE8ZplTR3AcBjlRwWkcbDkW96g3f9lB5
         RwZrGPfNHMQndxNQDMcY4gZ1GmAa0WR79U/8qw23Ued/vfd73kqhU/hUm9rKdhasr5zn
         2zRv7hekoF5jetvPp7+WK43jZeXE29vcSfb7S4xs99HfcMQoQCyFMe+l9lrlcokvXXYe
         fJkg==
X-Gm-Message-State: AOJu0YxDsl3ZuW+aV1ZrWiSVoxF5QFZ93OgrVvIkNELUA2bPXm9RbYkU
        JyiH2eQi9s7DsICG2cav0kc=
X-Google-Smtp-Source: AGHT+IHXbNOmCQSjVGfizZp9XLZZ6ta0VI7LWSdJEJ2pe+anf6utVqesspw/pobJhAxnFvIlI4lpZQ==
X-Received: by 2002:a17:903:234e:b0:1bc:5924:2da2 with SMTP id c14-20020a170903234e00b001bc59242da2mr22845946plh.56.1697082701083;
        Wed, 11 Oct 2023 20:51:41 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:40 -0700 (PDT)
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
Subject: [PATCH 20/48] perf report: Add 'symoff' sort key
Date:   Wed, 11 Oct 2023 20:50:43 -0700
Message-ID: <20231012035111.676789-21-namhyung@kernel.org>
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
index 98eafef282df..e21bbd442637 100644
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
@@ -2328,6 +2374,7 @@ static struct sort_dimension common_sort_dimensions[] = {
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
2.42.0.655.g421f12c284-goog

