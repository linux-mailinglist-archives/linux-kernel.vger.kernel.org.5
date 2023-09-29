Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E827B2BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjI2Fmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjI2Flz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:41:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F39E1FD0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so2033059a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 22:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695966001; x=1696570801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PfMtA30yQarNexzGp0RMbiiUyv2vHbUdK/IH8vIF5k=;
        b=Mm30P8P4Nln5Dz3i5pwBRvEXMMS8ci/zMEBxwwZspQQHftTP0X9nT6BUFzyxP4r23c
         9T30ZlWIy58HeYmo5EfDv4nCqtVizNhOJOpXaML/TZt2rwrgqjwY+HxC+vpfFCdz4Sye
         qGWGNJyWDSgGBFwUYmQSvd+7hBIw9CVtmijpeNhTmsAro/PJNVkkz+271zk/WtChMjTq
         oFdMUI7No/YEqJI/ZbbfqJQ3KvBxLRUuvqsLnRuFtxx5i1svRMsTpOnWbjWRac5wANXn
         LAmwxNo9BVsLJnyRmNNTrVYQNhRthg0D6Vqlu2UoQfGEhPza0W7eufRShaKiSBhh39S6
         9dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695966001; x=1696570801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2PfMtA30yQarNexzGp0RMbiiUyv2vHbUdK/IH8vIF5k=;
        b=PlJfDrjm0c7B7i/YYHgcszU+NYjgOPL3rvxLuoLGe87vfWoPY6LowXbd5Pnl+C3h6N
         9+kokZ+6uQs4s4P4eWQKfLA+NDshmoBDKdaoUU4bpwX3CdYONq4+5JvsLJUdvghO03wD
         b/8rga50LEZYz2UO+U4XUe9mOX85NX5iDXOpOJXBPVbELKRryeFAMUX9K7kL5msuZWxg
         Ll/tf8GYsYCJX1OTLznoTXCYIe9d38aq8I8FTBWKwKeuZWjPyRjejrzgPlPvIft1Vmxo
         3Mz8HYFVPShAc0Iqm+3SNGE9fKRIYy/y3LG3dT7q5ij4pgNTpza5c+N8tHuZ0rx/nrxE
         Sd4Q==
X-Gm-Message-State: AOJu0YyZtBI64lWdnHdclM8vA7vu4P1ew+TDPWTPgDLMHp2CUo/gWQVG
        l5xf8c/x3Y8bPJDfYQWsHeDayg==
X-Google-Smtp-Source: AGHT+IFiLBkEUsxDd/kOr/AFMOwfxCGebv9dCLnk6YR2yfJZ12Vk0HKulAaScqCnOkn6q660Cu+Y7Q==
X-Received: by 2002:a17:907:7886:b0:9ae:3a68:93e8 with SMTP id ku6-20020a170907788600b009ae3a6893e8mr3366738ejc.14.1695966001597;
        Thu, 28 Sep 2023 22:40:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:40:01 -0700 (PDT)
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
Subject: [PATCH v2 21/28] pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
Date:   Fri, 29 Sep 2023 08:39:08 +0300
Message-Id: <20230929053915.1530607-22-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v2:
- dropped [RZG2L_IOLH_IDX_2V5 ... RZG2L_IOLH_IDX_3V3 - 1] =
  RZG2L_INVALID_IOLH_VAL initializations from v1 as these are not needed
  anymore with the new code adjustements
- added BUILD_BUG_ON() for r9a08g045_gpio_configs[] in
  rzg2l_pinctrl_probe()

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 126 +++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 8b74838510ad..57af2db445e1 100644
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
@@ -1313,6 +1319,36 @@ static const u32 r9a07g043_gpio_configs[] = {
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
@@ -1399,6 +1435,46 @@ static const struct {
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
@@ -1760,6 +1836,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
+	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -1805,6 +1884,35 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
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
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 1900, 4000, 8000, 9000,
+	},
+	.iolh_groupb_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 7000, 8000, 9000, 10000,
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
+	.func_base = 1,
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -1826,6 +1934,16 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
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
@@ -1835,6 +1953,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
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

