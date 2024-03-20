Return-Path: <linux-kernel+bounces-109112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C018814CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D80AB22A10
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F06524D4;
	Wed, 20 Mar 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsxpcmjW"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFF5467F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949269; cv=none; b=GywN4xjzXP1l2wwce7pUOY0EH26SY0aJA9cLexMgNbjKPciyHbGZ9CahEzI0GKJ5gQcHviMlLUDfJtqAhPatKeGkDXwtbcqSgTOIi/oWcg8vPxaVx1tnm08DPloxhneOFo9fWTJmsqaWdRZDzjvJXLd9+9+lolTlSLsgFg+YRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949269; c=relaxed/simple;
	bh=iCunZ+6YcFE7t2PkWp192A1LxUrQ4MKFnnxcQpM6ksg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghr0wkYxRJ7JDYOF3zZ5lfH6jkIAb1Dw4esIVMQaMXUADyUU03VisUCpI4dJtGUr9xjzzBWgELW1Vz4vTKrlXSDHatwKKczHdlSemHrBzXVI9YBlGaXnoFILFfGhcRBEuqRc5iDu211b8ObpkXqFz7A0Jh0pQzbZD+ZHKVSolw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsxpcmjW; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-366abfd7b09so162795ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710949266; x=1711554066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0jkrB/0fBH+KbVOwuSNWx0pd80AKnh03N5PGTLZESg=;
        b=tsxpcmjWzM4TV0aC4bUGpRe4FCz/Zg0JYGQarj56iuS5LXtDuYgspr9dAhmdLgkeOd
         zqXK+4Srz6fEs0cVMq4x3NeRW/6jP3R1MTyl+Lkxn+5YbrW0QlW1bcHVQg7s5h5AZEJF
         Z7aWk3b+8hSVWNMlMDze7g3P3eXj5qQIE97tVGx2F/cYztEwyyyLQ421uCeIqElzZ8s9
         +w+qO3UrXT1091Ppgs53EthkT7vIZ9i3DoZ4PTcqyMKNhuzcxxylX49iXD2vx5j5XeUs
         kyWGIMn1DIfrtcQsTmLI3u8kowvifhgZ1N62SwINwVuDnKvtQto1sgYgSmvEwhxMaWs+
         vX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949266; x=1711554066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0jkrB/0fBH+KbVOwuSNWx0pd80AKnh03N5PGTLZESg=;
        b=Eqdz9D2ghu2ZR5TOCbl17XAELNo2FfNt2jMUwNnNFFnEzAAUBCRKsDDyz33F0BUwGb
         VRzrY2cUr/Q/sWPCYRPd0iLrbSBc+0G+V3Q4k83abyMx6zrPaG7W8Rv/kjXU+tZOUORs
         mPhjXdS0UT1cQqcc4iTZNiQD23k3yAtHryeUzmUnlrRfSZWWXvkyggCIzkY5VqgaavsK
         VKEUwvlHr5AxplX2GxQbUmoQGTkrpCu7ziZMGvWF2h+iYmJqWDJLLqWAQIYNTLCOtFJ1
         z3lqjgsnQk8eO1VxziXDPBTixGI98iVDV9SzG3kwMvaFfAyCpsg72z01imMXiFTQRoUw
         4f8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm75SXvGfm0XIkEbZhE82PfLS6A4iJQupot9vAgdQIoro4xZ9eOy21wjmOMhAeQq/Jq4mArG3Ci6xJlI6kCwJdz+LS5Yr2b2eNWoHD
X-Gm-Message-State: AOJu0YyLhm/h5bIPsqIBAgfRqP1MZXbN/h1JjqMs9+QLtuIiIecLHBlJ
	oUitwhN++81rfVqh4Suvbn2i2wW3gNa5W8l2G04h4KWX1mcGa+dVPLxIagL31OQT0b6uE46hkxe
	XGsVawlf/0dCf+zWLPnbtp9kxyxHteYNf6WtqxjpNPmWsEw6tcBnMD8w=
X-Google-Smtp-Source: AGHT+IFA0TJQu0728H2S5fTBoKBtazLc2VkFUwKlMTDSZ4EQS7K7GdYQY/Hi1tgzHPt3h88l5unhnUslSejtawQgf/w=
X-Received: by 2002:a05:6e02:b4f:b0:366:4f55:bdc7 with SMTP id
 f15-20020a056e020b4f00b003664f55bdc7mr306850ilu.20.1710949266478; Wed, 20 Mar
 2024 08:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301201306.2680986-1-irogers@google.com> <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1> <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1> <ZfsBopALY3whsst5@x1>
In-Reply-To: <ZfsBopALY3whsst5@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 08:40:52 -0700
Message-ID: <CAP-5=fXwfckSBwMVRj_MuZ=aZkkS-bxrcWkzg1y=AZwFQGUjCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:32=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 12:20:20PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 20, 2024 at 08:12:56AM -0700, Ian Rogers wrote:
> > > Ah, the change:
> > >
> > > -               static int done_help;
> > > +               int done_help;
> > >
> > > created an uninitialized use. Compiler warning/sanitizers? Anyway,
> > > done_help needs hoisting out of the loop and initializing to zero, or
> > > being made static again (ugh).
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index c719e6ccd9e27778..f9532b20e87cbf05 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -459,7 +459,7 @@ static int libperf_print(enum libperf_print_level l=
evel,
> >
> >  int main(int argc, const char **argv)
> >  {
> > -       int err;
> > +       int err, done_help =3D 0;
> >         const char *cmd;
> >         char sbuf[STRERR_BUFSIZE];
> >
> > @@ -558,8 +558,6 @@ int main(int argc, const char **argv)
> >         pthread__block_sigwinch();
> >
> >         while (1) {
> > -               int done_help;
> > -
> >                 run_argv(&argc, &argv);
> >
> >                 if (errno !=3D ENOENT)
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
> >   Fatal: Out of memory, realloc failed
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > Then:
> >
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index c719e6ccd9e27778..54f62aa6612bc290 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -558,7 +558,7 @@ int main(int argc, const char **argv)
> >         pthread__block_sigwinch();
> >
> >         while (1) {
> > -               int done_help;
> > +               static int done_help;
> >
> >                 run_argv(&argc, &argv);
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
> >   Fatal: Out of memory, realloc failed
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> That main_cmds variable is uninitialized, which ends up making
> add_cmdname() to explode, are you sure this is working on your side?
>
> Further clarifying, this is without considering the second patch, I
> haven't got to it yet, from what I recall from the description it
> shouldn't matter tho.
>
> - Arnaldo
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index c719e6ccd9e27778..164b3c78baff4204 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -558,7 +558,7 @@ int main(int argc, const char **argv)
>         pthread__block_sigwinch();
>
>         while (1) {
> -               int done_help;
> +               static int done_help;
>
>                 run_argv(&argc, &argv);
>
> @@ -566,7 +566,7 @@ int main(int argc, const char **argv)
>                         break;
>
>                 if (!done_help) {
> -                       struct cmdnames main_cmds;
> +                       struct cmdnames main_cmds =3D { 0, };
>
>                         for (unsigned int i =3D 0; i < ARRAY_SIZE(command=
s); i++) {
>                                 add_cmdname(&main_cmds,
> =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
> perf: 'raccord' is not a perf-command. See 'perf --help'.
> =E2=AC=A2[acme@toolbox perf-tools-next]$

Perhaps change the 'a' to an 'e', the 2nd patch just improves the
weights on removing characters. For me:

```
$ /tmp/perf/perf raccord
perf: 'raccord' is not a perf-command. See 'perf --help'.

Did you mean this?
       record
```

For a memory sanitizer build with the 2 patches and the 2 line changes
I sent before. Fwiw, I'm trying to get memory sanitizer to test "perf
test" but running into an issue with scandirat not having an msan
interceptor.

Thanks,
Ian

