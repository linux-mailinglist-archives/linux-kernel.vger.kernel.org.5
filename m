Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9839E800B93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378968AbjLANQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378940AbjLANQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:16:20 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC410D;
        Fri,  1 Dec 2023 05:16:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso15983315e9.1;
        Fri, 01 Dec 2023 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701436584; x=1702041384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94+sG/JkMUDSIfa/ScahMURKXx9i5cc80IypUbe+Rhk=;
        b=CM+cAMu41I5LeQkNQa5v9z2kCixiFraUyTeAIj7+AYlVlAUwBqJfQsgkf2RQR883XZ
         zTfj1rhMjZcr2jIj/lKG09R0Ctly7PBgYu47nOol1A9mmudKUyU8TtMeVkLRiPXrbEkk
         kOXcdOuD93G1bF2yYVcV5cdu8K6hE/7r+26rxuQ3Q+cnVEBOuYpMR0zB4k/d61FyGYk6
         j/8oURDEU/KV9Pmpj8Kypp7GyDUHfNEevXw2RyittQHM1uXKPbxrsnVnP0+tdQSjgf86
         Hn2Y3djwpEHMhJTlmdTIlNR7BuWofCuclkkvkCER5zsMq/aV3GZUkobF0274UPpsxwJm
         8iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436584; x=1702041384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94+sG/JkMUDSIfa/ScahMURKXx9i5cc80IypUbe+Rhk=;
        b=LCcZ1RJG1LoYTL2kH40sf3PfGV220b86sLB6UW3Giy57ZMOwRvWDc+6RCYcyCifPKb
         f8omLeZ/OrUFMM/A2pipaFZQuWDHf2yYdPvJyOf2tuy5rorh1Th7h9JgKm3KK5BZbkWw
         cOWsJIedGdnvZSFm5ZxXPSBpr3HGSSHf0cA/SZHDk4axJVajqiqbmozJwMhDJPny8GGe
         3dT2clcf8isGy4TR7eBpQS7UrVOxodKHaiJbiwEDnvHB2ciwrhftTlpxMkWuCABbhTqQ
         dLFXa3MV+fEXJDCCCilltw2FkkewNkfSGzCjFLlx8vcMZic2S3kespDAIpRhxP+glwlh
         L38Q==
X-Gm-Message-State: AOJu0Yxxf8mJiUWEOdqRH+5jusK2u+wwKiEP92C2/2ez4zK9FIKdcJqW
        DQibix/QLxAHqx2ELHG8IfQ=
X-Google-Smtp-Source: AGHT+IEg/M+lSwTzw6WAn0USeJW8SvbNtKVgLocNe+b7EdtTzsIhovM7S6SijYG8pibCv9pxNKWCFw==
X-Received: by 2002:a05:600c:181c:b0:40b:5e59:b7af with SMTP id n28-20020a05600c181c00b0040b5e59b7afmr380229wmp.140.1701436583034;
        Fri, 01 Dec 2023 05:16:23 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:3c2e:cd45:f50f:f083])
        by smtp.gmail.com with ESMTPSA id fm21-20020a05600c0c1500b0040b3dbb5c93sm1451723wmb.1.2023.12.01.05.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:16:22 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-gpio@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/3] pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() macro
Date:   Fri,  1 Dec 2023 13:15:49 +0000
Message-Id: <20231201131551.201503-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Currently we assume all the port pins are sequential ie always PX_0 to
PX_n (n=1..7) exist, but on RZ/Five SoC we have additional pins P19_1 to
P28_5 which have holes in them, for example only one pin on port19 is
available and that is P19_1 and not P19_0. So to handle such cases
include pinmap for each port which would indicate the pin availability
on each port. As the pincount can be calculated based on pinmap drop this
from RZG2L_GPIO_PORT_PACK() macro and update RZG2L_GPIO_PORT_GET_PINCNT()
macro.

Previously we had a max of 7 pins on each port but on RZ/Five Port-20
has 8 pins, so move the single pin configuration to BIT(63).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 50 +++++++++++++------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index aed59c53207c..94d072c8a743 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -80,15 +80,17 @@
  * n indicates number of pins in the port, a is the register index
  * and f is pin configuration capabilities supported.
  */
-#define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) | (f))
-#define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
+#define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) > 0 ? ((u64)(GENMASK_ULL(((n) - 1 + 28), 28))) : 0) | \
+					 ((a) << 20) | (f))
+#define RZG2L_GPIO_PORT_GET_PINMAP(x)	(((x) & GENMASK_ULL(35, 28)) >> 28)
+#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT_GET_PINMAP((x))))
 
 /*
- * BIT(31) indicates dedicated pin, p is the register index while
+ * BIT(63) indicates dedicated pin, p is the register index while
  * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
  * (b * 8) and f is the pin configuration capabilities supported.
  */
-#define RZG2L_SINGLE_PIN		BIT(31)
+#define RZG2L_SINGLE_PIN		BIT_ULL(63)
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 ((p) << 24) | ((b) << 20) | (f))
 #define RZG2L_SINGLE_PIN_GET_BIT(x)	(((x) & GENMASK(22, 20)) >> 20)
@@ -180,12 +182,12 @@ struct rzg2l_hwcfg {
 
 struct rzg2l_dedicated_configs {
 	const char *name;
-	u32 config;
+	u64 config;
 };
 
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
-	const u32 *port_pin_configs;
+	const u64 *port_pin_configs;
 	unsigned int n_ports;
 	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
@@ -286,7 +288,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	pins = group->pins;
 
 	for (i = 0; i < group->num_pins; i++) {
-		unsigned int *pin_data = pctrl->desc.pins[pins[i]].drv_data;
+		u64 *pin_data = pctrl->desc.pins[pins[i]].drv_data;
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
 
@@ -536,13 +538,13 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 }
 
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
-				   u32 cfg, u32 port, u8 bit)
+				   u64 cfg, u32 port, u8 bit)
 {
-	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
+	u8 pinmap = RZG2L_GPIO_PORT_GET_PINMAP(cfg);
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
-	u32 data;
+	u64 data;
 
-	if (bit >= pincount || port >= pctrl->data->n_port_pins)
+	if (!(pinmap & BIT(bit)) || port >= pctrl->data->n_port_pins)
 		return -EINVAL;
 
 	data = pctrl->data->port_pin_configs[port];
@@ -743,7 +745,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	unsigned int arg = 0;
 	u32 off, cfg;
 	int ret;
@@ -840,7 +842,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	enum pin_config_param param;
 	unsigned int i;
 	u32 cfg, off;
@@ -1044,7 +1046,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	u32 *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
@@ -1076,7 +1078,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 				     bool output)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
@@ -1097,7 +1099,7 @@ static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
@@ -1128,7 +1130,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
@@ -1161,7 +1163,7 @@ static int rzg2l_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	u16 reg16;
@@ -1246,7 +1248,7 @@ static const char * const rzg2l_gpio_names[] = {
 	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
 };
 
-static const u32 r9a07g044_gpio_configs[] = {
+static const u64 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
@@ -1298,7 +1300,7 @@ static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a07g043_gpio_configs[] = {
+static const u64 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
@@ -1320,7 +1322,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a08g045_gpio_configs[] = {
+static const u64 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)),	/* P1 */
@@ -1502,7 +1504,7 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
@@ -1529,7 +1531,7 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
@@ -1748,7 +1750,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
-	u32 *pin_data;
+	u64 *pin_data;
 	int ret;
 
 	pctrl->desc.name = DRV_NAME;
-- 
2.34.1

