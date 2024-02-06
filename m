Return-Path: <linux-kernel+bounces-55391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4284BC20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A561F276E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57A1B805;
	Tue,  6 Feb 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPm4T2nB"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BF1802E;
	Tue,  6 Feb 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240793; cv=none; b=kJt5j8ZphqQ8IuvOphj15fW59chZt0TWUmZ20mA0u2mvg1ZsRp8Tsp//ltg6VN4MhzwSqz72u9UvJ7zy9ZmAvpe5rvRB3T/mtU9ppHwudlqioNCxKQjb/qCkN7eYVGBunwOdCte99J3eyYxpWcu4GFxcmv0EhpPpFJ8UCcyk1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240793; c=relaxed/simple;
	bh=IF0oo1ZQ82QB95MrqtNsrEE2S8zMLUpGhSkd5BwFGAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tms8ZkzXzGInG4wAFgmxvzRhAfbOftMXrShrFlG5gzI/xMy5ojXK0dMADOKgbW259sArTodOLTG1jYb2NW91/DjenoloPuNV2SKVnu78AXMQep9gpIidD3MY79563TEFzW4RJE09c54ltMx52MOTaXiF8rzlov4THgQdcc729P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPm4T2nB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33934567777so909076f8f.1;
        Tue, 06 Feb 2024 09:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240790; x=1707845590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WoCJEsbiVlNOq1w7ZYfzlKdo640PAaFTQAV/jxjbsU=;
        b=mPm4T2nBDdSele7bZ1GN3VMsOprwVqRVK5loDfzElxcNNBPPvJRLFcTo75GgOAKuTH
         VNtMKo8DQ8+c4jsc9aeQFKZ1NLX4CaWsWxDkwSYu5t0/XNJxxFmJ2tG7pZOfGaVrIDCw
         6Ek+WZCN+Rd+2jlMcyps3ohYv6U8kqZWzFNQ93xhIIEeYoxZB5evpff2CvTbNjE6Y2yE
         hqm4WxOspJFpTUPv3G9+6qBt+vg2SJWhKIFbH4r05QH9EEchnYfy6xq37Bn7n00MxCUC
         lJKE5SUcCp98NDM9nfIuC7To/hWnSc65IE4gyPC+jsHDrsxf1+isUw62ubi0HUSxHZcx
         VReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240790; x=1707845590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WoCJEsbiVlNOq1w7ZYfzlKdo640PAaFTQAV/jxjbsU=;
        b=tyHhADW2CALZ39I23ztUtOV71T7SqbIyzw3pfw2yq6E3VFuId6XEZqXMkOQA8z+ikn
         j9mAsv38gSr9TlcGEfYgFEOn+PNMHQae4Sh6y+Q7eQOe4+EWzusvyDztAymbBaGYy7M5
         nTtAcqTroAjDagTclYS/FjrZBdoCuK1I8oyuRDAxxKaiUwnGIx3FADT/KczVaL7RqPZ3
         sA+sLMkR+dP9bWObDipE/VRXLFiN3N8o2YObiBmmwoga1SPjyN5MqpM8HSypDHyEYEI6
         QLgPhBmt1IKXmFbPUDwoQNDFU23HCjvE5BM/G8kebSg2L61JkCKVImTzEqc4Da0mhtnQ
         a3aA==
X-Gm-Message-State: AOJu0YyinwDqX1pr69f5OQJ723wSEkQOBWlhhLSyyfyKhb5LGo8wmZ/P
	6HTnVYVnPIpZh1nDqzqnVjrkWxNDLFDzbrQxjiCiTGGLl4fVWUx8
X-Google-Smtp-Source: AGHT+IEbk9h6D7IhbdV0KwvfVF0MEd+FZ583ibPIEOzUNRz6hMjjyF89VkYI1fnyP8XqiNCjvoy2VA==
X-Received: by 2002:adf:fc92:0:b0:33b:36d6:90cc with SMTP id g18-20020adffc92000000b0033b36d690ccmr1455336wrr.28.1707240789750;
        Tue, 06 Feb 2024 09:33:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWkV1MrnrNr1a6IZO0zm4JrvsAAnme+HWTseqI6Yn1WM8oIjj54bOmuHXvTkGI6sa1qTCFogCBX2yxIwMlp4MaoxlX/B8Gp1zOc/w1dOHgNYDWWPtn4Me0EqUJ5ExtLZ7ovxozsMkIdyv4xHEEOcRmZxjjzib5ocr2HUYWlMl40PfaS/MwMFYwMlrb3swQhFHR1ucH7uEfeK1rxT577d896sgZmqTUPEFdK0gcKIqBVDiHlefqxFm0h/TOTPLOSmP04iFlUXidSjfLPt16CXsKtk/ZObu3iSY5pnWSYTuE7Tm0yH1U3p6EJDazL8o5Si6NtwJaszFCtnJfvyCQjAkLEJXs317m5dVhNbyh5PnD0FJe+ePx0C27VZVVxAoPhYOi6l66pHRPVbCKoc04ywYIqlEXxKLg53861FuQ4+D+gD77E84XvP5Ohi/B/2pt6opl/xTn5ggZ4SLmTcqQLcOWZUhvvqMQXAhJYSuh/fpuqqfe1qvYfTAycBedJd0brects+fVtK2mZCcwTQlZ5UTLPSP2YwhDw3HI06fSqtVwSQmlsCRgwjf89app9lzWA7R2jFu6aBcGHzWpF7oCISuNt1X0dHlRGz72t7QvciK9v/QrJsclpyRWBZQseK2tzSxp/ji4hV6CVMmEDaDMjNGLqhL4qPqV0qm9wNU0oGQgSRbjQRDNnEg==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:33:08 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 09/10] net: phy: qcom: generalize some qca808x LED functions
Date: Tue,  6 Feb 2024 18:31:12 +0100
Message-ID: <20240206173115.7654-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize some qca808x LED functions in preparation for qca807x LED
support.

The LED implementation of qca808x and qca807x is the same but qca807x
supports also Fiber port and have different hw control bits for Fiber
port. To limit code duplication introduce micro functions that takes reg
instead of LED index to tweak all the supported LED modes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c      | 38 +++-----------------
 drivers/net/phy/qcom/qcom-phy-lib.c | 54 +++++++++++++++++++++++++++++
 drivers/net/phy/qcom/qcom.h         |  7 ++++
 3 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index f1edff6b6bfc..2acf852fb4de 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -437,9 +437,7 @@ static int qca808x_led_hw_control_enable(struct phy_device *phydev, u8 index)
 		return -EINVAL;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
-				  QCA808X_LED_FORCE_EN);
+	return qca808x_led_reg_hw_control_enable(phydev, reg);
 }
 
 static int qca808x_led_hw_is_supported(struct phy_device *phydev, u8 index,
@@ -480,16 +478,12 @@ static int qca808x_led_hw_control_set(struct phy_device *phydev, u8 index,
 static bool qca808x_led_hw_control_status(struct phy_device *phydev, u8 index)
 {
 	u16 reg;
-	int val;
 
 	if (index > 2)
 		return false;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
-
-	return !(val & QCA808X_LED_FORCE_EN);
+	return qca808x_led_reg_hw_control_status(phydev, reg);
 }
 
 static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
@@ -557,44 +551,20 @@ static int qca808x_led_brightness_set(struct phy_device *phydev,
 	}
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
-			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			      QCA808X_LED_FORCE_EN | (value ? QCA808X_LED_FORCE_ON :
-							     QCA808X_LED_FORCE_OFF));
+	return qca808x_led_reg_brightness_set(phydev, reg, value);
 }
 
 static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
 				 unsigned long *delay_on,
 				 unsigned long *delay_off)
 {
-	int ret;
 	u16 reg;
 
 	if (index > 2)
 		return -EINVAL;
 
 	reg = QCA808X_MMD7_LED_FORCE_CTRL(index);
-
-	/* Set blink to 50% off, 50% on at 4Hz by default */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
-			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
-			     QCA808X_LED_BLINK_FREQ_4HZ | QCA808X_LED_BLINK_DUTY_50_50);
-	if (ret)
-		return ret;
-
-	/* We use BLINK_1 for normal blinking */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
-			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_BLINK_1);
-	if (ret)
-		return ret;
-
-	/* We set blink to 4Hz, aka 250ms */
-	*delay_on = 250 / 2;
-	*delay_off = 250 / 2;
-
-	return 0;
+	return qca808x_led_reg_blink_set(phydev, reg, delay_on, delay_off);
 }
 
 static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
diff --git a/drivers/net/phy/qcom/qcom-phy-lib.c b/drivers/net/phy/qcom/qcom-phy-lib.c
index 786bfc39912c..d28815ef56bb 100644
--- a/drivers/net/phy/qcom/qcom-phy-lib.c
+++ b/drivers/net/phy/qcom/qcom-phy-lib.c
@@ -620,3 +620,57 @@ int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qca808x_cable_test_get_status);
+
+int qca808x_led_reg_hw_control_enable(struct phy_device *phydev, u16 reg)
+{
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, reg,
+				  QCA808X_LED_FORCE_EN);
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_hw_control_enable);
+
+bool qca808x_led_reg_hw_control_status(struct phy_device *phydev, u16 reg)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
+	return !(val & QCA808X_LED_FORCE_EN);
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_hw_control_status);
+
+int qca808x_led_reg_brightness_set(struct phy_device *phydev,
+				   u16 reg, enum led_brightness value)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			      QCA808X_LED_FORCE_EN | (value ? QCA808X_LED_FORCE_ON :
+							      QCA808X_LED_FORCE_OFF));
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_brightness_set);
+
+int qca808x_led_reg_blink_set(struct phy_device *phydev, u16 reg,
+			      unsigned long *delay_on,
+			      unsigned long *delay_off)
+{
+	int ret;
+
+	/* Set blink to 50% off, 50% on at 4Hz by default */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, QCA808X_MMD7_LED_GLOBAL,
+			     QCA808X_LED_BLINK_FREQ_MASK | QCA808X_LED_BLINK_DUTY_MASK,
+			     QCA808X_LED_BLINK_FREQ_4HZ | QCA808X_LED_BLINK_DUTY_50_50);
+	if (ret)
+		return ret;
+
+	/* We use BLINK_1 for normal blinking */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
+			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
+			     QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_BLINK_1);
+	if (ret)
+		return ret;
+
+	/* We set blink to 4Hz, aka 250ms */
+	*delay_on = 250 / 2;
+	*delay_off = 250 / 2;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca808x_led_reg_blink_set);
diff --git a/drivers/net/phy/qcom/qcom.h b/drivers/net/phy/qcom/qcom.h
index 9e24997c355f..4bb541728846 100644
--- a/drivers/net/phy/qcom/qcom.h
+++ b/drivers/net/phy/qcom/qcom.h
@@ -234,3 +234,10 @@ int at803x_cdt_start(struct phy_device *phydev, u32 cdt_start);
 int at803x_cdt_wait_for_completion(struct phy_device *phydev,
 				   u32 cdt_en);
 int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished);
+int qca808x_led_reg_hw_control_enable(struct phy_device *phydev, u16 reg);
+bool qca808x_led_reg_hw_control_status(struct phy_device *phydev, u16 reg);
+int qca808x_led_reg_brightness_set(struct phy_device *phydev,
+				   u16 reg, enum led_brightness value);
+int qca808x_led_reg_blink_set(struct phy_device *phydev, u16 reg,
+			      unsigned long *delay_on,
+			      unsigned long *delay_off);
-- 
2.43.0


