Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54337ADCF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjIYQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjIYQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:20:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BECE;
        Mon, 25 Sep 2023 09:20:47 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AA086607083;
        Mon, 25 Sep 2023 17:20:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695658845;
        bh=hLrIxPnIrH+CavuOWQVjMQm2fM6kCBplHnPFlCTy1Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9hHKlbf+AxbsU9Vfk8qvmq56+Cd8O1+RlbISjcVCQ4M+mAbPiUF7L+/E1dtIYXz6
         zBWeW/7XUOOnnx7hlIJ7Y/zCIsYxyh1MlSGprZLj2bxkI+0wScsuFw3nCY3Il2jYIE
         VDVBpLsDIVu1fAxpbuxmTnSuNJpS+7NiOTpjo91hsDEheYJlarbisBIIGrxJ1pMhnc
         ezfxL/DybGO3ZEziv44mB17mQVtJEgoAoiNOR/w4Uixuxkl+nb6H0iCbAKxKVrWKEO
         tnOXU25RBIWzHqBVXHA4irjsQPeKlLd8EjUPOd1TAXAVyDnkXfynqJvzP9i3ztOuOB
         b6Q46VZn5t6mA==
Date:   Mon, 25 Sep 2023 12:20:40 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: core: Check correct temperature for thermal
 trip notification
Message-ID: <4b38b84a-7427-45b1-b8e6-c68c5dbce676@notapiano>
References: <20230922192724.295129-1-nfraprado@collabora.com>
 <7558dd96-0d96-9463-9a97-7ea8bac2046e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7558dd96-0d96-9463-9a97-7ea8bac2046e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 12:19:18PM +0200, Daniel Lezcano wrote:
> 
> Hi Nicolas,
> 
> On 22/09/2023 21:27, Nícolas F. R. A. Prado wrote:
> > The thermal trip down notification should be triggered when the
> > temperature goes below the trip temperature minus the hysteresis. But
> > while the temperature is correctly checked against that, the last
> > temperature is instead compared against the trip point temperature. The
> > end result is that the notification won't always be triggered, only when
> > the temperature happens to drop quick enough so that the last
> > temperature was still above the trip point temperature.
> > 
> > Fix the incorrect check.
> > 
> > Fixes: 55cdf0a283b8 ("thermal: core: Add notifications call in the framework")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >   drivers/thermal/thermal_core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 58533ea75cd9..120fcf23b8e5 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -361,7 +361,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip_id)
> >   		    tz->temperature >= trip.temperature)
> >   			thermal_notify_tz_trip_up(tz->id, trip_id,
> >   						  tz->temperature);
> > -		if (tz->last_temperature >= trip.temperature &&
> > +		if (tz->last_temperature >= (trip.temperature - trip.hysteresis) &&
> >   		    tz->temperature < (trip.temperature - trip.hysteresis))
> >   			thermal_notify_tz_trip_down(tz->id, trip_id,
> >   						    tz->temperature);
> 
> We already did a try to fix the thermal trip cross notification but this is
> not sufficient for a full fix.
> 
> We are receiving multiple notifications from the same event, all this due to
> the hysteresis.
> 
> Let's say, we have a trip point T and a hysteresis H.
> 
> There is a trip point crossed the way up when:
> 
> 	last_temperature < T and temperature >= T
> 
> At this point, we send a notification
> 
> Now, the temperature decreases but it stays in the hysteresis:
> 
> 	last_temperature >= T and temperature > (T - H)
> 
> And then, the temperature increases again and is greater than T.
> 
> 	last_temperature > (T - H) and temperature >= T
> 
> We send a second notification.

Right, I've observed this issue in the logic that updates the trip points, and
just sent the v2 fix for it:

https://lore.kernel.org/all/20230922184425.290894-1-nfraprado@collabora.com

I wasn't aware of the cleanups you pointed to below, but at least in their
current form it doesn't seem they would take care of fixing the trip point
update logic like I did in that patch. So please do take a look.

It was while testing that patch that I stumbled upon this code for the
notification and just quickly fixed it. But indeed this patch is not a full fix
as the one you pointed to, so let's wait for that one.

Thanks,
Nícolas

> 
> With the mitigation kicking in at temp >= T, we end up with multiple events
> 'temperature crossed the trip point the way up"'. That forces the receiver
> of the events to detect duplicate events in order to ignore them.
> 
> More info:
> 
> 	https://lore.kernel.org/all/20220718145038.1114379-4-daniel.lezcano@linaro.org/
> 	
> We have done a lot of cleanups to use the 'generic trip points' and remove
> those get_trip_* ops. So the trip point structure is a core component being
> reused by the drivers and registered as an array.
> 
> Next step is to make sure the trip points are ordered in the array, so we
> can implement the correct trip point crossing detection.
> 
> 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
