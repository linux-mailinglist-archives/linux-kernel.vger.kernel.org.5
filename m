Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CCA7C889B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjJMP1Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjJMP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:27:24 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B689C9;
        Fri, 13 Oct 2023 08:27:20 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57ddba5ba84so229993eaf.0;
        Fri, 13 Oct 2023 08:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210840; x=1697815640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nUDXrT0stOFmjcIAQLP4jzYXflJAno/zxPmKI4vR7E=;
        b=BfKe6vZFK9UPCP3lDG/ssgFfC2/oI/3NlUUM06tspoUuH/Blz4PZKHDesT/jESKdNO
         moGmCD8W6r/rqa33MN+FzxtKo03AT8C3y9oLfL6MPuOgT66761zQtw9wkTU9IxtFOpdG
         X9iWdBFFc97XGG1ryI1FGDEkak+skJdvGM1EWEQJvx8q1Icbqehd0Gm5CFugVcjNCRVl
         6ZGKqQeUO39tHjb4n1IyB2lD6NQE6setpghs9EZYxgoYzhIiHblsolvnJD36nXS9I7gz
         +7o2t+wMyk4QGr7NcBPEkf741ddiUFvNuAxNbL+Z1mI/801isMHA53eXtm5ogpQ1AH5C
         mZ6g==
X-Gm-Message-State: AOJu0YxfSUgvgilNI0rKARARjtwJowYtJYzy3oH2zd/tgKuPCmiOCCir
        u4uiJOhxygyK6ypImH2+Ji2sVQx+Hw3fg7/NAnA=
X-Google-Smtp-Source: AGHT+IFGEiYulFwt6vAOmsUSk7LDEV6P/ugFJQ9isRKdOdnVbJrwx4O5eNPTzxh5lPgeAxsE8BNFt5f4UQ1nfKWZWRE=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr25632718ooo.0.1697210839825; Fri, 13 Oct
 2023 08:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230922184425.290894-1-nfraprado@collabora.com> <6627b83b-bee7-a123-d845-cad8523ffb30@collabora.com>
In-Reply-To: <6627b83b-bee7-a123-d845-cad8523ffb30@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Oct 2023 17:27:08 +0200
Message-ID: <CAJZ5v0hU9E10BeEjF-PZ8Yx9NZO1YimitockY3Hsobha7dARDQ@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/core: Don't update trip points inside the
 hysteresis range
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Caesar Wang <wxt@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
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

On Mon, Sep 25, 2023 at 9:29 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 22/09/23 20:44, Nícolas F. R. A. Prado ha scritto:
> > When searching for the trip points that need to be set, the nearest
> > higher trip point's temperature is used for the high trip, while the
> > nearest lower trip point's temperature minus the hysteresis is used for
> > the low trip. The issue with this logic is that when the current
> > temperature is inside a trip point's hysteresis range, both high and low
> > trips will come from the same trip point. As a consequence instability
> > can still occur like this:
> > * the temperature rises slightly and enters the hysteresis range of a
> >    trip point
> > * polling happens and updates the trip points to the hysteresis range
> > * the temperature falls slightly, exiting the hysteresis range, crossing
> >    the trip point and triggering an IRQ, the trip points are updated
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
> > The following logs show the current behavior when running on a real
> > machine:
> >
> > [  202.524658] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 40000
> >     203.562817: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=36986 temp=37979
> > [  203.562845] thermal thermal_zone0: new temperature boundaries: 37000 < x < 40000
> >     204.176059: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=37979 temp=40028
> > [  204.176089] thermal thermal_zone0: new temperature boundaries: 37000 < x < 100000
> >     205.226813: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=40028 temp=38652
> > [  205.226842] thermal thermal_zone0: new temperature boundaries: 37000 < x < 40000
> >
> > And with this patch applied:
> >
> > [  184.933415] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 40000
> >     185.981182: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=36986 temp=37872
> >     186.744685: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=37872 temp=40058
> > [  186.744716] thermal thermal_zone0: new temperature boundaries: 37000 < x < 100000
> >     187.773284: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=40058 temp=38698
> >
> > Fixes: 060c034a9741 ("thermal: Add support for hardware-tracked trip points")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> >
> > ---
> >
> > Changes in v2:
> > - Changed logic as suggested by Rafael
> > - Added log example to commit message
> > - Added fixes tag
> >
> >   drivers/thermal/thermal_trip.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> > index 024e2e365a26..597ac4144e33 100644
> > --- a/drivers/thermal/thermal_trip.c
> > +++ b/drivers/thermal/thermal_trip.c
> > @@ -55,6 +55,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> >   {
> >       struct thermal_trip trip;
> >       int low = -INT_MAX, high = INT_MAX;
> > +     bool same_trip = false;
> >       int i, ret;
> >
> >       lockdep_assert_held(&tz->lock);
> > @@ -63,6 +64,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> >               return;
> >
> >       for (i = 0; i < tz->num_trips; i++) {
> > +             bool low_set = false;
> >               int trip_low;
> >
> >               ret = __thermal_zone_get_trip(tz, i , &trip);
> > @@ -71,18 +73,31 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
> >
> >               trip_low = trip.temperature - trip.hysteresis;
> >
> > -             if (trip_low < tz->temperature && trip_low > low)
> > +             if (trip_low < tz->temperature && trip_low > low) {
> >                       low = trip_low;
> > +                     low_set = true;
> > +                     same_trip = false;
> > +             }
> >
> >               if (trip.temperature > tz->temperature &&
> > -                 trip.temperature < high)
> > +                 trip.temperature < high) {
> >                       high = trip.temperature;
> > +                     same_trip = low_set;
> > +             }
> >       }
> >
> >       /* No need to change trip points */
> >       if (tz->prev_low_trip == low && tz->prev_high_trip == high)
> >               return;
> >
> > +     /*
> > +      * If "high" and "low" are the same, skip the change unless this is the
> > +      * first time.
> > +      */
> > +     if (same_trip && (tz->prev_low_trip != -INT_MAX ||
> > +         tz->prev_high_trip != INT_MAX))
> > +             return;
> > +
> >       tz->prev_low_trip = low;
> >       tz->prev_high_trip = high;
> >

Applied as 6.7 material, but I added a Co-developed-by tag for myself,
because it has been based on my patch.

Thanks!
