Return-Path: <linux-kernel+bounces-57051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D572384D356
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86349283F94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAD5A0EB;
	Wed,  7 Feb 2024 20:58:59 +0000 (UTC)
Received: from mail.imserv.org (mail.imserv.org [46.232.251.232])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A384A30;
	Wed,  7 Feb 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.251.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339538; cv=none; b=MibP5OflbEOg8/8AH8UpGph364mX31WEhc6mQiyBNrs3JdzidN5RE8S8mz9oxd5hIka4lE3KFKPJ4v69zYOokHM/SwWnmPef26K5VeKrSVDptoc48Amx3o4qcalllAjUN5skFj+mesPY9ur07hR7CPbJZMb6XK9Yg+wcRy2DWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339538; c=relaxed/simple;
	bh=hVfevEdzbvR5deqc7/z3+xuWOkj/6CkmlmXiUb4kwuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4HsOa0a+2QOaaPHf/O2DdXpCHMYiy5H+IO1fxJoFfIJmrJm0NQ+N08SUl1/xY4NmS3dyIcweFeYlvmipZShev3FfpHmZQa7yiDGAm5JpSnKcc4mASPKdT2Nn1Qk2Toncm2/BwwJ4mXpZFHSm3AeLRxVdOmBQzN7ZpaQgk+4XpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=imserv.org; spf=pass smtp.mailfrom=imserv.org; arc=none smtp.client-ip=46.232.251.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=imserv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imserv.org
Message-ID: <bfb48c27-aec3-421c-b597-897a36ff189e@imserv.org>
Date: Wed, 7 Feb 2024 21:52:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] gpio-mvebu: no hardcoded timer assignment for pwm
To: Finn Behrens <me@kloenk.de>, Bartosz Golaszewski <brgl@bgdev.pl>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yureka Lilian <yuka@yuka.dev>, Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240130105515.30258-1-me@kloenk.de>
From: Jannis <jannis@imserv.org>
Autocrypt: addr=jannis@imserv.org; keydata=
 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
In-Reply-To: <20240130105515.30258-1-me@kloenk.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for raising this patch. I have been adjusting it forever, would 
be great to get it in.
Looks good from my side too.


Am 30.01.2024 um 11:55 schrieb Finn Behrens:
> Removes the hardcoded timer assignment of timers to pwm controllers.
> This allows to use more than one pwm per gpio bank.
>
> Original patch with chip_data interface by Heisath <jannis@imserv.org>
>
> Link: https://wiki.kobol.io/helios4/pwm/#patch-requirement
> Co-developed-by: Yureka Lilian <yuka@yuka.dev>
> Signed-off-by: Yureka Lilian <yuka@yuka.dev>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> ---
>   drivers/gpio/gpio-mvebu.c | 223 ++++++++++++++++++++++++--------------
>   1 file changed, 139 insertions(+), 84 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index a13f3c18ccd4..303ea3be0b69 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -94,21 +94,43 @@
>   
>   #define MVEBU_MAX_GPIO_PER_BANK		32
>   
> -struct mvebu_pwm {
> +enum mvebu_pwm_ctrl {
> +	MVEBU_PWM_CTRL_SET_A = 0,
> +	MVEBU_PWM_CTRL_SET_B,
> +	MVEBU_PWM_CTRL_MAX
> +};
> +
> +struct mvebu_pwmchip {
>   	struct regmap		*regs;
>   	u32			 offset;
>   	unsigned long		 clk_rate;
> -	struct gpio_desc	*gpiod;
> -	struct pwm_chip		 chip;
>   	spinlock_t		 lock;
> -	struct mvebu_gpio_chip	*mvchip;
> +	bool			 in_use;
>   
>   	/* Used to preserve GPIO/PWM registers across suspend/resume */
> -	u32			 blink_select;
>   	u32			 blink_on_duration;
>   	u32			 blink_off_duration;
>   };
>   
> +struct mvebu_pwm_chip_drv {
> +	enum mvebu_pwm_ctrl	 ctrl;
> +	struct gpio_desc	*gpiod;
> +	bool			 master;
> +};
> +
> +struct mvebu_pwm {
> +	struct pwm_chip		 chip;
> +	struct mvebu_gpio_chip	*mvchip;
> +	struct mvebu_pwmchip	 controller;
> +	enum mvebu_pwm_ctrl	 default_controller;
> +
> +	/* Used to preserve GPIO/PWM registers across suspend/resume */
> +	u32				 blink_select;
> +	struct mvebu_pwm_chip_drv	 drv[];
> +};
> +
> +static struct mvebu_pwmchip  *mvebu_pwm_list[MVEBU_PWM_CTRL_MAX];
> +
>   struct mvebu_gpio_chip {
>   	struct gpio_chip   chip;
>   	struct regmap     *regs;
> @@ -285,12 +307,12 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip *mvchip, u32 val)
>    * Functions returning offsets of individual registers for a given
>    * PWM controller.
>    */
> -static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
> +static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwmchip *mvpwm)
>   {
>   	return mvpwm->offset + PWM_BLINK_ON_DURATION_OFF;
>   }
>   
> -static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
> +static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwmchip *mvpwm)
>   {
>   	return mvpwm->offset + PWM_BLINK_OFF_DURATION_OFF;
>   }
> @@ -623,39 +645,71 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>   	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
>   	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
>   	struct gpio_desc *desc;
> +	enum mvebu_pwm_ctrl id;
>   	unsigned long flags;
>   	int ret = 0;
> +	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
>   
> -	spin_lock_irqsave(&mvpwm->lock, flags);
> +	spin_lock_irqsave(&mvpwm->controller.lock, flags);
>   
> -	if (mvpwm->gpiod) {
> +	if (drv->gpiod || (mvchip->blink_en_reg & BIT(pwm->hwpwm))) {
>   		ret = -EBUSY;
> -	} else {
> -		desc = gpiochip_request_own_desc(&mvchip->chip,
> -						 pwm->hwpwm, "mvebu-pwm",
> -						 GPIO_ACTIVE_HIGH,
> -						 GPIOD_OUT_LOW);
> -		if (IS_ERR(desc)) {
> -			ret = PTR_ERR(desc);
> -			goto out;
> -		}
> +		goto out;
> +	}
> +
> +	desc = gpiochip_request_own_desc(&mvchip->chip,
> +					 pwm->hwpwm, "mvebu-pwm",
> +					 GPIO_ACTIVE_HIGH,
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(desc)) {
> +		ret = PTR_ERR(desc);
> +		goto out;
> +	}
>   
> -		mvpwm->gpiod = desc;
> +	ret = gpiod_direction_output(desc, 0);
> +	if (ret) {
> +		gpiochip_free_own_desc(desc);
> +		goto out;
>   	}
> +
> +	for (id = MVEBU_PWM_CTRL_SET_A; id < MVEBU_PWM_CTRL_MAX; id++) {
> +		if (!mvebu_pwm_list[id]->in_use) {
> +			drv->ctrl = id;
> +			drv->master = true;
> +			mvebu_pwm_list[id]->in_use = true;
> +			break;
> +		}
> +	}
> +
> +	if (!drv->master)
> +		drv->ctrl = mvpwm->default_controller;
> +
> +	regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
> +			   BIT(pwm->hwpwm), drv->ctrl ? BIT(pwm->hwpwm) : 0);
> +
> +	drv->gpiod = desc;
> +
> +	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
> +		    &mvpwm->blink_select);
>   out:
> -	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +	spin_unlock_irqrestore(&mvpwm->controller.lock, flags);
>   	return ret;
>   }
>   
>   static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>   {
>   	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> +	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&mvpwm->lock, flags);
> -	gpiochip_free_own_desc(mvpwm->gpiod);
> -	mvpwm->gpiod = NULL;
> -	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +	spin_lock_irqsave(&mvpwm->controller.lock, flags);
> +	if (drv->master)
> +		mvebu_pwm_list[drv->ctrl]->in_use = false;
> +
> +	gpiochip_free_own_desc(drv->gpiod);
> +	memset(drv, 0, sizeof(struct mvebu_pwm_chip_drv));
> +
> +	spin_unlock_irqrestore(&mvpwm->controller.lock, flags);
>   }
>   
>   static int mvebu_pwm_get_state(struct pwm_chip *chip,
> @@ -665,28 +719,35 @@ static int mvebu_pwm_get_state(struct pwm_chip *chip,
>   
>   	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
>   	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
> +	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
> +	struct mvebu_pwmchip *controller;
>   	unsigned long long val;
>   	unsigned long flags;
>   	u32 u;
>   
> -	spin_lock_irqsave(&mvpwm->lock, flags);
> +	if (drv->gpiod)
> +		controller = mvebu_pwm_list[drv->ctrl];
> +	else
> +		controller = &mvpwm->controller;
> +
> +	spin_lock_irqsave(&controller->lock, flags);
>   
> -	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
> +	regmap_read(controller->regs, mvebu_pwmreg_blink_on_duration(controller), &u);
>   	/* Hardware treats zero as 2^32. See mvebu_pwm_apply(). */
>   	if (u > 0)
>   		val = u;
>   	else
>   		val = UINT_MAX + 1ULL;
>   	state->duty_cycle = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC,
> -			mvpwm->clk_rate);
> +			controller->clk_rate);
>   
> -	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
> +	regmap_read(controller->regs, mvebu_pwmreg_blink_off_duration(controller), &u);
>   	/* period = on + off duration */
>   	if (u > 0)
>   		val += u;
>   	else
>   		val += UINT_MAX + 1ULL;
> -	state->period = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC, mvpwm->clk_rate);
> +	state->period = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC, controller->clk_rate);
>   
>   	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
>   	if (u)
> @@ -694,7 +755,7 @@ static int mvebu_pwm_get_state(struct pwm_chip *chip,
>   	else
>   		state->enabled = false;
>   
> -	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +	spin_unlock_irqrestore(&controller->lock, flags);
>   
>   	return 0;
>   }
> @@ -703,6 +764,8 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   			   const struct pwm_state *state)
>   {
>   	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
> +	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
> +	struct mvebu_pwmchip *controller;
>   	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
>   	unsigned long long val;
>   	unsigned long flags;
> @@ -711,7 +774,11 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (state->polarity != PWM_POLARITY_NORMAL)
>   		return -EINVAL;
>   
> -	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
> +	if (drv->gpiod)
> +		controller = mvebu_pwm_list[drv->ctrl];
> +	else
> +		controller = &mvpwm->controller;
> +	val = (unsigned long long) controller->clk_rate * state->duty_cycle;
>   	do_div(val, NSEC_PER_SEC);
>   	if (val > UINT_MAX + 1ULL)
>   		return -EINVAL;
> @@ -726,7 +793,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	else
>   		on = 1;
>   
> -	val = (unsigned long long) mvpwm->clk_rate * state->period;
> +	val = (unsigned long long) controller->clk_rate * state->period;
>   	do_div(val, NSEC_PER_SEC);
>   	val -= on;
>   	if (val > UINT_MAX + 1ULL)
> @@ -738,16 +805,16 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	else
>   		off = 1;
>   
> -	spin_lock_irqsave(&mvpwm->lock, flags);
> +	spin_lock_irqsave(&controller->lock, flags);
>   
> -	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), on);
> -	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), off);
> +	regmap_write(controller->regs, mvebu_pwmreg_blink_on_duration(controller), on);
> +	regmap_write(controller->regs, mvebu_pwmreg_blink_off_duration(controller), off);
>   	if (state->enabled)
>   		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 1);
>   	else
>   		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 0);
>   
> -	spin_unlock_irqrestore(&mvpwm->lock, flags);
> +	spin_unlock_irqrestore(&controller->lock, flags);
>   
>   	return 0;
>   }
> @@ -762,25 +829,27 @@ static const struct pwm_ops mvebu_pwm_ops = {
>   static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
>   {
>   	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
> +	struct mvebu_pwmchip *controller = &mvpwm->controller;
>   
>   	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
>   		    &mvpwm->blink_select);
> -	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
> -		    &mvpwm->blink_on_duration);
> -	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
> -		    &mvpwm->blink_off_duration);
> +	regmap_read(controller->regs, mvebu_pwmreg_blink_on_duration(controller),
> +		    &controller->blink_on_duration);
> +	regmap_read(controller->regs, mvebu_pwmreg_blink_off_duration(controller),
> +		    &controller->blink_off_duration);
>   }
>   
>   static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
>   {
>   	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
> +	struct mvebu_pwmchip *controller = &mvpwm->controller;
>   
>   	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
>   		     mvpwm->blink_select);
> -	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
> -		     mvpwm->blink_on_duration);
> -	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
> -		     mvpwm->blink_off_duration);
> +	regmap_write(controller->regs, mvebu_pwmreg_blink_on_duration(controller),
> +		     controller->blink_on_duration);
> +	regmap_write(controller->regs, mvebu_pwmreg_blink_off_duration(controller),
> +		     controller->blink_off_duration);
>   }
>   
>   static int mvebu_pwm_probe(struct platform_device *pdev,
> @@ -792,6 +861,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>   	void __iomem *base;
>   	u32 offset;
>   	u32 set;
> +	enum mvebu_pwm_ctrl ctrl_set;
>   
>   	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
>   		int ret = of_property_read_u32(dev->of_node,
> @@ -813,57 +883,39 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>   	if (IS_ERR(mvchip->clk))
>   		return PTR_ERR(mvchip->clk);
>   
> -	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
> +	mvpwm = devm_kzalloc(dev, struct_size(mvpwm, drv, mvchip->chip.ngpio), GFP_KERNEL);
>   	if (!mvpwm)
>   		return -ENOMEM;
>   	mvchip->mvpwm = mvpwm;
>   	mvpwm->mvchip = mvchip;
> -	mvpwm->offset = offset;
>   
> -	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
> -		mvpwm->regs = mvchip->regs;
> +	base = devm_platform_ioremap_resource_byname(pdev, "pwm");
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +	mvpwm->controller.regs = devm_regmap_init_mmio(&pdev->dev, base,
> +						       &mvebu_gpio_regmap_config);
> +	if (IS_ERR(mvpwm->controller.regs))
> +		return PTR_ERR(mvpwm->controller.regs);
>   
> -		switch (mvchip->offset) {
> -		case AP80X_GPIO0_OFF_A8K:
> -		case CP11X_GPIO0_OFF_A8K:
> -			/* Blink counter A */
> -			set = 0;
> -			break;
> -		case CP11X_GPIO1_OFF_A8K:
> -			/* Blink counter B */
> -			set = U32_MAX;
> -			mvpwm->offset += PWM_BLINK_COUNTER_B_OFF;
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +	/*
> +	 * User set A for lines of GPIO chip with id 0, B for GPIO chip
> +	 * with id 1. Don't allow further GPIO chips to be used for PWM.
> +	 */
> +	if (id == 0) {
> +		set = 0;
> +		ctrl_set = MVEBU_PWM_CTRL_SET_A;
> +	} else if (id == 1) {
> +		set = U32_MAX;
> +		ctrl_set = MVEBU_PWM_CTRL_SET_B;
>   	} else {
> -		base = devm_platform_ioremap_resource_byname(pdev, "pwm");
> -		if (IS_ERR(base))
> -			return PTR_ERR(base);
> -
> -		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
> -						    &mvebu_gpio_regmap_config);
> -		if (IS_ERR(mvpwm->regs))
> -			return PTR_ERR(mvpwm->regs);
> -
> -		/*
> -		 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
> -		 * with id 1. Don't allow further GPIO chips to be used for PWM.
> -		 */
> -		if (id == 0)
> -			set = 0;
> -		else if (id == 1)
> -			set = U32_MAX;
> -		else
> -			return -EINVAL;
> +		return -EINVAL;
>   	}
>   
>   	regmap_write(mvchip->regs,
>   		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
>   
> -	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
> -	if (!mvpwm->clk_rate) {
> +	mvpwm->controller.clk_rate = clk_get_rate(mvchip->clk);
> +	if (!mvpwm->controller.clk_rate) {
>   		dev_err(dev, "failed to get clock rate\n");
>   		return -EINVAL;
>   	}
> @@ -872,7 +924,10 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>   	mvpwm->chip.ops = &mvebu_pwm_ops;
>   	mvpwm->chip.npwm = mvchip->chip.ngpio;
>   
> -	spin_lock_init(&mvpwm->lock);
> +	spin_lock_init(&mvpwm->controller.lock);
> +
> +	mvpwm->default_controller = ctrl_set;
> +	mvebu_pwm_list[ctrl_set] = &mvpwm->controller;
>   
>   	return devm_pwmchip_add(dev, &mvpwm->chip);
>   }


