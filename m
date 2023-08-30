Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13A178DBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbjH3SjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbjH3Haq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:30:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3A9CC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:30:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-591138c0978so74478417b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693380640; x=1693985440; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+VcEgrVJw9/Cn1VwNm/CzRA0xRzxNz/P7Du2BYg5res=;
        b=WSOZtGRlcVXviTqT41lJUNAIQIVzdsLhT2HHtM+7Ff85C3UWIaThqt2tkZrjnSMyMp
         ORbhkeNJaV0XYzJiDk6W/8MrOLDn7t7dZQyUd5TqnM/rBb5OsiSHSgFJbDODvlqznux9
         HAo7VuloSEwZItdCANDP07jcAFDzUfAw4mORE5vsiWszdvHauanlhoYq2mQmXcEZM2kq
         uVc8EAodSnnGetQvgBvTDM+EE23LGFB5x3atsH+8yxAFrwGfInmr8Q5Aw8SmdE4UarE3
         ox3MBylZ1Xf4btY/keBe+pL8bhmuZ+i5Y6fbaX6/dG/Dhtw6mvEnLB7doWxl+P/p+wUc
         6g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693380640; x=1693985440;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VcEgrVJw9/Cn1VwNm/CzRA0xRzxNz/P7Du2BYg5res=;
        b=Yu1QJ/DolroZJVFF79CAf80exaQKtYHJBUUWzGYW36hlLuGYyaFMTLk4gvUHabp0ZY
         NL762FtInh7TsvtvTS3rbhK4JBniNRPH0sVpJbukb51nl/a8ovLhfwCluH+7DmtbN8up
         0Ni96g4XI6NwWTckW3YLoUDrrAUxk400YoFDyZFkbnKHCaXyM1A7oBf7hd7dFhzZWtsr
         B2mTZuIyPMZWOP9vSS52lVTdYIwcOGHcerqPgko1XIlZ3J2tAjVs063uS474hpMMyE5J
         Yjy/I0nabZxBZmZ3l9txEovtEnW5jMCiC1+APluSaHeqB2Hq/RGspwmcqmgdKAH/SHnQ
         5ldA==
X-Gm-Message-State: AOJu0YzghE61wk7AXT8osrY2s28k6+hQrrwrhz/JDzS5ooM3NOBQqzvC
        SyWNt7XynQMT8cx+8dtAyzwdpFRJJfSm
X-Google-Smtp-Source: AGHT+IGhjWpqdd6O0tWiW4u/Z4O9VmB0rjp/VgcmWd5FXOz24gEhwSmvRHVNBFKW+bu0uIcIsOcCfbsAlaRl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:d623:3cd7:ecbc:8798])
 (user=irogers job=sendgmr) by 2002:a25:dc05:0:b0:d47:8db3:8bc9 with SMTP id
 y5-20020a25dc05000000b00d478db38bc9mr40344ybe.0.1693380640610; Wed, 30 Aug
 2023 00:30:40 -0700 (PDT)
Date:   Wed, 30 Aug 2023 00:30:26 -0700
Message-Id: <20230830073026.1829912-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v1] perf metric: Add #num_cpus_online literal
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
        Eduard Zingerman <eddyz87@gmail.com>,
        John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returns the number of CPUs online, unlike #num_cpus that returns the
number present. Add a test of the property. This will be used in
future Intel metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 5 ++++-
 tools/perf/util/expr.c  | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index c1c3fcbc2753..81229fa4f1e9 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -70,7 +70,7 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 {
 	struct expr_id_data *val_ptr;
 	const char *p;
-	double val, num_cpus, num_cores, num_dies, num_packages;
+	double val, num_cpus_online, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
 	bool is_intel = false;
@@ -227,7 +227,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 
 	/* Test toplogy constants appear well ordered. */
 	expr__ctx_clear(ctx);
+	TEST_ASSERT_VAL("#num_cpus_online",
+			expr__parse(&num_cpus_online, ctx, "#num_cpus_online") == 0);
 	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
+	TEST_ASSERT_VAL("#num_cpus >= #num_cpus_online", num_cpus >= num_cpus_online);
 	TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
 	TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
 	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 0985a3cbc6f9..4488f306de78 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -427,6 +427,13 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 		result = cpu__max_present_cpu().cpu;
 		goto out;
 	}
+	if (!strcmp("#num_cpus_online", literal)) {
+		struct perf_cpu_map *online = cpu_map__online();
+
+		if (online)
+			result = perf_cpu_map__nr(online);
+		goto out;
+	}
 
 	if (!strcasecmp("#system_tsc_freq", literal)) {
 		result = arch_get_tsc_freq();
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

