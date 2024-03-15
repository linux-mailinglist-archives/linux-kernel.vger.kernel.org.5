Return-Path: <linux-kernel+bounces-104961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905287D69D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5090F284010
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6631E59B47;
	Fri, 15 Mar 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cioaNmqa"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFA58225;
	Fri, 15 Mar 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710541729; cv=none; b=BmVMRxiKZK9TTY2OtDz58i2uAR/dm6ELSKK7WGpe+kZgDDArqcGC8/UsS+Xpj/juyxw36XsMRdSAuJ0RNQ3S5jYitJ3s+Dg0bELhfgwczAaEP6/Y9v5ZKgs/OsMXeYg63v05nJhODfkkOC4fdDHuUs2ifBN37o6C3qgUHVhJAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710541729; c=relaxed/simple;
	bh=/Em0EdX46q1ePPaeGgwt1AIfqbS9GnqEOoFYsjmP84A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CQM4iJYB/H6V9FpXWPBCAqzW2ACG68BwI64KZJRJIqBMhLNTGbSiNW3VPbewCZlaHPTpAJCm5pgJJJBqg6y7mUhYwYeYp6HGUICFe36/YmxdUZxiZoFqJKDQtaYvlKGHDFzFZ5kl//0wsm0ymtH2h3KEnGMOW65FWvAtUZD1Uw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cioaNmqa; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5687feeb1feso2589164a12.2;
        Fri, 15 Mar 2024 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710541725; x=1711146525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYdzaI1eyA1l5LCnb5/DYNm+G0BOSq1irGEnCEKn3hw=;
        b=cioaNmqa+hzyx5Eh84KFIwMDq0O3LTbVeUZN5t5YPIZume9JLh/ARPFX2K4CaH/6cG
         kvWqSinkfxL7OwuvWe3fkt2p1zcHwgflECbCjFVXKALuZ/ROrGNWBkkCBkMqMBlX9QEJ
         wEu3diTrzgCvkFB8STxCmBTEo2/Tq+xF9PxBEnGI1CSww7dKpgFavwlIkm1Wp2WOamPL
         VPLBvWFXXfeunlo8/Gtgr+Wo1PqcyhqHZyQQcr7mr7+5slWJhaUFN4E4ggwGIQ0mi8Y4
         Ho4H0OFa+HRA+jKZdbF0ev7y2DmgYC7mRMrMGWR1tINLHU0638OEbZfTwGhUKd9eUca9
         9CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710541725; x=1711146525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYdzaI1eyA1l5LCnb5/DYNm+G0BOSq1irGEnCEKn3hw=;
        b=N5KeMpnI361QdEnn+j1fSGNY7gEU6iPvkGBouHW5h3lZXT9l5lP4PE3qXuXbnFbMg7
         5fuK7MnM10Z4er9q2ep1HJoATgLImuda7i1NmlZbpyc1AeDKnjDjfW6Xogna67piAZJJ
         C7oy1mE/DgOZKx3A1SWrtb/68Ay7wLiq1biuTTEAACIQ2wSV3V9lw+Imyk38Q9p7yD8x
         VJfCGfMwq7avRITn/+oyFTGDIy7pWPKp7D9Q+RNCx6OCr8wjGmDOv0xelhayax4/rCWR
         gzVtUwRAn45t4JXtLoSHgCf6RHVg7N1H6FYJwq/twiQgBoq//HAhtKTgayudIDBL5WBL
         D6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVuHICB8LgsP9kHx4TO1Z84U29t6CKT+XccmsufsdLEH+GnQ3BKl/zKlHInq6sXkUI+AHLgx4kZPxU58k8mmIyinrVaTqaCv+jm7egAWAj0YJCjF8OPvQOdcxA39i+mcMIWxIxDOA7ylu4YwyU25vIeG46ILNu5uRrVacbs+9W0SDygTJDtqErCgou39aZAfqDAKbHSK9WgGXYRzg==
X-Gm-Message-State: AOJu0YywmjnqMS/nv1g8k7+4WXHuznfLqFM/cNnyJMvvY3UWgVJEXynC
	veEfP6YdChvaiPZdRCXDkLmUIyIvt4e0ivkLPwxyTqfD02n25BUA
X-Google-Smtp-Source: AGHT+IHxKuh84z/F3OBiz6d2Qj0ZQHQzmu8WpEQSSVaxaFcnXA5VKEtbGnPyU13CE3uQE7JxMXXEmQ==
X-Received: by 2002:aa7:c54e:0:b0:566:ecce:9d3c with SMTP id s14-20020aa7c54e000000b00566ecce9d3cmr276215edr.26.1710541724771;
        Fri, 15 Mar 2024 15:28:44 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::f845])
        by smtp.googlemail.com with ESMTPSA id el9-20020a056402360900b005684173e413sm2039833edb.72.2024.03.15.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 15:28:44 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-clk@vger.kernel.org
Subject: [PATCH 2/3] net: stmmac: Add NXP S32 SoC family support
Date: Fri, 15 Mar 2024 23:27:48 +0100
Message-Id: <20240315222754.22366-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240315222754.22366-1-wafgo01@gmail.com>
References: <20240315222754.22366-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for NXP S32 SoC family's GMAC to the stmmac network driver. This driver implementation is based on the patchset originally contributed by Chester Lin [1], which itself draws heavily from NXP's downstream implementation [2]. The patchset was never merged.

The S32G2/3 SoCs feature multiple Ethernet interfaces (PFE0, PFE1, PFE2, and GMAC) which can be routed through a SerDes Subsystem, supporting various interfaces such as SGMII and RGMII. However, the current Glue Code lacks support for SerDes routing and pinctrl handling, relying solely on correct settings in U-Boot. Clock settings for this SoC are managed by the ATF Firmware.

Changes made compared to [1]:

    Rebased onto Linux 6.8-rc7
    Consolidated into a single commit
    Minor adjustments in naming and usage of dev_err()/dev_info()

Test Environment:
The driver has been successfully tested on the official S32G-VNP-RDB3 Reference Design Board from NXP, utilizing an S32G3 SoC. The firmware and U-Boot used were from the BSP39 Release. The official BSP39 Ubuntu 22.04 Release was successfully booted. A network stress test using iperf [3] was also executed without issues.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20221031101052.14956-6-clin@suse.com/#25068228
[2] https://github.com/nxp-auto-linux/linux/blob/release/bsp39.0-5.15.129-rt/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
[3] https://linux.die.net/man/1/iperf
[4] https://github.com/nxp-auto-linux/u-boot
[5] https://github.com/nxp-auto-linux/arm-trusted-firmware

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 drivers/net/ethernet/stmicro/stmmac/common.h  |   3 +
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 313 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |   9 +
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |   3 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   5 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   7 +
 include/linux/stmmac.h                        |   9 +
 9 files changed, 362 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 85dcda51df05..1cdf2da0251c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -142,6 +142,18 @@ config DWMAC_ROCKCHIP
 	  This selects the Rockchip RK3288 SoC glue layer support for
 	  the stmmac device driver.
 
+config DWMAC_S32
+	tristate "NXP S32 series GMAC support"
+	default ARCH_S32
+	depends on OF && (ARCH_S32 || COMPILE_TEST)
+	select PHYLINK
+	help
+	  Support for ethernet controller on NXP S32 series SOCs.
+
+	  This selects NXP SoC glue layer support for the stmmac
+	  device driver. This driver is used for the S32 series
+	  SOCs GMAC ethernet controller.
+
 config DWMAC_SOCFPGA
 	tristate "SOCFPGA dwmac support"
 	default ARCH_INTEL_SOCFPGA
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 26cad4344701..c48ff95ed972 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
 obj-$(CONFIG_DWMAC_IMX8)	+= dwmac-imx.o
 obj-$(CONFIG_DWMAC_TEGRA)	+= dwmac-tegra.o
 obj-$(CONFIG_DWMAC_VISCONTI)	+= dwmac-visconti.o
+obj-$(CONFIG_DWMAC_S32)	+= dwmac-s32.o
 stmmac-platform-objs:= stmmac_platform.o
 dwmac-altr-socfpga-objs := dwmac-socfpga.o
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 5ba606a596e7..e5e23e8c07e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -254,6 +254,9 @@ struct stmmac_safety_stats {
 #define CSR_F_150M	150000000
 #define CSR_F_250M	250000000
 #define CSR_F_300M	300000000
+#define CSR_F_500M	500000000
+#define CSR_F_800M	800000000
+
 
 #define	MAC_CSR_H_FRQ_MASK	0x20
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
new file mode 100644
index 000000000000..1920eeed2269
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DWMAC Specific Glue layer for NXP S32 SoCs
+ *
+ * Copyright (C) 2019-2022 NXP
+ * Copyright (C) 2022 SUSE LLC
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/of_address.h>
+#include <linux/stmmac.h>
+#include "stmmac_platform.h"
+
+#define GMAC_TX_RATE_125M 125000000 /* 125MHz */
+#define GMAC_TX_RATE_25M 25000000 /* 25MHz */
+#define GMAC_TX_RATE_2M5 2500000 /* 2.5MHz */
+
+/* S32 SRC register for phyif selection */
+#define PHY_INTF_SEL_MII 0x00
+#define PHY_INTF_SEL_SGMII 0x01
+#define PHY_INTF_SEL_RGMII 0x02
+#define PHY_INTF_SEL_RMII 0x08
+
+/* AXI4 ACE control settings */
+#define ACE_DOMAIN_SIGNAL 0x2
+#define ACE_CACHE_SIGNAL 0xf
+#define ACE_CONTROL_SIGNALS ((ACE_DOMAIN_SIGNAL << 4) | ACE_CACHE_SIGNAL)
+#define ACE_PROTECTION 0x2
+
+struct s32_priv_data {
+	void __iomem *ctrl_sts;
+	struct device *dev;
+	phy_interface_t intf_mode;
+	struct clk *tx_clk;
+	struct clk *rx_clk;
+};
+
+static int s32_gmac_init(struct platform_device *pdev, void *priv)
+{
+	struct s32_priv_data *gmac = priv;
+	u32 intf_sel;
+	int ret;
+
+	if (gmac->tx_clk) {
+		ret = clk_prepare_enable(gmac->tx_clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't set tx clock\n");
+			return ret;
+		}
+	}
+
+	if (gmac->rx_clk) {
+		ret = clk_prepare_enable(gmac->rx_clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't set rx clock\n");
+			return ret;
+		}
+	}
+
+	/* set interface mode */
+	if (gmac->ctrl_sts) {
+		switch (gmac->intf_mode) {
+		default:
+			dev_info(
+				&pdev->dev,
+				"unsupported mode %u, set the default phy mode.\n",
+				gmac->intf_mode);
+			fallthrough;
+		case PHY_INTERFACE_MODE_SGMII:
+			dev_info(&pdev->dev, "phy mode set to SGMII\n");
+			intf_sel = PHY_INTF_SEL_SGMII;
+			break;
+		case PHY_INTERFACE_MODE_RGMII:
+		case PHY_INTERFACE_MODE_RGMII_ID:
+		case PHY_INTERFACE_MODE_RGMII_TXID:
+		case PHY_INTERFACE_MODE_RGMII_RXID:
+			dev_info(&pdev->dev, "phy mode set to RGMII\n");
+			intf_sel = PHY_INTF_SEL_RGMII;
+			break;
+		case PHY_INTERFACE_MODE_RMII:
+			dev_info(&pdev->dev, "phy mode set to RMII\n");
+			intf_sel = PHY_INTF_SEL_RMII;
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			dev_info(&pdev->dev, "phy mode set to MII\n");
+			intf_sel = PHY_INTF_SEL_MII;
+			break;
+		}
+
+		writel(intf_sel, gmac->ctrl_sts);
+	}
+
+	return 0;
+}
+
+static void s32_gmac_exit(struct platform_device *pdev, void *priv)
+{
+	struct s32_priv_data *gmac = priv;
+
+	if (gmac->tx_clk)
+		clk_disable_unprepare(gmac->tx_clk);
+
+	if (gmac->rx_clk)
+		clk_disable_unprepare(gmac->rx_clk);
+}
+
+static void s32_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct s32_priv_data *gmac = priv;
+
+	if (!gmac->tx_clk || !gmac->rx_clk)
+		return;
+
+	/* SGMII mode doesn't support the clock reconfiguration */
+	if (gmac->intf_mode == PHY_INTERFACE_MODE_SGMII)
+		return;
+
+	switch (speed) {
+	case SPEED_1000:
+		dev_info(gmac->dev, "Set TX clock to 125M\n");
+		clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
+		break;
+	case SPEED_100:
+		dev_info(gmac->dev, "Set TX clock to 25M\n");
+		clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_25M);
+		break;
+	case SPEED_10:
+		dev_info(gmac->dev, "Set TX clock to 2.5M\n");
+		clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_2M5);
+		break;
+	default:
+		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", speed);
+		return;
+	}
+}
+
+static int s32_config_cache_coherency(struct platform_device *pdev,
+				      struct plat_stmmacenet_data *plat_dat)
+{
+	plat_dat->axi4_ace_ctrl = devm_kzalloc(
+		&pdev->dev, sizeof(struct stmmac_axi4_ace_ctrl), GFP_KERNEL);
+
+	if (!plat_dat->axi4_ace_ctrl)
+		return -ENOMEM;
+
+	plat_dat->axi4_ace_ctrl->tx_ar_reg = (ACE_CONTROL_SIGNALS << 16) |
+					     (ACE_CONTROL_SIGNALS << 8) |
+					     ACE_CONTROL_SIGNALS;
+
+	plat_dat->axi4_ace_ctrl->rx_aw_reg =
+		(ACE_CONTROL_SIGNALS << 24) | (ACE_CONTROL_SIGNALS << 16) |
+		(ACE_CONTROL_SIGNALS << 8) | ACE_CONTROL_SIGNALS;
+
+	plat_dat->axi4_ace_ctrl->txrx_awar_reg =
+		(ACE_PROTECTION << 20) | (ACE_PROTECTION << 16) |
+		(ACE_CONTROL_SIGNALS << 8) | ACE_CONTROL_SIGNALS;
+
+	return 0;
+}
+
+static int s32_dwmac_probe(struct platform_device *pdev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct s32_priv_data *gmac;
+	struct resource *res;
+	const char *tx_clk, *rx_clk;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	gmac = devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
+	if (!gmac)
+		return PTR_ERR(gmac);
+
+	gmac->dev = &pdev->dev;
+
+	/* S32G control reg */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	gmac->ctrl_sts = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR_OR_NULL(gmac->ctrl_sts)) {
+		dev_err(&pdev->dev, "S32G config region is missing\n");
+		return PTR_ERR(gmac->ctrl_sts);
+	}
+
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	plat_dat->bsp_priv = gmac;
+
+	switch (plat_dat->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		tx_clk = "tx_sgmii";
+		rx_clk = "rx_sgmii";
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		tx_clk = "tx_rgmii";
+		rx_clk = "rx_rgmii";
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		tx_clk = "tx_rmii";
+		rx_clk = "rx_rmii";
+		break;
+	case PHY_INTERFACE_MODE_MII:
+		tx_clk = "tx_mii";
+		rx_clk = "rx_mii";
+		break;
+	default:
+		dev_err(&pdev->dev, "Not supported phy interface mode: [%s]\n",
+			phy_modes(plat_dat->phy_interface));
+		return -EINVAL;
+	};
+
+	gmac->intf_mode = plat_dat->phy_interface;
+
+	/* DMA cache coherency settings */
+	if (of_dma_is_coherent(pdev->dev.of_node)) {
+		ret = s32_config_cache_coherency(pdev, plat_dat);
+		if (ret)
+			return ret;
+	}
+
+	/* tx clock */
+	gmac->tx_clk = devm_clk_get(&pdev->dev, tx_clk);
+	if (IS_ERR(gmac->tx_clk)) {
+		dev_info(&pdev->dev, "tx clock not found\n");
+		gmac->tx_clk = NULL;
+	}
+
+	/* rx clock */
+	gmac->rx_clk = devm_clk_get(&pdev->dev, rx_clk);
+	if (IS_ERR(gmac->rx_clk)) {
+		dev_info(&pdev->dev, "rx clock not found\n");
+		gmac->rx_clk = NULL;
+	}
+
+	ret = s32_gmac_init(pdev, gmac);
+	if (ret)
+		return ret;
+
+	/* core feature set */
+	plat_dat->has_gmac4 = true;
+	plat_dat->pmt = 1;
+
+	plat_dat->init = s32_gmac_init;
+	plat_dat->exit = s32_gmac_exit;
+	plat_dat->fix_mac_speed = s32_fix_speed;
+
+	/* safety feature config */
+	plat_dat->safety_feat_cfg = devm_kzalloc(
+		&pdev->dev, sizeof(*plat_dat->safety_feat_cfg), GFP_KERNEL);
+
+	if (!plat_dat->safety_feat_cfg) {
+		dev_err(&pdev->dev, "allocate safety_feat_cfg failed\n");
+		goto err_gmac_exit;
+	}
+
+	plat_dat->safety_feat_cfg->tsoee = 1;
+	plat_dat->safety_feat_cfg->mrxpee = 1;
+	plat_dat->safety_feat_cfg->mestee = 1;
+	plat_dat->safety_feat_cfg->mrxee = 1;
+	plat_dat->safety_feat_cfg->mtxee = 1;
+	plat_dat->safety_feat_cfg->epsi = 1;
+	plat_dat->safety_feat_cfg->edpp = 1;
+	plat_dat->safety_feat_cfg->prtyen = 1;
+	plat_dat->safety_feat_cfg->tmouten = 1;
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		goto err_gmac_exit;
+
+	return 0;
+
+err_gmac_exit:
+	s32_gmac_exit(pdev, plat_dat->bsp_priv);
+	return ret;
+}
+
+static const struct of_device_id s32_dwmac_match[] = {
+	{ .compatible = "nxp,s32-dwmac" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, s32_dwmac_match);
+
+static struct platform_driver s32_dwmac_driver = {
+	.probe  = s32_dwmac_probe,
+	.remove_new = stmmac_pltfr_remove,
+	.driver = {
+		.name           = "s32-dwmac",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = s32_dwmac_match,
+	},
+};
+module_platform_driver(s32_dwmac_driver);
+
+MODULE_AUTHOR("Jan Petrous <jan.petrous@nxp.com>");
+MODULE_DESCRIPTION("NXP S32 GMAC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..edb559c36509 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -556,6 +556,14 @@ static int dwmac4_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
 	return 0;
 }
 
+static void dwmac4_set_axi4_cc(struct stmmac_priv *priv, void __iomem *ioaddr,
+			   struct stmmac_axi4_ace_ctrl *acecfg)
+{
+	writel(acecfg->tx_ar_reg, ioaddr + DMA_AXI4_TX_AR_ACE_CONTROL);
+	writel(acecfg->rx_aw_reg, ioaddr + DMA_AXI4_RX_AW_ACE_CONTROL);
+	writel(acecfg->txrx_awar_reg, ioaddr + DMA_AXI4_TXRX_AWAR_ACE_CONTROL);
+}
+
 const struct stmmac_dma_ops dwmac4_dma_ops = {
 	.reset = dwmac4_dma_reset,
 	.init = dwmac4_dma_init,
@@ -608,6 +616,7 @@ const struct stmmac_dma_ops dwmac410_dma_ops = {
 	.set_tx_ring_len = dwmac4_set_tx_ring_len,
 	.set_rx_tail_ptr = dwmac4_set_rx_tail_ptr,
 	.set_tx_tail_ptr = dwmac4_set_tx_tail_ptr,
+	.set_axi4_cc = dwmac4_set_axi4_cc,
 	.enable_tso = dwmac4_enable_tso,
 	.qmode = dwmac4_qmode,
 	.set_bfsize = dwmac4_set_bfsize,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 358e7dcb6a9a..7195c643774f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -22,6 +22,9 @@
 #define DMA_DEBUG_STATUS_1		0x00001010
 #define DMA_DEBUG_STATUS_2		0x00001014
 #define DMA_AXI_BUS_MODE		0x00001028
+#define DMA_AXI4_TX_AR_ACE_CONTROL	0x00001020
+#define DMA_AXI4_RX_AW_ACE_CONTROL	0x00001024
+#define DMA_AXI4_TXRX_AWAR_ACE_CONTROL	0x00001028
 #define DMA_TBS_CTRL			0x00001050
 
 /* DMA Bus Mode bitmap */
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 7be04b54738b..6ea2d8f562d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -227,6 +227,9 @@ struct stmmac_dma_ops {
 				u32 tail_ptr, u32 chan);
 	void (*set_tx_tail_ptr)(struct stmmac_priv *priv, void __iomem *ioaddr,
 				u32 tail_ptr, u32 chan);
+    	/* Configure AXI4 cache coherency for Tx and Rx DMA channels */
+        void (*set_axi4_cc)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			   struct stmmac_axi4_ace_ctrl *acecfg);
 	void (*enable_tso)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   bool en, u32 chan);
 	void (*qmode)(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -285,6 +288,8 @@ struct stmmac_dma_ops {
 	stmmac_do_void_callback(__priv, dma, set_rx_tail_ptr, __priv, __args)
 #define stmmac_set_tx_tail_ptr(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, set_tx_tail_ptr, __priv, __args)
+#define stmmac_set_axi4_cc(__priv, __args...) \
+        stmmac_do_void_callback(__priv, dma, set_axi4_cc, __priv, __args)
 #define stmmac_enable_tso(__priv, __args...) \
 	stmmac_do_void_callback(__priv, dma, enable_tso, __priv, __args)
 #define stmmac_dma_qmode(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7c6aef033a45..b7b4d7dd1149 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -324,6 +324,10 @@ static void stmmac_clk_csr_set(struct stmmac_priv *priv)
 			priv->clk_csr = STMMAC_CSR_150_250M;
 		else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
 			priv->clk_csr = STMMAC_CSR_250_300M;
+		else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
+			priv->clk_csr = STMMAC_CSR_300_500M;
+		else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
+			priv->clk_csr = STMMAC_CSR_500_800M;
 	}
 
 	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
@@ -3030,6 +3034,9 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	if (priv->plat->axi)
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
 
+	if (priv->plat->axi4_ace_ctrl)
+		stmmac_set_axi4_cc(priv, priv->ioaddr, priv->plat->axi4_ace_ctrl);
+
 	/* DMA CSR Channel configuration */
 	for (chan = 0; chan < dma_csr_ch; chan++) {
 		stmmac_init_chan(priv, priv->ioaddr, priv->plat->dma_cfg, chan);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..a69ac8b9274e 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -34,6 +34,8 @@
 #define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_scr_i/26 */
 #define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_scr_i/102 */
 #define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/122 */
+#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_scr_i/204 */
+#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_scr_i/324 */
 
 /* MTL algorithms identifiers */
 #define MTL_TX_ALGORITHM_WRR	0x0
@@ -115,6 +117,12 @@ struct stmmac_axi {
 	bool axi_rb;
 };
 
+struct stmmac_axi4_ace_ctrl {
+	u32 tx_ar_reg;
+	u32 rx_aw_reg;
+	u32 txrx_awar_reg;
+};
+
 #define EST_GCL		1024
 struct stmmac_est {
 	struct mutex lock;
@@ -296,6 +304,7 @@ struct plat_stmmacenet_data {
 	struct reset_control *stmmac_rst;
 	struct reset_control *stmmac_ahb_rst;
 	struct stmmac_axi *axi;
+	struct stmmac_axi4_ace_ctrl *axi4_ace_ctrl;
 	int has_gmac4;
 	int rss_en;
 	int mac_port_sel_speed;
-- 
2.25.1


