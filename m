Return-Path: <linux-kernel+bounces-156365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67A8B01D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0286F1F2360C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C22156C53;
	Wed, 24 Apr 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBJFB4ee"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8036D;
	Wed, 24 Apr 2024 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940476; cv=none; b=MHqAzRsnIcwU832gdgtYXsn4diP5WKUtlPcAPtwuH/MG6XoIEoJwMpFTaH0m73hjRogdOXt0o5gFt/kXDNtDwFgThogemcyNNCc9eRdCUxLmhk/XUxF18cnxGtVk6H363vCnsjg8FwL2fEZtUp2kUvfzmAs3a3sosH/bUTA7P0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940476; c=relaxed/simple;
	bh=I0CDR+UQx8pIKK08mZpMwJPZrKmFX4+NzKjWxZIyAxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDE9ettY1rM5TUGHGzYxG0/4x5lgfCPj9fEd0+APpnYeApy+sfcqsiOWIKrtBl6MSmqCLfrmJljIKJ6Zq9sumi2MAVV9/7JoL0vIH0cBmkLFsmUlGUOIoRplv2Ai+8hZjYOcT6QGnjzktjguiyh8c75LIucTH3asjH90H3398rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBJFB4ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F01C113CE;
	Wed, 24 Apr 2024 06:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940475;
	bh=I0CDR+UQx8pIKK08mZpMwJPZrKmFX4+NzKjWxZIyAxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QBJFB4eeLiwx6Tk0ZFRvPcqclvVhyVA2EwZfNQSyXujJ8QtJD/n475SuWDEASe9bD
	 XMZ5Z2vChp5bVOhPvB7GLWWJ7zTw1Z5UnBt2sZIcPcoCNOfl+x6IFU8H2Fih5BDX6u
	 dVfpLJ2RU+9VGQy1Xr+yZf3o1NuXDCXfdNLb+/IcVc8cPuBrSMHktl+WluY+dsw7RA
	 cJKAndzVhW264t+z9juKA0UiEZcXOaMoPw6A0tvpn+Q2o7ahErjYbkcm1k39goL65s
	 SGmt53gd5Ss4UQVLWL5skfc5PuZhayItc58+I/lAkaCHLsBGBRcZ/KP7Bv7qKBFVXw
	 v97NNQBQCHYcw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:27 +0200
Subject: [PATCH v2 01/19] backlight: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-1-1aaa82b07bc6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=krzk@kernel.org;
 h=from:subject:message-id; bh=I0CDR+UQx8pIKK08mZpMwJPZrKmFX4+NzKjWxZIyAxI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfeToXpF7L2yVN9k2sqZfozve2s4THf0Vo2R
 epNlzurbF+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin3gAKCRDBN2bmhouD
 19p1D/99+NJcxUjp5prNBS/1AhHZ7jpcTNsKZmpAaP58DryULCGl5CfY7sVAD0rs3R/AnzX/+p4
 K64AwvGNoyqke7ajX+ZHzin8hbv8N+9C/iil1xQCl0VDFMYe8M/rplcsBp2fYe/Yb47R/8CZkmg
 WJ3+jNA3rifj9dWGXV4pMUfLEgW1gpoPNmCUhIBa3pBacJUetd4RuBgIg4jWcUT1OugVlz/H2jM
 TKgrDRbS8HsrA8s8bU423MeunN2T9+vgeOVbUtfZMZ430Fw66qm0wRQUVdyxdCWe7JDEiGA5CfL
 3lX7PProDKUMmvFLsj1kVeGi0HQEznRVIck2RrTwx+Ff8QKPXk8KKOTBHiKjrKmVErFuLg/EZzg
 bupLP1D7A4TTmrXZfHgPmlx9W1614sglt/194qIPrLe76HeSX4o4r7xEYdgOre7Y90Y+wfGyG6M
 iheqT7BDxETuYD4Y5MRcCUnTWX4fDupaDhJyruDQl4OVA6CWi6oKMAMpMf17NpHOoVpx+RM58n/
 7NLfOwkSHP2ORpqsofr6EWyxnv+/2YnS0Qj94hh136eZLVOCNA8E6HMiS8AcoYCDwWLPBpwd9CH
 3m9CRX9Am9eJa2D9BquLDAGS72/UAnrXBuVoMZNj9CEToM9aDym6N7DX0EW6LgbTRWl9KPYju+2
 KYXG6toKDyMZMkA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' passed in lcd_device_register() is not modified by core
backlight code, so it can be made const for code safety.  This allows
drivers to also define the structure as const.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/lcd.c | 4 ++--
 include/linux/lcd.h           | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index ba4771cbd781..ceec90ca758b 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -191,7 +191,7 @@ static const struct class lcd_class = {
  * or a pointer to the newly allocated device.
  */
 struct lcd_device *lcd_device_register(const char *name, struct device *parent,
-		void *devdata, struct lcd_ops *ops)
+		void *devdata, const struct lcd_ops *ops)
 {
 	struct lcd_device *new_ld;
 	int rc;
@@ -279,7 +279,7 @@ static int devm_lcd_device_match(struct device *dev, void *res, void *data)
  */
 struct lcd_device *devm_lcd_device_register(struct device *dev,
 		const char *name, struct device *parent,
-		void *devdata, struct lcd_ops *ops)
+		void *devdata, const struct lcd_ops *ops)
 {
 	struct lcd_device **ptr, *lcd;
 
diff --git a/include/linux/lcd.h b/include/linux/lcd.h
index 238fb1dfed98..68703a51dc53 100644
--- a/include/linux/lcd.h
+++ b/include/linux/lcd.h
@@ -61,7 +61,7 @@ struct lcd_device {
 	   points to something in the body of that driver, it is also invalid. */
 	struct mutex ops_lock;
 	/* If this is NULL, the backing module is unloaded */
-	struct lcd_ops *ops;
+	const struct lcd_ops *ops;
 	/* Serialise access to set_power method */
 	struct mutex update_lock;
 	/* The framebuffer notifier block */
@@ -102,10 +102,10 @@ static inline void lcd_set_power(struct lcd_device *ld, int power)
 }
 
 extern struct lcd_device *lcd_device_register(const char *name,
-	struct device *parent, void *devdata, struct lcd_ops *ops);
+	struct device *parent, void *devdata, const struct lcd_ops *ops);
 extern struct lcd_device *devm_lcd_device_register(struct device *dev,
 	const char *name, struct device *parent,
-	void *devdata, struct lcd_ops *ops);
+	void *devdata, const struct lcd_ops *ops);
 extern void lcd_device_unregister(struct lcd_device *ld);
 extern void devm_lcd_device_unregister(struct device *dev,
 	struct lcd_device *ld);

-- 
2.43.0


