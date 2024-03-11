Return-Path: <linux-kernel+bounces-99405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F708787F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C04F1C21698
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0616360ECD;
	Mon, 11 Mar 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhNN8Db8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0C60DF9;
	Mon, 11 Mar 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182330; cv=none; b=SnqFB/AZqaVqLbjmdpJiLhAfLfhf1Dr5DokVjAcf6oTn6Flghm6+T+WD1j35YOFoWmiWGBRXsAES9GgfbmOfS0qLRT1DuyRxM1TkJVjUAQZsmsk5SeXJ7Ejf7ZZAzsDzH/+ne/h9uz0og4TycHDEviABL1XV7GOjI+iJu2UtFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182330; c=relaxed/simple;
	bh=YEz4yne20Y+PXJLPWPogO6ruSXDx1kKR8hKUaO0QDu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwPA/n/46em/15J/fafNESeEAEwbMbhTTPexXWKJgHaEKUHKl6vy8hvYAy9YknS/dsApxZ2ZU1rfe0dhCQ0TvaLI2BPOj0S5pGYlMNSBt6H5vJL2C+QG1rgRQQvYkAKqu/dKZWs6seaq9BiiircbaDUACLJ2IXD1zp64QwPjSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhNN8Db8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F393C433C7;
	Mon, 11 Mar 2024 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182330;
	bh=YEz4yne20Y+PXJLPWPogO6ruSXDx1kKR8hKUaO0QDu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhNN8Db8xfHpz7NrEXaUVaMHJPCyf5I/csLeJ2kl5q+O8ynZGXVrRza4TR0M5Df8R
	 njS9k8TNaeN96/EXZpCplE0/E096d0LskWLkDtFje2JYB9O2S4cW5N70G00QUyKZtS
	 fjy2HiU8SGEgPNktId0/WdmbN/dYr32790fhJ6KgjdHLGC2ZRlgZ5D+gaRwMuv2qc3
	 PEUggEVkMs6853px/qrJRD48nd0hXBH6sw23vCszxSoBOCPb5+ynpsUrxRbC5tWfJq
	 4hBbQIz+EOnRon9fjCFtUnHuihKSM+uNUmjVRHxjXSmIMyfziPIBgNPNQYN9QHbQ6T
	 2SrZN+zpMpSqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/7] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Mon, 11 Mar 2024 14:38:22 -0400
Message-ID: <20240311183826.328535-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183826.328535-1-sashal@kernel.org>
References: <20240311183826.328535-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
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


