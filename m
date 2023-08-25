Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF2788D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjHYQnS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Aug 2023 12:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbjHYQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:42:56 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC04E54;
        Fri, 25 Aug 2023 09:42:52 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-573128cd77dso195582eaf.0;
        Fri, 25 Aug 2023 09:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981771; x=1693586571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb6UwN7bqxNEBVBwpVvxzoowsG5Fs07U9AiGF9V4s0g=;
        b=klRKXH3WoI0t7v1fqOX27ynJ/ZhUxAbEikGL9MHEO4+3YwPp08XPEQSUIZiV6LI9o0
         EfwxOi9XcBsCxU33v6lqBjTRhypmUJpiFb9ZYkfbhMP4jGswrn+DPvFVv+ffdeGimk+G
         jjUHejgQEH1DG/ZnGZUO8ZGY2WshCTIIZIes+/bDnCvUfM4b/FZMucG79uUrn+RYzGBW
         oZhiKQ03x4AzhX+hhE+p22U2e9AJYTiQjEV0jvVLB/lplsikNYlcqCnfCb0JUosxFDAm
         YtF6zMofJ7sEqs9bvRnNehDx4uOO9YPsCIojE6FVB7I8HXb3830NrBWCt8QnUAN+Tnnb
         pyaA==
X-Gm-Message-State: AOJu0YwL/2lMugyCdklAiufzVLmHXgtaP1llzWloin1TXRDf0/asocnJ
        ilxXkBFIDMW6sTixjghp9glCk/bPREglqWh6o4o=
X-Google-Smtp-Source: AGHT+IFo1xts08LHwvna+TJOgUK2rfrorRhxJjJfcSqsbQ7yNEqg3JkIMYrx2iieZeWVQwJ5+oqBkuK6NfjLbCwi4uk=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr19227852oov.0.1692981771638; Fri, 25 Aug
 2023 09:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <12270283.O9o76ZdvQC@kreacher>
In-Reply-To: <12270283.O9o76ZdvQC@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Aug 2023 18:42:40 +0200
Message-ID: <CAJZ5v0iizEDW50Rr17qu2xCnPVE+4eY3aNMQ3FNRNTvmiRL1Zw@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Drop unused .get_trip_*() callbacks
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>
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

On Fri, Aug 25, 2023 at 6:17 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After recent changes in the ACPI thermal driver and in the Intel DTS
> IOSF thermal driver, all thermal zone drivers are expected to use trip
> tables for initialization and none of them should implement
> .get_trip_type(), .get_trip_temp() or .get_trip_hyst() callbacks, so
> drop these callbacks entirely from the core.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/thermal_core.c |    2 +-
>  drivers/thermal/thermal_trip.c |   22 +++-------------------
>  include/linux/thermal.h        |    4 ----
>  3 files changed, 4 insertions(+), 24 deletions(-)
>
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -76,11 +76,7 @@ struct thermal_zone_device_ops {
>         int (*set_trips) (struct thermal_zone_device *, int, int);
>         int (*change_mode) (struct thermal_zone_device *,
>                 enum thermal_device_mode);
> -       int (*get_trip_type) (struct thermal_zone_device *, int,
> -               enum thermal_trip_type *);
> -       int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
>         int (*set_trip_temp) (struct thermal_zone_device *, int, int);
> -       int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
>         int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
>         int (*get_crit_temp) (struct thermal_zone_device *, int *);
>         int (*set_emul_temp) (struct thermal_zone_device *, int);
> Index: linux-pm/drivers/thermal/thermal_trip.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_trip.c
> +++ linux-pm/drivers/thermal/thermal_trip.c
> @@ -118,27 +118,11 @@ int __thermal_zone_get_trip(struct therm
>  {
>         int ret;

The above needs to be dropped from this function too, but I'll fix it
up when applying the patch.

Hopefully, that will be fine with everyone.

>
> -       if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
> +       if (!tz || !tz->trips || trip_id < 0 || trip_id >= tz->num_trips || !trip)
>                 return -EINVAL;
>
> -       if (tz->trips) {
> -               *trip = tz->trips[trip_id];
> -               return 0;
> -       }
> -
> -       if (tz->ops->get_trip_hyst) {
> -               ret = tz->ops->get_trip_hyst(tz, trip_id, &trip->hysteresis);
> -               if (ret)
> -                       return ret;
> -       } else {
> -               trip->hysteresis = 0;
> -       }
> -
> -       ret = tz->ops->get_trip_temp(tz, trip_id, &trip->temperature);
> -       if (ret)
> -               return ret;
> -
> -       return tz->ops->get_trip_type(tz, trip_id, &trip->type);
> +       *trip = tz->trips[trip_id];
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1266,7 +1266,7 @@ thermal_zone_device_register_with_trips(
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
> +       if (num_trips > 0 && !trips)
>                 return ERR_PTR(-EINVAL);
>
>         if (!thermal_class)
>
>
>
