Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF357AD01E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjIYGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjIYGYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:24:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBC5E5C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:24:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59beea5ce93so163511067b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695623068; x=1696227868; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66Z0VZtyUYys0PdxQ7OWuDfLkowOhrBXRt1ENvc5Q34=;
        b=jB3XHqWs6yBx5WFm/ZvWhL3vJyZ1RrstswS1CHBYQVjA+5yQleA1IiP+oAmzBPQSL2
         7xD4uw80BXZGQgLJcxx9rIGZSU+SQZSzzH4ODoMx4WwCI5YSs2c+bSHUbtOPU6lgz97r
         +VEiygMmgyY+sIEOkVBXK+piu9eAoY0UVApJF8AnDzsDgRx5kY3SnpKNBsqzziszXEoo
         p41MadR22mNGWgqUUvIHLAXSF8xbyGK3q38etf++L7EyOxPAxaWRHwel0as+IL5K7nlp
         C1MngSYx50qnvyzCSAPl8gJNIlhygFOL5yO8kB10lTaVjTAbUattbnOIJbkDWH0W6/be
         /L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695623068; x=1696227868;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66Z0VZtyUYys0PdxQ7OWuDfLkowOhrBXRt1ENvc5Q34=;
        b=o3b4hXlZMvWeG4MeqJ3ssKYbgv/cMrKdFLlrgC10tW+vOHp4fi1wfioHA74r/9tvB8
         R9pb8nIDbzqgSRnVmB5zEh3xG4gPLfj9ynhDNrhLQclowlS3xRFdPx2mP2KrOu+6cvXC
         hacYIGMVpLzvWQSGOaUeXNd/clTBF5KkZgp172wCtDFa8FcTqS+kUrzZDRT6/AV+MYYr
         ZTtjet5PKmQv1DgRXjZKk3L+79SA0Q33/otMkvN1wHKs4N4Dg14U6Hsd+DH1Z1BtXqGv
         ReVFVJT+Vxs0lJVAC2oQgrUGEli3aXQMnvcVk5c/HDUMkZtbVU9yGaIe257+Dn5lAp9Y
         p8Sg==
X-Gm-Message-State: AOJu0Ywn9ZNBWfw/qwmSIB1IbCZ4qG08rFZeDT3j69hq2E+Yp8t2+qmL
        tyLEQ9q4wXBtGD2t6USOapOQ7TfFsTXQ
X-Google-Smtp-Source: AGHT+IFRzYD0MmvHuqoLSZgcjVTtth3pN3U1O0gxgnvc+hmvYLHm63JgsQnLUn8tN4x1rYF1tgr5YJW0Dle/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a8a5:e1ea:d5a4:5980])
 (user=irogers job=sendgmr) by 2002:a81:4c90:0:b0:59e:8f97:27ed with SMTP id
 z138-20020a814c90000000b0059e8f9727edmr156885ywa.1.1695623068705; Sun, 24 Sep
 2023 23:24:28 -0700 (PDT)
Date:   Sun, 24 Sep 2023 23:23:23 -0700
Message-Id: <20230925062323.840799-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1] perf pmus: Make PMU alias name loading lazy
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
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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

PMU alias names were computed when the first perf_pmu is created,
scanning all PMUs in event sources for a file called alias that
generally doesn't exist. Switch to trying to load the file when all
PMU related files are loaded in lookup. This would cause a PMU name
lookup of an alias name to fail if no PMUs were loaded, so in that
case all PMUs are loaded and the find repeated. The overhead is
similar but in the (very) general case not all PMUs are scanned for
the alias file.

As the overhead occurs once per invocation it doesn't show in perf
bench internals pmu-scan. On a tigerlake machine, the number of openat
system calls for an event of cpu/cycles/ with perf stat reduces from
94 to 69 (ie 25 fewer openat calls).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/pmu.c | 139 ---------------------------------
 tools/perf/util/pmu.c          |  39 ++++-----
 tools/perf/util/pmu.h          |   2 -
 tools/perf/util/pmus.c         |  10 +++
 4 files changed, 31 insertions(+), 159 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index f428cffb0378..8b53ca468a50 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -17,15 +17,6 @@
 #include "../../../util/pmus.h"
 #include "env.h"
 
-struct pmu_alias {
-	char *name;
-	char *alias;
-	struct list_head list;
-};
-
-static LIST_HEAD(pmu_alias_name_list);
-static bool cached_list;
-
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
@@ -41,136 +32,6 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __mayb
 	return NULL;
 }
 
-static void pmu_alias__delete(struct pmu_alias *pmu_alias)
-{
-	if (!pmu_alias)
-		return;
-
-	zfree(&pmu_alias->name);
-	zfree(&pmu_alias->alias);
-	free(pmu_alias);
-}
-
-static struct pmu_alias *pmu_alias__new(char *name, char *alias)
-{
-	struct pmu_alias *pmu_alias = zalloc(sizeof(*pmu_alias));
-
-	if (pmu_alias) {
-		pmu_alias->name = strdup(name);
-		if (!pmu_alias->name)
-			goto out_delete;
-
-		pmu_alias->alias = strdup(alias);
-		if (!pmu_alias->alias)
-			goto out_delete;
-	}
-	return pmu_alias;
-
-out_delete:
-	pmu_alias__delete(pmu_alias);
-	return NULL;
-}
-
-static int setup_pmu_alias_list(void)
-{
-	int fd, dirfd;
-	DIR *dir;
-	struct dirent *dent;
-	struct pmu_alias *pmu_alias;
-	char buf[MAX_PMU_NAME_LEN];
-	FILE *file;
-	int ret = -ENOMEM;
-
-	dirfd = perf_pmu__event_source_devices_fd();
-	if (dirfd < 0)
-		return -1;
-
-	dir = fdopendir(dirfd);
-	if (!dir)
-		return -errno;
-
-	while ((dent = readdir(dir))) {
-		if (!strcmp(dent->d_name, ".") ||
-		    !strcmp(dent->d_name, ".."))
-			continue;
-
-		fd = perf_pmu__pathname_fd(dirfd, dent->d_name, "alias", O_RDONLY);
-		if (fd < 0)
-			continue;
-
-		file = fdopen(fd, "r");
-		if (!file)
-			continue;
-
-		if (!fgets(buf, sizeof(buf), file)) {
-			fclose(file);
-			continue;
-		}
-
-		fclose(file);
-
-		/* Remove the last '\n' */
-		buf[strlen(buf) - 1] = 0;
-
-		pmu_alias = pmu_alias__new(dent->d_name, buf);
-		if (!pmu_alias)
-			goto close_dir;
-
-		list_add_tail(&pmu_alias->list, &pmu_alias_name_list);
-	}
-
-	ret = 0;
-
-close_dir:
-	closedir(dir);
-	return ret;
-}
-
-static const char *__pmu_find_real_name(const char *name)
-{
-	struct pmu_alias *pmu_alias;
-
-	list_for_each_entry(pmu_alias, &pmu_alias_name_list, list) {
-		if (!strcmp(name, pmu_alias->alias))
-			return pmu_alias->name;
-	}
-
-	return name;
-}
-
-const char *pmu_find_real_name(const char *name)
-{
-	if (cached_list)
-		return __pmu_find_real_name(name);
-
-	setup_pmu_alias_list();
-	cached_list = true;
-
-	return __pmu_find_real_name(name);
-}
-
-static const char *__pmu_find_alias_name(const char *name)
-{
-	struct pmu_alias *pmu_alias;
-
-	list_for_each_entry(pmu_alias, &pmu_alias_name_list, list) {
-		if (!strcmp(name, pmu_alias->name))
-			return pmu_alias->alias;
-	}
-	return NULL;
-}
-
-const char *pmu_find_alias_name(const char *name)
-{
-	if (cached_list)
-		return __pmu_find_alias_name(name);
-
-	setup_pmu_alias_list();
-	cached_list = true;
-
-	return __pmu_find_alias_name(name);
-}
-
 int perf_pmus__num_mem_pmus(void)
 {
 	/* AMD uses IBS OP pmu and not a core PMU for perf mem/c2c */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0d81c059c91c..0f5c6ed257a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -937,16 +937,27 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 	return NULL;
 }
 
-const char * __weak
-pmu_find_real_name(const char *name)
+static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
 {
-	return name;
-}
+	FILE *file = perf_pmu__open_file_at(pmu, dirfd, "alias");
+	char *line = NULL;
+	size_t line_len = 0;
+	ssize_t ret;
 
-const char * __weak
-pmu_find_alias_name(const char *name __maybe_unused)
-{
-	return NULL;
+	if (!file)
+		return NULL;
+
+	ret = getline(&line, &line_len, file);
+	if (ret < 0) {
+		fclose(file);
+		return NULL;
+	}
+	/* Remove trailing newline. */
+	if (ret > 0 && line[ret - 1] == '\n')
+		line[--ret] = '\0';
+
+	fclose(file);
+	return line;
 }
 
 static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
@@ -957,12 +968,10 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 	return max_precise;
 }
 
-struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name)
+struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
 	__u32 type;
-	const char *name = pmu_find_real_name(lookup_name);
-	const char *alias_name;
 
 	pmu = zalloc(sizeof(*pmu));
 	if (!pmu)
@@ -995,18 +1004,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
-	alias_name = pmu_find_alias_name(name);
-	if (alias_name) {
-		pmu->alias_name = strdup(alias_name);
-		if (!pmu->alias_name)
-			goto err;
-	}
-
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
+	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 04b317b17d66..bc807729a7cd 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -251,8 +251,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu);
 
 int perf_pmu__match(const char *pattern, const char *name, const char *tok);
 
-const char *pmu_find_real_name(const char *name);
-const char *pmu_find_alias_name(const char *name);
 double perf_pmu__cpu_slots_per_cycle(void);
 int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
 int perf_pmu__pathname_scnprintf(char *buf, size_t size,
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 64e798e68a2d..ce4931461741 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -37,6 +37,8 @@ static LIST_HEAD(other_pmus);
 static bool read_sysfs_core_pmus;
 static bool read_sysfs_all_pmus;
 
+static void pmu_read_sysfs(bool core_only);
+
 int pmu_name_len_no_suffix(const char *str, unsigned long *num)
 {
 	int orig_len, len;
@@ -124,6 +126,14 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	pmu = perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
 	close(dirfd);
 
+	if (!pmu) {
+		/*
+		 * Looking up an inidividual PMU failed. This may mean name is
+		 * an alias, so read the PMUs from sysfs and try to find again.
+		 */
+		pmu_read_sysfs(core_pmu);
+		pmu = pmu_find(name);
+	}
 	return pmu;
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

