Return-Path: <linux-kernel+bounces-99385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41258787A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6883C1F223B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A55A11D;
	Mon, 11 Mar 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeXSrNa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324185A4C6;
	Mon, 11 Mar 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182233; cv=none; b=jqf2MkPkWnKsS+hrxFMncdISxLAXey54DvdvCYWEhI2Vwd1jXEVl9Xn/MyJbTw39HZdLePQ3uRkT+jZXY8sOTOAXC8sII9BqblNa6VgJHyJ3UHCAEGQDekbreYpDpp8CGp5RqJyfhQj+9cr40H2IvoHH0f8NzjGy22bhYHahoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182233; c=relaxed/simple;
	bh=a90TlNcd55CuvJI7AGBcJt7/5SipQJTr/jE8uvYuenY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3/+RNR2H/XeHJe/enBZ7rdZtyFBVK6TQM75Dk7fMY7FR1cRcVtJXdRmbaDK2LZ9Nt6Uzs7BnNJXtMf+M+xGl8MIY9/dwZOLMxErc6TXa5K0Tvbj0JF3wbZgrs5XHXTNp+K4iNSAnGWLmOA+dJjJlNIZYFJ/ruJX+3bDsuLEl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeXSrNa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92152C43394;
	Mon, 11 Mar 2024 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182233;
	bh=a90TlNcd55CuvJI7AGBcJt7/5SipQJTr/jE8uvYuenY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeXSrNa9KvMFEnuCwREYZAoOsRQwHHgLDppMUqBrGuf7FHWUj9kI6rX3D/P+xwvul
	 drOYqry4ZpQx4tEeLaMBwJVILU7oV5G2JLckkHpxBU6Uv5UXf2NV2lbiiT2oTC9tBJ
	 n4eOOqts1MZeGzPRApz/StHq5Os0HEFNy+p0u+y/POC3c6vsP8g1Uc3fRRlPKteNIp
	 5SWKZ2etoCyc6kjRyrUoKIpYgGR+YLt2HhuknT5qGZVy70WNGP2kzH+Ou9eNFActhJ
	 L2gUkBBcnYAxtDres1AQ6P1+b/9FGsPBzg3N9Q4diFrgirgy+ZlbkCh6n+LJ74/kIn
	 zblztGRiZmK0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 11/14] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Mon, 11 Mar 2024 14:36:14 -0400
Message-ID: <20240311183618.327694-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


