Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078579C59B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjILEzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjILEyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3E2135
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31dca134c83so5205542f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494385; x=1695099185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UpewQv8gV1w2PM2MY4PJic7WTCQhdfeCuutZ7ZY/fE=;
        b=Vl4aKSaXdedeFSmt1Co1XENMTlc8dEyQBhHT1kMgaNbZlnBxM4XbfOk774kK4thl4g
         9EI2TYSOTpXboEbr+kSGjmI9sb0dFG1sQokL3mfQmgXqkgYsE+r22QOendr4BUAQ5lQq
         OgmATe8ACXYExjVdBVdjehIso8gWvley5xII6NZAifYnKHvYoD6wnTh+/8B+fITooxQO
         XbGbwboOuedH8qHQCtZvkLhesbNfDAvpkeZaSnjY6sI836Std8laIIM1s3JsMO4CsPOt
         +X2Lcs0GRDHHP0VoiQS2chYnECtjwbOamAYLSZ/6DLi8KHKD9GGjqXWFMMxx/FTupt26
         7Pyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494385; x=1695099185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UpewQv8gV1w2PM2MY4PJic7WTCQhdfeCuutZ7ZY/fE=;
        b=jCAoHIeqUhJClkH0ps+7r7IFmwKsY6rjvH7TBFTOY+qGn2cjpd/y1SuUsVzivrN5Np
         H+5ChCf7w9mmnuVl6SKKf4ZAo5P1S4Li9gVXl9LjTVbhqO5Em37e+g0SZujjn+6jY5D5
         XmETOMH57G3lVCWOPViP/2In6yGm7Ojq/0nOoaXZX19wsT35sh1ASgtuLM6zilRbWi0E
         8kV4mdQzD5LdiIlglPlRJyBKb84xny7sZxjzEtuDLfloSYHYHh2w6YgYdZ6XdgcMLw4W
         eFeP+ofuEvLyEwHrBZN0saDPW7sSgWeaWKEXqjcbm7g1zqZsuAvX8VcyDmH1jIQ5IWgL
         xbmw==
X-Gm-Message-State: AOJu0Yx6UjMP9JRhbpQUWJnEKs/kXKAG1BQtnGjCk1BtgFBnrispdBOw
        OTZPdc8dBcaiSy5ZCWbJC7jElw==
X-Google-Smtp-Source: AGHT+IEm6GWWZIJjg9WOhiUHX2cVZOIO11JV+VkBUtdYWsJUl3tyg+xTicUAbnvbBa4L7Y8Zr1qqCg==
X-Received: by 2002:a5d:6302:0:b0:316:f3cf:6f12 with SMTP id i2-20020a5d6302000000b00316f3cf6f12mr8619597wru.48.1694494385696;
        Mon, 11 Sep 2023 21:53:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:53:05 -0700 (PDT)
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
Subject: [PATCH 24/37] pinctrl: renesas: rzg2l: adapt for different SD, PWPR register offsets
Date:   Tue, 12 Sep 2023 07:51:44 +0300
Message-Id: <20230912045157.177966-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SD, PWPR power registers have different offsets b/w RZ/G2L and RZ/G3S.
Commit adds a per SoC configuration data structure that is initialized with
proper register offset for individual SoCs. The struct rzg2l_hwcfg will be
further extended in next commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 52 ++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6efdf4a424fd..8bdf065aa85b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -98,8 +98,7 @@
 #define IOLH(off)		(0x1000 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
-#define PWPR			(0x3014)
-#define SD_CH(n)		(0x3000 + (n) * 4)
+#define SD_CH(off, ch)		((off) + (ch) * 4)
 #define QSPI			(0x3008)
 
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -124,6 +123,24 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
 
+/**
+ * struct rzg2l_register_offsets - specific register offsets
+ * @pwpr: PWPR register offset
+ * @sd_ch: SD_CH register offset
+ */
+struct rzg2l_register_offsets {
+	u16 pwpr;
+	u16 sd_ch;
+};
+
+/**
+ * struct rzg2l_hwcfg - hardware configuration data structure
+ * @regs: hardware specific register offsets
+ */
+struct rzg2l_hwcfg {
+	const struct rzg2l_register_offsets regs;
+};
+
 struct rzg2l_dedicated_configs {
 	const char *name;
 	u32 config;
@@ -136,6 +153,7 @@ struct rzg2l_pinctrl_data {
 	struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
+	const struct rzg2l_hwcfg *hwcfg;
 };
 
 struct rzg2l_pinctrl {
@@ -163,6 +181,7 @@ static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
 	unsigned long flags;
 	u32 reg;
 
@@ -178,8 +197,8 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
 	/* Set the PWPR register to allow PFC register to write */
-	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
-	writel(PWPR_PFCWE, pctrl->base + PWPR);  /* B0WI=0, PFCWE=1 */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
 
 	/* Select Pin function mode with PFC register */
 	reg = readl(pctrl->base + PFC(off));
@@ -187,8 +206,8 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
 
 	/* Set the PWPR register to be write-protected */
-	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
-	writel(PWPR_B0WI, pctrl->base + PWPR);  /* B0WI=1, PFCWE=0 */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
 
 	/* Switch to Peripheral pin function with PMC register */
 	reg = readb(pctrl->base + PMC(off));
@@ -528,6 +547,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	unsigned int arg = 0;
@@ -563,9 +584,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		u32 pwr_reg = 0x0;
 
 		if (cfg & PIN_CFG_IO_VMC_SD0)
-			pwr_reg = SD_CH(0);
+			pwr_reg = SD_CH(regs->sd_ch, 0);
 		else if (cfg & PIN_CFG_IO_VMC_SD1)
-			pwr_reg = SD_CH(1);
+			pwr_reg = SD_CH(regs->sd_ch, 1);
 		else if (cfg & PIN_CFG_IO_VMC_QSPI)
 			pwr_reg = QSPI;
 		else
@@ -617,6 +638,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	enum pin_config_param param;
 	unsigned long flags;
 	void __iomem *addr;
@@ -660,9 +683,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				return -EINVAL;
 
 			if (cfg & PIN_CFG_IO_VMC_SD0)
-				pwr_reg = SD_CH(0);
+				pwr_reg = SD_CH(regs->sd_ch, 0);
 			else if (cfg & PIN_CFG_IO_VMC_SD1)
-				pwr_reg = SD_CH(1);
+				pwr_reg = SD_CH(regs->sd_ch, 1);
 			else if (cfg & PIN_CFG_IO_VMC_QSPI)
 				pwr_reg = QSPI;
 			else
@@ -1531,6 +1554,13 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_hwcfg rzg2l_hwcfg = {
+	.regs = {
+		.pwpr = 0x3014,
+		.sd_ch = 0x3000,
+	},
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -1538,6 +1568,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
+	.hwcfg = &rzg2l_hwcfg,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -1548,6 +1579,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
+	.hwcfg = &rzg2l_hwcfg,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.39.2

