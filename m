Return-Path: <linux-kernel+bounces-114740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2064889250
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E423CB279E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F7825B328;
	Mon, 25 Mar 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6J92zaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536D273D91;
	Sun, 24 Mar 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323328; cv=none; b=qs1TfnWwtWOvxsqQxlGHpm0F/Cdeo/PGbssm+XONi1hdJBwqNJqL4AfZFGAqFamPOeTOal6eOiuUjG60ZJc0uQzNO8ezARhEBgImE5ZfxL29vJ+ae/v/NyL8xl02wsV/KX5bhBkPcDkSNFbtIP6ZvOcquxSWfQ8uvQDkEQ3rdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323328; c=relaxed/simple;
	bh=YEz4yne20Y+PXJLPWPogO6ruSXDx1kKR8hKUaO0QDu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LglATiX+7nf+eMYcslDczZ/+o2vT3f5IITcWeZ6NOHLLngP/DUTCG7sYNJHkYUEiJAySjpY8aI2yAcPlkfb1jl3Sh0X0MzVcrWkEM7Kgk17XnwvlsL1Z7P2mhzSWi/cBbizmRBpMoVavc6Qit1gYvCi8zM8JIQIvnhIrL0J5WGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6J92zaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EE8C43399;
	Sun, 24 Mar 2024 23:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323326;
	bh=YEz4yne20Y+PXJLPWPogO6ruSXDx1kKR8hKUaO0QDu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6J92zaw9HIpxsd0LShI1rqs8fkvmp13IuGiFWJPy1PHHpaoRMK5foH1m06vIGjMR
	 0+CDH4JCmlv0jPiMYzK2RSD27PKuzPuArftZYghti/SisYcbQKHTukRNAaqvW3VNy+
	 LqEQDgKiNz1hE/u/3fb/Q6cen3s5xbe71EhynWK0m7j7/DLa6KS/G7HY9Uz05e+p7Y
	 sEKLuxwn8BwvKaJkWitrKxkb5tOEXKgCYHqejmY4MeWpwUUt/vJi+lOWKcA6wqXFKE
	 MsH21GK5U2tKx80WCh5H5grZJ7FjdPv40jOgnNUzMS5EieOvHIVGRcsZ1EJzKx7Ui/
	 qcXarbPeSJtbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/317] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Sun, 24 Mar 2024 19:30:07 -0400
Message-ID: <20240324233458.1352854-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


