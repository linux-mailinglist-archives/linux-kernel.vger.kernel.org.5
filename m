Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2539785294
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjHWIUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjHWILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:11:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFDE173D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7496b91389so6213121276.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778170; x=1693382970;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sO0nlbdYRpBXpPj2SCUtbtEV/g4IZLNC6VGcNaYE9js=;
        b=YVD+4vBEFiQzf4kVYZvEraiaWkZF5WarI2tHI4PfXpfRPLSCo9GX2y3E+LHTZ2RdYT
         fFNJ17mYrIRSaqkNUcDlKTYS7PF9ssMtGBOofKZQ/HU8TPn6VMHoq8qr4Y+fT8jHyk9y
         oSM++hKNJwP53jJml6aynN6Jrz0UQ4rTKEbDrtN4CcN4UaDIxfdM5HuodMqvZxOjP7vE
         3U0oBdMQA3ZtgLMD6x8Ewua0UfjxXTT80GxJn/Mwsndog9G8eKzIcwEF4M9ECOi7kXWp
         /ccaBKCzhotlgcGL2HDFAHR21WvwtO+qTd1DtskHmGGkJHeJENRQ9/3ZHclAbuoog3I/
         y3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778170; x=1693382970;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sO0nlbdYRpBXpPj2SCUtbtEV/g4IZLNC6VGcNaYE9js=;
        b=ND/QPnS52LdgspSL60+CwBzyrXudjEnDGMU3dIu6v/wqogiHwHBcMGMndd/bHt4bZG
         LqkT22XeUYeo374ng3Zr9YtYw1wxf9w+pkUqYImzVLab8YKwuF+iaTGYu7YP0ZngL0Fc
         jwyeLH//sq+JRAXXpz0jmuXCfTXD8Hb7iS4q9oDfSwpNp/2VfOw6Qi0OOJDQ+rI/M/16
         vPkm2+Bp3qTB8Qt0mIO1KuctMtrSTsfTRmQ9IZqNNgUO7s7VKzOy08Mdjft/a7qXBwQI
         vjrkOsElpLcmiFdnwpWDPD6dzuDB0TTbexzXbeZg8FRMP0NyNBf093yisyp2N916ETlW
         AZ1w==
X-Gm-Message-State: AOJu0YyStavFlWKzDczTw0d0u18BwrCMy/z8eJy8OuVSOblV/7gT6l3/
        Tj103RD9qNDexfVZC6hDifIL3y+iXzRT
X-Google-Smtp-Source: AGHT+IFcw6ORSo1i+RD3UKL/v2KyU9JDq2+rO9G6maG86y0uRyKzVhVlAiKR8i2TVGGqsDP2IDAyxs2O5VQh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:e68a:0:b0:d10:a33d:36b6 with SMTP id
 d132-20020a25e68a000000b00d10a33d36b6mr213223ybh.0.1692778170525; Wed, 23 Aug
 2023 01:09:30 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:26 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-24-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 23/25] perf pmu: Be lazy about loading event info files
 from sysfs
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

Event info is only needed when an event is parsed or when merging data
from an json and sysfs event. Be lazy in its loading to reduce file
accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 128 +++++++++++++++++++++++++++---------------
 1 file changed, 83 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b4ba4f7f5e18..c547fe607f9f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -58,6 +58,11 @@ struct perf_pmu_alias {
 	struct list_head terms;
 	/** @list: List element of struct perf_pmu aliases. */
 	struct list_head list;
+	/**
+	 * @pmu_name: The name copied from the json struct pmu_event. This can
+	 * differ from the PMU name as it won't have suffixes.
+	 */
+	char *pmu_name;
 	/** @unit: Units for the event, such as bytes or cache lines. */
 	char unit[UNIT_MAX_LEN+1];
 	/** @scale: Value to scale read counter values by. */
@@ -79,11 +84,10 @@ struct perf_pmu_alias {
 	 * default.
 	 */
 	bool deprecated;
-	/**
-	 * @pmu_name: The name copied from the json struct pmu_event. This can
-	 * differ from the PMU name as it won't have suffixes.
-	 */
-	char *pmu_name;
+	/** @from_sysfs: Was the alias from sysfs or a json event? */
+	bool from_sysfs;
+	/** @info_loaded: Have the scale, unit and other values been read from disk? */
+	bool info_loaded;
 };
 
 /**
@@ -276,17 +280,21 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 	return ret;
 }
 
-static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd, const char *name)
+static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
 	struct stat st;
 	ssize_t sret;
+	size_t len;
 	char scale[128];
 	int fd, ret = -1;
 	char path[PATH_MAX];
 
-	scnprintf(path, PATH_MAX, "%s.scale", name);
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/%s.scale", pmu->name, alias->name);
 
-	fd = openat(dirfd, path, O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -308,15 +316,20 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd, const
 	return ret;
 }
 
-static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd, const char *name)
+static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
 	char path[PATH_MAX];
+	size_t len;
 	ssize_t sret;
 	int fd;
 
-	scnprintf(path, PATH_MAX, "%s.unit", name);
 
-	fd = openat(dirfd, path, O_RDONLY);
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/%s.unit", pmu->name, alias->name);
+
+	fd = open(path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -339,14 +352,18 @@ static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd, const c
 }
 
 static int
-perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, const char *name)
+perf_pmu__parse_per_pkg(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
 	char path[PATH_MAX];
+	size_t len;
 	int fd;
 
-	scnprintf(path, PATH_MAX, "%s.per-pkg", name);
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/%s.per-pkg", pmu->name, alias->name);
 
-	fd = openat(dirfd, path, O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -356,15 +373,18 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, const char *nam
 	return 0;
 }
 
-static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
-				    int dirfd, const char *name)
+static int perf_pmu__parse_snapshot(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
 {
 	char path[PATH_MAX];
+	size_t len;
 	int fd;
 
-	scnprintf(path, PATH_MAX, "%s.snapshot", name);
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/%s.snapshot", pmu->name, alias->name);
 
-	fd = openat(dirfd, path, O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd == -1)
 		return -1;
 
@@ -425,32 +445,52 @@ static bool assign_str(const char *name, const char *field, char **old_str,
 	return true;
 }
 
+static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
+{
+	if (!alias->from_sysfs || alias->info_loaded)
+		return;
+
+	/*
+	 * load unit name and scale if available
+	 */
+	perf_pmu__parse_unit(pmu, alias);
+	perf_pmu__parse_scale(pmu, alias);
+	perf_pmu__parse_per_pkg(pmu, alias);
+	perf_pmu__parse_snapshot(pmu, alias);
+}
+
+struct update_alias_data {
+	struct perf_pmu *pmu;
+	struct perf_pmu_alias *alias;
+};
+
 static int update_alias(const struct pmu_event *pe,
 			const struct pmu_events_table *table __maybe_unused,
 			void *vdata)
 {
-	struct perf_pmu_alias *alias = vdata;
+	struct update_alias_data *data = vdata;
 	int ret = 0;
 
-	assign_str(pe->name, "desc", &alias->desc, pe->desc);
-	assign_str(pe->name, "long_desc", &alias->long_desc, pe->long_desc);
-	assign_str(pe->name, "topic", &alias->topic, pe->topic);
-	alias->per_pkg = pe->perpkg;
-	if (assign_str(pe->name, "value", &alias->str, pe->event)) {
-		parse_events_terms__purge(&alias->terms);
-		ret = parse_events_terms(&alias->terms, pe->event, /*input=*/NULL);
+	read_alias_info(data->pmu, data->alias);
+	assign_str(pe->name, "desc", &data->alias->desc, pe->desc);
+	assign_str(pe->name, "long_desc", &data->alias->long_desc, pe->long_desc);
+	assign_str(pe->name, "topic", &data->alias->topic, pe->topic);
+	data->alias->per_pkg = pe->perpkg;
+	if (assign_str(pe->name, "value", &data->alias->str, pe->event)) {
+		parse_events_terms__purge(&data->alias->terms);
+		ret = parse_events_terms(&data->alias->terms, pe->event, /*input=*/NULL);
 	}
 	if (!ret && pe->unit) {
 		char *unit;
 
-		ret = perf_pmu__convert_scale(pe->unit, &unit, &alias->scale);
+		ret = perf_pmu__convert_scale(pe->unit, &unit, &data->alias->scale);
 		if (!ret)
-			snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
+			snprintf(data->alias->unit, sizeof(data->alias->unit), "%s", unit);
 	}
 	return ret;
 }
 
-static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name,
+static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 				const char *desc, const char *val, FILE *val_fd,
 				const struct pmu_event *pe)
 {
@@ -494,16 +534,6 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	}
 
 	alias->name = strdup(name);
-	if (dirfd >= 0) {
-		/*
-		 * load unit name and scale if available
-		 */
-		perf_pmu__parse_unit(alias, dirfd, name);
-		perf_pmu__parse_scale(alias, dirfd, name);
-		perf_pmu__parse_per_pkg(alias, dirfd, name);
-		perf_pmu__parse_snapshot(alias, dirfd, name);
-	}
-
 	alias->desc = desc ? strdup(desc) : NULL;
 	alias->long_desc = long_desc ? strdup(long_desc) :
 				desc ? strdup(desc) : NULL;
@@ -518,9 +548,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, int dirfd, const char *name
 	}
 	if (!pe) {
 		/* Update an event from sysfs with json data. */
+		struct update_alias_data data = {
+			.pmu = pmu,
+			.alias = alias,
+		};
+
+		alias->from_sysfs = true;
 		if (pmu->events_table) {
 			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
-							 update_alias, alias) == 0)
+							 update_alias, &data) == 0)
 				pmu->loaded_json_aliases++;
 		}
 	}
@@ -608,7 +644,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu, int dirfd)
 			continue;
 		}
 
-		if (perf_pmu__new_alias(pmu, dirfd, name, /*desc=*/ NULL,
+		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
 					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
@@ -861,7 +897,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, -1, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
 	return 0;
 }
 
@@ -897,7 +933,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 
 	if (!strcmp(pmu->id, pe->compat) &&
 	    pmu_uncore_alias_match(pe->pmu, pmu->name)) {
-		perf_pmu__new_alias(pmu, -1,
+		perf_pmu__new_alias(pmu,
 				pe->name,
 				pe->desc,
 				pe->event,
@@ -1413,11 +1449,13 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 }
 
 
-static int check_info_data(struct perf_pmu_alias *alias,
+static int check_info_data(struct perf_pmu *pmu,
+			   struct perf_pmu_alias *alias,
 			   struct perf_pmu_info *info,
 			   struct parse_events_error *err,
 			   int column)
 {
+	read_alias_info(pmu, alias);
 	/*
 	 * Only one term in event definition can
 	 * define unit, scale and snapshot, fail
@@ -1487,7 +1525,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			return ret;
 		}
 
-		ret = check_info_data(alias, info, err, term->err_term);
+		ret = check_info_data(pmu, alias, info, err, term->err_term);
 		if (ret)
 			return ret;
 
-- 
2.42.0.rc1.204.g551eb34607-goog

