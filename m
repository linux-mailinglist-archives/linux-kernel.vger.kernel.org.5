Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034DF7B09AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjI0QKK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjI0QKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:10:02 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C7B1B8;
        Wed, 27 Sep 2023 09:09:56 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-57bf04841ccso444706eaf.0;
        Wed, 27 Sep 2023 09:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830996; x=1696435796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoBx4haDwLKQQRn3ZmCIvGY1ND5OJ+IJ+kQUcWjxXZg=;
        b=tPgQxZ3U4FJh2OB1AmEHhIkB3I9oLbaDeLNHHmFlhKcBEmjaQ7KAHHkMU9EBny2VF3
         bsQG4Jt5AH94x3AJvzH/11F+xglLGGJlVt5KAUIsyw0/9RntD/gM43R80jXWbkOUQ62W
         m2p0euFGCWJ14+Pn5581lpO07ebcY6kw6VutC+/BGUIVAemfbfldPDCPuINxIcoaLJOM
         PQEkkfwsX19xUPJgcwVFuiLNgnISYpKMLwkcjrjddu3P/IJQ/Loq6mJvZ1ABVZI6j/uk
         cQKRrKvbeBtAU53uGqsYG7I2JWh2n/GmRQDBRmq+lyLJwGlU6NdJ0xdJkRcn2nzvKa/4
         ezIw==
X-Gm-Message-State: AOJu0Yyp/uSe8YtzpHEw+58/5sLuzStbuDjtJ+lOJIRC2nVVjTYee074
        2pnu9y/91HPIVb3pda5CfrAKCGFIAVCOW20d0kc=
X-Google-Smtp-Source: AGHT+IEi5cA9AxvFYp7fB68YSeYwHe3jVtm4j1rrNlisxxUbOI1nfAfQyHhvuz6Cw8HTl6SXKYe00OcEDINZTFnKZJ8=
X-Received: by 2002:a4a:c58f:0:b0:57b:7804:9d72 with SMTP id
 x15-20020a4ac58f000000b0057b78049d72mr2771381oop.1.1695830995803; Wed, 27 Sep
 2023 09:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <1882755.CQOukoFCf9@kreacher>
 <3c9f7b7d-a9ca-79ae-4e64-367a82f953bc@linaro.org> <CAJZ5v0ifXSWd4QL+j-=8OBr1aQr0WAeMBGYtis_gkHJDBLeWMg@mail.gmail.com>
 <d4bdea97-1e92-6422-01c4-bf7caca4ea45@linaro.org>
In-Reply-To: <d4bdea97-1e92-6422-01c4-bf7caca4ea45@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Sep 2023 18:09:44 +0200
Message-ID: <CAJZ5v0hOJYuaJ2VXPCrHZspOjj342+NkB=nHXPT6YKvy90XXBA@mail.gmail.com>
Subject: Re: [PATCH v1 06/13] thermal: gov_fair_share: Rearrange get_trip_level()
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
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

On Wed, Sep 27, 2023 at 5:37 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/09/2023 17:06, Rafael J. Wysocki wrote:
> > On Wed, Sep 27, 2023 at 5:00 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 21/09/2023 19:54, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make get_trip_level() access the thermal zone's trip table directly
> >>> instead of using __thermal_zone_get_trip() which adds overhead related
> >>> to the unnecessary bounds checking and copying the trip point data.
> >>>
> >>> Also rearrange the code in it to make it somewhat easier to follow.
> >>>
> >>> The general functionality is not expected to be changed.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>    drivers/thermal/gov_fair_share.c |   22 ++++++++++------------
> >>>    1 file changed, 10 insertions(+), 12 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/thermal/gov_fair_share.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/thermal/gov_fair_share.c
> >>> +++ linux-pm/drivers/thermal/gov_fair_share.c
> >>> @@ -21,23 +21,21 @@
> >>>     */
> >>>    static int get_trip_level(struct thermal_zone_device *tz)
> >>>    {
> >>> -     struct thermal_trip trip;
> >>> -     int count;
> >>> +     const struct thermal_trip *trip = tz->trips;
> >>> +     int i;
> >>>
> >>> -     for (count = 0; count < tz->num_trips; count++) {
> >>> -             __thermal_zone_get_trip(tz, count, &trip);
> >>> -             if (tz->temperature < trip.temperature)
> >>> +     if (tz->temperature < trip->temperature)
> >>> +             return 0;
> >>> +
> >>> +     for (i = 0; i < tz->num_trips - 1; i++) {
> >>> +             trip++;
> >>> +             if (tz->temperature < trip->temperature)
> >>>                        break;
> >>>        }
> >>
> >> Is it possible to use for_each_thermal_trip() instead ? That would make
> >> the code more self-encapsulate
> >
> > It is possible in principle, but this is a governor which is regarded
> > as part of the core, isn't it?
> >
> > So is an extra overhead related to using a callback (which may be
> > subject to retpolines and such) really justified in this case?
>
>  From my POV, all trip points browsing should be replaced by
> for_each_thermal_trip() so any change in the future in how we go through
> the existing thermal trips will impact one place.
>
> If the routine needs to be optimized, that is something we can do also
> (may be an inline the callback?)

OK
