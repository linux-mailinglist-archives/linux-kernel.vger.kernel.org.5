Return-Path: <linux-kernel+bounces-99427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5811878829
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EE01C20B93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F89E65BDF;
	Mon, 11 Mar 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jiv/ZupV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75D5A4D1;
	Mon, 11 Mar 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182424; cv=none; b=SSvF+44Xl5DRKwXrWkN5Ew5qXA0HbtzONvVTdNlivFDH3ti7gNJmPpZKnZ0HP0iQRlyJXIxYLXdfkTpl3j1kKrZ3+jZIMqziLKVeXwiIxcm/QuVYeNtoUEcljFEStWEuf/DB14moG8uX7Po2hcQ4n+gGpu19/Tzb7+dnOShutsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182424; c=relaxed/simple;
	bh=3Q6+nkFmLZ8LSriDKFXBaKSN3UtPPBNDjNc8HitH7HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qktS+sW3tx6JiIbrZM83zwIAPpOGqu5hzyBrshopYvVModcRt5H64hDPhACYxxh1jfQp9HuKd6/pcsYNTViLbEpkVA/B5xgOR7d0XF8lvhQQoiIvgZEL3NOhdYT95veJPtcS9D5XSYTgG2Kpc8BqhcgvmZieox+qa/hJPHVMsWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jiv/ZupV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4595BC43390;
	Mon, 11 Mar 2024 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182424;
	bh=3Q6+nkFmLZ8LSriDKFXBaKSN3UtPPBNDjNc8HitH7HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jiv/ZupVP/OvPRa0/WVF8jr+FLsWwVsxhC4gLXZiwM/vcuFjc280pNBIumD54RPa6
	 8DESZS6Y7w616O9Bq0RNkj9n1VFDWQi+CZbebXqel4WQgGatduPQZ+vmfqy4Hg93fC
	 wZUMj84B68qtNASzzojrtAO3/RYNLNRFvlqlZF2SX0x5MYoTglsDRNtC66BEB9n9/R
	 2FkNrnUOjn4sGA5Yned0l7xZXdH0G2dnKyE3hTrlL9r7Ijk0ndX48a1WoaFp/0H1ql
	 wUHcMJ2f5c2wkaAuY1TF+Z3m4E3A94N7Nl5D+GjXmJo/3YVV+8BPv0DQghP5sJrI05
	 oJaIMJFiOVGDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Mon, 11 Mar 2024 14:40:08 -0400
Message-ID: <20240311184011.329314-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311184011.329314-1-sashal@kernel.org>
References: <20240311184011.329314-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.309
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
index edc7262103b9a..96e47b2401490 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -328,12 +328,10 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
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


