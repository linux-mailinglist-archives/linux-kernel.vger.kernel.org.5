Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74658786697
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbjHXEO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240123AbjHXEOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:14:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633F10F2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58ee4df08fbso84050287b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850447; x=1693455247;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nozX82LYkob4etjayWOPWotsGY16fgNQEBA5J9h7kqw=;
        b=7YqvCxcA2mHCu0e1kY99F65qxhuhYLFTf6tAMV9fXOtD74PP2yMEGjmXnfnAuMt6m2
         zHrr98CBLi4iexFuOWanfDp2Gbo3mdkbDkJzLgjuw6NF6+2+pHIzyK5mqAXCYNoQEpDh
         wXCgIXEUgZolWK/Kc9M8atpA/35EJ2FdNym80jUJHKKe/uM1LcKWHf1Kno8psyjOKFww
         Xj52XFEHU+XZDkFjLl9ngkh6mcNmtnJ/eRvvBVATmfQ7oXrtzpYdUmsQoI0EhJNIjEvD
         CeAz897WnAMOV5hxFx6Zyu9fmq378N3c1O3JGkTM0sr7VlqTxN0Eu1Fw9zp+2PjdaANd
         FODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850447; x=1693455247;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nozX82LYkob4etjayWOPWotsGY16fgNQEBA5J9h7kqw=;
        b=kg/u4Adzm30LaOEGaPqcn35HkcFYkMYtV3bBW+WYjj3fqp9ingA4ZWqEDMXAwa839q
         0pJRdWASTSYeE43kVJRrhMf3XPfCG2T0n4dIX8gxFIt6pmhMjP0D77gfOQWhDIBj+Cd9
         8uoITmZKkPlr8q/qNBgqb6txG5/00Om/7exUh6BD9bFFDm5wHqB5jw5Mv3QlyCOBlyE+
         di1GhnUpRNVTKCXPJEIwnZi9va5u5Axbz7E7+2lZyR0jvv3J/J0GUAmg+kEL2qD+qugQ
         PsTtii4ottnlALZZyhzaNnt6MsKWDiap/FKct6/kBV9M/LU0VE528iEeOjxU+YjtfXrY
         enFg==
X-Gm-Message-State: AOJu0YyriLATsELHbOCPV3DTnyDJ807jK0w9gEvnMiGgkmR1pbmlfzei
        QfoTzN/tFLhetZrfQqR9chL7lE2pr0Bt
X-Google-Smtp-Source: AGHT+IGRkvANlsRtSIEn7dTLGDtKZtdJDNqrEV9GAp9+8SMGYu/k1HMMD9hBeJRKxtOIvVrn3ITDSzM962GP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a25:41c1:0:b0:d45:daf4:1fc5 with SMTP id
 o184-20020a2541c1000000b00d45daf41fc5mr186638yba.3.1692850447358; Wed, 23 Aug
 2023 21:14:07 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:22 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-11-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 10/18] perf pmu: Prefer passing pmu to aliases list
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
index 263c63eabc2e..c37d98a11861 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -435,12 +435,12 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
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
@@ -454,7 +454,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
 	return false;
 }
 
-static int perf_pmu__new_alias(struct list_head *list, int dirfd, const char *name,
+static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name,
 				const char *desc, const char *val, FILE *val_fd,
 				const struct pmu_event *pe)
 {
@@ -536,8 +536,8 @@ static int perf_pmu__new_alias(struct list_head *list, int dirfd, const char *na
 	alias->str = strdup(newval);
 	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 
-	if (!perf_pmu_merge_alias(alias, list))
-		list_add_tail(&alias->list, list);
+	if (!perf_pmu_merge_alias(pmu, alias))
+		list_add_tail(&alias->list, &pmu->aliases);
 
 	return 0;
 }
@@ -563,7 +563,7 @@ static inline bool pmu_alias_info_file(char *name)
  * Process all the sysfs attributes located under the directory
  * specified in 'dir' parameter.
  */
-static int pmu_aliases_parse(int dirfd, struct list_head *head)
+static int pmu_aliases_parse(struct perf_pmu *pmu, int dirfd)
 {
 	struct dirent *evt_ent;
 	DIR *event_dir;
@@ -597,7 +597,7 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
 			continue;
 		}
 
-		if (perf_pmu__new_alias(head, dirfd, name, /*desc=*/ NULL,
+		if (perf_pmu__new_alias(pmu, dirfd, name, /*desc=*/ NULL,
 					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
@@ -620,7 +620,7 @@ static int pmu_aliases(struct perf_pmu *pmu, int dirfd, const char *name)
 		return 0;
 
 	/* it'll close the fd */
-	if (pmu_aliases_parse(fd, &pmu->aliases))
+	if (pmu_aliases_parse(pmu, fd))
 		return -1;
 
 	return 0;
@@ -848,10 +848,9 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
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
 
@@ -861,7 +860,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
  */
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_table *table)
 {
-	pmu_events_table__for_each_event(table, pmu, pmu_add_cpu_aliases_map_callback, &pmu->aliases);
+	pmu_events_table__for_each_event(table, pmu, pmu_add_cpu_aliases_map_callback, pmu);
 }
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
@@ -875,24 +874,18 @@ static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
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
@@ -905,15 +898,10 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 
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

