Return-Path: <linux-kernel+bounces-153004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C273D8AC75B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE8C283089
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983B54645;
	Mon, 22 Apr 2024 08:46:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA4482C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775597; cv=none; b=HKF9JjjD8V8TJpS7yVGGWL+vW9ScI6aV7RGYVwhXR8QCGkRBjMg7g7f1tlQGdOeRy45EEjpaYnMvyysFs9IBWuS/5sUajMn04WtwqxCTG2DSMspSV4GFsmy3RDyKWQaVMOu5ocB+FCCqDvn7Taa6d+bBAdxvhzcmhN0/TJPkZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775597; c=relaxed/simple;
	bh=hbWncv3O5p+eXPs67WyDuajeTIZwF1P/8g1gar0nJUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaP6IhtArjiWEePOBp0BkB59QoG/TEKudKXNMJ3Tls3TIBxZr1wfyk3SF0R1zWNpVMiqunKQ76p0BtpFJAD7loGpe+iQjur5GZrN6o87061boBnjUFXHrD2QRjMfguPGd7jP+z/dn4WNzD1AcHuB6nSvnMV4GfhIWs50SPBz0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rypJg-0000ML-DO; Mon, 22 Apr 2024 10:46:24 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 22 Apr 2024 10:46:19 +0200
Subject: [PATCH 3/3] net: stmicro: imx: set TX_CLK direction in RMII mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-v6-9-topic-imx93-eqos-rmii-v1-3-30151fca43d2@pengutronix.de>
References: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
In-Reply-To: <20240422-v6-9-topic-imx93-eqos-rmii-v1-0-30151fca43d2@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Linux Team <linux-imx@nxp.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.13.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In case of RMII connection, the TX_CLK must be set to output direction.
Parse the register and offset from the devicetree and set the direction
of the TX_CLK when the property was provided.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 6b65420e11b5c..0fc81a626a664 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -37,6 +37,9 @@
 #define MX93_GPR_ENET_QOS_INTF_SEL_RGMII	(0x1 << 1)
 #define MX93_GPR_ENET_QOS_CLK_GEN_EN		(0x1 << 0)
 
+#define MX93_GPR_ENET_QOS_TX_CLK_SEL_MASK	GENMASK(1, 1)
+#define MX93_GPR_ENET_QOS_TX_CLK_SEL		(0x1 << 1)
+
 #define DMA_BUS_MODE			0x00001000
 #define DMA_BUS_MODE_SFT_RESET		(0x1 << 0)
 #define RMII_RESET_SPEED		(0x3 << 14)
@@ -57,7 +60,9 @@ struct imx_priv_data {
 	struct clk *clk_tx;
 	struct clk *clk_mem;
 	struct regmap *intf_regmap;
+	struct regmap *enet_clk_regmap;
 	u32 intf_reg_off;
+	u32 enet_clk_reg_off;
 	bool rmii_refclk_ext;
 	void __iomem *base_addr;
 
@@ -116,6 +121,18 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val = MX93_GPR_ENET_QOS_INTF_SEL_RMII;
+
+		/* According to NXP AN14149, the direction of the
+		 * TX_CLK must be set to output in RMII mode.
+		 */
+		if (dwmac->enet_clk_regmap)
+			regmap_update_bits(dwmac->enet_clk_regmap,
+					   dwmac->enet_clk_reg_off,
+					   MX93_GPR_ENET_QOS_TX_CLK_SEL_MASK,
+					   MX93_GPR_ENET_QOS_TX_CLK_SEL);
+		else
+			dev_warn(dwmac->dev, "TX_CLK can't be set to output mode.\n");
+
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -310,6 +327,16 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 			dev_err(dev, "Can't get intf mode reg offset (%d)\n", err);
 			return err;
 		}
+
+		dwmac->enet_clk_regmap = syscon_regmap_lookup_by_phandle(np, "enet_clk_sel");
+		if (IS_ERR(dwmac->enet_clk_regmap))
+			return PTR_ERR(dwmac->enet_clk_regmap);
+
+		err = of_property_read_u32_index(np, "enet_clk_sel", 1, &dwmac->enet_clk_reg_off);
+		if (err) {
+			dev_err(dev, "Can't get enet clk sel reg offset (%d)\n", err);
+			return err;
+		}
 	}
 
 	return err;

-- 
2.43.2


