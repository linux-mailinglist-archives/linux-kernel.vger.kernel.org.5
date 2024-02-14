Return-Path: <linux-kernel+bounces-64732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C26854217
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF41B242A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF910A1B;
	Wed, 14 Feb 2024 04:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkaE9YpO"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD94101FA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707885232; cv=none; b=Js44ZuOoef8F4k7nxOCf3wq/o7SVPpsnVT2jg/bY/9SQBqJr+p29pKbM02EsvVcLt+sWKM1AyrhKGEewWR/oX17fYklQ7fqAO5ZubglkmF6XW9V1JpkezacGMiCN0aP4mmX+45XWhDqhI4ZLCee0OHQS1aZzqANz69Qi1NT/vQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707885232; c=relaxed/simple;
	bh=DX3lmGDBGmX8QNS+MI9SZDn/w2KNnJD/ve+KtVqRpSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVOoN+nJatm57grrLM0OpSImiOB44TGD4IKOCWMDvNrjaBsGD6GjnHO50HQNUd+4jJ6R36AsXhJ60I9B5VUcLfD+AifdzTtujK1C2agApSszUbB/qmUndOKBS6ngVInxQXA109AciuBQcZMFTHbkAYC1ZTSnf+GhJrJTgOhzRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkaE9YpO; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-363c3f7dc20so201215ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707885230; x=1708490030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oppXsRfOgsmX9oD1pmO95Yc48JACNQM6Q192XVNGNI=;
        b=qkaE9YpOcm+eHukKKBqWSCRnIr14ubuKZtxX6thnAcmO3aH2tlmThzRGeCVrRpUkAc
         5E+fFPgg4U24+y4HZk9cRdLMvJUvAS0c7BTqjSkGGO8uEoq0pIfQam0a+DnlNKE7UIzy
         VaiWCM0+oeiO5f5/UxAAXuoR2+98+34WCVL265Hr5yAHQgmTFv53UULQ2D/q1Wk/FNZV
         XTvMLKzj3CdBQpaiehWR7IQdGQu6BkRgw8zjKCG9hyx6SO6wQevfUsmzk43uoGS/tlgf
         47MzXdMDREwxCu2QzgkEAWuAr/lxUSExvN+2GdjnKQSaneweOxsBZCZNiIMMqOF30Pz/
         jRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707885230; x=1708490030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oppXsRfOgsmX9oD1pmO95Yc48JACNQM6Q192XVNGNI=;
        b=O67q2dBYM1hSAah5p0IzB72ES5QoutCRIarnX20HFifAq2t/wYfSc1olr4kzt1uOM0
         L7Y3PekUlqzp3o7UNuBIa2lwFcI++Mw/NsA8FZBTbH6ETsx0A6z+UvZvFiIB/2i2LRcl
         6P1PMIWovIvPDA3BSiOdtIcFw+sbuQn1pvmkbh3kqLY2kwt0yPMszIRBi1sivEVotlL7
         8SWCPBoDOljtf9g4MPjwNEMifufyNoNLlHiX3RdVdHxwuAPFERBVl7CEWpbVVH0IZpeu
         A3+anmPBXLcFSQXKVr2kP5/BC6xdQPDMGJjrxTutMJ5e1RFuJE/ZExrOzwC3UllQIbuR
         iLSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9sLCzUpJl4FZc+ahrAb4pdmXR7PL/xc/N3v5Evk5SeryznWLjTqjX3086Qesp38jjAbu/CAioRPrAXb/OKv2GsYZRlvp3oNL/H9rw
X-Gm-Message-State: AOJu0YyF6YItkRjeW7o9MwON/K3jCCtQQXSqjGJYqQ5Wv1H2h2oUbrrE
	G27heDL0kwokTqB/b9OBDWn30zSR6qnKjdSiLT+8jSNNGKzBCK4CjOWvljSK9DJ8FBmZhz89htj
	KbtqxaFTwDQT6xvsV01llyFe35pFglp0TjSrY
X-Google-Smtp-Source: AGHT+IFF4sQ90BX6vXnzz+zK6nk1Zg73NqW7rnSxvkA0GiMkhzqgWqoPBXgIMVJtaHp3xX1Rk+fC4/V5LzMr1uz4zC0=
X-Received: by 2002:a05:6e02:3d08:b0:363:bad1:b8d6 with SMTP id
 db8-20020a056e023d0800b00363bad1b8d6mr121340ilb.1.1707885229858; Tue, 13 Feb
 2024 20:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com> <20240212185858.68189-9-irogers@google.com>
 <CAM9d7chcdJ7zsOEWLo1q-U25YyvP=22+GGxcMEbdkQbW_csoyg@mail.gmail.com>
In-Reply-To: <CAM9d7chcdJ7zsOEWLo1q-U25YyvP=22+GGxcMEbdkQbW_csoyg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Feb 2024 20:33:35 -0800
Message-ID: <CAP-5=fXnY9zUH-u2X3w5pn+9ZWoamg+h_nR84YhNVU3+VnWfQg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] perf tests: Add option to run tests in parallel
To: Namhyung Kim <namhyung@kernel.org>
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

On Tue, Feb 13, 2024 at 5:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 12, 2024 at 10:59=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > By default tests are forked, add an option (-p or --parallel) so that
> > the forked tests are all started in parallel and then their output
> > gathered serially. This is opt-in as running in parallel can cause
> > test flakes.
> >
> > Rather than fork within the code, the start_command/finish_command
> > from libsubcmd are used. This changes how stderr and stdout are
> > handled. The child stderr and stdout are always read to avoid the
> > child blocking. If verbose is 1 (-v) then if the test fails the child
> > stdout and stderr are displayed. If the verbose is >1 (e.g. -vv) then
> > the stdout and stderr from the child are immediately displayed.
> >
> > An unscientific test on my laptop shows the wall clock time for perf
> > test without parallel being 5 minutes 21 seconds and with parallel
> > (-p) being 1 minute 50 seconds.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v1 of this code had a bug where stdout/stderr weren't read fully. This
> > and additional issues/improvements are dealt with in v2.
> > ---
> [SNIP]
> >  static int __cmd_test(int argc, const char *argv[], struct intlist *sk=
iplist)
> >  {
> >         struct test_suite *t;
> >         unsigned int j, k;
> >         int i =3D 0;
> >         int width =3D 0;
> > +       size_t num_tests =3D 0;
> > +       struct child_test **child_tests;
> > +       int child_test_num =3D 0;
> >
> >         for_each_test(j, k, t) {
> >                 int len =3D strlen(test_description(t, -1));
> >
> >                 if (width < len)
> >                         width =3D len;
> > +
> > +               if (has_subtests(t)) {
> > +                       for (int l =3D 0, subn =3D num_subtests(t); l <=
 subn; l++) {
> > +                               len =3D strlen(test_description(t, -1))=
;
>
> Shouldn't it be strlen(test_description(t, i)) ?  Looks like it has len
> of parent test already.
>
> Thanks,
> Namhyung

Thanks Namhyung, will fix in v4.

Ian

> > +                               if (width < len)
> > +                                       width =3D len;
> > +                               num_tests++;
> > +                       }
> > +               } else
> > +                       num_tests++;
> >         }
> > +       child_tests =3D calloc(num_tests, sizeof(*child_tests));
> > +       if (!child_tests)
> > +               return -ENOMEM;
> >
> >         for_each_test(j, k, t) {
> >                 int curr =3D i++;
> > @@ -334,52 +458,47 @@ static int __cmd_test(int argc, const char *argv[=
], struct intlist *skiplist)
> >                                 continue;
> >                 }
> >
> > -               pr_info("%3d: %-*s:", i, width, test_description(t, -1)=
);
> > -
> >                 if (intlist__find(skiplist, i)) {
> > +                       pr_info("%3d: %-*s:", curr + 1, width, test_des=
cription(t, -1));
> >                         color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip=
 (user override)\n");
> >                         continue;
> >                 }
> >
> >                 if (!has_subtests(t)) {
> > -                       test_and_print(t, -1);
> > +                       int err =3D start_test(t, curr, -1, &child_test=
s[child_test_num++], width);
> > +
> > +                       if (err) {
> > +                               /* TODO: if parallel waitpid the alread=
y forked children. */
> > +                               free(child_tests);
> > +                               return err;
> > +                       }
> >                 } else {
> >                         int subn =3D num_subtests(t);
> > -                       /*
> > -                        * minus 2 to align with normal testcases.
> > -                        * For subtest we print additional '.x' in numb=
er.
> > -                        * for example:
> > -                        *
> > -                        * 35: Test LLVM searching and compiling       =
                 :
> > -                        * 35.1: Basic BPF llvm compiling test         =
                 : Ok
> > -                        */
> > -                       int subw =3D width > 2 ? width - 2 : width;
> > -
> > -                       if (subn <=3D 0) {
> > -                               color_fprintf(stderr, PERF_COLOR_YELLOW=
,
> > -                                             " Skip (not compiled in)\=
n");
> > -                               continue;
> > -                       }
> > -                       pr_info("\n");
> >
> >                         for (subi =3D 0; subi < subn; subi++) {
> > -                               int len =3D strlen(test_description(t, =
subi));
> > +                               int err;
> >
> > -                               if (subw < len)
> > -                                       subw =3D len;
> > -                       }
> > -
> > -                       for (subi =3D 0; subi < subn; subi++) {
> >                                 if (!perf_test__matches(test_descriptio=
n(t, subi),
> >                                                         curr, argc, arg=
v))
> >                                         continue;
> >
> > -                               pr_info("%3d.%1d: %-*s:", i, subi + 1, =
subw,
> > -                                       test_description(t, subi));
> > -                               test_and_print(t, subi);
> > +                               err =3D start_test(t, curr, subi, &chil=
d_tests[child_test_num++],
> > +                                                width);
> > +                               if (err)
> > +                                       return err;
> >                         }
> >                 }
> >         }
> > +       for (i =3D 0; i < child_test_num; i++) {
> > +               if (parallel) {
> > +                       int ret  =3D finish_test(child_tests[i], width)=
;
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
> > @@ -447,6 +566,8 @@ int cmd_test(int argc, const char **argv)
> >                     "be more verbose (show symbol address, etc)"),
> >         OPT_BOOLEAN('F', "dont-fork", &dont_fork,
> >                     "Do not fork for testcase"),
> > +       OPT_BOOLEAN('p', "parallel", &parallel,
> > +                   "Run the tests altogether in parallel"),
> >         OPT_STRING('w', "workload", &workload, "work", "workload to run=
 for testing"),
> >         OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
> >         OPT_STRING(0, "objdump", &test_objdump_path, "path",
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

