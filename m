Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4AF785529
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjHWKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjHWIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C183172C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7493303b5cso3899125276.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778159; x=1693382959;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMP6WGJ4ddH4lGjG0xqZPHX/81hqViEaPRFSCM6GMJs=;
        b=LCiF7mKKBNCWe6UA5ZNJNsw+1D1U8GXTvTSEBdxde85gtj+RfhgcAXYkaHmPAx9mz/
         phYopS/cZP93lFTVYVOlH7qHr8En6seH5gj3SBwxQWsLRgoaiQM8W3Q5Zxt9XEOFIrVv
         r8E1m4EmddEunYNWeDreg7RyJC747ySljj32nPOAqkGFDoeUPr/LkaDx4nGe68UIko38
         2260GwXz5cIqCgo5sRmfaB8JNezwMSluKw9jyU9MVYl+a7kmwRdwzSExd6ROQEhuXjYJ
         7id1lSWoOLSSR+hrTY8EjmNalA7yANqSsGMbagsiilVepKuy4aY0H5XeP7hLeHgg60PQ
         SZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778159; x=1693382959;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMP6WGJ4ddH4lGjG0xqZPHX/81hqViEaPRFSCM6GMJs=;
        b=i5gNXN00MtLjTJpx5aWwYZjP7Zr0TVWVkRmjZY1nCTlFnbrhi9pQ80BtN4jtIQMe5T
         3zPtqOPApfTIL7I0h0in54cgxn5trbA1hnVlnIhvFMuqfE2jSo0bvxwD959+FYzcRmxW
         8HThE6hFLLLE39j6EF4fmWOIgklLFyXP9ewkyj1gAraUD2YC5KGcDz/f67iRMnqZQ2TA
         HMk54EMua51P69SyW2c2rr3fiiqSHCL8af+sRj88vMTq5/2EqiCXnvIRYFh3H14jbKsW
         LURZbP52XoLfAgZWH0JVSqSwF7vgSADGuFC1/m+c7HSyMbYvyAkalpj04TNAWspzQkSc
         yjmw==
X-Gm-Message-State: AOJu0YzxT7/R18EyWf+32ZTW7YtTKVAJXA6j2pinXhvy21fVDUQxKAMp
        dhNTmo3imM3NabvbviKYpRJegqc0lp/D
X-Google-Smtp-Source: AGHT+IE8NW0Ccx50IbVZq4xCWAoUT4Cy0sveUPZPfyLvneZJNoaHik39B0zDUW5X2csBd2ICVI6kIZS1N6g9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:ce87:0:b0:d3a:f3a6:ee64 with SMTP id
 x129-20020a25ce87000000b00d3af3a6ee64mr122626ybe.5.1692778159677; Wed, 23 Aug
 2023 01:09:19 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:22 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-20-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 19/25] perf pmu: Merge json events with sysfs at load time
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than load all sysfs events then parsing all json events and
merging with ones that already exist. When a sysfs event is loaded,
look for a corresponding json event and merge immediately.

To simplify the logic, early exit the perf_pmu__new_alias function if
an alias is attempted to be added twice - as merging has already been
explicitly handled.

Fix the copying of terms to a merged alias and some ENOMEM paths.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 177 +++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 89 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 069530b2f79e..a7d96e309843 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -373,38 +373,6 @@ static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
 	return 0;
 }
 
-static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
-				char **new_str)
-{
-	if (!*old_str)
-		goto set_new;
-
-	if (*new_str) {	/* Have new string, check with old */
-		if (strcasecmp(*old_str, *new_str))
-			pr_debug("alias %s differs in field '%s'\n",
-				 name, field);
-		zfree(old_str);
-	} else		/* Nothing new --> keep old string */
-		return;
-set_new:
-	*old_str = *new_str;
-	*new_str = NULL;
-}
-
-static void perf_pmu_update_alias(struct perf_pmu_alias *old,
-				  struct perf_pmu_alias *newalias)
-{
-	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
-	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
-			    &newalias->long_desc);
-	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
-	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
-	old->scale = newalias->scale;
-	old->per_pkg = newalias->per_pkg;
-	old->snapshot = newalias->snapshot;
-	memcpy(old->unit, newalias->unit, sizeof(old->unit));
-}
-
 /* Delete an alias entry. */
 static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
 {
@@ -428,26 +396,58 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 	}
 }
 
-/* Merge an alias, search in alias list. If this name is already
- * present merge both of them to combine all information.
- */
-static bool perf_pmu_merge_alias(struct perf_pmu *pmu,
-				 struct perf_pmu_alias *newalias)
+static struct perf_pmu_alias *perf_pmu__find_alias(const struct perf_pmu *pmu, const char *name)
 {
-	struct perf_pmu_alias *a;
+	struct perf_pmu_alias *alias;
 
-	list_for_each_entry(a, &pmu->aliases, list) {
-		if (!strcasecmp(newalias->name, a->name)) {
-			if (newalias->pmu_name && a->pmu_name &&
-			    !strcasecmp(newalias->pmu_name, a->pmu_name)) {
-				continue;
-			}
-			perf_pmu_update_alias(a, newalias);
-			perf_pmu_free_alias(newalias);
-			return true;
-		}
+	list_for_each_entry(alias, &pmu->aliases, list) {
+		if (!strcasecmp(alias->name, name))
+			return alias;
 	}
-	return false;
+	return NULL;
+}
+
+static bool assign_str(const char *name, const char *field, char **old_str,
+				const char *new_str)
+{
+	if (!*old_str && new_str) {
+		*old_str = strdup(new_str);
+		return true;
+	}
+
+	if (!new_str || !strcasecmp(*old_str, new_str))
+		return false; /* Nothing to update. */
+
+	pr_debug("alias %s differs in field '%s' ('%s' != '%s')\n",
+		name, field, *old_str, new_str);
+	zfree(old_str);
+	*old_str = strdup(new_str);
+	return true;
+}
+
+static int update_alias(const struct pmu_event *pe,
+			const struct pmu_events_table *table __maybe_unused,
+			void *vdata)
+{
+	struct perf_pmu_alias *alias = vdata;
+	int ret = 0;
+
+	assign_str(pe->name, "desc", &alias->desc, pe->desc);
+	assign_str(pe->name, "long_desc", &alias->long_desc, pe->long_desc);
+	assign_str(pe->name, "topic", &alias->topic, pe->topic);
+	alias->per_pkg = pe->perpkg;
+	if (assign_str(pe->name, "value", &alias->str, pe->event)) {
+		parse_events_terms__purge(&alias->terms);
+		ret = parse_events_terms(&alias->terms, pe->event, /*input=*/NULL);
+	}
+	if (!ret && pe->unit) {
+		char *unit;
+
+		ret = perf_pmu__convert_scale(pe->unit, &unit, &alias->scale);
+		if (!ret)
+			snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
+	}
+	return ret;
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name,
@@ -461,6 +461,11 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
 	bool deprecated = false, perpkg = false;
 
+	if (perf_pmu__find_alias(pmu, name)) {
+		/* Alias was already created/loaded. */
+		return 0;
+	}
+
 	if (pe) {
 		long_desc = pe->long_desc;
 		topic = pe->topic;
@@ -488,27 +493,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 		return ret;
 	}
 
-	/* Scan event and remove leading zeroes, spaces, newlines, some
-	 * platforms have terms specified as
-	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
-	 * and terms specified as event=0x91 (read from JSON files).
-	 *
-	 * Rebuild string to make alias->str member comparable.
-	 */
-	memset(newval, 0, sizeof(newval));
-	ret = 0;
-	list_for_each_entry(term, &alias->terms, list) {
-		if (ret)
-			ret += scnprintf(newval + ret, sizeof(newval) - ret,
-					 ",");
-		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
-			ret += scnprintf(newval + ret, sizeof(newval) - ret,
-					 "%s=%#x", term->config, term->val.num);
-		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
-			ret += scnprintf(newval + ret, sizeof(newval) - ret,
-					 "%s=%s", term->config, term->val.str);
-	}
-
 	alias->name = strdup(name);
 	if (dirfd >= 0) {
 		/*
@@ -524,17 +508,43 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	alias->long_desc = long_desc ? strdup(long_desc) :
 				desc ? strdup(desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
+	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
 	if (unit) {
-		if (perf_pmu__convert_scale(unit, (char **)&unit, &alias->scale) < 0)
+		if (perf_pmu__convert_scale(unit, (char **)&unit, &alias->scale) < 0) {
+			perf_pmu_free_alias(alias);
 			return -1;
+		}
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-	alias->str = strdup(newval);
-	alias->pmu_name = pmu_name ? strdup(pmu_name) : NULL;
+	if (!pe) {
+		/* Update an event from sysfs with json data. */
+		const struct pmu_events_table *table = perf_pmu__find_events_table(pmu);
 
-	if (!perf_pmu_merge_alias(pmu, alias))
-		list_add_tail(&alias->list, &pmu->aliases);
+		if (table)
+			pmu_events_table__find_event(table, pmu, name, update_alias, alias);
+	}
 
+	/* Scan event and remove leading zeroes, spaces, newlines, some
+	 * platforms have terms specified as
+	 * event=0x0091 (read from files ../<PMU>/events/<FILE>
+	 * and terms specified as event=0x91 (read from JSON files).
+	 *
+	 * Rebuild string to make alias->str member comparable.
+	 */
+	ret = 0;
+	list_for_each_entry(term, &alias->terms, list) {
+		if (ret)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 ",");
+		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%#x", term->config, term->val.num);
+		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
+			ret += scnprintf(newval + ret, sizeof(newval) - ret,
+					 "%s=%s", term->config, term->val.str);
+	}
+	alias->str = strdup(newval);
+	list_add_tail(&alias->list, &pmu->aliases);
 	return 0;
 }
 
@@ -940,6 +950,9 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	INIT_LIST_HEAD(&pmu->format);
 	INIT_LIST_HEAD(&pmu->aliases);
 	INIT_LIST_HEAD(&pmu->caps);
+	pmu->name = strdup(name);
+	if (!pmu->name)
+		goto err;
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -958,9 +971,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	}
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
-	pmu->name = strdup(name);
-	if (!pmu->name)
-		goto err;
 
 	/* Read type, and ensure that type value is successfully assigned (return 1) */
 	if (perf_pmu__scan_file_at(pmu, dirfd, "type", "%u", &type) != 1)
@@ -1353,17 +1363,6 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 	return perf_pmu__config_terms(pmu, attr, head_terms, zero, err);
 }
 
-static struct perf_pmu_alias *perf_pmu__find_alias(const struct perf_pmu *pmu, const char *str)
-{
-	struct perf_pmu_alias *alias;
-
-	list_for_each_entry(alias, &pmu->aliases, list) {
-		if (!strcasecmp(alias->name, str))
-			return alias;
-	}
-	return NULL;
-}
-
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 					     struct parse_events_term *term)
 {
-- 
2.42.0.rc1.204.g551eb34607-goog

