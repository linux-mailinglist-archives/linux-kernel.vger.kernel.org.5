Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34607D14BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJTRTX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377886AbjJTRTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:19:21 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03901D6F;
        Fri, 20 Oct 2023 10:19:19 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-57b83ff7654so60093eaf.1;
        Fri, 20 Oct 2023 10:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822359; x=1698427159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZdk3IcTInpdu6dxFpN0K1xv4jMgNLN6oNZ7x7JyzCo=;
        b=AhX5+W6N1NCFDJcb5tXA04V0IWNWY7UsKddrgv3ryhdi8SXVBGTZYHtn/kPG1+g19J
         tjScrV3xPZvcvWwNJqVsrAlIIvwQstCK25IsJ8yIl5m6QyVa1wFmBAH4WmQDsOD8tHTA
         YpfHplqIhICBa8Cex71hbzse9k1MqaHVa2/gbmylM68qUt+G4c7fcWAS3m9RUtedQ8p3
         xTE8W1A2VvNj0r8Ltf6BxvmRjogIGT7HEzqJ1nAP9tCCRhxBup2WZgcpByXrjx2izs51
         0+07MRl9gP9H67SmyvFW8DvTS7FxV8TB5kH0yRyyIvyv5ebQ8rGz1AtgoFYzrEQnd27Z
         c+Fg==
X-Gm-Message-State: AOJu0YxdR+gWBAAiqfPME/0sLBfgnx4QdSU4+243beybFSLM4AUZQGuz
        dmQWrU1EeoVaprBMQNOBahNiW7WBoiQsmo9CJ68=
X-Google-Smtp-Source: AGHT+IEbQq8YrmdXgL+MSVnT0GuElAEUqPisQdazuRTc9bl+OmZNuqaQgzsDJWHe1BP1Pigr5y6ig4GK4kRYrEfNFws=
X-Received: by 2002:a4a:e9ed:0:b0:584:537:ffbd with SMTP id
 w13-20020a4ae9ed000000b005840537ffbdmr2759105ooc.0.1697822359012; Fri, 20 Oct
 2023 10:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <8282829.T7Z3S40VBb@kreacher> <63b7f4da-8ddb-443c-8074-66b7b0c6cd84@arm.com>
In-Reply-To: <63b7f4da-8ddb-443c-8074-66b7b0c6cd84@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 19:19:08 +0200
Message-ID: <CAJZ5v0j9aZ-TGWj5oKeG3+pdDwpYv4y28-k3UtUMiyAroDMN5Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] thermal: trip: Define for_each_trip() macro
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Fri, Oct 20, 2023 at 7:14 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 10/6/23 18:41, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Define a new macro for_each_trip() to be used by the thermal core code
> > and thermal governors for walking trips in a given thermal zone.
> >
> > Modify for_each_thermal_trip() to use this macro instead of an open-
> > coded loop over trips.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_core.h |    3 +++
> >   drivers/thermal/thermal_trip.c |    7 ++++---
> >   2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_core.h
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_core.h
> > +++ linux-pm/drivers/thermal/thermal_core.h
> > @@ -116,6 +116,9 @@ void __thermal_zone_device_update(struct
> >                                 enum thermal_notify_event event);
> >
> >   /* Helpers */
> > +#define for_each_trip(__tz, __trip)  \
> > +     for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
> > +
> >   void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> >   int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> >                           struct thermal_trip *trip);
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -13,12 +13,13 @@ int for_each_thermal_trip(struct thermal
> >                         int (*cb)(struct thermal_trip *, void *),
> >                         void *data)
> >   {
> > -     int i, ret;
> > +     struct thermal_trip *trip;
> > +     int ret;
> >
> >       lockdep_assert_held(&tz->lock);
> >
> > -     for (i = 0; i < tz->num_trips; i++) {
> > -             ret = cb(&tz->trips[i], data);
> > +     for_each_trip(tz, trip) {
> > +             ret = cb(trip, data);
> >               if (ret)
> >                       return ret;
> >       }
> >
> >
> >
>
> LGTM
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks!
