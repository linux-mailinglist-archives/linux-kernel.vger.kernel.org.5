Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A17879C58F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjILEze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjILEyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:54:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C72109
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so6729382a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494379; x=1695099179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9n1uPO0iEaDmTJgL+Fv5kOk2NI9TkneRr5jOWzqknc=;
        b=faGmerJ0+SO7DxPOuIbRgvm3hJnQ75lV5FxlXXMSqfN/G/H9uJ6b6J6JWmgAS66NQz
         Fp8T7/lAtpW1GKH8YStnP7ew1tuZuHQSwZjJM35olmWzSWfmlUenuyNZr8TYNYzozkmL
         oG0Ayrh2TRr+KO2pwz5xLo7nVM6WMl1ylTy5TPz7Fqss9ADFYLSZ5+jWNCwXpMrl2C8/
         3NwS59VSyZsRkY7HsfFyHjvU/RoDZXTYWCbyWbqvkW+UCtc4ZVAqUon/wF0TfuUk1bn5
         Y+CBB6bSsLj4TynY31f+cTUZhu3IGRhnI8Rnpwy/LRj8WApGbU+kPcwIpagRXKfwcZTH
         PfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494379; x=1695099179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9n1uPO0iEaDmTJgL+Fv5kOk2NI9TkneRr5jOWzqknc=;
        b=YFnL55aqxcfImYOc5VMU+oHT6wkOFBEMjmTm4xsCI9EKbQ1iDxMwXp+NDA0hmmzHrw
         gcLCktHqIzrOI98iLQKvDAxN4BtqylZhTKxl83p3CvlMsojPGknDHzjszSlHPNBA2zlV
         YpiKts/a+NFLFs1ZpOdoNEvPp65WWzAXQJBPoywi19b9T9ccGJcG63SBU6K/CNLW/saB
         XJZzuIGyAZAP/Y+NTk6bEINBipaqtzX5BwwgdcOXNJ0/A/almjHb+RojAQFUeE5AcSbR
         glY6o7fXJprtPzw5V5TUKvgMKBfJFDrO6riA3yEwZERbz5m7WAKlC1N9ceTi9i06u7zj
         Ylig==
X-Gm-Message-State: AOJu0YxRr0l2ceys4Vz2KJamO16SJHEY/tz4Mq0/Xua5q1xkyfbkBf+c
        5Dw2vu6V0v9f76t5I8LAOpFi4Q==
X-Google-Smtp-Source: AGHT+IEBgcfgy0k8inEXJhI3KCA5vsU0kdxrAnVr9AVjLlFLmbf0kwETr6+KCzr73H0SKKTON3togA==
X-Received: by 2002:a50:baad:0:b0:52f:9d4c:1d28 with SMTP id x42-20020a50baad000000b0052f9d4c1d28mr834823ede.12.1694494379708;
        Mon, 11 Sep 2023 21:52:59 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:59 -0700 (PDT)
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
Subject: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and resets definitions
Date:   Tue, 12 Sep 2023 07:51:41 +0300
Message-Id: <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
clocks and resets.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/dt-bindings/clock/r9a08g045-cpg.h | 243 ++++++++++++++++++++++
 1 file changed, 243 insertions(+)
 create mode 100644 include/dt-bindings/clock/r9a08g045-cpg.h

diff --git a/include/dt-bindings/clock/r9a08g045-cpg.h b/include/dt-bindings/clock/r9a08g045-cpg.h
new file mode 100644
index 000000000000..08668715d790
--- /dev/null
+++ b/include/dt-bindings/clock/r9a08g045-cpg.h
@@ -0,0 +1,243 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__
+#define __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* R9A08G045 CPG Core Clocks */
+#define R9A08G045_CLK_I			0
+#define R9A08G045_CLK_I2		1
+#define R9A08G045_CLK_I3		2
+#define R9A08G045_CLK_S0		3
+#define R9A08G045_CLK_SPI0		4
+#define R9A08G045_CLK_SPI1		5
+#define R9A08G045_CLK_SD0		6
+#define R9A08G045_CLK_SD1		7
+#define R9A08G045_CLK_SD2		8
+#define R9A08G045_CLK_M0		9
+#define R9A08G045_CLK_HP		10
+#define R9A08G045_CLK_TSU		11
+#define R9A08G045_CLK_ZT		12
+#define R9A08G045_CLK_P0		13
+#define R9A08G045_CLK_P1		14
+#define R9A08G045_CLK_P2		15
+#define R9A08G045_CLK_P3		16
+#define R9A08G045_CLK_P4		17
+#define R9A08G045_CLK_P5		18
+#define R9A08G045_CLK_AT		19
+#define R9A08G045_CLK_OC0		20
+#define R9A08G045_CLK_OC1		21
+#define R9A08G045_OSCCLK		22
+#define R9A08G045_OSCCLK2		23
+#define R9A08G045_SWD			24
+
+/* R9A08G045 Module Clocks */
+#define R9A08G045_OCTA_ACLK		0
+#define R9A08G045_OCTA_MCLK		1
+#define R9A08G045_CA55_SCLK		2
+#define R9A08G045_CA55_PCLK		3
+#define R9A08G045_CA55_ATCLK		4
+#define R9A08G045_CA55_GICCLK		5
+#define R9A08G045_CA55_PERICLK		6
+#define R9A08G045_CA55_ACLK		7
+#define R9A08G045_CA55_TSCLK		8
+#define R9A08G045_SRAM_ACPU_ACLK0	9
+#define R9A08G045_SRAM_ACPU_ACLK1	10
+#define R9A08G045_SRAM_ACPU_ACLK2	11
+#define R9A08G045_GIC600_GICCLK		12
+#define R9A08G045_IA55_CLK		13
+#define R9A08G045_IA55_PCLK		14
+#define R9A08G045_MHU_PCLK		15
+#define R9A08G045_SYC_CNT_CLK		16
+#define R9A08G045_DMAC_ACLK		17
+#define R9A08G045_DMAC_PCLK		18
+#define R9A08G045_OSTM0_PCLK		19
+#define R9A08G045_OSTM1_PCLK		20
+#define R9A08G045_OSTM2_PCLK		21
+#define R9A08G045_OSTM3_PCLK		22
+#define R9A08G045_OSTM4_PCLK		23
+#define R9A08G045_OSTM5_PCLK		24
+#define R9A08G045_OSTM6_PCLK		25
+#define R9A08G045_OSTM7_PCLK		26
+#define R9A08G045_MTU_X_MCK_MTU3	27
+#define R9A08G045_POE3_CLKM_POE		28
+#define R9A08G045_GPT_PCLK		29
+#define R9A08G045_POEG_A_CLKP		30
+#define R9A08G045_POEG_B_CLKP		31
+#define R9A08G045_POEG_C_CLKP		32
+#define R9A08G045_POEG_D_CLKP		33
+#define R9A08G045_WDT0_PCLK		34
+#define R9A08G045_WDT0_CLK		35
+#define R9A08G045_WDT1_PCLK		36
+#define R9A08G045_WDT1_CLK		37
+#define R9A08G045_WDT2_PCLK		38
+#define R9A08G045_WDT2_CLK		39
+#define R9A08G045_SPI_HCLK		40
+#define R9A08G045_SPI_ACLK		41
+#define R9A08G045_SPI_CLK		42
+#define R9A08G045_SPI_CLKX2		43
+#define R9A08G045_SDHI0_IMCLK		44
+#define R9A08G045_SDHI0_IMCLK2		45
+#define R9A08G045_SDHI0_CLK_HS		46
+#define R9A08G045_SDHI0_ACLK		47
+#define R9A08G045_SDHI1_IMCLK		48
+#define R9A08G045_SDHI1_IMCLK2		49
+#define R9A08G045_SDHI1_CLK_HS		50
+#define R9A08G045_SDHI1_ACLK		51
+#define R9A08G045_SDHI2_IMCLK		52
+#define R9A08G045_SDHI2_IMCLK2		53
+#define R9A08G045_SDHI2_CLK_HS		54
+#define R9A08G045_SDHI2_ACLK		55
+#define R9A08G045_SSI0_PCLK2		56
+#define R9A08G045_SSI0_PCLK_SFR		57
+#define R9A08G045_SSI1_PCLK2		58
+#define R9A08G045_SSI1_PCLK_SFR		59
+#define R9A08G045_SSI2_PCLK2		60
+#define R9A08G045_SSI2_PCLK_SFR		61
+#define R9A08G045_SSI3_PCLK2		62
+#define R9A08G045_SSI3_PCLK_SFR		63
+#define R9A08G045_SRC_CLKP		64
+#define R9A08G045_USB_U2H0_HCLK		65
+#define R9A08G045_USB_U2H1_HCLK		66
+#define R9A08G045_USB_U2P_EXR_CPUCLK	67
+#define R9A08G045_USB_PCLK		68
+#define R9A08G045_USB_SCLK		69
+#define R9A08G045_ETH0_CLK_AXI		70
+#define R9A08G045_ETH0_CLK_CHI		71
+#define R9A08G045_ETH0_REFCLK		72
+#define R9A08G045_ETH1_CLK_AXI		73
+#define R9A08G045_ETH1_CLK_CHI		74
+#define R9A08G045_ETH1_REFCLK		75
+#define R9A08G045_I2C0_PCLK		76
+#define R9A08G045_I2C1_PCLK		77
+#define R9A08G045_I2C2_PCLK		78
+#define R9A08G045_I2C3_PCLK		79
+#define R9A08G045_SCIF0_CLK_PCK		80
+#define R9A08G045_SCIF1_CLK_PCK		81
+#define R9A08G045_SCIF2_CLK_PCK		82
+#define R9A08G045_SCIF3_CLK_PCK		83
+#define R9A08G045_SCIF4_CLK_PCK		84
+#define R9A08G045_SCIF5_CLK_PCK		85
+#define R9A08G045_SCI0_CLKP		86
+#define R9A08G045_SCI1_CLKP		87
+#define R9A08G045_IRDA_CLKP		88
+#define R9A08G045_RSPI0_CLKB		89
+#define R9A08G045_RSPI1_CLKB		90
+#define R9A08G045_RSPI2_CLKB		91
+#define R9A08G045_RSPI3_CLKB		92
+#define R9A08G045_RSPI4_CLKB		93
+#define R9A08G045_CANFD_PCLK		94
+#define R9A08G045_CANFD_CLK_RAM		95
+#define R9A08G045_GPIO_HCLK		96
+#define R9A08G045_ADC_ADCLK		97
+#define R9A08G045_ADC_PCLK		98
+#define R9A08G045_TSU_PCLK		99
+#define R9A08G045_PDM_PCLK		100
+#define R9A08G045_PDM_CCLK		101
+#define R9A08G045_PCI_ACLK		102
+#define R9A08G045_PCI_CLKL1PM		103
+#define R9A08G045_SPDIF_PCLK		104
+#define R9A08G045_I3C_PCLK		105
+#define R9A08G045_I3C_TCLK		106
+#define R9A08G045_VBAT_BCLK		107
+
+/* R9A08G045 Resets */
+#define R9A08G045_CA55_RST_1_0		0
+#define R9A08G045_CA55_RST_3_0		1
+#define R9A08G045_CA55_RST_4		2
+#define R9A08G045_CA55_RST_5		3
+#define R9A08G045_CA55_RST_6		4
+#define R9A08G045_CA55_RST_7		5
+#define R9A08G045_CA55_RST_8		6
+#define R9A08G045_CA55_RST_9		7
+#define R9A08G045_CA55_RST_10		8
+#define R9A08G045_CA55_RST_11		9
+#define R9A08G045_CA55_RST_12		10
+#define R9A08G045_SRAM_ACPU_ARESETN0	11
+#define R9A08G045_SRAM_ACPU_ARESETN1	12
+#define R9A08G045_SRAM_ACPU_ARESETN2	13
+#define R9A08G045_GIC600_GICRESET_N	14
+#define R9A08G045_GIC600_DBG_GICRESET_N	15
+#define R9A08G045_IA55_RESETN		16
+#define R9A08G045_MHU_RESETN		17
+#define R9A08G045_DMAC_ARESETN		18
+#define R9A08G045_DMAC_RST_ASYNC	19
+#define R9A08G045_SYC_RESETN		20
+#define R9A08G045_OSTM0_PRESETZ		21
+#define R9A08G045_OSTM1_PRESETZ		22
+#define R9A08G045_OSTM2_PRESETZ		23
+#define R9A08G045_OSTM3_PRESETZ		24
+#define R9A08G045_OSTM4_PRESETZ		25
+#define R9A08G045_OSTM5_PRESETZ		26
+#define R9A08G045_OSTM6_PRESETZ		27
+#define R9A08G045_OSTM7_PRESETZ		28
+#define R9A08G045_MTU_X_PRESET_MTU3	29
+#define R9A08G045_POE3_RST_M_REG	30
+#define R9A08G045_GPT_RST_C		31
+#define R9A08G045_POEG_A_RST		32
+#define R9A08G045_POEG_B_RST		33
+#define R9A08G045_POEG_C_RST		34
+#define R9A08G045_POEG_D_RST		35
+#define R9A08G045_WDT0_PRESETN		36
+#define R9A08G045_WDT1_PRESETN		37
+#define R9A08G045_WDT2_PRESETN		38
+#define R9A08G045_SPI_HRESETN		39
+#define R9A08G045_SPI_ARESETN		40
+#define R9A08G045_SDHI0_IXRST		41
+#define R9A08G045_SDHI1_IXRST		42
+#define R9A08G045_SDHI2_IXRST		43
+#define R9A08G045_SSI0_RST_M2_REG	44
+#define R9A08G045_SSI1_RST_M2_REG	45
+#define R9A08G045_SSI2_RST_M2_REG	46
+#define R9A08G045_SSI3_RST_M2_REG	47
+#define R9A08G045_SRC_RST		48
+#define R9A08G045_USB_U2H0_HRESETN	49
+#define R9A08G045_USB_U2H1_HRESETN	50
+#define R9A08G045_USB_U2P_EXL_SYSRST	51
+#define R9A08G045_USB_PRESETN		52
+#define R9A08G045_ETH0_RST_HW_N		53
+#define R9A08G045_ETH1_RST_HW_N		54
+#define R9A08G045_I2C0_MRST		55
+#define R9A08G045_I2C1_MRST		56
+#define R9A08G045_I2C2_MRST		57
+#define R9A08G045_I2C3_MRST		58
+#define R9A08G045_SCIF0_RST_SYSTEM_N	59
+#define R9A08G045_SCIF1_RST_SYSTEM_N	60
+#define R9A08G045_SCIF2_RST_SYSTEM_N	61
+#define R9A08G045_SCIF3_RST_SYSTEM_N	62
+#define R9A08G045_SCIF4_RST_SYSTEM_N	63
+#define R9A08G045_SCIF5_RST_SYSTEM_N	64
+#define R9A08G045_SCI0_RST		65
+#define R9A08G045_SCI1_RST		66
+#define R9A08G045_IRDA_RST		67
+#define R9A08G045_RSPI0_RST		68
+#define R9A08G045_RSPI1_RST		69
+#define R9A08G045_RSPI2_RST		70
+#define R9A08G045_RSPI3_RST		71
+#define R9A08G045_RSPI4_RST		72
+#define R9A08G045_CANFD_RSTP_N		73
+#define R9A08G045_CANFD_RSTC_N		74
+#define R9A08G045_GPIO_RSTN		75
+#define R9A08G045_GPIO_PORT_RESETN	76
+#define R9A08G045_GPIO_SPARE_RESETN	77
+#define R9A08G045_ADC_PRESETN		78
+#define R9A08G045_ADC_ADRST_N		79
+#define R9A08G045_TSU_PRESETN		80
+#define R9A08G045_OCTA_ARESETN		81
+#define R9A08G045_PDM0_PRESETNT		82
+#define R9A08G045_PCI_ARESETN		83
+#define R9A08G045_PCI_RST_B		84
+#define R9A08G045_PCI_RST_GP_B		85
+#define R9A08G045_PCI_RST_PS_B		86
+#define R9A08G045_PCI_RST_RSM_B		87
+#define R9A08G045_PCI_RST_CFG_B		88
+#define R9A08G045_PCI_RST_LOAD_B	89
+#define R9A08G045_SPDIF_RST		90
+#define R9A08G045_I3C_TRESETN		91
+#define R9A08G045_I3C_PRESETN		92
+#define R9A08G045_VBAT_BRESETN		93
+
+#endif /* __DT_BINDINGS_CLOCK_R9A08G045_CPG_H__ */
-- 
2.39.2

