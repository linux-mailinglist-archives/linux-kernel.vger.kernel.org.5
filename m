Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FA757F76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjGRO3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjGRO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:29:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB380171A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:29:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhd-0006wE-C5; Tue, 18 Jul 2023 16:29:25 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhc-000OTD-NP; Tue, 18 Jul 2023 16:29:24 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhc-000Ero-17;
        Tue, 18 Jul 2023 16:29:24 +0200
Message-ID: <d3df6f565421576bbf06140942593cd4d0af712e.camel@pengutronix.de>
Subject: Re: [PATCH] pwm: stm32: Implement .get_state()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:29:24 +0200
In-Reply-To: <ZLY_gER7FeEB07cw@orome>
References: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
         <ZLY_gER7FeEB07cw@orome>
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

Hi Thierry,

On Di, 2023-07-18 at 09:30 +0200, Thierry Reding wrote:
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
> Looking at the register definitions we should be able to replace this
> with a single line and parameterize based on channel.
> 
> I realize you probably just copied from write_ccrx(), but might as well
> improve this while at it. Could be a separate patch, though.
> 
> Also, ch should be unsigned int since it comes from pwm->hwpwm.

Thank you, I'll make both changes separately.

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
> 
> This should reflect the type of pwm->hwpwm.

Ok.

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
> > +	state->polarity = (ccer & (TIM_CCER_CC1P << (ch * 4))) ?
> > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > +	regmap_read(priv->regmap, TIM_PSC, &psc);
> > +	regmap_read(priv->regmap, TIM_ARR, &arr);
> 
> We should probably check regmap_read() consistently here.

Will do.

I'll also add locking so we can't PSC/ARR/CCRx in an in-between state.

> > +	read_ccrx(priv, ch, &ccr);
> > +	rate = clk_get_rate(priv->clk);
> > +
> > +	prd = (u64)NSEC_PER_SEC * (psc + 1) * (arr + 1);
> > +	state->period = DIV_ROUND_UP_ULL(prd, rate);
> > +	dty = (u64)NSEC_PER_SEC * (psc + 1) * ccr;
> > +	state->duty_cycle = DIV_ROUND_UP_ULL(dty, rate);
> > +
> > +	return ret;
> > +}
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
> 
> unsigned int * for n_enabled.

Ok.

> >  {
> > -	u32 ccer;
> > -	int npwm = 0;
> > +	u32 ccer, ccer_backup;
> > +	int npwm;
> 
> Also make this and the return value unsigned int while at it. These can
> never be negative.

Thanks, I'll split this out into a separate patch.

regards
Philipp
