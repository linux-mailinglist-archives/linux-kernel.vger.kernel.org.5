Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0C803F4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjLDUaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDUaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:30:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A0B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:30:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221A8C433C7;
        Mon,  4 Dec 2023 20:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701721812;
        bh=FQnnXIcrmsJS0CQ/ECI8/TSOUdlLjKhnOuMqg9sGnJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRAK3Tz33QVfZJMFSoNYCSqOP5RcGx8ztV1YRZ3c9aT3o5hsNrKVEWAD1h3JOO/JJ
         0/s3eSe37+9ryWpU5t0Ky7xUm/ERiPfwth637djONo7tf8U42D732J+PEpq67XuCkr
         LU/lFAYFv0edTFWXMwNjdkZHXYlSujAOYrl3PeJ3eDP28jRiNgJmyxvnNO1f7ke4R+
         jc7iR+bq2qpm/RsRgU8QsEmM27ZvDqyQrGBuuPu3i0QcbQzcPMEnq8thhKvuDEPJNg
         K6RiUi0j+Dz7pUpqEZAh3nfjlIhnvMDgwfbRIOASc0y6sZJgHArSh9l/r800y7P23Y
         DRZb8X30CkBWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62D7440094; Mon,  4 Dec 2023 17:30:09 -0300 (-03)
Date:   Mon, 4 Dec 2023 17:30:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v1 9/9] perf tests: Add option to run tests in parallel
Message-ID: <ZW420ecpaSjwykny@kernel.org>
References: <20231201235031.475293-1-irogers@google.com>
 <20231201235031.475293-9-irogers@google.com>
 <CAP-5=fUtoi7ynQ-x_7rrv_vYoTZfS_14COA1MskOFVXJ_jCDew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUtoi7ynQ-x_7rrv_vYoTZfS_14COA1MskOFVXJ_jCDew@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 01, 2023 at 06:06:12PM -0800, Ian Rogers escreveu:
> On Fri, Dec 1, 2023 at 3:50 PM Ian Rogers <irogers@google.com> wrote:
> >
> > By default tests are forked, add an option (-p or --parallel) so that
> > the forked tests are all started in parallel and then their output
> > gathered serially. This is opt-in as running in parallel can cause
> > test flakes.
> >
> > Rather than fork within the code, the start_command/finish_command
> > from libsubcmd are used. This changes how stderr and stdout are
> > handled.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Actually, I think this patch needs more work. The verbose output is
> degraded and missing in some cases. Suggestions on how to fix welcome.

I'll think about, but to make progress I think the first 8 patches in
this series can be considered now?

- Arnaldo

> It'd be nice to fix up the tests and allow parallel to be the default.
> The first patch in this series is 1 such fix. Another is needed to
> make "Couldn't resolve comm name for pid" silent in the cases where it
> is racy. I was also noticing hangs on things like the lock contention
> test. The good news is the tests are doing their job of finding bugs.
> 
> Thanks,
> Ian
> 
> 
> > ---
> >  tools/perf/tests/builtin-test.c | 261 +++++++++++++++++++++-----------
> >  1 file changed, 169 insertions(+), 92 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 54b11c23e863..91c32b477cbb 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -21,6 +21,7 @@
> >  #include "debug.h"
> >  #include "color.h"
> >  #include <subcmd/parse-options.h>
> > +#include <subcmd/run-command.h>
> >  #include "string2.h"
> >  #include "symbol.h"
> >  #include "util/rlimit.h"
> > @@ -31,7 +32,13 @@
> >
> >  #include "tests-scripts.h"
> >
> > +/*
> > + * Command line option to not fork the test running in the same process and
> > + * making them easier to debug.
> > + */
> >  static bool dont_fork;
> > +/* Fork the tests in parallel and then wait for their completion. */
> > +static bool parallel;
> >  const char *dso_to_test;
> >  const char *test_objdump_path = "objdump";
> >
> > @@ -211,76 +218,36 @@ static bool perf_test__matches(const char *desc, int curr, int argc, const char
> >         return false;
> >  }
> >
> > -static int run_test(struct test_suite *test, int subtest)
> > -{
> > -       int status, err = -1, child = dont_fork ? 0 : fork();
> > -       char sbuf[STRERR_BUFSIZE];
> > -
> > -       if (child < 0) {
> > -               pr_err("failed to fork test: %s\n",
> > -                       str_error_r(errno, sbuf, sizeof(sbuf)));
> > -               return -1;
> > -       }
> > -
> > -       if (!child) {
> > -               if (!dont_fork) {
> > -                       pr_debug("test child forked, pid %d\n", getpid());
> > -
> > -                       if (verbose <= 0) {
> > -                               int nullfd = open("/dev/null", O_WRONLY);
> > -
> > -                               if (nullfd >= 0) {
> > -                                       close(STDERR_FILENO);
> > -                                       close(STDOUT_FILENO);
> > -
> > -                                       dup2(nullfd, STDOUT_FILENO);
> > -                                       dup2(STDOUT_FILENO, STDERR_FILENO);
> > -                                       close(nullfd);
> > -                               }
> > -                       } else {
> > -                               signal(SIGSEGV, sighandler_dump_stack);
> > -                               signal(SIGFPE, sighandler_dump_stack);
> > -                       }
> > -               }
> > -
> > -               err = test_function(test, subtest)(test, subtest);
> > -               if (!dont_fork)
> > -                       exit(err);
> > -       }
> > -
> > -       if (!dont_fork) {
> > -               wait(&status);
> > +struct child_test {
> > +       struct child_process process;
> > +       struct test_suite *test;
> > +       int test_num;
> > +       int subtest;
> > +};
> >
> > -               if (WIFEXITED(status)) {
> > -                       err = (signed char)WEXITSTATUS(status);
> > -                       pr_debug("test child finished with %d\n", err);
> > -               } else if (WIFSIGNALED(status)) {
> > -                       err = -1;
> > -                       pr_debug("test child interrupted\n");
> > -               }
> > -       }
> > +static int run_test_child(struct child_process *process)
> > +{
> > +       struct child_test *child = container_of(process, struct child_test, process);
> > +       int err;
> >
> > -       return err;
> > +       pr_debug("--- start ---\n");
> > +       pr_debug("test child forked, pid %d\n", getpid());
> > +       err = test_function(child->test, child->subtest)(child->test, child->subtest);
> > +       pr_debug("---- end(%d) ----\n", err);
> > +       fflush(NULL);
> > +       return -err;
> >  }
> >
> > -#define for_each_test(j, k, t)                 \
> > -       for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)   \
> > -               while ((t = tests[j][k++]) != NULL)
> > -
> > -static int test_and_print(struct test_suite *t, int subtest)
> > +static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
> >  {
> > -       int err;
> > -
> > -       pr_debug("\n--- start ---\n");
> > -       err = run_test(t, subtest);
> > -       pr_debug("---- end ----\n");
> > +       if (has_subtests(t)) {
> > +               int subw = width > 2 ? width - 2 : width;
> >
> > -       if (!has_subtests(t))
> > -               pr_debug("%s:", t->desc);
> > -       else
> > -               pr_debug("%s subtest %d:", t->desc, subtest + 1);
> > +               pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_description(t, subtest));
> > +       } else
> > +               pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
> >
> > -       switch (err) {
> > +       switch (result) {
> >         case TEST_OK:
> >                 pr_info(" Ok\n");
> >                 break;
> > @@ -299,22 +266,135 @@ static int test_and_print(struct test_suite *t, int subtest)
> >                 break;
> >         }
> >
> > -       return err;
> > +       return 0;
> > +}
> > +
> > +static int finish_test(struct child_test *child_test, int width)
> > +{
> > +       struct test_suite *t = child_test->test;
> > +       int i = child_test->test_num;
> > +       int subi = child_test->subtest;
> > +       int out = child_test->process.out;
> > +       int err = child_test->process.err;
> > +       int ret;
> > +
> > +       if (verbose) {
> > +               bool out_done = false, err_done = false;
> > +
> > +               fcntl(out, F_SETFL, O_NONBLOCK);
> > +               fcntl(err, F_SETFL, O_NONBLOCK);
> > +               if (has_subtests(t))
> > +                       pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
> > +               else
> > +                       pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
> > +
> > +               while (!out_done && !err_done) {
> > +                       char buf[512];
> > +                       ssize_t len;
> > +
> > +                       if (!out_done) {
> > +                               errno = 0;
> > +                               len = read(out, buf, sizeof(buf) - 1);
> > +
> > +                               if (len <= 0)
> > +                                       err_done = errno != EAGAIN;
> > +                               else {
> > +                                       buf[len] = '\0';
> > +                                       fprintf(stdout, "%s", buf);
> > +                               }
> > +                       }
> > +                       if (!err_done) {
> > +                               errno = 0;
> > +                               len = read(err, buf, sizeof(buf) - 1);
> > +
> > +                               if (len <= 0)
> > +                                       err_done = errno != EAGAIN;
> > +                               else {
> > +                                       buf[len] = '\0';
> > +                                       fprintf(stderr, "%s", buf);
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +       ret = finish_command(&child_test->process);
> > +       print_test_result(t, i, subi, ret, width);
> > +       if (out >= 0)
> > +               close(out);
> > +       if (err >= 0)
> > +               close(err);
> > +       return 0;
> > +}
> > +
> > +static int start_test(struct test_suite *test, int i, int subi, struct child_test **child,
> > +                     int width)
> > +{
> > +       int err;
> > +
> > +       *child = NULL;
> > +       if (dont_fork) {
> > +               pr_debug("--- start ---\n");
> > +               err = test_function(test, subi)(test, subi);
> > +               pr_debug("---- end ----\n");
> > +               print_test_result(test, i, subi, err, width);
> > +               return 0;
> > +       }
> > +
> > +       *child = zalloc(sizeof(**child));
> > +       if (!*child)
> > +               return -ENOMEM;
> > +
> > +       (*child)->test = test;
> > +       (*child)->test_num = i;
> > +       (*child)->subtest = subi;
> > +       (*child)->process.pid = -1;
> > +       (*child)->process.no_stdin = 1;
> > +       if (verbose <= 0) {
> > +               (*child)->process.no_stdout = 1;
> > +               (*child)->process.no_stderr = 1;
> > +       } else {
> > +               (*child)->process.out = -1;
> > +               (*child)->process.err = -1;
> > +       }
> > +       (*child)->process.no_exec_cmd = run_test_child;
> > +       err = start_command(&(*child)->process);
> > +       if (err || parallel)
> > +               return  err;
> > +       return finish_test(*child, width);
> >  }
> >
> > +#define for_each_test(j, k, t)                                 \
> > +       for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)   \
> > +               while ((t = tests[j][k++]) != NULL)
> > +
> >  static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >  {
> >         struct test_suite *t;
> >         unsigned int j, k;
> >         int i = 0;
> >         int width = 0;
> > +       size_t num_tests = 0;
> > +       struct child_test **child_tests;
> > +       int child_test_num = 0;
> >
> >         for_each_test(j, k, t) {
> >                 int len = strlen(test_description(t, -1));
> >
> >                 if (width < len)
> >                         width = len;
> > +
> > +               if (has_subtests(t)) {
> > +                       for (int l = 0, subn = num_subtests(t); l < subn; l++) {
> > +                               len = strlen(test_description(t, -1));
> > +                               if (width < len)
> > +                                       width = len;
> > +                               num_tests++;
> > +                       }
> > +               } else
> > +                       num_tests++;
> >         }
> > +       child_tests = calloc(num_tests, sizeof(*child_tests));
> > +       if (!child_tests)
> > +               return -ENOMEM;
> >
> >         for_each_test(j, k, t) {
> >                 int curr = i++;
> > @@ -336,52 +416,47 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >                                 continue;
> >                 }
> >
> > -               pr_info("%3d: %-*s:", i, width, test_description(t, -1));
> > -
> >                 if (intlist__find(skiplist, i)) {
> > +                       pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
> >                         color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> >                         continue;
> >                 }
> >
> >                 if (!has_subtests(t)) {
> > -                       test_and_print(t, -1);
> > +                       int err = start_test(t, curr, -1, &child_tests[child_test_num++], width);
> > +
> > +                       if (err) {
> > +                               /* TODO: if parallel waitpid the already forked children. */
> > +                               free(child_tests);
> > +                               return err;
> > +                       }
> >                 } else {
> >                         int subn = num_subtests(t);
> > -                       /*
> > -                        * minus 2 to align with normal testcases.
> > -                        * For subtest we print additional '.x' in number.
> > -                        * for example:
> > -                        *
> > -                        * 35: Test LLVM searching and compiling                        :
> > -                        * 35.1: Basic BPF llvm compiling test                          : Ok
> > -                        */
> > -                       int subw = width > 2 ? width - 2 : width;
> > -
> > -                       if (subn <= 0) {
> > -                               color_fprintf(stderr, PERF_COLOR_YELLOW,
> > -                                             " Skip (not compiled in)\n");
> > -                               continue;
> > -                       }
> > -                       pr_info("\n");
> >
> >                         for (subi = 0; subi < subn; subi++) {
> > -                               int len = strlen(test_description(t, subi));
> > -
> > -                               if (subw < len)
> > -                                       subw = len;
> > -                       }
> > +                               int err;
> >
> > -                       for (subi = 0; subi < subn; subi++) {
> >                                 if (!perf_test__matches(test_description(t, subi),
> >                                                         curr, argc, argv))
> >                                         continue;
> >
> > -                               pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
> > -                                       test_description(t, subi));
> > -                               test_and_print(t, subi);
> > +                               err = start_test(t, curr, subi, &child_tests[child_test_num++],
> > +                                                width);
> > +                               if (err)
> > +                                       return err;
> >                         }
> >                 }
> >         }
> > +       for (i = 0; i < child_test_num; i++) {
> > +               if (parallel) {
> > +                       int ret  = finish_test(child_tests[i], width);
> > +
> > +                       if (ret)
> > +                               return ret;
> > +               }
> > +               free(child_tests[i]);
> > +       }
> > +       free(child_tests);
> >         return 0;
> >  }
> >
> > @@ -449,6 +524,8 @@ int cmd_test(int argc, const char **argv)
> >                     "be more verbose (show symbol address, etc)"),
> >         OPT_BOOLEAN('F', "dont-fork", &dont_fork,
> >                     "Do not fork for testcase"),
> > +       OPT_BOOLEAN('p', "parallel", &parallel,
> > +                   "Run the tests altogether in parallel"),
> >         OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
> >         OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
> >         OPT_STRING(0, "objdump", &test_objdump_path, "path",
> > --
> > 2.43.0.rc2.451.g8631bc7472-goog
> >

-- 

- Arnaldo
