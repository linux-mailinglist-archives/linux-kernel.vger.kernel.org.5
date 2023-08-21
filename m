Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5C7834B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjHUVKm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjHUVKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:10:41 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A821113;
        Mon, 21 Aug 2023 14:10:39 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56e280cc606so534057eaf.1;
        Mon, 21 Aug 2023 14:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652238; x=1693257038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3VkaElbXUDdfTX416XO4ch3nnzvO+a6QraObVmCpUU=;
        b=AYOfw0U238ptNbH+/xQ65RxeU1j/DZhzjaoSihEA8wetJB0ORdrzoF1tdu9Y3pdKpw
         MjuFG08tqKbQ9rFyQqXQvs4X9ocwLx3XTr9nEl+LVvLBsJIpA0cLyjrYNs6lNfHjtPnV
         8o3rK+mjzXtdNm/RPbAvPqG2R6FNvQ5zQXqxXtSOwSzjTK/73a4vmnHnhjX5q8yDFRXf
         iIEyj0K2v5UKKVI3fqyqnVCBRiufTM/tksux4+cV8b9Sc7Mdw47ae72pEli+lVT+ErBu
         HSnDQHu8tEBGa961RY6p49g9TuPrQday/SL8PwbPwbto3urofDNxZo2KO0t27OUy17jX
         je7g==
X-Gm-Message-State: AOJu0Ywuila9quvv2l+tE8UVk28WtdhTxfiPFEhRMgMrd2pr1QlHsAju
        HLtnHQqRdzaGBYVNBeHVmqrZPWempL1dXUIFRdbCGWeC
X-Google-Smtp-Source: AGHT+IHzghcRQ9Pnqhre/wjZH1QWgPRg9m085l5BTowOExRsX+CsEexMxP6omb/iU4xVrS8FnUdrcFKR9OYw/d1JOms=
X-Received: by 2002:a4a:37c3:0:b0:570:cad0:fce9 with SMTP id
 r186-20020a4a37c3000000b00570cad0fce9mr3955923oor.1.1692652238387; Mon, 21
 Aug 2023 14:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230703171502.44657-1-nfraprado@collabora.com>
In-Reply-To: <20230703171502.44657-1-nfraprado@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 23:10:27 +0200
Message-ID: <CAJZ5v0hiiiReiJBPZRCMs16E247GL-nJGjnwkiMCNq5q4VjkyQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Don't update trip points inside the
 hysteresis range
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Mon, Jul 3, 2023 at 7:15 PM Nícolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> When searching for the trip points that need to be set, the nearest trip
> point's temperature is used for the high trip, while the nearest trip
> point's temperature minus the hysteresis is used for the low trip. The
> issue with this logic is that when the current temperature is inside a
> trip point's hysteresis range, both high and low trips will come from
> the same trip point. As a consequence instability can still occur like
> this:
> * the temperature rises slightly and enters the hysteresis range of a
>   trip point
> * polling happens and updates the trip points to the hysteresis range
> * the temperature falls slightly, exiting the hysteresis range, crossing
>   the trip point and triggering an IRQ, the trip points are updated
> * repeat
>
> So even though the current hysteresis implementation prevents
> instability from happening due to IRQs triggering on the same
> temperature value, both ways, it doesn't prevent it from happening due
> to an IRQ on one way and polling on the other.
>
> To properly implement a hysteresis behavior, when inside the hysteresis
> range, don't update the trip points. This way, the previously set trip
> points will stay in effect, which will in a way remember the previous
> state (if the temperature signal came from above or below the range) and
> therefore have the right trip point already set. The exception is if
> there was no previous trip point set, in which case a previous state
> doesn't exist, and so it's sensible to allow the hysteresis range as
> trip points.
>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
>  drivers/thermal/thermal_trip.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 907f3a4d7bc8..c386ac5d8bad 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -57,6 +57,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>  {
>         struct thermal_trip trip;
>         int low = -INT_MAX, high = INT_MAX;
> +       int low_trip_id = -1, high_trip_id = -2;
>         int i, ret;
>
>         lockdep_assert_held(&tz->lock);
> @@ -73,18 +74,34 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>
>                 trip_low = trip.temperature - trip.hysteresis;
>
> -               if (trip_low < tz->temperature && trip_low > low)
> +               if (trip_low < tz->temperature && trip_low > low) {
>                         low = trip_low;
> +                       low_trip_id = i;
> +               }
>

I think I get the idea, but wouldn't a similar effect be achieved by
adding an "else" here?

>                 if (trip.temperature > tz->temperature &&
> -                   trip.temperature < high)
> +                   trip.temperature < high) {
>                         high = trip.temperature;
> +                       high_trip_id = i;
> +               }
>         }
>
>         /* No need to change trip points */
>         if (tz->prev_low_trip == low && tz->prev_high_trip == high)
>                 return;
>
> +       /*
> +        * If the current temperature is inside a trip point's hysteresis range,
> +        * don't update the trip points, rely on the previously set ones to
> +        * rememember the previous state.
> +        *
> +        * Unless no previous trip point was set, in which case there's no
> +        * previous state to remember.
> +        */
> +       if ((tz->prev_low_trip > -INT_MAX || tz->prev_high_trip < INT_MAX) &&
> +           low_trip_id == high_trip_id)
> +               return;
> +
>         tz->prev_low_trip = low;
>         tz->prev_high_trip = high;
>
> --
