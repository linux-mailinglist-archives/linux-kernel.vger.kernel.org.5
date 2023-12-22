Return-Path: <linux-kernel+bounces-9743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7981CA8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82CB5B23E24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE88199A7;
	Fri, 22 Dec 2023 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="ZgoNLsVw";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="VafF22rQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162E18E06;
	Fri, 22 Dec 2023 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703250800; bh=89OZzKPrOWnbF93jHg/V6IGPFL+n8RBW8Lb7Yb5GP3c=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgoNLsVwejtfEEUxarnPO5OUXt7j0DyskEcV3OBW5zXpnMkWOPyY5hfC3SZmwkRNT
	 qf3DpVAzifjqcB1Egh2IhBSW8EKsQr/sM3lPA/RJuZqNKHrIJVlfvIQHQlYrolHDka
	 27IQ2fu6YQmDpiO8foXWGv4MYJHqBCiKwhWYlwIQcZD80hG8QGEdtw3SPjjsXlBe6V
	 8M1C8oMziPR6e5yliA11WzXCsai5Zt8BhSTb8z8ZvLeWirhToONNmoS0i2T0p0BjJT
	 ydYXj8KRBgY1tY1msy8bMGaap/g9q1iQQ1CFfWD3Hj8yrYhuzTdkIStEPxMzZ80tMu
	 dO2CmmN5Hc9OA==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 8C70A1000CC; Fri, 22 Dec 2023 13:13:20 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703250799; bh=89OZzKPrOWnbF93jHg/V6IGPFL+n8RBW8Lb7Yb5GP3c=;
	h=From:To:Cc:Subject:Date:From;
	b=VafF22rQzDieWkoFdDRCISBS3swdw/eEWiMtQBk2d55rgzy1xMQ6vCFNwLNE4M3zg
	 FPUkpTN06l4BX2Y1unllPtAs77d2tenQMPddF7de0IgSuC6zEk4POkn6Ebp/L1UxSa
	 c2BhgeMpg33wqEyIJNf6ZqOCYxm/BCeW8c9kbpTi0XxYGVmNwCFvp1yCtEnYJDYIr9
	 AMDez4kc8DzGUVrrZguvRXbogl7GAknGNO/tdzlNtcirGk1LwvqzApKTrGWeo7FjvL
	 tksiuxhX+MT3YPVZrJ5OJVyMYnxL9wOZFeYYbis3uo+Liq598aRUA8waixyQnnpFHq
	 8fCDDq6oWyP4A==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 1E4971000CC;
	Fri, 22 Dec 2023 13:13:19 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Sean Young <sean@mess.org>
Cc: linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: bcm2835: Remove duplicate call to clk_rate_exclusive_put()
Date: Fri, 22 Dec 2023 13:13:11 +0000
Message-ID: <20231222131312.174491-1-sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

devm_add_action_or_reset() already calls the action in the error case.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/linux-pwm/fuku3b5ur6y4k4refd3vmeoenzjo6mwe3b3gtel34rhhhtvnsa@w4uktgbqsc3w/
Fixes: fcc760729359 ("pwm: bcm2835: Allow PWM driver to be used in atomic context")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 307c0bd5f885..283cf27f25ba 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -160,10 +160,8 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
 				       pc->clk);
-	if (ret) {
-		clk_rate_exclusive_put(pc->clk);
+	if (ret)
 		return ret;
-	}
 
 	pc->rate = clk_get_rate(pc->clk);
 	if (!pc->rate)
-- 
2.43.0


