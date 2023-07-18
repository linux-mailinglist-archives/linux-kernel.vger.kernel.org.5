Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B21757F74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjGRO32 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 10:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjGRO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:29:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7410199
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:29:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhV-0006tl-VW; Tue, 18 Jul 2023 16:29:18 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhV-000OT8-9t; Tue, 18 Jul 2023 16:29:17 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhV-000ErN-07;
        Tue, 18 Jul 2023 16:29:17 +0200
Message-ID: <7c0a264a9a70fbb49e8024acdbc3aaa56f76441a.camel@pengutronix.de>
Subject: Re: [PATCH] pwm: stm32: Implement .get_state()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:29:16 +0200
In-Reply-To: <20230614073345.5ejzkbcdiel5v7zg@pengutronix.de>
References: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
         <20230614073345.5ejzkbcdiel5v7zg@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Mi, 2023-06-14 at 09:33 +0200, Uwe Kleine-König wrote:
> On Thu, Jun 08, 2023 at 04:06:02PM +0200, Philipp Zabel wrote:
> > Stop stm32_pwm_detect_channels() from disabling all channels and count
> > the number of enabled PWMs to keep the clock running. Implement the
> > &pwm_ops->get_state callback so drivers can inherit PWM state set by
> > the bootloader.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > Make the necessary changes to allow inheriting PWM state set by the
> > bootloader, for example to avoid flickering with a pre-enabled PWM
> > backlight.
> > ---
> >  drivers/pwm/pwm-stm32.c | 75 ++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 59 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> > index 62e397aeb9aa..e0677c954bdf 100644
> > --- a/drivers/pwm/pwm-stm32.c
> > +++ b/drivers/pwm/pwm-stm32.c
> > @@ -52,6 +52,21 @@ static u32 active_channels(struct stm32_pwm *dev)
> >  	return ccer & TIM_CCER_CCXE;
> >  }
> >  
> > +static int read_ccrx(struct stm32_pwm *dev, int ch, u32 *value)
> > +{
> > +	switch (ch) {
> > +	case 0:
> > +		return regmap_read(dev->regmap, TIM_CCR1, value);
> > +	case 1:
> > +		return regmap_read(dev->regmap, TIM_CCR2, value);
> > +	case 2:
> > +		return regmap_read(dev->regmap, TIM_CCR3, value);
> > +	case 3:
> > +		return regmap_read(dev->regmap, TIM_CCR4, value);
> > +	}
> > +	return -EINVAL;
> > +}
> 
> I'd prefer having something like:
> 
> 	#define TIM_CCR(i)	(0x30 + 4 * (i))	/* Capt/Comp Register i, for i in 1 .. 4 */
> 	#define TIM_CCR1	TIM_CCR(1)
> 	#define TIM_CCR2	TIM_CCR(2)
> 	#define TIM_CCR3	TIM_CCR(3)
> 	#define TIM_CCR4	TIM_CCR(4)

I find this a bit confusing due to the 1-based register numbering. For
example, 0x30 is not one of the CCR registers at all.
When TIM_CCR(i) is used in the code, it's not evident that the valid
range is 1...4.

I'd prefer to leave this as is ...

> and then read_ccrx could be simplified to:
> 
> 	return regmap_read(dev->regmap, TIM_CCR(i + 1), value);

... and just turn this into

	regmap_read(regmap, TIM_CCR1 + 4 * ch, value);

> . (Not sure if passing an invalid channel really needs handling.)

I think it is not necessary.

ch is set to pwm->hwpwm, which is < pwm->npwm, which is <= 4.

> But given that write_ccrx looks the same, I'm ok with that.

I'd like to drop read/write_ccrx altogether and replace them with a
single regmap_read/write.

> > +
> >  static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
> >  {
> >  	switch (ch) {
> > @@ -486,9 +501,40 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	return ret;
> >  }
> >  
> > +static int stm32_pwm_get_state(struct pwm_chip *chip,
> > +			       struct pwm_device *pwm, struct pwm_state *state)
> > +{
> > +	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
> > +	int ch = pwm->hwpwm;
> > +	unsigned long rate;
> > +	u32 ccer, psc, arr, ccr;
> > +	u64 dty, prd;
> > +	int ret;
> > +
> > +	ret = regmap_read(priv->regmap, TIM_CCER, &ccer);
> > +	if (ret)
> > +		return ret;
> > +
> > +	state->enabled = ccer & (TIM_CCER_CC1E << (ch * 4));
> 
> Other parts of the driver use the macros from <linux/bitfield.h>. With a
> similar approach as suggested for TIM_CCR above, this could be made to
> read as:
> 
> 	state->enabled = FIELD_GET(TIM_CCER_CCxE(ch + 1), ccer);

Again this feels like an unnecessary indirection to me. I think it
doesn't work like this either, the mask has to be a compile time
constant.

There's already a few examples of the (TIM_CCER_CC1E << (ch * 4))
pattern in the driver. If they must be converted to something else, I'd
prefer this to be done separately, for all of them.

> > +	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	regmap_read(priv->regmap, TIM_PSC, &psc);
> > +	regmap_read(priv->regmap, TIM_ARR, &arr);
> > +	read_ccrx(priv, ch, &ccr);
> 
> You don't use the return value of read_ccrx(), so make it void (or check
> it)? If you check it, also do it for regmap_read().

Yes, thanks.

> > +	rate = clk_get_rate(priv->clk);
> > +
> > +	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
> 
> This might overflow?!

In practice this can't happen because PSC, ARR, and CCRx fields are
only 16-bit.
Although I'm not sure whether this will be true for future designs.

> > +	state->period = DIV_ROUND_UP_ULL(prd, rate);
> > +	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
> > +	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
> > +
> > +	return ret;
> > +}
> 
> While looking at stm32_pwm_config() to check if it matches your
> stm32_pwm_get_state() implementation, I noticed that for small values of
> period_ns, prd might become 0 which than yields surprising effects in
> combination with
> 
> 	regmap_write(priv->regmap, TIM_ARR, prd - 1);

What to do about this, "prd = max(1, div);"?
This should probably be fixed separately.

> Also the driver needs locking because of the PSC and ARR registers are
> shared for all channels

I'll lock priv->lock in get_state.

> and there are rounding issues (prd is used for
> the calculation of dty).

This should be fixed separately as well.

> > +
> >  static const struct pwm_ops stm32pwm_ops = {
> >  	.owner = THIS_MODULE,
> >  	.apply = stm32_pwm_apply_locked,
> > +	.get_state = stm32_pwm_get_state,
> >  	.capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
> >  };
> >  
> > @@ -579,30 +625,22 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
> >  	priv->have_complementary_output = (ccer != 0);
> >  }
> >  
> > -static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
> > +static int stm32_pwm_detect_channels(struct stm32_pwm *priv, int *n_enabled)
> >  {
> > -	u32 ccer;
> > -	int npwm = 0;
> > +	u32 ccer, ccer_backup;
> > +	int npwm;
> >  
> >  	/*
> >  	 * If channels enable bits don't exist writing 1 will have no
> >  	 * effect so we can detect and count them.
> >  	 */
> > +	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
> >  	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
> >  	regmap_read(priv->regmap, TIM_CCER, &ccer);
> > -	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
> > +	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
> >  
> > -	if (ccer & TIM_CCER_CC1E)
> > -		npwm++;
> > -
> > -	if (ccer & TIM_CCER_CC2E)
> > -		npwm++;
> > -
> > -	if (ccer & TIM_CCER_CC3E)
> > -		npwm++;
> > -
> > -	if (ccer & TIM_CCER_CC4E)
> > -		npwm++;
> > +	npwm = hweight32(ccer & TIM_CCER_CCXE);
> > +	*n_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
> 
> hweight32 returns an unsigned int. While there is probably no problem
> with values that don't fit, using unsigned for *n_enabled (and also
> npwm) looks better IMHO. Maybe split making npwm unsigned and using
> hweight32 to assign it to a separate preparing patch?

Yes, I'll do that.

> The inconsistency
> between "npwm" (without underscore) and "n_enabled" (with underscore)
> strikes me a bit. given that struct pwm_chip has "npwm", too, maybe drop
> the _ from "n_enabled"?

I can't properly read "nenabled", I'll turn it into "num_enabled"
(there's precedence with "priv->num_breakinputs") and drop "npwm"
altogether, as the value can be returned directly.

> 
regards
Philipp
