Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3D7CDAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjJRLsm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 07:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJRLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:48:40 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB016F7;
        Wed, 18 Oct 2023 04:48:38 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6bf106fb6a0so1341691a34.0;
        Wed, 18 Oct 2023 04:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629718; x=1698234518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q/Z+37O+9hSuiBMjYzeMo3yjEqRFNG+vOZC6JSJYCk=;
        b=rjmXQj+VKCCXNMW6V0kk7Ar+BaUrkWwSvYAa09g1J6ZvS4GfnGnyZ/Zlz2BhHa0pc5
         V0S1/rFjMz36B91DYk01v5VRFWNr5PmCHdyYEiNCuCKriGP+YnvJSJFCDxKej1UIQox2
         x6MVhFU4Bl6VirF4NF6auA5SUcwaTpVUfGGE09nxuALVioqcvZOWHUK7/NZaOZLGG9ms
         dOhOXafpFvUkfNd4P+c1ZbOWoD/BV+4TrZxA1UexObsi7PgrO/17U8wz6ky+FKEDFJNo
         eZE9+3Pmry4Z0ynQmMVsQ87u/373WP5sFzBjktnwkXCArrWMjvp91MeRwPIt7SqooSeq
         zvdw==
X-Gm-Message-State: AOJu0YzGYl4j9yDoCpVj7vwPsqRXkdvqIvPggsSSoXVrgajxPqWWKRdT
        1tlky4GdNzvHsUab58ZAl652IfsTqBzxoJuXvGA=
X-Google-Smtp-Source: AGHT+IESrE+6/GTLq2QJSvPquuCaryzdi+XZnUeLv45RGCYYAQTFj7ea1gj6QMAde8TamdCZzR3hvWU7zPLpmSaq9Jw=
X-Received: by 2002:a4a:ee97:0:b0:57c:6e35:251e with SMTP id
 dk23-20020a4aee97000000b0057c6e35251emr5173160oob.1.1697629718123; Wed, 18
 Oct 2023 04:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231014105426.26389-1-sumitg@nvidia.com> <20231014105426.26389-2-sumitg@nvidia.com>
In-Reply-To: <20231014105426.26389-2-sumitg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 13:48:27 +0200
Message-ID: <CAJZ5v0jm5h9qeZdnLDp9qUMT-31FOWMBERMzhFzgFsmt9QX78g@mail.gmail.com>
Subject: Re: [Patch v5 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, bbasu@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com
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

On Sat, Oct 14, 2023 at 12:54 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>
> From: Jeff Brasen <jbrasen@nvidia.com>
>
> Add support of "Thermal fast Sampling Period (_TFP)" for Passive cooling.
> As per [1], _TFP overrides the "Thermal Sampling Period (_TSP)" if both
> are present in a Thermal zone.
>
> [1] ACPI Specification 6.4 - section 11.4.17. _TFP (Thermal fast Sampling
>     Period)"
>
> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/thermal.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index d98ff69303b3..a91e3d566858 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -90,7 +90,7 @@ struct acpi_thermal_passive {
>         struct acpi_thermal_trip trip;
>         unsigned long tc1;
>         unsigned long tc2;
> -       unsigned long tsp;
> +       unsigned long passive_delay;

This is a passive trip structure anyway, so the "passive_" prefix is
redundant here.  "delay" alone would be fine.

>  };
>
>  struct acpi_thermal_active {
> @@ -404,11 +404,16 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
>
>         tz->trips.passive.tc2 = tmp;
>
> -       status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
> -       if (ACPI_FAILURE(status))
> -               return false;
> +       status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
> +       if (ACPI_FAILURE(status)) {
> +               status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
> +               if (ACPI_FAILURE(status))
> +                       return false;
>
> -       tz->trips.passive.tsp = tmp;
> +               tz->trips.passive.passive_delay = tmp * 100;
> +       } else {
> +               tz->trips.passive.passive_delay = tmp;
> +       }

I would prefer the if () statement above to be structured the other
way around, that is

 status = ...
 if (ACPI_SUCCESS(status)) {
        tz->trips.passive.delay = tmp;
        return true;
}

status = ...
if (ACPI_FAILURE(status))
         return false;

etc.

>
>         return true;
>  }
> @@ -904,7 +909,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>
>         acpi_trip = &tz->trips.passive.trip;
>         if (acpi_thermal_trip_valid(acpi_trip)) {
> -               passive_delay = tz->trips.passive.tsp * 100;
> +               passive_delay = tz->trips.passive.passive_delay;
>
>                 trip->type = THERMAL_TRIP_PASSIVE;
>                 trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
> --
> 2.17.1
>
