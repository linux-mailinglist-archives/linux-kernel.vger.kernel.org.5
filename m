Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87267B46F9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjJAKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjJAKlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:41:12 -0400
X-Greylist: delayed 152457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Oct 2023 03:41:09 PDT
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26960D8;
        Sun,  1 Oct 2023 03:41:09 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 8C6291007F9; Sun,  1 Oct 2023 11:41:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696156867; bh=RSMxdZlA6dvGl+ue7BCTI/DiHrSS0pIbsuFSiBzaOJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9z9EUlgawEqlaCkIPyJ6mNMWC2WE3QL+yucOEtRFySKnL/fb7NL2zshpKzwoTkmv
         44LYsYUlyznZDNPS6tcJCa6WODDu4ksUgG+bgTqodh7zRtgNaDL0ujp4ahdbJGeWsc
         /yE/wxsgFWrdmO0FLUCdm306F9vcbcM1QlNDpjAfTLqMNzy5aQZPLVL/ynm9SDdROx
         vB85Mj+LRA/DGUZEtXEnH59yRl47JPWWwFSzFY6+JBcAUeuB52UcBTw75XsBHouC6x
         BmOVl48nSleG9qMnPkVIgA/WnlNuGKn2nMQP27/B+U0qB6gGZlBl2AUKqp7LSv/VYa
         RNitSIyNv/rOQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id D57F41007F6;
        Sun,  1 Oct 2023 11:41:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696156860; bh=RSMxdZlA6dvGl+ue7BCTI/DiHrSS0pIbsuFSiBzaOJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Burzah2rsgdUFBELWQkDEpvEVUZuZ10sJsnvNNbRfakZycGZ1mt3/98/RYa/iw6D4
         KU840KaAqRazeBe/+RR/xfltc+SSlg5DrZpoy1IzcnDOIBMozmNiKKpeWLC0MOViLL
         5sfS5k1nunMjHzxWo94snpO5hz6l4mI0Tv1k8SJsVyDshiWy3q6Zn7svKI06GYwL+I
         LrrreBQQAdNKv2Vqv8jvYwdX0rDbpj4QaEyK3nX6Z89UVnZ9qfMZqA5l/5qSAq5piT
         NTHl62yvdP/bq9G9zOo4q7Sxtj7cUPj3PJ5oJf/iaYkQP7pIpeFd2YPU5slpZY1FMv
         shX3PYzqFLeDA==
From:   Sean Young <sean@mess.org>
To:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] media: pwm-ir-tx: trigger edges from hrtimer interrupt context
Date:   Sun,  1 Oct 2023 11:40:30 +0100
Message-ID: <7efe4229514001b835fa70d51973cd3306dc0b04.1696156485.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696156485.git.sean@mess.org>
References: <cover.1696156485.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
from delays as this is done in process context. Make this work in atomic
context.

This makes the driver much more precise.

Signed-off-by: Sean Young <sean@mess.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index c5f37c03af9c..557725a07a67 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -10,6 +10,8 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/hrtimer.h>
+#include <linux/completion.h>
 #include <media/rc-core.h>
 
 #define DRIVER_NAME	"pwm-ir-tx"
@@ -17,8 +19,13 @@
 
 struct pwm_ir {
 	struct pwm_device *pwm;
-	unsigned int carrier;
-	unsigned int duty_cycle;
+	struct hrtimer timer;
+	struct completion completion;
+	uint carrier;
+	uint duty_cycle;
+	uint *txbuf;
+	uint txbuf_len;
+	uint txbuf_index;
 };
 
 static const struct of_device_id pwm_ir_of_match[] = {
@@ -55,33 +62,65 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
 	struct pwm_state state;
-	int i;
-	ktime_t edge;
-	long delta;
+
+	reinit_completion(&pwm_ir->completion);
 
 	pwm_init_state(pwm, &state);
 
 	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
 	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
+	state.enabled = false;
 
-	edge = ktime_get();
+	pwm_ir->txbuf = txbuf;
+	pwm_ir->txbuf_len = count;
+	pwm_ir->txbuf_index = 0;
 
-	for (i = 0; i < count; i++) {
-		state.enabled = !(i % 2);
-		pwm_apply_state(pwm, &state);
+	pwm_apply_state(pwm, &state);
 
-		edge = ktime_add_us(edge, txbuf[i]);
-		delta = ktime_us_delta(edge, ktime_get());
-		if (delta > 0)
-			usleep_range(delta, delta + 10);
-	}
+	hrtimer_start(&pwm_ir->timer, 1000, HRTIMER_MODE_REL);
 
-	state.enabled = false;
-	pwm_apply_state(pwm, &state);
+	wait_for_completion(&pwm_ir->completion);
 
 	return count;
 }
 
+static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
+{
+	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
+	ktime_t now;
+
+	/*
+	 * If we happen to hit an odd latency spike, loop through the
+	 * pulses until we catch up.
+	 */
+	do {
+		u64 ns;
+
+		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
+			/* Stop TX here */
+			pwm_disable(pwm_ir->pwm);
+
+			complete(&pwm_ir->completion);
+
+			return HRTIMER_NORESTART;
+		}
+
+		if (pwm_ir->txbuf_index % 2)
+			pwm_disable(pwm_ir->pwm);
+		else
+			pwm_enable(pwm_ir->pwm);
+
+		ns = US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
+		hrtimer_add_expires_ns(timer, ns);
+
+		pwm_ir->txbuf_index++;
+
+		now = timer->base->get_time();
+	} while (hrtimer_get_expires_tv64(timer) < now);
+
+	return HRTIMER_RESTART;
+}
+
 static int pwm_ir_probe(struct platform_device *pdev)
 {
 	struct pwm_ir *pwm_ir;
@@ -96,8 +135,16 @@ static int pwm_ir_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm_ir->pwm))
 		return PTR_ERR(pwm_ir->pwm);
 
+	if (pwm_can_sleep(pwm_ir->pwm)) {
+		dev_err(&pdev->dev, "unsupported pwm device: driver can sleep\n");
+		return -ENODEV;
+	}
+
 	pwm_ir->carrier = 38000;
 	pwm_ir->duty_cycle = 50;
+	init_completion(&pwm_ir->completion);
+	hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	pwm_ir->timer.function = pwm_ir_timer;
 
 	rcdev = devm_rc_allocate_device(&pdev->dev, RC_DRIVER_IR_RAW_TX);
 	if (!rcdev)
-- 
2.42.0

