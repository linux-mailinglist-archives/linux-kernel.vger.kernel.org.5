Return-Path: <linux-kernel+bounces-74416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D956385D3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A251C2235A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D933D0DA;
	Wed, 21 Feb 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VRrAG5jz"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067033D38E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508058; cv=none; b=f411lKeQDd2PMdTHLr64yNtDmz5lJEniMlhe5V6R9iTDx60RnigxwSUSB6Lg7jYJ1MpSGaw0yN4Z1xGkCSK8rd2zODdCYgUl3i2nYrPxeBQxwU6kEbrn3yaK/FcEq04UwIwlhfNNuwGGbQ4LLQEbjwT8dDMfELU5u0Ai+zhPW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508058; c=relaxed/simple;
	bh=s9Xdj47z241ebdldl2LEE4WRvzWSsprOa0nwjY4SQKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mugn9/cdK1UT9690gBv3S9+d+6BlA/tnxloRsJUfqjuu2GtlsqXgR6H16JLL1n7ciPB7sg16AAt45DAUaE2wNPNke64kUk8Qw/hpZuqR1YPcDc/x58g7Id7g3jCJr5kkzWz6cFSQ4eRxXIYfaabpdDYKikzWiKbce6zA1LsOUAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VRrAG5jz; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c7c5ea58acso573343e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708508056; x=1709112856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUQzuNSpvAHZAkbJV7vuuzKawy3SshhIEJCuEXtwJJs=;
        b=VRrAG5jzGaOFfhAmm+lYdjnobCopFJC6cMJjlgJH7A22IszrOG0TmJRLhzIM/fEki6
         K9ujwH/CKfGGE4/YK0yIbck26xVkk12CkWdq3NamtcT4ONJ3DlH9srtgXnhAKW9Z8xUD
         UrX+L/B8vXNfFCP1orvWCAtAe3+PGjFlmRT7Nj+BsNsdimiXc4EVxOnxsXMB8dUOeTqm
         t/+GXJ0FIJrwXnGmQMVWfUI4Xi7JtrQ335ZibcAGwYRxQjtiNU1kqR8AL4CPm8sv0JJy
         r4bc12F30kyPkCKbyfl/MMYIMOHKrAHYlmlI9LqkW8lk6xCbvr+daupaWItcz/tqTMF7
         Or+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508056; x=1709112856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUQzuNSpvAHZAkbJV7vuuzKawy3SshhIEJCuEXtwJJs=;
        b=BAmzr6xuKp5Jgxqw108D0q4Z+2HLlj3kT7KBf+sVKwA0n2nVWMrfURr1qgj2WjO8LA
         nWde/3twExlmeIQ8P9/UDVDIbkDnRN7Yk1P2rbiJE0zJy21VTeRssFlnOoFZT5TP2kGa
         EKSs6IkLIcZMB8EPjW+4NrdvtbroPGiZOYrFn5KPsCw6hNRnrWCbLLa7RnTfBhuj7Xv8
         X7K79mBzog1byYXu6QoLNQIP9CwEargRv85hew/r5D/iNQLI8+E5A7aTEsfOr4HAjygu
         Rk3fru0MxscKP6h7/S8xn9woBgS8AJgCiHj6MSRaQg58HCHWd4X73SGxmiR3b54P16sa
         SIKA==
X-Forwarded-Encrypted: i=1; AJvYcCUR1KkNdF6aIKhDKrdp4oQBZLbOPtOHo5HaogT2Wa3qHejY9p0NNwHgfIfLu/14Xhw/EXas8ymsr2SBHv4vNngl36rkwW41ANk5Hedw
X-Gm-Message-State: AOJu0YxiVK8H0YOJvBIyuai1jm1xXbbT6n88Wp2dCadDDhX8D6jyHK8P
	g2kqK6HACxFbSoiLJgA198QVC5jCcuH57jW8RkORIn65Gf4873UY6TsYcXtPvPDUEgXm1bvmJH9
	90pVftKuagDNzzO/SlrndnVS1UTBAeOfGcg9pow==
X-Google-Smtp-Source: AGHT+IFDpkqz8w/wFwZZ1cXovCfniRVC/FS0s4CKKdJyP7MidrETpVlVLioXGD9qWjpEYr6G2g9FR61LMOXhUaWncFM=
X-Received: by 2002:a1f:4c84:0:b0:4c0:3116:e909 with SMTP id
 z126-20020a1f4c84000000b004c03116e909mr14379475vka.7.1708508055448; Wed, 21
 Feb 2024 01:34:15 -0800 (PST)
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
 <ZPWxbfHNOqAnkR09@smile.fi.intel.com> <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
In-Reply-To: <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Feb 2024 10:34:04 +0100
Message-ID: <CAMRc=Mfsw9MGCxnZO+zWfcsFoeA6XHCpZ95eS7-vK4cvwJt-9Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
To: Saravana Kannan <saravanak@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:47=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Sep 4, 2023 at 3:29=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Sep 04, 2023 at 12:12:44PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 4, 2023 at 12:05=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Sep 04, 2023 at 11:47:54AM +0200, Bartosz Golaszewski wrote=
:
> > > > > On Mon, Sep 4, 2023 at 11:40=E2=80=AFAM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski w=
rote:
> > > > > > > On Mon, Sep 4, 2023 at 10:59=E2=80=AFAM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszews=
ki wrote:
> > > > > > > > > On Fri, Sep 1, 2023 at 11:10=E2=80=AFPM Andy Shevchenko
> > > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golas=
zewski wrote:
> >
> > ...
> >
> > > > > > > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > > > > > > +     /* Used by sysfs callbacks. */
> > > > > > > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > > > > > > >
> > > > > > > > > > dev pointer of firmware node is solely for dev links. I=
s it the case here?
> > > > > > > > > > Seems to me you luckily abuse it.
> > > > > > > > >
> > > > > > > > > I don't think so. If anything we have a helper in the for=
m of
> > > > > > > > > get_dev_from_fwnode() but it takes reference to the devic=
e while we
> > > > > > > > > don't need it - we know it'll be there because we created=
 it.
> > > > > > > > >
> > > > > > > > > This information (struct device of the GPIO device) can a=
lso be
> > > > > > > > > retrieved by iterating over the device children of the to=
p platform
> > > > > > > > > device and comparing their fwnodes against the one we got=
 passed down
> > > > > > > > > from probe() but it's just so many extra steps.
> > > > > > > > >
> > > > > > > > > Or we can have a getter in gpio/driver.h for that but I d=
on't want to
> > > > > > > > > expose another interface is we can simply use the fwnode.
> > > > > > > >
>
> Sorry for being late to the party.
>
> > > > > > > > dev pointer in the fwnode strictly speaking is optional. No=
-one, except
> > > > > > > > its solely user, should rely on it (its presence and lifeti=
me).
> > > > > > >
> > > > > > > Where is this documented? Because just by a quick glance into
> > > > > > > drivers/base/core.c I can tell that if a device has an fwnode=
 then
> > > > > > > fwnode->dev gets assigned when the device is created and clea=
red when
> > > > > > > it's removed (note: note even attached to driver, just
> > > > > > > created/removed). Seems like pretty reliable behavior to me.
> > > > > >
> > > > > > Yes, and even that member in fwnode is a hack in my opinion. We=
 should not mix
> > > > > > layers and the idea in the future to get rid of the fwnode_hand=
le to be
> > > > > > _embedded_ into struct device. It should be separate entity, an=
d device
> > > > > > instance may use it as a linked list. Currently we have a few p=
roblems because
> > > > > > of the this design mistake.
> > > > >
> > > > > I don't see how this would work if fwnodes can exist before struc=
t
> > > > > device is even created.
> > > >
> > > > That's whole idea behind swnodes. They (ideally) should be created =
_before_
> > > > any other object they are being used with. This is how it works tod=
ay.
> > >
> > > Yes, this is what I meant: if fwnodes can be created before struct
> > > device (as it is now) and their life-time is separated then how could
> > > you possibly make the fwnode part of struct device?
> > >
> > > > And doing swnode->dev =3D ... contradicts a lot: layering, lifetime=
 objects, etc.
>
> I understand what you are trying to say about layering, but there are
> no lifetime violations here.
>
> > >
> > > No it doesn't. We have the software node - the template for the
> > > device. It can only be populated with a single device entry.
> >
> > Which is wrong assumption. Software nodes (and firmware nodes) in gener=
al
> > can be shared. Which device pointer you want to add there?
>
> I don't think this is any harder to handle than how a device's
> secondary fwnode is handled in set_primary_fwnode(). For secondary
> fwnodes, you just WARN and overwrite it and move on.
>
> > Which one
> > should be next when one of the devices is gone?
>
> Similar to how set_primary_fwnode() handles deletion (NULL), you can
> handle the same for when a device is removed. You can check the parent
> or the bus for another device with the same fwnode and set it.
>
> > No, simply no. Do not use it!
>
> Using fwnode_handle->dev is no different than searching a bus for a
> device which has dev->fwnode match the fwnode you are looking for.
>
> In both cases, you are just going to get the first device that was
> added. It's completely pointless to force searching a bus to find the
> device with a specific fwnode.
>
> In the special cases where one fwnode has multiple devices, no generic
> code is going to always handle the device search correctly. The
> framework adding those devices probably knows what's the right thing
> to do based on which of the N devices with the same fwnode they are
> trying to find.
>
> I understand it's not great, but blindly saying "search the bus" isn't
> really improving anything here and just makes things unnecessarily
> inefficient.
>
> -Saravana

Thanks for the input. I've since moved to using device_find_child()
but will keep it in mind for the future.

Bart

>
> >
> > > Once it's done, I don't see why you wouldn't want to assign this devi=
ce to
> > > its corresponding software node. Provided locking is in place etc.
> > >
> > > > > They - after all - represent the actual
> > > > > physical device hierarchy which may or may not be populated at
> > > > > run-time depending on many factors.
> > > >
> > > > No. This is a mistaken assumption.
> > >
> > > How so?
> >
> > See above.
> >
> > > > > Once populated, being able to retrieve the software representatio=
n of
> > > > > the device (struct device) from the node from which it was popula=
ted
> > > > > sounds like a reasonable thing to do. What are those problems and=
 are
> > > > > they even linked to this issue?
> > > > >
> > > > > > The get_dev_from_fwnode() is used only in devlink and I want to=
 keep it that way.
> > > > > > Nobody else should use it, really.
> > > > >
> > > > > I don't care all that much, I can get the device from the childre=
n of
> > > > > the platform device. Still comparing fwnodes, though this time th=
e
> > > > > other way around.
> > > >
> > > > Fine, but do not use dev pointer from fwnode, esp. software node.
> > >
> > > I will do it but I'd like to clarify the above at some point.
> >
> > The relationship between device instance(s) and firmware node instance(=
s)
> > is m:n, where each of them can be from 0 to ... x or y.
> >
> > There is no unique mapping between two.

