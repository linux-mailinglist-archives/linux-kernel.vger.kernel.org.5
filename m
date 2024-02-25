Return-Path: <linux-kernel+bounces-80203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A4862BC5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928D61C20E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048291B968;
	Sun, 25 Feb 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRNgzJVt"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F591B952;
	Sun, 25 Feb 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878620; cv=none; b=DWfQBvzuVUyhFJWiBqGyfYTzskUYOzqzng4+NgCyenSa8KmN4Afxq9Che+eFHAnhqfIm3GCmN8zjQPFX40Ead9irYfPbxp8lKEd6rJlko4sGxCSzzVOHyZarFKP1/D2imy9rPBgpIAzxXVIcUecahSy0E46b2QD+iHlD1MNXmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878620; c=relaxed/simple;
	bh=aGWDkl0VRtjUH4DVSrzqDOTU++PRn1TEKNwyTCV6XsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFsNVRfaxl/UFptsSeFFEeWKDDbgL5Tujs4fESh9OkPHtJvanME6C41vRJxQrFPw+gWS1yP2uiYzybpGenuTSExoPYsYoQHWHDsutclhp5Yu6KFrS9jMJGycTdyVLelU8vRLj7nA9PpI8cDPlY3QAiSwBhBnrQukFaOSYRlozI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRNgzJVt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e4de4fae2cso1328261b3a.3;
        Sun, 25 Feb 2024 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708878618; x=1709483418; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TId9cCS3A8DzD3QTIhlXdJucUWK6LQfPWKtp7ssfcho=;
        b=nRNgzJVtH4Dy1Ybomy40BfgyqjA4luiIOZQA77YGUBdxkg86fxI6WN+5yr/LGgDZwK
         BnEhhhtlI6HcZka6hWLptjD5R69x/Lduf3xuwD9zFFjRFaTbqGt8mmmokX7L3bLf/jGV
         Ew4PbR42eLLp7X2xuTGBz/FrVA1eY5KzcyqXZygPBboUzYmI1+0pXW2qz2RpL9UnOwrt
         EMHYVDGacwOzdQxeT0H0JKcxVlGH0WOF9iqJYigPznaZtj/3DeFx8hUD7T1pm6oRGBf8
         MYPg/YjnmQ8/G6/VS10lvR+uHwWgL6r/GQhrHgIa0zB3uhKn7pL/TdK8OEHihPAlcwLw
         IhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878618; x=1709483418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TId9cCS3A8DzD3QTIhlXdJucUWK6LQfPWKtp7ssfcho=;
        b=sWGW4cGwkuhCJLoqVs63gqyqmfQUeiIbKFyDWo1RZDRQcyBoc7gJ8h+gcYzKihlJUz
         zFiZ2kFZmKNRC8IYgW6kZ7HKU58nacnN4+CaFlbB+lnJGsg5Ab2ID1+P2qD6XgxLFMSM
         H4mC7ZgXN/fJo+PE5BsDrb5F3ArqjOVlqg2hEb7+86DqbzPuXcPDn+PqpOBboNBl3qrq
         bLHG2bjgmx1Om+e0U1VjKAyqLKtNf3b1iYt1kZBDgFWQ5NUA/CtC02edZcbBL5KJpYgY
         xZROBMozouJmCE/uHAphOz3COjwDPjvd1OrcpgzehqD1yWfMJTGxN6ueGoVMxdWFXqIH
         dN7A==
X-Forwarded-Encrypted: i=1; AJvYcCWf5355ZYD0/bzMKmfzRwVB5V3lBnhLe71T46hfaYiB0cVcpv6qN73PKgF1VekQZE3S1LETa//TZFgEY7QGEDGe4W3vA3P7sLEHxNwou0hdrohRoRqe5d9Kga1p7/TTP+Jy/dV9gdlX3w==
X-Gm-Message-State: AOJu0Yz6khaeH12X8hg6VPQwXJwmPoZmn6kz2bsIOrBJjPY9CNOKV0PB
	QVVnBFu7V3OZGv94qgvgEf80yvDwnUaxXKGYRifcAE9den3ANqUj
X-Google-Smtp-Source: AGHT+IFCOus17MZvuTa65D5oy8sSkk4x9Ymnv0HwhdN6PvdAgw5kJGudtmL8cwlBV8rwWx7nOoG04w==
X-Received: by 2002:a05:6a21:1014:b0:1a0:e86d:ee6a with SMTP id nk20-20020a056a21101400b001a0e86dee6amr3616045pzb.20.1708878617870;
        Sun, 25 Feb 2024 08:30:17 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090acb8c00b0029a4089fbf0sm2838367pju.16.2024.02.25.08.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:30:17 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 25 Feb 2024 13:29:55 -0300
Subject: [PATCH net-next v5 3/3] net: dsa: realtek: support reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-realtek-reset-v5-3-5a4dc0879dfb@gmail.com>
References: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
In-Reply-To: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4254; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=aGWDkl0VRtjUH4DVSrzqDOTU++PRn1TEKNwyTCV6XsU=;
 b=owGbwMvMwMG4W/D2rovs1mGMp9WSGFJvZ7OaabhY9TKm+G74qRF5119CWjDkkvmFmKkJ9mHN8
 Y+iPA92MhqzMDByMMiKKbIIsmu4t56NthL6pf8DZhArE8gUBi5OAZjIwgwOhvY5vP7l2S1bZzfu
 WyoSNzlDYX/ZjYxQuV/fvp7x+rNiZRXH9gNrrEsbDAxELPK+dma9nNhRIHQ9tObyIrX4hiNMUhO
 /r91x6tTEb9cDYnmPhNZE7WpiS27Lkjvur337YFXPlHeTLvm4hG5RzUlmfP6XjUGL89vSFvW7D0
 rCV9m7y+58Y/HKI+md/oLD/BLFPs0uus9XLljGesXxyRd7vfnqKZXGXzSXOLzi/cM62ZLpxy2vk
 hrxTzIxD7d+F1PKTHwwYfnM28s2fWfa/8fv1a6FoqcYY4s/Nl7TN8mf+MhFJjRf5pfmRan6U+qv
 2YHGbPxZwL9Jaeq78+uXp1vL5kd4XzRRtytcHdl0z0obAA==
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Add support for resetting the device using a reset controller,
complementing the existing GPIO reset functionality (reset-gpios).

Although the reset is optional and the driver performs a soft reset
during setup, if the initial reset pin state was asserted, the driver
will not detect the device until the reset is deasserted.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/realtek.h |  2 ++
 drivers/net/dsa/realtek/rtl83xx.c | 42 ++++++++++++++++++++++++++++++++++-----
 drivers/net/dsa/realtek/rtl83xx.h |  2 ++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index b80bfde1ad04..e0b1aa01337b 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <net/dsa.h>
+#include <linux/reset.h>
 
 #define REALTEK_HW_STOP_DELAY		25	/* msecs */
 #define REALTEK_HW_START_DELAY		100	/* msecs */
@@ -48,6 +49,7 @@ struct rtl8366_vlan_4k {
 
 struct realtek_priv {
 	struct device		*dev;
+	struct reset_control    *reset_ctl;
 	struct gpio_desc	*reset;
 	struct gpio_desc	*mdc;
 	struct gpio_desc	*mdio;
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 801873754df2..d2e876805393 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -184,6 +184,13 @@ rtl83xx_probe(struct device *dev,
 						    "realtek,disable-leds");
 
 	/* TODO: if power is software controlled, set up any regulators here */
+	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	if (IS_ERR(priv->reset_ctl)) {
+		ret = PTR_ERR(priv->reset_ctl);
+		dev_err_probe(dev, ret, "failed to get reset control\n");
+		return ERR_CAST(priv->reset_ctl);
+	}
+
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(priv->reset)) {
 		dev_err(dev, "failed to get RESET GPIO\n");
@@ -192,11 +199,11 @@ rtl83xx_probe(struct device *dev,
 
 	dev_set_drvdata(dev, priv);
 
-	if (priv->reset) {
-		gpiod_set_value(priv->reset, 1);
+	if (priv->reset_ctl || priv->reset) {
+		rtl83xx_reset_assert(priv);
 		dev_dbg(dev, "asserted RESET\n");
 		msleep(REALTEK_HW_STOP_DELAY);
-		gpiod_set_value(priv->reset, 0);
+		rtl83xx_reset_deassert(priv);
 		msleep(REALTEK_HW_START_DELAY);
 		dev_dbg(dev, "deasserted RESET\n");
 	}
@@ -292,11 +299,36 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
 void rtl83xx_remove(struct realtek_priv *priv)
 {
 	/* leave the device reset asserted */
-	if (priv->reset)
-		gpiod_set_value(priv->reset, 1);
+	rtl83xx_reset_assert(priv);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 
+void rtl83xx_reset_assert(struct realtek_priv *priv)
+{
+	int ret;
+
+	ret = reset_control_assert(priv->reset_ctl);
+	if (ret)
+		dev_warn(priv->dev,
+			 "Failed to assert the switch reset control: %pe\n",
+			 ERR_PTR(ret));
+
+	gpiod_set_value(priv->reset, true);
+}
+
+void rtl83xx_reset_deassert(struct realtek_priv *priv)
+{
+	int ret;
+
+	ret = reset_control_deassert(priv->reset_ctl);
+	if (ret)
+		dev_warn(priv->dev,
+			 "Failed to deassert the switch reset control: %pe\n",
+			 ERR_PTR(ret));
+
+	gpiod_set_value(priv->reset, false);
+}
+
 MODULE_AUTHOR("Luiz Angelo Daros de Luca <luizluca@gmail.com>");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Realtek DSA switches common module");
diff --git a/drivers/net/dsa/realtek/rtl83xx.h b/drivers/net/dsa/realtek/rtl83xx.h
index 0ddff33df6b0..c8a0ff8fd75e 100644
--- a/drivers/net/dsa/realtek/rtl83xx.h
+++ b/drivers/net/dsa/realtek/rtl83xx.h
@@ -18,5 +18,7 @@ int rtl83xx_register_switch(struct realtek_priv *priv);
 void rtl83xx_unregister_switch(struct realtek_priv *priv);
 void rtl83xx_shutdown(struct realtek_priv *priv);
 void rtl83xx_remove(struct realtek_priv *priv);
+void rtl83xx_reset_assert(struct realtek_priv *priv);
+void rtl83xx_reset_deassert(struct realtek_priv *priv);
 
 #endif /* _RTL83XX_H */

-- 
2.43.0


