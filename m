Return-Path: <linux-kernel+bounces-25335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ADD82CDC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3A2283C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83D4C89;
	Sat, 13 Jan 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="G/I/b9oK"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102B4C65;
	Sat, 13 Jan 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1705163200; bh=RQlY+jEYkNLZGSgB/4+Cf47fWKFdF0+OLYk1Sb7uF+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/I/b9oKpQhGjP/14desRRYG8sMKpLx0JWeRFYydyZP7r/cFiUD/Y11H2OamR/UNm
	 OkEGffzV7F0OAAUeJQqTvGegggOR/usBXKq6LPgePZuFk525StbLlBi6+gc9+RY8gP
	 iy/UNECCrwYRIBhq43eBj8CISLvN1l7AHeUO6fPP3DrD+7EuV4lIl5WSUe6dTc6bPW
	 WVoV9gN74SHfkAVy3Cu9T/A9uvkA0PI/sMNePG1Hn8xsL2x3uOBysXFOhRpMJN5Imu
	 SI1c2JtdZnP37Rq3iGD82NCNpvyKF0360mVtffbiRlqqGG3rPMRzWZov9rX1a8qlSk
	 MTjIfaslZq4uQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 6091C1000C6; Sat, 13 Jan 2024 16:26:40 +0000 (GMT)
Date: Sat, 13 Jan 2024 16:26:40 +0000
From: Sean Young <sean@mess.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, tony@atomide.com,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] drivers/clocksource/timer-ti-dm: Don't call
 clk_get_rate() in stop function
Message-ID: <ZaK5wOHxf2CvzZrk@gofer.mess.org>
References: <1696312220-11550-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696312220-11550-1-git-send-email-ivo.g.dimitrov.75@gmail.com>

Hi Ivaylo,

On Tue, Oct 03, 2023 at 08:50:20AM +0300, Ivaylo Dimitrov wrote:
> clk_get_rate() might sleep, and that prevents dm-timer based PWM from being
> used from atomic context.

Now that this is merged, pwm-ir-tx can only use the pwm in atomic context
if pwm-omap-timer.c sets the atomic field like the rpi pwm does here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-bcm2835.c#n175

see pwm-ir-tx here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/rc/pwm-ir-tx.c#n170

It would be nice to have this tested and working properly for the n900.

Thanks,

Sean


> 
> Fix that by getting fclk rate in probe() and using a notifier in case rate
> changes.
> 
> Fixes: af04aa856e93 ("ARM: OMAP: Move dmtimer driver out of plat-omap to drivers under clocksource")
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  drivers/clocksource/timer-ti-dm.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> index 09ab29c..5f60f6b 100644
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -140,6 +140,8 @@ struct dmtimer {
>  	struct platform_device *pdev;
>  	struct list_head node;
>  	struct notifier_block nb;
> +	struct notifier_block fclk_nb;
> +	unsigned long fclk_rate;
>  };
>  
>  static u32 omap_reserved_systimers;
> @@ -253,8 +255,7 @@ static inline void __omap_dm_timer_enable_posted(struct dmtimer *timer)
>  	timer->posted = OMAP_TIMER_POSTED;
>  }
>  
> -static inline void __omap_dm_timer_stop(struct dmtimer *timer,
> -					unsigned long rate)
> +static inline void __omap_dm_timer_stop(struct dmtimer *timer)
>  {
>  	u32 l;
>  
> @@ -269,7 +270,7 @@ static inline void __omap_dm_timer_stop(struct dmtimer *timer,
>  		 * Wait for functional clock period x 3.5 to make sure that
>  		 * timer is stopped
>  		 */
> -		udelay(3500000 / rate + 1);
> +		udelay(3500000 / timer->fclk_rate + 1);
>  #endif
>  	}
>  
> @@ -348,6 +349,21 @@ static int omap_timer_context_notifier(struct notifier_block *nb,
>  	return NOTIFY_OK;
>  }
>  
> +static int omap_timer_fclk_notifier(struct notifier_block *nb,
> +				    unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *clk_data = data;
> +	struct dmtimer *timer = container_of(nb, struct dmtimer, fclk_nb);
> +
> +	switch (event) {
> +	case POST_RATE_CHANGE:
> +		timer->fclk_rate = clk_data->new_rate;
> +		return NOTIFY_OK;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
>  static int omap_dm_timer_reset(struct dmtimer *timer)
>  {
>  	u32 l, timeout = 100000;
> @@ -754,7 +770,6 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
>  {
>  	struct dmtimer *timer;
>  	struct device *dev;
> -	unsigned long rate = 0;
>  
>  	timer = to_dmtimer(cookie);
>  	if (unlikely(!timer))
> @@ -762,10 +777,7 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
>  
>  	dev = &timer->pdev->dev;
>  
> -	if (!timer->omap1)
> -		rate = clk_get_rate(timer->fclk);
> -
> -	__omap_dm_timer_stop(timer, rate);
> +	__omap_dm_timer_stop(timer);
>  
>  	pm_runtime_put_sync(dev);
>  
> @@ -1124,6 +1136,14 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
>  		timer->fclk = devm_clk_get(dev, "fck");
>  		if (IS_ERR(timer->fclk))
>  			return PTR_ERR(timer->fclk);
> +
> +		timer->fclk_nb.notifier_call = omap_timer_fclk_notifier;
> +		ret = devm_clk_notifier_register(dev, timer->fclk,
> +						 &timer->fclk_nb);
> +		if (ret)
> +			return ret;
> +
> +		timer->fclk_rate = clk_get_rate(timer->fclk);
>  	} else {
>  		timer->fclk = ERR_PTR(-ENODEV);
>  	}
> -- 
> 1.9.1

