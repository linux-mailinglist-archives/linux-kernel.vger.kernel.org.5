Return-Path: <linux-kernel+bounces-44207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66296841EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D4E1F2BE72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9D60B93;
	Tue, 30 Jan 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UFdfHjAt"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA766B46;
	Tue, 30 Jan 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605484; cv=none; b=ldUsa0pI4XX7qQEdmijGRvdIuNnJtHfsX0wKYiAn5tRk8WLV41OeoPMP0sYC/IOCDqCeIItAWf6nHKREbHazp52v3gpHf5t5qXHcW2UD+4Yd5NiNcnZHHP70H4NxqfQznQuHp0PXEH1+7tvijXISEXCqzJwVN7iG4Pby4Wx2XJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605484; c=relaxed/simple;
	bh=YvFyEfP+dCZA9ZKondkqF7lJWdDHPoc6eQRkDL7dZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkQQJMxWQdd4cCPxZVAq3fNt92uyYhVrZ5Y6vNwEHwtT6VqFQ754orhFUlLzRO8kg54P/CYw6r4K6rA6TydxzmzeNXNSP4XBT2FHwboUGyL4LS0HVz2QE2n+1gDF93He52aYNzoPQzNOO3D/IO7zo6nc8PX/60RMkUy8nGoAd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UFdfHjAt; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 97C4F240002;
	Tue, 30 Jan 2024 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706605479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/L6bzf2gaHl/JyjqO/iv8M2x2ZxFgKdEPhznPGhi2w=;
	b=UFdfHjAtq0cdculhhmemTP/dfOs/LSfzOgZf77WhhPHYDXys8PnSWlhThw2cLFuQCqAk6M
	SthqX37ODNd/4vbJN1DkmbnvrbpCAZ/ng7pMwbmL7/fVWKNcv+0xu4AqRRKWOduFPG41Ti
	MRjGX2S/lcFQPd/ajJ80aJk4MynWS7FJ73WhqU+L8FM3Tc46VP83kmbFHod5HabYzz3Zai
	Nz3spRedOhgVgBoB45D9/5lHouceELLs+aHgaDoNTwwxiHI20AHlxsTR4GkHGk3D2baGng
	3XVzayg0VCkDgAax7zTeVJf5fsTcO6tuhVxUrEW8ynHgNVppYD+qQgUpDoirkQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/2] net: phy: Add some configuration from device-tree
Date: Tue, 30 Jan 2024 09:59:35 +0100
Message-ID: <20240130085935.33722-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Some features can now be enabled or disabled from device tree.
If attributes are present in device-tree, features are enabled
or disabled via MDIO registers. Else, hardware configuration is
left as is.
These features are : Energy Detect Mode, PHY Control Frames,
LED configuration and Fiber Mode.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/net/phy/dp83640.c     | 131 +++++++++++++++++++++++++++++++++-
 drivers/net/phy/dp83640_reg.h |  21 +++++-
 2 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 5c42c47dc564..f5770002b849 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <dt-bindings/net/ti-dp83640.h>
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
@@ -16,6 +17,7 @@
 #include <linux/net_tstamp.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/ptp_classify.h>
 #include <linux/ptp_clock_kernel.h>
@@ -1418,15 +1420,142 @@ static int dp83640_ts_info(struct mii_timestamper *mii_ts,
 	return 0;
 }
 
+#ifdef CONFIG_OF_MDIO
+static int dp83640_of_init(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct device_node *of_node = dev->of_node;
+	int reg_val;
+	u32 of_val;
+	int ret;
+
+	if (!of_node)
+		return 0;
+
+	/* All configured features reside in PAGE 0 */
+	phy_write(phydev, PAGESEL, 0);
+
+	/* Energy detect mode */
+	reg_val = phy_read(phydev, EDCR);
+	if (of_property_present(of_node, "ti,energy-detect-en"))
+		reg_val |= ED_EN;
+	else
+		reg_val &= ~ED_EN;
+	phy_write(phydev, EDCR, reg_val);
+
+	/* CLK_OUTPUT Pin */
+	if (of_property_present(of_node, "ti,clk-output")) {
+		ret = of_property_read_u32(of_node, "ti,clk-output", &of_val);
+		if (ret)
+			return ret;
+
+		reg_val = phy_read(phydev, PHYCR2);
+		switch (of_val) {
+		case 0:
+			reg_val |= CLK_OUT_DIS;
+			break;
+		case 1:
+			reg_val &= ~CLK_OUT_DIS;
+			break;
+		default:
+			phydev_err(phydev, "Invalid value for ti,clk-output property (%d)"
+					, of_val);
+			return -EINVAL;
+		}
+		phy_write(phydev, PHYCR2, reg_val);
+	}
+
+	/* LED configuration */
+	if (of_property_present(of_node, "ti,led-config"))  {
+		ret = of_property_read_u32(of_node, "ti,led-config", &of_val);
+		if (ret)
+			return ret;
+
+		reg_val = phy_read(phydev, PHYCR) & ~(LED_CNFG_1 | LED_CNFG_0);
+		switch (of_val) {
+		case DP83640_PHYCR_LED_CNFG_MODE_1:
+			reg_val |= LED_CNFG_0;
+			break;
+		case DP83640_PHYCR_LED_CNFG_MODE_2:
+			/* Keeping LED_CNFG_1 and LED_CNFG_0 unset */
+			break;
+		case DP83640_PHYCR_LED_CNFG_MODE_3:
+			reg_val |= LED_CNFG_1;
+			break;
+		default:
+			phydev_err(phydev, "Invalid value for ti,led-config property (%d)"
+					, of_val);
+			return -EINVAL;
+		}
+		phy_write(phydev, PHYCR, reg_val);
+	}
+	if (of_property_present(of_node, "ti,phy-control-frames")) {
+		of_property_read_u32(of_node, "ti,phy-control-frames", &of_val);
+		if (ret)
+			return ret;
+
+		reg_val = phy_read(phydev, PCFCR);
+		switch (of_val) {
+		case 0:
+			reg_val &= ~PCF_EN;
+			break;
+		case 1:
+			reg_val |= PCF_EN;
+			break;
+		default:
+			phydev_err(phydev, "Invalid value for ti,phy-control-frames property (%d)"
+					, of_val);
+			return -EINVAL;
+		}
+		phy_write(phydev, PCFCR, reg_val);
+	}
+	if (of_property_present(of_node, "ti,fiber-mode")) {
+		ret = of_property_read_u32(of_node, "ti,fiber-mode", &of_val);
+		if (ret)
+			return ret;
+
+		reg_val = phy_read(phydev, PCSR);
+		switch (of_val) {
+		case 0:
+			reg_val &= ~FX_EN;
+			break;
+		case 1:
+			reg_val |= FX_EN;
+			break;
+		default:
+			phydev_err(phydev, "Invalid value for ti,fiber-mode property (%d)"
+					, of_val);
+			return -EINVAL;
+		}
+		phy_write(phydev, PCSR, reg_val);
+		/* Write SOFT_RESET bit to ensure configuration */
+		reg_val = phy_read(phydev, PHYCR2) | SOFT_RESET;
+		phy_write(phydev, PHYCR2, reg_val);
+	}
+
+	return 0;
+}
+#else
+static int dp83640_of_init(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif /* CONFIG_OF_MDIO */
+
 static int dp83640_probe(struct phy_device *phydev)
 {
 	struct dp83640_clock *clock;
 	struct dp83640_private *dp83640;
-	int err = -ENOMEM, i;
+	int err, i;
 
 	if (phydev->mdio.addr == BROADCAST_ADDR)
 		return 0;
 
+	err = dp83640_of_init(phydev);
+	if (err < 0)
+		return err;
+
+	err = -ENOMEM;
 	clock = dp83640_clock_get_bus(phydev->mdio.bus);
 	if (!clock)
 		goto no_clock;
diff --git a/drivers/net/phy/dp83640_reg.h b/drivers/net/phy/dp83640_reg.h
index daae7fa58fb8..8877ba560406 100644
--- a/drivers/net/phy/dp83640_reg.h
+++ b/drivers/net/phy/dp83640_reg.h
@@ -6,7 +6,11 @@
 #define HAVE_DP83640_REGISTERS
 
 /* #define PAGE0                  0x0000 */
+#define PCSR                      0x0016 /* PCS Configuration and Status Register */
+#define PHYCR                     0x0019 /* PHY Control Register */
 #define PHYCR2                    0x001c /* PHY Control Register 2 */
+#define EDCR                      0x001D /* Energy Detect Control Register */
+#define PCFCR                     0x001F /* PHY Control Frames Control Register */
 
 #define PAGE4                     0x0004
 #define PTP_CTL                   0x0014 /* PTP Control Register */
@@ -50,8 +54,23 @@
 #define PTP_GPIOMON               0x001e /* PTP GPIO Monitor Register */
 #define PTP_RXHASH                0x001f /* PTP Receive Hash Register */
 
+/* Bit definitions for the PCSR register */
+#define FX_EN		          BIT(6)  /* Enable FX Fiber Mode */
+
+/* Bit definitions for the PHYCR register */
+#define LED_CNFG_0	          BIT(5)  /* LED configuration, bit 0 */
+#define LED_CNFG_1	          BIT(6)  /* LED configuration, bit 1 */
+
 /* Bit definitions for the PHYCR2 register */
-#define BC_WRITE                  (1<<11) /* Broadcast Write Enable */
+#define CLK_OUT_DIS	          BIT(1)  /* Disable CLK_OUT pin */
+#define SOFT_RESET		  BIT(9)  /* Soft Reset */
+#define BC_WRITE                  BIT(11) /* Broadcast Write Enable */
+
+/* Bit definitions for the EDCR register */
+#define ED_EN		          BIT(15) /* Enable Energy Detect Mode */
+
+/* Bit definitions for the PCFCR register */
+#define PCF_EN	                  BIT(0)  /* Enable PHY Control Frames */
 
 /* Bit definitions for the PTP_CTL register */
 #define TRIG_SEL_SHIFT            (10)    /* PTP Trigger Select */
-- 
2.43.0


