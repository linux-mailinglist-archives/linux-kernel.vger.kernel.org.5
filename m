Return-Path: <linux-kernel+bounces-109134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1A881512
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA831C20958
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E653E2C;
	Wed, 20 Mar 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wxYv5h07"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7750524D7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950334; cv=none; b=Is3vk0UATznYJiXzjEUw6loj2rKf7Hb7mB+OK5ZZQhYjmiz8inKspk3vk+TR/3JPjdxaApF9YE0juXozO8qsN74/BtEUGrEVG6HUPOVAuRn9ILPhmvJwmuzy5Un2dhnbf2pQpHULo1n8sBoI8GA2y6Jn9oKsb95AEiy8asvfG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950334; c=relaxed/simple;
	bh=GmmRjBu8OPrKOqfE4JDgrdYsY7XBEdzR9WTE+oGBr6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=A++tQFz1s0/Pbe7wo49uTSAQ+1CLzXdwrak04/xN92BaNjRUe+lYzDOqMlsHbll2WsstzJ+WoounJAuoPMvZs9/xmsStAdWXPbcAT2kuL9MxbT6nFbJT9Sb+foNQUCtPDl47NhML9i5RHRQ2W/iuu3a88qlHDi0hcVO7abHBM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wxYv5h07; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e058b9e479so184585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710950332; x=1711555132; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SAiUylEBb4Do6kg5NlBhcM+tFCB4UT2cndOgQS39Kg=;
        b=wxYv5h07nv/rLa/H/Uqnw4++Kcc0gMtr/v+EOmdHtgAYH8Sg9iMnVcXmksESG1CNp6
         etHECM0+LYXy5+0lUuIrhUR3z3+WrzHjkk0BzUFDlSNeNP28eRMZmswnQxaCkKu6rzvb
         ngvgB9UbdTI4J4YvDwuRGDqIRin6IZ2AUwSRKnasMKlRDBz3kUwfy6nzfdU0OS6nJl4T
         GhHiETz4lWSoIexY/dTEeFv2suA7cIceGJZ+ZKiwBwgwBHPi4FScIBcheyqYdvE0F9a9
         Jh33drI9D1Y859Ge1ZNfOk+z+9ZipL/3yzX4RJiiD7Oh1qcBE09SQm5/le5ZHgVVVp+w
         1hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710950332; x=1711555132;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SAiUylEBb4Do6kg5NlBhcM+tFCB4UT2cndOgQS39Kg=;
        b=pitgZr6AskOI4+TLoYHhlMAa94VVH20IX4tiLH440XzAuk/vSfaAtSSIVMW7HlTiwx
         nHCfBFXblvLMrwWirIscWo1vZsKndzKoCk47HrlyhQyZvG5Pu6sX/Kst+PEZVpDnSsWS
         odAIIZN13UqoYuIzkNMCM1Xspx6ly7uRENxVpMhZuuOF/uWoWfuAJ/fn0mBdAVsrPguN
         kFkb0I0pEnsABrH1ywa2Ng7IcGNmAj7c0EMav7ilvH79nymR5zs4TnDnjEh+RTVQx/bc
         9PMFu5iGryE7nxsjZTwUw8hK7OFEMjNZHnfGqTIvycb5U2l1WSjPfjGQse0TgqqV4LCI
         EYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4bhgMJVF+GGwq+q/2kkdK7vatSLUoADiyOJhJq4xSodh/8U9cg2eqHBLzbv+Sc7h20i3lGpgrH618lcFj9bpZQ7AXf8HUFI59DDu4
X-Gm-Message-State: AOJu0Yw8OxIgTk37GvZybF/+U9U5AjRnirdIu67pM8nV5fu3CBCmyPaQ
	Fakpl5+3nH3vPJ+i0SQl96j85vpCOrmGOa3BQdRm+4CBgzGoNZ8Amawns3K8XUAS0ZrpJqN5ut1
	P82K/m2TulgMQWkTYjC9jr9gdmYN6aLkLJ8uJ
X-Google-Smtp-Source: AGHT+IH+gChMwdD3bcfIhE7cZKWnqVX+ASAjEpb0BwxuT9gdJcGkpFGM/aRMHTBT1CXACIqug1dPf3Vvu+VIO5R1hIE=
X-Received: by 2002:a17:902:ecc8:b0:1de:ff9f:e760 with SMTP id
 a8-20020a170902ecc800b001deff9fe760mr293403plh.0.1710950331830; Wed, 20 Mar
 2024 08:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301174711.2646944-1-irogers@google.com>
In-Reply-To: <20240301174711.2646944-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 08:58:37 -0700
Message-ID: <CAP-5=fU7PNEDgOg=cFKkSMgHe7_Xbi5Y9k6yPoAwOpN-Uwdp7A@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Run tests in parallel by default
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:47=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> Switch from running tests sequentially to running in parallel by
> default. Change the opt-in '-p' or '--parallel' flag to '-S' or
> '--sequential'.
>
> On an 8 core tigerlake an address sanitizer run time changes from:
> 326.54user 622.73system 6:59.91elapsed 226%CPU
> to:
> 973.02user 583.98system 3:01.17elapsed 859%CPU
>
> So over twice as fast, saving 4 minutes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
> This change is on top of the test fixes in:
> https://lore.kernel.org/lkml/20240301074639.2260708-1-irogers@google.com/
> ---
>  tools/perf/tests/builtin-test.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index ddb2f4e38ea5..73f53b02f733 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -39,8 +39,8 @@
>   * making them easier to debug.
>   */
>  static bool dont_fork;
> -/* Fork the tests in parallel and then wait for their completion. */
> -static bool parallel;
> +/* Don't fork the tests in parallel and wait for their completion. */
> +static bool sequential;
>  const char *dso_to_test;
>  const char *test_objdump_path =3D "objdump";
>
> @@ -374,7 +374,7 @@ static int start_test(struct test_suite *test, int i,=
 int subi, struct child_tes
>         }
>         (*child)->process.no_exec_cmd =3D run_test_child;
>         err =3D start_command(&(*child)->process);
> -       if (err || parallel)
> +       if (err || !sequential)
>                 return  err;
>         return finish_test(*child, width);
>  }
> @@ -440,7 +440,7 @@ static int __cmd_test(int argc, const char *argv[], s=
truct intlist *skiplist)
>                         int err =3D start_test(t, curr, -1, &child_tests[=
child_test_num++], width);
>
>                         if (err) {
> -                               /* TODO: if parallel waitpid the already =
forked children. */
> +                               /* TODO: if !sequential waitpid the alrea=
dy forked children. */
>                                 free(child_tests);
>                                 return err;
>                         }
> @@ -460,7 +460,7 @@ static int __cmd_test(int argc, const char *argv[], s=
truct intlist *skiplist)
>                 }
>         }
>         for (i =3D 0; i < child_test_num; i++) {
> -               if (parallel) {
> +               if (!sequential) {
>                         int ret  =3D finish_test(child_tests[i], width);
>
>                         if (ret)
> @@ -536,8 +536,8 @@ int cmd_test(int argc, const char **argv)
>                     "be more verbose (show symbol address, etc)"),
>         OPT_BOOLEAN('F', "dont-fork", &dont_fork,
>                     "Do not fork for testcase"),
> -       OPT_BOOLEAN('p', "parallel", &parallel,
> -                   "Run the tests altogether in parallel"),
> +       OPT_BOOLEAN('S', "sequential", &sequential,
> +                   "Run the tests one after another rather than in paral=
lel"),
>         OPT_STRING('w', "workload", &workload, "work", "workload to run f=
or testing"),
>         OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
>         OPT_STRING(0, "objdump", &test_objdump_path, "path",
> @@ -564,6 +564,9 @@ int cmd_test(int argc, const char **argv)
>         if (workload)
>                 return run_workload(workload, argc, argv);
>
> +       if (dont_fork)
> +               sequential =3D true;
> +
>         symbol_conf.priv_size =3D sizeof(int);
>         symbol_conf.try_vmlinux_path =3D true;
>
> --
> 2.44.0.278.ge034bb2e1d-goog
>

