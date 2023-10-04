Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA7A7B7963
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241645AbjJDIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjJDIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:00:46 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A2A6;
        Wed,  4 Oct 2023 01:00:41 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 50736100092; Wed,  4 Oct 2023 09:00:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696406440; bh=P20aLjHrAhxgrHuMg5QiYe89UaZY0Q7KPEktQsHBWbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOb32D1N7cSgQhfuBPmdlTKM1M1+qzZuckJKWMgvV0ihbUTUhCTDCujRDhcALai2T
         YmvmX26bydxbj8ugrakJj9r2w9Tj3El5yh4+naVLQxGt840a0CBJmLL+vOmhqvEV4y
         poANJliqvHngN8FgxmKMhGXfxfH/yI9kN7/9YQrbogzxE3J8ulXNOaRvdgLz7nP6Af
         Xyh5uONDIqtbI6tQpeFitM5/Xyg8AMJT/l/HtSyTkkBBBtHToEDz/M4CmpJvJfbhw3
         ly81lqVVT7VYdK6wAQvO0eBs6H4VKtmuBnc65rse0uR8JxrfPfJ/d6knVIm0DGzh9l
         SFo8VwtNmL8iQ==
Date:   Wed, 4 Oct 2023 09:00:40 +0100
From:   Sean Young <sean@mess.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
Message-ID: <ZR0bqBbvM+hHOPXX@gofer.mess.org>
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
 <1647d018-cb4e-7c4a-c80f-c726b1ea3628@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1647d018-cb4e-7c4a-c80f-c726b1ea3628@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 02, 2023 at 09:16:53AM +0300, Ivaylo Dimitrov wrote:
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
> 
> what about the following patch(not a proper one, just RFC)? It achieves the
> same (if not better) precision (on n900 at least) without using atomic pwm.
> What it does is: create a fifo thread in which we swicth pwm on/off, start
> hrtimer that is used to signal thread when to switch pwm.
> As signal comes earlier than needed(because hrtimer runs async to the
> thread), we do a busy loop wait for the precise time to switch the pwm. At
> least on n900, this busy loop is less than 200 us per switch(worst case,
> usually it is less than 100 us). That way, even if we have some latency
> spike, it is covered by not doing busy loop for that particular pwm switch
> and we keep the precise timing.

I think this is a good idea.

> Maybe we shall merge both patches so fifo thread to be used for sleeping
> pwms and hrtimer for atomic. I can do that and test it here if you think
> that approach makes sense.

Let's try and merge this patch for the next merge window, and worry about
the atomic version after that. We've already queued the ir-rx51 removal
patches to media_stage so it would be nice to have to revert these patches,
and improve pwm-ir-tx for the next kernel release.

I'll test your patch, in the mean time would you mind posting this patch
as a proper patch (with review comments below addressed)?

Thanks,

Sean


> 
> Regards,
> Ivo
> 
> PS: I have a patch that converts timer-ti-dm to non-sleeping one, will send
> it when it comes to it.
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 105a9c24f1e3..e8b620f53056 100644
> --- a/drivers/media/rc/pwm-ir-tx.c
> +++ b/drivers/media/rc/pwm-ir-tx.c
> @@ -4,6 +4,7 @@
>   */
> 
>  #include <linux/kernel.h>
> +#include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/pwm.h>
>  #include <linux/delay.h>
> @@ -17,8 +18,16 @@
> 
>  struct pwm_ir {
>  	struct pwm_device *pwm;
> +	struct hrtimer timer;
> +	struct task_struct *tx_thread;
> +	wait_queue_head_t tx_wq;
> +	struct completion tx_done;
> +	struct completion edge;
>  	unsigned int carrier;
>  	unsigned int duty_cycle;
> +	unsigned int *txbuf;
> +	unsigned int count;
> +	unsigned int index;
>  };
> 
>  static const struct of_device_id pwm_ir_of_match[] = {
> @@ -48,35 +57,103 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32
> carrier)
>  	return 0;
>  }
> 
> -static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
> -		     unsigned int count)
> +static enum hrtimer_restart pwm_ir_timer_cb(struct hrtimer *timer)
> +{
> +	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
> +	ktime_t now;
> +
> +	/*
> +	 * If we happen to hit an odd latency spike, loop through the
> +	 * pulses until we catch up.
> +	 */
> +	do {
> +		u64 edge;
> +
> +		if (pwm_ir->index >= pwm_ir->count)
> +			goto out;

Might as well avoid the goto and put the complete and return in the body of
the if.

> +
> +		complete(&pwm_ir->edge);
> +
> +		edge = US_TO_NS(pwm_ir->txbuf[pwm_ir->index]);
> +		hrtimer_add_expires_ns(timer, edge);
> +
> +		pwm_ir->index++;
> +
> +		now = timer->base->get_time();
> +
> +	} while (hrtimer_get_expires_tv64(timer) < now);
> +
> +	return HRTIMER_RESTART;
> +out:
> +	complete(&pwm_ir->edge);
> +
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void _pwm_ir_tx(struct pwm_ir *pwm_ir)
>  {
> -	struct pwm_ir *pwm_ir = dev->priv;
> -	struct pwm_device *pwm = pwm_ir->pwm;
>  	struct pwm_state state;
>  	int i;
>  	ktime_t edge;
>  	long delta;
> 
> -	pwm_init_state(pwm, &state);
> +	pwm_init_state(pwm_ir->pwm, &state);
> 
>  	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>  	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
> 
> +	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
> +	wait_for_completion(&pwm_ir->edge);
>  	edge = ktime_get();
> 
> -	for (i = 0; i < count; i++) {
> +	for (i = 0; i < pwm_ir->count; i++) {
>  		state.enabled = !(i % 2);
> -		pwm_apply_state(pwm, &state);
> +		pwm_apply_state(pwm_ir->pwm, &state);
> +
> +		edge = ktime_add_us(edge, pwm_ir->txbuf[i]);
> +		wait_for_completion(&pwm_ir->edge);
> 
> -		edge = ktime_add_us(edge, txbuf[i]);
>  		delta = ktime_us_delta(edge, ktime_get());
> +
>  		if (delta > 0)
> -			usleep_range(delta, delta + 10);
> +			udelay(delta);
>  	}
> 
>  	state.enabled = false;
> -	pwm_apply_state(pwm, &state);
> +	pwm_apply_state(pwm_ir->pwm, &state);
> +
> +	pwm_ir->count = 0;
> +}
> +
> +static int pwm_ir_thread(void *data)
> +{
> +	struct pwm_ir *pwm_ir = data;
> +
> +	for (;;) {
> +		wait_event_idle(pwm_ir->tx_wq,
> +				kthread_should_stop() || pwm_ir->count);
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		_pwm_ir_tx(pwm_ir);
> +		complete(&pwm_ir->tx_done);
> +	}
> +
> +	return 0;
> +}
> +
> +static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
> +		     unsigned int count)
> +{
> +	struct pwm_ir *pwm_ir = dev->priv;
> +
> +	pwm_ir->txbuf = txbuf;
> +	pwm_ir->count = count;
> +	pwm_ir->index = 0;
> +
> +	wake_up(&pwm_ir->tx_wq);
> +	wait_for_completion(&pwm_ir->tx_done);
> 
>  	return count;
>  }
> @@ -91,12 +168,24 @@ static int pwm_ir_probe(struct platform_device *pdev)
>  	if (!pwm_ir)
>  		return -ENOMEM;
> 
> +	platform_set_drvdata(pdev, pwm_ir);
> +
> +	pwm_ir->count = 0;
> +
>  	pwm_ir->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pwm_ir->pwm))
>  		return PTR_ERR(pwm_ir->pwm);
> 
> -	pwm_ir->carrier = 38000;
> +	init_waitqueue_head(&pwm_ir->tx_wq);
> +	init_completion(&pwm_ir->edge);
> +	init_completion(&pwm_ir->tx_done);
> +
> +	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	pwm_ir->timer.function = pwm_ir_timer_cb;
> +
>  	pwm_ir->duty_cycle = 50;
> +	pwm_ir->carrier = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm_ir->pwm),
> +						NSEC_PER_SEC);
> 
>  	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
>  	if (!rcdev)
> @@ -109,15 +198,38 @@ static int pwm_ir_probe(struct platform_device *pdev)
>  	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
>  	rcdev->s_tx_carrier = pwm_ir_set_carrier;
> 
> +	pwm_ir->tx_thread = kthread_create(pwm_ir_thread, pwm_ir, "%s/tx",
> +					   dev_name(&pdev->dev));
> +	if (IS_ERR(pwm_ir->tx_thread))
> +		return PTR_ERR(pwm_ir->tx_thread);
> +
> +	sched_set_fifo(pwm_ir->tx_thread);
> +	wake_up_process(pwm_ir->tx_thread);

This means the thread is always around. How about creating the thread 
per-tx?

> +
>  	rc = devm_rc_register_device(&pdev->dev, rcdev);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		kthread_stop(pwm_ir->tx_thread);
>  		dev_err(&pdev->dev, "failed to register rc device\n");
> +	}
> 
>  	return rc;
>  }
> 
> +static int pwm_ir_remove(struct platform_device *pdev)
> +{
> +	struct pwm_ir *pwm_ir = platform_get_drvdata(pdev);
> +
> +	if (pwm_ir->tx_thread) {
> +		kthread_stop(pwm_ir->tx_thread);
> +		pwm_ir->tx_thread = NULL;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct platform_driver pwm_ir_driver = {
>  	.probe = pwm_ir_probe,
> +	.remove = pwm_ir_remove,
>  	.driver = {
>  		.name	= DRIVER_NAME,
>  		.of_match_table = of_match_ptr(pwm_ir_of_match),
