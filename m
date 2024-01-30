Return-Path: <linux-kernel+bounces-44454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D46842245
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529DEB30550
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA3664A9;
	Tue, 30 Jan 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.de header.i=@kloenk.de header.b="WBygx/4t"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6A664D5;
	Tue, 30 Jan 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612692; cv=none; b=o9c4RzQmjlyOIYAg7Esx1DbcCJYU6zLCZB69kF1l2T3lrXZE2YH5Vf0shzsNQN0NOXJM+DnCn/5N26u96DtBbS2RfWV1mLle/CI0cyS9KMiYL0jLk+AjfCwGHL7EvRvuBLqkhAriUvx9AjZ++dVNdbrEVsEOGpXVt0QoXotpZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612692; c=relaxed/simple;
	bh=xAazWK1TBwRgBwPDjmqMpw58fFQdD/vhCbBzfIdNgnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pskkLEUE+V1UCbeOMwiiuGFD0d0aAPfxgrD4V+BLAjHqaFy08lRapPtLdbwxwMYZAV03LlJtRj75jgUKzUmiIENyibtLDKEuc0tfkP9BLRfI3M9yIJ6W2rcdOdwE4DomO1hKkWOmIQU4zSVpC6WVRIEXFURvC0vXCed5u4fKLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.de; spf=pass smtp.mailfrom=kloenk.de; dkim=pass (1024-bit key) header.d=kloenk.de header.i=@kloenk.de header.b=WBygx/4t; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.de
From: Finn Behrens <me@kloenk.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.de; s=mail;
	t=1706612151; bh=xJvrGE3xhE9lJyWcs/KsWV4ng9+Xpu8qmEntGeVtCtY=;
	h=From:To:Cc:Subject:Date;
	b=WBygx/4txnwJhHvnKKVa6OueTkZF5GvGMEK8HV51MM3ePQvHF2KMV+017p22Gmo37
	 47ZPb1m0UUzGpV8rfnmYXqioRHAe3Y64Bd2RWtjrOSzXCF4m17kkXTV6Jfpc5bQfSY
	 ipg6uAPjwC5yEJo4uoLcTW90J1EKyW1kHENL8c3E=
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Finn Behrens <me@kloenk.de>,
	Heisath <jannis@imserv.org>,
	Yureka Lilian <yuka@yuka.dev>
Subject: [PATCH] gpio-mvebu: no hardcoded timer assignment for pwm
Date: Tue, 30 Jan 2024 11:55:13 +0100
Message-ID: <20240130105515.30258-1-me@kloenk.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes the hardcoded timer assignment of timers to pwm controllers.
This allows to use more than one pwm per gpio bank.

Original patch with chip_data interface by Heisath <jannis@imserv.org>

Link: https://wiki.kobol.io/helios4/pwm/#patch-requirement
Co-developed-by: Yureka Lilian <yuka@yuka.dev>
Signed-off-by: Yureka Lilian <yuka@yuka.dev>
Signed-off-by: Finn Behrens <me@kloenk.de>
---
 drivers/gpio/gpio-mvebu.c | 223 ++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 84 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a13f3c18ccd4..303ea3be0b69 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -94,21 +94,43 @@
 
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
-struct mvebu_pwm {
+enum mvebu_pwm_ctrl {
+	MVEBU_PWM_CTRL_SET_A = 0,
+	MVEBU_PWM_CTRL_SET_B,
+	MVEBU_PWM_CTRL_MAX
+};
+
+struct mvebu_pwmchip {
 	struct regmap		*regs;
 	u32			 offset;
 	unsigned long		 clk_rate;
-	struct gpio_desc	*gpiod;
-	struct pwm_chip		 chip;
 	spinlock_t		 lock;
-	struct mvebu_gpio_chip	*mvchip;
+	bool			 in_use;
 
 	/* Used to preserve GPIO/PWM registers across suspend/resume */
-	u32			 blink_select;
 	u32			 blink_on_duration;
 	u32			 blink_off_duration;
 };
 
+struct mvebu_pwm_chip_drv {
+	enum mvebu_pwm_ctrl	 ctrl;
+	struct gpio_desc	*gpiod;
+	bool			 master;
+};
+
+struct mvebu_pwm {
+	struct pwm_chip		 chip;
+	struct mvebu_gpio_chip	*mvchip;
+	struct mvebu_pwmchip	 controller;
+	enum mvebu_pwm_ctrl	 default_controller;
+
+	/* Used to preserve GPIO/PWM registers across suspend/resume */
+	u32				 blink_select;
+	struct mvebu_pwm_chip_drv	 drv[];
+};
+
+static struct mvebu_pwmchip  *mvebu_pwm_list[MVEBU_PWM_CTRL_MAX];
+
 struct mvebu_gpio_chip {
 	struct gpio_chip   chip;
 	struct regmap     *regs;
@@ -285,12 +307,12 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip *mvchip, u32 val)
  * Functions returning offsets of individual registers for a given
  * PWM controller.
  */
-static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
+static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwmchip *mvpwm)
 {
 	return mvpwm->offset + PWM_BLINK_ON_DURATION_OFF;
 }
 
-static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
+static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwmchip *mvpwm)
 {
 	return mvpwm->offset + PWM_BLINK_OFF_DURATION_OFF;
 }
@@ -623,39 +645,71 @@ static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
 	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
 	struct gpio_desc *desc;
+	enum mvebu_pwm_ctrl id;
 	unsigned long flags;
 	int ret = 0;
+	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
 
-	spin_lock_irqsave(&mvpwm->lock, flags);
+	spin_lock_irqsave(&mvpwm->controller.lock, flags);
 
-	if (mvpwm->gpiod) {
+	if (drv->gpiod || (mvchip->blink_en_reg & BIT(pwm->hwpwm))) {
 		ret = -EBUSY;
-	} else {
-		desc = gpiochip_request_own_desc(&mvchip->chip,
-						 pwm->hwpwm, "mvebu-pwm",
-						 GPIO_ACTIVE_HIGH,
-						 GPIOD_OUT_LOW);
-		if (IS_ERR(desc)) {
-			ret = PTR_ERR(desc);
-			goto out;
-		}
+		goto out;
+	}
+
+	desc = gpiochip_request_own_desc(&mvchip->chip,
+					 pwm->hwpwm, "mvebu-pwm",
+					 GPIO_ACTIVE_HIGH,
+					 GPIOD_OUT_LOW);
+	if (IS_ERR(desc)) {
+		ret = PTR_ERR(desc);
+		goto out;
+	}
 
-		mvpwm->gpiod = desc;
+	ret = gpiod_direction_output(desc, 0);
+	if (ret) {
+		gpiochip_free_own_desc(desc);
+		goto out;
 	}
+
+	for (id = MVEBU_PWM_CTRL_SET_A; id < MVEBU_PWM_CTRL_MAX; id++) {
+		if (!mvebu_pwm_list[id]->in_use) {
+			drv->ctrl = id;
+			drv->master = true;
+			mvebu_pwm_list[id]->in_use = true;
+			break;
+		}
+	}
+
+	if (!drv->master)
+		drv->ctrl = mvpwm->default_controller;
+
+	regmap_update_bits(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
+			   BIT(pwm->hwpwm), drv->ctrl ? BIT(pwm->hwpwm) : 0);
+
+	drv->gpiod = desc;
+
+	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
+		    &mvpwm->blink_select);
 out:
-	spin_unlock_irqrestore(&mvpwm->lock, flags);
+	spin_unlock_irqrestore(&mvpwm->controller.lock, flags);
 	return ret;
 }
 
 static void mvebu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
 	unsigned long flags;
 
-	spin_lock_irqsave(&mvpwm->lock, flags);
-	gpiochip_free_own_desc(mvpwm->gpiod);
-	mvpwm->gpiod = NULL;
-	spin_unlock_irqrestore(&mvpwm->lock, flags);
+	spin_lock_irqsave(&mvpwm->controller.lock, flags);
+	if (drv->master)
+		mvebu_pwm_list[drv->ctrl]->in_use = false;
+
+	gpiochip_free_own_desc(drv->gpiod);
+	memset(drv, 0, sizeof(struct mvebu_pwm_chip_drv));
+
+	spin_unlock_irqrestore(&mvpwm->controller.lock, flags);
 }
 
 static int mvebu_pwm_get_state(struct pwm_chip *chip,
@@ -665,28 +719,35 @@ static int mvebu_pwm_get_state(struct pwm_chip *chip,
 
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
 	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
+	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
+	struct mvebu_pwmchip *controller;
 	unsigned long long val;
 	unsigned long flags;
 	u32 u;
 
-	spin_lock_irqsave(&mvpwm->lock, flags);
+	if (drv->gpiod)
+		controller = mvebu_pwm_list[drv->ctrl];
+	else
+		controller = &mvpwm->controller;
+
+	spin_lock_irqsave(&controller->lock, flags);
 
-	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
+	regmap_read(controller->regs, mvebu_pwmreg_blink_on_duration(controller), &u);
 	/* Hardware treats zero as 2^32. See mvebu_pwm_apply(). */
 	if (u > 0)
 		val = u;
 	else
 		val = UINT_MAX + 1ULL;
 	state->duty_cycle = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC,
-			mvpwm->clk_rate);
+			controller->clk_rate);
 
-	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
+	regmap_read(controller->regs, mvebu_pwmreg_blink_off_duration(controller), &u);
 	/* period = on + off duration */
 	if (u > 0)
 		val += u;
 	else
 		val += UINT_MAX + 1ULL;
-	state->period = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC, mvpwm->clk_rate);
+	state->period = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC, controller->clk_rate);
 
 	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
 	if (u)
@@ -694,7 +755,7 @@ static int mvebu_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->enabled = false;
 
-	spin_unlock_irqrestore(&mvpwm->lock, flags);
+	spin_unlock_irqrestore(&controller->lock, flags);
 
 	return 0;
 }
@@ -703,6 +764,8 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
 	struct mvebu_pwm *mvpwm = to_mvebu_pwm(chip);
+	struct mvebu_pwm_chip_drv *drv = &mvpwm->drv[pwm->hwpwm];
+	struct mvebu_pwmchip *controller;
 	struct mvebu_gpio_chip *mvchip = mvpwm->mvchip;
 	unsigned long long val;
 	unsigned long flags;
@@ -711,7 +774,11 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
+	if (drv->gpiod)
+		controller = mvebu_pwm_list[drv->ctrl];
+	else
+		controller = &mvpwm->controller;
+	val = (unsigned long long) controller->clk_rate * state->duty_cycle;
 	do_div(val, NSEC_PER_SEC);
 	if (val > UINT_MAX + 1ULL)
 		return -EINVAL;
@@ -726,7 +793,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		on = 1;
 
-	val = (unsigned long long) mvpwm->clk_rate * state->period;
+	val = (unsigned long long) controller->clk_rate * state->period;
 	do_div(val, NSEC_PER_SEC);
 	val -= on;
 	if (val > UINT_MAX + 1ULL)
@@ -738,16 +805,16 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		off = 1;
 
-	spin_lock_irqsave(&mvpwm->lock, flags);
+	spin_lock_irqsave(&controller->lock, flags);
 
-	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), on);
-	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), off);
+	regmap_write(controller->regs, mvebu_pwmreg_blink_on_duration(controller), on);
+	regmap_write(controller->regs, mvebu_pwmreg_blink_off_duration(controller), off);
 	if (state->enabled)
 		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 1);
 	else
 		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 0);
 
-	spin_unlock_irqrestore(&mvpwm->lock, flags);
+	spin_unlock_irqrestore(&controller->lock, flags);
 
 	return 0;
 }
@@ -762,25 +829,27 @@ static const struct pwm_ops mvebu_pwm_ops = {
 static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
 {
 	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
+	struct mvebu_pwmchip *controller = &mvpwm->controller;
 
 	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		    &mvpwm->blink_select);
-	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
-		    &mvpwm->blink_on_duration);
-	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
-		    &mvpwm->blink_off_duration);
+	regmap_read(controller->regs, mvebu_pwmreg_blink_on_duration(controller),
+		    &controller->blink_on_duration);
+	regmap_read(controller->regs, mvebu_pwmreg_blink_off_duration(controller),
+		    &controller->blink_off_duration);
 }
 
 static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
 {
 	struct mvebu_pwm *mvpwm = mvchip->mvpwm;
+	struct mvebu_pwmchip *controller = &mvpwm->controller;
 
 	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		     mvpwm->blink_select);
-	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
-		     mvpwm->blink_on_duration);
-	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
-		     mvpwm->blink_off_duration);
+	regmap_write(controller->regs, mvebu_pwmreg_blink_on_duration(controller),
+		     controller->blink_on_duration);
+	regmap_write(controller->regs, mvebu_pwmreg_blink_off_duration(controller),
+		     controller->blink_off_duration);
 }
 
 static int mvebu_pwm_probe(struct platform_device *pdev,
@@ -792,6 +861,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	void __iomem *base;
 	u32 offset;
 	u32 set;
+	enum mvebu_pwm_ctrl ctrl_set;
 
 	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
 		int ret = of_property_read_u32(dev->of_node,
@@ -813,57 +883,39 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
-	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
+	mvpwm = devm_kzalloc(dev, struct_size(mvpwm, drv, mvchip->chip.ngpio), GFP_KERNEL);
 	if (!mvpwm)
 		return -ENOMEM;
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
-	mvpwm->offset = offset;
 
-	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
-		mvpwm->regs = mvchip->regs;
+	base = devm_platform_ioremap_resource_byname(pdev, "pwm");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+	mvpwm->controller.regs = devm_regmap_init_mmio(&pdev->dev, base,
+						       &mvebu_gpio_regmap_config);
+	if (IS_ERR(mvpwm->controller.regs))
+		return PTR_ERR(mvpwm->controller.regs);
 
-		switch (mvchip->offset) {
-		case AP80X_GPIO0_OFF_A8K:
-		case CP11X_GPIO0_OFF_A8K:
-			/* Blink counter A */
-			set = 0;
-			break;
-		case CP11X_GPIO1_OFF_A8K:
-			/* Blink counter B */
-			set = U32_MAX;
-			mvpwm->offset += PWM_BLINK_COUNTER_B_OFF;
-			break;
-		default:
-			return -EINVAL;
-		}
+	/*
+	 * User set A for lines of GPIO chip with id 0, B for GPIO chip
+	 * with id 1. Don't allow further GPIO chips to be used for PWM.
+	 */
+	if (id == 0) {
+		set = 0;
+		ctrl_set = MVEBU_PWM_CTRL_SET_A;
+	} else if (id == 1) {
+		set = U32_MAX;
+		ctrl_set = MVEBU_PWM_CTRL_SET_B;
 	} else {
-		base = devm_platform_ioremap_resource_byname(pdev, "pwm");
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-
-		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
-						    &mvebu_gpio_regmap_config);
-		if (IS_ERR(mvpwm->regs))
-			return PTR_ERR(mvpwm->regs);
-
-		/*
-		 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
-		 * with id 1. Don't allow further GPIO chips to be used for PWM.
-		 */
-		if (id == 0)
-			set = 0;
-		else if (id == 1)
-			set = U32_MAX;
-		else
-			return -EINVAL;
+		return -EINVAL;
 	}
 
 	regmap_write(mvchip->regs,
 		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
 
-	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
-	if (!mvpwm->clk_rate) {
+	mvpwm->controller.clk_rate = clk_get_rate(mvchip->clk);
+	if (!mvpwm->controller.clk_rate) {
 		dev_err(dev, "failed to get clock rate\n");
 		return -EINVAL;
 	}
@@ -872,7 +924,10 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	mvpwm->chip.ops = &mvebu_pwm_ops;
 	mvpwm->chip.npwm = mvchip->chip.ngpio;
 
-	spin_lock_init(&mvpwm->lock);
+	spin_lock_init(&mvpwm->controller.lock);
+
+	mvpwm->default_controller = ctrl_set;
+	mvebu_pwm_list[ctrl_set] = &mvpwm->controller;
 
 	return devm_pwmchip_add(dev, &mvpwm->chip);
 }
-- 
2.43.0


