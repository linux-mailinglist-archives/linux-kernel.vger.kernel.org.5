Return-Path: <linux-kernel+bounces-64628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C2854106
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAE21C2659A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0DD4683;
	Wed, 14 Feb 2024 01:14:30 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33AD7E2;
	Wed, 14 Feb 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873269; cv=none; b=WcNwJ+aMAJtT6DeuydhmsGmhliwsEidU4XKefKdAYwHZuUIgMPinXTAUWPmYpKvC4mnCjZVT4wwW+3dDRObBLksVgBVWfSD3rSZs6ka7YOngrlgA2cI5PwxPO96S5SsOMvri9Iz1LVAZHYe3bZ/DDOF8oPj6K1lFkpW4lOZnBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873269; c=relaxed/simple;
	bh=uaCmhwOn8mw1USdD5pf5zdexUd38umclcqM6RnhK7bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQFwU2BsYON+8302czLQqPfzJm+i7pUqCgxVtnveEOu+EJss+UNsNTjRd28lVN52SeQUu5oheJ0NptH5CSfki0dR7jRS4DrxTwSyXU+daAh/hR9cTb2uXXqd/cuid9Xnaa38+W7j7CBPs+QKfO2jIXfAAnradgmzohLOVspnZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-296c562ac70so3744100a91.2;
        Tue, 13 Feb 2024 17:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873267; x=1708478067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiVVTshxLf488JtQvB4freL8sn2VgHj3EfM+SItvhFw=;
        b=Yol66MnO5G2RnB+rbrpkAztmT/8kPAwBboIx5TPG6cdhuQJzJtnitp0Ii8yPZaDIeV
         v6wjK78bn06e6dyCYU9ua3scjGXxw4YmIuHlvAzCujL5JM2dZxeegNJL82Q/xQ5d/0fy
         f/2BnvY6fiK/v80B3sd+XYS11rrMHYpSsTH2QldrB7jXDbVYk4OHDSeoWy8hfwNinmnN
         oEs+jXogFo8Lx05YE5xZEaj+51YGvAOpkZJUlXVR2Q0dkJls9kAJTFz83XuIzqPf0BM3
         hFbeOgMOCt7QGVNEjCvK0W5GNIKhJNneWU0VgAylQBz6uXowvxSBpK7yiiY830pVVtyk
         Ptgw==
X-Forwarded-Encrypted: i=1; AJvYcCWqyJfJOPdJzR/iLva4/xA8d5jn/NKEEtfC67rUfPnvaHaaOSQLFqCMCAEC6Dt7sbewuusvAZEec2jrux9MEMFLb46bzE3pMH1AEQLdJlXrxjqUtzJGDuJmaX//LnOVKoQaulV3iioLX+VEuJLpHw==
X-Gm-Message-State: AOJu0YxfZMgwO4un0W1jjAP2yQXyqFxDvxkymqg6bTdegCM/dT7QbmXH
	etDn2nOwoWyTjqF4CrLc7RvSdcboJ6wE4Q1PWLB5OOVaahzaeEeZK+Wk07shPfbfw/qpPE1Ukmr
	ymBaYfZvEGC6ux5zKHlyonE2/91w=
X-Google-Smtp-Source: AGHT+IErwkMc01Tf/azIdIDCC7FFkLqYU5zAjx8RMnonJ7nwDnz2JckEoxZsVS70HQzcgO7U5pDHLBjJ+/QXjxztTZ0=
X-Received: by 2002:a17:90b:1054:b0:297:17b0:34e2 with SMTP id
 gq20-20020a17090b105400b0029717b034e2mr1278414pjb.48.1707873267048; Tue, 13
 Feb 2024 17:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com> <20240212185858.68189-9-irogers@google.com>
In-Reply-To: <20240212185858.68189-9-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 13 Feb 2024 17:14:15 -0800
Message-ID: <CAM9d7chcdJ7zsOEWLo1q-U25YyvP=22+GGxcMEbdkQbW_csoyg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] perf tests: Add option to run tests in parallel
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, James Clark <james.clark@arm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:59=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> By default tests are forked, add an option (-p or --parallel) so that
> the forked tests are all started in parallel and then their output
> gathered serially. This is opt-in as running in parallel can cause
> test flakes.
>
> Rather than fork within the code, the start_command/finish_command
> from libsubcmd are used. This changes how stderr and stdout are
> handled. The child stderr and stdout are always read to avoid the
> child blocking. If verbose is 1 (-v) then if the test fails the child
> stdout and stderr are displayed. If the verbose is >1 (e.g. -vv) then
> the stdout and stderr from the child are immediately displayed.
>
> An unscientific test on my laptop shows the wall clock time for perf
> test without parallel being 5 minutes 21 seconds and with parallel
> (-p) being 1 minute 50 seconds.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v1 of this code had a bug where stdout/stderr weren't read fully. This
> and additional issues/improvements are dealt with in v2.
> ---
[SNIP]
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

Shouldn't it be strlen(test_description(t, i)) ?  Looks like it has len
of parent test already.

Thanks,
Namhyung


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
> @@ -334,52 +458,47 @@ static int __cmd_test(int argc, const char *argv[],=
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
> +                               int err;
>
> -                               if (subw < len)
> -                                       subw =3D len;
> -                       }
> -
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
> @@ -447,6 +566,8 @@ int cmd_test(int argc, const char **argv)
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
> 2.43.0.687.g38aa6559b0-goog
>

