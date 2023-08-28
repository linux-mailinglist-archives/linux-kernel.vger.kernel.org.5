Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55C78B93F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjH1UMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjH1ULw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:11:52 -0400
X-Greylist: delayed 2636 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 13:11:48 PDT
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48898194
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:11:48 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1qahsQ-008Oxv-SS; Mon, 28 Aug 2023 19:26:18 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v2] ARM: dts: imx6qdl-gw5904: add internal mdio nodes
Date:   Mon, 28 Aug 2023 12:26:15 -0700
Message-Id: <20230828192615.1202078-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the switch definition by adding the internal mdio nodes.

This does not change behavior on Linux but is required if the dt is used
for U-Boot which requires the internal PHY ports to be defined for
DSA.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2: rebase and update commit log
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
index 9594bc5745ed..3375b3fd8d4c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
@@ -212,6 +212,27 @@ switch@0 {
 			compatible = "marvell,mv88e6085";
 			reg = <0>;
 
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				sw_phy0: ethernet-phy@0 {
+					reg = <0x0>;
+				};
+
+				sw_phy1: ethernet-phy@1 {
+					reg = <0x1>;
+				};
+
+				sw_phy2: ethernet-phy@2 {
+					reg = <0x2>;
+				};
+
+				sw_phy3: ethernet-phy@3 {
+					reg = <0x3>;
+				};
+			};
+
 			ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -219,21 +240,29 @@ ports {
 				port@0 {
 					reg = <0>;
 					label = "lan4";
+					phy-handle = <&sw_phy0>;
+					phy-mode = "internal";
 				};
 
 				port@1 {
 					reg = <1>;
 					label = "lan3";
+					phy-handle = <&sw_phy1>;
+					phy-mode = "internal";
 				};
 
 				port@2 {
 					reg = <2>;
 					label = "lan2";
+					phy-handle = <&sw_phy2>;
+					phy-mode = "internal";
 				};
 
 				port@3 {
 					reg = <3>;
 					label = "lan1";
+					phy-handle = <&sw_phy3>;
+					phy-mode = "internal";
 				};
 
 				port@5 {
-- 
2.25.1

