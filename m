Return-Path: <linux-kernel+bounces-140411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644048A1409
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CE51C21C53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE3F14B071;
	Thu, 11 Apr 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="TdE0uGBy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934814AD35
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837506; cv=none; b=f4iPXbMs26In6G2scFTWFCDoRj7eYnGCqHLf4qfrtbK1F9RM3wV7yeZ9ZJt52RKlKLd/0fPiHXHac6t043ZgHx1fddpA7lNGTTcXdt7EuiSGiFcCI6XHil70C8ZioR7F3ln93TSCvskw5iRcSvXWOS5+PPyjf+LibxSlnCYCXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837506; c=relaxed/simple;
	bh=itSQk2b/qeERn9WLQJ1lpDYwPMRo4EGLiCJYs3ABnM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYzKw0nKcXcPlJ+7K87rdsV/SiBvJ4puSPnWhVDMJ8UoBZ7XHN70hOTwMf3LnSG0xM61zWxgfqQCW0IPepTLxy/mS3SMuTpVuOteY5p3IsPhVCvAwQ8yz4Yc2ae3EpUGwszKiyF32qmY4gqhTl+AMvpacfShF/w7xWwxnmdbPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=TdE0uGBy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso4933236a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1712837503; x=1713442303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucpZc0sOAIBf0HKCIhwEI0FsYmNzoD9YG5D9Q7DejMI=;
        b=TdE0uGByLu4vaXVla5g+rhIlo1ZpcPlP1q68tv+MGIqLpruVpHOk6GSUiLgY3oLvZk
         CMT/X73OoQ+FocBDWUD614dolJJSnaxifMTwaisaqUDRW+BH3NbHGIL5/VHoy73h2U7A
         1dd1mEprRI3ivF1rE+9hgdnwjcKfUweuol1LIyQMWxsVSCADeovL4qrvx8Fj2xSXDikn
         SKdnsAvi2qhYHGtKXs0DMkH85yI9STG5w0gY/Mvvavx5OxhhS9JZ62Yc0Q4XE5Krb4/6
         pzTMPff2Km+dBLoy/NWzHZ0TAYUVXucCdR36U4fV8tsMp+ZW2BsKY+i3bpvFv/dsGXY9
         jtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837503; x=1713442303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucpZc0sOAIBf0HKCIhwEI0FsYmNzoD9YG5D9Q7DejMI=;
        b=R3fkyySG7H4oavk7GMcgKV49wEkNN62Mekl9fYkIht9/fZuOMjhylwdp3y5LYQHM3I
         oHvqoSHqGL7Grb4S6eB7BDTMLqwAfId2KwD5NehE4Ew9rciTzvX61lEfoQroW3i7pABt
         dDKNDADmS37KYkRODt0ypEUOI4kcOkf9TvxuEHxQmF+CAf1Z6oYEaUvuwgW8r6+9M8MZ
         zH2ijpWTyqOKF1eH573j+aJhAKE5eWYg7zZOxya+03enGLkRoMUuH0PugHVG988xgbBt
         0awqfiWxGLWXq2ytYkm5YE2/huwL67PfSseHUQKgLCDgGp1c17ctyrIVtFNTN757U+H4
         JOsA==
X-Gm-Message-State: AOJu0YyGY5hjq2cNyNXIA6jQ7ljf+AyvZIY7S2rElFyAZ/Cy0pOTRfGh
	0BBdulFDn/I1JANXM/9u7AiM9pzjP7/Mk9NCBp1Lf3Osh/cmiMVlUyEvbV0p8XWJsbx/mwtFI57
	21MhylfGZEWws1iSLRvouebSpY49taNnsqS3I
X-Google-Smtp-Source: AGHT+IEm1nJ7qqYszNRR+8iGrnPF9c7cTgTJApzdsUPIBIcpnN/vB8gRio2LJbUzoSYF+OYsYhZgz6lqTXqURByJlXQ=
X-Received: by 2002:a50:9558:0:b0:56e:4ac1:88f with SMTP id
 v24-20020a509558000000b0056e4ac1088fmr3825888eda.27.1712837502837; Thu, 11
 Apr 2024 05:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com> <20240214173950.18570-2-khuey@kylehuey.com>
 <ZhYWPGX0RzamxOHx@gmail.com>
In-Reply-To: <ZhYWPGX0RzamxOHx@gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Thu, 11 Apr 2024 08:11:28 -0400
Message-ID: <CAP045AqQ0MbF2PAm9f5t=PnkJ4eOnwsNR624gEEjyLWEpTFz1g@mail.gmail.com>
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

On Wed, Apr 10, 2024 at 12:32=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Kyle Huey <me@kylehuey.com> wrote:
>
> > To ultimately allow bpf programs attached to perf events to completely
> > suppress all of the effects of a perf event overflow (rather than just =
the
> > sample output, as they do today), call bpf_overflow_handler() from
> > __perf_event_overflow() directly rather than modifying struct perf_even=
t's
> > overflow_handler. Return the bpf program's return value from
> > bpf_overflow_handler() so that __perf_event_overflow() knows how to
> > proceed. Remove the now unnecessary orig_overflow_handler from struct
> > perf_event.
> >
> > This patch is solely a refactoring and results in no behavior change.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Acked-by: Song Liu <song@kernel.org>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/perf_event.h |  6 +-----
> >  kernel/events/core.c       | 28 +++++++++++++++-------------
> >  2 files changed, 16 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index d2a15c0c6f8a..c7f54fd74d89 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -810,7 +810,6 @@ struct perf_event {
> >       perf_overflow_handler_t         overflow_handler;
> >       void                            *overflow_handler_context;
> >  #ifdef CONFIG_BPF_SYSCALL
> > -     perf_overflow_handler_t         orig_overflow_handler;
> >       struct bpf_prog                 *prog;
> >       u64                             bpf_cookie;
> >  #endif
>
> Could we reduce the #ifdeffery please?

Not easily.

> On distros CONFIG_BPF_SYSCALL is almost always enabled, so it's not like
> this truly saves anything on real systems.
>
> I'd suggest making the perf_event::prog and perf_event::bpf_cookie fields
> unconditional.

That's not sufficient. See below.

> > +#ifdef CONFIG_BPF_SYSCALL
> > +static int bpf_overflow_handler(struct perf_event *event,
> > +                             struct perf_sample_data *data,
> > +                             struct pt_regs *regs);
> > +#endif
>
> If the function definitions are misordered then first do a patch that mov=
es
> the function earlier in the file, instead of slapping a random prototype
> into a random place.

Ok.

> > -     READ_ONCE(event->overflow_handler)(event, data, regs);
> > +#ifdef CONFIG_BPF_SYSCALL
> > +     if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> > +#endif
> > +             READ_ONCE(event->overflow_handler)(event, data, regs);
>
> This #ifdef would go away too - on !CONFIG_BPF_SYSCALL event->prog should
> always be NULL.

bpf_overflow_handler() is also #ifdef CONFIG_BPF_SYSCALL. It uses
bpf_prog_active, so that would need to be moved out of the ifdef,
which would require moving the DEFINE_PER_CPU out of bpf/syscall.c ...
or I'd have to add a !CONFIG_BPF_SYSCALL definition of
bpf_overflow_handler() that only returns 1 and never actually gets
called because the condition short-circuits on event->prog. Neither
seems like it makes my patch or the code simpler, especially since
this weird ifdef-that-applies-only-to-the-condition goes away in Part
3 where I actually change the behavior.

It feels like the root of your objection is that CONFIG_BPF_SYSCALL
exists at all. I could remove it in a separate patch if there's
consensus about that.




> Please keep the #ifdeffery reduction and function-moving patches separate
> from these other changes.
>
> Thanks,
>
>         Ingo

- Kyle

