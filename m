Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E9E77B16B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjHNGSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjHNGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:17:51 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9310F2;
        Sun, 13 Aug 2023 23:17:46 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2144F1A1C1C;
        Mon, 14 Aug 2023 08:17:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB8421A1C0F;
        Mon, 14 Aug 2023 08:17:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9B4091800319;
        Mon, 14 Aug 2023 14:17:43 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 4/9] arm: dts: nxp: Add i.MX6QDL and i.MX6QP PCIe EP supports
Date:   Mon, 14 Aug 2023 13:42:42 +0800
Message-Id: <1691991767-15809-5-git-send-email-hongxing.zhu@nxp.com>
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

Add i.MX6QDL and i.MX6QP PCIe EP supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp.dtsi  |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index bda182edc589..be02f7882c68 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -289,6 +289,20 @@ pcie: pcie@1ffc000 {
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1ffc000 {
+			compatible = "fsl,imx6q-pcie-ep";
+			reg = <0x01ffc000 0x04000>, <0x01000000 0xf00000>;
+			reg-names = "dbi", "addr_space";
+			num-lanes = <1>;
+			clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
+				 <&clks IMX6QDL_CLK_LVDS1_GATE>,
+				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy";
+			num-ib-windows = <4>;
+			num-ob-windows = <4>;
+			status = "disabled";
+		};
+
 		aips1: bus@2000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
index fc164991d2ae..4ca53a4c254c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp.dtsi
@@ -118,3 +118,7 @@ &mmdc0 {
 &pcie {
 	compatible = "fsl,imx6qp-pcie";
 };
+
+&pcie_ep {
+	compatible = "fsl,imx6qp-pcie-ep";
+};
-- 
2.34.1

