Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFEC801820
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbjLAXvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjLAXvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:51:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9211BC8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:50:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1b2153ba1so45114967b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474659; x=1702079459; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItZCiYTidXZ2+EA8+gqpTy6/95aFzEBMRZh+emcwQeg=;
        b=P4qdRorJ7kZBWcz/ff17x9g9poMG403Rnt2VknHDezs2CVhoAncGgSwKS7GlKH427m
         Uk5+bAdwdihjHyEh3WVAB8RjDBi9Id8FTnurrXqPHXsv1TkKK/NGPoUIga26kEV9I1jG
         XdZv2WOPkWGEAXRbZIDfsk6GMTN75+rbP0Bb2HrV3XwoE5gEyXW3mbNaYJeVHOZ3wHvL
         m2Ic3hkGaYzP9uSHne07O6BpE/VrhtDBehHPSa4wXHxAc7Jz/BDmFyTbDfKHux5ohc8G
         h0XW4K3Im4DEoZLMcKpNHUqlqX9LFbC3XnB5OAnEUVOT9ChYHvGF/hIdtoyKOyhrmAb9
         Nhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474659; x=1702079459;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItZCiYTidXZ2+EA8+gqpTy6/95aFzEBMRZh+emcwQeg=;
        b=r4Pe+0C6yYGo9fqz2GByU2XnRxAxnWEV7jOSGVrdqEBSq0bBRfje6870uq8ksgvPk1
         QQ5I4HKAYETg2dQx4wOVBekGJObti4mHvB+CFhCHsRAQ7aKregJPT00KQvBcNoT8sDhj
         jXxO+D+7SpfMuTsvH4tlcEnquMYSmawVQX3ko7Qtrv1tQbs7vNUWzRKj8VruNpzHYrsW
         ZoMqRBWwfd6Et0yE2mn9BklhdFxMfE641EEZChkcPyVXK+rac7q9lnPxHEeZwHhZ9hlP
         EcoMZhSp1HrpeG+q4TKjhSMijEqmzRxnRAelMAC+4W4m5xPPz4Fof3Uqr/5eu8uUycLO
         Ysjw==
X-Gm-Message-State: AOJu0Yzt65InkyQl/z2upu5Z3QYtVtYztb8fgdQwvyWdjatoiuMVxx0d
        178u90697GpPNtggDQiVW89vVjq2Czou
X-Google-Smtp-Source: AGHT+IGDDs6/HvyGk5Knpyyp8mX2A3qJeTHeuW32pljA5JhyoIcsghnFh68oXiE84dPYErF5lqWHH8RlQ1OC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a05:690c:2d04:b0:5d7:1941:61d3 with SMTP
 id eq4-20020a05690c2d0400b005d7194161d3mr19253ywb.9.1701474659108; Fri, 01
 Dec 2023 15:50:59 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:50:31 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-9-irogers@google.com>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 9/9] perf tests: Add option to run tests in parallel
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

By default tests are forked, add an option (-p or --parallel) so that
the forked tests are all started in parallel and then their output
gathered serially. This is opt-in as running in parallel can cause
test flakes.

Rather than fork within the code, the start_command/finish_command
from libsubcmd are used. This changes how stderr and stdout are
handled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 261 +++++++++++++++++++++-----------
 1 file changed, 169 insertions(+), 92 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54b11c23e863..91c32b477cbb 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -21,6 +21,7 @@
 #include "debug.h"
 #include "color.h"
 #include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
 #include "string2.h"
 #include "symbol.h"
 #include "util/rlimit.h"
@@ -31,7 +32,13 @@
 
 #include "tests-scripts.h"
 
+/*
+ * Command line option to not fork the test running in the same process and
+ * making them easier to debug.
+ */
 static bool dont_fork;
+/* Fork the tests in parallel and then wait for their completion. */
+static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -211,76 +218,36 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
 	return false;
 }
 
-static int run_test(struct test_suite *test, int subtest)
-{
-	int status, err = -1, child = dont_fork ? 0 : fork();
-	char sbuf[STRERR_BUFSIZE];
-
-	if (child < 0) {
-		pr_err("failed to fork test: %s\n",
-			str_error_r(errno, sbuf, sizeof(sbuf)));
-		return -1;
-	}
-
-	if (!child) {
-		if (!dont_fork) {
-			pr_debug("test child forked, pid %d\n", getpid());
-
-			if (verbose <= 0) {
-				int nullfd = open("/dev/null", O_WRONLY);
-
-				if (nullfd >= 0) {
-					close(STDERR_FILENO);
-					close(STDOUT_FILENO);
-
-					dup2(nullfd, STDOUT_FILENO);
-					dup2(STDOUT_FILENO, STDERR_FILENO);
-					close(nullfd);
-				}
-			} else {
-				signal(SIGSEGV, sighandler_dump_stack);
-				signal(SIGFPE, sighandler_dump_stack);
-			}
-		}
-
-		err = test_function(test, subtest)(test, subtest);
-		if (!dont_fork)
-			exit(err);
-	}
-
-	if (!dont_fork) {
-		wait(&status);
+struct child_test {
+	struct child_process process;
+	struct test_suite *test;
+	int test_num;
+	int subtest;
+};
 
-		if (WIFEXITED(status)) {
-			err = (signed char)WEXITSTATUS(status);
-			pr_debug("test child finished with %d\n", err);
-		} else if (WIFSIGNALED(status)) {
-			err = -1;
-			pr_debug("test child interrupted\n");
-		}
-	}
+static int run_test_child(struct child_process *process)
+{
+	struct child_test *child = container_of(process, struct child_test, process);
+	int err;
 
-	return err;
+	pr_debug("--- start ---\n");
+	pr_debug("test child forked, pid %d\n", getpid());
+	err = test_function(child->test, child->subtest)(child->test, child->subtest);
+	pr_debug("---- end(%d) ----\n", err);
+	fflush(NULL);
+	return -err;
 }
 
-#define for_each_test(j, k, t)			\
-	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
-		while ((t = tests[j][k++]) != NULL)
-
-static int test_and_print(struct test_suite *t, int subtest)
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
 {
-	int err;
-
-	pr_debug("\n--- start ---\n");
-	err = run_test(t, subtest);
-	pr_debug("---- end ----\n");
+	if (has_subtests(t)) {
+		int subw = width > 2 ? width - 2 : width;
 
-	if (!has_subtests(t))
-		pr_debug("%s:", t->desc);
-	else
-		pr_debug("%s subtest %d:", t->desc, subtest + 1);
+		pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_description(t, subtest));
+	} else
+		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
-	switch (err) {
+	switch (result) {
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -299,22 +266,135 @@ static int test_and_print(struct test_suite *t, int subtest)
 		break;
 	}
 
-	return err;
+	return 0;
+}
+
+static int finish_test(struct child_test *child_test, int width)
+{
+	struct test_suite *t = child_test->test;
+	int i = child_test->test_num;
+	int subi = child_test->subtest;
+	int out = child_test->process.out;
+	int err = child_test->process.err;
+	int ret;
+
+	if (verbose) {
+		bool out_done = false, err_done = false;
+
+		fcntl(out, F_SETFL, O_NONBLOCK);
+		fcntl(err, F_SETFL, O_NONBLOCK);
+		if (has_subtests(t))
+			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
+		else
+			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+
+		while (!out_done && !err_done) {
+			char buf[512];
+			ssize_t len;
+
+			if (!out_done) {
+				errno = 0;
+				len = read(out, buf, sizeof(buf) - 1);
+
+				if (len <= 0)
+					err_done = errno != EAGAIN;
+				else {
+					buf[len] = '\0';
+					fprintf(stdout, "%s", buf);
+				}
+			}
+			if (!err_done) {
+				errno = 0;
+				len = read(err, buf, sizeof(buf) - 1);
+
+				if (len <= 0)
+					err_done = errno != EAGAIN;
+				else {
+					buf[len] = '\0';
+					fprintf(stderr, "%s", buf);
+				}
+			}
+		}
+	}
+	ret = finish_command(&child_test->process);
+	print_test_result(t, i, subi, ret, width);
+	if (out >= 0)
+		close(out);
+	if (err >= 0)
+		close(err);
+	return 0;
+}
+
+static int start_test(struct test_suite *test, int i, int subi, struct child_test **child,
+		      int width)
+{
+	int err;
+
+	*child = NULL;
+	if (dont_fork) {
+		pr_debug("--- start ---\n");
+		err = test_function(test, subi)(test, subi);
+		pr_debug("---- end ----\n");
+		print_test_result(test, i, subi, err, width);
+		return 0;
+	}
+
+	*child = zalloc(sizeof(**child));
+	if (!*child)
+		return -ENOMEM;
+
+	(*child)->test = test;
+	(*child)->test_num = i;
+	(*child)->subtest = subi;
+	(*child)->process.pid = -1;
+	(*child)->process.no_stdin = 1;
+	if (verbose <= 0) {
+		(*child)->process.no_stdout = 1;
+		(*child)->process.no_stderr = 1;
+	} else {
+		(*child)->process.out = -1;
+		(*child)->process.err = -1;
+	}
+	(*child)->process.no_exec_cmd = run_test_child;
+	err = start_command(&(*child)->process);
+	if (err || parallel)
+		return  err;
+	return finish_test(*child, width);
 }
 
+#define for_each_test(j, k, t)					\
+	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
+		while ((t = tests[j][k++]) != NULL)
+
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
 	unsigned int j, k;
 	int i = 0;
 	int width = 0;
+	size_t num_tests = 0;
+	struct child_test **child_tests;
+	int child_test_num = 0;
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
 
 		if (width < len)
 			width = len;
+
+		if (has_subtests(t)) {
+			for (int l = 0, subn = num_subtests(t); l < subn; l++) {
+				len = strlen(test_description(t, -1));
+				if (width < len)
+					width = len;
+				num_tests++;
+			}
+		} else
+			num_tests++;
 	}
+	child_tests = calloc(num_tests, sizeof(*child_tests));
+	if (!child_tests)
+		return -ENOMEM;
 
 	for_each_test(j, k, t) {
 		int curr = i++;
@@ -336,52 +416,47 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 				continue;
 		}
 
-		pr_info("%3d: %-*s:", i, width, test_description(t, -1));
-
 		if (intlist__find(skiplist, i)) {
+			pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
 			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 			continue;
 		}
 
 		if (!has_subtests(t)) {
-			test_and_print(t, -1);
+			int err = start_test(t, curr, -1, &child_tests[child_test_num++], width);
+
+			if (err) {
+				/* TODO: if parallel waitpid the already forked children. */
+				free(child_tests);
+				return err;
+			}
 		} else {
 			int subn = num_subtests(t);
-			/*
-			 * minus 2 to align with normal testcases.
-			 * For subtest we print additional '.x' in number.
-			 * for example:
-			 *
-			 * 35: Test LLVM searching and compiling                        :
-			 * 35.1: Basic BPF llvm compiling test                          : Ok
-			 */
-			int subw = width > 2 ? width - 2 : width;
-
-			if (subn <= 0) {
-				color_fprintf(stderr, PERF_COLOR_YELLOW,
-					      " Skip (not compiled in)\n");
-				continue;
-			}
-			pr_info("\n");
 
 			for (subi = 0; subi < subn; subi++) {
-				int len = strlen(test_description(t, subi));
-
-				if (subw < len)
-					subw = len;
-			}
+				int err;
 
-			for (subi = 0; subi < subn; subi++) {
 				if (!perf_test__matches(test_description(t, subi),
 							curr, argc, argv))
 					continue;
 
-				pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
-					test_description(t, subi));
-				test_and_print(t, subi);
+				err = start_test(t, curr, subi, &child_tests[child_test_num++],
+						 width);
+				if (err)
+					return err;
 			}
 		}
 	}
+	for (i = 0; i < child_test_num; i++) {
+		if (parallel) {
+			int ret  = finish_test(child_tests[i], width);
+
+			if (ret)
+				return ret;
+		}
+		free(child_tests[i]);
+	}
+	free(child_tests);
 	return 0;
 }
 
@@ -449,6 +524,8 @@ int cmd_test(int argc, const char **argv)
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
+	OPT_BOOLEAN('p', "parallel", &parallel,
+		    "Run the tests altogether in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
-- 
2.43.0.rc2.451.g8631bc7472-goog

