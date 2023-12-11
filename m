Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309580C305
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjLKIZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbjLKIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:25:21 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F95F1;
        Mon, 11 Dec 2023 00:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702283125; bh=gTEti/8B23Lhh743tVWTymBVRCEpQHU5KFyCDk5okO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tSGp//TXt3IeNW4WoqJ98TXLw18mgHbTczTAoKaaYWYfNVyLdb4QR7hRkCqJO7QST
         o8ZYUlbGSyDKjI141ZeZphvFX/WbWvWEuh1EnLtml6ANKH0Uk4Dqn4f3tcNN1FDZH7
         97ZiJMK8TD2nJeB5JnPJClL6lHNZWdiDnTIexMEG8Ai+fHxQ+/fhocqv1M4pSHoAqC
         GKnzavrTDsttQi89VA2aRh8w6eXn2rXCz0PNuBYYVmC2j4WPlumghLYc8KkcGHtCcw
         y0Mzw6sIB3yK/imhIzigcgp8TAplaq0CYVcpKRjN6KkV3imgMoQmJMjLnAea+AwNB1
         SOr9v2A8Uocbg==
Received: by gofer.mess.org (Postfix, from userid 501)
        id D8770100A09; Mon, 11 Dec 2023 08:25:25 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1702283109; bh=gTEti/8B23Lhh743tVWTymBVRCEpQHU5KFyCDk5okO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7EmiRK0dftRbaYX3YYclS0dtrzl/X2SCpG0r1GV1oJLzJlrPkl6/EQxuIhTw9MKy
         fwmtKUzpOSl4YSWekq3yBb4HyzwUIKG50VPs2p9lGS7kaYQzRkhGLAVFjM/OixfHo0
         fuQBPlSDq6kCUY22Zz0y7yG0YBqUJKPIDQW0NsE8Umv7Z81t4wzT2ZI4o3WakUMvPw
         BbLhICHo3Y7MGl67j8FEIuwaPx1Chm3Kv1V1oL8xgo1LIjQbD7Yzpg4xjhJT2E2AvA
         PdBYjI9J6y1dKkhpFAW0B7/sPmTaeTSv8O57PsThAsYLWzrKPX+0LeL1bYZ0iR/Ao8
         Qjq5a5rXK1v7Q==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 73D8710029E;
        Mon, 11 Dec 2023 08:25:09 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Sean Young <sean@mess.org>, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/4] pwm: bcm2835: Allow PWM driver to be used in atomic context
Date:   Mon, 11 Dec 2023 08:24:54 +0000
Message-ID: <69e50d0df1dbb08122cd54af442063c0618fd4ee.1702282807.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702282806.git.sean@mess.org>
References: <cover.1702282806.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
rate changes using clk_rate_exclusive_get().

Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index ab30667f4f951..309d52ec43bbe 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -28,6 +28,7 @@ struct bcm2835_pwm {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	unsigned long rate;
 };
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
@@ -63,17 +64,11 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	unsigned long rate = clk_get_rate(pc->clk);
 	unsigned long long period_cycles;
 	u64 max_period;
 
 	u32 val;
 
-	if (!rate) {
-		dev_err(pc->dev, "failed to get clock rate\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_SEC
 	 * must be <= U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
@@ -88,13 +83,13 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * <=> period < ((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate
 	 * <=> period <= ceil((U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC/2) / rate) - 1
 	 */
-	max_period = DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC / 2, rate) - 1;
+	max_period = DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER_SEC / 2, pc->rate) - 1;
 
 	if (state->period > max_period)
 		return -EINVAL;
 
 	/* set period */
-	period_cycles = DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER_SEC);
+	period_cycles = DIV_ROUND_CLOSEST_ULL(state->period * pc->rate, NSEC_PER_SEC);
 
 	/* don't accept a period that is too small */
 	if (period_cycles < PERIOD_MIN)
@@ -103,7 +98,7 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
 
 	/* set duty cycle */
-	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * rate, NSEC_PER_SEC);
+	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pc->rate, NSEC_PER_SEC);
 	writel(val, pc->base + DUTY(pwm->hwpwm));
 
 	/* set polarity */
@@ -151,16 +146,31 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
+	ret = clk_rate_exclusive_get(pc->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "fail to get exclusive rate\n");
+
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate) {
+		clk_rate_exclusive_put(pc->clk);
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get clock rate\n");
+	}
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.atomic = true;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
 
 	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
-	if (ret < 0)
+	if (ret < 0) {
+		clk_rate_exclusive_put(pc->clk);
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
+	}
 
 	return 0;
 }
@@ -169,6 +179,7 @@ static int bcm2835_pwm_suspend(struct device *dev)
 {
 	struct bcm2835_pwm *pc = dev_get_drvdata(dev);
 
+	clk_rate_exclusive_put(pc->clk);
 	clk_disable_unprepare(pc->clk);
 
 	return 0;
-- 
2.43.0

