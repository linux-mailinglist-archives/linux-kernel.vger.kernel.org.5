Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A84577B16F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHNGSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjHNGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:17:51 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E1E18F;
        Sun, 13 Aug 2023 23:17:49 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C145C201B0F;
        Mon, 14 Aug 2023 08:17:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 86AFE201B08;
        Mon, 14 Aug 2023 08:17:47 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E15851800319;
        Mon, 14 Aug 2023 14:17:45 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 6/9] arm: dts: nxp: Add i.MX7D PCIe EP support
Date:   Mon, 14 Aug 2023 13:42:44 +0800
Message-Id: <1691991767-15809-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691991767-15809-1-git-send-email-hongxing.zhu@nxp.com>
References: <1691991767-15809-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7D PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index 4b94b8afb55d..135684f17a20 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -156,6 +156,33 @@ pcie: pcie@33800000 {
 			fsl,imx7d-pcie-phy = <&pcie_phy>;
 			status = "disabled";
 		};
+
+		pcie_ep: pcie-ep@33800000 {
+			compatible = "fsl,imx7d-pcie-ep";
+			reg = <0x33800000 0x4000>,
+			      <0x40000000 0x10000000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			clocks = <&clks IMX7D_PCIE_CTRL_ROOT_CLK>,
+				 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>,
+				 <&clks IMX7D_PCIE_PHY_ROOT_CLK>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
+			assigned-clocks = <&clks IMX7D_PCIE_CTRL_ROOT_SRC>,
+					  <&clks IMX7D_PCIE_PHY_ROOT_SRC>;
+			assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_250M_CLK>,
+						 <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
+
+			fsl,max-link-speed = <2>;
+			power-domains = <&pgc_pcie_phy>;
+			resets = <&src IMX7_RESET_PCIEPHY>,
+				 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
+				 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
+			reset-names = "pciephy", "apps", "turnoff";
+			fsl,imx7d-pcie-phy = <&pcie_phy>;
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.34.1

