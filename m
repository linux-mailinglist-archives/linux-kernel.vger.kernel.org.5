Return-Path: <linux-kernel+bounces-111384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D13886B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016621C22050
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3513FB94;
	Fri, 22 Mar 2024 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ur8jCYAx"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE493FB1F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108363; cv=none; b=TwRjbD2OBeHOi2DGwxngaNWt24lrtP2xw0ztsd5uxe6j1nxoI7UyQox6rmcM6G/Ma3jfVsAQD2f7b/080o1hXQDxstk+BtUfH89uXMP6z+ujTSxq56N/V65mY6IuTeUpyYM+f7gxMmkTrECWUklugMEZgAKbGFPrxgP/gyrjfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108363; c=relaxed/simple;
	bh=x+a9e6Frx0VlBb4fwtx3sGzeXPW2PGanVCb6UGSYC30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ72p3EetPj8IYerLajKa0h1BKOoDcyJbB0OLZySQAIuTWfdkc+ouilP7GmnX5zt+QAtRRQjug/Qtz5LO1G896G17EIJU4KvdhzMRqiRsikKoySrkKTwmZRMb712dNm9GSgfNah6V3Bcu5exXqV+XUHfTs6GOj2AvBW768LnwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ur8jCYAx; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so33904701fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711108360; x=1711713160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVWFUDwpLHRWKDYEaq1Gc8i1EAEVOWiexCNmJxdcxRk=;
        b=ur8jCYAx2yLsvFWywcV8HOlgN7UrRzXgONknLA60UdcW1j6X3pkVAK9rt96aOVQHIk
         EowLG+h1vT/ysD77+Ale4zyHM6NCeEtPdq6Oyl49TmyD7TdkDsg3dTEcrHNa6S3Z8sWd
         7w+VfoNG4N7AbOAAiSaNwH0uwazh1fGQJycwLhV5RZ0fMDORjAZ8BNk5ZV3yO2Akv+sL
         tlwInav+rH1WY6Q8tzuZMhopPRZGiJwghgR09as5xH5lAsj4auONK0uFRRMKoKn+yUKl
         WOkomPl7gTjf92SuDFh9XYZ6tcImsWCqZYb7u7aSH4RvdRpUTftIapD0MxWs8S8EZ7ak
         COMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711108360; x=1711713160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVWFUDwpLHRWKDYEaq1Gc8i1EAEVOWiexCNmJxdcxRk=;
        b=F/SamgICVFt3nLBofg2qfQx8dXAP5al7TuDmBevEWJ1v4ICBxVY4VKGFzP1B9VKTHM
         6BFSywBJWmo9lqn5bmSvX3t2i+vngJHwdkQSA5dg3/APtY3A3NxWbi0yHyv6DocO7xm1
         n2YjtMuAvssVQAk+CXqKD9KdMxhSEzBZh8uEyDO13eiuzQykj2323tAgrxoIwrK1VbHZ
         yLtpvbUvsqmDeXFqCpC0hDqR3R7LasfXl6/VzGIX+MCqqKdtB8rL2bM0aI/BzJqtBsF5
         pPBIwhv3vkRJT3s7fCouTUgKLyrxvwHuSCY+cz1d83IX/YZsDEaPLPoXunD+6to2W3Tv
         5AVg==
X-Forwarded-Encrypted: i=1; AJvYcCVyGtl6kFJxEyAFmgiDuXsQ3KMPW+GgoJtz2sSCuNySmGBllOe0pUEnzVFTZASZYZZ6RWLvm3UD3m/An36ybEtBQR8OhXXJAwXk+Nq+
X-Gm-Message-State: AOJu0Yydxx+IJsqXg990dwuAKRfJudVCa2+qCc0Z0KDT5VgUo+U+9GHz
	0wRhikzgTlBCeFydfDN1wd4EmYHZaQGQT5uj93Pf34sP3VKbsyRTcyVzrw2Ew9ebPRHwLy4r7ea
	yTx5NOYxXvvJv/CKLgOi+DRbm5fAn9TFEhMeXmQ==
X-Google-Smtp-Source: AGHT+IF/QBC/XHMCsVWI52LV3ij5tlkUWiGM7xOVip6HJdc4V/iuOPS3esn/2MrMi3SBgwp8I6jTFKtKxXphgBDt0MI=
X-Received: by 2002:a2e:9056:0:b0:2d4:76d6:e9c9 with SMTP id
 n22-20020a2e9056000000b002d476d6e9c9mr1542931ljg.52.1711108360010; Fri, 22
 Mar 2024 04:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322090209.13384-1-brgl@bgdev.pl> <20240322111835.GA24228@rigel>
In-Reply-To: <20240322111835.GA24228@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Mar 2024 12:52:29 +0100
Message-ID: <CAMRc=Md87eGmjehSEegdFCdv6D3H1p2On153JowY5cDnW9iw8Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: cdev: sanitize the label before requesting the interrupt
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:18=E2=80=AFPM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Fri, Mar 22, 2024 at 10:02:08AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > @@ -2198,12 +2216,18 @@ static int lineevent_create(struct gpio_device =
*gdev, void __user *ip)
> >       if (ret)
> >               goto out_free_le;
> >
> > +     label =3D make_irq_label(le->label);
> > +     if (!label) {
> > +             ret =3D -ENOMEM;
> > +             goto out_free_le;
> > +     }
> > +
> >       /* Request a thread to read the events */
> >       ret =3D request_threaded_irq(irq,
> >                                  lineevent_irq_handler,
> >                                  lineevent_irq_thread,
> >                                  irqflags,
> > -                                le->label,
> > +                                label,
> >                                  le);
> >       if (ret)
> >               goto out_free_le;
>
> Leaks label if the request_threaded_irq() fails.
>

Ah, dammit, I didn't catch the fact that irq_free() will not return
the label address if the request failed.

Nice catch.

Bart

