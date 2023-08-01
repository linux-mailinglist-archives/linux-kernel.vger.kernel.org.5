Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA476BD33
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjHATCo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHATCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:02:42 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB5DF;
        Tue,  1 Aug 2023 12:02:40 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56475c1b930so872924eaf.0;
        Tue, 01 Aug 2023 12:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690916560; x=1691521360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrPqP6zfM7TPHzxFi2iNHZ0PPSaifL2OoBOSqdJmnOQ=;
        b=H05Y7e3HpKBGqhfs5nx9NAN2Re2dsNULkp6jHMFlZ4imcVKQHASKPefVMoEOKKmhxR
         ZENUmRXreSvtrJiFZV+9mvA+Bz8GJfdxtp42Wy1GAA8qadORr2CSEHDxujfadDt6DFoi
         troWsD5nDnIQjQH1kTvMcjfzwUB3UrEjViEJwXgp6o/ZeLkGGEpIl5W99Uo6UsY1k7Sb
         ajYbAJCTZKteFytf5rFaxvsh34wBjiCgawSrn/27MvSX41EbfvXDtoWoL25MH8qHJc41
         JjoCApS+SRyaUa9ZM55V/sThJBDorD0RkCBYTEUt6yx2RxvLaoIwlggtNRWrYAny/vLA
         zA7A==
X-Gm-Message-State: ABy/qLb+SxmKmLwpW1sRE7/gKN7DHpo6Vur9h5mWA7yVFAj2ayg9cLcp
        YWrJ6howkd+cuoHFE9qz68T9UN0SqbqRK3DMmEA=
X-Google-Smtp-Source: APBJJlGWxRmGHi0NEdg0sK/BKR0K/xMaDnqaNkFy4KIoHyl1Rdl1KQQSMb69o4USwZFN96eKA9CSoasBidg3B7CKc8E=
X-Received: by 2002:a4a:e251:0:b0:566:951e:140c with SMTP id
 c17-20020a4ae251000000b00566951e140cmr7162902oot.1.1690916560093; Tue, 01 Aug
 2023 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher> <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
In-Reply-To: <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 21:02:28 +0200
Message-ID: <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Tue, Aug 1, 2023 at 8:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 25/07/2023 14:04, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some drivers need to update trip point data (temperature and/or
> > hysteresis) upon notifications from the platform firmware or they
> > may need to reprogram hardware when trip point parameters are changed
> > via sysfs.  For those purposes, they need to connect struct thermal_trip
> > to a private data set associated with the trip or the other way around
> > and using a trip point index for that may not always work, because the
> > core may need to reorder the trips during thermal zone registration (in
> > particular, they may need to be sorted).
> >
> > To allow that to be done without using a trip point index, introduce
> > a new field in struct thermal_trip that can be pointed by the driver
> > to its own data structure containing a trip pointer to be initialized
> > by the core during thermal zone registration.  That pointer will then
> > have to be updated by the core every time the location of the given
> > trip point object in memory changes.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3: No changes.
> >
> > v1 -> v2: No changes.
> >
> > ---
> >   drivers/thermal/thermal_core.c |   20 +++++++++++++++++---
> >   include/linux/thermal.h        |   13 +++++++++++++
> >   2 files changed, 30 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/include/linux/thermal.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/thermal.h
> > +++ linux-pm/include/linux/thermal.h
> > @@ -76,16 +76,29 @@ struct thermal_zone_device_ops {
> >       void (*critical)(struct thermal_zone_device *);
> >   };
> >
> > +struct thermal_trip_ref {
> > +     struct thermal_trip *trip;
> > +};
>
> That introduces a circular dependency. That should be avoided.

Sorry, but this is an empty statement without any substance.

> >   /**
> >    * struct thermal_trip - representation of a point in temperature domain
> >    * @temperature: temperature value in miliCelsius
> >    * @hysteresis: relative hysteresis in miliCelsius
> >    * @type: trip point type
> > + * @driver_ref: driver's reference to this trip point
> > + *
> > + * If @driver_ref is not NULL, the trip pointer in the object pointed to by it
> > + * will be initialized by the core during thermal zone registration and updated
> > + * whenever the location of the given trip object changes.  This allows the
> > + * driver to access the trip point data without knowing the relative ordering
> > + * of trips within the trip table used by the core and, given a trip pointer,
> > + * to get back to its private data associated with the given trip.
> >    */
> >   struct thermal_trip {
> >       int temperature;
> >       int hysteresis;
> >       enum thermal_trip_type type;
> > +     struct thermal_trip_ref *driver_ref;
> >   };
>
> Why not use void *priv ?

Because it wouldn't work.

> AFAICT, the ACPI driver is the only one where when we reorder the trip
> points, the trip id is no longer matching the definition provided by the
> ACPI description.

No, it is not the only one.  Every driver that needs to handle trip
point update notifications from the platform firmware will have this
problem.

> It is possible to have the driver *specific* code to define its own
> structure with the id and use it instead of the trip_id.

Then it would need to walk the trips[] table in the thermal zone, if I
understand the suggestion correctly, which goes kind of against your
previous changes.

> So we end up with the ACPI driver registering the trip points with a
> data structure containing a private trip id.
>
> The thermal framework is not supposed to have to deal with this kind of
> driver issues and from a higher perspective, any driver specific thing
> must stay in the driver.
>
> eg.
>
> struct acpi_thermal_trip_data {
>         int id;
>         ... other info
> };
>
> struct acpi_thermal_trip_data attd[NRTRIPS] = { .id = 0 }, { .id = 1 }, ...
>
> struct thermal_trip trips[NRTRIPS];
>
> trips[i].priv = &attd[i];

But the driver needs to get from priv to trips[i], not the other way around.

> The drivers with another kind of specific trip data can use this field.

They could if the trips did not get reordered.  Otherwise they would
need to walk trips[] every time and have a way to match each trip
against its private counterpart.

I guess they could use the address of the private part as a tag in
this, but is walking trips[] by drivers something that you really
want?

>
>
> >   struct thermal_cooling_device_ops {
> > Index: linux-pm/drivers/thermal/thermal_core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > +++ linux-pm/drivers/thermal/thermal_core.c
> > @@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
> >       if (result)
> >               goto release_device;
> >
> > +     mutex_lock(&tz->lock);
> > +
> >       for (count = 0; count < num_trips; count++) {
> > -             struct thermal_trip trip;
> > +             int temperature = 0;
> > +
> > +             if (trips) {
> > +                     temperature = trips[count].temperature;
> > +                     if (trips[count].driver_ref)
> > +                             trips[count].driver_ref->trip = &trips[count];
> > +             } else {
> > +                     struct thermal_trip trip;
>
> As mentioned above, that should not appear in the thermal core code.

Well, this is a matter of opinion to me.  Clearly, I disagree with it.

Anyway, I want to be productive, so here's the thing: either something
like this is done, or drivers need to be allowed to walk the trips
table.

Which one is better?

>
> > -             result = thermal_zone_get_trip(tz, count, &trip);
> > -             if (result || !trip.temperature)
> > +                     result = __thermal_zone_get_trip(tz, count, &trip);
> > +                     if (!result)
> > +                             temperature = trip.temperature;
> > +             }
> > +             if (!temperature)
> >                       set_bit(count, &tz->trips_disabled);
> >       }
> >
> > +     mutex_unlock(&tz->lock);
> > +
> >       /* Update 'this' zone's governor information */
> >       mutex_lock(&thermal_governor_lock);
