Return-Path: <linux-kernel+bounces-73913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B785CD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C333285506
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A446BF;
	Wed, 21 Feb 2024 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbXmoQFN"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F8723C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480026; cv=none; b=Gv43kTkjEBrHLkactY+lcX+T0Pw+CAiKgjp+6KzEnpe1FElrmPMAA91EuHfwFiJdMMSt5XP999YNftNqy2slSaB3X5aKRbu1hkQmmswryBVdAJY+rAWA7f3WOlRE+QBsAxylBbJUTNOK42z6pIeRWJ2shAvNHRaXRdFgdw/kOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480026; c=relaxed/simple;
	bh=iUEglDd0IusnsHYdDg0SbXUSjK8oaW8VjqNhWNenHi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGqqPOHQlZHim4PwVLrgSIxKL5BTAY0A5vkTCGnkX/a4XjRZ3RtBThvdkiKOV6+5biZabHVM5RYlekLQJSdU8eQF1hgg9jXSfga7jY+SNWRAK7QyQiGGtqY8gZbYN7OqZSwTSflIXEZb4K2bGLdvQo8zAt3RJZkRvNTV1nliIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbXmoQFN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e2507c6e1so72721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708480023; x=1709084823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMzkgKLHF3yCOXDrFqm4rm+9bW0f0+sEV83/usFGaoc=;
        b=cbXmoQFNUipOs2V5lqNhhahs/M3t7apGXw/JpDXF1/qQOh2zG05MZT63HGj3v0eQS+
         OH4jSIrhhC9MzDh+7BymiPc8zdWJhb+9TvcAAA4r8ka681MNBBr5M5KEUC9P/87yTrzu
         kGea3iaWhNnwv0gL7+iSH7zWEigMwXiidzZHIL8AS4XuXpOW1pad0IOoMQP9u/9Rs/8G
         tkYSos5yaf+mOcXe0RKY2YLZhAGEkm4bLPfXOT1kIXnB+aK3inJs/EGqnsl0MVYl1k2B
         PgVZOubBgZ3yHGR3GVNlOgS7lbXbU/sRxPU7SilKAT0LQJtraaXjphPk7a3guRAjxuDj
         Ss+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480023; x=1709084823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMzkgKLHF3yCOXDrFqm4rm+9bW0f0+sEV83/usFGaoc=;
        b=XqDUwR/v0fjKGPMzfchFm6kcqfDcpTtLq51JMYpqwUVb7Fxo9S6MsyyWcCsgLLGvfR
         QyUahd8kwaA7wqIyDjBhhUQdr3LN5HrDe49w81vsTjBXa3QeOyaT8jYvKlVCOAD9v/Un
         aYNhkqLIhLRnbsgSrAXucO6UjOLywGrEDTWqLVJ8UF1+QLVwDPfkWE+P6RrhCqYrEj/i
         Qf0hUhPhCrZi5hhkkaf4ALqEpBkMoBGFNFrj0CdvzqX7UAzAocc2K368JDt4IXzCmNbz
         BJTOp9HyezYIlo3IToJc6077qsTPNF7CZbrARjJADjsgVn1HXs631AfpIwEzgmVzVyZd
         1chw==
X-Forwarded-Encrypted: i=1; AJvYcCV1pwomlmtG7PLUBDyNzCCalZc9/oOpW35DptR+7MJkqOZbfKuDSZEP4G077AgDhBB74mblH6S0vgwsBF3dP2a8SHZRMmXxxynE7zsB
X-Gm-Message-State: AOJu0YxJfW8oalvSpgdM9OPj9fftRG0I+Vl0rZ74Xla20RlYdZr+u76d
	9i9IKIF3XqF3oG61ZSSgLbcrA/0sA+kOG8qbc1YFK5qZeg9o7xlDMzALopRhLahFwp8u9V0g7K5
	SeFjZP49Vs8WisP8UX2OBR6FwYnE4hahBvF+Z
X-Google-Smtp-Source: AGHT+IGJDM0SJLzYNC7YRvw8M4u1KIXektOQ+aav00QS8YrONP0N83zrf2dUgYknTBFMt3qpmkG7ZMukLFbh7yilv+M=
X-Received: by 2002:ac8:5c16:0:b0:42d:ff6e:12c9 with SMTP id
 i22-20020ac85c16000000b0042dff6e12c9mr160959qti.4.1708480023254; Tue, 20 Feb
 2024 17:47:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901183240.102701-1-brgl@bgdev.pl> <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com> <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com> <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
 <ZPWr3dRP5C1GSY9F@smile.fi.intel.com> <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
 <ZPWxbfHNOqAnkR09@smile.fi.intel.com>
In-Reply-To: <ZPWxbfHNOqAnkR09@smile.fi.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 17:46:27 -0800
Message-ID: <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 4, 2023 at 3:29=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 04, 2023 at 12:12:44PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 4, 2023 at 12:05=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Sep 04, 2023 at 11:47:54AM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Sep 4, 2023 at 11:40=E2=80=AFAM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > On Mon, Sep 4, 2023 at 10:59=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski=
 wrote:
> > > > > > > > On Fri, Sep 1, 2023 at 11:10=E2=80=AFPM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golasze=
wski wrote:
>
> ...
>
> > > > > > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > > > > > +     /* Used by sysfs callbacks. */
> > > > > > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > > > > > >
> > > > > > > > > dev pointer of firmware node is solely for dev links. Is =
it the case here?
> > > > > > > > > Seems to me you luckily abuse it.
> > > > > > > >
> > > > > > > > I don't think so. If anything we have a helper in the form =
of
> > > > > > > > get_dev_from_fwnode() but it takes reference to the device =
while we
> > > > > > > > don't need it - we know it'll be there because we created i=
t.
> > > > > > > >
> > > > > > > > This information (struct device of the GPIO device) can als=
o be
> > > > > > > > retrieved by iterating over the device children of the top =
platform
> > > > > > > > device and comparing their fwnodes against the one we got p=
assed down
> > > > > > > > from probe() but it's just so many extra steps.
> > > > > > > >
> > > > > > > > Or we can have a getter in gpio/driver.h for that but I don=
't want to
> > > > > > > > expose another interface is we can simply use the fwnode.
> > > > > > >

Sorry for being late to the party.

> > > > > > > dev pointer in the fwnode strictly speaking is optional. No-o=
ne, except
> > > > > > > its solely user, should rely on it (its presence and lifetime=
).
> > > > > >
> > > > > > Where is this documented? Because just by a quick glance into
> > > > > > drivers/base/core.c I can tell that if a device has an fwnode t=
hen
> > > > > > fwnode->dev gets assigned when the device is created and cleare=
d when
> > > > > > it's removed (note: note even attached to driver, just
> > > > > > created/removed). Seems like pretty reliable behavior to me.
> > > > >
> > > > > Yes, and even that member in fwnode is a hack in my opinion. We s=
hould not mix
> > > > > layers and the idea in the future to get rid of the fwnode_handle=
 to be
> > > > > _embedded_ into struct device. It should be separate entity, and =
device
> > > > > instance may use it as a linked list. Currently we have a few pro=
blems because
> > > > > of the this design mistake.
> > > >
> > > > I don't see how this would work if fwnodes can exist before struct
> > > > device is even created.
> > >
> > > That's whole idea behind swnodes. They (ideally) should be created _b=
efore_
> > > any other object they are being used with. This is how it works today=
.
> >
> > Yes, this is what I meant: if fwnodes can be created before struct
> > device (as it is now) and their life-time is separated then how could
> > you possibly make the fwnode part of struct device?
> >
> > > And doing swnode->dev =3D ... contradicts a lot: layering, lifetime o=
bjects, etc.

I understand what you are trying to say about layering, but there are
no lifetime violations here.

> >
> > No it doesn't. We have the software node - the template for the
> > device. It can only be populated with a single device entry.
>
> Which is wrong assumption. Software nodes (and firmware nodes) in general
> can be shared. Which device pointer you want to add there?

I don't think this is any harder to handle than how a device's
secondary fwnode is handled in set_primary_fwnode(). For secondary
fwnodes, you just WARN and overwrite it and move on.

> Which one
> should be next when one of the devices is gone?

Similar to how set_primary_fwnode() handles deletion (NULL), you can
handle the same for when a device is removed. You can check the parent
or the bus for another device with the same fwnode and set it.

> No, simply no. Do not use it!

Using fwnode_handle->dev is no different than searching a bus for a
device which has dev->fwnode match the fwnode you are looking for.

In both cases, you are just going to get the first device that was
added. It's completely pointless to force searching a bus to find the
device with a specific fwnode.

In the special cases where one fwnode has multiple devices, no generic
code is going to always handle the device search correctly. The
framework adding those devices probably knows what's the right thing
to do based on which of the N devices with the same fwnode they are
trying to find.

I understand it's not great, but blindly saying "search the bus" isn't
really improving anything here and just makes things unnecessarily
inefficient.

-Saravana

>
> > Once it's done, I don't see why you wouldn't want to assign this device=
 to
> > its corresponding software node. Provided locking is in place etc.
> >
> > > > They - after all - represent the actual
> > > > physical device hierarchy which may or may not be populated at
> > > > run-time depending on many factors.
> > >
> > > No. This is a mistaken assumption.
> >
> > How so?
>
> See above.
>
> > > > Once populated, being able to retrieve the software representation =
of
> > > > the device (struct device) from the node from which it was populate=
d
> > > > sounds like a reasonable thing to do. What are those problems and a=
re
> > > > they even linked to this issue?
> > > >
> > > > > The get_dev_from_fwnode() is used only in devlink and I want to k=
eep it that way.
> > > > > Nobody else should use it, really.
> > > >
> > > > I don't care all that much, I can get the device from the children =
of
> > > > the platform device. Still comparing fwnodes, though this time the
> > > > other way around.
> > >
> > > Fine, but do not use dev pointer from fwnode, esp. software node.
> >
> > I will do it but I'd like to clarify the above at some point.
>
> The relationship between device instance(s) and firmware node instance(s)
> is m:n, where each of them can be from 0 to ... x or y.
>
> There is no unique mapping between two.

