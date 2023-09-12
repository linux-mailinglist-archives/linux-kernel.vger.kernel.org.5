Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C43179C5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjILE4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjILEzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:55:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8672727
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9aa0495f9cfso729586766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494398; x=1695099198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RHKXSm7JxIUaKmkTOeSBlkP7ga3ZTjW4TbYxPmDrgg=;
        b=Ab9oR+DtQ8aZ1A6WlZcrhsyRgZGXMd17RE6sAxtfg/P1nkaOoa1sAeqkt4wVtRCWX0
         dujar+mm0/PZMglcY6fF1EPXhT0cJcj5tXEoFV/kPRPEBleYR6mZ5Rvb3bzoXsFkfIwB
         ZXuWbuTqJvgIzUUz0WVDlLrEabfl1/PVrhjY0k1PyFKrCDHxgsqY+u83lwq1Om5iYtCI
         EFT/AtSM64eazlTc1va62jw32ds5k5l2iw+cylMWA7wcA9e9yEWtLhlOoOnMdRkzg5Y1
         SQ1yGFL0dp7cRk+2SFmOWBGX/4VYcXwjGjiIManB27TmVPmE2WagZnV3hCF49gO9VtSG
         vI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494398; x=1695099198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RHKXSm7JxIUaKmkTOeSBlkP7ga3ZTjW4TbYxPmDrgg=;
        b=w6n58e283G+TYYil/X1AZIZW3eXmY1ZznkXMRaQPHv3fbo1PiwOvdS3A4rahu953x5
         FxYumUUwaYnurolHbuVIEJc1Heyk/yFlwJZWaZ4jFnX7iKePSQi6G0x0qMMCGt8qR21y
         wwJTRz6FqKkiXT15n5ZcJi0TrmwYMAGbTbLZJrFjvHIoLSdiwoRNG2gj/OaZzbU+uK5k
         qgfoTh5yJb9ieop+0Jzw9unPGbDvZV0cTMsq4lXMQZPJi60yA4l64s7r6LiPzP5GalD+
         hazKRP+r0O46Gsxsfx/8kBLQ8IL9+uZyzkGgAp3+i31oxz9JAYJXOJzIlPmKeBiszGCC
         +JWw==
X-Gm-Message-State: AOJu0YyCXwLqkTQzi53Kcq83748CdUv2LL3hJHZPo+eDCyqY4BJc1GLP
        ZJOrYNqd2u2jiTks0G3H+7o7SA==
X-Google-Smtp-Source: AGHT+IFvuFy6E54ozH+8nLejfEjMegAXtX77/ddNYTfW5aBdT8lH2Zqy6ZpZ8+LumKTIyKAAABeSyg==
X-Received: by 2002:a17:907:da3:b0:9a5:aa43:1c7c with SMTP id go35-20020a1709070da300b009a5aa431c7cmr2077298ejc.26.1694494398054;
        Mon, 11 Sep 2023 21:53:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:17 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 30/37] pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
Date:   Tue, 12 Sep 2023 07:51:50 +0300
Message-Id: <20230912045157.177966-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add basic support for RZ/G3S to be able to boot from SD card, have a
running console port and use GPIOs. RZ/G3S has 82 general-purpose IO
ports. Support for the remaining pin functions (e.g. Ethernet, XSPI)
will be added along with controller specific support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 128 +++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index cf2092d9229d..e6389c946f06 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -58,13 +58,19 @@
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
 
-#define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
-					 PIN_CFG_SR | \
+#define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
+					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
 					 PIN_CFG_FILONOFF | \
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
 
+#define RZG2L_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(A) | \
+					 PIN_CFG_SR)
+
+#define RZG3S_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
+					 PIN_CFG_SOFT_PS)
+
 #define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
 					 PIN_CFG_FILONOFF | \
 					 PIN_CFG_FILNUM | \
@@ -1330,6 +1336,36 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
+static const u32 r9a08g045_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
+	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P1 */
+	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
+	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P3 */
+	RZG2L_GPIO_PORT_PACK(6, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P4 */
+	RZG2L_GPIO_PORT_PACK(5, 0x21, RZG3S_MPXED_PIN_FUNCS(A)),			/* P5  */
+	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
+	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P7 */
+	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
+	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P9 */
+	RZG2L_GPIO_PORT_PACK(5, 0x37, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P10 */
+	RZG2L_GPIO_PORT_PACK(4, 0x23, RZG3S_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),		/* P11  */
+	RZG2L_GPIO_PORT_PACK(2, 0x24, RZG3S_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),		/* P12  */
+	RZG2L_GPIO_PORT_PACK(5, 0x25, RZG3S_MPXED_PIN_FUNCS(A)),			/* P13  */
+	RZG2L_GPIO_PORT_PACK(3, 0x26, RZG3S_MPXED_PIN_FUNCS(A)),			/* P14  */
+	RZG2L_GPIO_PORT_PACK(4, 0x27, RZG3S_MPXED_PIN_FUNCS(A)),			/* P15  */
+	RZG2L_GPIO_PORT_PACK(2, 0x28, RZG3S_MPXED_PIN_FUNCS(A)),			/* P16  */
+	RZG2L_GPIO_PORT_PACK(4, 0x29, RZG3S_MPXED_PIN_FUNCS(A)),			/* P17  */
+	RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),			/* P18 */
+};
+
 static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
@@ -1416,6 +1452,46 @@ static const struct {
 	}
 };
 
+static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM |
+						PIN_CFG_FILCLKSEL)) },
+	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IEN |
+						      PIN_CFG_SOFT_PS)) },
+	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
+	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
+	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						     PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						     PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
 {
 	unsigned int gpioint;
@@ -1823,6 +1899,40 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.iolh_groupb_oi = { 100, 66, 50, 33, },
 };
 
+static const struct rzg2l_hwcfg rzg3s_hwcfg = {
+	.regs = {
+		.pwpr = 0x3000,
+		.sd_ch = 0x3004,
+	},
+	.iolh_groupa_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 2200, 4400, 9000, 10000,
+		/* 2v5 power source */
+		[RZG2L_IOLH_IDX_2V5 ... RZG2L_IOLH_IDX_3V3 - 1] = RZG2L_INVALID_IOLH_VAL,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 1900, 4000, 8000, 9000,
+	},
+	.iolh_groupb_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 7000, 8000, 9000, 10000,
+		/* 2v5 power source */
+		[RZG2L_IOLH_IDX_2V5 ... RZG2L_IOLH_IDX_3V3 - 1] = RZG2L_INVALID_IOLH_VAL,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 4000, 6000, 8000, 9000,
+	},
+	.iolh_groupc_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 5200, 6000, 6550, 6800,
+		/* 2v5 source */
+		[RZG2L_IOLH_IDX_2V5] = 4700, 5300, 5800, 6100,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 4500, 5200, 5700, 6050,
+	},
+	.drive_strength_ua = true,
+	.iolh_groupb_oi = { [0 ... 3] = RZG2L_INVALID_IOLH_VAL, },
+	.func_base = 1,
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -1844,6 +1954,16 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.hwcfg = &rzg2l_hwcfg,
 };
 
+static struct rzg2l_pinctrl_data r9a08g045_data = {
+	.port_pins = rzg2l_gpio_names,
+	.port_pin_configs = r9a08g045_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a08g045_gpio_configs),
+	.dedicated_pins = rzg3s_dedicated_pins,
+	.n_port_pins = ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_dedicated_pins = ARRAY_SIZE(rzg3s_dedicated_pins),
+	.hwcfg = &rzg3s_hwcfg,
+};
+
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 	{
 		.compatible = "renesas,r9a07g043-pinctrl",
@@ -1853,6 +1973,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 		.compatible = "renesas,r9a07g044-pinctrl",
 		.data = &r9a07g044_data,
 	},
+	{
+		.compatible = "renesas,r9a08g045-pinctrl",
+		.data = &r9a08g045_data,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.39.2

