Return-Path: <linux-kernel+bounces-99422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85B87881C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE431C21701
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D59657A9;
	Mon, 11 Mar 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUGO3WcI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711A6651B3;
	Mon, 11 Mar 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182400; cv=none; b=U2ELXfYiz+DAYaxdLpLa8NwNxdgxTZBzjyZ1TnDM/C5BZle13x76kVEKGrxTJD9IMVx7gaxP/JFVhmjcGqGxnysksGJyvd2PjFkemPHmxIgvWhpxPXu9wvJqLVfoNNVf6u5ochdO1j9fTszHQZcSIseLWXdGX3kPHScx+h5EP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182400; c=relaxed/simple;
	bh=Nolwht7xB4k8AtWq7yscABEu12du6hQAJPByB7bvTj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usKU/ML3PcIyIrtDpfMXyERi9q+pWHURMxutqjornXiqVEVcVC1Qr9X469edptMpHh+bjPFebSb+V2/XFQZKPNGHfP81cAYQJ02c0dNBN+aqCob7EyIw2kOQ6zlctLO1Xu+kveT6D4CCe7faJXKnr6uBPZD5kqLpimXqspvW6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUGO3WcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CAC433F1;
	Mon, 11 Mar 2024 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182400;
	bh=Nolwht7xB4k8AtWq7yscABEu12du6hQAJPByB7bvTj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUGO3WcINuCUl0OK6KPjjS7HUFxj4uLqht+zVESUI+HnuoaRmaOI2NKFZhi/U/ClN
	 3i2gd0b41Op9n3AfNAyO7GV7L/n1kvEsuCe90gNZJtbKEN9EMolwWuzDkfhjzGqT55
	 FJnvmMficAQDy/2oJ/51LXYqg8/t/NHCT+u2GHPS7TJ1TeXQ5zccayRxiAfM8xcj9f
	 38Jn7BdWZMPMdwpW4BA5da+ZSTGEmcsmoNsR+u19o1HNx852O9ced9fdVjimo16LcJ
	 Lw15i6QjYKsO9EWlP2NWsWuukkSCZBKE4NI6zjXdpWmOOTu1TFHPBIwvGjxkvZB55U
	 ARWIcGQQsG1tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/5] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Mon, 11 Mar 2024 14:39:46 -0400
Message-ID: <20240311183950.329120-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183950.329120-1-sashal@kernel.org>
References: <20240311183950.329120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
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
index 465eecfa6b3f0..825fff00e4f88 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -325,12 +325,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
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


