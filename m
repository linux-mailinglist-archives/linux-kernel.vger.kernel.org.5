Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56B766481
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjG1GuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjG1GuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:50:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459ADE64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d27ac992539so366192276.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690526994; x=1691131794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kv5zMq7Gf+E/mq3KI9mmBvkyfhWn6r0mf6FnCBupmRU=;
        b=l4MYYbki/hukDreSiqPgSSi7kqT1I0MQAIIMZIRxKVi/gAKLP++vvsd3ohOTx5Peii
         fqJRbuy+r7VsxO2l6XzHudVyls1bul7gFWrwlg4Rytz7DH8HyH9gSFhKJaR9boqxH5vf
         tQfuU5hcGl/o9sWuVE9WVfiAGOTqTKTExEQBqUE387gTXbEcKWPa8knk8egaau1z8RJ5
         vo6VhoZfucWIvZZld14uFMpRpXPex78nOuYY+HlH6yuU4IhsIMPIUUG5/GjQBsL95wLy
         W8JKCHqR1HtA8ERSKiqVL7z9rAR1bnYFcooC/jmcbIeA1w6HhuY7zkKABT+erQaA7juD
         1jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690526994; x=1691131794;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kv5zMq7Gf+E/mq3KI9mmBvkyfhWn6r0mf6FnCBupmRU=;
        b=HjmpuP/7dmEOs90Tdew5LozrBOnhcuU0ExIFyc2AcyQt+ot+gAw5BoEgrOSc12TIPV
         PO6gcJY+h2v8oDskH3NAcdTNbHNx5PxgqovoHdmQvXDAOwLfSIJQj/7OuLlLYNLbml9k
         KXAzxcol42bv+sHgDp5tb8rDs5TjZPdCXc0hEO9bztRBM2Ussh7IZFiO84kuw6xSqEOx
         UVIHgHGD4YZsqtQVRWoYy7dinpBwZaS814NTheNd1CB8Rba+VXKyLW4J79I/qmeswuzL
         spDrcPsv0NdVQper6QgbOGJ8fdKdQy9lMt8pebDIZUEbkKooEils7yBU+v9yVt9YkM0n
         mv4w==
X-Gm-Message-State: ABy/qLY4YVRPluAWf7rbyhBD5h6jlm0XiohQuweg3mJgkW/u30XO0F8e
        VEPvNW3LUuZK+XDKT3AUFgW3J3nj7RfB
X-Google-Smtp-Source: APBJJlHSjc/IT1qlh3DupBROZRiA34CttLjbZ/ikQplvXR7TLxlgSKa9DNC7fbAHgw/FKUsK9regMJwIlwEM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:d613:0:b0:d12:d6e4:a08d with SMTP id
 n19-20020a25d613000000b00d12d6e4a08dmr4686ybg.7.1690526993885; Thu, 27 Jul
 2023 23:49:53 -0700 (PDT)
Date:   Thu, 27 Jul 2023 23:49:16 -0700
In-Reply-To: <20230728064917.767761-1-irogers@google.com>
Message-Id: <20230728064917.767761-6-irogers@google.com>
Mime-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 5/6] perf build: Disable fewer bison warnings
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bison is version 3.8.2, reduce the number of bison C warnings
disabled. Earlier bison versions have all C warnings disabled. Avoid
implicit declarations of yylex by adding the declaration in the C
file. A header can't be included as a circular dependency would occur
due to the lexer using the bison defined tokens.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build          | 6 +++---
 tools/perf/util/bpf-filter.y   | 2 ++
 tools/perf/util/expr.y         | 4 +++-
 tools/perf/util/parse-events.y | 1 +
 tools/perf/util/pmu.y          | 3 +++
 5 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 32239c4b0393..20aa8545b127 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -291,9 +291,9 @@ CFLAGS_expr-flex.o          += $(flex_flags)
 CFLAGS_bpf-filter-flex.o    += $(flex_flags)
 
 bison_flags := -DYYENABLE_NLS=0
-BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
-ifeq ($(BISON_GE_35),1)
-  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable -Wno-unknown-warning-option
+BISON_GE_382 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 382)
+ifeq ($(BISON_GE_382),1)
+  bison_flags += -Wno-switch-enum
 else
   bison_flags += -w
 endif
diff --git a/tools/perf/util/bpf-filter.y b/tools/perf/util/bpf-filter.y
index 07d6c7926c13..5dfa948fc986 100644
--- a/tools/perf/util/bpf-filter.y
+++ b/tools/perf/util/bpf-filter.y
@@ -9,6 +9,8 @@
 #include <linux/list.h>
 #include "bpf-filter.h"
 
+int perf_bpf_filter_lex(void);
+
 static void perf_bpf_filter_error(struct list_head *expr __maybe_unused,
 				  char const *msg)
 {
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index dd504afd8f36..65d54a6f29ad 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -7,6 +7,8 @@
 #include "util/debug.h"
 #define IN_EXPR_Y 1
 #include "expr.h"
+#include "expr-bison.h"
+int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 %}
 
 %define api.pure full
@@ -56,7 +58,7 @@
 static void expr_error(double *final_val __maybe_unused,
 		       struct expr_parse_ctx *ctx __maybe_unused,
 		       bool compute_ids __maybe_unused,
-		       void *scanner,
+		       void *scanner __maybe_unused,
 		       const char *s)
 {
 	pr_debug("%s\n", s);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 454577f7aff6..251b7d2fde32 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -20,6 +20,7 @@
 #include "parse-events.h"
 #include "parse-events-bison.h"
 
+int parse_events_lex(YYSTYPE * yylval_param, YYLTYPE * yylloc_param , void *yyscanner);
 void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
 
 #define PE_ABORT(val) \
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index dff4e892ac4d..3d46cca3bb94 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -11,6 +11,9 @@
 #include <linux/bitmap.h>
 #include <string.h>
 #include "pmu.h"
+#include "pmu-bison.h"
+
+int perf_pmu_lex(YYSTYPE * yylval_param , void *yyscanner);
 
 #define ABORT_ON(val) \
 do { \
-- 
2.41.0.487.g6d72f3e995-goog

