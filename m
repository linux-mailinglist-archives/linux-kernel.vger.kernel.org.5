Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530397B9EA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjJEOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjJEOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:24 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCF08A71;
        Thu,  5 Oct 2023 01:30:38 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id EFC201007F6; Thu,  5 Oct 2023 09:30:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696494632; bh=yTqM0lOviMpVtY3gEC2fnjg+lpnZmaa/xqOOO1oFjzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hM4/6PU/BVCUmsjcFfLAZHOdsLJZBPi+IERfvAziz3nfnEK4C7KS4IvaOhQF74oUa
         pm/jySTmFQfMxdTKCSDifYiz+6AUgqHrAipeZA/gPtdfM+zALHVTx2Zc3etj0F8Uvj
         Z+6+P3UfUXB4S+dg6826xd+d4QJrSOPKQf4pOCA+1cpbIPfgjobt3K8v8W29gu2XFf
         EozsFhCZzdMkmYxxlZzWuHs3+awRG8hRctGYRXzu5lggSBZ9V8y5NfKjZIp5utFREo
         m8TSihVOCaoYFaigu8xqW/v53d8h8T2slqaY2mkHTgDaQkYnFk+bb6M8VNQI8mAzW8
         t0IV4IH911NYA==
Date:   Thu, 5 Oct 2023 09:30:32 +0100
From:   Sean Young <sean@mess.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic
 context
Message-ID: <ZR50KCVNzhlLooLW@gofer.mess.org>
References: <cover.1696156485.git.sean@mess.org>
 <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
 <20231004095920.ne7yrrthow6tnuvg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004095920.ne7yrrthow6tnuvg@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On Wed, Oct 04, 2023 at 11:59:20AM +0200, Uwe Kleine-König wrote:
> On Sun, Oct 01, 2023 at 11:40:29AM +0100, Sean Young wrote:
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index dc66e3405bf5..d9679ae5b2be 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -505,7 +505,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
> >  	 * is a bad idea. So make it explicit that calling this function might
> >  	 * sleep.
> >  	 */
> > -	might_sleep();
> > +	might_sleep_if(pwm_can_sleep(pwm));
> >  
> >  	if (!pwm || !state || !state->period ||
> >  	    state->duty_cycle > state->period)
> 
> I'd like to have a mechanism to catch drivers that missed to set
> .can_sleep. The best idea I currently have for that is to disable
> preemption if IS_ENABLED(CONFIG_PWM_DEBUG) && !pwm_can_sleep(pwm) while
> .apply() is running.

If we have pwm_apply_state_atomic(), then CONFIG_DEBUG_ATOMIC_SLEEP will
catch them, but only in that code path of course.

How about using non_block_start() and non_block_end() if can_sleep is
not set?

> > diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> > index b7c6045c5d08..b8b9392844e9 100644
> > --- a/drivers/pwm/pwm-fsl-ftm.c
> > +++ b/drivers/pwm/pwm-fsl-ftm.c
> > @@ -405,6 +405,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
> >  
> >  	fpc->soc = of_device_get_match_data(&pdev->dev);
> >  	fpc->chip.dev = &pdev->dev;
> > +	fpc->chip.can_sleep = true;
> 
> As .apply() being callable in non-sleepable context only depends on
> .apply() I think a better place for this property is in struct pwm_ops.

That makes sense.

> Also I wonder if the distinction between atomic and sleeping
> pwm_state_apply() should be more explicit. For GPIOs you have a sleeping
> variant gpiod_set_value_cansleep() that allows to immediately determine
> the intended context in the caller. This would allow that programming
> a PWM stays a preemption point (if possible/desired) even if the
> underlying hardware/driver is atomic. To not have to touch all consumer
> drivers, maybe the pair for pwm should better be
> 
> 	pwm_apply_state()
> 	pwm_apply_state_atomic()

Do we need pwm_config_atomic(), pwm_enable_atomic(), and pwm_disable_atomic()
too? These are just convenience functions, so we can probably do without them.

> instead of a "cansleep" suffix for the sleeping variant? Or maybe it's
> better to accept touching all consumer drivers to get semantics similar
> to gpio? I couldn't decide quickly what I really like better here, so
> that's your chance to comment and influence the outcome :-)

If you expect to have more parameters for pwm_apply_state() then a flags
argument makes sense.

TBH I like the pwm_apply_state_atomic() option.


Sean
