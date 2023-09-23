Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D903E7ABEBA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjIWIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjIWIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:01:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB0A198
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:01:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A41C433C9;
        Sat, 23 Sep 2023 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695456096;
        bh=RKLIpEQ5S2mFP6kp/v4L5r5HBMSsXtLcED1ZmKHGQwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unKuQq9CnqHnjVy+rDYxhSiuihYrSn88kTPp2wVobfwuEEuJ3q7CNOkmLjj0Z+lcN
         u/vTgOYyUjrZrPQMTd3z2lElY4N4U7wq43oMGVMFBtLOe8Bm5RD1j64uqabUyB5EbZ
         WNFHwepluHs0bq+Qy7K0TyfaYn3NtPrEXt1sNDBuBxphVm0f1OWLnu5Xi3tny8dsOv
         +0Oww9KxUOgwEoKaiMbH4ewhk12c/fuNe9RX+I897k3Ymk52xGCEMZ/E5dcalg1Toe
         2qdmkdVH9u1Lf/QbYp9ptlAvngCJ++1a++qQxvLD+l+XiSrnlWjnmxroDmck9xZWMC
         tMJhS80xA8rDA==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, afd@ti.com, robh+dt@kernel.org
Cc:     vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: ti: am642-evm: Add overlay for NAND expansion card
Date:   Sat, 23 Sep 2023 11:00:45 +0300
Message-Id: <20230923080046.5373-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923080046.5373-1-rogerq@kernel.org>
References: <20230923080046.5373-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NAND expansion card plugs in over the HSE (High Speed Expansion)
connector. Add support for it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/Makefile               |   3 +-
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++++++++++
 2 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e7b8e2e7f083..ad5f688df430 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -28,7 +28,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 
 # Boards with AM64x SoC
-dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
+k3-am642-evm-nand-dtbs := k3-am642-evm.dtb k3-am642-evm-nand.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
new file mode 100644
index 000000000000..12593836eaab
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DT overlay for HSE NAND expansion card on AM642 EVM
+ *
+ * Copyright (C) 2021-2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "k3-pinctrl.h"
+
+&main_pmx0 {
+	gpmc0_pins_default: gpmc0-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
+
+			AM64X_IOPAD(0x003c, PIN_INPUT, 0) /* (T20) GPMC0_AD0 */
+			AM64X_IOPAD(0x0040, PIN_INPUT, 0) /* (U21) GPMC0_AD1 */
+			AM64X_IOPAD(0x0064, PIN_INPUT, 0) /* (R16) GPMC0_AD10 */
+			AM64X_IOPAD(0x0068, PIN_INPUT, 0) /* (W20) GPMC0_AD11 */
+			AM64X_IOPAD(0x006c, PIN_INPUT, 0) /* (W21) GPMC0_AD12 */
+			AM64X_IOPAD(0x0070, PIN_INPUT, 0) /* (V18) GPMC0_AD13 */
+			AM64X_IOPAD(0x0074, PIN_INPUT, 0) /* (Y21) GPMC0_AD14 */
+			AM64X_IOPAD(0x0078, PIN_INPUT, 0) /* (Y20) GPMC0_AD15 */
+			AM64X_IOPAD(0x0044, PIN_INPUT, 0) /* (T18) GPMC0_AD2 */
+			AM64X_IOPAD(0x0048, PIN_INPUT, 0) /* (U20) GPMC0_AD3 */
+			AM64X_IOPAD(0x004c, PIN_INPUT, 0) /* (U18) GPMC0_AD4 */
+			AM64X_IOPAD(0x0050, PIN_INPUT, 0) /* (U19) GPMC0_AD5 */
+			AM64X_IOPAD(0x0054, PIN_INPUT, 0) /* (V20) GPMC0_AD6 */
+			AM64X_IOPAD(0x0058, PIN_INPUT, 0) /* (V21) GPMC0_AD7 */
+			AM64X_IOPAD(0x005c, PIN_INPUT, 0) /* (V19) GPMC0_AD8 */
+			AM64X_IOPAD(0x0060, PIN_INPUT, 0) /* (T17) GPMC0_AD9 */
+			AM64X_IOPAD(0x0098, PIN_INPUT_PULLUP, 0) /* (W19) GPMC0_WAIT0 */
+			AM64X_IOPAD(0x009c, PIN_INPUT_PULLUP, 0) /* (Y18) GPMC0_WAIT1 */
+			AM64X_IOPAD(0x00a8, PIN_OUTPUT_PULLUP, 0) /* (R19) GPMC0_CSn0 */
+			AM64X_IOPAD(0x00ac, PIN_OUTPUT_PULLUP, 0) /* (R20) GPMC0_CSn1 */
+			AM64X_IOPAD(0x00b0, PIN_OUTPUT_PULLUP, 0) /* (P19) GPMC0_CSn2 */
+			AM64X_IOPAD(0x00b4, PIN_OUTPUT_PULLUP, 0) /* (R21) GPMC0_CSn3 */
+			AM64X_IOPAD(0x007c, PIN_OUTPUT, 0) /* (R17) GPMC0_CLK */
+			AM64X_IOPAD(0x0084, PIN_OUTPUT, 0) /* (P16) GPMC0_ADVn_ALE */
+			AM64X_IOPAD(0x0088, PIN_OUTPUT, 0) /* (R18) GPMC0_OEn_REn */
+			AM64X_IOPAD(0x008c, PIN_OUTPUT, 0) /* (T21) GPMC0_WEn */
+			AM64X_IOPAD(0x0090, PIN_OUTPUT, 0) /* (P17) GPMC0_BE0n_CLE */
+			AM64X_IOPAD(0x00a0, PIN_OUTPUT_PULLUP, 0) /* (N16) GPMC0_WPn */
+			AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
+		>;
+	};
+};
+
+&main_gpio0 {
+	gpio0-36 {
+		gpio-hog;
+		gpios = <36 0>;
+		input;
+		line-name = "GPMC0_MUX_DIR";
+	};
+};
+
+&elm0 {
+	status = "okay";
+};
+
+&gpmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpmc0_pins_default>;
+	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	nand@0,0 {
+		compatible = "ti,am64-nand";
+		reg = <0 0 64>;		/* device IO registers */
+		interrupt-parent = <&gpmc0>;
+		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
+			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc0 0 GPIO_ACTIVE_HIGH>;	/* gpmc_wait0 */
+		ti,nand-xfer-type = "prefetch-polled";
+		ti,nand-ecc-opt = "bch8";	/* BCH8: Bootrom limitation */
+		ti,elm-id = <&elm0>;
+		nand-bus-width = <8>;
+		gpmc,device-width = <1>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-on-ns = <0>;
+		gpmc,adv-rd-off-ns = <25>;
+		gpmc,adv-wr-off-ns = <25>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <20>;
+		gpmc,oe-on-ns = <3>;
+		gpmc,oe-off-ns = <30>;
+		gpmc,access-ns = <30>;
+		gpmc,rd-cycle-ns = <40>;
+		gpmc,wr-cycle-ns = <40>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "NAND.tiboot3";
+				reg = <0x00000000 0x00200000>;	/* 2M */
+			};
+			partition@200000 {
+				label = "NAND.tispl";
+				reg = <0x00200000 0x00200000>;	/* 2M */
+			};
+			partition@400000 {
+				label = "NAND.tiboot3.backup";	/* 2M */
+				reg = <0x00400000 0x00200000>;	/* BootROM looks at 4M */
+			};
+			partition@600000 {
+				label = "NAND.u-boot";
+				reg = <0x00600000 0x00400000>;	/* 4M */
+			};
+			partition@a00000 {
+				label = "NAND.u-boot-env";
+				reg = <0x00a00000 0x00040000>;	/* 256K */
+			};
+			partition@a40000 {
+				label = "NAND.u-boot-env.backup";
+				reg = <0x00a40000 0x00040000>;	/* 256K */
+			};
+			partition@a80000 {
+				label = "NAND.file-system";
+				reg = <0x00a80000 0x3f580000>;
+			};
+		};
+	};
+};
-- 
2.34.1

