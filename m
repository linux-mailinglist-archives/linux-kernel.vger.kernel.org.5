Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75002787DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbjHYCku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbjHYCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BD81FD5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77bd411d7eso572967276.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931234; x=1693536034;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+zdRFvr84d+fBWt10B0hHI/TeqmfF3seVVv15ew7F8=;
        b=HZSXLXGkuLPKgBuf4pk6J10eXiT7nvHcO4Exh1bIycY3L3BPD0nK3nX5wfOGHMWkDv
         fOGkuKwMhGemx7niIQSm5B6O3bwh2/0NdB86qMH9C6emksooUVvhet30JMKyQh2/8Ftc
         uRM999s3VRcT4ThF81DOXn0sQrFYDM/V3skOcZ0TaZeTpqp6uJHBEixUnhOsv7YIB6vU
         WfbAcOLPK86fNr+Iv4agkDrrY71JNNbNgU+M3vOuMK4jKOGS0aIQzHZy5v952AFnwYgx
         C4e04r+BRwB9Ud6KpXJe+k2b6OlJ6QK9VdDzYDudMRI3FVJHzcA1nw71vUwAvb3I4dih
         +IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931234; x=1693536034;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+zdRFvr84d+fBWt10B0hHI/TeqmfF3seVVv15ew7F8=;
        b=WVCU1cKWAWHiNAMQaj/e9x2kTjLn4JnDfV4+fKLh9gyCIVn8vzFrvT8VOq/5dyTPS/
         9/SrjNdgm4ixrnUlPNx0HaV0iHX02qUEgbyFsS9oYIAT1JmM0rKzjlsBMP4r5chZfGzC
         3hHtZ4zrGCA+jBCL2GzipdFXwD2u91onv3qjnI1mNnyd3kSu/oLRli91tnBE0StBXrZv
         IHHR9Vc+Qz+7q2VyZZP0okrZobO/hlh+7T6stAgc2P0nAwFXoVXqJggrbYxpNTchU9Py
         mzw/EZNV+My0tbGKVV7qSoayp/480zB4Wjfkj1YZ1CHE6NnXdTZbkRno0xNNjK37XSzJ
         Xvxg==
X-Gm-Message-State: AOJu0Ywg8e74SQg7McbX87IFW4YAesqkgdsRDzM9/gCmopoII65NvtFQ
        J9nYa1R8F08IvoBqSI/jUQi2dh4MUjgD
X-Google-Smtp-Source: AGHT+IEzM4glBr+PazUhBNmMADT2m3Tq6v7cCwDbE9cQUy4ophVAFva8E+T9hCeg0cPS0+531uZjKd8AAFZM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a25:aa06:0:b0:d15:d6da:7e97 with SMTP id
 s6-20020a25aa06000000b00d15d6da7e97mr319274ybi.3.1692931234631; Thu, 24 Aug
 2023 19:40:34 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:39:59 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-4-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 3/6] perf parse-events: Make term's config const
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids casts in tests. Use zfree in a few places to avoid
warnings about a freeing a const pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c         | 18 +++++++++---------
 tools/perf/util/parse-events.c | 10 +++++-----
 tools/perf/util/parse-events.h |  4 ++--
 tools/perf/util/pmu.c          |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index c204ed1f1a8b..eb60e5f66859 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -28,55 +28,55 @@ static struct test_format {
 /* Simulated users input. */
 static struct parse_events_term test_terms[] = {
 	{
-		.config    = (char *) "krava01",
+		.config    = "krava01",
 		.val.num   = 15,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava02",
+		.config    = "krava02",
 		.val.num   = 170,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava03",
+		.config    = "krava03",
 		.val.num   = 1,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava11",
+		.config    = "krava11",
 		.val.num   = 27,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava12",
+		.config    = "krava12",
 		.val.num   = 1,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava13",
+		.config    = "krava13",
 		.val.num   = 2,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava21",
+		.config    = "krava21",
 		.val.num   = 119,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava22",
+		.config    = "krava22",
 		.val.num   = 11,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
 	},
 	{
-		.config    = (char *) "krava23",
+		.config    = "krava23",
 		.val.num   = 2,
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 621bdd157a0f..4c812fbe0cf9 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -199,7 +199,7 @@ static void fix_raw(struct list_head *config_terms, struct perf_pmu *pmu)
 			continue;
 
 		if (perf_pmu__have_event(pmu, term->val.str)) {
-			free(term->config);
+			zfree(&term->config);
 			term->config = term->val.str;
 			term->type_val = PARSE_EVENTS__TERM_TYPE_NUM;
 			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
@@ -208,7 +208,7 @@ static void fix_raw(struct list_head *config_terms, struct perf_pmu *pmu)
 			continue;
 		}
 
-		free(term->config);
+		zfree(&term->config);
 		term->config = strdup("config");
 		errno = 0;
 		num = strtoull(term->val.str + 1, NULL, 16);
@@ -1416,7 +1416,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 	struct perf_pmu *pmu = NULL;
 	YYLTYPE *loc = loc_;
 	int ok = 0;
-	char *config;
+	const char *config;
 
 	*listp = NULL;
 
@@ -1435,7 +1435,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				   PARSE_EVENTS__TERM_TYPE_USER,
 				   config, 1, false, NULL,
 					NULL) < 0) {
-		free(config);
+		zfree(&config);
 		goto out_err;
 	}
 	list_add_tail(&term->list, head);
@@ -2378,7 +2378,7 @@ static int new_term(struct parse_events_term **_term,
 }
 
 int parse_events_term__num(struct parse_events_term **term,
-			   int type_term, char *config, u64 num,
+			   int type_term, const char *config, u64 num,
 			   bool no_value,
 			   void *loc_term_, void *loc_val_)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c4e8d8e94b28..6d75d853ce00 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -83,7 +83,7 @@ enum {
 };
 
 struct parse_events_term {
-	char *config;
+	const char *config;
 	union {
 		char *str;
 		u64  num;
@@ -138,7 +138,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 void parse_events__shrink_config_terms(void);
 int parse_events__is_hardcoded_term(struct parse_events_term *term);
 int parse_events_term__num(struct parse_events_term **term,
-			   int type_term, char *config, u64 num,
+			   int type_term, const char *config, u64 num,
 			   bool novalue,
 			   void *loc_term, void *loc_val);
 int parse_events_term__str(struct parse_events_term **term,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a96ccc5c3b51..eb42f9830be7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1418,7 +1418,7 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 					     struct parse_events_term *term)
 {
 	struct perf_pmu_alias *alias;
-	char *name;
+	const char *name;
 
 	if (parse_events__is_hardcoded_term(term))
 		return NULL;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

