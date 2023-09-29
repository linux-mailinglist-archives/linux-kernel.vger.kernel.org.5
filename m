Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E87B2BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjI2Fld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjI2Fko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:40:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C6219AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so855982866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965988; x=1696570788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJMR3BIVFc/e2wFbXvT9fkt09KcHBL/X5Epeaz5Mq7I=;
        b=MFRzzpO7Vri7LEKfSDwrRSUib55dVNOFUc8v9IrJHFEF/SocxTP+4rHuZ6JNXj2ICU
         xesAXZkML0RKUk9dtB9bJsJ8d/FgJO8B2OovbV52/7KAZ+a9ZozUywe+tDIl6pEoiITn
         whNlMHw1mCkjsWfEOWu743WNaitL+gHsNUAHGfACXrsdRIlIrgPzIxWyHaQdfBrJAXDp
         pFIBmweu3JQBRb2C1ly74gFNNgDoLmBKeUb97w0/Mb3Thi+EF1eAA0MaeIY3p6OZZw8M
         LIvpV8wkWnJC/htf0qFqUDEMzxUXI22kCb7lcbXarv7TpsFqJrWer0+do9vOjULVfuTK
         Q1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965988; x=1696570788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJMR3BIVFc/e2wFbXvT9fkt09KcHBL/X5Epeaz5Mq7I=;
        b=DIRxEvf5eYp15gSkdrQg3xtfSEmoyO83vsXtPQTlv6i4f+bmaFFQ3cvn6l+4qnkHf0
         OZa9wzA0KXgNc6t9gMKgKH7PJvj+0BaGwJrprFv+4Eh3j1DOzOfymgFZpshO6olPoFex
         OBpvPlDXK9ShEEW81WgoyywbnWctF8k0GLPiFAAZ+uEneALTo0NHVmj9uuMfJl0AfRmA
         azN7hd8BpFklUEDxDiCi5n8vZnyjI96TIdL3w0dEcB2tGZopm/isg9ERUrR54xPyhqnu
         ppqrjwKudgphiiX4cB+u9XxmjRZYmigQUrtLR4K63vZdjPwgfYa/0KDj5QPOGjB3Gi7t
         BSLg==
X-Gm-Message-State: AOJu0YyjNaG06CF3lo3DaEg69+gLu28seRuq9v+xzzKvD33Exc17TpWg
        CRqqsVb64oNdTEpbLu1fQSn30Q==
X-Google-Smtp-Source: AGHT+IEH8UwRnfEoAtSU02uj39eVCy6VKeN9V+ezAcRGQZdw7FRf1xK6KNsGeYM/5L8Sl3UkQUs4aw==
X-Received: by 2002:a17:906:256:b0:9ae:74d1:4b45 with SMTP id 22-20020a170906025600b009ae74d14b45mr3031529ejl.65.1695965988155;
        Thu, 28 Sep 2023 22:39:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:47 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 14/28] pinctrl: renesas: rzg2l: index all registers based on port offset
Date:   Fri, 29 Sep 2023 08:39:01 +0300
Message-Id: <20230929053915.1530607-15-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

To get address that needs to be read/write for specific port
functionalities the P(), PM(), PMC(), PFC(), PIN(), IOLH() IEN(), ISEL()
macros are used. Some of these macros received as argument the hardware
port identifier, some hardware port offset address (e.g. ISEL() received
port identifier, IOLH() received port offset address). This makes hard to
extend the current driver for SoCs were port identifiers are not continuous
in memory map of pin controller. This is the case for RZ/G3S pin controller
were ports are mapped as follows:

port offset    port identifier
-----------    ---------------
0x20           P0
0x21           P5
0x22           P6
0x23           P11
0x24           P12
0x25           P13
0x26           P14
0x27           P15
0x28           P16
0x29           P17
0x2a           P18
0x30           P1
0x31           P2
0x32           P3
0x33           P4
0x34           P7
0x35           P8
0x36           P8
0x37           P10

To make this achievable change all the above macros used to get the address
of a port register for specific port functionality based on port hardware
address. Shortly, all the above macros will get as argument the port
offset address listed in the above table.

With this RZG2L_SINGLE_PIN_GET_PORT_OFFSET(), RZG2L_PIN_ID_TO_PORT_OFFSET()
and RZG2L_GPIO_PORT_GET_INDEX() were replaced by
RZG2L_PIN_CFG_TO_PORT_OFFSET(), RZG2L_SINGLE_PIN_GET_CFGS() and
RZG2L_GPIO_PORT_GET_CFGS() were replaced by RZG2L_PIN_CFG_TO_CAPS().

Also rzg2l_pinctrl_set_pfc_mode() don't need port argument anymore.
Also rzg2l_gpio_direction_input() and rzg2l_gpio_direction_output() don't
need to translate port and bit locally as this can be done by
rzg2l_gpio_set_direction().

To use the same naming for port, bit/pin and register offset the
port_offset variable names in different places was replaced by variable
named off and there is no need to initialize anymore cfg and bit in
different code places.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---

Changes in v2:
- mentioned in commit description about the replacement of
  RZG2L_GPIO_PORT_GET_INDEX() with RZG2L_PIN_CFG_TO_PORT_OFFSET()
- moved variable declaration inside for()
- got rid of local variable and used directly RZG2L_PIN_ID_TO_PORT() in
  debug message from rzg2l_pinctrl_set_mux() function
- collected tags

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 183 ++++++++++++------------
 1 file changed, 95 insertions(+), 88 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 03b36c6b2b6d..96fd829131bd 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -74,8 +74,6 @@
  */
 #define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) | (f))
 #define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
-#define RZG2L_GPIO_PORT_GET_INDEX(x)	(((x) & GENMASK(26, 20)) >> 20)
-#define RZG2L_GPIO_PORT_GET_CFGS(x)	((x) & GENMASK(19, 0))
 
 /*
  * BIT(31) indicates dedicated pin, p is the register index while
@@ -85,18 +83,21 @@
 #define RZG2L_SINGLE_PIN		BIT(31)
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 ((p) << 24) | ((b) << 20) | (f))
-#define RZG2L_SINGLE_PIN_GET_PORT_OFFSET(x)	(((x) & GENMASK(30, 24)) >> 24)
 #define RZG2L_SINGLE_PIN_GET_BIT(x)	(((x) & GENMASK(22, 20)) >> 20)
-#define RZG2L_SINGLE_PIN_GET_CFGS(x)	((x) & GENMASK(19, 0))
-
-#define P(n)			(0x0000 + 0x10 + (n))
-#define PM(n)			(0x0100 + 0x20 + (n) * 2)
-#define PMC(n)			(0x0200 + 0x10 + (n))
-#define PFC(n)			(0x0400 + 0x40 + (n) * 4)
-#define PIN(n)			(0x0800 + 0x10 + (n))
-#define IOLH(n)			(0x1000 + (n) * 8)
-#define IEN(n)			(0x1800 + (n) * 8)
-#define ISEL(n)			(0x2c80 + (n) * 8)
+
+#define RZG2L_PIN_CFG_TO_CAPS(cfg)		((cfg) & GENMASK(19, 0))
+#define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)	((cfg) & RZG2L_SINGLE_PIN ? \
+						(((cfg) & GENMASK(30, 24)) >> 24) : \
+						(((cfg) & GENMASK(26, 20)) >> 20))
+
+#define P(off)			(0x0000 + (off))
+#define PM(off)			(0x0100 + (off) * 2)
+#define PMC(off)		(0x0200 + (off))
+#define PFC(off)		(0x0400 + (off) * 4)
+#define PIN(off)		(0x0800 + (off))
+#define IOLH(off)		(0x1000 + (off) * 8)
+#define IEN(off)		(0x1800 + (off) * 8)
+#define ISEL(off)		(0x2C00 + (off) * 8)
 #define PWPR			(0x3014)
 #define SD_CH(n)		(0x3000 + (n) * 4)
 #define QSPI			(0x3008)
@@ -117,7 +118,6 @@
 #define PM_OUTPUT		0x2
 
 #define RZG2L_PIN_ID_TO_PORT(id)	((id) / RZG2L_PINS_PER_PORT)
-#define RZG2L_PIN_ID_TO_PORT_OFFSET(id)	(RZG2L_PIN_ID_TO_PORT(id) + 0x10)
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
 
 #define RZG2L_TINT_MAX_INTERRUPT	32
@@ -161,7 +161,7 @@ static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
 static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
 
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
-				       u8 port, u8 pin, u8 func)
+				       u8 pin, u8 off, u8 func)
 {
 	unsigned long flags;
 	u32 reg;
@@ -169,30 +169,30 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
-	reg = readw(pctrl->base + PM(port));
+	reg = readw(pctrl->base + PM(off));
 	reg &= ~(PM_MASK << (pin * 2));
-	writew(reg, pctrl->base + PM(port));
+	writew(reg, pctrl->base + PM(off));
 
 	/* Temporarily switch to GPIO mode with PMC register */
-	reg = readb(pctrl->base + PMC(port));
-	writeb(reg & ~BIT(pin), pctrl->base + PMC(port));
+	reg = readb(pctrl->base + PMC(off));
+	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
 	/* Set the PWPR register to allow PFC register to write */
 	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
 	writel(PWPR_PFCWE, pctrl->base + PWPR);  /* B0WI=0, PFCWE=1 */
 
 	/* Select Pin function mode with PFC register */
-	reg = readl(pctrl->base + PFC(port));
+	reg = readl(pctrl->base + PFC(off));
 	reg &= ~(PFC_MASK << (pin * 4));
-	writel(reg | (func << (pin * 4)), pctrl->base + PFC(port));
+	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
 
 	/* Set the PWPR register to be write-protected */
 	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
 	writel(PWPR_B0WI, pctrl->base + PWPR);  /* B0WI=1, PFCWE=0 */
 
 	/* Switch to Peripheral pin function with PMC register */
-	reg = readb(pctrl->base + PMC(port));
-	writeb(reg | BIT(pin), pctrl->base + PMC(port));
+	reg = readb(pctrl->base + PMC(off));
+	writeb(reg | BIT(pin), pctrl->base + PMC(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
@@ -202,9 +202,11 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct pinctrl_pin_desc *pin_desc;
+	unsigned int *psel_val, *pin_data;
 	struct function_desc *func;
-	unsigned int i, *psel_val;
 	struct group_desc *group;
+	u32 pin, off;
 	int *pins;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
@@ -217,12 +219,17 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	psel_val = func->data;
 	pins = group->pins;
 
-	for (i = 0; i < group->num_pins; i++) {
-		dev_dbg(pctrl->dev, "port:%u pin: %u PSEL:%u\n",
-			RZG2L_PIN_ID_TO_PORT(pins[i]), RZG2L_PIN_ID_TO_PIN(pins[i]),
-			psel_val[i]);
-		rzg2l_pinctrl_set_pfc_mode(pctrl, RZG2L_PIN_ID_TO_PORT(pins[i]),
-					   RZG2L_PIN_ID_TO_PIN(pins[i]), psel_val[i]);
+	for (unsigned int i = 0; i < group->num_pins; i++) {
+		pin_desc = &pctrl->desc.pins[pins[i]];
+		pin_data = pin_desc->drv_data;
+
+		pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
+		off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+
+		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
+			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i]);
+
+		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
 	}
 
 	return 0;
@@ -468,14 +475,14 @@ static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
 				   u32 cfg, u32 port, u8 bit)
 {
 	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
-	u32 port_index = RZG2L_GPIO_PORT_GET_INDEX(cfg);
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
 	u32 data;
 
 	if (bit >= pincount || port >= pctrl->data->n_port_pins)
 		return -EINVAL;
 
 	data = pctrl->data->port_pin_configs[port];
-	if (port_index != RZG2L_GPIO_PORT_GET_INDEX(data))
+	if (off != RZG2L_PIN_CFG_TO_PORT_OFFSET(data))
 		return -EINVAL;
 
 	return 0;
@@ -525,20 +532,17 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	unsigned int arg = 0;
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port_offset;
-	u32 cfg = 0;
-	u8 bit = 0;
+	u32 off, cfg;
+	u8 bit;
 
 	if (!pin_data)
 		return -EINVAL;
 
+	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
-		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
 	} else {
-		cfg = RZG2L_GPIO_PORT_GET_CFGS(*pin_data);
-		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
 		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
@@ -549,7 +553,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_ENABLE:
 		if (!(cfg & PIN_CFG_IEN))
 			return -EINVAL;
-		arg = rzg2l_read_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK);
+		arg = rzg2l_read_pin_config(pctrl, IEN(off), bit, IEN_MASK);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -579,7 +583,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		if (!(cfg & PIN_CFG_IOLH_A))
 			return -EINVAL;
 
-		index = rzg2l_read_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK);
+		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
 		arg = iolh_groupa_mA[index];
 		break;
 	}
@@ -590,7 +594,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		if (!(cfg & PIN_CFG_IOLH_B))
 			return -EINVAL;
 
-		index = rzg2l_read_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK);
+		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
 		arg = iolh_groupb_oi[index];
 		break;
 	}
@@ -615,21 +619,18 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	enum pin_config_param param;
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port_offset;
 	unsigned int i;
-	u32 cfg = 0;
-	u8 bit = 0;
+	u32 cfg, off;
+	u8 bit;
 
 	if (!pin_data)
 		return -EINVAL;
 
+	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
-		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
 	} else {
-		cfg = RZG2L_GPIO_PORT_GET_CFGS(*pin_data);
-		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
 		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
@@ -646,7 +647,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
 
-			rzg2l_rmw_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK, !!arg);
+			rzg2l_rmw_pin_config(pctrl, IEN(off), bit, IEN_MASK, !!arg);
 			break;
 		}
 
@@ -687,7 +688,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (index >= ARRAY_SIZE(iolh_groupa_mA))
 				return -EINVAL;
 
-			rzg2l_rmw_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK, index);
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
 		}
 
@@ -705,7 +706,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (index >= ARRAY_SIZE(iolh_groupb_oi))
 				return -EINVAL;
 
-			rzg2l_rmw_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK, index);
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
 		}
 
@@ -795,7 +796,9 @@ static const struct pinconf_ops rzg2l_pinctrl_confops = {
 static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
 	u8 reg8;
@@ -808,28 +811,32 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Select GPIO mode in PMC Register */
-	reg8 = readb(pctrl->base + PMC(port));
+	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
-	writeb(reg8, pctrl->base + PMC(port));
+	writeb(reg8, pctrl->base + PMC(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
 
-static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 port,
-				     u8 bit, bool output)
+static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
+				     bool output)
 {
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
 	u16 reg16;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
 
-	reg16 = readw(pctrl->base + PM(port));
+	reg16 = readw(pctrl->base + PM(off));
 	reg16 &= ~(PM_MASK << (bit * 2));
 
 	reg16 |= (output ? PM_OUTPUT : PM_INPUT) << (bit * 2);
-	writew(reg16, pctrl->base + PM(port));
+	writew(reg16, pctrl->base + PM(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
@@ -837,13 +844,15 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 port,
 static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
-	if (!(readb(pctrl->base + PMC(port)) & BIT(bit))) {
+	if (!(readb(pctrl->base + PMC(off)) & BIT(bit))) {
 		u16 reg16;
 
-		reg16 = readw(pctrl->base + PM(port));
+		reg16 = readw(pctrl->base + PM(off));
 		reg16 = (reg16 >> (bit * 2)) & PM_MASK;
 		if (reg16 == PM_OUTPUT)
 			return GPIO_LINE_DIRECTION_OUT;
@@ -856,10 +865,8 @@ static int rzg2l_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
-	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
-	rzg2l_gpio_set_direction(pctrl, port, bit, false);
+	rzg2l_gpio_set_direction(pctrl, offset, false);
 
 	return 0;
 }
@@ -868,19 +875,21 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
 	u8 reg8;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
 
-	reg8 = readb(pctrl->base + P(port));
+	reg8 = readb(pctrl->base + P(off));
 
 	if (value)
-		writeb(reg8 | BIT(bit), pctrl->base + P(port));
+		writeb(reg8 | BIT(bit), pctrl->base + P(off));
 	else
-		writeb(reg8 & ~BIT(bit), pctrl->base + P(port));
+		writeb(reg8 & ~BIT(bit), pctrl->base + P(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
@@ -889,11 +898,9 @@ static int rzg2l_gpio_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
-	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
 	rzg2l_gpio_set(chip, offset, value);
-	rzg2l_gpio_set_direction(pctrl, port, bit, true);
+	rzg2l_gpio_set_direction(pctrl, offset, true);
 
 	return 0;
 }
@@ -901,17 +908,19 @@ static int rzg2l_gpio_direction_output(struct gpio_chip *chip,
 static int rzg2l_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	u16 reg16;
 
-	reg16 = readw(pctrl->base + PM(port));
+	reg16 = readw(pctrl->base + PM(off));
 	reg16 = (reg16 >> (bit * 2)) & PM_MASK;
 
 	if (reg16 == PM_INPUT)
-		return !!(readb(pctrl->base + PIN(port)) & BIT(bit));
+		return !!(readb(pctrl->base + PIN(off)) & BIT(bit));
 	else if (reg16 == PM_OUTPUT)
-		return !!(readb(pctrl->base + P(port)) & BIT(bit));
+		return !!(readb(pctrl->base + P(off)) & BIT(bit));
 	else
 		return -EINVAL;
 }
@@ -1170,17 +1179,16 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port;
-	u8 bit;
 
 	irq_chip_disable_parent(d);
 
-	port = RZG2L_PIN_ID_TO_PORT(hwirq);
-	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-
-	addr = pctrl->base + ISEL(port);
+	addr = pctrl->base + ISEL(off);
 	if (bit >= 4) {
 		bit -= 4;
 		addr += 4;
@@ -1198,17 +1206,16 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port;
-	u8 bit;
 
 	gpiochip_enable_irq(gc, hwirq);
 
-	port = RZG2L_PIN_ID_TO_PORT(hwirq);
-	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-
-	addr = pctrl->base + ISEL(port);
+	addr = pctrl->base + ISEL(off);
 	if (bit >= 4) {
 		bit -= 4;
 		addr += 4;
-- 
2.39.2

