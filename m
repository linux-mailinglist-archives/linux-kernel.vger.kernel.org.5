Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D97F3706
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjKUUAQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 15:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjKUUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:00:15 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1ACD51;
        Tue, 21 Nov 2023 12:00:06 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58cf7d3b4deso41807eaf.0;
        Tue, 21 Nov 2023 12:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596806; x=1701201606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mLj5rstumdH3YxR5Ngi8wRMMBkTHdU3Odp76NDyzSg=;
        b=ocFo9lOTYhx5h4X53UHA5PJuwCbc1dFCnLBOjv/OcOddFe8OZeUh5uf52g4y2Zuzln
         hHejTtsPvGcZwmEq4jW9r4g+9jGDMdf5VSJWdJ8WGfLSmNtYFLYuXjnz7LwS3Y88XshM
         Bzgner6SzLDrFA3QaJE0nqIq86YjLLhzcMp2xwZEu4Rfi5if6tq4m4rCSQTOWe8n18xn
         oy1Jx5UB6/V0C1HgDO0LLmFUKGwLGv+yHLcVoZIafNINSw+SKIug7Eo8fmS7cUx8A/+v
         m32637BuwDefu/+rirZL9rQqgU53/hpTfTx4bewwgF/0u5ttl21mNJuwGOj/tQdrmdl0
         LzeQ==
X-Gm-Message-State: AOJu0Yzy+i7wvMAhTeDw8Iwt3oJcVVp9yi//48G+ITq+Zdzm5kAh3ExY
        wtFFNRO9H3RzJR3aq38VXue+shjqqL0HRttr/Aw=
X-Google-Smtp-Source: AGHT+IGrYrkrbENwV/Uasb7GDGFQpjIl709++hpNYB35CN+zoWa0hRU7RuwdBWZkmBBrIqL3ZRVXAvX8Wl7maPSXxxA=
X-Received: by 2002:a4a:d087:0:b0:584:17d0:de3d with SMTP id
 i7-20020a4ad087000000b0058417d0de3dmr433216oor.1.1700596805818; Tue, 21 Nov
 2023 12:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20231109183322.28039-1-sumitg@nvidia.com> <20231109183322.28039-2-sumitg@nvidia.com>
In-Reply-To: <20231109183322.28039-2-sumitg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Nov 2023 20:59:54 +0100
Message-ID: <CAJZ5v0jEXYP-V93XJ02cZ8UbMwKei2E27Sc0He0WnKvNXpUECg@mail.gmail.com>
Subject: Re: [Patch v6 1/2] ACPI: thermal: Add Thermal fast Sampling Period
 (_TFP) support
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com,
        jbrasen@nvidia.com
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

On Thu, Nov 9, 2023 at 7:34 PM Sumit Gupta <sumitg@nvidia.com> wrote:
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
> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/thermal.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index f74d81abdbfc..3b75eb2260d7 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -90,7 +90,7 @@ struct acpi_thermal_passive {
>         struct acpi_thermal_trip trip;
>         unsigned long tc1;
>         unsigned long tc2;
> -       unsigned long tsp;
> +       unsigned long delay;
>  };
>
>  struct acpi_thermal_active {
> @@ -404,11 +404,17 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
>
>         tz->trips.passive.tc2 = tmp;
>
> +       status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
> +       if (ACPI_SUCCESS(status)) {
> +               tz->trips.passive.delay = tmp;
> +               return true;
> +       }
> +
>         status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
>         if (ACPI_FAILURE(status))
>                 return false;
>
> -       tz->trips.passive.tsp = tmp;
> +       tz->trips.passive.delay = tmp * 100;
>
>         return true;
>  }
> @@ -904,7 +910,7 @@ static int acpi_thermal_add(struct acpi_device *device)
>
>         acpi_trip = &tz->trips.passive.trip;
>         if (acpi_thermal_trip_valid(acpi_trip)) {
> -               passive_delay = tz->trips.passive.tsp * 100;
> +               passive_delay = tz->trips.passive.delay;
>
>                 trip->type = THERMAL_TRIP_PASSIVE;
>                 trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
> --

So does the second patch in the series really depend on this one?

If not, I can apply it I think.
