Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30737B4D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbjJBIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:20:26 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6934BAC;
        Mon,  2 Oct 2023 01:20:22 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 86568100092; Mon,  2 Oct 2023 09:20:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696234820; bh=OlA0pl5VSa+hyOkc5IXR0SOcbRUBvOFJJLhphqTBLzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QGsTgdOmxf3yPTzRlHQFBU434qP/FCRqb0w2FsIEhT1hn935KhEokeVckqf3xD+zM
         B/ZmU/a5xZd+GXvzwMn4TLkFC2t3Nz0+0Dh9zTE7sI6hY+DLWpeyAXGAsOWPaB+gWA
         xrCY/jughT/INCYfCGREExLRZ1ipwv9cGz0XxnwdpgvAifyE3yRoqAC+Hr56/tbAce
         oo4G801RbuLl9bRLW57PwzwfukO7fV9Pg9vWKfb0f/JxlmHDke5v+Q4G/Pju/1auJP
         PjRh5GupJf6Fh8xVLhEWUgnUFQOpaULb60j1A5n45jAjItIYhromOw/b7rhhpeGqIu
         Y31yw9y4FsAmw==
Date:   Mon, 2 Oct 2023 09:20:20 +0100
From:   Sean Young <sean@mess.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZRp9RE2jOZdL0+1/@gofer.mess.org>
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
 <5982681d-4fb5-0271-fdc5-712d6c8512e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5982681d-4fb5-0271-fdc5-712d6c8512e3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 02, 2023 at 08:49:47AM +0300, Ivaylo Dimitrov wrote:
> On 1.10.23 г. 13:40 ч., Sean Young wrote:
> > The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> > from delays as this is done in process context. Make this work in atomic
> > context.
> > 
> > This makes the driver much more precise.
> > 
> > Signed-off-by: Sean Young <sean@mess.org>
> > Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > ---
> >   drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++--------
> >   1 file changed, 63 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> > index c5f37c03af9c..557725a07a67 100644
> > --- a/drivers/media/rc/pwm-ir-tx.c
> > +++ b/drivers/media/rc/pwm-ir-tx.c
> > @@ -10,6 +10,8 @@
> >   #include <linux/slab.h>
> >   #include <linux/of.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/completion.h>
> >   #include <media/rc-core.h>
> >   #define DRIVER_NAME	"pwm-ir-tx"
> > @@ -17,8 +19,13 @@
> >   struct pwm_ir {
> >   	struct pwm_device *pwm;
> > -	unsigned int carrier;
> > -	unsigned int duty_cycle;
> > +	struct hrtimer timer;
> > +	struct completion completion;
> > +	uint carrier;
> > +	uint duty_cycle;
> > +	uint *txbuf;
> > +	uint txbuf_len;
> > +	uint txbuf_index;
> >   };
> >   static const struct of_device_id pwm_ir_of_match[] = {
> > @@ -55,33 +62,65 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
> >   	struct pwm_ir *pwm_ir = dev->priv;
> >   	struct pwm_device *pwm = pwm_ir->pwm;
> >   	struct pwm_state state;
> > -	int i;
> > -	ktime_t edge;
> > -	long delta;
> > +
> > +	reinit_completion(&pwm_ir->completion);
> 
> You should not need that.

It does not work without it - the process doing the 2nd tx hangs indefinitely.

> >   	pwm_init_state(pwm, &state);
> >   	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
> >   	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> > +	state.enabled = false;
> > -	edge = ktime_get();
> > +	pwm_ir->txbuf = txbuf;
> > +	pwm_ir->txbuf_len = count;
> > +	pwm_ir->txbuf_index = 0;
> > -	for (i = 0; i < count; i++) {
> > -		state.enabled = !(i % 2);
> > -		pwm_apply_state(pwm, &state);
> > +	pwm_apply_state(pwm, &state);
> 
> ditto, first pwm control should be in the timer function

This requires keeping a copy of pwm_state in pwm_ir but does avoid the extra
call to pwm_apply_state() here.

Having said that, the extra call to pwm_apply_state() may have benefits,
see this comment in the pwm-sifive driver:

 * - When changing both duty cycle and period, we cannot prevent in
 *   software that the output might produce a period with mixed
 *   settings (new period length and old duty cycle).

So setting the duty cycle and period once with enabled = false prevents a
first period with mixed settings (i.e. bogus).

> > -		edge = ktime_add_us(edge, txbuf[i]);
> > -		delta = ktime_us_delta(edge, ktime_get());
> > -		if (delta > 0)
> > -			usleep_range(delta, delta + 10);
> > -	}
> > +	hrtimer_start(&pwm_ir->timer, 1000, HRTIMER_MODE_REL);
> 
> why not just call it with 0 time?

Otherwise the timings are a little off for the first edge - hrtimer setup
time, I think. I can experiment again.

> > -	state.enabled = false;
> > -	pwm_apply_state(pwm, &state);
> > +	wait_for_completion(&pwm_ir->completion);
> >   	return count;
> >   }
> > +static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
> > +{
> > +	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
> > +	ktime_t now;
> > +
> > +	/*
> > +	 * If we happen to hit an odd latency spike, loop through the
> > +	 * pulses until we catch up.
> > +	 */
> > +	do {
> > +		u64 ns;
> > +
> > +		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
> > +			/* Stop TX here */
> > +			pwm_disable(pwm_ir->pwm);
> > +
> > +			complete(&pwm_ir->completion);
> > +
> > +			return HRTIMER_NORESTART;
> > +		}
> > +
> > +		if (pwm_ir->txbuf_index % 2)
> > +			pwm_disable(pwm_ir->pwm);
> > +		else
> > +			pwm_enable(pwm_ir->pwm);
> > +
> 
> pwm_ir->pwm->state.enabled = !(pwm_ir->txbuf_index % 2);
> pwm_apply_state(pwm_ir->pwm, pwm_ir->state);

Requires a copy of pwm_state in pwm_ir, not a huge difference (copy of 28
bytes vs keeping it around).

> > +		ns = US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
> > +		hrtimer_add_expires_ns(timer, ns);
> > +
> > +		pwm_ir->txbuf_index++;
> > +
> > +		now = timer->base->get_time();
> > +	} while (hrtimer_get_expires_tv64(timer) < now);
> > +
> > +	return HRTIMER_RESTART;
> > +}
> > +
> >   static int pwm_ir_probe(struct platform_device *pdev)
> >   {
> >   	struct pwm_ir *pwm_ir;
> > @@ -96,8 +135,16 @@ static int pwm_ir_probe(struct platform_device *pdev)
> >   	if (IS_ERR(pwm_ir->pwm))
> >   		return PTR_ERR(pwm_ir->pwm);
> > +	if (pwm_can_sleep(pwm_ir->pwm)) {
> > +		dev_err(&pdev->dev, "unsupported pwm device: driver can sleep\n");
> > +		return -ENODEV;
> > +	}
> > +
> 
> I think we shall not limit, but use high priority thread to support those
> drivers. I have that working on n900 with current (sleeping) pwm, see my
> reply on the other mail. Maybe we can combine both patches in a way to
> support both atomic and sleeping pwm drivers.

If the ir-rx51 driver uses a sleeping pwm then that's broken and only works
by accident - the current driver is broken then.

Spinning for longer periods (e.g. 100us) does not play well with RT. Would
make more sense to fix the pwm driver to non-sleeping when a pwm driver
is used for pwm-ir-tx?

Thanks

Sean

> 
> >   	pwm_ir->carrier = 38000;
> >   	pwm_ir->duty_cycle = 50;
> > +	init_completion(&pwm_ir->completion);
> > +	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	pwm_ir->timer.function = pwm_ir_timer;
> >   	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
> >   	if (!rcdev)
> > 
> 
> Regards,
> Ivo
