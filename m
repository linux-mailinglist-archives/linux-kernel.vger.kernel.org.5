Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7867C725A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379527AbjJLQVY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 12:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbjJLQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:21:21 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3661D8;
        Thu, 12 Oct 2023 09:21:19 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57ddba5ba84so124139eaf.0;
        Thu, 12 Oct 2023 09:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127679; x=1697732479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fghx/3ez5n58sg38991FNjnRDD8UbfxWtztsAcswAE8=;
        b=cZOwT7QKDoD5LPE6pZwbu9oHivlESZotA1GUIOH9rKijipk5a0fTEYrr62Nxmwc5hY
         ElEHqL6YzRXo++MWDYYHnUCLzJQ4YrfQ7viDAzRFQjCHKZW/xAMTs2HbAsfzafdahsch
         T9tfsW9LcXXaLThtgxlsv+mXJWVrv/vkNd7t6jLuw/fFL/0/LANC+d5bVzOQdkPEoUcz
         sDPN4OPcUCJFRvLk1/zwfj2ajrB+tHAi9fMiUIhIXfFc9tVilpHWhkbcW4W9exQK0AVu
         2guPZFmkp1EADTZExurtdGtmbkdQCb1PaOev3AdIVshmAXtwcHDgV+jra9I9lYMaGEn5
         fZPg==
X-Gm-Message-State: AOJu0YxGpkMgr+9CwDiQP+TQEm0DeYXas0kzfO/y4WODoXPQLoXagVYr
        STU+8PJI1lE1uZA3QOwmb/cF/oDf16xBB9TzT+z3g51JVI0=
X-Google-Smtp-Source: AGHT+IEtwVncZ1lNS/4QhQySCQtVDBTBTrHBnDC97w1kkgBQ2mlqnkLCMS+6fCDQkcNyuKd4fdP9SgKcafwgPr03XH0=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr22923283ooo.0.1697127679100; Thu, 12 Oct
 2023 09:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <13365827.uLZWGnKmhe@kreacher> <3256881.aeNJFYEL58@kreacher> <d2d6fae5-ace7-4b94-9354-a01cd6a7e343@linaro.org>
In-Reply-To: <d2d6fae5-ace7-4b94-9354-a01cd6a7e343@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 18:21:08 +0200
Message-ID: <CAJZ5v0iBD-z6-ncM4jG_eDp+TNBLpPXSrhyrSC+UCt--wmf_8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] thermal: trip: Simplify computing trip indices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Oct 12, 2023 at 4:27 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 06/10/2023 19:40, Rafael J. Wysocki wrote:
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
>
> Shouldn't be divided by sizeof(*trip) ?

No, it's in sizeof(*trip) units already.
