Return-Path: <linux-kernel+bounces-115341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8E889AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA841F34D59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865B1E6F62;
	Mon, 25 Mar 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thuGPc/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CF1411C1;
	Sun, 24 Mar 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320516; cv=none; b=kXeeCE8gpISWB9hxXHrreHtmGuS6o6RxzCIz+Qi2NvGBa75rDlwVWp8ZjQ5B1iNvEi6+CsF87eF9WQ24/CqTsp/uiHu2rMAwSTggwxpk+JEEtXGtTzS0nzmX5FSpRwilmkdUuZZZTBbsZ6AhEC7aPzMpP0AwLDlUu+pFtMHpLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320516; c=relaxed/simple;
	bh=a90TlNcd55CuvJI7AGBcJt7/5SipQJTr/jE8uvYuenY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODrPzWMFq2YBBrbX2P4kkrFI7spPkJe3cFJPTB+pKZOCjkwNCBfoto2tbMU0DZEYG/fza4APDZY2cQ4+OnoyJGdnOU0gwEJk2HCE9p1YcpFK/GZPayZVGVrwLr+XuSN8iMqBD4j5wkogK1q1i6oYuJ4S179KWg/wLhqhyoZfncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thuGPc/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3304C433F1;
	Sun, 24 Mar 2024 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320516;
	bh=a90TlNcd55CuvJI7AGBcJt7/5SipQJTr/jE8uvYuenY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=thuGPc/LgPv2ux2Hifr2J7PYK6X7/HN1nZtRTMjVbq5yphl7Lq8FCCNA7JSaywFaM
	 R6RTj35WNAlEIDXCH6SnGKPrj6PbXRcIwRzI4uJMJQezk89PFVeFYM6tvxppPBRIj2
	 SFY4ce9ndftPtUAiuKWOqUXD/ajFutGNy/XLKjdmKRPaP2wqTqAK7GNneAmONoGcJd
	 bG61Q1oBlVOaXXyuQRpzOKH8ry0X85Lrs0Cyo/R1424f9lYh+S8DX7cKM1J8F8EnEI
	 jh6rYQ/mYf3NMBTzUal3ezCThRd69709Dgpp3Uuu4pMoHdEA/lpxzrzmF5lfmje8HJ
	 r5EMl+Q5Lxm0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 077/713] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Sun, 24 Mar 2024 18:36:43 -0400
Message-ID: <20240324224720.1345309-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


