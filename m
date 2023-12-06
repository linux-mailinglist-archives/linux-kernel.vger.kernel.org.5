Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAB807185
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378796AbjLFOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378764AbjLFOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:01:11 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B1D49;
        Wed,  6 Dec 2023 06:01:16 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3B6D9XvB030571;
        Wed, 6 Dec 2023 15:00:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=1qGFaBcs+OGg0vqscD04cfo2vPPfTvTMkHJAI0v67YY=; b=pe
        US6OJsGZsas5nF+q5vX97WFJIuu6rXORcby3JivBetGMf7I+UzMwoD+RP9HuNk2W
        fnEr6p/PQRHjCnadIwWKjPjS+2HsWI3fKK1IQnSHJdA8WT1VLpXJodj6msJWaaxd
        6ISa5j9SAXcJQEzZlWd5KqJ1mEnXVBUaaKG7A5CaeZmWXAdCidKoCTMM28DeOJko
        Tw9yJhuZBwRJ5bEal/n8OLugqJryfqulIXm2TNbI36M0Xn13WV53Qu/y37gPfGD0
        JcAF7oT0ux5+HktnLgYi5wm6tayugqkBUW8Fc41QB0y1UJENfCPZ1MmOe1xVZPO6
        hrIozAIWSvMbiUKEyTgg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3utd2gbbhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 15:00:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D192100053;
        Wed,  6 Dec 2023 15:00:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 456BD233C65;
        Wed,  6 Dec 2023 15:00:45 +0100 (CET)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Dec
 2023 15:00:44 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/5] clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
Date:   Wed, 6 Dec 2023 15:00:25 +0100
Message-ID: <20231206140029.492906-2-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206140029.492906-1-gabriel.fernandez@foss.st.com>
References: <20231206140029.492906-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_11,2023-12-06_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Move all STM32MP clock drivers into same directory (stm32).

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 drivers/clk/Kconfig                    | 11 +---------
 drivers/clk/Makefile                   |  1 -
 drivers/clk/stm32/Kconfig              | 29 ++++++++++++++++++++++++++
 drivers/clk/stm32/Makefile             |  1 +
 drivers/clk/{ => stm32}/clk-stm32mp1.c |  0
 5 files changed, 31 insertions(+), 11 deletions(-)
 create mode 100644 drivers/clk/stm32/Kconfig
 rename drivers/clk/{ => stm32}/clk-stm32mp1.c (100%)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c30d0d396f7a..50af5fc7f570 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -414,16 +414,6 @@ config COMMON_CLK_VC7
 	  Renesas Versaclock7 is a family of configurable clock generator
 	  and jitter attenuator ICs with fractional and integer dividers.
 
-config COMMON_CLK_STM32MP135
-	def_bool COMMON_CLK && MACH_STM32MP13
-	help
-	  Support for stm32mp135 SoC family clocks
-
-config COMMON_CLK_STM32MP157
-	def_bool COMMON_CLK && MACH_STM32MP157
-	help
-	  Support for stm32mp157 SoC family clocks
-
 config COMMON_CLK_STM32F
 	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
 	help
@@ -504,6 +494,7 @@ source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
+source "drivers/clk/stm32/Kconfig"
 source "drivers/clk/ti/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
 source "drivers/clk/visconti/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ed71f2e0ee36..14fa8d4ecc1f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -70,7 +70,6 @@ obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
 obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
 obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
 obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
-obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
 obj-$(CONFIG_COMMON_CLK_TPS68470)      += clk-tps68470.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
 obj-$(CONFIG_CLK_TWL)			+= clk-twl.o
diff --git a/drivers/clk/stm32/Kconfig b/drivers/clk/stm32/Kconfig
new file mode 100644
index 000000000000..3c8493a94a11
--- /dev/null
+++ b/drivers/clk/stm32/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# common clock support for STMicroelectronics SoC family.
+
+menuconfig COMMON_CLK_STM32MP
+	bool "Clock support for common STM32MP clocks"
+	depends on ARCH_STM32 || COMPILE_TEST
+	default y
+	select RESET_CONTROLLER
+	help
+	  Support for STM32MP SoC family clocks.
+
+if COMMON_CLK_STM32MP
+
+config COMMON_CLK_STM32MP135
+	bool "Clock driver for stm32mp13x clocks"
+	depends on ARM || COMPILE_TEST
+	default y
+	help
+	  Support for stm32mp13x SoC family clocks.
+
+config COMMON_CLK_STM32MP157
+	bool "Clock driver for stm32mp15x clocks"
+	depends on ARM || COMPILE_TEST
+	default y
+	help
+	  Support for stm32mp15x SoC family clocks.
+
+endif
+
diff --git a/drivers/clk/stm32/Makefile b/drivers/clk/stm32/Makefile
index 95bd2230bba0..c154ef3e88f9 100644
--- a/drivers/clk/stm32/Makefile
+++ b/drivers/clk/stm32/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_COMMON_CLK_STM32MP135)	+= clk-stm32mp13.o clk-stm32-core.o reset-stm32.o
+obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
similarity index 100%
rename from drivers/clk/clk-stm32mp1.c
rename to drivers/clk/stm32/clk-stm32mp1.c
-- 
2.25.1

