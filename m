Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD186785528
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjHWKPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjHWILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:11:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA760CED
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6412374defso6537738276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778162; x=1693382962;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXvCFhL984TX2oQ47qDb/BYaP1EU6FGu4C4k2bcoWxA=;
        b=d2ctvFcr4XNnEwl476cUwp8Ir8ybnDC28SJSGMpFfm3HWQyw6DeVHNNKOF2qZSfQL/
         SFfKkvhanOKg/MhxxNwtbs5iHXcg6yQz+3K1BR/jH7TbgPHZ5W2aDSWuynYNLUENf4vM
         hdVSpYlpMjLCEwCOP6A88bPMTrLIU4KT1tM95Hq2GQNL5d28EMRcpTQ7vS+PY4QIy5VS
         Hr+tG9hvmXo+TwCpR/kov9shGLDR4zVThP9yDDLo7ipKpky3dybPMVywktOfFvBBaLLc
         8ZwUDltEXVcQ/MNI1LYIZ7Pkf5QOoLXL0lGKRg0ZWmTgQvLq2KRmrGH7QX+u4e/JxafI
         AMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778162; x=1693382962;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXvCFhL984TX2oQ47qDb/BYaP1EU6FGu4C4k2bcoWxA=;
        b=HZyKz7dQ6JTTUXJ5maExSBzhsuf94rU4Ozle8mehHcvogkzO8pFp3zTd1XfmfP8oXD
         AIRrbtzTZUTfJ1k9ARIzm5TYbOmCeXCjHZYDPKr7+8nrG2fbn/AGEn26YL49pU5S0yfB
         3+M7Z5Bu61W2Cs2mZVuBP5+r2xPcZqbhnTr4RzhyxzPCfXPOTbHEniT8JaHnospYR3Pj
         iuxjMCl0eL5pvfp5NTOvn19d9LKH+X9RYpIJXa5SHoFHjalqy5zINvuucZKvPqYnzNU5
         6MifnC5aDQj0rLZQ3krn7ZrH/kj8jw1l7MHpuD+tXk2d/lVXxi/zODnmW2BqsJ8Sv0ps
         7mUg==
X-Gm-Message-State: AOJu0YwjX7UVhBPQaWuGnOmskm7IlgS5LgDjl0sp3bbE4bWJXjIUpMoo
        LiZT20U9NV3EAo6S+ul63vqzhyc7RWhC
X-Google-Smtp-Source: AGHT+IHXFsqtea8U7dSOIUqSWapJui7ri3nA09iWxLIct/mbtTiUjfIR5ZaEbwTJ9gFdLqnPC3azMTOFhCFQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c6:b0:d77:bcce:eb11 with SMTP
 id j6-20020a05690212c600b00d77bcceeb11mr37382ybu.10.1692778162082; Wed, 23
 Aug 2023 01:09:22 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:23 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-21-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 20/25] perf pmu: Cache json events table
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the json events table so that finding it isn't done per
event/alias. Change the events table find so that when the PMU is
given, if the PMU has no json events return null. Update usage to
always use the PMU variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 14 ++++++++++++--
 tools/perf/tests/pmu-events.c    |  2 ++
 tools/perf/util/pmu.c            | 17 ++++++++---------
 tools/perf/util/pmu.h            |  4 ++++
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 991fcf6cca64..f07864fabd54 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -948,7 +948,7 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_table *table = NULL;
         char *cpuid = perf_pmu__getcpuid(pmu);
-        int i;
+        size_t i;
 
         /* on some platforms which uses cpus map, cpuid can be NULL for
          * PMUs other than CORE PMUs.
@@ -968,7 +968,17 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
                 }
         }
         free(cpuid);
-        return table;
+        if (!pmu)
+                return table;
+
+        for (i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                        return table;
+        }
+        return NULL;
 }
 
 const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct perf_pmu *pmu)
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 34f0de182fa9..4fcb84fd1f65 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -544,6 +544,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	INIT_LIST_HEAD(&pmu->list);
 	pmu->name = strdup(pmu_name);
 
+	pmu->events_table = table;
 	pmu_add_cpu_aliases_table(pmu, table);
 
 	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
@@ -583,6 +584,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	events_table = find_core_events_table("testarch", "testcpu");
 	if (!events_table)
 		return -1;
+	pmu->events_table = events_table;
 	pmu_add_cpu_aliases_table(pmu, events_table);
 	pmu_add_sys_aliases(pmu);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a7d96e309843..dabae2019bd0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -518,10 +518,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	}
 	if (!pe) {
 		/* Update an event from sysfs with json data. */
-		const struct pmu_events_table *table = perf_pmu__find_events_table(pmu);
-
-		if (table)
-			pmu_events_table__find_event(table, pmu, name, update_alias, alias);
+		if (pmu->events_table) {
+			pmu_events_table__find_event(pmu->events_table, pmu, name,
+						     update_alias, alias);
+		}
 	}
 
 	/* Scan event and remove leading zeroes, spaces, newlines, some
@@ -871,13 +871,10 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 {
-	const struct pmu_events_table *table;
-
-	table = perf_pmu__find_events_table(pmu);
-	if (!table)
+	if (!pmu->events_table)
 		return;
 
-	pmu_add_cpu_aliases_table(pmu, table);
+	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
 }
 
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
@@ -988,6 +985,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
+	pmu->events_table = perf_pmu__find_events_table(pmu);
 	pmu_add_cpu_aliases(pmu);
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
@@ -1001,6 +999,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	return NULL;
 }
 
+
 /* Creates the PMU when sysfs scanning fails. */
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 2b1730152bc0..6bf0fbde4e85 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -114,6 +114,10 @@ struct perf_pmu {
 	 * from json events in pmu-events.c.
 	 */
 	struct list_head aliases;
+	/**
+	 * @events_table: The events table for json events in pmu-events.c.
+	 */
+	const struct pmu_events_table *events_table;
 	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
 	/** @nr_caps: The length of the list caps. */
-- 
2.42.0.rc1.204.g551eb34607-goog

