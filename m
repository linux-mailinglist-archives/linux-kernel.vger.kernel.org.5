Return-Path: <linux-kernel+bounces-156379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7B8B0224
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F68B23C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334615920B;
	Wed, 24 Apr 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ6xIdW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5959A1591FA;
	Wed, 24 Apr 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940563; cv=none; b=kpiDCS6f94PgWrXZxoThYA5NsrBT6cK42ZEwGrSZ4Ln6FteIrqi/I8ZFkw8aZiLhfzYsGR0Nb0X15LE478BRPuyF3dXli+Tx6UkAruBFFfC9c1AXYEywQzsR6C2ey3ECwXHIosy7/UbkVWEnXKSKmQApmDjE2x/ES1EkopJXXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940563; c=relaxed/simple;
	bh=vOCgFXE0yZtrMeCN/DmcJGN2jbuTcHFP/HtJfH739cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfjytT4ny73QUg0s0OBmW5jubMlnuVFkPaqH8qtkfUp0FfuQPtIi0YDvzVNt+okul/VX0Vp4sZH/ShRkDCtvV+d4RzDHBb28u0yBguPlulNh28cYiKQ7EOiWLvNP+1OBHBEJTiFzZXvXQ8nNFdbDwPnfwZA3ombv/+AHU4hJgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ6xIdW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B8C113CE;
	Wed, 24 Apr 2024 06:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940563;
	bh=vOCgFXE0yZtrMeCN/DmcJGN2jbuTcHFP/HtJfH739cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZ6xIdW3H4qldDXElBNvIpjA80XivxCnNEwvb1nqQ1Lmsm3r5l9t6QI1lEY+4jkg9
	 zFm8bpiz9k9EnztfU51sUq0iqS3lp4XmKDskoa/TuTO4qQgj4+hrQEjJxGeGMwaR+t
	 H+Tg9Hzmu2CaxMJGl+QL7kWUZVN057SFR4kxIV4Eet0YeWDPQxGaliSyDwLL7KPz20
	 JqpzSQ0x4YkKWLrSvm/ddc/jZN/t4dD9zn1dZSG0owYi1eqmKtCJ/PHMmifjxYYHgc
	 mwkiejg82pco13UrjhTiv/wcRvfcMOJmZ3TN4Bb2Re09iKiCVGITp7Qx4zZcDXj1GY
	 asroXTakL3Xgw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:41 +0200
Subject: [PATCH v2 15/19] HID: picoLCD: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-15-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=krzk@kernel.org;
 h=from:subject:message-id; bh=vOCgFXE0yZtrMeCN/DmcJGN2jbuTcHFP/HtJfH739cc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfq4M1IDJPlPFMkIXlVPIEqNDgxTDlWKP8ND
 FrU8RWlF9aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin6gAKCRDBN2bmhouD
 1/N4D/0WVW8jUjibDXsx8n2ptJVAi3ksr8AEwnSVXriRdjkWTmuFQgyDS+D6O4h0tbeNHlR6onO
 KGMgPoa8V6ptLHP9BU0icb2AgC4D9Kh8q+OkjfvfQzaAudoiyEVHG9ztnyq5qxl+AhOBWvmi8wT
 vmMYcToLDq/W+QsSe9mlRXAJrQTlF6V8kWo6yUHh80ANHEJH6o8Ret/wz04WXFJz3VlVCGPSwaV
 iKgGVP3HOzosrJU5tDq0ucAUbHnykIh6BZhYGsUH+Asr+S4i+v2VlaD2FPkJIWTmEJgIvBBfyet
 XklLq6y8iLRl4GfOkU78HTFkSxTftPz1/5e4unxcMYP53jfWgoHYwWNoLWxhY4UtSjpNMne7/za
 8Z+0+CkqHAbylhE8WZNg9DGsXTrI7V3G35JjLVETvCEkDBvPrNopn79LKKRzO2Ma38px+20z8ri
 u3Vbgsxn3OpX62sNaIComZ9U7JnigtjrRz4MjR1laKEbHRpk2THeV6W+1ec1M9OHWTPfHShNBuM
 7wS8NyXRAHov5RvAE9OzuRwMMMLk7hPefhtdDBK7goKDuQAIzumwLRBOP7tyaf1MkHmnTUfwKEC
 oo3dP4Jlf+M0js9uJHJINT5J4cwD/qdhqlnJNVEeENiXW9PUl9/rhQgMNRcEKxP1ikkdksx9TSO
 VH0W6ULF+Aee9Yw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Reviewed-by: Bruno Prémont <bonbons@linux-vserver.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Depends on the first patch in the series.
---
 drivers/hid/hid-picolcd_lcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_lcd.c b/drivers/hid/hid-picolcd_lcd.c
index 0c4b76de8ae5..061a33ba7b1d 100644
--- a/drivers/hid/hid-picolcd_lcd.c
+++ b/drivers/hid/hid-picolcd_lcd.c
@@ -46,7 +46,7 @@ static int picolcd_check_lcd_fb(struct lcd_device *ldev, struct fb_info *fb)
 	return fb && fb == picolcd_fbinfo((struct picolcd_data *)lcd_get_data(ldev));
 }
 
-static struct lcd_ops picolcd_lcdops = {
+static const struct lcd_ops picolcd_lcdops = {
 	.get_contrast   = picolcd_get_contrast,
 	.set_contrast   = picolcd_set_contrast,
 	.check_fb       = picolcd_check_lcd_fb,

-- 
2.43.0


