Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E5807FF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjLGFFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjLGFEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:04:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042AD51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:04:58 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d8f69da4c8so3960947b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701925497; x=1702530297; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yddnIh+eN5/+1uKGHF2Xb5nfq0hpynkUoMoJjaaQGg=;
        b=q34xsdtWe+M02IKvzjOSxgMLzNDMir7y4GddACF4uwS1xLYobrcr5JqQlwvTEbOqFb
         Bdbni7PR4oS1Ulkd0+x6lLWMNPPUJwZa36paZYHagqkSxsviR5WamB3dpsjoxF2ApD7P
         A2ue9Dn5U5e2W3RHSm++aMFN3HfhDmg1LpKnfUOj4nOTRmjm533bxa7fXx1yepq0SwGu
         ivEUDJa9+ij9Hbr8cgTMv1nVubCdxgx64i0quslEc8kyX7itmHLUxMm+Vy2tZVKN0wpk
         Vq90xrUt21f6EhxVtptXt+VBeu3IDyYjflmWKnCvNRoeH7608C6ZhgFhYMWaLwqNs2yT
         vjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701925497; x=1702530297;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yddnIh+eN5/+1uKGHF2Xb5nfq0hpynkUoMoJjaaQGg=;
        b=Sd018liynRWb7FJ6Ifxysr1ebJ99HxUW2Uh7BLCqX2UuTj9FLrTgxzLEHv9aq5itiw
         j1cX9h7GyQey41IXU2gdoLVVAc+i1nwPD+o0dLukgJ49YKtFJjUzaS6sgyWkbUcxgfE6
         ypx6EbWRFCY3Gezc8b8R7juf7Tdr2R8y+lZ25SSBGtD4S5UMaMHIIgyTevbSq1Ds9VnE
         rThfd+tRkapTat32TEQqgfviD5JtXcamlSN9U653wYzeTW/XOkfOSsG8u1c4Wo9lvzXo
         wo6HBW69UIHhb5cLyyYRXDn8M071PPCgQBsDNDaYCAtTsX7ovVNY2TGNKtjnbPtv0bQS
         CxWA==
X-Gm-Message-State: AOJu0YwJ5akEETBEnUxLVPMYo8Xoe77mU345dI1p9mErsZezT8e4xrSu
        J9KByF9YwRX45YuIA1fE+VUjtBmc4FrB
X-Google-Smtp-Source: AGHT+IE882a5TV3lzEwPVuhsbdGQD4YkJ4nM2OZr83LhR4in6R8D9tV/naisyo0LtFoYkBhOxvaSkjr1xQ4u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a25:74d1:0:b0:db4:5e66:4a05 with SMTP id
 p200-20020a2574d1000000b00db45e664a05mr30614ybc.2.1701925497312; Wed, 06 Dec
 2023 21:04:57 -0800 (PST)
Date:   Wed,  6 Dec 2023 21:04:31 -0800
In-Reply-To: <20231207050433.1426834-1-irogers@google.com>
Message-Id: <20231207050433.1426834-5-irogers@google.com>
Mime-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 4/6] perf pmu: Switch to io_dir__readdir
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Fangrui Song <maskray@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        James Clark <james.clark@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid DIR allocations when scanning sysfs by using io_dir for the
readdir implementation, that allocates about 1kb on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 48 +++++++++++++++++-------------------------
 tools/perf/util/pmus.c | 30 ++++++++++----------------
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 3c9609944a2f..cddb82123a1e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <dirent.h>
 #include <api/fs/fs.h>
+#include <api/io_dir.h>
 #include <locale.h>
 #include <fnmatch.h>
 #include <math.h>
@@ -184,19 +185,17 @@ static void perf_pmu_format__load(const struct perf_pmu *pmu, struct perf_pmu_fo
  */
 int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
 {
-	struct dirent *evt_ent;
-	DIR *format_dir;
+	struct io_dirent64 *evt_ent;
+	struct io_dir format_dir;
 	int ret = 0;
 
-	format_dir = fdopendir(dirfd);
-	if (!format_dir)
-		return -EINVAL;
+	io_dir__init(&format_dir, dirfd);
 
-	while ((evt_ent = readdir(format_dir)) != NULL) {
+	while ((evt_ent = io_dir__readdir(&format_dir)) != NULL) {
 		struct perf_pmu_format *format;
 		char *name = evt_ent->d_name;
 
-		if (!strcmp(name, ".") || !strcmp(name, ".."))
+		if (io_dir__is_dir(&format_dir, evt_ent))
 			continue;
 
 		format = perf_pmu__new_format(&pmu->format, name);
@@ -223,7 +222,7 @@ int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
 		}
 	}
 
-	closedir(format_dir);
+	close(format_dir.dirfd);
 	return ret;
 }
 
@@ -599,8 +598,8 @@ static inline bool pmu_alias_info_file(const char *name)
 static int pmu_aliases_parse(struct perf_pmu *pmu)
 {
 	char path[PATH_MAX];
-	struct dirent *evt_ent;
-	DIR *event_dir;
+	struct io_dirent64 *evt_ent;
+	struct io_dir event_dir;
 	size_t len;
 	int fd, dir_fd;
 
@@ -615,13 +614,9 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		return 0;
 	}
 
-	event_dir = fdopendir(dir_fd);
-	if (!event_dir){
-		close (dir_fd);
-		return -EINVAL;
-	}
+	io_dir__init(&event_dir, dir_fd);
 
-	while ((evt_ent = readdir(event_dir))) {
+	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		FILE *file;
 
@@ -651,7 +646,6 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		fclose(file);
 	}
 
-	closedir(event_dir);
 	close (dir_fd);
 	pmu->sysfs_aliases_loaded = true;
 	return 0;
@@ -1883,10 +1877,9 @@ static void perf_pmu__del_caps(struct perf_pmu *pmu)
  */
 int perf_pmu__caps_parse(struct perf_pmu *pmu)
 {
-	struct stat st;
 	char caps_path[PATH_MAX];
-	DIR *caps_dir;
-	struct dirent *evt_ent;
+	struct io_dir caps_dir;
+	struct io_dirent64 *evt_ent;
 	int caps_fd;
 
 	if (pmu->caps_initialized)
@@ -1897,24 +1890,21 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	if (!perf_pmu__pathname_scnprintf(caps_path, sizeof(caps_path), pmu->name, "caps"))
 		return -1;
 
-	if (stat(caps_path, &st) < 0) {
+	caps_fd = open(caps_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
+	if (caps_fd == -1) {
 		pmu->caps_initialized = true;
 		return 0;	/* no error if caps does not exist */
 	}
 
-	caps_dir = opendir(caps_path);
-	if (!caps_dir)
-		return -EINVAL;
-
-	caps_fd = dirfd(caps_dir);
+	io_dir__init(&caps_dir, caps_fd);
 
-	while ((evt_ent = readdir(caps_dir)) != NULL) {
+	while ((evt_ent = io_dir__readdir(&caps_dir)) != NULL) {
 		char *name = evt_ent->d_name;
 		char value[128];
 		FILE *file;
 		int fd;
 
-		if (!strcmp(name, ".") || !strcmp(name, ".."))
+		if (io_dir__is_dir(&caps_dir, evt_ent))
 			continue;
 
 		fd = openat(caps_fd, name, O_RDONLY);
@@ -1936,7 +1926,7 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 		fclose(file);
 	}
 
-	closedir(caps_dir);
+	close(caps_fd);
 
 	pmu->caps_initialized = true;
 	return pmu->nr_caps;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index ce4931461741..65b23b98666b 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -3,10 +3,10 @@
 #include <linux/list_sort.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <api/io_dir.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
-#include <dirent.h>
 #include <pthread.h>
 #include <string.h>
 #include <unistd.h>
@@ -184,8 +184,8 @@ static int pmus_cmp(void *priv __maybe_unused,
 static void pmu_read_sysfs(bool core_only)
 {
 	int fd;
-	DIR *dir;
-	struct dirent *dent;
+	struct io_dir dir;
+	struct io_dirent64 *dent;
 
 	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
 		return;
@@ -194,13 +194,9 @@ static void pmu_read_sysfs(bool core_only)
 	if (fd < 0)
 		return;
 
-	dir = fdopendir(fd);
-	if (!dir) {
-		close(fd);
-		return;
-	}
+	io_dir__init(&dir, fd);
 
-	while ((dent = readdir(dir))) {
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
 		if (core_only && !is_pmu_core(dent->d_name))
@@ -209,7 +205,7 @@ static void pmu_read_sysfs(bool core_only)
 		perf_pmu__find2(fd, dent->d_name);
 	}
 
-	closedir(dir);
+	close(fd);
 	if (list_empty(&core_pmus)) {
 		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
 			pr_err("Failure to set up any core PMUs\n");
@@ -563,8 +559,8 @@ bool perf_pmus__supports_extended_type(void)
 char *perf_pmus__default_pmu_name(void)
 {
 	int fd;
-	DIR *dir;
-	struct dirent *dent;
+	struct io_dir dir;
+	struct io_dirent64 *dent;
 	char *result = NULL;
 
 	if (!list_empty(&core_pmus))
@@ -574,13 +570,9 @@ char *perf_pmus__default_pmu_name(void)
 	if (fd < 0)
 		return strdup("cpu");
 
-	dir = fdopendir(fd);
-	if (!dir) {
-		close(fd);
-		return strdup("cpu");
-	}
+	io_dir__init(&dir, fd);
 
-	while ((dent = readdir(dir))) {
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
 		if (is_pmu_core(dent->d_name)) {
@@ -589,7 +581,7 @@ char *perf_pmus__default_pmu_name(void)
 		}
 	}
 
-	closedir(dir);
+	close(fd);
 	return result ?: strdup("cpu");
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

