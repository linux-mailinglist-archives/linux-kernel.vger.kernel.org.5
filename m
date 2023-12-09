Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4867D80B389
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjLIJwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIJwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:52:04 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED210C7;
        Sat,  9 Dec 2023 01:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702115529; bh=ylrgEA3zbjC4BUaTh9xcfvwH7XspfsRlgzCDfDuD0Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ji0yme4wBw9VwSR0+h+ffZxLjj3LK6jkp4/rm+0K39pVYaYYMpMVcTYEj74xUfhfg
         ET9cjglES2OqhiijJjav7UxIQvVLUFAYSvNRXwK+oxqfh8xTNxqNszVxqYs9tWJ6AJ
         pnK7Jnyia/WJOrRq179PhiZ6zLIh/dPzuwTKA2qrujCbiYlx7Kx4EcTTVDtrUkN9rl
         uh91y3c48meztAKYlLdvsL5pThDPl/uZMyVM1iecO4721Uy97/oGFqybVA9mTcmB4+
         u8k9qDhW7glRaPj2SeLJHvxWVSB/KOTVWM8vte2/PRAUFMAh+1/GuHoMMoEJtq6mL8
         F0ogWKqRYA0OQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 4D4D1100091; Sat,  9 Dec 2023 09:52:09 +0000 (GMT)
Date:   Sat, 9 Dec 2023 09:52:09 +0000
From:   Sean Young <sean@mess.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZXQ4yYx8QKu6wWwY@gofer.mess.org>
References: <cover.1701248996.git.sean@mess.org>
 <88fdb3a200989458c6f95c26fa9bb84c1e864798.1701248996.git.sean@mess.org>
 <ZXNEg3ax4MChSJ5A@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXNEg3ax4MChSJ5A@orome.fritz.box>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 05:29:55PM +0100, Thierry Reding wrote:
> On Wed, Nov 29, 2023 at 09:13:37AM +0000, Sean Young wrote:
> > This makes the generated IR much more precise. Before this change, the
> > driver is unreliable and many users opted to use gpio-ir-tx instead.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 76 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> > index cf51e2760975..8575c4596d7b 100644
> > --- a/drivers/media/rc/pwm-ir-tx.c
> > +++ b/drivers/media/rc/pwm-ir-tx.c
> > @@ -10,6 +10,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/completion.h>
> >  #include <media/rc-core.h>
> >  
> >  #define DRIVER_NAME	"pwm-ir-tx"
> > @@ -17,8 +19,14 @@
> >  
> >  struct pwm_ir {
> >  	struct pwm_device *pwm;
> > -	unsigned int carrier;
> > -	unsigned int duty_cycle;
> > +	struct hrtimer timer;
> > +	struct completion tx_done;
> > +	struct pwm_state *state;
> > +	u32 carrier;
> > +	u32 duty_cycle;
> > +	uint *txbuf;
> 
> Maybe mark this as const to signal that it's not going to get modified?

Ah nice, I usually forget const. 

> > +	uint txbuf_len;
> > +	uint txbuf_index;
> 
> uint is rather rare. Or so I thought. There seem to be quite a few
> occurrences throughout the kernel. I'd still prefer unsigned int over
> this abbreviated form, but ultimately up to you and Mauro to decide.

Yes, unsigned int is used a lot more. Changed.

> >  static int pwm_ir_probe(struct platform_device *pdev)
> >  {
> >  	struct pwm_ir *pwm_ir;
> > @@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pdev)
> >  	if (!rcdev)
> >  		return -ENOMEM;
> >  
> > +	if (pwm_is_atomic(pwm_ir->pwm)) {
> > +		init_completion(&pwm_ir->tx_done);
> > +		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +		pwm_ir->timer.function = pwm_ir_timer;
> > +		rcdev->tx_ir = pwm_ir_tx_atomic;
> > +	} else {
> > +		dev_info(&pdev->dev, "tx will not be accurate as pwm device does not support atomic mode");
> 
> s/tx/TX and s/pwm/PWM/? Also, I'm a bit unhappy about "atomic mode" here
> because the term is overloaded in PWM. If you call pwm_appy_*() then by
> definition it's going to be "atomic" in the "atomic state" sense. So
> maybe switch to something like:
> 
> 	"TX will not be accurate as PWM device might sleep"
> 
> ?

Very nice, changed.

Thanks
Sean
