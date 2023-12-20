Return-Path: <linux-kernel+bounces-7056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F581A114
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2101C21756
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533A38FBF;
	Wed, 20 Dec 2023 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="fsIgbuOC";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="CJ77FQKT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7338F8E;
	Wed, 20 Dec 2023 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703082278; bh=3nJY5azeXpwacoa6a2SmWI95bGDplAo5X6yyrstIjmU=;
	h=From:To:Cc:Subject:Date:From;
	b=fsIgbuOCsPqt2uskYUYZh1wJwArRP6uO97NbODoc+qf9AkVTPtj+79/J/mPMUDLzf
	 X+AlAwWPxBf47mSCj89pGu141jLGFIcVPgleMxrC/rLMgpNgxifRi0YiieE+k/zFpc
	 qUxOfQBFd8tjkHmRzO27T1KYQfnx8YTmca82ZeArUfiXsb/e0/v5tgqTOcnadjYgce
	 Y2lKz2Ynn1pCF9qkKXxAHq/vfxV+SA4PmghCuQuobfAg5aO3eI4AEy9gafq7LOjgi8
	 lpWVOURnlu0s4BnCNALzDoXCKQPTNC+KpuQ3FL+9NR4UJ7CWJGtDmsf4Ufm5MCAtEt
	 eH7z9cDskVxYA==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 39D6B1000CC; Wed, 20 Dec 2023 14:24:38 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703082276; bh=3nJY5azeXpwacoa6a2SmWI95bGDplAo5X6yyrstIjmU=;
	h=From:To:Cc:Subject:Date:From;
	b=CJ77FQKTi3a7yYSw14QDo+huocBfxWeIAdaGsdHQQS+UfVhiOgGZPKyb8hzW6PNr6
	 BlOlb/fp4aRMahIpP8qgNMuRbZALcOb79ezlUDY0FYSV/Cz4aTY+eukU53BuyU5HSk
	 s6tlYfVOyWK6vf6R6uNOJ5S4ieUwXiqOIC9HqjI3E92xYEkEavngA0H/ogI584SXVT
	 2SXI91OnJ/lm0ZHy5dFjL7RuOIx4m86LkbYBTBehVp88iQhWxfXWMO9DQBYl/Zup2T
	 pRDykH5Haz0S5TwhdHKIISE89lT07Soq6BmQ+65CHk6bLX7runTYduRMs39Mj09mJi
	 Wpx02ysD7lPUA==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 077791000CC;
	Wed, 20 Dec 2023 14:24:36 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Sean Young <sean@mess.org>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11] pwm: bcm2835: Allow PWM driver to be used in atomic context
Date: Wed, 20 Dec 2023 14:24:25 +0000
Message-ID: <20231220142426.1275052-1-sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
rate changes using clk_rate_exclusive_get().

Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/pwm/pwm-bcm2835.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index ab30667f4f95..307c0bd5f885 100644
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
@@ -131,6 +126,13 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 	.apply = bcm2835_pwm_apply,
 };
 
+static void devm_clk_rate_exclusive_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_rate_exclusive_put(clk);
+}
+
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
 	struct bcm2835_pwm *pc;
@@ -151,8 +153,26 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
+	ret = clk_rate_exclusive_get(pc->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "fail to get exclusive rate\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
+				       pc->clk);
+	if (ret) {
+		clk_rate_exclusive_put(pc->clk);
+		return ret;
+	}
+
+	pc->rate = clk_get_rate(pc->clk);
+	if (!pc->rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "failed to get clock rate\n");
+
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
+	pc->chip.atomic = true;
 	pc->chip.npwm = 2;
 
 	platform_set_drvdata(pdev, pc);
-- 
2.43.0


