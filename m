Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC77CBF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjJQJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343536AbjJQJSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:18:23 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD75B0;
        Tue, 17 Oct 2023 02:18:22 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id A9B95100104; Tue, 17 Oct 2023 10:18:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697534300; bh=ZxkAUO/92zmH6rwh0JhJYrp15Z9F2+z1H8tS7+HuIAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3SAEy0Jh/uC6yOisGXO7E8FcJndlpHQXuu8+SOJ4mkBl3KlJFZR8bw5HHqXrUPhu
         0kk+TnXZ6+gDrlv3ZVkUV5oNOTdQurFoCFubawAnFlbfYJ5ccFjZpgJr3JsMBFlGZa
         Cn4qV8Twe7S9JlOzwqKyZprOJEZvhMNh17Eg1jaI3soETrabW6bynYvIy6Xjihmlz4
         asCxY7RJX728mIwLZo8gGkwPDoJZkXVRQiy9YeF8hv4INidGJ7aNXWEMXgk+ovT+Jk
         M+rXI1xcjarUx/PhahnUoDibOrVhId8muFWoQ2kPQ6TTfPJimwTarsgHmdpDXOqK/O
         28+z35quysClA==
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
        by gofer.mess.org (Postfix) with ESMTPSA id C326A1000FC;
        Tue, 17 Oct 2023 10:18:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697534281; bh=ZxkAUO/92zmH6rwh0JhJYrp15Z9F2+z1H8tS7+HuIAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHTwiL3HjDbFE9ouWJwhZWrVKb7IKfxwHplcViSwMPdSQNNi7zVHZSNGuwa4zxBLe
         NXLN3pVFxLQAHoGM/LAap5h9zZ1dfA4/Wpfq3gzT9tVDL4ApnVyuLSBjk9Z8mzC6aX
         yHabu3WGq1g1YPFis65Zm7lpbhhcfqkw3GBs0a8HfIRti7dCczkP75LRQq2u3Cs11G
         k5vLUMIblfnn5TTQRLkG7idVgOXz56iZMALKcDD2Ylcw1xglQCrhXlvbmP8zXzTBAb
         qs+4fyLB/sC5qHuUCgTx/20EyNzBsrbCRgZD0iL41/2Om+jOgdGiqH2D587OzRIJSq
         bUBmkCxDenmpQ==
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
Subject: [PATCH v3 2/3] pwm: bcm2835: allow pwm driver to be used in atomic context
Date:   Tue, 17 Oct 2023 10:17:38 +0100
Message-ID: <c826281c0ceab8ce8fcc453a5ce777444349ff9a.1697534024.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697534024.git.sean@mess.org>
References: <cover.1697534024.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate() may do a mutex lock. Since the clock rate cannot change on
an rpi, simply fetch it once.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-bcm2835.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index bdfc2a5ec0d69..bd636ac1c5074 100644
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
@@ -156,18 +151,32 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = clk_rate_exclusive_get(pc->clk);
+	if (ret)
+		goto add_fail;
+
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate) {
+		dev_err(pc->dev, "failed to get clock rate\n");
+		ret = -EINVAL;
+		goto rate_fail;
+	}
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.atomic = true;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0)
-		goto add_fail;
+		goto rate_fail;
 
 	return 0;
 
+rate_fail:
+	clk_rate_exclusive_put(pc->clk);
 add_fail:
 	clk_disable_unprepare(pc->clk);
 	return ret;
@@ -179,6 +188,7 @@ static void bcm2835_pwm_remove(struct platform_device *pdev)
 
 	pwmchip_remove(&pc->chip);
 
+	clk_rate_exclusive_put(pc->clk);
 	clk_disable_unprepare(pc->clk);
 }
 
-- 
2.42.0

