Return-Path: <linux-kernel+bounces-93865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A66873603
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326311C22CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F78003E;
	Wed,  6 Mar 2024 12:03:00 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604677FBAE;
	Wed,  6 Mar 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726580; cv=none; b=dpTyfAp5pUV6nZlBZJ7QFL9FRmB+h0XsIc0PW6gCBQB01pzuSy25Q7AY+5Jc9/BUPk0giPAXoPXV6x6aTE/yuh0iLTHfOvaCyO6In2ae7vA+RJTTssA8yWfT5+j8lzwf6bl59/HlaP93ieHKb2pQNaN+E7zTPy4TZZOhc85E/gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726580; c=relaxed/simple;
	bh=ygOUcxcRpUINHsb9d9oL2323fFjzJsOlLgRBp5SVIVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQvtpoz8mHqMNaibxC+GkjNCmPIUeGED+Y1tNL+Lnwp7Bp5X9S2e/fEoZo4ExRgmuF4RtUsO3YwsmDMw01Z1ExOYuTMhSZIyTeKwY/zqrrMz7Hzj4axDXOF+nVT8eOPoabwPrD3AQbWOa5gtUwHf4xTo/RbdHAFtx9X6FShHRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21f10aae252so735106fac.0;
        Wed, 06 Mar 2024 04:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726577; x=1710331377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGkv/Y4Ut4vTGw3rcpL6a48vgfRCwr0jO5gV/dxwk4I=;
        b=KLFt0akeThbOisMBSLftHT9KUMOf+cW9MTt45+atWKlEzuxx5MMqBk0LWpTB9u12g9
         kD1S/jVb9LbFLaX3fcmvE7zLjjr2SL41hO/5o1rTLns78f17RbybkwI6euYe8cAav4Y3
         GgsOze17K/E3nQNDvesKpyy2LxsJv8/kWxsr1vCBUp1ne44F88jMdmlRhHmtEIDr2UyB
         8flblyKakUyiSNK3I7lrtiVYyms5qW4db8vBPpOSBGVarMoJiMAjAROFFjOVTAzHVJDw
         5lIHxNTEvWqIwN3ZRXuz1Is7wwy+2bvGH8gVM+RqAqSw0Bx32MsybZmGauq+VLtSbl0o
         i9AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwPGm6h9neV5AQG/S0froefPj1E6Na1P4/GQVs8gh8M3EVAAyAfaYUIE/a4Uzp1q8U6NSPLGF1mtmt6fvVPwi8pRk6WG7h+9sf7YPFWVNyQbmT+Re+Mufi1mUbyUY8SZl8tS2xI5s=
X-Gm-Message-State: AOJu0YxZ32y67S+ZjYeLdaiaBnD/9jqIrAPKaOSWCssFXvNZPD7kJHPr
	hupvklKK5Im+BrVkO8LE3eau0k6bh6gD7Y3v+XJ40M9joYDtA6SYYiUo/elUYzLEZ7wef9m7ujs
	KT7leANX02obp7QTV90EOdiG1mVE=
X-Google-Smtp-Source: AGHT+IFnaboa01aFQV5lPR30HlGfY/+Il5mmcq+JaTPaMIvwVPJBshCCIa27lGDlV0b/Uqzmcdc68nhgL+dmu42frE8=
X-Received: by 2002:a05:6870:b507:b0:21f:cd7d:9904 with SMTP id
 v7-20020a056870b50700b0021fcd7d9904mr3487536oap.4.1709726577329; Wed, 06 Mar
 2024 04:02:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306085428.88011-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240306085428.88011-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Mar 2024 13:02:45 +0100
Message-ID: <CAJZ5v0jAn2F-GH=fguX0+3bG38vyAxfufadtFiBUfg=EjTBh6Q@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal/core: Fix trip point crossing events ordering
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 9:54=E2=80=AFAM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> Let's assume the following setup:
>
>  - trip 0 =3D 65=C2=B0C
>  - trip 1 =3D 70=C2=B0C
>  - trip 2 =3D 75=C2=B0C
>
> The current temperature is 35=C2=B0C.
>
> The interrupt is setup to fire at 65=C2=B0C. If the thermal capacity is
> saturated it is possible the temperature jumps to 72=C2=B0c when reading
> the temperature after the interrupt fired when 65=C2=B0C was crossed. Tha=
t
> means we should have two events notified to userspace. The first one
> for trip 0 and the second one for trip 1.
>
> When the function thermal_zone_update() is called from the threaded
> interrupt, it will read the temperature and then call for_each_trip()
> which in turns call handle_trip_point().
>
> This function will check:
>
>      if (tz->last_temperature < trip->temperature &&
>         tz->temperature >=3D trip->temperature)
>                         thermal_notify_tz_trip_up()

For the mainline:

$ git grep handle_trip_point | cat
$

Do you mean handle_thermal_trip()?

But it doesn't do the above in the mainline.  It does (comments omitted)

if (tz->last_temperature < trip->threshold) {
   if (tz->temperature >=3D trip->temperature) {
        thermal_notify_tz_trip_up(tz, trip);
        thermal_debug_tz_trip_up(tz, trip);
        trip->threshold =3D trip->temperature - trip->hysteresis;
    } else {
        trip->threshold =3D trip->temperature;
    }
}

>
> So here, we will call this function with trip0 followed by trip1. That
> will result in an event for each trip point, reflecting the trip point
> being crossed the way up with a temperature raising. So far, so good.
>
> Usually the sensors have an interrupt when the temperature is crossed
> the way up but not the way down, so there an extra delay corresponding
> to the passive polling where the temperature could have dropped and
> crossed more than one trip point. This scenario is likely to happen
> more often when multiple trip points are specified. So considering the
> same setup after crossing the trip 2, we stop the workload responsible
> of the heat and the temperature drops suddenly to 62=C2=B0C. In this case=
,
> the next polling will call thermal_zone_device_update(), then
> for_each_trip() and handle_trip_point().
>
> This function will check:
>
>      if (tz->last_temperature >=3D trip->temperature &&
>         tz->temperature < trip->temperature - trip->hysteresis)
>                         thermal_notify_tz_trip_down()

Again, assuming that you mean handle_thermal_trip(), the above is not
the current mainline code, which is (comments omitted)

if (tz->last_temperature >=3D trip->threshold) {
    if (tz->temperature < trip->temperature - trip->hysteresis) {
         thermal_notify_tz_trip_down(tz, trip);
         thermal_debug_tz_trip_down(tz, trip);
         trip->threshold =3D trip->temperature;
    } else {
        trip->threshold =3D trip->temperature - trip->hysteresis;
    }
}

I guess this doesn't matter here?

> The loop for_each_trip() will call trip0, 1 and 2. That will result in
> generating the events for trip0, 1 and 2, in the wrong order. That is
> not reflecting the thermal dynamic and puzzles the userspace
> monitoring the temperature.

Only if the trips are ordered in a specific way, but they don't need
to be ordered in any way.

> Fix this by inspecting the trend of the temperature. If it is raising,
> then we browse the trip point in the ascending order, if it is falling
> then we browse in the descending order.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 8 ++++++--
>  drivers/thermal/thermal_core.h | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index dfaa6341694a..abb8ee5c9afe 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -473,8 +473,12 @@ void __thermal_zone_device_update(struct thermal_zon=
e_device *tz,
>
>         tz->notify_event =3D event;
>
> -       for_each_trip(tz, trip)
> -               handle_thermal_trip(tz, trip);
> +       if (tz->last_temperature < tz->temperature)
> +               for_each_trip(tz, trip)
> +                       handle_thermal_trip(tz, trip);
> +       else
> +               for_each_trip_reverse(tz, trip)
> +                       handle_thermal_trip(tz, trip);

This works assuming a "proper" ordering of the trips.

>
>         monitor_thermal_zone(tz);
>  }
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_cor=
e.h
> index e9c099ecdd0f..0072b3d4039e 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -123,6 +123,9 @@ void thermal_governor_update_tz(struct thermal_zone_d=
evice *tz,
>  #define for_each_trip(__tz, __trip)    \
>         for (__trip =3D __tz->trips; __trip - __tz->trips < __tz->num_tri=
ps; __trip++)
>
> +#define for_each_trip_reverse(__tz, __trip)    \
> +       for (__trip =3D &__tz->trips[__tz->num_trips - 1]; __trip >=3D __=
tz->trips ; __trip--)
> +
>  void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>  int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>                          const struct thermal_trip *trip);
> --

Generally speaking, this is a matter of getting alignment on the
expectations between the kernel and user space.

It looks like user space expects to get the notifications in the order
of either growing or falling temperatures, depending on the direction
of the temperature change.  Ordering the trips in the kernel is not
practical, but the notifications can be ordered in principle.  Is this
what you'd like to do?

Or can user space be bothered with recognizing that it may get the
notifications for different trips out of order?

