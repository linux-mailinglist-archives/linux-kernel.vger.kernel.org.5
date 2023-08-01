Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E20576BCFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjHASwU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 14:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjHASwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:52:18 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A64126A1;
        Tue,  1 Aug 2023 11:52:11 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56d0deeca09so32945eaf.0;
        Tue, 01 Aug 2023 11:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915930; x=1691520730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDF+MyCYxqY1Suy31l3VNJ8qreWErHQzhBqOCnxacPo=;
        b=GnRNdVeGxggrfPV1lIMsZoJd+xTxbj1fYGN6uugm7cDw+PMnBEIjwqQgiVB/SHh4U6
         uTZ0SrRrGGgeuxUGnceFSMRe7ZI1AoRkD/Hv89j4Sh9+eO99Msx8796dm9t1cv/1jvlk
         4qBzsq821urpo4tQqHigyv+xfk9S9uAiERiXT7VSI5LrV4YUAeXFGMUi25hCdNqmIjY6
         /b/213kJ//7EA0UvXj2aEnEmpqVquzhKecBWMClUscwCf7CIn1bYzxzD5dELl3G64RPo
         W5RwZTmaJVOxY/PzyEAAsdaHUoaSNhDYL2/adNKv/gzN0tEkzWonOKEt5OQl2xUlJxyv
         UfDg==
X-Gm-Message-State: ABy/qLZ1valhqZUNmf3NN4Wa1BJcYDm7c+Hwu5huO5J2CgA/Qt0cbI1C
        HjpkuYdpkyE9TYXKOQfCqUtytCUYk+5slRbdItdfjS8bI3o=
X-Google-Smtp-Source: APBJJlGB8BiGH7rdxWxxWgn6VIpoLYNe/FN/bIb8KJ20VqCaACeW/krItvO4XX+Q8DrZOaOQ+S3zBV9rFejyKb/lDqE=
X-Received: by 2002:a4a:cf14:0:b0:569:a08a:d9c5 with SMTP id
 l20-20020a4acf14000000b00569a08ad9c5mr7986887oos.0.1690915930146; Tue, 01 Aug
 2023 11:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <7552439.EvYhyI6sBW@kreacher> <cc972aec-dd21-e025-8984-e48b7c1df4bc@linaro.org>
In-Reply-To: <cc972aec-dd21-e025-8984-e48b7c1df4bc@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Aug 2023 20:51:58 +0200
Message-ID: <CAJZ5v0iizOkgX6YbMXpOrKBTp+EFV-hZJmJxPkWsBM0GtuK9VA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] ACPI: thermal: Hold thermal zone lock around trip updates
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Tue, Aug 1, 2023 at 8:39 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 25/07/2023 14:16, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is a race condition between acpi_thermal_trips_update() and
> > acpi_thermal_check_fn(), because the trip points may get updated while
> > the latter is running which in theory may lead to inconsistent results.
> > For example, if two trips are updated together, using the temperature
> > value of one of them from before the update and the temperature value
> > of the other one from after the update may not lead to the expected
> > outcome.
> >
> > To address this, make acpi_thermal_trips_update() hold the thermal zone
> > lock across the entire update of trip points.
>
> As commented in patch 3/8, having a driver locking a thermal core
> structure is not right and goes to the opposite direction of the recent
> cleanups.

It already happens though, because thermal_zone_device_update() locks
the zone and it is called by the driver.

> Don't we have 2 race conditions:
>
> acpi_thermal_trips_update() + thermal_zone_device_check()
>
> acpi_thermal_trips_update() + acpi_thermal_trips_update()

I'm not sure what you mean.

First off, acpi_thermal_check_fn() needs to be locked against anything
using the trips in the zone's trips[] table, in particular
thermal_get_trend().

However, thermal_get_trend() also uses the driver's private trips
information, so it needs to be locked against
acpi_thermal_trips_update().

And obviously the latter needs to be locked against acpi_thermal_check_fn().

> For the former, we can disable the thermal zone, update and then enable

Disabling the thermal zone is an idea, but it would be necessary to do
that in both acpi_thermal_check_fn() and acpi_thermal_trips_update().
Also I'm not sure how different that would be from holding the zone
lock across the updates.

Moreover, acpi_thermal_trips_update() would then need to hold the
local lock around the thermal zone disable/enable which would be way
uglier than just using the zone lock directly in it.
