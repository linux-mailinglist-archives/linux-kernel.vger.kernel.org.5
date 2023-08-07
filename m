Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737B277297E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjHGPkz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjHGPkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:40:53 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020A910E0;
        Mon,  7 Aug 2023 08:40:48 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56d0deeca09so720923eaf.0;
        Mon, 07 Aug 2023 08:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691422847; x=1692027647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5ByB1kCbWvE4LvHZxA6DmVsnS3SGc4dZRlcaVebhA=;
        b=h8Toi/fXYwLqeg9ioVQ0qkDqA9uLBEH831CW6xRz99r3791bRiumXWFM20c13JSfZP
         X1BkL/13sOTbcN5AkBcZaG2qFwV6CiF7KiuCiR/OvYhSkYvxHh1Nc1FvUsQ+AlhoIgrZ
         xApZKl2dlRlha/WozzqlPeRAouuxnVC02pnWzcVqFoqOQZKo00jSI90WghBJBn3W37dr
         h474GmLXaUIWR2SPPO/muncGPsAlVFEQv2ENyAmhdyZ1gIS4B29XF+7VTcVDcjQZPoFL
         hyP8Nq/cJekpOYZEbVHLm4Mc4srLZnzMuYHrF/5rQb8c7O9A2CYH1q8zzKofASn4Ifke
         swww==
X-Gm-Message-State: ABy/qLYGhebjEfCToWMC1VrEfWDqwerhtQPuWr4HQUv8jKiBBL0m+d0y
        8X35CbqzU2CZ6FUIvVAI+Bds8Fq1h52WzKMN1O3X9XgrZt0=
X-Google-Smtp-Source: APBJJlFQEpelaJgVONRqETjQPaMw/guTk1Yuygf051lL+f+Lyz1D5gcY/iHtPDM2SnOSc+icGPuhuOtanN6w5q2L38E=
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr21423816oom.1.1691422847098; Mon, 07 Aug
 2023 08:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <1967710.PYKUYFuaPT@kreacher> <f47b7e17-7ec6-4c19-9db1-c1a2e1ad66b6@linaro.org>
In-Reply-To: <f47b7e17-7ec6-4c19-9db1-c1a2e1ad66b6@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 17:40:36 +0200
Message-ID: <CAJZ5v0iNOD9FW0deZYvfjmB8Us+7KjTNnB8Fkm=nnVJ6a82EZQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] thermal: core: Add thermal_zone_update_trip_temp()
 helper routine
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
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 1:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/08/2023 23:05, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Introduce a helper routine called thermal_zone_update_trip_temp() that
> > can be used to update a trip point's temperature with the help of a
> > pointer to local data associated with that trip point provided by
> > the thermal driver that created it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > New patch in v4.
> >
> > ---
> >   drivers/thermal/thermal_trip.c |   37 +++++++++++++++++++++++++++++++++++++
> >   include/linux/thermal.h        |    4 ++++
> >   2 files changed, 41 insertions(+)
> >
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -180,3 +180,40 @@ int thermal_zone_set_trip(struct thermal
> >
> >       return 0;
> >   }
> > +
> > +/**
> > + * thermal_zone_update_trip_temp - Update the trip point temperature.
> > + * @tz: Thermal zone.
> > + * @trip_priv: Trip tag.
> > + * @temp: New trip temperature.
> > + *
> > + * This only works for thermal zones using trip tables and its caller must
> > + * ensure that the zone lock is held before using it.
> > + *
> > + * @trip_priv is expected to be the value that has been stored by the driver
> > + * in the struct thermal_trip representing the trip point in question, so it
> > + * can be matched against the value of the priv field in that structure.
> > + *
> > + * If @trip_priv does not match any trip point in the trip table of @tz,
> > + * nothing happens.
> > + */
> > +void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
> > +                                void *trip_priv, int temperature)
> > +{
> > +     int i;
> > +
> > +     lockdep_assert_held(&tz->lock);
> > +
> > +     if (!tz->trips || !trip_priv)
> > +             return;
> > +
> > +     for (i = 0; i < tz->num_trips; i++) {
> > +             struct thermal_trip *trip = &tz->trips[i];
> > +
> > +             if (trip->priv == trip_priv) {
> > +                     trip->temperature = temperature;
> > +                     return;
> > +             }
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(thermal_zone_update_trip_temp);
>
> This function would imply the comparator is always trip->priv but if we
> want another comparison eg. trip->priv->id, that won't be possible.
>
> Actually, I think you can reuse an existing function with a simple
> change, for_each_thermal_trip() located in thermal_core.h.

for_each_thermal_trip() is only defined in tools/lib/thermal/thermal.c
AFAICS, but this one could actually work, so I can copy that
definition to somewhere else.

But I suppose that you mean __for_each_thermal_trip() which won't
work, because it makes a copy of the trip and passes that to the
callback, but the callback would need to update the temperature of the
original trip.

It would work if it passed the original trip to the caller, so I can
add something like that.

> The changes would be renaming it without the '__' prefix and moving it
> in include/linux/thermal.h.
>
> Then the comparison function and the temperature change can be an ACPI
> driver specific callback passed as parameter to for_each_thermal_zone

I guess you mean for_each_thermal_trip().

As per the above, not really, but I can do something along these lines.
