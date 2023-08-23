Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AEA78528C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjHWIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbjHWIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F310DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc4291239so48525937b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778127; x=1693382927;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myrZI6DclPn0eLWcMv9biHZACVNMEh01ZlQXZypDBfA=;
        b=R2cp0GlpupvjYWd6I5tT/FuSllBfvZSN8fAwQNUIwunrLFPYs7/ZOH4DuouAyEiBFy
         Alqi4Rn5BSGp03SWnilJZybv1TgbXEyEkCj+KGNwxprJB3Lhnf1SP6TlTldcEC0br92j
         ptXg5FMeK+QioamO97JPJ2UWIb7i8pSf7pY2VMkp9owd0SKAGvWyv8OUba1avqn5THpQ
         pBxgSaGsrRVB6m85IF4PPcdwweop/0zNKyh2AFgH85DPWrwxKq66/3/ugVpwHB/EfmZf
         qoaTlX7g0Dt6No2MnSa+91aFA93m3nDcWtivH2yQ1JTL5Mtqnx7nuVIfRj6wPcQSzLPR
         76PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778127; x=1693382927;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myrZI6DclPn0eLWcMv9biHZACVNMEh01ZlQXZypDBfA=;
        b=XuTStV47XXHwt/FY+bXb3G3X1NsCQiNCTnIq/YMidCeW5IqbJIDOotAz0n8QueSn4n
         oeBoO8BwhiASuQ42jNSAz8Yfi/MAyP82HPltkKLJRLdygN4qjfVuh2LGa55TEji24uVy
         fK4iwYj6qzkbVA4iHvr/KmcDkCQmMs0p0OSauIQu3XqUngmP8Jv4wIcIi/ciUhDWYjnT
         jNxsyYMt02dvtoIuwoQ7mJ+gyg7wUGx6TpcFDLeOFEvQo3G9nBOatCq8GT226EVu99OR
         KtLOWaaL17rPxBs0LJLVQP4KUuLGA640irpdg0JEm3VIRP4YRjGK9Vtl+hTcDMmDANgT
         Jd2Q==
X-Gm-Message-State: AOJu0YyL2OPuwWRIbjEpJKzhTiZfBjwK28wzzgs1gK+5dVqlIgYcKkaA
        9s0Ok3UT9i95PQ8oKUHCL9y3dB6BADFP
X-Google-Smtp-Source: AGHT+IG2CJ7EsJ8ALY4GJ9uZv36SkkpuYxzpWI3WofNFCIJnmuwyxtmrcdEBDTkhQkINfbl+Ybljr0LhO7eP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:d809:0:b0:d4c:d744:2ad with SMTP id
 p9-20020a25d809000000b00d4cd74402admr132919ybg.10.1692778127045; Wed, 23 Aug
 2023 01:08:47 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:09 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-7-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 06/25] perf pmu: Avoid passing format list to perf_pmu__format_type
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
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Pass the pmu so the format list can be better abstracted and later
lazily loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/pmu.c          | 4 ++--
 tools/perf/util/pmu.h          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 00a8ec94f5b2..8ede27089766 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1159,7 +1159,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	list_for_each_entry(term, head_config, list) {
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_USER:
-			type = perf_pmu__format_type(&pmu->format, term->config);
+			type = perf_pmu__format_type(pmu, term->config);
 			if (type != PERF_PMU_FORMAT_VALUE_CONFIG)
 				continue;
 			bits |= perf_pmu__format_bits(&pmu->format, term->config);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 89573a8eaf0b..96189afe54b0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1038,9 +1038,9 @@ __u64 perf_pmu__format_bits(struct list_head *formats, const char *name)
 	return bits;
 }
 
-int perf_pmu__format_type(struct list_head *formats, const char *name)
+int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
 {
-	struct perf_pmu_format *format = pmu_find_format(formats, name);
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
 
 	if (!format)
 		return -1;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index eb26c8bc079f..1ea78d2fa531 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -222,7 +222,7 @@ int perf_pmu__config_terms(struct perf_pmu *pmu,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *error);
 __u64 perf_pmu__format_bits(struct list_head *formats, const char *name);
-int perf_pmu__format_type(struct list_head *formats, const char *name);
+int perf_pmu__format_type(struct perf_pmu *pmu, const char *name);
 int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
-- 
2.42.0.rc1.204.g551eb34607-goog

