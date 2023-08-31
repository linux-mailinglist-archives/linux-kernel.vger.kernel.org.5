Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F28378E706
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbjHaHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245389AbjHaHOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 03:14:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0C2CC5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:14:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7493303b5cso373779276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 00:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693466089; x=1694070889; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5R5LTR1o+O1ggaXGLd8xlIboaGHj+v+QmwBBnwG6HY=;
        b=Cq7lo1IsSWnaAKZ03XF+9nF2kWY28QTYe5oNRGuEcHsNbGNvP7TdnDOGPIRTfHrttJ
         VPHFS5994RjABbYdG2WHEXx9uGCqCkyaIZViCcvri1mVjhvnwjRt6MuphLdDV3zWylqq
         zPLypU1yIusm7/jnz9sa66XxDNPJRgB5526iQTwwIcvSot/EgLKgM+elkXV6GoP4r+Xw
         T9YV6MixOAN+iXObYa1iJpKtIUnYssDC7IjYGO8eet7SWPtBDlhod1qLN7yPjLmnXkP0
         yvFb+os9FinfF72UVvEaoIz7nn/TNX4oTjPGb4XanKs2opcSFa8Y8QA90a5FAjRmUDaB
         NJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693466089; x=1694070889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5R5LTR1o+O1ggaXGLd8xlIboaGHj+v+QmwBBnwG6HY=;
        b=lKLYNaJVg20xFhpXebL5qR/YQfDIivnJFOqaf4051HcMT4miBqboyRXtpr80OtHRPp
         3m9kKj7X9uFPUL9FIo/kPBUXD0MlnEQ3UrlUl7GjLynARjWgclO+YPjFuHyq+qPBHuoI
         AnXRhIu0mHZNvwnuvOug8b+tPXzwa62x9ECG/lr31uT9UjmcCYVkKdqcD9LmtGc1h+2F
         Fz9EYmaA2QeZHHuJVAPMbktfG9ji2NrCN1F8NF0KMSPHTNhaJME2Ldk53C/aCDfW5Kv7
         6R/shHTIrmmMA1K8YKX4qq72QkciATpIioKJYxxsbDCPLw3YlSiQBwOtCFfN40hxxwdT
         SGCg==
X-Gm-Message-State: AOJu0YwUda9Kiw55HWXpGrKjxSD7S5BetcNu8XS4gGLqo0fvZgK0bfTm
        dWH6cOrgxqkEALB2aG5R4BnAe/1tCgeN
X-Google-Smtp-Source: AGHT+IFiIX1fcSRdJtWjhfy1sxtZ93298AD9cMAT4KuCQqTCkhOqdD4bkF/mJIFj3cYchCpTNuQwbz7hzFY4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:feef:cd5e:6353:57f0])
 (user=irogers job=sendgmr) by 2002:a25:dc84:0:b0:d72:8661:ee29 with SMTP id
 y126-20020a25dc84000000b00d728661ee29mr123139ybe.2.1693466088813; Thu, 31 Aug
 2023 00:14:48 -0700 (PDT)
Date:   Thu, 31 Aug 2023 00:14:21 -0700
In-Reply-To: <20230831071421.2201358-1-irogers@google.com>
Message-Id: <20230831071421.2201358-4-irogers@google.com>
Mime-Version: 1.0
References: <20230831071421.2201358-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1 3/3] perf parse-events: Fix propagation of term's no_value
 when cloning
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
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

The no_value field in parse_events_term indicates that the val
variable isn't used, the case for an event name. Cloning wasn't
propagating this, making cloned event name terms appearing to have a
constant assinged to them. Working around the bug would check for a
value of 1 assigned to value, but then this meant a user value of 1
couldn't be differentiated causing the value to be lost in debug
printing and perf list.

The change fixes the cloning and updates the "val.num ==/!= 1" tests
to use no_value instead. To better check the no_value is set
appropriately parameter comments are added for constant values. This
found that no_value wasn't set correctly in
parse_events_multi_pmu_add, which matters now that no_value is used to
indicate an event name.

Fixes: 7a6e91644708 ("perf parse-events: Make common term list to strbuf helper")
Fixes: 99e7138eb789 ("perf tools: Fail on using multiple bits long terms without value")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 29 +++++++++++++----------------
 tools/perf/util/parse-events.y |  9 +++++----
 tools/perf/util/pmu.c          |  2 +-
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 51b73207e9f4..68fe2c4ff49f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1510,8 +1510,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_events_term__num(&term,
 				   PARSE_EVENTS__TERM_TYPE_USER,
-				   config, 1, false, NULL,
-					NULL) < 0) {
+				   config, /*num=*/1, /*novalue=*/true,
+				   loc, /*loc_val=*/NULL) < 0) {
 		zfree(&config);
 		goto out_err;
 	}
@@ -2482,7 +2482,7 @@ int parse_events_term__num(struct parse_events_term **term,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
 	};
 
-	return new_term(term, &temp, NULL, num);
+	return new_term(term, &temp, /*str=*/NULL, num);
 }
 
 int parse_events_term__str(struct parse_events_term **term,
@@ -2501,7 +2501,7 @@ int parse_events_term__str(struct parse_events_term **term,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
 	};
 
-	return new_term(term, &temp, str, 0);
+	return new_term(term, &temp, str, /*num=*/0);
 }
 
 int parse_events_term__term(struct parse_events_term **term,
@@ -2518,26 +2518,21 @@ int parse_events_term__clone(struct parse_events_term **new,
 			     struct parse_events_term *term)
 {
 	char *str;
-	struct parse_events_term temp = {
-		.type_val  = term->type_val,
-		.type_term = term->type_term,
-		.config    = NULL,
-		.err_term  = term->err_term,
-		.err_val   = term->err_val,
-	};
+	struct parse_events_term temp = *term;
 
+	temp.used = false;
 	if (term->config) {
 		temp.config = strdup(term->config);
 		if (!temp.config)
 			return -ENOMEM;
 	}
 	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
-		return new_term(new, &temp, NULL, term->val.num);
+		return new_term(new, &temp, /*str=*/NULL, term->val.num);
 
 	str = strdup(term->val.str);
 	if (!str)
 		return -ENOMEM;
-	return new_term(new, &temp, str, 0);
+	return new_term(new, &temp, str, /*num=*/0);
 }
 
 void parse_events_term__delete(struct parse_events_term *term)
@@ -2611,20 +2606,22 @@ int parse_events_term__to_strbuf(struct list_head *term_list, struct strbuf *sb)
 		first = false;
 
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
-			if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER && term->val.num == 1)
+			if (term->no_value) {
+				assert(term->type_term == PARSE_EVENTS__TERM_TYPE_USER);
 				ret = strbuf_addf(sb, "%s", term->config);
-			else
+			} else
 				ret = strbuf_addf(sb, "%s=%#"PRIx64, term->config, term->val.num);
 		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR) {
 			if (term->config) {
 				ret = strbuf_addf(sb, "%s=", term->config);
 				if (ret < 0)
 					return ret;
-			} else if (term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
+			} else if ((unsigned int)term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
 				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
+			assert(!term->no_value);
 			ret = strbuf_addf(sb, "%s", term->val.str);
 		}
 		if (ret < 0)
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 534daed91c50..4a305df61f74 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -712,7 +712,7 @@ name_or_raw '=' PE_VALUE
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					 $1, $3, false, &@1, &@3);
+					 $1, $3, /*novalue=*/false, &@1, &@3);
 
 	if (err) {
 		free($1);
@@ -739,7 +739,7 @@ PE_LEGACY_CACHE
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
-					 $1, 1, true, &@1, NULL);
+					 $1, /*num=*/1, /*novalue=*/true, &@1, /*loc_val=*/NULL);
 
 	if (err) {
 		free($1);
@@ -752,7 +752,7 @@ PE_NAME
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					 $1, 1, true, &@1, NULL);
+					 $1, /*num=*/1, /*novalue=*/true, &@1, /*loc_val=*/NULL);
 
 	if (err) {
 		free($1);
@@ -765,7 +765,8 @@ PE_TERM_HW
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_HARDWARE,
-					 $1.str, $1.num & 255, false, &@1, NULL);
+					 $1.str, $1.num & 255, /*novalue=*/false,
+					 &@1, /*loc_val=*/NULL);
 
 	if (err) {
 		free($1.str);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 152cda84f273..d85602aa4b9f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1396,7 +1396,7 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return NULL;
 
 	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
-		if (term->val.num != 1)
+		if (!term->no_value)
 			return NULL;
 		if (pmu_find_format(&pmu->format, term->config))
 			return NULL;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

