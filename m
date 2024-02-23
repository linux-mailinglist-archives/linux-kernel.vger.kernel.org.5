Return-Path: <linux-kernel+bounces-77599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3048607F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F87B20ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E0944D;
	Fri, 23 Feb 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbDzYsfJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062D29A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650112; cv=none; b=WVBOa93IX/U6OCZ7aA/kCtI8nRtdlCrGh28jSE0Zx+iqKudM6shDQhaZL/NGtFmpxNTf0HSfdLhoon1geCitEljqNdcb87DnV3VKekCrRhSo6dWy+teLre02PtcAOux+QjG6e9gmQ7s0y1x9iDCIK0IEr4RWZjGB+9Gp8/97NFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650112; c=relaxed/simple;
	bh=WwCcamfA1yyMH2zjwyI/WY8SVF/pqh3FqjFI8ZMOuVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1Q684/WoZUApZdqOogcU61DAok1+X1Jyby0YrS/BxWI7P3b1J3gHvPE91PM3BP8ETbuWdefNVkZPBSDjtozy3J+xEOLvueIeJNq/kYGrYi+J+jC1iRMfVZhkNpgy5+z52L8QVgPe9ytms9mGmaUCJ+CCUFjoFFsa1MgHoY5bO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbDzYsfJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso3201a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650108; x=1709254908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVdirAtuXCcwvmsp0Gpng+bWxyNVR71xIxmrFvk0pMg=;
        b=GbDzYsfJrrbqGgzwmP7fccojVKpwCq2dLsbgim6Yxzz4S4gNbvLu+iCg0rmvVTesh7
         yVHNByhOyXWT+AcIqBIYJbjR5IaynJUh+6wjA+3t9b5gEWKfk4Y6XhLhHW9FeEN+MAVC
         5JdLXahKsJnVA+6jaoATX/BCtTwYIlSGOdW1xo17QeXI9Av1CtxKe7pOiN8W0khTvBa/
         3sqzCm/PJHC5j2RqVqNvu37AcZSwgz8SaDLbfy9aTp804395Yq4SrmRXmRhirgdedlbb
         X2OMkmCJFVAtDZOIz6iV8hwGjEocQIUPKjPjIb1K1sgwExhIZq+XtMebnpOuJq/UwXc9
         +Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650108; x=1709254908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVdirAtuXCcwvmsp0Gpng+bWxyNVR71xIxmrFvk0pMg=;
        b=qzjm8rlOaBZec+uVnalpLizlXCCUGuYIqRf2j3r8XSWrh+oJhogiucF0DPBW2Jp+Su
         3lfZGcEyRDqkftLU/A1NnRdniw09DYZj8j96OY2cqEKd9NDFcvLm9aM5mGoL8aOKn5vJ
         U5GnbM/4D35EMvhOKChBfQ4h25iC2wPVA8qD4kh/V2Izbkk+1IyLm0c/K166adbzBB5w
         5opHUAQLgFvazLzdrfFOJc/UqSezVMObRrO3BS1uW7DP14eVQlWSVSKp0uJx7nklOVXv
         8BgfO1ypcUQVq4d0oy4RiG8TINK0sWz5/JvFyHGRViaouExy7DtdQlOulLRgK+nB6J6H
         LwXA==
X-Forwarded-Encrypted: i=1; AJvYcCXYdeZDpFlvYHVdjlY1pFx7TwdJcmnPG844EdJbo3PS+9TylEIOy/RURDL42oqrJ1DsmeIQBcBPG5hXvxDJF2ttz1Nt6AJDQR66Fu/K
X-Gm-Message-State: AOJu0Yy5UlyyPTWTIxXY6gcRpIHwfnJ4Cq0uw2hzdpR2H4/jPyPjjk7V
	V+HhB5CA97AZpXyVAilSijvNbAfd/lP5V3AKhr2QJjKW4quPdD+uGR3aNX4Fk2gWHOgjuG7f0g2
	1SypUJKV3L/MORbiSkEfTFErMcovQU5TlptfT
X-Google-Smtp-Source: AGHT+IFbrGgUabD7OnJN7jSaJJF1tCNRufKI+jKS4FM/exn6Cm17iOSpsSW5VATM3O9EC+LYBpIsdNWbPLw2Q0W47zE=
X-Received: by 2002:a50:a408:0:b0:565:123a:ccec with SMTP id
 u8-20020a50a408000000b00565123accecmr420084edb.3.1708650108312; Thu, 22 Feb
 2024 17:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZPJTT/l9fX1lhu6O@smile.fi.intel.com> <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com> <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com> <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
 <ZPWr3dRP5C1GSY9F@smile.fi.intel.com> <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
 <ZPWxbfHNOqAnkR09@smile.fi.intel.com> <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
 <ZdXzxY3-g7oY00Mq@smile.fi.intel.com>
In-Reply-To: <ZdXzxY3-g7oY00Mq@smile.fi.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 17:01:04 -0800
Message-ID: <CAGETcx92GgwBpd58dLgquLFxqXiHK5QHGK3Rhkd9pC_4p7Ra6w@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:59=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 20, 2024 at 05:46:27PM -0800, Saravana Kannan wrote:
> > On Mon, Sep 4, 2023 at 3:29=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Sep 04, 2023 at 12:12:44PM +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Sep 4, 2023 at 12:05=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Mon, Sep 04, 2023 at 11:47:54AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > On Mon, Sep 4, 2023 at 11:40=E2=80=AFAM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski=
 wrote:
> > > > > > > > On Mon, Sep 4, 2023 at 10:59=E2=80=AFAM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golasze=
wski wrote:
> > > > > > > > > > On Fri, Sep 1, 2023 at 11:10=E2=80=AFPM Andy Shevchenko
> > > > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Gol=
aszewski wrote:
>
> ...
>
> > > > > > > > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > > > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > > > > > > > +     /* Used by sysfs callbacks. */
> > > > > > > > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > > > > > > > >
> > > > > > > > > > > dev pointer of firmware node is solely for dev links.=
 Is it the case here?
> > > > > > > > > > > Seems to me you luckily abuse it.
> > > > > > > > > >
> > > > > > > > > > I don't think so. If anything we have a helper in the f=
orm of
> > > > > > > > > > get_dev_from_fwnode() but it takes reference to the dev=
ice while we
> > > > > > > > > > don't need it - we know it'll be there because we creat=
ed it.
> > > > > > > > > >
> > > > > > > > > > This information (struct device of the GPIO device) can=
 also be
> > > > > > > > > > retrieved by iterating over the device children of the =
top platform
> > > > > > > > > > device and comparing their fwnodes against the one we g=
ot passed down
> > > > > > > > > > from probe() but it's just so many extra steps.
> > > > > > > > > >
> > > > > > > > > > Or we can have a getter in gpio/driver.h for that but I=
 don't want to
> > > > > > > > > > expose another interface is we can simply use the fwnod=
e.
> > > > > > > > >
> >
> > Sorry for being late to the party.
>
> You decided to make a blast from the past due to the last patches from me=
? :-)

Yeah :) I meant to reply to this when you sent it, but was swamped and
forgot about it.

>
> > > > > > > > > dev pointer in the fwnode strictly speaking is optional. =
No-one, except
> > > > > > > > > its solely user, should rely on it (its presence and life=
time).
> > > > > > > >
> > > > > > > > Where is this documented? Because just by a quick glance in=
to
> > > > > > > > drivers/base/core.c I can tell that if a device has an fwno=
de then
> > > > > > > > fwnode->dev gets assigned when the device is created and cl=
eared when
> > > > > > > > it's removed (note: note even attached to driver, just
> > > > > > > > created/removed). Seems like pretty reliable behavior to me=
.
> > > > > > >
> > > > > > > Yes, and even that member in fwnode is a hack in my opinion. =
We should not mix
> > > > > > > layers and the idea in the future to get rid of the fwnode_ha=
ndle to be
> > > > > > > _embedded_ into struct device. It should be separate entity, =
and device
> > > > > > > instance may use it as a linked list. Currently we have a few=
 problems because
> > > > > > > of the this design mistake.
> > > > > >
> > > > > > I don't see how this would work if fwnodes can exist before str=
uct
> > > > > > device is even created.
> > > > >
> > > > > That's whole idea behind swnodes. They (ideally) should be create=
d _before_
> > > > > any other object they are being used with. This is how it works t=
oday.
> > > >
> > > > Yes, this is what I meant: if fwnodes can be created before struct
> > > > device (as it is now) and their life-time is separated then how cou=
ld
> > > > you possibly make the fwnode part of struct device?
> > > >
> > > > > And doing swnode->dev =3D ... contradicts a lot: layering, lifeti=
me objects, etc.
> >
> > I understand what you are trying to say about layering, but there are
> > no lifetime violations here.
>
> There is. Software node is not firmware node, their lifetime is the same =
or
> wider than the respective device (often, they are statically defined with=
out
> any device in mind).
>
> > > > No it doesn't. We have the software node - the template for the
> > > > device. It can only be populated with a single device entry.
> > >
> > > Which is wrong assumption. Software nodes (and firmware nodes) in gen=
eral
> > > can be shared. Which device pointer you want to add there?
> >
> > I don't think this is any harder to handle than how a device's
> > secondary fwnode is handled in set_primary_fwnode(). For secondary
> > fwnodes, you just WARN and overwrite it and move on.
>
> The whole concept of a single linked list with limitation to up to two
> nodes and being the part of the struct fwnode_handle itself appears to
> be problematic. We have a lot of tricks here and there instead of properl=
y
> having a list head in the struct device without any limitations in number
> of nodes with a priority based on the appearance in the list.
>
> For the details you may ask USB DWC3 developers and related to that.
>
> > > Which one should be next when one of the devices is gone?
> >
> > Similar to how set_primary_fwnode() handles deletion (NULL), you can
> > handle the same for when a device is removed. You can check the parent
> > or the bus for another device with the same fwnode and set it.
>
> > > No, simply no. Do not use it!
> >
> > Using fwnode_handle->dev is no different than searching a bus for a
> > device which has dev->fwnode match the fwnode you are looking for.
> >
> > In both cases, you are just going to get the first device that was
> > added. It's completely pointless to force searching a bus to find the
> > device with a specific fwnode.
> >
> > In the special cases where one fwnode has multiple devices, no generic
> > code is going to always handle the device search correctly. The
> > framework adding those devices probably knows what's the right thing
> > to do based on which of the N devices with the same fwnode they are
> > trying to find.
> >
> > I understand it's not great, but blindly saying "search the bus" isn't
> > really improving anything here and just makes things unnecessarily
> > inefficient.
>
> Is there any _good_ documentation for devlinks and all that fields in the
> struct fwnode? Why should we use that without any understanding of the
> purposes of that field. We, as device property developers, hadn't introdu=
ced
> that field and never required it. It's an alien to device properties APIs=
.

If I add some inline documentation for these fields, will you be more
open to letting people use this as a way to look up devices? I'm happy
to do that for you.

Thanks,
Saravana

