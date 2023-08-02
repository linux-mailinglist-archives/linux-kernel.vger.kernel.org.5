Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A502276D413
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjHBQtE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHBQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:48:30 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9711AC;
        Wed,  2 Aug 2023 09:48:29 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56475c1b930so1027903eaf.0;
        Wed, 02 Aug 2023 09:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994908; x=1691599708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4DJQJkC9NXulAsskXsBVfJzo4vhzZPcLEYBWos2xhk=;
        b=LGX99bfLc3V1UPzQU4NAqOpkEjEr3BF4Ac9BmD/k4HVaKQp3fmaiKwEaQYSquewhiN
         bU9Dfo3CyOxCYkuHddprqFjGsMm/2rkAjloqV1IryYSB5Joxf+hQiOZJbg/ZYP4u3dOr
         KWuTYepa2ZMJUfFTYVH4zmMHT53GqCQhXdHzJt4vKCz4QMRxz86CkUxUUde+uVgjdw47
         U5pAInc4ui9CaKMf2RZky4eM/KFP4Jxg1yg8LEdTbaox6X1e5eZtmIiVXMwyUvUtfVLS
         48oMYkbbBw7IIlKVDYIHeVXFNztSIzGmQSUt4MVVWLYHwgXZDPg22JS6eHhPZqY7YrIj
         NVog==
X-Gm-Message-State: ABy/qLZ22+Y5OfnSg+U0rYmUohKb18yf9+06OwNknRAWocMRbn0TlsFP
        duSdnU1fTae251vFgON0azV4psbP06IREK9pkOk=
X-Google-Smtp-Source: APBJJlHSECy5jKPCEQN5IlcgxAHfjF5aalctkrWz+1/ATuL6Ow+piNoQF2SC+imfMegE01xDjGTvGCOxhAYg0CG8zt4=
X-Received: by 2002:a05:6820:2201:b0:560:b01a:653d with SMTP id
 cj1-20020a056820220100b00560b01a653dmr12607199oob.0.1690994908588; Wed, 02
 Aug 2023 09:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher> <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org> <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
In-Reply-To: <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Aug 2023 18:48:17 +0200
Message-ID: <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
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

On Wed, Aug 2, 2023 at 5:50 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 02/08/2023 15:03, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >>>>> +struct thermal_trip_ref {
> >>>>> +     struct thermal_trip *trip;
> >>>>> +};
> >>>>
> >>>> That introduces a circular dependency. That should be avoided.
> >>>
> >>> Sorry, but this is an empty statement without any substance.
> >>
> >> I'm just pointing that we have a struct A pointing to struct B and
> >> struct B pointing to struct A.
> >
> > Why is this a problem in general?
>
> Cyclic dependencies are often a sign of a design problem.
>
> > There are cases in which struct A needs to be found given struct B
> > (like in the ACPI thermal case, when the driver needs to get to
> > trips[i] from its local data) and there are cases in which struct B
> > needs to be found given struct A (like when a driver's callback is
> > invoked and passed a trip pointer, so the driver needs to get to its
> > local data from it - arguably this is not the case right now, but I
> > suppose it will be the case in the future).
> >
> >> [ ... ]
> >>
> >>>>>     struct thermal_cooling_device_ops {
> >>>>> Index: linux-pm/drivers/thermal/thermal_core.c
> >>>>> ===================================================================
> >>>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
> >>>>> +++ linux-pm/drivers/thermal/thermal_core.c
> >>>>> @@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
> >>>>>         if (result)
> >>>>>                 goto release_device;
> >>>>>
> >>>>> +     mutex_lock(&tz->lock);
> >>>>> +
> >>>>>         for (count = 0; count < num_trips; count++) {
> >>>>> -             struct thermal_trip trip;
> >>>>> +             int temperature = 0;
> >>>>> +
> >>>>> +             if (trips) {
> >>>>> +                     temperature = trips[count].temperature;
> >>>>> +                     if (trips[count].driver_ref)
> >>>>> +                             trips[count].driver_ref->trip = &trips[count];
> >>>>> +             } else {
> >>>>> +                     struct thermal_trip trip;
> >>>>
> >>>> As mentioned above, that should not appear in the thermal core code.
> >>>
> >>> Well, this is a matter of opinion to me.  Clearly, I disagree with it.
> >>
> >> Why? It is not an opinion.
> >
> > So what's wrong with it, technically?  What's broken by it?  Why does
> > it make the code more difficult to maintain?
>
>
>
> >> The thermal core code has been very very tied
> >> with the ACPI implementation (which is logical given the history of the
> >> changes). All the efforts have been made to cut these frictions and make
> >> the thermal core code driver agnostic.
> >>
> >> The changes put in place a mechanism for the ACPI driver.
> >
> > Not really, for all drivers that have local trip data and need to get
> > to trips[i] from there and/or the other way around.
> >
> >> The thermal zone lock wrapper is put in place for the ACPI driver.
> >
> > Yes, it is, because that's the most straightforward way to address the
> > use case at hand IMV.
> >
> >>> Anyway, I want to be productive, so here's the thing: either something
> >>> like this is done, or drivers need to be allowed to walk the trips
> >>> table.
> >>>
> >>> Which one is better?
> >>
> >> None of them. I think we can find a third solution where the changes are
> >> self contained in the ACPI driver. What do you think?
> >
> > The ACPI thermal driver needs to update trip point temperatures at
> > times.  For this purpose, it needs to get from its local trip data to
> > trip[i] somehow.
> >
> > Creating a new trips[] array and handing it over to the core is not an
> > option, because it potentially breaks the thermal device binding to
> > the zone (in which trip indices are used, mind you).
> >
> > So how exactly do you want the driver to do the above?
> >
> > It could save a pointer to each trips[i] in its local data structures
> > before registering the zone, but then if the core reordered the trips,
> > those pointers would become stale.
> >
> > So how?
>
> Let me check if I can do something on top of your series to move it in
> the ACPI driver.

It doesn't need to be on top of my series, so if you have an idea,
please just let me know what it is.

It can't be entirely in the ACPI driver AFAICS, though, because
trips[i] need to be modified on updates and they belong to the core.
Hence, the driver needs some help from the core to get to them.  It
can be something like "this is my trip tag and please give me the
address of the trip matching it" or similar, but it is needed, because
the driver has to assume that the trip indices used by it initially
may change.
