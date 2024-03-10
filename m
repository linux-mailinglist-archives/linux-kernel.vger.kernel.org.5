Return-Path: <linux-kernel+bounces-98115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798DF87754D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1761C21163
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82889208C4;
	Sun, 10 Mar 2024 04:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAQWroAu"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028711EB22;
	Sun, 10 Mar 2024 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046342; cv=none; b=gUgsy3IAHfRe/njgaSN5158hww0/GZCRtNXEu/S4ceyAfYkYdVnPx5oXzcM9nccOxAnE3OGOcAhDTKJGX+HJcLA5YmnB7KsyzabSIUHS4n+/ugO3c2Shtg0HIwzKFMFUh/9aHeudzViouYUhWQcynBoTWApRy3/pa0llB/GfXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046342; c=relaxed/simple;
	bh=9ZKWPMfna0jwv6fGXFjbpfO9PS9iN4T7q95CeiGCuwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cm5blVILi/w+T3QaG7ZPEIjTZuPvGLaeb8OT6Z1isRu+69fxVeiuZKm0N4s7NF9hz8L2F10nhO46OnCAE/VouhpnW7hL9bGidrxytcvFIXwRMa94RouirwG5jL5y3X1d7bqpSniL24kKsPtpygSk0olYrSroLA9KoXcCnWrdzxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAQWroAu; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2210a266118so1532990fac.1;
        Sat, 09 Mar 2024 20:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710046340; x=1710651140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9F4InxFahtIzBCiasX92apB/V4CV7bosSvWP44yKEb4=;
        b=MAQWroAuZc+y5sXQme4YymWc5TUsoVawer/bifwrin6kZf1g6z/6mIpr5lXpKf0WvF
         7XyNgARGXfLOTUnxANzHUwy5So4zJX6+3k2J80GqKVgU8P57od/fdCqIImyS3LEF9C3c
         kAVAistN/lf6TPgKQVwVgALha4aReSzVxzFVLvXf/sMQDGRLQu0420nGN1QWRr8iUIoM
         5sXKjA3cGt2t4+qvm+yiOQywgkkTJEZWmNMkCg3K+IOfJZhc9RUvTET0ifWIUUMdabKE
         6kHBlHYpf3tkL+Mf6FewbBipIRTV5g2UxU1ON74WvpWYxEPTk61KPtdCoQ/BQndgwIpE
         cWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710046340; x=1710651140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F4InxFahtIzBCiasX92apB/V4CV7bosSvWP44yKEb4=;
        b=AZF5k65fkC0eSTWtNISFzLisDUaOGkRbEbIvWzmHqjPqJoswOw28RCLpcIjr4KSj37
         H2/g/IRnfwrd40DhvmN0VItoUuXdakdtCyKFNDh8wvUkTBtEe2FoB6kbBQ/Nue+Msw3i
         +SX4bwnADgYdbh/62op/uvxskvgaUxTrWFrhF1qObgGDyLmGtg5ImRbO0J3/eDQShPEc
         2ir61amuO/WAv/pa3Li4R0PnUUP+pph83TPJoed6yZZxgxTwsmZ2iew30ayWsIFvwTL9
         YLS8oci5qAY6xMhBhnX++WnolHuARBpaVBHlOYS7pd93i+EgxJ8uvYOIQ/mI4L+CK4p4
         fhXg==
X-Forwarded-Encrypted: i=1; AJvYcCUl2SUvYSm5Y0lo8EoRrHlee9djq8MCEl2UcymDHjv//ZebPf7uK3Awxw50G4uKK0IuHa1hLaqggc5Vd6RL2VlxMQSlDp/40AxHGY2s
X-Gm-Message-State: AOJu0Yx60rg2iANCT2mvZ2JkNlE/K3whgONHHrdyLScud0gStDwz/ar9
	7W0pjS/JjMvvvm2CmLrXNNpZAJkZpUIF4ihGVS8bDpRfpiCmhgWr
X-Google-Smtp-Source: AGHT+IHLqjp9RdoDu8wQRcjHXyF6C0gN0BIUqlGl2sP89zlfCJ2CAAWXLS5KDTMSrK6LJ34m6g7CVA==
X-Received: by 2002:a05:6359:7604:b0:17b:a0d0:5678 with SMTP id wg4-20020a056359760400b0017ba0d05678mr4670132rwc.9.1710046340149;
        Sat, 09 Mar 2024 20:52:20 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b005dc48e56191sm1984659pgh.11.2024.03.09.20.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 20:52:19 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 10 Mar 2024 01:51:59 -0300
Subject: [PATCH net-next 2/4] net: dsa: realtek: keep default LED state in
 rtl8366rb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-realtek-led-v1-2-4d9813ce938e@gmail.com>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
In-Reply-To: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6278; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=9ZKWPMfna0jwv6fGXFjbpfO9PS9iN4T7q95CeiGCuwg=;
 b=owEBbAGT/pANAwAIAbsR27rRBztWAcsmYgBl7Tx26yS+c8GdKfYNxhAiMu87GEDgJ9bp5iBzg
 6NPY7pYdg+JATIEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZe08dgAKCRC7Edu60Qc7
 VleeB/jJndP1mleQvrIlnbR1mFWnnzeZAfFk+DpGp6vBNsLiMQEPUfMIWUeXYpKi8rHGdq8DaeE
 HKpWo+/WIkRXbLSmd5XHFsqmD8kqiQM34+rsI9JmVZEPCuTfs8ZquTXKeNRm2O/GBQQrQBHVXy5
 TFqZB4IqlOh69liee+z9plr5uBP5eexyF+gi1V+701gkAZkO8DePKJSqLaI6yTfqgsYOM7+MPCH
 ras13acIBpqACe9O0hRxhLAm3ucTgoWetpJZon6SLKEOLTc2sPPhTE1sukKnOzDCJ3TWLCzb4oN
 zdFVWPJGwLxuIEwDp001ItHTWE1RiVdyujh1Tp5bd72RfTo=
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

This switch family supports four LEDs for each of its six ports. Each
LED group is composed of one of these four LEDs from all six ports. LED
groups can be configured to display hardware information, such as link
activity, or manually controlled through a bitmap in registers
RTL8366RB_LED_0_1_CTRL_REG and RTL8366RB_LED_2_3_CTRL_REG.

After a reset, the default LED group configuration for groups 0 to 3
indicates, respectively, link activity, link at 1000M, 100M, and 10M, or
RTL8366RB_LED_CTRL_REG as 0x5432. These configurations are commonly used
for LED indications. However, the driver was replacing that
configuration to use manually controlled LEDs (RTL8366RB_LED_FORCE)
without providing a way for the OS to control them. The default
configuration is deemed more useful than fixed, uncontrollable turned-on
LEDs.

The driver was enabling/disabling LEDs during port_enable/disable.
However, these events occur when the port is administratively controlled
(up or down) and are not related to link presence. Additionally, when a
port N was disabled, the driver was turning off all LEDs for group N,
not only the corresponding LED for port N in any of those 4 groups. In
such cases, if port 0 was brought down, the LEDs for all ports in LED
group 0 would be turned off. As another side effect, the driver was
wrongly warning that port 5 didn't have an LED ("no LED for port 5").
Since showing the administrative state of ports is not an orthodox way
to use LEDs, it was not worth it to fix it and all this code was
dropped.

The code to disable LEDs was simplified only changing each LED group to
the RTL8366RB_LED_OFF state. Registers RTL8366RB_LED_0_1_CTRL_REG and
RTL8366RB_LED_2_3_CTRL_REG are only used when the corresponding LED
group is configured with RTL8366RB_LED_FORCE and they don't need to be
cleaned. The code still references an LED controlled by
RTL8366RB_INTERRUPT_CONTROL_REG, but as of now, no test device has
actually used it. Also, some magic numbers were replaced by macros.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 87 +++++++++----------------------------
 1 file changed, 20 insertions(+), 67 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index e10ae94cf771..5ccb1a3a149d 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -185,7 +185,12 @@
 #define RTL8366RB_LED_BLINKRATE_222MS		0x0004
 #define RTL8366RB_LED_BLINKRATE_446MS		0x0005
 
+/* LED trigger event for each group */
 #define RTL8366RB_LED_CTRL_REG			0x0431
+#define RTL8366RB_LED_CTRL_OFFSET(led_group)	\
+	(4 * (led_group))
+#define RTL8366RB_LED_CTRL_MASK(led_group)	\
+	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
 #define RTL8366RB_LED_OFF			0x0
 #define RTL8366RB_LED_DUP_COL			0x1
 #define RTL8366RB_LED_LINK_ACT			0x2
@@ -202,6 +207,11 @@
 #define RTL8366RB_LED_LINK_TX			0xd
 #define RTL8366RB_LED_MASTER			0xe
 #define RTL8366RB_LED_FORCE			0xf
+
+/* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
+ * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
+ * RTL8366RB_LED_FORCE. Otherwise, it is ignored.
+ */
 #define RTL8366RB_LED_0_1_CTRL_REG		0x0432
 #define RTL8366RB_LED_1_OFFSET			6
 #define RTL8366RB_LED_2_3_CTRL_REG		0x0433
@@ -1001,28 +1011,20 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	 */
 	if (priv->leds_disabled) {
 		/* Turn everything off */
-		regmap_update_bits(priv->map,
-				   RTL8366RB_LED_0_1_CTRL_REG,
-				   0x0FFF, 0);
-		regmap_update_bits(priv->map,
-				   RTL8366RB_LED_2_3_CTRL_REG,
-				   0x0FFF, 0);
 		regmap_update_bits(priv->map,
 				   RTL8366RB_INTERRUPT_CONTROL_REG,
 				   RTL8366RB_P4_RGMII_LED,
 				   0);
-		val = RTL8366RB_LED_OFF;
-	} else {
-		/* TODO: make this configurable per LED */
-		val = RTL8366RB_LED_FORCE;
-	}
-	for (i = 0; i < 4; i++) {
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_CTRL_REG,
-					 0xf << (i * 4),
-					 val << (i * 4));
-		if (ret)
-			return ret;
+
+		for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
+			val = RTL8366RB_LED_OFF << RTL8366RB_LED_CTRL_OFFSET(i);
+			ret = regmap_update_bits(priv->map,
+						 RTL8366RB_LED_CTRL_REG,
+						 RTL8366RB_LED_CTRL_MASK(i),
+						 val);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = rtl8366_reset_vlan(priv);
@@ -1167,52 +1169,6 @@ rtl8366rb_mac_link_down(struct dsa_switch *ds, int port, unsigned int mode,
 	}
 }
 
-static void rb8366rb_set_port_led(struct realtek_priv *priv,
-				  int port, bool enable)
-{
-	u16 val = enable ? 0x3f : 0;
-	int ret;
-
-	if (priv->leds_disabled)
-		return;
-
-	switch (port) {
-	case 0:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_0_1_CTRL_REG,
-					 0x3F, val);
-		break;
-	case 1:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_0_1_CTRL_REG,
-					 0x3F << RTL8366RB_LED_1_OFFSET,
-					 val << RTL8366RB_LED_1_OFFSET);
-		break;
-	case 2:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_2_3_CTRL_REG,
-					 0x3F, val);
-		break;
-	case 3:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_LED_2_3_CTRL_REG,
-					 0x3F << RTL8366RB_LED_3_OFFSET,
-					 val << RTL8366RB_LED_3_OFFSET);
-		break;
-	case 4:
-		ret = regmap_update_bits(priv->map,
-					 RTL8366RB_INTERRUPT_CONTROL_REG,
-					 RTL8366RB_P4_RGMII_LED,
-					 enable ? RTL8366RB_P4_RGMII_LED : 0);
-		break;
-	default:
-		dev_err(priv->dev, "no LED for port %d\n", port);
-		return;
-	}
-	if (ret)
-		dev_err(priv->dev, "error updating LED on port %d\n", port);
-}
-
 static int
 rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 		      struct phy_device *phy)
@@ -1226,7 +1182,6 @@ rtl8366rb_port_enable(struct dsa_switch *ds, int port,
 	if (ret)
 		return ret;
 
-	rb8366rb_set_port_led(priv, port, true);
 	return 0;
 }
 
@@ -1241,8 +1196,6 @@ rtl8366rb_port_disable(struct dsa_switch *ds, int port)
 				 BIT(port));
 	if (ret)
 		return;
-
-	rb8366rb_set_port_led(priv, port, false);
 }
 
 static int

-- 
2.44.0


