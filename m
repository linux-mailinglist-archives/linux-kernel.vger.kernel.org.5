Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3087F0C29
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjKTHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjKTHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:01:16 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9846D47
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:01:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-408425c7c10so13470475e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700463665; x=1701068465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4yMJimsrnfBvgXM8ijwjI7P7A5CS/3nNHSN0ZDOyWY=;
        b=kWH6T8FgaQwM2etwza9p/QFxPPsoqXL8C8jGOzxKttbMkyu9+a8T8DPYkiPsH7lsDX
         LvgVa3lEhSWYHIKncSP2q/K4yLbplQo1iRnVOrjsV7OHaDTqPW5F4z2B2vx5QJqhKQBc
         VOdj3CBJFFgEfaqrQ+SgE1JdYoDa6AdVo4nmsjeW2RZPjjLVcEUuC/9I0fw36n3ml7UI
         hVN4QyLZvc77bMxNAZrpDay7Y67cS7C66/I1wQQVl9lDFApNP3G2Voy45GkWYwetoO0X
         REIBy6XPXm6o3pcd91TC+riHMgjL2jqoac8W4gnopE8TxJdso4+4V+hV4zEhZ3qR4pgX
         d6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700463665; x=1701068465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4yMJimsrnfBvgXM8ijwjI7P7A5CS/3nNHSN0ZDOyWY=;
        b=Vs9X0zvjwr3dXYrdQ9bbh65Miz3XaYE5yMjEu1uSSObW8ThjqG7PH34K/5421YzmFh
         Ryf+zF5k/am7Km2NZaGe7ZXCMtWyVwvjtQS99ZQQQadzvjkanS9/+u2IsX2zgjHzkPty
         BTQLy+3+k2g3reynTP3xn/Vl81RVCfb18w5ZPl3DJ0v+H/MMhZpmqVM+qSQALnM8AE3f
         6Caqct8pmX253ROrsZhxRtewj0DteyJbn8H0/ocTQzrgwNNTEiDKRVDIBnqk9lJi8s65
         RU2r1RJD7reb/b0G/IywF2rzr2cROLLSp2Hr3wC2dOUeb8StdEeDWatXZc2xNBJrqoSU
         oC9w==
X-Gm-Message-State: AOJu0Yy+1LWK8wY7w7I4cFWEXhF65zUVtMeSBzDgVce/6ZzaS/QZvAou
        68FrKtGHuiKzVP/xZbIykR9bHw==
X-Google-Smtp-Source: AGHT+IF7P3J69VmsHEKrq+E0Aj5Jc4jfgjS3ZoOocWBs1Mss544ir4PsbxqwN50EZj9mHGKGMQAtgg==
X-Received: by 2002:a05:6000:1c0a:b0:331:6c7b:87b5 with SMTP id ba10-20020a0560001c0a00b003316c7b87b5mr5889818wrb.22.1700463665075;
        Sun, 19 Nov 2023 23:01:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm8777667wrq.78.2023.11.19.23.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:01:04 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, claudiu.beznea@tuxon.dev,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 03/14] clk: renesas: rzg2l-cpg: Add support for MSTOP
Date:   Mon, 20 Nov 2023 09:00:13 +0200
Message-Id: <20231120070024.4079344-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
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

RZ/{G2L, V2L, G3S} based CPG versions have support for saving extra
power when clocks are disabled by activating module standby. This is done
though MSTOP specific registers that are part of CPG. Each individual
module have one or more bits associated in one MSTOP register (see table
"Registers for Module Standby Mode" from HW manuals). Hardware manual
associates modules' clocks to one or more MSTOP bits. There are 3 mappings
available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW manuals):

case 1: N clocks mapped to N MSTOP bits (with N={0, ..., X})
case 2: N clocks mapped to 1 MSTOP bit  (with N={0, ..., X})
case 3: N clocks mapped to M MSTOP bits (with N={0, ..., X}, M={0, ..., Y})

Case 3 has been currently identified on RZ/V2L for VCPL4 module.

To cover all 3 cases the individual platform drivers will provide to
clock driver MSTOP register offset and associated bits in this register
as a bitmask and the clock driver will apply this bitmask to proper
MSTOP register.

As most of the modules have more than one clock and these clocks are
mapped to 1 MSTOP bitmap that need to be applied to MSTOP registers,
to avoid switching the module to/out of standby when the module has
enabled/disabled clocks a counter has been associated to each module
(though struct mstop::count) which is incremented/decremented every
time a module's clock is enabled/disabled and the settings to MSTOP
register are applied only when the counter reaches zero (counter zero
means either 1st clock of the module is going to be enabled or all clocks
of the module are going to be disabled).

The MSTOP functionality has been instantiated at the moment for RZ/G3S.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 116 ++++++++++----------
 drivers/clk/renesas/r9a07g044-cpg.c | 158 ++++++++++++++--------------
 drivers/clk/renesas/r9a08g045-cpg.c |  50 ++++++---
 drivers/clk/renesas/r9a09g011-cpg.c | 116 ++++++++++----------
 drivers/clk/renesas/rzg2l-cpg.c     | 104 ++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h     |  21 +++-
 6 files changed, 348 insertions(+), 217 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index b70bb378ab46..7a40bc445054 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -147,124 +147,124 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 #ifdef CONFIG_ARM64
 	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
-				0x514, 0),
+				0x514, 0, 0),
 	DEF_MOD("ia55_pclk",	R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
-				0x518, 0),
+				0x518, 0, 0),
 	DEF_MOD("ia55_clk",	R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
-				0x518, 1),
+				0x518, 1, 0),
 #endif
 #ifdef CONFIG_RISCV
 	DEF_MOD("iax45_pclk",	R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
-				0x518, 0),
+				0x518, 0, 0),
 	DEF_MOD("iax45_clk",	R9A07G043_IAX45_CLK, R9A07G043_CLK_P1,
-				0x518, 1),
+				0x518, 1, 0),
 #endif
 	DEF_MOD("dmac_aclk",	R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
-				0x52c, 0),
+				0x52c, 0, 0),
 	DEF_MOD("dmac_pclk",	R9A07G043_DMAC_PCLK, CLK_P1_DIV2,
-				0x52c, 1),
+				0x52c, 1, 0),
 	DEF_MOD("ostm0_pclk",	R9A07G043_OSTM0_PCLK, R9A07G043_CLK_P0,
-				0x534, 0),
+				0x534, 0, 0),
 	DEF_MOD("ostm1_pclk",	R9A07G043_OSTM1_PCLK, R9A07G043_CLK_P0,
-				0x534, 1),
+				0x534, 1, 0),
 	DEF_MOD("ostm2_pclk",	R9A07G043_OSTM2_PCLK, R9A07G043_CLK_P0,
-				0x534, 2),
+				0x534, 2, 0),
 	DEF_MOD("mtu_x_mck",	R9A07G043_MTU_X_MCK_MTU3, R9A07G043_CLK_P0,
-				0x538, 0),
+				0x538, 0, 0),
 	DEF_MOD("wdt0_pclk",	R9A07G043_WDT0_PCLK, R9A07G043_CLK_P0,
-				0x548, 0),
+				0x548, 0, 0),
 	DEF_MOD("wdt0_clk",	R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
-				0x548, 1),
+				0x548, 1, 0),
 	DEF_MOD("spi_clk2",	R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
-				0x550, 0),
+				0x550, 0, 0),
 	DEF_MOD("spi_clk",	R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
-				0x550, 1),
+				0x550, 1, 0),
 	DEF_MOD("sdhi0_imclk",	R9A07G043_SDHI0_IMCLK, CLK_SD0_DIV4,
-				0x554, 0),
+				0x554, 0, 0),
 	DEF_MOD("sdhi0_imclk2",	R9A07G043_SDHI0_IMCLK2, CLK_SD0_DIV4,
-				0x554, 1),
+				0x554, 1, 0),
 	DEF_MOD("sdhi0_clk_hs",	R9A07G043_SDHI0_CLK_HS, R9A07G043_CLK_SD0,
-				0x554, 2),
+				0x554, 2, 0),
 	DEF_MOD("sdhi0_aclk",	R9A07G043_SDHI0_ACLK, R9A07G043_CLK_P1,
-				0x554, 3),
+				0x554, 3, 0),
 	DEF_MOD("sdhi1_imclk",	R9A07G043_SDHI1_IMCLK, CLK_SD1_DIV4,
-				0x554, 4),
+				0x554, 4, 0),
 	DEF_MOD("sdhi1_imclk2",	R9A07G043_SDHI1_IMCLK2, CLK_SD1_DIV4,
-				0x554, 5),
+				0x554, 5, 0),
 	DEF_MOD("sdhi1_clk_hs",	R9A07G043_SDHI1_CLK_HS, R9A07G043_CLK_SD1,
-				0x554, 6),
+				0x554, 6, 0),
 	DEF_MOD("sdhi1_aclk",	R9A07G043_SDHI1_ACLK, R9A07G043_CLK_P1,
-				0x554, 7),
+				0x554, 7, 0),
 	DEF_MOD("ssi0_pclk",	R9A07G043_SSI0_PCLK2, R9A07G043_CLK_P0,
-				0x570, 0),
+				0x570, 0, 0),
 	DEF_MOD("ssi0_sfr",	R9A07G043_SSI0_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 1),
+				0x570, 1, 0),
 	DEF_MOD("ssi1_pclk",	R9A07G043_SSI1_PCLK2, R9A07G043_CLK_P0,
-				0x570, 2),
+				0x570, 2, 0),
 	DEF_MOD("ssi1_sfr",	R9A07G043_SSI1_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 3),
+				0x570, 3, 0),
 	DEF_MOD("ssi2_pclk",	R9A07G043_SSI2_PCLK2, R9A07G043_CLK_P0,
-				0x570, 4),
+				0x570, 4, 0),
 	DEF_MOD("ssi2_sfr",	R9A07G043_SSI2_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 5),
+				0x570, 5, 0),
 	DEF_MOD("ssi3_pclk",	R9A07G043_SSI3_PCLK2, R9A07G043_CLK_P0,
-				0x570, 6),
+				0x570, 6, 0),
 	DEF_MOD("ssi3_sfr",	R9A07G043_SSI3_PCLK_SFR, R9A07G043_CLK_P0,
-				0x570, 7),
+				0x570, 7, 0),
 	DEF_MOD("usb0_host",	R9A07G043_USB_U2H0_HCLK, R9A07G043_CLK_P1,
-				0x578, 0),
+				0x578, 0, 0),
 	DEF_MOD("usb1_host",	R9A07G043_USB_U2H1_HCLK, R9A07G043_CLK_P1,
-				0x578, 1),
+				0x578, 1, 0),
 	DEF_MOD("usb0_func",	R9A07G043_USB_U2P_EXR_CPUCLK, R9A07G043_CLK_P1,
-				0x578, 2),
+				0x578, 2, 0),
 	DEF_MOD("usb_pclk",	R9A07G043_USB_PCLK, R9A07G043_CLK_P1,
-				0x578, 3),
+				0x578, 3, 0),
 	DEF_COUPLED("eth0_axi",	R9A07G043_ETH0_CLK_AXI, R9A07G043_CLK_M0,
-				0x57c, 0),
+				0x57c, 0, 0),
 	DEF_COUPLED("eth0_chi",	R9A07G043_ETH0_CLK_CHI, R9A07G043_CLK_ZT,
-				0x57c, 0),
+				0x57c, 0, 0),
 	DEF_COUPLED("eth1_axi",	R9A07G043_ETH1_CLK_AXI, R9A07G043_CLK_M0,
-				0x57c, 1),
+				0x57c, 1, 0),
 	DEF_COUPLED("eth1_chi",	R9A07G043_ETH1_CLK_CHI, R9A07G043_CLK_ZT,
-				0x57c, 1),
+				0x57c, 1, 0),
 	DEF_MOD("i2c0",		R9A07G043_I2C0_PCLK, R9A07G043_CLK_P0,
-				0x580, 0),
+				0x580, 0, 0),
 	DEF_MOD("i2c1",		R9A07G043_I2C1_PCLK, R9A07G043_CLK_P0,
-				0x580, 1),
+				0x580, 1, 0),
 	DEF_MOD("i2c2",		R9A07G043_I2C2_PCLK, R9A07G043_CLK_P0,
-				0x580, 2),
+				0x580, 2, 0),
 	DEF_MOD("i2c3",		R9A07G043_I2C3_PCLK, R9A07G043_CLK_P0,
-				0x580, 3),
+				0x580, 3, 0),
 	DEF_MOD("scif0",	R9A07G043_SCIF0_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 0),
+				0x584, 0, 0),
 	DEF_MOD("scif1",	R9A07G043_SCIF1_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 1),
+				0x584, 1, 0),
 	DEF_MOD("scif2",	R9A07G043_SCIF2_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 2),
+				0x584, 2, 0),
 	DEF_MOD("scif3",	R9A07G043_SCIF3_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 3),
+				0x584, 3, 0),
 	DEF_MOD("scif4",	R9A07G043_SCIF4_CLK_PCK, R9A07G043_CLK_P0,
-				0x584, 4),
+				0x584, 4, 0),
 	DEF_MOD("sci0",		R9A07G043_SCI0_CLKP, R9A07G043_CLK_P0,
-				0x588, 0),
+				0x588, 0, 0),
 	DEF_MOD("sci1",		R9A07G043_SCI1_CLKP, R9A07G043_CLK_P0,
-				0x588, 1),
+				0x588, 1, 0),
 	DEF_MOD("rspi0",	R9A07G043_RSPI0_CLKB, R9A07G043_CLK_P0,
-				0x590, 0),
+				0x590, 0, 0),
 	DEF_MOD("rspi1",	R9A07G043_RSPI1_CLKB, R9A07G043_CLK_P0,
-				0x590, 1),
+				0x590, 1, 0),
 	DEF_MOD("rspi2",	R9A07G043_RSPI2_CLKB, R9A07G043_CLK_P0,
-				0x590, 2),
+				0x590, 2, 0),
 	DEF_MOD("canfd",	R9A07G043_CANFD_PCLK, R9A07G043_CLK_P0,
-				0x594, 0),
+				0x594, 0, 0),
 	DEF_MOD("gpio",		R9A07G043_GPIO_HCLK, R9A07G043_OSCCLK,
-				0x598, 0),
+				0x598, 0, 0),
 	DEF_MOD("adc_adclk",	R9A07G043_ADC_ADCLK, R9A07G043_CLK_TSU,
-				0x5a8, 0),
+				0x5a8, 0, 0),
 	DEF_MOD("adc_pclk",	R9A07G043_ADC_PCLK, R9A07G043_CLK_P0,
-				0x5a8, 1),
+				0x5a8, 1, 0),
 	DEF_MOD("tsu_pclk",	R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
-				0x5ac, 0),
+				0x5ac, 0, 0),
 };
 
 static struct rzg2l_reset r9a07g043_resets[] = {
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 1047278c9079..ed0c17341803 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -204,163 +204,163 @@ static const struct {
 } mod_clks = {
 	.common = {
 		DEF_MOD("gic",		R9A07G044_GIC600_GICCLK, R9A07G044_CLK_P1,
-					0x514, 0),
+					0x514, 0, 0),
 		DEF_MOD("ia55_pclk",	R9A07G044_IA55_PCLK, R9A07G044_CLK_P2,
-					0x518, 0),
+					0x518, 0, 0),
 		DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
-					0x518, 1),
+					0x518, 1, 0),
 		DEF_MOD("dmac_aclk",	R9A07G044_DMAC_ACLK, R9A07G044_CLK_P1,
-					0x52c, 0),
+					0x52c, 0, 0),
 		DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
-					0x52c, 1),
+					0x52c, 1, 0),
 		DEF_MOD("ostm0_pclk",	R9A07G044_OSTM0_PCLK, R9A07G044_CLK_P0,
-					0x534, 0),
+					0x534, 0, 0),
 		DEF_MOD("ostm1_pclk",	R9A07G044_OSTM1_PCLK, R9A07G044_CLK_P0,
-					0x534, 1),
+					0x534, 1, 0),
 		DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
-					0x534, 2),
+					0x534, 2, 0),
 		DEF_MOD("mtu_x_mck",	R9A07G044_MTU_X_MCK_MTU3, R9A07G044_CLK_P0,
-					0x538, 0),
+					0x538, 0, 0),
 		DEF_MOD("gpt_pclk",	R9A07G044_GPT_PCLK, R9A07G044_CLK_P0,
-					0x540, 0),
+					0x540, 0, 0),
 		DEF_MOD("poeg_a_clkp",	R9A07G044_POEG_A_CLKP, R9A07G044_CLK_P0,
-					0x544, 0),
+					0x544, 0, 0),
 		DEF_MOD("poeg_b_clkp",	R9A07G044_POEG_B_CLKP, R9A07G044_CLK_P0,
-					0x544, 1),
+					0x544, 1, 0),
 		DEF_MOD("poeg_c_clkp",	R9A07G044_POEG_C_CLKP, R9A07G044_CLK_P0,
-					0x544, 2),
+					0x544, 2, 0),
 		DEF_MOD("poeg_d_clkp",	R9A07G044_POEG_D_CLKP, R9A07G044_CLK_P0,
-					0x544, 3),
+					0x544, 3, 0),
 		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
-					0x548, 0),
+					0x548, 0, 0),
 		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
-					0x548, 1),
+					0x548, 1, 0),
 		DEF_MOD("wdt1_pclk",	R9A07G044_WDT1_PCLK, R9A07G044_CLK_P0,
-					0x548, 2),
+					0x548, 2, 0),
 		DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
-					0x548, 3),
+					0x548, 3, 0),
 		DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
-					0x550, 0),
+					0x550, 0, 0),
 		DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
-					0x550, 1),
+					0x550, 1, 0),
 		DEF_MOD("sdhi0_imclk",	R9A07G044_SDHI0_IMCLK, CLK_SD0_DIV4,
-					0x554, 0),
+					0x554, 0, 0),
 		DEF_MOD("sdhi0_imclk2",	R9A07G044_SDHI0_IMCLK2, CLK_SD0_DIV4,
-					0x554, 1),
+					0x554, 1, 0),
 		DEF_MOD("sdhi0_clk_hs",	R9A07G044_SDHI0_CLK_HS, R9A07G044_CLK_SD0,
-					0x554, 2),
+					0x554, 2, 0),
 		DEF_MOD("sdhi0_aclk",	R9A07G044_SDHI0_ACLK, R9A07G044_CLK_P1,
-					0x554, 3),
+					0x554, 3, 0),
 		DEF_MOD("sdhi1_imclk",	R9A07G044_SDHI1_IMCLK, CLK_SD1_DIV4,
-					0x554, 4),
+					0x554, 4, 0),
 		DEF_MOD("sdhi1_imclk2",	R9A07G044_SDHI1_IMCLK2, CLK_SD1_DIV4,
-					0x554, 5),
+					0x554, 5, 0),
 		DEF_MOD("sdhi1_clk_hs",	R9A07G044_SDHI1_CLK_HS, R9A07G044_CLK_SD1,
-					0x554, 6),
+					0x554, 6, 0),
 		DEF_MOD("sdhi1_aclk",	R9A07G044_SDHI1_ACLK, R9A07G044_CLK_P1,
-					0x554, 7),
+					0x554, 7, 0),
 		DEF_MOD("gpu_clk",	R9A07G044_GPU_CLK, R9A07G044_CLK_G,
-					0x558, 0),
+					0x558, 0, 0),
 		DEF_MOD("gpu_axi_clk",	R9A07G044_GPU_AXI_CLK, R9A07G044_CLK_P1,
-					0x558, 1),
+					0x558, 1, 0),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
-					0x558, 2),
+					0x558, 2, 0),
 		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
-					0x564, 0),
+					0x564, 0, 0),
 		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
-					0x564, 1),
+					0x564, 1, 0),
 		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
-					0x564, 2),
+					0x564, 2, 0),
 		DEF_MOD("cru_aclk",     R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
-					0x564, 3),
+					0x564, 3, 0),
 		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
-					0x568, 0),
+					0x568, 0, 0),
 		DEF_MOD("dsi_sys_clk",	R9A07G044_MIPI_DSI_SYSCLK, CLK_M2_DIV2,
-					0x568, 1),
+					0x568, 1, 0),
 		DEF_MOD("dsi_aclk",	R9A07G044_MIPI_DSI_ACLK, R9A07G044_CLK_P1,
-					0x568, 2),
+					0x568, 2, 0),
 		DEF_MOD("dsi_pclk",	R9A07G044_MIPI_DSI_PCLK, R9A07G044_CLK_P2,
-					0x568, 3),
+					0x568, 3, 0),
 		DEF_MOD("dsi_vclk",	R9A07G044_MIPI_DSI_VCLK, R9A07G044_CLK_M3,
-					0x568, 4),
+					0x568, 4, 0),
 		DEF_MOD("dsi_lpclk",	R9A07G044_MIPI_DSI_LPCLK, R9A07G044_CLK_M4,
-					0x568, 5),
+					0x568, 5, 0),
 		DEF_COUPLED("lcdc_a",	R9A07G044_LCDC_CLK_A, R9A07G044_CLK_M0,
-					0x56c, 0),
+					0x56c, 0, 0),
 		DEF_COUPLED("lcdc_p",	R9A07G044_LCDC_CLK_P, R9A07G044_CLK_ZT,
-					0x56c, 0),
+					0x56c, 0, 0),
 		DEF_MOD("lcdc_clk_d",	R9A07G044_LCDC_CLK_D, R9A07G044_CLK_M3,
-					0x56c, 1),
+					0x56c, 1, 0),
 		DEF_MOD("ssi0_pclk",	R9A07G044_SSI0_PCLK2, R9A07G044_CLK_P0,
-					0x570, 0),
+					0x570, 0, 0),
 		DEF_MOD("ssi0_sfr",	R9A07G044_SSI0_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 1),
+					0x570, 1, 0),
 		DEF_MOD("ssi1_pclk",	R9A07G044_SSI1_PCLK2, R9A07G044_CLK_P0,
-					0x570, 2),
+					0x570, 2, 0),
 		DEF_MOD("ssi1_sfr",	R9A07G044_SSI1_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 3),
+					0x570, 3, 0),
 		DEF_MOD("ssi2_pclk",	R9A07G044_SSI2_PCLK2, R9A07G044_CLK_P0,
-					0x570, 4),
+					0x570, 4, 0),
 		DEF_MOD("ssi2_sfr",	R9A07G044_SSI2_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 5),
+					0x570, 5, 0),
 		DEF_MOD("ssi3_pclk",	R9A07G044_SSI3_PCLK2, R9A07G044_CLK_P0,
-					0x570, 6),
+					0x570, 6, 0),
 		DEF_MOD("ssi3_sfr",	R9A07G044_SSI3_PCLK_SFR, R9A07G044_CLK_P0,
-					0x570, 7),
+					0x570, 7, 0),
 		DEF_MOD("usb0_host",	R9A07G044_USB_U2H0_HCLK, R9A07G044_CLK_P1,
-					0x578, 0),
+					0x578, 0, 0),
 		DEF_MOD("usb1_host",	R9A07G044_USB_U2H1_HCLK, R9A07G044_CLK_P1,
-					0x578, 1),
+					0x578, 1, 0),
 		DEF_MOD("usb0_func",	R9A07G044_USB_U2P_EXR_CPUCLK, R9A07G044_CLK_P1,
-					0x578, 2),
+					0x578, 2, 0),
 		DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
-					0x578, 3),
+					0x578, 3, 0),
 		DEF_COUPLED("eth0_axi",	R9A07G044_ETH0_CLK_AXI, R9A07G044_CLK_M0,
-					0x57c, 0),
+					0x57c, 0, 0),
 		DEF_COUPLED("eth0_chi",	R9A07G044_ETH0_CLK_CHI, R9A07G044_CLK_ZT,
-					0x57c, 0),
+					0x57c, 0, 0),
 		DEF_COUPLED("eth1_axi",	R9A07G044_ETH1_CLK_AXI, R9A07G044_CLK_M0,
-					0x57c, 1),
+					0x57c, 1, 0),
 		DEF_COUPLED("eth1_chi",	R9A07G044_ETH1_CLK_CHI, R9A07G044_CLK_ZT,
-					0x57c, 1),
+					0x57c, 1, 0),
 		DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
-					0x580, 0),
+					0x580, 0, 0),
 		DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
-					0x580, 1),
+					0x580, 1, 0),
 		DEF_MOD("i2c2",		R9A07G044_I2C2_PCLK, R9A07G044_CLK_P0,
-					0x580, 2),
+					0x580, 2, 0),
 		DEF_MOD("i2c3",		R9A07G044_I2C3_PCLK, R9A07G044_CLK_P0,
-					0x580, 3),
+					0x580, 3, 0),
 		DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 0),
+					0x584, 0, 0),
 		DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 1),
+					0x584, 1, 0),
 		DEF_MOD("scif2",	R9A07G044_SCIF2_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 2),
+					0x584, 2, 0),
 		DEF_MOD("scif3",	R9A07G044_SCIF3_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 3),
+					0x584, 3, 0),
 		DEF_MOD("scif4",	R9A07G044_SCIF4_CLK_PCK, R9A07G044_CLK_P0,
-					0x584, 4),
+					0x584, 4, 0),
 		DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
-					0x588, 0),
+					0x588, 0, 0),
 		DEF_MOD("sci1",		R9A07G044_SCI1_CLKP, R9A07G044_CLK_P0,
-					0x588, 1),
+					0x588, 1, 0),
 		DEF_MOD("rspi0",	R9A07G044_RSPI0_CLKB, R9A07G044_CLK_P0,
-					0x590, 0),
+					0x590, 0, 0),
 		DEF_MOD("rspi1",	R9A07G044_RSPI1_CLKB, R9A07G044_CLK_P0,
-					0x590, 1),
+					0x590, 1, 0),
 		DEF_MOD("rspi2",	R9A07G044_RSPI2_CLKB, R9A07G044_CLK_P0,
-					0x590, 2),
+					0x590, 2, 0),
 		DEF_MOD("canfd",	R9A07G044_CANFD_PCLK, R9A07G044_CLK_P0,
-					0x594, 0),
+					0x594, 0, 0),
 		DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
-					0x598, 0),
+					0x598, 0, 0),
 		DEF_MOD("adc_adclk",	R9A07G044_ADC_ADCLK, R9A07G044_CLK_TSU,
-					0x5a8, 0),
+					0x5a8, 0, 0),
 		DEF_MOD("adc_pclk",	R9A07G044_ADC_PCLK, R9A07G044_CLK_P0,
-					0x5a8, 1),
+					0x5a8, 1, 0),
 		DEF_MOD("tsu_pclk",	R9A07G044_TSU_PCLK, R9A07G044_CLK_TSU,
-					0x5ac, 0),
+					0x5ac, 0, 0),
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index 4394cb241d99..6ff40763a00a 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -187,23 +187,39 @@ static const struct cpg_core_clk r9a08g045_core_clks[] __initconst = {
 };
 
 static const struct rzg2l_mod_clk r9a08g045_mod_clks[] = {
-	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0),
-	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1),
-	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0),
-	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0),
-	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1),
-	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2),
-	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3),
-	DEF_MOD("sdhi1_imclk",		R9A08G045_SDHI1_IMCLK, CLK_SD1_DIV4, 0x554, 4),
-	DEF_MOD("sdhi1_imclk2",		R9A08G045_SDHI1_IMCLK2, CLK_SD1_DIV4, 0x554, 5),
-	DEF_MOD("sdhi1_clk_hs",		R9A08G045_SDHI1_CLK_HS, R9A08G045_CLK_SD1, 0x554, 6),
-	DEF_MOD("sdhi1_aclk",		R9A08G045_SDHI1_ACLK, R9A08G045_CLK_P1, 0x554, 7),
-	DEF_MOD("sdhi2_imclk",		R9A08G045_SDHI2_IMCLK, CLK_SD2_DIV4, 0x554, 8),
-	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9),
-	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10),
-	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11),
-	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0),
-	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0),
+	DEF_MOD("gic_gicclk",		R9A08G045_GIC600_GICCLK, R9A08G045_CLK_P1, 0x514, 0,
+					MSTOP(ACPU, BIT(3))),
+	DEF_MOD("ia55_clk",		R9A08G045_IA55_CLK, R9A08G045_CLK_P1, 0x518, 1,
+					MSTOP(PERI_CPU, BIT(13))),
+	DEF_MOD("dmac_aclk",		R9A08G045_DMAC_ACLK, R9A08G045_CLK_P3, 0x52c, 0,
+					MSTOP(REG1, BIT(2))),
+	DEF_MOD("sdhi0_imclk",		R9A08G045_SDHI0_IMCLK, CLK_SD0_DIV4, 0x554, 0,
+					MSTOP(PERI_COM, BIT(0))),
+	DEF_MOD("sdhi0_imclk2",		R9A08G045_SDHI0_IMCLK2, CLK_SD0_DIV4, 0x554, 1,
+					MSTOP(PERI_COM, BIT(0))),
+	DEF_MOD("sdhi0_clk_hs",		R9A08G045_SDHI0_CLK_HS, R9A08G045_CLK_SD0, 0x554, 2,
+					MSTOP(PERI_COM, BIT(0))),
+	DEF_MOD("sdhi0_aclk",		R9A08G045_SDHI0_ACLK, R9A08G045_CLK_P1, 0x554, 3,
+					MSTOP(PERI_COM, BIT(0))),
+	DEF_MOD("sdhi1_imclk",		R9A08G045_SDHI1_IMCLK, CLK_SD1_DIV4, 0x554, 4,
+					MSTOP(PERI_COM, BIT(1))),
+	DEF_MOD("sdhi1_imclk2",		R9A08G045_SDHI1_IMCLK2, CLK_SD1_DIV4, 0x554, 5,
+					MSTOP(PERI_COM, BIT(1))),
+	DEF_MOD("sdhi1_clk_hs",		R9A08G045_SDHI1_CLK_HS, R9A08G045_CLK_SD1, 0x554, 6,
+					MSTOP(PERI_COM, BIT(1))),
+	DEF_MOD("sdhi1_aclk",		R9A08G045_SDHI1_ACLK, R9A08G045_CLK_P1, 0x554, 7,
+					MSTOP(PERI_COM, BIT(1))),
+	DEF_MOD("sdhi2_imclk",		R9A08G045_SDHI2_IMCLK, CLK_SD2_DIV4, 0x554, 8,
+					MSTOP(PERI_COM, BIT(11))),
+	DEF_MOD("sdhi2_imclk2",		R9A08G045_SDHI2_IMCLK2, CLK_SD2_DIV4, 0x554, 9,
+					MSTOP(PERI_COM, BIT(11))),
+	DEF_MOD("sdhi2_clk_hs",		R9A08G045_SDHI2_CLK_HS, R9A08G045_CLK_SD2, 0x554, 10,
+					MSTOP(PERI_COM, BIT(11))),
+	DEF_MOD("sdhi2_aclk",		R9A08G045_SDHI2_ACLK, R9A08G045_CLK_P1, 0x554, 11,
+					MSTOP(PERI_COM, BIT(11))),
+	DEF_MOD("scif0_clk_pck",	R9A08G045_SCIF0_CLK_PCK, R9A08G045_CLK_P0, 0x584, 0,
+					MSTOP(MCPU2, BIT(1))),
+	DEF_MOD("gpio_hclk",		R9A08G045_GPIO_HCLK, R9A08G045_OSCCLK, 0x598, 0, 0),
 };
 
 static const struct rzg2l_reset r9a08g045_resets[] = {
diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index dda9f29dff33..eae408f8604a 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -152,64 +152,64 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 };
 
 static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
-	DEF_MOD("pfc",		R9A09G011_PFC_PCLK,	 CLK_MAIN,     0x400, 2),
-	DEF_MOD("gic",		R9A09G011_GIC_CLK,	 CLK_SEL_B_D2, 0x400, 5),
-	DEF_MOD("sdi0_aclk",	R9A09G011_SDI0_ACLK,	 CLK_SEL_D,    0x408, 0),
-	DEF_MOD("sdi0_imclk",	R9A09G011_SDI0_IMCLK,	 CLK_SEL_SDI,  0x408, 1),
-	DEF_MOD("sdi0_imclk2",	R9A09G011_SDI0_IMCLK2,	 CLK_SEL_SDI,  0x408, 2),
-	DEF_MOD("sdi0_clk_hs",	R9A09G011_SDI0_CLK_HS,	 CLK_PLL2_800, 0x408, 3),
-	DEF_MOD("sdi1_aclk",	R9A09G011_SDI1_ACLK,	 CLK_SEL_D,    0x408, 4),
-	DEF_MOD("sdi1_imclk",	R9A09G011_SDI1_IMCLK,	 CLK_SEL_SDI,  0x408, 5),
-	DEF_MOD("sdi1_imclk2",	R9A09G011_SDI1_IMCLK2,	 CLK_SEL_SDI,  0x408, 6),
-	DEF_MOD("sdi1_clk_hs",	R9A09G011_SDI1_CLK_HS,	 CLK_PLL2_800, 0x408, 7),
-	DEF_MOD("emm_aclk",	R9A09G011_EMM_ACLK,	 CLK_SEL_D,    0x408, 8),
-	DEF_MOD("emm_imclk",	R9A09G011_EMM_IMCLK,	 CLK_SEL_SDI,  0x408, 9),
-	DEF_MOD("emm_imclk2",	R9A09G011_EMM_IMCLK2,	 CLK_SEL_SDI,  0x408, 10),
-	DEF_MOD("emm_clk_hs",	R9A09G011_EMM_CLK_HS,	 CLK_PLL2_800, 0x408, 11),
-	DEF_COUPLED("eth_axi",	R9A09G011_ETH0_CLK_AXI,	 CLK_PLL2_200, 0x40c, 8),
-	DEF_COUPLED("eth_chi",	R9A09G011_ETH0_CLK_CHI,	 CLK_PLL2_100, 0x40c, 8),
-	DEF_MOD("eth_clk_gptp",	R9A09G011_ETH0_GPTP_EXT, CLK_PLL2_100, 0x40c, 9),
-	DEF_MOD("usb_aclk_h",	R9A09G011_USB_ACLK_H,	 CLK_SEL_D,    0x40c, 4),
-	DEF_MOD("usb_aclk_p",	R9A09G011_USB_ACLK_P,	 CLK_SEL_D,    0x40c, 5),
-	DEF_MOD("usb_pclk",	R9A09G011_USB_PCLK,	 CLK_SEL_E,    0x40c, 6),
-	DEF_MOD("syc_cnt_clk",	R9A09G011_SYC_CNT_CLK,	 CLK_MAIN_24,  0x41c, 12),
-	DEF_MOD("iic_pclk0",	R9A09G011_IIC_PCLK0,	 CLK_SEL_E,    0x420, 12),
-	DEF_MOD("cperi_grpb",	R9A09G011_CPERI_GRPB_PCLK, CLK_SEL_E,  0x424, 0),
-	DEF_MOD("tim_clk_8",	R9A09G011_TIM8_CLK,	 CLK_MAIN_2,   0x424, 4),
-	DEF_MOD("tim_clk_9",	R9A09G011_TIM9_CLK,	 CLK_MAIN_2,   0x424, 5),
-	DEF_MOD("tim_clk_10",	R9A09G011_TIM10_CLK,	 CLK_MAIN_2,   0x424, 6),
-	DEF_MOD("tim_clk_11",	R9A09G011_TIM11_CLK,	 CLK_MAIN_2,   0x424, 7),
-	DEF_MOD("tim_clk_12",	R9A09G011_TIM12_CLK,	 CLK_MAIN_2,   0x424, 8),
-	DEF_MOD("tim_clk_13",	R9A09G011_TIM13_CLK,	 CLK_MAIN_2,   0x424, 9),
-	DEF_MOD("tim_clk_14",	R9A09G011_TIM14_CLK,	 CLK_MAIN_2,   0x424, 10),
-	DEF_MOD("tim_clk_15",	R9A09G011_TIM15_CLK,	 CLK_MAIN_2,   0x424, 11),
-	DEF_MOD("iic_pclk1",	R9A09G011_IIC_PCLK1,	 CLK_SEL_E,    0x424, 12),
-	DEF_MOD("cperi_grpc",	R9A09G011_CPERI_GRPC_PCLK, CLK_SEL_E,  0x428, 0),
-	DEF_MOD("tim_clk_16",	R9A09G011_TIM16_CLK,	 CLK_MAIN_2,   0x428, 4),
-	DEF_MOD("tim_clk_17",	R9A09G011_TIM17_CLK,	 CLK_MAIN_2,   0x428, 5),
-	DEF_MOD("tim_clk_18",	R9A09G011_TIM18_CLK,	 CLK_MAIN_2,   0x428, 6),
-	DEF_MOD("tim_clk_19",	R9A09G011_TIM19_CLK,	 CLK_MAIN_2,   0x428, 7),
-	DEF_MOD("tim_clk_20",	R9A09G011_TIM20_CLK,	 CLK_MAIN_2,   0x428, 8),
-	DEF_MOD("tim_clk_21",	R9A09G011_TIM21_CLK,	 CLK_MAIN_2,   0x428, 9),
-	DEF_MOD("tim_clk_22",	R9A09G011_TIM22_CLK,	 CLK_MAIN_2,   0x428, 10),
-	DEF_MOD("tim_clk_23",	R9A09G011_TIM23_CLK,	 CLK_MAIN_2,   0x428, 11),
-	DEF_MOD("wdt0_pclk",	R9A09G011_WDT0_PCLK,	 CLK_SEL_E,    0x428, 12),
-	DEF_MOD("wdt0_clk",	R9A09G011_WDT0_CLK,	 CLK_MAIN,     0x428, 13),
-	DEF_MOD("cperi_grpf",	R9A09G011_CPERI_GRPF_PCLK, CLK_SEL_E,  0x434, 0),
-	DEF_MOD("pwm8_clk",	R9A09G011_PWM8_CLK,	 CLK_MAIN,     0x434, 4),
-	DEF_MOD("pwm9_clk",	R9A09G011_PWM9_CLK,	 CLK_MAIN,     0x434, 5),
-	DEF_MOD("pwm10_clk",	R9A09G011_PWM10_CLK,	 CLK_MAIN,     0x434, 6),
-	DEF_MOD("pwm11_clk",	R9A09G011_PWM11_CLK,	 CLK_MAIN,     0x434, 7),
-	DEF_MOD("pwm12_clk",	R9A09G011_PWM12_CLK,	 CLK_MAIN,     0x434, 8),
-	DEF_MOD("pwm13_clk",	R9A09G011_PWM13_CLK,	 CLK_MAIN,     0x434, 9),
-	DEF_MOD("pwm14_clk",	R9A09G011_PWM14_CLK,	 CLK_MAIN,     0x434, 10),
-	DEF_MOD("cperi_grpg",	R9A09G011_CPERI_GRPG_PCLK, CLK_SEL_E,  0x438, 0),
-	DEF_MOD("cperi_grph",	R9A09G011_CPERI_GRPH_PCLK, CLK_SEL_E,  0x438, 1),
-	DEF_MOD("urt_pclk",	R9A09G011_URT_PCLK,	 CLK_SEL_E,    0x438, 4),
-	DEF_MOD("urt0_clk",	R9A09G011_URT0_CLK,	 CLK_SEL_W0,   0x438, 5),
-	DEF_MOD("csi0_clk",	R9A09G011_CSI0_CLK,	 CLK_SEL_CSI0, 0x438, 8),
-	DEF_MOD("csi4_clk",	R9A09G011_CSI4_CLK,	 CLK_SEL_CSI4, 0x438, 12),
-	DEF_MOD("ca53",		R9A09G011_CA53_CLK,	 CLK_DIV_A,    0x448, 0),
+	DEF_MOD("pfc",		R9A09G011_PFC_PCLK,	 CLK_MAIN,     0x400, 2, 0),
+	DEF_MOD("gic",		R9A09G011_GIC_CLK,	 CLK_SEL_B_D2, 0x400, 5, 0),
+	DEF_MOD("sdi0_aclk",	R9A09G011_SDI0_ACLK,	 CLK_SEL_D,    0x408, 0, 0),
+	DEF_MOD("sdi0_imclk",	R9A09G011_SDI0_IMCLK,	 CLK_SEL_SDI,  0x408, 1, 0),
+	DEF_MOD("sdi0_imclk2",	R9A09G011_SDI0_IMCLK2,	 CLK_SEL_SDI,  0x408, 2, 0),
+	DEF_MOD("sdi0_clk_hs",	R9A09G011_SDI0_CLK_HS,	 CLK_PLL2_800, 0x408, 3, 0),
+	DEF_MOD("sdi1_aclk",	R9A09G011_SDI1_ACLK,	 CLK_SEL_D,    0x408, 4, 0),
+	DEF_MOD("sdi1_imclk",	R9A09G011_SDI1_IMCLK,	 CLK_SEL_SDI,  0x408, 5, 0),
+	DEF_MOD("sdi1_imclk2",	R9A09G011_SDI1_IMCLK2,	 CLK_SEL_SDI,  0x408, 6, 0),
+	DEF_MOD("sdi1_clk_hs",	R9A09G011_SDI1_CLK_HS,	 CLK_PLL2_800, 0x408, 7, 0),
+	DEF_MOD("emm_aclk",	R9A09G011_EMM_ACLK,	 CLK_SEL_D,    0x408, 8, 0),
+	DEF_MOD("emm_imclk",	R9A09G011_EMM_IMCLK,	 CLK_SEL_SDI,  0x408, 9, 0),
+	DEF_MOD("emm_imclk2",	R9A09G011_EMM_IMCLK2,	 CLK_SEL_SDI,  0x408, 10, 0),
+	DEF_MOD("emm_clk_hs",	R9A09G011_EMM_CLK_HS,	 CLK_PLL2_800, 0x408, 11, 0),
+	DEF_COUPLED("eth_axi",	R9A09G011_ETH0_CLK_AXI,	 CLK_PLL2_200, 0x40c, 8, 0),
+	DEF_COUPLED("eth_chi",	R9A09G011_ETH0_CLK_CHI,	 CLK_PLL2_100, 0x40c, 8, 0),
+	DEF_MOD("eth_clk_gptp",	R9A09G011_ETH0_GPTP_EXT, CLK_PLL2_100, 0x40c, 9, 0),
+	DEF_MOD("usb_aclk_h",	R9A09G011_USB_ACLK_H,	 CLK_SEL_D,    0x40c, 4, 0),
+	DEF_MOD("usb_aclk_p",	R9A09G011_USB_ACLK_P,	 CLK_SEL_D,    0x40c, 5, 0),
+	DEF_MOD("usb_pclk",	R9A09G011_USB_PCLK,	 CLK_SEL_E,    0x40c, 6, 0),
+	DEF_MOD("syc_cnt_clk",	R9A09G011_SYC_CNT_CLK,	 CLK_MAIN_24,  0x41c, 12, 0),
+	DEF_MOD("iic_pclk0",	R9A09G011_IIC_PCLK0,	 CLK_SEL_E,    0x420, 12, 0),
+	DEF_MOD("cperi_grpb",	R9A09G011_CPERI_GRPB_PCLK, CLK_SEL_E,  0x424, 0, 0),
+	DEF_MOD("tim_clk_8",	R9A09G011_TIM8_CLK,	 CLK_MAIN_2,   0x424, 4, 0),
+	DEF_MOD("tim_clk_9",	R9A09G011_TIM9_CLK,	 CLK_MAIN_2,   0x424, 5, 0),
+	DEF_MOD("tim_clk_10",	R9A09G011_TIM10_CLK,	 CLK_MAIN_2,   0x424, 6, 0),
+	DEF_MOD("tim_clk_11",	R9A09G011_TIM11_CLK,	 CLK_MAIN_2,   0x424, 7, 0),
+	DEF_MOD("tim_clk_12",	R9A09G011_TIM12_CLK,	 CLK_MAIN_2,   0x424, 8, 0),
+	DEF_MOD("tim_clk_13",	R9A09G011_TIM13_CLK,	 CLK_MAIN_2,   0x424, 9, 0),
+	DEF_MOD("tim_clk_14",	R9A09G011_TIM14_CLK,	 CLK_MAIN_2,   0x424, 10, 0),
+	DEF_MOD("tim_clk_15",	R9A09G011_TIM15_CLK,	 CLK_MAIN_2,   0x424, 11, 0),
+	DEF_MOD("iic_pclk1",	R9A09G011_IIC_PCLK1,	 CLK_SEL_E,    0x424, 12, 0),
+	DEF_MOD("cperi_grpc",	R9A09G011_CPERI_GRPC_PCLK, CLK_SEL_E,  0x428, 0, 0),
+	DEF_MOD("tim_clk_16",	R9A09G011_TIM16_CLK,	 CLK_MAIN_2,   0x428, 4, 0),
+	DEF_MOD("tim_clk_17",	R9A09G011_TIM17_CLK,	 CLK_MAIN_2,   0x428, 5, 0),
+	DEF_MOD("tim_clk_18",	R9A09G011_TIM18_CLK,	 CLK_MAIN_2,   0x428, 6, 0),
+	DEF_MOD("tim_clk_19",	R9A09G011_TIM19_CLK,	 CLK_MAIN_2,   0x428, 7, 0),
+	DEF_MOD("tim_clk_20",	R9A09G011_TIM20_CLK,	 CLK_MAIN_2,   0x428, 8, 0),
+	DEF_MOD("tim_clk_21",	R9A09G011_TIM21_CLK,	 CLK_MAIN_2,   0x428, 9, 0),
+	DEF_MOD("tim_clk_22",	R9A09G011_TIM22_CLK,	 CLK_MAIN_2,   0x428, 10, 0),
+	DEF_MOD("tim_clk_23",	R9A09G011_TIM23_CLK,	 CLK_MAIN_2,   0x428, 11, 0),
+	DEF_MOD("wdt0_pclk",	R9A09G011_WDT0_PCLK,	 CLK_SEL_E,    0x428, 12, 0),
+	DEF_MOD("wdt0_clk",	R9A09G011_WDT0_CLK,	 CLK_MAIN,     0x428, 13, 0),
+	DEF_MOD("cperi_grpf",	R9A09G011_CPERI_GRPF_PCLK, CLK_SEL_E,  0x434, 0, 0),
+	DEF_MOD("pwm8_clk",	R9A09G011_PWM8_CLK,	 CLK_MAIN,     0x434, 4, 0),
+	DEF_MOD("pwm9_clk",	R9A09G011_PWM9_CLK,	 CLK_MAIN,     0x434, 5, 0),
+	DEF_MOD("pwm10_clk",	R9A09G011_PWM10_CLK,	 CLK_MAIN,     0x434, 6, 0),
+	DEF_MOD("pwm11_clk",	R9A09G011_PWM11_CLK,	 CLK_MAIN,     0x434, 7, 0),
+	DEF_MOD("pwm12_clk",	R9A09G011_PWM12_CLK,	 CLK_MAIN,     0x434, 8, 0),
+	DEF_MOD("pwm13_clk",	R9A09G011_PWM13_CLK,	 CLK_MAIN,     0x434, 9, 0),
+	DEF_MOD("pwm14_clk",	R9A09G011_PWM14_CLK,	 CLK_MAIN,     0x434, 10, 0),
+	DEF_MOD("cperi_grpg",	R9A09G011_CPERI_GRPG_PCLK, CLK_SEL_E,  0x438, 0, 0),
+	DEF_MOD("cperi_grph",	R9A09G011_CPERI_GRPH_PCLK, CLK_SEL_E,  0x438, 1, 0),
+	DEF_MOD("urt_pclk",	R9A09G011_URT_PCLK,	 CLK_SEL_E,    0x438, 4, 0),
+	DEF_MOD("urt0_clk",	R9A09G011_URT0_CLK,	 CLK_SEL_W0,   0x438, 5, 0),
+	DEF_MOD("csi0_clk",	R9A09G011_CSI0_CLK,	 CLK_SEL_CSI0, 0x438, 8, 0),
+	DEF_MOD("csi4_clk",	R9A09G011_CSI4_CLK,	 CLK_SEL_CSI4, 0x438, 12, 0),
+	DEF_MOD("ca53",		R9A09G011_CA53_CLK,	 CLK_DIV_A,    0x448, 0, 0),
 };
 
 static const struct rzg2l_reset r9a09g011_resets[] = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 2922dc884e35..6fb815862e44 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1177,6 +1177,17 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 		core->name, PTR_ERR(clk));
 }
 
+/**
+ * struct mstop - MSTOP specific data structure
+ * @count: reference counter for MSTOP settings (when zero the settings
+ *	   are applied to register)
+ * @conf: MSTOP configuration (register offset, setup bits)
+ */
+struct mstop {
+	u32 count;
+	u32 conf;
+};
+
 /**
  * struct mstp_clock - MSTP gating clock
  *
@@ -1186,6 +1197,7 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  * @enabled: soft state of the clock, if it is coupled with another clock
  * @priv: CPG/MSTP private data
  * @sibling: pointer to the other coupled clock
+ * @mstop: MSTOP configuration
  */
 struct mstp_clock {
 	struct clk_hw hw;
@@ -1194,10 +1206,46 @@ struct mstp_clock {
 	bool enabled;
 	struct rzg2l_cpg_priv *priv;
 	struct mstp_clock *sibling;
+	struct mstop *mstop;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
 
+/* Need to be called with a lock held to avoid concurent access to mstop->count. */
+static void rzg2l_mod_clock_module_set_standby(struct mstp_clock *clock,
+					       bool standby)
+{
+	struct rzg2l_cpg_priv *priv = clock->priv;
+	struct mstop *mstop = clock->mstop;
+	bool update = false;
+	u32 value;
+
+	if (!mstop)
+		return;
+
+	value = MSTOP_MASK(mstop->conf) << 16;
+
+	if (standby) {
+		value |= MSTOP_MASK(mstop->conf);
+		/* Avoid overflow. */
+		if (mstop->count > 0)
+			mstop->count--;
+
+		if (!mstop->count)
+			update = true;
+	} else {
+		if (!mstop->count)
+			update = true;
+
+		/* Avoid overflow. */
+		if (mstop->count + 1 != 0)
+			mstop->count++;
+	}
+
+	if (update)
+		writel(value, priv->base + MSTOP_OFF(mstop->conf));
+}
+
 static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 {
 	struct mstp_clock *clock = to_mod_clock(hw);
@@ -1205,6 +1253,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	unsigned int reg = clock->off;
 	struct device *dev = priv->dev;
 	u32 bitmask = BIT(clock->bit);
+	unsigned long flags;
 	u32 value;
 	int error;
 
@@ -1220,7 +1269,10 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	if (enable)
 		value |= bitmask;
 
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	rzg2l_mod_clock_module_set_standby(clock, !enable);
 	writel(value, priv->base + CLK_ON_R(reg));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 
 	if (!enable)
 		return 0;
@@ -1328,6 +1380,27 @@ static struct mstp_clock
 	return NULL;
 }
 
+static struct mstop *rzg2l_mod_clock_get_mstop(struct rzg2l_cpg_priv *priv, u32 conf)
+{
+	for (unsigned int i = 0; i < priv->num_mod_clks; i++) {
+		struct mstp_clock *clk;
+		struct clk_hw *hw;
+
+		if (priv->clks[priv->num_core_clks + i] == ERR_PTR(-ENOENT))
+			continue;
+
+		hw = __clk_get_hw(priv->clks[priv->num_core_clks + i]);
+		clk = to_mod_clock(hw);
+		if (!clk->mstop)
+			continue;
+
+		if (clk->mstop->conf == conf)
+			return clk->mstop;
+	}
+
+	return NULL;
+}
+
 static void __init
 rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 			   const struct rzg2l_cpg_info *info,
@@ -1401,6 +1474,37 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 		}
 	}
 
+	if (mod->mstop_conf) {
+		struct mstop *mstop = rzg2l_mod_clock_get_mstop(priv, mod->mstop_conf);
+
+		if (mstop) {
+			clock->mstop = mstop;
+		} else {
+			mstop = devm_kzalloc(dev, sizeof(*mstop), GFP_KERNEL);
+			if (!mstop) {
+				clk_unregister(clk);
+				goto fail;
+			}
+
+			mstop->conf = mod->mstop_conf;
+			clock->mstop = mstop;
+		}
+
+		if (rzg2l_mod_clock_is_enabled(&clock->hw)) {
+			if (clock->sibling)
+				clock->mstop->count = 1;
+			else
+				clock->mstop->count++;
+		}
+
+		/*
+		 * Out of reset all modules are enabled. Set module to standby
+		 * in case associated clocks are disabled at probe.
+		 */
+		if (!clock->mstop->count)
+			rzg2l_mod_clock_module_set_standby(clock, true);
+	}
+
 	return;
 
 fail:
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 6e38c8fc888c..10ee8aa4a5da 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -27,6 +27,11 @@
 #define CPG_PL6_ETH_SSEL	(0x418)
 #define CPG_PL5_SDIV		(0x420)
 #define CPG_RST_MON		(0x680)
+#define CPG_ACPU_MSTOP		(0xB60)
+#define CPG_MCPU2_MSTOP		(0xB68)
+#define CPG_PERI_COM_MSTOP	(0xB6C)
+#define CPG_PERI_CPU_MSTOP	(0xB70)
+#define CPG_REG1_MSTOP		(0xB80)
 #define CPG_OTHERFUNC1_REG	(0xBE8)
 
 #define CPG_SIPLL5_STBY_RESETB		BIT(0)
@@ -68,6 +73,10 @@
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 #define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
+#define MSTOP(name, bitmask)	((CPG_##name##_MSTOP) << 16 | (bitmask))
+#define MSTOP_OFF(conf)		((conf) >> 16)
+#define MSTOP_MASK(conf)	((conf) & GENMASK(15, 0))
+
 #define EXTAL_FREQ_IN_MEGA_HZ	(24)
 
 /**
@@ -191,26 +200,28 @@ struct rzg2l_mod_clk {
 	const char *name;
 	unsigned int id;
 	unsigned int parent;
+	u32 mstop_conf;
 	u16 off;
 	u8 bit;
 	bool is_coupled;
 };
 
-#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled)	\
+#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _mstop_conf, _is_coupled)	\
 	{ \
 		.name = _name, \
 		.id = MOD_CLK_BASE + (_id), \
 		.parent = (_parent), \
+		.mstop_conf = (_mstop_conf), \
 		.off = (_off), \
 		.bit = (_bit), \
 		.is_coupled = (_is_coupled), \
 	}
 
-#define DEF_MOD(_name, _id, _parent, _off, _bit)	\
-	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false)
+#define DEF_MOD(_name, _id, _parent, _off, _bit, _mstop_conf)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _mstop_conf, false)
 
-#define DEF_COUPLED(_name, _id, _parent, _off, _bit)	\
-	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true)
+#define DEF_COUPLED(_name, _id, _parent, _off, _bit, _mstop_conf)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _mstop_conf, true)
 
 /**
  * struct rzg2l_reset - Reset definitions
-- 
2.39.2

