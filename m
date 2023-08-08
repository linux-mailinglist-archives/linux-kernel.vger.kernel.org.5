Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33660774583
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjHHSnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHHSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:42:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7C114274;
        Tue,  8 Aug 2023 09:36:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378DZAEV081691;
        Tue, 8 Aug 2023 08:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691501710;
        bh=Gec+PlfxvHyoRA3dEj4AxO6X7XqqUtC2GWCVDqHinbU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hhCRI64cmzB3sDuEvcQzQD9iaJGkFHmTyj4mIjCqfWnhGLbmHRJqqNJq5tc6HQ/zV
         X/PCaJ3+vyGVnRoMvkB79rd6PepLjWtA4DxS2KPIiPVa4nBcEojIr4w51xH50XRNO3
         lFuWJBFdvRLUyZPmnAJ2n3YNOtH8V69icjaHqbHY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378DZA0f004701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 08:35:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 08:35:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 08:35:09 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378DZ4Px053163;
        Tue, 8 Aug 2023 08:35:09 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Dhruva Gole <d-gole@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2 07/13] arm64: dts: ti: k3-am64: Enable OSPI nodes at the board level
Date:   Tue, 8 Aug 2023 08:34:51 -0500
Message-ID: <20230808133457.25060-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808133457.25060-1-afd@ti.com>
References: <20230808133457.25060-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSPI nodes defined in the top-level AM64 SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux and
device information.

As the attached OSPI device is only known about at the board integration
level, these nodes should only be enabled when provided with this
information.

Disable the OSPI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi        | 1 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts         | 1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts          | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 4e3e450e4e4c8..ed1b63b9c1c5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -794,6 +794,7 @@ ospi0: spi@fc40000 {
 			assigned-clock-parents = <&k3_clks 75 7>;
 			assigned-clock-rates = <166666666>;
 			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 5606d775153d4..1c2c8f0daca9f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -181,6 +181,7 @@ i2c_som_rtc: rtc@52 {
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index d84e7ee160328..b4a1f73d4fb17 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -520,6 +520,7 @@ &tscadc0 {
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 963d796a3a970..af06ccd466802 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -518,6 +518,7 @@ &tscadc0 {
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-- 
2.39.2

