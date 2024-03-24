Return-Path: <linux-kernel+bounces-115168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B29889335
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC272954C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC741C883C;
	Mon, 25 Mar 2024 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJM5+T13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265031836F8;
	Sun, 24 Mar 2024 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324229; cv=none; b=RKWMqNFdKxkMM7CkT/DZ3/py5fPRUrb47jmLfi64JnPdw/NWAIIRHZv7Ar2zKckYG/jPJkX6uM0vntqCUYKP5tNfQsU03X3LRewh90mpkR6ra4y1/0MPCOC9nZ+tiTsxf7VP+SZ0vsjE8VFRZIo21baDPgj1zHM8DH18ucY2Ig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324229; c=relaxed/simple;
	bh=3Q6+nkFmLZ8LSriDKFXBaKSN3UtPPBNDjNc8HitH7HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJ8bS6LkffAdcM1GyD1YCqTgDVWnQ/8PvwG4jwgUkIS454JmEtEPxkmG2k39nMORBDokEwfelwq6H/YPYNMLmVGKeYFlJ70lCFjcmvo3Budd+kmA33XNxckoAv0ep7vHmbX49NMM/GgPKVa1vvpH1XFjyBoMqyWemXBSE2wSfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJM5+T13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5845C433F1;
	Sun, 24 Mar 2024 23:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324227;
	bh=3Q6+nkFmLZ8LSriDKFXBaKSN3UtPPBNDjNc8HitH7HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJM5+T13DL+UuTWs6Nt1JGSuo26Nv5AtPaM8n0Z1IXV5YNaWKQvFyykor7ZNiQYM2
	 fGYXu2pIfC28MmimTLogPJJ9CZWiITzXhHeGtAD+8K1S7wD6SJKgoaIAaILaQdnT9r
	 w9HAzXhDu5O0XHhAKmAtQh2jykIrCuS8iLbt9c7z8wmM9blZwEXSjzgVYNbtk9H1g5
	 eiepPjO36fVq3cqCucCt/JOb10W3yqRPp9CsZGXrfbB5ICSj33IEKwwyUel33sScjI
	 t3xN1jzw1pqpPVIE3rjfCNoR6OHEYr38wAhyvz+O2hvag8BuXWP8FtvrWF5lz7a2GA
	 xyhVJg8lp7DIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/148] Input: gpio_keys_polled - suppress deferred probe error for gpio
Date: Sun, 24 Mar 2024 19:47:55 -0400
Message-ID: <20240324235012.1356413-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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


