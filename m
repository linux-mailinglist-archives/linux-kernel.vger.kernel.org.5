Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A88C7C8414
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjJMLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjJMLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:08:33 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8AED;
        Fri, 13 Oct 2023 04:08:29 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 75BFE1000C4; Fri, 13 Oct 2023 12:08:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697195308; bh=zTnxXs5WkLWGedGanBKBI5sMR53wBy4YKczpjgItnfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bPMtAVT3v1LbwwIUARFzte6MHwLYlPQtYxXD6hI1aejBFH3t1V5bxpe9H9ZLEJKcQ
         JX9a3us+tjDWNzYuubVN+ShIYMrC9u71f26/G48L5Ay5+4GMCEgytJyrkfmXSGOq6H
         CDEICD2BuWogx41w8Xr+WumDEBQrocG7CcDdF0mLpZjZtUI+p7GFdvPYFh4ODwbztM
         B6OeFcpAhSfOWNPnSaC/U6PCKt5Tdw6nKEirHHoTRcH+rW/J0+R2LIOFDHsHxqI6Lh
         LTBaoSQ8DoOIPdZTFf5tdkWd7wjvSnFCVhoW0VcWV+29yChqQEkcgIEgfUtGvnkZEZ
         ag/m8xIFd6dTQ==
Date:   Fri, 13 Oct 2023 12:08:28 +0100
From:   Sean Young <sean@mess.org>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] media: rc: pwm-ir-tx: use hrtimer for edge generation
Message-ID: <ZSklLLWaxpS98Agc@gofer.mess.org>
References: <1696501739-29861-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696501739-29861-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:28:59PM +0300, Ivaylo Dimitrov wrote:
> usleep_range() seems to suffer from scheduling latency of up to 400 us on
> some platforms (like OMAP) which makes it unusable for IR pulses edge
> timings. In the same time pwm_ir_trx() is called in a context with priority
> which might not be suitable for real-time IR pulses generation.
> 
> Fix that by using hrtimer and a thread with sched_set_fifo() priority. That
> way scheduling latency is compensated by the fact that PWM is controlled in
> the thread after a completion is signalled in hrtimer function - we have
> more or less the same latency for every edge. If completion comes earlier
> than needed, we do udelay() till the exact time for the next edge. That
> way pulse width generation is robust and precise and mostly independent of
> the system load.
> 
> Tests on Nokia N900 showed that udelay() is called with up to 200 us in
> worst cases, usually times are less that 100 us.

Cc the RT folks, I would like some input on this. How bad is this for
linux-rt or non-linux-rt for latency? Is this a problem, and if so is there
an #ifdef we can use to avoid it in certain builds?

> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  drivers/media/rc/pwm-ir-tx.c | 122 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 115 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
> index 7732054c..cb6ce73 100644
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
> @@ -48,12 +57,41 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32 carrier)
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
> +		complete(&pwm_ir->edge);
> +
> +		if (pwm_ir->index >= pwm_ir->count)
> +			return HRTIMER_NORESTART;
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
> +}
> +
> +static void _pwm_ir_tx(struct pwm_ir *pwm_ir)
>  {
> -	struct pwm_ir *pwm_ir = dev->priv;
>  	struct pwm_device *pwm = pwm_ir->pwm;
>  	struct pwm_state state;
> +	unsigned int *txbuf = pwm_ir->txbuf;
> +	unsigned int count = pwm_ir->count;
>  	int i;
>  	ktime_t edge;
>  	long delta;
> @@ -63,6 +101,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>  	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
>  	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
>  
> +	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
> +	wait_for_completion(&pwm_ir->edge);
>  	edge = ktime_get();
>  
>  	for (i = 0; i < count; i++) {
> @@ -70,14 +110,50 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
>  		pwm_apply_state(pwm, &state);
>  
>  		edge = ktime_add_us(edge, txbuf[i]);
> +		wait_for_completion(&pwm_ir->edge);
> +
>  		delta = ktime_us_delta(edge, ktime_get());
> +
>  		if (delta > 0)
> -			usleep_range(delta, delta + 10);
> +			udelay(delta);

So you're sleeping if the timer arrives early, but what about if it arrives
late? No amount of sleeping will here there.

>  	}
>  
>  	state.enabled = false;
>  	pwm_apply_state(pwm, &state);
>  
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

Rather than creating a new thread, we could use re-use the process that
is doing the TX, i.e. put this in pwm_ir_tx() itself. That should work,
right?

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
> +
>  	return count;
>  }
>  
> @@ -91,12 +167,24 @@ static int pwm_ir_probe(struct platform_device *pdev)
>  	if (!pwm_ir)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, pwm_ir);
> +
>  	pwm_ir->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pwm_ir->pwm))
>  		return PTR_ERR(pwm_ir->pwm);
>  
> -	pwm_ir->carrier = 38000;
> +	/* Use default, in case userspace does not set the carrier */
> +	pwm_ir->carrier = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm_ir->pwm),
> +						NSEC_PER_SEC);
>  	pwm_ir->duty_cycle = 50;
> +	pwm_ir->count = 0;
> +
> +	init_waitqueue_head(&pwm_ir->tx_wq);
> +	init_completion(&pwm_ir->edge);
> +	init_completion(&pwm_ir->tx_done);
> +
> +	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	pwm_ir->timer.function = pwm_ir_timer_cb;
>  
>  	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
>  	if (!rcdev)
> @@ -110,14 +198,34 @@ static int pwm_ir_probe(struct platform_device *pdev)
>  	rcdev->s_tx_carrier = pwm_ir_set_carrier;
>  
>  	rc = devm_rc_register_device(&pdev->dev, rcdev);
> -	if (rc < 0)
> +	if (rc < 0) {
>  		dev_err(&pdev->dev, "failed to register rc device\n");
> +		return rc;
> +	}
> +
> +	pwm_ir->tx_thread = kthread_create(pwm_ir_thread, pwm_ir, "%s/tx",
> +					   dev_name(&pdev->dev));
> +	if (IS_ERR(pwm_ir->tx_thread))
> +		return PTR_ERR(pwm_ir->tx_thread);
>  
> -	return rc;
> +	sched_set_fifo(pwm_ir->tx_thread);
> +	wake_up_process(pwm_ir->tx_thread);
> +
> +	return 0;
> +}
> +
> +static int pwm_ir_remove(struct platform_device *pdev)
> +{
> +	struct pwm_ir *pwm_ir = platform_get_drvdata(pdev);
> +
> +	kthread_stop(pwm_ir->tx_thread);
> +
> +	return 0;
>  }
>  
>  static struct platform_driver pwm_ir_driver = {
>  	.probe = pwm_ir_probe,
> +	.remove = pwm_ir_remove,
>  	.driver = {
>  		.name	= DRIVER_NAME,
>  		.of_match_table = pwm_ir_of_match,
> -- 
> 1.9.1
