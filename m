Return-Path: <linux-kernel+bounces-22233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3512829B39
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163AC1C21BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEE48CF0;
	Wed, 10 Jan 2024 13:30:29 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D06487AC;
	Wed, 10 Jan 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-598a589e0beso14233eaf.0;
        Wed, 10 Jan 2024 05:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893425; x=1705498225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8y/D/R5G8HSXHy1RxNqsRhPnVsNFw+yMQfq/ORpxS4=;
        b=kYEoFGSZ1Oyd15FughG2v9fMgt19KR0s4cWBAO+Cka7UELWe8MOtnSkrHwJfv93uQB
         v94Al3Fdy9o8UZDGLTc5kyhEx84lmXWkNDjRqxPj5LalGlkyU3dO9gG7hfK9MhOUZ8RH
         iNLIAp3QiOvVk1D4rqWWl6s+j9aiX0w2OADYu1p72seBk9oMFsBr5TecKm0P7MrLGDG9
         JTicw2oRX4Ja8tt4/tgp3Kx+6vDJBkbnGEbjTzH9iespaUwA1poacKPzFO3pqO0uTjpp
         dCv/tasVQFO+OI+awLAR/YXdBbicbmnxbHkxNidM5MhLjHDxQ8Wez7lJHaW+JIT78CWA
         cj3g==
X-Gm-Message-State: AOJu0Yy89ooXMxlm2lr2PcgGKB1dCAYT7LcK8oUt5TK3lTH6MLDJ9Osa
	esSlJjTxNhC79g3Pn8kU9g9ry3Cjs622VtSz3FQDODvy
X-Google-Smtp-Source: AGHT+IHWRNoSG12vYIkKgSvS56mZ/ACZEsFqWuo5FZojg+VI8YZcjs81FHvN+rPLRqc8PUtR6UeFd7ucIPk/PLCZmdc=
X-Received: by 2002:a4a:d813:0:b0:598:205c:f387 with SMTP id
 f19-20020a4ad813000000b00598205cf387mr1732436oov.1.1704893425101; Wed, 10 Jan
 2024 05:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110115526.30776-1-di.shen@unisoc.com> <0cbc1708-bc50-459c-ad57-0cf283921f2e@arm.com>
In-Reply-To: <0cbc1708-bc50-459c-ad57-0cf283921f2e@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jan 2024 14:30:13 +0100
Message-ID: <CAJZ5v0iTff4Uvmd7KT-SJ253xvHo8Jxrqjy5XQ6TTAomiVagbg@mail.gmail.com>
Subject: Re: [PATCH V7] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org, rui.zhang@intel.com, 
	daniel.lezcano@linaro.org, rafael@kernel.org, linux-kernel@vger.kernel.org, 
	wvw@google.com, tkjos@google.com, xuewen.yan@unisoc.com, zhanglyra@gmail.com, 
	orsonzhai@gmail.com, cindygm567@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:03=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 1/10/24 11:55, Di Shen wrote:
> > Commit 0952177f2a1f ("thermal/core/power_allocator: Update once
> > cooling devices when temp is low") adds an update flag to avoid
> > the thermal event is triggered when there is no need, and
> > thermal cdev would be updated once when temperature is low.
> >
> > But when the trips are writable, and switch_on_temp is set
> > to be a higher value, the cooling device state may not be
> > reset to 0, because last_temperature is smaller than the
> > switch_on_temp.
> >
> > For example:
> > First:
> > switch_on_temp=3D70 control_temp=3D85;
> > Then userspace change the trip_temp:
> > switch_on_temp=3D45 control_temp=3D55 cur_temp=3D54
> >
> > Then userspace reset the trip_temp:
> > switch_on_temp=3D70 control_temp=3D85 cur_temp=3D57 last_temp=3D54
> >
> > At this time, the cooling device state should be reset to 0.
> > However, because cur_temp(57) < switch_on_temp(70)
> > last_temp(54) < switch_on_temp(70)  ---->  update =3D false,
> > update is false, the cooling device state can not be reset.
> >
> > Considering tz->passive can also be represented the temperature
> > status, this patch modifies the update flag with tz->passive.
> >
> > When the first time the temperature drops below switch_on, the
> > states of cooling devices can be reset once, and the tz->passive
> > is updated to 0. In the next round, because tz->passive is 0,
> > the cdev->state would not be updated.
> >
> > By using the tz->passive as the "update" flag, the issue above
> > can be solved, and the cooling devices can be update only once
> > when the temperature is low.
> >
> > Fixes: 0952177f2a1f ("thermal/core/power_allocator: Update once cooling=
 devices when temp is low")
> > Cc: <stable@vger.kernel.org> # v5.13+
> > Suggested-by: Wei Wang <wvw@google.com>
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> >
> > ---
> > V7:
> > - Some formatting changes.
> > - Add Suggested-by tag.
> >
> > V6: [6]
> > Compared to the previous version:
> > - Not change the thermal core.
> > - Not add new variables and function.
> > - Use tz->passive as "update" flag to indicate whether the cooling
> >    devices should be reset.
> >
> > V5: [5]
> > - Simplify the reset ops, make it no return value and no specific
> >    trip ID as argument.
> > - Extend the commit message.
> >
> > V4: [4]
> > - Compared to V3, handle it in thermal core instead of in governor.
> > - Add an ops to the governor structure, and call it when a trip
> >    point is changed.
> > - Define reset ops for power allocator.
> >
> > V3: [3]
> > - Add fix tag.
> >
> > V2: [2]
> > - Compared to v1, do not revert.
> > - Add a variable(last_switch_on_temp) in power_allocator_params
> >    to record the last switch_on_temp value.
> > - Adds a function to renew the update flag and update the
> >    last_switch_on_temp when thermal trips are writable.
> >
> > V1: [1]
> > - Revert commit 0952177f2a1f.
> >
> > [1] https://lore.kernel.org/all/20230309135515.1232-1-di.shen@unisoc.co=
m/
> > [2] https://lore.kernel.org/all/20230315093008.17489-1-di.shen@unisoc.c=
om/
> > [3] https://lore.kernel.org/all/20230320095620.7480-1-di.shen@unisoc.co=
m/
> > [4] https://lore.kernel.org/all/20230619063534.12831-1-di.shen@unisoc.c=
om/
> > [5] https://lore.kernel.org/all/20230710033234.28641-1-di.shen@unisoc.c=
om/
> > [6] https://lore.kernel.org/all/20240109112736.32566-1-di.shen@unisoc.c=
om/
> > ---
> > ---
> >   drivers/thermal/gov_power_allocator.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 7b6aa265ff6a..81e061f183ad 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -762,7 +762,7 @@ static int power_allocator_throttle(struct thermal_=
zone_device *tz,
> >
> >       trip =3D params->trip_switch_on;
> >       if (trip && tz->temperature < trip->temperature) {
> > -             update =3D tz->last_temperature >=3D trip->temperature;
> > +             update =3D tz->passive;
> >               tz->passive =3D 0;
> >               reset_pid_controller(params);
> >               allow_maximum_power(tz, update);
>
> Thanks for the patch, LGTM.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.8-rc1 material with modified subject and edited changelog.

Thanks!

