Return-Path: <linux-kernel+bounces-151850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C48AB4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE25B22AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8813B5A1;
	Fri, 19 Apr 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2HcSxa5"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9F130AC4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549912; cv=none; b=glGkTFwSykQI8isCqRc5qODD610mXM1hIOj4Lp43Gl9R3juc7TDDdXTfzkLHnV8AAz+TFYyVBrswTQ68UOx43JnDLUTGDaEZ9otfGq3vzeziq/Bp/qS4Vy4ADSUU0pA/wOvhV7xPEV+PA1dqqSxJozD8fZXW9JCBHAmidi53Oeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549912; c=relaxed/simple;
	bh=F4cNOrYwM4Aq4Iiy4jYOyWYoKlDnc4rZFnYqfqmTWJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHMmeL/1n9InM0VnYiOCGXVYG8iw+v2ltNnZ5EMZMXoSmiwME36MtjHRvF96a+rKzycitqSzYFUS5lzgGHKfF+h5ovuQ+UgYCztBaDHqT0o9tNlXWvmgHYGNcMdUyQyf7EayB4wuA+AuE3S4DESXM0dKibEJdVhisUvwbJ8WgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2HcSxa5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so2172a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713549909; x=1714154709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmgSdIOaBGzF1wIJwZyCqHKWiUO1epUovMBrXDSKd70=;
        b=d2HcSxa5F65+eScAfEpAhoKksIvRGfuZBpJXIMiBC+K8a1+k0S+cqd8ygzEmehsf4n
         ZASPZIwM0OIrSYlcj1htbfPP8tq0S48Ne/V+lVdca2+OYl12fRNDVyCJJ6Id9+Jr9Mn+
         mC2FZDTP9LxUpjTz7PqGFcDIVbWHSC/VjQ6a889ixUFByjOEw4xt+ZzjWiTAZMV4MBCz
         Vy4c5kzHexzU4EEy2IB6YStLSmGO5DHkripX3mxg6vok+Wzn6Mb1lzEVfF6fGrIwHzz/
         EFkOQkmiLwau4BTUcjXYHMmuG+HVLdUYDeFIvyg89EumIaEZbCpGYfL8ezqXe0ypG92P
         1C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549909; x=1714154709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmgSdIOaBGzF1wIJwZyCqHKWiUO1epUovMBrXDSKd70=;
        b=HX5S3acHJgo9NQlw87E9Ugza/yis6V/MJst2bj3/1H/9xTSM+DaivZdYc/40kZewT7
         XkNOvhCzzGiioqgVhulTcov0QGvCDZElRzyHORiPLK68s4JI3RWRZieun0oD/85XPz5g
         A6HTAjTEdwJCw0kxJOaq3KUeozyYE8HynAqgCbDkZy6//RYV417VAhz97DyGL4C4wakh
         vvApqgnrwTGXU1YIzl95Cshfb1Tqj8Y0HUg7ETUGOB8En5QIsrLRMCyi8Akeyblk9l5z
         nWUHqxg1a7YEryJvfp4If9Pf5wC9JUeAss4kH8wDlQuaSNiHLdzEUL9Et10XMAkLTXis
         QY/g==
X-Forwarded-Encrypted: i=1; AJvYcCWoCiFDLjocaNzrAkdNos3GIGqfaXTzF6jKhyoDIqeEK8auCQrYD4mjNhLmI9KFal83N+y7T+aueMFpRJ2ItWNIlrDacymCWURClvuI
X-Gm-Message-State: AOJu0YzjsySScS/HtR/LpsX/EKNgkKdVl6ou8chveZN5DNPzTWOMo6ZC
	uv2Az8wirXUn672VhDxv9ceHKml5dpPdOe8r4O9peX5yyu07BTwKHmMFeBpUTfC5j27XBuL/x8+
	9kJxqB3xU/O8YiBrslxiAVHMvRRxvU7xpD0pK
X-Google-Smtp-Source: AGHT+IFiJwIF8NBICxhoTwIgH3tKMxmE/Jfl8ucbO0D4wydmlmbZBia7J/vwSPgO/y44rmwz5zaGNM//OJRSzziGxyg=
X-Received: by 2002:a50:fc08:0:b0:571:b9c7:2804 with SMTP id
 i8-20020a50fc08000000b00571b9c72804mr5894edr.5.1713549908902; Fri, 19 Apr
 2024 11:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118181954.1415197-1-zokeefe@google.com> <20240417111001.fa2eg5gp6t2wiwco@quack3>
 <CAAa6QmSOum_0ZhyUq1ppguLp0jpEs0u1U843GkF==xMwaMGV4A@mail.gmail.com> <20240418110434.g5bx5ntp2m4433eo@quack3>
In-Reply-To: <20240418110434.g5bx5ntp2m4433eo@quack3>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 19 Apr 2024 11:04:31 -0700
Message-ID: <CAAa6QmS-PwoR7QGr5f-yUrMsnszb=q8+wpjKrYzsv0OsgdP4jw@mail.gmail.com>
Subject: Re: [PATCH] mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Maxim Patlasov <MPatlasov@parallels.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 4:04=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 17-04-24 12:33:39, Zach O'Keefe wrote:
> > On Wed, Apr 17, 2024 at 4:10=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > > index cd4e4ae77c40a..02147b61712bc 100644
> > > > --- a/mm/page-writeback.c
> > > > +++ b/mm/page-writeback.c
> > > > @@ -1638,7 +1638,7 @@ static inline void wb_dirty_limits(struct dir=
ty_throttle_control *dtc)
> > > >        */
> > > >       dtc->wb_thresh =3D __wb_calc_thresh(dtc);
> > > >       dtc->wb_bg_thresh =3D dtc->thresh ?
> > > > -             div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->th=
resh) : 0;
> > > > +             div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thres=
h) : 0;
> ...
> > > Thirdly, if thresholds are larger than 1<<32 pages, then dirty balanc=
ing is
> > > going to blow up in many other spectacular ways - consider only the
> > > multiplication on this line - it will not necessarily fit into u64 an=
ymore.
> > > The whole dirty limiting code is interspersed with assumptions that l=
imits
> > > are actually within u32 and we do our calculations in unsigned longs =
to
> > > avoid worrying about overflows (with occasional typing to u64 to make=
 it
> > > more interesting because people expected those entities to overflow 3=
2 bits
> > > even on 32-bit archs). Which is lame I agree but so far people don't =
seem
> > > to be setting limits to 16TB or more. And I'm not really worried abou=
t
> > > security here since this is global-root-only tunable and that has muc=
h
> > > better ways to DoS the system.
> > >
> > > So overall I'm all for cleaning up this code but in a sensible way pl=
ease.
> > > E.g. for these overflow issues at least do it one function at a time =
so
> > > that we can sensibly review it.
> > >
> > > Andrew, can you please revert this patch until we have a better fix? =
So far
> > > it does more harm than good... Thanks!
> >
> > Shall we just roll-forward with a suitable fix? I think all the
> > original code actually "needed" was to cast the ternary predicate,
> > like:
> >
> > ---8<---
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index fba324e1a010..ca1bfc0c9bdd 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -1637,8 +1637,8 @@ static inline void wb_dirty_limits(struct
> > dirty_throttle_control *dtc)
> >          *   at some rate <=3D (write_bw / 2) for bringing down wb_dirt=
y.
> >          */
> >         dtc->wb_thresh =3D __wb_calc_thresh(dtc);
> > -       dtc->wb_bg_thresh =3D dtc->thresh ?
> > -               div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh)=
 : 0;
> > +       dtc->wb_bg_thresh =3D (u32)dtc->thresh ?
> > +               div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thre=
sh) : 0;
>
> Well, this would fix the division by 0 but when you read the code you
> really start wondering what's going on :) [..]

Ya, this was definitely a local fix in an area of code I know very
little abit. I stumbled across it in a rather contrived way -- made
easier by internal patches -- and felt its existence still warranted a
local fix.

> [..] And as I wrote above when
> thresholds pass UINT_MAX, the dirty limitting code breaks down anyway so =
I
> don't think the machine will be more usable after your fix. Would you be =
up
> for a challenge to modify mm/page-writeback.c so that such huge limits
> cannot be set instead? That would be actually a useful fix...

:) I can't say my schedule affords me much time to take on any
significant unplanned work. Perhaps as a Friday afternoon exercise
I'll come back to scope this out, driven by some sense of
responsibility garnered from starting down this path ; but ... my TODO
list is long.

Have a great rest of your day / weekend,
Zach

>                                                                 Honza
>
> >
> >         /*
> >          * In order to avoid the stacked BDI deadlock we need
> > ---8<---
> >
> > Thanks, and apologize for the inconvenience
> >
> > Zach
> >
> > >                                                                 Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

