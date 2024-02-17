Return-Path: <linux-kernel+bounces-69689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDCB858D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC472837FB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD51F1C691;
	Sat, 17 Feb 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8wvOj6h"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886781BF20
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708146728; cv=none; b=j9nAw5RUaoPUssqrioxWmz4bOZ7n0LqgmjJiYyyBBIbEG4ponJ/gqE1qobgSm1usyHoSX4ROZXn0jOhQSd6ijYHkR56Zdfm8Ki5edzqiO7B60zejs4P6mf8JewifxqzJCElSXQ49lnTPyBiu0BxKKjw8byX0pqQRlHGnmZuMQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708146728; c=relaxed/simple;
	bh=URADTGIosTS7P4+eX3FuMOADYYBCiUGgTyTh++46QLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNi/pxTmOAaQNs1FjMy0hwJ4uxrQG03GJVQQfJTTY0PtvTm0FQCZDYSrVHK4G3xqNZYMRI1UOynv7kHzaRJ12oOYWoZUDYVXYefZJSm/qfqSjuqvxEZAJpYAtJ/Mujd5usQ1XVVN5sZTSwHN6S0SoLTYNTVoSScnQySqueaDK8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8wvOj6h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4120933b710so18265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708146724; x=1708751524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K70lgBcu7tk1H4/muC53496J1GXspshhrMHKi80019s=;
        b=A8wvOj6hc1SwV5FXH9orI1/pbxphNErgeT9AI8gv575Rd4FnsvqEy/40Jg0mlCHSW1
         ObfRrQo780hQLjAmZR9eb+NVLtVG8XRDZEcD5bN5zXkRKczvYdzt84SDOydKx4T/cw7M
         jfsG0xeEST0yRnUCd/e+XLlpPyNaC5OeywoR60d635E4fN8cgqRjw9eF+zdx2Hmu8Pue
         6KwfHfcANSC1lBgmwr2VLlOzVum+Cqd06LQJdmGNMC484+8hCvDLvmyohTdMR6G8cwdt
         sYoYZi3p460VFGFTzL3Cww6RtPNn/IxZEK/CSw2azXk2H4mOssaZ+P9KfZO6MGn3QvYs
         xgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708146724; x=1708751524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K70lgBcu7tk1H4/muC53496J1GXspshhrMHKi80019s=;
        b=voi1yT1nscSt8RCyRglpPVUJwtbvIaRnZqQeO22ADyDIRR4A7dcxraTiTNCYpDTnyF
         unKKytwfwhOM9gqAOlKlCd/hUCY4/pobJ14eD2CjHPVE6kejDTEAzngoPe2YY7W2G6hR
         yUIdePHLMOcO4guQGsUdMW/tKyS6FodqX45RVWP1NE+u0xNWmmGN09uUgbepqUeXCgcI
         RFhdAUaUg6+LWEsw+mxSi/y0priXK2vWubzRNjUWLzmLGlKQqDE30OzwLi8ia1oTJk0G
         3V+EXuZx7ajJaeh+AgAv+DFGSXW7NKDcSNID901JwuipieoOxMTYVhPD00cHIHysstOP
         Eslw==
X-Forwarded-Encrypted: i=1; AJvYcCXREXnoA0ramcBwbIAb/aLzAj0fTMX1z/qKNVeU2WqRvt2xqI9vMW2QwmPPCyRCCtWN7gwXSDQgCnZPPx2D4znc8h18kMYjp6PDTuT4
X-Gm-Message-State: AOJu0YzTXkjAohwUoZtJ/m5xRERDWSZa3u2SOnBqcSBSb8BN6RMotZuC
	u83EbTQBr0AM/bX5KjUx+M/duMXop5q5U58SElfQdfmTFrqgonENTt3qJ6o0WymKBdQVv83hq00
	7f2mD2qcBVBV+F4ab8u96UqNElKxWnxfi8PfP
X-Google-Smtp-Source: AGHT+IHJdbdFpifcl1UxAGM4ZsFIq+6YMU1UQp37BMHZQeazrv3ssuETT8xCek0PnCH/RB8r5jwu2AXXnwsisbeqkMg=
X-Received: by 2002:a05:600c:3493:b0:411:f6b6:faf5 with SMTP id
 a19-20020a05600c349300b00411f6b6faf5mr91584wmq.3.1708146723521; Fri, 16 Feb
 2024 21:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208061825.36640-1-byungchul@sk.com> <CAOUHufYUC-oWePfqbbmm15Ue9QLfPg1G2nhXn6iSX_A460O6Uw@mail.gmail.com>
 <20240216072434.GC32626@system.software.com>
In-Reply-To: <20240216072434.GC32626@system.software.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 17 Feb 2024 00:11:25 -0500
Message-ID: <CAOUHufbGQ_ZFLhVSPG78pbMtvcfZ5v-E3oRdfZDP2mtHtkrPVg@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: Don't turn on cache_trim_mode at the highest
 scan priority
To: Byungchul Park <byungchul@sk.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:24=E2=80=AFAM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Fri, Feb 16, 2024 at 12:55:17AM -0500, Yu Zhao wrote:
> > On Thu, Feb 8, 2024 at 1:18=E2=80=AFAM Byungchul Park <byungchul@sk.com=
> wrote:
> > >
> > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > > pages. However, it should be more careful to turn on the mode because
> > > it's going to prevent anon pages from reclaimed even if there are hug=
e
> > > ammount of anon pages that are very cold so should be reclaimed. Even
> > > worse, that can lead kswapd_failures to be MAX_RECLAIM_RETRIES and st=
op
> > > until direct reclaim eventually works to resume kswapd.
> >
> > Is a theory or something observed in the real world? If it's the
> > former, would this change risk breaking existing use cases? It's the
>
> I faced the latter case.
>
> > latter, where are the performance numbers to show what it looks like
> > before and after this patch?

Let me ask again: where are the performance numbers to show what it
looks like before and after this patch?

> Before:
>
> Whenever the system meets the condition to turn on cache_trim_mode but
> few cache pages to trim, kswapd fails without scanning anon pages that
> are plenty and cold for sure and it retries 8 times and looks *stopped
> for ever*.
>
> After:
>
> When the system meets the condition to turn on cache_trim_mode but few
> cache pages to trim, kswapd finally works at the highest scan priority.
> So kswap looks working well even in the same condition.

These are not performance numbers -- what test cases can prove what's
described here?

> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  mm/vmscan.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index bba207f41b14..25b55fdc0d41 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2268,7 +2268,8 @@ static void prepare_scan_control(pg_data_t *pgd=
at, struct scan_control *sc)
> > >          * anonymous pages.
> > >          */
> > >         file =3D lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > > -       if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE=
_FILE))
> > > +       if (sc->priority !=3D 1 && file >> sc->priority &
> >
> > Why 1?
>
> It means the highest scan priority. The priority goes from DEF_PRIORITY
> to 1.

This is not true -- sc->priority can go all the way to zero.

>         Byungchul
>
> > > +           !(sc->may_deactivate & DEACTIVATE_FILE))
> > >                 sc->cache_trim_mode =3D 1;
> > >         else
> > >                 sc->cache_trim_mode =3D 0;

