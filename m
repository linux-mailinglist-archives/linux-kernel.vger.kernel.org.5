Return-Path: <linux-kernel+bounces-107981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4B880466
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E998E1C231E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44C82C1A3;
	Tue, 19 Mar 2024 18:10:11 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80652E401;
	Tue, 19 Mar 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871811; cv=none; b=rvh9x0zFR4PJmeT4piKzbT6av48b3TDy57OMPpj9dYf2UTLAi5kvkPsvbf3o9r4BC/v7LYsFx7D7NHjMs/iF85hA2zFRyr5Ivd2U6sN7CYBlIxydjAx4RC1vgCKl4qWtV/MSZSzSVFxLe2KPMqWo4HYoesDxHoEVoqCL7IHsN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871811; c=relaxed/simple;
	bh=xD4aOHRhHuw1j3plQj9V4WOL6Uu7nCb+GdWr5HHMcyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unvJmKqBCjr8f7hYcTRbwtZ6S3dc/uV/2Zp0LXMIyylku+8HVZSUd4D/9ebB/Dt+DnQymdpBbuM/KmPVnT1m0zR3l5nL15B1y9Ed6+mbRcjdMq6PXVN7nHYlJR8dQwT6Rkv5fJbjMTiyi/O6zg39VLRs/H/wgHquSmdquAaBn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6afb754fcso5585583b3a.3;
        Tue, 19 Mar 2024 11:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871809; x=1711476609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIMLYVE6CyTm+xoNKJoABJx7QmXwGTxTuG4FdhVieQQ=;
        b=xFaXjMd/WzhMpfORKoRpa7kG31lnXij+VtqdZRWTnZE/ETJ/HEvKo2ntrKBdJ4j40s
         clWDfKZGgQeHcrlxul9YFxZotIpkp79XOzx80s8z7tg3EF1lwtV4H5Vk0C1VHIDFTmEo
         FBhT3DVWsanv9NhbdL1G8DVOUxQs89chET8Jk2vao16xATayRgf9OPmOtpgB1vRb2SVG
         4Ti5fiUF2V0xhdKppMQ7sBxo55oNAYTXs/uYDT2CBrQfUj0JosvDau44wViorEEvaERP
         WmTGsaEdgHvoPfRKI9TuDHcjcwbltRbfYWfHMntMf3610orqHE22XV+hArKMU7z0KVdU
         IShA==
X-Forwarded-Encrypted: i=1; AJvYcCWp1j/XgZaF3ZEmM6rGf8/WpBxagVk4vdkUtbBq+9cqYXp0yLLHnGVz0R8Q9NDcGiUYhHPYKAM9hPiSaTSomIJDpIXazjS/TwbMCbJEKRZQpXt+23GooYRfukOxE676xENfySi4LSjztKx1gLjjnaz2Yj2XIkR3fV7uG1oIyOe6a4rr//kjPh+HBg1ZIUGuCNV6CLCGQib+VjYKGeIEYFkxNfMo3m2Se4bl9DK11aNZPkdwQw==
X-Gm-Message-State: AOJu0YwL8d+pJFe4oDMwjEN598nEzREZpQcLRpBe/2yc5dZ29PNNRLTS
	uCeq4m59AJfc59bXvc9DbcqbI+USOEBtCtscnq4mqOnj4jDi6PE2hx3mF/l7MGJiN89YBoZiMA4
	XDL0DXnF8EpTh/mWA5vwP0Cg1hXZ/EW3U
X-Google-Smtp-Source: AGHT+IHL4Xp6Ooj5iBTZpOU9C02JjUT6srW4+kSCgeFpNRNnAeeZozZal+8OtwFsxCQJqYtt9Snc02of3tWOCY5C5o4=
X-Received: by 2002:a05:6a20:dd86:b0:1a3:4670:fbbf with SMTP id
 kw6-20020a056a20dd8600b001a34670fbbfmr15636738pzb.50.1710871809147; Tue, 19
 Mar 2024 11:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319055115.4063940-1-namhyung@kernel.org> <20240319055115.4063940-23-namhyung@kernel.org>
 <CAM9d7cjhuxB_iWPPWgFxK1_oBaYqF=MgthV=EBG0HeyJ9-ONXg@mail.gmail.com> <ZfnUUqWozFf55eyx@x1>
In-Reply-To: <ZfnUUqWozFf55eyx@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 19 Mar 2024 11:09:58 -0700
Message-ID: <CAM9d7ci1dqph=4genU7m+L85oHtVaXj4FR=aFZYNyuVtC1eAVg@mail.gmail.com>
Subject: Re: [PATCH 22/23] perf annotate-data: Add a cache for global variable types
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Mar 19, 2024 at 11:05:04AM -0700, Namhyung Kim wrote:
> > On Mon, Mar 18, 2024 at 10:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > They are often searched by many different places.  Let's add a cache
> > > for them to reduce the duplicate DWARF access.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/annotate-data.c | 107 ++++++++++++++++++++++++++++++=
+-
> > >  tools/perf/util/annotate-data.h |   7 +++
> > >  tools/perf/util/dso.c           |   2 +
> > >  tools/perf/util/dso.h           |   6 +-
> > >  4 files changed, 118 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annota=
te-data.c
> > > index 633fe125fcd8..4b3184b7c799 100644
> > > --- a/tools/perf/util/annotate-data.c
> > > +++ b/tools/perf/util/annotate-data.c
> > > @@ -433,6 +433,91 @@ static struct type_state_stack *findnew_stack_st=
ate(struct type_state *state,
> > >         return stack;
> > >  }
> > >
> > > +/* Maintain a cache for quick global variable lookup */
> > > +struct global_var_entry {
> > > +       struct rb_node node;
> > > +       char *name;
> > > +       u64 start;
> > > +       u64 end;
> > > +       u64 die_offset;
> > > +};
> > > +
> > > +static int global_var_cmp(const void *_key, const struct rb_node *no=
de)
> > > +{
> > > +       const u64 addr =3D (uintptr_t)_key;
> > > +       struct global_var_entry *gvar;
> > > +
> > > +       gvar =3D rb_entry(node, struct global_var_entry, node);
> > > +
> > > +       if (gvar->start <=3D addr && addr < gvar->end)
> > > +               return 0;
> > > +       return gvar->start > addr ? -1 : 1;
> > > +}
> > > +
> > > +static bool global_var_less(struct rb_node *node_a, const struct rb_=
node *node_b)
> > > +{
> > > +       struct global_var_entry *gvar_a, *gvar_b;
> > > +
> > > +       gvar_a =3D rb_entry(node_a, struct global_var_entry, node);
> > > +       gvar_b =3D rb_entry(node_b, struct global_var_entry, node);
> > > +
> > > +       return gvar_a->start < gvar_b->start;
> > > +}
> > > +
> > > +static struct global_var_entry *global_var__find(struct data_loc_inf=
o *dloc, u64 addr)
> > > +{
> > > +       struct dso *dso =3D map__dso(dloc->ms->map);
> > > +       struct rb_node *node;
> > > +
> > > +       node =3D rb_find((void *)addr, &dso->global_vars, global_var_=
cmp);
> >
> > It seems to cause a build error on 32-bit systems.  It needs one
> > more cast to suppress the "pointer cast w/ different size" warning.
> >
> >     node =3D rb_find(void *)(uintptr_tr)addr, ...);
>
> I can add that, to speed up the process, ok?

That would be great!

Thanks,
Namhyung

