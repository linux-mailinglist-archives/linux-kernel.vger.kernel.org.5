Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2563D810651
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378163AbjLMAO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377930AbjLMAOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:14:10 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC971BF;
        Tue, 12 Dec 2023 16:13:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d0ccda19eeso39492205ad.1;
        Tue, 12 Dec 2023 16:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426429; x=1703031229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4UEMHhiignCwX0EjxC7/0B5MhyjQn86th3on3YHVjY=;
        b=YB5Gx0VhKM5KpNaWf89X3AlRS615oRwOZdVZp8nk2SQAzwyh/cSwYb5KRIF5w27PmP
         Wz1gtz12XqO8kTP4Wjgcc6Fs2/ZzN8msPZAPtbOrYEM79Bvl7UCw4QrN+R95LXR0fGEj
         kXX2ez7f7ysEaSv8mM3eUJoUoH6hYutfZYBnscJDT2Mr5vchIX8RtowfB7bnF83JGkj9
         MiqlB5ZU9Vz+F7kRpAR6MwFWggR68YgygOY9Ir4X8/OQG5O49N+Bao+eCmAGCXz6e3OG
         MrZe+0aPQBLKw1GkND4JbwSVaQTxbIoZhknaFNMRJeGqlBIc3qDhE6ZDI4F5elmqXHc7
         DZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426429; x=1703031229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4UEMHhiignCwX0EjxC7/0B5MhyjQn86th3on3YHVjY=;
        b=ihe4CqDf45HpVjBcaLrIzI0vbE8o+qnmz82u5Kg8qRawq7WF0Gq2FjibUOjPrqXacO
         s+rRmhIrHIqLFndwQqmiThxkH5f/8q/5n9ZSvGGGA5zWRkVNz+VbIAXJp2m7NluGTCOc
         lFapJf59LM5pzQWrQZPZP29Nw6tPcVFyx+RTWKyIdNoB9dykLYJfQKeYyWlwkhej5OSo
         7mTIvzXnR0u+XlaMheWtHcji8aslmT4S+zkXiOWUSZkI71Xwr0EIzzTIHBPlBPrWMbjJ
         dDGJ0ri4wjbmRvKkvOQhhThMsqRTgOkCEU56kBT1gEDZl1myK/PWHonNdHXckenKFgVS
         JneA==
X-Gm-Message-State: AOJu0YwBBgkPk/+VOAUfzOaRV6Ltjy7yuu1x9syHmm/5j1wV7u5HqD2V
        AKBE/zBJZl04WUgLgo0v+5U=
X-Google-Smtp-Source: AGHT+IF1ppacjeHy1QfN9R1urpl1T+hzGF2wUXlm405kbRKcpjG2u6jFQo0KPZygdhNc6Ot3ItKiRg==
X-Received: by 2002:a17:903:44a:b0:1cc:446c:770c with SMTP id iw10-20020a170903044a00b001cc446c770cmr3763140plb.33.1702426429067;
        Tue, 12 Dec 2023 16:13:49 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:8251:f360:4316:214e])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b001d0ab572458sm9136398plr.121.2023.12.12.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 16:13:48 -0800 (PST)
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
Subject: [PATCH 13/17] perf report: Add 'symoff' sort key
Date:   Tue, 12 Dec 2023 16:13:19 -0800
Message-ID: <20231213001323.718046-14-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213001323.718046-1-namhyung@kernel.org>
References: <20231213001323.718046-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 18128a49309e..4a0aea0c9e00 100644
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
2.43.0.472.g3155946c3a-goog

