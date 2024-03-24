Return-Path: <linux-kernel+bounces-115789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE48897CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1F129D2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513826205B;
	Mon, 25 Mar 2024 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp+72O3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A414533C;
	Sun, 24 Mar 2024 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321982; cv=none; b=Mgw51c8fRhLryon0GdFz2/DpoIhEGKm1CUoz0DjOh9dWnUrveJkYlJUGRX/BLYh9ujj3I76YdUV5oa5k8f3ToDZQWV/At9ZsoTnGXLE2KH0Zd9XN59HIfsknPphBXJl87NeyD0H+U1qtefje+lF9ocOfFt6mTFqIdFV7QtxlWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321982; c=relaxed/simple;
	bh=YEz4yne20Y+PXJLPWPogO6ruSXDx1kKR8hKUaO0QDu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNLDX0iVWvTVLd91kii76WUbXg2X4wRCSW6KPX1XWKYemO5KF+x3pVtwd9YwRbFZ/p4JUErB8nUlNzBFbpPnPRhsgI0+QBLYrMZDjTNK+kUpcbJTf/XL5XpqmQelg3a0JcRjX+Y4gA2AWBDnM7aJpT2W3uTcHz/Ef4LwTm0oaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp+72O3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9FBC433C7;
	Sun, 24 Mar 2024 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321981;
	bh=YEz4yne20Y+PXJLPWPogO6ruSXDx1kKR8hKUaO0QDu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kp+72O3ehbx2ec2ZvUYcY3reRlh7EdfLdgRBtpIksUEGPRAJe4rt96Cswv402E97E
	 10GBSx1N8SM7SEV17MouYcmKbGV1MQyfMsJQz04fOzuk9fQSmyecehHUQ6WR/9i/uV
	 W/J+1t0FCcv7iAUmQRwOejWv+r7B64He9Bc+IOS9kTeXww051aC7XgdXscGstUwG6Y
	 +Y8NakBIwHyj/u95RsMSngNXVGaSAWVKWz1PMhMvAK/UZFL1GtunHIijNHfJ6hOhxN
	 /4p4IzPLpsbIYSXCNtBD0ML2IJEIoLqqbodVGJcyLgoGx/IsWeQEnDJiIWZgWAccyu
	 Po7XlQi4rddzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 054/451] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Sun, 24 Mar 2024 19:05:30 -0400
Message-ID: <20240324231207.1351418-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 963465a33141d0d52338e77f80fe543d2c9dc053 ]

On a PC Engines APU our admins are faced with:

	$ dmesg | grep -c "gpio-keys-polled gpio-keys-polled: unable to claim gpio 0, err=-517"
	261

Such a message always appears when e.g. a new USB device is plugged in.

Suppress this message which considerably clutters the kernel log for
EPROBE_DEFER (i.e. -517).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240305101042.10953-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/gpio_keys_polled.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index c3937d2fc7446..a0f9978c68f55 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -319,12 +319,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 			error = devm_gpio_request_one(dev, button->gpio,
 					flags, button->desc ? : DRV_NAME);
-			if (error) {
-				dev_err(dev,
-					"unable to claim gpio %u, err=%d\n",
-					button->gpio, error);
-				return error;
-			}
+			if (error)
+				return dev_err_probe(dev, error,
+						     "unable to claim gpio %u\n",
+						     button->gpio);
 
 			bdata->gpiod = gpio_to_desc(button->gpio);
 			if (!bdata->gpiod) {
-- 
2.43.0


