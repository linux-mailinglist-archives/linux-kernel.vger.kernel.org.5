Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14180181E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441928AbjLAXvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjLAXu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:50:56 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95881728
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:50:52 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb6271b225so44475217b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474651; x=1702079451; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5IiqyDqLNulHTFOWCxBUv16hjnCat1rWXnO7upHaLs=;
        b=pXosDT1GtFf5okH9SWD0Cxh2DdAGdatouSE0S96C21umGgqUY4Z+Rk1CnnRWHb6nsY
         KfLVwGdUNbcn1OwpzBXOOXurVMruwgB1PReey0PeyX0frKmpM0oXH6StX89jdwalCnyu
         ZoBbWq9CbLoF8I0YBvNG8NpNAU0mn/ktfw3J6WgfHL4U0J1ZgsAthc2hkrd2BYeqX/3t
         b6bRIVULCkxEYAmgl9nqWAX1JnKFWwsWzfTsFJe07PwHcL1T0iHDhPBLBymByzt9mLY2
         oDwkLBxqmwwvI8zh55k/8nTZSVhaBDtrgb4oMNdovO/jkIdB5q6uRFp5PetHrooDdQb1
         OrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474651; x=1702079451;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5IiqyDqLNulHTFOWCxBUv16hjnCat1rWXnO7upHaLs=;
        b=g6DTV2NrqTtx0T5xqgkICnBzXMT0lFDZLTkLD4EVQ2enMBkcRWJ4dyihtFJUpSU94K
         uCiqwwyzlEPP5m89KKsnWbiw3vi9Fx5VYA8PqSc2kwprP6uD3p6fUhR9TqH0a8WnXfSA
         6tQi2H6X9Z0Y6F8V5Ruc8xL/VTajreoHE+IlKtyl4SnYBNSEMaIeAQX1nDz10ZNSjcSK
         NqerIcIrmlMDmtiNISMggqkuQyU0kk0C2Z3z/VMhP8vN+fj8j5kOtLMhs1MC5cj+wts3
         G6TILG4p5iSYvY/Amro1iPaYr/TCnsLx/qahXC72Hkai7+4M3woYNXvi96yCi5tiC6pO
         xffg==
X-Gm-Message-State: AOJu0Yw/6SZgPWGH1zKPRDSmXIa6I9zgCfmyW1PobZFVpB9FpRcmRIXp
        2uuCBvF+ue1BGRxz0dS8tzldDMJnJ/e0
X-Google-Smtp-Source: AGHT+IGldQPGAdByJf0EoaNKhxl7xNpy0PJW+qAX4PYgR/nYcpS0sG1oPxQuS17aQbs8HlZoaTdqLi+uS0Vr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a81:ae21:0:b0:5d4:ce2:e90b with SMTP id
 m33-20020a81ae21000000b005d40ce2e90bmr124625ywh.7.1701474651724; Fri, 01 Dec
 2023 15:50:51 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:50:28 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-6-irogers@google.com>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 6/9] perf tests: Use scandirat for shell script finding
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid filename appending buffers by using openat, faccessat and
scandirat more widely. Turn the script's path back to a file name
using readlink from /proc/<pid>/fd/<fd>.

Read the script's description using api/io.h to avoid fdopen
conversions. Whilst reading perform additional sanity checks on the
script's contents.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  |  21 ++---
 tools/perf/tests/tests-scripts.c | 144 ++++++++++++++++++-------------
 tools/perf/tests/tests-scripts.h |   1 -
 3 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fab49a60d508..2669d1d66ed8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -302,22 +302,20 @@ static int test_and_print(struct test_suite *t, int subtest)
 }
 
 struct shell_test {
-	const char *dir;
 	const char *file;
 };
 
 static int shell_test__run(struct test_suite *test, int subdir __maybe_unused)
 {
 	int err;
-	char script[PATH_MAX];
 	struct shell_test *st = test->priv;
+	char *cmd;
 
-	path__join(script, sizeof(script) - 3, st->dir, st->file);
-
-	if (verbose > 0)
-		strncat(script, " -v", sizeof(script) - strlen(script) - 1);
-
-	err = system(script);
+	asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
+	if (!cmd)
+		return TEST_FAIL;
+	err = system(cmd);
+	free(cmd);
 	if (!err)
 		return TEST_OK;
 
@@ -333,7 +331,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 	files = list_script_files();
 	if (!files)
 		return 0;
-	for (file = files; file->dir; file++) {
+	for (file = files; file->file; file++) {
 		int curr = i++;
 		struct test_case test_cases[] = {
 			{
@@ -347,13 +345,12 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 			.test_cases = test_cases,
 			.priv = &st,
 		};
-		st.dir = file->dir;
+		st.file = file->file;
 
 		if (test_suite.desc == NULL ||
 		    !perf_test__matches(test_suite.desc, curr, argc, argv))
 			continue;
 
-		st.file = file->file;
 		pr_info("%3d: %-*s:", i, width, test_suite.desc);
 
 		if (intlist__find(skiplist, i)) {
@@ -457,7 +454,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 	files = list_script_files();
 	if (!files)
 		return 0;
-	for (file = files; file->dir; file++) {
+	for (file = files; file->file; file++) {
 		int curr = i++;
 		struct test_suite t = {
 			.desc = file->desc
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index 4ebd841da05b..9b3b66dd5508 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -14,6 +14,7 @@
 #include <subcmd/parse-options.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
+#include <api/io.h>
 #include "builtin.h"
 #include "tests-scripts.h"
 #include "color.h"
@@ -35,55 +36,69 @@ static size_t files_num = 0;
 static struct script_file *files = NULL;
 static int files_max_width = 0;
 
-static const char *shell_tests__dir(char *path, size_t size)
+static int shell_tests__dir_fd(void)
 {
-	const char *devel_dirs[] = { "./tools/perf/tests", "./tests", };
-	char *exec_path;
-	unsigned int i;
+	char path[PATH_MAX], *exec_path;
+	static const char * const devel_dirs[] = { "./tools/perf/tests/shell", "./tests/shell", };
 
-	for (i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
-		struct stat st;
+	for (size_t i = 0; i < ARRAY_SIZE(devel_dirs); ++i) {
+		int fd = open(devel_dirs[i], O_PATH);
 
-		if (!lstat(devel_dirs[i], &st)) {
-			scnprintf(path, size, "%s/shell", devel_dirs[i]);
-			if (!lstat(devel_dirs[i], &st))
-				return path;
-		}
+		if (fd >= 0)
+			return fd;
 	}
 
 	/* Then installed path. */
 	exec_path = get_argv_exec_path();
-	scnprintf(path, size, "%s/tests/shell", exec_path);
+	scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
 	free(exec_path);
-	return path;
+	return open(path, O_PATH);
 }
 
-static const char *shell_test__description(char *description, size_t size,
-                                           const char *path, const char *name)
+static char *shell_test__description(int dir_fd, const char *name)
 {
-	FILE *fp;
-	char filename[PATH_MAX];
-	int ch;
+	struct io io;
+	char buf[128], desc[256];
+	int ch, pos = 0;
 
-	path__join(filename, sizeof(filename), path, name);
-	fp = fopen(filename, "r");
-	if (!fp)
+	io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf));
+	if (io.fd < 0)
 		return NULL;
 
 	/* Skip first line - should be #!/bin/sh Shebang */
+	if (io__get_char(&io) != '#')
+		goto err_out;
+	if (io__get_char(&io) != '!')
+		goto err_out;
 	do {
-		ch = fgetc(fp);
-	} while (ch != EOF && ch != '\n');
-
-	description = fgets(description, size, fp);
-	fclose(fp);
+		ch = io__get_char(&io);
+		if (ch < 0)
+			goto err_out;
+	} while (ch != '\n');
 
-	/* Assume first char on line is omment everything after that desc */
-	return description ? strim(description + 1) : NULL;
+	do {
+		ch = io__get_char(&io);
+		if (ch < 0)
+			goto err_out;
+	} while (ch == '#' || isspace(ch));
+	while (ch > 0 && ch != '\n') {
+		desc[pos++] = ch;
+		if (pos >= (int)sizeof(desc) - 1)
+			break;
+		ch = io__get_char(&io);
+	}
+	while (pos > 0 && isspace(desc[--pos]))
+		;
+	desc[++pos] = '\0';
+	close(io.fd);
+	return strdup(desc);
+err_out:
+	close(io.fd);
+	return NULL;
 }
 
 /* Is this full file path a shell script */
-static bool is_shell_script(const char *path)
+static bool is_shell_script(int dir_fd, const char *path)
 {
 	const char *ext;
 
@@ -91,20 +106,16 @@ static bool is_shell_script(const char *path)
 	if (!ext)
 		return false;
 	if (!strcmp(ext, ".sh")) { /* Has .sh extension */
-		if (access(path, R_OK | X_OK) == 0) /* Is executable */
+		if (faccessat(dir_fd, path, R_OK | X_OK, 0) == 0) /* Is executable */
 			return true;
 	}
 	return false;
 }
 
 /* Is this file in this dir a shell script (for test purposes) */
-static bool is_test_script(const char *path, const char *name)
+static bool is_test_script(int dir_fd, const char *name)
 {
-	char filename[PATH_MAX];
-
-	path__join(filename, sizeof(filename), path, name);
-	if (!is_shell_script(filename)) return false;
-	return true;
+	return is_shell_script(dir_fd, name);
 }
 
 /* Duplicate a string and fall over and die if we run out of memory */
@@ -120,12 +131,21 @@ static char *strdup_check(const char *str)
 	return newstr;
 }
 
-static void append_script(const char *dir, const char *file, const char *desc)
+static void append_script(int dir_fd, const char *name, char *desc)
 {
+	char filename[PATH_MAX], link[128];
 	struct script_file *files_tmp;
-	size_t files_num_tmp;
+	size_t files_num_tmp, len;
 	int width;
 
+	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
+	len = readlink(link, filename, sizeof(filename));
+	if (len < 0) {
+		pr_err("Failed to readlink %s", link);
+		return;
+	}
+	filename[len++] = '/';
+	strcpy(&filename[len], name);
 	files_num_tmp = files_num + 1;
 	if (files_num_tmp >= SIZE_MAX) {
 		pr_err("Too many script files\n");
@@ -142,10 +162,8 @@ static void append_script(const char *dir, const char *file, const char *desc)
 	/* Add file to end and NULL terminate the struct array */
 	files = files_tmp;
 	files_num = files_num_tmp;
-	files[files_num - 1].dir = strdup_check(dir);
-	files[files_num - 1].file = strdup_check(file);
-	files[files_num - 1].desc = strdup_check(desc);
-	files[files_num].dir = NULL;
+	files[files_num - 1].file = strdup_check(filename);
+	files[files_num - 1].desc = desc;
 	files[files_num].file = NULL;
 	files[files_num].desc = NULL;
 
@@ -154,32 +172,39 @@ static void append_script(const char *dir, const char *file, const char *desc)
 		files_max_width = width;
 }
 
-static void append_scripts_in_dir(const char *path)
+static void append_scripts_in_dir(int dir_fd)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
 	int n_dirs, i;
-	char filename[PATH_MAX];
 
 	/* List files, sorted by alpha */
-	n_dirs = scandir(path, &entlist, NULL, alphasort);
+	n_dirs = scandirat(dir_fd, ".", &entlist, NULL, alphasort);
 	if (n_dirs == -1)
 		return;
 	for (i = 0; i < n_dirs && (ent = entlist[i]); i++) {
+		int fd;
+
 		if (ent->d_name[0] == '.')
 			continue; /* Skip hidden files */
-		if (is_test_script(path, ent->d_name)) { /* It's a test */
-			char bf[256];
-			const char *desc = shell_test__description
-				(bf, sizeof(bf), path, ent->d_name);
+		if (is_test_script(dir_fd, ent->d_name)) { /* It's a test */
+			char *desc = shell_test__description(dir_fd, ent->d_name);
 
 			if (desc) /* It has a desc line - valid script */
-				append_script(path, ent->d_name, desc);
-		} else if (is_directory(path, ent)) { /* Scan the subdir */
-			path__join(filename, sizeof(filename),
-				   path, ent->d_name);
-			append_scripts_in_dir(filename);
+				append_script(dir_fd, ent->d_name, desc);
+			continue;
+		}
+		if (ent->d_type != DT_DIR) {
+			struct stat st;
+
+			if (ent->d_type != DT_UNKNOWN)
+				continue;
+			fstatat(dir_fd, ent->d_name, &st, 0);
+			if (!S_ISDIR(st.st_mode))
+				continue;
 		}
+		fd = openat(dir_fd, ent->d_name, O_PATH);
+		append_scripts_in_dir(fd);
 	}
 	for (i = 0; i < n_dirs; i++) /* Clean up */
 		zfree(&entlist[i]);
@@ -188,14 +213,17 @@ static void append_scripts_in_dir(const char *path)
 
 const struct script_file *list_script_files(void)
 {
-	char path_dir[PATH_MAX];
-	const char *path;
+	int dir_fd;
 
 	if (files)
 		return files; /* Singleton - we already know our list */
 
-	path = shell_tests__dir(path_dir, sizeof(path_dir)); /* Walk  dir */
-	append_scripts_in_dir(path);
+	dir_fd = shell_tests__dir_fd(); /* Walk  dir */
+	if (dir_fd < 0)
+		return NULL;
+
+	append_scripts_in_dir(dir_fd);
+	close(dir_fd);
 
 	return files;
 }
diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-scripts.h
index 3a3ec6191848..3508a293aaf9 100644
--- a/tools/perf/tests/tests-scripts.h
+++ b/tools/perf/tests/tests-scripts.h
@@ -3,7 +3,6 @@
 #define TESTS_SCRIPTS_H
 
 struct script_file {
-	char *dir;
 	char *file;
 	char *desc;
 };
-- 
2.43.0.rc2.451.g8631bc7472-goog

