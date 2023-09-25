Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6577AD1A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjIYH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjIYH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:29:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFEC2;
        Mon, 25 Sep 2023 00:29:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3550066072FA;
        Mon, 25 Sep 2023 08:29:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695626984;
        bh=NIz7AxjYQTNM8H8Rw46TefzsjcnUvs+rYiu/YNmscrc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jxgd3ACqioHtDsevPcxrQ4jUXMsBjwG/exoZMuX2C0N06qzR0LgYk4HtP6nl6tG+3
         viZa+UVuPGGekmCx95aCoGaSst4pszaMTz7Gkj/svW1feu6QvyArwlMN2+tOrEhpH1
         wx5wW8vZUG3FcWoK9SU1GLKvi6kCTAgXZQZpmdOHnZQ++Gruo5KgSGuS9mChZyoONz
         R80CT3jsOo2kbQAGEQrya4K3w+x6GHW7DCw9MzSMkBtxbOAeh4gG+F1dj9nIvagn7e
         FIBTfcDIiJo0rtCysigXUWANqYI1YFRKpReTuuee3YO/AGvWe/Ww8LxOOU8tImYmG3
         mDMtuX4rrj9fg==
Message-ID: <6627b83b-bee7-a123-d845-cad8523ffb30@collabora.com>
Date:   Mon, 25 Sep 2023 09:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] thermal/core: Don't update trip points inside the
 hysteresis range
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Amit Kucheria <amitk@kernel.org>,
        Caesar Wang <wxt@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230922184425.290894-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230922184425.290894-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/09/23 20:44, Nícolas F. R. A. Prado ha scritto:
> When searching for the trip points that need to be set, the nearest
> higher trip point's temperature is used for the high trip, while the
> nearest lower trip point's temperature minus the hysteresis is used for
> the low trip. The issue with this logic is that when the current
> temperature is inside a trip point's hysteresis range, both high and low
> trips will come from the same trip point. As a consequence instability
> can still occur like this:
> * the temperature rises slightly and enters the hysteresis range of a
>    trip point
> * polling happens and updates the trip points to the hysteresis range
> * the temperature falls slightly, exiting the hysteresis range, crossing
>    the trip point and triggering an IRQ, the trip points are updated
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
> The following logs show the current behavior when running on a real
> machine:
> 
> [  202.524658] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 40000
>     203.562817: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=36986 temp=37979
> [  203.562845] thermal thermal_zone0: new temperature boundaries: 37000 < x < 40000
>     204.176059: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=37979 temp=40028
> [  204.176089] thermal thermal_zone0: new temperature boundaries: 37000 < x < 100000
>     205.226813: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=40028 temp=38652
> [  205.226842] thermal thermal_zone0: new temperature boundaries: 37000 < x < 40000
> 
> And with this patch applied:
> 
> [  184.933415] thermal thermal_zone0: new temperature boundaries: -2147483647 < x < 40000
>     185.981182: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=36986 temp=37872
>     186.744685: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=37872 temp=40058
> [  186.744716] thermal thermal_zone0: new temperature boundaries: 37000 < x < 100000
>     187.773284: thermal_temperature: thermal_zone=vpu0-thermal id=0 temp_prev=40058 temp=38698
> 
> Fixes: 060c034a9741 ("thermal: Add support for hardware-tracked trip points")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> ---
> 
> Changes in v2:
> - Changed logic as suggested by Rafael
> - Added log example to commit message
> - Added fixes tag
> 
>   drivers/thermal/thermal_trip.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 024e2e365a26..597ac4144e33 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -55,6 +55,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>   {
>   	struct thermal_trip trip;
>   	int low = -INT_MAX, high = INT_MAX;
> +	bool same_trip = false;
>   	int i, ret;
>   
>   	lockdep_assert_held(&tz->lock);
> @@ -63,6 +64,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>   		return;
>   
>   	for (i = 0; i < tz->num_trips; i++) {
> +		bool low_set = false;
>   		int trip_low;
>   
>   		ret = __thermal_zone_get_trip(tz, i , &trip);
> @@ -71,18 +73,31 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>   
>   		trip_low = trip.temperature - trip.hysteresis;
>   
> -		if (trip_low < tz->temperature && trip_low > low)
> +		if (trip_low < tz->temperature && trip_low > low) {
>   			low = trip_low;
> +			low_set = true;
> +			same_trip = false;
> +		}
>   
>   		if (trip.temperature > tz->temperature &&
> -		    trip.temperature < high)
> +		    trip.temperature < high) {
>   			high = trip.temperature;
> +			same_trip = low_set;
> +		}
>   	}
>   
>   	/* No need to change trip points */
>   	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
>   		return;
>   
> +	/*
> +	 * If "high" and "low" are the same, skip the change unless this is the
> +	 * first time.
> +	 */
> +	if (same_trip && (tz->prev_low_trip != -INT_MAX ||
> +	    tz->prev_high_trip != INT_MAX))
> +		return;
> +
>   	tz->prev_low_trip = low;
>   	tz->prev_high_trip = high;
>   
