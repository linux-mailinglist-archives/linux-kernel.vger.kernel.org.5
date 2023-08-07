Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057A772A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjHGQXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjHGQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:23:49 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B421998;
        Mon,  7 Aug 2023 09:23:18 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d279a4d5cso930601eaf.1;
        Mon, 07 Aug 2023 09:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425395; x=1692030195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pixDtAKy9Cw9KBr/6zRS3zidTud25upCpNKC+6ucwwo=;
        b=bockYbKMgM2lI8LWSQ9MjvWY6pAvnM9ckGwbWSKW3tdLjHo5jSVdtisww40hiYYZlb
         07LpJMV/hPVJ/ah/ZdiptXEWjr1FDHnxMmRu8HBCbtyNOORuWC5AYOmNofWjxmFdKp3T
         PtdIBwHR9YgoeCtxkRBSAKrb1dwAxvOzEB21FJ3iUf8qoTi8B5eNWJyYRm/OIbzEDf5h
         CmUx54CkC+owIqi6v2NJke7IYHVgPxZ+ZM0oSo+taeeBF3A99kA8mn7zDPRj8LFI6MaI
         Dz+5MaOTc9k97E1VRfLTxkD2A+UhYBu1f0cqwQTOLva46q8Lx+qv86wDqVS7itOB13ku
         FWsw==
X-Gm-Message-State: ABy/qLZ7G2Y9WNbFjOJ8IAiVhrTXnsxQLESDvNkv8Oo5tz8LHqIa3yso
        0WSy1cYcY5+fnV8KG1RkSWHRWeZm1kNuW3kJ3pI=
X-Google-Smtp-Source: APBJJlHbvF3yWA3mA4oVBthg1hng2+YLoXoVfXq1/srfY6aj3fsDtqPAHqkk6+gqSzJomc20Qu/dZQnMP2G23BFFvJ8=
X-Received: by 2002:a4a:e251:0:b0:566:951e:140c with SMTP id
 c17-20020a4ae251000000b00566951e140cmr17567127oot.1.1691425395557; Mon, 07
 Aug 2023 09:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <1967710.PYKUYFuaPT@kreacher> <f47b7e17-7ec6-4c19-9db1-c1a2e1ad66b6@linaro.org>
 <CAJZ5v0iNOD9FW0deZYvfjmB8Us+7KjTNnB8Fkm=nnVJ6a82EZQ@mail.gmail.com> <4bfabfce-574b-ed52-2956-d0d2b9502e60@linaro.org>
In-Reply-To: <4bfabfce-574b-ed52-2956-d0d2b9502e60@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 18:23:04 +0200
Message-ID: <CAJZ5v0hzSLS1wu6QF1SakrzL3242e_Xy7HjZiA-N8w-g8H=81A@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] thermal: core: Add thermal_zone_update_trip_temp()
 helper routine
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Mon, Aug 7, 2023 at 6:17 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 07/08/2023 17:40, Rafael J. Wysocki wrote:
> > On Mon, Aug 7, 2023 at 1:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 04/08/2023 23:05, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Introduce a helper routine called thermal_zone_update_trip_temp() that
> >>> can be used to update a trip point's temperature with the help of a
> >>> pointer to local data associated with that trip point provided by
> >>> the thermal driver that created it.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> New patch in v4.
> >>>
> >>> ---
> >>>    drivers/thermal/thermal_trip.c |   37 +++++++++++++++++++++++++++++++++++++
> >>>    include/linux/thermal.h        |    4 ++++
> >>>    2 files changed, 41 insertions(+)
> >>>
> >>> Index: linux-pm/drivers/thermal/thermal_trip.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> >>> +++ linux-pm/drivers/thermal/thermal_trip.c
> >>> @@ -180,3 +180,40 @@ int thermal_zone_set_trip(struct thermal
> >>>
> >>>        return 0;
> >>>    }
> >>> +
> >>> +/**
> >>> + * thermal_zone_update_trip_temp - Update the trip point temperature.
> >>> + * @tz: Thermal zone.
> >>> + * @trip_priv: Trip tag.
> >>> + * @temp: New trip temperature.
> >>> + *
> >>> + * This only works for thermal zones using trip tables and its caller must
> >>> + * ensure that the zone lock is held before using it.
> >>> + *
> >>> + * @trip_priv is expected to be the value that has been stored by the driver
> >>> + * in the struct thermal_trip representing the trip point in question, so it
> >>> + * can be matched against the value of the priv field in that structure.
> >>> + *
> >>> + * If @trip_priv does not match any trip point in the trip table of @tz,
> >>> + * nothing happens.
> >>> + */
> >>> +void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
> >>> +                                void *trip_priv, int temperature)
> >>> +{
> >>> +     int i;
> >>> +
> >>> +     lockdep_assert_held(&tz->lock);
> >>> +
> >>> +     if (!tz->trips || !trip_priv)
> >>> +             return;
> >>> +
> >>> +     for (i = 0; i < tz->num_trips; i++) {
> >>> +             struct thermal_trip *trip = &tz->trips[i];
> >>> +
> >>> +             if (trip->priv == trip_priv) {
> >>> +                     trip->temperature = temperature;
> >>> +                     return;
> >>> +             }
> >>> +     }
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(thermal_zone_update_trip_temp);
> >>
> >> This function would imply the comparator is always trip->priv but if we
> >> want another comparison eg. trip->priv->id, that won't be possible.
> >>
> >> Actually, I think you can reuse an existing function with a simple
> >> change, for_each_thermal_trip() located in thermal_core.h.
> >
> > for_each_thermal_trip() is only defined in tools/lib/thermal/thermal.c
> > AFAICS, but this one could actually work, so I can copy that
> > definition to somewhere else.
> >
> > But I suppose that you mean __for_each_thermal_trip() which won't
> > work, because it makes a copy of the trip and passes that to the
> > callback, but the callback would need to update the temperature of the
> > original trip.
> >
> > It would work if it passed the original trip to the caller, so I can
> > add something like that.
>
> As there is no user of this function yet, I think you can change that to
> use the trip array instead of the __thermal_zone_get_trip(). This one
> was used to have a compatibility with thermal zones using get_trip_* ops
> but that is not really needed and with your series only one driver will
> remain before dropping these ops.

Sounds good.

> >> The changes would be renaming it without the '__' prefix and moving it
> >> in include/linux/thermal.h.
> >>
> >> Then the comparison function and the temperature change can be an ACPI
> >> driver specific callback passed as parameter to for_each_thermal_zone
> >
> > I guess you mean for_each_thermal_trip().
>
> Yes, __for_each_thermal_trip()

OK
