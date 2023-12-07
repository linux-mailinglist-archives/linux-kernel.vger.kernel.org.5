Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67CA80816F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377964AbjLGHI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377825AbjLGHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:08:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D845010DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:08:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so767324a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 23:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701932897; x=1702537697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gywAwq9qJG6+p4wdmC5POU/toms4P6YzG5VQvmZQgJo=;
        b=SF9xKO9dTlRHbzKzxxgMv1dwTpKAdBXeZJeBvEGOn25NesbB3uPDly614Z5rzkIOA4
         aU3lhrBLa9Bpat4khyijYgsvsVSOiY0qLUmgm0XOA8h52dykkeuiRglgxKbQrt4RPacR
         mXCliiHSEUgXlE+yyn+u+iXB4LxA47AMUCBGzugLd5xBBjoX3zepJsGsVnKPwiKSKChd
         Ov6WwIBb2PzPrRIFd+x8BQuKuUzyg1s8wz3b8v07oNluMDXW2uYBLkfxnef3b4r6uAaX
         8DfXpV6hWK6Ps+stdAzW7ml9B4iwuGbKfpMQ4TMOaLhX5BRVC8vfTngY8hrd62KlZidE
         vkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701932897; x=1702537697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gywAwq9qJG6+p4wdmC5POU/toms4P6YzG5VQvmZQgJo=;
        b=RloKlaf9GGB/PyAAl6iTALEZMca7nqdD6MFDXwMt20ngzbzoO2xG7d1SRZ2dc4Ocda
         sRm0AId+jTNE6rZyJoSljjDmvRRF7gb3zZAJ2kCi/VOEMCRziUVyZsNmHBmWxkgfDSqM
         0YI8LCgcW5Xqo6CScD9CkSk1vHFAel/JsBnBKcJ61VLKoRjsAmCXXmWc3/SIlNUWFXfL
         1G3m9VOz9jVdW6AYwWbZ4enhIrHBhov3zl42UC6aOSeVyat7bowoKm05PAP7Gcj5z+bL
         N4Kd4pqsmQkFzZxyUJOa3PR3/pqJrRX5PlkLYv2NrSUJUDrhOMy5XYizjXera8XNiRT5
         Tcxw==
X-Gm-Message-State: AOJu0YxLTKaW4BLpp53Iu/fm276bc9Ur/p2cjs91+qAbHF3lo58temJg
        cI/qjlOGsc7fA/tWlzwM6ASpLg==
X-Google-Smtp-Source: AGHT+IH2s13SvnGUnp9Exacy8WvKTCkwe6cVk81dwDV/TMe00FfiDjtDFUaBNkpHFymxLpe4GnkSVw==
X-Received: by 2002:a50:a699:0:b0:53e:1825:be81 with SMTP id e25-20020a50a699000000b0053e1825be81mr1329406edc.21.1701932896937;
        Wed, 06 Dec 2023 23:08:16 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.22])
        by smtp.gmail.com with ESMTPSA id b41-20020a509f2c000000b0054cb88a353dsm420818edf.14.2023.12.06.23.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:08:16 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 06/11] pinctrl: renesas: rzg2l: Add output enable support
Date:   Thu,  7 Dec 2023 09:06:55 +0200
Message-Id: <20231207070700.4156557-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231207070700.4156557-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Some of the Ethernet pins on RZ/G3S (but also valid for RZ/G2L) need to
have the direction of the IO buffer set as output for Ethernet to work
properly. On RZ/G3S, these pins are P1_0/P7_0, P1_1/P7_1 which could have
the following Ethernet functions: TXC/TX_CLK or TX_CTL/TX_EN.

As the pins supporting output enable are SoC specific and there is a
limited number of these pins (TXC/TX_CLK and/or TX_CTL/TX_EN), for proper
validation the output enable capable port limits were specified on
platform-based configuration data structure.

The OEN support has been intantiated for RZ/G3S at the moment.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- use 8 bit helpers to get/set value of output enable register
- adapted to code to work for both RZ/G2L based devices and RZ/G3S
- removed IEN capability for Ethernet pins and added it in a separate
  patch (patch 07/12)
  
  
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 87 ++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6b082161e821..0c05ccd03eb2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -57,6 +57,7 @@
 #define PIN_CFG_FILCLKSEL		BIT(12)
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
+#define PIN_CFG_OEN			BIT(15)
 
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -109,6 +110,7 @@
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
+#define ETH_MODE		(0x3018)
 
 #define PVDD_2500		2	/* I/O domain voltage 2.5V */
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -170,6 +172,8 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_oi: IOLH group B output impedance specific values
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is supported)
  * @func_base: base number for port function (see register PFC)
+ * @oen_max_pin: the maximum pin number supporting output enable
+ * @oen_max_port: the maximum port number supporting output enable
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
@@ -179,6 +183,8 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_oi[4];
 	bool drive_strength_ua;
 	u8 func_base;
+	u8 oen_max_pin;
+	u8 oen_max_port;
 };
 
 struct rzg2l_dedicated_configs {
@@ -782,6 +788,66 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
 	return false;
 }
 
+static bool rzg2l_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
+{
+	if (!(caps & PIN_CFG_OEN))
+		return false;
+
+	if (pin > max_pin)
+		return false;
+
+	return true;
+}
+
+static u8 rzg2l_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
+{
+	if (pin)
+		pin *= 2;
+
+	if (offset / RZG2L_PINS_PER_PORT == max_port)
+		pin += 1;
+
+	return pin;
+}
+
+static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin)
+{
+	u8 max_port = pctrl->data->hwcfg->oen_max_port;
+	u8 max_pin = pctrl->data->hwcfg->oen_max_pin;
+	u8 bit;
+
+	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+		return 0;
+
+	bit = rzg2l_pin_to_oen_bit(offset, pin, max_port);
+
+	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
+}
+
+static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offset, u8 pin, u8 oen)
+{
+	u8 max_port = pctrl->data->hwcfg->oen_max_port;
+	u8 max_pin = pctrl->data->hwcfg->oen_max_pin;
+	unsigned long flags;
+	u8 val, bit;
+
+	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+		return -EINVAL;
+
+	bit = rzg2l_pin_to_oen_bit(offset, pin, max_port);
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	val = readb(pctrl->base + ETH_MODE);
+	if (oen)
+		val &= ~BIT(bit);
+	else
+		val |= BIT(bit);
+	writeb(val, pctrl->base + ETH_MODE);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	return 0;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -819,6 +885,12 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		break;
 
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		arg = rzg2l_read_oen(pctrl, cfg, _pin, bit);
+		if (!arg)
+			return -EINVAL;
+		break;
+
 	case PIN_CONFIG_POWER_SOURCE:
 		ret = rzg2l_get_power_source(pctrl, _pin, cfg);
 		if (ret < 0)
@@ -920,6 +992,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IEN(off), bit, IEN_MASK, !!arg);
 			break;
 
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			arg = pinconf_to_config_argument(_configs[i]);
+			ret = rzg2l_write_oen(pctrl, cfg, _pin, bit, !!arg);
+			if (ret)
+				return ret;
+			break;
+
 		case PIN_CONFIG_POWER_SOURCE:
 			settings.power_source = pinconf_to_config_argument(_configs[i]);
 			break;
@@ -1364,7 +1443,8 @@ static const u32 r9a07g043_gpio_configs[] = {
 static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-								PIN_CFG_IO_VMC_ETH0)),	/* P1 */
+								PIN_CFG_IO_VMC_ETH0)) |
+				      PIN_CFG_OEN,					/* P1 */
 	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
 	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1374,7 +1454,8 @@ static const u32 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x21, RZG3S_MPXED_PIN_FUNCS(A)),			/* P5  */
 	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
 	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
-								PIN_CFG_IO_VMC_ETH1)),	/* P7 */
+								PIN_CFG_IO_VMC_ETH1)) |
+				      PIN_CFG_OEN,					/* P7 */
 	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
 	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
@@ -1956,6 +2037,8 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg = {
 	},
 	.drive_strength_ua = true,
 	.func_base = 1,
+	.oen_max_pin = 1, /* Pin 1 of P0 and P7 is the maximum OEN pin. */
+	.oen_max_port = 7, /* P7_1 is the maximum OEN port. */
 };
 
 static struct rzg2l_pinctrl_data r9a07g043_data = {
-- 
2.39.2

