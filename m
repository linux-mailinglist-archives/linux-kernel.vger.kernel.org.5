Return-Path: <linux-kernel+bounces-62124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69852851BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2053828BCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1373F9C4;
	Mon, 12 Feb 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UB9qaXmr"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E43E49E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759781; cv=none; b=OAf8triPJTXbukNNpYBd+wIPjOZ0EltfNwTPnj4EESdlgi8bg+CXbceJ7jtFhwsNKUXYjD/Mw1NNWbAv7pBNkM6VjvEMlxKeYpdudCE5tcYwUV8UvfmnYTnn99hfU/OOq7FiUqt0s6mnvLuS+xa8xGp7OUQgxUMQ8+suX60ONqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759781; c=relaxed/simple;
	bh=hBgrgSQ2WvIgsLwAhLEzviAF1OJWnbhtT5OgqSqwi+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2r+Ccc7r6HhhyMlZ+jWTBO0ruveXyi61rmLazmwJnjEK9nmsb5o3DQQ3LkFUAuewQT6lJrmY4GgW8pMpdopGbe8tA5uKRzchK11WbdXTW/iPvHxuKcUOj0r6jtQTNTlXmQnh/OZUFgkRDSLJ2Rf+tYKAtKIzjDvY6J1gErMqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UB9qaXmr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso3405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707759779; x=1708364579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aog8VNE4h8I2REQO4L/3hmawK8e9r1k2E9qbJbf6Tdg=;
        b=UB9qaXmrNMz5+ZwcDWVfqTaX9RI38kYNBW80Tef9A/Q9PrAIkSlyCBXlD762zl/x23
         9T+mZTH4K0rDuhWe/lYLRilo6AXYKAFD02N+bPtNI3vIZooDeAdYDwwlIOZEHMMHiJLR
         Ba4AeLPshZrjEksiheltDym2Vu6uRgBwFkmKkNtkNFzJPAhByunAfZIN0TYSX5oX9IOT
         9fyz+2lKbpJEIDuVQge7YiUUiJKSVUFJSThKnsVklGlyO5i5hM3PRVnRYPd3DPkMYscK
         urfj542TLmcQdCUFU/lwuwWqEwvJb/WCNnG2IxiQmRdy6PXt6FX9uP1sA96csvsGn1Dx
         bUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759779; x=1708364579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aog8VNE4h8I2REQO4L/3hmawK8e9r1k2E9qbJbf6Tdg=;
        b=v01sZM9wytyW5laYvviYE3WNaX/3Yp7T7YFcETfS4Zj0PkZC216bbl9/wixiARhFpj
         ZaykkYHN33rvkTAbAu+l4El/5IkptfnjOtfDvMwpP+yummP5nQECEw9Evm+grR+JzZxN
         QyoCGJjaoCcWWXG6jDPa4yBzgkbGb47s7vPJKuA92aHqGRjMHYIDTCkW5WW14DhCxyva
         pq41L5npkQIq9mpsR0fuXxwPgBexAoUPY1I/cUmf/nv2KjkbMwKJSZF5mcDjpl5EeEZF
         eeMxZ4TyoD/485QFV4/dBAbpBfm0SX9v7z6g9354izK9JLZLep5/R3AO4VY3boWWTxAb
         4X8w==
X-Forwarded-Encrypted: i=1; AJvYcCWbKP/P2txxT1lGCniybrPoLJJo1iACCZQeCbl/M0ViYQbDPVg8dVmVwaurZ7GfXrmgCe9Td5kvSRztxWsZLu9guzIHmMv9q3asbgCp
X-Gm-Message-State: AOJu0Ywiqn+PvwFG12eHs4si08LVBLrRmkmhLwZ2J/aXa9GeVOExf7DK
	oe2xOLlMLXXds0ma3FrZXO8GsKNa0IXdny0nOb6+2hrlPcpB05lAJIxRPb7tV8C/ltn8zUeTrCH
	6Y1Go0aiKO6cE62nTmSQrlKBEz0KkGA2LnUDY
X-Google-Smtp-Source: AGHT+IG5gqqu63E2iPVSh2XOU/55eaq9aA8oeIvghGsL83zPoBMpXKfS+YHy3TgdRZn1nFQYlX8g7DScoHt+c1lkzJA=
X-Received: by 2002:a17:902:7294:b0:1db:2acb:edfd with SMTP id
 d20-20020a170902729400b001db2acbedfdmr38554pll.22.1707759778576; Mon, 12 Feb
 2024 09:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com> <20240201001504.1348511-7-irogers@google.com>
 <CAM9d7ciaKQadAZJt1431iqZsvAvk9HrCgLp1mLpNwabQ4=_8tg@mail.gmail.com>
In-Reply-To: <CAM9d7ciaKQadAZJt1431iqZsvAvk9HrCgLp1mLpNwabQ4=_8tg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Feb 2024 09:42:45 -0800
Message-ID: <CAP-5=fU+15n_bUExE6e+TcvoSaossORydBB8GEhOTtR3vC3ixA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] perf tests: Run time generate shell test suites
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Jan 31, 2024 at 4:15=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Rather than special shell test logic, do a single pass to create an
> > array of test suites. Hold the shell test file name in the test suite
> > priv field. This makes the special shell test logic in builtin-test.c
> > redundant so remove it.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c  |  91 +----------------------
> >  tools/perf/tests/tests-scripts.c | 120 ++++++++++++++++++-------------
> >  tools/perf/tests/tests-scripts.h |  10 +--
> >  3 files changed, 74 insertions(+), 147 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index 6d5001daaf63..c42cb40fc242 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -130,6 +130,7 @@ static struct test_suite *generic_tests[] =3D {
> >  static struct test_suite **tests[] =3D {
> >         generic_tests,
> >         arch_tests,
> > +       NULL, /* shell tests created at runtime. */
> >  };
> >
> >  static struct test_workload *workloads[] =3D {
> > @@ -299,74 +300,12 @@ static int test_and_print(struct test_suite *t, i=
nt subtest)
> >         return err;
> >  }
> >
> > -struct shell_test {
> > -       const char *file;
> > -};
> > -
> > -static int shell_test__run(struct test_suite *test, int subdir __maybe=
_unused)
> > -{
> > -       int err;
> > -       struct shell_test *st =3D test->priv;
> > -       char *cmd;
> > -
> > -       asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
> > -       if (!cmd)
> > -               return TEST_FAIL;
> > -       err =3D system(cmd);
> > -       free(cmd);
> > -       if (!err)
> > -               return TEST_OK;
> > -
> > -       return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
> > -}
> > -
> > -static int run_shell_tests(int argc, const char *argv[], int i, int wi=
dth,
> > -                               struct intlist *skiplist)
> > -{
> > -       struct shell_test st;
> > -       const struct script_file *files, *file;
> > -
> > -       files =3D list_script_files();
> > -       if (!files)
> > -               return 0;
> > -       for (file =3D files; file->file; file++) {
> > -               int curr =3D i++;
> > -               struct test_case test_cases[] =3D {
> > -                       {
> > -                               .desc =3D file->desc,
> > -                               .run_case =3D shell_test__run,
> > -                       },
> > -                       { .name =3D NULL, }
> > -               };
> > -               struct test_suite test_suite =3D {
> > -                       .desc =3D test_cases[0].desc,
> > -                       .test_cases =3D test_cases,
> > -                       .priv =3D &st,
> > -               };
> > -               st.file =3D file->file;
> > -
> > -               if (test_suite.desc =3D=3D NULL ||
> > -                   !perf_test__matches(test_suite.desc, curr, argc, ar=
gv))
> > -                       continue;
> > -
> > -               pr_info("%3d: %-*s:", i, width, test_suite.desc);
> > -
> > -               if (intlist__find(skiplist, i)) {
> > -                       color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip=
 (user override)\n");
> > -                       continue;
> > -               }
> > -
> > -               test_and_print(&test_suite, 0);
> > -       }
> > -       return 0;
> > -}
> > -
> >  static int __cmd_test(int argc, const char *argv[], struct intlist *sk=
iplist)
> >  {
> >         struct test_suite *t;
> >         unsigned int j, k;
> >         int i =3D 0;
> > -       int width =3D list_script_max_width();
> > +       int width =3D 0;
> >
> >         for_each_test(j, k, t) {
> >                 int len =3D strlen(test_description(t, -1));
> > @@ -441,28 +380,6 @@ static int __cmd_test(int argc, const char *argv[]=
, struct intlist *skiplist)
> >                         }
> >                 }
> >         }
> > -
> > -       return run_shell_tests(argc, argv, i, width, skiplist);
> > -}
> > -
> > -static int perf_test__list_shell(int argc, const char **argv, int i)
> > -{
> > -       const struct script_file *files, *file;
> > -
> > -       files =3D list_script_files();
> > -       if (!files)
> > -               return 0;
> > -       for (file =3D files; file->file; file++) {
> > -               int curr =3D i++;
> > -               struct test_suite t =3D {
> > -                       .desc =3D file->desc
> > -               };
> > -
> > -               if (!perf_test__matches(t.desc, curr, argc, argv))
> > -                       continue;
> > -
> > -               pr_info("%3d: %s\n", i, t.desc);
> > -       }
> >         return 0;
> >  }
> >
> > @@ -489,9 +406,6 @@ static int perf_test__list(int argc, const char **a=
rgv)
> >                                         test_description(t, subi));
> >                 }
> >         }
> > -
> > -       perf_test__list_shell(argc, argv, i);
> > -
> >         return 0;
> >  }
> >
> > @@ -551,6 +465,7 @@ int cmd_test(int argc, const char **argv)
> >         /* Unbuffered output */
> >         setvbuf(stdout, NULL, _IONBF, 0);
> >
> > +       tests[2] =3D create_script_test_suites();
>
> I like this part! :)
>
>
> >         argc =3D parse_options_subcommand(argc, argv, test_options, tes=
t_subcommands, test_usage, 0);
> >         if (argc >=3D 1 && !strcmp(argv[0], "list"))
> >                 return perf_test__list(argc - 1, argv + 1);
> > diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-=
scripts.c
> > index 9b3b66dd5508..b92a93c251c6 100644
> > --- a/tools/perf/tests/tests-scripts.c
> > +++ b/tools/perf/tests/tests-scripts.c
> > @@ -26,16 +26,6 @@
> >  #include "tests.h"
> >  #include "util/rlimit.h"
> >
> > -
> > -/*
> > - * As this is a singleton built once for the run of the process, there=
 is
> > - * no value in trying to free it and just let it stay around until pro=
cess
> > - * exits when it's cleaned up.
> > - */
> > -static size_t files_num =3D 0;
> > -static struct script_file *files =3D NULL;
> > -static int files_max_width =3D 0;
> > -
> >  static int shell_tests__dir_fd(void)
> >  {
> >         char path[PATH_MAX], *exec_path;
> > @@ -131,12 +121,31 @@ static char *strdup_check(const char *str)
> >         return newstr;
> >  }
> >
> > -static void append_script(int dir_fd, const char *name, char *desc)
> > +static int shell_test__run(struct test_suite *test, int subtest __mayb=
e_unused)
> > +{
> > +       const char *file =3D test->priv;
> > +       int err;
> > +       char *cmd;
> > +
> > +       asprintf(&cmd, "%s%s", file, verbose ? " -v" : "");
> > +       if (!cmd)
> > +               return TEST_FAIL;
> > +       err =3D system(cmd);
> > +       free(cmd);
> > +       if (!err)
> > +               return TEST_OK;
> > +
> > +       return WEXITSTATUS(err) =3D=3D 2 ? TEST_SKIP : TEST_FAIL;
> > +}
> > +
> > +static void append_script(int dir_fd, const char *name, char *desc,
> > +                         struct test_suite ***result,
> > +                         size_t *result_sz)
> >  {
> >         char filename[PATH_MAX], link[128];
> > -       struct script_file *files_tmp;
> > -       size_t files_num_tmp, len;
> > -       int width;
> > +       struct test_suite *test_suite, **result_tmp;
> > +       struct test_case *tests;
> > +       size_t len;
> >
> >         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd=
);
> >         len =3D readlink(link, filename, sizeof(filename));
> > @@ -146,33 +155,43 @@ static void append_script(int dir_fd, const char =
*name, char *desc)
> >         }
> >         filename[len++] =3D '/';
> >         strcpy(&filename[len], name);
> > -       files_num_tmp =3D files_num + 1;
> > -       if (files_num_tmp >=3D SIZE_MAX) {
> > -               pr_err("Too many script files\n");
> > -               abort();
> > +
> > +       tests =3D calloc(2, sizeof(*tests));
> > +       if (!tests) {
> > +               pr_err("Out of memory while building script test suite =
list\n");
> > +               return;
> > +       }
> > +       tests[0].name =3D strdup_check(name);
> > +       tests[0].desc =3D strdup_check(desc);
> > +       tests[0].run_case =3D shell_test__run;
> > +
> > +       test_suite =3D zalloc(sizeof(*test_suite));
> > +       if (!test_suite) {
> > +               pr_err("Out of memory while building script test suite =
list\n");
> > +               free(tests);
> > +               return;
> >         }
> > +       test_suite->desc =3D desc;
> > +       test_suite->test_cases =3D tests;
> > +       test_suite->priv =3D strdup_check(filename);
> >         /* Realloc is good enough, though we could realloc by chunks, n=
ot that
> >          * anyone will ever measure performance here */
> > -       files_tmp =3D realloc(files,
> > -                           (files_num_tmp + 1) * sizeof(struct script_=
file));
> > -       if (files_tmp =3D=3D NULL) {
> > -               pr_err("Out of memory while building test list\n");
> > -               abort();
> > +       result_tmp =3D realloc(*result, (*result_sz + 1) * sizeof(*resu=
lt_tmp));
> > +       if (result_tmp =3D=3D NULL) {
> > +               pr_err("Out of memory while building script test suite =
list\n");
> > +               free(tests);
> > +               free(test_suite);
> > +               return;
> >         }
> >         /* Add file to end and NULL terminate the struct array */
> > -       files =3D files_tmp;
> > -       files_num =3D files_num_tmp;
> > -       files[files_num - 1].file =3D strdup_check(filename);
> > -       files[files_num - 1].desc =3D desc;
> > -       files[files_num].file =3D NULL;
> > -       files[files_num].desc =3D NULL;
> > -
> > -       width =3D strlen(desc); /* Track max width of desc */
> > -       if (width > files_max_width)
> > -               files_max_width =3D width;
> > +       *result =3D result_tmp;
> > +       (*result)[*result_sz] =3D test_suite;
> > +       (*result_sz)++;
> >  }
> >
> > -static void append_scripts_in_dir(int dir_fd)
> > +static void append_scripts_in_dir(int dir_fd,
> > +                                 struct test_suite ***result,
> > +                                 size_t *result_sz)
> >  {
> >         struct dirent **entlist;
> >         struct dirent *ent;
> > @@ -191,7 +210,7 @@ static void append_scripts_in_dir(int dir_fd)
> >                         char *desc =3D shell_test__description(dir_fd, =
ent->d_name);
> >
> >                         if (desc) /* It has a desc line - valid script =
*/
> > -                               append_script(dir_fd, ent->d_name, desc=
);
> > +                               append_script(dir_fd, ent->d_name, desc=
, result, result_sz);
> >                         continue;
> >                 }
> >                 if (ent->d_type !=3D DT_DIR) {
> > @@ -204,32 +223,31 @@ static void append_scripts_in_dir(int dir_fd)
> >                                 continue;
> >                 }
> >                 fd =3D openat(dir_fd, ent->d_name, O_PATH);
> > -               append_scripts_in_dir(fd);
> > +               append_scripts_in_dir(fd, result, result_sz);
> >         }
> >         for (i =3D 0; i < n_dirs; i++) /* Clean up */
> >                 zfree(&entlist[i]);
> >         free(entlist);
> >  }
> >
> > -const struct script_file *list_script_files(void)
> > +struct test_suite **create_script_test_suites(void)
> >  {
> > -       int dir_fd;
> > -
> > -       if (files)
> > -               return files; /* Singleton - we already know our list *=
/
> > +       struct test_suite **result =3D NULL, **result_tmp;
> > +       size_t result_sz =3D 0;
> > +       int dir_fd =3D shell_tests__dir_fd(); /* Walk  dir */
> >
> > -       dir_fd =3D shell_tests__dir_fd(); /* Walk  dir */
> >         if (dir_fd < 0)
> >                 return NULL;
>
> When can it fail?  If the test directory doesn't exist?
> I'm afraid returning NULL here can crash perf test.
> I think you need to return a NULL entry result.

Good catch, will fix in v3.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >
> > -       append_scripts_in_dir(dir_fd);
> > +       append_scripts_in_dir(dir_fd, &result, &result_sz);
> > +       result_tmp =3D realloc(result, (result_sz + 1) * sizeof(*result=
_tmp));
> > +       if (result_tmp =3D=3D NULL) {
> > +               pr_err("Out of memory while building script test suite =
list\n");
> > +               abort();
> > +       }
> > +       /* NULL terminate the test suite array. */
> > +       result =3D result_tmp;
> > +       result[result_sz] =3D NULL;
> >         close(dir_fd);
> > -
> > -       return files;
> > -}
> > -
> > -int list_script_max_width(void)
> > -{
> > -       list_script_files(); /* Ensure we have scanned all scripts */
> > -       return files_max_width;
> > +       return result;
> >  }
> > diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-=
scripts.h
> > index 3508a293aaf9..b553ad26ea17 100644
> > --- a/tools/perf/tests/tests-scripts.h
> > +++ b/tools/perf/tests/tests-scripts.h
> > @@ -2,14 +2,8 @@
> >  #ifndef TESTS_SCRIPTS_H
> >  #define TESTS_SCRIPTS_H
> >
> > -struct script_file {
> > -       char *file;
> > -       char *desc;
> > -};
> > +#include "tests.h"
> >
> > -/* List available script tests to run - singleton - never freed */
> > -const struct script_file *list_script_files(void);
> > -/* Get maximum width of description string */
> > -int list_script_max_width(void);
> > +struct test_suite **create_script_test_suites(void);
> >
> >  #endif /* TESTS_SCRIPTS_H */
> > --
> > 2.43.0.429.g432eaa2c6b-goog
> >

