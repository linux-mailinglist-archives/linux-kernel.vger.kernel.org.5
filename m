Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494C76CDCD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjHBNDX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 09:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjHBNDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:03:19 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB7268E;
        Wed,  2 Aug 2023 06:03:18 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56c9f7830c2so416099eaf.0;
        Wed, 02 Aug 2023 06:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981397; x=1691586197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yafhNQ4YTkPLG1VAsvNTE7v945AY1cuztAj25fNjZQc=;
        b=Ah/iheg3tUMma4KTqonKmWnXxzlO8yg6eDtKqyFvsVj2XxD9X50MOJYZ7ufQMyWt77
         UYxuNzk9Y9dxw/SZ2qLrJbFRJhDyiF0KYEotVmCDAzu3CnM4W6Z5wpzfmMBHCKPpuNUq
         hYtpeuCz88sDw1hV76w/3X1/i9ZzcONbntVNkA4+FiBJJ6AFoAg0N83j6zqz1A7BEI6v
         YDANRF3yJ7jqE1zbUYwqrcqFc13V4LYigzGQOiTEUBprlZ7InRVOOri4iHgocYjnkjsz
         HNoP9j/q+PCX5C4Gy+chTapqxaAyoVBNyBhvKbIiGk6L9a4TMUC/WEuqYMSXx+idqpeg
         69fg==
X-Gm-Message-State: ABy/qLYAIfkVNXr01jsC75XG9STJJw9sZqEaXUayiTkex/eI7oYgZS/0
        M8MAKBUNEl/wPmW061kebbYI1tON827TSkcc1oZWefl9
X-Google-Smtp-Source: APBJJlHSPU4JfpHvbzSQ8Twq1XvyC06N73nchp4xEbEjCml8oaWzT2gJGqmt7JikCGYtvDl6nCh5LcsEZrcZcTFgaSs=
X-Received: by 2002:a05:6820:1686:b0:56c:5e21:c730 with SMTP id
 bc6-20020a056820168600b0056c5e21c730mr11286117oob.1.1690981397443; Wed, 02
 Aug 2023 06:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher> <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com> <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
In-Reply-To: <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Aug 2023 15:03:06 +0200
Message-ID: <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

Hi Daniel,

On Wed, Aug 2, 2023 at 2:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 01/08/2023 21:02, Rafael J. Wysocki wrote:
> > On Tue, Aug 1, 2023 at 8:29 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 25/07/2023 14:04, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Some drivers need to update trip point data (temperature and/or
> >>> hysteresis) upon notifications from the platform firmware or they
> >>> may need to reprogram hardware when trip point parameters are changed
> >>> via sysfs.  For those purposes, they need to connect struct thermal_trip
> >>> to a private data set associated with the trip or the other way around
> >>> and using a trip point index for that may not always work, because the
> >>> core may need to reorder the trips during thermal zone registration (in
> >>> particular, they may need to be sorted).
> >>>
> >>> To allow that to be done without using a trip point index, introduce
> >>> a new field in struct thermal_trip that can be pointed by the driver
> >>> to its own data structure containing a trip pointer to be initialized
> >>> by the core during thermal zone registration.  That pointer will then
> >>> have to be updated by the core every time the location of the given
> >>> trip point object in memory changes.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> v2 -> v3: No changes.
> >>>
> >>> v1 -> v2: No changes.
> >>>
> >>> ---
> >>>    drivers/thermal/thermal_core.c |   20 +++++++++++++++++---
> >>>    include/linux/thermal.h        |   13 +++++++++++++
> >>>    2 files changed, 30 insertions(+), 3 deletions(-)
> >>>
> >>> Index: linux-pm/include/linux/thermal.h
> >>> ===================================================================
> >>> --- linux-pm.orig/include/linux/thermal.h
> >>> +++ linux-pm/include/linux/thermal.h
> >>> @@ -76,16 +76,29 @@ struct thermal_zone_device_ops {
> >>>        void (*critical)(struct thermal_zone_device *);
> >>>    };
> >>>
> >>> +struct thermal_trip_ref {
> >>> +     struct thermal_trip *trip;
> >>> +};
> >>
> >> That introduces a circular dependency. That should be avoided.
> >
> > Sorry, but this is an empty statement without any substance.
>
> I'm just pointing that we have a struct A pointing to struct B and
> struct B pointing to struct A.

Why is this a problem in general?

There are cases in which struct A needs to be found given struct B
(like in the ACPI thermal case, when the driver needs to get to
trips[i] from its local data) and there are cases in which struct B
needs to be found given struct A (like when a driver's callback is
invoked and passed a trip pointer, so the driver needs to get to its
local data from it - arguably this is not the case right now, but I
suppose it will be the case in the future).

> [ ... ]
>
> >>>    struct thermal_cooling_device_ops {
> >>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>> @@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
> >>>        if (result)
> >>>                goto release_device;
> >>>
> >>> +     mutex_lock(&tz->lock);
> >>> +
> >>>        for (count = 0; count < num_trips; count++) {
> >>> -             struct thermal_trip trip;
> >>> +             int temperature = 0;
> >>> +
> >>> +             if (trips) {
> >>> +                     temperature = trips[count].temperature;
> >>> +                     if (trips[count].driver_ref)
> >>> +                             trips[count].driver_ref->trip = &trips[count];
> >>> +             } else {
> >>> +                     struct thermal_trip trip;
> >>
> >> As mentioned above, that should not appear in the thermal core code.
> >
> > Well, this is a matter of opinion to me.  Clearly, I disagree with it.
>
> Why? It is not an opinion.

So what's wrong with it, technically?  What's broken by it?  Why does
it make the code more difficult to maintain?

> The thermal core code has been very very tied
> with the ACPI implementation (which is logical given the history of the
> changes). All the efforts have been made to cut these frictions and make
> the thermal core code driver agnostic.
>
> The changes put in place a mechanism for the ACPI driver.

Not really, for all drivers that have local trip data and need to get
to trips[i] from there and/or the other way around.

> The thermal zone lock wrapper is put in place for the ACPI driver.

Yes, it is, because that's the most straightforward way to address the
use case at hand IMV.

> > Anyway, I want to be productive, so here's the thing: either something
> > like this is done, or drivers need to be allowed to walk the trips
> > table.
> >
> > Which one is better?
>
> None of them. I think we can find a third solution where the changes are
> self contained in the ACPI driver. What do you think?

The ACPI thermal driver needs to update trip point temperatures at
times.  For this purpose, it needs to get from its local trip data to
trip[i] somehow.

Creating a new trips[] array and handing it over to the core is not an
option, because it potentially breaks the thermal device binding to
the zone (in which trip indices are used, mind you).

So how exactly do you want the driver to do the above?

It could save a pointer to each trips[i] in its local data structures
before registering the zone, but then if the core reordered the trips,
those pointers would become stale.

So how?
