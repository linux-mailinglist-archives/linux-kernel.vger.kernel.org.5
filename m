Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0668778669C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjHXEPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbjHXEOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5710C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-591138c0978so54859307b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850453; x=1693455253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBwLMLKJCYv4PjzpijbZ5QEB0J7EgzXqXuvGjcNNjMg=;
        b=YpA22ufBJ40L0tFpmTZUdRNm9nXzndqEhhLcZJDP9SxcVdAABpavpRZFs+93KGCVSG
         3JhLpzc0f/2M+z4q7pH0MJnvdFjADtVTxRmBUyq73rvYX1lkhEDNgdcNDKi+bEYwB5At
         /OWw3ZWzfNaGYz+eAb9Duj0vqqUJjbKv7h+v44nigvQZGBdBK7S7alDIQABMiIfMPwaC
         9KQBNPRJIhZ8jaYN9E5s6CQfN5GemAejHQha8ZNyRQghtFsVEJ7F28IExMxMqOOppG9Z
         CZDBF7KJoybrbUs+lsNN0LyLOGrPyS5J0Mqi7AKysJj+uLBGxPQjub5XnSJz1AzQv0RF
         q6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850453; x=1693455253;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBwLMLKJCYv4PjzpijbZ5QEB0J7EgzXqXuvGjcNNjMg=;
        b=dQPgYMY6aufoDKNW/f3ckrJdklPrN4EFDviuJqMK3r3hEGWmbMsCNjwozlRaN5zrjL
         c7gcTAzNNxd6lKnXb7mRYdvbqFWKhAhfmdjPtZ7zmCv9RzFb1+klZ6nLX5NA1Nv6d3FD
         VXj0xNm4dZJyDDOej2SfUMV80wnIDy12FZW1Ompf+n+/wnAvxv8SEQWQMw7y+etYTxl5
         yELVZA4qychvi0BsbJCDZl08IDPjoGrSaJ2vrGDaLIuYxMH67eo+9jPAEvrpQsw0DR58
         50RhzbOcz2Xj3cFXfck9An22rUT6u6VnjV725GSMbBkPjcoSTk++4z3uNbpUq2+oxXX5
         IuoQ==
X-Gm-Message-State: AOJu0Yw+lHquBBvPjzMqFgZx6eSYkwBQrpjypesR8Wv0r9eSZG4Bj/Ij
        cFw7XxtYU4AOiJGv9LWR6zvU4AXrSyOx
X-Google-Smtp-Source: AGHT+IF7xRVc2r3KxWkbIkCWv31O+OU7P/dE1Z04f4HUkNLe1WV4gdaTWlFtjAZmDWdkS/JUvcTE3N6W8Xeg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a81:4303:0:b0:583:4f82:b9d9 with SMTP id
 q3-20020a814303000000b005834f82b9d9mr225721ywa.5.1692850453440; Wed, 23 Aug
 2023 21:14:13 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:24 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-13-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 12/18] perf pmu: Cache json events table
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 tools/perf/util/pmu.c            | 16 +++++++---------
 tools/perf/util/pmu.h            |  4 ++++
 4 files changed, 25 insertions(+), 11 deletions(-)

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
index bc2dd8f94bcf..685903c1970b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -522,10 +522,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
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
@@ -875,13 +875,10 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
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
@@ -992,6 +989,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
+	pmu->events_table = perf_pmu__find_events_table(pmu);
 	pmu_add_cpu_aliases(pmu);
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
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

