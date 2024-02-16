Return-Path: <linux-kernel+bounces-69455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E11858937
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BEE1C222E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE614831D;
	Fri, 16 Feb 2024 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mN0jd+1b"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42111482F0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124041; cv=none; b=d7nVcacqFIGDn9UW/+bhGZSH/nCk+dNV7+L6nHNu62mnGQhwZLtDy47R/FkagzlELFy0z4Ub+P/eXclI8l8axfM8F3nH/RZF38oW4p6ssZQ2y+JhzTKUBndybe2/TO2VJY6gt4iM81w9A+kPVt9SGVDYx3iwUDcfZV2i/6WkQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124041; c=relaxed/simple;
	bh=3q90EipWvvvaqgaI/6EsgApL9uUJGd4Z/CoVt0j/CKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyR4XRvbaMaW5kP0UzBUY8VY7z/TtXv8pQyWCF7EgeFEyfI8jMQ+ZmPBA8ZxfEf9EPBJpzlX2k6V0LBU+jhnq9uE8H4F4Kc3816TY00uhi5Q6yVOlDiUcNUus+dgaWv5Dafesfzf7J5jDqsnLMVVXt5NpST4NJpHDYGrlya41pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mN0jd+1b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d89f0ab02bso17255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708124039; x=1708728839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kgkAZMrLqxerengCHS3AJVNNnKIBlki1eFX8UwCow0=;
        b=mN0jd+1bqlXVWOMxV2oYaJFgarht5HM6CBpLxTrmBYuoevyiDrs7XuqNsy8C0KemiQ
         adtEsjvLJ//YMMRr4wxZf4Y9h5eKcuzSNBtfS3hSvlZvjH7Oh94r9fhyT5Hyqhr5Ic0t
         +013t1TXPWQjVHhHIuX+BeqJspdSoQtdlRhAmOdLs6SxeuyxhOKTwGqpCo8nXnhadi3a
         xWdC4NT4nQSpbgu6/rCxyvg5DJ1+oV8D42YRqZL9PvfGWyeoqeWGK4gkFu4KuWHdbydf
         HGOvH7P2GH5ihI1hHSZ0XsZGkmPdzNrolrrocas9DbCk068OOi3UoVtHvKi2Eag34ld1
         nQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124039; x=1708728839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kgkAZMrLqxerengCHS3AJVNNnKIBlki1eFX8UwCow0=;
        b=HVQOInmRNsjK4Svf7ZfeK4HBxeWP4WE4WmXgnnaDe4Und1E/AlEr3Mm557m3Pk2LH4
         JUaQlEIEh5tvnuZX19moUqSRBM+KgWrap7+m6kDIm1TFg0DaKQMf6OGtc9drThZLvxeG
         sAWu3xiKfnEmqosCIu58NvgTGkJ5pyqQH3Qstovf3XG9yM8rQ4o2QH+unFx44O3BXDc1
         0Il/nmFzm3u5X9R+xi+zubXYHDUCwULgt1zN5K8Wq0087tKZBfCQ/LeKoYPZYZC+X2Gh
         s9Wn2sQmQ0EPn4mfPidI1jjkKuI3YlallMByoxzRgCOmOfG9eHlV/iIY/bgWUq7RPYJn
         Vjvg==
X-Forwarded-Encrypted: i=1; AJvYcCXSMMpjGFT+MSHS5ibELdvI1KTPAlMO2eyxzC5nLgmTGYpMG8rc9sv2Lvxxs1brfO1z2WN5/h6oOR3qW1yGrclszab2REqjvvXgV22X
X-Gm-Message-State: AOJu0YytmpgiBhql7TwLgyaheGk0jrbja3yUkQHzI0lLltc797zVYdRm
	2fhq3LNXJiZTJdasHsXx9IhA0Q1PjYlyqwg+OLFP0/ZFQ7InHcIpSfuevbMjHWS+L7xeYF96MCG
	kJQLIUZTefc08PoU+3TdxCG6k4CRtltIUvamF
X-Google-Smtp-Source: AGHT+IGcRBWlQPnvx3Kjur7P29rXsE6x8UxTZTl+jz1tifGisUkPx/OhVZjPNCly11NUA3Yb4nsFQSg4KPNtSAplaQ8=
X-Received: by 2002:a17:903:a47:b0:1da:21e3:b26f with SMTP id
 mn7-20020a1709030a4700b001da21e3b26fmr77326plb.25.1708124038849; Fri, 16 Feb
 2024 14:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214045356.748330-1-irogers@google.com> <20240214045356.748330-7-irogers@google.com>
 <CAM9d7cg5O_1yKpk_X5vn380Cu28ObLjjjnOONHF75D07ZbkR3g@mail.gmail.com>
In-Reply-To: <CAM9d7cg5O_1yKpk_X5vn380Cu28ObLjjjnOONHF75D07ZbkR3g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Feb 2024 14:53:44 -0800
Message-ID: <CAP-5=fW14M5SM3=RidG-SNaugH7++o3Xq7gDS5S6RKnsf3wtwQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] perf tests: Use scandirat for shell script finding
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

On Fri, Feb 16, 2024 at 12:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Feb 13, 2024 at 8:54=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Avoid filename appending buffers by using openat, faccessat and
> > scandirat more widely. Turn the script's path back to a file name
> > using readlink from /proc/<pid>/fd/<fd>.
> >
> > Read the script's description using api/io.h to avoid fdopen
> > conversions. Whilst reading perform additional sanity checks on the
> > script's contents.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/builtin-test.c  |  21 ++---
> >  tools/perf/tests/tests-scripts.c | 144 ++++++++++++++++++-------------
> >  tools/perf/tests/tests-scripts.h |   1 -
> >  3 files changed, 95 insertions(+), 71 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index eff3c62e9b47..6d5001daaf63 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -300,22 +300,20 @@ static int test_and_print(struct test_suite *t, i=
nt subtest)
> >  }
> >
> >  struct shell_test {
> > -       const char *dir;
> >         const char *file;
> >  };
> >
> >  static int shell_test__run(struct test_suite *test, int subdir __maybe=
_unused)
> >  {
> >         int err;
> > -       char script[PATH_MAX];
> >         struct shell_test *st =3D test->priv;
> > +       char *cmd;
> >
> > -       path__join(script, sizeof(script) - 3, st->dir, st->file);
> > -
> > -       if (verbose > 0)
> > -               strncat(script, " -v", sizeof(script) - strlen(script) =
- 1);
> > -
> > -       err =3D system(script);
> > +       asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "");
> > +       if (!cmd)
> > +               return TEST_FAIL;
>
> It fails to build.
>
> tests/tests-scripts.c: In function =E2=80=98shell_test__run=E2=80=99:
> tests/tests-scripts.c:130:9: error: ignoring return value of
> =E2=80=98asprintf=E2=80=99 declared with attribute =E2=80=98warn_unused_r=
esult=E2=80=99
> [-Werror=3Dunused-result]
>   130 |         asprintf(&cmd, "%s%s", file, verbose ? " -v" : "");
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks, 1 liner fix in v5 on its way. I'll add -Werror=3Dunused-result
to my EXTRA_CFLAGS.

Ian

> Thanks,
> Namhyung
>
>
> > +       err =3D system(cmd);
> > +       free(cmd);
> >         if (!err)
> >                 return TEST_OK;
> >

