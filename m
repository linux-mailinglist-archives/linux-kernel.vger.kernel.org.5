Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2843E759DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGSSqg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGSSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:46:34 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F231BF6;
        Wed, 19 Jul 2023 11:46:33 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3145fcecef6so1764216f8f.0;
        Wed, 19 Jul 2023 11:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792391; x=1690397191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ByvbQMuYrnzmBQu7LqbeEUJHEjEfKu2/AoamfTxq6E=;
        b=DhNnjhODwlZDvPHwxHCEHmD2wVKNZM0IrpKE2dqON1piryqvak4Qpd80xguaYElnec
         PVu75vCiJ52BQ8mBO4jbTbjlpU63aHNHnqurCmEGE1y2DztLNZUdlhHSG1r4VlEILm0k
         Ckw4Is8ETRxa5/2Kpz8luQanG+tgL5brXm/4WKdunTINf6CyXwNRCpC/iuMBMQ9LB4z9
         Am4wGTar6o4mED0f1oVAdVEwg/Tw448r6X3HzXziDNMMxt2P+QV4z7+eSNcS0de51Y2+
         +kx9JjY06+XPNTf+vOpqyeBH6w8w9FqUm604lf9EHorjPXm+CViQ2JTxN2/j0SZfFAJQ
         4Ovw==
X-Gm-Message-State: ABy/qLbvyLfwp+ZUoiWjD26uu58h3AbFQ+hDFhlwfa78febwUf2KG0va
        kErZoy+WveSC4bYqQ18PzvZgRlwWoaXg6BagyETddiF1
X-Google-Smtp-Source: APBJJlGIe6HC12q1fgC+FWQlqMdQg8rAOB93G8hsFO73c7PoLDgp+aFvhRb10bzo537cBWmvUwlJzVKyC0S3VpHKMk4=
X-Received: by 2002:adf:e3c6:0:b0:317:943:8e1a with SMTP id
 k6-20020adfe3c6000000b0031709438e1amr541699wrm.1.1689792391238; Wed, 19 Jul
 2023 11:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <3760707.kQq0lBPeGt@kreacher>
In-Reply-To: <3760707.kQq0lBPeGt@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jul 2023 20:46:20 +0200
Message-ID: <CAJZ5v0gEhR6q=O-qCyX-H+uMqDUKJ1YeAo6hZcAS4bhZ9StOXA@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] ACPI: thermal: Use trip point table to register
 thermal zones
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 8:21 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make the ACPI thermal driver use thermal_zone_device_register_with_trips()
> to register its thermal zones.
>
> For this purpose, make it create a trip point table and pass it to
> thermal_zone_device_register_with_trips() as an argument and use the
> struct thermal_trip_ref introduced previously to connect the generic
> thermal trip structures to the internal data structures representing
> trip points in the driver.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -93,16 +93,19 @@ MODULE_PARM_DESC(psv, "Disable or overri
>  static struct workqueue_struct *acpi_thermal_pm_queue;
>
>  struct acpi_thermal_critical {
> +       struct thermal_trip_ref trip_ref;
>         unsigned long temperature;
>         bool valid;
>  };
>
>  struct acpi_thermal_hot {
> +       struct thermal_trip_ref trip_ref;
>         unsigned long temperature;
>         bool valid;
>  };
>
>  struct acpi_thermal_passive {
> +       struct thermal_trip_ref trip_ref;
>         struct acpi_handle_list devices;
>         unsigned long temperature;
>         unsigned long tc1;
> @@ -112,6 +115,7 @@ struct acpi_thermal_passive {
>  };
>
>  struct acpi_thermal_active {
> +       struct thermal_trip_ref trip_ref;
>         struct acpi_handle_list devices;
>         unsigned long temperature;
>         bool valid;
> @@ -133,6 +137,7 @@ struct acpi_thermal {
>         unsigned long polling_frequency;
>         volatile u8 zombie;
>         struct acpi_thermal_trips trips;
> +       struct thermal_trip *trip_table;
>         struct acpi_handle_list devices;
>         struct thermal_zone_device *thermal_zone;
>         int kelvin_offset;      /* in millidegrees */
> @@ -186,6 +191,18 @@ static int acpi_thermal_get_polling_freq
>         return 0;
>  }
>
> +static void acpi_thermal_trip_set_temp(struct acpi_thermal *tz,
> +                                      struct thermal_trip *trip,
> +                                      long temperature)
> +{
> +       /* Ignore unititialized trips */
> +       if (!trip)
> +               return;

This check is actually redundant, because the function never receives
a NULL trip argument.

I'll drop it.

> +
> +       trip->temperature = deci_kelvin_to_millicelsius_with_offset(temperature,
> +                                                                   tz->kelvin_offset);
> +}
> +
>  static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>  {
>         acpi_status status;
> @@ -745,6 +762,7 @@ static void acpi_thermal_zone_sysfs_remo
>
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>  {
> +       struct thermal_trip *trip;
>         int passive_delay = 0;
>         int trip_count = 0;
>         int result;
> @@ -765,10 +783,52 @@ static int acpi_thermal_register_thermal
>         for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++)
>                 trip_count++;
>
> -       tz->thermal_zone = thermal_zone_device_register("acpitz", trip_count, 0,
> -                                                       tz, &acpi_thermal_zone_ops,
> -                                                       NULL, passive_delay,
> -                                                       tz->polling_frequency * 100);
> +       tz->trip_table = kcalloc(trip_count, sizeof(*tz->trip_table), GFP_KERNEL);
> +       if (!tz->trip_table)
> +               return -ENOMEM;
> +
> +       trip = tz->trip_table;
> +
> +       if (tz->trips.critical.valid) {
> +               trip->type = THERMAL_TRIP_CRITICAL;
> +               acpi_thermal_trip_set_temp(tz, trip,
> +                                          tz->trips.critical.temperature);
> +               trip->driver_ref = &tz->trips.critical.trip_ref;
> +               trip++;
> +       }
> +
> +       if (tz->trips.hot.valid) {
> +               trip->type = THERMAL_TRIP_HOT;
> +               acpi_thermal_trip_set_temp(tz, trip,
> +                                          tz->trips.hot.temperature);
> +               trip->driver_ref = &tz->trips.hot.trip_ref;
> +               trip++;
> +       }
> +
> +       if (tz->trips.passive.valid) {
> +               trip->type = THERMAL_TRIP_PASSIVE;
> +               acpi_thermal_trip_set_temp(tz, trip,
> +                                          tz->trips.passive.temperature);
> +               trip->driver_ref = &tz->trips.passive.trip_ref;
> +               trip++;
> +       }
> +
> +       for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
> +               trip->type = THERMAL_TRIP_ACTIVE;
> +               acpi_thermal_trip_set_temp(tz, trip,
> +                                          tz->trips.active[i].temperature);
> +               trip->driver_ref = &tz->trips.active[i].trip_ref;
> +               trip++;
> +       }
> +
> +       tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
> +                                                                  tz->trip_table,
> +                                                                  trip_count,
> +                                                                  0, tz,
> +                                                                  &acpi_thermal_zone_ops,
> +                                                                  NULL,
> +                                                                  passive_delay,
> +                                                                  tz->polling_frequency * 100);
>         if (IS_ERR(tz->thermal_zone))
>                 return -ENODEV;
>
> @@ -806,6 +866,7 @@ static void acpi_thermal_unregister_ther
>  {
>         acpi_thermal_zone_sysfs_remove(tz);
>         thermal_zone_device_unregister(tz->thermal_zone);
> +       kfree(tz->trip_table);
>         tz->thermal_zone = NULL;
>         acpi_bus_detach_private_data(tz->device->handle);
>  }
> @@ -939,6 +1000,9 @@ static void acpi_thermal_check_fn(struct
>  {
>         struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
>                                                thermal_check_work);
> +       struct thermal_trip *trip;
> +       long temperature;
> +       int i;
>
>         /*
>          * In general, it is not sufficient to check the pending bit, because
> @@ -953,6 +1017,34 @@ static void acpi_thermal_check_fn(struct
>
>         mutex_lock(&tz->thermal_check_lock);
>
> +       trip = tz->trips.passive.trip_ref.trip;
> +       if (trip) {
> +               /*
> +                * This means that the passive trip was valid initially, so
> +                * update its temperature in case it has changed or the trip
> +                * has become invalid.
> +                */
> +               temperature = tz->trips.passive.valid ?
> +                               tz->trips.passive.temperature :
> +                               THERMAL_TEMP_INVALID;
> +               acpi_thermal_trip_set_temp(tz, trip, temperature);
> +       }
> +
> +       for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> +               trip = tz->trips.active[i].trip_ref.trip;
> +               if (trip) {
> +                       /*
> +                        * This means that the active trip #i was valid
> +                        * initially, so update its temperature in case it has
> +                        * changed or the trip has become invalid.
> +                        */
> +                       temperature = tz->trips.active[i].valid ?
> +                                       tz->trips.active[i].temperature :
> +                                       THERMAL_TEMP_INVALID;
> +                       acpi_thermal_trip_set_temp(tz, trip, temperature);
> +               }
> +       }
> +
>         thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
>
>         refcount_inc(&tz->thermal_check_count);
>
>
>
