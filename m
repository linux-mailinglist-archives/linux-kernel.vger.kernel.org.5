Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26A27C7294
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379560AbjJLQ3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379582AbjJLQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:29:41 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5F9D3;
        Thu, 12 Oct 2023 09:29:40 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57b68555467so26292eaf.0;
        Thu, 12 Oct 2023 09:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128179; x=1697732979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAl3+uNQYC6UB13kffuDk/amKGx+yj+5/jXC7+UiWUQ=;
        b=cgGkWAwPyiAcf3yczETm34FV9hgQB1wEvWsTL1YK91007CXGiFtmqNZfoYyOe1R/Fj
         DSDZw8BV0PklhiyX01UHVihEJg8lytclg6rb1uOybA9noiuIhVuC2+CNoza5PBvM73S/
         Gq/jvIo7FRyHd39ouJr+Sn6WGHkBYXgcaSbAiiN0XNwCbPdi08/V6XUgZWmHj1cG2jOf
         njR0ZTj6rbDQiuRiI63S1YxpxFbjc7RdLqlr/3rEeFSOgOgmhU+eF8HAc1IDLdXoEXRF
         WcS77DnslJ9D0wFSg3UhtCOMkIVun3VX7T/1hHFvwjuloQWUHuNOQouizFaNXJgeDMXP
         0gpA==
X-Gm-Message-State: AOJu0YyvHPcC5ES193TR0CzMhoelsrhJ22ZodmFYVpIOII+H7Rqa7Yye
        304X0COyncat+OvfaYh1fu5G9rFG9UzPNbYtNyA=
X-Google-Smtp-Source: AGHT+IGh1f6oVO/LvwqDvixeJyTAYBP0I2APjNZQmOTNP+tmXqle0Qk4fGO835S/gtpG9LzlSqo3GE6fHAZnFbc3JB0=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr24662463oou.0.1697128179431; Thu, 12 Oct
 2023 09:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <2244940.iZASKD2KPV@kreacher> <a9c42b1d-919d-4c77-991d-be113b9cf2a5@linaro.org>
In-Reply-To: <a9c42b1d-919d-4c77-991d-be113b9cf2a5@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 18:29:28 +0200
Message-ID: <CAJZ5v0hrfoZbXTdPLZ5o9j5h0whb4jRhDjJ0iyqPeBTzA1gTZg@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] thermal: gov_fair_share: Rearrange get_trip_level()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 5:04 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 06/10/2023 19:42, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make get_trip_level() use for_each_trip() to iterate over trip points
> > and make it call thermal_zone_trip_id() to obtain the integer ID of a
> > given trip point so as to avoid relying on the knowledge of struct
> > thermal_zone_device internals.
> >
> > The general functionality is not expected to be changed.
> >
> > This change causes the governor to use trip pointers instead of trip
> > indices everywhere except for the fair_share_throttle() second argument
> > that will be modified subsequently along with the definition of the
> > governor .throttle() callback.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/gov_fair_share.c |   30 ++++++++++++++----------------
> >   1 file changed, 14 insertions(+), 16 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/gov_fair_share.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> > +++ linux-pm/drivers/thermal/gov_fair_share.c
> > @@ -15,29 +15,27 @@
> >
> >   #include "thermal_core.h"
> >
> > -/**
> > - * get_trip_level: - obtains the current trip level for a zone
> > - * @tz:              thermal zone device
> > - */
> >   static int get_trip_level(struct thermal_zone_device *tz)
> >   {
> > -     struct thermal_trip trip;
> > -     int count;
> > +     const struct thermal_trip *trip, *level_trip = NULL;
> > +     int trip_level;
> >
> > -     for (count = 0; count < tz->num_trips; count++) {
> > -             __thermal_zone_get_trip(tz, count, &trip);
> > -             if (tz->temperature < trip.temperature)
> > +     for_each_trip(tz, trip) {
> > +             if (level_trip && trip->temperature >= tz->temperature)
> >                       break;
>
> Even if very likely the trip points are ordered by the hardware
> enumeration, strictly we don't have yet the guarantee the trips are
> ordered (as that is the final goal to correctly detect thresholds
> crossing with the generic trip). We should go through all the trip
> points, no?

Well, I just retained the existing logic, because changing it is not
the purpose of this patch.

Such a change can certainly be considered, but not in this patch and
not in this patch series.

> > +             level_trip = trip;
> >       }
> >
> > -     /*
> > -      * count > 0 only if temperature is greater than first trip
> > -      * point, in which case, trip_point = count - 1
> > -      */
> > -     if (count > 0)
> > -             trace_thermal_zone_trip(tz, count - 1, trip.type);
> > +     /*  Bail out if the temperature is not greater than any trips. */
> > +     if (level_trip->temperature >= tz->temperature)
> > +             return 0;
>
> Isn't simpler to remove the test level_trip != NULL in the loop and then
> check here if it is NULL and then return 0.

Yes, good point.

> > +     trip_level = thermal_zone_trip_id(tz, level_trip);
> > +
> > +     trace_thermal_zone_trip(tz, trip_level, level_trip->type);
> >
> > -     return count;
> > +     return trip_level;
> >   }
> >
> >   static long get_target_state(struct thermal_zone_device *tz,
> >
> >
> >
>
> --
