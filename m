Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB47D1488
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377655AbjJTREa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJTREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:04:30 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E1A3;
        Fri, 20 Oct 2023 10:04:28 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57de3096e25so92007eaf.1;
        Fri, 20 Oct 2023 10:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697821468; x=1698426268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SVQ8l1CCV9qwZQSfGppRIONwDwSIVUsnVYDUHbg5UE=;
        b=XknaEqI9SKWVs6Sb6yU0YQUcYW6wcwf36f1wgFVk8cOR0VZ/+C4KIe76jnVj6UVlKT
         iMKkm4LaEW8kW8Uss/VvnyOy3oPenGyS+xK7Fj1hYK5vxk8sN7+02gRFo4dT4s1bBcFz
         QWwYyLM7huCDOwrlK9NacLgXKmGrWWbxbHVCy3YXqtpN+j/FU3Y8LvSdqU5kKD2Nt9L1
         4kOyEJ5ET9LjxefLTkFw/rmILCZzNxjUeAyZu0nEh46l7S4G25dcF9qz4BRqlmvvFkyr
         cvIquDcEf3fZ/46IUD+mfuAktkfnq19F04WN17Gbf3cJZHCAxS8alLGlEO4AVTPl+SYL
         r3Zw==
X-Gm-Message-State: AOJu0Yw6+IJmkRh/+EN3A/cOptEY7n0la8vSlV7itxCbaPp3pL9UYMfj
        5I2t9mRI3LfEHQV5iId7mrW4mIwwGM88j+gxOiI=
X-Google-Smtp-Source: AGHT+IE2jkEkDXV4fjwnLfCZ+N8Trk+LUXqbn/LkhFnox09hpvFDzv5LdppOrqQ1EwhKusNcWM5qjlzsS+fb2s9xdOg=
X-Received: by 2002:a4a:bd18:0:b0:581:e7b8:dd77 with SMTP id
 n24-20020a4abd18000000b00581e7b8dd77mr2846282oop.1.1697821467835; Fri, 20 Oct
 2023 10:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <3256881.aeNJFYEL58@kreacher> <430d4342-a2fd-431f-b279-92ea90b83778@arm.com>
In-Reply-To: <430d4342-a2fd-431f-b279-92ea90b83778@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Oct 2023 19:04:16 +0200
Message-ID: <CAJZ5v0iVRedZG=dL71Ue2Msy9qHvHyY5VMzAYZwwhbieAA2J9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] thermal: trip: Simplify computing trip indices
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

On Fri, Oct 20, 2023 at 6:58 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 10/6/23 18:40, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A trip index can be computed right away as a difference between the
> > value of a trip pointer pointing to the given trip object and the
> > start of the trips[] table in the thermal zone containing the trip, so
> > change thermal_zone_trip_id() accordingly.
> >
> > No intentional functional impact (except for some speedup).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/thermal/thermal_trip.c |   13 +++++--------
> >   1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_trip.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_trip.c
> > +++ linux-pm/drivers/thermal/thermal_trip.c
> > @@ -175,14 +175,11 @@ int thermal_zone_set_trip(struct thermal
> >   int thermal_zone_trip_id(struct thermal_zone_device *tz,
> >                        const struct thermal_trip *trip)
> >   {
> > -     int i;
> > -
> >       lockdep_assert_held(&tz->lock);
> >
> > -     for (i = 0; i < tz->num_trips; i++) {
> > -             if (&tz->trips[i] == trip)
> > -                     return i;
> > -     }
> > -
> > -     return -ENODATA;
> > +     /*
> > +      * Assume the trip to be located within the bounds of the thermal
> > +      * zone's trips[] table.
> > +      */
> > +     return trip - tz->trips;
> >   }
> >
> >
> >
>
> I agree wit hthe comment, we should be safe here, since we control that
> array.
>
> I could be a bit picky about this 'int' return in that function on
> 64bit kernels, were we have also ptrdiff_t set to long IIRC. But this
> particular usage should be handled properly in all our cases, so:
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks!
