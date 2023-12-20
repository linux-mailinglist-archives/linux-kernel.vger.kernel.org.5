Return-Path: <linux-kernel+bounces-7362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CE81A68A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B6A1C256F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FC481D8;
	Wed, 20 Dec 2023 17:44:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2247F4A;
	Wed, 20 Dec 2023 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58dd5193db4so1162332eaf.1;
        Wed, 20 Dec 2023 09:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703094282; x=1703699082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spg9sI5q8sRQEzGkG7hq+MtRjhUPkBO3KmZ8kEcf9EI=;
        b=uQifR7h15vnOfKGNdIsg0e7SFTJcQ4auIgzJ4CpNTnnYBCDFim5BY1NUU3t7NYnH06
         tEcUvmrr6kxxQC775XgedKqnLMfDj6ixcjjArAdtFLsxXyY8Nyyty0wlhjU9DnnwED4C
         bPvKYmdA0Z7gLUuE6nxEthghxXDNo+fE8IW06jrfrax99PTeM+gk0g42prk1/Vaiub/X
         mSH8FGrz2dXbuk/wXU+IkLETMn1q2J2DEaR0eijTXUMuK/nOfpaVasMMQyjlWhTxyYZ7
         NWDy2Po18nuBBWl98glBYYz7IskIPntZer2kOnbqldGTpEPzv8wj0NSsg14uLNR2jNvo
         CSyw==
X-Gm-Message-State: AOJu0Yy/biUwSae1AAju+wShummSSbWCpuUa4onMPXg0IAMdctoyT0BU
	R/9BsvxnvO+NChzwrfhNW3L7r7Ew0IeXdAfZ2XNWYM6H
X-Google-Smtp-Source: AGHT+IFynnWUPWM9XOIU1aH7pErxasjAXHQoOy3y6oW62+YAKzqP+n5VbJamYby0I4iLDvOZc4WNxXHruJd13TVZ7RQ=
X-Received: by 2002:a05:6820:104f:b0:594:33c:f126 with SMTP id
 x15-20020a056820104f00b00594033cf126mr2281624oot.0.1703094282175; Wed, 20 Dec
 2023 09:44:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212134844.1213381-1-lukasz.luba@arm.com> <20231212134844.1213381-2-lukasz.luba@arm.com>
 <CAJZ5v0iFOrgtN82pqUqDhE1jMA4wjhH19DFhzPP3yYO05O03=g@mail.gmail.com> <4e5f7d1b-1534-432b-92c1-880c863d79a2@arm.com>
In-Reply-To: <4e5f7d1b-1534-432b-92c1-880c863d79a2@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 18:44:31 +0100
Message-ID: <CAJZ5v0ieGnAaBU=mvKWWs1PVnNtr4QOQev_X1SA+5XvpADh-gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] thermal: core: Add governor callback for thermal
 zone change
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:16=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 12/20/23 13:51, Rafael J. Wysocki wrote:
> > On Tue, Dec 12, 2023 at 2:48=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.co=
m> wrote:
> >>
> >> Add a new callback which can update governors when there is a change i=
n
> >> the thermal zone internals, e.g. thermal cooling instance list changed=
.
> >
> > I would say what struct type the callback is going to be added to.
>
> OK, I'll add that.
>
> >
> >> That makes possible to move some heavy operations like memory allocati=
ons
> >> related to the number of cooling instances out of the throttle() callb=
ack.
> >>
> >> Reuse the 'enum thermal_notify_event' and extend it with a new event:
> >> THERMAL_INSTANCE_LIST_UPDATE.
> >
> > I think that this is a bit too low-level (see below).
>
> Yes, I agree (based on below).
>
> >
> >> Both callback code paths (throttle() and update_tz()) are protected wi=
th
> >> the same thermal zone lock, which guaranties the consistency.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   drivers/thermal/thermal_core.c | 13 +++++++++++++
> >>   include/linux/thermal.h        |  5 +++++
> >>   2 files changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
> >> index 625ba07cbe2f..592c956f6fd5 100644
> >> --- a/drivers/thermal/thermal_core.c
> >> +++ b/drivers/thermal/thermal_core.c
> >> @@ -314,6 +314,14 @@ static void handle_non_critical_trips(struct ther=
mal_zone_device *tz,
> >>                         def_governor->throttle(tz, trip);
> >>   }
> >>
> >
> > I needed a bit more time to think about this.
>
> OK.
>
> >
> >> +static void handle_instances_list_update(struct thermal_zone_device *=
tz)
> >> +{
> >> +       if (!tz->governor || !tz->governor->update_tz)
> >> +               return;
> >> +
> >> +       tz->governor->update_tz(tz, THERMAL_INSTANCE_LIST_UPDATE);
> >> +}
> >
> > So I would call the above something more generic, like
> > thermal_governor_update_tz() and I would pass the "reason" argument to
> > it.
>
> That sounds better, I agree.
>
> >
> >> +
> >>   void thermal_zone_device_critical(struct thermal_zone_device *tz)
> >>   {
> >>          /*
> >> @@ -723,6 +731,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_=
device *tz,
> >>                  list_add_tail(&dev->tz_node, &tz->thermal_instances);
> >>                  list_add_tail(&dev->cdev_node, &cdev->thermal_instanc=
es);
> >>                  atomic_set(&tz->need_update, 1);
> >> +
> >> +               handle_instances_list_update(tz);
> >
> > In particular for this, I would use a special "reason" value, like
> > THERMAL_TZ_BIND_CDEV.
> >
> > Yes, the list of instances will change as a result of the binding, but
> > that is an internal detail specific to the current implementation.
>
> I see. With that new more generic thermal_governor_update_tz() would
> be better then, right?

I think so, IIUC.

