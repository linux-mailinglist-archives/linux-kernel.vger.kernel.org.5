Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6C67BA5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbjJEQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjJEQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80302AFB9;
        Thu,  5 Oct 2023 07:18:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E33CC43395;
        Thu,  5 Oct 2023 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515539;
        bh=+5giS8dCDEB9SSIrIST7R8CXKZKXlmVab1T0e3RZ980=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZq+rtBHFgu7hUs9WU6oYZctlBrd8N8B6gpDD6vXr/eRZuuDq5yhSI/zvykHn5bDG
         FxdBPitqVLrJMSY2mQ5UEB8SQR+q42ZA328/UwbpxuQg8xFE4s8cHoyPLZyCFlaJm2
         T8oZPiVBbWLi7I528nPlTqYqOiYM4XSlFSJe6B5tMJpFlK9QpdxD+TldHQwf7bibC2
         sU0eKnKWL9hjEdZ4CKwA+7bpCQwxA/GxAj6ro2nfoSowaAJb9MLyufNioMejjt0SV6
         GvMsnjHqOYXyPXDbzQ4TO6ni2SPaiSB2w3FFb523TufPFH1DyA58ff5TAH+ONFDlVh
         j/hSOIbqc4dUg==
Date:   Thu, 5 Oct 2023 22:06:50 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/2] pwm: add T-HEAD PWM driver
Message-ID: <ZR7C+hrisF0lsAg1@xhacker>
References: <20231004092731.1362-1-jszhang@kernel.org>
 <20231004092731.1362-3-jszhang@kernel.org>
 <20231004140130.ljsfpn4axmsmszwm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004140130.ljsfpn4axmsmszwm@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 04:01:30PM +0200, Uwe Kleine-König wrote:
> On Wed, Oct 04, 2023 at 05:27:31PM +0800, Jisheng Zhang wrote:
> > T-HEAD SoCs such as the TH1520 contain a PWM controller used
> > to control the LCD backlight, fan and so on. Add driver for it.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---

...

Hi Uwe,

Thanks a lot for your review and nice suggestions. v3 has been sent out.
And I want to add more comments to your questions here.

> > +
> > +static int thead_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct thead_pwm_chip *priv = thead_pwm_from_chip(chip);
> > +	u64 period_cycle, duty_cycle, rate;
> > +	u32 val;
> > +
> > +	/* if ever started, can't change the polarity */
> > +	if (priv->ever_started && state->polarity != pwm->state.polarity)
> > +		return -EINVAL;

This is the polority check[1] for ever started channel.

> > +
> > +	if (!state->enabled) {
> > +		if (pwm->state.enabled) {
> > +			val = readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +			val &= ~THEAD_PWM_CFG_UPDATE;
> > +			writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +
> > +			writel(0, priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
> > +
> > +			val |= THEAD_PWM_CFG_UPDATE;
> > +			writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +		}
> > +		return 0;
> > +	}
> > +
> > +	if (!pwm->state.enabled)
> > +		pm_runtime_get_sync(chip->dev);

> 
> pm_runtime_get_sync() returns an int that you shouldn't ignore.

In v3 I switch to pm_runtime_resume_and_get() because it can simplify
the error handling code.

> 
> > +	val = readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +	val &= ~THEAD_PWM_CFG_UPDATE;
> > +
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		val &= ~THEAD_PWM_FPOUT;
> > +	else
> > +		val |= THEAD_PWM_FPOUT;
> 
> What happens here if the bootloader already touched that flag? Or the
> driver is reloaded/rebound?

Only polarity can't be changed once started, so if bootloader already
configured polarity and started the pwm channel, and we want to change
to a different polarity, the check[1] in the beginning of this function
will fail so return -EINVAL.

> 
> > +	writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +
> > +	rate = clk_get_rate(priv->clk);
> > +	/*
> > +	 * The following calculations might overflow if clk is bigger
> > +	 * than 1 GHz. In practise it's 24MHz, so this limitation
> > +	 * is only theoretic.
> > +	 */
> > +	if (rate > (u64)NSEC_PER_SEC)
> 
> this cast isn't needed.
> 
> > +		return -EINVAL;
> > +
> > +	period_cycle = mul_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC);
> > +	if (period_cycle > THEAD_PWM_MAX_PERIOD)
> > +		period_cycle = THEAD_PWM_MAX_PERIOD;
> > +	/*
> > +	 * With limitation above we have period_cycle <= THEAD_PWM_MAX_PERIOD,
> > +	 * so this cannot overflow.
> > +	 */
> > +	writel((u32)period_cycle, priv->mmio_base + THEAD_PWM_PER(pwm->hwpwm));
> 
> This cast can also be dropped.
> 
> > +
> > +	duty_cycle = mul_u64_u64_div_u64(rate, state->duty_cycle, NSEC_PER_SEC);
> > +	if (duty_cycle > THEAD_PWM_MAX_DUTY)
> > +		duty_cycle = THEAD_PWM_MAX_DUTY;
> > +	/*
> > +	 * With limitation above we have duty_cycle <= THEAD_PWM_MAX_PERIOD,
> > +	 * so this cannot overflow.
> > +	 */
> > +	writel((u32)duty_cycle, priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
> 
> ...
> 
> > +
> > +	val |= THEAD_PWM_CFG_UPDATE;
> > +	writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +
> > +	if (!pwm->state.enabled) {
> > +		val |= THEAD_PWM_START;
> > +		writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
> > +		priv->ever_started = true;
> > +	}
> 
> Further above you conditionally call pm_runtime_get_sync(), there should
> be a matching pm_runtime_put().

In v3, I call pm_runtime_put_sync() when pwm channel is disabled.


Thanks
