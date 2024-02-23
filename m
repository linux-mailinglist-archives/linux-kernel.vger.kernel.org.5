Return-Path: <linux-kernel+bounces-77551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B71586075D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFCE1C21F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80D61FA4;
	Fri, 23 Feb 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obHVaBWm"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8178370
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646545; cv=none; b=rEnUbvBXG6eXgmnsRPuB+h8+aKcnhrUFpHNP9F68yDq1hHnBSKvYWvAB2DRTOiQ7hhGOGrDH1Pe3H2Muay3o40q7A8dIuJOeC9g86iX3qmKM3lZ6oCh4EiYHrkCUFx+HM85fCrGPwC5TuGAzht8CI/RHZFdKyoxy/Ocog7RSgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646545; c=relaxed/simple;
	bh=e+0tBc5rl3AsuopjGEnlgHYKkTUemBC1S0uodgi3rj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff3XXxaRwVyCI57i45mbEp74mhoBqffOqlfies3CxROCB1UPfk+aJR4lHF+eRYvDySgH6r8pm7GJvkv/RpQBSoIQzq4aAPwXbq9Jo13pqngOXPHBhM6RCmB2fF0/3ekyKgKdeSR9vmqQAdhpVbVmeAu7KdjFJ5LIcbAAZP9+C9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obHVaBWm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d5ce88b51cso36145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708646543; x=1709251343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKIqei624U8pNnH0un8neNQZM9OozSHq1mh1Op7pFks=;
        b=obHVaBWmN2MUW8UVZkDATg3Eh6mC8E/svZFewFXut+0YRIgCGRAES2gnH8zfUHxUp1
         cDpVN+MICjIpv1l2xiDoVBPOMlzTI8CBTV/kK/cWR4v85gjzncbe2W7UdcmmqDfgQFt2
         nZC9YnB0aFeD47dbjoq4FMNf3VaymQHRhDoqmG//EkRP2EuHGKm3Yes8QWSar+lIQkuB
         s4dp7/p9BbFk8qrg+bYyMrh4lLJw5uAePzRv5Y7+rE8rb/oO1gBrAtP4N6xWxItSOKD+
         5eVZbcafepdjCo2lV/J5QV/E4Y4xkOyc5e9OdQQ5JsEicVC7rPeiIvvkDtLQKS2EiI8V
         SiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646543; x=1709251343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKIqei624U8pNnH0un8neNQZM9OozSHq1mh1Op7pFks=;
        b=YQvQlSVnrlSd9mZE+xCe1NbOycfDVGMTVLJknDfa0ENtMRJVL6f29NczeRJW77ZyQo
         gqrhLyN3Z6MDH3Lpl+aNOxvZsIovBPdcBQkOo3IG+Spf/pHw60Tj+n9X+ONtzKdczkXK
         6+NHHgl8lYtkEoLw+iaehZLPC9kqZMW706y1z9I6EjL/2FCRUcO7WTqxY29ezYa6O20d
         ZBL7+sEFIlniae/1MdVG3KRh32vqxilpwS+YkAQ4FUudyN4PGlPR1StF2OXUP5yKdx2E
         I3KEF5WW6yol34HzmurcqVvaV1T+PTKddKhUWTEjqHJDNuzZw1Js1gKTtRtnZw36jtNN
         gW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+33UWb+LYeFRfhiBfSvZ7P2FLqqEN4zu1ecsymjXlVyeqkcfrCdHjln5/0aTP5fbd3iCD9P3qgM0gDXeRTtD1VYh27RTmoEzRYwS0
X-Gm-Message-State: AOJu0YzJswd2jQJ5zpdOa7ohpoaklmdwUZt9WNnF60JDlUQwv5m9g2CK
	JfQg3fxLkxV9JhcoOCRhP1pgf9VN/9WoCGSmqKgOdQVMOPXBzhct5Ty4ONzuMqvYotvIQfrPeFy
	YWI176srWRwhNvfqXATFehfSu3xoXMNSkNBf/yEXOhn/AyznorcXc
X-Google-Smtp-Source: AGHT+IER6ZkSQzG0kj2Bw1ykdDF9DFfTp86VxCrkri92YG1vjri132FLxMLOD4+5Zql5MBIoVXrxSQvCBDFa7V50Cs8=
X-Received: by 2002:a17:903:4093:b0:1d9:6949:6c88 with SMTP id
 z19-20020a170903409300b001d969496c88mr606312plc.17.1708646542627; Thu, 22 Feb
 2024 16:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdepeMsjagbf1ufD@x1>
In-Reply-To: <ZdepeMsjagbf1ufD@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Feb 2024 16:02:07 -0800
Message-ID: <CAP-5=fVkA0-JMn-Xu-typJYFod-+LfyAwdUKCKEDQdQu4V_NNw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf test: Use TEST_FAIL in the TEST_ASSERT macros
 instead of -1
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Just to make things clearer, return TEST_FAIL (-1) instead of an open
> coded -1.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/tests.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index dad3d7414142d1be..3aa7701ee0e939f7 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -4,11 +4,17 @@
>
>  #include <stdbool.h>
>
> +enum {
> +       TEST_OK   =3D  0,
> +       TEST_FAIL =3D -1,
> +       TEST_SKIP =3D -2,
> +};
> +
>  #define TEST_ASSERT_VAL(text, cond)                                     =
\
>  do {                                                                    =
\
>         if (!(cond)) {                                                   =
\
>                 pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); =
\
> -               return -1;                                               =
\
> +               return TEST_FAIL;                                        =
\
>         }                                                                =
\
>  } while (0)
>
> @@ -17,16 +23,10 @@ do {                                                 =
                        \
>         if (val !=3D expected) {                                         =
  \
>                 pr_debug("FAILED %s:%d %s (%d !=3D %d)\n",               =
  \
>                          __FILE__, __LINE__, text, val, expected);       =
\
> -               return -1;                                               =
\
> +               return TEST_FAIL;                                        =
        \
>         }                                                                =
\
>  } while (0)
>
> -enum {
> -       TEST_OK   =3D  0,
> -       TEST_FAIL =3D -1,
> -       TEST_SKIP =3D -2,
> -};
> -
>  struct test_suite;
>
>  typedef int (*test_fnptr)(struct test_suite *, int);
> --
> 2.43.0
>

