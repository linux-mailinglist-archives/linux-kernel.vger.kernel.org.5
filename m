Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC278669D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbjHXEPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbjHXEOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:21 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBB810F3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59224c40275so39662497b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850459; x=1693455259;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ScEv4GX5A4Io0po//7S7PvWnFzmCqkRHzJYnXAt+bY=;
        b=r8VSBW4qdoFWgdyFcw0Sn10q8onBDQmJf0aih/aqmXo8WHsheh/ylVTvf/6mOrFCL2
         qMDBt5AltI9qZ5eeMutQFVdZNW/xohjsKntv2HDkKPW9ABtV+b/Z/EkjYnVdhpoLXZNi
         p6tCrf2LwZxraNvuHHqPe4UiqAZ84rmmBDP70FEh0Q8KxWGGBMfG0UhiXGwU1jz/Oj4K
         EicHYGdtkg9aZSVLOt2rp/wpI5Psmu5qapxieMghJQpzDZ86fbLw6mGOyIDJXGdzoqKD
         wMa13Qk7oxnnHCkaHzzHKP1KTKsK12pDvsu9xVVl3y1nFQpl2ADL44gL7JF8IDa79QYa
         AcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850459; x=1693455259;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ScEv4GX5A4Io0po//7S7PvWnFzmCqkRHzJYnXAt+bY=;
        b=SBACFvPJHtfuSRvY/+vqVyC2cYth89qxqvJr2836hBQ9HUbXJRLtx+QSXdDNZzLqF1
         7Q8wRePG8DkxKUbBlxHIDi4feT/oXg3rlrDzdO69j/N3TTRRZ5RDSi/JDTTJa7bBS1PA
         yzADYPLX09BwKH+wODODBb+UbCoEdJv6BIVCLmdTmdyUh47HOj2eBtPzH3XRL6501qgg
         JwY5wrYyPqBnZlW8vDnLxIdkLQ8XhCyAb2IpR/UvuaHUP/ZwhwrcDmCndei+UOsN2DiW
         bSv0viIW/9B00Nxwlb9yo0ZyPzoF2pICS+IlYYluV4t2QYo4Jhmoop3q3wzRpq38pLhr
         yDyw==
X-Gm-Message-State: AOJu0YxpfUGogNmVBkAG+d9R3mkE5cChm+6xhtpa1bUMKVgESNvlPFTV
        BXZ4NUZw5czhFvfIdNlvK06c623sE0oW
X-Google-Smtp-Source: AGHT+IGLEEHEeCmx11MwTgaezBT64VhjVTmHANbZExv2smPbeqft6cHfLwu/s4hF4lr/HZGGWEU4nFI7uzrM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:ad23:0:b0:581:3899:91bc with SMTP id
 l35-20020a81ad23000000b00581389991bcmr197582ywh.6.1692850458760; Wed, 23 Aug
 2023 21:14:18 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:26 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-15-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 14/18] perf pmu: Scan type early to fail an invalid PMU quickly
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

Scan sysfs PMU's type early so that format and aliases aren't
attempted to be loaded if the PMU name is invalid. This is the case
for event_pmu tokens in parse-events.y where a wildcard name is first
assumed to be a PMU name.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b6a118226541..9e3b72d84168 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -957,12 +957,21 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (!pmu)
 		return NULL;
 
-	INIT_LIST_HEAD(&pmu->format);
-	INIT_LIST_HEAD(&pmu->aliases);
-	INIT_LIST_HEAD(&pmu->caps);
 	pmu->name = strdup(name);
 	if (!pmu->name)
 		goto err;
+
+	/*
+	 * Read type early to fail fast if a lookup name isn't a PMU. Ensure
+	 * that type value is successfully assigned (return 1).
+	 */
+	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
+		goto err;
+
+	INIT_LIST_HEAD(&pmu->format);
+	INIT_LIST_HEAD(&pmu->aliases);
+	INIT_LIST_HEAD(&pmu->caps);
+
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -982,10 +991,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-	/* Read type, and ensure that type value is successfully assigned (return 1) */
-	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
-		goto err;
-
 	alias_name = pmu_find_alias_name(name);
 	if (alias_name) {
 		pmu->alias_name = strdup(alias_name);
-- 
2.42.0.rc1.204.g551eb34607-goog

