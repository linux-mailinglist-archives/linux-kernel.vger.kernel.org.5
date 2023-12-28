Return-Path: <linux-kernel+bounces-12470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0752481F535
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3FB1C21B36
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB663CD;
	Thu, 28 Dec 2023 06:53:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945A63AA;
	Thu, 28 Dec 2023 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 72F8224E29D;
	Thu, 28 Dec 2023 14:53:41 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:41 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:36 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Yangtao Li <frank.li@vivo.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [PATCH 2/3] mmc: sdhci-cadence6: add Cadence SD6HC support
Date: Thu, 28 Dec 2023 14:53:21 +0800
Message-ID: <20231228065322.1176351-3-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
References: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add a driver for the Cadence SD6HC SD/SDIO/eMMC controller.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 MAINTAINERS                           |   6 +
 drivers/mmc/host/Kconfig              |  11 +
 drivers/mmc/host/Makefile             |   2 +
 drivers/mmc/host/sdhci-cadence6-phy.c | 384 +++++++++++++++++++
 drivers/mmc/host/sdhci-cadence6.c     | 531 ++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-cadence6.h     | 148 +++++++
 6 files changed, 1082 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-cadence6-phy.c
 create mode 100644 drivers/mmc/host/sdhci-cadence6.c
 create mode 100644 drivers/mmc/host/sdhci-cadence6.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 451ee21086a7..88e2120a4cef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4537,6 +4537,12 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 F:	drivers/mtd/nand/raw/cadence-nand-controller.c
=20
+CADENCE SDHCI MMC HOST CONTROLLER VERSION 6 DRIVER
+M:	Alex Soo <yuklin.soo@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/mmc/cdns,sd6hci.yaml
+F:	drivers/mmc/host/sdhci-cadence6*
+
 CADENCE USB3 DRD IP DRIVER
 M:	Peter Chen <peter.chen@kernel.org>
 M:	Pawel Laszczak <pawell@cadence.com>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 58bd5fe4cd25..892923ee5a7a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -263,6 +263,17 @@ config MMC_SDHCI_CADENCE
=20
 	  If unsure, say N.
=20
+config MMC_SDHCI_CADENCE6
+	tristate "SDHCI support for the Cadence SD/SDIO/eMMC (Version 6) contro=
ller"
+	depends on MMC_SDHCI_PLTFM
+	depends on OF
+	help
+	  This selects the Cadence SD/SDIO/eMMC (Version 6) driver.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_ESDHC_MCF
 	tristate "SDHCI support for the Freescale eSDHC ColdFire controller"
 	depends on M5441x
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index d0be4465f3ec..9a4cbedfd196 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -109,3 +109,5 @@ endif
=20
 obj-$(CONFIG_MMC_SDHCI_XENON)	+=3D sdhci-xenon-driver.o
 sdhci-xenon-driver-y		+=3D sdhci-xenon.o sdhci-xenon-phy.o
+obj-$(CONFIG_MMC_SDHCI_CADENCE6)	+=3D sdhci-cadence6-driver.o
+sdhci-cadence6-driver-y		+=3D sdhci-cadence6.o sdhci-cadence6-phy.o
diff --git a/drivers/mmc/host/sdhci-cadence6-phy.c b/drivers/mmc/host/sdh=
ci-cadence6-phy.c
new file mode 100644
index 000000000000..8429f35c0c96
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence6-phy.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PHY support for Cadence version 6 SDHC
+ *
+ * Copyright (C) 2022-2023 Shanghai StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/iopoll.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci-cadence6.h"
+
+static struct sdhci_cdns_hrs_reg_vals hrs07_reg_cfg[] =3D {
+		{0x00090000},	/* MMC legacy or SD default */
+		{0x00090000},	/* MMC High Speed */
+		{0x00090001},	/* SD High Speed  */
+		{0x00090001},	/* SD UHS1 SDR12  */
+		{0x00090001},	/* SD UHS1 SDR25  */
+		{0x00090001},	/* SD UHS1 SDR50  */
+		{0x000a0001},	/* SD UHS1 SDR104 */
+		{0x00090001},	/* SD UHS1 DDR50  */
+		{0x00090001},	/* MMC DDR52 */
+		{0x00090000},	/* MMC HS200 */
+		{0x00090001},	/* MMC HS400 */
+};
+
+static struct sdhci_cdns_hrs_reg_vals hrs09_reg_cfg[] =3D {
+		{0x0001800C},	/* MMC legacy or SD default */
+		{0x0001800C},	/* MMC High Speed */
+		{0x0001800C},	/* SD High Speed  */
+		{0x0001800C},	/* SD UHS1 SDR12  */
+		{0x0001800C},	/* SD UHS1 SDR25  */
+		{0x0001800C},	/* SD UHS1 SDR50  */
+		{0x0000000C},	/* SD UHS1 SDR104 */
+		{0x0001800C},	/* SD UHS1 DDR50  */
+		{0x0001800C},	/* MMC DDR52 */
+		{0x0001800C},	/* MMC HS200 */
+		{0x0000000C},	/* MMC HS400 */
+};
+
+static struct sdhci_cdns_hrs_reg_vals hrs10_reg_cfg[] =3D {
+		{0x00010000},	/* MMC legacy or SD default */
+		{0x00010000},	/* MMC High Speed */
+		{0x00030000},	/* SD High Speed  */
+		{0x00020000},	/* SD UHS1 SDR12  */
+		{0x00030000},	/* SD UHS1 SDR25  */
+		{0x00060000},	/* SD UHS1 SDR50  */
+		{0x00090000},	/* SD UHS1 SDR104 */
+		{0x00020000},	/* SD UHS1 DDR50  */
+		{0x00020000},	/* MMC DDR52 */
+		{0x00080000},	/* MMC HS200 */
+		{0x00080000},	/* MMC HS400 */
+};
+
+static struct sdhci_cdns_hrs_reg_vals hrs16_reg_cfg[] =3D {
+		{0x00000101},	/* MMC legacy or SD default */
+		{0x00000101},	/* MMC High Speed */
+		{0x00000000},	/* SD High Speed  */
+		{0x00000000},	/* SD UHS1 SDR12  */
+		{0x00000000},	/* SD UHS1 SDR25  */
+		{0x00000000},	/* SD UHS1 SDR50  */
+		{0x00000101},	/* SD UHS1 SDR104 */
+		{0x11000000},	/* SD UHS1 DDR50  */
+		{0x11000001},	/* MMC DDR52 */
+		{0x00000101},	/* MMC HS200 */
+		{0x11000001},	/* MMC HS400 */
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_ds_mode_setting[] =3D {
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000180, PHY_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_hs_mode_setting[] =3D {
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000180, PHY_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_uhs_sdr12_mode_setting[] =3D {
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000180, PHY_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_uhs_sdr25_mode_setting[] =3D {
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000180, PHY_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_uhs_sdr50_mode_setting[] =3D {
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000180, PHY_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_uhs_sdr104_mode_setting[] =3D =
{
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00004D00, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x01000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs sd_uhs_ddr50_mode_setting[] =3D {
+		{0x00380000, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000180, PHY_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs emmc_sdr_mode_setting[] =3D {
+		{0x00380004, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs emmc_sdr_bc_mode_setting[] =3D {
+		{0x00380004, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs emmc_ddr_mode_setting[] =3D {
+		{0x00380004, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00000000, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs emmc_hs200_mode_setting[] =3D {
+		{0x00380004, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00DADA00, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs emmc_hs400_mode_setting[] =3D {
+		{0x00380004, PHY_DQS_TIMING_REG_ADDR},
+		{0x01A00040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x00DAD800, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x00000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_pairs emmc_hs400es_mode_setting[] =3D {
+		{0x00680000, PHY_DQS_TIMING_REG_ADDR},
+		{0x80A40040, PHY_GATE_LPBK_CTRL_REG_ADDR},
+		{0x04004B40, PHY_DLL_SLAVE_CTRL_REG_ADDR},
+		{0x08000001, PHY_DQ_TIMING_REG_ADDR},
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_ds_mode_cfgs =3D {
+		.reg_pairs =3D sd_ds_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_ds_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_hs_mode_cfgs =3D {
+		.reg_pairs =3D sd_hs_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_hs_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_uhs_sdr12_mode_cfgs =3D {
+		.reg_pairs =3D sd_uhs_sdr12_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_uhs_sdr12_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_uhs_sdr25_mode_cfgs =3D {
+		.reg_pairs =3D sd_uhs_sdr25_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_uhs_sdr25_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_uhs_sdr50_mode_cfgs =3D {
+		.reg_pairs =3D sd_uhs_sdr50_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_uhs_sdr50_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_uhs_sdr104_mode_cfgs =3D {
+		.reg_pairs =3D sd_uhs_sdr104_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_uhs_sdr104_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals sd_uhs_ddr50_mode_cfgs =3D {
+		.reg_pairs =3D sd_uhs_ddr50_mode_setting,
+		.num_regs =3D ARRAY_SIZE(sd_uhs_ddr50_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals emmc_sdr_mode_cfgs =3D {
+		.reg_pairs =3D emmc_sdr_mode_setting,
+		.num_regs =3D ARRAY_SIZE(emmc_sdr_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals emmc_sdr_bc_mode_cfgs =3D {
+		.reg_pairs =3D emmc_sdr_bc_mode_setting,
+		.num_regs =3D ARRAY_SIZE(emmc_sdr_bc_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals emmc_ddr_mode_cfgs =3D {
+		.reg_pairs =3D emmc_ddr_mode_setting,
+		.num_regs =3D ARRAY_SIZE(emmc_ddr_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals emmc_hs200_mode_cfgs =3D {
+		.reg_pairs =3D emmc_hs200_mode_setting,
+		.num_regs =3D ARRAY_SIZE(emmc_hs200_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals emmc_hs400_mode_cfgs =3D {
+		.reg_pairs =3D emmc_hs400_mode_setting,
+		.num_regs =3D ARRAY_SIZE(emmc_hs400_mode_setting),
+};
+
+static struct sdhci_cdns_phy_reg_vals emmc_hs400es_mode_cfgs =3D {
+		.reg_pairs =3D emmc_hs400es_mode_setting,
+		.num_regs =3D ARRAY_SIZE(emmc_hs400es_mode_setting),
+};
+
+/* Cadence SDMMC version 6 Combo PHY registers (aligned 32-bit) read/wri=
te functions */
+
+unsigned int sdhci_cdns_read_phy_reg(struct sdhci_cdns_priv *priv, u32 a=
ddress)
+{
+	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
+	return readl(priv->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv, u32 address,=
 u32 value)
+{
+	writel(address, priv->hrs_addr + SDHCI_CDNS_HRS04);
+	writel(value, priv->hrs_addr + SDHCI_CDNS_HRS05);
+}
+
+int sdhci_cdns_reset_phy_dll(struct sdhci_host *host, unsigned int reset=
)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	void __iomem *reg =3D priv->hrs_addr + SDHCI_CDNS_HRS09;
+	u32 tmp;
+	int ret;
+
+	tmp =3D readl(reg);
+	tmp &=3D ~SDHCI_CDNS_HRS09_PHY_SW_RESET;
+
+	if (reset)	/* Switch On DLL Reset */
+		tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 0);
+	else		/* Switch Off DLL Reset */
+		tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS09_PHY_SW_RESET, 1);
+
+	writel(tmp, reg);
+
+	if (!reset) {
+		ret =3D readl_poll_timeout(reg, tmp, (tmp & SDHCI_CDNS_HRS09_PHY_INIT_=
COMPLETE),
+					 0, 3000);
+	}
+
+	return ret;
+}
+
+int sdhci_cdns_phy_adj(struct sdhci_host *host, unsigned char timing)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	struct sdhci_cdns_phy_reg_vals *sdhci_cdns_mode_init;
+	struct sdhci_cdns_phy_reg_pairs *reg_pairs;
+	void __iomem *reg;
+	u32 num_regs, mode, tmp;
+	int i;
+
+	mode =3D sdhci_cdns_get_emmc_mode(priv);
+
+	/* Switch On the DLL Reset */
+	sdhci_cdns_reset_phy_dll(host, 1);
+
+	/* Initialize the PHY registers for different speed modes */
+	switch (timing) {
+	case MMC_TIMING_LEGACY:
+		if (mode =3D=3D SDHCI_CDNS_HRS06_MODE_SD)
+			sdhci_cdns_mode_init =3D &sd_ds_mode_cfgs;
+		else
+			sdhci_cdns_mode_init =3D &emmc_sdr_bc_mode_cfgs;
+		break;
+	case MMC_TIMING_MMC_HS:
+		sdhci_cdns_mode_init =3D &emmc_sdr_mode_cfgs;
+		break;
+	case MMC_TIMING_SD_HS:
+		sdhci_cdns_mode_init =3D &sd_hs_mode_cfgs;
+		break;
+	case MMC_TIMING_UHS_SDR12:
+		sdhci_cdns_mode_init =3D &sd_uhs_sdr12_mode_cfgs;
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		sdhci_cdns_mode_init =3D &sd_uhs_sdr25_mode_cfgs;
+		break;
+	case MMC_TIMING_UHS_SDR50:
+		sdhci_cdns_mode_init =3D &sd_uhs_sdr50_mode_cfgs;
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		sdhci_cdns_mode_init =3D &sd_uhs_sdr104_mode_cfgs;
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		sdhci_cdns_mode_init =3D &sd_uhs_ddr50_mode_cfgs;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		sdhci_cdns_mode_init =3D &emmc_ddr_mode_cfgs;
+		break;
+	case MMC_TIMING_MMC_HS200:
+		sdhci_cdns_mode_init =3D &emmc_hs200_mode_cfgs;
+		break;
+	case MMC_TIMING_MMC_HS400:
+		if (priv->enhanced_strobe)
+			sdhci_cdns_mode_init =3D &emmc_hs400es_mode_cfgs;
+		else
+			sdhci_cdns_mode_init =3D &emmc_hs400_mode_cfgs;
+		break;
+	default:
+		dev_err(mmc_dev(host->mmc), "%s: Invalid \"timing\" value\n",
+			mmc_hostname(host->mmc));
+		return -EINVAL;
+	}
+
+	reg_pairs =3D sdhci_cdns_mode_init->reg_pairs;
+	num_regs =3D sdhci_cdns_mode_init->num_regs;
+	for (i =3D 0; i < num_regs - 1; i++)
+		sdhci_cdns_write_phy_reg(priv, reg_pairs[i].off, reg_pairs[i].val);
+
+	/* Switch Off the DLL Reset */
+	sdhci_cdns_reset_phy_dll(host, 0);
+
+	/* Set PHY DQ TIMING control register */
+	sdhci_cdns_write_phy_reg(priv, reg_pairs[i].off, reg_pairs[i].val);
+
+	/* Set HRS09 register */
+	reg =3D priv->hrs_addr + SDHCI_CDNS_HRS09;
+	tmp =3D readl(reg);
+	tmp &=3D ~(SDHCI_CDNS_HRS09_EXTENDED_WR_MODE |
+		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
+		 SDHCI_CDNS_HRS09_RDDATA_EN |
+		 SDHCI_CDNS_HRS09_RDCMD_EN);
+	tmp |=3D hrs09_reg_cfg[timing].val;
+	writel(tmp, reg);
+
+	/* Set HRS10 register */
+	reg =3D priv->hrs_addr + SDHCI_CDNS_HRS10;
+	tmp =3D hrs10_reg_cfg[timing].val;
+	writel(tmp, reg);
+
+	/* Set HRS16 register */
+	reg =3D priv->hrs_addr + SDHCI_CDNS_HRS16;
+	tmp =3D readl(reg);
+	tmp &=3D ~(SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY |
+		 SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY |
+		 SDHCI_CDNS_HRS16_WRDATA0_DLY |
+		 SDHCI_CDNS_HRS16_WRCMD0_DLY);
+	tmp |=3D hrs16_reg_cfg[timing].val;
+	writel(tmp, reg);
+
+	/* Set HRS07 register */
+	reg =3D priv->hrs_addr + SDHCI_CDNS_HRS07;
+	tmp =3D readl(reg);
+	tmp &=3D ~(SDHCI_CDNS_HRS07_RW_COMPENSATE |
+		 SDHCI_CDNS_HRS07_IDELAY_VAL);
+	tmp |=3D hrs07_reg_cfg[timing].val;
+	writel(tmp, reg);
+
+	priv->timing =3D timing;
+
+	return 0;
+}
diff --git a/drivers/mmc/host/sdhci-cadence6.c b/drivers/mmc/host/sdhci-c=
adence6.c
new file mode 100644
index 000000000000..c9f5327a6f0e
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence6.c
@@ -0,0 +1,531 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Cadence SD/SDIO/eMMC Host Controller Version 6
+ *
+ * Copyright (C) 2022-2023 Shanghai StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#include "sdhci-pltfm.h"
+#include "sdhci-cadence6.h"
+
+/* SRS - Slot Register Set (SDHCI-compatible) */
+#define SDHCI_CDNS_SRS_BASE		0x200
+
+static void sdhci_cdns_set_emmc_mode(struct sdhci_cdns_priv *priv, u32 m=
ode)
+{
+	u32 tmp;
+
+	/* The speed mode for eMMC is selected by HRS06 register */
+	tmp =3D readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
+	tmp &=3D ~SDHCI_CDNS_HRS06_MODE;
+	tmp |=3D FIELD_PREP(SDHCI_CDNS_HRS06_MODE, mode);
+	writel(tmp, priv->hrs_addr + SDHCI_CDNS_HRS06);
+}
+
+u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
+{
+	u32 tmp;
+
+	tmp =3D readl(priv->hrs_addr + SDHCI_CDNS_HRS06);
+	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
+}
+
+static int sdhci_cdns_hs200_set_tune_val(struct sdhci_host *host, unsign=
ed int val)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	u32 tmp, tuneval;
+
+	tuneval =3D (val * 256) / 40;
+
+	tmp =3D sdhci_cdns_read_phy_reg(priv, PHY_DLL_SLAVE_CTRL_REG_ADDR);
+	tmp &=3D ~(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY |
+		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
+	tmp |=3D FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval)=
 |
+		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
+	sdhci_cdns_write_phy_reg(priv, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
+
+	return 0;
+}
+
+static int sdhci_cdns_execute_sd_tuning(struct sdhci_host *host, u32 opc=
ode)
+{
+	u16 ctrl;
+	int i;
+
+	/* reset and restart the tuning block */
+	sdhci_start_tuning(host);
+
+	/* Start the SD tuning */
+	for (i =3D 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
+		sdhci_send_tuning(host, opcode);
+
+		if (!host->tuning_done) {
+			sdhci_abort_tuning(host, opcode);
+			break;
+		}
+
+		ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK)
+				return 0; /* Success! */
+			break;
+		}
+	}
+
+	if (!host->tuning_done) {
+		dev_err(mmc_dev(host->mmc), "%s: SD tuning timed out!\n",
+			mmc_hostname(host->mmc));
+		return -ETIMEDOUT;
+	}
+
+	dev_err(mmc_dev(host->mmc), "%s: SD tuning failed!\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+
+	return -EAGAIN;
+}
+
+static int sdhci_cdns_execute_emmc_tuning(struct sdhci_host *host, u32 o=
pcode)
+{
+	int cur_streak =3D 0;
+	int max_streak =3D 0;
+	int end_of_streak =3D 0;
+	int i, ret =3D 0;
+
+	/* Start the eMMC tuning loop */
+	for (i =3D 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
+		/* Set tune value to adjust timing for data sampling */
+		if (sdhci_cdns_hs200_set_tune_val(host, i) ||
+		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
+			cur_streak =3D 0;
+		} else { /* good */
+			cur_streak++;
+			if (cur_streak > max_streak) {
+				max_streak =3D cur_streak;
+				end_of_streak =3D i;
+			}
+		}
+	}
+
+	if (!max_streak) {
+		dev_err(mmc_dev(host->mmc), "%s: %s: eMMC tuning failed!\n",
+			__func__, mmc_hostname(host->mmc));
+		ret =3D -EIO;
+	}
+
+	return sdhci_cdns_hs200_set_tune_val(host, end_of_streak - max_streak /=
 2);
+}
+
+static unsigned int sdhci_cdns_get_timeout_clock(struct sdhci_host *host=
)
+{
+	/* Timeout clock freq (KHz) */
+	return host->max_clk / 1000;
+}
+
+static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode=
)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	int ret =3D 0;
+
+	/*
+	 * execute tuning for UHS_SDR104 and MMC_HS200
+	 */
+	if (host->timing !=3D MMC_TIMING_MMC_HS200 &&
+	    host->timing !=3D MMC_TIMING_MMC_HS400 &&
+	    host->timing !=3D MMC_TIMING_UHS_SDR104)
+		return 0;
+
+	if (host->timing =3D=3D MMC_TIMING_MMC_HS400)
+		if (priv->enhanced_strobe)
+			return 0;
+
+	if (host->timing =3D=3D MMC_TIMING_UHS_SDR104) {
+		host->tuning_err =3D sdhci_cdns_execute_sd_tuning(host, opcode);
+		sdhci_end_tuning(host);
+		return 0;
+	} else if (host->timing =3D=3D MMC_TIMING_MMC_HS200 ||
+		   host->timing =3D=3D MMC_TIMING_MMC_HS400) {
+		ret =3D sdhci_cdns_execute_emmc_tuning(host, opcode);
+	}
+
+	return ret;
+}
+
+static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
+					 unsigned int timing)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	u32 mode;
+
+	switch (timing) {
+	case MMC_TIMING_LEGACY:
+		mode =3D SDHCI_CDNS_HRS06_MODE_MMC_LEGACY;
+		break;
+	case MMC_TIMING_MMC_HS:
+		mode =3D SDHCI_CDNS_HRS06_MODE_MMC_SDR;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		mode =3D SDHCI_CDNS_HRS06_MODE_MMC_DDR;
+		break;
+	case MMC_TIMING_MMC_HS200:
+		mode =3D SDHCI_CDNS_HRS06_MODE_MMC_HS200;
+		break;
+	case MMC_TIMING_MMC_HS400:
+		if (priv->enhanced_strobe)
+			mode =3D SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
+		else
+			mode =3D SDHCI_CDNS_HRS06_MODE_MMC_HS400;
+		break;
+	default:
+		mode =3D SDHCI_CDNS_HRS06_MODE_SD;
+		break;
+	}
+
+	sdhci_cdns_set_emmc_mode(priv, mode);
+
+	/* For SD, fall back to the default handler to set the UHS-I mode */
+	if (mode =3D=3D SDHCI_CDNS_HRS06_MODE_SD)
+		sdhci_set_uhs_signaling(host, timing);
+
+	/* Set DLL PHY registers for different timing modes */
+	sdhci_cdns_phy_adj(host, timing);
+}
+
+static void sdhci_cdns_hw_reset(struct sdhci_host *host)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	void __iomem *reg;
+
+	dev_dbg(mmc_dev(host->mmc), "%s: %s: sd/emmc card hardware reset\n",
+		__func__, mmc_hostname(host->mmc));
+
+	reg =3D priv->hrs_addr + SDHCI_CDNS_HRS11;
+	writel(SDHCI_CDNS_HRS11_EMMC_RST, reg);
+	udelay(9);
+	writel(!SDHCI_CDNS_HRS11_EMMC_RST, reg);
+	usleep_range(300, 1000);
+}
+
+static const struct sdhci_ops sdhci_cdns_ops =3D {
+	.set_clock =3D sdhci_set_clock,
+	.get_max_clock =3D sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock =3D sdhci_cdns_get_timeout_clock,
+	.set_bus_width =3D sdhci_set_bus_width,
+	.reset =3D sdhci_reset,
+	.platform_execute_tuning =3D sdhci_cdns_execute_tuning,
+	.set_uhs_signaling =3D sdhci_cdns_set_uhs_signaling,
+	.hw_reset =3D sdhci_cdns_hw_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_cdns_jh8100_pltfm_data =3D {
+	.ops =3D &sdhci_cdns_ops,
+	.quirks2 =3D SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
+static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data =3D {
+	.ops =3D &sdhci_cdns_ops,
+};
+
+static int sdhci_cdns_clk_enable(struct sdhci_host *host)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	int ret =3D 0;
+
+	ret =3D reset_control_deassert(priv->reset);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "%s: failed to deassert main reset: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret =3D clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "%s: failed to enable main clock :%d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void sdhci_cdns_clk_disable(struct sdhci_host *host)
+{
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+
+	clk_disable_unprepare(priv->clk);
+	clk_put(priv->clk);
+	reset_control_assert(priv->reset);
+}
+
+static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct sdhci_host *host =3D mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv =3D sdhci_cdns_priv(host);
+	u32 mode;
+
+	priv->enhanced_strobe =3D ios->enhanced_strobe;
+
+	mode =3D sdhci_cdns_get_emmc_mode(priv);
+
+	if (mode =3D=3D SDHCI_CDNS_HRS06_MODE_MMC_HS400 && ios->enhanced_strobe=
)
+		sdhci_cdns_set_emmc_mode(priv,
+					 SDHCI_CDNS_HRS06_MODE_MMC_HS400ES);
+
+	if (mode =3D=3D SDHCI_CDNS_HRS06_MODE_MMC_HS400ES && !ios->enhanced_str=
obe)
+		sdhci_cdns_set_emmc_mode(priv,
+					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
+}
+
+static int sdhci_cdns_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	const struct sdhci_pltfm_data *data;
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_cdns_priv *priv;
+	int ret;
+	struct device *dev =3D &pdev->dev;
+	static const u16 version =3D SDHCI_SPEC_420 << SDHCI_SPEC_VER_SHIFT;
+
+	data =3D of_device_get_match_data(dev);
+	if (!data)
+		data =3D &sdhci_cdns_pltfm_data;
+
+	host =3D sdhci_pltfm_init(pdev, data, 0);
+	if (IS_ERR(host)) {
+		ret =3D PTR_ERR(host);
+		goto free;
+	}
+
+	pltfm_host =3D sdhci_priv(host);
+
+	priv =3D sdhci_pltfm_priv(pltfm_host);
+	priv->hrs_addr =3D host->ioaddr;
+	priv->enhanced_strobe =3D false;
+
+	/* reset control line */
+	priv->reset =3D devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->reset)) {
+		dev_err(dev, "%s: request of reset line \"%s\" failed (%ld)\n",
+			__func__, "reset", PTR_ERR(priv->reset));
+		goto free;
+	}
+
+	/* SD master clock */
+	priv->sdmclk =3D devm_clk_get(dev, "sdmclk");
+	if (IS_ERR(priv->sdmclk)) {
+		dev_err(dev, "%s: request of SD master clock failed (%ld)\n",
+			__func__, PTR_ERR(priv->sdmclk));
+		goto err_clk_sdmclk;
+	}
+	pltfm_host->clk =3D priv->sdmclk;
+
+	/* main clock */
+	priv->clk =3D devm_clk_get(dev, "main");
+	if (IS_ERR(priv->clk)) {
+		dev_err(dev, "%s: request of main clock failed (%ld)\n",
+			__func__, PTR_ERR(priv->clk));
+		goto err_clk_main;
+	}
+
+	ret =3D sdhci_cdns_clk_enable(host);
+	if (ret)
+		goto err_clk_enable;
+
+	host->ioaddr +=3D SDHCI_CDNS_SRS_BASE;
+	host->mmc_host_ops.hs400_enhanced_strobe =3D
+				sdhci_cdns_hs400_enhanced_strobe;
+	sdhci_enable_v4_mode(host);
+	__sdhci_read_caps(host, &version, NULL, NULL);
+
+	sdhci_get_of_property(pdev);
+
+	ret =3D mmc_of_parse(host->mmc);
+	if (ret)
+		goto disable_clk;
+
+	ret =3D sdhci_add_host(host);
+	if (ret)
+		goto disable_clk;
+
+	pm_runtime_enable(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 250);
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(priv->clk);
+err_clk_enable:
+	clk_put(priv->clk);
+err_clk_main:
+	clk_put(priv->sdmclk);
+err_clk_sdmclk:
+	reset_control_put(priv->reset);
+free:
+	sdhci_pltfm_free(pdev);
+
+	return ret;
+}
+
+static int sdhci_cdns_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host =3D platform_get_drvdata(pdev);
+	int dead =3D (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) =3D=3D
+		    0xffffffff);
+
+	sdhci_remove_host(host, dead);
+
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	sdhci_cdns_clk_disable(host);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused sdhci_cdns_suspend(struct device *dev)
+{
+	struct sdhci_host *host =3D dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct sdhci_cdns_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	ret =3D sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static int __maybe_unused sdhci_cdns_resume(struct device *dev)
+{
+	struct sdhci_host *host =3D dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct sdhci_cdns_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret =3D clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "can't enable the main clock\n");
+		return ret;
+	}
+
+	ret =3D sdhci_cdns_phy_adj(host, priv->timing);
+	if (ret)
+		goto disable_clk;
+
+	ret =3D sdhci_resume_host(host);
+	if (ret)
+		goto disable_clk;
+
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int sdhci_cdns_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host =3D dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct sdhci_cdns_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret =3D sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
+
+	if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
+		mmc_retune_needed(host->mmc);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int sdhci_cdns_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host =3D dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+	struct sdhci_cdns_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret =3D clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "can't enable the main clock\n");
+		return ret;
+	}
+
+	ret =3D sdhci_runtime_resume_host(host, 0);
+	if (ret)
+		goto disable_clk;
+	return 0;
+
+disable_clk:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+#endif
+
+static const struct dev_pm_ops sdhci_cdns_pm_ops =3D {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_cdns_suspend, sdhci_cdns_resume)
+	SET_RUNTIME_PM_OPS(sdhci_cdns_runtime_suspend,
+			   sdhci_cdns_runtime_resume, NULL)
+};
+
+static const struct of_device_id sdhci_cdns_match[] =3D {
+	{
+		.compatible =3D "starfive,jh8100-sd6hc",
+		.data =3D &sdhci_cdns_jh8100_pltfm_data,
+	},
+	{ .compatible =3D "cdns,sd6hc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
+
+static struct platform_driver sdhci_cdns_driver =3D {
+	.driver =3D {
+		.name =3D "sd6hci-cdns",
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+		.pm =3D &sdhci_cdns_pm_ops,
+		.of_match_table =3D sdhci_cdns_match,
+	},
+	.probe =3D sdhci_cdns_probe,
+	.remove =3D sdhci_cdns_remove,
+};
+module_platform_driver(sdhci_cdns_driver);
+
+MODULE_DESCRIPTION("Cadence SD/SDIO/eMMC Host Controller Version 6 Drive=
r");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-cadence6.h b/drivers/mmc/host/sdhci-c=
adence6.h
new file mode 100644
index 000000000000..dc0201a32f80
--- /dev/null
+++ b/drivers/mmc/host/sdhci-cadence6.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2022-2023 Shanghai StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+#ifndef SDHCI_CADENCE_V6_H_
+#define SDHCI_CADENCE_V6_H_
+
+/* HRS - Host Register Set (specific to Cadence) */
+#define SDHCI_CDNS_HRS04		0x10		/* Combo PHY registers address */
+
+#define SDHCI_CDNS_HRS05		0x14		/* Combo PHY register data port */
+
+#define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
+#define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
+#define   SDHCI_CDNS_HRS06_MODE_SD		0x0
+#define   SDHCI_CDNS_HRS06_MODE_MMC_LEGACY	0x1
+#define   SDHCI_CDNS_HRS06_MODE_MMC_SDR		0x2
+#define   SDHCI_CDNS_HRS06_MODE_MMC_DDR		0x3
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS200	0x4
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
+#define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
+
+#define SDHCI_CDNS_HRS07		0X1C		/* IO Delay Information */
+#define   SDHCI_CDNS_HRS07_RW_COMPENSATE		GENMASK(20, 16)
+#define   SDHCI_CDNS_HRS07_IDELAY_VAL			GENMASK(4, 0)
+
+#define SDHCI_CDNS_HRS09		0x24		/* PHY Control and Status */
+#define   SDHCI_CDNS_HRS09_RDDATA_EN		BIT(16)
+#define   SDHCI_CDNS_HRS09_RDCMD_EN		BIT(15)
+#define   SDHCI_CDNS_HRS09_EXTENDED_WR_MODE	BIT(3)
+#define   SDHCI_CDNS_HRS09_EXTENDED_RD_MODE	BIT(2)
+#define   SDHCI_CDNS_HRS09_PHY_INIT_COMPLETE	BIT(1)
+#define   SDHCI_CDNS_HRS09_PHY_SW_RESET		BIT(0)
+
+#define SDHCI_CDNS_HRS10		0x28		/* SDCLK adjustment */
+#define   SDHCI_CDNS_HRS10_RDDATA_SWAP		BIT(22)
+#define   SDHCI_CDNS_HRS10_HCSDCLKADJ		GENMASK(19, 16)
+
+#define SDHCI_CDNS_HRS11		0x2C		/* eMMC reset */
+#define   SDHCI_CDNS_HRS11_EMMC_RST		BIT(0)
+
+#define SDHCI_CDNS_HRS16		0x40		/* CMD/DAT output delay */
+#define   SDHCI_CDNS_HRS16_WRDATA1_SDCLK_DLY	GENMASK(31, 28)
+#define   SDHCI_CDNS_HRS16_WRDATA0_SDCLK_DLY	GENMASK(27, 24)
+#define   SDHCI_CDNS_HRS16_WRCMD1_SDCLK_DLY	GENMASK(23, 20)
+#define   SDHCI_CDNS_HRS16_WRCMD0_SDCLK_DLY	GENMASK(19, 16)
+#define   SDHCI_CDNS_HRS16_WRDATA1_DLY		GENMASK(15, 12)
+#define   SDHCI_CDNS_HRS16_WRDATA0_DLY		GENMASK(11, 8)
+#define   SDHCI_CDNS_HRS16_WRCMD1_DLY		GENMASK(7, 4)
+#define   SDHCI_CDNS_HRS16_WRCMD0_DLY		GENMASK(3, 0)
+
+struct sdhci_cdns_hrs_reg_vals {
+	u32 val;
+};
+
+/* PHY Special Function Registers */
+#define DLL_PHY_REG_BASE		0x2000
+
+/* register to control the DQ related timing */
+#define PHY_DQ_TIMING_REG_ADDR		0x2000
+#define PHY_DQ_TIMING_REG_IO_MASK_ALWAYS_ON		BIT(31)
+#define PHY_DQ_TIMING_REG_IO_MASK_END			GENMASK(29, 27)
+#define PHY_DQ_TIMING_REG_IO_MASK_START			GENMASK(26, 24)
+#define PHY_DQ_TIMING_REG_DATA_SELECT_OE_END		GENMASK(2, 0)
+
+/* register to control the DQS related timing */
+#define PHY_DQS_TIMING_REG_ADDR		0x2004
+#define PHY_DQS_TIMING_REG_USE_EXT_LPBK_DQS		BIT(22)
+#define PHY_DQS_TIMING_REG_USE_LPBK_DQS			BIT(21)
+#define PHY_DQS_TIMING_REG_USE_PHONY_DQS		BIT(20)
+#define PHY_DQS_TIMING_REG_USE_PHONY_DQS_CMD		BIT(19)
+
+/* register to control the gate and loopback control related timing */
+#define PHY_GATE_LPBK_CTRL_REG_ADDR	0x2008
+#define PHY_GATE_LPBK_CTRL_REG_SYNC_METHOD		BIT(31)
+#define PHY_GATE_LPBK_CTRL_REG_RD_DEL_SEL		GENMASK(23, 19)
+#define PHY_GATE_LPBK_CTRL_REG_UNDERRUN_SUPPRESS	BIT(18)
+#define PHY_GATE_LPBK_CTRL_GATE_CFG_ALWAYS_ON		BIT(6)
+
+/* register to control the Master DLL logic */
+#define PHY_DLL_MASTER_CTRL_REG_ADDR	0x200C
+#define PHY_DLL_MASTER_CTRL_REG_PARAM_DLL_BYPASS_MODE	BIT(23)
+#define PHY_DLL_MASTER_CTRL_REG_PARAM_PHASE_DETECT_SEL	GENMASK(22, 20)
+#define PHY_DLL_MASTER_CTRL_REG_PARAM_DLL_LOCK_NUM	GENMASK(18, 16)
+#define PHY_DLL_MASTER_CTRL_REG_PARAM_DLL_START_POINT	GENMASK(7, 0)
+
+/* register to control the Slave DLL logic */
+#define PHY_DLL_SLAVE_CTRL_REG_ADDR	0x2010
+#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
+#define PHY_DLL_SLAVE_CTRL_REG_CLK_WRITE_DELAY		GENMASK(15, 8)
+#define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
+
+/* register to control the global settings for PHY */
+#define PHY_CTRL_REG_ADDR		0x2080
+#define PHY_CTRL_REG_PU_PD_POLARITY			BIT(21)
+#define PHY_CTRL_REG_PHONY_DQS_TIMING			GENMASK(8, 4)
+#define PHY_CTRL_REG_CTRL_CLKPERIOD_DELAY		BIT(0)
+
+/*
+ * The tuned val register is 6 bit-wide, but not the whole of the range =
is
+ * available.  The range 0-42 seems to be available (then 43 wraps aroun=
d to 0)
+ * but I am not quite sure if it is official.  Use only 0 to 39 for safe=
ty.
+ */
+#define SDHCI_CDNS_MAX_TUNING_LOOP	40
+
+struct sdhci_cdns_priv {
+	void			__iomem *hrs_addr;
+	bool			enhanced_strobe;
+	unsigned char		timing;
+	struct reset_control	*reset;
+	struct clk		*sdmclk;
+	struct clk		*clk;
+};
+
+enum sdhci_cdns_phy_reg {
+	PHY_DQS_TIMING,
+	PHY_GATE_LPBK_CTRL,
+	PHY_DLL_MASTER_CTRL,
+	PHY_DLL_SLAVE_CTRL,
+	PHY_CTRL,
+	PHY_DQ_TIMING,
+};
+
+struct sdhci_cdns_phy_reg_pairs {
+	u32 val;
+	u32 off;
+};
+
+struct sdhci_cdns_phy_reg_vals {
+	struct sdhci_cdns_phy_reg_pairs *reg_pairs;
+	u32 num_regs;
+};
+
+static inline void *sdhci_cdns_priv(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+
+	return sdhci_pltfm_priv(pltfm_host);
+}
+
+unsigned int sdhci_cdns_read_phy_reg(struct sdhci_cdns_priv *priv, u32 a=
ddress);
+void sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv, u32 address,=
 u32 value);
+int sdhci_cdns_phy_adj(struct sdhci_host *host, unsigned char timing);
+u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv);
+
+#endif
--=20
2.25.1


