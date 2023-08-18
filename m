Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97057812EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379448AbjHRSef convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHRSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:34:02 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6B2D7D;
        Fri, 18 Aug 2023 11:34:01 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56d0deeca09so194048eaf.0;
        Fri, 18 Aug 2023 11:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692383640; x=1692988440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBlf1nUQbQFfKp2zKc4LcGN+VaY8kuxNt6d+r4cR42E=;
        b=M1dk1rxTlI9dCNyIuG6vzOIXFNP63CbNcCzQnzj5+84HmYfjcKfxU/Bgut+R7kBXAe
         A/6QwkUs5Q27G+l4tOqFU+QtCcC9w3SBm8sBBRg/x1Pcga9KgTJkEyn36/yevYBQLIVw
         8DMLtQYzDnDxgR+LZXv9vdkiCrAo56x0hZ5F+bB8JG8tBoh94wFl7JUhy10gmwCxpFQN
         0DZFI2MxW4uyr+V4Rm5gEjt3tsWiVH1pJ8FY20bOzQ9Tb8s8q4XT5HIEXelcvFxGNt6J
         c44MS6EtUXZicg2jcKppSqxSJvZaqfiqlkUVEvT9lsvOMUx7gBBYd61kcM/sFaK5JNm9
         maAQ==
X-Gm-Message-State: AOJu0YxoVwoCwwodE1sx3DsZY7jYMc7Pzi+qF3haSECTqwuHvc0LYILk
        7HRt15kH4nJ+SCLln6D4xlqYAU6UX4/JL/+DA10=
X-Google-Smtp-Source: AGHT+IGuDEf404L20cLinB+qq0IvT6x+B4zee3DZX6C39FncXp/0fDdfUrlcQSfj4EdEaLs7zjsYafTuCQ2678V5Ghw=
X-Received: by 2002:a4a:be17:0:b0:56e:72e0:9c5f with SMTP id
 l23-20020a4abe17000000b0056e72e09c5fmr36938oop.1.1692383640542; Fri, 18 Aug
 2023 11:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230817093011.1378-1-sumitg@nvidia.com> <20230817093011.1378-2-sumitg@nvidia.com>
In-Reply-To: <20230817093011.1378-2-sumitg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 20:33:49 +0200
Message-ID: <CAJZ5v0gKtwgu=ysdROapfK-pnr3om8zXH_xsP3i=HVqQSs_d-g@mail.gmail.com>
Subject: Re: [Patch 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com,
        jbrasen@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:30 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>
> From: Jeff Brasen <jbrasen@nvidia.com>
>
> Add support for Thermal fast Sampling Period (_TFP) for Passive cooling.
> As per UEFI spec,

You mean the ACPI spec I suppose?  It would be good to give the
relevant section number and title.

>  _TFP overrides the "Thermal Sampling Period (_TSP)"
>  if both are present in a Thermal zone.
>
> Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/thermal.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index f9f6ebb08fdb..5dee3722509c 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -111,7 +111,7 @@ struct acpi_thermal_passive {
>         unsigned long temperature;
>         unsigned long tc1;
>         unsigned long tc2;
> -       unsigned long tsp;
> +       unsigned long sampling_period;
>         bool valid;
>  };
>
> @@ -289,11 +289,18 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
>                                         tz->trips.passive.tc2 = tmp;
>
>                                 status = acpi_evaluate_integer(tz->device->handle,
> -                                                              "_TSP", NULL, &tmp);
> -                               if (ACPI_FAILURE(status))
> -                                       tz->trips.passive.valid = false;
> -                               else
> -                                       tz->trips.passive.tsp = tmp;
> +                                                              "_TFP", NULL, &tmp);
> +                               if (ACPI_FAILURE(status)) {
> +                                       status = acpi_evaluate_integer(tz->device->handle,
> +                                                                      "_TSP", NULL, &tmp);
> +                                       if (ACPI_FAILURE(status))
> +                                               tz->trips.passive.valid = false;
> +                                       else
> +                                               tz->trips.passive.sampling_period = tmp * 100;
> +
> +                               } else {
> +                                       tz->trips.passive.sampling_period = tmp;
> +                               }
>                         }
>                 }
>         }
> @@ -765,7 +772,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>         if (tz->trips.passive.valid)
>                 tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
>                                                                 &acpi_thermal_zone_ops, NULL,
> -                                                               tz->trips.passive.tsp * 100,
> +                                                               tz->trips.passive.sampling_period,
>                                                                 tz->polling_frequency * 100);
>         else
>                 tz->thermal_zone =
> --

So this needs to be rebased on top of the current linux-next branch in
linux-pm.git or on top of the acpi-thermal branch in there.
