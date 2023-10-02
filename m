Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84E7B4B5C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbjJBGRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjJBGRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:17:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFBCAD;
        Sun,  1 Oct 2023 23:17:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so6048939a12.3;
        Sun, 01 Oct 2023 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696227420; x=1696832220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5zgVPM6xCRS2MkTT3rRhQMNTBCaTvz2Hu9amsFTpnE=;
        b=YTi/Be56OzCwzvlM5VeBvufDtHkGvALwO2Ax67nXB/VBo1hSl9Qy/sJYpXny1tx0dX
         YiSvgpL22pgf186elH/2ocWDtM66CYoviK3ofMAT621RfEKgsUeYzehFK5mpMI2O7taB
         VDY33ZFk0CtqogsTsrMFmVlNehMglo/x/o7FNh8i+tNja+K+5s8z2G/97G37fInzD2/b
         CNYK0eYweYRg0KUPlhksW1G0V1FX55t8A6BJgJgdp2qCCy+ulfSRY+koHa9LtEQdu02T
         y+GfaDt/9hW42NsCMdn8CZBXdvNQH6Nt514sPL/o8f1HBy8W0qYizU6XB0c2jDO855SW
         MHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696227420; x=1696832220;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5zgVPM6xCRS2MkTT3rRhQMNTBCaTvz2Hu9amsFTpnE=;
        b=f9VeielJrcV2kNoXt06rrFjCmkY99bK+qq/538R/ZxZzs6eNMVSYhDDsOwfk4/PrFv
         B5p/XwRSBjLfoNDU4W5VdFF2e/4R3moidqls39+wapzI08/8Q4bOqOGbmvZWes29RFX1
         HRgj981CjQujBxpR9RDmPF4AIo7PMv+7RWFT/eDAzxzp7+we+dWLCOXn6/7fooHXhXAi
         75qWquob5t373ZPK6xl/3nuQm9jlzbf7RHU7VD1tCdvwzOAieWChtsY6rOcD6CkbbdzC
         RJBv+Zrm11TV1z0xQND0S2v+o3koIrBu87YHHTp0KJFXcdmQcIQe8UDR4J6kL7U1x96k
         vFIQ==
X-Gm-Message-State: AOJu0YyZxHHhx+J7TMtn4OsWehkIGZ2TyEnlmvqT/MZQxTVx0RjmPMZg
        JtNzI+1u5fyl+CY5VqUyDfMeWVj/Qlo=
X-Google-Smtp-Source: AGHT+IFsc+TPyFS6zoVkPLPZd/y5hbA+SjHI7afq8NkMXYWH09pZe4ezn9tnKQ3nbvN6wduVevAo8Q==
X-Received: by 2002:a17:906:209e:b0:9b2:b747:e460 with SMTP id 30-20020a170906209e00b009b2b747e460mr9947302ejq.55.1696227419919;
        Sun, 01 Oct 2023 23:16:59 -0700 (PDT)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id rv7-20020a17090710c700b009adc81bb544sm16352505ejb.106.2023.10.01.23.16.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Oct 2023 23:16:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer
 interrupt context
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <cover.1696156485.git.sean@mess.org>
 <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <1647d018-cb4e-7c4a-c80f-c726b1ea3628@gmail.com>
Date:   Mon, 2 Oct 2023 09:16:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1.10.23 г. 13:40 ч., Sean Young wrote:
> The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> from delays as this is done in process context. Make this work in atomic
> context.
> 
> This makes the driver much more precise.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++--------
>   1 file changed, 63 insertions(+), 16 deletions(-)
> 

what about the following patch(not a proper one, just RFC)? It achieves 
the same (if not better) precision (on n900 at least) without using 
atomic pwm. What it does is: create a fifo thread in which we swicth pwm 
on/off, start hrtimer that is used to signal thread when to switch pwm.
As signal comes earlier than needed(because hrtimer runs async to the 
thread), we do a busy loop wait for the precise time to switch the pwm. 
At least on n900, this busy loop is less than 200 us per switch(worst 
case, usually it is less than 100 us). That way, even if we have some 
latency spike, it is covered by not doing busy loop for that particular 
pwm switch and we keep the precise timing.

Maybe we shall merge both patches so fifo thread to be used for sleeping 
pwms and hrtimer for atomic. I can do that and test it here if you think 
that approach makes sense.

Regards,
Ivo

PS: I have a patch that converts timer-ti-dm to non-sleeping one, will 
send it when it comes to it.

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 105a9c24f1e3..e8b620f53056 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -4,6 +4,7 @@
   */

  #include <linux/kernel.h>
+#include <linux/kthread.h>
  #include <linux/module.h>
  #include <linux/pwm.h>
  #include <linux/delay.h>
@@ -17,8 +18,16 @@

  struct pwm_ir {
  	struct pwm_device *pwm;
+	struct hrtimer timer;
+	struct task_struct *tx_thread;
+	wait_queue_head_t tx_wq;
+	struct completion tx_done;
+	struct completion edge;
  	unsigned int carrier;
  	unsigned int duty_cycle;
+	unsigned int *txbuf;
+	unsigned int count;
+	unsigned int index;
  };

  static const struct of_device_id pwm_ir_of_match[] = {
@@ -48,35 +57,103 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, 
u32 carrier)
  	return 0;
  }

-static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
-		     unsigned int count)
+static enum hrtimer_restart pwm_ir_timer_cb(struct hrtimer *timer)
+{
+	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
+	ktime_t now;
+
+	/*
+	 * If we happen to hit an odd latency spike, loop through the
+	 * pulses until we catch up.
+	 */
+	do {
+		u64 edge;
+
+		if (pwm_ir->index >= pwm_ir->count)
+			goto out;
+
+		complete(&pwm_ir->edge);
+
+		edge = US_TO_NS(pwm_ir->txbuf[pwm_ir->index]);
+		hrtimer_add_expires_ns(timer, edge);
+
+		pwm_ir->index++;
+
+		now = timer->base->get_time();
+
+	} while (hrtimer_get_expires_tv64(timer) < now);
+
+	return HRTIMER_RESTART;
+out:
+	complete(&pwm_ir->edge);
+
+	return HRTIMER_NORESTART;
+}
+
+static void _pwm_ir_tx(struct pwm_ir *pwm_ir)
  {
-	struct pwm_ir *pwm_ir = dev->priv;
-	struct pwm_device *pwm = pwm_ir->pwm;
  	struct pwm_state state;
  	int i;
  	ktime_t edge;
  	long delta;

-	pwm_init_state(pwm, &state);
+	pwm_init_state(pwm_ir->pwm, &state);

  	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
  	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);

+	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
+	wait_for_completion(&pwm_ir->edge);
  	edge = ktime_get();

-	for (i = 0; i < count; i++) {
+	for (i = 0; i < pwm_ir->count; i++) {
  		state.enabled = !(i % 2);
-		pwm_apply_state(pwm, &state);
+		pwm_apply_state(pwm_ir->pwm, &state);
+
+		edge = ktime_add_us(edge, pwm_ir->txbuf[i]);
+		wait_for_completion(&pwm_ir->edge);

-		edge = ktime_add_us(edge, txbuf[i]);
  		delta = ktime_us_delta(edge, ktime_get());
+
  		if (delta > 0)
-			usleep_range(delta, delta + 10);
+			udelay(delta);
  	}

  	state.enabled = false;
-	pwm_apply_state(pwm, &state);
+	pwm_apply_state(pwm_ir->pwm, &state);
+
+	pwm_ir->count = 0;
+}
+
+static int pwm_ir_thread(void *data)
+{
+	struct pwm_ir *pwm_ir = data;
+
+	for (;;) {
+		wait_event_idle(pwm_ir->tx_wq,
+				kthread_should_stop() || pwm_ir->count);
+
+		if (kthread_should_stop())
+			break;
+
+		_pwm_ir_tx(pwm_ir);
+		complete(&pwm_ir->tx_done);
+	}
+
+	return 0;
+}
+
+static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
+		     unsigned int count)
+{
+	struct pwm_ir *pwm_ir = dev->priv;
+
+	pwm_ir->txbuf = txbuf;
+	pwm_ir->count = count;
+	pwm_ir->index = 0;
+
+	wake_up(&pwm_ir->tx_wq);
+	wait_for_completion(&pwm_ir->tx_done);

  	return count;
  }
@@ -91,12 +168,24 @@ static int pwm_ir_probe(struct platform_device *pdev)
  	if (!pwm_ir)
  		return -ENOMEM;

+	platform_set_drvdata(pdev, pwm_ir);
+
+	pwm_ir->count = 0;
+
  	pwm_ir->pwm = devm_pwm_get(&pdev->dev, NULL);
  	if (IS_ERR(pwm_ir->pwm))
  		return PTR_ERR(pwm_ir->pwm);

-	pwm_ir->carrier = 38000;
+	init_waitqueue_head(&pwm_ir->tx_wq);
+	init_completion(&pwm_ir->edge);
+	init_completion(&pwm_ir->tx_done);
+
+	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	pwm_ir->timer.function = pwm_ir_timer_cb;
+
  	pwm_ir->duty_cycle = 50;
+	pwm_ir->carrier = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm_ir->pwm),
+						NSEC_PER_SEC);

  	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
  	if (!rcdev)
@@ -109,15 +198,38 @@ static int pwm_ir_probe(struct platform_device *pdev)
  	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
  	rcdev->s_tx_carrier = pwm_ir_set_carrier;

+	pwm_ir->tx_thread = kthread_create(pwm_ir_thread, pwm_ir, "%s/tx",
+					   dev_name(&pdev->dev));
+	if (IS_ERR(pwm_ir->tx_thread))
+		return PTR_ERR(pwm_ir->tx_thread);
+
+	sched_set_fifo(pwm_ir->tx_thread);
+	wake_up_process(pwm_ir->tx_thread);
+
  	rc = devm_rc_register_device(&pdev->dev, rcdev);
-	if (rc < 0)
+	if (rc < 0) {
+		kthread_stop(pwm_ir->tx_thread);
  		dev_err(&pdev->dev, "failed to register rc device\n");
+	}

  	return rc;
  }

+static int pwm_ir_remove(struct platform_device *pdev)
+{
+	struct pwm_ir *pwm_ir = platform_get_drvdata(pdev);
+
+	if (pwm_ir->tx_thread) {
+		kthread_stop(pwm_ir->tx_thread);
+		pwm_ir->tx_thread = NULL;
+	}
+
+	return 0;
+}
+
  static struct platform_driver pwm_ir_driver = {
  	.probe = pwm_ir_probe,
+	.remove = pwm_ir_remove,
  	.driver = {
  		.name	= DRIVER_NAME,
  		.of_match_table = of_match_ptr(pwm_ir_of_match),
