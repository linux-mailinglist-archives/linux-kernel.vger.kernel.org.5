Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216A88110B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378750AbjLMMCA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 07:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjLMMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:01:58 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42BB0;
        Wed, 13 Dec 2023 04:02:04 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5909156aea9so776116eaf.0;
        Wed, 13 Dec 2023 04:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702468924; x=1703073724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEAmrfWfgZx6bB3/5cn+QWsBw2i2koXTN0PXN9whVn8=;
        b=nYU5OVKO5EfPB7T8KVDLps6h/cH/bhh7NPPEnQPKGHEeW8peatYEehdpFEd5cFn5n4
         YLJ2J2UH/t1KEEzc0PSNEFXBqdCO4VMFauG1DUltK/M1REAR1x7kjrX8hH0K0zWbgjEu
         4UMmwqRRr9tlXmMHNuN3iFP9/+V+tK55Oik0RpUUaF9kgv7feoVJdZjpufEsnJc1GoB3
         X59IAO0pXnegjdrJ2d9eiUvFpSDuj0gs73anR4sG18adZLDhl8RY1flsAf3Ek8Ug3f25
         aoo8i8i8uP84LSjb/9fWutZXPPd39fqIo8NI3WI9r5CQHPlhltgZgw9/OKwwK0hmq2q7
         2eEQ==
X-Gm-Message-State: AOJu0YwpF9NnFO9kR5AQXCmz/Do6ZgJRP5h+fYpU6HANgXD/duOM3Fa7
        z9dH8w0wIg8ZmeBxSa8GwFzSYH0bVg0RSxzIEZbPNyZX
X-Google-Smtp-Source: AGHT+IEd98MMQNnvYVtMuG9REb9GI+09RbG/7vfhRBzULZG5FHP6kxtZY+jLCMYeodTMboSxRQWo7+8YZlAYrp8p9/c=
X-Received: by 2002:a05:6871:e717:b0:1fa:df87:4eba with SMTP id
 qa23-20020a056871e71700b001fadf874ebamr15536835oac.5.1702468923676; Wed, 13
 Dec 2023 04:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
In-Reply-To: <20231212221301.12581-1-ansuelsmth@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 13:01:51 +0100
Message-ID: <CAJZ5v0gTUSFeR=8ov_CgMzkPF7hJ4_MXYZNvsONC8wMxyhiu=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:17 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Add initial support for cold and critical_cold trip point. Many if not
> all hwmon and thermal device have normally trip point for hot
> temperature and for cold temperature.
>
> Till now only hot temperature were supported. Add support for also cold
> temperature to permit complete definition of cold trip point in DT.
>
> Thermal driver may use these additional trip point to correctly set
> interrupt for cold temperature values and react based on that with
> various measure like enabling attached heater, forcing higher voltage
> and other specialaized peripherals.
>
> For hwmon drivers this is needed as currently there is a problem with
> setting the full operating range of the device for thermal devices
> defined with hwmon. To better describe the problem, the following
> example is needed:
>
> In the scenario of a simple hwmon with an active trip point declared
> and a cooling device attached, the hwmon subsystem currently set the
> min and max trip point based on the single active trip point.
> Thermal subsystem parse all the trip points and calculate the lowest and
> the highest trip point and calls the .set_trip of hwmon to setup the
> trip points.
>
> The fact that we currently don't have a way to declare the cold/min
> temperature values, makes the thermal subsystem to set the low value as
> -INT_MAX.
> For hwmon drivers that doesn't use clamp_value and actually reject
> invalid values for the trip point, this results in the hwmon settings to
> be rejected.
>
> To permit to pass the correct range of trip point, permit to set in DT
> also cold and critical_cold trip point.
>
> Thermal driver may also define .cold and .critical_cold to act on these
> trip point tripped and apply the required measure.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Generally speaking, it is kind of late in the cycle for adding
significant new features like this.  We can get to it when 6.8-rc1 is
out, so please resend then.

Also it would be nice to define/document the cold and crtitical_cold
trip points somewhere and is there a better name for critical_cold?

> ---
>  drivers/thermal/thermal_core.c  | 13 +++++++++++++
>  drivers/thermal/thermal_of.c    |  2 ++
>  drivers/thermal/thermal_sysfs.c |  4 ++++
>  drivers/thermal/thermal_trace.h |  4 ++++
>  include/linux/thermal.h         |  2 ++
>  include/uapi/linux/thermal.h    |  2 ++
>  6 files changed, 27 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9c17d35ccbbd..3c5ab560e72f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -344,6 +344,17 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>                 tz->ops->hot(tz);
>  }
>
> +static void handle_critical_cold_trips(struct thermal_zone_device *tz,
> +                                      const struct thermal_trip *trip)
> +{
> +       trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
> +
> +       if (trip->type == THERMAL_TRIP_CRITICAL_COLD && tz->ops->critical_cold)
> +               tz->ops->critical_cold(tz);
> +       else if (trip->type == THERMAL_TRIP_COLD && tz->ops->cold)
> +               tz->ops->cold(tz);
> +}
> +
>  static void handle_thermal_trip(struct thermal_zone_device *tz,
>                                 const struct thermal_trip *trip)
>  {
> @@ -365,6 +376,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
>
>         if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
>                 handle_critical_trips(tz, trip);
> +       else if (trip->type == THERMAL_TRIP_CRITICAL_COLD || trip->type == THERMAL_TRIP_COLD)
> +               handle_critical_cold_trips(tz, trip);
>         else
>                 handle_non_critical_trips(tz, trip);
>  }
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1e0655b63259..95bc600bb4b8 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -60,6 +60,8 @@ static const char * const trip_types[] = {
>         [THERMAL_TRIP_PASSIVE]  = "passive",
>         [THERMAL_TRIP_HOT]      = "hot",
>         [THERMAL_TRIP_CRITICAL] = "critical",
> +       [THERMAL_TRIP_COLD]     = "cold",
> +       [THERMAL_TRIP_CRITICAL_COLD] = "critical_cold",
>  };
>
>  /**
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index eef40d4f3063..e1e69e0991c2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -106,6 +106,10 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
>                 return sprintf(buf, "critical\n");
>         case THERMAL_TRIP_HOT:
>                 return sprintf(buf, "hot\n");
> +       case THERMAL_TRIP_COLD:
> +               return sprintf(buf, "cold\n");
> +       case THERMAL_TRIP_CRITICAL_COLD:
> +               return sprintf(buf, "critical_cold\n");
>         case THERMAL_TRIP_PASSIVE:
>                 return sprintf(buf, "passive\n");
>         case THERMAL_TRIP_ACTIVE:
> diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
> index 459c8ce6cf3b..0a4f96075d7d 100644
> --- a/drivers/thermal/thermal_trace.h
> +++ b/drivers/thermal/thermal_trace.h
> @@ -11,6 +11,8 @@
>
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_COLD);
> +TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL_COLD);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
>  TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>
> @@ -18,6 +20,8 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>         __print_symbolic(type,                                  \
>                          { THERMAL_TRIP_CRITICAL, "CRITICAL"},  \
>                          { THERMAL_TRIP_HOT,      "HOT"},       \
> +                        { THERMAL_TRIP_COLD,      "COLD"},     \
> +                        { THERMAL_TRIP_CRITICAL_COLD, "CRITICAL_COLD"}, \
>                          { THERMAL_TRIP_PASSIVE,  "PASSIVE"},   \
>                          { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index cee814d5d1ac..d6345c9ec50d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -84,6 +84,8 @@ struct thermal_zone_device_ops {
>                           const struct thermal_trip *, enum thermal_trend *);
>         void (*hot)(struct thermal_zone_device *);
>         void (*critical)(struct thermal_zone_device *);
> +       void (*cold)(struct thermal_zone_device *);
> +       void (*critical_cold)(struct thermal_zone_device *);
>  };
>
>  struct thermal_cooling_device_ops {
> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> index fc78bf3aead7..7fa1ba0dff05 100644
> --- a/include/uapi/linux/thermal.h
> +++ b/include/uapi/linux/thermal.h
> @@ -14,6 +14,8 @@ enum thermal_trip_type {
>         THERMAL_TRIP_PASSIVE,
>         THERMAL_TRIP_HOT,
>         THERMAL_TRIP_CRITICAL,
> +       THERMAL_TRIP_COLD,
> +       THERMAL_TRIP_CRITICAL_COLD,
>  };
>
>  /* Adding event notification support elements */
> --
> 2.40.1
>
