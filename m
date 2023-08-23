Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7A785527
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjHWKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjHWILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:11:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93821E72
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74a012e6a6so3645583276.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778165; x=1693382965;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBOzUn7kVci/f1ahcDivuamI46IHq10R7u54lzmBAPU=;
        b=IJSDaIcKFqNAEj4/KIUcavGeF0CnQEdrBrXhtZOra6WXuy6CwIcMxSexfrznViOFlR
         iXTpOV0ibacY3lRGHKXD+RCcs2XcWG2NdFqHR1PgtduhiF2NCgNUwt6dfGgwGdRE+aoo
         kEvTkq4yvA1TZMTo5j1C8hSgyFgVKkmnH9drbFMPtqgRIFk5V0P0f+WJ+S2HjHAUdOQ6
         NEwj/rBSoO/9DJWAIVgjkao89ac7w6vR344qfjOvmtpPjh/APQi7OCT9GLee+DDtFhY7
         xInnVZUXJOvqU9rJ58/Rijhw0tedL7tRKJaK6eWOeNtsx0PLqyADYFK55USOgI4i8y2i
         HX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778165; x=1693382965;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBOzUn7kVci/f1ahcDivuamI46IHq10R7u54lzmBAPU=;
        b=FSz8ZOK8EtIaPSfqLB1CPewJOcZciWyA98WoMwggu/OZ51/RNMlsSUbVyJOBOKKW0q
         gDZ2SZhMwWl8dITmOI5DViYmpQp6bpFY2CLGeBnw83PBo2PijNbYSGrGHtajsPoDy1dY
         dPMgDcnMkqK1A8sovy/tJi8IZG0Fp0/9lDAVDfmiH8e0i/qH4apNh3yq2GvmNUjZJPvb
         D1n09yzG24OJfGUaGOGgiaqNn9rI6JULEkRLFGDgxIs5p6o3Qv3WS0nKC0XbEHBahgx0
         JQEfpN+rb62oIsuovSdEPG6o1ple2Q4e5rG2zBnoiJYdVbxqMlu5+QZ9P6blrTgh6uA3
         6j5Q==
X-Gm-Message-State: AOJu0Ywo/H0QjVYwWaZQBvN+CL4AC7/DChvxUjDk+eJP9xE6eKdTHWX4
        hTQUJCYuZ/jYauYoRA2ty2oQpQdP918f
X-Google-Smtp-Source: AGHT+IEO8BuEoHXgZz7PBKUmwF4RjHrASpuqs/bXkO7Zbrhl9XrQAy4w/XWl4BRycEi5RrvKilwspuRKQBKc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c6:b0:d77:bcce:eb11 with SMTP
 id j6-20020a05690212c600b00d77bcceeb11mr37384ybu.10.1692778164548; Wed, 23
 Aug 2023 01:09:24 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:24 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-22-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 21/25] perf pmu: Lazily add json events
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than scanning all json events and adding them when a PMU is
created, add the alias when the json event is needed.

Average core PMU scanning run time reduced by 60.2%. Average PMU
scanning run time reduced by 15%. Page faults with no events reduced
by 74 page faults, 4% of total.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 14 +++++++
 tools/perf/pmu-events/jevents.py         | 15 +++++++
 tools/perf/pmu-events/pmu-events.h       |  4 ++
 tools/perf/tests/pmu-events.c            |  2 +
 tools/perf/util/pmu.c                    | 50 ++++++++++++++++++------
 tools/perf/util/pmu.h                    | 15 +++++--
 6 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index ef18d403f25f..12bd043a05e3 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -298,6 +298,20 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
         return -1000;
 }
 
+size_t pmu_events_table__num_events(const struct pmu_events_table *table,
+                                    struct perf_pmu *pmu)
+{
+        size_t count = 0;
+
+	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
+                if (pmu && !pmu__name_match(pmu, pe->pmu))
+                        continue;
+
+		count++;
+	}
+        return count;
+}
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				      void *data)
 {
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index f07864fabd54..01335a452e70 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -909,6 +909,21 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
         return -1000;
 }
 
+size_t pmu_events_table__num_events(const struct pmu_events_table *table,
+                                    struct perf_pmu *pmu)
+{
+        size_t count = 0;
+
+        for (size_t i = 0; i < table->num_pmus; i++) {
+                const struct pmu_table_entry *table_pmu = &table->pmus[i];
+                const char *pmu_name = &big_c_string[table_pmu->pmu_name.offset];
+
+                if (pmu__name_match(pmu, pmu_name))
+                        count += table_pmu->num_entries;
+        }
+        return count;
+}
+
 static int pmu_metrics_table__for_each_metric_pmu(const struct pmu_metrics_table *table,
                                                 const struct pmu_table_entry *pmu,
                                                 pmu_metric_iter_fn fn,
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 9882b7125761..f5aa96f1685c 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -3,6 +3,7 @@
 #define PMU_EVENTS_H
 
 #include <stdbool.h>
+#include <stddef.h>
 
 struct perf_pmu;
 
@@ -86,6 +87,9 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
                                  const char *name,
                                  pmu_event_iter_fn fn,
 				 void *data);
+size_t pmu_events_table__num_events(const struct pmu_events_table *table,
+				    struct perf_pmu *pmu);
+
 int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 4fcb84fd1f65..9ac893ae5f0d 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -546,6 +546,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 
 	pmu->events_table = table;
 	pmu_add_cpu_aliases_table(pmu, table);
+	pmu->cpu_aliases_added = true;
 
 	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
 	if (res != 0) {
@@ -586,6 +587,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 		return -1;
 	pmu->events_table = events_table;
 	pmu_add_cpu_aliases_table(pmu, events_table);
+	pmu->cpu_aliases_added = true;
 	pmu_add_sys_aliases(pmu);
 
 	/* Count how many aliases we generated */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index dabae2019bd0..81a40fe02d65 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -519,8 +519,9 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	if (!pe) {
 		/* Update an event from sysfs with json data. */
 		if (pmu->events_table) {
-			pmu_events_table__find_event(pmu->events_table, pmu, name,
-						     update_alias, alias);
+			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
+							 update_alias, alias) == 0)
+				pmu->loaded_json_aliases++;
 		}
 	}
 
@@ -544,6 +545,10 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 					 "%s=%s", term->config, term->val.str);
 	}
 	alias->str = strdup(newval);
+	if (!pe)
+		pmu->sysfs_aliases++;
+	else
+		pmu->loaded_json_aliases++;
 	list_add_tail(&alias->list, &pmu->aliases);
 	return 0;
 }
@@ -874,7 +879,11 @@ static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 	if (!pmu->events_table)
 		return;
 
+	if (pmu->cpu_aliases_added)
+		return;
+
 	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
+	pmu->cpu_aliases_added = true;
 }
 
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
@@ -986,7 +995,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
-	pmu_add_cpu_aliases(pmu);
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
@@ -1365,6 +1373,7 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 					     struct parse_events_term *term)
 {
+	struct perf_pmu_alias *alias;
 	char *name;
 
 	if (parse_events__is_hardcoded_term(term))
@@ -1385,7 +1394,18 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return NULL;
 	}
 
-	return perf_pmu__find_alias(pmu, name);
+	alias = perf_pmu__find_alias(pmu, name);
+	if (alias || pmu->cpu_aliases_added)
+		return alias;
+
+	/* Alias doesn't exist, try to get it from the json events. */
+	if (pmu->events_table &&
+	    pmu_events_table__find_event(pmu->events_table, pmu, name,
+				         pmu_add_cpu_aliases_map_callback,
+				         pmu) == 0) {
+		alias = perf_pmu__find_alias(pmu, name);
+	}
+	return alias;
 }
 
 
@@ -1552,18 +1572,23 @@ bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 	return !pmu->is_core || perf_pmus__num_core_pmus() == 1;
 }
 
-bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name)
+bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 {
-	return perf_pmu__find_alias(pmu, name) != NULL;
+	if (perf_pmu__find_alias(pmu, name) != NULL)
+		return true;
+	if (pmu->cpu_aliases_added || !pmu->events_table)
+		return false;
+	return pmu_events_table__find_event(pmu->events_table, pmu, name, NULL, NULL) == 0;
 }
 
-size_t perf_pmu__num_events(const struct perf_pmu *pmu)
+size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
-	struct list_head *list;
-	size_t nr = 0;
+	size_t nr = pmu->sysfs_aliases;
 
-	list_for_each(list, &pmu->aliases)
-		nr++;
+	if (pmu->cpu_aliases_added)
+		 nr += pmu->loaded_json_aliases;
+	else if (pmu->events_table)
+		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
 
 	return pmu->selectable ? nr + 1 : nr;
 }
@@ -1601,7 +1626,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 	return buf;
 }
 
-int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
 {
 	char buf[1024];
 	struct perf_pmu_alias *event;
@@ -1610,6 +1635,7 @@ int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_
 	};
 	int ret = 0;
 
+	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6bf0fbde4e85..288d2908382a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -118,6 +118,15 @@ struct perf_pmu {
 	 * @events_table: The events table for json events in pmu-events.c.
 	 */
 	const struct pmu_events_table *events_table;
+	/** @sysfs_aliases: Number of sysfs aliases loaded. */
+	uint32_t sysfs_aliases;
+	/** @sysfs_aliases: Number of json event aliases loaded. */
+	uint32_t loaded_json_aliases;
+	/**
+	 * @cpu_aliases_added: Have all json events table entries for the PMU
+	 * been added?
+	 */
+	bool cpu_aliases_added;
 	/** @caps_initialized: Has the list caps been initialized? */
 	bool caps_initialized;
 	/** @nr_caps: The length of the list caps. */
@@ -199,9 +208,9 @@ bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
-bool perf_pmu__have_event(const struct perf_pmu *pmu, const char *name);
-size_t perf_pmu__num_events(const struct perf_pmu *pmu);
-int perf_pmu__for_each_event(const struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name);
+size_t perf_pmu__num_events(struct perf_pmu *pmu);
+int perf_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
 bool pmu__name_match(const struct perf_pmu *pmu, const char *pmu_name);
 
 /**
-- 
2.42.0.rc1.204.g551eb34607-goog

