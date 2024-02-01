Return-Path: <linux-kernel+bounces-47422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4A844DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D031C25C55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B326AFA;
	Thu,  1 Feb 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fG+au86v"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E96EACC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746543; cv=none; b=OLAUe7VnJFBRWK/RPha/5au+6JHlX7cPK5ua9bGH/kGjCb4IVoxWqxBDSwWLS2cQUOfSQr0PEwe+RZkP8VkElNwLfKaEcHnhXeSXCfrUBfLY670hoMj8oDsfa7KXGrHVr4UQ3/j+mIycAw6reHhYS4FXgzwOTkf91kVX5A+fc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746543; c=relaxed/simple;
	bh=dp7HB3eRdJHRroBZf1k+WUfjbzVVAvKAZY16vMqI9Y4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oQzdjcgOnHj1ItGRcf52O6JNbs/0gYF7ZYf2G7rXYZMtnke+nd1vOBJ65sYHkVjrOUHIQJIko4BQ9UJqC4EEw73dMjWbNV9Lhf78mm9B5J+29+03/ohdOF6RgoWefvUm/oe1XuMUN2Lx9J/KmUQp9DGn0hcm8f91cHUKKQLPS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fG+au86v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602dae507caso7437297b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746540; x=1707351340; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2A7abhWIJ5fxlhS1+pqWax4u5tjH9fY/bArkcWvzPGc=;
        b=fG+au86vVb+XlsQx8CAdA57Y/v4VzupLL872GDn+WQDrxDzTIWqes4DiavbbLfT5AX
         QQEa+lian8VZjyMh6TWTIFwwfpxrSqHUJH+g6KioI3OFcwPziK2ExdQ+pS2NYWR99ZmG
         NHFCtGb+Y0uG265ngh3SR6rl6GsTGNqlUGiPsnXKAVn43HFAUwZ5at18PDErJgTiZmM1
         yD/ZenmxNRbcQM4ZE3CVIC0kWaQJsDzyE9cSykEACYxE3h6IVJ+1EpTpeaOLe0T6jjpJ
         0WrAW8PmbQao9fNcImyz8wvjUYDufrEjMB0+9CnJ5+JZR2v3iDE6/IP/8aOw9YXfONy2
         h/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746540; x=1707351340;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A7abhWIJ5fxlhS1+pqWax4u5tjH9fY/bArkcWvzPGc=;
        b=n039eJUWGEDas424DY4cUz+gUGF41jczNYGCRuIGD1o8T6Z3ddI1mfrHRALgIDdZuP
         1pA+AWb8V0LDpdH/Zmxt6kmSKnGRnusHJovtrxJJIR+9RIa6z+UqQnbkcq4fS3C5k89z
         rUJcKCwT74GmgMSlc6dVbaxX4VoM25Vyz9R2Irf7dl0yFGEJCXTDZoe3JfONppq9CTf6
         ok/vHBWPx1xYUyByGUm81UvWkEnjtafmLY1YskabopitUmSQ2kn9JU4y6IlQDI6H7L9S
         7EW5j3/zm4CsxM0BM52LSiX79jaUip5SPsFxBepEaq/sOhkPUH6vOE7wv26k/jkcCIuB
         8Qhg==
X-Gm-Message-State: AOJu0Yy2o62qKvLuaufvD7BjBEA/8A7P1onFHUMz6CrIuBT2dbp10YwC
	BQ/WYTLCQeoDp803DKzYdqKx5NfRntV8R6n52gX6SRuo7Ig/m/7SMffofsTAlugsrlmbobAlq3i
	MR9XeKQ==
X-Google-Smtp-Source: AGHT+IH02+GahXeVQLCXPsY2ZKw1hokhnyHY6iOJ0+orjpPXEth0No5p3JU42u2eZNiHvWE7Z3mLdyuMt2/U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a05:690c:39d:b0:604:228:7e with SMTP id
 bh29-20020a05690c039d00b006040228007emr690099ywb.8.1706746539927; Wed, 31 Jan
 2024 16:15:39 -0800 (PST)
Date: Wed, 31 Jan 2024 16:15:03 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 9/9] perf tests: Add option to run tests in parallel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

By default tests are forked, add an option (-p or --parallel) so that
the forked tests are all started in parallel and then their output
gathered serially. This is opt-in as running in parallel can cause
test flakes.

Rather than fork within the code, the start_command/finish_command
from libsubcmd are used. This changes how stderr and stdout are
handled. The child stderr and stdout are always read to avoid the
child blocking. If verbose is 1 (-v) then if the test fails the child
stdout and stderr are displayed. If the verbose is >1 (e.g. -vv) then
the stdout and stderr from the child are immediately displayed.

An unscientific test on my laptop shows the wall clock time for perf
test without parallel being 5 minutes 21 seconds and with parallel
(-p) being 1 minute 50 seconds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v1 of this code had a bug where stdout/stderr weren't read fully. This
and additional issues/improvements are dealt with in v2.
---
 tools/perf/tests/builtin-test.c | 305 ++++++++++++++++++++++----------
 1 file changed, 213 insertions(+), 92 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c42cb40fc242..b815db8ebf79 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -6,6 +6,7 @@
  */
 #include <fcntl.h>
 #include <errno.h>
+#include <poll.h>
 #include <unistd.h>
 #include <string.h>
 #include <stdlib.h>
@@ -21,9 +22,11 @@
 #include "debug.h"
 #include "color.h"
 #include <subcmd/parse-options.h>
+#include <subcmd/run-command.h>
 #include "string2.h"
 #include "symbol.h"
 #include "util/rlimit.h"
+#include "util/strbuf.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <subcmd/exec-cmd.h>
@@ -31,7 +34,13 @@
 
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
 
@@ -209,76 +218,36 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
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
@@ -297,22 +266,177 @@ static int test_and_print(struct test_suite *t, int subtest)
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
+	bool out_done = out <= 0;
+	bool err_done = err <= 0;
+	struct strbuf out_output = STRBUF_INIT;
+	struct strbuf err_output = STRBUF_INIT;
+	int ret;
+
+	/*
+	 * For test suites with subtests, display the suite name ahead of the
+	 * sub test names.
+	 */
+	if (has_subtests(t) && subi == 0)
+		pr_info("%3d: %-*s:\n", i + 1, width, test_description(t, -1));
+
+	/*
+	 * Busy loop reading from the child's stdout and stderr that are set to
+	 * be non-blocking until EOF.
+	 */
+	if (!out_done)
+		fcntl(out, F_SETFL, O_NONBLOCK);
+	if (!err_done)
+		fcntl(err, F_SETFL, O_NONBLOCK);
+	if (verbose > 1) {
+		if (has_subtests(t))
+			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
+		else
+			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+	}
+	while (!out_done || !err_done) {
+		struct pollfd pfds[2] = {
+			{ .fd = out,
+			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
+			},
+			{ .fd = err,
+			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
+			},
+		};
+		char buf[512];
+		ssize_t len;
+
+		/* Poll to avoid excessive spinning, timeout set for 1000ms. */
+		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/1000);
+		if (!out_done && pfds[0].revents) {
+			errno = 0;
+			len = read(out, buf, sizeof(buf) - 1);
+
+			if (len <= 0) {
+				out_done = errno != EAGAIN;
+			} else {
+				buf[len] = '\0';
+				if (verbose > 1)
+					fprintf(stdout, "%s", buf);
+				else
+					strbuf_addstr(&out_output, buf);
+			}
+		}
+		if (!err_done && pfds[1].revents) {
+			errno = 0;
+			len = read(err, buf, sizeof(buf) - 1);
+
+			if (len <= 0) {
+				err_done = errno != EAGAIN;
+			} else {
+				buf[len] = '\0';
+				if (verbose > 1)
+					fprintf(stdout, "%s", buf);
+				else
+					strbuf_addstr(&err_output, buf);
+			}
+		}
+	}
+	/* Clean up child process. */
+	ret = finish_command(&child_test->process);
+	if (verbose == 1 && ret == TEST_FAIL) {
+		/* Add header for test that was skipped above. */
+		if (has_subtests(t))
+			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
+		else
+			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+		fprintf(stdout, "%s", out_output.buf);
+		fprintf(stderr, "%s", err_output.buf);
+	}
+	strbuf_release(&out_output);
+	strbuf_release(&err_output);
+	print_test_result(t, i, subi, ret, width);
+	if (out > 0)
+		close(out);
+	if (err > 0)
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
@@ -334,52 +458,47 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
+				int err;
 
-				if (subw < len)
-					subw = len;
-			}
-
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
 
@@ -447,6 +566,8 @@ int cmd_test(int argc, const char **argv)
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
+	OPT_BOOLEAN('p', "parallel", &parallel,
+		    "Run the tests altogether in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
 	OPT_STRING(0, "objdump", &test_objdump_path, "path",
-- 
2.43.0.429.g432eaa2c6b-goog


