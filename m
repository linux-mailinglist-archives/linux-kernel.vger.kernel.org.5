Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170687FBA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbjK1MyD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 07:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbjK1MyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:54:01 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE010D4;
        Tue, 28 Nov 2023 04:54:07 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d815062598so871708a34.0;
        Tue, 28 Nov 2023 04:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701176045; x=1701780845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KansKB/I6JMABnep2eO/OwfMWyW5lRyhE+ZO5W+A/ws=;
        b=cHVMkKQjb2/3hAfY2clot2YmI6PaEOiLfqgoFZAfmWL3XjZJRzf9mwyeWOqh467EwY
         sORBJgHhJdg7yZRzvhXkj68t4Su97edQZt5kk0UxUGt26ZdYIymzPNEYfSaYV/0SpKm0
         T5TawRQUpher0tjniLpKLKksc2YgRJuxSDqPVA+EnlqRRUHx6dC+zTnVzYxEY38EMI8u
         4XQs+T+/s69CKTnQcxYGtNWblp63AiD4xE62hXyxI8S9wNYVqOi3mDQUMkL23WP8GRR8
         oKTaaXD/rjFqci7pDZ48mw7Y8s7jQSezEE3iZwJG6IeNVsFJE8fjrV3XtC8Yc7ysr2CC
         4Bug==
X-Gm-Message-State: AOJu0YzGYoCVrMpuXJAQCRzclSqwgCju/WRDyJ1wvvYWASIJ1mTvKmk9
        sILwuOwmvp2qIvh7sUSCZSMMFYG/Qf5v8JXQsr4=
X-Google-Smtp-Source: AGHT+IEPoptBOm+FCdrsD7uMUnoB/xFwq4DwM8OLtwgqU3ZrwwVTieoVYv+j/HqoSQetrl66aq3gAlFezhhjcgjCihA=
X-Received: by 2002:a05:6820:b0b:b0:58a:7cff:2406 with SMTP id
 df11-20020a0568200b0b00b0058a7cff2406mr13172699oob.0.1701176045412; Tue, 28
 Nov 2023 04:54:05 -0800 (PST)
MIME-Version: 1.0
References: <4892163.31r3eYUQgx@kreacher> <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
In-Reply-To: <f3b2dc4d-3d20-4f90-95ce-5d62fc7ef685@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Nov 2023 13:53:54 +0100
Message-ID: <CAJZ5v0iYy90+WPceFrJdv15jBg4NKUz0gj9DsxjCYQr38GznBQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: trip: Rework thermal_zone_set_trip() and its callers
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, Nov 28, 2023 at 9:16 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 11/27/23 19:59, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both trip_point_temp_store() and trip_point_hyst_store() use
> > thermal_zone_set_trip() to update a given trip point, but none of them
> > actually needs to change more than one field in struct thermal_trip
> > representing it.  However, each of them effectively calls
> > __thermal_zone_get_trip() twice in a row for the same trip index value,
> > once directly and once via thermal_zone_set_trip(), which is not
> > particularly efficient, and the way in which thermal_zone_set_trip()
> > carries out the update is not particularly straightforward.
> >
> > Moreover, some checks done by them both need not go under the thermal
> > zone lock and code duplication between them can be reduced quilte a bit
>
> s/quilte/quite/
>
> > by moving the majority of logic into thermal_zone_set_trip().
> >
> > Rework all of the above funtcions to address the above.
>
> s/funtcions/functions/

Thanks for spotting the typos!

> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.h  |    9 +++++
> >   drivers/thermal/thermal_sysfs.c |   52 +++++++---------------------------
> >   drivers/thermal/thermal_trip.c  |   61 ++++++++++++++++++++++++++--------------
> >   include/linux/thermal.h         |    3 -
> >   4 files changed, 61 insertions(+), 64 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -122,6 +122,15 @@ void __thermal_zone_device_update(struct
> >   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> >   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> >                           struct thermal_trip *trip);
> > +
> > +enum thermal_set_trip_target {
> > +     THERMAL_TRIP_SET_TEMP,
> > +     THERMAL_TRIP_SET_HYST,
> > +};
> > +
> > +int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> > +                       enum thermal_set_trip_target what, const char *buf);
> > +
> >   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> >                        const struct thermal_trip *trip);
> >   int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -120,31 +120,17 @@ trip_point_temp_store(struct device *dev
> >                     const char *buf, size_t count)
> >   {
> >       struct thermal_zone_device *tz = to_thermal_zone(dev);
> > -     struct thermal_trip trip;
> > -     int trip_id, ret;
> > +     int trip_id;
> > +     int ret;
> > +
> > +     if (!device_is_registered(dev))
> > +             return -ENODEV;
> >
> >       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
> >               return -EINVAL;
> >
> > -     mutex_lock(&tz->lock);
> > -
> > -     if (!device_is_registered(dev)) {
> > -             ret = -ENODEV;
> > -             goto unlock;
> > -     }
> > -
> > -     ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> > -     if (ret)
> > -             goto unlock;
> > -
> > -     ret = kstrtoint(buf, 10, &trip.temperature);
> > -     if (ret)
> > -             goto unlock;
> > +     ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_TEMP, buf);
> >
> > -     ret = thermal_zone_set_trip(tz, trip_id, &trip);
> > -unlock:
> > -     mutex_unlock(&tz->lock);
> > -
> >       return ret ? ret : count;
> >   }
> >
> > @@ -179,30 +165,16 @@ trip_point_hyst_store(struct device *dev
> >                     const char *buf, size_t count)
> >   {
> >       struct thermal_zone_device *tz = to_thermal_zone(dev);
> > -     struct thermal_trip trip;
> > -     int trip_id, ret;
> > +     int trip_id;
> > +     int ret;
> > +
> > +     if (!device_is_registered(dev))
> > +             return -ENODEV;
> >
> >       if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
> >               return -EINVAL;
> >
> > -     mutex_lock(&tz->lock);
> > -
> > -     if (!device_is_registered(dev)) {
> > -             ret = -ENODEV;
> > -             goto unlock;
> > -     }
> > -
> > -     ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> > -     if (ret)
> > -             goto unlock;
> > -
> > -     ret = kstrtoint(buf, 10, &trip.hysteresis);
> > -     if (ret)
> > -             goto unlock;
> > -
> > -     ret = thermal_zone_set_trip(tz, trip_id, &trip);
> > -unlock:
> > -     mutex_unlock(&tz->lock);
> > +     ret = thermal_zone_set_trip(tz, trip_id, THERMAL_TRIP_SET_HYST, buf);
> >
> >       return ret ? ret : count;
> >   }
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -148,42 +148,61 @@ int thermal_zone_get_trip(struct thermal
> >   EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
> >
> >   int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> > -                       const struct thermal_trip *trip)
> > +                       enum thermal_set_trip_target what, const char *buf)
> >   {
> > -     struct thermal_trip t;
> > -     int ret;
> > +     struct thermal_trip *trip;
> > +     int val, ret = 0;
> >
> > -     if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
> > -             return -EINVAL;
>
> Here we could bail out when there are no callbacks.

Not really, because the trip is updated regardless.

>
> > +     if (trip_id < 0 || trip_id >= tz->num_trips)
> > +             ret = -EINVAL;
> >
> > -     ret = __thermal_zone_get_trip(tz, trip_id, &t);
> > +     ret = kstrtoint(buf, 10, &val);
> >       if (ret)
> >               return ret;
> >
> > -     if (t.type != trip->type)
> > -             return -EINVAL;
> > +     mutex_lock(&tz->lock);
> >
> > -     if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
> > -             ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     trip = &tz->trips[trip_id];
> >
> > -     if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
> > -             ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
> > -             if (ret)
> > -                     return ret;
> > +     switch (what) {
> > +     case THERMAL_TRIP_SET_TEMP:
> > +             if (val == trip->temperature)
> > +                     goto unlock;
> > +
> > +             if (tz->ops->set_trip_temp) {
> > +                     ret = tz->ops->set_trip_temp(tz, trip_id, val);
> > +                     if (ret)
> > +                             goto unlock;
> > +             }
>
> But here we don't bail out and go line below
>
> > +             trip->temperature = val;
>
> where we modify the actual '&tz->trips[trip_id]'.

Right, the trip is updated regardless unless the callback invocation
fails, in which case it is better to retain the existing configuration
for consistency.

The current logic is exactly this AFAICS except that it is hard to untangle.

> Shouldn't be something like the code flow below?
> --------------------------------------------8<-----------------------------
>                 if (!tz->ops->set_trip_temp)
>                         goto unlock;
>
>                 ret = tz->ops->set_trip_temp(tz, trip_id, val);
>                 if (ret)
>                         goto unlock;
>
>                 trip->temperature = val;
>                 break
> ----------------------------------->8--------------------------------------

Not really.

>
>
>
>
> > +             break;
> > +
> > +     case THERMAL_TRIP_SET_HYST:
> > +             if (val == trip->hysteresis)
> > +                     goto unlock;
> > +
> > +             if (tz->ops->set_trip_hyst) {
> > +                     ret = tz->ops->set_trip_hyst(tz, trip_id, val);
> > +                     if (ret)
> > +                             goto unlock;
> > +             }
> > +             trip->hysteresis = val;
>
> Similar question here.
>
> > +             break;
> > +
> > +     default:
> > +             ret = -EINVAL;
> > +             goto unlock;
> >       }
> >
> > -     if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
> > -             tz->trips[trip_id] = *trip;
> > -
> >       thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
> >                                     trip->temperature, trip->hysteresis);
> >
> >       __thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> >
> > -     return 0;
> > +unlock:
> > +     mutex_unlock(&tz->lock);
> > +
> > +     return ret;
> >   }
> >
> >   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> > Index: linux-pm/include/linux/thermal.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -283,9 +283,6 @@ int __thermal_zone_get_trip(struct therm
> >   int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> >                         struct thermal_trip *trip);
> >
> > -int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> > -                       const struct thermal_trip *trip);
> > -
>
> Surprisingly, nothing outside thermal fwk uses it...
> Maybe it's worth to check other functions there.

Fair enough, but that's outside this patch IMO.

> Other than that, it looks like a good idea.

Thanks for the review!
