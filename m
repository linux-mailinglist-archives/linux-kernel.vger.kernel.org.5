Return-Path: <linux-kernel+bounces-144271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC48A43E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9801F211BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8162813666E;
	Sun, 14 Apr 2024 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbTGLCjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467113665A;
	Sun, 14 Apr 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112600; cv=none; b=QeSm0mTwTspz62SZkC7Uvts8+BAcDyP9rE2CULyRN4u2nyI5FP2rz37K5YLzha4a9JpoZ7mvuewrjUM+zIuxR7+NOxSrXR6+rf+p8KUVfXVbUVfaFNDagAkABo7bkdUgrIxB3t/qJriRZ9U0kWCnRXnI5JqomYNHc9jUyG6m8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112600; c=relaxed/simple;
	bh=gNtUfvCnP/vl7s5KxA50YOmfMZHPc2iETBnBx689Xlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UniYIQ4YzcuP7tlC0N5Cwo77v8CAICR7QrKnXHqY9bDDOvCdVKk/NoNkZNwvYO824deLU2QcVZFzSG7o57fPC2eBrgtA6p+eWHx3sg5eXadKdouZtP4ISQXIpR1Qxac1k3QA+6OHV3PPfO+2HZEYAqaZBPYDsBf8ULnBfkEYuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbTGLCjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7325C072AA;
	Sun, 14 Apr 2024 16:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112600;
	bh=gNtUfvCnP/vl7s5KxA50YOmfMZHPc2iETBnBx689Xlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TbTGLCjjbbtXtfADwb55S9EaehmpaoPrlTjFT+954V5u9bdJ/h6DS2YNuHE+L4HJy
	 O26tuJJ7TpiWFegurP8jp2NoDibbPLNpXYcFTVNLOWIzO0CWBXIPgCc1QEr52oo3CL
	 3nrKPNTygVyi7kJI78oi62UgoOGda91Gj9JYBZ2pLZCFsA4M6XDfeNPr7s6JcYZdQl
	 Cu+/aJkFNwJ8REl28ddt6v6bzg9UrA20Rs+N6DSkrtq8GSWBUa0zqLuS+XjMiev9hG
	 Y/SMtxrfda5RDX7vSMICilsyB1x9SPrqTM/M4z75BJzWRJTTw8FehH7ngKxSItFonP
	 pN1dSHYCR89Ow==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:01 +0200
Subject: [PATCH 03/18] backlight: corgi_lcd: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-3-9b37fcbf546a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=krzk@kernel.org;
 h=from:subject:message-id; bh=gNtUfvCnP/vl7s5KxA50YOmfMZHPc2iETBnBx689Xlk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX13JqTXbFfVWGaVYWEZN4voLC7kmZ82Ga6t
 7wnw09Gkf2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF9QAKCRDBN2bmhouD
 15rdEACLc9kX95QP2hUV2UVUQ48Lmy/qgA2/kFP76bgDcHdSo5tYR9kMpPEMMOirRh4Clj8OjwD
 NcGbx3ymYmUwsXI13fpz3aiy9zqeQ3WXl8rLemR6d+5DJRgTca042Q89noEbL+sKmY0TQDwJ3gB
 +dyKThZwfzhNeHFu03dslmx+yss7EZO2O1x9T/p7r90dJ0aifSlrtgmyUsj529WpT2b0rKJH2+3
 P+M1GTTO2ZqLppKVEJEbZiU7L+gLALH2oCj7Vy5aN4yqM/TGcHrLbEMpg4hQed0FqImV72oQ8zY
 PwV4k8LglNj4znjJ2P0KmINgTbsWzN4s4muFKsCQUHv6AIEwxw20B2TLFV0BAL5GEduigoYrIee
 cpDziLJmImL5wspjy7YPhVEd7zyZwqY70bi647jAlIowzvh5Gmb6HtaQOgFbhCJ6mkW54azFsHi
 eoYIjbsHHI8UtUssrYKKihLAK6DFHNNhpt9sjreBunbDCfKsJTcZv8uouuAy70A89Q+/qz2aJlb
 dJLDgXfrLStk4ccl0Hq3n2D4T8srrjIOMknxKOkFg7QPPO09bpLDE2mhBsrpQ42OD9Zo+oKWyT9
 By5m1ck8gTQEfIqVAboDKMgvkMdOfrO+1buAvtLovHGFEOFoJOtjKSDBvLnhYTdVWDqf7do/fEd
 2/E/Q/qK0X4c1tQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/corgi_lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index dd765098ad98..aad1680c9075 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -380,7 +380,7 @@ static int corgi_lcd_get_power(struct lcd_device *ld)
 	return lcd->power;
 }
 
-static struct lcd_ops corgi_lcd_ops = {
+static const struct lcd_ops corgi_lcd_ops = {
 	.get_power	= corgi_lcd_get_power,
 	.set_power	= corgi_lcd_set_power,
 	.set_mode	= corgi_lcd_set_mode,

-- 
2.34.1


