Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697117A8354
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjITN1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjITN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:27:03 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5CA9;
        Wed, 20 Sep 2023 06:26:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5278A4000B;
        Wed, 20 Sep 2023 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695216415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IPx7Jmkoig2dFPoaQnl9oODzj/zMV0LMvfVPjxIECtc=;
        b=C8epKASfmcu4PmIHh2QuitaDTSH8j988DZ3QnPpNAYU4pZp1RPtIwaFDNE2aIhwJywqkCz
        79yz97vnpeQ9oIkv0S7CJeh4F5junoCUN1whaepE//w3z5gUZYHGmwQouTfqIr5DIXGAM6
        /Mi5EMRhR90w1WvE2zxHiTRBc2aNM9DUxgoUa5tOMSliSWpSrZMu/fn8lLEeowSJOYnN8H
        uNbT+ftnKX+hPiO3FMKh2RvJqQ8NCZSM38a6MjjHncLB1otyvmUWXPvE8fAxRX1fZ5zOoa
        LOCIZEdTjTyss70FVesOknhO26XijSm4XthbTynJmotWDnwJnGgQUGXucmSOKw==
Date:   Wed, 20 Sep 2023 15:26:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: Fix rebind failure
Message-ID: <2023092013265355e7a02a@mail.local>
References: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920115935.144391-1-biju.das.jz@bp.renesas.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 12:59:35+0100, Biju Das wrote:
> The resources allocated in alarmtimer_rtc_add_device() are not freed
> leading to re-bind failure for the endpoint driver. Fix this issue
> by adding alarmtimer_rtc_remove_device().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> This issue is found while adding irq support for built in RTC
> found on Renesas PMIC RAA215300 device. This issue should present
> on all RTC drivers which calls device_init_wakeup() in probe(). 
> ---
>  kernel/time/alarmtimer.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
> index 8d9f13d847f0..592668136bb5 100644
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -61,6 +61,7 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
>  /* rtc timer and device for setting alarm wakeups at suspend */
>  static struct rtc_timer		rtctimer;
>  static struct rtc_device	*rtcdev;
> +static struct platform_device	*rtc_pdev;

This is the alarmtimer pdev, not the RTC one, right?

>  static DEFINE_SPINLOCK(rtcdev_lock);
>  
>  /**
> @@ -109,6 +110,7 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>  		}
>  
>  		rtcdev = rtc;
> +		rtc_pdev = pdev;
>  		/* hold a reference so it doesn't go away */
>  		get_device(dev);
>  		pdev = NULL;
> @@ -123,6 +125,23 @@ static int alarmtimer_rtc_add_device(struct device *dev)
>  	return ret;
>  }
>  
> +static void alarmtimer_rtc_remove_device(struct device *dev)
> +{
> +	struct rtc_device *rtc = to_rtc_device(dev);
> +
> +	if (rtc_pdev) {
> +		module_put(rtc->owner);
> +		if (device_may_wakeup(rtc->dev.parent))
> +			device_init_wakeup(&rtc_pdev->dev, false);
> +
> +		platform_device_unregister(rtc_pdev);
> +		put_device(dev);
> +	}
> +
> +	rtcdev = NULL;
> +	rtc_pdev = NULL;
> +}
> +
>  static inline void alarmtimer_rtc_timer_init(void)
>  {
>  	rtc_timer_init(&rtctimer, NULL, NULL);
> @@ -130,6 +149,7 @@ static inline void alarmtimer_rtc_timer_init(void)
>  
>  static struct class_interface alarmtimer_rtc_interface = {
>  	.add_dev = &alarmtimer_rtc_add_device,
> +	.remove_dev = &alarmtimer_rtc_remove_device,
>  };
>  
>  static int alarmtimer_rtc_interface_setup(void)
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
