Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963687B9F59
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjJEOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjJEOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:20:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2B20E62;
        Thu,  5 Oct 2023 03:29:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2cee55056so150959766b.3;
        Thu, 05 Oct 2023 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696501792; x=1697106592; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWK1KGgsFifnpxABECH4YtKcxOvbFg5VERnvowJC8Eo=;
        b=IzUfYMGDCo50uyCw0Ziwlr00jI0QpZt2isx2fVrbGhWjZOz4YTesvaNqfnN+WKuRoe
         AwdVNxzOIy9InlFzHuMvi0TcY8f/2Ks3bXlV19AFUpRW57Rwc1sjMcZpqbjZbrlFGfCG
         BkWSTsXF6T4VwpnxM+e1mqfs4A0zi/WKQKGZBtKUrSygZ8iQPOG2SoFeDNFn7ytGY/Ma
         M1nxFYxxXjyz6fxIAahS3nMOUE0y2OmP7aP5zSRK6rSOikPvh6An4SDOpElJkfTigwrt
         iB1C81nxNNDUF9GB76haXNbusJMDKMLHNCD8KyBNFXqEZkcgZp1VCfkgmbKGTJl2g2Sx
         DL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696501792; x=1697106592;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWK1KGgsFifnpxABECH4YtKcxOvbFg5VERnvowJC8Eo=;
        b=xPsu/FfHBTVhpwA5Kf4G5UoxFGkeSKUWo9A4BA7EtxESdeLYm+VJct0Ig2T4bVWw6e
         1clBdvI1n4bQY4cuz5zIwqZ8VVV/b/q2EyYGf3CxpiecunYjLxSjvM6yCN3Q7zGuJLLY
         Ee4Ki9KY8+Edq8aM8LneejLgV44fhRF5/3NY+OemuOxFkUtxNu+tPRW6+mOdaYy0lpWR
         nF6RJPgrAW3rzhESLbTtnJlTZNwluJ3DiUbdg885cRL+2AkRxucRQ03IG99RvUjQJjTH
         uJNxruwya/AvDWihntt8oj8qsTKAXUIf5YOTFv+Y0OZhHFiCNkznM4Rw6pdGjc+M4rDw
         kMsw==
X-Gm-Message-State: AOJu0YwFECubpk3SBeRhsLpSuwNsCCICnWNf8MqDJVfK3MV5a5alXz2B
        zLCqBaOeao5CY5gVAcBqAe8oJX2U8Kk=
X-Google-Smtp-Source: AGHT+IFdziX5Oo0F0ntZMF7HNZK0fTv4bVtYW+Of9g01bQ/Dwd5j7u1XOjdgO+kEmVNDI4N4f04Nlw==
X-Received: by 2002:a17:906:51d1:b0:9b2:7657:87c0 with SMTP id v17-20020a17090651d100b009b2765787c0mr4126798ejk.51.1696501791664;
        Thu, 05 Oct 2023 03:29:51 -0700 (PDT)
Received: from localhost.localdomain ([95.43.220.235])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906378c00b0099d45ed589csm927940ejc.125.2023.10.05.03.29.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2023 03:29:51 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] media: rc: pwm-ir-tx: use hrtimer for edge generation
Date:   Thu,  5 Oct 2023 13:28:59 +0300
Message-Id: <1696501739-29861-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usleep_range() seems to suffer from scheduling latency of up to 400 us on
some platforms (like OMAP) which makes it unusable for IR pulses edge
timings. In the same time pwm_ir_trx() is called in a context with priority
which might not be suitable for real-time IR pulses generation.

Fix that by using hrtimer and a thread with sched_set_fifo() priority. That
way scheduling latency is compensated by the fact that PWM is controlled in
the thread after a completion is signalled in hrtimer function - we have
more or less the same latency for every edge. If completion comes earlier
than needed, we do udelay() till the exact time for the next edge. That
way pulse width generation is robust and precise and mostly independent of
the system load.

Tests on Nokia N900 showed that udelay() is called with up to 200 us in
worst cases, usually times are less that 100 us.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/media/rc/pwm-ir-tx.c | 122 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index 7732054c..cb6ce73 100644
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
@@ -48,12 +57,41 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32 carrier)
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
+		complete(&pwm_ir->edge);
+
+		if (pwm_ir->index >= pwm_ir->count)
+			return HRTIMER_NORESTART;
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
+}
+
+static void _pwm_ir_tx(struct pwm_ir *pwm_ir)
 {
-	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
 	struct pwm_state state;
+	unsigned int *txbuf = pwm_ir->txbuf;
+	unsigned int count = pwm_ir->count;
 	int i;
 	ktime_t edge;
 	long delta;
@@ -63,6 +101,8 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
 	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
 
+	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
+	wait_for_completion(&pwm_ir->edge);
 	edge = ktime_get();
 
 	for (i = 0; i < count; i++) {
@@ -70,14 +110,50 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 		pwm_apply_state(pwm, &state);
 
 		edge = ktime_add_us(edge, txbuf[i]);
+		wait_for_completion(&pwm_ir->edge);
+
 		delta = ktime_us_delta(edge, ktime_get());
+
 		if (delta > 0)
-			usleep_range(delta, delta + 10);
+			udelay(delta);
 	}
 
 	state.enabled = false;
 	pwm_apply_state(pwm, &state);
 
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
+
 	return count;
 }
 
@@ -91,12 +167,24 @@ static int pwm_ir_probe(struct platform_device *pdev)
 	if (!pwm_ir)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, pwm_ir);
+
 	pwm_ir->pwm = devm_pwm_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm_ir->pwm))
 		return PTR_ERR(pwm_ir->pwm);
 
-	pwm_ir->carrier = 38000;
+	/* Use default, in case userspace does not set the carrier */
+	pwm_ir->carrier = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm_ir->pwm),
+						NSEC_PER_SEC);
 	pwm_ir->duty_cycle = 50;
+	pwm_ir->count = 0;
+
+	init_waitqueue_head(&pwm_ir->tx_wq);
+	init_completion(&pwm_ir->edge);
+	init_completion(&pwm_ir->tx_done);
+
+	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	pwm_ir->timer.function = pwm_ir_timer_cb;
 
 	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
 	if (!rcdev)
@@ -110,14 +198,34 @@ static int pwm_ir_probe(struct platform_device *pdev)
 	rcdev->s_tx_carrier = pwm_ir_set_carrier;
 
 	rc = devm_rc_register_device(&pdev->dev, rcdev);
-	if (rc < 0)
+	if (rc < 0) {
 		dev_err(&pdev->dev, "failed to register rc device\n");
+		return rc;
+	}
+
+	pwm_ir->tx_thread = kthread_create(pwm_ir_thread, pwm_ir, "%s/tx",
+					   dev_name(&pdev->dev));
+	if (IS_ERR(pwm_ir->tx_thread))
+		return PTR_ERR(pwm_ir->tx_thread);
 
-	return rc;
+	sched_set_fifo(pwm_ir->tx_thread);
+	wake_up_process(pwm_ir->tx_thread);
+
+	return 0;
+}
+
+static int pwm_ir_remove(struct platform_device *pdev)
+{
+	struct pwm_ir *pwm_ir = platform_get_drvdata(pdev);
+
+	kthread_stop(pwm_ir->tx_thread);
+
+	return 0;
 }
 
 static struct platform_driver pwm_ir_driver = {
 	.probe = pwm_ir_probe,
+	.remove = pwm_ir_remove,
 	.driver = {
 		.name	= DRIVER_NAME,
 		.of_match_table = pwm_ir_of_match,
-- 
1.9.1

