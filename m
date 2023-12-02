Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046F78019F2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjLBCGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:06:21 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABBD5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:06:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bbf7a6029so1265e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 18:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701482785; x=1702087585; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM3njdPU2hNDuW3eG9mwGeyTcedFjyL6DVGCrpPchJM=;
        b=XfRxVOseFmsG3toXYT+mcl1lxI4pWRP+ZDqvubh/2kLsHdb8ceyGAMvhgh9q+K/8DQ
         XJzK0VYXX8qjkdK27H2mrJdaPG4QRrld1lbRxzzsCj5UEpnNQIH3QWT3ExLmyZM1g8RG
         hUDDuhgvDjPBN05WcuGv+sV1kWuhz6usZzkqjNSzve0h/sG7L98ggX6or1wigyR/bcIL
         lCHhkUVVOotWTy+UGJQvD8CoXy8smATHSGQqV0pWgsFI238C5O+s/gdmOIYtPIU1Ibd5
         NjgQgczlIMNRwmcriENFHkha/Vba+/GQTu6mySs2b+Zvxy7JODeP+O8EDvYR3Q9i7Ype
         sC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482785; x=1702087585;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KM3njdPU2hNDuW3eG9mwGeyTcedFjyL6DVGCrpPchJM=;
        b=qyobW0Nn/xbaf0cK9hc4w5JgDRGjYudZAAAoBWE2Lha+CgkigYvJ94TTmvO77hUJ2a
         yt9a+UX7t6Apw2hYDLlXwEHiIzGIuFLq+SOpl40uSuIObqSrCZjO51m+tWrXHzozYrs6
         +F1joZa8UEHsjAJ0nwVqWkMA+N/1DYT/I07CxDhRA+EuS0kwreoYtbF763JzweoExyod
         HPSBkREC/GCVQuOWPdVgy3r98bYjLFHHrxObVKd9agZdmYFP8AKg4/SDqIDgNbSy1dSr
         hP/AkYKJaGZvcM8JqcSI5IQAY/GbEVS5HKmSG7Nk1e5n9EqAKZKVEgpcR1eUsUdVC1YB
         RHIw==
X-Gm-Message-State: AOJu0YyFvJhrew8jTPb7r118FD+HWIPUIcVQXOGRMiX8JVSCRo2CP0ca
        B72WScrIYzWECdNgzRKHCuOX0iQCJaH/dLkmik7rUA==
X-Google-Smtp-Source: AGHT+IFAMGsgc3tG2f+2P9FeIbOBEb2yiGPU5uiQjCAwDgQP4/KDhHppHhbIc+N33VqFIkvL2hmqxLfhDaTcwH2h1BA=
X-Received: by 2002:a05:6512:33cf:b0:50b:c542:1dd0 with SMTP id
 d15-20020a05651233cf00b0050bc5421dd0mr174177lfg.5.1701482784414; Fri, 01 Dec
 2023 18:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com> <20231201235031.475293-9-irogers@google.com>
In-Reply-To: <20231201235031.475293-9-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 1 Dec 2023 18:06:12 -0800
Message-ID: <CAP-5=fUtoi7ynQ-x_7rrv_vYoTZfS_14COA1MskOFVXJ_jCDew@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] perf tests: Add option to run tests in parallel
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 3:50=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> By default tests are forked, add an option (-p or --parallel) so that
> the forked tests are all started in parallel and then their output
> gathered serially. This is opt-in as running in parallel can cause
> test flakes.
>
> Rather than fork within the code, the start_command/finish_command
> from libsubcmd are used. This changes how stderr and stdout are
> handled.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Actually, I think this patch needs more work. The verbose output is
degraded and missing in some cases. Suggestions on how to fix welcome.
It'd be nice to fix up the tests and allow parallel to be the default.
The first patch in this series is 1 such fix. Another is needed to
make "Couldn't resolve comm name for pid" silent in the cases where it
is racy. I was also noticing hangs on things like the lock contention
test. The good news is the tests are doing their job of finding bugs.

Thanks,
Ian


> ---
>  tools/perf/tests/builtin-test.c | 261 +++++++++++++++++++++-----------
>  1 file changed, 169 insertions(+), 92 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 54b11c23e863..91c32b477cbb 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -21,6 +21,7 @@
>  #include "debug.h"
>  #include "color.h"
>  #include <subcmd/parse-options.h>
> +#include <subcmd/run-command.h>
>  #include "string2.h"
>  #include "symbol.h"
>  #include "util/rlimit.h"
> @@ -31,7 +32,13 @@
>
>  #include "tests-scripts.h"
>
> +/*
> + * Command line option to not fork the test running in the same process =
and
> + * making them easier to debug.
> + */
>  static bool dont_fork;
> +/* Fork the tests in parallel and then wait for their completion. */
> +static bool parallel;
>  const char *dso_to_test;
>  const char *test_objdump_path =3D "objdump";
>
> @@ -211,76 +218,36 @@ static bool perf_test__matches(const char *desc, in=
t curr, int argc, const char
>         return false;
>  }
>
> -static int run_test(struct test_suite *test, int subtest)
> -{
> -       int status, err =3D -1, child =3D dont_fork ? 0 : fork();
> -       char sbuf[STRERR_BUFSIZE];
> -
> -       if (child < 0) {
> -               pr_err("failed to fork test: %s\n",
> -                       str_error_r(errno, sbuf, sizeof(sbuf)));
> -               return -1;
> -       }
> -
> -       if (!child) {
> -               if (!dont_fork) {
> -                       pr_debug("test child forked, pid %d\n", getpid())=
;
> -
> -                       if (verbose <=3D 0) {
> -                               int nullfd =3D open("/dev/null", O_WRONLY=
);
> -
> -                               if (nullfd >=3D 0) {
> -                                       close(STDERR_FILENO);
> -                                       close(STDOUT_FILENO);
> -
> -                                       dup2(nullfd, STDOUT_FILENO);
> -                                       dup2(STDOUT_FILENO, STDERR_FILENO=
);
> -                                       close(nullfd);
> -                               }
> -                       } else {
> -                               signal(SIGSEGV, sighandler_dump_stack);
> -                               signal(SIGFPE, sighandler_dump_stack);
> -                       }
> -               }
> -
> -               err =3D test_function(test, subtest)(test, subtest);
> -               if (!dont_fork)
> -                       exit(err);
> -       }
> -
> -       if (!dont_fork) {
> -               wait(&status);
> +struct child_test {
> +       struct child_process process;
> +       struct test_suite *test;
> +       int test_num;
> +       int subtest;
> +};
>
> -               if (WIFEXITED(status)) {
> -                       err =3D (signed char)WEXITSTATUS(status);
> -                       pr_debug("test child finished with %d\n", err);
> -               } else if (WIFSIGNALED(status)) {
> -                       err =3D -1;
> -                       pr_debug("test child interrupted\n");
> -               }
> -       }
> +static int run_test_child(struct child_process *process)
> +{
> +       struct child_test *child =3D container_of(process, struct child_t=
est, process);
> +       int err;
>
> -       return err;
> +       pr_debug("--- start ---\n");
> +       pr_debug("test child forked, pid %d\n", getpid());
> +       err =3D test_function(child->test, child->subtest)(child->test, c=
hild->subtest);
> +       pr_debug("---- end(%d) ----\n", err);
> +       fflush(NULL);
> +       return -err;
>  }
>
> -#define for_each_test(j, k, t)                 \
> -       for (j =3D 0, k =3D 0; j < ARRAY_SIZE(tests); j++, k =3D 0)   \
> -               while ((t =3D tests[j][k++]) !=3D NULL)
> -
> -static int test_and_print(struct test_suite *t, int subtest)
> +static int print_test_result(struct test_suite *t, int i, int subtest, i=
nt result, int width)
>  {
> -       int err;
> -
> -       pr_debug("\n--- start ---\n");
> -       err =3D run_test(t, subtest);
> -       pr_debug("---- end ----\n");
> +       if (has_subtests(t)) {
> +               int subw =3D width > 2 ? width - 2 : width;
>
> -       if (!has_subtests(t))
> -               pr_debug("%s:", t->desc);
> -       else
> -               pr_debug("%s subtest %d:", t->desc, subtest + 1);
> +               pr_info("%3d.%1d: %-*s:", i + 1, subtest + 1, subw, test_=
description(t, subtest));
> +       } else
> +               pr_info("%3d: %-*s:", i + 1, width, test_description(t, s=
ubtest));
>
> -       switch (err) {
> +       switch (result) {
>         case TEST_OK:
>                 pr_info(" Ok\n");
>                 break;
> @@ -299,22 +266,135 @@ static int test_and_print(struct test_suite *t, in=
t subtest)
>                 break;
>         }
>
> -       return err;
> +       return 0;
> +}
> +
> +static int finish_test(struct child_test *child_test, int width)
> +{
> +       struct test_suite *t =3D child_test->test;
> +       int i =3D child_test->test_num;
> +       int subi =3D child_test->subtest;
> +       int out =3D child_test->process.out;
> +       int err =3D child_test->process.err;
> +       int ret;
> +
> +       if (verbose) {
> +               bool out_done =3D false, err_done =3D false;
> +
> +               fcntl(out, F_SETFL, O_NONBLOCK);
> +               fcntl(err, F_SETFL, O_NONBLOCK);
> +               if (has_subtests(t))
> +                       pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_d=
escription(t, subi));
> +               else
> +                       pr_info("%3d: %s:\n", i + 1, test_description(t, =
-1));
> +
> +               while (!out_done && !err_done) {
> +                       char buf[512];
> +                       ssize_t len;
> +
> +                       if (!out_done) {
> +                               errno =3D 0;
> +                               len =3D read(out, buf, sizeof(buf) - 1);
> +
> +                               if (len <=3D 0)
> +                                       err_done =3D errno !=3D EAGAIN;
> +                               else {
> +                                       buf[len] =3D '\0';
> +                                       fprintf(stdout, "%s", buf);
> +                               }
> +                       }
> +                       if (!err_done) {
> +                               errno =3D 0;
> +                               len =3D read(err, buf, sizeof(buf) - 1);
> +
> +                               if (len <=3D 0)
> +                                       err_done =3D errno !=3D EAGAIN;
> +                               else {
> +                                       buf[len] =3D '\0';
> +                                       fprintf(stderr, "%s", buf);
> +                               }
> +                       }
> +               }
> +       }
> +       ret =3D finish_command(&child_test->process);
> +       print_test_result(t, i, subi, ret, width);
> +       if (out >=3D 0)
> +               close(out);
> +       if (err >=3D 0)
> +               close(err);
> +       return 0;
> +}
> +
> +static int start_test(struct test_suite *test, int i, int subi, struct c=
hild_test **child,
> +                     int width)
> +{
> +       int err;
> +
> +       *child =3D NULL;
> +       if (dont_fork) {
> +               pr_debug("--- start ---\n");
> +               err =3D test_function(test, subi)(test, subi);
> +               pr_debug("---- end ----\n");
> +               print_test_result(test, i, subi, err, width);
> +               return 0;
> +       }
> +
> +       *child =3D zalloc(sizeof(**child));
> +       if (!*child)
> +               return -ENOMEM;
> +
> +       (*child)->test =3D test;
> +       (*child)->test_num =3D i;
> +       (*child)->subtest =3D subi;
> +       (*child)->process.pid =3D -1;
> +       (*child)->process.no_stdin =3D 1;
> +       if (verbose <=3D 0) {
> +               (*child)->process.no_stdout =3D 1;
> +               (*child)->process.no_stderr =3D 1;
> +       } else {
> +               (*child)->process.out =3D -1;
> +               (*child)->process.err =3D -1;
> +       }
> +       (*child)->process.no_exec_cmd =3D run_test_child;
> +       err =3D start_command(&(*child)->process);
> +       if (err || parallel)
> +               return  err;
> +       return finish_test(*child, width);
>  }
>
> +#define for_each_test(j, k, t)                                 \
> +       for (j =3D 0, k =3D 0; j < ARRAY_SIZE(tests); j++, k =3D 0)   \
> +               while ((t =3D tests[j][k++]) !=3D NULL)
> +
>  static int __cmd_test(int argc, const char *argv[], struct intlist *skip=
list)
>  {
>         struct test_suite *t;
>         unsigned int j, k;
>         int i =3D 0;
>         int width =3D 0;
> +       size_t num_tests =3D 0;
> +       struct child_test **child_tests;
> +       int child_test_num =3D 0;
>
>         for_each_test(j, k, t) {
>                 int len =3D strlen(test_description(t, -1));
>
>                 if (width < len)
>                         width =3D len;
> +
> +               if (has_subtests(t)) {
> +                       for (int l =3D 0, subn =3D num_subtests(t); l < s=
ubn; l++) {
> +                               len =3D strlen(test_description(t, -1));
> +                               if (width < len)
> +                                       width =3D len;
> +                               num_tests++;
> +                       }
> +               } else
> +                       num_tests++;
>         }
> +       child_tests =3D calloc(num_tests, sizeof(*child_tests));
> +       if (!child_tests)
> +               return -ENOMEM;
>
>         for_each_test(j, k, t) {
>                 int curr =3D i++;
> @@ -336,52 +416,47 @@ static int __cmd_test(int argc, const char *argv[],=
 struct intlist *skiplist)
>                                 continue;
>                 }
>
> -               pr_info("%3d: %-*s:", i, width, test_description(t, -1));
> -
>                 if (intlist__find(skiplist, i)) {
> +                       pr_info("%3d: %-*s:", curr + 1, width, test_descr=
iption(t, -1));
>                         color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (=
user override)\n");
>                         continue;
>                 }
>
>                 if (!has_subtests(t)) {
> -                       test_and_print(t, -1);
> +                       int err =3D start_test(t, curr, -1, &child_tests[=
child_test_num++], width);
> +
> +                       if (err) {
> +                               /* TODO: if parallel waitpid the already =
forked children. */
> +                               free(child_tests);
> +                               return err;
> +                       }
>                 } else {
>                         int subn =3D num_subtests(t);
> -                       /*
> -                        * minus 2 to align with normal testcases.
> -                        * For subtest we print additional '.x' in number=
.
> -                        * for example:
> -                        *
> -                        * 35: Test LLVM searching and compiling         =
               :
> -                        * 35.1: Basic BPF llvm compiling test           =
               : Ok
> -                        */
> -                       int subw =3D width > 2 ? width - 2 : width;
> -
> -                       if (subn <=3D 0) {
> -                               color_fprintf(stderr, PERF_COLOR_YELLOW,
> -                                             " Skip (not compiled in)\n"=
);
> -                               continue;
> -                       }
> -                       pr_info("\n");
>
>                         for (subi =3D 0; subi < subn; subi++) {
> -                               int len =3D strlen(test_description(t, su=
bi));
> -
> -                               if (subw < len)
> -                                       subw =3D len;
> -                       }
> +                               int err;
>
> -                       for (subi =3D 0; subi < subn; subi++) {
>                                 if (!perf_test__matches(test_description(=
t, subi),
>                                                         curr, argc, argv)=
)
>                                         continue;
>
> -                               pr_info("%3d.%1d: %-*s:", i, subi + 1, su=
bw,
> -                                       test_description(t, subi));
> -                               test_and_print(t, subi);
> +                               err =3D start_test(t, curr, subi, &child_=
tests[child_test_num++],
> +                                                width);
> +                               if (err)
> +                                       return err;
>                         }
>                 }
>         }
> +       for (i =3D 0; i < child_test_num; i++) {
> +               if (parallel) {
> +                       int ret  =3D finish_test(child_tests[i], width);
> +
> +                       if (ret)
> +                               return ret;
> +               }
> +               free(child_tests[i]);
> +       }
> +       free(child_tests);
>         return 0;
>  }
>
> @@ -449,6 +524,8 @@ int cmd_test(int argc, const char **argv)
>                     "be more verbose (show symbol address, etc)"),
>         OPT_BOOLEAN('F', "dont-fork", &dont_fork,
>                     "Do not fork for testcase"),
> +       OPT_BOOLEAN('p', "parallel", &parallel,
> +                   "Run the tests altogether in parallel"),
>         OPT_STRING('w', "workload", &workload, "work", "workload to run f=
or testing"),
>         OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>         OPT_STRING(0, "objdump", &test_objdump_path, "path",
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
