Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833576A863
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjHAFhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjHAFhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:37:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C2139
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584139b6b03so60961927b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690868209; x=1691473009;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cgKjdSs3G1HD7e5a1QJ2TPW0bOH8fEPCcMkC6M5juE=;
        b=vasKg5Ucb7s834gs6TqGgTHy3yn7y2I64AU1KlEXsVFglMHUYI3YWwtIeYmJvvv7r1
         J8h8xXYpI5jbWq2H53iOxymdAQ0Tbx2jcEvsDuO0ChxhooVaqtkxu4ir0iYA2vI/IYel
         NCGM+o+vdH8s/IVNwLS6M5MOulScPi4J5PmFQlGNoKkzIy9Es4XPEvD/Mpn927LiyRBz
         XHa0scMkWQc3+kY21TTAOfWtR2nFdnXSir3rgHtN2dcQHFN4PjhOz2j2T2XtsymDGMi2
         iiAfovKi/QYXaEo/A7iRqgnc8YuNWzlhxcTfcGZyYaOq2tklUNXoMNnuvEXy53HwRZiK
         Y1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868209; x=1691473009;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cgKjdSs3G1HD7e5a1QJ2TPW0bOH8fEPCcMkC6M5juE=;
        b=DwoJ9A/2CS5Fnikd5F7cB7N4KaiUXc229dXMUwcPK234hkGD7h2ObPDV/zx1pzHi7C
         Yj7XgmeHapgAqa40m1jg0sYXWf3pml9IjS5664NJw/xx2mCZOIU/Qi9l//TSMv5RuxVd
         YEFYP0uVawTKxX74xNHsZnVWmre2CxrpIoitMdzAnw6w93ze2FLuElUH11S3UB4LZ+NF
         eRogGwXPW+ODM4LersiNRYMapiAmwkw5dSGvWM2Fxgawi8pXgy5tjHNonVQuA/Z1Q8l9
         A5/9IM4TopA+Bt2KpfZhG4RF2pR9hEiTTmAHI5fkXCBH8PTonzEd8pc/5M8S3WOmuMz0
         KiUw==
X-Gm-Message-State: ABy/qLaIWO4D5WQ9P9e5tuNSsYNu5NR/Y9HSye/xZnp7g6M6HPdkbIwV
        20gUC4HDoB0Gr8Wcg4x7m62JtfXykZC6
X-Google-Smtp-Source: APBJJlHy6JFYSb9M9Oh886GADCpFJqSyjGvQ5kdRzdU6QgUVE9MfCqO3B63MHXpf8WNkAXKF78c6grWhGTtr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd0a:f4b:6531:d8dc])
 (user=irogers job=sendgmr) by 2002:a81:a789:0:b0:586:5388:82ba with SMTP id
 e131-20020a81a789000000b00586538882bamr12914ywh.6.1690868208792; Mon, 31 Jul
 2023 22:36:48 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:36:31 -0700
In-Reply-To: <20230801053634.1142634-1-irogers@google.com>
Message-Id: <20230801053634.1142634-2-irogers@google.com>
Mime-Version: 1.0
References: <20230801053634.1142634-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1 1/4] perf parse-events x86: Avoid sorting uops_retired.slots
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As topdown.slots may appear as slots it may get confused with
uops_retired.slots which is an invalid perf metric event group
leader. Special case uops_retired.slots to avoid this confusion.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 7 ++++---
 tools/perf/arch/x86/util/evsel.c  | 7 +++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index cbd582182932..b1ce0c52d88d 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -75,11 +75,12 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
-	if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
+	if (topdown_sys_has_perf_metrics() &&
+	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
 		/* Ensure the topdown slots comes first. */
-		if (strcasestr(lhs->name, "slots"))
+		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
 			return -1;
-		if (strcasestr(rhs->name, "slots"))
+		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
 			return 1;
 		/* Followed by topdown events. */
 		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 81d22657922a..090d0f371891 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -40,12 +40,11 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 {
-	if (!evsel__sys_has_perf_metrics(evsel))
+	if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
+	    strcasestr(evsel->name, "uops_retired.slots"))
 		return false;
 
-	return evsel->name &&
-		(strcasestr(evsel->name, "slots") ||
-		 strcasestr(evsel->name, "topdown"));
+	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
 }
 
 int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
-- 
2.41.0.585.gd2178a4bd4-goog

