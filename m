Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B433787DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbjHYCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241603AbjHYCkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A011BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:30 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59285f1e267so23964757b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931230; x=1693536030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gleOx1R6bSswKzh9EuhLGrWijl71cST/VqhPvXlvs9U=;
        b=Cqu+Mpf9iSpDeRLvOSI3IVWLQssJ9tYBK0e1ZWdNFAycIwrIj1MxpQ1quvIleMZJB6
         Drb5sCcEu+fxJtnG5dfoegKcS4mWhHZ523Dohm1QrgK8uHjNxutRRM2W/taS217gq+oI
         kHkSwnzlHIvea+nMmyhch28gwXtZtS4Q+i0/r1FVJ8rgPQ3Zgmo3DJUDTHva04iSuZ7j
         Pwog+gL+Ygwt5ML1nXOfFqaQvFCsUOw036pa3OrChBdWXOmot7F0ZhRNIpy1NkakWboa
         IV/zDZC3ynvtqUUfHShJiG/JbJzUmp13jVoZAVuTdnxcp6qj4ryVFvEGNKWJatT75FYw
         4IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931230; x=1693536030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gleOx1R6bSswKzh9EuhLGrWijl71cST/VqhPvXlvs9U=;
        b=SikKP3bVqYqMfXM0AS24xCPZmUCyiWXHOcup/SldgrbZVDa1J02iw2hVgHhKZeaaBO
         l2YQ0Fx8Yxik2xlnGknMiudB7vovUr2ijGt+E9twNkumcC7YF71SIjd8VIRclbP5Bvck
         D3TZKDXFniGND7yKQKB/qe4vxLUi1dCTE2/fhJeqFU35c0jWmSyvkUCMmIZR4a6CPnVH
         vNm5thIbzCWbBOZPOXb1nEPwBex4/rC1XKIzNuNDB5AnUGZfLWstaTIHUIZM4PTPhtqb
         WMsZimaDFtcLLXjar4DLJerz/1ULbiu/diJK1UFYqxdoQav9ww/vj24VnNmpfwDwbvza
         AqTQ==
X-Gm-Message-State: AOJu0Yw+DaVvkuSQ+lbXKXktR6u213qWK7iRsnmlRdz15ieSebDy00y4
        T27sx5PBLJIVNdlY0KB7iymJdjl7o65e
X-Google-Smtp-Source: AGHT+IFi5wnjwMO3TOfHdkD/PK6fZ23/bjTAUd5coQ8Pvt3nE13DfLfuhsCiqnLwncG7b5sT0DyY9knVVA03
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a05:6902:691:b0:bd5:dc2d:9d7f with SMTP id
 i17-20020a056902069100b00bd5dc2d9d7fmr410342ybt.4.1692931229945; Thu, 24 Aug
 2023 19:40:29 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:39:57 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-2-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 1/6] perf header: Fix missing PMU caps
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
2.42.0.rc2.253.gd59a3bf2b4-goog

