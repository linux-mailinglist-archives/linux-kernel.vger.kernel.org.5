Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446187C6579
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbjJLGYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377489AbjJLGYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744F7DA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c09bcf078so10632477b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091859; x=1697696659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1XV0QFNl94Dga6C5yNB0j7b/b+j1y+ea9fmjMXYiZE=;
        b=ED5zioZlE2JQEYIbZxOIUw0/ikIag2J7aKWATtm8K1f4h3JJdvHw5UOKDveG7N3i5Z
         xt48kuA0sLFwarUHJbmzGCYNX49g3zoLEBABaF+kMO2gdhikcvvv+roP5qoRc+xudako
         Rv7zV/cSnFEP0sM7ipA8Bw48PFDAO+EdHo6SR3mSq+F2ss9uCxF8UkAHkHBYlxPFYV/U
         SCA1GecmlPIl5otdvOka5tRsHaz+V8kgSObPH4IZTSLdR2qLGLu/808QaBE4pTnM5OKT
         OpMUaOveJ8P5EJhMIwe0O0XzNqcxw82IrZcUwcwVLtcar4Imm3a4/TV+GbLMfrBJovF0
         Lbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091859; x=1697696659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1XV0QFNl94Dga6C5yNB0j7b/b+j1y+ea9fmjMXYiZE=;
        b=ukzwgVyInseBLGEi95zuzKTrWJgXt8qQCH5/LHLJBkSh8Rq7NNh/p73cpVUg2pTIV0
         azXAIHT0T9J558P1qgzz8Yk6fSmyOlWWAPn3BWXiDAhIelwgy0OPMLHQt+JsOB/E9EZi
         cuPXYX/FxnRROnUI6cqfuV4R80fZFxUbwal9jeVvmgFzyitJYMG1Ertf0kGpZHm5qOzz
         2oUXl+j1ZbGFm/JSZmQcn8rYSu3jwN/vXU4T6KudpF0OvHc2shDxR8MlPqvsRgH3jWEc
         gjEr7r46uZO7Ww2iccBZXpwjM8u5gxtOXciL8rVfRvJcBYt5JBtrk81r9tlMj7mj79E1
         YHAA==
X-Gm-Message-State: AOJu0YzxshJnh7hOYA6SDa3uACO9hPEZiBiFiFC1ktlrH5UEFU7oE/CE
        tUIPGO5i8dORs8OAb4L8jOTOm0tpc9Oy
X-Google-Smtp-Source: AGHT+IEtnoASSsk/Nird/ZGn7R6QxnVY+UPZa4Hq2teEUgoVuV/bsP6OcU6vLxDnODFIrvfjzKo0NZ50XKFs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a05:690c:c15:b0:5a7:a98a:4af0 with SMTP id
 cl21-20020a05690c0c1500b005a7a98a4af0mr182493ywb.3.1697091859678; Wed, 11 Oct
 2023 23:24:19 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:52 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-7-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 06/13] perf callchain: Make display use of branch_type_stat const
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display code doesn't modify the branch_type_stat so switch uses to
const. This is done to aid refactoring struct callchain_list where
current the branch_type_stat is embedded even if not used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/branch.c    | 4 ++--
 tools/perf/util/branch.h    | 4 ++--
 tools/perf/util/callchain.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index 378f16a24751..ab760e267d41 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -109,7 +109,7 @@ const char *get_branch_type(struct branch_entry *e)
 	return branch_type_name(e->flags.type);
 }
 
-void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
+void branch_type_stat_display(FILE *fp, const struct branch_type_stat *st)
 {
 	u64 total = 0;
 	int i;
@@ -171,7 +171,7 @@ static int count_str_scnprintf(int idx, const char *str, char *bf, int size)
 	return scnprintf(bf, size, "%s%s", (idx) ? " " : " (", str);
 }
 
-int branch_type_str(struct branch_type_stat *st, char *bf, int size)
+int branch_type_str(const struct branch_type_stat *st, char *bf, int size)
 {
 	int i, j = 0, printed = 0;
 	u64 total = 0;
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index e41bfffe2217..87704d713ff6 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -86,8 +86,8 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 const char *branch_type_name(int type);
 const char *branch_new_type_name(int new_type);
 const char *get_branch_type(struct branch_entry *e);
-void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
-int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
+void branch_type_stat_display(FILE *fp, const struct branch_type_stat *st);
+int branch_type_str(const struct branch_type_stat *st, char *bf, int bfsize);
 
 const char *branch_spec_desc(int spec);
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index aee937d14fbb..229cedee1e68 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1339,7 +1339,7 @@ static int count_float_printf(int idx, const char *str, float value,
 static int branch_to_str(char *bf, int bfsize,
 			 u64 branch_count, u64 predicted_count,
 			 u64 abort_count,
-			 struct branch_type_stat *brtype_stat)
+			 const struct branch_type_stat *brtype_stat)
 {
 	int printed, i = 0;
 
@@ -1403,7 +1403,7 @@ static int counts_str_build(char *bf, int bfsize,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 iter_cycles,
 			     u64 from_count,
-			     struct branch_type_stat *brtype_stat)
+			     const struct branch_type_stat *brtype_stat)
 {
 	int printed;
 
@@ -1430,7 +1430,7 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 abort_count, u64 cycles_count,
 				   u64 iter_count, u64 iter_cycles,
 				   u64 from_count,
-				   struct branch_type_stat *brtype_stat)
+				   const struct branch_type_stat *brtype_stat)
 {
 	char str[256];
 
-- 
2.42.0.609.gbb76f46606-goog

