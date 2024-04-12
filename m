Return-Path: <linux-kernel+bounces-141777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672B88A2358
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD3D1C21907
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC591524C;
	Fri, 12 Apr 2024 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="OwHBLEZs"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673FDDAA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886445; cv=none; b=TZ5eN8XiyRO3sMWFf8ZgE5Z72wPL4Ni5q4xjz4xgZOhe2blh9bpN6rOSHZ1vHtBNVfJxacosFBY9rIbh85wJwKzYbfk1ybuKPIIomkTTK/Z67QUVc5RcQPBhLujJ7G5bxgS8UZTdDizm+XbxtQgdA1JyZgM6RNc41IlcWstxDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886445; c=relaxed/simple;
	bh=g9UjYOg9Kyh9GD+IongtakgGXRYTohWmsMgeLoWdgio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrXkE3+365+fUGYklefeB40ni9qkvdoN1HjpHnok3S8WS6q9lgE+l5ArKru5aZCLA5u5uQm4xXAec85mT7CtG0oGXeA4EStTbboEAO+EJJ3jy0lC1W9kpqOM6oi06KLPWs7SKtnTHdNPUbf3TIAK6q8VwbCBbF9hRCsDPSpok2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=OwHBLEZs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so617866a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712886441; x=1713491241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osjArfM964ZMCs2J7V2IvF4mEAZbgUY8xcLmh6ewJ6U=;
        b=OwHBLEZsAmCbf+jjjyfuW/6e4iXuFZyG4li8l/B93Yq0slqchDM/vf+CnRCbDoWTWQ
         Vt+bom7BBWloadEtUpWjOgb8spu8yNcbeIbnF62ALUEv+IQ6EBzIikE0cPttEvrN4K7c
         Vg29PDyaj3j4fDL55HXh2B6zDnr0wbQbd41e5iSloLO8t+Q0LUz5sCU8hagICFGTHeLb
         rfKVxQufPxtA3NYg8WElB39Cv+H3dOfxXiQGZpNEvWPM2quf20JihTiEhUiVQaVKBwNl
         cDKzA+i5NCwInXtoF6LYc+zBdhMZOXSwDW2a3q6PTuaeXLImiDAqk1IXe5CnTRYVPigR
         5hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712886441; x=1713491241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osjArfM964ZMCs2J7V2IvF4mEAZbgUY8xcLmh6ewJ6U=;
        b=qW3smtnc0Gx9loFrrAkJ2QJRR8TB/sAM5u3IJi/3u6RkU3tFPlL48cOQ7cGtB/g5lZ
         1PdxHnJLniegAsDgJ9/j88PTrj8rHzTao8dy09UTUgHLTZQcQc2bWwx3hLHi7OA0bKgf
         N4ngZZ5xRuQq9gZXi7schN9DOzbJS+UDDGE4dR8GzZioVoTtL7YBKTByvfG1rhbuKsYE
         wNSf2ALWegNlt4fRufFBXYZCAhzV6FsfE7xRxrP+Fgb4TvlVMB2DxagAUG+92HhmhPnX
         ykxULaMtQ6YxVTmRCjZxYfpdMH2w/mj6wP3HPvl01fYa+Ttgz5OtdVths1kfQyOpyWsZ
         6N5A==
X-Gm-Message-State: AOJu0YykhAsjL1eafDC79KHXFSjElcoRRWf5PXNst0JgWJvIcU+zU3rG
	axtCQCpNcoDVwfxcjEgkjdURrWrk3ILTFfjvqnKOnPap41D0UXa7VTfIaVhRcndvMafcRVZXbGU
	2oq2gm0eyV1CJpAPYT1D1VTzLhaFwKFBJTjXdsFtgAhTcYBQcog==
X-Google-Smtp-Source: AGHT+IG8i6DYHsQL51qUvlr37BR6pKSs1BXU1eUuAH2rPkS1Bv1IWQy08sQtUUrN0aKi/bNVqzgwZL5NlVG9Tsn4PC0=
X-Received: by 2002:a50:ab5a:0:b0:56e:3172:20dd with SMTP id
 t26-20020a50ab5a000000b0056e317220ddmr1096208edc.27.1712886441445; Thu, 11
 Apr 2024 18:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com> <20240214173950.18570-2-khuey@kylehuey.com>
 <ZhYWPGX0RzamxOHx@gmail.com> <CAP045AqQ0MbF2PAm9f5t=PnkJ4eOnwsNR624gEEjyLWEpTFz1g@mail.gmail.com>
In-Reply-To: <CAP045AqQ0MbF2PAm9f5t=PnkJ4eOnwsNR624gEEjyLWEpTFz1g@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 11 Apr 2024 21:47:09 -0400
Message-ID: <CAP045Apm6e07tZWp8OOQeCYD_MGNz1fbfuFWx1w9Rt4DVqRfrQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 1/4] perf/bpf: Call bpf handler directly, not
 through overflow machinery
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Robert O'Callahan" <robert@ocallahan.org>, Song Liu <song@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:11=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> On Wed, Apr 10, 2024 at 12:32=E2=80=AFAM Ingo Molnar <mingo@kernel.org> w=
rote:
> >
> >
> > * Kyle Huey <me@kylehuey.com> wrote:
> >
> > > To ultimately allow bpf programs attached to perf events to completel=
y
> > > suppress all of the effects of a perf event overflow (rather than jus=
t the
> > > sample output, as they do today), call bpf_overflow_handler() from
> > > __perf_event_overflow() directly rather than modifying struct perf_ev=
ent's
> > > overflow_handler. Return the bpf program's return value from
> > > bpf_overflow_handler() so that __perf_event_overflow() knows how to
> > > proceed. Remove the now unnecessary orig_overflow_handler from struct
> > > perf_event.
> > >
> > > This patch is solely a refactoring and results in no behavior change.
> > >
> > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Acked-by: Song Liu <song@kernel.org>
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/perf_event.h |  6 +-----
> > >  kernel/events/core.c       | 28 +++++++++++++++-------------
> > >  2 files changed, 16 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index d2a15c0c6f8a..c7f54fd74d89 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -810,7 +810,6 @@ struct perf_event {
> > >       perf_overflow_handler_t         overflow_handler;
> > >       void                            *overflow_handler_context;
> > >  #ifdef CONFIG_BPF_SYSCALL
> > > -     perf_overflow_handler_t         orig_overflow_handler;
> > >       struct bpf_prog                 *prog;
> > >       u64                             bpf_cookie;
> > >  #endif
> >
> > Could we reduce the #ifdeffery please?
>
> Not easily.
>
> > On distros CONFIG_BPF_SYSCALL is almost always enabled, so it's not lik=
e
> > this truly saves anything on real systems.
> >
> > I'd suggest making the perf_event::prog and perf_event::bpf_cookie fiel=
ds
> > unconditional.
>
> That's not sufficient. See below.
>
> > > +#ifdef CONFIG_BPF_SYSCALL
> > > +static int bpf_overflow_handler(struct perf_event *event,
> > > +                             struct perf_sample_data *data,
> > > +                             struct pt_regs *regs);
> > > +#endif
> >
> > If the function definitions are misordered then first do a patch that m=
oves
> > the function earlier in the file, instead of slapping a random prototyp=
e
> > into a random place.
>
> Ok.
>
> > > -     READ_ONCE(event->overflow_handler)(event, data, regs);
> > > +#ifdef CONFIG_BPF_SYSCALL
> > > +     if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> > > +#endif
> > > +             READ_ONCE(event->overflow_handler)(event, data, regs);
> >
> > This #ifdef would go away too - on !CONFIG_BPF_SYSCALL event->prog shou=
ld
> > always be NULL.
>
> bpf_overflow_handler() is also #ifdef CONFIG_BPF_SYSCALL. It uses
> bpf_prog_active, so that would need to be moved out of the ifdef,
> which would require moving the DEFINE_PER_CPU out of bpf/syscall.c ...
> or I'd have to add a !CONFIG_BPF_SYSCALL definition of
> bpf_overflow_handler() that only returns 1 and never actually gets
> called because the condition short-circuits on event->prog. Neither
> seems like it makes my patch or the code simpler, especially since
> this weird ifdef-that-applies-only-to-the-condition goes away in Part
> 3 where I actually change the behavior.

After fiddling with this I think the stub definition of
bpf_overflow_handler() is fine. The other CONFIG_BPF_SYSCALL functions
in this file already have similar stubs. I'll send a new patch set.

- Kyle

> It feels like the root of your objection is that CONFIG_BPF_SYSCALL
> exists at all. I could remove it in a separate patch if there's
> consensus about that.
>
>
>
>
> > Please keep the #ifdeffery reduction and function-moving patches separa=
te
> > from these other changes.
> >
> > Thanks,
> >
> >         Ingo
>
> - Kyle

