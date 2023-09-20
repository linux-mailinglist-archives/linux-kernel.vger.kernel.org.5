Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3B7A82E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjITNHF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 09:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjITNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:06:37 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072E119;
        Wed, 20 Sep 2023 06:06:30 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b3e03afa7so61708eaf.1;
        Wed, 20 Sep 2023 06:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215189; x=1695819989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+pSJMMIxWoPf9Ez4RY8fPdFg8lZuFnc7YIxoUqbklQ=;
        b=EnvDP3N0gNkH1G2gI5AidOI4DCW2rAJP53W10Z4ksG6ftCcXBNwdKVmX6NQZ/NyUml
         uldxi/QNlQaMMEQiaNwo+IqYR/Y1VK3B9a5TOsnw42uoM1Gdm957xwh08znKoiBVWWd5
         Ry+rUwo74ECYDMwNVVKBSK+CgANHzVGEQfuyzZxFCJNPNYuU8Lf6XqYfXK3Ns34Wv3qJ
         Vj5Pk4hVUNMOUel8lYnP7cuWSeTbEY/CxHB01u4JFpSpOXuXGodmMb6qKBAEau5Sb3p8
         g8hhNXTZfLyyW7FcbWXHB2XFVJ51cdYeXLDLvG6+rB5lA+Kg7BAQiIxxRaa4qbNfPHCg
         B3zg==
X-Gm-Message-State: AOJu0Yy0oZFY82UcXriIYzO1YkZiAIGWGO+DnLMZtwR0g7TOr5Dq3jHf
        rqpMiDyFLClSUZMHI5vyWBgf7gLCmnHClvekh5g8CcGw8yk=
X-Google-Smtp-Source: AGHT+IEVZPg5Hs7mfyDIpauU/1JDC6TVrCRVHBrnRYNuVjkUooYPGuxoPJueQom/ARY5zgWwVdxqCkiZMHN4ybrVVuk=
X-Received: by 2002:a4a:2a4e:0:b0:573:3a3b:594b with SMTP id
 x14-20020a4a2a4e000000b005733a3b594bmr2221958oox.1.1695215189281; Wed, 20 Sep
 2023 06:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <5708760.DvuYhMxLoT@kreacher> <22010294.EfDdHjke4D@kreacher>
In-Reply-To: <22010294.EfDdHjke4D@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Sep 2023 15:06:18 +0200
Message-ID: <CAJZ5v0gjWhY8AnipzMEgLOp1hsKT6c0PKKKtE+OYSsp0OMxT6w@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] ACPI: thermal: Untangle initialization and updates
 of active trips
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

On Tue, Sep 12, 2023 at 8:47 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Separate the code needed to update active trips (in a response to a
> notification from the platform firmware) as well as to initialize them
> from the code that is only necessary for their initialization and
> cleanly divide it into functions that each carry out a specific action.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c |  197 ++++++++++++++++++++++++-------------------------
>  1 file changed, 100 insertions(+), 97 deletions(-)
>
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -184,94 +184,6 @@ static int acpi_thermal_temp(struct acpi
>                                                        tz->kelvin_offset);
>  }
>
> -static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
> -{
> -       acpi_status status;
> -       unsigned long long tmp;
> -       struct acpi_handle_list devices;
> -       bool valid = false;
> -       int i;
> -
> -       /* Active (optional) */
> -       for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> -               char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
> -               valid = tz->trips.active[i].trip.valid;
> -
> -               if (act == -1)
> -                       break; /* disable all active trip points */
> -
> -               if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
> -                   tz->trips.active[i].trip.valid)) {
> -                       status = acpi_evaluate_integer(tz->device->handle,
> -                                                      name, NULL, &tmp);
> -                       if (ACPI_FAILURE(status)) {
> -                               tz->trips.active[i].trip.valid = false;
> -                               if (i == 0)
> -                                       break;
> -
> -                               if (act <= 0)
> -                                       break;
> -
> -                               if (i == 1)
> -                                       tz->trips.active[0].trip.temperature =
> -                                                       celsius_to_deci_kelvin(act);
> -                               else
> -                                       /*
> -                                        * Don't allow override higher than
> -                                        * the next higher trip point
> -                                        */
> -                                       tz->trips.active[i-1].trip.temperature =
> -                                               min_t(unsigned long,
> -                                                     tz->trips.active[i-2].trip.temperature,
> -                                                     celsius_to_deci_kelvin(act));
> -
> -                               break;
> -                       } else {
> -                               tz->trips.active[i].trip.temperature = tmp;
> -                               tz->trips.active[i].trip.valid = true;
> -                       }
> -               }
> -
> -               name[2] = 'L';
> -               if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].trip.valid) {
> -                       memset(&devices, 0, sizeof(struct acpi_handle_list));
> -                       status = acpi_evaluate_reference(tz->device->handle,
> -                                                        name, NULL, &devices);
> -                       if (ACPI_FAILURE(status)) {
> -                               acpi_handle_info(tz->device->handle,
> -                                                "Invalid active%d threshold\n", i);
> -                               tz->trips.active[i].trip.valid = false;
> -                       } else {
> -                               tz->trips.active[i].trip.valid = true;
> -                       }
> -
> -                       if (memcmp(&tz->trips.active[i].devices, &devices,
> -                                  sizeof(struct acpi_handle_list))) {
> -                               memcpy(&tz->trips.active[i].devices, &devices,
> -                                      sizeof(struct acpi_handle_list));
> -                               ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
> -                       }
> -               }
> -               if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
> -                       if (valid != tz->trips.active[i].trip.valid)
> -                               ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
> -
> -               if (!tz->trips.active[i].trip.valid)
> -                       break;
> -       }
> -
> -       if (flag & ACPI_TRIPS_DEVICES) {
> -               memset(&devices, 0, sizeof(devices));
> -               status = acpi_evaluate_reference(tz->device->handle, "_TZD",
> -                                                NULL, &devices);
> -               if (ACPI_SUCCESS(status) &&
> -                   memcmp(&tz->devices, &devices, sizeof(devices))) {
> -                       tz->devices = devices;
> -                       ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
> -               }
> -       }
> -}
> -
>  static void update_acpi_thermal_trip_temp(struct acpi_thermal_trip *acpi_trip,
>                                           int temp)
>  {
> @@ -338,6 +250,78 @@ static void acpi_thermal_update_passive_
>         ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "state");
>  }
>
> +static long get_active_temp(struct acpi_thermal *tz, int index)
> +{
> +       char method[] = { '_', 'A', 'C', '0' + index, '\0' };
> +       unsigned long long tmp;
> +       acpi_status status;
> +
> +       status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
> +       if (ACPI_FAILURE(status))
> +               return THERMAL_TEMP_INVALID;
> +
> +       /*
> +        * If an override has been provided, apply it so there are no active
> +        * trips with thresholds greater than the override.
> +        */
> +       if (act > 0) {
> +               unsigned long long override = celsius_to_deci_kelvin(act);
> +
> +               if (tmp > override)
> +                       tmp = override;
> +       }
> +       return tmp;
> +}
> +
> +static void acpi_thermal_update_active_trip(struct acpi_thermal *tz, int index)
> +{
> +       struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
> +
> +       if (!acpi_trip->valid)
> +               return;
> +
> +       update_acpi_thermal_trip_temp(acpi_trip, get_active_temp(tz, index));
> +       if (!acpi_trip->valid)
> +               ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "state");
> +}
> +
> +static bool update_active_devices(struct acpi_thermal *tz, int index, bool compare)
> +{
> +       char method[] = { '_', 'A', 'L', '0' + index, '\0' };
> +       struct acpi_handle_list devices;
> +       acpi_status status;
> +
> +       memset(&devices, 0, sizeof(devices));
> +
> +       status = acpi_evaluate_reference(tz->device->handle, method, NULL, &devices);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_handle_info(tz->device->handle,
> +                                "Missing device list for active threshold %d\n",
> +                                index);
> +               return false;
> +       }
> +
> +       if (compare && memcmp(&tz->trips.active[index].devices, &devices, sizeof(devices)))
> +               ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "device");
> +
> +       memcpy(&tz->trips.active[index].devices, &devices, sizeof(devices));
> +       return true;
> +}
> +
> +static void acpi_thermal_update_active_devices(struct acpi_thermal *tz, int index)
> +{
> +       struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
> +
> +       if (!acpi_trip->valid)
> +               return;
> +
> +       if (update_active_devices(tz, index, true))
> +               return;
> +
> +       update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
> +       ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "state");
> +}
> +
>  static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
>  {
>         struct acpi_thermal_trip *acpi_trip = trip->priv;
> @@ -358,18 +342,18 @@ static void acpi_thermal_adjust_thermal_
>                                              unsigned long data)
>  {
>         struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
> -       int flag;
> +       int i;
>
>         if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
>                 acpi_thermal_update_passive_trip(tz);
> -               flag = ACPI_TRIPS_THRESHOLDS;
> +               for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +                       acpi_thermal_update_active_trip(tz, i);
>         } else {
>                 acpi_thermal_update_passive_devices(tz);
> -               flag = ACPI_TRIPS_DEVICES;
> +               for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
> +                       acpi_thermal_update_active_devices(tz, i);
>         }
>
> -       __acpi_thermal_trips_update(tz, flag);
> -
>         for_each_thermal_trip(tz->thermal_zone, acpi_thermal_adjust_trip, tz);
>  }
>
> @@ -498,6 +482,28 @@ fail:
>         return false;
>  }
>
> +static bool acpi_thermal_init_active_trip(struct acpi_thermal *tz, int index)
> +{
> +       long temp;
> +
> +       if (act == -1)
> +               goto fail;
> +
> +       temp = get_active_temp(tz, index);
> +       if (temp == THERMAL_TEMP_INVALID)
> +               goto fail;
> +
> +       if (!update_active_devices(tz, false, index))

This should be

      if (!update_active_devices(tz, index, false))

and I've already fixed it in the tree.

> +               goto fail;
> +
> +       update_acpi_thermal_trip_temp(&tz->trips.active[index].trip, temp);
> +       return true;
> +
> +fail:
> +       update_acpi_thermal_trip_temp(&tz->trips.active[index].trip, THERMAL_TEMP_INVALID);
> +       return false;
> +}
> +
>  static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
>  {
>         unsigned int count = 0;
> @@ -506,11 +512,8 @@ static int acpi_thermal_get_trip_points(
>         if (acpi_thermal_init_passive_trip(tz))
>                 count++;
>
> -       /* Active trip points (optional). */
> -       __acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
> -
>         for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> -               if (tz->trips.active[i].trip.valid)
> +               if (acpi_thermal_init_active_trip(tz, i))
>                         count++;
>                 else
>                         break;
>
>
>
