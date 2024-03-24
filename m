Return-Path: <linux-kernel+bounces-114046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA38888F28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68051F346F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AD91FD5BB;
	Sun, 24 Mar 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4r3XgGi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEA1FDB5C;
	Sun, 24 Mar 2024 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321341; cv=none; b=h2BrAy02HO+EvkTH0/6vmUHJZ7N0m4LC0fXb4AmArv/0GEuev3mL8EvEZIaQDC2MyGsU9wGXu7dk/T/cpHcKhTSjjnFMKEfZXWY4kt23rvOa9KouG/UoGLOChzNjPw6g7ed1Y1YIyNm90Fz8lpV0jxFmW0K+R4LzJqYo6caGRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321341; c=relaxed/simple;
	bh=a90TlNcd55CuvJI7AGBcJt7/5SipQJTr/jE8uvYuenY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Byy7xkDaoIcWLnw9rJ6T01CdWgWaOlFxBobKE0gUyzj79NaNwHkpRZz6Hm95LY2GC4VqAYnyTHYi6CQpL62C2kC2CSSe3BW8cU/ZKdJyPW05cJl3oEqDZINrU3+oYZceLKN3uVEf7u0HCt9LC1zKIXTJMyHUFOaBuH9oGXsV0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4r3XgGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B191C433A6;
	Sun, 24 Mar 2024 23:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321339;
	bh=a90TlNcd55CuvJI7AGBcJt7/5SipQJTr/jE8uvYuenY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4r3XgGieelOL5DuBBYVJISeeh6tWecDijYB//90d5dAIGqAySJfWPXcJlt5b7/U0
	 F41/6u5q2q5v0v/LE9qhZ4DDGr3Jruq8+Z18pOhWOvujSTFG9Jpp3YlZa+eQ3KRsO8
	 W1C7M3SWOjAAffJd7eemdpzGrh9zPA8wuxlxpnQPNBOs0obl1M1NdVwVRhuqCwc8GK
	 0ol0602rfWXIde1YEc0XJSEXv3KVE9xBCPiiEUDL6XR3amVzFB2geLmNrsH408yANt
	 46Tpa8cvJYG2/afm+bRzRKwZU4X6ZQmeu+lm6lStKCBTxAYp7kvYx3oQmWDCrmcmrs
	 tpl4bOi7ujBLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/638] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Sun, 24 Mar 2024 18:51:40 -0400
Message-ID: <20240324230116.1348576-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index ba00ecfbd343b..b41fd1240f431 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -315,12 +315,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
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


