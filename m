Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020B7AF20A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjIZR4g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjIZR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:56:34 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CFE9F;
        Tue, 26 Sep 2023 10:56:27 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57b68555467so688110eaf.0;
        Tue, 26 Sep 2023 10:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695750986; x=1696355786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yqXaetlVLQEcWlksdWUaZspSGSc2dTGLE72sp01bYI=;
        b=SvCdznlUpca8WZ9D5D4EuekT4+1JoiEQKDqPoA7/gJXS7pv7dPZKm+zrfszFgrOxws
         dOMi8EKrICyWmDCtJNQbiR1kEi9BjLZwfAf9GPZL89tjDSix5+bB2sbTcMFh0EYXGGlW
         UZVsGUqj+kiplzeLzxw8Ie5ZfZb34W3B0bgcPokZoyliXwxeIlSV86JK1k1wwQxGH0yL
         yR7F4NW0vPizz2uh3hBeeSDpx8OKWPeGPm6g77MtoDiYTmERRFKuqXjYfjMCUzL0R9tf
         MCopj5WbsGx+fqDk3r0Ty4jVsSLCD5ZCK0LZpHAZ74HieskbAeNZLLRgCSbKNiAL/CBG
         hncw==
X-Gm-Message-State: AOJu0Yx7KXL/9jX5YeB7nBdeyWX0ayngV9NSDqjskZCJHcIj5swvUCJo
        5UeVoqWQtA1RrgfMI6AdYWpFeAkipl1g/3bdXbE=
X-Google-Smtp-Source: AGHT+IG92Y5OWwELWyPqUjJ1G1ken/HOqivotisiJ5rtf/jKwT5sn4buOWxVaJSYKgtRvTciMEezzQgseewhKy3WVIc=
X-Received: by 2002:a4a:e8c4:0:b0:57b:73f6:6f80 with SMTP id
 h4-20020a4ae8c4000000b0057b73f66f80mr9468857ooe.0.1695750986553; Tue, 26 Sep
 2023 10:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher> <38ea14aa-ecc2-c40e-34ea-05b348158cfb@linaro.org>
In-Reply-To: <38ea14aa-ecc2-c40e-34ea-05b348158cfb@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 19:56:15 +0200
Message-ID: <CAJZ5v0iww__Kd2e8bSarXL5ugjL1zuCaXgOfzLp-VGdmHBBabQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Tue, Sep 26, 2023 at 7:18 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/09/2023 19:49, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In order to reduce code duplication, merge update_passive_devices() and
> > update_active_devices() into one function called update_trip_devices()
> > that will be used for updating both the passive and active trip points.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/acpi/thermal.c |   53 ++++++++++++++++++-------------------------------
> >   1 file changed, 20 insertions(+), 33 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/thermal.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/thermal.c
> > +++ linux-pm/drivers/acpi/thermal.c
> > @@ -43,6 +43,8 @@
> >   #define ACPI_THERMAL_MAX_ACTIVE             10
> >   #define ACPI_THERMAL_MAX_LIMIT_STR_LEN      65
> >
> > +#define ACPI_THERMAL_TRIP_PASSIVE    (-1)
> > +
> >   /*
> >    * This exception is thrown out in two cases:
> >    * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
> > @@ -202,18 +204,25 @@ static void acpi_thermal_update_passive_
> >               ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
> >   }
> >
> > -static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
> > +static bool update_trip_devices(struct acpi_thermal *tz,
> > +                             struct acpi_thermal_trip *acpi_trip,
> > +                             int index, bool compare)
> >   {
> > -     struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
> >       struct acpi_handle_list devices;
> > +     char method[] = "_PSL";
> >       acpi_status status;
> >
> > +     if (index != ACPI_THERMAL_TRIP_PASSIVE) {
> > +             method[1] = 'A';
> > +             method[2] = 'L';
> > +             method[3] = '0' + index;
> > +     }
>
> Could be index > 9 ?

I can add a check, but it will never be called with index > 9 anyway.
