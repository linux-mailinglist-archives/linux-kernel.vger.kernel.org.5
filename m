Return-Path: <linux-kernel+bounces-151994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D478AB720
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D151C20D47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DB13D294;
	Fri, 19 Apr 2024 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I72Toh/B"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710B13D250
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564890; cv=none; b=iJ//osDTLALwy5qGEkJ1GpFV+J0L0HEvB6WAz9SrkxdI0y1rnd+goMxHM73GQkbq+BciXrfdtPgkgydq54fVokpjdzNn1BlC0oF31EGoBBV62WKLC9x7InbXfTK9mYTsTM3fCP4W9+q+9g5sImBVZmyO4YfMZ5Hnm2JigO+3jIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564890; c=relaxed/simple;
	bh=rvuzjRzSkyxRF2iNeXMy1pRg2zH+eva/o8+UMG/qlIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxSGSW19eQuhtlVhw8WpPEwxOBx75LA4dWhGD3fsaIB8a+5WM9Hcw8xJz4Nb5PELZhS8ktuGgx1W5hL99CkvhFsejAteuPjgoP5hMKIvoQhOXbgEWJsrHFPlWwnDXxySYeGbr7vCSGX7z2H8DaPMzqQylIL6TZwGEbnfibtiEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I72Toh/B; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-696609f5cf2so14565606d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713564888; x=1714169688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6gH6XCg5jIlnRMmDrx2Di9LcjiK/49bY7DTwVZH5Us=;
        b=I72Toh/Bv5q28LAfQJFs9TrfvMzoT1dw4Mku+A+9rmxoHFWT7iUlOk5YUJxKYhGd67
         3dvvap4MyL61kuFqyoPQpDis7KbM+1p9gxsVSkcdrm1y71/rUv1UtTMLxxuVa9ZgG6uC
         hfSh68vKF0r8T0dYChXpVlWR5zmpG7Q25Kj4FPwyT0ZN2EjjoNSifF42wEuAknDpqWdE
         910UroTfC6X9gAfKrRqjmVAzbMkq5D5/TywEiP74xNkLkIQrgoZR5bfYxkSApaPIM0za
         q8f9XcBHeRFAbcv93anSIrKGErIwitzTQh8FRNsaJfYrXHk038rWzHSwlWKLrS0BaCBb
         E1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564888; x=1714169688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6gH6XCg5jIlnRMmDrx2Di9LcjiK/49bY7DTwVZH5Us=;
        b=UlRPSA7txGwU9KCJv0XSnnLHxuDzSGKpfxlqItPk/f2gu6eaIBpNFmikm7pK/qFQlr
         dvguJu0YS37oTSWTjVF7+6HXUHBTfazo69qc19dgyCRsNSlmSUyZehOyyd2xkA3z1yAf
         ENbBDmBtG5XCwxtcIKTKY+QzZOLD5oP923N4pFyenA584eLQeMWkFO6AlxIn4iWzsB0l
         n95jKyJYo2ouIx+zaP/KRZJekgMDapgAJDEJKOSLVrbVsIKgbGihwC1jWAqXTuKxg+Fd
         31aNL1bsoYXGbPxGzvpJ/+UlKQQbZMHhhmBwSB4uSmRVtswoANi3wCGurEIZhhFaLVsK
         m8tg==
X-Forwarded-Encrypted: i=1; AJvYcCXo+lwOLYfk2m2PliiLrZ2e08S6CvDcGCo2ozMemPRtfTQp+fv59lvcvyhWR1hRJfQU0uZEJ0i+yck4d3KDZ2UDj5JlkyS0s6bB2zOc
X-Gm-Message-State: AOJu0Yxy3YZeIfWmpDf2r0eTEblUjk2/Zo+hpX0cZSfUOfN3V/95RcTJ
	+Vz55B4c76s0NJE6k3plOdS1II76SJVp7mIHCUuQrbIqVcn2TucI/NxDLXra3Vk8FixZ3nwsdgx
	pwi7H74H603RoiFGIBGDDVmgJaKUvg3xeTe6b
X-Google-Smtp-Source: AGHT+IEJb118AnyH+IevWpP8ieDaJ3zOxvlDGJ+ue1Yu9AmuXk6CyrQ4osZTMiz0UibRY5dmfssTzDpYs57t5wU2or0=
X-Received: by 2002:a0c:e113:0:b0:69b:1be3:e773 with SMTP id
 w19-20020a0ce113000000b0069b1be3e773mr4168322qvk.5.1713564887745; Fri, 19 Apr
 2024 15:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418042706.1261473-1-maheshb@google.com> <20240418185524.18801983@kernel.org>
In-Reply-To: <20240418185524.18801983@kernel.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Fri, 19 Apr 2024 15:14:19 -0700
Message-ID: <CAF2d9jhrC0uywa3NJLqgXGKauTEkGhK4A0YWorw4BV-fa5hbmg@mail.gmail.com>
Subject: Re: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally in
 mono-raw base.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 17 Apr 2024 21:27:06 -0700 Mahesh Bandewar wrote:
> > --- a/include/uapi/linux/ptp_clock.h
> > +++ b/include/uapi/linux/ptp_clock.h
> > @@ -157,7 +157,12 @@ struct ptp_sys_offset {
> >
> >  struct ptp_sys_offset_extended {
> >       unsigned int n_samples; /* Desired number of measurements. */
> > -     unsigned int rsv[3];    /* Reserved for future use. */
> > +     /* The original implementation provided timestamps (always) in
> > +      * REALTIME clock-base. Since CLOCK_REALTIME is 0, adding
> > +      * clockid doesn't break backward compatibility.
> > +      */
> > +     clockid_t clockid;      /* One of the supported clock-ids */
> > +     unsigned int rsv[2];    /* Reserved for future use. */
>
> This suffers from a moderate inability to build:
>
> usr/include/linux/ptp_clock.h:164:2: error: unknown type name 'clockid_t'
>   164 |         clockid_t clockid;      /* One of the supported clock-ids=
 */
>       |         ^
Hmm, my bad, it didn't fail while I was testing/building. I should
watch the bot checks more carefully :(
I'll fix it in the next revision.
> --
> pw-bot: cr

