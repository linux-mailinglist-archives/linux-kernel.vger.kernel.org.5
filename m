Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D9E7C839A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJMKrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJMKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:47:31 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A22B7;
        Fri, 13 Oct 2023 03:47:26 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 819221000C6; Fri, 13 Oct 2023 11:47:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697194045; bh=a+OT+HzNlnPxyf1ivSREODdEglTMX6uJLENTDZVv+3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2rYGmFbzU16Zo9TZ5PgbeTlCgt2UAm/9upTR5nZ/Fh/NatlJIEH+dLl8DxMacDLs
         KwQwemhkJHGkejK2zCttay/P5x3SRy3Afe4ML4IlUbX7EHPffPGG0PiYzrlzy77maB
         iMLyil3Y4qKit5K365OXf1o+UWhkNx6OgKVaMkVcZA3QUoSzfeqgIWk/xHT3BwfDHt
         pjmp09NJ9UJfH1/kfvxZ90eP3Ke96ZWPFwvASr2qVzWwVAfCl5QiknABL4QoC6t80d
         E7AD8rAZ9iAP3oUFyWoZgWdUWaJSLHAcO1Pvk2Oznz5Bc5rZonordQRO1SWEOT2AM8
         kfQ/jMqphyllQ==
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
        by gofer.mess.org (Postfix) with ESMTPSA id 95D831000C6;
        Fri, 13 Oct 2023 11:47:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697194043; bh=a+OT+HzNlnPxyf1ivSREODdEglTMX6uJLENTDZVv+3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyFMY6Cp/t2LA/IOZwLp4An5hFfJhhWgS9n8uhI7JwF3aR63b0IceINN0kJpQfTFi
         i700a30JMLprBEYm3Vduw3pD5FUXcS/T9OjLF2aU/D9fezt2GVGLYp8wdDk2VSLfaI
         53ossojhah6OONUpD48GxW93FitpVkDhy7QZsRShrmi/7GtCqG77Sj97QC9knIwL8p
         HpqnO2LyqV9sb+27mRDxtfC+e1ITLwJ/aXv51PYHDpKq2xt0Jsi3jFMv7NAaIDcype
         9dPaFAFBHNxa3/41gjHyOZZDLcCuajJ5dkKyAUDZreLEooHxh6Y8p5sBoNjzt50rM6
         /n4UEhoDXHhMg==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] pwm: bcm2835: allow pwm driver to be used in atomic context
Date:   Fri, 13 Oct 2023 11:46:15 +0100
Message-ID: <6ce73b2688f059e7169935699044104cf37b2425.1697193646.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697193646.git.sean@mess.org>
References: <cover.1697193646.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate() may do a mutex lock. Since the clock rate cannot change on
an rpi, simply fetch it once.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-bcm2835.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index bdfc2a5ec0d6..59ea154dd657 100644
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
@@ -129,6 +124,7 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 	.request = bcm2835_pwm_request,
 	.free = bcm2835_pwm_free,
 	.apply = bcm2835_pwm_apply,
+	.atomic = true,
 	.owner = THIS_MODULE,
 };
 
@@ -156,6 +152,13 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate) {
+		dev_err(pc->dev, "failed to get clock rate\n");
+		ret = -EINVAL;
+		goto add_fail;
+	}
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
-- 
2.42.0

