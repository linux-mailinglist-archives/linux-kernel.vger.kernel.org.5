Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EAF790409
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351218AbjIAXkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351123AbjIAXkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:40:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0510D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:40:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so15402047b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693611604; x=1694216404; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtbstwhM750foArngOjUdnAW59K1Cmw/OZwRlfXgIkY=;
        b=TYtXB7v9zsUdWQ6sLfeY8PnHjcWOV0WLJiJDtxt6ot85BpCnsW6WnTP9Mnq3MKdNT4
         Pj42gueetRrytTcxJO+5DW5y3OaRChSciz1qkFsiIKF8x26F6zUmY+DNIhnwpKcC68Uu
         cqeOIQGYIwImnfGUK5Ehy7+srqlczb2RJ5LvE8JWi4f6eOB5WrJ9J4zr5+NlDGd7gLzC
         DxpMIZ59kKzDc8PxDRciWoSjKV50QPHXxFTEC5pvY+ppzZmMhbBi5Zd7cmhRIYn+lvUY
         ALFCJ/FfTpr0DunQHUrVm4a5g/yytxfUat69htEOJ6zGzsOd8H6LmCPrOeiXRIEAk4gs
         MRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611604; x=1694216404;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtbstwhM750foArngOjUdnAW59K1Cmw/OZwRlfXgIkY=;
        b=RD1SnHlNEaZa+A7Az2jaSMsyUiHiIThxdXqkDkao2iOqTD09mDlTS6/n95phjg98yS
         WE2dEDhUA3JArG2pgfgPlYBIq1CV46RiSDovzsvxK8J2ZwLXV8PnpU+4JY2LkR8FAER+
         9JsatiaYoCemqzwEeuDobupAHzS7k6wf6Fqrjp6l2Dz5hU17hj4Kh7V1DsUrFGKOp2FZ
         +GnSULQuls3Ej9URugYzWXGvg+BS6CEUHv/PU/koaBU4alHNRPHX8kWI22ljyYTLnurt
         KQNfqFynWcFqh2vQXNALe16W2HplJsutsUi2bVZHDPZ6bWnLBZ/E0GtJjtvlyiuRvg4U
         Skjg==
X-Gm-Message-State: AOJu0YwejWh+zHxKsFqDiwB6wjlE9Km9WnAn9NTLPTN/LDRQy+/Qxyfw
        3wqLGEJN/3e84iHZ8/2Cti28nBSdMvtY
X-Google-Smtp-Source: AGHT+IFozOA0unARbKlIA5NDlu3aa8OXlOHN2umEvQTZ/DQ+Ne+XCm4U9pCE0/1bB1SisVgkkjSp4kquQDMf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:51bc:d985:dbbd:10b])
 (user=irogers job=sendgmr) by 2002:a05:690c:721:b0:586:5d03:67c8 with SMTP id
 bt1-20020a05690c072100b005865d0367c8mr114526ywb.3.1693611604484; Fri, 01 Sep
 2023 16:40:04 -0700 (PDT)
Date:   Fri,  1 Sep 2023 16:39:47 -0700
In-Reply-To: <20230901233949.2930562-1-irogers@google.com>
Message-Id: <20230901233949.2930562-4-irogers@google.com>
Mime-Version: 1.0
References: <20230901233949.2930562-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 4/6] perf parse-events: Avoid enum casts
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add term_type to union of values returned by the lexer to avoid casts
to and from an integer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.l |  2 +-
 tools/perf/util/parse-events.y | 25 +++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 4ef4b6f171a0..7bdf0565a92c 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -120,7 +120,7 @@ static int term(yyscan_t scanner, enum parse_events__term_type type)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
 
-	yylval->num = type;
+	yylval->term_type = type;
 	return PE_TERM;
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4a305df61f74..4fae7847d13b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -70,7 +70,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
 %type <num> PE_VALUE_SYM_TOOL
-%type <num> PE_TERM
+%type <term_type> PE_TERM
 %type <num> value_sym
 %type <str> PE_RAW
 %type <str> PE_NAME
@@ -111,6 +111,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 {
 	char *str;
 	u64 num;
+	enum parse_events__term_type term_type;
 	struct list_head *list_evsel;
 	struct list_head *list_terms;
 	struct parse_events_term *term;
@@ -778,8 +779,7 @@ PE_TERM_HW
 PE_TERM '=' name_or_legacy
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, (enum parse_events__term_type)$1,
-					/*config=*/NULL, $3, &@1, &@3);
+	int err = parse_events_term__str(&term, $1, /*config=*/NULL, $3, &@1, &@3);
 
 	if (err) {
 		free($3);
@@ -791,8 +791,7 @@ PE_TERM '=' name_or_legacy
 PE_TERM '=' PE_TERM_HW
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, (enum parse_events__term_type)$1,
-					 /*config=*/NULL, $3.str, &@1, &@3);
+	int err = parse_events_term__str(&term, $1, /*config=*/NULL, $3.str, &@1, &@3);
 
 	if (err) {
 		free($3.str);
@@ -804,10 +803,7 @@ PE_TERM '=' PE_TERM_HW
 PE_TERM '=' PE_TERM
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__term(&term,
-					  (enum parse_events__term_type)$1,
-					  (enum parse_events__term_type)$3,
-					  &@1, &@3);
+	int err = parse_events_term__term(&term, $1, $3, &@1, &@3);
 
 	if (err)
 		PE_ABORT(err);
@@ -818,8 +814,9 @@ PE_TERM '=' PE_TERM
 PE_TERM '=' PE_VALUE
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, (enum parse_events__term_type)$1,
-					 /*config=*/NULL, $3, /*novalue=*/false, &@1, &@3);
+	int err = parse_events_term__num(&term, $1,
+					 /*config=*/NULL, $3, /*novalue=*/false,
+					 &@1, &@3);
 
 	if (err)
 		PE_ABORT(err);
@@ -830,9 +827,9 @@ PE_TERM '=' PE_VALUE
 PE_TERM
 {
 	struct parse_events_term *term;
-	int err = parse_events_term__num(&term, (enum parse_events__term_type)$1,
-					/*config=*/NULL, /*num=*/1, /*novalue=*/true,
-					&@1, /*loc_val=*/NULL);
+	int err = parse_events_term__num(&term, $1,
+					 /*config=*/NULL, /*num=*/1, /*novalue=*/true,
+					 &@1, /*loc_val=*/NULL);
 
 	if (err)
 		PE_ABORT(err);
-- 
2.42.0.283.g2d96d420d3-goog

