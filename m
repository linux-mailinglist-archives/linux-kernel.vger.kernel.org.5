Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3F7E1D75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjKFJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:51:42 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D09BDB;
        Mon,  6 Nov 2023 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1699264298; x=1730800298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gjF0M2PpCgYk+/ZTgC61t7QmzFXN08axmI0slI2iSbQ=;
  b=g51Jn2ilBU3yN4iPZ/b0FSeeW5cjRBsk6NlDxCVJNqTkiDGZ6F/0224A
   trB8UUUz4r0BcqOgSy7yRLlYp/AgZRarfQ2JsXXrzLW9mFT76q7cNXATR
   Xq1L/tlxY5GRsx5w5VfE0OsjtfcR59dLapGAFovIcSUib/juKwG/+dCRB
   N76A+eqSLVz6A/3+Cl94G17uWfCES8nBubw3BF+lERZ10WYTwnBgCcXdB
   cM5Q9/NS10pFnOcpKFa665Z7qCaj0366dtIjGx57W+TFoONgUl5u884nR
   L7HhY4xm4WCBLevloY1e8Db+erOzo4pkuiCe0qV2WzT+kSxRfzJAAnm0e
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,281,1694728800"; 
   d="scan'208";a="33823082"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Nov 2023 10:51:35 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 1C8DB28007F;
        Mon,  6 Nov 2023 10:51:35 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     Faiz Abbas <faiz_abbas@ti.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 5.4] Revert "ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver"
Date:   Mon,  6 Nov 2023 10:50:48 +0100
Message-ID: <20231106095048.8396-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d0c69c722ff16ce2481a5e0932c6d5b172109f21.

The reverted commit completely breaks MMC on the AM33xx/AM437x for
multiple reasons:

- The changed compatible strings ti,am335-sdhci and ti,am437-sdhci
  aren't supported on Linux 5.4 at all, so no driver is found
- Even when additionally backporting the support for these compatible
  strings in the sdhci-omap driver, I could not the the MMC interfaces
  to work on our TQMa335x SoM - the interface would time out during card
  initialization for both an eMMC and an SD card.

I did not investigate the cause of the timeouts further, and instead
just reverted the commit - switching to a different MMC driver in a stable
kernel seems like a rather risky change unless it's thoroughly tested,
which has obviously not happened in this case.

The reverted commit is also given as a Stable-dep-of commit 2eb502f496f7
("ARM: dts: am33xx: Fix MMCHS0 dma properties"), however the conflict
resulting when only the one commit is reverted is trivial to resolve,
which leads to working MMC controllers again.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

I have not checked if other stable kernels exhibit the same breakage; it
might be a good idea to revert the change for all stable branches unless
it is proven that the sdhci-omap driver actually works.


 arch/arm/boot/dts/am335x-baltos.dtsi              | 2 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi    | 1 -
 arch/arm/boot/dts/am335x-boneblack-wireless.dts   | 1 +
 arch/arm/boot/dts/am335x-boneblue.dts             | 1 +
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts   | 1 +
 arch/arm/boot/dts/am335x-evm.dts                  | 3 ++-
 arch/arm/boot/dts/am335x-evmsk.dts                | 2 +-
 arch/arm/boot/dts/am335x-lxm.dts                  | 2 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    | 2 +-
 arch/arm/boot/dts/am335x-pepper.dts               | 4 ++--
 arch/arm/boot/dts/am335x-phycore-som.dtsi         | 2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                  | 6 ++++--
 arch/arm/boot/dts/am33xx.dtsi                     | 3 +--
 arch/arm/boot/dts/am4372.dtsi                     | 3 +--
 arch/arm/boot/dts/am437x-cm-t43.dts               | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               | 4 ++--
 arch/arm/boot/dts/am437x-l4.dtsi                  | 5 +++--
 arch/arm/boot/dts/am437x-sk-evm.dts               | 2 +-
 19 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index ee84155844adb..ed235f263e293 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -381,7 +381,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
+	ti,non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
index dd932220a8bf7..91f93bc89716d 100644
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -22,7 +22,6 @@
 	pinctrl-0 = <&emmc_pins>;
 	bus-width = <8>;
 	status = "okay";
-	non-removable;
 };
 
 &am33xx_pinmux {
diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index e07dd79795868..3124d94c0b3cc 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -75,6 +75,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 30b62de86b5b1..2f6652ef9a157 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -389,6 +389,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 609c8db687ec6..4092cd193b8a6 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -75,6 +75,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index af25b42e85f4d..a00145705c9be 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -782,7 +782,8 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wlan_pins>;
-	non-removable;
+	ti,non-removable;
+	ti,needs-special-hs-handling;
 	cap-power-off-card;
 	keep-power-in-suspend;
 
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 7805b0618a4fb..e28a5b82fdf30 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -700,7 +700,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
+	ti,non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
 	keep-power-in-suspend;
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index c3bfd8ed5f884..a8005e975ea24 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -361,7 +361,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 7749122dad71d..671d4a5da9c43 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -176,7 +176,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	pinctrl-0 = <&mmc1_pins_default>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index 66a5c09ff388a..783d411f2cefe 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -473,7 +473,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	pinctrl-0 = <&mmc2_pins_default>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 03852eff2b3ce..e7764ecdf65f8 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -341,7 +341,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&ldo3_reg>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -351,7 +351,7 @@
 	pinctrl-0 = <&wireless_pins>;
 	vmmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
-	non-removable;
+	ti,non-removable;
 	dmas = <&edma_xbar 12 0 1
 		&edma_xbar 13 0 2>;
 	dma-names = "tx", "rx";
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 7e46b4c027094..3d0672b53d779 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -69,7 +69,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmc_reg>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index cacd564b4d28b..8ec6c4500fd59 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1333,8 +1333,10 @@
 			ranges = <0x0 0x60000 0x1000>;
 
 			mmc1: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
+				ti,dual-volt;
 				ti,needs-special-reset;
+				ti,needs-special-hs-handling;
 				dmas = <&edma 24 0>, <&edma 25 0>;
 				dma-names = "tx", "rx";
 				interrupts = <64>;
@@ -1824,7 +1826,7 @@
 			ranges = <0x0 0xd8000 0x1000>;
 
 			mmc2: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				dmas = <&edma 2 0
 					&edma 3 0>;
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index efe36f395bdd0..77fa7c0f21046 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -259,11 +259,10 @@
 			ranges = <0x0 0x47810000 0x1000>;
 
 			mmc3: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				interrupts = <29>;
 				reg = <0x0 0x1000>;
-				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index c5b67993743d6..14bbc438055fd 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -250,11 +250,10 @@
 			ranges = <0x0 0x47810000 0x1000>;
 
 			mmc3: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x0 0x1000>;
-				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index a6b4fca8626ac..063113a5da2d4 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -291,7 +291,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmc_3v3>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &spi0 {
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 448853701d3d1..126965a34841e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -872,7 +872,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&emmc_pins_default>;
 	pinctrl-1 = <&emmc_pins_sleep>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -889,7 +889,7 @@
 	pinctrl-1 = <&mmc3_pins_sleep>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	non-removable;
+	ti,non-removable;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index 8c9e7e723fc97..64fdd5079d49b 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -1104,8 +1104,9 @@
 			ranges = <0x0 0x60000 0x1000>;
 
 			mmc1: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				reg = <0x0 0x1000>;
+				ti,dual-volt;
 				ti,needs-special-reset;
 				dmas = <&edma 24 0>,
 					<&edma 25 0>;
@@ -1640,7 +1641,7 @@
 			ranges = <0x0 0xd8000 0x1000>;
 
 			mmc2: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				reg = <0x0 0x1000>;
 				ti,needs-special-reset;
 				dmas = <&edma 2 0>,
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 292153c6cb5d3..74eaa6a3b258c 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -694,7 +694,7 @@
 	pinctrl-1 = <&mmc3_pins_sleep>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	non-removable;
+	ti,non-removable;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

