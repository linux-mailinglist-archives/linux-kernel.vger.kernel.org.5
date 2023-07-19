Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787B2759DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGSSuR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 14:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGSSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:50:15 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1218B6;
        Wed, 19 Jul 2023 11:50:14 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-98dfd15aae1so1078066b.0;
        Wed, 19 Jul 2023 11:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792613; x=1690397413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04YX9R3mG7CuWz76OohlmuJRDoflU0LoC/zLXWiywQ0=;
        b=PAKwjSDjk1UTM7ukFkHNH7ZIRoiDhI7k8dwEjeG/V9q7vwqyH/xXFs3aWLlZQmD0Dq
         Wurr0ufblsyFoe0lssQ5LbGpM7b3vzuIgJ/nOtwhrEtjopvQZlhdfsfM6cnetjqfhuU/
         fUXZBoGi143DpkEFoLCqC+9UZaOeU/4GF9bBAPi94lZ2SvFHib4DjATOEqBrhYWQaJox
         /v/sxAw4dt3yQHFynU01aUuW6tONJ2VXeC6CPuGXPbfpRSe5YD4JW4fwOTSoeV5+ulBb
         FZ8LpHOuCUAeAdch0+rirzS665B+DpTF71dxliagsU6/GcbknPVX9wNIbE6atb2NhkRJ
         HTPA==
X-Gm-Message-State: ABy/qLZ+H/dPncKr9ySoEO1Qta1lSf1qzjdWKmIt2ADl0uGnGEFCkZgF
        pZTqGligaEyRDgKwM9znwJq7R/4RnKnofskm54iOIg0V
X-Google-Smtp-Source: APBJJlHgHeKbdvSsNplqi4vWbixWg+++up+haAXbtRAIyyTIz89ixN+GxcA8YMcmgzYGSYjlhGvshRP7V6anXRo3HdM=
X-Received: by 2002:a17:906:5192:b0:994:1808:176b with SMTP id
 y18-20020a170906519200b009941808176bmr318089ejk.6.1689792612991; Wed, 19 Jul
 2023 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <9147669.CDJkKcVGEf@kreacher>
In-Reply-To: <9147669.CDJkKcVGEf@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jul 2023 20:50:01 +0200
Message-ID: <CAJZ5v0jWQHq-YSQtsOPeriH1_7-3gFQvNHawv7J9D8rzxXichQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] ACPI: thermal: Rework thermal_get_trend()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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

On Tue, Jul 18, 2023 at 8:21 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Rework the ACPI thermal driver's .get_trend() callback function,
> thermal_get_trend(), to use trip point data stored in the generic
> trip structures instead of calling thermal_get_trip_type() and
> thermal_get_trip_temp() and make it hold thermal_check_lock to
> protect against possible races against trip point updates.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |  107 +++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 78 insertions(+), 29 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -572,47 +572,96 @@ static int thermal_get_crit_temp(struct
>         return -EINVAL;
>  }
>
> +static struct thermal_trip *acpi_thermal_get_trip(struct acpi_thermal *tz,
> +                                          int trip_index)
> +{
> +       struct thermal_trip *trip;
> +       int i;
> +
> +       if (!tz || trip_index < 0)
> +               return NULL;
> +
> +       trip = tz->trips.critical.trip_ref.trip;
> +       if (trip) {
> +               if (!trip_index)
> +                       return trip;
> +
> +               trip_index--;
> +       }
> +
> +       trip = tz->trips.hot.trip_ref.trip;
> +       if (trip) {
> +               if (!trip_index)
> +                       return trip;
> +
> +               trip_index--;
> +       }
> +
> +       trip = tz->trips.passive.trip_ref.trip;
> +       if (trip) {
> +               if (!trip_index)
> +                       return trip;
> +
> +               trip_index--;
> +       }
> +
> +       for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> +               trip = tz->trips.active[i].trip_ref.trip;
> +               if (trip) {
> +                       if (!trip_index)
> +                               return trip;
> +
> +                       trip_index--;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
>  static int thermal_get_trend(struct thermal_zone_device *thermal,
> -                            int trip, enum thermal_trend *trend)
> +                            int trip_index, enum thermal_trend *trend)
>  {
>         struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
> -       enum thermal_trip_type type;
> -       int i;
> +       struct thermal_trip *trip;
> +       int ret = 0;
>
> -       if (thermal_get_trip_type(thermal, trip, &type))
> -               return -EINVAL;
> +       mutex_lock(&tz->thermal_check_lock);
>
> -       if (type == THERMAL_TRIP_ACTIVE) {
> -               int trip_temp;
> +       trip = acpi_thermal_get_trip(tz, trip_index);
> +       if (!trip) {

This should also return an error for trips with invalid temperature.

Moreover, an error should be returned for the critical and hot trips,
because it doesn't make sense to deal with them here.

It looks like a new version of this patch is needed.

> +               ret = -EINVAL;
> +               goto out;
> +       }
> +       if (trip->type == THERMAL_TRIP_ACTIVE) {
>                 int temp = deci_kelvin_to_millicelsius_with_offset(
>                                         tz->temperature, tz->kelvin_offset);
> -               if (thermal_get_trip_temp(thermal, trip, &trip_temp))
> -                       return -EINVAL;
>
> -               if (temp > trip_temp) {
> +               if (temp > trip->temperature)
>                         *trend = THERMAL_TREND_RAISING;
> -                       return 0;
> -               } else {
> -                       /* Fall back on default trend */
> -                       return -EINVAL;
> -               }
> +               else /* Fall back on default trend */
> +                       ret = -EINVAL;
> +       } else {
> +               /*
> +                * tz->temperature has already been updated by generic thermal
> +                * layer, before this callback being invoked.
> +                */
> +               int i = tz->trips.passive.tc1 * (tz->temperature -
> +                               tz->last_temperature) +
> +                       tz->trips.passive.tc2 * (tz->temperature -
> +                               tz->trips.passive.temperature);
> +
> +               if (i > 0)
> +                       *trend = THERMAL_TREND_RAISING;
> +               else if (i < 0)
> +                       *trend = THERMAL_TREND_DROPPING;
> +               else
> +                       *trend = THERMAL_TREND_STABLE;
>         }
>
> -       /*
> -        * tz->temperature has already been updated by generic thermal layer,
> -        * before this callback being invoked
> -        */
> -       i = tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature) +
> -           tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature);
> -
> -       if (i > 0)
> -               *trend = THERMAL_TREND_RAISING;
> -       else if (i < 0)
> -               *trend = THERMAL_TREND_DROPPING;
> -       else
> -               *trend = THERMAL_TREND_STABLE;
> +out:
> +       mutex_unlock(&tz->thermal_check_lock);
>
> -       return 0;
> +       return ret;
>  }
>
>  static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)
>
>
>
