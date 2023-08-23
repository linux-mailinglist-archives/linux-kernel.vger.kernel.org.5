Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0007578552D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjHWKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHWIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1761722
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d71f505d21dso6364804276.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778157; x=1693382957;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBddR/dgewe8GYO0FrkatqTRkhbux9YJuNBE1TDZZC0=;
        b=oziN7b6v5AfOnHzKPspObBatkOujx0BnpIlhrQJjeaf0TmwdEkszLP6tax+sjFW20d
         2YuJTAmLZc5IyVKF8NTcp320rtRYcUmQJcwTyTJQo7vFBCfWVSiwkoGY97qK5vN4+KDZ
         jGoeAiFMCl4k+NfJb84YnDvpwgQw9F2AWgl8XOxgaLFDO/Je3iqv0Qsx6XBwSsaoNMTc
         NwIBT9EwANSQlcHNs6FF1zEpxH112+SFmqj2MoTa1ASzE43aUJBvY1t5ZMlkvL1GNEX3
         1fg9awA0/hXvI+SHg00x4qXqzk8kLqPTSooGqFjyCoTjyaoS/tHHqaKRA8qp1Q2CkZwJ
         6ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778157; x=1693382957;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBddR/dgewe8GYO0FrkatqTRkhbux9YJuNBE1TDZZC0=;
        b=YAivrT/jaRG3rnrVgd63gIzIcP+eUPnvhq1XLj8e8pw0dxgXYuicwz8Ri0MYn7FkQK
         0J+tvhRDcuWMpzruXRF2I7CkIrT2e5bW139E6SZaoO6XuIeWFqGACiUo3o6/LkVBtwCr
         7PbLwQF+wiPDgttt4pZvJ/27ocf3l1KaaoD6rzDG43O5Q9DhLWCzag7kh+6mfaIuvuyk
         nAxIAX236y57lTtOYt6YA/bWq20tfDzbmS1ocH663Dh6bVmCqO5GnitafcEwSvAU7gOO
         50duaPC7vjJFxwtNQTJfGsqwMZqXn+E1+PaChvUUB+KwqwrPdpVBlUYrevzd+kY9wjef
         OJZQ==
X-Gm-Message-State: AOJu0Yw4spW1wrRho8Tw0JwhH/CEGW6NFErIXFP3uKliGsrmNxuV9Ep7
        ToxClIzzAp4azcat4egFFpalnb/eWKqB
X-Google-Smtp-Source: AGHT+IGsvh02i20oTWovc7RDuu05QsrjrwbHMB9S3aGw8G43nY8jhiQG+e0qNu5wNDADshfI0YdsG9U6Ekom
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:25d7:0:b0:d4b:99ce:5e51 with SMTP id
 l206-20020a2525d7000000b00d4b99ce5e51mr128199ybl.6.1692778157056; Wed, 23 Aug
 2023 01:09:17 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:21 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-19-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 18/25] perf pmu: Prefer passing pmu to aliases list
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

The aliases list is part of the PMU. Rather than pass the aliases
list, pass the full PMU simplifying some callbacks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 44 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6db14967ded9..069530b2f79e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -431,12 +431,12 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 /* Merge an alias, search in alias list. If this name is already
  * present merge both of them to combine all information.
  */
-static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
-				 struct list_head *alist)
+static bool perf_pmu_merge_alias(struct perf_pmu *pmu,
+				 struct perf_pmu_alias *newalias)
 {
 	struct perf_pmu_alias *a;
 
-	list_for_each_entry(a, alist, list) {
+	list_for_each_entry(a, &pmu->aliases, list) {
 		if (!strcasecmp(newalias->name, a->name)) {
 			if (newalias->pmu_name && a->pmu_name &&
 			    !strcasecmp(newalias->pmu_name, a->pmu_name)) {
@@ -450,7 +450,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 	return false;
 }
 
-static int perf_pmu__new_alias(struct list_head *list, int dirfd, const char *name,
+static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name,
 				const char *desc, const char *val, FILE *val_fd,
 				const struct pmu_event *pe)
 {
@@ -532,8 +532,8 @@ static int perf_pmu__new_alias(struct list_head *list, int dirfd, const char *na
 	alias->str = strdup(newval);
 	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 
-	if (!perf_pmu_merge_alias(alias, list))
-		list_add_tail(&alias->list, list);
+	if (!perf_pmu_merge_alias(pmu, alias))
+		list_add_tail(&alias->list, &pmu->aliases);
 
 	return 0;
 }
@@ -559,7 +559,7 @@ static inline bool pmu_alias_info_file(char *name)
  * Process all the sysfs attributes located under the directory
  * specified in 'dir' parameter.
  */
-static int pmu_aliases_parse(int dirfd, struct list_head *head)
+static int pmu_aliases_parse(struct perf_pmu *pmu, int dirfd)
 {
 	struct dirent *evt_ent;
 	DIR *event_dir;
@@ -593,7 +593,7 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
 			continue;
 		}
 
-		if (perf_pmu__new_alias(head, dirfd, name, /*desc=*/ NULL,
+		if (perf_pmu__new_alias(pmu, dirfd, name, /*desc=*/ NULL,
 					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
@@ -616,7 +616,7 @@ static int pmu_aliases(struct perf_pmu *pmu, int dirfd, const char *name)
 		return 0;
 
 	/* it'll close the fd */
-	if (pmu_aliases_parse(fd, &pmu->aliases))
+	if (pmu_aliases_parse(pmu, fd))
 		return -1;
 
 	return 0;
@@ -844,10 +844,9 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 					const struct pmu_events_table *table __maybe_unused,
 					void *vdata)
 {
-	struct list_head *head = vdata;
+	struct perf_pmu *pmu = vdata;
 
-	/* need type casts to override 'const' */
-	perf_pmu__new_alias(head, -1, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
+	perf_pmu__new_alias(pmu, -1, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
 	return 0;
 }
 
@@ -857,7 +856,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
  */
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_table *table)
 {
-	pmu_events_table__for_each_event(table, pmu, pmu_add_cpu_aliases_map_callback, &pmu->aliases);
+	pmu_events_table__for_each_event(table, pmu, pmu_add_cpu_aliases_map_callback, pmu);
 }
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
@@ -871,24 +870,18 @@ static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 	pmu_add_cpu_aliases_table(pmu, table);
 }
 
-struct pmu_sys_event_iter_data {
-	struct list_head *head;
-	struct perf_pmu *pmu;
-};
-
 static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				       const struct pmu_events_table *table __maybe_unused,
-				       void *data)
+				       void *vdata)
 {
-	struct pmu_sys_event_iter_data *idata = data;
-	struct perf_pmu *pmu = idata->pmu;
+	struct perf_pmu *pmu = vdata;
 
 	if (!pe->compat || !pe->pmu)
 		return 0;
 
 	if (!strcmp(pmu->id, pe->compat) &&
 	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
-		perf_pmu__new_alias(idata->head, -1,
+		perf_pmu__new_alias(pmu, -1,
 				pe->name,
 				pe->desc,
 				pe->event,
@@ -901,15 +894,10 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 
 void pmu_add_sys_aliases(struct perf_pmu *pmu)
 {
-	struct pmu_sys_event_iter_data idata = {
-		.head = &pmu->aliases,
-		.pmu = pmu,
-	};
-
 	if (!pmu->id)
 		return;
 
-	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, &idata);
+	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, pmu);
 }
 
 struct perf_event_attr * __weak
-- 
2.42.0.rc1.204.g551eb34607-goog

