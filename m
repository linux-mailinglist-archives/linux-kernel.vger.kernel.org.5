Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52885785292
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjHWITe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjHWIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:12:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE6173F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58ee4df08fbso73789267b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778173; x=1693382973;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qaJRxBCyklSMWuPm+izeLXJoqyCIVuwmc1TFOmlkgI=;
        b=HYbuLJFmM89qjJvmBl3tRTcMNf1fLI3hJZEAeKXBIo84IZ5crxB9gYYh99GOFyv1E2
         IExozTzs9hWyqs5K7X6i6Dqj8+JK+abPaMjSnOIlCNU8DFgUq+QUOZSn0Wpc4ulaMUkn
         +lDYufL22mW0iEVm5peGIBsBp3Zt7eIeftICgATUgukRUH1eC42oN4H1P0pbzTbC5XA1
         O7wJttqhKEgm4qGt9mjeX1qjs3/uKiYN8KLqNm7EAvQ+qOqx9J9IcLxhvILqcNYzgaxR
         wroF2Q9peXqhmmUdSgfwi6nvIij1E+qUA5SO3lnrGIP83PTOh1Ggk/wYXAej36fKxVCX
         Yzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778173; x=1693382973;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qaJRxBCyklSMWuPm+izeLXJoqyCIVuwmc1TFOmlkgI=;
        b=aCb/ZmwGjpuzrxG8AcKRW26pkNHrSp7EJaY5AUNbpVcqsE8jbzMCXfeaz05UJMwg7E
         Fth8n79X1OUqE1jOpgyA3KBru6l8gKZ+Ig2ZdQQ83bBjByRFa+SUbCQLp3V9uLCczYJ6
         CuheBRsaf6exaNAA+zqW8vOYWZxIxfHZhLfJMtmcox29SA7TWf3Epo+p3ajYdpLhW+Ny
         5KMskrIHsgycpZ28x2PFhePUC2XSaKhfijtpTJJECeY3xyhNunB42hE1za4FX397KLHr
         VsextRU4F5mh8TjhDQL2iTJPyPrH0lJjjjvU+Ln/OcwKIB9YzwIdClV9zvPcO9iqYLdD
         xa7A==
X-Gm-Message-State: AOJu0YwXuL/uoIHklSwtBCR5GGk9SJUP9rVoXr9j2VFO5XO0yUwvJHgH
        puQvDCiv8fNfx8FJ6IfHNWfJ6FhaWEHQ
X-Google-Smtp-Source: AGHT+IFEwGkpQOFrN5AJCbgmqj0oTABtx0SRmjN2OR1zrYEY5KKUgeFpToIA4RVOwawMiSdD1KbEnU9gqbtJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:b724:0:b0:583:a3c1:6b5a with SMTP id
 v36-20020a81b724000000b00583a3c16b5amr140584ywh.4.1692778172847; Wed, 23 Aug
 2023 01:09:32 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:27 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-25-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 24/25] perf pmu: Lazily load sysfs aliases
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

Don't load sysfs aliases for a PMU when the PMU is first created,
defer until an alias needs to be found. For the pmu-scan benchmark,
average core PMU scanning is reduced by 30.8%, and average PMU
scanning by 12.6%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c |  2 +
 tools/perf/util/pmu.c         | 81 ++++++++++++++++++-----------------
 tools/perf/util/pmu.h         |  2 +
 3 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 9ac893ae5f0d..3dc1ebee4d9f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -547,6 +547,7 @@ static int __test_core_pmu_event_aliases(char *pmu_name, int *count)
 	pmu->events_table = table;
 	pmu_add_cpu_aliases_table(pmu, table);
 	pmu->cpu_aliases_added = true;
+	pmu->sysfs_aliases_loaded = true;
 
 	res = pmu_events_table__find_event(table, pmu, "bp_l1_btb_correct", NULL, NULL);
 	if (res != 0) {
@@ -588,6 +589,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	pmu->events_table = events_table;
 	pmu_add_cpu_aliases_table(pmu, events_table);
 	pmu->cpu_aliases_added = true;
+	pmu->sysfs_aliases_loaded = true;
 	pmu_add_sys_aliases(pmu);
 
 	/* Count how many aliases we generated */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c547fe607f9f..fb437b50443f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -115,6 +115,8 @@ struct perf_pmu_format {
 	bool loaded;
 };
 
+static int pmu_aliases_parse(struct perf_pmu *pmu);
+
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
 {
 	struct perf_pmu_format *format;
@@ -416,10 +418,15 @@ static void perf_pmu__del_aliases(struct perf_pmu *pmu)
 	}
 }
 
-static struct perf_pmu_alias *perf_pmu__find_alias(const struct perf_pmu *pmu, const char *name)
+static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
+						   const char *name,
+						   bool load)
 {
 	struct perf_pmu_alias *alias;
 
+	if (load && !pmu->sysfs_aliases_loaded)
+		pmu_aliases_parse(pmu);
+
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -501,7 +508,7 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
 	bool deprecated = false, perpkg = false;
 
-	if (perf_pmu__find_alias(pmu, name)) {
+	if (perf_pmu__find_alias(pmu, name, /*load=*/ false)) {
 		/* Alias was already created/loaded. */
 		return 0;
 	}
@@ -607,18 +614,33 @@ static inline bool pmu_alias_info_file(char *name)
 }
 
 /*
- * Process all the sysfs attributes located under the directory
- * specified in 'dir' parameter.
+ * Reading the pmu event aliases definition, which should be located at:
+ * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
  */
-static int pmu_aliases_parse(struct perf_pmu *pmu, int dirfd)
+static int pmu_aliases_parse(struct perf_pmu *pmu)
 {
+	char path[PATH_MAX];
 	struct dirent *evt_ent;
 	DIR *event_dir;
-	int fd;
+	size_t len;
+	int fd, dir_fd;
 
-	event_dir = fdopendir(dirfd);
-	if (!event_dir)
+	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
+	if (!len)
+		return 0;
+	scnprintf(path + len, sizeof(path) - len, "%s/events", pmu->name);
+
+	dir_fd = open(path, O_DIRECTORY);
+	if (dir_fd == -1) {
+		pmu->sysfs_aliases_loaded = true;
+		return 0;
+	}
+
+	event_dir = fdopendir(dir_fd);
+	if (!event_dir){
+		close (dir_fd);
 		return -EINVAL;
+	}
 
 	while ((evt_ent = readdir(event_dir))) {
 		char *name = evt_ent->d_name;
@@ -633,7 +655,7 @@ static int pmu_aliases_parse(struct perf_pmu *pmu, int dirfd)
 		if (pmu_alias_info_file(name))
 			continue;
 
-		fd = openat(dirfd, name, O_RDONLY);
+		fd = openat(dir_fd, name, O_RDONLY);
 		if (fd == -1) {
 			pr_debug("Cannot open %s\n", name);
 			continue;
@@ -651,25 +673,8 @@ static int pmu_aliases_parse(struct perf_pmu *pmu, int dirfd)
 	}
 
 	closedir(event_dir);
-	return 0;
-}
-
-/*
- * Reading the pmu event aliases definition, which should be located at:
- * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
- */
-static int pmu_aliases(struct perf_pmu *pmu, int dirfd, const char *name)
-{
-	int fd;
-
-	fd = perf_pmu__pathname_fd(dirfd, name, "events", O_DIRECTORY);
-	if (fd < 0)
-		return 0;
-
-	/* it'll close the fd */
-	if (pmu_aliases_parse(pmu, fd))
-		return -1;
-
+	close (dir_fd);
+	pmu->sysfs_aliases_loaded = true;
 	return 0;
 }
 
@@ -1013,13 +1018,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 		free(pmu);
 		return NULL;
 	}
-	/*
-	 * Check the aliases first to avoid unnecessary work.
-	 */
-	if (pmu_aliases(pmu, dirfd, name)) {
-		free(pmu);
-		return NULL;
-	}
 	pmu->is_core = is_pmu_core(name);
 	pmu->cpus = pmu_cpumask(dirfd, name, pmu->is_core);
 
@@ -1434,7 +1432,7 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 		return NULL;
 	}
 
-	alias = perf_pmu__find_alias(pmu, name);
+	alias = perf_pmu__find_alias(pmu, name, /*load=*/ true);
 	if (alias || pmu->cpu_aliases_added)
 		return alias;
 
@@ -1443,7 +1441,7 @@ static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
 	    pmu_events_table__find_event(pmu->events_table, pmu, name,
 				         pmu_add_cpu_aliases_map_callback,
 				         pmu) == 0) {
-		alias = perf_pmu__find_alias(pmu, name);
+		alias = perf_pmu__find_alias(pmu, name, /*load=*/ false);
 	}
 	return alias;
 }
@@ -1616,7 +1614,7 @@ bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 
 bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 {
-	if (perf_pmu__find_alias(pmu, name) != NULL)
+	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
 		return false;
@@ -1625,7 +1623,12 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 
 size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
-	size_t nr = pmu->sysfs_aliases;
+	size_t nr;
+
+	if (!pmu->sysfs_aliases_loaded)
+		pmu_aliases_parse(pmu);
+
+	nr = pmu->sysfs_aliases;
 
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->loaded_json_aliases;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 288d2908382a..bae0de3ed7a5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -122,6 +122,8 @@ struct perf_pmu {
 	uint32_t sysfs_aliases;
 	/** @sysfs_aliases: Number of json event aliases loaded. */
 	uint32_t loaded_json_aliases;
+	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
+	bool sysfs_aliases_loaded;
 	/**
 	 * @cpu_aliases_added: Have all json events table entries for the PMU
 	 * been added?
-- 
2.42.0.rc1.204.g551eb34607-goog

