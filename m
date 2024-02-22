Return-Path: <linux-kernel+bounces-77546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B1860720
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C51284897
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB213BAE4;
	Thu, 22 Feb 2024 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G9chThIT"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB5182A3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645917; cv=none; b=m27aeh7KjwnNUYwhzy9KqDmXNK1yxMzBQv4wL15R0oX+ZaPIEpJ1cFjJywnxZdP6V00ZamMRI9Wv8ipr/mv2g2zYck80PwcGQxcJ2PGXddWwOeCYpIV/jPpzFUoivq1wBN2KDIKoeJ7M2Hwxs3pd+72+4EM/eUycpd8WLv29i4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645917; c=relaxed/simple;
	bh=/wHGiiuPEih+Dl1DSbuFdBlrYyz4M3oticJERwW5nCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwOaPFsGI8AZ/J2unCGUaVDbF5nBLmFKMvY2rTW8HaH39ErXlEvAgHm7Gu84kdRCz2EPqsE39/ASFh3elDyJWXXZRk6M4HdzI3R4+VVHqtyWZO46dFHagmPRbnfUfh3ZzDfpn7mOjSIcAP2bbed+NCh97IKIb2P/EvAiPn0MQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G9chThIT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42e0b1b11bbso31441cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708645914; x=1709250714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVOy0PwhnBKY+4KzN/4pkuX8/YBWUL2pDvveZN+SjoI=;
        b=G9chThIT/Y2Zg923Jah7ISL6MTQfKSPHIGS8WAAUu88KKfuzKlhnLIPWfU5/9v3Loi
         BOqhKkpyiZnhd6xS2TMndq4d3v91WQ1DoWQh0JXtyxAj5KJnxSWD2AT7Lu1AT1l1lxyf
         KY0gd5CzFSJi1+z1KQP9jtYlPGdH+5f2d8AKq9UEYK7HQbaRgPPd9IQ86XwdrlheHK26
         Vmob9eB7uYNU3+qzycA6xKOCYGRFK9C032/MHfG0WZj+tBaR00a3vontxCNKqhq9SRx6
         rqSTWslXF8Kj6LLebRwkH/Qet1CJlcrKt4A1f6XC6cn6bfF1Avr10R08T+EBDsMKcAEc
         aeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708645914; x=1709250714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVOy0PwhnBKY+4KzN/4pkuX8/YBWUL2pDvveZN+SjoI=;
        b=oTUNn91m8irAGHPL2F1/2p3euIMPR20MawzjRuQSK8hOFlblDd0g+wJjPl9PT3u1yi
         mTtTS69S10hWwmybaEBzoYaDthVMGZdap92U40PoMN2KpzL6YbKUD4iYOVlJdEcYtuQq
         Rp6dkvMqIF/kHyYPVppJ7rJ1FqnVEh7+X3QG0WBDy6lNFMjcLwWKtohY5MkFoU23Iry+
         SKVspTtG+BRr3cYDsHl7IHY3KEI04GGyDiqIwomW7Br04Rp7KyXjg+jW5P9vj1H/ynC/
         dQfD4qn8S6ZnkJDJBQCmU5NarMuQInK+Mv+Jmg/dQbz/GYg97bL34WoyzFhXsNj9DHbz
         gNQA==
X-Forwarded-Encrypted: i=1; AJvYcCVW3xYw8gCG+/UD9FJiFs0xz5lmEo4c5ZY1t2riIpFCcu0IYAq243PvWCCMrE6GXrogLz8RNJ4ltBbFC/RgUcaIVOCvDqdgAVJuCx13
X-Gm-Message-State: AOJu0YxRYVWBIkhl1Acy5E+i1tIQBm2PY0CJnGDd3b8epr6Y90FqevSq
	gll6BCX9LBgNhm2e4HabKnjBolAnSiIXseg9MrdvkV/721TwiOr5SfRBxC8JWbhyVVDArT8y8NW
	KEYYTkQW77ZRWX/mbYMOxbKW5mj/zRapQFfb5
X-Google-Smtp-Source: AGHT+IGSx9IqL62y1LNBY7s+dmpCEtqTu2O+jgsJsFv46ojLa1Dsip1JzYkOGamsGRfmVVJM30+X6ptu5wefZ3VTfAA=
X-Received: by 2002:a05:622a:181d:b0:42e:377e:8c07 with SMTP id
 t29-20020a05622a181d00b0042e377e8c07mr854859qtc.11.1708645914096; Thu, 22 Feb
 2024 15:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com> <20240220142959.GA244726@rigel>
 <20240222005744.GA3603@rigel> <20240222010530.GA11949@rigel>
 <CAMRc=MdCm4UXMkzvG17Vd=6ajE+feihgYc66qUNTTKXhN0--dA@mail.gmail.com>
 <20240222123615.2cbada98@bootlin.com> <CAMRc=McTkVPD-1_5vvPcM2Q15=w+ocki2xTmvQzU-o395A930w@mail.gmail.com>
In-Reply-To: <CAMRc=McTkVPD-1_5vvPcM2Q15=w+ocki2xTmvQzU-o395A930w@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 15:51:15 -0800
Message-ID: <CAGETcx_j4613QjHgX5AJ96Ux6MJSxxhT7DL36yzNv1JCsoxTAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip device
 is removed
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Herve Codina <herve.codina@bootlin.com>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:21=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Feb 22, 2024 at 12:36=E2=80=AFPM Herve Codina <herve.codina@bootl=
in.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Thu, 22 Feb 2024 00:31:08 -0800
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > > On Thu, 22 Feb 2024 02:05:30 +0100, Kent Gibson <warthog618@gmail.com=
> said:
> > > > On Thu, Feb 22, 2024 at 08:57:44AM +0800, Kent Gibson wrote:
> > > >> On Tue, Feb 20, 2024 at 10:29:59PM +0800, Kent Gibson wrote:
> > > >> > On Tue, Feb 20, 2024 at 12:10:18PM +0100, Herve Codina wrote:
> > > >>
> > > >> ...
> > > >>
> > > >> > >  }
> > > >> > >
> > > >> > > +static int linereq_unregistered_notify(struct notifier_block =
*nb,
> > > >> > > +                                     unsigned long action, vo=
id *data)
> > > >> > > +{
> > > >> > > +      struct linereq *lr =3D container_of(nb, struct linereq,
> > > >> > > +                                        device_unregistered_n=
b);
> > > >> > > +      int i;
> > > >> > > +
> > > >> > > +      for (i =3D 0; i < lr->num_lines; i++) {
> > > >> > > +              if (lr->lines[i].desc)
> > > >> > > +                      edge_detector_stop(&lr->lines[i]);
> > > >> > > +      }
> > > >> > > +
> > > >> >
> > > >> > Firstly, the re-ordering in the previous patch creates a race,
> > > >> > as the NULLing of the gdev->chip serves to numb the cdev ioctls,=
 so
> > > >> > there is now a window between the notifier being called and that=
 numbing,
> > > >> > during which userspace may call linereq_set_config() and re-requ=
est
> > > >> > the irq.
> > > >> >
> > > >> > There is also a race here with linereq_set_config().  That can b=
e prevented
> > > >> > by holding the lr->config_mutex - assuming the notifier is not b=
eing called
> > > >> > from atomic context.
> > > >> >
> > > >>
> > > >> It occurs to me that the fixed reordering in patch 1 would place
> > > >> the notifier call AFTER the NULLing of the ioctls, so there will n=
o longer
> > > >> be any chance of a race with linereq_set_config() - so holding the
> > > >> config_mutex semaphore is not necessary.
> > > >>
> > > >
> > > > NULLing -> numbing
> > > >
> > > > The gdev->chip is NULLed, so the ioctls are numbed.
> > > > And I need to let the coffee soak in before sending.
> > > >
> > > >> In which case this patch is fine - it is only patch 1 that require=
s
> > > >> updating.
> > > >>
> > > >> Cheers,
> > > >> Kent.
> > > >
> > >
> > > The fix for the user-space issue may be more-or-less correct but the =
problem is
> > > deeper and this won't fix it for in-kernel users.
> > >
> > > Herve: please consider the following DT snippet:
> > >
> > >       gpio0 {
> > >               compatible =3D "foo";
> > >
> > >               gpio-controller;
> > >               #gpio-cells =3D <2>;
> > >               interrupt-controller;
> > >               #interrupt-cells =3D <1>;
> > >               ngpios =3D <8>;
> > >       };
> > >
> > >       consumer {
> > >               compatible =3D "bar";
> > >
> > >               interrupts-extended =3D <&gpio0 0>;
> > >       };
> > >
> > > If you unbind the "gpio0" device after the consumer requested the int=
errupt,
> > > you'll get the same splat. And device links will not help you here (o=
n that
> > > note: Saravana: is there anything we could do about it? Have you even
> > > considered making the irqchip subsystem use the driver model in any w=
ay? Is it
> > > even feasible?).

I did add support to irqchip to use the driver model. See
IRQCHIP_PLATFORM_DRIVER_BEGIN() and uses of it.  So this makes sure
the probe ordering is correct.

But when I added that support, there was some pushback on making the
modules removable[1]. But that's why you'll see that the
IRQCHIP_PLATFORM_DRIVER_BEGIN() macro set .suppress_bind_attrs =3D true.

Do you have a way to unregister an interrupt controller in your
example? If so, how do you unregister it? It shouldn't be too hard to
extend those macros to add removal support. We could add a
IRQCHIP_MATCH2() that also takes in an exit() function op that gets
called on device unbind.

[1] - https://lore.kernel.org/lkml/86sghas7so.wl-maz@kernel.org/#t

> > >
> > > I would prefer this to be fixed at a lower lever than the GPIOLIB cha=
racter
> > > device.
> >
> > I think this use case is covered.
> > When the consumer device related to the consumer DT node is added, a
> > consumer/supplier relationship is created:
> > parse_interrupts() parses the 'interrups-extended' property
> >   https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/property.=
c#L1316
> > and so, of_link_to_phandle() creates the consumer/supplier link.
> >   https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/of/property.=
c#L1316
> >
> > We that link present, if the supplier is removed, the consumer is remov=
ed
> > before.
> > The consumer should release the interrupt during its remove process (i.=
e
> > explicit in its .remove() or explicit because of a devm_*() call).
> >
> > At least, it is my understanding.
>
> Well, then it doesn't work, because I literally just tried it before
> sending my previous email.

For your gpio0 device, can you see why __device_release_driver()
doesn't end up calling device_links_unbind_consumers()?

Also, can you look at
/sys/class/devlink/<bus:gpio0-devicename>--<consumer device name>
folders and see what the status file says before you try to unbind the
gpio0 device? It should say "active".

> Please try it yourself, you'll see.
>
> Also: an interrupt controller may not even have a device consuming its
> DT node (see IRQCHIP_DECLARE()), what happens then?

Yeah, we are screwed in those cases. Ideally we are rejecting all
submissions for irqchip drivers that use IRQCHIP_DECLARE().

-Saravana

