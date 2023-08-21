Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D68078359A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjHUWZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjHUWZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:25:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FF186;
        Mon, 21 Aug 2023 15:25:45 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD4F26606FC2;
        Mon, 21 Aug 2023 23:25:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692656743;
        bh=l/wG3p2sA+TVeOg0PE9sGueWyLHVUoq7ed7m13hcpKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b9BC/UvIvybq2hj1EiJ8OnfC5iZLio9THfVXvsEpgsYMqE1RMPgvWw++W79AnFYx1
         uYtd3/iPWhhUxwG0HIzPMsLDmzbFkCQGsJ+K/ZOCv0/OpNrrN0IUUH1+SUDXSLVg+u
         7gPsRiZwoNP7dRg3KGTFMeroAREyG8uNO3aGSzWXEjGmzeO/T0ILmXZvHHNR7MP7qu
         jVrwxJPotHe+5RLOTeVspQyPuDpi7ghIJ06Z0CMhuPOmjmFhsHl5MeawjnuxVfIkqo
         avRuzg3PUVW4sGZQar0Dtm1ZjDLoZinLC/7l46RRDjRe5gpAKw1hhTM+9Md3phzA1E
         ND2VS621HPLRw==
Date:   Mon, 21 Aug 2023 18:25:38 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal/core: Don't update trip points inside the
 hysteresis range
Message-ID: <3bc5be02-4e05-4c5c-a247-58c4b862528d@notapiano>
References: <20230703171502.44657-1-nfraprado@collabora.com>
 <CAJZ5v0hiiiReiJBPZRCMs16E247GL-nJGjnwkiMCNq5q4VjkyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hiiiReiJBPZRCMs16E247GL-nJGjnwkiMCNq5q4VjkyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:10:27PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jul 3, 2023 at 7:15 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > When searching for the trip points that need to be set, the nearest trip
> > point's temperature is used for the high trip, while the nearest trip
> > point's temperature minus the hysteresis is used for the low trip. The
> > issue with this logic is that when the current temperature is inside a
> > trip point's hysteresis range, both high and low trips will come from
> > the same trip point. As a consequence instability can still occur like
> > this:
> > * the temperature rises slightly and enters the hysteresis range of a
> >   trip point
> > * polling happens and updates the trip points to the hysteresis range
> > * the temperature falls slightly, exiting the hysteresis range, crossing
> >   the trip point and triggering an IRQ, the trip points are updated
> > * repeat
> >
> > So even though the current hysteresis implementation prevents
> > instability from happening due to IRQs triggering on the same
> > temperature value, both ways, it doesn't prevent it from happening due
> > to an IRQ on one way and polling on the other.
> >
> > To properly implement a hysteresis behavior, when inside the hysteresis
> > range, don't update the trip points. This way, the previously set trip
> > points will stay in effect, which will in a way remember the previous
> > state (if the temperature signal came from above or below the range) and
> > therefore have the right trip point already set. The exception is if
> > there was no previous trip point set, in which case a previous state
> > doesn't exist, and so it's sensible to allow the hysteresis range as
> > trip points.
> >
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> >
> > ---
> >
> >  drivers/thermal/thermal_trip.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> > index 907f3a4d7bc8..c386ac5d8bad 100644
> > --- a/drivers/thermal/thermal_trip.c
> > +++ b/drivers/thermal/thermal_trip.c
> > @@ -57,6 +57,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> >  {
> >         struct thermal_trip trip;
> >         int low = -INT_MAX, high = INT_MAX;
> > +       int low_trip_id = -1, high_trip_id = -2;
> >         int i, ret;
> >
> >         lockdep_assert_held(&tz->lock);
> > @@ -73,18 +74,34 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> >
> >                 trip_low = trip.temperature - trip.hysteresis;
> >
> > -               if (trip_low < tz->temperature && trip_low > low)
> > +               if (trip_low < tz->temperature && trip_low > low) {
> >                         low = trip_low;
> > +                       low_trip_id = i;
> > +               }
> >
> 
> I think I get the idea, but wouldn't a similar effect be achieved by
> adding an "else" here?

No. That would only fix the problem in one direction, namely, when the
temperature entered the hysteresis range from above. But when the temperature
entered the range from below, we'd need to check the high threshold first to
achieve the same result.

The way I've implemented here is the simplest I could think of that works for
both directions. 

Thanks,
Nícolas

> 
> >                 if (trip.temperature > tz->temperature &&
> > -                   trip.temperature < high)
> > +                   trip.temperature < high) {
> >                         high = trip.temperature;
> > +                       high_trip_id = i;
> > +               }
> >         }
> >
> >         /* No need to change trip points */
> >         if (tz->prev_low_trip == low && tz->prev_high_trip == high)
> >                 return;
> >
> > +       /*
> > +        * If the current temperature is inside a trip point's hysteresis range,
> > +        * don't update the trip points, rely on the previously set ones to
> > +        * rememember the previous state.
> > +        *
> > +        * Unless no previous trip point was set, in which case there's no
> > +        * previous state to remember.
> > +        */
> > +       if ((tz->prev_low_trip > -INT_MAX || tz->prev_high_trip < INT_MAX) &&
> > +           low_trip_id == high_trip_id)
> > +               return;
> > +
> >         tz->prev_low_trip = low;
> >         tz->prev_high_trip = high;
> >
> > --
