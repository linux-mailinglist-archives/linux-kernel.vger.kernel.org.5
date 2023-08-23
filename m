Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E666785293
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjHWIUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjHWILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:11:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6057D173B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7475f45d31so4664916276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778167; x=1693382967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLOHuaoioxUIPfraGI/RscnO6tlIZddOURBBsgyssoE=;
        b=Qz42NKTTx6zTspcQcJfd5SPnOrPnd5c00ZQ5+EY52NaVZ0hc3YTjcUVBHf0sfbvLMB
         ddz3sWDQdyNJneq6OddnEy5ajtknBPl/4FAIK8+S7mEKv1VLLEnxZhCLtDeoLwX7bntT
         tEP6+qxwhJSe6D08LX5LRtMwUth0drK1B8ITajpkP8ULjjvSiHlW7B+sVsju6oocKIt2
         zo6mHAfG/5qPIzXHGBWEwh4b78lxuExssZN+rwTcOUMwZasaDuchoRPODZe8Vy+nbSrN
         cpBJ1/4809OB7f6y74q/YD3soph+v61YnjKubT/oyhZo2nD2tPJnF2i79mmMLLzhl0tH
         lkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778167; x=1693382967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLOHuaoioxUIPfraGI/RscnO6tlIZddOURBBsgyssoE=;
        b=N5gQq1Srwz8mOIXg/u9jGK4JXqO1WmNYegMPQ9H1s8TWtYUG3/6AsVMQ73vz4QvRZd
         wc5qmrZWLnERpxdUihXaBG2d5t6y43ecJCEXNPagnkOjG08D5cNb1Bl1uFobgDMr5hz/
         7hhLIwc0QWV8BSVE0/9Z7Bzk00Wj/sSKcloisLV3pCk2sMyLK51HpmW3nusT/iPD3z2V
         inhQP099FscCLDgS8mYUw9EVst8nIYTY0edEV2JoPAEixj0alElPLDwxwDyJNzhKtIbk
         6qLOeIgXztfE8wOpOoTnOAeaO4ThVtfejOLhZS8+6ChoswYyW/8TJCpY5nVtuDEPAUVu
         b9kw==
X-Gm-Message-State: AOJu0YzljKA+xuCKTr2dd9Kc5e6qnD1gnkKmK8B5wUieVJ6TC+X1rWxA
        022CLrZT3y+JYslzLldC/4OrM7ngQdgB
X-Google-Smtp-Source: AGHT+IEe9e7MnCLgVp65s/JZqoRZX2GWP1p1t6uwoZhQMx0RQHxlMSCM5JVnoCRQRuIKliPIlA+3zuOPa1UA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:d2c4:0:b0:d47:5cc3:9917 with SMTP id
 j187-20020a25d2c4000000b00d475cc39917mr149953ybg.9.1692778167623; Wed, 23 Aug
 2023 01:09:27 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:25 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-23-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 22/25] perf pmu: Scan type early to fail an invalid PMU quickly
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
 tools/perf/util/pmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 81a40fe02d65..b4ba4f7f5e18 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -953,12 +953,21 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
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
@@ -978,10 +987,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-	/* Read type, and ensure that type value is successfully assigned (return 1) */
-	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
-		goto err;
-
 	alias_name = pmu_find_alias_name(name);
 	if (alias_name) {
 		pmu->alias_name = strdup(alias_name);
@@ -1007,7 +1012,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	return NULL;
 }
 
-
 /* Creates the PMU when sysfs scanning fails. */
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
 {
-- 
2.42.0.rc1.204.g551eb34607-goog

