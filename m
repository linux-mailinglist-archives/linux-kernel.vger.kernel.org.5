Return-Path: <linux-kernel+bounces-109070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4AF881445
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7527A1C216E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569D535D0;
	Wed, 20 Mar 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPNXjGu4"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA4F4EB45
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947593; cv=none; b=D3oKS0Ep5XU3BmILHYu3dIaRGU0n7v6HJjSRt+L7cGdK8Yexvs7kPh4LNw5jLIStlzRWL9USb+5hOEGCilHSoC7EOSZxMJ1ybl4k5nxdIEPB8umPEHS+JJ60XABAzQI2PHvN1zbULkgBpneZn0//6hkWrEwaxgcX5KIRvEZh400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947593; c=relaxed/simple;
	bh=m9OPYIu+QyrTH8BWbr0XWwVVNmSf9KYn3EcQnz1bmt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGvVtA+QSngAGba8BB0x/ndEIZml/0pjWtvtkZtcw0ksfc/aYiM6hoIlCAELSbbd5PV4lhwmflqbvnSAVGUopiD4HYPcUNPX4j2Ut6w2554oUyycGLjfzBF2pVQSXfUwFpU7z0ATNb4EyS6jadckdBMBRV4fvE5Cl5RR19FOd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPNXjGu4; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-366abfd7b09so158795ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710947590; x=1711552390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m73wGiqzdBJkICS2Dfzy+2irDr2Zv+TJxkjsujiC7nc=;
        b=LPNXjGu4tTKEoe8loHcdy1wzObq2oH/cgJZvBz83qBwScx0J/iezBIWD0wZuD0fP83
         9JueySU8xnXkojoQPTn+3W9tojJ5teq7NRODqjbo1QdIWHmpavyFErIOyVkvyDzjuJTZ
         OoPTmbMTJPxNo6CZzRI9lxIdBlq4JhIzoUEbE5cFJwKZi9GWO9O81tI9Laz61UtSuOMO
         OlFO1MRbMtEMO0beCorf1EvpKj7LXIREe4i84wbFzZC/ywVEfd69rms04QRpFy1PJd0X
         RCeXyh77fFf539ylt97pbnKxwEnohMQdfUNfkiSO7AA+xNtMOv0DWw3lBZ8/qTkQsg87
         9HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947590; x=1711552390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m73wGiqzdBJkICS2Dfzy+2irDr2Zv+TJxkjsujiC7nc=;
        b=wc/0mK2RrDIRqpxge4Y9X9HhfgXXf4oTzwl379Z/1+HcOFmOALW5zNquwmpcwCiMup
         g4eidYHEX+K3nt2gLcoM4Y+B1NF7km4KAj00LL96bT6ZU4YTXQPkjQcPXWrXyX18dSFO
         wqCR6ZQCDPMC4Spm8//puQO0G7gf0pNT9ypy51712n8/bhzpF/zgKAcfGBIlMJSxeiT0
         CXwmieuSq+UvFIlyHjzPXtyD7poVn7WkIHLDK6PbzseJk1E+wa1yvFVxvXwK7qf7ekiT
         oeOJklX+VHnL/mXjmkJIAAHl2RvUuFjyokXg3lNIW/FRlJcsiuQxIpxVi5CHPi6p5vkV
         m0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTtGfHj5xbqEG+8kSnFePz6XFaXJePnB6+XN4wl7qGPGBYwaDzC6oqMCrRCJHmqx8DNDDxwmDlYZGLXfjDo9GC2DBj6mwh72RC4OTE
X-Gm-Message-State: AOJu0YxnUG/siFOuWkn+PeLvxn1aMbyswsvpKmBiVtMLcPAp5OUDyGzw
	osKodpVO8GbMiN6lTdwp3GNJt2gaGy+L40PqUu7nuf6DvZQgi0XerSJ0XBU8Gi5qfD72RvzqjQf
	X+xbsjmAZlhP4fBF5Z+LNgTxa8oktGHi6D4sq
X-Google-Smtp-Source: AGHT+IHhzD7rWhP/rASzVqdjNRMPtc4CdkNESAN0qWC0nidrRdWCR7Fg3vwNaOCuSmxvy8dTSgunF4MZSs4aJjm+pRo=
X-Received: by 2002:a05:6e02:1d92:b0:368:5254:dc3c with SMTP id
 h18-20020a056e021d9200b003685254dc3cmr252833ila.1.1710947590485; Wed, 20 Mar
 2024 08:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301201306.2680986-1-irogers@google.com> <Zfr4jX_b8FCOG_x_@x1>
 <Zfr5__Ej3-0C8sJj@x1>
In-Reply-To: <Zfr5__Ej3-0C8sJj@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 08:12:56 -0700
Message-ID: <CAP-5=fXXrJRH=Dto2ajD_TUDE1YmkkJZO5Ey2pq5YB0wbVAzeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf: Suggest inbuilt commands for unknown command
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 8:00=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 11:54:09AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Mar 01, 2024 at 12:13:05PM -0800, Ian Rogers wrote:
> > > The existing unknown command code looks for perf scripts like
> > > perf-archive.sh and perf-iostat.sh, however, inbuilt commands aren't
> > > suggested. Add the inbuilt commands so they may be suggested too.
> > >
> > > Before:
> > > ```
> > > $ perf reccord
> > > perf: 'reccord' is not a perf-command. See 'perf --help'.
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf reccord
> > > perf: 'reccord' is not a perf-command. See 'perf --help'.
> > >
> > > Did you mean this?
> > >         record
> > > ```
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > v2. Drops a merged patch and rebases. No functional change. Arnaldo
> > >     reported the patch not working for him, but I've not found a
> >
> > Not working:
> >
> > root@number:~# perf reccord
> > Failed to run command 'reccord': No such file or directory
> > root@number:~#
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ git log --oneline -1
> > a65ef8052854ba75 (HEAD) perf: Suggest inbuilt commands for unknown comm=
and
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > I use O=3D with install-bin, trying:
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ make -C  tools/perf install-bi=
n
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ perf raccord
> > Failed to run command 'raccord': No such file or directory
> > =E2=AC=A2[acme@toolbox perf-tools-next]$
> >
> > Also didn't work
> >
> > Trying to figure this out...
>
> It somehow gets done_help set to 32767, and this will not run help_unknow=
n_cmd(), continuing after a conf call...
>
> (gdb) p *argv
> $7 =3D 0x7fffffffe4c5 "raccord"
> (gdb) s
> run_argv (argcp=3D0x7fffffffdfbc, argv=3D0x7fffffffdfb0) at perf.c:445
> 445     {
> (gdb) n
> 447             handle_internal_command(*argcp, *argv);
> (gdb) n
> 450             execv_dashed_external(*argv);
> (gdb) p *argv
> $8 =3D (const char **) 0x7fffffffe1d0
> (gdb) p **argv
> $9 =3D 0x7fffffffe4c5 "raccord"
> (gdb) n
> [Detaching after fork from child process 3245070]
> 451             return 0;
> (gdb) n
> 452     }
> (gdb) n
> main (argc=3D1, argv=3D0x7fffffffe1d0) at perf.c:565
> 565                     if (errno !=3D ENOENT)
> (gdb) p; errno
> Invalid character ';' in expression.
> (gdb) p errno
> $10 =3D 2
> (gdb) n
> 568                     if (!done_help) {
> (gdb) p done_help
> $11 =3D 32767
> (gdb) list
> 563                     run_argv(&argc, &argv);
> 564
> 565                     if (errno !=3D ENOENT)
> 566                             break;
> 567
> 568                     if (!done_help) {
> 569                             struct cmdnames main_cmds;
> 570
> 571                             for (unsigned int i =3D 0; i < ARRAY_SIZE=
(commands); i++) {
> 572                                     add_cmdname(&main_cmds,
> (gdb)
> 573                                                 commands[i].cmd,
> 574                                                 strlen(commands[i].cm=
d));
> 575                             }
> 576                             cmd =3D argv[0] =3D help_unknown_cmd(cmd,=
 &main_cmds);
> 577                             clean_cmdnames(&main_cmds);
> 578                             done_help =3D 1;
> 579                             if (!cmd)
> 580                                     break;
> 581                     } else
> 582                             break;
> (gdb)

Ah, the change:

-               static int done_help;
+               int done_help;

created an uninitialized use. Compiler warning/sanitizers? Anyway,
done_help needs hoisting out of the loop and initializing to zero, or
being made static again (ugh).

Thanks,
Ian

