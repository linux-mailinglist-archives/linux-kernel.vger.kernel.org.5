Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9A7ADDA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjIYRNM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:13:10 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5245FBC;
        Mon, 25 Sep 2023 10:13:04 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57bb41f5937so357349eaf.1;
        Mon, 25 Sep 2023 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661983; x=1696266783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9DtViKcadvsCwKJmf4sI2t1Y1EYW1bA3Q/3dmceKgo=;
        b=p7rGfOMDCHUs0GxEmHVzwc2dv/luspuDAtUe66ir8E0gRxe8IhC6rAXCRUW8sd7yWS
         y+w3VZn59/sUpISmmc/H4sdXLjLfrOzL0sr9vi7WypBm8XVhn9LwsswhW9dHOASy5qMS
         JbmreRzAJVfWfW7F23ukd8V4kNDj16LdBzb9DS8dfLOztN3ZtWPm8fgLnsMcae61DpV5
         mEc62PK++iYoe9Mr+vVXenByGY7uvru2uyBMPTy5svLcUomHhZUUlalEJ8Go146ds7Gx
         UeW3YmWHXvFLBdHxf+2JAbF/hBdeAXhpYv4ujil9Z9iIOXzpyS790Z7/oBdsI8bUNw1q
         iTYw==
X-Gm-Message-State: AOJu0YwvoUtyvXy1e/aLrgyEocnsSFdtub/UV9ez1Ws54kEABqqMrwMX
        x2y1kCLyBNkc5OdyZq8a8KSBjm1O6ZSBEdK/Cpw=
X-Google-Smtp-Source: AGHT+IFeaaZDtBFssVidpb6XsNjkGoZaZziGcibuqd883kWO9pNqUFQ/JRFywUllnnkorziePhJy8UrhPyc11mAZIUk=
X-Received: by 2002:a4a:c91a:0:b0:57b:94b7:c6ba with SMTP id
 v26-20020a4ac91a000000b0057b94b7c6bamr6356508ooq.0.1695661983592; Mon, 25 Sep
 2023 10:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <5708760.DvuYhMxLoT@kreacher> <4858652.31r3eYUQgx@kreacher> <acb102d2-c44b-f9a6-671f-d157d1827468@linaro.org>
In-Reply-To: <acb102d2-c44b-f9a6-671f-d157d1827468@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Sep 2023 19:12:52 +0200
Message-ID: <CAJZ5v0iRe17sziFesvenjvjq+Onu2tdAsohb+VLA+exp5xPC-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ACPI: thermal: Simplify initialization of critical
 and hot trips
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Mon, Sep 25, 2023 at 5:20 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 12/09/2023 20:35, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Use the observation that the critical and hot trip points are never
> > updated by the ACPI thermal driver, because the flags passed from
> > acpi_thermal_notify() to acpi_thermal_trips_update() do not include
> > ACPI_TRIPS_CRITICAL or ACPI_TRIPS_HOT, to move the initialization
> > of those trip points directly into acpi_thermal_get_trip_points() and
> > reduce the size of __acpi_thermal_trips_update().
> >
> > Also make the critical and hot trip points initialization code more
> > straightforward and drop the flags that are not needed any more.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> [ ... ]
>
> > +static void acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
> > +{
> > +     unsigned long long tmp;
> > +     acpi_status status;
> > +
> > +     if (crt > 0) {
> > +             tmp = celsius_to_deci_kelvin(crt);
> > +             goto set;
> > +     }
> > +     if (crt == -1) {
> > +             acpi_handle_debug(tz->device->handle, "Critical threshold disabled\n");
> > +             goto fail;
> > +     }
> > +
> > +     status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
> > +     if (ACPI_FAILURE(status)) {
> > +             acpi_handle_debug(tz->device->handle, "No critical threshold\n");
> > +             goto fail;
> > +     }
> > +     if (tmp <= 2732) {
> > +             /*
> > +              * Below zero (Celsius) values clearly aren't right for sure,
> > +              * so discard them as invalid.
> > +              */
> > +             pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
> > +             goto fail;
> > +     }
> > +
> > +set:
> > +     tz->trips.critical.valid = true;
> > +     tz->trips.critical.temperature = tmp;
> > +     acpi_handle_debug(tz->device->handle, "Critical threshold [%lu]\n",
> > +                       tz->trips.critical.temperature);
> > +     return;
> > +
> > +fail:
>
> nit: 'notset' may be more adequate

Well, this is a bit moot, because the label goes away in one of the
later patches anyway.

> > +     tz->trips.critical.valid = false;
> > +     tz->trips.critical.temperature = THERMAL_TEMP_INVALID;
> > +}
>
> Other than that,
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!
