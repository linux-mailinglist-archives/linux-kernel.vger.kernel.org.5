Return-Path: <linux-kernel+bounces-116242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F98895CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B3E298A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042013C2FA2;
	Mon, 25 Mar 2024 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEEpIa8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96D17F363;
	Sun, 24 Mar 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324018; cv=none; b=gYSSu4kKcqJByYCLi2UGPZjJa/+WiEUL5+RsbqRNr2E61FHuFfx0hb0kw1s0QWh2jPCdM2pzRJIBPjSpfpcMQs4FQryYjw5uWD7Nkl/earBUmRFVeKupRVLiOdHTa+3fLxEaa1AlZ9UDg2kUNQ0+8lv7OwWpkl/KBIvOWW8Vxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324018; c=relaxed/simple;
	bh=Nolwht7xB4k8AtWq7yscABEu12du6hQAJPByB7bvTj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuoVOorJAK7GZruZUb7w9zrtnq3hlWcegFLbF0Xj4B6h6rxOlKGhTJkNdSO8URGDh8Fxe+r3sEjkfiOdrFJEpanzRjcqpD0iUDmJHP/iROGww25D8/bbPlcEXnzUrPDQBFmp6BaLkVjXECg/cPO0lJ8EOmPxr39kM9f6Llcra14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEEpIa8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51CAC433A6;
	Sun, 24 Mar 2024 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324017;
	bh=Nolwht7xB4k8AtWq7yscABEu12du6hQAJPByB7bvTj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEEpIa8lm85S8G/CFah1+DWGjoWdn409/lPbDDGrsr1EiGNDJH/1LAIXkaK0oC898
	 pkK23NTRcG+b9YCmbLeKAWiEJyhbgdiRkWoL/rqtZQkrTFQh1K4zc/Tt2JcRwB+QrN
	 mqIB4vCnWojSSQ5aS5S1S1Hlrvk+ZOkJW6cjmBRgI4aFjFjOIDTYI5coI0IBg79fy4
	 b19trSx6Atb9lCYm/0llUFcPhwJ9K/Kujj5yMdBlbyMj6mN54QeE0PG/9b29k6pdF4
	 eyB9tvr3OUaZ2u/jBsv+rOWZeHT03OT0RsDQK7SK7a6s/K32fnR/KOiEflcOv7rGOh
	 TRav4eTCKI+2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 018/183] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Sun, 24 Mar 2024 19:43:51 -0400
Message-ID: <20240324234638.1355609-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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


