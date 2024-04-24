Return-Path: <linux-kernel+bounces-156370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE108B01FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDC61C2278D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2915885B;
	Wed, 24 Apr 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4YRGvdM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8841C67;
	Wed, 24 Apr 2024 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940507; cv=none; b=GDtPAJCsUj7ysryEDeW71/vJV5OeTiqREKirAp4i0OJ/DkNWuiM0ZjzOJ7W/YTA+JgLuoka/c8091sgnhFL4y3BySs0ZiT4O2MvgftcY5Q0B4qULR1p7BvUQGA3rwGqqf1N/pE0eHWBzfQTvhpQApwZbJU9kOCuFXG1vdDP+CdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940507; c=relaxed/simple;
	bh=wU56o6IRk+w/zyCtQAgmAtO7kC/xHPmjWsXJIiMIGjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCXmSisIA1JYts/MPhuhbPLvgpvlD3ErnhUZUBSTB1kEGtPo3uAs7aGwEl7MSRwdoKNGU/8pi8GDTsoIZZv5aGHgsmr9NvoQzboKRwhgOSNLGlEsiSqyyDEBC0cJcgQwx2Pg/h4DlnaE9GgVl4WOcTaMhyg57e0zr89mIUBPfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4YRGvdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C7EC4AF07;
	Wed, 24 Apr 2024 06:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940506;
	bh=wU56o6IRk+w/zyCtQAgmAtO7kC/xHPmjWsXJIiMIGjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O4YRGvdMrbSSd0h4kc6I4VGBW6GUmq+7POlQDRbMhkDy6tyT3wPAm0U6639BLoDy2
	 pc92NlO3y4PZ7V2VYkaf3pbJbW38GzI4nIjxGc+/gml+nmkH3HfGpLjWjyiMHRS4wB
	 KTK8o0Fy6OafYkVJFTgmws1G10L324yR4magSj8LZEyOZacFtnuzquLpvl0v/9uwAk
	 FDbZ26+k2JbzBhW/08ACSKkkmQawRI+Xyi6hS81DIMNx69ypi5FJf28sjrfPUnLfu4
	 wHWLR8LbSlHEFNyOJ6WaeZDeZCHef7srirYe73xrtDArKsUWMnQ7qUbsv+lGOOFbZ8
	 NTcXj0VkFfaYQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:32 +0200
Subject: [PATCH v2 06/19] backlight: ili9320: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-6-1aaa82b07bc6@kernel.org>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=krzk@kernel.org;
 h=from:subject:message-id; bh=wU56o6IRk+w/zyCtQAgmAtO7kC/xHPmjWsXJIiMIGjI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfi7SUmzEwFhDA3Gu4Na9Y/v/mgYOlvJtevf
 5MvxP4khJSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin4gAKCRDBN2bmhouD
 11YaD/9DWrDdngpRk03vWD8VsPY9N5ciGuLjx9uJTxNIvhRY+S/6GcCx0xFTCwnd+nuju2cigUJ
 lwo/1w51zNFSMLGcT7b7/n5ojfSSJg9mWHbdK2iKqlMkV4Oj4rjraPeA9rDgq4QaKX8ZUT3elmQ
 NVTTVF/HJuuySHnBmDnIAsEqpj+iKZmRjOpu8UFvFaZdFyf4YHtbCkcXmNktMOyvExnbiBf6dH1
 /1UyXPW+weTiRUbVhDfnxJWl7YgwjhSpZzodh8Tv/PvuSc8EsT4HmEexJMX4jbvIjFCs9t6/5lh
 8nPKK+5lCQBPeucbs+W3hJvy8ihWerEhFY72leWx25436STy0ZWN0wdVEEzTEhLAyV1mxYP6kDg
 NnYyuwEP5YHBxG1FtMR+LM7jpi1bL5k7o56s4YVw4FM5vXtAdL1lVS2YEw1BlldLKnTSs/vbKXp
 pJNYXPhn3nKfE9kf1Bwz0CcsqWFGSRKuMmiJbv5P04iUYPS7navT4z7JC9WbtBTC3zUmuXy1vUT
 d28OG0cF/xrQMIS9c5JBDvdd5I9HoIFopT7/vJBkJZmiiHVKnlKYKtbdaIVRQcc5ip9Z7v7zKqc
 14JAwE6u2traRH4NkQ5+jTcoFlTlpq6vAsMWeSxOZTPZ1XP0YFp8pySa/JItg357kCZv3b0x/MO
 gtbyed329RfSc2g==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ili9320.c b/drivers/video/backlight/ili9320.c
index 2acd2708f8ca..3e318d1891b6 100644
--- a/drivers/video/backlight/ili9320.c
+++ b/drivers/video/backlight/ili9320.c
@@ -161,7 +161,7 @@ static int ili9320_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static struct lcd_ops ili9320_ops = {
+static const struct lcd_ops ili9320_ops = {
 	.get_power	= ili9320_get_power,
 	.set_power	= ili9320_set_power,
 };

-- 
2.43.0


