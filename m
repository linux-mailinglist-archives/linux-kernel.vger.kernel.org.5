Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40447B07A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjI0PG3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjI0PG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:06:28 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4B6F9;
        Wed, 27 Sep 2023 08:06:26 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57bc11c197aso813417eaf.1;
        Wed, 27 Sep 2023 08:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695827186; x=1696431986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOU2TsYoHI87o4MQ2qgkhZ2w81LG4U8JjmVaBsHW46M=;
        b=Y286ki/9nVqIz94z3jG+5TW4bwlwplWSKxouwkazTaqbOLLuqxNw+U8LaL9oxMjAwC
         ngCIwcd79mimx2MOviB3YHpmPfnPXLiX8t8wvAdESBm9CZclSJu+XGpnw7gB1svfL+sC
         gE/hW7Ek8Xvanxd3KPzYU29XXAmQflkFc7Ye26xWve+Vo/PRDC/JJAUt7eNbYock3Hpv
         3F2U391KGoz7OyByyV+0LjJ6vDCdJjWT8gf35HJD+IIbUXmoCc4sWEDmUc7ieTa+NrYO
         x2A9qsIDdWjvouBEM+lH57I8yTN0G4tmvhSqfEzWXmyZJT5w6mBKTGq/6lCwDJzDMhxs
         YYow==
X-Gm-Message-State: AOJu0YwhD9eG9SKyRbOtnNR+TOnfC2QkrVNHyfznB/R3VzmfrBXR9CHF
        TV4ZjBvoHkl+brytRnfWl7amSh9RZ1M5I3/PB5E=
X-Google-Smtp-Source: AGHT+IG9SK7oeqtUGZZk6NA1P5Pb49ChbMqBRIPibOc013j+ztYHwfD+qdKOyFYjoZUcjfLwRDVXHexlXzP/BtGYivw=
X-Received: by 2002:a05:6820:2182:b0:57b:7e31:c12 with SMTP id
 ce2-20020a056820218200b0057b7e310c12mr2355007oob.1.1695827185901; Wed, 27 Sep
 2023 08:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <1882755.CQOukoFCf9@kreacher> <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org>
In-Reply-To: <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Sep 2023 17:06:14 +0200
Message-ID: <CAJZ5v0ifXSWd4QL+j-=8OBr1aQr0WAeMBGYtis_gkHJDBLeWMg@mail.gmail.com>
Subject: Re: [PATCH v1 06/13] thermal: gov_fair_share: Rearrange get_trip_level()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Sep 27, 2023 at 5:00 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/09/2023 19:54, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make get_trip_level() access the thermal zone's trip table directly
> > instead of using __thermal_zone_get_trip() which adds overhead related
> > to the unnecessary bounds checking and copying the trip point data.
> >
> > Also rearrange the code in it to make it somewhat easier to follow.
> >
> > The general functionality is not expected to be changed.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/gov_fair_share.c |   22 ++++++++++------------
> >   1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/gov_fair_share.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> > +++ linux-pm/drivers/thermal/gov_fair_share.c
> > @@ -21,23 +21,21 @@
> >    */
> >   static int get_trip_level(struct thermal_zone_device *tz)
> >   {
> > -     struct thermal_trip trip;
> > -     int count;
> > +     const struct thermal_trip *trip = tz->trips;
> > +     int i;
> >
> > -     for (count = 0; count < tz->num_trips; count++) {
> > -             __thermal_zone_get_trip(tz, count, &trip);
> > -             if (tz->temperature < trip.temperature)
> > +     if (tz->temperature < trip->temperature)
> > +             return 0;
> > +
> > +     for (i = 0; i < tz->num_trips - 1; i++) {
> > +             trip++;
> > +             if (tz->temperature < trip->temperature)
> >                       break;
> >       }
>
> Is it possible to use for_each_thermal_trip() instead ? That would make
> the code more self-encapsulate

It is possible in principle, but this is a governor which is regarded
as part of the core, isn't it?

So is an extra overhead related to using a callback (which may be
subject to retpolines and such) really justified in this case?

>
> > -     /*
> > -      * count > 0 only if temperature is greater than first trip
> > -      * point, in which case, trip_point = count - 1
> > -      */
> > -     if (count > 0)
> > -             trace_thermal_zone_trip(tz, count - 1, trip.type);
> > +     trace_thermal_zone_trip(tz, i, tz->trips[i].type);
> >
> > -     return count;
> > +     return i;
> >   }
> >
> >   static long get_target_state(struct thermal_zone_device *tz,
> >
> >
> >
>
> --
