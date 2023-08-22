Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE0783E73
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjHVK6d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjHVK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:58:30 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C20E5B;
        Tue, 22 Aug 2023 03:58:11 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-570e8bee8b5so205521eaf.1;
        Tue, 22 Aug 2023 03:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701891; x=1693306691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzUMRMzjXb63NCDMZbdIbs0HqsTWUd8TxRKoGYC/IaU=;
        b=SA1/EEI8E+9E+B4Y+4ExxCGl7lKmggpROuzE05MzpZ2E6XTP22ZtNsfkExrbQkSKu8
         7ZVfBs8CIxSF7dwitfFiSKcm3dvGOmPwz4cStERfXYl6DvZPRpMg8ongm6uKdrP6/4kA
         bGJU66llXQw+6zFK6tK5Re4fp8asVPw2G5qOPChHjlfdcJWBKuuTOjnHcpvRmpw7bJfa
         Bx10PLgwFXiWnGD/EuMSbAGN99Za4TorK6Pb5zIpEdIrIyDBfkRudsl7qJx0XDUs1WoK
         aj+GMQJS/xzA/KT/iy9Xr2fEtysQWM62oJXfMpj0Sbj3oA/JUJ0USUCZupuSvwh8HCty
         tQVA==
X-Gm-Message-State: AOJu0YxYganVjYnhBTKahMuhfS6xfshzLee3tQYe8cRrtjIPAc6fy6w0
        SLp5uVfe24k9B3YeBfKv4+phEdLBdR4Cu12MoYmaZFqtpdI=
X-Google-Smtp-Source: AGHT+IFqoo8tMg6z8+/ufGWKwwyt1Lcv5RFIHXJg9VhsKTc573xrc6Ub61TJlR3I7s7mvjs6O8FaiN7FWSl3Ed5+uzY=
X-Received: by 2002:a4a:e882:0:b0:570:d852:f77f with SMTP id
 g2-20020a4ae882000000b00570d852f77fmr4544769ooe.1.1692701891063; Tue, 22 Aug
 2023 03:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230703171502.44657-1-nfraprado@collabora.com>
 <CAJZ5v0hiiiReiJBPZRCMs16E247GL-nJGjnwkiMCNq5q4VjkyQ@mail.gmail.com> <3bc5be02-4e05-4c5c-a247-58c4b862528d@notapiano>
In-Reply-To: <3bc5be02-4e05-4c5c-a247-58c4b862528d@notapiano>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 12:57:59 +0200
Message-ID: <CAJZ5v0gwgBmj0XaLhBz0puSOA_OYUy0oFEjoBVCWjT3XW+qZVg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Don't update trip points inside the
 hysteresis range
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Tue, Aug 22, 2023 at 12:25 AM Nícolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Mon, Aug 21, 2023 at 11:10:27PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 3, 2023 at 7:15 PM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > When searching for the trip points that need to be set, the nearest trip
> > > point's temperature is used for the high trip, while the nearest trip
> > > point's temperature minus the hysteresis is used for the low trip. The
> > > issue with this logic is that when the current temperature is inside a
> > > trip point's hysteresis range, both high and low trips will come from
> > > the same trip point. As a consequence instability can still occur like
> > > this:
> > > * the temperature rises slightly and enters the hysteresis range of a
> > >   trip point
> > > * polling happens and updates the trip points to the hysteresis range
> > > * the temperature falls slightly, exiting the hysteresis range, crossing
> > >   the trip point and triggering an IRQ, the trip points are updated
> > > * repeat
> > >
> > > So even though the current hysteresis implementation prevents
> > > instability from happening due to IRQs triggering on the same
> > > temperature value, both ways, it doesn't prevent it from happening due
> > > to an IRQ on one way and polling on the other.
> > >
> > > To properly implement a hysteresis behavior, when inside the hysteresis
> > > range, don't update the trip points. This way, the previously set trip
> > > points will stay in effect, which will in a way remember the previous
> > > state (if the temperature signal came from above or below the range) and
> > > therefore have the right trip point already set. The exception is if
> > > there was no previous trip point set, in which case a previous state
> > > doesn't exist, and so it's sensible to allow the hysteresis range as
> > > trip points.
> > >
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > >
> > > ---
> > >
> > >  drivers/thermal/thermal_trip.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> > > index 907f3a4d7bc8..c386ac5d8bad 100644
> > > --- a/drivers/thermal/thermal_trip.c
> > > +++ b/drivers/thermal/thermal_trip.c
> > > @@ -57,6 +57,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> > >  {
> > >         struct thermal_trip trip;
> > >         int low = -INT_MAX, high = INT_MAX;
> > > +       int low_trip_id = -1, high_trip_id = -2;
> > >         int i, ret;
> > >
> > >         lockdep_assert_held(&tz->lock);
> > > @@ -73,18 +74,34 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> > >
> > >                 trip_low = trip.temperature - trip.hysteresis;
> > >
> > > -               if (trip_low < tz->temperature && trip_low > low)
> > > +               if (trip_low < tz->temperature && trip_low > low) {
> > >                         low = trip_low;
> > > +                       low_trip_id = i;
> > > +               }
> > >
> >
> > I think I get the idea, but wouldn't a similar effect be achieved by
> > adding an "else" here?
>
> No. That would only fix the problem in one direction, namely, when the
> temperature entered the hysteresis range from above. But when the temperature
> entered the range from below, we'd need to check the high threshold first to
> achieve the same result.
>
> The way I've implemented here is the simplest I could think of that works for
> both directions.

Well, what about the replacement patch below (untested)?

---
 drivers/thermal/thermal_trip.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -55,6 +55,7 @@ void __thermal_zone_set_trips(struct the
 {
     struct thermal_trip trip;
     int low = -INT_MAX, high = INT_MAX;
+    bool same_trip = false;
     int i, ret;

     lockdep_assert_held(&tz->lock);
@@ -63,6 +64,7 @@ void __thermal_zone_set_trips(struct the
         return;

     for (i = 0; i < tz->num_trips; i++) {
+        bool low_set = false;
         int trip_low;

         ret = __thermal_zone_get_trip(tz, i , &trip);
@@ -71,18 +73,31 @@ void __thermal_zone_set_trips(struct the

         trip_low = trip.temperature - trip.hysteresis;

-        if (trip_low < tz->temperature && trip_low > low)
+        if (trip_low < tz->temperature && trip_low > low) {
             low = trip_low;
+            low_set = true;
+            same_trip = false;
+        }

         if (trip.temperature > tz->temperature &&
-            trip.temperature < high)
+            trip.temperature < high) {
             high = trip.temperature;
+            same_trip = low_set;
+        }
     }

     /* No need to change trip points */
     if (tz->prev_low_trip == low && tz->prev_high_trip == high)
         return;

+    /*
+     * If "high" and "low" are the same, skip the change unless this is the
+     * first time.
+     */
+    if (same_trip && (tz->prev_low_trip != -INT_MAX ||
+        tz->prev_high_trip != INT_MAX))
+        return;
+
     tz->prev_low_trip = low;
     tz->prev_high_trip = high;
