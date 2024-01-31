Return-Path: <linux-kernel+bounces-46979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738884475D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1801C2101E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155A18B00;
	Wed, 31 Jan 2024 18:42:07 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1559020DE8;
	Wed, 31 Jan 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726526; cv=none; b=Ae+VCbWeHMSoaW34xRjyCHJYztBjm8ssEzo+UjRmQ7SOcKUvZQv07XJeXgM4ng2lQGEH91kufzjyM9wObL4R+F3cnquPlf4gH+G6+FnZmM5PiLIj9sbyEyBMwLKtelrH3+3usBxByERqrMBk/1nSr6tRpJLmw5uxVj1Hx7ZGW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726526; c=relaxed/simple;
	bh=LySeV0x9gTWQ9PyXJK3eEnKnNOh6iCuIqoGD9UGdHhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmgn6hiT+l1ROLZ0Yg9LQPjx8GzdVEYKasrSyWBicuN0GCHHjNbXRntfAJ+l2Iw/1t82odE1a6uymjG2erqOOc0WqmmzbDXxzCw2VC6eSwk57oxASYWutgGaaZKFAY1aGc0o8utlRfpNaJHhY5J+SUM/DSeGER80WqQbP1rn9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a24bf7cadso19869eaf.0;
        Wed, 31 Jan 2024 10:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706726524; x=1707331324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSOeo3jssOB/9Y9vgCs4JDfVJ5a4bumlhRKAsN3wcRM=;
        b=Ch+a5B7Owd6pkTyfNnXnRVg64epI7zVbf0e5kIyCrRn//iWIsbVqYXLInaKfvUhCtk
         +izOslbShF+drdZxzJc8tAw8u56FlS1HpB2FQqo9h6FMdNJozRjhqra4q4xIAg1Dp1y5
         Par2vHEmeZ3x+gUCmhNyDbU2SEhoZAeNG6T2ygJQry0ay+s40tHG/Pw/DOrxZbbuInSP
         23+Lz761FE8tKfRh7jN5O7OOhzB062h8LYV6RwrC6Vl1dAv0G77r1PTQ9xmJXiAuK/mL
         hwVkQtCHT1LNuFsIIIznWkMFps1RKJGM6TJqAgPBWX94wCjWwcNXInu7bYkFcpSCc0Pz
         LbGg==
X-Forwarded-Encrypted: i=0; AJvYcCWv/Gye2nxamke5nLfH1CqvalHo1rZ+sJkUa4w56nBrY3mT7mSkCLFTy8fiOcDbBmp+NR3fN7M3BGKCP0HaWGt46xiTHpq3XowwyEINr2oIjDnnkpJyXvxnJ0zh9XvyqJTd2hYAnuY=
X-Gm-Message-State: AOJu0YzR3J8yDsSJKTQHhCgQ253PE3f5BEHGiuVs4SEc7hVq0YqejGLQ
	/GlMuBLNuDP8VE2xt4S7wNF/z+nMxLPLIc0ptr5Sj/AsNUQjzGBQa68G4P3ukh8Uw12/cDkVD+Z
	OCrQJTCeHtA/5bjn23tyjChWlGmA=
X-Google-Smtp-Source: AGHT+IH3diaPr7QIWLD8DcKA5QDYMNp8E7NsmoQiYxVUow6cdWfTmUqWHwD37UGbZSFW1GOuCcljlrDj2IODORolaBE=
X-Received: by 2002:a05:6870:4694:b0:204:5ad3:e6ec with SMTP id
 a20-20020a056870469400b002045ad3e6ecmr21276oap.4.1706726524073; Wed, 31 Jan
 2024 10:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4565526.LvFx2qVVIh@kreacher> <7caf2f4d-d0d5-4622-b290-bb0396547f3c@linaro.org>
In-Reply-To: <7caf2f4d-d0d5-4622-b290-bb0396547f3c@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 31 Jan 2024 19:41:52 +0100
Message-ID: <CAJZ5v0iZ0hyPYB3i6YdbiKueHGWoM3i6mPBnzGL9bB8wFxVSPw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: sysfs: Make trip hysteresis writable along
 with trip temperature
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:18=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/01/2024 21:40, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Trip point temperature can be modified via sysfs if
> > CONFIG_THERMAL_WRITABLE_TRIPS is enabled and the thermal
> > zone creator requested that the given trip be writable
> > in the writable trips mask passed to the registration
> > function.
> >
> > However, trip point hysteresis is treated differently - it is only
> > writable if the thermal zone has a .set_trip_hyst() operation defined
> > and neither CONFIG_THERMAL_WRITABLE_TRIPS, nor the writable trips mask
> > supplied by the zone creator has any bearing on this.  That is
> > inconsistent and confusing, and it generally does not meet user
> > expectations.
> >
> > For this reason, modify create_trip_attrs() to handle trip point
> > hysteresis in the same way as trip point temperature, so they both
> > are writable at the same time regardless of what trip point operations
> > are defined for the thermal zone.
> >
> > Link: https://lore.kernel.org/linux-pm/20240106191502.29126-1-quic_mana=
fm@quicinc.com
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Notes:
> >
> >   * I don't think that CONFIG_THERMAL_WRITABLE_TRIPS is very useful.
> >     The only thing controlled by it is whether or not the writable trip
> >     mask used during registration will have any effect and this is quit=
e
> >     confusing.  Some drivers select it for this reason which seems a bi=
t
> >     odd to me.
> >
> >     Maybe it can be dropped after the patch below?
>
> Actually it is used from an userspace daemon to get threshold crossing
> temperature which is then changed on the fly.

I mean to drop CONFIG_THERMAL_WRITABLE_TRIPS and make the writable
trip masks used during zone registration always work.  Sorry for the
confusion.

> Instead of using multiple trip points, they use one where they change
> the temperature after it crossed the threshold.
>
> Usually the userspace tracks slow sensor temperature in order to set a
> specific set of limitations given a scenario. We are talking here about
> Android and thermal engines which are platform specific. For example,
> lower the battery charging speed if there is a game profile.
>
>  From my POV, the thermal framework has been hacked via
> CONFIG_THERMAL_WRITABLE_TRIPS from userspace to get these threshold
> notification and to be honest I find that not sane. This should fall in
> a thermal debug section defaulting to 'no'.
>
> So in some ways in agree with you. We should drop it or make it more
> debug oriented in order to prevent it to go in production.
>
> But before doing that, we should provide a mechanism to userspace to
> specify an 'userspace' trip point. However, it is more complex than what
> it looks because the userspace should be able to specify a group of
> temperature (and hysteresis) in order to be notified when the boundaries
> are crossed and those can be dynamic.
>
> I will provide a proposal in a separate thread in order to not pollute
> the discussion of this one.
>
> >   * IMO the writable trips mask itself is quite cumbersome and it would=
 be
> >     better to mark individual trips as writable in the trips table pass=
ed
> >     during registration.  This would be less prone to mistakes and it
> >     would allow the code to check whether or not the given trip should
> >     be writable (root can change sysfs file modes after all).  If I'm n=
ot
> >     mistaken, this change should not be very hard to make, although it =
may
> >     take some time to switch over all of the relevant drivers from usin=
g
> >     the mask.
>
> +1 +1 +1
>
> I don't think they are so many drivers using this mask. All the drivers
> tied with a OF initialization are not impacted as the change will be in
> one site.

There are a few.  I think around 50% of the
thermal_zone_device_register_with_trips() callers pass non-empty
writable trip points masks.

> > ---
> >   drivers/thermal/thermal_sysfs.c |    3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -474,7 +474,8 @@ static int create_trip_attrs(struct ther
> >                                       tz->trip_hyst_attrs[indx].name;
> >               tz->trip_hyst_attrs[indx].attr.attr.mode =3D S_IRUGO;
> >               tz->trip_hyst_attrs[indx].attr.show =3D trip_point_hyst_s=
how;
> > -             if (tz->ops->set_trip_hyst) {
> > +             if (IS_ENABLED(v) &&
>
>                               ^^^
>
> s/v/CONFIG_THERMAL_WRITABLE_TRIPS/ ?

Yes, and I'm not sure what happened here, because my local copy of the
patch is correct.

I'll send a v2 shortly.

> > +                 mask & (1 << indx)) {
> >                       tz->trip_hyst_attrs[indx].attr.attr.mode |=3D S_I=
WUSR;
> >                       tz->trip_hyst_attrs[indx].attr.store =3D
> >                                       trip_point_hyst_store;
> >
> >
> >
>
> --

