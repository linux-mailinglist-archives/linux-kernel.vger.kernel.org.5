Return-Path: <linux-kernel+bounces-144276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8AD8A4405
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38D52813C5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C8137764;
	Sun, 14 Apr 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOOC5Ont"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8371353E1;
	Sun, 14 Apr 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112625; cv=none; b=FnEwDpV1MSo/vRbIIwDIOYdFbbSL2Jlr3YL3GWGc3tVtECb6GSyeZtlW/hMqWy/YP6Rmrp33n2INyUwd1vO3EiN+S+KC1BIaZA+dysP9rhgmRAYnyS3nkc2oDyXtMFmNwj1vHlFCdqPs1yoJLg7xVlUQW6LCwqT/Sj66GkSXePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112625; c=relaxed/simple;
	bh=YPzrDayne4RsVvwgv+6Amz6T/hPNpbOfbV29tRkK+J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOhl9AyqP92k7thRRQuwRFTBQ2Ut9j/bIvcnWacCm7EhuWDyQjOE/Rk7vMAOZpcRFzMNWTrEjT17IPb4UfT1EV9aspJ9ILBCql4IWDTrs0YHqkRxwgD33oJtnN9qrL7aoll/J6JXIekAWezYd8RNPh5Dp2Tv6E/mYr8Gkw1pcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOOC5Ont; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161F9C2BD10;
	Sun, 14 Apr 2024 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112624;
	bh=YPzrDayne4RsVvwgv+6Amz6T/hPNpbOfbV29tRkK+J4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WOOC5Ont5LDbeveY1rWMpV/B4eo9u0qhC0DiseQeuSnr9mS8HWXEzcrg1yM/zwJ8A
	 Hp2yOH03ZGLwy0Awwa2cgdCCuNrzMft8pSKHZP7FEdDqAw3PC9BYMoaTEqYSSzds7I
	 Csc3BozrAJ5tS5Sip69P2PzL8pBLR/yEMHyZiDg5/OTFR7zTZH/duuDoj512vRGQNy
	 9QKOZwobNyXmCePZ8GfDT9YZuWjh24wC2dlZph/pSq1UW6LKMpcCiE516LxO54QYxm
	 qBBh1hvllwVI/L4mv6b+JSJy7/TI5k4gkjPq+XzO0+dk8YBxd2ZPIX05urVQUZ15ud
	 iogfjO/gVHqnQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:06 +0200
Subject: [PATCH 08/18] backlight: l4f00242t03: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-8-9b37fcbf546a@kernel.org>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=krzk@kernel.org;
 h=from:subject:message-id; bh=YPzrDayne4RsVvwgv+6Amz6T/hPNpbOfbV29tRkK+J4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX5+G2r4LHJsJWz/AdfA9TXepPdHYib8tDLf
 NkIDcO22GqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF+QAKCRDBN2bmhouD
 1/LKD/9VWjfNPWPT125xSZyzNAAkWwa1XpfFmw9kMbYwZXaaL+DSmFpJSbBGFn7KSp3nyDQLlmy
 YKCulZJMLmFMcQ0XQyTTZnlTLS/TxrjKqbi55mGJ6IOKwqDnqyekHpcZgrVGyyuZBbV9ibilzUU
 BsCB20lUn1qXZ3Igk+phQmEv1OzfhQN6V44uoAmiTj/IW0o28iNW6G2SWBX3b4HiLhv6vquqHAI
 6u5++V1d3TNqBs4nWy95JdchIqVAd5u+EgCC+3M//c/AbLNdJ7nQlqZ9oE31cuAhLovB6VL5Lke
 iQJD6pUfLs5UUVJCZowUbHjunADEgAY29AInndLpn9S8VmyoWWCC33v4c2SMLajz/3pxEpxm3If
 7ApIB+KRFZ+21zt0uDxchqnEEd5FVIM+ulxi7HSiTjgjLeN5DBGPlSFjNm6QllGQFZ+1q2caMMZ
 eZcZPhfSv38aAGie8sgrrtPUQt6NrtcFcEeulKnJN5+ldxEAz1ogGj+ccbdYiRWejGXpAgk2OC0
 QTypNgYJo38zrZqNBKem8jWkwNRvA288D6tYXj3PnCAPobUkWxc3cvCq2pue9v9XlgZ5/NsOHtP
 z2d1pTDtY25H/5J5/FJVj8+tSA6Fnc2U2SG3kkc7dgMaVVzX8XH595u7m9SV+Sj+MjfqfH1jLE3
 dISSCZSKXV0lKmA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/l4f00242t03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index bd5137ee203b..dd0874f8c7ff 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -158,7 +158,7 @@ static int l4f00242t03_lcd_power_set(struct lcd_device *ld, int power)
 	return 0;
 }
 
-static struct lcd_ops l4f_ops = {
+static const struct lcd_ops l4f_ops = {
 	.set_power	= l4f00242t03_lcd_power_set,
 	.get_power	= l4f00242t03_lcd_power_get,
 };

-- 
2.34.1


