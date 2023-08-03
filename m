Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5480176F3BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjHCT6r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 15:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHCT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:58:45 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C30420F;
        Thu,  3 Aug 2023 12:58:44 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56d0deeca09so188419eaf.0;
        Thu, 03 Aug 2023 12:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691092723; x=1691697523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5lbrYku02MGucWZlgqTufTYfZYAYDVopF3bhZtB7NU=;
        b=O7d0mAiecBwrknl1PYdSGAQhBY1tQfHHfrAqRoFoUWtWr8hcdwWQlVrWPKjiHMYE0Q
         qGTZfR+TO7bZ6ux4mzmXB1NGeMXx9dgkux+Yo+5kNOsIXd8X5amTKkMqeRdRQjLjWNR+
         LD74JRd6hqvYa9hw8XAY5k2QoGYHdCVJxfVATHXrAZVDVQ+GfgllqItv0Kyf1Ojo1WKj
         gVH4HKSev1ypWGXqR8rI2QB+53RGVHXg22e/De1z6hjzRxCFET2ML4+YwYbo2Gi6IjO2
         dW7mV6eZyXm92Oj16L7yXA/3vNDFAuVu7wNoO6QI3BnqKkPsbe5Zlrv36RKISrsJts+c
         Uhkg==
X-Gm-Message-State: ABy/qLbbH/5HdGQYq+TePwh9v7BT2EuWQWYNaN1ztC8gHKhj8mHXyidC
        E1q4R+rJd1kJYcX4se+tEicRXYtEjCYTmS5M7ew=
X-Google-Smtp-Source: APBJJlEFaRUb1D3ofaPFX3gImb+a7isGHR4BOwxQBVGLYqbi8AM4d3+S/zxJiGipzTHQfvRm3JYUepQqqwuz7wcgo3s=
X-Received: by 2002:a4a:a585:0:b0:56c:484a:923d with SMTP id
 d5-20020a4aa585000000b0056c484a923dmr13794384oom.1.1691092723574; Thu, 03 Aug
 2023 12:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher> <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org> <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org> <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
 <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org> <CAJZ5v0gtkZTwt-qP0uwvTJNx8cpO1o1esmW9BfVxB67X3Yt++w@mail.gmail.com>
 <b4e474f9-79e8-534b-509e-12eb5995fa0c@linaro.org>
In-Reply-To: <b4e474f9-79e8-534b-509e-12eb5995fa0c@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Aug 2023 21:58:32 +0200
Message-ID: <CAJZ5v0iH+qf6eBuZASPKyA6rT8O6FiA7516MiYYUx6Uc+wR4Ow@mail.gmail.com>
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

On Thu, Aug 3, 2023 at 6:20 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 03/08/2023 16:15, Rafael J. Wysocki wrote:
> > On Thu, Aug 3, 2023 at 3:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 02/08/2023 18:48, Rafael J. Wysocki wrote:
> >>
> >> [ ... ]
> >>
> >>>> Let me check if I can do something on top of your series to move it in
> >>>> the ACPI driver.
> >>>
> >>> It doesn't need to be on top of my series, so if you have an idea,
> >>> please just let me know what it is.
> >>>
> >>> It can't be entirely in the ACPI driver AFAICS, though, because
> >>> trips[i] need to be modified on updates and they belong to the core.
> >>> Hence, the driver needs some help from the core to get to them.  It
> >>> can be something like "this is my trip tag and please give me the
> >>> address of the trip matching it" or similar, but it is needed, because
> >>> the driver has to assume that the trip indices used by it initially
> >>> may change.
> >>
> >> May be I'm missing something but driver_ref does not seems to be used
> >> except when assigning it, no?
> >
> > It is used on the other side.  That is, the value assigned to the trip
> > field in it is accessed via trip_ref in the driver.
> >
> > The idea is that the driver puts a pointer to its local struct
> > thermal_trip_ref into a struct thermal_trip and the core stores the
> > address of that struct thermal_trip in there, which allows the driver
> > to access the struct thermal_trip via its local struct
> > thermal_trip_ref going forward.
> >
> > Admittedly, this is somewhat convoluted.
> >
> > I have an alternative approach in the works, just for illustration
> > purposes if nothing else, but I have encountered a problem that I
> > would like to ask you about.
> >
> > Namely, zone disabling is not particularly useful for preventing the
> > zone from being used while the trips are updated, because it has side
> > effects.  First, it triggers __thermal_zone_device_update() and a
> > netlink message every time the mode changes, which can be kind of
> > overcome.
>
> Right
>
> > But second, if the mode is "disabled", it does not actually
> > prevent things like __thermal_zone_get_trip() from running and the
> > zone lock is the only thing that can be used for that AFAICS.
>  >
> > So by "disabling" a thermal zone, did you mean changing its mode to
> > "disabled" or something else?
>
> Yes, that is what I meant.
>
> May be the initial proposal by updating the thermal trips pointer can
> solve that [1]

No, it can't.  An existing trips[] table cannot be replaced with a new
one with different trip indices, because those indices are already in
use.  And if the indices are the same, there's no reason to replace
trips.

> IMO we can assume the trip point changes are very rare (if any), so
> rebuilding a new trip array and update the thermal zone with the pointer
> may solve the situation.
>
> The routine does a copy of the trips array, so it can reorder it without
> impacting the array passed as a parameter. And it can take the lock.

The driver can take a lock as well.  Forbidding drivers to use the
zone lock is an artificial limitation without technical merit IMV.

> We just have to constraint the update function to invalidate arrays with
> a number of trip points different from the one initially passed when
> creating the thermal zone.
>
> Alternatively, we can be smarter in the ACPI driver and update the
> corresponding temperature+hysteresis trip point by using the
> thermal_zone_set_trip() function.

I don't see why this would make any difference.

> [1]
> https://lore.kernel.org/all/20230525140135.3589917-5-daniel.lezcano@linaro.org/
