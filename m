Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4659D781185
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378935AbjHRRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378922AbjHRRT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:19:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42DF3C2F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:19:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d72b76f202bso1366249276.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692379196; x=1692983996;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C88yoZ/6ZItf49caBe3kpaia+5Rtg28dk/8WphFe0UE=;
        b=kzOAAW+bH/P/jXgYgurMNurhrMHYNJ6xVcZLGuxm2srgiJHcPBc94SuTwmnTPHbh6h
         CghnDjnA1oOcvO6fLtD5Igg6SZds2jEy2yUnkeOlFHosAp3JofvGYFMcSlPfH1V2Ojf/
         Xu+HgLwzaSdnJ0EAkYgCWlcaJSAQz3j/CbaSZipA2krxRb0/8hJXOVBHFKg3ggIjbj4K
         5XIbtKs7GFRWz3ODRHfVx45CCHV81DeJAvuxvSndbuCYQuq+YyvvPEeCbhrCyrIAPGTY
         3mvIWNsBc5DFR+kymlutZjOWH9wvRxYr7zXjYaLeKyO4QWzJ6Vn36t7hn5VUfvRFxUX1
         04YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692379196; x=1692983996;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C88yoZ/6ZItf49caBe3kpaia+5Rtg28dk/8WphFe0UE=;
        b=ipbjk0uJtED3Krl4PjcskQ2DYlxhWtZk3l1BoWZUrie512CPa5+24Kw9fRElfDQq21
         uFSVth6Pi6LajMJbQDzJdASj01GTu+Hle+v6LFy0vekEoJ3JCfAh5lVKelviwgcFygRb
         p3nNVGIEG0PcsoNnZpW9gdHi+Xme6Bt0fanA6t0Cdz0sNWeHAlMye75D3sUw9qWWo1bU
         C1I/VnvJMmrRxwSAT1+VuXEEZOrFCcVvw//EPSdgyyaOIp103/w4uZuHknmmF4rxfN/r
         5awf0iSEqd//OjnFjIUI6/YQgzKO4S7L/gXDWnMPJHU3VCrTJe0Q2WTFUFkVqxx1Xew/
         DGEA==
X-Gm-Message-State: AOJu0Yy2+mGmqEsMZj9yz24JsdcCdInlj90UjH1u0p1ikwtsxnkvy15U
        513Ht4515RvR9yrhY9CejuTQVZRs+wSm
X-Google-Smtp-Source: AGHT+IH/cwGQQXBuGtb+eTWAc/SHyLXhNoaVa6UZHzDS9Y1Y4xq/wGSp5SXrG2C0pMPd0s4kQhH/6jLdIERj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5c87:ff9a:b64c:ee])
 (user=irogers job=sendgmr) by 2002:a25:393:0:b0:d4a:7656:a680 with SMTP id
 141-20020a250393000000b00d4a7656a680mr42236ybd.2.1692379196087; Fri, 18 Aug
 2023 10:19:56 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:19:52 -0700
Message-Id: <20230818171952.3719251-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1] perf header: Fix missing PMU caps
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
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei <liwei391@huawei.com>
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

PMU caps are written as HEADER_PMU_CAPS or for the special case of the
PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and not
any "core" PMU, the logic had become broken and core PMUs not called
"cpu" were not having their caps written. This affects ARM and s390
non-hybrid PMUs.

Simplify the PMU caps writing logic to scan one fewer time and to be
more explicit in its behavior.

Reported-by: Wei Li <liwei391@huawei.com>
Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74..13c71d28e0eb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
 	int ret;
 
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    perf_pmu__caps_parse(pmu) <= 0)
+		if (!strcmp(pmu->name, "cpu")) {
+			/*
+			 * The "cpu" PMU is special and covered by
+			 * HEADER_CPU_PMU_CAPS. Note, core PMUs are
+			 * counted/written here for ARM, s390 and Intel hybrid.
+			 */
+			continue;
+		}
+		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
 		nr_pmu++;
 	}
@@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
 		return 0;
 
 	/*
-	 * Write hybrid pmu caps first to maintain compatibility with
-	 * older perf tool.
+	 * Note older perf tools assume core PMUs come first, this is a property
+	 * of perf_pmus__scan.
 	 */
-	if (perf_pmus__num_core_pmus() > 1) {
-		pmu = NULL;
-		while ((pmu = perf_pmus__scan_core(pmu))) {
-			ret = __write_pmu_caps(ff, pmu, true);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
 	pmu = NULL;
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (pmu->is_core || !pmu->nr_caps)
+		if (!strcmp(pmu->name, "cpu")) {
+			/* Skip as above. */
+			continue;
+		}
+		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
-
 		ret = __write_pmu_caps(ff, pmu, true);
 		if (ret < 0)
 			return ret;
-- 
2.42.0.rc1.204.g551eb34607-goog

