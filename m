Return-Path: <linux-kernel+bounces-109090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFC881483
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09E6B22BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D38854F9D;
	Wed, 20 Mar 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWleWffk"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51A54BFD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948368; cv=none; b=JaPUKx7juwcUP7BDFnCoB9FJwzMZ49S3oy7BmDwIHVJau4OA1GzpVUakHnX092MwoKOcXp+rQT18lmzxS0KPOs6bkLGoO3DnqP+PVQJA4iE5V4tNlkDCgKbpadJn2hZf8Zus8i+PUrgkSZgm1ZgyzgC8PUNOo4Fl9Ig+qrDIKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948368; c=relaxed/simple;
	bh=HzTQTrodQsDZulCeLz3oMGVRsw/ifknd40bGVJlis8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8X0V0vObeGnuioA70wdzPBxVwzWDRvYatGSqt3p9z7+MRdhh3JkoEk563UkUv3H/AA/GWCv8nU4VvDLTc3gH31240roHtjlQwnTIjSJqtrKWgNc2cauc0VAr7SqPXolUu4tohkJDPDCEjSMPWCf/RbFSvRo4rizt4pKVUkioqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWleWffk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1deddb82b43so194545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710948366; x=1711553166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y59vSrCcaiAMI5hSgEs+dfCCdMghPK9Y1TcWhvh90As=;
        b=lWleWffkezz5LG6Wzp/GbiotFy+Ydjsu5jHv/iKfy/vcRWStQJ5qFCJAO8zTvaab6s
         OJoAaQb1zlvm8Z6dEaW5iOMTNawdj2TVPUGA4fqTdTKd4bSihvw0n7P7qpbIVFmwG0LD
         diVun3urlNkxo2c1bWk6AH33ZDdToYQ3S3UXHYd77b6iFCjBHbHihdOK9GZ5eDr6Q7Ck
         9VDa/gbPsiD+ZqJjlndeLSUvKXu4BwYUmEcV7Yq30ZMiU/14ipZcZoytpo5RbZXSYoQW
         a2ZE+lZ6ucnDaKWr+xdmQgZwtpB935Ew1+DSMyus8PVm25JvMo+vBJFigiWyLv9xsjAs
         izOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710948366; x=1711553166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y59vSrCcaiAMI5hSgEs+dfCCdMghPK9Y1TcWhvh90As=;
        b=EI0n7ht3f5gP8n+BMNdw8pInbLxW6zfd2GjpYcIVYqyxMlga+1dahdqcgAddYGQiYZ
         2pDDWdGn/yErhE3uDMfdQN1meWPiiz4UYwPKRKzo3wzKct9WqYxIYCUtUoux+nnwJBPI
         +vCtiSIxCJx3AAaCPhhCw4+QcDBTmOCvH7NaHjijrxNG9We+clVFtypPS6xB8E15COQJ
         bFr6gvgi7sqlJBbMv7sJWtTDnbrFAxWhUvuOdZkTOPn233kISJ56Ry/PHsB/Im+VrzLf
         GzXvNZjhzIOA7aulEfaPsVtsu46/edzakS+8Yuz8LQPF+Gm3LruMlWs/62ThkeTHoyaN
         Rxsw==
X-Forwarded-Encrypted: i=1; AJvYcCUhfNgi5vJ693DVf5iZIXM+IB8Zd+NBoPM3DDnaznED/Ffrsijs7HEjxDinxMNyYe3vVNZakTozZoa52faU9QgAsh3vsqWlXB5W/Mkl
X-Gm-Message-State: AOJu0YxULmIJuIl6nMFwcMt+nP90EZn3iyp2b+2DNXtJ0hqCuOV+iT2I
	tGgJM2CwAGfoRNvni/g/ZQ9YIChZsth40i7+9orcvcZ9iQjESrgxR1Z8L9vOnM92BzEnrVGVvSH
	yiyft9Y9dMB6F71VQdkZVH4kQPwysh/SG8n9e
X-Google-Smtp-Source: AGHT+IFoFYFjtg1HKYVBc29E8GCVdzzBQ4lsdFyBaiE5yqR6BRoa9//8oVfbQ/nhMoQTGYSfBkGVhmzKvtEiSnu8Dik=
X-Received: by 2002:a17:902:e842:b0:1dd:5807:a647 with SMTP id
 t2-20020a170902e84200b001dd5807a647mr284161plg.4.1710948365513; Wed, 20 Mar
 2024 08:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301201306.2680986-1-irogers@google.com> <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1> <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
 <Zfr-sQJPbZzbtk8K@x1>
In-Reply-To: <Zfr-sQJPbZzbtk8K@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 08:25:54 -0700
Message-ID: <CAP-5=fXTy5SKpqVoqgHhUycp3GFHPA8repnmzOiUuW=SMjNFQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:20=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 08:12:56AM -0700, Ian Rogers wrote:
> > Ah, the change:
> >
> > -               static int done_help;
> > +               int done_help;
> >
> > created an uninitialized use. Compiler warning/sanitizers? Anyway,
> > done_help needs hoisting out of the loop and initializing to zero, or
> > being made static again (ugh).
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index c719e6ccd9e27778..f9532b20e87cbf05 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -459,7 +459,7 @@ static int libperf_print(enum libperf_print_level lev=
el,
>
>  int main(int argc, const char **argv)
>  {
> -       int err;
> +       int err, done_help =3D 0;
>         const char *cmd;
>         char sbuf[STRERR_BUFSIZE];
>
> @@ -558,8 +558,6 @@ int main(int argc, const char **argv)
>         pthread__block_sigwinch();
>
>         while (1) {
> -               int done_help;
> -
>                 run_argv(&argc, &argv);
>
>                 if (errno !=3D ENOENT)
> =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
>   Fatal: Out of memory, realloc failed
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> Then:
>
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index c719e6ccd9e27778..54f62aa6612bc290 100644
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
> =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
>   Fatal: Out of memory, realloc failed
> =E2=AC=A2[acme@toolbox perf-tools-next]$


Similar issue on main_cmds, caught by memory sanitizer. I think the
following fixes it:

```
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index c719e6ccd9e2..bd3f80b5bb46 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -459,7 +459,7 @@ static int libperf_print(enum libperf_print_level level=
,

int main(int argc, const char **argv)
{
-       int err;
+       int err, done_help =3D 0;
       const char *cmd;
       char sbuf[STRERR_BUFSIZE];

@@ -558,15 +558,13 @@ int main(int argc, const char **argv)
       pthread__block_sigwinch();

       while (1) {
-               int done_help;
-
               run_argv(&argc, &argv);

               if (errno !=3D ENOENT)
                       break;

               if (!done_help) {
-                       struct cmdnames main_cmds;
+                       struct cmdnames main_cmds =3D {};

                       for (unsigned int i =3D 0; i < ARRAY_SIZE(commands);=
 i++) {
                               add_cmdname(&main_cmds,
```

Thanks,
Ian

> - Arnaldo

