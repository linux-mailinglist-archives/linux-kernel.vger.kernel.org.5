Return-Path: <linux-kernel+bounces-160899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0588B4448
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8521F23663
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D0B45948;
	Sat, 27 Apr 2024 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zni3YmDs"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320544376;
	Sat, 27 Apr 2024 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714194729; cv=none; b=rruonesxZth1FXriOHm2zfOYNR6bwQb6NlUnMCyk192ICt0CZ7P4SKqjhcAXSatLCsbqqgfartHL9tzRTB+qK2hT3AhELy7sURePIh4O9SlAiwtnqVg3W3ev01yWBgu7ESaSG968ZHqUKJIEql900FI+zhJ4zsWXCN7W2YFycCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714194729; c=relaxed/simple;
	bh=w7j7eoPe3wMPBymfAu2rfATkFGf9aoN/OioKZKEgqAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQYaZficOZXI4KimN7BQI5XA5gfyB5HBrcmQl5IHnWDXzFx9iNJ/fWtptW/ZkFIi6clcSKSRnhiLNXLWmXv6/qolyff8znoI/dPhvZjXIhlYMaTqBVdiw7/Vwy7YzHmMBYcLf7jgQ9efvCFxWGFZVzsHG07KZDQqA5L1n5cnqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zni3YmDs; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5af2358c7e5so1764485eaf.0;
        Fri, 26 Apr 2024 22:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714194726; x=1714799526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqQXMvgfEIvf1SoegchzmEBs0evEfQTO7JV2ujH24s0=;
        b=Zni3YmDsLdlGWeobmeOSJR9LWa+NnONlbNbeCOuDkXLzPAIfCtWKSKzD9bCZ0tgGxb
         PTQcsGSAwtQQJ68irJOy2VmmgN0VL7e8C1aCYWXEG/Pxf9kFmIzwhhDjUteJui2IM+Dl
         lEEZNapeUX3UmhCUnJ1nul2Zsx/lJs6EtJMGdOebUtA/xM6BQVSuPszlmtYaMkBsYfJD
         u8KGAE7ZV2sth3gemwDGbc7Fi260Iov+SeWQgrx/OL1Pyp3VN1q4WXRIFdkijBrPAFHX
         lR5eb8WFR8+Vk6Nw4zUS05umidgjyyjswgE8Hb3IF2mC2awft22qFNtCUdSHJ3w91W7G
         bsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714194726; x=1714799526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqQXMvgfEIvf1SoegchzmEBs0evEfQTO7JV2ujH24s0=;
        b=FsPDM7PqAdCOG01ypCf5J3DltkhgrWI5uEqJbS2BdS0KRhZhxgs0e2FyPyT3BQbRaA
         jgO9ruJpkx+5VnYxxC2mnPFgoTqjk4M4krUCUgId8moklBbIJEWryNBtFibVfKr+OxCX
         2Q2toDpt5l/ldJD9sltAtEKpm4Up2hbZQ9DZxX383bnNZ788xPqI91IjYYMuorjSH1xc
         5IrDMmfhNMTqcU5GZ1/SGg9uvJ4xz2sBHgJGyDM/e0uTo1UOLB8OA8G0pb4t0uavT4N7
         x8SjisEDQwi6NRn/Lgm6feHkidtZGJjQ1yNsachqjn9/2j2rD05NeSyGplAVJDgLTS73
         BofQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt4aqWbHRvxBSqAg1Xj/yDhK6tcr/eKXHuPveHuEnq8k0hWnRZyQaTwq5Lg3MYW2zd+SjPyYqIdtmzIoyTR86qoYlddahTWly870JlaiGNyg/vsxE1Jq9hXmV43t1ZbYO1dFvwZKZ3sg==
X-Gm-Message-State: AOJu0YzugVAL3n3RnU8OybCCZln4tdUi+8DZhPf4ZWlndDmbi++Ke2/y
	8yO4uqsX3/DPwdowv8YYsXAfeZXFLBE9SikjmXSUn73fHg9XjHrTcJPcrkcG
X-Google-Smtp-Source: AGHT+IEDxEbHUa0iEITOStiDCKL7LmwldX6SjCB1iMMGOW/z4uBw5734azLOc3hOoGPfSZij8UJ5ow==
X-Received: by 2002:a05:6358:b58a:b0:186:100b:1552 with SMTP id wa10-20020a056358b58a00b00186100b1552mr5437096rwc.8.1714194725864;
        Fri, 26 Apr 2024 22:12:05 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([189.34.32.15])
        by smtp.gmail.com with ESMTPSA id cb17-20020a056a02071100b0060063c4be3bsm8108513pgb.14.2024.04.26.22.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 22:12:05 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 27 Apr 2024 02:11:30 -0300
Subject: [PATCH net-next v2 3/3] net: dsa: realtek: add LED drivers for
 rtl8366rb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-realtek-led-v2-3-5abaddc32cf6@gmail.com>
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
In-Reply-To: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11662; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=w7j7eoPe3wMPBymfAu2rfATkFGf9aoN/OioKZKEgqAI=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBmLIkLFq2cD/EcUYBtCokmfJ8vz9xDNTxj5c8S2
 ROToXU6fKWJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZiyJCwAKCRC7Edu60Qc7
 VselB/0e+1kLCy/9RKS3ZUdZXlpfuGdQdt0g2kxsiE4z3z+/evmd7LHV7ucXH9jCuXJqCu3sodJ
 iH92imdKAvUnv152Z5REAV0IjvdrcW/8mz845824LNLfzY4+uGyAxzFChTYD27vTbF+61x//avL
 1erhVZFKGGW1mOHoYnkL00hT/S0kmY4zRUQrXRlrqPIoFYrylBErI4JTNK3mRS7HFetGdY++SnP
 ihlVL3dXfg8Xyi4P8Ae2FqtVNmMsdnEoaqyLmniKlRDkqD2ZidzrMl8ZeUDFUXEjZJCaDmyf3SE
 1O/d7b+LAJCaQHzX3GMGD4pEppeccPTK65qLoymYP/oWDZzM
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

This commit introduces LED drivers for rtl8366rb, enabling LEDs to be
described in the device tree using the same format as qca8k. Each port
can configure up to 4 LEDs.

If all LEDs in a group use the default state "keep", they will use the
default behavior after a reset. Changing the brightness of one LED,
either manually or by a trigger, will disable the default hardware
trigger and switch the entire LED group to manually controlled LEDs.
Once in this mode, there is no way to revert to hardware-controlled LEDs
(except by resetting the switch).

Software triggers function as expected with manually controlled LEDs.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/rtl8366rb.c | 304 +++++++++++++++++++++++++++++++-----
 1 file changed, 265 insertions(+), 39 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 5ccb1a3a149d..9244c63e8289 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -176,6 +176,7 @@
 #define RTL8366RB_VLAN_INGRESS_CTRL2_REG	0x037f
 
 /* LED control registers */
+/* The LED blink rate is global; it is used by all triggers in all groups. */
 #define RTL8366RB_LED_BLINKRATE_REG		0x0430
 #define RTL8366RB_LED_BLINKRATE_MASK		0x0007
 #define RTL8366RB_LED_BLINKRATE_28MS		0x0000
@@ -191,31 +192,21 @@
 	(4 * (led_group))
 #define RTL8366RB_LED_CTRL_MASK(led_group)	\
 	(0xf << RTL8366RB_LED_CTRL_OFFSET(led_group))
-#define RTL8366RB_LED_OFF			0x0
-#define RTL8366RB_LED_DUP_COL			0x1
-#define RTL8366RB_LED_LINK_ACT			0x2
-#define RTL8366RB_LED_SPD1000			0x3
-#define RTL8366RB_LED_SPD100			0x4
-#define RTL8366RB_LED_SPD10			0x5
-#define RTL8366RB_LED_SPD1000_ACT		0x6
-#define RTL8366RB_LED_SPD100_ACT		0x7
-#define RTL8366RB_LED_SPD10_ACT			0x8
-#define RTL8366RB_LED_SPD100_10_ACT		0x9
-#define RTL8366RB_LED_FIBER			0xa
-#define RTL8366RB_LED_AN_FAULT			0xb
-#define RTL8366RB_LED_LINK_RX			0xc
-#define RTL8366RB_LED_LINK_TX			0xd
-#define RTL8366RB_LED_MASTER			0xe
-#define RTL8366RB_LED_FORCE			0xf
 
 /* The RTL8366RB_LED_X_X registers are used to manually set the LED state only
  * when the corresponding LED group in RTL8366RB_LED_CTRL_REG is
- * RTL8366RB_LED_FORCE. Otherwise, it is ignored.
+ * RTL8366RB_LEDGROUP_FORCE. Otherwise, it is ignored.
  */
 #define RTL8366RB_LED_0_1_CTRL_REG		0x0432
-#define RTL8366RB_LED_1_OFFSET			6
 #define RTL8366RB_LED_2_3_CTRL_REG		0x0433
-#define RTL8366RB_LED_3_OFFSET			6
+#define RTL8366RB_LED_X_X_CTRL_REG(led_group)	\
+	((led_group) <= 1 ? \
+		RTL8366RB_LED_0_1_CTRL_REG : \
+		RTL8366RB_LED_2_3_CTRL_REG)
+#define RTL8366RB_LED_0_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_1_CTRL_MASK		GENMASK(11, 6)
+#define RTL8366RB_LED_2_X_CTRL_MASK		GENMASK(5, 0)
+#define RTL8366RB_LED_X_3_CTRL_MASK		GENMASK(11, 6)
 
 #define RTL8366RB_MIB_COUNT			33
 #define RTL8366RB_GLOBAL_MIB_COUNT		1
@@ -359,14 +350,44 @@
 #define RTL8366RB_GREEN_FEATURE_TX	BIT(0)
 #define RTL8366RB_GREEN_FEATURE_RX	BIT(2)
 
+enum rtl8366_ledgroup_mode {
+	RTL8366RB_LEDGROUP_OFF			= 0x0,
+	RTL8366RB_LEDGROUP_DUP_COL		= 0x1,
+	RTL8366RB_LEDGROUP_LINK_ACT		= 0x2,
+	RTL8366RB_LEDGROUP_SPD1000		= 0x3,
+	RTL8366RB_LEDGROUP_SPD100		= 0x4,
+	RTL8366RB_LEDGROUP_SPD10		= 0x5,
+	RTL8366RB_LEDGROUP_SPD1000_ACT		= 0x6,
+	RTL8366RB_LEDGROUP_SPD100_ACT		= 0x7,
+	RTL8366RB_LEDGROUP_SPD10_ACT		= 0x8,
+	RTL8366RB_LEDGROUP_SPD100_10_ACT	= 0x9,
+	RTL8366RB_LEDGROUP_FIBER		= 0xa,
+	RTL8366RB_LEDGROUP_AN_FAULT		= 0xb,
+	RTL8366RB_LEDGROUP_LINK_RX		= 0xc,
+	RTL8366RB_LEDGROUP_LINK_TX		= 0xd,
+	RTL8366RB_LEDGROUP_MASTER		= 0xe,
+	RTL8366RB_LEDGROUP_FORCE		= 0xf,
+
+	__RTL8366RB_LEDGROUP_MODE_MAX
+};
+
+struct rtl8366rb_led {
+	u8 port_num;
+	u8 led_group;
+	struct realtek_priv *priv;
+	struct led_classdev cdev;
+};
+
 /**
  * struct rtl8366rb - RTL8366RB-specific data
  * @max_mtu: per-port max MTU setting
  * @pvid_enabled: if PVID is set for respective port
+ * @leds: per-port and per-ledgroup led info
  */
 struct rtl8366rb {
 	unsigned int max_mtu[RTL8366RB_NUM_PORTS];
 	bool pvid_enabled[RTL8366RB_NUM_PORTS];
+	struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
 };
 
 static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
@@ -809,6 +830,217 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
 	return 0;
 }
 
+static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
+				      u8 led_group,
+				      enum rtl8366_ledgroup_mode mode)
+{
+	int ret;
+	u32 val;
+
+	val = mode << RTL8366RB_LED_CTRL_OFFSET(led_group);
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_CTRL_REG,
+				 RTL8366RB_LED_CTRL_MASK(led_group),
+				 val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
+{
+	switch (led_group) {
+	case 0:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 1:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 2:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	case 3:
+		return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
+	default:
+		return 0;
+	}
+}
+
+static int rb8366rb_get_port_led(struct rtl8366rb_led *led)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(priv->map, RTL8366RB_LED_X_X_CTRL_REG(led_group),
+			  &val);
+	if (ret) {
+		dev_err(priv->dev, "error reading LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	return !!(val & rtl8366rb_led_group_port_mask(led_group, port_num));
+}
+
+static int rb8366rb_set_port_led(struct rtl8366rb_led *led, bool enable)
+{
+	struct realtek_priv *priv = led->priv;
+	u8 led_group = led->led_group;
+	u8 port_num = led->port_num;
+	int ret;
+
+	ret = regmap_update_bits(priv->map,
+				 RTL8366RB_LED_X_X_CTRL_REG(led_group),
+				 rtl8366rb_led_group_port_mask(led_group,
+							       port_num),
+				 enable ? 0xffff : 0);
+	if (ret) {
+		dev_err(priv->dev, "error updating LED on port %d group %d\n",
+			led_group, port_num);
+		return ret;
+	}
+
+	/* Change the LED group to manual controlled LEDs if required */
+	ret = rb8366rb_set_ledgroup_mode(priv, led_group,
+					 RTL8366RB_LEDGROUP_FORCE);
+
+	if (ret) {
+		dev_err(priv->dev, "error updating LED GROUP group %d\n",
+			led_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+rtl8366rb_cled_brightness_set_blocking(struct led_classdev *ldev,
+				       enum led_brightness brightness)
+{
+	struct rtl8366rb_led *led = container_of(ldev, struct rtl8366rb_led,
+						 cdev);
+
+	return rb8366rb_set_port_led(led, brightness == LED_ON);
+}
+
+static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
+			       struct fwnode_handle *led_fwnode)
+{
+	struct rtl8366rb *rb = priv->chip_data;
+	struct led_init_data init_data = { };
+	enum led_default_state state;
+	struct rtl8366rb_led *led;
+	u32 led_group;
+	int ret;
+
+	ret = fwnode_property_read_u32(led_fwnode, "reg", &led_group);
+	if (ret)
+		return ret;
+
+	if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
+		dev_warn(priv->dev, "Invalid LED reg %d defined for port %d",
+			 led_group, dp->index);
+		return -EINVAL;
+	}
+
+	led = &rb->leds[dp->index][led_group];
+	led->port_num = dp->index;
+	led->led_group = led_group;
+	led->priv = priv;
+
+	state = led_init_default_state_get(led_fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = 1;
+		rb8366rb_set_port_led(led, 1);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		led->cdev.brightness =
+			rb8366rb_get_port_led(led);
+		break;
+	case LEDS_DEFSTATE_OFF:
+	default:
+		led->cdev.brightness = 0;
+		rb8366rb_set_port_led(led, 0);
+	}
+
+	led->cdev.max_brightness = 1;
+	led->cdev.brightness_set_blocking =
+		rtl8366rb_cled_brightness_set_blocking;
+	init_data.fwnode = led_fwnode;
+	init_data.devname_mandatory = true;
+
+	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
+					 dp->ds->index, dp->index, led_group);
+	if (!init_data.devicename)
+		return -ENOMEM;
+
+	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
+	if (ret) {
+		dev_warn(priv->dev, "Failed to init LED %d for port %d",
+			 led_group, dp->index);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtl8366rb_setup_all_leds_off(struct realtek_priv *priv)
+{
+	int ret = 0;
+	int i;
+
+	regmap_update_bits(priv->map,
+			   RTL8366RB_INTERRUPT_CONTROL_REG,
+			   RTL8366RB_P4_RGMII_LED,
+			   0);
+
+	for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
+		ret = rb8366rb_set_ledgroup_mode(priv, i,
+						 RTL8366RB_LEDGROUP_OFF);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int rtl8366rb_setup_leds(struct realtek_priv *priv)
+{
+	struct device_node *leds_np, *led_np;
+	struct dsa_switch *ds = &priv->ds;
+	struct dsa_port *dp;
+	int ret = 0;
+
+	dsa_switch_for_each_port(dp, ds) {
+		if (!dp->dn)
+			continue;
+
+		leds_np = of_get_child_by_name(dp->dn, "leds");
+		if (!leds_np) {
+			dev_dbg(priv->dev, "No leds defined for port %d",
+				dp->index);
+			continue;
+		}
+
+		for_each_child_of_node(leds_np, led_np) {
+			ret = rtl8366rb_setup_led(priv, dp,
+						  of_fwnode_handle(led_np));
+			if (ret) {
+				of_node_put(led_np);
+				break;
+			}
+		}
+
+		of_node_put(leds_np);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static int rtl8366rb_setup(struct dsa_switch *ds)
 {
 	struct realtek_priv *priv = ds->priv;
@@ -817,7 +1049,6 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	u32 chip_ver = 0;
 	u32 chip_id = 0;
 	int jam_size;
-	u32 val;
 	int ret;
 	int i;
 
@@ -997,7 +1228,9 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Set blinking, TODO: make this configurable */
+	/* Set blinking, used by all LED groups using HW triggers.
+	 * TODO: make this configurable
+	 */
 	ret = regmap_update_bits(priv->map, RTL8366RB_LED_BLINKRATE_REG,
 				 RTL8366RB_LED_BLINKRATE_MASK,
 				 RTL8366RB_LED_BLINKRATE_56MS);
@@ -1005,26 +1238,19 @@ static int rtl8366rb_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Set up LED activity:
-	 * Each port has 4 LEDs, we configure all ports to the same
-	 * behaviour (no individual config) but we can set up each
-	 * LED separately.
+	 * Each port has 4 LEDs on fixed groups. Each group shares the same
+	 * hardware trigger across all ports. LEDs can only be indiviually
+	 * controlled setting the LED group to fixed mode and using the driver
+	 * to toggle them LEDs on/off.
 	 */
 	if (priv->leds_disabled) {
-		/* Turn everything off */
-		regmap_update_bits(priv->map,
-				   RTL8366RB_INTERRUPT_CONTROL_REG,
-				   RTL8366RB_P4_RGMII_LED,
-				   0);
-
-		for (i = 0; i < RTL8366RB_NUM_LEDGROUPS; i++) {
-			val = RTL8366RB_LED_OFF << RTL8366RB_LED_CTRL_OFFSET(i);
-			ret = regmap_update_bits(priv->map,
-						 RTL8366RB_LED_CTRL_REG,
-						 RTL8366RB_LED_CTRL_MASK(i),
-						 val);
-			if (ret)
-				return ret;
-		}
+		ret = rtl8366rb_setup_all_leds_off(priv);
+		if (ret)
+			return ret;
+	} else {
+		ret = rtl8366rb_setup_leds(priv);
+		if (ret)
+			return ret;
 	}
 
 	ret = rtl8366_reset_vlan(priv);

-- 
2.44.0


