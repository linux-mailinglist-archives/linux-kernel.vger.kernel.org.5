Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13997FFB69
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbjK3TdW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 14:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376422AbjK3TdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:33:20 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C893;
        Thu, 30 Nov 2023 11:33:27 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6cb90b33c1dso291023b3a.0;
        Thu, 30 Nov 2023 11:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701372806; x=1701977606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mg9NX8SmvZzhqz4CJUk+NYEDY+XieW5G5uysa9/nGSM=;
        b=IBuBgLG4fm9VyYldyehYdT2F2xy4jovaVfyailPycy42bWwiBbhd8qno7/2xxIACNB
         Lzoz4julf6aAQljSwV8NVLTUYINa0rJKsDoSUMxxtKnaknskjUq69x/Q8ThHiKGgJPsX
         Kg2UyEQd4WIM3qHPFdUZdys87Nv4bsLuiRYed8UwvzAK0+KrYGb0ji8BHvT++wf47R2h
         vbrqoOMiyVWKLmhxUH21mtv8FPTqo04Lk4UI0N1xYgwA/m602r8J3Pr55z6DloE2lCOs
         qoRYX3422x20bBwc0EPu8K32S1unZ5ixZdsAT2KGtGvRBFzWyMRBu2p1jNMpcOI0VhKX
         aQ5A==
X-Gm-Message-State: AOJu0Yy7jQgEghpAamPrgh9wFL2Wh0VR/zAqFrPHmPEddwh57cUfabsF
        5wPh1YJe6Xa+MFwRwTaa1NXZvfEL9BpfCvJXC2s=
X-Google-Smtp-Source: AGHT+IFRJohRl++SrBlukWA7FCdD8FQgGsoANEZiosMnB/Z2DDlSy6kJ6zoVeCNsaiz4EmIddDfm5r30r3KVLb57OW8=
X-Received: by 2002:a05:6a00:3a19:b0:6cb:8347:c8b1 with SMTP id
 fj25-20020a056a003a1900b006cb8347c8b1mr27778157pfb.1.1701372806544; Thu, 30
 Nov 2023 11:33:26 -0800 (PST)
MIME-Version: 1.0
References: <5754079.DvuYhMxLoT@kreacher> <2933888.e9J7NaK4W3@kreacher>
In-Reply-To: <2933888.e9J7NaK4W3@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Nov 2023 20:33:14 +0100
Message-ID: <CAJZ5v0iSvhaCeZaDShRKnk93=jwcQWnJuqfL9grWyQm4YHaAYw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: sysfs: Eliminate unnecessary zone locking
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Nov 30, 2023 at 7:38 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The _show() callback functions of the trip point sysfs attributes,
> temperature, hysteresis and type, need not use thermal zone locking,
> because the layout of the data structures they access does not change
> after the thermal zone registration.
>
> Namely, they all need to access a specific entry in the thermal
> zone's trips[] table that is always present for non-tripless thermal
> zones and its size cannot change after the thermal zone has been
> registered.  Thus it is always safe to access the trips[] table of a
> registered thermal zone from each of the sysfs attributes in question.
>
> Moreover, the type of a trip point does not change after registering its
> thermal zone, and while its temperature and hysteresis can change, for
> example due to a firmware-induced thermal zone update, holding the zone
> lock around reading them is pointless, because it does not prevent stale
> values from being returned to user space.  For example, a trip point
> temperature can always change ater trip_point_temp_show() has read it
> and before the function's return statement is executed, regardless of
> whether or not zone locking is used.
>
> For this reason, drop the zone locking from trip_point_type_show(),
> trip_point_temp_show(), and trip_point_hyst_show().
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/thermal_sysfs.c |   60 ++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 39 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -83,25 +83,18 @@ trip_point_type_show(struct device *dev,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       struct thermal_trip trip;
> -       int trip_id, result;
> +       int trip_id;
> +
> +       if (!device_is_registered(dev))
> +               return -ENODEV;
>
>         if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
>                 return -EINVAL;
>
> -       mutex_lock(&tz->lock);
> -
> -       if (device_is_registered(dev))
> -               result = __thermal_zone_get_trip(tz, trip_id, &trip);
> -       else
> -               result = -ENODEV;
> -
> -       mutex_unlock(&tz->lock);
> -
> -       if (result)
> -               return result;
> +       if (trip_id < 0 || trip_id > tz->num_trips)

An off-by-one here, it should be trip_id >= tz->num_trips (and
analogously below).

I'll send an update of this shortly.

> +               return -EINVAL;
>
> -       switch (trip.type) {
> +       switch (tz->trips[trip_id].type) {
>         case THERMAL_TRIP_CRITICAL:
>                 return sprintf(buf, "critical\n");
>         case THERMAL_TRIP_HOT:
> @@ -164,25 +157,18 @@ trip_point_temp_show(struct device *dev,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       struct thermal_trip trip;
> -       int trip_id, ret;
> +       int trip_id;
> +
> +       if (!device_is_registered(dev))
> +               return -ENODEV;
>
>         if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>                 return -EINVAL;
>
> -       mutex_lock(&tz->lock);
> -
> -       if (device_is_registered(dev))
> -               ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -       else
> -               ret = -ENODEV;
> -
> -       mutex_unlock(&tz->lock);
> -
> -       if (ret)
> -               return ret;
> +       if (trip_id < 0 || trip_id > tz->num_trips)
> +               return -EINVAL;
>
> -       return sprintf(buf, "%d\n", trip.temperature);
> +       return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
>  }
>
>  static ssize_t
> @@ -234,22 +220,18 @@ trip_point_hyst_show(struct device *dev,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       struct thermal_trip trip;
> -       int trip_id, ret;
> +       int trip_id;
> +
> +       if (!device_is_registered(dev))
> +               return -ENODEV;
>
>         if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>                 return -EINVAL;
>
> -       mutex_lock(&tz->lock);
> -
> -       if (device_is_registered(dev))
> -               ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> -       else
> -               ret = -ENODEV;
> -
> -       mutex_unlock(&tz->lock);
> +       if (trip_id < 0 || trip_id > tz->num_trips)
> +               return -EINVAL;
>
> -       return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
> +       return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
>  }
>
>  static ssize_t
>
>
>
>
