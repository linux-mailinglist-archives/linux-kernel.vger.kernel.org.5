Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755E980E640
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjLLIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjLLIef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:34:35 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EEA10F;
        Tue, 12 Dec 2023 00:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702370080; bh=VG5ODc7Qao4WW/nSZE6mHR4bHC822oumil/Bqxfu/yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vnfp6YoO7jtQab8iFoGW0hu488sNLYVDDT0hzj2zgpA2rNDlbLyrTEbxKVpGLeUHD
         OrKBM66Gu9RWQY3/GNESwATskeMU+xDYMjZqWDlvakjD37Xbq7XoONKk/344lUeDAE
         opZxpMJdQeQYUbsGRwc8Mzw5XBVmuRehVwmYfnZrB+FjO/pTFoNE+ZpFNhuSft59Z+
         AVPgqHoAZBu/L5L29xxjMXeEcXhC883WjfyO9+cQ5NBqgHku1tqmu630ehI4iiwmAN
         orf1RAfqAIHoM+Z9m8MCEOJsMgwYlH/HlqvKvEFai8UCnkwscgks3wiFz8ti1szcCV
         fZa1PfPcZLmZg==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 92E071009FC; Tue, 12 Dec 2023 08:34:40 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702370063; bh=VG5ODc7Qao4WW/nSZE6mHR4bHC822oumil/Bqxfu/yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emtTqSerEUlYl32NAURBtyHU9Z9sq+JDT0rHFJM3r+S+bGmhDAYBFhSdpiBnMNgCe
         UMzBGGX5ZURggUJz+hPxyhLj3t0D4Lb6AE9cDNjaqurMkrlTsLWmzJ0vEvLV+xTPus
         nG0Wga8YcutIInMslBN3+nAgl2zowTNZBhXPnoZ0tYDyXLIGaqQLdFB7TpQmSY/sze
         Jsm9afwxkdvhNrEPcLOS/J/NRqBUAsEgVRMgYiadBHtw19LNVVfrFqT4gi9cJNeHj+
         hdL2/Gl9lGmpF2c9glf6t8BpaAb0DlLo6d5Cyduh70GVkobvWKMMbt/66f/WHWmRvn
         RhLC/M3qo6OFA==
Received: from localhost.localdomain (bigcore-58.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 3A0E71009FF;
        Tue, 12 Dec 2023 08:34:23 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/6] media: pwm-ir-tx: Trigger edges from hrtimer interrupt context
Date:   Tue, 12 Dec 2023 08:34:05 +0000
Message-ID: <e20c1f2a61ca2cafd7e8b7b78f08c6e496a0efc6.1702369869.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702369869.git.sean@mess.org>
References: <cover.1702369869.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the generated IR much more precise. Before this change, the
driver is unreliable and many users opted to use gpio-ir-tx instead.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 83 +++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index cf51e27609759..fe368aebbc139 100644
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
@@ -17,8 +19,14 @@
 
 struct pwm_ir {
 	struct pwm_device *pwm;
-	unsigned int carrier;
-	unsigned int duty_cycle;
+	struct hrtimer timer;
+	struct completion tx_done;
+	struct pwm_state *state;
+	u32 carrier;
+	u32 duty_cycle;
+	const unsigned int *txbuf;
+	unsigned int txbuf_len;
+	unsigned int txbuf_index;
 };
 
 static const struct of_device_id pwm_ir_of_match[] = {
@@ -49,8 +57,8 @@ static int pwm_ir_set_carrier(struct rc_dev *dev, u32 carrier)
 	return 0;
 }
 
-static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
-		     unsigned int count)
+static int pwm_ir_tx_sleep(struct rc_dev *dev, unsigned int *txbuf,
+			   unsigned int count)
 {
 	struct pwm_ir *pwm_ir = dev->priv;
 	struct pwm_device *pwm = pwm_ir->pwm;
@@ -82,6 +90,62 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	return count;
 }
 
+static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned int *txbuf,
+			    unsigned int count)
+{
+	struct pwm_ir *pwm_ir = dev->priv;
+	struct pwm_device *pwm = pwm_ir->pwm;
+	struct pwm_state state;
+
+	pwm_init_state(pwm, &state);
+
+	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
+	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
+
+	pwm_ir->txbuf = txbuf;
+	pwm_ir->txbuf_len = count;
+	pwm_ir->txbuf_index = 0;
+	pwm_ir->state = &state;
+
+	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
+
+	wait_for_completion(&pwm_ir->tx_done);
+
+	return count;
+}
+
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
+		pwm_ir->state->enabled = !(pwm_ir->txbuf_index % 2);
+		pwm_apply_atomic(pwm_ir->pwm, pwm_ir->state);
+
+		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
+			complete(&pwm_ir->tx_done);
+
+			return HRTIMER_NORESTART;
+		}
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
@@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pdev)
 	if (!rcdev)
 		return -ENOMEM;
 
+	if (pwm_might_sleep(pwm_ir->pwm)) {
+		dev_info(&pdev->dev, "TX will not be accurate as PWM device might sleep\n");
+		rcdev->tx_ir = pwm_ir_tx_sleep;
+	} else {
+		init_completion(&pwm_ir->tx_done);
+		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		pwm_ir->timer.function = pwm_ir_timer;
+		rcdev->tx_ir = pwm_ir_tx_atomic;
+	}
+
 	rcdev->priv = pwm_ir;
 	rcdev->driver_name = DRIVER_NAME;
 	rcdev->device_name = DEVICE_NAME;
-	rcdev->tx_ir = pwm_ir_tx;
 	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
 	rcdev->s_tx_carrier = pwm_ir_set_carrier;
 
-- 
2.43.0

