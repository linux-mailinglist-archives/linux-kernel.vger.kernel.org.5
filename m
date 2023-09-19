Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2306C7A602C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjISKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjISKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:52:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038A135;
        Tue, 19 Sep 2023 03:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD51FC433C7;
        Tue, 19 Sep 2023 10:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695120685;
        bh=HKOUKMtJNLDDDWle+m1Pdn7hDSIuT76ciRPwpoCEtQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUw5F2ol4NzKDyVKAnwhptrEZDpsVW6k+MnYH8NrWMYVyTcFIhj5OGkso66IzHlZL
         C9Hp1hknneb/Q8ccXXVE5GXuJl7fkGYj8l4YkX6/Nu4rN0l75tW/onNCS7P3gBgbma
         thtrX4CIRdAuKomXLXDiUFjtXTNfdN7dgN6tNu40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.195
Date:   Tue, 19 Sep 2023 12:51:14 +0200
Message-ID: <2023091914-corral-boxy-de85@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023091913-uncharted-fondly-97b8@gregkh>
References: <2023091913-uncharted-fondly-97b8@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
index 229af98b1d30..7cd88bc3a67d 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
@@ -16,8 +16,6 @@ description: |
   reads required input clock frequencies from the devicetree and acts as clock
   provider for all clock consumers of PS clocks.
 
-select: false
-
 properties:
   compatible:
     const: xlnx,versal-clk
diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 5bc17d012b25..d65c902b69ea 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -1195,11 +1195,11 @@ Members of interest:
 		 - pointer to scsi_device object that this command is
                    associated with.
     resid
-		 - an LLD should set this signed integer to the requested
+		 - an LLD should set this unsigned integer to the requested
                    transfer length (i.e. 'request_bufflen') less the number
                    of bytes that are actually transferred. 'resid' is
                    preset to 0 so an LLD can ignore it if it cannot detect
-                   underruns (overruns should be rare). If possible an LLD
+                   underruns (overruns should not be reported). An LLD
                    should set 'resid' prior to invoking 'done'. The most
                    interesting case is data transfers from a SCSI target
                    device (e.g. READs) that underrun.
diff --git a/Makefile b/Makefile
index 9ec2fb0d08f0..006700fbb652 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 194
+SUBLEVEL = 195
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
index cd797b4202ad..01c48faabfad 100644
--- a/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
@@ -19,7 +19,8 @@ chosen {
 
 	memory@0 {
 		device_type = "memory";
-		reg = <0x00000000 0x08000000>;
+		reg = <0x00000000 0x08000000>,
+		      <0x88000000 0x08000000>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 57ca1cfaecd8..00e688b45d98 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -46,3 +46,16 @@ restart {
 		};
 	};
 };
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&bcm54210e>;
+
+	mdio {
+		/delete-node/ switch@1e;
+
+		bcm54210e: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 2e1a7e382cb7..78c80a5d3f4f 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -83,3 +83,16 @@ pcie0_chipcommon: chipcommon@0 {
 		};
 	};
 };
+
+&gmac0 {
+	phy-mode = "rgmii";
+	phy-handle = <&bcm54210e>;
+
+	mdio {
+		/delete-node/ switch@1e;
+
+		bcm54210e: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4e9bb10f37d0..9189a9489464 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -267,7 +267,7 @@ usb2: usb2@21000 {
 
 			interrupt-parent = <&gic>;
 
-			ehci: ehci@21000 {
+			ehci: usb@21000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ehci";
@@ -289,7 +289,7 @@ ehci_port2: port@2 {
 				};
 			};
 
-			ohci: ohci@22000 {
+			ohci: usb@22000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ohci";
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 4af8e3293cff..eed1a6147f0b 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -127,6 +127,9 @@ uart0: serial@300 {
 
 		pcie0: pcie@2000 {
 			reg = <0x00002000 0x1000>;
+
+			#address-cells = <3>;
+			#size-cells = <2>;
 		};
 
 		usb2: usb2@4000 {
@@ -135,7 +138,7 @@ usb2: usb2@4000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ehci: ehci@4000 {
+			ehci: usb@4000 {
 				compatible = "generic-ehci";
 				reg = <0x4000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -155,9 +158,7 @@ ehci_port2: port@2 {
 				};
 			};
 
-			ohci: ohci@d000 {
-				#usb-cells = <0>;
-
+			ohci: usb@d000 {
 				compatible = "generic-ohci";
 				reg = <0xd000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -180,6 +181,24 @@ ohci_port2: port@2 {
 
 		gmac0: ethernet@5000 {
 			reg = <0x5000 0x1000>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				switch: switch@1e {
+					compatible = "brcm,bcm53125";
+					reg = <0x1e>;
+
+					status = "disabled";
+
+					/* ports are defined in board DTS */
+					ports {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+			};
 		};
 
 		gmac1: ethernet@b000 {
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index b0b8c774a37f..1f0be30e5443 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -60,9 +60,9 @@ wps {
 	spi {
 		compatible = "spi-gpio";
 		num-chipselects = <1>;
-		gpio-sck = <&chipcommon 21 0>;
-		gpio-miso = <&chipcommon 22 0>;
-		gpio-mosi = <&chipcommon 23 0>;
+		sck-gpios = <&chipcommon 21 0>;
+		miso-gpios = <&chipcommon 22 0>;
+		mosi-gpios = <&chipcommon 23 0>;
 		cs-gpios = <&chipcommon 24 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index ecc9d4dc707e..d186b93144e3 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -170,8 +170,8 @@ lcd@0 {
 			power-on-delay = <10>;
 			reset-delay = <10>;
 
-			panel-width-mm = <90>;
-			panel-height-mm = <154>;
+			panel-width-mm = <56>;
+			panel-height-mm = <93>;
 
 			display-timings {
 				timing {
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 7f4c602454a5..ce3d6360a7ef 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -59,7 +59,7 @@ icoll: interrupt-controller@80000000 {
 				reg = <0x80000000 0x2000>;
 			};
 
-			dma_apbh: dma-apbh@80004000 {
+			dma_apbh: dma-controller@80004000 {
 				compatible = "fsl,imx23-dma-apbh";
 				reg = <0x80004000 0x2000>;
 				interrupts = <0 14 20 0
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 1ab19f1268f8..d24b1da18766 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -515,7 +515,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx25-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 112>, <&clks 68>;
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 94dfbf5b3f34..6cab8b66db80 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -78,7 +78,7 @@ hsadc: hsadc@80002000 {
 				status = "disabled";
 			};
 
-			dma_apbh: dma-apbh@80004000 {
+			dma_apbh: dma-controller@80004000 {
 				compatible = "fsl,imx28-dma-apbh";
 				reg = <0x80004000 0x2000>;
 				interrupts = <82 83 84 85
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index 45333f7e10ea..0ee7e5547bea 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -297,7 +297,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx31-sdma";
 				reg = <0x53fd4000 0x4000>;
 				interrupts = <34>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index aba16252faab..e7c4803ef866 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -284,7 +284,7 @@ gpio2: gpio@53fd0000 {
 				#interrupt-cells = <2>;
 			};
 
-			sdma: sdma@53fd4000 {
+			sdma: dma-controller@53fd4000 {
 				compatible = "fsl,imx35-sdma";
 				reg = <0x53fd4000 0x4000>;
 				clocks = <&clks 9>, <&clks 65>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index b6b2e6af9b96..ae51333c30b3 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -421,7 +421,7 @@ ecspi2: spi@63fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@63fb0000 {
+			sdma: dma-controller@63fb0000 {
 				compatible = "fsl,imx50-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 985e1be03ad6..d80063560a65 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -498,7 +498,7 @@ ecspi2: spi@83fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@83fb0000 {
+			sdma: dma-controller@83fb0000 {
 				compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
 				reg = <0x83fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 500eeaa3a27c..f4e7f437ea50 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -710,7 +710,7 @@ ecspi2: spi@63fac000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@63fb0000 {
+			sdma: dma-controller@63fb0000 {
 				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 7d81992dfafc..e67d8dffba35 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -150,7 +150,7 @@ soc {
 		interrupt-parent = <&gpc>;
 		ranges;
 
-		dma_apbh: dma-apbh@110000 {
+		dma_apbh: dma-controller@110000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x00110000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
@@ -927,7 +927,7 @@ dcic2: dcic@20e8000 {
 				interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 5b4dfc62030e..0e0139246ad2 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -752,7 +752,7 @@ spdc: spdc@20e8000 {
 				interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6sl-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 629c6a7432d9..08332f70a8dc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -209,7 +209,7 @@ gpu: gpu@1800000 {
 			power-domains = <&pd_pu>;
 		};
 
-		dma_apbh: dma-apbh@1804000 {
+		dma_apbh: dma-controller@1804000 {
 			compatible = "fsl,imx6sx-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
@@ -848,7 +848,7 @@ gpr: iomuxc-gpr@20e4000 {
 				reg = <0x020e4000 0x4000>;
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6sx-sdma", "fsl,imx6q-sdma";
 				reg = <0x020ec000 0x4000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index b40dd0c19802..c374fe2a6f19 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -164,7 +164,7 @@ intc: interrupt-controller@a01000 {
 			      <0x00a06000 0x2000>;
 		};
 
-		dma_apbh: dma-apbh@1804000 {
+		dma_apbh: dma-controller@1804000 {
 			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x01804000 0x2000>;
 			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>,
@@ -743,7 +743,7 @@ gpt2: timer@20e8000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
 					     "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 334e781663cc..854c380cccea 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1137,6 +1137,8 @@ usdhc1: mmc@30b40000 {
 					<&clks IMX7D_USDHC1_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1149,6 +1151,8 @@ usdhc2: mmc@30b50000 {
 					<&clks IMX7D_USDHC2_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1161,6 +1165,8 @@ usdhc3: mmc@30b60000 {
 					<&clks IMX7D_USDHC3_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1177,7 +1183,7 @@ qspi: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@30bd0000 {
+			sdma: dma-controller@30bd0000 {
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -1210,14 +1216,13 @@ fec1: ethernet@30be0000 {
 			};
 		};
 
-		dma_apbh: dma-apbh@33000000 {
+		dma_apbh: dma-controller@33000000 {
 			compatible = "fsl,imx7d-dma-apbh", "fsl,imx28-dma-apbh";
 			reg = <0x33000000 0x2000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			clocks = <&clks IMX7D_NAND_USDHC_BUS_RAWNAND_CLK>;
diff --git a/arch/arm/boot/dts/s3c6410-mini6410.dts b/arch/arm/boot/dts/s3c6410-mini6410.dts
index 285555b9ed94..0b07b3c31960 100644
--- a/arch/arm/boot/dts/s3c6410-mini6410.dts
+++ b/arch/arm/boot/dts/s3c6410-mini6410.dts
@@ -51,7 +51,7 @@ srom-cs1-bus@18000000 {
 
 		ethernet@18000000 {
 			compatible = "davicom,dm9000";
-			reg = <0x18000000 0x2 0x18000004 0x2>;
+			reg = <0x18000000 0x2>, <0x18000004 0x2>;
 			interrupt-parent = <&gpn>;
 			interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
 			davicom,no-eeprom;
@@ -193,12 +193,12 @@ &uart3 {
 };
 
 &pinctrl0 {
-	gpio_leds: gpio-leds {
+	gpio_leds: gpio-leds-pins {
 		samsung,pins = "gpk-4", "gpk-5", "gpk-6", "gpk-7";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	gpio_keys: gpio-keys {
+	gpio_keys: gpio-keys-pins {
 		samsung,pins = "gpn-0", "gpn-1", "gpn-2", "gpn-3",
 				"gpn-4", "gpn-5", "gpl-11", "gpl-12";
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
diff --git a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
index 8e9594d64b57..0a3186d57cb5 100644
--- a/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
@@ -16,111 +16,111 @@ &pinctrl0 {
 	 * Pin banks
 	 */
 
-	gpa: gpa {
+	gpa: gpa-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpb: gpb {
+	gpb: gpb-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpc: gpc {
+	gpc: gpc-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpd: gpd {
+	gpd: gpd-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpe: gpe {
+	gpe: gpe-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpf: gpf {
+	gpf: gpf-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpg: gpg {
+	gpg: gpg-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gph: gph {
+	gph: gph-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpi: gpi {
+	gpi: gpi-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpj: gpj {
+	gpj: gpj-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpk: gpk {
+	gpk: gpk-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
 
-	gpl: gpl {
+	gpl: gpl-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpm: gpm {
+	gpm: gpm-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpn: gpn {
+	gpn: gpn-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpo: gpo {
+	gpo: gpo-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpp: gpp {
+	gpp: gpp-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
-	gpq: gpq {
+	gpq: gpq-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -131,225 +131,225 @@ gpq: gpq {
 	 * Pin groups
 	 */
 
-	uart0_data: uart0-data {
+	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa-0", "gpa-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart0_fctl: uart0-fctl {
+	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa-2", "gpa-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart1_data: uart1-data {
+	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa-4", "gpa-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart1_fctl: uart1-fctl {
+	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa-6", "gpa-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart2_data: uart2-data {
+	uart2_data: uart2-data-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	uart3_data: uart3-data {
+	uart3_data: uart3-data-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ext_dma_0: ext-dma-0 {
+	ext_dma_0: ext-dma-0-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ext_dma_1: ext-dma-1 {
+	ext_dma_1: ext-dma-1-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_data_0: irda-data-0 {
+	irda_data_0: irda-data-0-pins {
 		samsung,pins = "gpb-0", "gpb-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_data_1: irda-data-1 {
+	irda_data_1: irda-data-1-pins {
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	irda_sdbw: irda-sdbw {
+	irda_sdbw: irda-sdbw-pins {
 		samsung,pins = "gpb-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2c0_bus: i2c0-bus {
+	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpb-5", "gpb-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	i2c1_bus: i2c1-bus {
+	i2c1_bus: i2c1-bus-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpb-2", "gpb-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_6>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi0_bus: spi0-bus {
+	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpc-0", "gpc-1", "gpc-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi0_cs: spi0-cs {
+	spi0_cs: spi0-cs-pins {
 		samsung,pins = "gpc-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	spi1_bus: spi1-bus {
+	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpc-4", "gpc-5", "gpc-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	spi1_cs: spi1-cs {
+	spi1_cs: spi1-cs-pins {
 		samsung,pins = "gpc-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_cmd: sd0-cmd {
+	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpg-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_clk: sd0-clk {
+	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpg-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_bus1: sd0-bus1 {
+	sd0_bus1: sd0-bus1-pins {
 		samsung,pins = "gpg-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_bus4: sd0-bus4 {
+	sd0_bus4: sd0-bus4-pins {
 		samsung,pins = "gpg-2", "gpg-3", "gpg-4", "gpg-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd0_cd: sd0-cd {
+	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpg-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	sd1_cmd: sd1-cmd {
+	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_clk: sd1-clk {
+	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gph-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus1: sd1-bus1 {
+	sd1_bus1: sd1-bus1-pins {
 		samsung,pins = "gph-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus4: sd1-bus4 {
+	sd1_bus4: sd1-bus4-pins {
 		samsung,pins = "gph-2", "gph-3", "gph-4", "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_bus8: sd1-bus8 {
+	sd1_bus8: sd1-bus8-pins {
 		samsung,pins = "gph-2", "gph-3", "gph-4", "gph-5",
 				"gph-6", "gph-7", "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd1_cd: sd1-cd {
+	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpg-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
 	};
 
-	sd2_cmd: sd2-cmd {
+	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpc-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_clk: sd2-clk {
+	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpc-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_bus1: sd2-bus1 {
+	sd2_bus1: sd2-bus1-pins {
 		samsung,pins = "gph-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	sd2_bus4: sd2-bus4 {
+	sd2_bus4: sd2-bus4-pins {
 		samsung,pins = "gph-6", "gph-7", "gph-8", "gph-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s0_bus: i2s0-bus {
+	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpd-0", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s0_cdclk: i2s0-cdclk {
+	i2s0_cdclk: i2s0-cdclk-pins {
 		samsung,pins = "gpd-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s1_bus: i2s1-bus {
+	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpe-0", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s1_cdclk: i2s1-cdclk {
+	i2s1_cdclk: i2s1-cdclk-pins {
 		samsung,pins = "gpe-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s2_bus: i2s2-bus {
+	i2s2_bus: i2s2-bus-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpc-4", "gpc-5", "gpc-6", "gph-6",
 				"gph-8", "gph-9";
@@ -357,50 +357,50 @@ i2s2_bus: i2s2-bus {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	i2s2_cdclk: i2s2-cdclk {
+	i2s2_cdclk: i2s2-cdclk-pins {
 		/* S3C6410-only */
 		samsung,pins = "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm0_bus: pcm0-bus {
+	pcm0_bus: pcm0-bus-pins {
 		samsung,pins = "gpd-0", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm0_extclk: pcm0-extclk {
+	pcm0_extclk: pcm0-extclk-pins {
 		samsung,pins = "gpd-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm1_bus: pcm1-bus {
+	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpe-0", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pcm1_extclk: pcm1-extclk {
+	pcm1_extclk: pcm1-extclk-pins {
 		samsung,pins = "gpe-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ac97_bus_0: ac97-bus-0 {
+	ac97_bus_0: ac97-bus-0-pins {
 		samsung,pins = "gpd-0", "gpd-1", "gpd-2", "gpd-3", "gpd-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	ac97_bus_1: ac97-bus-1 {
+	ac97_bus_1: ac97-bus-1-pins {
 		samsung,pins = "gpe-0", "gpe-1", "gpe-2", "gpe-3", "gpe-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_port: cam-port {
+	cam_port: cam-port-pins {
 		samsung,pins = "gpf-0", "gpf-1", "gpf-2", "gpf-4",
 				"gpf-5", "gpf-6", "gpf-7", "gpf-8",
 				"gpf-9", "gpf-10", "gpf-11", "gpf-12";
@@ -408,242 +408,242 @@ cam_port: cam-port {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_rst: cam-rst {
+	cam_rst: cam-rst-pins {
 		samsung,pins = "gpf-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	cam_field: cam-field {
+	cam_field: cam-field-pins {
 		/* S3C6410-only */
 		samsung,pins = "gpb-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm_extclk: pwm-extclk {
+	pwm_extclk: pwm-extclk-pins {
 		samsung,pins = "gpf-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm0_out: pwm0-out {
+	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpf-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	pwm1_out: pwm1-out {
+	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpf-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	clkout0: clkout-0 {
+	clkout0: clkout-0-pins {
 		samsung,pins = "gpf-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col0_0: keypad-col0-0 {
+	keypad_col0_0: keypad-col0-0-pins {
 		samsung,pins = "gph-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col1_0: keypad-col1-0 {
+	keypad_col1_0: keypad-col1-0-pins {
 		samsung,pins = "gph-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col2_0: keypad-col2-0 {
+	keypad_col2_0: keypad-col2-0-pins {
 		samsung,pins = "gph-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col3_0: keypad-col3-0 {
+	keypad_col3_0: keypad-col3-0-pins {
 		samsung,pins = "gph-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col4_0: keypad-col4-0 {
+	keypad_col4_0: keypad-col4-0-pins {
 		samsung,pins = "gph-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col5_0: keypad-col5-0 {
+	keypad_col5_0: keypad-col5-0-pins {
 		samsung,pins = "gph-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col6_0: keypad-col6-0 {
+	keypad_col6_0: keypad-col6-0-pins {
 		samsung,pins = "gph-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col7_0: keypad-col7-0 {
+	keypad_col7_0: keypad-col7-0-pins {
 		samsung,pins = "gph-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col0_1: keypad-col0-1 {
+	keypad_col0_1: keypad-col0-1-pins {
 		samsung,pins = "gpl-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col1_1: keypad-col1-1 {
+	keypad_col1_1: keypad-col1-1-pins {
 		samsung,pins = "gpl-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col2_1: keypad-col2-1 {
+	keypad_col2_1: keypad-col2-1-pins {
 		samsung,pins = "gpl-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col3_1: keypad-col3-1 {
+	keypad_col3_1: keypad-col3-1-pins {
 		samsung,pins = "gpl-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col4_1: keypad-col4-1 {
+	keypad_col4_1: keypad-col4-1-pins {
 		samsung,pins = "gpl-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col5_1: keypad-col5-1 {
+	keypad_col5_1: keypad-col5-1-pins {
 		samsung,pins = "gpl-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col6_1: keypad-col6-1 {
+	keypad_col6_1: keypad-col6-1-pins {
 		samsung,pins = "gpl-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_col7_1: keypad-col7-1 {
+	keypad_col7_1: keypad-col7-1-pins {
 		samsung,pins = "gpl-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row0_0: keypad-row0-0 {
+	keypad_row0_0: keypad-row0-0-pins {
 		samsung,pins = "gpk-8";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row1_0: keypad-row1-0 {
+	keypad_row1_0: keypad-row1-0-pins {
 		samsung,pins = "gpk-9";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row2_0: keypad-row2-0 {
+	keypad_row2_0: keypad-row2-0-pins {
 		samsung,pins = "gpk-10";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row3_0: keypad-row3-0 {
+	keypad_row3_0: keypad-row3-0-pins {
 		samsung,pins = "gpk-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row4_0: keypad-row4-0 {
+	keypad_row4_0: keypad-row4-0-pins {
 		samsung,pins = "gpk-12";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row5_0: keypad-row5-0 {
+	keypad_row5_0: keypad-row5-0-pins {
 		samsung,pins = "gpk-13";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row6_0: keypad-row6-0 {
+	keypad_row6_0: keypad-row6-0-pins {
 		samsung,pins = "gpk-14";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row7_0: keypad-row7-0 {
+	keypad_row7_0: keypad-row7-0-pins {
 		samsung,pins = "gpk-15";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row0_1: keypad-row0-1 {
+	keypad_row0_1: keypad-row0-1-pins {
 		samsung,pins = "gpn-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row1_1: keypad-row1-1 {
+	keypad_row1_1: keypad-row1-1-pins {
 		samsung,pins = "gpn-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row2_1: keypad-row2-1 {
+	keypad_row2_1: keypad-row2-1-pins {
 		samsung,pins = "gpn-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row3_1: keypad-row3-1 {
+	keypad_row3_1: keypad-row3-1-pins {
 		samsung,pins = "gpn-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row4_1: keypad-row4-1 {
+	keypad_row4_1: keypad-row4-1-pins {
 		samsung,pins = "gpn-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row5_1: keypad-row5-1 {
+	keypad_row5_1: keypad-row5-1-pins {
 		samsung,pins = "gpn-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row6_1: keypad-row6-1 {
+	keypad_row6_1: keypad-row6-1-pins {
 		samsung,pins = "gpn-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	keypad_row7_1: keypad-row7-1 {
+	keypad_row7_1: keypad-row7-1-pins {
 		samsung,pins = "gpn-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_ctrl: lcd-ctrl {
+	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpj-8", "gpj-9", "gpj-10", "gpj-11";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data16: lcd-data-width16 {
+	lcd_data16: lcd-data-width16-pins {
 		samsung,pins = "gpi-3", "gpi-4", "gpi-5", "gpi-6",
 				"gpi-7", "gpi-10", "gpi-11", "gpi-12",
 				"gpi-13", "gpi-14", "gpi-15", "gpj-3",
@@ -652,7 +652,7 @@ lcd_data16: lcd-data-width16 {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data18: lcd-data-width18 {
+	lcd_data18: lcd-data-width18-pins {
 		samsung,pins = "gpi-2", "gpi-3", "gpi-4", "gpi-5",
 				"gpi-6", "gpi-7", "gpi-10", "gpi-11",
 				"gpi-12", "gpi-13", "gpi-14", "gpi-15",
@@ -662,7 +662,7 @@ lcd_data18: lcd-data-width18 {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	lcd_data24: lcd-data-width24 {
+	lcd_data24: lcd-data-width24-pins {
 		samsung,pins = "gpi-0", "gpi-1", "gpi-2", "gpi-3",
 				"gpi-4", "gpi-5", "gpi-6", "gpi-7",
 				"gpi-8", "gpi-9", "gpi-10", "gpi-11",
@@ -673,7 +673,7 @@ lcd_data24: lcd-data-width24 {
 		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
 	};
 
-	hsi_bus: hsi-bus {
+	hsi_bus: hsi-bus-pins {
 		samsung,pins = "gpk-0", "gpk-1", "gpk-2", "gpk-3",
 				"gpk-4", "gpk-5", "gpk-6", "gpk-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 8e57e5a1f0c5..6423348034b6 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -277,37 +277,37 @@ &keypad {
 			<&keypad_col0>, <&keypad_col1>, <&keypad_col2>;
 	status = "okay";
 
-	key_1 {
+	key-1 {
 		keypad,row = <0>;
 		keypad,column = <1>;
 		linux,code = <KEY_CONNECT>;
 	};
 
-	key_2 {
+	key-2 {
 		keypad,row = <0>;
 		keypad,column = <2>;
 		linux,code = <KEY_BACK>;
 	};
 
-	key_3 {
+	key-3 {
 		keypad,row = <1>;
 		keypad,column = <1>;
 		linux,code = <KEY_CAMERA_FOCUS>;
 	};
 
-	key_4 {
+	key-4 {
 		keypad,row = <1>;
 		keypad,column = <2>;
 		linux,code = <KEY_VOLUMEUP>;
 	};
 
-	key_5 {
+	key-5 {
 		keypad,row = <2>;
 		keypad,column = <1>;
 		linux,code = <KEY_CAMERA>;
 	};
 
-	key_6 {
+	key-6 {
 		keypad,row = <2>;
 		keypad,column = <2>;
 		linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 984bc8dc5e4b..8f7dcd7af0bc 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -54,7 +54,7 @@ pmic_ap_clk: clock-0 {
 		clock-frequency = <32768>;
 	};
 
-	bt_codec: bt_sco {
+	bt_codec: bt-sco {
 		compatible = "linux,bt-sco";
 		#sound-dai-cells = <0>;
 	};
@@ -113,7 +113,7 @@ i2c_sound: i2c-gpio-0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&sound_i2c_pins>;
 
-		wm8994: wm8994@1a {
+		wm8994: audio-codec@1a {
 			compatible = "wlf,wm8994";
 			reg = <0x1a>;
 
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index ad8d5d2fa32d..5c1e12d39747 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -259,37 +259,37 @@ &keypad {
 			<&keypad_col0>, <&keypad_col1>, <&keypad_col2>;
 	status = "okay";
 
-	key_1 {
+	key-1 {
 		keypad,row = <0>;
 		keypad,column = <1>;
 		linux,code = <KEY_CONNECT>;
 	};
 
-	key_2 {
+	key-2 {
 		keypad,row = <0>;
 		keypad,column = <2>;
 		linux,code = <KEY_BACK>;
 	};
 
-	key_3 {
+	key-3 {
 		keypad,row = <1>;
 		keypad,column = <1>;
 		linux,code = <KEY_CAMERA_FOCUS>;
 	};
 
-	key_4 {
+	key-4 {
 		keypad,row = <1>;
 		keypad,column = <2>;
 		linux,code = <KEY_VOLUMEUP>;
 	};
 
-	key_5 {
+	key-5 {
 		keypad,row = <2>;
 		keypad,column = <1>;
 		linux,code = <KEY_CAMERA>;
 	};
 
-	key_6 {
+	key-6 {
 		keypad,row = <2>;
 		keypad,column = <2>;
 		linux,code = <KEY_VOLUMEDOWN>;
@@ -353,7 +353,7 @@ &i2c2 {
 	samsung,i2c-slave-addr = <0x10>;
 	status = "okay";
 
-	tsp@4a {
+	touchscreen@4a {
 		compatible = "atmel,maxtouch";
 		reg = <0x4a>;
 		interrupt-parent = <&gpj0>;
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index 7459e41e8ef1..901e7197b136 100644
--- a/arch/arm/boot/dts/s5pv210-smdkv210.dts
+++ b/arch/arm/boot/dts/s5pv210-smdkv210.dts
@@ -41,7 +41,7 @@ pmic_ap_clk: clock-0 {
 
 	ethernet@a8000000 {
 		compatible = "davicom,dm9000";
-		reg = <0xA8000000 0x2 0xA8000002 0x2>;
+		reg = <0xa8000000 0x2>, <0xa8000002 0x2>;
 		interrupt-parent = <&gph1>;
 		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 		local-mac-address = [00 00 de ad be ef];
@@ -55,6 +55,14 @@ backlight {
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_out>;
+		power-supply = <&dc5v_reg>;
+	};
+
+	dc5v_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "DC5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 	};
 };
 
@@ -76,61 +84,61 @@ &keypad {
 			<&keypad_col6>, <&keypad_col7>;
 	status = "okay";
 
-	key_1 {
+	key-1 {
 		keypad,row = <0>;
 		keypad,column = <3>;
 		linux,code = <KEY_1>;
 	};
 
-	key_2 {
+	key-2 {
 		keypad,row = <0>;
 		keypad,column = <4>;
 		linux,code = <KEY_2>;
 	};
 
-	key_3 {
+	key-3 {
 		keypad,row = <0>;
 		keypad,column = <5>;
 		linux,code = <KEY_3>;
 	};
 
-	key_4 {
+	key-4 {
 		keypad,row = <0>;
 		keypad,column = <6>;
 		linux,code = <KEY_4>;
 	};
 
-	key_5 {
+	key-5 {
 		keypad,row = <0
 		>;
 		keypad,column = <7>;
 		linux,code = <KEY_5>;
 	};
 
-	key_6 {
+	key-6 {
 		keypad,row = <1>;
 		keypad,column = <3>;
 		linux,code = <KEY_A>;
 	};
-	key_7 {
+	key-7 {
 		keypad,row = <1>;
 		keypad,column = <4>;
 		linux,code = <KEY_B>;
 	};
 
-	key_8 {
+	key-8 {
 		keypad,row = <1>;
 		keypad,column = <5>;
 		linux,code = <KEY_C>;
 	};
 
-	key_9 {
+	key-9 {
 		keypad,row = <1>;
 		keypad,column = <6>;
 		linux,code = <KEY_D>;
 	};
 
-	key_10 {
+	key-10 {
 		keypad,row = <1>;
 		keypad,column = <7>;
 		linux,code = <KEY_E>;
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1cbac76136d4..6a10d23d787e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -174,7 +174,7 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		break;
 	case PWRDM_STATE_PREV:
 		prev = pwrdm_read_prev_pwrst(pwrdm);
-		if (pwrdm->state != prev)
+		if (prev >= 0 && pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
 		if (prev == PWRDM_POWER_RET)
 			_update_logic_membank_counters(pwrdm);
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 83cfbb882a2d..7f6bd7f069e4 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -220,8 +220,6 @@ void sharpsl_battery_kick(void)
 {
 	schedule_delayed_work(&sharpsl_bat, msecs_to_jiffies(125));
 }
-EXPORT_SYMBOL(sharpsl_battery_kick);
-
 
 static void sharpsl_battery_thread(struct work_struct *private_)
 {
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 371008e9bb02..264de0bc97d6 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>	/* symbol_get ; symbol_put */
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio_keys.h>
@@ -514,17 +513,6 @@ static struct pxa2xx_spi_chip spitz_ads7846_chip = {
 	.gpio_cs		= SPITZ_GPIO_ADS7846_CS,
 };
 
-static void spitz_bl_kick_battery(void)
-{
-	void (*kick_batt)(void);
-
-	kick_batt = symbol_get(sharpsl_battery_kick);
-	if (kick_batt) {
-		kick_batt();
-		symbol_put(sharpsl_battery_kick);
-	}
-}
-
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
@@ -552,7 +540,7 @@ static struct corgi_lcd_platform_data spitz_lcdcon_info = {
 	.max_intensity		= 0x2f,
 	.default_intensity	= 0x1f,
 	.limit_mask		= 0x0b,
-	.kick_battery		= spitz_bl_kick_battery,
+	.kick_battery		= sharpsl_battery_kick,
 };
 
 static struct pxa2xx_spi_chip spitz_lcdcon_chip = {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 73f7490911c9..0bc5fefb7a49 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1966,6 +1966,9 @@ usb2: usb@76f8800 {
 			#size-cells = <1>;
 			ranges;
 
+			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
 			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
 				<&gcc GCC_USB20_MASTER_CLK>,
 				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 71e5b9fdc9e1..5c696ebf5c20 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1064,6 +1064,7 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>;
 		};
 
 		qfprom@784000 {
@@ -2108,7 +2109,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 300000000>;
+				<75000000 300000000>;
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 63e0b92a5fbb..5882c0e29331 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -17,6 +17,9 @@
 
 #include <asm/virt.h>
 
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 extern unsigned long sdei_exit_mode;
 
 /* Software Delegated Exception entry point from firmware*/
@@ -29,6 +32,9 @@ asmlinkage void __sdei_asm_entry_trampoline(unsigned long event_num,
 						   unsigned long pc,
 						   unsigned long pstate);
 
+/* Abort a running handler. Context is discarded. */
+void __sdei_handler_abort(void);
+
 /*
  * The above entry point does the minimum to call C code. This function does
  * anything else, before calling the driver.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 55e477f73158..a94acea770c7 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1137,9 +1137,13 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	mov	x19, x1
 
-#if defined(CONFIG_VMAP_STACK) || defined(CONFIG_SHADOW_CALL_STACK)
+	/* Store the registered-event for crash_smp_send_stop() */
 	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
-#endif
+	cbnz	w4, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	x19, [x5]
 
 #ifdef CONFIG_VMAP_STACK
 	/*
@@ -1204,6 +1208,14 @@ SYM_CODE_START(__sdei_asm_handler)
 
 	ldr_l	x2, sdei_exit_mode
 
+	/* Clear the registered-event seen by crash_smp_send_stop() */
+	ldrb	w3, [x4, #SDEI_EVENT_PRIORITY]
+	cbnz	w3, 1f
+	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
+	b	2f
+1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
+2:	str	xzr, [x5]
+
 alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
 	sdei_handler_exit exit_mode=x2
 alternative_else_nop_endif
@@ -1214,4 +1226,15 @@ alternative_else_nop_endif
 #endif
 SYM_CODE_END(__sdei_asm_handler)
 NOKPROBE(__sdei_asm_handler)
+
+SYM_CODE_START(__sdei_handler_abort)
+	mov_q	x0, SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME
+	adr	x1, 1f
+	ldr_l	x2, sdei_exit_mode
+	sdei_handler_exit exit_mode=x2
+	// exit the handler and jump to the next instruction.
+	// Exit will stomp x0-x17, PSTATE, ELR_ELx, and SPSR_ELx.
+1:	ret
+SYM_CODE_END(__sdei_handler_abort)
+NOKPROBE(__sdei_handler_abort)
 #endif /* CONFIG_ARM_SDE_INTERFACE */
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 793c46d6a447..0083f5afa51d 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -38,6 +38,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_stack_critical_ptr);
 #endif
 
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index feee5a3cd128..ae0977b632a1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1072,10 +1072,8 @@ void crash_smp_send_stop(void)
 	 * If this cpu is the only one alive at this point in time, online or
 	 * not, there are no stop messages to be sent around, so just back out.
 	 */
-	if (num_other_online_cpus() == 0) {
-		sdei_mask_local_cpu();
-		return;
-	}
+	if (num_other_online_cpus() == 0)
+		goto skip_ipi;
 
 	cpumask_copy(&mask, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &mask);
@@ -1094,7 +1092,9 @@ void crash_smp_send_stop(void)
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
 			cpumask_pr_args(&mask));
 
+skip_ipi:
 	sdei_mask_local_cpu();
+	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
diff --git a/arch/arm64/lib/csum.c b/arch/arm64/lib/csum.c
index 78b87a64ca0a..2432683e48a6 100644
--- a/arch/arm64/lib/csum.c
+++ b/arch/arm64/lib/csum.c
@@ -24,7 +24,7 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	const u64 *ptr;
 	u64 data, sum64 = 0;
 
-	if (unlikely(len == 0))
+	if (unlikely(len <= 0))
 		return 0;
 
 	offset = (unsigned long)buff & 7;
diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f41615d94a..31a9c634c81e 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -499,12 +499,12 @@ in_ea:
 	dbf	%d0,morein
 	rts
 
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:
 	jbra	fpsp040_die
 
-	.section __ex_table,#alloc
+	.section __ex_table,"a"
 	.align	4
 
 	.long	in_ea,1b
diff --git a/arch/m68k/ifpsp060/os.S b/arch/m68k/ifpsp060/os.S
index 7a0d6e428066..89e2ec224ab6 100644
--- a/arch/m68k/ifpsp060/os.S
+++ b/arch/m68k/ifpsp060/os.S
@@ -379,11 +379,11 @@ _060_real_access:
 
 
 | Execption handling for movs access to illegal memory
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:	moveq		#-1,%d1
 	rts
-.section __ex_table,#alloc
+.section __ex_table,"a"
 	.align 4
 	.long	dmrbuae,1b
 	.long	dmrwuae,1b
diff --git a/arch/m68k/kernel/relocate_kernel.S b/arch/m68k/kernel/relocate_kernel.S
index ab0f1e7d4653..f7667079e08e 100644
--- a/arch/m68k/kernel/relocate_kernel.S
+++ b/arch/m68k/kernel/relocate_kernel.S
@@ -26,7 +26,7 @@ ENTRY(relocate_new_kernel)
 	lea %pc@(.Lcopy),%a4
 2:	addl #0x00000000,%a4		/* virt_to_phys() */
 
-	.section ".m68k_fixup","aw"
+	.section .m68k_fixup,"aw"
 	.long M68K_FIXUP_MEMOFFSET, 2b+2
 	.previous
 
@@ -49,7 +49,7 @@ ENTRY(relocate_new_kernel)
 	lea %pc@(.Lcont040),%a4
 5:	addl #0x00000000,%a4		/* virt_to_phys() */
 
-	.section ".m68k_fixup","aw"
+	.section .m68k_fixup,"aw"
 	.long M68K_FIXUP_MEMOFFSET, 5b+2
 	.previous
 
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 2c52ee27b4f2..50de86eb8784 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -14,7 +14,6 @@
 #include <linux/interrupt.h>
 #include <linux/leds.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/spi/spi.h>
@@ -167,12 +166,7 @@ static struct platform_device db1x00_audio_dev = {
 
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(500));
-	symbol_put(mmc_detect_change);
-
+	mmc_detect_change(ptr, msecs_to_jiffies(500));
 	return IRQ_HANDLED;
 }
 
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 421d651433b6..b70e2cf8a27b 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -10,7 +10,6 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/leds.h>
@@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
 
 static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1200_SD0_INSERT_INT)
@@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
 
 static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(200));
-		symbol_put(mmc_detect_change);
-	}
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == PB1200_SD1_INSERT_INT)
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index cd72eaa1168f..ca71e5ed51ab 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/ata_platform.h>
 #include <linux/mmc/host.h>
-#include <linux/module.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/platnand.h>
 #include <linux/platform_device.h>
@@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 
 static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
 {
-	void (*mmc_cd)(struct mmc_host *, unsigned long);
-
-	/* link against CONFIG_MMC=m.  We can only be called once MMC core has
-	 * initialized the controller, so symbol_get() should always succeed.
-	 */
-	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(200));
-	symbol_put(mmc_detect_change);
+	mmc_detect_change(ptr, msecs_to_jiffies(200));
 
 	msleep(100);	/* debounce */
 	if (irq == DB1300_SD1_INSERT_INT)
diff --git a/arch/parisc/include/asm/led.h b/arch/parisc/include/asm/led.h
index 6de13d08a388..b70b9094fb7c 100644
--- a/arch/parisc/include/asm/led.h
+++ b/arch/parisc/include/asm/led.h
@@ -11,8 +11,8 @@
 #define	LED1		0x02
 #define	LED0		0x01		/* bottom (or furthest left) LED */
 
-#define	LED_LAN_TX	LED0		/* for LAN transmit activity */
-#define	LED_LAN_RCV	LED1		/* for LAN receive activity */
+#define	LED_LAN_RCV	LED0		/* for LAN receive activity */
+#define	LED_LAN_TX	LED1		/* for LAN transmit activity */
 #define	LED_DISK_IO	LED2		/* for disk activity */
 #define	LED_HEARTBEAT	LED3		/* heartbeat */
 
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 6e2a8176b0dd..40135be97965 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -97,7 +97,6 @@ struct cpuinfo_parisc {
 	unsigned long cpu_loc;      /* CPU location from PAT firmware */
 	unsigned int state;
 	struct parisc_device *dev;
-	unsigned long loops_per_jiffy;
 };
 
 extern struct system_cpuinfo_parisc boot_cpu_data;
diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index 176ef00bdd15..ccdbcfdfe4e2 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -163,7 +163,6 @@ static int __init processor_probe(struct parisc_device *dev)
 	if (cpuid)
 		memset(p, 0, sizeof(struct cpuinfo_parisc));
 
-	p->loops_per_jiffy = loops_per_jiffy;
 	p->dev = dev;		/* Save IODC data in case we need it */
 	p->hpa = dev->hpa.start;	/* save CPU hpa */
 	p->cpuid = cpuid;	/* save CPU id */
@@ -373,10 +372,18 @@ int
 show_cpuinfo (struct seq_file *m, void *v)
 {
 	unsigned long cpu;
+	char cpu_name[60], *p;
+
+	/* strip PA path from CPU name to not confuse lscpu */
+	strlcpy(cpu_name, per_cpu(cpu_data, 0).dev->name, sizeof(cpu_name));
+	p = strrchr(cpu_name, '[');
+	if (p)
+		*(--p) = 0;
 
 	for_each_online_cpu(cpu) {
-		const struct cpuinfo_parisc *cpuinfo = &per_cpu(cpu_data, cpu);
 #ifdef CONFIG_SMP
+		const struct cpuinfo_parisc *cpuinfo = &per_cpu(cpu_data, cpu);
+
 		if (0 == cpuinfo->hpa)
 			continue;
 #endif
@@ -421,8 +428,7 @@ show_cpuinfo (struct seq_file *m, void *v)
 
 		seq_printf(m, "model\t\t: %s - %s\n",
 				 boot_cpu_data.pdc.sys_model_name,
-				 cpuinfo->dev ?
-				 cpuinfo->dev->name : "Unknown");
+				 cpu_name);
 
 		seq_printf(m, "hversion\t: 0x%08x\n"
 			        "sversion\t: 0x%08x\n",
@@ -433,8 +439,8 @@ show_cpuinfo (struct seq_file *m, void *v)
 		show_cache_info(m);
 
 		seq_printf(m, "bogomips\t: %lu.%02lu\n",
-			     cpuinfo->loops_per_jiffy / (500000 / HZ),
-			     (cpuinfo->loops_per_jiffy / (5000 / HZ)) % 100);
+			     loops_per_jiffy / (500000 / HZ),
+			     loops_per_jiffy / (5000 / HZ) % 100);
 
 		seq_printf(m, "software id\t: %ld\n\n",
 				boot_cpu_data.pdc.model.sw_id);
diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index c390ec377bae..1412e643122e 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -45,6 +45,7 @@
 #include <asm/types.h>
 #include <asm/mmu.h>
 #include <asm/firmware.h>
+#include <asm/paca.h>
 
 /*
  * The lppaca is the "virtual processor area" registered with the hypervisor,
@@ -123,13 +124,23 @@ struct lppaca {
  */
 #define LPPACA_OLD_SHARED_PROC		2
 
-static inline bool lppaca_shared_proc(struct lppaca *l)
+#ifdef CONFIG_PPC_PSERIES
+/*
+ * All CPUs should have the same shared proc value, so directly access the PACA
+ * to avoid false positives from DEBUG_PREEMPT.
+ */
+static inline bool lppaca_shared_proc(void)
 {
+	struct lppaca *l = local_paca->lppaca_ptr;
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return false;
 	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
 }
 
+#define get_lppaca()	(get_paca()->lppaca_ptr)
+#endif
+
 /*
  * SLB shadow buffer structure as defined in the PAPR.  The save_area
  * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 9454d29ff4b4..555aa3580e16 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -14,7 +14,6 @@
 
 #include <linux/string.h>
 #include <asm/types.h>
-#include <asm/lppaca.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #ifdef CONFIG_PPC_BOOK3E
@@ -45,14 +44,11 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_paca()	local_paca
 #endif
 
-#ifdef CONFIG_PPC_PSERIES
-#define get_lppaca()	(get_paca()->lppaca_ptr)
-#endif
-
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
 struct rtas_args;
+struct lppaca;
 
 /*
  * Defines the layout of the paca.
diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index 588bfb9a0579..546c72501378 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -6,6 +6,7 @@
 #include <asm/smp.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/hvcall.h>
 #endif
 
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index ece84a430701..7796cc05e2c8 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -9,6 +9,7 @@
 
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/page.h>
 
 static inline long poll_pending(void)
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 1a5ba26aab15..935ce1bec43f 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -642,6 +642,7 @@ int __init fadump_reserve_mem(void)
 	return ret;
 error_out:
 	fw_dump.fadump_enabled = 0;
+	fw_dump.reserve_dump_area_size = 0;
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 6806eefa52ce..370635107f1c 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -133,17 +133,28 @@ static int fail_iommu_bus_notify(struct notifier_block *nb,
 	return 0;
 }
 
-static struct notifier_block fail_iommu_bus_notifier = {
+/*
+ * PCI and VIO buses need separate notifier_block structs, since they're linked
+ * list nodes.  Sharing a notifier_block would mean that any notifiers later
+ * registered for PCI buses would also get called by VIO buses and vice versa.
+ */
+static struct notifier_block fail_iommu_pci_bus_notifier = {
 	.notifier_call = fail_iommu_bus_notify
 };
 
+#ifdef CONFIG_IBMVIO
+static struct notifier_block fail_iommu_vio_bus_notifier = {
+	.notifier_call = fail_iommu_bus_notify
+};
+#endif
+
 static int __init fail_iommu_setup(void)
 {
 #ifdef CONFIG_PCI
-	bus_register_notifier(&pci_bus_type, &fail_iommu_bus_notifier);
+	bus_register_notifier(&pci_bus_type, &fail_iommu_pci_bus_notifier);
 #endif
 #ifdef CONFIG_IBMVIO
-	bus_register_notifier(&vio_bus_type, &fail_iommu_bus_notifier);
+	bus_register_notifier(&vio_bus_type, &fail_iommu_vio_bus_notifier);
 #endif
 
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
index 6028628ea3ac..7c693b3ee34b 100644
--- a/arch/powerpc/kvm/book3s_hv_ras.c
+++ b/arch/powerpc/kvm/book3s_hv_ras.c
@@ -9,6 +9,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/kernel.h>
+#include <asm/lppaca.h>
 #include <asm/opal.h>
 #include <asm/mce.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index c30fcbfa0e32..ccf0a876a7bd 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -13,6 +13,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index ee721f420a7b..1a53ab08447c 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -645,7 +645,6 @@ static void perf_event_interrupt(struct pt_regs *regs)
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
 	unsigned long val;
-	int found = 0;
 
 	for (i = 0; i < ppmu->n_counter; ++i) {
 		event = cpuhw->event[i];
@@ -654,7 +653,6 @@ static void perf_event_interrupt(struct pt_regs *regs)
 		if ((int)val < 0) {
 			if (event) {
 				/* event has overflowed */
-				found = 1;
 				record_and_restart(event, val, regs);
 			} else {
 				/*
@@ -672,11 +670,13 @@ static void perf_event_interrupt(struct pt_regs *regs)
 	isync();
 }
 
-void hw_perf_event_setup(int cpu)
+static int fsl_emb_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
 
 	memset(cpuhw, 0, sizeof(*cpuhw));
+
+	return 0;
 }
 
 int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
@@ -689,6 +689,8 @@ int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
 		pmu->name);
 
 	perf_pmu_register(&fsl_emb_pmu, "cpu", PERF_TYPE_RAW);
+	cpuhp_setup_state(CPUHP_PERF_POWER, "perf/powerpc:prepare",
+			  fsl_emb_pmu_prepare_cpu, NULL);
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 28396a7e77d6..68f3b082245e 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -637,16 +637,8 @@ static const struct proc_ops vcpudispatch_stats_freq_proc_ops = {
 
 static int __init vcpudispatch_stats_procfs_init(void)
 {
-	/*
-	 * Avoid smp_processor_id while preemptible. All CPUs should have
-	 * the same value for lppaca_shared_proc.
-	 */
-	preempt_disable();
-	if (!lppaca_shared_proc(get_lppaca())) {
-		preempt_enable();
+	if (!lppaca_shared_proc())
 		return 0;
-	}
-	preempt_enable();
 
 	if (!proc_create("powerpc/vcpudispatch_stats", 0600, NULL,
 					&vcpudispatch_stats_proc_ops))
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index d3517e498512..a7d4e25ae82a 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -205,7 +205,7 @@ static void parse_ppp_data(struct seq_file *m)
 	           ppp_data.active_system_procs);
 
 	/* pool related entries are appropriate for shared configs */
-	if (lppaca_shared_proc(get_lppaca())) {
+	if (lppaca_shared_proc()) {
 		unsigned long pool_idle_time, pool_procs;
 
 		seq_printf(m, "pool=%d\n", ppp_data.pool_num);
@@ -529,7 +529,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 		   partition_potential_processors);
 
 	seq_printf(m, "shared_processor_mode=%d\n",
-		   lppaca_shared_proc(get_lppaca()));
+		   lppaca_shared_proc());
 
 #ifdef CONFIG_PPC_BOOK3S_64
 	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0eac9ca782c2..822be2680b79 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -800,7 +800,7 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca())) {
+		if (lppaca_shared_proc()) {
 			static_branch_enable(&shared_processor);
 			pv_spinlocks_init();
 		}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 2872b66d9fec..3de2adc0a807 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -58,6 +58,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #endif
 
 #include "nonstdio.h"
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index f3caeb17c85b..a6727ad58d65 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -34,7 +34,7 @@
  * and padding is also possible, the limits need to be generous.
  */
 #define PAES_MIN_KEYSIZE 16
-#define PAES_MAX_KEYSIZE 320
+#define PAES_MAX_KEYSIZE MAXEP11AESKEYBLOBSIZE
 
 static u8 *ctrblk;
 static DEFINE_MUTEX(ctrblk_lock);
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 6da06905ddce..c469e8848d65 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -501,6 +501,8 @@ static struct attribute_group ipl_ccw_attr_group_lpar = {
 
 static struct attribute *ipl_unknown_attrs[] = {
 	&sys_ipl_type_attr.attr,
+	&sys_ipl_secure_attr.attr,
+	&sys_ipl_has_secure_attr.attr,
 	NULL,
 };
 
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index bac8a058ebd7..05bd42dde107 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -530,7 +530,7 @@ static int __init ap325rxa_devices_setup(void)
 	device_initialize(&ap325rxa_ceu_device.dev);
 	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
 			ceu_dma_membase, ceu_dma_membase,
-			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
+			CEU_BUFFER_MEMORY_SIZE);
 
 	platform_device_add(&ap325rxa_ceu_device);
 
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bab91a99124e..9730a992dab3 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1454,15 +1454,13 @@ static int __init arch_setup(void)
 	device_initialize(&ecovec_ceu_devices[0]->dev);
 	dma_declare_coherent_memory(&ecovec_ceu_devices[0]->dev,
 				    ceu0_dma_membase, ceu0_dma_membase,
-				    ceu0_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ecovec_ceu_devices[0]);
 
 	device_initialize(&ecovec_ceu_devices[1]->dev);
 	dma_declare_coherent_memory(&ecovec_ceu_devices[1]->dev,
 				    ceu1_dma_membase, ceu1_dma_membase,
-				    ceu1_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ecovec_ceu_devices[1]);
 
 	gpiod_add_lookup_table(&cn12_power_gpiod_table);
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index eeb5ce341efd..4a1caa3e7cf5 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -603,7 +603,7 @@ static int __init kfr2r09_devices_setup(void)
 	device_initialize(&kfr2r09_ceu_device.dev);
 	dma_declare_coherent_memory(&kfr2r09_ceu_device.dev,
 			ceu_dma_membase, ceu_dma_membase,
-			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
+			CEU_BUFFER_MEMORY_SIZE);
 
 	platform_device_add(&kfr2r09_ceu_device);
 
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 6703a2122c0d..bd4ccd9f8dd0 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -604,7 +604,7 @@ static int __init migor_devices_setup(void)
 	device_initialize(&migor_ceu_device.dev);
 	dma_declare_coherent_memory(&migor_ceu_device.dev,
 			ceu_dma_membase, ceu_dma_membase,
-			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
+			CEU_BUFFER_MEMORY_SIZE);
 
 	platform_device_add(&migor_ceu_device);
 
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 8d6541ba0186..edc7712e4a80 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -940,15 +940,13 @@ static int __init devices_setup(void)
 	device_initialize(&ms7724se_ceu_devices[0]->dev);
 	dma_declare_coherent_memory(&ms7724se_ceu_devices[0]->dev,
 				    ceu0_dma_membase, ceu0_dma_membase,
-				    ceu0_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ms7724se_ceu_devices[0]);
 
 	device_initialize(&ms7724se_ceu_devices[1]->dev);
 	dma_declare_coherent_memory(&ms7724se_ceu_devices[1]->dev,
 				    ceu1_dma_membase, ceu1_dma_membase,
-				    ceu1_dma_membase +
-				    CEU_BUFFER_MEMORY_SIZE - 1);
+				    CEU_BUFFER_MEMORY_SIZE);
 	platform_device_add(ms7724se_ceu_devices[1]);
 
 	return platform_add_devices(ms7724se_devices,
diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
index fb51bd206dbe..4d7f99a02c1e 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -35,6 +35,7 @@ CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
+CONFIG_SOUND=m
 CONFIG_UML_SOUND=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
index 477b87317424..4bdd83008f62 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -33,6 +33,7 @@ CONFIG_TTY_CHAN=y
 CONFIG_XTERM_CHAN=y
 CONFIG_CON_CHAN="pts"
 CONFIG_SSL_CHAN="pts"
+CONFIG_SOUND=m
 CONFIG_UML_SOUND=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2e7b8e0e7194..01dfbd57e29d 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -104,24 +104,14 @@ config SSL_CHAN
 
 config UML_SOUND
 	tristate "Sound support"
+	depends on SOUND
+	select SOUND_OSS_CORE
 	help
 	  This option enables UML sound support.  If enabled, it will pull in
-	  soundcore and the UML hostaudio relay, which acts as a intermediary
+	  the UML hostaudio relay, which acts as a intermediary
 	  between the host's dsp and mixer devices and the UML sound system.
 	  It is safe to say 'Y' here.
 
-config SOUND
-	tristate
-	default UML_SOUND
-
-config SOUND_OSS_CORE
-	bool
-	default UML_SOUND
-
-config HOSTAUDIO
-	tristate
-	default UML_SOUND
-
 endmenu
 
 menu "UML Network Devices"
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 2a249f619467..207d62ab519d 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_UML_NET) += net.o
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
 obj-$(CONFIG_BLK_DEV_UBD) += ubd.o 
-obj-$(CONFIG_HOSTAUDIO) += hostaudio.o
+obj-$(CONFIG_UML_SOUND) += hostaudio.o
 obj-$(CONFIG_NULL_CHAN) += null.o 
 obj-$(CONFIG_PORT_CHAN) += port.o
 obj-$(CONFIG_PTY_CHAN) += pty.o
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b55e2007b30c..473d84eb5dda 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -454,11 +454,25 @@ SYM_CODE_START(startup_64)
 	/* Save the trampoline address in RCX */
 	movq	%rax, %rcx
 
+	/* Set up 32-bit addressable stack */
+	leaq	TRAMPOLINE_32BIT_STACK_END(%rcx), %rsp
+
+	/*
+	 * Preserve live 64-bit registers on the stack: this is necessary
+	 * because the architecture does not guarantee that GPRs will retain
+	 * their full 64-bit values across a 32-bit mode switch.
+	 */
+	pushq	%rbp
+	pushq	%rbx
+	pushq	%rsi
+
 	/*
-	 * Load the address of trampoline_return() into RDI.
-	 * It will be used by the trampoline to return to the main code.
+	 * Push the 64-bit address of trampoline_return() onto the new stack.
+	 * It will be used by the trampoline to return to the main code. Due to
+	 * the 32-bit mode switch, it cannot be kept it in a register either.
 	 */
 	leaq	trampoline_return(%rip), %rdi
+	pushq	%rdi
 
 	/* Switch to compatibility mode (CS.L = 0 CS.D = 1) via far return */
 	pushq	$__KERNEL32_CS
@@ -466,6 +480,11 @@ SYM_CODE_START(startup_64)
 	pushq	%rax
 	lretq
 trampoline_return:
+	/* Restore live 64-bit registers */
+	popq	%rsi
+	popq	%rbx
+	popq	%rbp
+
 	/* Restore the stack, the 32-bit trampoline uses its own stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
 
@@ -586,7 +605,7 @@ SYM_FUNC_END(.Lrelocated)
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
- * RDI contains the return address (might be above 4G).
+ * Return address is at the top of the stack (might be above 4G).
  * ECX contains the base address of the trampoline memory.
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
@@ -596,9 +615,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %ds
 	movl	%eax, %ss
 
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -658,7 +674,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	jmp	*%rdi
+	retq
 SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 394757ee030a..85baa72cb894 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -125,11 +125,12 @@
  * instance, and is *not* included in this mask since
  * pte_modify() does modify it.
  */
-#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
-			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
-			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC |  \
-			 _PAGE_UFFD_WP)
-#define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
+#define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	       \
+				 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |\
+				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC | \
+				 _PAGE_UFFD_WP)
+#define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
+#define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
 
 /*
  * The cache modes defined here are used to translate between pure SW usage
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 8eefa3386d8c..331474296e6f 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -95,12 +95,6 @@ static inline int cpu_has_svm(const char **msg)
 		return 0;
 	}
 
-	if (boot_cpu_data.extended_cpuid_level < SVM_CPUID_FUNC) {
-		if (msg)
-			*msg = "can't execute cpuid_8000000a";
-		return 0;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_SVM)) {
 		if (msg)
 			*msg = "svm not available";
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 660270359d39..166d9991e711 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -237,12 +237,6 @@
 extern int (*console_blank_hook)(int);
 #endif
 
-/*
- * The apm_bios device is one of the misc char devices.
- * This is its minor number.
- */
-#define	APM_MINOR_DEV	134
-
 /*
  * Various options can be changed at boot time as follows:
  * (We allow underscores for compatibility with the modules code)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c1ff75ad1135..4ecc6072e9a4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1145,11 +1145,11 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		SRBDS | MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS),
diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 5590b0f68837..a4e40166ff4b 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -26,4 +26,13 @@
 #define XCHAL_SPANNING_WAY 0
 #endif
 
+#ifndef XCHAL_HW_MIN_VERSION
+#if defined(XCHAL_HW_MIN_VERSION_MAJOR) && defined(XCHAL_HW_MIN_VERSION_MINOR)
+#define XCHAL_HW_MIN_VERSION (XCHAL_HW_MIN_VERSION_MAJOR * 100 + \
+			      XCHAL_HW_MIN_VERSION_MINOR)
+#else
+#define XCHAL_HW_MIN_VERSION 0
+#endif
+#endif
+
 #endif
diff --git a/arch/xtensa/kernel/perf_event.c b/arch/xtensa/kernel/perf_event.c
index a0d05c8598d0..183618090d05 100644
--- a/arch/xtensa/kernel/perf_event.c
+++ b/arch/xtensa/kernel/perf_event.c
@@ -13,17 +13,26 @@
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
+#include <asm/core.h>
 #include <asm/processor.h>
 #include <asm/stacktrace.h>
 
+#define XTENSA_HWVERSION_RG_2015_0	260000
+
+#if XCHAL_HW_MIN_VERSION >= XTENSA_HWVERSION_RG_2015_0
+#define XTENSA_PMU_ERI_BASE		0x00101000
+#else
+#define XTENSA_PMU_ERI_BASE		0x00001000
+#endif
+
 /* Global control/status for all perf counters */
-#define XTENSA_PMU_PMG			0x1000
+#define XTENSA_PMU_PMG			XTENSA_PMU_ERI_BASE
 /* Perf counter values */
-#define XTENSA_PMU_PM(i)		(0x1080 + (i) * 4)
+#define XTENSA_PMU_PM(i)		(XTENSA_PMU_ERI_BASE + 0x80 + (i) * 4)
 /* Perf counter control registers */
-#define XTENSA_PMU_PMCTRL(i)		(0x1100 + (i) * 4)
+#define XTENSA_PMU_PMCTRL(i)		(XTENSA_PMU_ERI_BASE + 0x100 + (i) * 4)
 /* Perf counter status registers */
-#define XTENSA_PMU_PMSTAT(i)		(0x1180 + (i) * 4)
+#define XTENSA_PMU_PMSTAT(i)		(XTENSA_PMU_ERI_BASE + 0x180 + (i) * 4)
 
 #define XTENSA_PMU_PMG_PMEN		0x1
 
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 42dca17dc2d9..5d422e725b26 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -16,6 +16,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "internal.h"
 
@@ -68,15 +69,26 @@ static void crypto_free_instance(struct crypto_instance *inst)
 	inst->alg.cra_type->free(inst);
 }
 
-static void crypto_destroy_instance(struct crypto_alg *alg)
+static void crypto_destroy_instance_workfn(struct work_struct *w)
 {
-	struct crypto_instance *inst = (void *)alg;
+	struct crypto_instance *inst = container_of(w, struct crypto_instance,
+						    free_work);
 	struct crypto_template *tmpl = inst->tmpl;
 
 	crypto_free_instance(inst);
 	crypto_tmpl_put(tmpl);
 }
 
+static void crypto_destroy_instance(struct crypto_alg *alg)
+{
+	struct crypto_instance *inst = container_of(alg,
+						    struct crypto_instance,
+						    alg);
+
+	INIT_WORK(&inst->free_work, crypto_destroy_instance_workfn);
+	schedule_work(&inst->free_work);
+}
+
 /*
  * This function adds a spawn to the list secondary_spawns which
  * will be used at the end of crypto_remove_spawns to unregister
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index ae450eb8be14..b8135c38f584 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -132,6 +132,11 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
 		goto out;
 
+	if (cert->unsupported_sig) {
+		ret = 0;
+		goto out;
+	}
+
 	ret = public_key_verify_signature(cert->pub, cert->sig);
 	if (ret < 0) {
 		if (ret == -ENOPKG) {
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9bdb5bd5fda6..8678e162181f 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1457,33 +1457,35 @@ static struct platform_driver ghes_platform_driver = {
 	.remove		= ghes_remove,
 };
 
-static int __init ghes_init(void)
+void __init ghes_init(void)
 {
 	int rc;
 
+	sdei_init();
+
 	if (acpi_disabled)
-		return -ENODEV;
+		return;
 
 	switch (hest_disable) {
 	case HEST_NOT_FOUND:
-		return -ENODEV;
+		return;
 	case HEST_DISABLED:
 		pr_info(GHES_PFX "HEST is not enabled!\n");
-		return -EINVAL;
+		return;
 	default:
 		break;
 	}
 
 	if (ghes_disable) {
 		pr_info(GHES_PFX "GHES is not enabled!\n");
-		return -EINVAL;
+		return;
 	}
 
 	ghes_nmi_init_cxt();
 
 	rc = platform_driver_register(&ghes_platform_driver);
 	if (rc)
-		goto err;
+		return;
 
 	rc = apei_osc_setup();
 	if (rc == 0 && osc_sb_apei_support_acked)
@@ -1494,9 +1496,4 @@ static int __init ghes_init(void)
 		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
 	else
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
-
-	return 0;
-err:
-	return rc;
 }
-device_initcall(ghes_init);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5e14288fcabe..60dfe63301d0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1252,6 +1252,8 @@ static int __init acpi_init(void)
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
+	acpi_hest_init();
+	ghes_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c12b5fb3e8fb..d972ea057a03 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -20,8 +20,6 @@
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/platform_data/x86/apple.h>
-#include <acpi/apei.h>	/* for acpi_hest_init() */
-
 #include "internal.h"
 
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
@@ -950,7 +948,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 
 void __init acpi_pci_root_init(void)
 {
-	acpi_hest_init();
 	if (acpi_pci_disabled)
 		return;
 
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 47c72447ccd5..52ab582930ca 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -363,6 +363,7 @@ static void amba_device_release(struct device *dev)
 {
 	struct amba_device *d = to_amba_device(dev);
 
+	of_node_put(d->dev.of_node);
 	if (d->res.parent)
 		release_resource(&d->res);
 	kfree(d);
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 63f39440a9b4..4ba02f082f96 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -528,7 +528,8 @@ static void data_xfer(struct work_struct *work)
 	/* dma_request_channel may sleep, so calling from process context */
 	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
 	if (IS_ERR(acdev->dma_chan)) {
-		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		dev_err_probe(acdev->host->dev, PTR_ERR(acdev->dma_chan),
+			      "Unable to get dma_chan\n");
 		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 34cb104f6b43..bc30e2f305be 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -570,6 +570,7 @@ static struct platform_driver pata_ftide010_driver = {
 };
 module_platform_driver(pata_ftide010_driver);
 
+MODULE_DESCRIPTION("low level driver for Faraday Technology FTIDE010");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index f793564f3d78..6fd54e968d10 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -435,6 +435,7 @@ static struct platform_driver gemini_sata_driver = {
 };
 module_platform_driver(gemini_sata_driver);
 
+MODULE_DESCRIPTION("low level driver for Cortina Systems Gemini SATA bridge");
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index fabf87058d80..ae6b8788d5f3 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -277,7 +277,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 
 	blk = krealloc(rbnode->block,
 		       blklen * map->cache_word_size,
-		       GFP_KERNEL);
+		       map->alloc_flags);
 	if (!blk)
 		return -ENOMEM;
 
@@ -286,7 +286,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
 	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
 		present = krealloc(rbnode->cache_present,
 				   BITS_TO_LONGS(blklen) * sizeof(*present),
-				   GFP_KERNEL);
+				   map->alloc_flags);
 		if (!present)
 			return -ENOMEM;
 
@@ -320,7 +320,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	const struct regmap_range *range;
 	int i;
 
-	rbnode = kzalloc(sizeof(*rbnode), GFP_KERNEL);
+	rbnode = kzalloc(sizeof(*rbnode), map->alloc_flags);
 	if (!rbnode)
 		return NULL;
 
@@ -346,13 +346,13 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
 	}
 
 	rbnode->block = kmalloc_array(rbnode->blklen, map->cache_word_size,
-				      GFP_KERNEL);
+				      map->alloc_flags);
 	if (!rbnode->block)
 		goto err_free;
 
 	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
 					sizeof(*rbnode->cache_present),
-					GFP_KERNEL);
+					map->alloc_flags);
 	if (!rbnode->cache_present)
 		goto err_free_block;
 
diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index c157a912d673..88336f093dec 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -84,7 +84,7 @@ test_platform_device_register_node(char *name, int id, int nid)
 
 	pdev = platform_device_alloc(name, id);
 	if (!pdev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (nid != NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, nid);
diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 199e8f7d426d..2e4ac39dd975 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -355,6 +355,7 @@ static void btsdio_remove(struct sdio_func *func)
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 49d5375b04f4..f99d19077020 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1689,7 +1689,7 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 		 * alternate setting.
 		 */
 		spin_lock_irqsave(&data->rxlock, flags);
-		kfree_skb(data->sco_skb);
+		dev_kfree_skb_irq(data->sco_skb);
 		data->sco_skb = NULL;
 		spin_unlock_irqrestore(&data->rxlock, flags);
 
diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 05f7f6de6863..97da0b2bfd17 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -734,7 +734,11 @@ static int nokia_bluetooth_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
-	clk_prepare_enable(sysclk);
+	err = clk_prepare_enable(sysclk);
+	if (err) {
+		dev_err(dev, "could not enable sysclk: %d", err);
+		return err;
+	}
 	btdev->sysclk_speed = clk_get_rate(sysclk);
 	clk_disable_unprepare(sysclk);
 
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 7d69b740b9f9..fe8ecd6eaa4d 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -490,6 +490,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		u32 in_reset = -1;
 		unsigned long timeout = msecs_to_jiffies(mhi_cntrl->timeout_ms);
 
+		/* Skip MHI RESET if in RDDM state */
+		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
+			goto skip_mhi_reset;
+
 		dev_dbg(dev, "Triggering MHI Reset in device\n");
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 
@@ -515,6 +519,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
 	}
 
+skip_mhi_reset:
 	dev_dbg(dev,
 		 "Waiting for all pending event ring processing to complete\n");
 	mhi_event = mhi_cntrl->mhi_event;
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index fcfe4d16cc14..c8e0f8cb9aa3 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3041,7 +3041,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 
 	match = soc_device_match(sysc_soc_match);
 	if (match && match->data)
-		sysc_soc->soc = (int)match->data;
+		sysc_soc->soc = (enum sysc_soc)(uintptr_t)match->data;
 
 	/* Ignore devices that are not available on HS and EMU SoCs */
 	if (!sysc_soc->general_purpose) {
diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
index 01583faf9893..52c4aa66d837 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -195,6 +195,8 @@ static int iproc_rng200_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 	}
 
+	dev_set_drvdata(dev, priv);
+
 	priv->rng.name = "iproc-rng200";
 	priv->rng.read = iproc_rng200_read;
 	priv->rng.init = iproc_rng200_init;
@@ -212,6 +214,28 @@ static int iproc_rng200_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused iproc_rng200_suspend(struct device *dev)
+{
+	struct iproc_rng200_dev *priv = dev_get_drvdata(dev);
+
+	iproc_rng200_cleanup(&priv->rng);
+
+	return 0;
+}
+
+static int __maybe_unused iproc_rng200_resume(struct device *dev)
+{
+	struct iproc_rng200_dev *priv =  dev_get_drvdata(dev);
+
+	iproc_rng200_init(&priv->rng);
+
+	return 0;
+}
+
+static const struct dev_pm_ops iproc_rng200_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(iproc_rng200_suspend, iproc_rng200_resume)
+};
+
 static const struct of_device_id iproc_rng200_of_match[] = {
 	{ .compatible = "brcm,bcm2711-rng200", },
 	{ .compatible = "brcm,bcm7211-rng200", },
@@ -225,6 +249,7 @@ static struct platform_driver iproc_rng200_driver = {
 	.driver = {
 		.name		= "iproc-rng200",
 		.of_match_table = iproc_rng200_of_match,
+		.pm		= &iproc_rng200_pm_ops,
 	},
 	.probe		= iproc_rng200_probe,
 };
diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index e8f9621e7954..3774adf903a8 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -13,8 +13,6 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
-static struct clk *rng_clk;
-
 static int nmk_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
 	void __iomem *base = (void __iomem *)rng->priv;
@@ -36,21 +34,20 @@ static struct hwrng nmk_rng = {
 
 static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 {
+	struct clk *rng_clk;
 	void __iomem *base;
 	int ret;
 
-	rng_clk = devm_clk_get(&dev->dev, NULL);
+	rng_clk = devm_clk_get_enabled(&dev->dev, NULL);
 	if (IS_ERR(rng_clk)) {
 		dev_err(&dev->dev, "could not get rng clock\n");
 		ret = PTR_ERR(rng_clk);
 		return ret;
 	}
 
-	clk_prepare_enable(rng_clk);
-
 	ret = amba_request_regions(dev, dev->dev.init_name);
 	if (ret)
-		goto out_clk;
+		return ret;
 	ret = -ENOMEM;
 	base = devm_ioremap(&dev->dev, dev->res.start,
 			    resource_size(&dev->res));
@@ -64,15 +61,12 @@ static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 
 out_release:
 	amba_release_regions(dev);
-out_clk:
-	clk_disable_unprepare(rng_clk);
 	return ret;
 }
 
 static void nmk_rng_remove(struct amba_device *dev)
 {
 	amba_release_regions(dev);
-	clk_disable_unprepare(rng_clk);
 }
 
 static const struct amba_id nmk_rng_ids[] = {
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 7fe68c680d3e..a5418692a818 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2089,6 +2089,11 @@ static int try_smi_init(struct smi_info *new_smi)
 		new_smi->io.io_cleanup = NULL;
 	}
 
+	if (rv && new_smi->si_sm) {
+		kfree(new_smi->si_sm);
+		new_smi->si_sm = NULL;
+	}
+
 	return rv;
 }
 
diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index a3745fa643f3..30f757249c5c 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1414,7 +1414,7 @@ static struct ssif_addr_info *ssif_info_find(unsigned short addr,
 restart:
 	list_for_each_entry(info, &ssif_infos, link) {
 		if (info->binfo.addr == addr) {
-			if (info->addr_src == SI_SMBIOS)
+			if (info->addr_src == SI_SMBIOS && !info->adapter_name)
 				info->adapter_name = kstrdup(adapter_name,
 							     GFP_KERNEL);
 
@@ -1614,6 +1614,11 @@ static int ssif_add_infos(struct i2c_client *client)
 	info->addr_src = SI_ACPI;
 	info->client = client;
 	info->adapter_name = kstrdup(client->adapter->name, GFP_KERNEL);
+	if (!info->adapter_name) {
+		kfree(info);
+		return -ENOMEM;
+	}
+
 	info->binfo.addr = client->addr;
 	list_add_tail(&info->link, &ssif_infos);
 	return 0;
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4ae49eae4586..df739665f206 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -356,6 +356,7 @@ config COMMON_CLK_BD718XX
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 04e728538cef..75e05582cb24 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -97,7 +97,7 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 	int prediv_value;
 	int div_value;
 	int ret;
-	u32 val;
+	u32 orig, val;
 
 	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
 						&prediv_value, &div_value);
@@ -106,13 +106,15 @@ static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
 
 	spin_lock_irqsave(divider->lock, flags);
 
-	val = readl(divider->reg);
-	val &= ~((clk_div_mask(divider->width) << divider->shift) |
-			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+	orig = readl(divider->reg);
+	val = orig & ~((clk_div_mask(divider->width) << divider->shift) |
+		       (clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
 
 	val |= (u32)(prediv_value  - 1) << divider->shift;
 	val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
-	writel(val, divider->reg);
+
+	if (val != orig)
+		writel(val, divider->reg);
 
 	spin_unlock_irqrestore(divider->lock, flags);
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 98a4711ef38d..148572852e70 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -181,10 +181,6 @@ static const char * const imx8mp_sai3_sels[] = {"osc_24m", "audio_pll1_out", "au
 						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext3", "clk_ext4", };
 
-static const char * const imx8mp_sai4_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
-						"clk_ext1", "clk_ext2", };
-
 static const char * const imx8mp_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
 						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext2", "clk_ext3", };
@@ -596,7 +592,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mp_sai1_sels, ccm_base + 0xa580);
 	hws[IMX8MP_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mp_sai2_sels, ccm_base + 0xa600);
 	hws[IMX8MP_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mp_sai3_sels, ccm_base + 0xa680);
-	hws[IMX8MP_CLK_SAI4] = imx8m_clk_hw_composite("sai4", imx8mp_sai4_sels, ccm_base + 0xa700);
 	hws[IMX8MP_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mp_sai5_sels, ccm_base + 0xa780);
 	hws[IMX8MP_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mp_sai6_sels, ccm_base + 0xa800);
 	hws[IMX8MP_CLK_ENET_QOS] = imx8m_clk_hw_composite("enet_qos", imx8mp_enet_qos_sels, ccm_base + 0xa880);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index aba36e4217d2..e46311c2e63e 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -60,8 +60,6 @@ static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
 	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
-	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
-	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
 
 struct imx_pll14xx_clk imx_1443x_pll = {
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index d59a7621bb20..ee5c72369334 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -209,7 +209,7 @@ static void __init _of_pll_clk_init(struct device_node *node, bool pllctrl)
 	}
 
 	clk = clk_register_pll(NULL, node->name, parent_name, pll_data);
-	if (clk) {
+	if (!IS_ERR_OR_NULL(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		return;
 	}
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index 8bed02a748ab..470a277603a9 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -58,7 +58,7 @@ static struct clk_regmap pll0_vote = {
 	.enable_mask = BIT(0),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll0_vote",
-		.parent_names = (const char *[]){ "pll8" },
+		.parent_names = (const char *[]){ "pll0" },
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
 	},
diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index 7e80dbd4a3f9..bebe31793523 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -285,7 +285,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
 		.parent_data = gcc_parent_data_0_ao,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0_ao),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 		},
@@ -309,7 +309,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parent_data_4,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -323,7 +323,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parent_data_4,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -337,7 +337,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parent_data_4,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -357,7 +357,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -378,7 +378,7 @@ static struct clk_rcg2 gcc_qspi_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qspi_core_clk_src",
 		.parent_data = gcc_parent_data_2,
-		.num_parents = 6,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -619,7 +619,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
@@ -641,7 +641,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -665,7 +665,8 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
@@ -688,7 +689,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -710,7 +711,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -730,7 +731,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_3,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -751,7 +752,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -773,7 +774,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -793,7 +794,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -812,7 +813,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_prim_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_6,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
 		.ops = &clk_rcg2_ops,
 	},
 };
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index 7ec11acc8298..70723e4dab00 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -200,7 +200,7 @@ static struct clk_rcg2 gcc_cpuss_ahb_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_cpuss_ahb_clk_src",
 		.parent_data = gcc_parent_data_0_ao,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0_ao),
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_ops,
 	},
@@ -224,7 +224,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parent_data_1,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -238,7 +238,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parent_data_1,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -252,7 +252,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parent_data_1,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -272,7 +272,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_0_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -286,7 +286,7 @@ static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_1_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -300,7 +300,7 @@ static struct clk_rcg2 gcc_pcie_2_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_2_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -320,7 +320,7 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_phy_refgen_clk_src",
 		.parent_data = gcc_parent_data_0_ao,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0_ao),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -341,7 +341,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -369,7 +369,7 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -385,7 +385,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -417,7 +417,7 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
 static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -433,7 +433,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -449,7 +449,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -465,7 +465,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -481,7 +481,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s6_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -497,7 +497,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
 	.name = "gcc_qupv3_wrap0_s7_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -513,7 +513,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -529,7 +529,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -545,7 +545,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -561,7 +561,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -577,7 +577,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -593,7 +593,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -609,7 +609,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s0_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s0_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -625,7 +625,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s1_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s1_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -641,7 +641,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s2_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s2_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -657,7 +657,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s3_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s3_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -673,7 +673,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s4_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s4_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -689,7 +689,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
 static struct clk_init_data gcc_qupv3_wrap2_s5_clk_src_init = {
 	.name = "gcc_qupv3_wrap2_s5_clk_src",
 	.parent_data = gcc_parent_data_0,
-	.num_parents = 3,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.ops = &clk_rcg2_ops,
 };
 
@@ -721,7 +721,8 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4,
-		.num_parents = 5,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
@@ -744,7 +745,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
@@ -763,7 +764,7 @@ static struct clk_rcg2 gcc_tsif_ref_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_tsif_ref_clk_src",
 		.parent_data = gcc_parent_data_5,
-		.num_parents = 4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -785,7 +786,7 @@ static struct clk_rcg2 gcc_ufs_card_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_axi_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -807,7 +808,7 @@ static struct clk_rcg2 gcc_ufs_card_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -826,7 +827,7 @@ static struct clk_rcg2 gcc_ufs_card_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_3,
-		.num_parents = 1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -847,7 +848,7 @@ static struct clk_rcg2 gcc_ufs_card_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_unipro_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -870,7 +871,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -884,7 +885,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -898,7 +899,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_3,
-		.num_parents = 1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -912,7 +913,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -935,7 +936,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -949,7 +950,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -963,7 +964,7 @@ static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_master_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -977,7 +978,7 @@ static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_mock_utmi_clk_src",
 		.parent_data = gcc_parent_data_0,
-		.num_parents = 3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -991,7 +992,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_prim_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -1005,7 +1006,7 @@ static struct clk_rcg2 gcc_usb3_sec_phy_aux_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb3_sec_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
-		.num_parents = 2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.ops = &clk_rcg2_ops,
 	},
 };
diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 0e914ec7aeae..e45e32804d2c 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -16,7 +16,8 @@ static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
 
 	rcdev->ops->assert(rcdev, id);
-	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
diff --git a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
index de33414fc5c2..c6a6ce98ca03 100644
--- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c
+++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
@@ -43,7 +43,7 @@ int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode)
 EXPORT_SYMBOL_GPL(sunxi_ccu_set_mmc_timing_mode);
 
 /**
- * sunxi_ccu_set_mmc_timing_mode: Get the current MMC clock timing mode
+ * sunxi_ccu_get_mmc_timing_mode: Get the current MMC clock timing mode
  * @clk: clock to query
  *
  * Returns 0 if the clock is in old timing mode, > 0 if it is in
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 4153150e20db..f644c5e325fb 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -434,7 +434,11 @@ brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
 	if (ret)
 		return ERR_PTR(ret);
 
-	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1, sizeof(*table),
+	/*
+	 * We allocate space for the 5 different P-STATES AVS,
+	 * plus extra space for a terminating element.
+	 */
+	table = devm_kcalloc(dev, AVS_PSTATE_MAX + 1 + 1, sizeof(*table),
 			     GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 58342390966b..5b4bca71f201 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -450,8 +450,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 			    policy->cur,
 			    policy->cpuinfo.max_freq);
 
+	spin_lock(&policy->transition_lock);
 	policy->transition_ongoing = false;
 	policy->transition_task = NULL;
+	spin_unlock(&policy->transition_lock);
 
 	wake_up(&policy->transition_wait);
 }
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index b9ccb6a3dad9..22d4c639d71d 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1101,7 +1101,8 @@ static int powernowk8_cpu_exit(struct cpufreq_policy *pol)
 
 	kfree(data->powernow_table);
 	kfree(data);
-	for_each_cpu(cpu, pol->cpus)
+	/* pol->cpus will be empty here, use related_cpus instead. */
+	for_each_cpu(cpu, pol->related_cpus)
 		per_cpu(powernow_data, cpu) = NULL;
 
 	return 0;
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index ff164dec8422..f4cf3ade03db 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -409,13 +409,7 @@ static int __init pseries_idle_probe(void)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		/*
-		 * Use local_paca instead of get_lppaca() since
-		 * preemption is not disabled, and it is not required in
-		 * fact, since lppaca_ptr does not need to be the value
-		 * associated to the current CPU, it can be from any CPU.
-		 */
-		if (lppaca_shared_proc(local_paca->lppaca_ptr)) {
+		if (lppaca_shared_proc()) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 3acc825da4cc..5bd70a59f4ce 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -222,7 +222,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
 		if (len && *buff)
 			break;
 
-		sg_miter_next(&miter);
+		if (!sg_miter_next(&miter))
+			break;
+
 		buff = miter.addr;
 		len = miter.length;
 
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 16bb52836b28..37fde13b80dd 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -564,9 +564,9 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	}
 
 	for_each_sg(rctx->sg, tsg, rctx->nents, i) {
+		sg[0] = *tsg;
 		len = sg->length;
 
-		sg[0] = *tsg;
 		if (sg_is_last(sg)) {
 			if (hdev->dma_mode == 1) {
 				len = (ALIGN(sg->length, 16) - 16);
@@ -1565,9 +1565,7 @@ static int stm32_hash_remove(struct platform_device *pdev)
 	if (!hdev)
 		return -ENODEV;
 
-	ret = pm_runtime_resume_and_get(hdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(hdev->dev);
 
 	stm32_hash_unregister_algs(hdev);
 
@@ -1583,7 +1581,8 @@ static int stm32_hash_remove(struct platform_device *pdev)
 	pm_runtime_disable(hdev->dev);
 	pm_runtime_put_noidle(hdev->dev);
 
-	clk_disable_unprepare(hdev->clk);
+	if (ret >= 0)
+		clk_disable_unprepare(hdev->clk);
 
 	return 0;
 }
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c6f460550f5e..42c1eed44529 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -732,6 +732,7 @@ static void devfreq_dev_release(struct device *dev)
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	mutex_destroy(&devfreq->lock);
+	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
 }
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 08013345d1f2..7e1bd79fbee8 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -208,6 +208,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -277,6 +278,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index b35b97cb8fd2..d99fec821508 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3598,6 +3598,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	spin_lock_init(&base->lcla_pool.lock);
 
 	base->irq = platform_get_irq(pdev, 0);
+	if (base->irq < 0) {
+		ret = base->irq;
+		goto destroy_cache;
+	}
 
 	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index c08968c5ddf8..807c5320dc0f 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -72,6 +72,7 @@ config ARM_SCPI_POWER_DOMAIN
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
+	depends on ACPI_APEI_GHES
 	help
 	  The Software Delegated Exception Interface (SDEI) is an ARM
 	  standard for registering callbacks from the platform firmware
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 5a877d76078f..68e55ca7491e 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1063,14 +1063,14 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
-static int __init sdei_init(void)
+void __init sdei_init(void)
 {
 	struct platform_device *pdev;
 	int ret;
 
 	ret = platform_driver_register(&sdei_driver);
 	if (ret || !sdei_present_acpi())
-		return ret;
+		return;
 
 	pdev = platform_device_register_simple(sdei_driver.driver.name,
 					       0, NULL, 0);
@@ -1080,17 +1080,8 @@ static int __init sdei_init(void)
 		pr_info("Failed to register ACPI:SDEI platform device %d\n",
 			ret);
 	}
-
-	return ret;
 }
 
-/*
- * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
- * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
- * by device_initcall(). We want to be called in the middle.
- */
-subsys_initcall_sync(sdei_init);
-
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
@@ -1118,3 +1109,22 @@ int sdei_event_handler(struct pt_regs *regs,
 	return err;
 }
 NOKPROBE_SYMBOL(sdei_event_handler);
+
+void sdei_handler_abort(void)
+{
+	/*
+	 * If the crash happened in an SDEI event handler then we need to
+	 * finish the handler with the firmware so that we can have working
+	 * interrupts in the crash kernel.
+	 */
+	if (__this_cpu_read(sdei_active_critical_event)) {
+	        pr_warn("still in SDEI critical event context, attempting to finish handler.\n");
+	        __sdei_handler_abort();
+	        __this_cpu_write(sdei_active_critical_event, NULL);
+	}
+	if (__this_cpu_read(sdei_active_normal_event)) {
+	        pr_warn("still in SDEI normal event context, attempting to finish handler.\n");
+	        __sdei_handler_abort();
+	        __this_cpu_write(sdei_active_normal_event, NULL);
+	}
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 5d0f1b1966fc..9f998e6bff95 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -60,7 +60,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	rom->data.type	= SETUP_PCI;
 	rom->data.len	= size - sizeof(struct setup_data);
 	rom->data.next	= 0;
-	rom->pcilen	= pci->romsize;
+	rom->pcilen	= romsize;
 	*__rom = rom;
 
 	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 2854b56f6e0b..ed27ff2e503e 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -292,6 +292,8 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip = of_match_device(meson_sm_ids, dev)->data;
+	if (!chip)
+		return -EINVAL;
 
 	if (chip->cmd_shmem_in_base) {
 		fw->sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index f432fe7cb60d..cd0f12b2b386 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -623,7 +623,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 87edc77260d2..db0519da0f89 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -445,6 +445,8 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	usleep_range(900, 1000);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
+	usleep_range(900, 1000);
+	opb_writel(aspeed, ctrl_base + FSI_MRESP0, cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
 	mutex_unlock(&aspeed->lock);
 
 	return count;
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 70c03e304d6c..42f908025985 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1440,3 +1440,4 @@ static struct platform_driver fsi_master_acf = {
 
 module_platform_driver(fsi_master_acf);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE_NAME);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8bd887fb6e63..f0db9724ca85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1091,6 +1091,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	u16 cmd;
 	int r;
 
+	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		return 0;
+
 	/* Bypass for VF */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 917b94002f4b..93a4b52f4a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -505,6 +505,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 			crtc = (struct drm_crtc *)minfo->crtcs[i];
 			if (crtc && crtc->base.id == info->mode_crtc.id) {
 				struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+
 				ui32 = amdgpu_crtc->crtc_id;
 				found = 1;
 				break;
@@ -523,7 +524,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		if (ret)
 			return ret;
 
-		ret = copy_to_user(out, &ip, min((size_t)size, sizeof(ip)));
+		ret = copy_to_user(out, &ip, min_t(size_t, size, sizeof(ip)));
 		return ret ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_HW_IP_COUNT: {
@@ -671,17 +672,18 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
-		unsigned n, alloc_size;
+		unsigned int n, alloc_size;
 		uint32_t *regs;
-		unsigned se_num = (info->read_mmr_reg.instance >>
+		unsigned int se_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SE_INDEX_MASK;
-		unsigned sh_num = (info->read_mmr_reg.instance >>
+		unsigned int sh_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
 
 		/* set full masks if the userspace set all bits
-		 * in the bitfields */
+		 * in the bitfields
+		 */
 		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
 			se_num = 0xffffffff;
 		else if (se_num >= AMDGPU_GFX_MAX_SE)
@@ -799,7 +801,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 				    min((size_t)size, sizeof(dev_info))) ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_VCE_CLOCK_TABLE: {
-		unsigned i;
+		unsigned int i;
 		struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
 		struct amd_vce_state *vce_state;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 5442df094102..453464914f35 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1509,17 +1509,8 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(ixPCIE_LC_STATUS1);
 			max_lw = (tmp & PCIE_LC_STATUS1__LC_DETECTED_LINK_WIDTH_MASK) >>
@@ -1572,21 +1563,14 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 				msleep(100);
 
 				/* linkctl */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(adev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(adev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e5e336fd9e94..b7e1201d46f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2159,17 +2159,8 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(adev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(adev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(adev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -2214,21 +2205,14 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 
 				mdelay(100);
 
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(adev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(adev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(adev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
 							  &tmp16);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index e33fe0207b9e..53e8defd3475 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1682,10 +1682,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			hws->funcs.edp_backlight_control(edp_link_with_sink, false);
 		}
 		/*resume from S3, no vbios posting, no need to power down again*/
+		clk_mgr_exit_optimized_pwr_state(dc, dc->clk_mgr);
+
 		power_down_all_hw_blocks(dc);
 		disable_vga_and_power_gate_all_controllers(dc);
 		if (edp_link_with_sink && !keep_edp_vdd_on)
 			dc->hwss.edp_power_control(edp_link_with_sink, false);
+		clk_mgr_optimize_pwr_state(dc, dc->clk_mgr);
 	}
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 855682590c1b..fd08177de595 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -206,8 +206,9 @@ struct mpcc *mpc1_insert_plane(
 		/* check insert_above_mpcc exist in tree->opp_list */
 		struct mpcc *temp_mpcc = tree->opp_list;
 
-		while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
-			temp_mpcc = temp_mpcc->mpcc_bot;
+		if (temp_mpcc != insert_above_mpcc)
+			while (temp_mpcc && temp_mpcc->mpcc_bot != insert_above_mpcc)
+				temp_mpcc = temp_mpcc->mpcc_bot;
 		if (temp_mpcc == NULL)
 			return NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index d988533d4af5..627d578175cf 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -327,7 +327,9 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		 *  - Delta for CEIL: delta_from_mid_point_in_us_1
 		 *  - Delta for FLOOR: delta_from_mid_point_in_us_2
 		 */
-		if ((last_render_time_in_us / mid_point_frames_ceil) < in_out_vrr->min_duration_in_us) {
+		if (mid_point_frames_ceil &&
+		    (last_render_time_in_us / mid_point_frames_ceil) <
+		    in_out_vrr->min_duration_in_us) {
 			/* Check for out of range.
 			 * If using CEIL produces a value that is out of range,
 			 * then we are forced to use FLOOR.
@@ -374,8 +376,9 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 		/* Either we've calculated the number of frames to insert,
 		 * or we need to insert min duration frames
 		 */
-		if (last_render_time_in_us / frames_to_insert <
-				in_out_vrr->min_duration_in_us){
+		if (frames_to_insert &&
+		    (last_render_time_in_us / frames_to_insert) <
+		    in_out_vrr->min_duration_in_us){
 			frames_to_insert -= (frames_to_insert > 1) ?
 					1 : 0;
 		}
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5abb68017f6e..d58a59cf4f85 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2115,15 +2115,19 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
 				     uint32_t mask, struct list_head *attr_list)
 {
 	int ret = 0;
-	struct device_attribute *dev_attr = &attr->dev_attr;
-	const char *name = dev_attr->attr.name;
 	enum amdgpu_device_attr_states attr_states = ATTR_STATE_SUPPORTED;
 	struct amdgpu_device_attr_entry *attr_entry;
+	struct device_attribute *dev_attr;
+	const char *name;
 
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			   uint32_t mask, enum amdgpu_device_attr_states *states) = default_attr_update;
 
-	BUG_ON(!attr);
+	if (!attr)
+		return -EINVAL;
+
+	dev_attr = &attr->dev_attr;
+	name = dev_attr->attr.name;
 
 	attr_update = attr->attr_update ? attr_update : default_attr_update;
 
diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 30e01101f59e..7ee4c90d4a2d 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -4,6 +4,8 @@
  *  Rewritten from the dovefb driver, and Armada510 manuals.
  */
 
+#include <linux/bitfield.h>
+
 #include <drm/armada_drm.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -446,8 +448,8 @@ static int armada_overlay_get_property(struct drm_plane *plane,
 			     drm_to_overlay_state(state)->colorkey_ug,
 			     drm_to_overlay_state(state)->colorkey_vb, 0);
 	} else if (property == priv->colorkey_mode_prop) {
-		*val = (drm_to_overlay_state(state)->colorkey_mode &
-			CFG_CKMODE_MASK) >> ffs(CFG_CKMODE_MASK);
+		*val = FIELD_GET(CFG_CKMODE_MASK,
+				 drm_to_overlay_state(state)->colorkey_mode);
 	} else if (property == priv->brightness_prop) {
 		*val = drm_to_overlay_state(state)->brightness + 256;
 	} else if (property == priv->contrast_prop) {
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index 8902c2f84bf9..1bc05bf0f232 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -290,7 +290,7 @@ static void ast_init_dram_reg(struct drm_device *dev)
 				;
 			} while (ast_read32(ast, 0x10100) != 0xa8);
 		} else {/* AST2100/1100 */
-			if (ast->chip == AST2100 || ast->chip == 2200)
+			if (ast->chip == AST2100 || ast->chip == AST2200)
 				dram_reg_info = ast2100_dram_table_data;
 			else
 				dram_reg_info = ast1100_dram_table_data;
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 6ba860a16e96..e50c741cbfe7 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511,
 	else
 		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
 
-	regmap_update_bits(adv7511->regmap, 0xfb,
-		0x6, low_refresh_rate << 1);
+	if (adv7511->type == ADV7511)
+		regmap_update_bits(adv7511->regmap, 0xfb,
+				   0x6, low_refresh_rate << 1);
+	else
+		regmap_update_bits(adv7511->regmap, 0x4a,
+				   0xc, low_refresh_rate << 2);
+
 	regmap_update_bits(adv7511->regmap, 0x17,
 		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
 
diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index d89394bc5aa4..ea1445e09e6f 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -180,7 +180,7 @@ static void tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)
 	if (ret >= 0)
 		le32_to_cpus(val);
 
-	dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
+	dev_dbg(ctx->dev, "read: addr=0x%04x data=0x%08x\n", addr, *val);
 }
 
 static void tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
index 706af0304ca4..7b57d01ba865 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -125,9 +125,9 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *submit)
 		return;
 	etnaviv_dump_core = false;
 
-	mutex_lock(&gpu->mmu_context->lock);
+	mutex_lock(&submit->mmu_context->lock);
 
-	mmu_size = etnaviv_iommu_dump_size(gpu->mmu_context);
+	mmu_size = etnaviv_iommu_dump_size(submit->mmu_context);
 
 	/* We always dump registers, mmu, ring, hanging cmdbuf and end marker */
 	n_obj = 5;
@@ -157,7 +157,7 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *submit)
 	iter.start = __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN |
 			__GFP_NORETRY);
 	if (!iter.start) {
-		mutex_unlock(&gpu->mmu_context->lock);
+		mutex_unlock(&submit->mmu_context->lock);
 		dev_warn(gpu->dev, "failed to allocate devcoredump file\n");
 		return;
 	}
@@ -169,18 +169,18 @@ void etnaviv_core_dump(struct etnaviv_gem_submit *submit)
 	memset(iter.hdr, 0, iter.data - iter.start);
 
 	etnaviv_core_dump_registers(&iter, gpu);
-	etnaviv_core_dump_mmu(&iter, gpu->mmu_context, mmu_size);
+	etnaviv_core_dump_mmu(&iter, submit->mmu_context, mmu_size);
 	etnaviv_core_dump_mem(&iter, ETDUMP_BUF_RING, gpu->buffer.vaddr,
 			      gpu->buffer.size,
 			      etnaviv_cmdbuf_get_va(&gpu->buffer,
-					&gpu->mmu_context->cmdbuf_mapping));
+					&submit->mmu_context->cmdbuf_mapping));
 
 	etnaviv_core_dump_mem(&iter, ETDUMP_BUF_CMD,
 			      submit->cmdbuf.vaddr, submit->cmdbuf.size,
 			      etnaviv_cmdbuf_get_va(&submit->cmdbuf,
-					&gpu->mmu_context->cmdbuf_mapping));
+					&submit->mmu_context->cmdbuf_mapping));
 
-	mutex_unlock(&gpu->mmu_context->lock);
+	mutex_unlock(&submit->mmu_context->lock);
 
 	/* Reserve space for the bomap */
 	if (n_bomap_pages) {
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 0201f9b5f87e..0d31a0db305d 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -636,9 +636,18 @@ static void ggtt_set_host_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
 	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	unsigned long offset = index;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_GGTT);
 
+	if (vgpu_gmadr_is_aperture(mm->vgpu, index << I915_GTT_PAGE_SHIFT)) {
+		offset -= (vgpu_aperture_gmadr_base(mm->vgpu) >> PAGE_SHIFT);
+		mm->ggtt_mm.host_ggtt_aperture[offset] = entry->val64;
+	} else if (vgpu_gmadr_is_hidden(mm->vgpu, index << I915_GTT_PAGE_SHIFT)) {
+		offset -= (vgpu_hidden_gmadr_base(mm->vgpu) >> PAGE_SHIFT);
+		mm->ggtt_mm.host_ggtt_hidden[offset] = entry->val64;
+	}
+
 	pte_ops->set_entry(NULL, entry, index, false, 0, mm->vgpu);
 }
 
@@ -1953,6 +1962,21 @@ static struct intel_vgpu_mm *intel_vgpu_create_ggtt_mm(struct intel_vgpu *vgpu)
 		return ERR_PTR(-ENOMEM);
 	}
 
+	mm->ggtt_mm.host_ggtt_aperture = vzalloc((vgpu_aperture_sz(vgpu) >> PAGE_SHIFT) * sizeof(u64));
+	if (!mm->ggtt_mm.host_ggtt_aperture) {
+		vfree(mm->ggtt_mm.virtual_ggtt);
+		vgpu_free_mm(mm);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mm->ggtt_mm.host_ggtt_hidden = vzalloc((vgpu_hidden_sz(vgpu) >> PAGE_SHIFT) * sizeof(u64));
+	if (!mm->ggtt_mm.host_ggtt_hidden) {
+		vfree(mm->ggtt_mm.host_ggtt_aperture);
+		vfree(mm->ggtt_mm.virtual_ggtt);
+		vgpu_free_mm(mm);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	return mm;
 }
 
@@ -1980,6 +2004,8 @@ void _intel_vgpu_mm_release(struct kref *mm_ref)
 		invalidate_ppgtt_mm(mm);
 	} else {
 		vfree(mm->ggtt_mm.virtual_ggtt);
+		vfree(mm->ggtt_mm.host_ggtt_aperture);
+		vfree(mm->ggtt_mm.host_ggtt_hidden);
 	}
 
 	vgpu_free_mm(mm);
@@ -2845,19 +2871,39 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old)
 }
 
 /**
- * intel_vgpu_reset_gtt - reset the all GTT related status
- * @vgpu: a vGPU
+ * intel_gvt_restore_ggtt - restore all vGPU's ggtt entries
+ * @gvt: intel gvt device
  *
- * This function is called from vfio core to reset reset all
- * GTT related status, including GGTT, PPGTT, scratch page.
+ * This function is called at driver resume stage to restore
+ * GGTT entries of every vGPU.
  *
  */
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu)
+void intel_gvt_restore_ggtt(struct intel_gvt *gvt)
 {
-	/* Shadow pages are only created when there is no page
-	 * table tracking data, so remove page tracking data after
-	 * removing the shadow pages.
-	 */
-	intel_vgpu_destroy_all_ppgtt_mm(vgpu);
-	intel_vgpu_reset_ggtt(vgpu, true);
+	struct intel_vgpu *vgpu;
+	struct intel_vgpu_mm *mm;
+	int id;
+	gen8_pte_t pte;
+	u32 idx, num_low, num_hi, offset;
+
+	/* Restore dirty host ggtt for all vGPUs */
+	idr_for_each_entry(&(gvt)->vgpu_idr, vgpu, id) {
+		mm = vgpu->gtt.ggtt_mm;
+
+		num_low = vgpu_aperture_sz(vgpu) >> PAGE_SHIFT;
+		offset = vgpu_aperture_gmadr_base(vgpu) >> PAGE_SHIFT;
+		for (idx = 0; idx < num_low; idx++) {
+			pte = mm->ggtt_mm.host_ggtt_aperture[idx];
+			if (pte & _PAGE_PRESENT)
+				write_pte64(vgpu->gvt->gt->ggtt, offset + idx, pte);
+		}
+
+		num_hi = vgpu_hidden_sz(vgpu) >> PAGE_SHIFT;
+		offset = vgpu_hidden_gmadr_base(vgpu) >> PAGE_SHIFT;
+		for (idx = 0; idx < num_hi; idx++) {
+			pte = mm->ggtt_mm.host_ggtt_hidden[idx];
+			if (pte & _PAGE_PRESENT)
+				write_pte64(vgpu->gvt->gt->ggtt, offset + idx, pte);
+		}
+	}
 }
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index 52d0d88abd86..89ffb52cafa0 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -164,6 +164,9 @@ struct intel_vgpu_mm {
 		} ppgtt_mm;
 		struct {
 			void *virtual_ggtt;
+			/* Save/restore for PM */
+			u64 *host_ggtt_aperture;
+			u64 *host_ggtt_hidden;
 			struct list_head partial_pte_list;
 		} ggtt_mm;
 	};
@@ -212,7 +215,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old);
 void intel_vgpu_invalidate_ppgtt(struct intel_vgpu *vgpu);
 
 int intel_gvt_init_gtt(struct intel_gvt *gvt);
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu);
 void intel_gvt_clean_gtt(struct intel_gvt *gvt);
 
 struct intel_vgpu_mm *intel_gvt_find_ppgtt_mm(struct intel_vgpu *vgpu,
@@ -280,5 +282,6 @@ int intel_vgpu_emulate_ggtt_mmio_write(struct intel_vgpu *vgpu,
 	unsigned int off, void *p_data, unsigned int bytes);
 
 void intel_vgpu_destroy_all_ppgtt_mm(struct intel_vgpu *vgpu);
+void intel_gvt_restore_ggtt(struct intel_gvt *gvt);
 
 #endif /* _GVT_GTT_H_ */
diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 5c9ef8e58a08..87f22a88925c 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -405,6 +405,15 @@ int intel_gvt_init_device(struct drm_i915_private *i915)
 	return ret;
 }
 
+int
+intel_gvt_pm_resume(struct intel_gvt *gvt)
+{
+	intel_gvt_restore_fence(gvt);
+	intel_gvt_restore_mmio(gvt);
+	intel_gvt_restore_ggtt(gvt);
+	return 0;
+}
+
 int
 intel_gvt_register_hypervisor(struct intel_gvt_mpt *m)
 {
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index a81cf0f01e78..b3d6355dd797 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -255,6 +255,8 @@ struct intel_gvt_mmio {
 #define F_CMD_ACCESS	(1 << 3)
 /* This reg has been accessed by a VM */
 #define F_ACCESSED	(1 << 4)
+/* This reg requires save & restore during host PM suspend/resume */
+#define F_PM_SAVE	(1 << 5)
 /* This reg could be accessed by unaligned address */
 #define F_UNALIGN	(1 << 6)
 /* This reg is in GVT's mmio save-restor list and in hardware
@@ -685,6 +687,7 @@ void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_debugfs_init(struct intel_gvt *gvt);
 void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
 
+int intel_gvt_pm_resume(struct intel_gvt *gvt);
 
 #include "trace.h"
 #include "mpt.h"
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index 606e6c315fe2..55ce7aaabf89 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -3135,9 +3135,10 @@ static int init_skl_mmio_info(struct intel_gvt *gvt)
 	MMIO_DFH(TRVATTL3PTRDW(2), D_SKL_PLUS, F_CMD_ACCESS, NULL, NULL);
 	MMIO_DFH(TRVATTL3PTRDW(3), D_SKL_PLUS, F_CMD_ACCESS, NULL, NULL);
 	MMIO_DFH(TRVADR, D_SKL_PLUS, F_CMD_ACCESS, NULL, NULL);
-	MMIO_DFH(TRTTE, D_SKL_PLUS, F_CMD_ACCESS,
-		NULL, gen9_trtte_write);
-	MMIO_DH(_MMIO(0x4dfc), D_SKL_PLUS, NULL, gen9_trtt_chicken_write);
+	MMIO_DFH(TRTTE, D_SKL_PLUS, F_CMD_ACCESS | F_PM_SAVE,
+		 NULL, gen9_trtte_write);
+	MMIO_DFH(_MMIO(0x4dfc), D_SKL_PLUS, F_PM_SAVE,
+		 NULL, gen9_trtt_chicken_write);
 
 	MMIO_D(_MMIO(0x46430), D_SKL_PLUS);
 
@@ -3686,3 +3687,40 @@ int intel_vgpu_mmio_reg_rw(struct intel_vgpu *vgpu, unsigned int offset,
 		intel_vgpu_default_mmio_read(vgpu, offset, pdata, bytes) :
 		intel_vgpu_default_mmio_write(vgpu, offset, pdata, bytes);
 }
+
+void intel_gvt_restore_fence(struct intel_gvt *gvt)
+{
+	struct intel_vgpu *vgpu;
+	int i, id;
+
+	idr_for_each_entry(&(gvt)->vgpu_idr, vgpu, id) {
+		mmio_hw_access_pre(gvt->gt);
+		for (i = 0; i < vgpu_fence_sz(vgpu); i++)
+			intel_vgpu_write_fence(vgpu, i, vgpu_vreg64(vgpu, fence_num_to_offset(i)));
+		mmio_hw_access_post(gvt->gt);
+	}
+}
+
+static inline int mmio_pm_restore_handler(struct intel_gvt *gvt,
+					  u32 offset, void *data)
+{
+	struct intel_vgpu *vgpu = data;
+	struct drm_i915_private *dev_priv = gvt->gt->i915;
+
+	if (gvt->mmio.mmio_attribute[offset >> 2] & F_PM_SAVE)
+		I915_WRITE(_MMIO(offset), vgpu_vreg(vgpu, offset));
+
+	return 0;
+}
+
+void intel_gvt_restore_mmio(struct intel_gvt *gvt)
+{
+	struct intel_vgpu *vgpu;
+	int id;
+
+	idr_for_each_entry(&(gvt)->vgpu_idr, vgpu, id) {
+		mmio_hw_access_pre(gvt->gt);
+		intel_gvt_for_each_tracked_mmio(gvt, mmio_pm_restore_handler, vgpu);
+		mmio_hw_access_post(gvt->gt);
+	}
+}
diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/mmio.h
index cc4812648bf4..9e862dc73579 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.h
+++ b/drivers/gpu/drm/i915/gvt/mmio.h
@@ -104,4 +104,8 @@ int intel_vgpu_mmio_reg_rw(struct intel_vgpu *vgpu, unsigned int offset,
 
 int intel_vgpu_mask_mmio_write(struct intel_vgpu *vgpu, unsigned int offset,
 				  void *p_data, unsigned int bytes);
+
+void intel_gvt_restore_fence(struct intel_gvt *gvt);
+void intel_gvt_restore_mmio(struct intel_gvt *gvt);
+
 #endif
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 99fe8aef1c67..4e70c1a9ef2e 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -24,6 +24,7 @@
 #include "i915_drv.h"
 #include "i915_vgpu.h"
 #include "intel_gvt.h"
+#include "gvt/gvt.h"
 
 /**
  * DOC: Intel GVT-g host support
@@ -147,3 +148,17 @@ void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 
 	intel_gvt_clean_device(dev_priv);
 }
+
+/**
+ * intel_gvt_resume - GVT resume routine wapper
+ *
+ * @dev_priv: drm i915 private *
+ *
+ * This function is called at the i915 driver resume stage to restore required
+ * HW status for GVT so that vGPU can continue running after resumed.
+ */
+void intel_gvt_resume(struct drm_i915_private *dev_priv)
+{
+	if (intel_gvt_active(dev_priv))
+		intel_gvt_pm_resume(dev_priv->gvt);
+}
diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/intel_gvt.h
index 502fad8a8652..d7d3fb6186fd 100644
--- a/drivers/gpu/drm/i915/intel_gvt.h
+++ b/drivers/gpu/drm/i915/intel_gvt.h
@@ -33,6 +33,7 @@ int intel_gvt_init_device(struct drm_i915_private *dev_priv);
 void intel_gvt_clean_device(struct drm_i915_private *dev_priv);
 int intel_gvt_init_host(void);
 void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
+void intel_gvt_resume(struct drm_i915_private *dev_priv);
 #else
 static inline int intel_gvt_init(struct drm_i915_private *dev_priv)
 {
@@ -46,6 +47,10 @@ static inline void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 static inline void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
 {
 }
+
+static inline void intel_gvt_resume(struct drm_i915_private *dev_priv)
+{
+}
 #endif
 
 #endif /* _INTEL_GVT_H_ */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 29702dd8631d..fe64bf2176f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -249,7 +249,11 @@ void *mtk_drm_gem_prime_vmap(struct drm_gem_object *obj)
 
 	mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
 			       pgprot_writecombine(PAGE_KERNEL));
-
+	if (!mtk_gem->kvaddr) {
+		kfree(sgt);
+		kfree(mtk_gem->pages);
+		return -ENOMEM;
+	}
 out:
 	kfree(sgt);
 
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index 7e82c41a85f1..64ee63dcdb7c 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -521,6 +521,10 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	gpu->perfcntrs = perfcntrs;
 	gpu->num_perfcntrs = ARRAY_SIZE(perfcntrs);
 
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
+	if (ret)
+		goto fail;
+
 	if (adreno_is_a20x(adreno_gpu))
 		adreno_gpu->registers = a200_registers;
 	else if (adreno_is_a225(adreno_gpu))
@@ -528,10 +532,6 @@ struct msm_gpu *a2xx_gpu_init(struct drm_device *dev)
 	else
 		adreno_gpu->registers = a220_registers;
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, &funcs, 1);
-	if (ret)
-		goto fail;
-
 	if (!gpu->aspace) {
 		dev_err(dev->dev, "No memory protection without MMU\n");
 		ret = -ENXIO;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 0dc23c86747e..e1c1b4ad5ed0 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -221,8 +221,7 @@ static void mdp5_plane_destroy_state(struct drm_plane *plane,
 {
 	struct mdp5_plane_state *pstate = to_mdp5_plane_state(state);
 
-	if (state->fb)
-		drm_framebuffer_put(state->fb);
+	__drm_atomic_helper_plane_destroy_state(state);
 
 	kfree(pstate);
 }
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e40321d79898..e90b51811888 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1200,7 +1200,9 @@ static const struct panel_desc auo_t215hvn01 = {
 	.delay = {
 		.disable = 5,
 		.unprepare = 1000,
-	}
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 static const struct drm_display_mode avic_tm070ddh03_mode = {
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 5c42877fd6fb..13f25ec1fe25 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9551,17 +9551,8 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(rdev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE_PORT(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -9608,21 +9599,14 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
 				msleep(100);
 
 				/* linkctl */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root, PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(rdev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(rdev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 93dcab548a83..31e2c1083b08 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7138,17 +7138,8 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 			u16 bridge_cfg2, gpu_cfg2;
 			u32 max_lw, current_lw, tmp;
 
-			pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-						  &bridge_cfg);
-			pcie_capability_read_word(rdev->pdev, PCI_EXP_LNKCTL,
-						  &gpu_cfg);
-
-			tmp16 = bridge_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(root, PCI_EXP_LNKCTL, tmp16);
-
-			tmp16 = gpu_cfg | PCI_EXP_LNKCTL_HAWD;
-			pcie_capability_write_word(rdev->pdev, PCI_EXP_LNKCTL,
-						   tmp16);
+			pcie_capability_set_word(root, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
+			pcie_capability_set_word(rdev->pdev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_HAWD);
 
 			tmp = RREG32_PCIE(PCIE_LC_STATUS1);
 			max_lw = (tmp & LC_DETECTED_LINK_WIDTH_MASK) >> LC_DETECTED_LINK_WIDTH_SHIFT;
@@ -7195,22 +7186,14 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
 				msleep(100);
 
 				/* linkctl */
-				pcie_capability_read_word(root, PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (bridge_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(root,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
-
-				pcie_capability_read_word(rdev->pdev,
-							  PCI_EXP_LNKCTL,
-							  &tmp16);
-				tmp16 &= ~PCI_EXP_LNKCTL_HAWD;
-				tmp16 |= (gpu_cfg & PCI_EXP_LNKCTL_HAWD);
-				pcie_capability_write_word(rdev->pdev,
-							   PCI_EXP_LNKCTL,
-							   tmp16);
+				pcie_capability_clear_and_set_word(root, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   bridge_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
+				pcie_capability_clear_and_set_word(rdev->pdev, PCI_EXP_LNKCTL,
+								   PCI_EXP_LNKCTL_HAWD,
+								   gpu_cfg &
+								   PCI_EXP_LNKCTL_HAWD);
 
 				/* linkctl2 */
 				pcie_capability_read_word(root, PCI_EXP_LNKCTL2,
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 105fb9cdbb3b..f8b8107368a0 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -467,10 +467,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 		return PTR_ERR(dpaux->regs);
 
 	dpaux->irq = platform_get_irq(pdev, 0);
-	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
-		return -ENXIO;
-	}
+	if (dpaux->irq < 0)
+		return dpaux->irq;
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 8e69303aad3f..5f6eea81f3cc 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -214,7 +214,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	dpsub->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dpsub);
 
-	dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
+	ret = dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
+	if (ret)
+		return ret;
 
 	/* Try the reserved memory. Proceed if there's none. */
 	of_reserved_mem_device_init(&pdev->dev);
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 587259b3db97..f4d79ec82679 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1217,6 +1217,9 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 		 * 50 msec should gives enough time to the receiver to be ready.
 		 */
 		msleep(50);
+
+		if (retval)
+			return retval;
 	}
 
 	/*
@@ -1238,7 +1241,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 	buf[5] = 0x09;
 	buf[6] = 0x00;
 
-	hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
+	retval = hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
 			HIDPP_REPORT_SHORT_LENGTH, HID_OUTPUT_REPORT,
 			HID_REQ_SET_REPORT);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ea8c52f0aa78..dc7c33f6b2c4 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1541,7 +1541,6 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	char *name;
 	const char *suffix = NULL;
 	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
@@ -1595,15 +1594,9 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		break;
 	}
 
-	if (suffix) {
-		name = devm_kzalloc(&hi->input->dev,
-				    strlen(hdev->name) + strlen(suffix) + 2,
-				    GFP_KERNEL);
-		if (name) {
-			sprintf(name, "%s %s", hdev->name, suffix);
-			hi->input->name = name;
-		}
-	}
+	if (suffix)
+		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+						 "%s %s", hdev->name, suffix);
 
 	return 0;
 }
diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 3f8b24a57014..c034a1e850e4 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -153,6 +153,7 @@ struct wacom_remote {
 		struct input_dev *input;
 		bool registered;
 		struct wacom_battery battery;
+		ktime_t active_time;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 36cb456709ed..1a7e1d3e7a37 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2529,6 +2529,18 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 }
 
+static void wacom_remote_destroy_battery(struct wacom *wacom, int index)
+{
+	struct wacom_remote *remote = wacom->remote;
+
+	if (remote->remotes[index].battery.battery) {
+		devres_release_group(&wacom->hdev->dev,
+				     &remote->remotes[index].battery.bat_desc);
+		remote->remotes[index].battery.battery = NULL;
+		remote->remotes[index].active_time = 0;
+	}
+}
+
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 {
 	struct wacom_remote *remote = wacom->remote;
@@ -2543,9 +2555,7 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 			remote->remotes[i].registered = false;
 			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-			if (remote->remotes[i].battery.battery)
-				devres_release_group(&wacom->hdev->dev,
-						     &remote->remotes[i].battery.bat_desc);
+			wacom_remote_destroy_battery(wacom, i);
 
 			if (remote->remotes[i].group.name)
 				devres_release_group(&wacom->hdev->dev,
@@ -2553,7 +2563,6 @@ static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
 
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
 	}
@@ -2638,6 +2647,9 @@ static int wacom_remote_attach_battery(struct wacom *wacom, int index)
 	if (remote->remotes[index].battery.battery)
 		return 0;
 
+	if (!remote->remotes[index].active_time)
+		return 0;
+
 	if (wacom->led.groups[index].select == WACOM_STATUS_UNKNOWN)
 		return 0;
 
@@ -2653,6 +2665,7 @@ static void wacom_remote_work(struct work_struct *work)
 {
 	struct wacom *wacom = container_of(work, struct wacom, remote_work);
 	struct wacom_remote *remote = wacom->remote;
+	ktime_t kt = ktime_get();
 	struct wacom_remote_data data;
 	unsigned long flags;
 	unsigned int count;
@@ -2679,6 +2692,10 @@ static void wacom_remote_work(struct work_struct *work)
 		serial = data.remote[i].serial;
 		if (data.remote[i].connected) {
 
+			if (kt - remote->remotes[i].active_time > WACOM_REMOTE_BATTERY_TIMEOUT
+			    && remote->remotes[i].active_time != 0)
+				wacom_remote_destroy_battery(wacom, i);
+
 			if (remote->remotes[i].serial == serial) {
 				wacom_remote_attach_battery(wacom, i);
 				continue;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index de6fe9866870..1b5e5e9f577d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1127,6 +1127,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	if (index < 0 || !remote->remotes[index].registered)
 		goto out;
 
+	remote->remotes[i].active_time = ktime_get();
 	input = remote->remotes[index].input;
 
 	input_report_key(input, BTN_0, (data[9] & 0x01));
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 166731292c35..d393f96626fb 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -15,6 +15,7 @@
 #define WACOM_NAME_MAX		64
 #define WACOM_MAX_REMOTES	5
 #define WACOM_STATUS_UNKNOWN	255
+#define WACOM_REMOTE_BATTERY_TIMEOUT	21000000000ll
 
 /* packet length for individual models */
 #define WACOM_PKGLEN_BBFUN	 9
diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 7d5f7441aceb..b9a93ee9c236 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -434,7 +434,7 @@ static umode_t tmp51x_is_visible(const void *_data,
 
 	switch (type) {
 	case hwmon_temp:
-		if (data->id == tmp512 && channel == 4)
+		if (data->id == tmp512 && channel == 3)
 			return 0;
 		switch (attr) {
 		case hwmon_temp_input:
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 8978f3410bee..eee069e95b9f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -426,7 +426,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 		return -EINVAL;
 
 	/* wrap head around to the amount of space we have */
-	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+	head = handle->head & (((unsigned long)buf->nr_pages << PAGE_SHIFT) - 1);
 
 	/* find the page to write to */
 	buf->cur = head / PAGE_SIZE;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 3e74f5aed20d..ae2dd0c88f4e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -47,7 +47,8 @@ struct etr_perf_buffer {
 };
 
 /* Convert the perf index to an offset within the ETR buffer */
-#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf)		\
+		((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /* Lower limit for ETR hardware buffer */
 #define TMC_ETR_PERF_MIN_BUF_SIZE	SZ_1M
@@ -1232,7 +1233,7 @@ alloc_etr_buf(struct tmc_drvdata *drvdata, struct perf_event *event,
 	 * than the size requested via sysfs.
 	 */
 	if ((nr_pages << PAGE_SHIFT) > drvdata->size) {
-		etr_buf = tmc_alloc_etr_buf(drvdata, (nr_pages << PAGE_SHIFT),
+		etr_buf = tmc_alloc_etr_buf(drvdata, ((ssize_t)nr_pages << PAGE_SHIFT),
 					    0, node, NULL);
 		if (!IS_ERR(etr_buf))
 			goto done;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index b91ec7dde7bc..3655b3bfb2e3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -321,7 +321,7 @@ ssize_t tmc_sg_table_get_data(struct tmc_sg_table *sg_table,
 static inline unsigned long
 tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 {
-	return sg_table->data_pages.nr_pages << PAGE_SHIFT;
+	return (unsigned long)sg_table->data_pages.nr_pages << PAGE_SHIFT;
 }
 
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index b3c6c066b601..c61b10fbf90a 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -108,6 +108,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 		return ret;
 
 	uattr = uverbs_attr_get(attrs, UVERBS_ATTR_READ_COUNTERS_BUFF);
+	if (IS_ERR(uattr))
+		return PTR_ERR(uattr);
 	read_attr.ncounters = uattr->ptr_attr.len / sizeof(u64);
 	read_attr.counters_buff = uverbs_zalloc(
 		attrs, array_size(read_attr.ncounters, sizeof(u64)));
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index b87ba4c9fccf..de5ab282ac74 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1490,7 +1490,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index d043793ff0f5..1d4e0dc550e4 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1487,7 +1487,7 @@ int siw_map_mr_sg(struct ib_mr *base_mr, struct scatterlist *sl, int num_sle,
 
 	if (pbl->max_buf < num_sle) {
 		siw_dbg_mem(mem, "too many SGE's: %d > %d\n",
-			    mem->pbl->max_buf, num_sle);
+			    num_sle, pbl->max_buf);
 		return -ENOMEM;
 	}
 	for_each_sg(sl, slp, num_sle, i) {
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 7cd90604502e..ed375f517e8a 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2560,6 +2560,8 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
+
+	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsi_conn *conn)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index adbd56af379f..9b9b9557ae74 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1990,12 +1990,8 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 
 		if (unlikely(rsp->flags & SRP_RSP_FLAG_DIUNDER))
 			scsi_set_resid(scmnd, be32_to_cpu(rsp->data_in_res_cnt));
-		else if (unlikely(rsp->flags & SRP_RSP_FLAG_DIOVER))
-			scsi_set_resid(scmnd, -be32_to_cpu(rsp->data_in_res_cnt));
 		else if (unlikely(rsp->flags & SRP_RSP_FLAG_DOUNDER))
 			scsi_set_resid(scmnd, be32_to_cpu(rsp->data_out_res_cnt));
-		else if (unlikely(rsp->flags & SRP_RSP_FLAG_DOOVER))
-			scsi_set_resid(scmnd, -be32_to_cpu(rsp->data_out_res_cnt));
 
 		srp_free_req(ch, req, scmnd,
 			     be32_to_cpu(rsp->req_lim_delta));
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a24390c548a9..37c8f75a3580 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -283,6 +283,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		/* Disable context bank before programming */
+		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+
+		/* Clear context bank fault address fault status registers */
+		iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
+		iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
+
 		/* TTBRs */
 		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
 				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 80d6412e2c54..9b24e8224379 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -187,7 +187,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	device_attach_pasid_table(info, pasid_table);
 
 	if (!ecap_coherent(info->iommu->ecap))
-		clflush_cache_range(pasid_table->table, size);
+		clflush_cache_range(pasid_table->table, (1 << order) * PAGE_SIZE);
 
 	return 0;
 }
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index f843ade442de..b28302836b2e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -2476,11 +2476,35 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 {
 	unsigned long backlog;
 	unsigned long old_mwb = mddev->bitmap_info.max_write_behind;
+	struct md_rdev *rdev;
+	bool has_write_mostly = false;
 	int rv = kstrtoul(buf, 10, &backlog);
 	if (rv)
 		return rv;
 	if (backlog > COUNTER_MAX)
 		return -EINVAL;
+
+	rv = mddev_lock(mddev);
+	if (rv)
+		return rv;
+
+	/*
+	 * Without write mostly device, it doesn't make sense to set
+	 * backlog for max_write_behind.
+	 */
+	rdev_for_each(rdev, mddev) {
+		if (test_bit(WriteMostly, &rdev->flags)) {
+			has_write_mostly = true;
+			break;
+		}
+	}
+	if (!has_write_mostly) {
+		pr_warn_ratelimited("%s: can't set backlog, no write mostly device available\n",
+				    mdname(mddev));
+		mddev_unlock(mddev);
+		return -EINVAL;
+	}
+
 	mddev->bitmap_info.max_write_behind = backlog;
 	if (!backlog && mddev->serial_info_pool) {
 		/* serial_info_pool is not needed if backlog is zero */
@@ -2488,13 +2512,13 @@ backlog_store(struct mddev *mddev, const char *buf, size_t len)
 			mddev_destroy_serial_pool(mddev, NULL, false);
 	} else if (backlog && !mddev->serial_info_pool) {
 		/* serial_info_pool is needed since backlog is not zero */
-		struct md_rdev *rdev;
-
 		rdev_for_each(rdev, mddev)
 			mddev_create_serial_pool(mddev, rdev, false);
 	}
 	if (old_mwb != backlog)
 		md_bitmap_update_sb(mddev->bitmap);
+
+	mddev_unlock(mddev);
 	return len;
 }
 
diff --git a/drivers/media/cec/usb/pulse8/pulse8-cec.c b/drivers/media/cec/usb/pulse8/pulse8-cec.c
index 04b13cdc38d2..ba67587bd43e 100644
--- a/drivers/media/cec/usb/pulse8/pulse8-cec.c
+++ b/drivers/media/cec/usb/pulse8/pulse8-cec.c
@@ -809,8 +809,11 @@ static void pulse8_ping_eeprom_work_handler(struct work_struct *work)
 
 	mutex_lock(&pulse8->lock);
 	cmd = MSGCODE_PING;
-	pulse8_send_and_wait(pulse8, &cmd, 1,
-			     MSGCODE_COMMAND_ACCEPTED, 0);
+	if (pulse8_send_and_wait(pulse8, &cmd, 1,
+				 MSGCODE_COMMAND_ACCEPTED, 0)) {
+		dev_warn(pulse8->dev, "failed to ping EEPROM\n");
+		goto unlock;
+	}
 
 	if (pulse8->vers < 2)
 		goto unlock;
diff --git a/drivers/media/dvb-frontends/ascot2e.c b/drivers/media/dvb-frontends/ascot2e.c
index 9b00b56230b6..cf8e5f1bd101 100644
--- a/drivers/media/dvb-frontends/ascot2e.c
+++ b/drivers/media/dvb-frontends/ascot2e.c
@@ -533,7 +533,7 @@ struct dvb_frontend *ascot2e_attach(struct dvb_frontend *fe,
 		priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(ascot2e_attach);
+EXPORT_SYMBOL_GPL(ascot2e_attach);
 
 MODULE_DESCRIPTION("Sony ASCOT2E terr/cab tuner driver");
 MODULE_AUTHOR("info@netup.ru");
diff --git a/drivers/media/dvb-frontends/atbm8830.c b/drivers/media/dvb-frontends/atbm8830.c
index bdd16b9c5824..778c865085bf 100644
--- a/drivers/media/dvb-frontends/atbm8830.c
+++ b/drivers/media/dvb-frontends/atbm8830.c
@@ -489,7 +489,7 @@ struct dvb_frontend *atbm8830_attach(const struct atbm8830_config *config,
 	return NULL;
 
 }
-EXPORT_SYMBOL(atbm8830_attach);
+EXPORT_SYMBOL_GPL(atbm8830_attach);
 
 MODULE_DESCRIPTION("AltoBeam ATBM8830/8831 GB20600 demodulator driver");
 MODULE_AUTHOR("David T. L. Wong <davidtlwong@gmail.com>");
diff --git a/drivers/media/dvb-frontends/au8522_dig.c b/drivers/media/dvb-frontends/au8522_dig.c
index 78cafdf27961..230436bf6cbd 100644
--- a/drivers/media/dvb-frontends/au8522_dig.c
+++ b/drivers/media/dvb-frontends/au8522_dig.c
@@ -879,7 +879,7 @@ struct dvb_frontend *au8522_attach(const struct au8522_config *config,
 	au8522_release_state(state);
 	return NULL;
 }
-EXPORT_SYMBOL(au8522_attach);
+EXPORT_SYMBOL_GPL(au8522_attach);
 
 static const struct dvb_frontend_ops au8522_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/bcm3510.c b/drivers/media/dvb-frontends/bcm3510.c
index 68b92b4419cf..b3f5c49accaf 100644
--- a/drivers/media/dvb-frontends/bcm3510.c
+++ b/drivers/media/dvb-frontends/bcm3510.c
@@ -835,7 +835,7 @@ struct dvb_frontend* bcm3510_attach(const struct bcm3510_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(bcm3510_attach);
+EXPORT_SYMBOL_GPL(bcm3510_attach);
 
 static const struct dvb_frontend_ops bcm3510_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/cx22700.c b/drivers/media/dvb-frontends/cx22700.c
index b39ff516271b..1d04c0a652b2 100644
--- a/drivers/media/dvb-frontends/cx22700.c
+++ b/drivers/media/dvb-frontends/cx22700.c
@@ -432,4 +432,4 @@ MODULE_DESCRIPTION("Conexant CX22700 DVB-T Demodulator driver");
 MODULE_AUTHOR("Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(cx22700_attach);
+EXPORT_SYMBOL_GPL(cx22700_attach);
diff --git a/drivers/media/dvb-frontends/cx22702.c b/drivers/media/dvb-frontends/cx22702.c
index cc6acbf6393d..61ad34b7004b 100644
--- a/drivers/media/dvb-frontends/cx22702.c
+++ b/drivers/media/dvb-frontends/cx22702.c
@@ -604,7 +604,7 @@ struct dvb_frontend *cx22702_attach(const struct cx22702_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(cx22702_attach);
+EXPORT_SYMBOL_GPL(cx22702_attach);
 
 static const struct dvb_frontend_ops cx22702_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/cx24110.c b/drivers/media/dvb-frontends/cx24110.c
index 6f99d6a27be2..9aeea089756f 100644
--- a/drivers/media/dvb-frontends/cx24110.c
+++ b/drivers/media/dvb-frontends/cx24110.c
@@ -653,4 +653,4 @@ MODULE_DESCRIPTION("Conexant CX24110 DVB-S Demodulator driver");
 MODULE_AUTHOR("Peter Hettkamp");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(cx24110_attach);
+EXPORT_SYMBOL_GPL(cx24110_attach);
diff --git a/drivers/media/dvb-frontends/cx24113.c b/drivers/media/dvb-frontends/cx24113.c
index 60a9f70275f7..619df8329fbb 100644
--- a/drivers/media/dvb-frontends/cx24113.c
+++ b/drivers/media/dvb-frontends/cx24113.c
@@ -590,7 +590,7 @@ struct dvb_frontend *cx24113_attach(struct dvb_frontend *fe,
 
 	return NULL;
 }
-EXPORT_SYMBOL(cx24113_attach);
+EXPORT_SYMBOL_GPL(cx24113_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activates frontend debugging (default:0)");
diff --git a/drivers/media/dvb-frontends/cx24116.c b/drivers/media/dvb-frontends/cx24116.c
index ea8264ccbb4e..8b978a9f74a4 100644
--- a/drivers/media/dvb-frontends/cx24116.c
+++ b/drivers/media/dvb-frontends/cx24116.c
@@ -1133,7 +1133,7 @@ struct dvb_frontend *cx24116_attach(const struct cx24116_config *config,
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
 }
-EXPORT_SYMBOL(cx24116_attach);
+EXPORT_SYMBOL_GPL(cx24116_attach);
 
 /*
  * Initialise or wake up device
diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index 2464b63fe0cf..0fa033633f4c 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -305,7 +305,7 @@ struct dvb_frontend *cx24120_attach(const struct cx24120_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(cx24120_attach);
+EXPORT_SYMBOL_GPL(cx24120_attach);
 
 static int cx24120_test_rom(struct cx24120_state *state)
 {
@@ -972,7 +972,9 @@ static void cx24120_set_clock_ratios(struct dvb_frontend *fe)
 	cmd.arg[8] = (clock_ratios_table[idx].rate >> 8) & 0xff;
 	cmd.arg[9] = (clock_ratios_table[idx].rate >> 0) & 0xff;
 
-	cx24120_message_send(state, &cmd);
+	ret = cx24120_message_send(state, &cmd);
+	if (ret != 0)
+		return;
 
 	/* Calculate ber window rates for stat work */
 	cx24120_calculate_ber_window(state, clock_ratios_table[idx].rate);
diff --git a/drivers/media/dvb-frontends/cx24123.c b/drivers/media/dvb-frontends/cx24123.c
index 3d84ee17e54c..539889e638cc 100644
--- a/drivers/media/dvb-frontends/cx24123.c
+++ b/drivers/media/dvb-frontends/cx24123.c
@@ -1096,7 +1096,7 @@ struct dvb_frontend *cx24123_attach(const struct cx24123_config *config,
 
 	return NULL;
 }
-EXPORT_SYMBOL(cx24123_attach);
+EXPORT_SYMBOL_GPL(cx24123_attach);
 
 static const struct dvb_frontend_ops cx24123_ops = {
 	.delsys = { SYS_DVBS },
diff --git a/drivers/media/dvb-frontends/cxd2820r_core.c b/drivers/media/dvb-frontends/cxd2820r_core.c
index b1618339eec0..b0e6343ea591 100644
--- a/drivers/media/dvb-frontends/cxd2820r_core.c
+++ b/drivers/media/dvb-frontends/cxd2820r_core.c
@@ -536,7 +536,7 @@ struct dvb_frontend *cxd2820r_attach(const struct cxd2820r_config *config,
 
 	return pdata.get_dvb_frontend(client);
 }
-EXPORT_SYMBOL(cxd2820r_attach);
+EXPORT_SYMBOL_GPL(cxd2820r_attach);
 
 static struct dvb_frontend *cxd2820r_get_dvb_frontend(struct i2c_client *client)
 {
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index 758c95bc3b11..493ba8b6b8f6 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -3930,14 +3930,14 @@ struct dvb_frontend *cxd2841er_attach_s(struct cxd2841er_config *cfg,
 {
 	return cxd2841er_attach(cfg, i2c, SYS_DVBS);
 }
-EXPORT_SYMBOL(cxd2841er_attach_s);
+EXPORT_SYMBOL_GPL(cxd2841er_attach_s);
 
 struct dvb_frontend *cxd2841er_attach_t_c(struct cxd2841er_config *cfg,
 					struct i2c_adapter *i2c)
 {
 	return cxd2841er_attach(cfg, i2c, 0);
 }
-EXPORT_SYMBOL(cxd2841er_attach_t_c);
+EXPORT_SYMBOL_GPL(cxd2841er_attach_t_c);
 
 static const struct dvb_frontend_ops cxd2841er_dvbs_s2_ops = {
 	.delsys = { SYS_DVBS, SYS_DVBS2 },
diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
index d5b1b3788e39..09d31c368741 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
@@ -1950,7 +1950,7 @@ struct dvb_frontend *cxd2880_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(cxd2880_attach);
+EXPORT_SYMBOL_GPL(cxd2880_attach);
 
 MODULE_DESCRIPTION("Sony CXD2880 DVB-T2/T tuner + demod driver");
 MODULE_AUTHOR("Sony Semiconductor Solutions Corporation");
diff --git a/drivers/media/dvb-frontends/dib0070.c b/drivers/media/dvb-frontends/dib0070.c
index cafb41dba861..9a8e7cdd2a24 100644
--- a/drivers/media/dvb-frontends/dib0070.c
+++ b/drivers/media/dvb-frontends/dib0070.c
@@ -762,7 +762,7 @@ struct dvb_frontend *dib0070_attach(struct dvb_frontend *fe, struct i2c_adapter
 	fe->tuner_priv = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(dib0070_attach);
+EXPORT_SYMBOL_GPL(dib0070_attach);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@posteo.de>");
 MODULE_DESCRIPTION("Driver for the DiBcom 0070 base-band RF Tuner");
diff --git a/drivers/media/dvb-frontends/dib0090.c b/drivers/media/dvb-frontends/dib0090.c
index 08a85831e917..bb2fc12c114c 100644
--- a/drivers/media/dvb-frontends/dib0090.c
+++ b/drivers/media/dvb-frontends/dib0090.c
@@ -2632,7 +2632,7 @@ struct dvb_frontend *dib0090_register(struct dvb_frontend *fe, struct i2c_adapte
 	return NULL;
 }
 
-EXPORT_SYMBOL(dib0090_register);
+EXPORT_SYMBOL_GPL(dib0090_register);
 
 struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_adapter *i2c, const struct dib0090_config *config)
 {
@@ -2658,7 +2658,7 @@ struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_ada
 	fe->tuner_priv = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(dib0090_fw_register);
+EXPORT_SYMBOL_GPL(dib0090_fw_register);
 
 MODULE_AUTHOR("Patrick Boettcher <patrick.boettcher@posteo.de>");
 MODULE_AUTHOR("Olivier Grenie <olivier.grenie@parrot.com>");
diff --git a/drivers/media/dvb-frontends/dib3000mb.c b/drivers/media/dvb-frontends/dib3000mb.c
index a6c2fc4586eb..c598b2a63325 100644
--- a/drivers/media/dvb-frontends/dib3000mb.c
+++ b/drivers/media/dvb-frontends/dib3000mb.c
@@ -815,4 +815,4 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(dib3000mb_attach);
+EXPORT_SYMBOL_GPL(dib3000mb_attach);
diff --git a/drivers/media/dvb-frontends/dib3000mc.c b/drivers/media/dvb-frontends/dib3000mc.c
index 692600ce5f23..c69665024330 100644
--- a/drivers/media/dvb-frontends/dib3000mc.c
+++ b/drivers/media/dvb-frontends/dib3000mc.c
@@ -935,7 +935,7 @@ struct dvb_frontend * dib3000mc_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr
 	kfree(st);
 	return NULL;
 }
-EXPORT_SYMBOL(dib3000mc_attach);
+EXPORT_SYMBOL_GPL(dib3000mc_attach);
 
 static const struct dvb_frontend_ops dib3000mc_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/dib7000m.c b/drivers/media/dvb-frontends/dib7000m.c
index 97ce97789c9e..fdb22f32e3a1 100644
--- a/drivers/media/dvb-frontends/dib7000m.c
+++ b/drivers/media/dvb-frontends/dib7000m.c
@@ -1434,7 +1434,7 @@ struct dvb_frontend * dib7000m_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr,
 	kfree(st);
 	return NULL;
 }
-EXPORT_SYMBOL(dib7000m_attach);
+EXPORT_SYMBOL_GPL(dib7000m_attach);
 
 static const struct dvb_frontend_ops dib7000m_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index 55bee50aa871..8c426baf76ee 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -497,7 +497,7 @@ static int dib7000p_update_pll(struct dvb_frontend *fe, struct dibx000_bandwidth
 	prediv = reg_1856 & 0x3f;
 	loopdiv = (reg_1856 >> 6) & 0x3f;
 
-	if ((bw != NULL) && (bw->pll_prediv != prediv || bw->pll_ratio != loopdiv)) {
+	if (loopdiv && bw && (bw->pll_prediv != prediv || bw->pll_ratio != loopdiv)) {
 		dprintk("Updating pll (prediv: old =  %d new = %d ; loopdiv : old = %d new = %d)\n", prediv, bw->pll_prediv, loopdiv, bw->pll_ratio);
 		reg_1856 &= 0xf000;
 		reg_1857 = dib7000p_read_word(state, 1857);
@@ -2822,7 +2822,7 @@ void *dib7000p_attach(struct dib7000p_ops *ops)
 
 	return ops;
 }
-EXPORT_SYMBOL(dib7000p_attach);
+EXPORT_SYMBOL_GPL(dib7000p_attach);
 
 static const struct dvb_frontend_ops dib7000p_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index d67f2dd997d0..02cb48223dc6 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -4527,7 +4527,7 @@ void *dib8000_attach(struct dib8000_ops *ops)
 
 	return ops;
 }
-EXPORT_SYMBOL(dib8000_attach);
+EXPORT_SYMBOL_GPL(dib8000_attach);
 
 MODULE_AUTHOR("Olivier Grenie <Olivier.Grenie@parrot.com, Patrick Boettcher <patrick.boettcher@posteo.de>");
 MODULE_DESCRIPTION("Driver for the DiBcom 8000 ISDB-T demodulator");
diff --git a/drivers/media/dvb-frontends/dib9000.c b/drivers/media/dvb-frontends/dib9000.c
index 04d92d614279..24f7f7a7598d 100644
--- a/drivers/media/dvb-frontends/dib9000.c
+++ b/drivers/media/dvb-frontends/dib9000.c
@@ -2546,7 +2546,7 @@ struct dvb_frontend *dib9000_attach(struct i2c_adapter *i2c_adap, u8 i2c_addr, c
 	kfree(st);
 	return NULL;
 }
-EXPORT_SYMBOL(dib9000_attach);
+EXPORT_SYMBOL_GPL(dib9000_attach);
 
 static const struct dvb_frontend_ops dib9000_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/drx39xyj/drxj.c b/drivers/media/dvb-frontends/drx39xyj/drxj.c
index 237b9d04c076..499b37b78dd5 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -12375,7 +12375,7 @@ struct dvb_frontend *drx39xxj_attach(struct i2c_adapter *i2c)
 
 	return NULL;
 }
-EXPORT_SYMBOL(drx39xxj_attach);
+EXPORT_SYMBOL_GPL(drx39xxj_attach);
 
 static const struct dvb_frontend_ops drx39xxj_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
index 45f982863904..e3236adf8402 100644
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -2948,7 +2948,7 @@ struct dvb_frontend *drxd_attach(const struct drxd_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(drxd_attach);
+EXPORT_SYMBOL_GPL(drxd_attach);
 
 MODULE_DESCRIPTION("DRXD driver");
 MODULE_AUTHOR("Micronas");
diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 2134e25096aa..a6b86c181d1c 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -6845,7 +6845,7 @@ struct dvb_frontend *drxk_attach(const struct drxk_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(drxk_attach);
+EXPORT_SYMBOL_GPL(drxk_attach);
 
 MODULE_DESCRIPTION("DRX-K driver");
 MODULE_AUTHOR("Ralph Metzler");
diff --git a/drivers/media/dvb-frontends/ds3000.c b/drivers/media/dvb-frontends/ds3000.c
index 20fcf31af165..515aa7c7baf2 100644
--- a/drivers/media/dvb-frontends/ds3000.c
+++ b/drivers/media/dvb-frontends/ds3000.c
@@ -859,7 +859,7 @@ struct dvb_frontend *ds3000_attach(const struct ds3000_config *config,
 	ds3000_set_voltage(&state->frontend, SEC_VOLTAGE_OFF);
 	return &state->frontend;
 }
-EXPORT_SYMBOL(ds3000_attach);
+EXPORT_SYMBOL_GPL(ds3000_attach);
 
 static int ds3000_set_carrier_offset(struct dvb_frontend *fe,
 					s32 carrier_offset_khz)
diff --git a/drivers/media/dvb-frontends/dvb-pll.c b/drivers/media/dvb-frontends/dvb-pll.c
index d45b4ddc8f91..846bfe7ef30e 100644
--- a/drivers/media/dvb-frontends/dvb-pll.c
+++ b/drivers/media/dvb-frontends/dvb-pll.c
@@ -866,7 +866,7 @@ struct dvb_frontend *dvb_pll_attach(struct dvb_frontend *fe, int pll_addr,
 
 	return NULL;
 }
-EXPORT_SYMBOL(dvb_pll_attach);
+EXPORT_SYMBOL_GPL(dvb_pll_attach);
 
 
 static int
diff --git a/drivers/media/dvb-frontends/ec100.c b/drivers/media/dvb-frontends/ec100.c
index 03bd80666cf8..2ad0a3c2f756 100644
--- a/drivers/media/dvb-frontends/ec100.c
+++ b/drivers/media/dvb-frontends/ec100.c
@@ -299,7 +299,7 @@ struct dvb_frontend *ec100_attach(const struct ec100_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(ec100_attach);
+EXPORT_SYMBOL_GPL(ec100_attach);
 
 static const struct dvb_frontend_ops ec100_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index 8c1310c6b0bc..c299d31dc7d2 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -1025,7 +1025,7 @@ struct dvb_frontend *helene_attach_s(struct dvb_frontend *fe,
 			priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(helene_attach_s);
+EXPORT_SYMBOL_GPL(helene_attach_s);
 
 struct dvb_frontend *helene_attach(struct dvb_frontend *fe,
 		const struct helene_config *config,
@@ -1061,7 +1061,7 @@ struct dvb_frontend *helene_attach(struct dvb_frontend *fe,
 			priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(helene_attach);
+EXPORT_SYMBOL_GPL(helene_attach);
 
 static int helene_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
diff --git a/drivers/media/dvb-frontends/horus3a.c b/drivers/media/dvb-frontends/horus3a.c
index 24bf5cbcc184..0330b78a5b3f 100644
--- a/drivers/media/dvb-frontends/horus3a.c
+++ b/drivers/media/dvb-frontends/horus3a.c
@@ -395,7 +395,7 @@ struct dvb_frontend *horus3a_attach(struct dvb_frontend *fe,
 		priv->i2c_address, priv->i2c);
 	return fe;
 }
-EXPORT_SYMBOL(horus3a_attach);
+EXPORT_SYMBOL_GPL(horus3a_attach);
 
 MODULE_DESCRIPTION("Sony HORUS3A satellite tuner driver");
 MODULE_AUTHOR("Sergey Kozlov <serjk@netup.ru>");
diff --git a/drivers/media/dvb-frontends/isl6405.c b/drivers/media/dvb-frontends/isl6405.c
index 2cd69b4ff82c..7d28a743f97e 100644
--- a/drivers/media/dvb-frontends/isl6405.c
+++ b/drivers/media/dvb-frontends/isl6405.c
@@ -141,7 +141,7 @@ struct dvb_frontend *isl6405_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(isl6405_attach);
+EXPORT_SYMBOL_GPL(isl6405_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic isl6405");
 MODULE_AUTHOR("Hartmut Hackmann & Oliver Endriss");
diff --git a/drivers/media/dvb-frontends/isl6421.c b/drivers/media/dvb-frontends/isl6421.c
index 43b0dfc6f453..2e9f6f12f849 100644
--- a/drivers/media/dvb-frontends/isl6421.c
+++ b/drivers/media/dvb-frontends/isl6421.c
@@ -213,7 +213,7 @@ struct dvb_frontend *isl6421_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(isl6421_attach);
+EXPORT_SYMBOL_GPL(isl6421_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic isl6421");
 MODULE_AUTHOR("Andrew de Quincey & Oliver Endriss");
diff --git a/drivers/media/dvb-frontends/isl6423.c b/drivers/media/dvb-frontends/isl6423.c
index 8cd1bb88ce6e..a0d0a3834057 100644
--- a/drivers/media/dvb-frontends/isl6423.c
+++ b/drivers/media/dvb-frontends/isl6423.c
@@ -289,7 +289,7 @@ struct dvb_frontend *isl6423_attach(struct dvb_frontend *fe,
 	fe->sec_priv = NULL;
 	return NULL;
 }
-EXPORT_SYMBOL(isl6423_attach);
+EXPORT_SYMBOL_GPL(isl6423_attach);
 
 MODULE_DESCRIPTION("ISL6423 SEC");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/itd1000.c b/drivers/media/dvb-frontends/itd1000.c
index 1b33478653d1..f8f362f50e78 100644
--- a/drivers/media/dvb-frontends/itd1000.c
+++ b/drivers/media/dvb-frontends/itd1000.c
@@ -389,7 +389,7 @@ struct dvb_frontend *itd1000_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(itd1000_attach);
+EXPORT_SYMBOL_GPL(itd1000_attach);
 
 MODULE_AUTHOR("Patrick Boettcher <pb@linuxtv.org>");
 MODULE_DESCRIPTION("Integrant ITD1000 driver");
diff --git a/drivers/media/dvb-frontends/ix2505v.c b/drivers/media/dvb-frontends/ix2505v.c
index 73f27105c139..3212e333d472 100644
--- a/drivers/media/dvb-frontends/ix2505v.c
+++ b/drivers/media/dvb-frontends/ix2505v.c
@@ -302,7 +302,7 @@ struct dvb_frontend *ix2505v_attach(struct dvb_frontend *fe,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(ix2505v_attach);
+EXPORT_SYMBOL_GPL(ix2505v_attach);
 
 module_param_named(debug, ix2505v_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/l64781.c b/drivers/media/dvb-frontends/l64781.c
index c5106a1ea1cd..fe5af2453d55 100644
--- a/drivers/media/dvb-frontends/l64781.c
+++ b/drivers/media/dvb-frontends/l64781.c
@@ -593,4 +593,4 @@ MODULE_DESCRIPTION("LSI L64781 DVB-T Demodulator driver");
 MODULE_AUTHOR("Holger Waechtler, Marko Kohtala");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(l64781_attach);
+EXPORT_SYMBOL_GPL(l64781_attach);
diff --git a/drivers/media/dvb-frontends/lg2160.c b/drivers/media/dvb-frontends/lg2160.c
index f343066c297e..fe700aa56bff 100644
--- a/drivers/media/dvb-frontends/lg2160.c
+++ b/drivers/media/dvb-frontends/lg2160.c
@@ -1426,7 +1426,7 @@ struct dvb_frontend *lg2160_attach(const struct lg2160_config *config,
 
 	return &state->frontend;
 }
-EXPORT_SYMBOL(lg2160_attach);
+EXPORT_SYMBOL_GPL(lg2160_attach);
 
 MODULE_DESCRIPTION("LG Electronics LG216x ATSC/MH Demodulator Driver");
 MODULE_AUTHOR("Michael Krufky <mkrufky@linuxtv.org>");
diff --git a/drivers/media/dvb-frontends/lgdt3305.c b/drivers/media/dvb-frontends/lgdt3305.c
index 62d743988919..60a97f1cc74e 100644
--- a/drivers/media/dvb-frontends/lgdt3305.c
+++ b/drivers/media/dvb-frontends/lgdt3305.c
@@ -1148,7 +1148,7 @@ struct dvb_frontend *lgdt3305_attach(const struct lgdt3305_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(lgdt3305_attach);
+EXPORT_SYMBOL_GPL(lgdt3305_attach);
 
 static const struct dvb_frontend_ops lgdt3304_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index 722576f1732a..47fb22180d5b 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -1895,7 +1895,7 @@ struct dvb_frontend *lgdt3306a_attach(const struct lgdt3306a_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(lgdt3306a_attach);
+EXPORT_SYMBOL_GPL(lgdt3306a_attach);
 
 #ifdef DBG_DUMP
 
diff --git a/drivers/media/dvb-frontends/lgdt330x.c b/drivers/media/dvb-frontends/lgdt330x.c
index da3a8c5e18d8..53b1443ba022 100644
--- a/drivers/media/dvb-frontends/lgdt330x.c
+++ b/drivers/media/dvb-frontends/lgdt330x.c
@@ -928,7 +928,7 @@ struct dvb_frontend *lgdt330x_attach(const struct lgdt330x_config *_config,
 
 	return lgdt330x_get_dvb_frontend(client);
 }
-EXPORT_SYMBOL(lgdt330x_attach);
+EXPORT_SYMBOL_GPL(lgdt330x_attach);
 
 static const struct dvb_frontend_ops lgdt3302_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/lgs8gxx.c b/drivers/media/dvb-frontends/lgs8gxx.c
index 30014979b985..ffaf60e16ecd 100644
--- a/drivers/media/dvb-frontends/lgs8gxx.c
+++ b/drivers/media/dvb-frontends/lgs8gxx.c
@@ -1043,7 +1043,7 @@ struct dvb_frontend *lgs8gxx_attach(const struct lgs8gxx_config *config,
 	return NULL;
 
 }
-EXPORT_SYMBOL(lgs8gxx_attach);
+EXPORT_SYMBOL_GPL(lgs8gxx_attach);
 
 MODULE_DESCRIPTION("Legend Silicon LGS8913/LGS8GXX DMB-TH demodulator driver");
 MODULE_AUTHOR("David T. L. Wong <davidtlwong@gmail.com>");
diff --git a/drivers/media/dvb-frontends/lnbh25.c b/drivers/media/dvb-frontends/lnbh25.c
index 9ffe06cd787d..41bec050642b 100644
--- a/drivers/media/dvb-frontends/lnbh25.c
+++ b/drivers/media/dvb-frontends/lnbh25.c
@@ -173,7 +173,7 @@ struct dvb_frontend *lnbh25_attach(struct dvb_frontend *fe,
 		__func__, priv->i2c_address);
 	return fe;
 }
-EXPORT_SYMBOL(lnbh25_attach);
+EXPORT_SYMBOL_GPL(lnbh25_attach);
 
 MODULE_DESCRIPTION("ST LNBH25 driver");
 MODULE_AUTHOR("info@netup.ru");
diff --git a/drivers/media/dvb-frontends/lnbp21.c b/drivers/media/dvb-frontends/lnbp21.c
index e564974162d6..32593b1f75a3 100644
--- a/drivers/media/dvb-frontends/lnbp21.c
+++ b/drivers/media/dvb-frontends/lnbp21.c
@@ -155,7 +155,7 @@ struct dvb_frontend *lnbh24_attach(struct dvb_frontend *fe,
 	return lnbx2x_attach(fe, i2c, override_set, override_clear,
 							i2c_addr, LNBH24_TTX);
 }
-EXPORT_SYMBOL(lnbh24_attach);
+EXPORT_SYMBOL_GPL(lnbh24_attach);
 
 struct dvb_frontend *lnbp21_attach(struct dvb_frontend *fe,
 				struct i2c_adapter *i2c, u8 override_set,
@@ -164,7 +164,7 @@ struct dvb_frontend *lnbp21_attach(struct dvb_frontend *fe,
 	return lnbx2x_attach(fe, i2c, override_set, override_clear,
 							0x08, LNBP21_ISEL);
 }
-EXPORT_SYMBOL(lnbp21_attach);
+EXPORT_SYMBOL_GPL(lnbp21_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic lnbp21, lnbh24");
 MODULE_AUTHOR("Oliver Endriss, Igor M. Liplianin");
diff --git a/drivers/media/dvb-frontends/lnbp22.c b/drivers/media/dvb-frontends/lnbp22.c
index b8c7145d4cef..cb4ea5d3fad4 100644
--- a/drivers/media/dvb-frontends/lnbp22.c
+++ b/drivers/media/dvb-frontends/lnbp22.c
@@ -125,7 +125,7 @@ struct dvb_frontend *lnbp22_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(lnbp22_attach);
+EXPORT_SYMBOL_GPL(lnbp22_attach);
 
 MODULE_DESCRIPTION("Driver for lnb supply and control ic lnbp22");
 MODULE_AUTHOR("Dominik Kuhlen");
diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index c120cffb52ad..ff106d6ece68 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1699,7 +1699,7 @@ struct dvb_frontend *m88ds3103_attach(const struct m88ds3103_config *cfg,
 	*tuner_i2c_adapter = pdata.get_i2c_adapter(client);
 	return pdata.get_dvb_frontend(client);
 }
-EXPORT_SYMBOL(m88ds3103_attach);
+EXPORT_SYMBOL_GPL(m88ds3103_attach);
 
 static const struct dvb_frontend_ops m88ds3103_ops = {
 	.delsys = {SYS_DVBS, SYS_DVBS2},
diff --git a/drivers/media/dvb-frontends/m88rs2000.c b/drivers/media/dvb-frontends/m88rs2000.c
index 39cbb3ea1c9d..d1f235b472ce 100644
--- a/drivers/media/dvb-frontends/m88rs2000.c
+++ b/drivers/media/dvb-frontends/m88rs2000.c
@@ -807,7 +807,7 @@ struct dvb_frontend *m88rs2000_attach(const struct m88rs2000_config *config,
 
 	return NULL;
 }
-EXPORT_SYMBOL(m88rs2000_attach);
+EXPORT_SYMBOL_GPL(m88rs2000_attach);
 
 MODULE_DESCRIPTION("M88RS2000 DVB-S Demodulator driver");
 MODULE_AUTHOR("Malcolm Priestley tvboxspy@gmail.com");
diff --git a/drivers/media/dvb-frontends/mb86a16.c b/drivers/media/dvb-frontends/mb86a16.c
index 2505f1e5794e..ed08e0c2cf51 100644
--- a/drivers/media/dvb-frontends/mb86a16.c
+++ b/drivers/media/dvb-frontends/mb86a16.c
@@ -1848,6 +1848,6 @@ struct dvb_frontend *mb86a16_attach(const struct mb86a16_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(mb86a16_attach);
+EXPORT_SYMBOL_GPL(mb86a16_attach);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/mb86a20s.c b/drivers/media/dvb-frontends/mb86a20s.c
index a7faf0cf8788..8a333af9e176 100644
--- a/drivers/media/dvb-frontends/mb86a20s.c
+++ b/drivers/media/dvb-frontends/mb86a20s.c
@@ -2081,7 +2081,7 @@ struct dvb_frontend *mb86a20s_attach(const struct mb86a20s_config *config,
 	dev_info(&i2c->dev, "Detected a Fujitsu mb86a20s frontend\n");
 	return &state->frontend;
 }
-EXPORT_SYMBOL(mb86a20s_attach);
+EXPORT_SYMBOL_GPL(mb86a20s_attach);
 
 static const struct dvb_frontend_ops mb86a20s_ops = {
 	.delsys = { SYS_ISDBT },
diff --git a/drivers/media/dvb-frontends/mt312.c b/drivers/media/dvb-frontends/mt312.c
index d43a67045dbe..fb867dd8a26b 100644
--- a/drivers/media/dvb-frontends/mt312.c
+++ b/drivers/media/dvb-frontends/mt312.c
@@ -827,7 +827,7 @@ struct dvb_frontend *mt312_attach(const struct mt312_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(mt312_attach);
+EXPORT_SYMBOL_GPL(mt312_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/mt352.c b/drivers/media/dvb-frontends/mt352.c
index 399d5c519027..1b2889f5cf67 100644
--- a/drivers/media/dvb-frontends/mt352.c
+++ b/drivers/media/dvb-frontends/mt352.c
@@ -593,4 +593,4 @@ MODULE_DESCRIPTION("Zarlink MT352 DVB-T Demodulator driver");
 MODULE_AUTHOR("Holger Waechtler, Daniel Mack, Antonio Mancuso");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(mt352_attach);
+EXPORT_SYMBOL_GPL(mt352_attach);
diff --git a/drivers/media/dvb-frontends/nxt200x.c b/drivers/media/dvb-frontends/nxt200x.c
index 35b83b1dd82c..1124baf5baf4 100644
--- a/drivers/media/dvb-frontends/nxt200x.c
+++ b/drivers/media/dvb-frontends/nxt200x.c
@@ -1232,5 +1232,5 @@ MODULE_DESCRIPTION("NXT200X (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulat
 MODULE_AUTHOR("Kirk Lapray, Michael Krufky, Jean-Francois Thibert, and Taylor Jacob");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(nxt200x_attach);
+EXPORT_SYMBOL_GPL(nxt200x_attach);
 
diff --git a/drivers/media/dvb-frontends/nxt6000.c b/drivers/media/dvb-frontends/nxt6000.c
index 136918f82dda..e8d4940370dd 100644
--- a/drivers/media/dvb-frontends/nxt6000.c
+++ b/drivers/media/dvb-frontends/nxt6000.c
@@ -621,4 +621,4 @@ MODULE_DESCRIPTION("NxtWave NXT6000 DVB-T demodulator driver");
 MODULE_AUTHOR("Florian Schirmer");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(nxt6000_attach);
+EXPORT_SYMBOL_GPL(nxt6000_attach);
diff --git a/drivers/media/dvb-frontends/or51132.c b/drivers/media/dvb-frontends/or51132.c
index 24de1b115158..144a1f25dec0 100644
--- a/drivers/media/dvb-frontends/or51132.c
+++ b/drivers/media/dvb-frontends/or51132.c
@@ -605,4 +605,4 @@ MODULE_AUTHOR("Kirk Lapray");
 MODULE_AUTHOR("Trent Piepho");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(or51132_attach);
+EXPORT_SYMBOL_GPL(or51132_attach);
diff --git a/drivers/media/dvb-frontends/or51211.c b/drivers/media/dvb-frontends/or51211.c
index ddcaea5c9941..dc60482162c5 100644
--- a/drivers/media/dvb-frontends/or51211.c
+++ b/drivers/media/dvb-frontends/or51211.c
@@ -551,5 +551,5 @@ MODULE_DESCRIPTION("Oren OR51211 VSB [pcHDTV HD-2000] Demodulator Driver");
 MODULE_AUTHOR("Kirk Lapray");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(or51211_attach);
+EXPORT_SYMBOL_GPL(or51211_attach);
 
diff --git a/drivers/media/dvb-frontends/s5h1409.c b/drivers/media/dvb-frontends/s5h1409.c
index 3089cc174a6f..28b1dca077ea 100644
--- a/drivers/media/dvb-frontends/s5h1409.c
+++ b/drivers/media/dvb-frontends/s5h1409.c
@@ -981,7 +981,7 @@ struct dvb_frontend *s5h1409_attach(const struct s5h1409_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(s5h1409_attach);
+EXPORT_SYMBOL_GPL(s5h1409_attach);
 
 static const struct dvb_frontend_ops s5h1409_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/s5h1411.c b/drivers/media/dvb-frontends/s5h1411.c
index c1334d7eb442..ae2b391af903 100644
--- a/drivers/media/dvb-frontends/s5h1411.c
+++ b/drivers/media/dvb-frontends/s5h1411.c
@@ -900,7 +900,7 @@ struct dvb_frontend *s5h1411_attach(const struct s5h1411_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(s5h1411_attach);
+EXPORT_SYMBOL_GPL(s5h1411_attach);
 
 static const struct dvb_frontend_ops s5h1411_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/s5h1420.c b/drivers/media/dvb-frontends/s5h1420.c
index 6bdec2898bc8..d700de1ea6c2 100644
--- a/drivers/media/dvb-frontends/s5h1420.c
+++ b/drivers/media/dvb-frontends/s5h1420.c
@@ -918,7 +918,7 @@ struct dvb_frontend *s5h1420_attach(const struct s5h1420_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(s5h1420_attach);
+EXPORT_SYMBOL_GPL(s5h1420_attach);
 
 static const struct dvb_frontend_ops s5h1420_ops = {
 	.delsys = { SYS_DVBS },
diff --git a/drivers/media/dvb-frontends/s5h1432.c b/drivers/media/dvb-frontends/s5h1432.c
index 956e8ee4b388..ff5d3bdf3bc6 100644
--- a/drivers/media/dvb-frontends/s5h1432.c
+++ b/drivers/media/dvb-frontends/s5h1432.c
@@ -355,7 +355,7 @@ struct dvb_frontend *s5h1432_attach(const struct s5h1432_config *config,
 
 	return &state->frontend;
 }
-EXPORT_SYMBOL(s5h1432_attach);
+EXPORT_SYMBOL_GPL(s5h1432_attach);
 
 static const struct dvb_frontend_ops s5h1432_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/s921.c b/drivers/media/dvb-frontends/s921.c
index f118d8e64103..7e461ac159fc 100644
--- a/drivers/media/dvb-frontends/s921.c
+++ b/drivers/media/dvb-frontends/s921.c
@@ -495,7 +495,7 @@ struct dvb_frontend *s921_attach(const struct s921_config *config,
 
 	return &state->frontend;
 }
-EXPORT_SYMBOL(s921_attach);
+EXPORT_SYMBOL_GPL(s921_attach);
 
 static const struct dvb_frontend_ops s921_ops = {
 	.delsys = { SYS_ISDBT },
diff --git a/drivers/media/dvb-frontends/si21xx.c b/drivers/media/dvb-frontends/si21xx.c
index a116eff417f2..6d84a5534aba 100644
--- a/drivers/media/dvb-frontends/si21xx.c
+++ b/drivers/media/dvb-frontends/si21xx.c
@@ -938,7 +938,7 @@ struct dvb_frontend *si21xx_attach(const struct si21xx_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(si21xx_attach);
+EXPORT_SYMBOL_GPL(si21xx_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/sp887x.c b/drivers/media/dvb-frontends/sp887x.c
index c89a91a3daf4..72f58626475c 100644
--- a/drivers/media/dvb-frontends/sp887x.c
+++ b/drivers/media/dvb-frontends/sp887x.c
@@ -626,4 +626,4 @@ MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
 MODULE_DESCRIPTION("Spase sp887x DVB-T demodulator driver");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(sp887x_attach);
+EXPORT_SYMBOL_GPL(sp887x_attach);
diff --git a/drivers/media/dvb-frontends/stb0899_drv.c b/drivers/media/dvb-frontends/stb0899_drv.c
index 4ee6c1e1e9f7..2f4d8fb400cd 100644
--- a/drivers/media/dvb-frontends/stb0899_drv.c
+++ b/drivers/media/dvb-frontends/stb0899_drv.c
@@ -1638,7 +1638,7 @@ struct dvb_frontend *stb0899_attach(struct stb0899_config *config, struct i2c_ad
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stb0899_attach);
+EXPORT_SYMBOL_GPL(stb0899_attach);
 MODULE_PARM_DESC(verbose, "Set Verbosity level");
 MODULE_AUTHOR("Manu Abraham");
 MODULE_DESCRIPTION("STB0899 Multi-Std frontend");
diff --git a/drivers/media/dvb-frontends/stb6000.c b/drivers/media/dvb-frontends/stb6000.c
index 8c9800d577e0..d74e34677b92 100644
--- a/drivers/media/dvb-frontends/stb6000.c
+++ b/drivers/media/dvb-frontends/stb6000.c
@@ -232,7 +232,7 @@ struct dvb_frontend *stb6000_attach(struct dvb_frontend *fe, int addr,
 
 	return fe;
 }
-EXPORT_SYMBOL(stb6000_attach);
+EXPORT_SYMBOL_GPL(stb6000_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/stb6100.c b/drivers/media/dvb-frontends/stb6100.c
index d541d6613610..9f92760256cf 100644
--- a/drivers/media/dvb-frontends/stb6100.c
+++ b/drivers/media/dvb-frontends/stb6100.c
@@ -557,7 +557,7 @@ static void stb6100_release(struct dvb_frontend *fe)
 	kfree(state);
 }
 
-EXPORT_SYMBOL(stb6100_attach);
+EXPORT_SYMBOL_GPL(stb6100_attach);
 MODULE_PARM_DESC(verbose, "Set Verbosity level");
 
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/stv0288.c b/drivers/media/dvb-frontends/stv0288.c
index 3ae1f3a2f142..a5581bd60f9e 100644
--- a/drivers/media/dvb-frontends/stv0288.c
+++ b/drivers/media/dvb-frontends/stv0288.c
@@ -590,7 +590,7 @@ struct dvb_frontend *stv0288_attach(const struct stv0288_config *config,
 
 	return NULL;
 }
-EXPORT_SYMBOL(stv0288_attach);
+EXPORT_SYMBOL_GPL(stv0288_attach);
 
 module_param(debug_legacy_dish_switch, int, 0444);
 MODULE_PARM_DESC(debug_legacy_dish_switch,
diff --git a/drivers/media/dvb-frontends/stv0297.c b/drivers/media/dvb-frontends/stv0297.c
index 6d5962d5697a..9d4dbd99a5a7 100644
--- a/drivers/media/dvb-frontends/stv0297.c
+++ b/drivers/media/dvb-frontends/stv0297.c
@@ -710,4 +710,4 @@ MODULE_DESCRIPTION("ST STV0297 DVB-C Demodulator driver");
 MODULE_AUTHOR("Dennis Noermann and Andrew de Quincey");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(stv0297_attach);
+EXPORT_SYMBOL_GPL(stv0297_attach);
diff --git a/drivers/media/dvb-frontends/stv0299.c b/drivers/media/dvb-frontends/stv0299.c
index 421395ea3334..0a1b57e9e228 100644
--- a/drivers/media/dvb-frontends/stv0299.c
+++ b/drivers/media/dvb-frontends/stv0299.c
@@ -751,4 +751,4 @@ MODULE_DESCRIPTION("ST STV0299 DVB Demodulator driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter, Andrew de Quincey, Kenneth Aafly");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(stv0299_attach);
+EXPORT_SYMBOL_GPL(stv0299_attach);
diff --git a/drivers/media/dvb-frontends/stv0367.c b/drivers/media/dvb-frontends/stv0367.c
index 6c2b05fae1c5..0bfca1174e9e 100644
--- a/drivers/media/dvb-frontends/stv0367.c
+++ b/drivers/media/dvb-frontends/stv0367.c
@@ -1750,7 +1750,7 @@ struct dvb_frontend *stv0367ter_attach(const struct stv0367_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0367ter_attach);
+EXPORT_SYMBOL_GPL(stv0367ter_attach);
 
 static int stv0367cab_gate_ctrl(struct dvb_frontend *fe, int enable)
 {
@@ -2923,7 +2923,7 @@ struct dvb_frontend *stv0367cab_attach(const struct stv0367_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0367cab_attach);
+EXPORT_SYMBOL_GPL(stv0367cab_attach);
 
 /*
  * Functions for operation on Digital Devices hardware
@@ -3344,7 +3344,7 @@ struct dvb_frontend *stv0367ddb_attach(const struct stv0367_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0367ddb_attach);
+EXPORT_SYMBOL_GPL(stv0367ddb_attach);
 
 MODULE_PARM_DESC(debug, "Set debug");
 MODULE_PARM_DESC(i2c_debug, "Set i2c debug");
diff --git a/drivers/media/dvb-frontends/stv0900_core.c b/drivers/media/dvb-frontends/stv0900_core.c
index 212312d20ff6..e7b9b9b11d7d 100644
--- a/drivers/media/dvb-frontends/stv0900_core.c
+++ b/drivers/media/dvb-frontends/stv0900_core.c
@@ -1957,7 +1957,7 @@ struct dvb_frontend *stv0900_attach(const struct stv0900_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv0900_attach);
+EXPORT_SYMBOL_GPL(stv0900_attach);
 
 MODULE_PARM_DESC(debug, "Set debug");
 
diff --git a/drivers/media/dvb-frontends/stv090x.c b/drivers/media/dvb-frontends/stv090x.c
index 90d24131d335..799dbefb9eef 100644
--- a/drivers/media/dvb-frontends/stv090x.c
+++ b/drivers/media/dvb-frontends/stv090x.c
@@ -5073,7 +5073,7 @@ struct dvb_frontend *stv090x_attach(struct stv090x_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(stv090x_attach);
+EXPORT_SYMBOL_GPL(stv090x_attach);
 
 static const struct i2c_device_id stv090x_id_table[] = {
 	{"stv090x", 0},
diff --git a/drivers/media/dvb-frontends/stv6110.c b/drivers/media/dvb-frontends/stv6110.c
index 963f6a896102..1cf9c095dbff 100644
--- a/drivers/media/dvb-frontends/stv6110.c
+++ b/drivers/media/dvb-frontends/stv6110.c
@@ -427,7 +427,7 @@ struct dvb_frontend *stv6110_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(stv6110_attach);
+EXPORT_SYMBOL_GPL(stv6110_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/stv6110x.c b/drivers/media/dvb-frontends/stv6110x.c
index 5012d0231652..b08c7536a69f 100644
--- a/drivers/media/dvb-frontends/stv6110x.c
+++ b/drivers/media/dvb-frontends/stv6110x.c
@@ -469,7 +469,7 @@ const struct stv6110x_devctl *stv6110x_attach(struct dvb_frontend *fe,
 	dev_info(&stv6110x->i2c->dev, "Attaching STV6110x\n");
 	return stv6110x->devctl;
 }
-EXPORT_SYMBOL(stv6110x_attach);
+EXPORT_SYMBOL_GPL(stv6110x_attach);
 
 static const struct i2c_device_id stv6110x_id_table[] = {
 	{"stv6110x", 0},
diff --git a/drivers/media/dvb-frontends/tda10021.c b/drivers/media/dvb-frontends/tda10021.c
index faa6e54b3372..462e12ab6bd1 100644
--- a/drivers/media/dvb-frontends/tda10021.c
+++ b/drivers/media/dvb-frontends/tda10021.c
@@ -523,4 +523,4 @@ MODULE_DESCRIPTION("Philips TDA10021 DVB-C demodulator driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Markus Schulz");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10021_attach);
+EXPORT_SYMBOL_GPL(tda10021_attach);
diff --git a/drivers/media/dvb-frontends/tda10023.c b/drivers/media/dvb-frontends/tda10023.c
index 8f32edf6b700..4c2541ecd743 100644
--- a/drivers/media/dvb-frontends/tda10023.c
+++ b/drivers/media/dvb-frontends/tda10023.c
@@ -594,4 +594,4 @@ MODULE_DESCRIPTION("Philips TDA10023 DVB-C demodulator driver");
 MODULE_AUTHOR("Georg Acher, Hartmut Birr");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10023_attach);
+EXPORT_SYMBOL_GPL(tda10023_attach);
diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index d1d206ebdedd..f1d5e77d5dcc 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -1138,7 +1138,7 @@ struct dvb_frontend *tda10048_attach(const struct tda10048_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(tda10048_attach);
+EXPORT_SYMBOL_GPL(tda10048_attach);
 
 static const struct dvb_frontend_ops tda10048_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/dvb-frontends/tda1004x.c b/drivers/media/dvb-frontends/tda1004x.c
index 83a798ca9b00..6f306db6c615 100644
--- a/drivers/media/dvb-frontends/tda1004x.c
+++ b/drivers/media/dvb-frontends/tda1004x.c
@@ -1378,5 +1378,5 @@ MODULE_DESCRIPTION("Philips TDA10045H & TDA10046H DVB-T Demodulator");
 MODULE_AUTHOR("Andrew de Quincey & Robert Schlabbach");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10045_attach);
-EXPORT_SYMBOL(tda10046_attach);
+EXPORT_SYMBOL_GPL(tda10045_attach);
+EXPORT_SYMBOL_GPL(tda10046_attach);
diff --git a/drivers/media/dvb-frontends/tda10086.c b/drivers/media/dvb-frontends/tda10086.c
index cdcf97664bba..b449514ae585 100644
--- a/drivers/media/dvb-frontends/tda10086.c
+++ b/drivers/media/dvb-frontends/tda10086.c
@@ -764,4 +764,4 @@ MODULE_DESCRIPTION("Philips TDA10086 DVB-S Demodulator");
 MODULE_AUTHOR("Andrew de Quincey");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda10086_attach);
+EXPORT_SYMBOL_GPL(tda10086_attach);
diff --git a/drivers/media/dvb-frontends/tda665x.c b/drivers/media/dvb-frontends/tda665x.c
index 13e8969da7f8..346be5011fb7 100644
--- a/drivers/media/dvb-frontends/tda665x.c
+++ b/drivers/media/dvb-frontends/tda665x.c
@@ -227,7 +227,7 @@ struct dvb_frontend *tda665x_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(tda665x_attach);
+EXPORT_SYMBOL_GPL(tda665x_attach);
 
 MODULE_DESCRIPTION("TDA665x driver");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/dvb-frontends/tda8083.c b/drivers/media/dvb-frontends/tda8083.c
index 5be11fd65e3b..9fc16e917f34 100644
--- a/drivers/media/dvb-frontends/tda8083.c
+++ b/drivers/media/dvb-frontends/tda8083.c
@@ -481,4 +481,4 @@ MODULE_DESCRIPTION("Philips TDA8083 DVB-S Demodulator");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(tda8083_attach);
+EXPORT_SYMBOL_GPL(tda8083_attach);
diff --git a/drivers/media/dvb-frontends/tda8261.c b/drivers/media/dvb-frontends/tda8261.c
index 0d576d41c67d..8b06f92745dc 100644
--- a/drivers/media/dvb-frontends/tda8261.c
+++ b/drivers/media/dvb-frontends/tda8261.c
@@ -188,7 +188,7 @@ struct dvb_frontend *tda8261_attach(struct dvb_frontend *fe,
 	return NULL;
 }
 
-EXPORT_SYMBOL(tda8261_attach);
+EXPORT_SYMBOL_GPL(tda8261_attach);
 
 MODULE_AUTHOR("Manu Abraham");
 MODULE_DESCRIPTION("TDA8261 8PSK/QPSK Tuner");
diff --git a/drivers/media/dvb-frontends/tda826x.c b/drivers/media/dvb-frontends/tda826x.c
index f9703a1dd758..eafcf5f7da3d 100644
--- a/drivers/media/dvb-frontends/tda826x.c
+++ b/drivers/media/dvb-frontends/tda826x.c
@@ -164,7 +164,7 @@ struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, struct i2
 
 	return fe;
 }
-EXPORT_SYMBOL(tda826x_attach);
+EXPORT_SYMBOL_GPL(tda826x_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/ts2020.c b/drivers/media/dvb-frontends/ts2020.c
index 234607b02edb..1f1004ccce1e 100644
--- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -525,7 +525,7 @@ struct dvb_frontend *ts2020_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(ts2020_attach);
+EXPORT_SYMBOL_GPL(ts2020_attach);
 
 /*
  * We implement own regmap locking due to legacy DVB attach which uses frontend
diff --git a/drivers/media/dvb-frontends/tua6100.c b/drivers/media/dvb-frontends/tua6100.c
index 2483f614d0e7..41dd9b6d3190 100644
--- a/drivers/media/dvb-frontends/tua6100.c
+++ b/drivers/media/dvb-frontends/tua6100.c
@@ -186,7 +186,7 @@ struct dvb_frontend *tua6100_attach(struct dvb_frontend *fe, int addr, struct i2
 	fe->tuner_priv = priv;
 	return fe;
 }
-EXPORT_SYMBOL(tua6100_attach);
+EXPORT_SYMBOL_GPL(tua6100_attach);
 
 MODULE_DESCRIPTION("DVB tua6100 driver");
 MODULE_AUTHOR("Andrew de Quincey");
diff --git a/drivers/media/dvb-frontends/ves1820.c b/drivers/media/dvb-frontends/ves1820.c
index 9df14d0be1c1..ee5620e731e9 100644
--- a/drivers/media/dvb-frontends/ves1820.c
+++ b/drivers/media/dvb-frontends/ves1820.c
@@ -434,4 +434,4 @@ MODULE_DESCRIPTION("VLSI VES1820 DVB-C Demodulator driver");
 MODULE_AUTHOR("Ralph Metzler, Holger Waechtler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ves1820_attach);
+EXPORT_SYMBOL_GPL(ves1820_attach);
diff --git a/drivers/media/dvb-frontends/ves1x93.c b/drivers/media/dvb-frontends/ves1x93.c
index b74727286302..c60e21d26b88 100644
--- a/drivers/media/dvb-frontends/ves1x93.c
+++ b/drivers/media/dvb-frontends/ves1x93.c
@@ -540,4 +540,4 @@ MODULE_DESCRIPTION("VLSI VES1x93 DVB-S Demodulator driver");
 MODULE_AUTHOR("Ralph Metzler");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(ves1x93_attach);
+EXPORT_SYMBOL_GPL(ves1x93_attach);
diff --git a/drivers/media/dvb-frontends/zl10036.c b/drivers/media/dvb-frontends/zl10036.c
index d392c7cce2ce..7ba575e9c55f 100644
--- a/drivers/media/dvb-frontends/zl10036.c
+++ b/drivers/media/dvb-frontends/zl10036.c
@@ -496,7 +496,7 @@ struct dvb_frontend *zl10036_attach(struct dvb_frontend *fe,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(zl10036_attach);
+EXPORT_SYMBOL_GPL(zl10036_attach);
 
 module_param_named(debug, zl10036_debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/zl10039.c b/drivers/media/dvb-frontends/zl10039.c
index 1335bf78d5b7..a3e4d219400c 100644
--- a/drivers/media/dvb-frontends/zl10039.c
+++ b/drivers/media/dvb-frontends/zl10039.c
@@ -295,7 +295,7 @@ struct dvb_frontend *zl10039_attach(struct dvb_frontend *fe,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(zl10039_attach);
+EXPORT_SYMBOL_GPL(zl10039_attach);
 
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
diff --git a/drivers/media/dvb-frontends/zl10353.c b/drivers/media/dvb-frontends/zl10353.c
index 2a2cf20a73d6..8849d05475c2 100644
--- a/drivers/media/dvb-frontends/zl10353.c
+++ b/drivers/media/dvb-frontends/zl10353.c
@@ -665,4 +665,4 @@ MODULE_DESCRIPTION("Zarlink ZL10353 DVB-T demodulator driver");
 MODULE_AUTHOR("Chris Pascoe");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(zl10353_attach);
+EXPORT_SYMBOL_GPL(zl10353_attach);
diff --git a/drivers/media/i2c/ad5820.c b/drivers/media/i2c/ad5820.c
index f55322eebf6d..d2c69ee27f00 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -359,7 +359,6 @@ static int ad5820_remove(struct i2c_client *client)
 static const struct i2c_device_id ad5820_id_table[] = {
 	{ "ad5820", 0 },
 	{ "ad5821", 0 },
-	{ "ad5823", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
@@ -367,7 +366,6 @@ MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 static const struct of_device_id ad5820_of_table[] = {
 	{ .compatible = "adi,ad5820" },
 	{ .compatible = "adi,ad5821" },
-	{ .compatible = "adi,ad5823" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 59cdbc33658c..731a60f6a59a 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -85,15 +85,8 @@ struct ov2680_mode_info {
 
 struct ov2680_ctrls {
 	struct v4l2_ctrl_handler handler;
-	struct {
-		struct v4l2_ctrl *auto_exp;
-		struct v4l2_ctrl *exposure;
-	};
-	struct {
-		struct v4l2_ctrl *auto_gain;
-		struct v4l2_ctrl *gain;
-	};
-
+	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *gain;
 	struct v4l2_ctrl *hflip;
 	struct v4l2_ctrl *vflip;
 	struct v4l2_ctrl *test_pattern;
@@ -143,6 +136,7 @@ static const struct reg_value ov2680_setting_30fps_QUXGA_800_600[] = {
 	{0x380e, 0x02}, {0x380f, 0x84}, {0x3811, 0x04}, {0x3813, 0x04},
 	{0x3814, 0x31}, {0x3815, 0x31}, {0x3820, 0xc0}, {0x4008, 0x00},
 	{0x4009, 0x03}, {0x4837, 0x1e}, {0x3501, 0x4e}, {0x3502, 0xe0},
+	{0x3503, 0x03},
 };
 
 static const struct reg_value ov2680_setting_30fps_720P_1280_720[] = {
@@ -321,70 +315,49 @@ static void ov2680_power_down(struct ov2680_dev *sensor)
 	usleep_range(5000, 10000);
 }
 
-static int ov2680_bayer_order(struct ov2680_dev *sensor)
+static void ov2680_set_bayer_order(struct ov2680_dev *sensor)
 {
-	u32 format1;
-	u32 format2;
-	u32 hv_flip;
-	int ret;
-
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT1, &format1);
-	if (ret < 0)
-		return ret;
+	int hv_flip = 0;
 
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT2, &format2);
-	if (ret < 0)
-		return ret;
+	if (sensor->ctrls.vflip && sensor->ctrls.vflip->val)
+		hv_flip += 1;
 
-	hv_flip = (format2 & BIT(2)  << 1) | (format1 & BIT(2));
+	if (sensor->ctrls.hflip && sensor->ctrls.hflip->val)
+		hv_flip += 2;
 
 	sensor->fmt.code = ov2680_hv_flip_bayer_order[hv_flip];
-
-	return 0;
 }
 
-static int ov2680_vflip_enable(struct ov2680_dev *sensor)
+static int ov2680_set_vflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	return ov2680_bayer_order(sensor);
-}
-
-static int ov2680_vflip_disable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(0));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
-static int ov2680_hflip_enable(struct ov2680_dev *sensor)
+static int ov2680_set_hflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	return ov2680_bayer_order(sensor);
-}
-
-static int ov2680_hflip_disable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(0));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor);
+	return 0;
 }
 
 static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
@@ -405,69 +378,15 @@ static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
 	return 0;
 }
 
-static int ov2680_gain_set(struct ov2680_dev *sensor, bool auto_gain)
+static int ov2680_gain_set(struct ov2680_dev *sensor, u32 gain)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	u32 gain;
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_R_MANUAL, BIT(1),
-			     auto_gain ? 0 : BIT(1));
-	if (ret < 0)
-		return ret;
-
-	if (auto_gain || !ctrls->gain->is_new)
-		return 0;
-
-	gain = ctrls->gain->val;
-
-	ret = ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
-
-	return 0;
+	return ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
 }
 
-static int ov2680_gain_get(struct ov2680_dev *sensor)
+static int ov2680_exposure_set(struct ov2680_dev *sensor, u32 exp)
 {
-	u32 gain;
-	int ret;
-
-	ret = ov2680_read_reg16(sensor, OV2680_REG_GAIN_PK, &gain);
-	if (ret)
-		return ret;
-
-	return gain;
-}
-
-static int ov2680_exposure_set(struct ov2680_dev *sensor, bool auto_exp)
-{
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	u32 exp;
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_R_MANUAL, BIT(0),
-			     auto_exp ? 0 : BIT(0));
-	if (ret < 0)
-		return ret;
-
-	if (auto_exp || !ctrls->exposure->is_new)
-		return 0;
-
-	exp = (u32)ctrls->exposure->val;
-	exp <<= 4;
-
-	return ov2680_write_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH, exp);
-}
-
-static int ov2680_exposure_get(struct ov2680_dev *sensor)
-{
-	int ret;
-	u32 exp;
-
-	ret = ov2680_read_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH, &exp);
-	if (ret)
-		return ret;
-
-	return exp >> 4;
+	return ov2680_write_reg24(sensor, OV2680_REG_EXPOSURE_PK_HIGH,
+				  exp << 4);
 }
 
 static int ov2680_stream_enable(struct ov2680_dev *sensor)
@@ -482,33 +401,17 @@ static int ov2680_stream_disable(struct ov2680_dev *sensor)
 
 static int ov2680_mode_set(struct ov2680_dev *sensor)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 	int ret;
 
-	ret = ov2680_gain_set(sensor, false);
+	ret = ov2680_load_regs(sensor, sensor->current_mode);
 	if (ret < 0)
 		return ret;
 
-	ret = ov2680_exposure_set(sensor, false);
+	/* Restore value of all ctrls */
+	ret = __v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
 	if (ret < 0)
 		return ret;
 
-	ret = ov2680_load_regs(sensor, sensor->current_mode);
-	if (ret < 0)
-		return ret;
-
-	if (ctrls->auto_gain->val) {
-		ret = ov2680_gain_set(sensor, true);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (ctrls->auto_exp->val == V4L2_EXPOSURE_AUTO) {
-		ret = ov2680_exposure_set(sensor, true);
-		if (ret < 0)
-			return ret;
-	}
-
 	sensor->mode_pending_changes = false;
 
 	return 0;
@@ -556,7 +459,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 		ret = ov2680_write_reg(sensor, OV2680_REG_SOFT_RESET, 0x01);
 		if (ret != 0) {
 			dev_err(dev, "sensor soft reset failed\n");
-			return ret;
+			goto err_disable_regulators;
 		}
 		usleep_range(1000, 2000);
 	} else {
@@ -566,7 +469,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 
 	ret = clk_prepare_enable(sensor->xvclk);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	sensor->is_enabled = true;
 
@@ -576,6 +479,10 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 	ov2680_stream_disable(sensor);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(OV2680_NUM_SUPPLIES, sensor->supplies);
+	return ret;
 }
 
 static int ov2680_s_power(struct v4l2_subdev *sd, int on)
@@ -590,15 +497,10 @@ static int ov2680_s_power(struct v4l2_subdev *sd, int on)
 	else
 		ret = ov2680_power_off(sensor);
 
-	mutex_unlock(&sensor->lock);
-
-	if (on && ret == 0) {
-		ret = v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
-		if (ret < 0)
-			return ret;
-
+	if (on && ret == 0)
 		ret = ov2680_mode_restore(sensor);
-	}
+
+	mutex_unlock(&sensor->lock);
 
 	return ret;
 }
@@ -793,66 +695,23 @@ static int ov2680_enum_frame_interval(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int ov2680_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
-{
-	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
-	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
-	int val;
-
-	if (!sensor->is_enabled)
-		return 0;
-
-	switch (ctrl->id) {
-	case V4L2_CID_GAIN:
-		val = ov2680_gain_get(sensor);
-		if (val < 0)
-			return val;
-		ctrls->gain->val = val;
-		break;
-	case V4L2_CID_EXPOSURE:
-		val = ov2680_exposure_get(sensor);
-		if (val < 0)
-			return val;
-		ctrls->exposure->val = val;
-		break;
-	}
-
-	return 0;
-}
-
 static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 
 	if (!sensor->is_enabled)
 		return 0;
 
 	switch (ctrl->id) {
-	case V4L2_CID_AUTOGAIN:
-		return ov2680_gain_set(sensor, !!ctrl->val);
 	case V4L2_CID_GAIN:
-		return ov2680_gain_set(sensor, !!ctrls->auto_gain->val);
-	case V4L2_CID_EXPOSURE_AUTO:
-		return ov2680_exposure_set(sensor, !!ctrl->val);
+		return ov2680_gain_set(sensor, ctrl->val);
 	case V4L2_CID_EXPOSURE:
-		return ov2680_exposure_set(sensor, !!ctrls->auto_exp->val);
+		return ov2680_exposure_set(sensor, ctrl->val);
 	case V4L2_CID_VFLIP:
-		if (sensor->is_streaming)
-			return -EBUSY;
-		if (ctrl->val)
-			return ov2680_vflip_enable(sensor);
-		else
-			return ov2680_vflip_disable(sensor);
+		return ov2680_set_vflip(sensor, ctrl->val);
 	case V4L2_CID_HFLIP:
-		if (sensor->is_streaming)
-			return -EBUSY;
-		if (ctrl->val)
-			return ov2680_hflip_enable(sensor);
-		else
-			return ov2680_hflip_disable(sensor);
+		return ov2680_set_hflip(sensor, ctrl->val);
 	case V4L2_CID_TEST_PATTERN:
 		return ov2680_test_pattern_set(sensor, ctrl->val);
 	default:
@@ -863,7 +722,6 @@ static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 }
 
 static const struct v4l2_ctrl_ops ov2680_ctrl_ops = {
-	.g_volatile_ctrl = ov2680_g_volatile_ctrl,
 	.s_ctrl = ov2680_s_ctrl,
 };
 
@@ -935,7 +793,7 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	v4l2_ctrl_handler_init(hdl, 7);
+	v4l2_ctrl_handler_init(hdl, 5);
 
 	hdl->lock = &sensor->lock;
 
@@ -947,16 +805,9 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 					ARRAY_SIZE(test_pattern_menu) - 1,
 					0, 0, test_pattern_menu);
 
-	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
-						 V4L2_CID_EXPOSURE_AUTO,
-						 V4L2_EXPOSURE_MANUAL, 0,
-						 V4L2_EXPOSURE_AUTO);
-
 	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_EXPOSURE,
 					    0, 32767, 1, 0);
 
-	ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_AUTOGAIN,
-					     0, 1, 1, 1);
 	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN, 0, 2047, 1, 0);
 
 	if (hdl->error) {
@@ -964,11 +815,8 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 		goto cleanup_entity;
 	}
 
-	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
-	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
-
-	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
-	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+	ctrls->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
+	ctrls->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	sensor->sd.ctrl_handler = hdl;
 
diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 92a5f9aff9b5..db4b6095f4f4 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1942,9 +1942,9 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
 	 *		  "ov5640_set_stream_mipi()")
 	 * [4] = 0	: Power up MIPI HS Tx
 	 * [3] = 0	: Power up MIPI LS Rx
-	 * [2] = 0	: MIPI interface disabled
+	 * [2] = 1	: MIPI interface enabled
 	 */
-	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00, 0x40);
+	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00, 0x44);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 3b3221fd3fe8..cf0570a6760c 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -2078,6 +2078,10 @@ static int tvp5150_parse_dt(struct tvp5150 *decoder, struct device_node *np)
 		tvpc->ent.name = devm_kasprintf(dev, GFP_KERNEL, "%s %s",
 						v4l2c->name, v4l2c->label ?
 						v4l2c->label : "");
+		if (!tvpc->ent.name) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
 	}
 
 	ep_np = of_graph_get_endpoint_by_regs(np, TVP5150_PAD_VID_OUT, 0);
diff --git a/drivers/media/pci/bt8xx/dst.c b/drivers/media/pci/bt8xx/dst.c
index 3e52a51982d7..110651e47831 100644
--- a/drivers/media/pci/bt8xx/dst.c
+++ b/drivers/media/pci/bt8xx/dst.c
@@ -1722,7 +1722,7 @@ struct dst_state *dst_attach(struct dst_state *state, struct dvb_adapter *dvb_ad
 	return state;				/*	Manu (DST is a card not a frontend)	*/
 }
 
-EXPORT_SYMBOL(dst_attach);
+EXPORT_SYMBOL_GPL(dst_attach);
 
 static const struct dvb_frontend_ops dst_dvbt_ops = {
 	.delsys = { SYS_DVBT },
diff --git a/drivers/media/pci/bt8xx/dst_ca.c b/drivers/media/pci/bt8xx/dst_ca.c
index 85fcdc59f0d1..571392d80ccc 100644
--- a/drivers/media/pci/bt8xx/dst_ca.c
+++ b/drivers/media/pci/bt8xx/dst_ca.c
@@ -668,7 +668,7 @@ struct dvb_device *dst_ca_attach(struct dst_state *dst, struct dvb_adapter *dvb_
 	return NULL;
 }
 
-EXPORT_SYMBOL(dst_ca_attach);
+EXPORT_SYMBOL_GPL(dst_ca_attach);
 
 MODULE_DESCRIPTION("DST DVB-S/T/C Combo CA driver");
 MODULE_AUTHOR("Manu Abraham");
diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 45c2f4afceb8..9b437faf2c3f 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -2459,16 +2459,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
@@ -2505,16 +2499,10 @@ static int dvb_register(struct cx23885_tsport *port)
 			request_module("%s", info.type);
 			client_tuner = i2c_new_client_device(&dev->i2c_bus[1].i2c_adap, &info);
 			if (!i2c_client_has_driver(client_tuner)) {
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			if (!try_module_get(client_tuner->dev.driver->owner)) {
 				i2c_unregister_device(client_tuner);
-				module_put(client_demod->dev.driver->owner);
-				i2c_unregister_device(client_demod);
-				port->i2c_client_demod = NULL;
 				goto frontend_detach;
 			}
 			port->i2c_client_tuner = client_tuner;
diff --git a/drivers/media/pci/ddbridge/ddbridge-dummy-fe.c b/drivers/media/pci/ddbridge/ddbridge-dummy-fe.c
index 6868a0c4fc82..520ebd16b0c4 100644
--- a/drivers/media/pci/ddbridge/ddbridge-dummy-fe.c
+++ b/drivers/media/pci/ddbridge/ddbridge-dummy-fe.c
@@ -112,7 +112,7 @@ struct dvb_frontend *ddbridge_dummy_fe_qam_attach(void)
 	state->frontend.demodulator_priv = state;
 	return &state->frontend;
 }
-EXPORT_SYMBOL(ddbridge_dummy_fe_qam_attach);
+EXPORT_SYMBOL_GPL(ddbridge_dummy_fe_qam_attach);
 
 static const struct dvb_frontend_ops ddbridge_dummy_fe_qam_ops = {
 	.delsys = { SYS_DVBC_ANNEX_A },
diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
index d9880210b2ab..43c108b68d0a 100644
--- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
@@ -226,10 +226,11 @@ static struct vdec_fb *vp9_rm_from_fb_use_list(struct vdec_vp9_inst
 		if (fb->base_y.va == addr) {
 			list_move_tail(&node->list,
 				       &inst->available_fb_node_list);
-			break;
+			return fb;
 		}
 	}
-	return fb;
+
+	return NULL;
 }
 
 static void vp9_add_to_fb_free_list(struct vdec_vp9_inst *inst,
diff --git a/drivers/media/tuners/fc0011.c b/drivers/media/tuners/fc0011.c
index eaa3bbc903d7..3d3b54be2955 100644
--- a/drivers/media/tuners/fc0011.c
+++ b/drivers/media/tuners/fc0011.c
@@ -499,7 +499,7 @@ struct dvb_frontend *fc0011_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(fc0011_attach);
+EXPORT_SYMBOL_GPL(fc0011_attach);
 
 MODULE_DESCRIPTION("Fitipower FC0011 silicon tuner driver");
 MODULE_AUTHOR("Michael Buesch <m@bues.ch>");
diff --git a/drivers/media/tuners/fc0012.c b/drivers/media/tuners/fc0012.c
index 4429d5e8c579..81e65acbdb17 100644
--- a/drivers/media/tuners/fc0012.c
+++ b/drivers/media/tuners/fc0012.c
@@ -495,7 +495,7 @@ struct dvb_frontend *fc0012_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(fc0012_attach);
+EXPORT_SYMBOL_GPL(fc0012_attach);
 
 MODULE_DESCRIPTION("Fitipower FC0012 silicon tuner driver");
 MODULE_AUTHOR("Hans-Frieder Vogt <hfvogt@gmx.net>");
diff --git a/drivers/media/tuners/fc0013.c b/drivers/media/tuners/fc0013.c
index 29dd9b55ff33..1006a2798eef 100644
--- a/drivers/media/tuners/fc0013.c
+++ b/drivers/media/tuners/fc0013.c
@@ -608,7 +608,7 @@ struct dvb_frontend *fc0013_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(fc0013_attach);
+EXPORT_SYMBOL_GPL(fc0013_attach);
 
 MODULE_DESCRIPTION("Fitipower FC0013 silicon tuner driver");
 MODULE_AUTHOR("Hans-Frieder Vogt <hfvogt@gmx.net>");
diff --git a/drivers/media/tuners/max2165.c b/drivers/media/tuners/max2165.c
index 1c746bed51fe..1575ab94e1c8 100644
--- a/drivers/media/tuners/max2165.c
+++ b/drivers/media/tuners/max2165.c
@@ -410,7 +410,7 @@ struct dvb_frontend *max2165_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(max2165_attach);
+EXPORT_SYMBOL_GPL(max2165_attach);
 
 MODULE_AUTHOR("David T. L. Wong <davidtlwong@gmail.com>");
 MODULE_DESCRIPTION("Maxim MAX2165 silicon tuner driver");
diff --git a/drivers/media/tuners/mc44s803.c b/drivers/media/tuners/mc44s803.c
index 0c9161516abd..ed8bdf7ebd99 100644
--- a/drivers/media/tuners/mc44s803.c
+++ b/drivers/media/tuners/mc44s803.c
@@ -356,7 +356,7 @@ struct dvb_frontend *mc44s803_attach(struct dvb_frontend *fe,
 	kfree(priv);
 	return NULL;
 }
-EXPORT_SYMBOL(mc44s803_attach);
+EXPORT_SYMBOL_GPL(mc44s803_attach);
 
 MODULE_AUTHOR("Jochen Friedrich");
 MODULE_DESCRIPTION("Freescale MC44S803 silicon tuner driver");
diff --git a/drivers/media/tuners/mt2060.c b/drivers/media/tuners/mt2060.c
index 0e7ac2b49990..b59c5ba2ee58 100644
--- a/drivers/media/tuners/mt2060.c
+++ b/drivers/media/tuners/mt2060.c
@@ -440,7 +440,7 @@ struct dvb_frontend * mt2060_attach(struct dvb_frontend *fe, struct i2c_adapter
 
 	return fe;
 }
-EXPORT_SYMBOL(mt2060_attach);
+EXPORT_SYMBOL_GPL(mt2060_attach);
 
 static int mt2060_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
diff --git a/drivers/media/tuners/mt2131.c b/drivers/media/tuners/mt2131.c
index 37f50ff6c0bd..eebc06088341 100644
--- a/drivers/media/tuners/mt2131.c
+++ b/drivers/media/tuners/mt2131.c
@@ -274,7 +274,7 @@ struct dvb_frontend * mt2131_attach(struct dvb_frontend *fe,
 	fe->tuner_priv = priv;
 	return fe;
 }
-EXPORT_SYMBOL(mt2131_attach);
+EXPORT_SYMBOL_GPL(mt2131_attach);
 
 MODULE_AUTHOR("Steven Toth");
 MODULE_DESCRIPTION("Microtune MT2131 silicon tuner driver");
diff --git a/drivers/media/tuners/mt2266.c b/drivers/media/tuners/mt2266.c
index 6136f20fa9b7..2e92885a6bcb 100644
--- a/drivers/media/tuners/mt2266.c
+++ b/drivers/media/tuners/mt2266.c
@@ -336,7 +336,7 @@ struct dvb_frontend * mt2266_attach(struct dvb_frontend *fe, struct i2c_adapter
 	mt2266_calibrate(priv);
 	return fe;
 }
-EXPORT_SYMBOL(mt2266_attach);
+EXPORT_SYMBOL_GPL(mt2266_attach);
 
 MODULE_AUTHOR("Olivier DANET");
 MODULE_DESCRIPTION("Microtune MT2266 silicon tuner driver");
diff --git a/drivers/media/tuners/mxl5005s.c b/drivers/media/tuners/mxl5005s.c
index 1c07e2225fb3..cae6ded10b12 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -4114,7 +4114,7 @@ struct dvb_frontend *mxl5005s_attach(struct dvb_frontend *fe,
 	fe->tuner_priv = state;
 	return fe;
 }
-EXPORT_SYMBOL(mxl5005s_attach);
+EXPORT_SYMBOL_GPL(mxl5005s_attach);
 
 MODULE_DESCRIPTION("MaxLinear MXL5005S silicon tuner driver");
 MODULE_AUTHOR("Steven Toth");
diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
index 3853a3d43d4f..60931367b82c 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -440,7 +440,7 @@ struct dvb_frontend * qt1010_attach(struct dvb_frontend *fe,
 	fe->tuner_priv = priv;
 	return fe;
 }
-EXPORT_SYMBOL(qt1010_attach);
+EXPORT_SYMBOL_GPL(qt1010_attach);
 
 MODULE_DESCRIPTION("Quantek QT1010 silicon tuner driver");
 MODULE_AUTHOR("Antti Palosaari <crope@iki.fi>");
diff --git a/drivers/media/tuners/tda18218.c b/drivers/media/tuners/tda18218.c
index 4ed94646116f..7d8d84dcb245 100644
--- a/drivers/media/tuners/tda18218.c
+++ b/drivers/media/tuners/tda18218.c
@@ -336,7 +336,7 @@ struct dvb_frontend *tda18218_attach(struct dvb_frontend *fe,
 
 	return fe;
 }
-EXPORT_SYMBOL(tda18218_attach);
+EXPORT_SYMBOL_GPL(tda18218_attach);
 
 MODULE_DESCRIPTION("NXP TDA18218HN silicon tuner driver");
 MODULE_AUTHOR("Antti Palosaari <crope@iki.fi>");
diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index d9606738ce43..ef9af052007c 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -1744,7 +1744,7 @@ struct dvb_frontend *xc4000_attach(struct dvb_frontend *fe,
 	xc4000_release(fe);
 	return NULL;
 }
-EXPORT_SYMBOL(xc4000_attach);
+EXPORT_SYMBOL_GPL(xc4000_attach);
 
 MODULE_AUTHOR("Steven Toth, Davide Ferri");
 MODULE_DESCRIPTION("Xceive xc4000 silicon tuner driver");
diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index 7b7d9fe4f945..2182e5b7b606 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -1460,7 +1460,7 @@ struct dvb_frontend *xc5000_attach(struct dvb_frontend *fe,
 	xc5000_release(fe);
 	return NULL;
 }
-EXPORT_SYMBOL(xc5000_attach);
+EXPORT_SYMBOL_GPL(xc5000_attach);
 
 MODULE_AUTHOR("Steven Toth");
 MODULE_DESCRIPTION("Xceive xc5000 silicon tuner driver");
diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-usb/m920x.c
index 691e05833db1..da81fa189b5d 100644
--- a/drivers/media/usb/dvb-usb/m920x.c
+++ b/drivers/media/usb/dvb-usb/m920x.c
@@ -277,7 +277,6 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 			char *read = kmalloc(1, GFP_KERNEL);
 			if (!read) {
 				ret = -ENOMEM;
-				kfree(read);
 				goto unlock;
 			}
 
@@ -288,8 +287,10 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int nu
 
 				if ((ret = m920x_read(d->udev, M9206_I2C, 0x0,
 						      0x20 | stop,
-						      read, 1)) != 0)
+						      read, 1)) != 0) {
+					kfree(read);
 					goto unlock;
+				}
 				msg[i].buf[j] = read[0];
 			}
 
diff --git a/drivers/media/usb/go7007/go7007-i2c.c b/drivers/media/usb/go7007/go7007-i2c.c
index 38339dd2f83f..2880370e45c8 100644
--- a/drivers/media/usb/go7007/go7007-i2c.c
+++ b/drivers/media/usb/go7007/go7007-i2c.c
@@ -165,8 +165,6 @@ static int go7007_i2c_master_xfer(struct i2c_adapter *adapter,
 		} else if (msgs[i].len == 3) {
 			if (msgs[i].flags & I2C_M_RD)
 				return -EIO;
-			if (msgs[i].len != 3)
-				return -EIO;
 			if (go7007_i2c_xfer(go, msgs[i].addr, 0,
 					(msgs[i].buf[0] << 8) | msgs[i].buf[1],
 					0x01, &msgs[i].buf[2]) < 0)
diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 5c223b5498b4..6036ad3b1568 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -455,12 +455,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_register_device(&params, &dev->coredev, 0, mdev);
 	if (rc < 0) {
 		pr_err("smscore_register_device(...) failed, rc %d\n", rc);
-		smsusb_term_device(intf);
-#ifdef CONFIG_MEDIA_CONTROLLER_DVB
-		media_device_unregister(mdev);
-#endif
-		kfree(mdev);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	smscore_set_board_id(dev->coredev, board_id);
@@ -477,8 +472,7 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smsusb_start_streaming(dev);
 	if (rc < 0) {
 		pr_err("smsusb_start_streaming(...) failed\n");
-		smsusb_term_device(intf);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	dev->state = SMSUSB_ACTIVE;
@@ -486,13 +480,20 @@ static int smsusb_init_device(struct usb_interface *intf, int board_id)
 	rc = smscore_start_device(dev->coredev);
 	if (rc < 0) {
 		pr_err("smscore_start_device(...) failed\n");
-		smsusb_term_device(intf);
-		return rc;
+		goto err_unregister_device;
 	}
 
 	pr_debug("device 0x%p created\n", dev);
 
 	return rc;
+
+err_unregister_device:
+	smsusb_term_device(intf);
+#ifdef CONFIG_MEDIA_CONTROLLER_DVB
+	media_device_unregister(mdev);
+#endif
+	kfree(mdev);
+	return rc;
 }
 
 static int smsusb_probe(struct usb_interface *intf,
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index dfc53d11053f..1977ce0195fe 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -572,19 +572,29 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 	link->local_id = fwep.id;
 	link->local_port = fwep.port;
 	link->local_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->local_node)
+		return -ENOLINK;
 
 	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
-	if (!fwnode) {
-		fwnode_handle_put(fwnode);
-		return -ENOLINK;
-	}
+	if (!fwnode)
+		goto err_put_local_node;
 
 	fwnode_graph_parse_endpoint(fwnode, &fwep);
 	link->remote_id = fwep.id;
 	link->remote_port = fwep.port;
 	link->remote_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->remote_node)
+		goto err_put_remote_endpoint;
 
 	return 0;
+
+err_put_remote_endpoint:
+	fwnode_handle_put(fwnode);
+
+err_put_local_node:
+	fwnode_handle_put(link->local_node);
+
+	return -ENOLINK;
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_link);
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 82e1fbd6b2ff..a5b2bf0e40cc 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -520,11 +520,12 @@ config MMC_ALCOR
 	  of Alcor Micro PCI-E card reader
 
 config MMC_AU1X
-	tristate "Alchemy AU1XX0 MMC Card Interface support"
+	bool "Alchemy AU1XX0 MMC Card Interface support"
 	depends on MIPS_ALCHEMY
+	depends on MMC=y
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
-	  If you have a Alchemy platform with a MMC slot, say Y or M here.
+	  If you have a Alchemy platform with a MMC slot, say Y here.
 
 	  If unsure, say N.
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 580b91cbd18d..e170c545fec5 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1040,6 +1040,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
 		cpu_relax();
 	} while (time_after(limit, jiffies));
 
+	/*
+	 * do a final check after time out in case the CPU was busy and the driver
+	 * did not get enough time to perform the polling to avoid false alarms
+	 */
+	val = brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS);
+	if ((val & mask) == expected_val)
+		return 0;
+
 	dev_warn(ctrl->dev, "timeout on status poll (expected %x got %x)\n",
 		 expected_val, val & mask);
 
@@ -1429,19 +1437,33 @@ static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
 			     const u8 *oob, int sas, int sector_1k)
 {
 	int tbytes = sas << sector_1k;
-	int j;
+	int j, k = 0;
+	u32 last = 0xffffffff;
+	u8 *plast = (u8 *)&last;
 
 	/* Adjust OOB values for 1K sector size */
 	if (sector_1k && (i & 0x01))
 		tbytes = max(0, tbytes - (int)ctrl->max_oob);
 	tbytes = min_t(int, tbytes, ctrl->max_oob);
 
-	for (j = 0; j < tbytes; j += 4)
+	/*
+	 * tbytes may not be multiple of words. Make sure we don't read out of
+	 * the boundary and stop at last word.
+	 */
+	for (j = 0; (j + 3) < tbytes; j += 4)
 		oob_reg_write(ctrl, j,
 				(oob[j + 0] << 24) |
 				(oob[j + 1] << 16) |
 				(oob[j + 2] <<  8) |
 				(oob[j + 3] <<  0));
+
+	/* handle the remaing bytes */
+	while (j < tbytes)
+		plast[k++] = oob[j++];
+
+	if (tbytes & 0x3)
+		oob_reg_write(ctrl, (tbytes & ~0x3), (__force u32)cpu_to_be32(last));
+
 	return tbytes;
 }
 
@@ -1543,7 +1565,17 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
 
 	dev_dbg(ctrl->dev, "send native cmd %d addr 0x%llx\n", cmd, cmd_addr);
 
-	BUG_ON(ctrl->cmd_pending != 0);
+	/*
+	 * If we came here through _panic_write and there is a pending
+	 * command, try to wait for it. If it times out, rather than
+	 * hitting BUG_ON, just return so we don't crash while crashing.
+	 */
+	if (oops_in_progress) {
+		if (ctrl->cmd_pending &&
+			bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0))
+			return;
+	} else
+		BUG_ON(ctrl->cmd_pending != 0);
 	ctrl->cmd_pending = cmd;
 
 	ret = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY, NAND_CTRL_RDY, 0);
@@ -2534,6 +2566,8 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	struct nand_chip *chip = &host->chip;
 	const struct nand_ecc_props *requirements =
 		nanddev_get_ecc_requirements(&chip->base);
+	struct nand_memory_organization *memorg =
+		nanddev_get_memorg(&chip->base);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
 	char msg[128];
@@ -2555,10 +2589,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	if (cfg->spare_area_size > ctrl->max_oob)
 		cfg->spare_area_size = ctrl->max_oob;
 	/*
-	 * Set oobsize to be consistent with controller's spare_area_size, as
-	 * the rest is inaccessible.
+	 * Set mtd and memorg oobsize to be consistent with controller's
+	 * spare_area_size, as the rest is inaccessible.
 	 */
 	mtd->oobsize = cfg->spare_area_size * (mtd->writesize >> FC_SHIFT);
+	memorg->oobsize = mtd->oobsize;
 
 	cfg->device_size = mtd->size;
 	cfg->block_size = mtd->erasesize;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 663ff5300ad9..3da66e95e5b7 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1190,9 +1190,14 @@ static int fsmc_nand_suspend(struct device *dev)
 static int fsmc_nand_resume(struct device *dev)
 {
 	struct fsmc_nand_data *host = dev_get_drvdata(dev);
+	int ret;
 
 	if (host) {
-		clk_prepare_enable(host->clk);
+		ret = clk_prepare_enable(host->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable clk\n");
+			return ret;
+		}
 		if (host->dev_timings)
 			fsmc_nand_setup(host, host->dev_timings);
 		nand_reset(&host->nand, 0);
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 342215231932..09e112f37691 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -800,21 +800,22 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 		ret = spi_nor_read_cr(nor, &sr_cr[1]);
 		if (ret)
 			return ret;
-	} else if (nor->params->quad_enable) {
+	} else if (spi_nor_get_protocol_width(nor->read_proto) == 4 &&
+		   spi_nor_get_protocol_width(nor->write_proto) == 4 &&
+		   nor->params->quad_enable) {
 		/*
 		 * If the Status Register 2 Read command (35h) is not
 		 * supported, we should at least be sure we don't
 		 * change the value of the SR2 Quad Enable bit.
 		 *
-		 * We can safely assume that when the Quad Enable method is
-		 * set, the value of the QE bit is one, as a consequence of the
-		 * nor->params->quad_enable() call.
+		 * When the Quad Enable method is set and the buswidth is 4, we
+		 * can safely assume that the value of the QE bit is one, as a
+		 * consequence of the nor->params->quad_enable() call.
 		 *
-		 * We can safely assume that the Quad Enable bit is present in
-		 * the Status Register 2 at BIT(1). According to the JESD216
-		 * revB standard, BFPT DWORDS[15], bits 22:20, the 16-bit
-		 * Write Status (01h) command is available just for the cases
-		 * in which the QE bit is described in SR2 at BIT(1).
+		 * According to the JESD216 revB standard, BFPT DWORDS[15],
+		 * bits 22:20, the 16-bit Write Status (01h) command is
+		 * available just for the cases in which the QE bit is
+		 * described in SR2 at BIT(1).
 		 */
 		sr_cr[1] = SR2_QUAD_EN_BIT1;
 	} else {
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index d76dd7d14299..a7899405a51a 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -468,7 +468,7 @@ static void arcnet_reply_tasklet(unsigned long data)
 
 	ret = sock_queue_err_skb(sk, ackskb);
 	if (ret)
-		kfree_skb(ackskb);
+		dev_kfree_skb_irq(ackskb);
 
 	local_irq_enable();
 };
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1f81293f137c..864db200f45e 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -381,6 +381,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
 			goto resubmit_urb;
@@ -388,8 +391,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->can_dlc = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		stats->rx_over_errors++;
-		stats->rx_errors++;
 		netif_rx(skb);
 	}
 
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c03d76c10868..4362fe0f346d 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1691,6 +1691,18 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 
 #define BYTES_PER_KBIT (1000LL / 8)
 
+static int sja1105_find_cbs_shaper(struct sja1105_private *priv,
+				   int port, int prio)
+{
+	int i;
+
+	for (i = 0; i < priv->info->num_cbs_shapers; i++)
+		if (priv->cbs[i].port == port && priv->cbs[i].prio == prio)
+			return i;
+
+	return -1;
+}
+
 static int sja1105_find_unused_cbs_shaper(struct sja1105_private *priv)
 {
 	int i;
@@ -1725,14 +1737,20 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
 {
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_cbs_entry *cbs;
+	s64 port_transmit_rate_kbps;
 	int index;
 
 	if (!offload->enable)
 		return sja1105_delete_cbs_shaper(priv, port, offload->queue);
 
-	index = sja1105_find_unused_cbs_shaper(priv);
-	if (index < 0)
-		return -ENOSPC;
+	/* The user may be replacing an existing shaper */
+	index = sja1105_find_cbs_shaper(priv, port, offload->queue);
+	if (index < 0) {
+		/* That isn't the case - see if we can allocate a new one */
+		index = sja1105_find_unused_cbs_shaper(priv);
+		if (index < 0)
+			return -ENOSPC;
+	}
 
 	cbs = &priv->cbs[index];
 	cbs->port = port;
@@ -1742,9 +1760,17 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
 	 */
 	cbs->credit_hi = offload->hicredit;
 	cbs->credit_lo = abs(offload->locredit);
-	/* User space is in kbits/sec, hardware in bytes/sec */
-	cbs->idle_slope = offload->idleslope * BYTES_PER_KBIT;
-	cbs->send_slope = abs(offload->sendslope * BYTES_PER_KBIT);
+	/* User space is in kbits/sec, while the hardware in bytes/sec times
+	 * link speed. Since the given offload->sendslope is good only for the
+	 * current link speed anyway, and user space is likely to reprogram it
+	 * when that changes, don't even bother to track the port's link speed,
+	 * but deduce the port transmit rate from idleslope - sendslope.
+	 */
+	port_transmit_rate_kbps = offload->idleslope - offload->sendslope;
+	cbs->idle_slope = div_s64(offload->idleslope * BYTES_PER_KBIT,
+				  port_transmit_rate_kbps);
+	cbs->send_slope = div_s64(abs(offload->sendslope * BYTES_PER_KBIT),
+				  port_transmit_rate_kbps);
 	/* Convert the negative values from 64-bit 2's complement
 	 * to 32-bit 2's complement (for the case of 0x80000000 whose
 	 * negative is still negative).
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 3f65f2b370c5..2c5af0d7666a 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1987,8 +1987,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index afb6d3ee1f56..c8cbf3ed128d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14372,11 +14372,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
 	bp->fw_seq = SHMEM_RD(bp, func_mb[BP_FW_MB_IDX(bp)].drv_mb_header) &
 							DRV_MSG_SEQ_NUMBER_MASK;
 
-	if (netif_running(dev))
-		bnx2x_nic_load(bp, LOAD_NORMAL);
+	if (netif_running(dev)) {
+		if (bnx2x_nic_load(bp, LOAD_NORMAL)) {
+			netdev_err(bp->dev, "Error during driver initialization, try unloading/reloading the driver\n");
+			goto done;
+		}
+	}
 
 	netif_device_attach(dev);
 
+done:
 	rtnl_unlock();
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index bc594892507a..8c3661525694 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -8,7 +8,7 @@
 #include "enetc.h"
 
 int enetc_phc_index = -1;
-EXPORT_SYMBOL(enetc_phc_index);
+EXPORT_SYMBOL_GPL(enetc_phc_index);
 
 static struct ptp_clock_info enetc_ptp_caps = {
 	.owner		= THIS_MODULE,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index cd0d7a546957..d35f4b2b480e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -704,7 +704,9 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		hns3_get_ksettings(h, cmd);
 		break;
 	case HNAE3_MEDIA_TYPE_FIBER:
-		if (module_type == HNAE3_MODULE_TYPE_CR)
+		if (module_type == HNAE3_MODULE_TYPE_UNKNOWN)
+			cmd->base.port = PORT_OTHER;
+		else if (module_type == HNAE3_MODULE_TYPE_CR)
 			cmd->base.port = PORT_DA;
 		else
 			cmd->base.port = PORT_FIBRE;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4f0d63fa5709..d2ee760f9294 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1137,6 +1137,7 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 				struct ice_rq_event_info *event)
 {
+	struct ice_rq_event_info *task_ev;
 	struct ice_aq_task *task;
 	bool found = false;
 
@@ -1145,15 +1146,15 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 		if (task->state || task->opcode != opcode)
 			continue;
 
-		memcpy(&task->event->desc, &event->desc, sizeof(event->desc));
-		task->event->msg_len = event->msg_len;
+		task_ev = task->event;
+		memcpy(&task_ev->desc, &event->desc, sizeof(event->desc));
+		task_ev->msg_len = event->msg_len;
 
 		/* Only copy the data buffer if a destination was set */
-		if (task->event->msg_buf &&
-		    task->event->buf_len > event->buf_len) {
-			memcpy(task->event->msg_buf, event->msg_buf,
+		if (task_ev->msg_buf && task_ev->buf_len >= event->buf_len) {
+			memcpy(task_ev->msg_buf, event->msg_buf,
 			       event->buf_len);
-			task->event->buf_len = event->buf_len;
+			task_ev->buf_len = event->buf_len;
 		}
 
 		task->state = ICE_AQ_TASK_COMPLETE;
diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index e6d2800a8abc..da0e3897e683 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -34,11 +34,11 @@ struct igb_adapter;
 /* TX/RX descriptor defines */
 #define IGB_DEFAULT_TXD		256
 #define IGB_DEFAULT_TX_WORK	128
-#define IGB_MIN_TXD		80
+#define IGB_MIN_TXD		64
 #define IGB_MAX_TXD		4096
 
 #define IGB_DEFAULT_RXD		256
-#define IGB_MIN_RXD		80
+#define IGB_MIN_RXD		64
 #define IGB_MAX_RXD		4096
 
 #define IGB_DEFAULT_ITR		3 /* dynamic */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 446598210012..01176c86be12 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3857,8 +3857,9 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	struct pci_dev *pdev = adapter->pdev;
 	struct e1000_hw *hw = &adapter->hw;
 
-	/* Virtualization features not supported on i210 family. */
-	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
+	/* Virtualization features not supported on i210 and 82580 family. */
+	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
+	    (hw->mac.type == e1000_82580))
 		return;
 
 	/* Of the below we really only want the effect of getting
@@ -4731,6 +4732,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
 static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 				  struct igb_ring *rx_ring)
 {
+#if (PAGE_SIZE < 8192)
+	struct e1000_hw *hw = &adapter->hw;
+#endif
+
 	/* set build_skb and buffer size flags */
 	clear_ring_build_skb_enabled(rx_ring);
 	clear_ring_uses_large_buffer(rx_ring);
@@ -4741,10 +4746,9 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
 	set_ring_build_skb_enabled(rx_ring);
 
 #if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		return;
-
-	set_ring_uses_large_buffer(rx_ring);
+	if (adapter->max_frame_size > IGB_MAX_FRAME_BUILD_SKB ||
+	    rd32(E1000_RCTL) & E1000_RCTL_SBP)
+		set_ring_uses_large_buffer(rx_ring);
 #endif
 }
 
diff --git a/drivers/net/ethernet/intel/igbvf/igbvf.h b/drivers/net/ethernet/intel/igbvf/igbvf.h
index 975eb47ee04d..b39fca9827dc 100644
--- a/drivers/net/ethernet/intel/igbvf/igbvf.h
+++ b/drivers/net/ethernet/intel/igbvf/igbvf.h
@@ -39,11 +39,11 @@ enum latency_range {
 /* Tx/Rx descriptor defines */
 #define IGBVF_DEFAULT_TXD	256
 #define IGBVF_MAX_TXD		4096
-#define IGBVF_MIN_TXD		80
+#define IGBVF_MIN_TXD		64
 
 #define IGBVF_DEFAULT_RXD	256
 #define IGBVF_MAX_RXD		4096
-#define IGBVF_MIN_RXD		80
+#define IGBVF_MIN_RXD		64
 
 #define IGBVF_MIN_ITR_USECS	10 /* 100000 irq/sec */
 #define IGBVF_MAX_ITR_USECS	10000 /* 100    irq/sec */
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 33f64c80335d..31af08ceb36b 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -319,11 +319,11 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
 /* TX/RX descriptor defines */
 #define IGC_DEFAULT_TXD		256
 #define IGC_DEFAULT_TX_WORK	128
-#define IGC_MIN_TXD		80
+#define IGC_MIN_TXD		64
 #define IGC_MAX_TXD		4096
 
 #define IGC_DEFAULT_RXD		256
-#define IGC_MIN_RXD		80
+#define IGC_MIN_RXD		64
 #define IGC_MAX_RXD		4096
 
 /* Supported Rx Buffer Sizes */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 8b7f30035571..3eb2c05361e8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -989,6 +989,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	u32 tsync_tx_ctl = IXGBE_TSYNCTXCTL_ENABLED;
 	u32 tsync_rx_ctl = IXGBE_TSYNCRXCTL_ENABLED;
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	u32 aflags = adapter->flags;
 	bool is_l2 = false;
 	u32 regval;
 
@@ -1009,20 +1010,20 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	case HWTSTAMP_FILTER_NONE:
 		tsync_rx_ctl = 0;
 		tsync_rx_mtrl = 0;
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= IXGBE_RXMTRL_V1_SYNC_MSG;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_L4_V1;
 		tsync_rx_mtrl |= IXGBE_RXMTRL_V1_DELAY_REQ_MSG;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
@@ -1036,8 +1037,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_EVENT_V2;
 		is_l2 = true;
 		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
-		adapter->flags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
+		aflags |= (IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
+			   IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_NTP_ALL:
@@ -1048,7 +1049,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		if (hw->mac.type >= ixgbe_mac_X550) {
 			tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_ALL;
 			config->rx_filter = HWTSTAMP_FILTER_ALL;
-			adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+			aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
 			break;
 		}
 		fallthrough;
@@ -1059,8 +1060,6 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		 * Delay_Req messages and hardware does not support
 		 * timestamping all packets => return error
 		 */
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		config->rx_filter = HWTSTAMP_FILTER_NONE;
 		return -ERANGE;
 	}
@@ -1092,8 +1091,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 			       IXGBE_TSYNCRXCTL_TYPE_ALL |
 			       IXGBE_TSYNCRXCTL_TSIP_UT_EN;
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
-		adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
-		adapter->flags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
+		aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+		aflags &= ~IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER;
 		is_l2 = true;
 		break;
 	default:
@@ -1126,6 +1125,9 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 
 	IXGBE_WRITE_FLUSH(hw);
 
+	/* configure adapter flags only when HW is actually configured */
+	adapter->flags = aflags;
+
 	/* clear TX/RX time stamp registers, just to be sure */
 	ixgbe_ptp_clear_tx_timestamp(adapter);
 	IXGBE_READ_REG(hw, IXGBE_RXSTMPH);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 68c5ed8716c8..e0e6275b3e20 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5201,6 +5201,11 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		for (i = 0; i < MVPP2_N_RFS_ENTRIES_PER_FLOW; i++) {
+			if (loc == info->rule_cnt) {
+				ret = -EMSGSIZE;
+				break;
+			}
+
 			if (port->rfs_rules[i])
 				rules[loc++] = i;
 		}
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index a8319295f1ab..aa9e616cc1d5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2013,6 +2013,9 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
 	int i;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+
 		if (mac->hwlro_ip[i]) {
 			rule_locs[cnt] = i;
 			cnt++;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index e29db4c39b37..a2d9904e1049 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -279,16 +279,11 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
 		pci_cfg_access_lock(sdev);
 	}
 	/* PCI link toggle */
-	err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
-	if (err)
-		return err;
-	reg16 |= PCI_EXP_LNKCTL_LD;
-	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
+	err = pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
 		return err;
 	msleep(500);
-	reg16 &= ~PCI_EXP_LNKCTL_LD;
-	err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
+	err = pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index ce843ea91464..61d2f621d65f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -47,6 +47,7 @@
 #define MLXSW_I2C_MBOX_SIZE_BITS	12
 #define MLXSW_I2C_ADDR_BUF_SIZE		4
 #define MLXSW_I2C_BLK_DEF		32
+#define MLXSW_I2C_BLK_MAX		100
 #define MLXSW_I2C_RETRY			5
 #define MLXSW_I2C_TIMEOUT_MSECS		5000
 #define MLXSW_I2C_MAX_DATA_SIZE		256
@@ -428,7 +429,7 @@ mlxsw_i2c_cmd(struct device *dev, u16 opcode, u32 in_mod, size_t in_mbox_size,
 	} else {
 		/* No input mailbox is case of initialization query command. */
 		reg_size = MLXSW_I2C_MAX_DATA_SIZE;
-		num = reg_size / mlxsw_i2c->block_size;
+		num = DIV_ROUND_UP(reg_size, mlxsw_i2c->block_size);
 
 		if (mutex_lock_interruptible(&mlxsw_i2c->cmd.lock) < 0) {
 			dev_err(&client->dev, "Could not acquire lock");
@@ -576,7 +577,7 @@ static int mlxsw_i2c_probe(struct i2c_client *client,
 			return -EOPNOTSUPP;
 		}
 
-		mlxsw_i2c->block_size = max_t(u16, MLXSW_I2C_BLK_DEF,
+		mlxsw_i2c->block_size = min_t(u16, MLXSW_I2C_BLK_MAX,
 					      min_t(u16, quirks->max_read_len,
 						    quirks->max_write_len));
 	} else {
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 2ad15b1d7ffd..4fb58fc5ec95 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1347,8 +1347,7 @@ static struct crypto_aead *macsec_alloc_tfm(char *key, int key_len, int icv_len)
 	struct crypto_aead *tfm;
 	int ret;
 
-	/* Pick a sync gcm(aes) cipher to ensure order is preserved. */
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
 
 	if (IS_ERR(tfm))
 		return tfm;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index de6c56153534..5cf7f389bf4e 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1351,6 +1351,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f9a79d67d6d4..cc7c86debfa2 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2439,6 +2439,9 @@ static int r8152_poll(struct napi_struct *napi, int budget)
 	struct r8152 *tp = container_of(napi, struct r8152, napi);
 	int work_done;
 
+	if (!budget)
+		return 0;
+
 	work_done = rx_bottom(tp, budget);
 
 	if (work_done < budget) {
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 4ba86fa4d649..743716ebebdb 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -285,6 +285,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
+	int ret = NETDEV_TX_OK;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool rcv_xdp = false;
@@ -311,6 +312,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
+		ret = NET_XMIT_DROP;
 	}
 
 	if (rcv_xdp)
@@ -318,7 +320,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rcu_read_unlock();
 
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static u64 veth_stats_tx(struct net_device *dev, u64 *packets, u64 *bytes)
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1ac9de69bde6..3096769e718e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -729,6 +729,32 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
 	return 1;
 }
 
+static bool vxlan_parse_gpe_proto(struct vxlanhdr *hdr, __be16 *protocol)
+{
+	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)hdr;
+
+	/* Need to have Next Protocol set for interfaces in GPE mode. */
+	if (!gpe->np_applied)
+		return false;
+	/* "The initial version is 0. If a receiver does not support the
+	 * version indicated it MUST drop the packet.
+	 */
+	if (gpe->version != 0)
+		return false;
+	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
+	 * processing MUST occur." However, we don't implement OAM
+	 * processing, thus drop the packet.
+	 */
+	if (gpe->oam_flag)
+		return false;
+
+	*protocol = tun_p_to_eth_p(gpe->next_protocol);
+	if (!*protocol)
+		return false;
+
+	return true;
+}
+
 static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 					  unsigned int off,
 					  struct vxlanhdr *vh, size_t hdrlen,
@@ -1737,35 +1763,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
 	unparsed->vx_flags &= ~VXLAN_GBP_USED_BITS;
 }
 
-static bool vxlan_parse_gpe_hdr(struct vxlanhdr *unparsed,
-				__be16 *protocol,
-				struct sk_buff *skb, u32 vxflags)
-{
-	struct vxlanhdr_gpe *gpe = (struct vxlanhdr_gpe *)unparsed;
-
-	/* Need to have Next Protocol set for interfaces in GPE mode. */
-	if (!gpe->np_applied)
-		return false;
-	/* "The initial version is 0. If a receiver does not support the
-	 * version indicated it MUST drop the packet.
-	 */
-	if (gpe->version != 0)
-		return false;
-	/* "When the O bit is set to 1, the packet is an OAM packet and OAM
-	 * processing MUST occur." However, we don't implement OAM
-	 * processing, thus drop the packet.
-	 */
-	if (gpe->oam_flag)
-		return false;
-
-	*protocol = tun_p_to_eth_p(gpe->next_protocol);
-	if (!*protocol)
-		return false;
-
-	unparsed->vx_flags &= ~VXLAN_GPE_USED_BITS;
-	return true;
-}
-
 static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 			  struct vxlan_sock *vs,
 			  struct sk_buff *skb, __be32 vni)
@@ -1866,8 +1863,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vs->flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_hdr(&unparsed, &protocol, skb, vs->flags))
+		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
 			goto drop;
+		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 67e240327fb3..2c8f04b415c7 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1963,8 +1963,9 @@ static int ath10k_pci_hif_start(struct ath10k *ar)
 	ath10k_pci_irq_enable(ar);
 	ath10k_pci_rx_post(ar);
 
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl);
+	pcie_capability_clear_and_set_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   ar_pci->link_ctl & PCI_EXP_LNKCTL_ASPMC);
 
 	return 0;
 }
@@ -2820,8 +2821,8 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 
 	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
 				  &ar_pci->link_ctl);
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	/*
 	 * Bring the target up cleanly.
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da..c55aab01fff5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -491,7 +491,7 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (!priv->debug.debugfs_phy)
+	if (IS_ERR(priv->debug.debugfs_phy))
 		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index d652c647d56b..1476b42b52a9 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -242,10 +242,10 @@ static void ath9k_wmi_ctrl_rx(void *priv, struct sk_buff *skb,
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		goto free_skb;
 	}
-	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 	/* WMI command response */
 	ath9k_wmi_rsp_callback(wmi, skb);
+	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
 free_skb:
 	kfree_skb(skb);
@@ -283,7 +283,8 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 
 static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 			       struct sk_buff *skb,
-			       enum wmi_cmd_id cmd, u16 len)
+			       enum wmi_cmd_id cmd, u16 len,
+			       u8 *rsp_buf, u32 rsp_len)
 {
 	struct wmi_cmd_hdr *hdr;
 	unsigned long flags;
@@ -293,6 +294,11 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	hdr->seq_no = cpu_to_be16(++wmi->tx_seq_id);
 
 	spin_lock_irqsave(&wmi->wmi_lock, flags);
+
+	/* record the rsp buffer and length */
+	wmi->cmd_rsp_buf = rsp_buf;
+	wmi->cmd_rsp_len = rsp_len;
+
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
@@ -308,8 +314,8 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	struct ath_common *common = ath9k_hw_common(ah);
 	u16 headroom = sizeof(struct htc_frame_hdr) +
 		       sizeof(struct wmi_cmd_hdr);
+	unsigned long time_left, flags;
 	struct sk_buff *skb;
-	unsigned long time_left;
 	int ret = 0;
 
 	if (ah->ah_flags & AH_UNPLUGGED)
@@ -333,11 +339,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		goto out;
 	}
 
-	/* record the rsp buffer and length */
-	wmi->cmd_rsp_buf = rsp_buf;
-	wmi->cmd_rsp_len = rsp_len;
-
-	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len);
+	ret = ath9k_wmi_cmd_issue(wmi, skb, cmd_id, cmd_len, rsp_buf, rsp_len);
 	if (ret)
 		goto out;
 
@@ -345,7 +347,9 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 	if (!time_left) {
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
+		spin_lock_irqsave(&wmi->wmi_lock, flags);
 		wmi->last_seq_id = 0;
+		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 		mutex_unlock(&wmi->op_mutex);
 		return -ETIMEDOUT;
 	}
diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index dded92db1f37..1e7dc724c6a9 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -265,8 +265,11 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	if (!p)
 		return -ENOMEM;
 
-	if (!priv || !priv->hist_data)
-		return -EFAULT;
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
 	phist_data = priv->hist_data;
 
 	p += sprintf(p, "\n"
@@ -321,6 +324,8 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
 				      (unsigned long)p - page);
 
+free_and_exit:
+	free_page(page);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 50c34630ca30..7cec6398da71 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -200,6 +200,8 @@ static int mwifiex_pcie_probe_of(struct device *dev)
 }
 
 static void mwifiex_pcie_work(struct work_struct *work);
+static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter);
+static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter);
 
 static int
 mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
@@ -794,14 +796,15 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for RX ring.\n");
-			kfree(card->rxbd_ring_vbase);
 			return -ENOMEM;
 		}
 
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   DMA_FROM_DEVICE))
-			return -1;
+					   DMA_FROM_DEVICE)) {
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
 
@@ -851,7 +854,6 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for EVENT buf.\n");
-			kfree(card->evtbd_ring_vbase);
 			return -ENOMEM;
 		}
 		skb_put(skb, MAX_EVENT_SIZE);
@@ -859,8 +861,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
 					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
-			kfree(card->evtbd_ring_vbase);
-			return -1;
+			return -ENOMEM;
 		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -1060,6 +1061,7 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -1098,7 +1100,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->rxbd_ring_pbase >> 32),
 		    card->rxbd_ring_size);
 
-	return mwifiex_init_rxq_ring(adapter);
+	ret = mwifiex_init_rxq_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_rxbd_ring(adapter);
+	return ret;
 }
 
 /*
@@ -1129,6 +1134,7 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -1163,7 +1169,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->evtbd_ring_pbase >> 32),
 		    card->evtbd_ring_size);
 
-	return mwifiex_pcie_init_evt_ring(adapter);
+	ret = mwifiex_pcie_init_evt_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_evtbd_ring(adapter);
+	return ret;
 }
 
 /*
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_rx.c b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
index 0d2adf887900..3c555946cb2c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_rx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_rx.c
@@ -98,6 +98,15 @@ int mwifiex_process_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_len = le16_to_cpu(local_rx_pd->rx_pkt_length);
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_off;
 
+	if (sizeof(*rx_pkt_hdr) + rx_pkt_off > skb->len) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "wrong rx packet offset: len=%d, rx_pkt_off=%d\n",
+			    skb->len, rx_pkt_off);
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return -1;
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -206,7 +215,8 @@ int mwifiex_process_sta_rx_packet(struct mwifiex_private *priv,
 
 	rx_pkt_hdr = (void *)local_rx_pd + rx_pkt_offset;
 
-	if ((rx_pkt_offset + rx_pkt_length) > (u16) skb->len) {
+	if ((rx_pkt_offset + rx_pkt_length) > skb->len ||
+	    sizeof(rx_pkt_hdr->eth803_hdr) + rx_pkt_offset > skb->len) {
 		mwifiex_dbg(adapter, ERROR,
 			    "wrong rx packet: len=%d, rx_pkt_offset=%d, rx_pkt_length=%d\n",
 			    skb->len, rx_pkt_offset, rx_pkt_length);
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
index 9bbdb8dfce62..780ea467471f 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
@@ -115,6 +115,16 @@ static void mwifiex_uap_queue_bridged_pkt(struct mwifiex_private *priv,
 		return;
 	}
 
+	if (sizeof(*rx_pkt_hdr) +
+	    le16_to_cpu(uap_rx_pd->rx_pkt_offset) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet offset: len=%d,rx_pkt_offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
 	if ((!memcmp(&rx_pkt_hdr->rfc1042_hdr, bridge_tunnel_header,
 		     sizeof(bridge_tunnel_header))) ||
 	    (!memcmp(&rx_pkt_hdr->rfc1042_hdr, rfc1042_header,
@@ -255,7 +265,15 @@ int mwifiex_handle_uap_rx_forward(struct mwifiex_private *priv,
 
 	if (is_multicast_ether_addr(ra)) {
 		skb_uap = skb_copy(skb, GFP_ATOMIC);
-		mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		if (likely(skb_uap)) {
+			mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
+		} else {
+			mwifiex_dbg(adapter, ERROR,
+				    "failed to copy skb for uAP\n");
+			priv->stats.rx_dropped++;
+			dev_kfree_skb_any(skb);
+			return -1;
+		}
 	} else {
 		if (mwifiex_get_sta_entry(priv, ra)) {
 			/* Requeue Intra-BSS packet */
@@ -379,6 +397,16 @@ int mwifiex_process_uap_rx_packet(struct mwifiex_private *priv,
 	rx_pkt_type = le16_to_cpu(uap_rx_pd->rx_pkt_type);
 	rx_pkt_hdr = (void *)uap_rx_pd + le16_to_cpu(uap_rx_pd->rx_pkt_offset);
 
+	if (le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
+	    sizeof(rx_pkt_hdr->eth803_hdr) > skb->len) {
+		mwifiex_dbg(adapter, ERROR,
+			    "wrong rx packet for struct ethhdr: len=%d, offset=%d\n",
+			    skb->len, le16_to_cpu(uap_rx_pd->rx_pkt_offset));
+		priv->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
 	ether_addr_copy(ta, rx_pkt_hdr->eth803_hdr.h_source);
 
 	if ((le16_to_cpu(uap_rx_pd->rx_pkt_offset) +
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index d583fa600a29..1f5a6dab9ce5 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -405,11 +405,15 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 	}
 
 	rx_pd = (struct rxpd *)skb->data;
+	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	if (pkt_len < sizeof(struct ieee80211_hdr) + sizeof(pkt_len)) {
+		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
+		return -1;
+	}
 
 	skb_pull(skb, le16_to_cpu(rx_pd->rx_pkt_offset));
 	skb_pull(skb, sizeof(pkt_len));
-
-	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
+	pkt_len -= sizeof(pkt_len);
 
 	ieee_hdr = (void *)skb->data;
 	if (ieee80211_is_mgmt(ieee_hdr->frame_control)) {
@@ -422,7 +426,7 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 		skb->data + sizeof(struct ieee80211_hdr),
 		pkt_len - sizeof(struct ieee80211_hdr));
 
-	pkt_len -= ETH_ALEN + sizeof(pkt_len);
+	pkt_len -= ETH_ALEN;
 	rx_pd->rx_pkt_length = cpu_to_le16(pkt_len);
 
 	cfg80211_rx_mgmt(&priv->wdev, priv->roc_cfg.chan.center_freq,
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 883f59c7a7e4..7ab99efb7f9b 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -6,6 +6,7 @@ static const struct nla_policy mt76_tm_policy[NUM_MT76_TM_ATTRS] = {
 	[MT76_TM_ATTR_RESET] = { .type = NLA_FLAG },
 	[MT76_TM_ATTR_STATE] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_COUNT] = { .type = NLA_U32 },
+	[MT76_TM_ATTR_TX_LENGTH] = { .type = NLA_U32 },
 	[MT76_TM_ATTR_TX_RATE_MODE] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_RATE_NSS] = { .type = NLA_U8 },
 	[MT76_TM_ATTR_TX_RATE_IDX] = { .type = NLA_U8 },
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d18cb4476560..859570017ef3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -911,7 +911,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	return 0;
 }
 
-static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
 	qp->active = false;
@@ -934,6 +934,13 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 	qp->tx_async = 0;
 }
 
+static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+{
+	ntb_qp_link_context_reset(qp);
+	if (qp->remote_rx_info)
+		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -1176,7 +1183,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
-	ntb_qp_link_down_reset(qp);
+	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
 		num_qps_mw = qp_count / mw_count + 1;
@@ -2278,9 +2285,13 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || !qp->link_is_up || !len)
+	if (!qp || !len)
 		return -EINVAL;
 
+	/* If the qp link is down already, just ignore. */
+	if (!qp->link_is_up)
+		return 0;
+
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;
@@ -2420,7 +2431,7 @@ unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 	unsigned int head = qp->tx_index;
 	unsigned int tail = qp->remote_rx_info->entry;
 
-	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 5407bbdb6439..412d7ddb3b8b 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -69,7 +69,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find /testcase-data failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -80,14 +80,14 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find /testcase-data/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
 
 	np = of_find_node_by_path("testcase-alias");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find testcase-alias failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -98,7 +98,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("testcase-alias/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find testcase-alias/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -1376,6 +1376,8 @@ static void attach_node_and_children(struct device_node *np)
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!full_name)
+		return;
 
 	if (!strcmp(full_name, "/__local_fixups__") ||
 	    !strcmp(full_name, "/__fixups__")) {
@@ -2065,7 +2067,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 	of_unittest_untrack_overlay(save_id);
 
 	/* unittest device must be again in before state */
-	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
+	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
 		unittest(0, "%s with device @\"%s\" %s\n",
 				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7ed605ffb717..7999baa075b0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2053,7 +2053,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
 		if (IS_ERR_OR_NULL(virt_dev)) {
-			ret = PTR_ERR(virt_dev) ? : -ENODEV;
+			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 4854120fc095..81e5e7a20b94 100644
--- a/drivers/parisc/led.c
+++ b/drivers/parisc/led.c
@@ -56,8 +56,8 @@
 static int led_type __read_mostly = -1;
 static unsigned char lastleds;	/* LED state from most recent update */
 static unsigned int led_heartbeat __read_mostly = 1;
-static unsigned int led_diskio    __read_mostly = 1;
-static unsigned int led_lanrxtx   __read_mostly = 1;
+static unsigned int led_diskio    __read_mostly;
+static unsigned int led_lanrxtx   __read_mostly;
 static char lcd_text[32]          __read_mostly;
 static char lcd_text_default[32]  __read_mostly;
 static int  lcd_no_led_support    __read_mostly = 0; /* KittyHawk doesn't support LED on its LCD */
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index dda952357747..75c6c72ec32a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -332,17 +332,11 @@ int pciehp_check_link_status(struct controller *ctrl)
 static int __pciehp_link_set(struct controller *ctrl, bool enable)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_ctrl;
 
-	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnk_ctrl);
+	pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_LD,
+					   enable ? 0 : PCI_EXP_LNKCTL_LD);
 
-	if (enable)
-		lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
-	else
-		lnk_ctrl |= PCI_EXP_LNKCTL_LD;
-
-	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, lnk_ctrl);
-	ctrl_dbg(ctrl, "%s: lnk_ctrl = %x\n", __func__, lnk_ctrl);
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7a3cf8aaec25..ef6f0ceb92f9 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -249,7 +249,7 @@ static int pcie_retrain_link(struct pcie_link_state *link)
 static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 {
 	int same_clock = 1;
-	u16 reg16, parent_reg, child_reg[8];
+	u16 reg16, ccc, parent_old_ccc, child_old_ccc[8];
 	struct pci_dev *child, *parent = link->pdev;
 	struct pci_bus *linkbus = parent->subordinate;
 	/*
@@ -271,6 +271,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 
 	/* Port might be already in common clock mode */
 	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
+	parent_old_ccc = reg16 & PCI_EXP_LNKCTL_CCC;
 	if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
 		bool consistent = true;
 
@@ -287,34 +288,29 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		pci_info(parent, "ASPM: current common clock configuration is inconsistent, reconfiguring\n");
 	}
 
+	ccc = same_clock ? PCI_EXP_LNKCTL_CCC : 0;
 	/* Configure downstream component, all functions */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
 		pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
-		child_reg[PCI_FUNC(child->devfn)] = reg16;
-		if (same_clock)
-			reg16 |= PCI_EXP_LNKCTL_CCC;
-		else
-			reg16 &= ~PCI_EXP_LNKCTL_CCC;
-		pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
+		child_old_ccc[PCI_FUNC(child->devfn)] = reg16 & PCI_EXP_LNKCTL_CCC;
+		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, ccc);
 	}
 
 	/* Configure upstream component */
-	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
-	parent_reg = reg16;
-	if (same_clock)
-		reg16 |= PCI_EXP_LNKCTL_CCC;
-	else
-		reg16 &= ~PCI_EXP_LNKCTL_CCC;
-	pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_CCC, ccc);
 
 	if (pcie_retrain_link(link)) {
 
 		/* Training failed. Restore common clock configurations */
 		pci_err(parent, "ASPM: Could not configure common clock\n");
 		list_for_each_entry(child, &linkbus->devices, bus_list)
-			pcie_capability_write_word(child, PCI_EXP_LNKCTL,
-					   child_reg[PCI_FUNC(child->devfn)]);
-		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
+			pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_CCC,
+							   child_old_ccc[PCI_FUNC(child->devfn)]);
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_CCC, parent_old_ccc);
 	}
 }
 
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index e09bbf3890c4..8dfb67530d6b 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -82,6 +82,7 @@ struct ddr_pmu {
 	const struct fsl_ddr_devtype_data *devtype_data;
 	int irq;
 	int id;
+	int active_counter;
 };
 
 enum ddr_perf_filter_capabilities {
@@ -414,6 +415,10 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 
 	ddr_perf_counter_enable(pmu, event->attr.config, counter, true);
 
+	if (!pmu->active_counter++)
+		ddr_perf_counter_enable(pmu, EVENT_CYCLES_ID,
+			EVENT_CYCLES_COUNTER, true);
+
 	hwc->state = 0;
 }
 
@@ -468,6 +473,10 @@ static void ddr_perf_event_stop(struct perf_event *event, int flags)
 	ddr_perf_counter_enable(pmu, event->attr.config, counter, false);
 	ddr_perf_event_update(event);
 
+	if (!--pmu->active_counter)
+		ddr_perf_counter_enable(pmu, EVENT_CYCLES_ID,
+			EVENT_CYCLES_COUNTER, false);
+
 	hwc->state |= PERF_HES_STOPPED;
 }
 
@@ -486,25 +495,10 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 
 static void ddr_perf_pmu_enable(struct pmu *pmu)
 {
-	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
-
-	/* enable cycle counter if cycle is not active event list */
-	if (ddr_pmu->events[EVENT_CYCLES_COUNTER] == NULL)
-		ddr_perf_counter_enable(ddr_pmu,
-				      EVENT_CYCLES_ID,
-				      EVENT_CYCLES_COUNTER,
-				      true);
 }
 
 static void ddr_perf_pmu_disable(struct pmu *pmu)
 {
-	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
-
-	if (ddr_pmu->events[EVENT_CYCLES_COUNTER] == NULL)
-		ddr_perf_counter_enable(ddr_pmu,
-				      EVENT_CYCLES_ID,
-				      EVENT_CYCLES_COUNTER,
-				      false);
 }
 
 static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index abb926456933..173d166ed829 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -171,8 +171,7 @@ static int __maybe_unused qcom_snps_hsphy_runtime_suspend(struct device *dev)
 	if (!hsphy->phy_initialized)
 		return 0;
 
-	qcom_snps_hsphy_suspend(hsphy);
-	return 0;
+	return qcom_snps_hsphy_suspend(hsphy);
 }
 
 static int __maybe_unused qcom_snps_hsphy_runtime_resume(struct device *dev)
@@ -182,8 +181,7 @@ static int __maybe_unused qcom_snps_hsphy_runtime_resume(struct device *dev)
 	if (!hsphy->phy_initialized)
 		return 0;
 
-	qcom_snps_hsphy_resume(hsphy);
-	return 0;
+	return qcom_snps_hsphy_resume(hsphy);
 }
 
 static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index 9ca20c947283..2b0f5f2b4f33 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -745,10 +745,12 @@ unsigned long inno_hdmi_phy_rk3328_clk_recalc_rate(struct clk_hw *hw,
 		do_div(vco, (nd * (no_a == 1 ? no_b : no_a) * no_d * 2));
 	}
 
-	inno->pixclock = vco;
-	dev_dbg(inno->dev, "%s rate %lu\n", __func__, inno->pixclock);
+	inno->pixclock = DIV_ROUND_CLOSEST((unsigned long)vco, 1000) * 1000;
 
-	return vco;
+	dev_dbg(inno->dev, "%s rate %lu vco %llu\n",
+		__func__, inno->pixclock, vco);
+
+	return inno->pixclock;
 }
 
 static long inno_hdmi_phy_rk3328_clk_round_rate(struct clk_hw *hw,
@@ -790,8 +792,8 @@ static int inno_hdmi_phy_rk3328_clk_set_rate(struct clk_hw *hw,
 			 RK3328_PRE_PLL_POWER_DOWN);
 
 	/* Configure pre-pll */
-	inno_update_bits(inno, 0xa0, RK3228_PCLK_VCO_DIV_5_MASK,
-			 RK3228_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
+	inno_update_bits(inno, 0xa0, RK3328_PCLK_VCO_DIV_5_MASK,
+			 RK3328_PCLK_VCO_DIV_5(cfg->vco_div_5_en));
 	inno_write(inno, 0xa1, RK3328_PRE_PLL_PRE_DIV(cfg->prediv));
 
 	val = RK3328_SPREAD_SPECTRUM_MOD_DISABLE;
@@ -1021,9 +1023,10 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 
 	inno_write(inno, 0xac, RK3328_POST_PLL_FB_DIV_7_0(cfg->fbdiv));
 	if (cfg->postdiv == 1) {
-		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS);
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
+		inno_write(inno, 0xaa, RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	} else {
 		v = (cfg->postdiv / 2) - 1;
 		v &= RK3328_POST_PLL_POST_DIV_MASK;
@@ -1031,7 +1034,8 @@ inno_hdmi_phy_rk3328_power_on(struct inno_hdmi_phy *inno,
 		inno_write(inno, 0xab, RK3328_POST_PLL_FB_DIV_8(cfg->fbdiv) |
 			   RK3328_POST_PLL_PRE_DIV(cfg->prediv));
 		inno_write(inno, 0xaa, RK3328_POST_PLL_POST_DIV_ENABLE |
-			   RK3328_POST_PLL_REFCLK_SEL_TMDS);
+			   RK3328_POST_PLL_REFCLK_SEL_TMDS |
+			   RK3328_POST_PLL_POWER_DOWN);
 	}
 
 	for (v = 0; v < 14; v++)
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 44caada37b71..18b85ae84ed7 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1625,7 +1625,6 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	const struct intel_pinctrl_soc_data *soc_data;
 	struct intel_community *community;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct intel_pinctrl *pctrl;
 	acpi_status status;
 	int ret, irq;
@@ -1688,7 +1687,7 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	status = acpi_install_address_space_handler(adev->handle,
+	status = acpi_install_address_space_handler(ACPI_HANDLE(dev),
 					community->acpi_space_id,
 					chv_pinctrl_mmio_access_handler,
 					NULL, pctrl);
@@ -1705,7 +1704,7 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
 	const struct intel_community *community = &pctrl->communities[0];
 
-	acpi_remove_address_space_handler(ACPI_COMPANION(&pdev->dev),
+	acpi_remove_address_space_handler(ACPI_HANDLE(&pdev->dev),
 					  community->acpi_space_id,
 					  chv_pinctrl_mmio_access_handler);
 
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 3a05ebb9aa25..71576dceed3a 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -653,7 +653,7 @@ static int amd_pinconf_get(struct pinctrl_dev *pctldev,
 		break;
 
 	default:
-		dev_err(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
+		dev_dbg(&gpio_dev->pdev->dev, "Invalid config param %04x\n",
 			param);
 		return -ENOTSUPP;
 	}
@@ -706,7 +706,7 @@ static int amd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		default:
-			dev_err(&gpio_dev->pdev->dev,
+			dev_dbg(&gpio_dev->pdev->dev,
 				"Invalid config param %04x\n", param);
 			ret = -ENOTSUPP;
 		}
diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
index 9ae10318f6f3..ea059b9c5542 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -91,18 +91,28 @@ static int mcp23s08_spi_regmap_init(struct mcp23s08 *mcp, struct device *dev,
 		mcp->reg_shift = 0;
 		mcp->chip.ngpio = 8;
 		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s08.%d", addr);
+		if (!mcp->chip.label)
+			return -ENOMEM;
 
 		config = &mcp23x08_regmap;
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
+		if (!name)
+			return -ENOMEM;
+
 		break;
 
 	case MCP_TYPE_S17:
 		mcp->reg_shift = 1;
 		mcp->chip.ngpio = 16;
 		mcp->chip.label = devm_kasprintf(dev, GFP_KERNEL, "mcp23s17.%d", addr);
+		if (!mcp->chip.label)
+			return -ENOMEM;
 
 		config = &mcp23x17_regmap;
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", addr);
+		if (!name)
+			return -ENOMEM;
+
 		break;
 
 	case MCP_TYPE_S18:
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 38800e86ed8a..194f3205e559 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -56,6 +56,7 @@ struct mlxbf_tmfifo;
  * @vq: pointer to the virtio virtqueue
  * @desc: current descriptor of the pending packet
  * @desc_head: head descriptor of the pending packet
+ * @drop_desc: dummy desc for packet dropping
  * @cur_len: processed length of the current descriptor
  * @rem_len: remaining length of the pending packet
  * @pkt_len: total length of the pending packet
@@ -72,6 +73,7 @@ struct mlxbf_tmfifo_vring {
 	struct virtqueue *vq;
 	struct vring_desc *desc;
 	struct vring_desc *desc_head;
+	struct vring_desc drop_desc;
 	int cur_len;
 	int rem_len;
 	u32 pkt_len;
@@ -83,6 +85,14 @@ struct mlxbf_tmfifo_vring {
 	struct mlxbf_tmfifo *fifo;
 };
 
+/* Check whether vring is in drop mode. */
+#define IS_VRING_DROP(_r) ({ \
+	typeof(_r) (r) = (_r); \
+	(r->desc_head == &r->drop_desc ? true : false); })
+
+/* A stub length to drop maximum length packet. */
+#define VRING_DROP_DESC_MAX_LEN		GENMASK(15, 0)
+
 /* Interrupt types. */
 enum {
 	MLXBF_TM_RX_LWM_IRQ,
@@ -195,7 +205,7 @@ static u8 mlxbf_tmfifo_net_default_mac[ETH_ALEN] = {
 static efi_char16_t mlxbf_tmfifo_efi_name[] = L"RshimMacAddr";
 
 /* Maximum L2 header length. */
-#define MLXBF_TMFIFO_NET_L2_OVERHEAD	36
+#define MLXBF_TMFIFO_NET_L2_OVERHEAD	(ETH_HLEN + VLAN_HLEN)
 
 /* Supported virtio-net features. */
 #define MLXBF_TMFIFO_NET_FEATURES \
@@ -243,6 +253,7 @@ static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
 		vring->align = SMP_CACHE_BYTES;
 		vring->index = i;
 		vring->vdev_id = tm_vdev->vdev.id.device;
+		vring->drop_desc.len = VRING_DROP_DESC_MAX_LEN;
 		dev = &tm_vdev->vdev.dev;
 
 		size = vring_size(vring->num, vring->align);
@@ -348,7 +359,7 @@ static u32 mlxbf_tmfifo_get_pkt_len(struct mlxbf_tmfifo_vring *vring,
 	return len;
 }
 
-static void mlxbf_tmfifo_release_pending_pkt(struct mlxbf_tmfifo_vring *vring)
+static void mlxbf_tmfifo_release_pkt(struct mlxbf_tmfifo_vring *vring)
 {
 	struct vring_desc *desc_head;
 	u32 len = 0;
@@ -577,19 +588,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (is_rx)
-			memcpy(addr + vring->cur_len, &data, sizeof(u64));
-		else
-			memcpy(&data, addr + vring->cur_len, sizeof(u64));
+		if (!IS_VRING_DROP(vring)) {
+			if (is_rx)
+				memcpy(addr + vring->cur_len, &data,
+				       sizeof(u64));
+			else
+				memcpy(&data, addr + vring->cur_len,
+				       sizeof(u64));
+		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (is_rx)
-			memcpy(addr + vring->cur_len, &data,
-			       len - vring->cur_len);
-		else
-			memcpy(&data, addr + vring->cur_len,
-			       len - vring->cur_len);
+		if (!IS_VRING_DROP(vring)) {
+			if (is_rx)
+				memcpy(addr + vring->cur_len, &data,
+				       len - vring->cur_len);
+			else
+				memcpy(&data, addr + vring->cur_len,
+				       len - vring->cur_len);
+		}
 		vring->cur_len = len;
 	}
 
@@ -606,13 +623,14 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
  * flag is set.
  */
 static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
-				     struct vring_desc *desc,
+				     struct vring_desc **desc,
 				     bool is_rx, bool *vring_change)
 {
 	struct mlxbf_tmfifo *fifo = vring->fifo;
 	struct virtio_net_config *config;
 	struct mlxbf_tmfifo_msg_hdr hdr;
 	int vdev_id, hdr_len;
+	bool drop_rx = false;
 
 	/* Read/Write packet header. */
 	if (is_rx) {
@@ -632,8 +650,8 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 			if (ntohs(hdr.len) >
 			    __virtio16_to_cpu(virtio_legacy_is_little_endian(),
 					      config->mtu) +
-			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
-				return;
+					      MLXBF_TMFIFO_NET_L2_OVERHEAD)
+				drop_rx = true;
 		} else {
 			vdev_id = VIRTIO_ID_CONSOLE;
 			hdr_len = 0;
@@ -648,16 +666,25 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 
 			if (!tm_dev2)
 				return;
-			vring->desc = desc;
+			vring->desc = *desc;
 			vring = &tm_dev2->vrings[MLXBF_TMFIFO_VRING_RX];
 			*vring_change = true;
 		}
+
+		if (drop_rx && !IS_VRING_DROP(vring)) {
+			if (vring->desc_head)
+				mlxbf_tmfifo_release_pkt(vring);
+			*desc = &vring->drop_desc;
+			vring->desc_head = *desc;
+			vring->desc = *desc;
+		}
+
 		vring->pkt_len = ntohs(hdr.len) + hdr_len;
 	} else {
 		/* Network virtio has an extra header. */
 		hdr_len = (vring->vdev_id == VIRTIO_ID_NET) ?
 			   sizeof(struct virtio_net_hdr) : 0;
-		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vring, desc);
+		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vring, *desc);
 		hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
 			    VIRTIO_ID_NET : VIRTIO_ID_CONSOLE;
 		hdr.len = htons(vring->pkt_len - hdr_len);
@@ -690,15 +717,23 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 	/* Get the descriptor of the next packet. */
 	if (!vring->desc) {
 		desc = mlxbf_tmfifo_get_next_pkt(vring, is_rx);
-		if (!desc)
-			return false;
+		if (!desc) {
+			/* Drop next Rx packet to avoid stuck. */
+			if (is_rx) {
+				desc = &vring->drop_desc;
+				vring->desc_head = desc;
+				vring->desc = desc;
+			} else {
+				return false;
+			}
+		}
 	} else {
 		desc = vring->desc;
 	}
 
 	/* Beginning of a packet. Start to Rx/Tx packet header. */
 	if (vring->pkt_len == 0) {
-		mlxbf_tmfifo_rxtx_header(vring, desc, is_rx, &vring_change);
+		mlxbf_tmfifo_rxtx_header(vring, &desc, is_rx, &vring_change);
 		(*avail)--;
 
 		/* Return if new packet is for another ring. */
@@ -724,17 +759,24 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 		vring->rem_len -= len;
 
 		/* Get the next desc on the chain. */
-		if (vring->rem_len > 0 &&
+		if (!IS_VRING_DROP(vring) && vring->rem_len > 0 &&
 		    (virtio16_to_cpu(vdev, desc->flags) & VRING_DESC_F_NEXT)) {
 			idx = virtio16_to_cpu(vdev, desc->next);
 			desc = &vr->desc[idx];
 			goto mlxbf_tmfifo_desc_done;
 		}
 
-		/* Done and release the pending packet. */
-		mlxbf_tmfifo_release_pending_pkt(vring);
+		/* Done and release the packet. */
 		desc = NULL;
 		fifo->vring[is_rx] = NULL;
+		if (!IS_VRING_DROP(vring)) {
+			mlxbf_tmfifo_release_pkt(vring);
+		} else {
+			vring->pkt_len = 0;
+			vring->desc_head = NULL;
+			vring->desc = NULL;
+			return false;
+		}
 
 		/*
 		 * Make sure the load/store are in order before
@@ -868,6 +910,7 @@ static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
 			tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
 			mlxbf_tmfifo_console_output(tm_vdev, vring);
 			spin_unlock_irqrestore(&fifo->spin_lock[0], flags);
+			set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
 		} else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
 					    &fifo->pend_events)) {
 			return true;
@@ -913,7 +956,7 @@ static void mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev)
 
 		/* Release the pending packet. */
 		if (vring->desc)
-			mlxbf_tmfifo_release_pending_pkt(vring);
+			mlxbf_tmfifo_release_pkt(vring);
 		vq = vring->vq;
 		if (vq) {
 			vring->vq = NULL;
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 935562c870c3..23ebd0c046e1 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -86,6 +86,8 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
 	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
+	// Ignore Ambient Light Sensoring
+	{ KE_KEY,    0x2c1, { KEY_RESERVED } },
 	{ KE_END,	 0 }
 };
 
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index cebddefba2f4..0b0602fc4360 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -458,7 +458,7 @@ static bool button_array_present(struct platform_device *device)
 static int intel_hid_probe(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	unsigned long long mode;
+	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
 	acpi_status status;
 	int err;
@@ -510,18 +510,15 @@ static int intel_hid_probe(struct platform_device *device)
 	if (err)
 		goto err_remove_notify;
 
-	if (priv->array) {
-		unsigned long long dummy;
+	intel_button_array_enable(&device->dev, true);
 
-		intel_button_array_enable(&device->dev, true);
-
-		/* Call button load method to enable HID power button */
-		if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN,
-					       &dummy)) {
-			dev_warn(&device->dev,
-				 "failed to enable HID power button\n");
-		}
-	}
+	/*
+	 * Call button load method to enable HID power button
+	 * Always do this since it activates events on some devices without
+	 * a button array too.
+	 */
+	if (!intel_hid_evaluate_method(handle, INTEL_HID_DSM_BTNL_FN, &dummy))
+		dev_warn(&device->dev, "failed to enable HID power button\n");
 
 	device_init_wakeup(&device->dev, true);
 	/*
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 522f862eca52..504a8f506195 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -51,10 +51,10 @@ static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty_cycles > 255)
 		duty_cycles = 255;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~0xFFFF;
 	val |= (period_cycles << 8) | duty_cycles;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -69,9 +69,9 @@ static int lpc32xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret)
 		return ret;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val |= PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -81,9 +81,9 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct lpc32xx_pwm_chip *lpc32xx = to_lpc32xx_pwm_chip(chip);
 	u32 val;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	clk_disable_unprepare(lpc32xx->clk);
 }
@@ -121,9 +121,9 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.base = -1;
 
 	/* If PWM is disabled, configure the output to the default value */
-	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
-	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	ret = pwmchip_add(&lpc32xx->chip);
 	if (ret < 0) {
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 98b6d4c09c82..e776d1bfc976 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -222,6 +222,10 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 
 	channel->glink = glink;
 	channel->name = kstrdup(name, GFP_KERNEL);
+	if (!channel->name) {
+		kfree(channel);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	init_completion(&channel->open_req);
 	init_completion(&channel->open_ack);
diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index dfbd7b88b2b9..98932ab0fcab 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1441,7 +1441,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 792f8f568808..09e932a7b17f 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2985,41 +2985,32 @@ static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
  * Requeue a request back to the block request queue
  * only works for block requests
  */
-static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
+static void _dasd_requeue_request(struct dasd_ccw_req *cqr)
 {
-	struct dasd_block *block = cqr->block;
 	struct request *req;
 
-	if (!block)
-		return -EINVAL;
 	/*
 	 * If the request is an ERP request there is nothing to requeue.
 	 * This will be done with the remaining original request.
 	 */
 	if (cqr->refers)
-		return 0;
+		return;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
-	return 0;
+	return;
 }
 
-/*
- * Go through all request on the dasd_block request queue, cancel them
- * on the respective dasd_device, and return them to the generic
- * block layer.
- */
-static int dasd_flush_block_queue(struct dasd_block *block)
+static int _dasd_requests_to_flushqueue(struct dasd_block *block,
+					struct list_head *flush_queue)
 {
 	struct dasd_ccw_req *cqr, *n;
-	int rc, i;
-	struct list_head flush_queue;
 	unsigned long flags;
+	int rc, i;
 
-	INIT_LIST_HEAD(&flush_queue);
-	spin_lock_bh(&block->queue_lock);
+	spin_lock_irqsave(&block->queue_lock, flags);
 	rc = 0;
 restart:
 	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
@@ -3034,13 +3025,32 @@ static int dasd_flush_block_queue(struct dasd_block *block)
 		 * is returned from the dasd_device layer.
 		 */
 		cqr->callback = _dasd_wake_block_flush_cb;
-		for (i = 0; cqr != NULL; cqr = cqr->refers, i++)
-			list_move_tail(&cqr->blocklist, &flush_queue);
+		for (i = 0; cqr; cqr = cqr->refers, i++)
+			list_move_tail(&cqr->blocklist, flush_queue);
 		if (i > 1)
 			/* moved more than one request - need to restart */
 			goto restart;
 	}
-	spin_unlock_bh(&block->queue_lock);
+	spin_unlock_irqrestore(&block->queue_lock, flags);
+
+	return rc;
+}
+
+/*
+ * Go through all request on the dasd_block request queue, cancel them
+ * on the respective dasd_device, and return them to the generic
+ * block layer.
+ */
+static int dasd_flush_block_queue(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr, *n;
+	struct list_head flush_queue;
+	unsigned long flags;
+	int rc;
+
+	INIT_LIST_HEAD(&flush_queue);
+	rc = _dasd_requests_to_flushqueue(block, &flush_queue);
+
 	/* Now call the callback function of flushed requests */
 restart_cb:
 	list_for_each_entry_safe(cqr, n, &flush_queue, blocklist) {
@@ -3977,75 +3987,36 @@ EXPORT_SYMBOL_GPL(dasd_generic_space_avail);
  */
 static int dasd_generic_requeue_all_requests(struct dasd_device *device)
 {
+	struct dasd_block *block = device->block;
 	struct list_head requeue_queue;
 	struct dasd_ccw_req *cqr, *n;
-	struct dasd_ccw_req *refers;
 	int rc;
 
-	INIT_LIST_HEAD(&requeue_queue);
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = 0;
-	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
-		/* Check status and move request to flush_queue */
-		if (cqr->status == DASD_CQR_IN_IO) {
-			rc = device->discipline->term_IO(cqr);
-			if (rc) {
-				/* unable to terminate requeust */
-				dev_err(&device->cdev->dev,
-					"Unable to terminate request %p "
-					"on suspend\n", cqr);
-				spin_unlock_irq(get_ccwdev_lock(device->cdev));
-				dasd_put_device(device);
-				return rc;
-			}
-		}
-		list_move_tail(&cqr->devlist, &requeue_queue);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	list_for_each_entry_safe(cqr, n, &requeue_queue, devlist) {
-		wait_event(dasd_flush_wq,
-			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+	if (!block)
+		return 0;
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
+	INIT_LIST_HEAD(&requeue_queue);
+	rc = _dasd_requests_to_flushqueue(block, &requeue_queue);
 
-		/* remove requests from device and block queue */
-		list_del_init(&cqr->devlist);
-		while (cqr->refers != NULL) {
-			refers = cqr->refers;
-			/* remove the request from the block queue */
-			list_del(&cqr->blocklist);
-			/* free the finished erp request */
-			dasd_free_erp_request(cqr, cqr->memdev);
-			cqr = refers;
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &requeue_queue, blocklist) {
+		wait_event(dasd_flush_wq, (cqr->status < DASD_CQR_QUEUED));
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			spin_lock_bh(&block->queue_lock);
+			__dasd_process_erp(block->base, cqr);
+			spin_unlock_bh(&block->queue_lock);
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements
+			 */
+			goto restart_cb;
 		}
-
-		/*
-		 * _dasd_requeue_request already checked for a valid
-		 * blockdevice, no need to check again
-		 * all erp requests (cqr->refers) have a cqr->block
-		 * pointer copy from the original cqr
-		 */
+		_dasd_requeue_request(cqr);
 		list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
 			cqr, (struct request *) cqr->callback_data);
 	}
-
-	/*
-	 * if requests remain then they are internal request
-	 * and go back to the device queue
-	 */
-	if (!list_empty(&requeue_queue)) {
-		/* move freeze_queue to start of the ccw_queue */
-		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		list_splice_tail(&requeue_queue, &device->ccw_queue);
-		spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	}
 	dasd_schedule_device_bh(device);
 	return rc;
 }
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 4691a3c35d72..c2d4ea74e0d0 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -2436,7 +2436,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 	erp->block    = cqr->block;
 	erp->magic    = cqr->magic;
 	erp->expires  = cqr->expires;
-	erp->retries  = 256;
+	erp->retries  = device->default_retries;
 	erp->buildclk = get_tod_clock();
 	erp->status = DASD_CQR_FILLED;
 
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 870e00effe43..69882ff4db10 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -735,7 +735,7 @@ static int pkey_verifykey2(const u8 *key, size_t keylen,
 		if (ktype)
 			*ktype = PKEY_TYPE_EP11;
 		if (ksize)
-			*ksize = kb->head.keybitlen;
+			*ksize = kb->head.bitlen;
 
 		rc = ep11_findcard2(&_apqns, &_nr_apqns, *cardnr, *domain,
 				    ZCRYPT_CEX7, EP11_API_V, kb->wkvp);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 3b9eda311c27..b518009715ee 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -399,6 +399,7 @@ static int zcdn_create(const char *name)
 			 ZCRYPT_NAME "_%d", (int) MINOR(devt));
 	nodename[sizeof(nodename)-1] = '\0';
 	if (dev_set_name(&zcdndev->device, nodename)) {
+		kfree(zcdndev);
 		rc = -EINVAL;
 		goto unlockout;
 	}
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 9ce5a71da69b..3daf259ba10e 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -788,7 +788,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	kb->head.type = TOKTYPE_NON_CCA;
 	kb->head.len = rep_pl->data_len;
 	kb->head.version = TOKVER_EP11_AES;
-	kb->head.keybitlen = keybitsize;
+	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
@@ -1056,7 +1056,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 	kb->head.type = TOKTYPE_NON_CCA;
 	kb->head.len = rep_pl->data_len;
 	kb->head.version = TOKVER_EP11_AES;
-	kb->head.keybitlen = keybitsize;
+	kb->head.bitlen = keybitsize;
 
 out:
 	kfree(req);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 1e02b197c003..d424fa901f1b 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -29,14 +29,7 @@ struct ep11keyblob {
 	union {
 		u8 session[32];
 		/* only used for PKEY_TYPE_EP11: */
-		struct {
-			u8  type;      /* 0x00 (TOKTYPE_NON_CCA) */
-			u8  res0;      /* unused */
-			u16 len;       /* total length in bytes of this blob */
-			u8  version;   /* 0x03 (TOKVER_EP11_AES) */
-			u8  res1;      /* unused */
-			u16 keybitlen; /* clear key bit len, 0 for unknown */
-		} head;
+		struct ep11kblob_header head;
 	};
 	u8  wkvp[16];  /* wrapping key verification pattern */
 	u64 attr;      /* boolean key attributes */
diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 593b167ceefe..2eb2885ee6e2 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -208,7 +208,7 @@ static void asd_task_tasklet_complete(struct asd_ascb *ascb,
 	switch (opcode) {
 	case TC_NO_ERROR:
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		break;
 	case TC_UNDERRUN:
 		ts->resp = SAS_TASK_COMPLETE;
diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index c4881657a807..e07052fb0ec3 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -450,6 +450,10 @@ int beiscsi_iface_set_param(struct Scsi_Host *shost,
 	}
 
 	nla_for_each_attr(attrib, data, dt_len, rm_len) {
+		/* ignore nla_type as it is never used */
+		if (nla_len(attrib) < sizeof(*iface_param))
+			return -EINVAL;
+
 		iface_param = nla_data(attrib);
 
 		if (iface_param->param_type != ISCSI_NET_PARAM)
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index bbc5d6b9be73..a2d60ad2a683 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,16 +319,17 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -699,6 +700,7 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
+	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -732,11 +734,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_bh(&fip->ctlr_lock);
+		spin_lock_irqsave(&fip->ctlr_lock, flags);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_bh(&fip->ctlr_lock);
+		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1713,10 +1715,11 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1727,7 +1730,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1744,8 +1747,9 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
+	unsigned long flags;
 
-	spin_lock_bh(&fip->ctlr_lock);
+	spin_lock_irqsave(&fip->ctlr_lock, flags);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1772,7 +1776,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_bh(&fip->ctlr_lock);
+	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
 }
 
 /**
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 2c1028183b24..5b54cdd6b976 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1152,14 +1152,14 @@ static void slot_err_v1_hw(struct hisi_hba *hisi_hba,
 		}
 		default:
 		{
-			ts->stat = SAM_STAT_CHECK_CONDITION;
+			ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 			break;
 		}
 		}
 	}
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SATA:
@@ -1281,7 +1281,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -1298,7 +1298,7 @@ static void slot_complete_v1_hw(struct hisi_hba *hisi_hba,
 		break;
 
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index b75d54339e40..f6e9114debd4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2026,6 +2026,11 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	u16 dma_tx_err_type = le16_to_cpu(err_record->dma_tx_err_type);
 	u16 sipc_rx_err_type = le16_to_cpu(err_record->sipc_rx_err_type);
 	u32 dma_rx_err_type = le32_to_cpu(err_record->dma_rx_err_type);
+	struct hisi_sas_complete_v2_hdr *complete_queue =
+			hisi_hba->complete_hdr[slot->cmplt_queue];
+	struct hisi_sas_complete_v2_hdr *complete_hdr =
+			&complete_queue[slot->cmplt_queue_slot];
+	u32 dw0 = le32_to_cpu(complete_hdr->dw0);
 	int error = -1;
 
 	if (err_phase == 1) {
@@ -2168,7 +2173,7 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	}
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SATA:
@@ -2310,7 +2315,8 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 			break;
 		}
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 	}
 		break;
 	default:
@@ -2427,7 +2433,7 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -2441,12 +2447,13 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 	{
-		ts->stat = SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		ts->stat = SAS_SAM_STAT_GOOD;
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	}
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 65971bd80186..0d21c64efa81 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -392,6 +392,8 @@
 #define CMPLT_HDR_ERROR_PHASE_MSK   (0xff << CMPLT_HDR_ERROR_PHASE_OFF)
 #define CMPLT_HDR_RSPNS_XFRD_OFF	10
 #define CMPLT_HDR_RSPNS_XFRD_MSK	(0x1 << CMPLT_HDR_RSPNS_XFRD_OFF)
+#define CMPLT_HDR_RSPNS_GOOD_OFF	11
+#define CMPLT_HDR_RSPNS_GOOD_MSK	(0x1 << CMPLT_HDR_RSPNS_GOOD_OFF)
 #define CMPLT_HDR_ERX_OFF		12
 #define CMPLT_HDR_ERX_MSK		(0x1 << CMPLT_HDR_ERX_OFF)
 #define CMPLT_HDR_ABORT_STAT_OFF	13
@@ -465,6 +467,9 @@ struct hisi_sas_err_record_v3 {
 #define RX_DATA_LEN_UNDERFLOW_OFF	6
 #define RX_DATA_LEN_UNDERFLOW_MSK	(1 << RX_DATA_LEN_UNDERFLOW_OFF)
 
+#define RX_FIS_STATUS_ERR_OFF		0
+#define RX_FIS_STATUS_ERR_MSK		(1 << RX_FIS_STATUS_ERR_OFF)
+
 #define HISI_SAS_COMMAND_ENTRIES_V3_HW 4096
 #define HISI_SAS_MSI_COUNT_V3_HW 32
 
@@ -2115,7 +2120,7 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	return IRQ_HANDLED;
 }
 
-static void
+static bool
 slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	       struct hisi_sas_slot *slot)
 {
@@ -2128,11 +2133,22 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			hisi_sas_status_buf_addr_mem(slot);
 	u32 dma_rx_err_type = le32_to_cpu(record->dma_rx_err_type);
 	u32 trans_tx_fail_type = le32_to_cpu(record->trans_tx_fail_type);
+	u16 sipc_rx_err_type = le16_to_cpu(record->sipc_rx_err_type);
 	u32 dw3 = le32_to_cpu(complete_hdr->dw3);
+	u32 dw0 = le32_to_cpu(complete_hdr->dw0);
 
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SSP:
 		if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
+			/*
+			 * If returned response frame is incorrect because of data underflow,
+			 * but I/O information has been written to the host memory, we examine
+			 * response IU.
+			 */
+			if (!(dw0 & CMPLT_HDR_RSPNS_GOOD_MSK) &&
+			    (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK))
+				return false;
+
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
 		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
@@ -2146,7 +2162,10 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
-		if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
+		if ((dw0 & CMPLT_HDR_RSPNS_XFRD_MSK) &&
+		    (sipc_rx_err_type & RX_FIS_STATUS_ERR_MSK)) {
+			ts->stat = SAS_PROTO_RESPONSE;
+		} else if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
 			ts->residual = trans_tx_fail_type;
 			ts->stat = SAS_DATA_UNDERRUN;
 		} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
@@ -2156,14 +2175,16 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			ts->stat = SAS_OPEN_REJECT;
 			ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	case SAS_PROTOCOL_SMP:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	default:
 		break;
 	}
+	return true;
 }
 
 static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
@@ -2238,18 +2259,20 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	if ((dw0 & CMPLT_HDR_CMPLT_MSK) == 0x3) {
 		u32 *error_info = hisi_sas_status_buf_addr_mem(slot);
 
-		slot_err_v3_hw(hisi_hba, task, slot);
-		if (ts->stat != SAS_DATA_UNDERRUN)
-			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
-				 slot->idx, task, sas_dev->device_id,
-				 dw0, dw1, complete_hdr->act, dw3,
-				 error_info[0], error_info[1],
-				 error_info[2], error_info[3]);
-		if (unlikely(slot->abort)) {
-			sas_task_abort(task);
-			return;
+		if (slot_err_v3_hw(hisi_hba, task, slot)) {
+			if (ts->stat != SAS_DATA_UNDERRUN)
+				dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d addr=%016llx CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
+					slot->idx, task, sas_dev->device_id,
+					SAS_ADDR(device->sas_addr),
+					dw0, dw1, complete_hdr->act, dw3,
+					error_info[0], error_info[1],
+					error_info[2], error_info[3]);
+			if (unlikely(slot->abort)) {
+				sas_task_abort(task);
+				return;
+			}
+			goto out;
 		}
-		goto out;
 	}
 
 	switch (task->task_proto) {
@@ -2265,7 +2288,7 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 		struct scatterlist *sg_resp = &task->smp_task.smp_resp;
 		void *to = page_address(sg_page(sg_resp));
 
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 		dma_unmap_sg(dev, &task->smp_task.smp_req, 1,
 			     DMA_TO_DEVICE);
@@ -2278,11 +2301,12 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_SATA:
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
-		ts->stat = SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		ts->stat = SAS_SAM_STAT_GOOD;
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	default:
-		ts->stat = SAM_STAT_CHECK_CONDITION;
+		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 18321cf9db5d..59eb6c296986 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -522,7 +522,7 @@ EXPORT_SYMBOL(scsi_host_alloc);
 static int __scsi_host_match(struct device *dev, const void *data)
 {
 	struct Scsi_Host *p;
-	const unsigned short *hostnum = data;
+	const unsigned int *hostnum = data;
 
 	p = class_to_shost(dev);
 	return p->host_no == *hostnum;
@@ -539,7 +539,7 @@ static int __scsi_host_match(struct device *dev, const void *data)
  *	that scsi_host_get() took. The put_device() below dropped
  *	the reference from class_find_device().
  **/
-struct Scsi_Host *scsi_host_lookup(unsigned short hostnum)
+struct Scsi_Host *scsi_host_lookup(unsigned int hostnum)
 {
 	struct device *cdev;
 	struct Scsi_Host *shost = NULL;
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 6e0817941fa7..b6d68d871b6c 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2574,7 +2574,7 @@ static void isci_request_handle_controller_specific_errors(
 			if (!idev)
 				*status_ptr = SAS_DEVICE_UNKNOWN;
 			else
-				*status_ptr = SAM_STAT_TASK_ABORTED;
+				*status_ptr = SAS_SAM_STAT_TASK_ABORTED;
 
 			clear_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 		}
@@ -2704,7 +2704,7 @@ static void isci_request_handle_controller_specific_errors(
 	default:
 		/* Task in the target is not done. */
 		*response_ptr = SAS_TASK_UNDELIVERED;
-		*status_ptr = SAM_STAT_TASK_ABORTED;
+		*status_ptr = SAS_SAM_STAT_TASK_ABORTED;
 
 		if (task->task_proto == SAS_PROTOCOL_SMP)
 			set_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
@@ -2727,7 +2727,7 @@ static void isci_process_stp_response(struct sas_task *task, struct dev_to_host_
 	if (ac_err_mask(fis->status))
 		ts->stat = SAS_PROTO_RESPONSE;
 	else
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 
 	ts->resp = SAS_TASK_COMPLETE;
 }
@@ -2790,7 +2790,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 	case SCI_IO_SUCCESS_IO_DONE_EARLY:
 
 		response = SAS_TASK_COMPLETE;
-		status   = SAM_STAT_GOOD;
+		status   = SAS_SAM_STAT_GOOD;
 		set_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 
 		if (completion_status == SCI_IO_SUCCESS_IO_DONE_EARLY) {
@@ -2860,7 +2860,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 
 		/* Fail the I/O. */
 		response = SAS_TASK_UNDELIVERED;
-		status = SAM_STAT_TASK_ABORTED;
+		status = SAS_SAM_STAT_TASK_ABORTED;
 
 		clear_bit(IREQ_COMPLETE_IN_TARGET, &request->flags);
 		break;
diff --git a/drivers/scsi/isci/task.c b/drivers/scsi/isci/task.c
index 26fa1a4d1e6b..1d1db40a1572 100644
--- a/drivers/scsi/isci/task.c
+++ b/drivers/scsi/isci/task.c
@@ -160,7 +160,7 @@ int isci_task_execute_task(struct sas_task *task, gfp_t gfp_flags)
 
 			isci_task_refuse(ihost, task,
 					 SAS_TASK_UNDELIVERED,
-					 SAM_STAT_TASK_ABORTED);
+					 SAS_SAM_STAT_TASK_ABORTED);
 		} else {
 			task->task_state_flags |= SAS_TASK_AT_INITIATOR;
 			spin_unlock_irqrestore(&task->task_state_lock, flags);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index a1a06a832d86..f92b889369c3 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -122,9 +122,10 @@ static void sas_ata_task_done(struct sas_task *task)
 		}
 	}
 
-	if (stat->stat == SAS_PROTO_RESPONSE || stat->stat == SAM_STAT_GOOD ||
-	    ((stat->stat == SAM_STAT_CHECK_CONDITION &&
-	      dev->sata_dev.class == ATA_DEV_ATAPI))) {
+	if (stat->stat == SAS_PROTO_RESPONSE ||
+	    stat->stat == SAS_SAM_STAT_GOOD ||
+	    (stat->stat == SAS_SAM_STAT_CHECK_CONDITION &&
+	      dev->sata_dev.class == ATA_DEV_ATAPI)) {
 		memcpy(dev->sata_dev.fis, resp->ending_fis, ATA_RESP_FIS_SIZE);
 
 		if (!link->sactive) {
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 51485d0251f2..8444a4287ac1 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -101,7 +101,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 			}
 		}
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAM_STAT_GOOD) {
+		    task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = 0;
 			break;
 		}
diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
index e2d42593ce52..2966ead1d421 100644
--- a/drivers/scsi/libsas/sas_task.c
+++ b/drivers/scsi/libsas/sas_task.c
@@ -20,7 +20,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	else if (iu->datapres == 1)
 		tstat->stat = iu->resp_data[3];
 	else if (iu->datapres == 2) {
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		tstat->buf_valid_size =
 			min_t(int, SAS_STATUS_BUF_SIZE,
 			      be32_to_cpu(iu->sense_data_len));
@@ -32,7 +32,7 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
 	}
 	else
 		/* when datapres contains corrupt/unknown value... */
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 }
 EXPORT_SYMBOL_GPL(sas_ssp_task_response);
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 26b15a24300e..3728e4cf6e05 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -131,6 +131,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc);
 static void
 _base_clear_outstanding_commands(struct MPT3SAS_ADAPTER *ioc);
 
+static u32
+_base_readl_ext_retry(const volatile void __iomem *addr);
+
 /**
  * mpt3sas_base_check_cmd_timeout - Function
  *		to check timeout and command termination due
@@ -206,6 +209,20 @@ _base_readl_aero(const volatile void __iomem *addr)
 	return ret_val;
 }
 
+static u32
+_base_readl_ext_retry(const volatile void __iomem *addr)
+{
+	u32 i, ret_val;
+
+	for (i = 0 ; i < 30 ; i++) {
+		ret_val = readl(addr);
+		if (ret_val == 0)
+			continue;
+	}
+
+	return ret_val;
+}
+
 static inline u32
 _base_readl(const volatile void __iomem *addr)
 {
@@ -861,7 +878,7 @@ mpt3sas_halt_firmware(struct MPT3SAS_ADAPTER *ioc)
 
 	dump_stack();
 
-	doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+	doorbell = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 	if ((doorbell & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT) {
 		mpt3sas_print_fault_code(ioc, doorbell &
 		    MPI2_DOORBELL_DATA_MASK);
@@ -5667,7 +5684,7 @@ mpt3sas_base_get_iocstate(struct MPT3SAS_ADAPTER *ioc, int cooked)
 {
 	u32 s, sc;
 
-	s = ioc->base_readl(&ioc->chip->Doorbell);
+	s = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 	sc = s & MPI2_IOC_STATE_MASK;
 	return cooked ? sc : s;
 }
@@ -5812,7 +5829,7 @@ _base_wait_for_doorbell_ack(struct MPT3SAS_ADAPTER *ioc, int timeout)
 					   __func__, count, timeout));
 			return 0;
 		} else if (int_status & MPI2_HIS_IOC2SYS_DB_STATUS) {
-			doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+			doorbell = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 			if ((doorbell & MPI2_IOC_STATE_MASK) ==
 			    MPI2_IOC_STATE_FAULT) {
 				mpt3sas_print_fault_code(ioc, doorbell);
@@ -5852,7 +5869,7 @@ _base_wait_for_doorbell_not_used(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	count = 0;
 	cntdn = 1000 * timeout;
 	do {
-		doorbell_reg = ioc->base_readl(&ioc->chip->Doorbell);
+		doorbell_reg = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 		if (!(doorbell_reg & MPI2_DOORBELL_USED)) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
@@ -5989,7 +6006,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	__le32 *mfp;
 
 	/* make sure doorbell is not in use */
-	if ((ioc->base_readl(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
+	if ((ioc->base_readl_ext_retry(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
 		ioc_err(ioc, "doorbell is in use (line=%d)\n", __LINE__);
 		return -EFAULT;
 	}
@@ -6038,7 +6055,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	}
 
 	/* read the first two 16-bits, it gives the total length of the reply */
-	reply[0] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[0] = le16_to_cpu(ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 	if ((_base_wait_for_doorbell_int(ioc, 5))) {
@@ -6046,7 +6063,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			__LINE__);
 		return -EFAULT;
 	}
-	reply[1] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[1] = le16_to_cpu(ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 
@@ -6057,10 +6074,10 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			return -EFAULT;
 		}
 		if (i >=  reply_bytes/2) /* overflow case */
-			ioc->base_readl(&ioc->chip->Doorbell);
+			ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 		else
 			reply[i] = le16_to_cpu(
-			    ioc->base_readl(&ioc->chip->Doorbell)
+			    ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 			    & MPI2_DOORBELL_DATA_MASK);
 		writel(0, &ioc->chip->HostInterruptStatus);
 	}
@@ -6906,7 +6923,7 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 			goto out;
 		}
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl_ext_retry(&ioc->chip->HostDiagnostic);
 		drsprintk(ioc,
 			  ioc_info(ioc, "wrote magic sequence: count(%d), host_diagnostic(0x%08x)\n",
 				   count, host_diagnostic));
@@ -6926,7 +6943,7 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 	for (count = 0; count < (300000000 /
 		MPI2_HARD_RESET_PCIE_SECOND_READ_DELAY_MICRO_SEC); count++) {
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl_ext_retry(&ioc->chip->HostDiagnostic);
 
 		if (host_diagnostic == 0xFFFFFFFF) {
 			ioc_info(ioc,
@@ -7313,10 +7330,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 	ioc->rdpq_array_enable_assigned = 0;
 	ioc->use_32bit_dma = false;
 	ioc->dma_mask = 64;
-	if (ioc->is_aero_ioc)
+	if (ioc->is_aero_ioc) {
 		ioc->base_readl = &_base_readl_aero;
-	else
+		ioc->base_readl_ext_retry = &_base_readl_ext_retry;
+	} else {
 		ioc->base_readl = &_base_readl;
+		ioc->base_readl_ext_retry = &_base_readl;
+	}
 	r = mpt3sas_base_map_resources(ioc);
 	if (r)
 		goto out_free_resources;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 823bbe64a477..dc0e130ba5ea 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1469,6 +1469,7 @@ struct MPT3SAS_ADAPTER {
 	u8		diag_trigger_active;
 	u8		atomic_desc_capable;
 	BASE_READ_REG	base_readl;
+	BASE_READ_REG	base_readl_ext_retry;
 	struct SL_WH_MASTER_TRIGGER_T diag_trigger_master;
 	struct SL_WH_EVENT_TRIGGERS_T diag_trigger_event;
 	struct SL_WH_SCSI_TRIGGERS_T diag_trigger_scsi;
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 484e01428da2..a2a13969c686 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1314,7 +1314,7 @@ static int mvs_exec_internal_tmf_task(struct domain_device *dev,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-		    task->task_status.stat == SAM_STAT_GOOD) {
+		    task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 		}
@@ -1764,7 +1764,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 	case SAS_PROTOCOL_SSP:
 		/* hw says status == 0, datapres == 0 */
 		if (rx_desc & RXQ_GOOD) {
-			tstat->stat = SAM_STAT_GOOD;
+			tstat->stat = SAS_SAM_STAT_GOOD;
 			tstat->resp = SAS_TASK_COMPLETE;
 		}
 		/* response frame present */
@@ -1773,12 +1773,12 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 						sizeof(struct mvs_err_info);
 			sas_ssp_task_response(mvi->dev, task, iu);
 		} else
-			tstat->stat = SAM_STAT_CHECK_CONDITION;
+			tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 
 	case SAS_PROTOCOL_SMP: {
 			struct scatterlist *sg_resp = &task->smp_task.smp_resp;
-			tstat->stat = SAM_STAT_GOOD;
+			tstat->stat = SAS_SAM_STAT_GOOD;
 			to = kmap_atomic(sg_page(sg_resp));
 			memcpy(to + sg_resp->offset,
 				slot->response + sizeof(struct mvs_err_info),
@@ -1795,7 +1795,7 @@ int mvs_slot_complete(struct mvs_info *mvi, u32 rx_desc, u32 flags)
 		}
 
 	default:
-		tstat->stat = SAM_STAT_CHECK_CONDITION;
+		tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
 		break;
 	}
 	if (!slot->port->port_attached) {
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index da9fbe62a34d..e9b3485baee0 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1881,7 +1881,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			   param);
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 		} else {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_PROTO_RESPONSE;
@@ -2341,7 +2341,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			/* check if response is for SEND READ LOG */
 			if (pm8001_dev &&
 				(pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
@@ -2864,7 +2864,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		break;
@@ -2891,17 +2891,17 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_ERROR_HW_TIMEOUT:
 		pm8001_dbg(pm8001_ha, IO, "IO_ERROR_HW_TIMEOUT\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_BREAK:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_BREAK\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_PHY_NOT_READY:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_PHY_NOT_READY\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
 		pm8001_dbg(pm8001_ha, IO,
@@ -3656,7 +3656,7 @@ int pm8001_mpi_task_abort_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, EH, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		break;
 	case IO_NOT_VALID:
 		pm8001_dbg(pm8001_ha, EH, "IO_NOT_VALID\n");
@@ -4288,7 +4288,7 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 
 			spin_lock_irqsave(&task->task_state_lock, flags);
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 			task->task_state_flags |= SAS_TASK_STATE_DONE;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ba5852548bee..a16ed0695f1a 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -764,7 +764,7 @@ static int pm8001_exec_internal_tmf_task(struct domain_device *dev,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAM_STAT_GOOD) {
+			task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 		}
@@ -846,7 +846,7 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
 		}
 
 		if (task->task_status.resp == SAS_TASK_COMPLETE &&
-			task->task_status.stat == SAM_STAT_GOOD) {
+			task->task_status.stat == SAS_SAM_STAT_GOOD) {
 			res = TMF_RESP_FUNC_COMPLETE;
 			break;
 
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 0305c8999ba5..c98c0a53a018 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -1916,7 +1916,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_ha , void *piomb)
 			   param);
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 		} else {
 			ts->resp = SAS_TASK_COMPLETE;
 			ts->stat = SAS_PROTO_RESPONSE;
@@ -2450,7 +2450,7 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		if (param == 0) {
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			/* check if response is for SEND READ LOG */
 			if (pm8001_dev &&
 				(pm8001_dev->id & NCQ_READ_LOG_FLAG)) {
@@ -3004,7 +3004,7 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_SUCCESS:
 		pm8001_dbg(pm8001_ha, IO, "IO_SUCCESS\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_GOOD;
+		ts->stat = SAS_SAM_STAT_GOOD;
 		if (pm8001_dev)
 			atomic_dec(&pm8001_dev->running_req);
 		if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
@@ -3046,17 +3046,17 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	case IO_ERROR_HW_TIMEOUT:
 		pm8001_dbg(pm8001_ha, IO, "IO_ERROR_HW_TIMEOUT\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_BREAK:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_BREAK\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_XFER_ERROR_PHY_NOT_READY:
 		pm8001_dbg(pm8001_ha, IO, "IO_XFER_ERROR_PHY_NOT_READY\n");
 		ts->resp = SAS_TASK_COMPLETE;
-		ts->stat = SAM_STAT_BUSY;
+		ts->stat = SAS_SAM_STAT_BUSY;
 		break;
 	case IO_OPEN_CNX_ERROR_PROTOCOL_NOT_SUPPORTED:
 		pm8001_dbg(pm8001_ha, IO,
@@ -4679,7 +4679,7 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
 
 			spin_lock_irqsave(&task->task_state_lock, flags);
 			ts->resp = SAS_TASK_COMPLETE;
-			ts->stat = SAM_STAT_GOOD;
+			ts->stat = SAS_SAM_STAT_GOOD;
 			task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
 			task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 			task->task_state_flags |= SAS_TASK_STATE_DONE;
diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index 2386bfb73c46..4a536c837708 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -60,6 +60,8 @@ extern uint qedf_debug;
 #define QEDF_LOG_NOTICE	0x40000000	/* Notice logs */
 #define QEDF_LOG_WARN		0x80000000	/* Warning logs */
 
+#define QEDF_DEBUGFS_LOG_LEN (2 * PAGE_SIZE)
+
 /* Debug context structure */
 struct qedf_dbg_ctx {
 	unsigned int host_no;
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index a3ed681c8ce3..451fd236bfd0 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
+#include <linux/vmalloc.h>
 
 #include "qedf.h"
 #include "qedf_dbg.h"
@@ -98,7 +99,9 @@ static ssize_t
 qedf_dbg_fp_int_cmd_read(struct file *filp, char __user *buffer, size_t count,
 			 loff_t *ppos)
 {
+	ssize_t ret;
 	size_t cnt = 0;
+	char *cbuf;
 	int id;
 	struct qedf_fastpath *fp = NULL;
 	struct qedf_dbg_ctx *qedf_dbg =
@@ -108,19 +111,25 @@ qedf_dbg_fp_int_cmd_read(struct file *filp, char __user *buffer, size_t count,
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
 
-	cnt = sprintf(buffer, "\nFastpath I/O completions\n\n");
+	cbuf = vmalloc(QEDF_DEBUGFS_LOG_LEN);
+	if (!cbuf)
+		return 0;
+
+	cnt += scnprintf(cbuf + cnt, QEDF_DEBUGFS_LOG_LEN - cnt, "\nFastpath I/O completions\n\n");
 
 	for (id = 0; id < qedf->num_queues; id++) {
 		fp = &(qedf->fp_array[id]);
 		if (fp->sb_id == QEDF_SB_ID_NULL)
 			continue;
-		cnt += sprintf((buffer + cnt), "#%d: %lu\n", id,
-			       fp->completions);
+		cnt += scnprintf(cbuf + cnt, QEDF_DEBUGFS_LOG_LEN - cnt,
+				 "#%d: %lu\n", id, fp->completions);
 	}
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	ret = simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
+
+	vfree(cbuf);
+
+	return ret;
 }
 
 static ssize_t
@@ -138,15 +147,14 @@ qedf_dbg_debug_cmd_read(struct file *filp, char __user *buffer, size_t count,
 			loff_t *ppos)
 {
 	int cnt;
+	char cbuf[32];
 	struct qedf_dbg_ctx *qedf_dbg =
 				(struct qedf_dbg_ctx *)filp->private_data;
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "debug mask=0x%x\n", qedf_debug);
-	cnt = sprintf(buffer, "debug mask = 0x%x\n", qedf_debug);
+	cnt = scnprintf(cbuf, sizeof(cbuf), "debug mask = 0x%x\n", qedf_debug);
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
 }
 
 static ssize_t
@@ -185,18 +193,17 @@ qedf_dbg_stop_io_on_error_cmd_read(struct file *filp, char __user *buffer,
 				   size_t count, loff_t *ppos)
 {
 	int cnt;
+	char cbuf[7];
 	struct qedf_dbg_ctx *qedf_dbg =
 				(struct qedf_dbg_ctx *)filp->private_data;
 	struct qedf_ctx *qedf = container_of(qedf_dbg,
 	    struct qedf_ctx, dbg_ctx);
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
-	cnt = sprintf(buffer, "%s\n",
+	cnt = scnprintf(cbuf, sizeof(cbuf), "%s\n",
 	    qedf->stop_io_on_error ? "true" : "false");
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
 }
 
 static ssize_t
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index cc2152c56d35..96e470746767 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1981,8 +1981,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1993,7 +1994,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 12e27ee8c5c7..f919da0bbf75 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -3028,8 +3028,6 @@ qla24xx_vport_create(struct fc_vport *fc_vport, bool disable)
 			vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_user, vha, 0x7082,
 			    "Registered for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			scsi_host_set_prot(vha->host,
 			    prot | SHOST_DIF_TYPE1_PROTECTION
 			    | SHOST_DIF_TYPE2_PROTECTION
diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 00b4d033b07a..8e9ffbec6643 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -18,7 +18,7 @@
  * | Queue Command and IO tracing |       0x3074       | 0x300b         |
  * |                              |                    | 0x3027-0x3028  |
  * |                              |                    | 0x303d-0x3041  |
- * |                              |                    | 0x302d,0x3033  |
+ * |                              |                    | 0x302e,0x3033  |
  * |                              |                    | 0x3036,0x3038  |
  * |                              |                    | 0x303a		|
  * | DPC Thread                   |       0x4023       | 0x4002,0x4013  |
@@ -112,8 +112,13 @@ qla27xx_dump_mpi_ram(struct qla_hw_data *ha, uint32_t addr, uint32_t *ram,
 	uint32_t stat;
 	ulong i, j, timer = 6000000;
 	int rval = QLA_FUNCTION_FAILED;
+	scsi_qla_host_t *vha = pci_get_drvdata(ha->pdev);
 
 	clear_bit(MBX_INTERRUPT, &ha->mbx_cmd_flags);
+
+	if (qla_pci_disconnected(vha, reg))
+		return rval;
+
 	for (i = 0; i < ram_dwords; i += dwords, addr += dwords) {
 		if (i + dwords > ram_dwords)
 			dwords = ram_dwords - i;
@@ -137,6 +142,9 @@ qla27xx_dump_mpi_ram(struct qla_hw_data *ha, uint32_t addr, uint32_t *ram,
 		while (timer--) {
 			udelay(5);
 
+			if (qla_pci_disconnected(vha, reg))
+				return rval;
+
 			stat = rd_reg_dword(&reg->host_status);
 			/* Check for pending interrupts. */
 			if (!(stat & HSRX_RISC_INT))
@@ -191,9 +199,13 @@ qla24xx_dump_ram(struct qla_hw_data *ha, uint32_t addr, __be32 *ram,
 	uint32_t dwords = qla2x00_gid_list_size(ha) / 4;
 	uint32_t stat;
 	ulong i, j, timer = 6000000;
+	scsi_qla_host_t *vha = pci_get_drvdata(ha->pdev);
 
 	clear_bit(MBX_INTERRUPT, &ha->mbx_cmd_flags);
 
+	if (qla_pci_disconnected(vha, reg))
+		return rval;
+
 	for (i = 0; i < ram_dwords; i += dwords, addr += dwords) {
 		if (i + dwords > ram_dwords)
 			dwords = ram_dwords - i;
@@ -215,8 +227,10 @@ qla24xx_dump_ram(struct qla_hw_data *ha, uint32_t addr, __be32 *ram,
 		ha->flags.mbox_int = 0;
 		while (timer--) {
 			udelay(5);
-			stat = rd_reg_dword(&reg->host_status);
+			if (qla_pci_disconnected(vha, reg))
+				return rval;
 
+			stat = rd_reg_dword(&reg->host_status);
 			/* Check for pending interrupts. */
 			if (!(stat & HSRX_RISC_INT))
 				continue;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 06b0ad2b51bb..6645b69fc2a0 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -396,6 +396,7 @@ typedef union {
 	} b;
 } port_id_t;
 #define INVALID_PORT_ID	0xFFFFFF
+#define ISP_REG16_DISCONNECT 0xFFFF
 
 static inline le_id_t be_id_to_le(be_id_t id)
 {
@@ -3848,6 +3849,13 @@ struct qla_hw_data_stat {
 	u32 num_mpi_reset;
 };
 
+/* refer to pcie_do_recovery reference */
+typedef enum {
+	QLA_PCI_RESUME,
+	QLA_PCI_ERR_DETECTED,
+	QLA_PCI_MMIO_ENABLED,
+	QLA_PCI_SLOT_RESET,
+} pci_error_state_t;
 /*
  * Qlogic host adapter specific data structure.
 */
@@ -4192,7 +4200,6 @@ struct qla_hw_data {
 	uint8_t		aen_mbx_count;
 	atomic_t	num_pend_mbx_stage1;
 	atomic_t	num_pend_mbx_stage2;
-	atomic_t	num_pend_mbx_stage3;
 	uint16_t	frame_payload_size;
 
 	uint32_t	login_retry_count;
@@ -4586,6 +4593,7 @@ struct qla_hw_data {
 #define DEFAULT_ZIO_THRESHOLD 5
 
 	struct qla_hw_data_stat stat;
+	pci_error_state_t pci_error_state;
 };
 
 struct active_regions {
@@ -4706,7 +4714,7 @@ typedef struct scsi_qla_host {
 #define FX00_CRITEMP_RECOVERY	25
 #define FX00_HOST_INFO_RESEND	26
 #define QPAIR_ONLINE_CHECK_NEEDED	27
-#define SET_NVME_ZIO_THRESHOLD_NEEDED	28
+#define DO_EEH_RECOVERY		28
 #define DETECT_SFP_CHANGE	29
 #define N2N_LOGIN_NEEDED	30
 #define IOCB_WORK_ACTIVE	31
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 7e5ee31581d6..8ef2de6822de 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -222,6 +222,7 @@ extern int qla2x00_post_uevent_work(struct scsi_qla_host *, u32);
 
 extern int qla2x00_post_uevent_work(struct scsi_qla_host *, u32);
 extern void qla2x00_disable_board_on_pci_error(struct work_struct *);
+extern void qla_eeh_work(struct work_struct *);
 extern void qla2x00_sp_compl(srb_t *sp, int);
 extern void qla2xxx_qpair_sp_free_dma(srb_t *sp);
 extern void qla2xxx_qpair_sp_compl(srb_t *sp, int);
@@ -233,6 +234,8 @@ int qla24xx_post_relogin_work(struct scsi_qla_host *vha);
 void qla2x00_wait_for_sess_deletion(scsi_qla_host_t *);
 void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 			       struct purex_item *pkt);
+void qla_pci_set_eeh_busy(struct scsi_qla_host *);
+void qla_schedule_eeh_work(struct scsi_qla_host *);
 
 /*
  * Global Functions in qla_mid.c source file.
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 3d1a53ba86ac..a8d2c06285c2 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -483,6 +483,7 @@ static
 void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	struct fc_port *fcport = ea->fcport;
+	unsigned long flags;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d2,
 	    "%s %8phC DS %d LS %d rc %d login %d|%d rscn %d|%d lid %d\n",
@@ -497,9 +498,15 @@ void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 		ql_dbg(ql_dbg_disc, vha, 0x2066,
 		    "%s %8phC: adisc fail: post delete\n",
 		    __func__, ea->fcport->port_name);
+
+		spin_lock_irqsave(&vha->work_lock, flags);
 		/* deleted = 0 & logout_on_delete = force fw cleanup */
-		fcport->deleted = 0;
+		if (fcport->deleted == QLA_SESS_DELETED)
+			fcport->deleted = 0;
+
 		fcport->logout_on_delete = 1;
+		spin_unlock_irqrestore(&vha->work_lock, flags);
+
 		qlt_schedule_sess_for_deletion(ea->fcport);
 		return;
 	}
@@ -1405,7 +1412,6 @@ void __qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	ea->fcport->login_gen++;
-	ea->fcport->deleted = 0;
 	ea->fcport->logout_on_delete = 1;
 
 	if (!ea->fcport->login_succ && !IS_SW_RESV_ADDR(ea->fcport->d_id)) {
@@ -4336,15 +4342,16 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 		memcpy(ha->port_name, ha->init_cb->port_name, WWN_SIZE);
 	}
 
+	QLA_FW_STARTED(ha);
 	rval = qla2x00_init_firmware(vha, ha->init_cb_size);
 next_check:
 	if (rval) {
+		QLA_FW_STOPPED(ha);
 		ql_log(ql_log_fatal, vha, 0x00d2,
 		    "Init Firmware **** FAILED ****.\n");
 	} else {
 		ql_dbg(ql_dbg_init, vha, 0x00d3,
 		    "Init Firmware -- success.\n");
-		QLA_FW_STARTED(ha);
 		vha->u_ql2xexchoffld = vha->u_ql2xiniexchg = 0;
 	}
 
@@ -5107,7 +5114,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
@@ -5639,6 +5646,8 @@ qla2x00_reg_remote_port(scsi_qla_host_t *vha, fc_port_t *fcport)
 void
 qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 {
+	unsigned long flags;
+
 	if (IS_SW_RESV_ADDR(fcport->d_id))
 		return;
 
@@ -5648,7 +5657,11 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 	qla2x00_set_fcport_disc_state(fcport, DSC_UPD_FCPORT);
 	fcport->login_retry = vha->hw->login_retry_count;
 	fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
+
+	spin_lock_irqsave(&vha->work_lock, flags);
 	fcport->deleted = 0;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
 	if (vha->hw->current_topology == ISP_CFG_NL)
 		fcport->logout_on_delete = 0;
 	else
@@ -6913,14 +6926,15 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 	}
 
 	/* purge MBox commands */
-	if (atomic_read(&ha->num_pend_mbx_stage3)) {
+	spin_lock_irqsave(&ha->hardware_lock, flags);
+	if (test_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags)) {
 		clear_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags);
 		complete(&ha->mbx_intr_comp);
 	}
+	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 	i = 0;
-	while (atomic_read(&ha->num_pend_mbx_stage3) ||
-	    atomic_read(&ha->num_pend_mbx_stage2) ||
+	while (atomic_read(&ha->num_pend_mbx_stage2) ||
 	    atomic_read(&ha->num_pend_mbx_stage1)) {
 		msleep(20);
 		i++;
@@ -6969,22 +6983,18 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
 	}
 	spin_unlock_irqrestore(&ha->vport_slock, flags);
 
-	if (!ha->flags.eeh_busy) {
-		/* Make sure for ISP 82XX IO DMA is complete */
-		if (IS_P3P_TYPE(ha)) {
-			qla82xx_chip_reset_cleanup(vha);
-			ql_log(ql_log_info, vha, 0x00b4,
-			    "Done chip reset cleanup.\n");
-
-			/* Done waiting for pending commands.
-			 * Reset the online flag.
-			 */
-			vha->flags.online = 0;
-		}
+	/* Make sure for ISP 82XX IO DMA is complete */
+	if (IS_P3P_TYPE(ha)) {
+		qla82xx_chip_reset_cleanup(vha);
+		ql_log(ql_log_info, vha, 0x00b4,
+		       "Done chip reset cleanup.\n");
 
-		/* Requeue all commands in outstanding command list. */
-		qla2x00_abort_all_cmds(vha, DID_RESET << 16);
+		/* Done waiting for pending commands. Reset online flag */
+		vha->flags.online = 0;
 	}
+
+	/* Requeue all commands in outstanding command list. */
+	qla2x00_abort_all_cmds(vha, DID_RESET << 16);
 	/* memory barrier */
 	wmb();
 }
@@ -7012,6 +7022,12 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 	if (vha->flags.online) {
 		qla2x00_abort_isp_cleanup(vha);
 
+		if (qla2x00_isp_reg_stat(ha)) {
+			ql_log(ql_log_info, vha, 0x803f,
+			       "ISP Abort - ISP reg disconnect, exiting.\n");
+			return status;
+		}
+
 		if (test_and_clear_bit(ISP_ABORT_TO_ROM, &vha->dpc_flags)) {
 			ha->flags.chip_reset_done = 1;
 			vha->flags.online = 1;
@@ -7052,8 +7068,18 @@ qla2x00_abort_isp(scsi_qla_host_t *vha)
 
 		ha->isp_ops->get_flash_version(vha, req->ring);
 
+		if (qla2x00_isp_reg_stat(ha)) {
+			ql_log(ql_log_info, vha, 0x803f,
+			       "ISP Abort - ISP reg disconnect pre nvram config, exiting.\n");
+			return status;
+		}
 		ha->isp_ops->nvram_config(vha);
 
+		if (qla2x00_isp_reg_stat(ha)) {
+			ql_log(ql_log_info, vha, 0x803f,
+			       "ISP Abort - ISP reg disconnect post nvmram config, exiting.\n");
+			return status;
+		}
 		if (!qla2x00_restart_isp(vha)) {
 			clear_bit(RESET_MARKER_NEEDED, &vha->dpc_flags);
 
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 7e8b59a0954b..47ee5b9f2a55 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -435,3 +435,49 @@ qla_put_iocbs(struct qla_qpair *qp, struct iocb_resource *iores)
 	}
 	iores->res_type = RESOURCE_NONE;
 }
+
+#define ISP_REG_DISCONNECT 0xffffffffU
+/**************************************************************************
+ * qla2x00_isp_reg_stat
+ *
+ * Description:
+ *        Read the host status register of ISP before aborting the command.
+ *
+ * Input:
+ *       ha = pointer to host adapter structure.
+ *
+ *
+ * Returns:
+ *       Either true or false.
+ *
+ * Note: Return true if there is register disconnect.
+ **************************************************************************/
+static inline
+uint32_t qla2x00_isp_reg_stat(struct qla_hw_data *ha)
+{
+	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
+	struct device_reg_82xx __iomem *reg82 = &ha->iobase->isp82;
+
+	if (IS_P3P_TYPE(ha))
+		return ((rd_reg_dword(&reg82->host_int)) == ISP_REG_DISCONNECT);
+	else
+		return ((rd_reg_dword(&reg->host_status)) ==
+			ISP_REG_DISCONNECT);
+}
+
+static inline
+bool qla_pci_disconnected(struct scsi_qla_host *vha,
+			  struct device_reg_24xx __iomem *reg)
+{
+	uint32_t stat;
+	bool ret = false;
+
+	stat = rd_reg_dword(&reg->host_status);
+	if (stat == 0xffffffff) {
+		ql_log(ql_log_info, vha, 0x8041,
+		       "detected PCI disconnect.\n");
+		qla_schedule_eeh_work(vha);
+		ret = true;
+	}
+	return ret;
+}
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 54fc0afbc02a..1752a6203171 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1644,8 +1644,14 @@ qla24xx_start_scsi(srb_t *sp)
 		goto queuing_error;
 
 	if (req->cnt < (req_cnt + 2)) {
-		cnt = IS_SHADOW_REG_CAPABLE(ha) ? *req->out_ptr :
-		    rd_reg_dword_relaxed(req->req_q_out);
+		if (IS_SHADOW_REG_CAPABLE(ha)) {
+			cnt = *req->out_ptr;
+		} else {
+			cnt = rd_reg_dword_relaxed(req->req_q_out);
+			if (qla2x00_check_reg16_for_disconnect(vha, cnt))
+				goto queuing_error;
+		}
+
 		if (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
 		else
@@ -1836,8 +1842,13 @@ qla24xx_dif_start_scsi(srb_t *sp)
 		goto queuing_error;
 
 	if (req->cnt < (req_cnt + 2)) {
-		cnt = IS_SHADOW_REG_CAPABLE(ha) ? *req->out_ptr :
-		    rd_reg_dword_relaxed(req->req_q_out);
+		if (IS_SHADOW_REG_CAPABLE(ha)) {
+			cnt = *req->out_ptr;
+		} else {
+			cnt = rd_reg_dword_relaxed(req->req_q_out);
+			if (qla2x00_check_reg16_for_disconnect(vha, cnt))
+				goto queuing_error;
+		}
 		if (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
 		else
@@ -1911,6 +1922,7 @@ qla24xx_dif_start_scsi(srb_t *sp)
 
 	qla_put_iocbs(sp->qpair, &sp->iores);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
+
 	return QLA_FUNCTION_FAILED;
 }
 
@@ -1978,8 +1990,14 @@ qla2xxx_start_scsi_mq(srb_t *sp)
 		goto queuing_error;
 
 	if (req->cnt < (req_cnt + 2)) {
-		cnt = IS_SHADOW_REG_CAPABLE(ha) ? *req->out_ptr :
-		    rd_reg_dword_relaxed(req->req_q_out);
+		if (IS_SHADOW_REG_CAPABLE(ha)) {
+			cnt = *req->out_ptr;
+		} else {
+			cnt = rd_reg_dword_relaxed(req->req_q_out);
+			if (qla2x00_check_reg16_for_disconnect(vha, cnt))
+				goto queuing_error;
+		}
+
 		if (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
 		else
@@ -2185,8 +2203,14 @@ qla2xxx_dif_start_scsi_mq(srb_t *sp)
 		goto queuing_error;
 
 	if (req->cnt < (req_cnt + 2)) {
-		cnt = IS_SHADOW_REG_CAPABLE(ha) ? *req->out_ptr :
-		    rd_reg_dword_relaxed(req->req_q_out);
+		if (IS_SHADOW_REG_CAPABLE(ha)) {
+			cnt = *req->out_ptr;
+		} else {
+			cnt = rd_reg_dword_relaxed(req->req_q_out);
+			if (qla2x00_check_reg16_for_disconnect(vha, cnt))
+				goto queuing_error;
+		}
+
 		if (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
 		else
@@ -2263,6 +2287,7 @@ qla2xxx_dif_start_scsi_mq(srb_t *sp)
 
 	qla_put_iocbs(sp->qpair, &sp->iores);
 	spin_unlock_irqrestore(&qpair->qp_lock, flags);
+
 	return QLA_FUNCTION_FAILED;
 }
 
@@ -2307,6 +2332,11 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 			cnt = qla2x00_debounce_register(
 			    ISP_REQ_Q_OUT(ha, &reg->isp));
 
+		if (!qpair->use_shadow_reg && cnt == ISP_REG16_DISCONNECT) {
+			qla_schedule_eeh_work(vha);
+			return NULL;
+		}
+
 		if  (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
 		else
@@ -3711,6 +3741,9 @@ qla2x00_start_sp(srb_t *sp)
 	void *pkt;
 	unsigned long flags;
 
+	if (vha->hw->flags.eeh_busy)
+		return -EIO;
+
 	spin_lock_irqsave(qp->qp_lock_ptr, flags);
 	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
 	if (!pkt) {
@@ -3928,8 +3961,14 @@ qla2x00_start_bidir(srb_t *sp, struct scsi_qla_host *vha, uint32_t tot_dsds)
 
 	/* Check for room on request queue. */
 	if (req->cnt < req_cnt + 2) {
-		cnt = IS_SHADOW_REG_CAPABLE(ha) ? *req->out_ptr :
-		    rd_reg_dword_relaxed(req->req_q_out);
+		if (IS_SHADOW_REG_CAPABLE(ha)) {
+			cnt = *req->out_ptr;
+		} else {
+			cnt = rd_reg_dword_relaxed(req->req_q_out);
+			if (qla2x00_check_reg16_for_disconnect(vha, cnt))
+				goto queuing_error;
+		}
+
 		if  (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
 		else
@@ -3968,5 +4007,6 @@ qla2x00_start_bidir(srb_t *sp, struct scsi_qla_host *vha, uint32_t tot_dsds)
 	qla2x00_start_iocbs(vha, req);
 queuing_error:
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
+
 	return rval;
 }
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 7ea73ad845de..fd0beb194e35 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -269,12 +269,7 @@ qla2x00_check_reg32_for_disconnect(scsi_qla_host_t *vha, uint32_t reg)
 		if (!test_and_set_bit(PFLG_DISCONNECTED, &vha->pci_flags) &&
 		    !test_bit(PFLG_DRIVER_REMOVING, &vha->pci_flags) &&
 		    !test_bit(PFLG_DRIVER_PROBING, &vha->pci_flags)) {
-			/*
-			 * Schedule this (only once) on the default system
-			 * workqueue so that all the adapter workqueues and the
-			 * DPC thread can be shutdown cleanly.
-			 */
-			schedule_work(&vha->hw->board_disable);
+			qla_schedule_eeh_work(vha);
 		}
 		return true;
 	} else
@@ -982,8 +977,12 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 	unsigned long	flags;
 	fc_port_t	*fcport = NULL;
 
-	if (!vha->hw->flags.fw_started)
+	if (!vha->hw->flags.fw_started) {
+		ql_log(ql_log_warn, vha, 0x50ff,
+		    "Dropping AEN - %04x %04x %04x %04x.\n",
+		    mb[0], mb[1], mb[2], mb[3]);
 		return;
+	}
 
 	/* Setup to process RIO completion. */
 	handle_cnt = 0;
@@ -1639,8 +1638,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 	case MBA_TEMPERATURE_ALERT:
 		ql_dbg(ql_dbg_async, vha, 0x505e,
 		    "TEMPERATURE ALERT: %04x %04x %04x\n", mb[1], mb[2], mb[3]);
-		if (mb[1] == 0x12)
-			schedule_work(&ha->board_disable);
 		break;
 
 	case MBA_TRANS_INSERT:
@@ -3139,7 +3136,6 @@ qla2x00_status_entry(scsi_qla_host_t *vha, struct rsp_que *rsp, void *pkt)
 	case CS_PORT_BUSY:
 	case CS_INCOMPLETE:
 	case CS_PORT_UNAVAILABLE:
-	case CS_TIMEOUT:
 	case CS_RESET:
 
 		/*
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 6ff720d8961d..21ba7100ff67 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -167,7 +167,8 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 	/* check if ISP abort is active and return cmd with timeout */
 	if ((test_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags) ||
 	    test_bit(ISP_ABORT_RETRY, &base_vha->dpc_flags) ||
-	    test_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags)) &&
+	    test_bit(ISP_ABORT_NEEDED, &base_vha->dpc_flags) ||
+	    ha->flags.eeh_busy) &&
 	    !is_rom_cmd(mcp->mb[0])) {
 		ql_log(ql_log_info, vha, 0x1005,
 		    "Cmd 0x%x aborted with timeout since ISP Abort is pending\n",
@@ -268,7 +269,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		wait_time = jiffies;
-		atomic_inc(&ha->num_pend_mbx_stage3);
 		if (!wait_for_completion_timeout(&ha->mbx_intr_comp,
 		    mcp->tov * HZ)) {
 			ql_dbg(ql_dbg_mbx, vha, 0x117a,
@@ -283,7 +283,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				spin_unlock_irqrestore(&ha->hardware_lock,
 				    flags);
 				atomic_dec(&ha->num_pend_mbx_stage2);
-				atomic_dec(&ha->num_pend_mbx_stage3);
 				rval = QLA_ABORTED;
 				goto premature_exit;
 			}
@@ -293,11 +292,9 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			ha->flags.mbox_busy = 0;
 			spin_unlock_irqrestore(&ha->hardware_lock, flags);
 			atomic_dec(&ha->num_pend_mbx_stage2);
-			atomic_dec(&ha->num_pend_mbx_stage3);
 			rval = QLA_ABORTED;
 			goto premature_exit;
 		}
-		atomic_dec(&ha->num_pend_mbx_stage3);
 
 		if (time_after(jiffies, wait_time + 5 * HZ))
 			ql_log(ql_log_warn, vha, 0x1015, "cmd=0x%x, waited %d msecs\n",
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 8b0c8f9bdef0..6dad7787f20d 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -397,8 +397,13 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 	}
 	req_cnt = qla24xx_calc_iocbs(vha, tot_dsds);
 	if (req->cnt < (req_cnt + 2)) {
-		cnt = IS_SHADOW_REG_CAPABLE(ha) ? *req->out_ptr :
-		    rd_reg_dword_relaxed(req->req_q_out);
+		if (IS_SHADOW_REG_CAPABLE(ha)) {
+			cnt = *req->out_ptr;
+		} else {
+			cnt = rd_reg_dword_relaxed(req->req_q_out);
+			if (qla2x00_check_reg16_for_disconnect(vha, cnt))
+				goto queuing_error;
+		}
 
 		if (req->ring_index < cnt)
 			req->cnt = cnt - req->ring_index;
@@ -535,6 +540,7 @@ static inline int qla2x00_start_nvme_mq(srb_t *sp)
 
 queuing_error:
 	spin_unlock_irqrestore(&qpair->qp_lock, flags);
+
 	return rval;
 }
 
@@ -604,7 +610,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	rval = qla2x00_start_nvme_mq(sp);
 	if (rval != QLA_SUCCESS) {
-		ql_log(ql_log_warn, vha, 0x212d,
+		ql_dbg(ql_dbg_io + ql_dbg_verbose, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
 		sp->priv = NULL;
 		priv->sp = NULL;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index cbc5af26303a..8d199deaf3b1 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -879,8 +879,8 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 			goto qc24_fail_command;
 	}
 
-	if (!fcport) {
-		cmd->result = DID_NO_CONNECT << 16;
+	if (!fcport || fcport->deleted) {
+		cmd->result = DID_IMM_RETRY << 16;
 		goto qc24_fail_command;
 	}
 
@@ -961,11 +961,18 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 		goto qc24_fail_command;
 	}
 
-	if (!fcport) {
+	if (!qpair->online) {
+		ql_dbg(ql_dbg_io, vha, 0x3077,
+		       "qpair not online. eeh_busy=%d.\n", ha->flags.eeh_busy);
 		cmd->result = DID_NO_CONNECT << 16;
 		goto qc24_fail_command;
 	}
 
+	if (!fcport || fcport->deleted) {
+		cmd->result = DID_IMM_RETRY << 16;
+		goto qc24_fail_command;
+	}
+
 	if (atomic_read(&fcport->state) != FCS_ONLINE || fcport->deleted) {
 		if (atomic_read(&fcport->state) == FCS_DEVICE_DEAD ||
 			atomic_read(&base_vha->loop_state) == LOOP_DEAD) {
@@ -1190,35 +1197,6 @@ qla2x00_wait_for_chip_reset(scsi_qla_host_t *vha)
 	return return_status;
 }
 
-#define ISP_REG_DISCONNECT 0xffffffffU
-/**************************************************************************
-* qla2x00_isp_reg_stat
-*
-* Description:
-*	Read the host status register of ISP before aborting the command.
-*
-* Input:
-*	ha = pointer to host adapter structure.
-*
-*
-* Returns:
-*	Either true or false.
-*
-* Note:	Return true if there is register disconnect.
-**************************************************************************/
-static inline
-uint32_t qla2x00_isp_reg_stat(struct qla_hw_data *ha)
-{
-	struct device_reg_24xx __iomem *reg = &ha->iobase->isp24;
-	struct device_reg_82xx __iomem *reg82 = &ha->iobase->isp82;
-
-	if (IS_P3P_TYPE(ha))
-		return ((rd_reg_dword(&reg82->host_int)) == ISP_REG_DISCONNECT);
-	else
-		return ((rd_reg_dword(&reg->host_status)) ==
-			ISP_REG_DISCONNECT);
-}
-
 /**************************************************************************
 * qla2xxx_eh_abort
 *
@@ -1253,6 +1231,7 @@ qla2xxx_eh_abort(struct scsi_cmnd *cmd)
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x8042,
 		    "PCI/Register disconnect, exiting.\n");
+		qla_pci_set_eeh_busy(vha);
 		return FAILED;
 	}
 
@@ -1444,6 +1423,7 @@ qla2xxx_eh_device_reset(struct scsi_cmnd *cmd)
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x803e,
 		    "PCI/Register disconnect, exiting.\n");
+		qla_pci_set_eeh_busy(vha);
 		return FAILED;
 	}
 
@@ -1460,6 +1440,7 @@ qla2xxx_eh_target_reset(struct scsi_cmnd *cmd)
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x803f,
 		    "PCI/Register disconnect, exiting.\n");
+		qla_pci_set_eeh_busy(vha);
 		return FAILED;
 	}
 
@@ -1495,6 +1476,7 @@ qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x8040,
 		    "PCI/Register disconnect, exiting.\n");
+		qla_pci_set_eeh_busy(vha);
 		return FAILED;
 	}
 
@@ -1572,7 +1554,7 @@ qla2xxx_eh_host_reset(struct scsi_cmnd *cmd)
 	if (qla2x00_isp_reg_stat(ha)) {
 		ql_log(ql_log_info, vha, 0x8041,
 		    "PCI/Register disconnect, exiting.\n");
-		schedule_work(&ha->board_disable);
+		qla_pci_set_eeh_busy(vha);
 		return SUCCESS;
 	}
 
@@ -2866,7 +2848,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ha->max_exchg = FW_MAX_EXCHANGES_CNT;
 	atomic_set(&ha->num_pend_mbx_stage1, 0);
 	atomic_set(&ha->num_pend_mbx_stage2, 0);
-	atomic_set(&ha->num_pend_mbx_stage3, 0);
 	atomic_set(&ha->zio_threshold, DEFAULT_ZIO_THRESHOLD);
 	ha->last_zio_threshold = DEFAULT_ZIO_THRESHOLD;
 
@@ -3141,6 +3122,13 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	host->max_id = ha->max_fibre_devices;
 	host->cmd_per_lun = 3;
 	host->unique_id = host->host_no;
+
+	if (ql2xenabledif && ql2xenabledif != 2) {
+		ql_log(ql_log_warn, base_vha, 0x302d,
+		       "Invalid value for ql2xenabledif, resetting it to default (2)\n");
+		ql2xenabledif = 2;
+	}
+
 	if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif)
 		host->max_cmd_len = 32;
 	else
@@ -3373,8 +3361,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			base_vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_init, base_vha, 0x00f1,
 			    "Registering for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			if (ql2xprotmask)
 				scsi_host_set_prot(host, ql2xprotmask);
 			else
@@ -6672,6 +6658,9 @@ qla2x00_do_dpc(void *data)
 
 		schedule();
 
+		if (test_and_clear_bit(DO_EEH_RECOVERY, &base_vha->dpc_flags))
+			qla_pci_set_eeh_busy(base_vha);
+
 		if (!base_vha->flags.init_done || ha->flags.mbox_busy)
 			goto end_loop;
 
@@ -6968,28 +6957,23 @@ qla2x00_do_dpc(void *data)
 			mutex_unlock(&ha->mq_lock);
 		}
 
-		if (test_and_clear_bit(SET_NVME_ZIO_THRESHOLD_NEEDED,
-		    &base_vha->dpc_flags)) {
+		if (test_and_clear_bit(SET_ZIO_THRESHOLD_NEEDED,
+				       &base_vha->dpc_flags)) {
+			u16 threshold = ha->nvme_last_rptd_aen + ha->last_zio_threshold;
+
+			if (threshold > ha->orig_fw_xcb_count)
+				threshold = ha->orig_fw_xcb_count;
+
 			ql_log(ql_log_info, base_vha, 0xffffff,
-				"nvme: SET ZIO Activity exchange threshold to %d.\n",
-						ha->nvme_last_rptd_aen);
-			if (qla27xx_set_zio_threshold(base_vha,
-			    ha->nvme_last_rptd_aen)) {
+			       "SET ZIO Activity exchange threshold to %d.\n",
+			       threshold);
+			if (qla27xx_set_zio_threshold(base_vha, threshold)) {
 				ql_log(ql_log_info, base_vha, 0xffffff,
-				    "nvme: Unable to SET ZIO Activity exchange threshold to %d.\n",
-				    ha->nvme_last_rptd_aen);
+				       "Unable to SET ZIO Activity exchange threshold to %d.\n",
+				       threshold);
 			}
 		}
 
-		if (test_and_clear_bit(SET_ZIO_THRESHOLD_NEEDED,
-		    &base_vha->dpc_flags)) {
-			ql_log(ql_log_info, base_vha, 0xffffff,
-			    "SET ZIO Activity exchange threshold to %d.\n",
-			    ha->last_zio_threshold);
-			qla27xx_set_zio_threshold(base_vha,
-			    ha->last_zio_threshold);
-		}
-
 		if (!IS_QLAFX00(ha))
 			qla2x00_do_dpc_all_vps(base_vha);
 
@@ -7205,14 +7189,13 @@ qla2x00_timer(struct timer_list *t)
 	index = atomic_read(&ha->nvme_active_aen_cnt);
 	if (!vha->vp_idx &&
 	    (index != ha->nvme_last_rptd_aen) &&
-	    (index >= DEFAULT_ZIO_THRESHOLD) &&
 	    ha->zio_mode == QLA_ZIO_MODE_6 &&
 	    !ha->flags.host_shutting_down) {
+		ha->nvme_last_rptd_aen = atomic_read(&ha->nvme_active_aen_cnt);
 		ql_log(ql_log_info, vha, 0x3002,
 		    "nvme: Sched: Set ZIO exchange threshold to %d.\n",
 		    ha->nvme_last_rptd_aen);
-		ha->nvme_last_rptd_aen = atomic_read(&ha->nvme_active_aen_cnt);
-		set_bit(SET_NVME_ZIO_THRESHOLD_NEEDED, &vha->dpc_flags);
+		set_bit(SET_ZIO_THRESHOLD_NEEDED, &vha->dpc_flags);
 		start_dpc++;
 	}
 
@@ -7385,6 +7368,8 @@ static void qla_pci_error_cleanup(scsi_qla_host_t *vha)
 	int i;
 	unsigned long flags;
 
+	ql_dbg(ql_dbg_aer, vha, 0x9000,
+	       "%s\n", __func__);
 	ha->chip_reset++;
 
 	ha->base_qpair->chip_reset = ha->chip_reset;
@@ -7394,28 +7379,16 @@ static void qla_pci_error_cleanup(scsi_qla_host_t *vha)
 			    ha->base_qpair->chip_reset;
 	}
 
-	/* purge MBox commands */
-	if (atomic_read(&ha->num_pend_mbx_stage3)) {
-		clear_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags);
-		complete(&ha->mbx_intr_comp);
-	}
-
-	i = 0;
-
-	while (atomic_read(&ha->num_pend_mbx_stage3) ||
-	    atomic_read(&ha->num_pend_mbx_stage2) ||
-	    atomic_read(&ha->num_pend_mbx_stage1)) {
-		msleep(20);
-		i++;
-		if (i > 50)
-			break;
-	}
-
-	ha->flags.purge_mbox = 0;
+	/*
+	 * purge mailbox might take a while. Slot Reset/chip reset
+	 * will take care of the purge
+	 */
 
 	mutex_lock(&ha->mq_lock);
+	ha->base_qpair->online = 0;
 	list_for_each_entry(qpair, &base_vha->qp_list, qp_list_elem)
 		qpair->online = 0;
+	wmb();
 	mutex_unlock(&ha->mq_lock);
 
 	qla2x00_mark_all_devices_lost(vha);
@@ -7452,14 +7425,17 @@ qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 {
 	scsi_qla_host_t *vha = pci_get_drvdata(pdev);
 	struct qla_hw_data *ha = vha->hw;
+	pci_ers_result_t ret = PCI_ERS_RESULT_NEED_RESET;
 
-	ql_dbg(ql_dbg_aer, vha, 0x9000,
-	    "PCI error detected, state %x.\n", state);
+	ql_log(ql_log_warn, vha, 0x9000,
+	       "PCI error detected, state %x.\n", state);
+	ha->pci_error_state = QLA_PCI_ERR_DETECTED;
 
 	if (!atomic_read(&pdev->enable_cnt)) {
 		ql_log(ql_log_info, vha, 0xffff,
 			"PCI device is disabled,state %x\n", state);
-		return PCI_ERS_RESULT_NEED_RESET;
+		ret = PCI_ERS_RESULT_NEED_RESET;
+		goto out;
 	}
 
 	switch (state) {
@@ -7469,11 +7445,12 @@ qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
 			qla2xxx_wake_dpc(vha);
 		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
+		ret = PCI_ERS_RESULT_CAN_RECOVER;
+		break;
 	case pci_channel_io_frozen:
-		ha->flags.eeh_busy = 1;
-		qla_pci_error_cleanup(vha);
-		return PCI_ERS_RESULT_NEED_RESET;
+		qla_pci_set_eeh_busy(vha);
+		ret = PCI_ERS_RESULT_NEED_RESET;
+		break;
 	case pci_channel_io_perm_failure:
 		ha->flags.pci_channel_io_perm_failure = 1;
 		qla2x00_abort_all_cmds(vha, DID_NO_CONNECT << 16);
@@ -7481,9 +7458,12 @@ qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
 			qla2xxx_wake_dpc(vha);
 		}
-		return PCI_ERS_RESULT_DISCONNECT;
+		ret = PCI_ERS_RESULT_DISCONNECT;
 	}
-	return PCI_ERS_RESULT_NEED_RESET;
+out:
+	ql_dbg(ql_dbg_aer, vha, 0x600d,
+	       "PCI error detected returning [%x].\n", ret);
+	return ret;
 }
 
 static pci_ers_result_t
@@ -7497,6 +7477,10 @@ qla2xxx_pci_mmio_enabled(struct pci_dev *pdev)
 	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
 	struct device_reg_24xx __iomem *reg24 = &ha->iobase->isp24;
 
+	ql_log(ql_log_warn, base_vha, 0x9000,
+	       "mmio enabled\n");
+
+	ha->pci_error_state = QLA_PCI_MMIO_ENABLED;
 	if (IS_QLA82XX(ha))
 		return PCI_ERS_RESULT_RECOVERED;
 
@@ -7520,10 +7504,11 @@ qla2xxx_pci_mmio_enabled(struct pci_dev *pdev)
 		ql_log(ql_log_info, base_vha, 0x9003,
 		    "RISC paused -- mmio_enabled, Dumping firmware.\n");
 		qla2xxx_dump_fw(base_vha);
-
-		return PCI_ERS_RESULT_NEED_RESET;
-	} else
-		return PCI_ERS_RESULT_RECOVERED;
+	}
+	/* set PCI_ERS_RESULT_NEED_RESET to trigger call to qla2xxx_pci_slot_reset */
+	ql_dbg(ql_dbg_aer, base_vha, 0x600d,
+	       "mmio enabled returning.\n");
+	return PCI_ERS_RESULT_NEED_RESET;
 }
 
 static pci_ers_result_t
@@ -7535,9 +7520,10 @@ qla2xxx_pci_slot_reset(struct pci_dev *pdev)
 	int rc;
 	struct qla_qpair *qpair = NULL;
 
-	ql_dbg(ql_dbg_aer, base_vha, 0x9004,
-	    "Slot Reset.\n");
+	ql_log(ql_log_warn, base_vha, 0x9004,
+	       "Slot Reset.\n");
 
+	ha->pci_error_state = QLA_PCI_SLOT_RESET;
 	/* Workaround: qla2xxx driver which access hardware earlier
 	 * needs error state to be pci_channel_io_online.
 	 * Otherwise mailbox command timesout.
@@ -7571,16 +7557,24 @@ qla2xxx_pci_slot_reset(struct pci_dev *pdev)
 		qpair->online = 1;
 	mutex_unlock(&ha->mq_lock);
 
+	ha->flags.eeh_busy = 0;
 	base_vha->flags.online = 1;
 	set_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
-	if (ha->isp_ops->abort_isp(base_vha) == QLA_SUCCESS)
-		ret =  PCI_ERS_RESULT_RECOVERED;
+	ha->isp_ops->abort_isp(base_vha);
 	clear_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
 
+	if (qla2x00_isp_reg_stat(ha)) {
+		ha->flags.eeh_busy = 1;
+		qla_pci_error_cleanup(base_vha);
+		ql_log(ql_log_warn, base_vha, 0x9005,
+		       "Device unable to recover from PCI error.\n");
+	} else {
+		ret =  PCI_ERS_RESULT_RECOVERED;
+	}
 
 exit_slot_reset:
 	ql_dbg(ql_dbg_aer, base_vha, 0x900e,
-	    "slot_reset return %x.\n", ret);
+	    "Slot Reset returning %x.\n", ret);
 
 	return ret;
 }
@@ -7592,16 +7586,55 @@ qla2xxx_pci_resume(struct pci_dev *pdev)
 	struct qla_hw_data *ha = base_vha->hw;
 	int ret;
 
-	ql_dbg(ql_dbg_aer, base_vha, 0x900f,
-	    "pci_resume.\n");
+	ql_log(ql_log_warn, base_vha, 0x900f,
+	       "Pci Resume.\n");
 
-	ha->flags.eeh_busy = 0;
 
 	ret = qla2x00_wait_for_hba_online(base_vha);
 	if (ret != QLA_SUCCESS) {
 		ql_log(ql_log_fatal, base_vha, 0x9002,
 		    "The device failed to resume I/O from slot/link_reset.\n");
 	}
+	ha->pci_error_state = QLA_PCI_RESUME;
+	ql_dbg(ql_dbg_aer, base_vha, 0x600d,
+	       "Pci Resume returning.\n");
+}
+
+void qla_pci_set_eeh_busy(struct scsi_qla_host *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+	struct scsi_qla_host *base_vha = pci_get_drvdata(ha->pdev);
+	bool do_cleanup = false;
+	unsigned long flags;
+
+	if (ha->flags.eeh_busy)
+		return;
+
+	spin_lock_irqsave(&base_vha->work_lock, flags);
+	if (!ha->flags.eeh_busy) {
+		ha->flags.eeh_busy = 1;
+		do_cleanup = true;
+	}
+	spin_unlock_irqrestore(&base_vha->work_lock, flags);
+
+	if (do_cleanup)
+		qla_pci_error_cleanup(base_vha);
+}
+
+/*
+ * this routine will schedule a task to pause IO from interrupt context
+ * if caller sees a PCIE error event (register read = 0xf's)
+ */
+void qla_schedule_eeh_work(struct scsi_qla_host *vha)
+{
+	struct qla_hw_data *ha = vha->hw;
+	struct scsi_qla_host *base_vha = pci_get_drvdata(ha->pdev);
+
+	if (ha->flags.eeh_busy)
+		return;
+
+	set_bit(DO_EEH_RECOVERY, &base_vha->dpc_flags);
+	qla2xxx_wake_dpc(base_vha);
 }
 
 static void
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index ecb30c2738b8..fdb424501da5 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1044,10 +1044,6 @@ void qlt_free_session_done(struct work_struct *work)
 			(struct imm_ntfy_from_isp *)sess->iocb, SRB_NACK_LOGO);
 	}
 
-	spin_lock_irqsave(&vha->work_lock, flags);
-	sess->flags &= ~FCF_ASYNC_SENT;
-	spin_unlock_irqrestore(&vha->work_lock, flags);
-
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	if (sess->se_sess) {
 		sess->se_sess = NULL;
@@ -1057,7 +1053,6 @@ void qlt_free_session_done(struct work_struct *work)
 
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETED);
 	sess->fw_login_state = DSC_LS_PORT_UNAVAIL;
-	sess->deleted = QLA_SESS_DELETED;
 
 	if (sess->login_succ && !IS_SW_RESV_ADDR(sess->d_id)) {
 		vha->fcport_count--;
@@ -1109,10 +1104,15 @@ void qlt_free_session_done(struct work_struct *work)
 
 	sess->explicit_logout = 0;
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
-	sess->free_pending = 0;
 
 	qla2x00_dfs_remove_rport(vha, sess);
 
+	spin_lock_irqsave(&vha->work_lock, flags);
+	sess->flags &= ~FCF_ASYNC_SENT;
+	sess->deleted = QLA_SESS_DELETED;
+	sess->free_pending = 0;
+	spin_unlock_irqrestore(&vha->work_lock, flags);
+
 	ql_dbg(ql_dbg_disc, vha, 0xf001,
 	    "Unregistration of sess %p %8phC finished fcp_cnt %d\n",
 		sess, sess->port_name, vha->fcport_count);
@@ -1161,12 +1161,12 @@ void qlt_unreg_sess(struct fc_port *sess)
 	 * management from being sent.
 	 */
 	sess->flags |= FCF_ASYNC_SENT;
+	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	spin_unlock_irqrestore(&sess->vha->work_lock, flags);
 
 	if (sess->se_sess)
 		vha->hw->tgt.tgt_ops->clear_nacl_from_fcport_map(sess);
 
-	sess->deleted = QLA_SESS_DELETION_IN_PROGRESS;
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETE_PEND);
 	sess->last_rscn_gen = sess->rscn_gen;
 	sess->last_login_gen = sess->login_gen;
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8d82d2a83059..05ae9b115709 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -973,6 +973,11 @@ static int qla4xxx_set_chap_entry(struct Scsi_Host *shost, void *data, int len)
 	memset(&chap_rec, 0, sizeof(chap_rec));
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*param_info)) {
+			rc = -EINVAL;
+			goto exit_set_chap;
+		}
+
 		param_info = nla_data(attr);
 
 		switch (param_info->param) {
@@ -2755,6 +2760,11 @@ qla4xxx_iface_set_param(struct Scsi_Host *shost, void *data, uint32_t len)
 	}
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*iface_param)) {
+			rval = -EINVAL;
+			goto exit_init_fw_cb;
+		}
+
 		iface_param = nla_data(attr);
 
 		if (iface_param->param_type == ISCSI_NET_PARAM) {
@@ -8119,6 +8129,11 @@ qla4xxx_sysfs_ddb_set_param(struct iscsi_bus_flash_session *fnode_sess,
 
 	memset((void *)&chap_tbl, 0, sizeof(chap_tbl));
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*fnode_param)) {
+			rc = -EINVAL;
+			goto exit_set_param;
+		}
+
 		fnode_param = nla_data(attr);
 
 		switch (fnode_param->param) {
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 092bd6a3d64a..074cbd64aa25 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2991,14 +2991,15 @@ iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev
 }
 
 static int
-iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev, u32 rlen)
 {
 	char *data = (char*)ev + sizeof(*ev);
 	struct iscsi_cls_conn *conn;
 	struct iscsi_cls_session *session;
 	int err = 0, value = 0, state;
 
-	if (ev->u.set_param.len > PAGE_SIZE)
+	if (ev->u.set_param.len > rlen ||
+	    ev->u.set_param.len > PAGE_SIZE)
 		return -EINVAL;
 
 	session = iscsi_session_lookup(ev->u.set_param.sid);
@@ -3006,6 +3007,10 @@ iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 	if (!conn || !session)
 		return -EINVAL;
 
+	/* data will be regarded as NULL-ended string, do length check */
+	if (strlen(data) > ev->u.set_param.len)
+		return -EINVAL;
+
 	switch (ev->u.set_param.param) {
 	case ISCSI_PARAM_SESS_RECOVERY_TMO:
 		sscanf(data, "%d", &value);
@@ -3095,7 +3100,7 @@ static int iscsi_if_ep_disconnect(struct iscsi_transport *transport,
 
 static int
 iscsi_if_transport_ep(struct iscsi_transport *transport,
-		      struct iscsi_uevent *ev, int msg_type)
+		      struct iscsi_uevent *ev, int msg_type, u32 rlen)
 {
 	struct iscsi_endpoint *ep;
 	int rc = 0;
@@ -3103,7 +3108,10 @@ iscsi_if_transport_ep(struct iscsi_transport *transport,
 	switch (msg_type) {
 	case ISCSI_UEVENT_TRANSPORT_EP_CONNECT_THROUGH_HOST:
 	case ISCSI_UEVENT_TRANSPORT_EP_CONNECT:
-		rc = iscsi_if_ep_connect(transport, ev, msg_type);
+		if (rlen < sizeof(struct sockaddr))
+			rc = -EINVAL;
+		else
+			rc = iscsi_if_ep_connect(transport, ev, msg_type);
 		break;
 	case ISCSI_UEVENT_TRANSPORT_EP_POLL:
 		if (!transport->ep_poll)
@@ -3127,12 +3135,15 @@ iscsi_if_transport_ep(struct iscsi_transport *transport,
 
 static int
 iscsi_tgt_dscvr(struct iscsi_transport *transport,
-		struct iscsi_uevent *ev)
+		struct iscsi_uevent *ev, u32 rlen)
 {
 	struct Scsi_Host *shost;
 	struct sockaddr *dst_addr;
 	int err;
 
+	if (rlen < sizeof(*dst_addr))
+		return -EINVAL;
+
 	if (!transport->tgt_dscvr)
 		return -EINVAL;
 
@@ -3153,7 +3164,7 @@ iscsi_tgt_dscvr(struct iscsi_transport *transport,
 
 static int
 iscsi_set_host_param(struct iscsi_transport *transport,
-		     struct iscsi_uevent *ev)
+		     struct iscsi_uevent *ev, u32 rlen)
 {
 	char *data = (char*)ev + sizeof(*ev);
 	struct Scsi_Host *shost;
@@ -3162,7 +3173,8 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 	if (!transport->set_host_param)
 		return -ENOSYS;
 
-	if (ev->u.set_host_param.len > PAGE_SIZE)
+	if (ev->u.set_host_param.len > rlen ||
+	    ev->u.set_host_param.len > PAGE_SIZE)
 		return -EINVAL;
 
 	shost = scsi_host_lookup(ev->u.set_host_param.host_no);
@@ -3172,6 +3184,10 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 		return -ENODEV;
 	}
 
+	/* see similar check in iscsi_if_set_param() */
+	if (strlen(data) > ev->u.set_host_param.len)
+		return -EINVAL;
+
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
 	scsi_host_put(shost);
@@ -3179,12 +3195,15 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 }
 
 static int
-iscsi_set_path(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_set_path(struct iscsi_transport *transport, struct iscsi_uevent *ev, u32 rlen)
 {
 	struct Scsi_Host *shost;
 	struct iscsi_path *params;
 	int err;
 
+	if (rlen < sizeof(*params))
+		return -EINVAL;
+
 	if (!transport->set_path)
 		return -ENOSYS;
 
@@ -3244,12 +3263,15 @@ iscsi_set_iface_params(struct iscsi_transport *transport,
 }
 
 static int
-iscsi_send_ping(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_send_ping(struct iscsi_transport *transport, struct iscsi_uevent *ev, u32 rlen)
 {
 	struct Scsi_Host *shost;
 	struct sockaddr *dst_addr;
 	int err;
 
+	if (rlen < sizeof(*dst_addr))
+		return -EINVAL;
+
 	if (!transport->send_ping)
 		return -ENOSYS;
 
@@ -3747,13 +3769,12 @@ iscsi_get_host_stats(struct iscsi_transport *transport, struct nlmsghdr *nlh)
 }
 
 static int iscsi_if_transport_conn(struct iscsi_transport *transport,
-				   struct nlmsghdr *nlh)
+				   struct nlmsghdr *nlh, u32 pdu_len)
 {
 	struct iscsi_uevent *ev = nlmsg_data(nlh);
 	struct iscsi_cls_session *session;
 	struct iscsi_cls_conn *conn = NULL;
 	struct iscsi_endpoint *ep;
-	uint32_t pdu_len;
 	int err = 0;
 
 	switch (nlh->nlmsg_type) {
@@ -3833,8 +3854,6 @@ static int iscsi_if_transport_conn(struct iscsi_transport *transport,
 
 		break;
 	case ISCSI_UEVENT_SEND_PDU:
-		pdu_len = nlh->nlmsg_len - sizeof(*nlh) - sizeof(*ev);
-
 		if ((ev->u.send_pdu.hdr_size > pdu_len) ||
 		    (ev->u.send_pdu.data_size > (pdu_len - ev->u.send_pdu.hdr_size))) {
 			err = -EINVAL;
@@ -3864,6 +3883,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	struct iscsi_internal *priv;
 	struct iscsi_cls_session *session;
 	struct iscsi_endpoint *ep = NULL;
+	u32 rlen;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3883,6 +3903,13 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 
 	portid = NETLINK_CB(skb).portid;
 
+	/*
+	 * Even though the remaining payload may not be regarded as nlattr,
+	 * (like address or something else), calculate the remaining length
+	 * here to ease following length checks.
+	 */
+	rlen = nlmsg_attrlen(nlh, sizeof(*ev));
+
 	switch (nlh->nlmsg_type) {
 	case ISCSI_UEVENT_CREATE_SESSION:
 		err = iscsi_if_create_session(priv, ep, ev,
@@ -3940,7 +3967,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			err = -EINVAL;
 		break;
 	case ISCSI_UEVENT_SET_PARAM:
-		err = iscsi_set_param(transport, ev);
+		err = iscsi_if_set_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_CREATE_CONN:
 	case ISCSI_UEVENT_DESTROY_CONN:
@@ -3948,7 +3975,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	case ISCSI_UEVENT_START_CONN:
 	case ISCSI_UEVENT_BIND_CONN:
 	case ISCSI_UEVENT_SEND_PDU:
-		err = iscsi_if_transport_conn(transport, nlh);
+		err = iscsi_if_transport_conn(transport, nlh, rlen);
 		break;
 	case ISCSI_UEVENT_GET_STATS:
 		err = iscsi_if_get_stats(transport, nlh);
@@ -3957,23 +3984,22 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	case ISCSI_UEVENT_TRANSPORT_EP_POLL:
 	case ISCSI_UEVENT_TRANSPORT_EP_DISCONNECT:
 	case ISCSI_UEVENT_TRANSPORT_EP_CONNECT_THROUGH_HOST:
-		err = iscsi_if_transport_ep(transport, ev, nlh->nlmsg_type);
+		err = iscsi_if_transport_ep(transport, ev, nlh->nlmsg_type, rlen);
 		break;
 	case ISCSI_UEVENT_TGT_DSCVR:
-		err = iscsi_tgt_dscvr(transport, ev);
+		err = iscsi_tgt_dscvr(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_SET_HOST_PARAM:
-		err = iscsi_set_host_param(transport, ev);
+		err = iscsi_set_host_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_PATH_UPDATE:
-		err = iscsi_set_path(transport, ev);
+		err = iscsi_set_path(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_SET_IFACE_PARAMS:
-		err = iscsi_set_iface_params(transport, ev,
-					     nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_set_iface_params(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_PING:
-		err = iscsi_send_ping(transport, ev);
+		err = iscsi_send_ping(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_GET_CHAP:
 		err = iscsi_get_chap(transport, nlh);
@@ -3982,13 +4008,10 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		err = iscsi_delete_chap(transport, ev);
 		break;
 	case ISCSI_UEVENT_SET_FLASHNODE_PARAMS:
-		err = iscsi_set_flashnode_param(transport, ev,
-						nlmsg_attrlen(nlh,
-							      sizeof(*ev)));
+		err = iscsi_set_flashnode_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_NEW_FLASHNODE:
-		err = iscsi_new_flashnode(transport, ev,
-					  nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_new_flashnode(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_DEL_FLASHNODE:
 		err = iscsi_del_flashnode(transport, ev);
@@ -4003,8 +4026,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		err = iscsi_logout_flashnode_sid(transport, ev);
 		break;
 	case ISCSI_UEVENT_SET_CHAP:
-		err = iscsi_set_chap(transport, ev,
-				     nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_set_chap(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_GET_HOST_STATS:
 		err = iscsi_get_host_stats(transport, nlh);
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 45d854962344..37ad5f525647 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1537,6 +1537,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
+	/* storvsc devices don't support MAINTENANCE_IN SCSI cmd */
+	sdevice->no_report_opcodes = 1;
 	sdevice->no_write_same = 1;
 
 	/*
diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 1dfdd0b9ba24..8b80c8e94c77 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -76,8 +76,12 @@ struct ocmem {
 #define OCMEM_REG_GFX_MPU_START			0x00001004
 #define OCMEM_REG_GFX_MPU_END			0x00001008
 
-#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_PREP(0x0000000f, (val))
-#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_PREP(0x00003f00, (val))
+#define OCMEM_HW_VERSION_MAJOR(val)		FIELD_GET(GENMASK(31, 28), val)
+#define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
+#define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
+
+#define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_GET(0x0000000f, (val))
+#define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_GET(0x00003f00, (val))
 
 #define OCMEM_HW_PROFILE_LAST_REGN_HALFSIZE	0x00010000
 #define OCMEM_HW_PROFILE_INTERLEAVING		0x00020000
@@ -357,6 +361,12 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
+	dev_dbg(dev, "OCMEM hardware version: %lu.%lu.%lu\n",
+		OCMEM_HW_VERSION_MAJOR(reg),
+		OCMEM_HW_VERSION_MINOR(reg),
+		OCMEM_HW_VERSION_STEP(reg));
+
 	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
 	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
 	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);
diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
index 3aaab71d1b2c..dbc8b4c93190 100644
--- a/drivers/soc/qcom/qmi_encdec.c
+++ b/drivers/soc/qcom/qmi_encdec.c
@@ -534,8 +534,8 @@ static int qmi_decode_string_elem(struct qmi_elem_info *ei_array,
 		decoded_bytes += rc;
 	}
 
-	if (string_len > temp_ei->elem_len) {
-		pr_err("%s: String len %d > Max Len %d\n",
+	if (string_len >= temp_ei->elem_len) {
+		pr_err("%s: String len %d >= Max Len %d\n",
 		       __func__, string_len, temp_ei->elem_len);
 		return -ETOOSMALL;
 	} else if (string_len > tlv_len) {
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index cfb7de737937..62e50830b7f9 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -456,7 +456,11 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_master;
 	}
 
-	tsd->irq = platform_get_irq(pdev, 0);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto exit_free_master;
+	tsd->irq = ret;
+
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
 			dev_name(&pdev->dev), tsd);
 	if (ret < 0) {
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index f6a29a707862..86483f1c070b 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -101,7 +101,7 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 			.max_width = 4096,
 			.step_width = 16,
 			.min_height = 48,
-			.max_height = 2304,
+			.max_height = 2560,
 			.step_height = 16,
 		},
 		.ctrls = &rkvdec_h264_ctrls,
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index daa3180dfde3..5dfc9e3aa83d 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -323,6 +323,7 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	mutex_init(&padapter->mutex_start);
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 68d66c3ce2c8..67f89ea1c588 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -570,7 +570,6 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	if (rtl871x_load_fw(padapter))
 		goto deinit_drv_sw;
 	spin_lock_init(&padapter->lock_rx_ff0_filter);
-	mutex_init(&padapter->mutex_start);
 	return 0;
 
 deinit_drv_sw:
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 65a0c4e2bb29..7caba23365c1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -125,6 +125,7 @@ struct qcom_geni_serial_port {
 	u32 tx_fifo_width;
 	u32 rx_fifo_depth;
 	bool setup;
+	unsigned long clk_rate;
 	int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
 	unsigned int baud;
 	void *rx_fifo;
@@ -1022,6 +1023,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
+	port->clk_rate = clk_rate;
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
@@ -1305,10 +1307,13 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
 		geni_icc_enable(&port->se);
+		if (port->clk_rate)
+			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
 		geni_se_resources_on(&port->se);
 	} else if (new_state == UART_PM_STATE_OFF &&
 			old_state == UART_PM_STATE_ON) {
 		geni_se_resources_off(&port->se);
+		dev_pm_opp_set_rate(uport->dev, 0);
 		geni_icc_disable(&port->se);
 	}
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7ece8d1a23cb..c681ed589303 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1170,9 +1170,18 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 		state |= BIT(offset);
 	else
 		state &= ~BIT(offset);
-	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
+
+	/*
+	 * If we write IOSTATE first, and then IODIR, the output value is not
+	 * transferred to the corresponding I/O pin.
+	 * The datasheet states that each register bit will be transferred to
+	 * the corresponding I/O pin programmed as output when writing to
+	 * IOSTATE. Therefore, configure direction first with IODIR, and then
+	 * set value after with IOSTATE.
+	 */
 	sc16is7xx_port_update(port, SC16IS7XX_IODIR_REG, BIT(offset),
 			      BIT(offset));
+	sc16is7xx_port_write(port, SC16IS7XX_IOSTATE_REG, state);
 
 	return 0;
 }
@@ -1256,6 +1265,12 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
 		s->p[i].port.iobase	= i;
+		/*
+		 * Use all ones as membase to make sure uart_configure_port() in
+		 * serial_core.c does not abort for SPI/I2C devices where the
+		 * membase address is not applicable.
+		 */
+		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 62377c831894..fac4d90047b0 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -994,7 +994,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
 	tup->ier_shadow = 0;
 	tup->current_baud = 0;
 
-	clk_prepare_enable(tup->uart_clk);
+	ret = clk_prepare_enable(tup->uart_clk);
+	if (ret) {
+		dev_err(tup->uport.dev, "could not enable clk\n");
+		return ret;
+	}
 
 	/* Reset the UART controller to clear all previous status.*/
 	reset_control_assert(tup->rst);
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 9a7ae6384edf..a1952e4f1fcb 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -367,7 +367,7 @@ static void sprd_rx_free_buf(struct sprd_uart_port *sp)
 	if (sp->rx_dma.virt)
 		dma_free_coherent(sp->port.dev, SPRD_UART_RX_SIZE,
 				  sp->rx_dma.virt, sp->rx_dma.phys_addr);
-
+	sp->rx_dma.virt = NULL;
 }
 
 static int sprd_rx_dma_config(struct uart_port *port, u32 burst)
@@ -1133,7 +1133,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
 static int sprd_clk_init(struct uart_port *uport)
 {
 	struct clk *clk_uart, *clk_parent;
-	struct sprd_uart_port *u = sprd_port[uport->line];
+	struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
 
 	clk_uart = devm_clk_get(uport->dev, "uart");
 	if (IS_ERR(clk_uart)) {
@@ -1176,22 +1176,22 @@ static int sprd_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct uart_port *up;
+	struct sprd_uart_port *sport;
 	int irq;
 	int index;
 	int ret;
 
 	index = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
+	if (index < 0 || index >= UART_NR_MAX) {
 		dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
 		return -EINVAL;
 	}
 
-	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
-					GFP_KERNEL);
-	if (!sprd_port[index])
+	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
 		return -ENOMEM;
 
-	up = &sprd_port[index]->port;
+	up = &sport->port;
 	up->dev = &pdev->dev;
 	up->line = index;
 	up->type = PORT_SPRD;
@@ -1222,7 +1222,7 @@ static int sprd_probe(struct platform_device *pdev)
 	 * Allocate one dma buffer to prepare for receive transfer, in case
 	 * memory allocation failure at runtime.
 	 */
-	ret = sprd_rx_alloc_buf(sprd_port[index]);
+	ret = sprd_rx_alloc_buf(sport);
 	if (ret)
 		return ret;
 
@@ -1230,17 +1230,27 @@ static int sprd_probe(struct platform_device *pdev)
 		ret = uart_register_driver(&sprd_uart_driver);
 		if (ret < 0) {
 			pr_err("Failed to register SPRD-UART driver\n");
-			return ret;
+			goto free_rx_buf;
 		}
 	}
+
 	sprd_ports_num++;
+	sprd_port[index] = sport;
 
 	ret = uart_add_one_port(&sprd_uart_driver, up);
 	if (ret)
-		sprd_remove(pdev);
+		goto clean_port;
 
 	platform_set_drvdata(pdev, up);
 
+	return 0;
+
+clean_port:
+	sprd_port[index] = NULL;
+	if (--sprd_ports_num == 0)
+		uart_unregister_driver(&sprd_uart_driver);
+free_rx_buf:
+	sprd_rx_free_buf(sport);
 	return ret;
 }
 
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 4d47fe89864d..a54c3cff6c28 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -175,10 +175,12 @@ static struct imx_usbmisc_data *usbmisc_get_init_data(struct device *dev)
 	if (of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI)
 		data->ulpi = 1;
 
-	of_property_read_u32(np, "samsung,picophy-pre-emp-curr-control",
-			&data->emp_curr_control);
-	of_property_read_u32(np, "samsung,picophy-dc-vol-level-adjust",
-			&data->dc_vol_level_adjust);
+	if (of_property_read_u32(np, "samsung,picophy-pre-emp-curr-control",
+			&data->emp_curr_control))
+		data->emp_curr_control = -1;
+	if (of_property_read_u32(np, "samsung,picophy-dc-vol-level-adjust",
+			&data->dc_vol_level_adjust))
+		data->dc_vol_level_adjust = -1;
 
 	return data;
 }
diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 9b1d5c11dc34..12fc8c83081c 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -657,13 +657,15 @@ static int usbmisc_imx7d_init(struct imx_usbmisc_data *data)
 			usbmisc->base + MX7D_USBNC_USB_CTRL2);
 		/* PHY tuning for signal quality */
 		reg = readl(usbmisc->base + MX7D_USB_OTG_PHY_CFG1);
-		if (data->emp_curr_control && data->emp_curr_control <=
+		if (data->emp_curr_control >= 0 &&
+			data->emp_curr_control <=
 			(TXPREEMPAMPTUNE0_MASK >> TXPREEMPAMPTUNE0_BIT)) {
 			reg &= ~TXPREEMPAMPTUNE0_MASK;
 			reg |= (data->emp_curr_control << TXPREEMPAMPTUNE0_BIT);
 		}
 
-		if (data->dc_vol_level_adjust && data->dc_vol_level_adjust <=
+		if (data->dc_vol_level_adjust >= 0 &&
+			data->dc_vol_level_adjust <=
 			(TXVREFTUNE0_MASK >> TXVREFTUNE0_BIT)) {
 			reg &= ~TXVREFTUNE0_MASK;
 			reg |= (data->dc_vol_level_adjust << TXVREFTUNE0_BIT);
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index ac347f9d5ef0..63bb04d262d8 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -982,6 +982,7 @@ static int register_root_hub(struct usb_hcd *hcd)
 {
 	struct device *parent_dev = hcd->self.controller;
 	struct usb_device *usb_dev = hcd->self.root_hub;
+	struct usb_device_descriptor *descr;
 	const int devnum = 1;
 	int retval;
 
@@ -993,13 +994,16 @@ static int register_root_hub(struct usb_hcd *hcd)
 	mutex_lock(&usb_bus_idr_lock);
 
 	usb_dev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-	retval = usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE);
-	if (retval != sizeof usb_dev->descriptor) {
+	descr = usb_get_device_descriptor(usb_dev);
+	if (IS_ERR(descr)) {
+		retval = PTR_ERR(descr);
 		mutex_unlock(&usb_bus_idr_lock);
 		dev_dbg (parent_dev, "can't read %s device descriptor %d\n",
 				dev_name(&usb_dev->dev), retval);
-		return (retval < 0) ? retval : -EMSGSIZE;
+		return retval;
 	}
+	usb_dev->descriptor = *descr;
+	kfree(descr);
 
 	if (le16_to_cpu(usb_dev->descriptor.bcdUSB) >= 0x0201) {
 		retval = usb_get_bos_descriptor(usb_dev);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 7af2def631a2..580604596499 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2646,12 +2646,17 @@ int usb_authorize_device(struct usb_device *usb_dev)
 	}
 
 	if (usb_dev->wusb) {
-		result = usb_get_device_descriptor(usb_dev, sizeof(usb_dev->descriptor));
-		if (result < 0) {
+		struct usb_device_descriptor *descr;
+
+		descr = usb_get_device_descriptor(usb_dev);
+		if (IS_ERR(descr)) {
+			result = PTR_ERR(descr);
 			dev_err(&usb_dev->dev, "can't re-read device descriptor for "
 				"authorization: %d\n", result);
 			goto error_device_descriptor;
 		}
+		usb_dev->descriptor = *descr;
+		kfree(descr);
 	}
 
 	usb_dev->authorized = 1;
@@ -4594,6 +4599,67 @@ static int hub_enable_device(struct usb_device *udev)
 	return hcd->driver->enable_device(hcd, udev);
 }
 
+/*
+ * Get the bMaxPacketSize0 value during initialization by reading the
+ * device's device descriptor.  Since we don't already know this value,
+ * the transfer is unsafe and it ignores I/O errors, only testing for
+ * reasonable received values.
+ *
+ * For "old scheme" initialization, size will be 8 so we read just the
+ * start of the device descriptor, which should work okay regardless of
+ * the actual bMaxPacketSize0 value.  For "new scheme" initialization,
+ * size will be 64 (and buf will point to a sufficiently large buffer),
+ * which might not be kosher according to the USB spec but it's what
+ * Windows does and what many devices expect.
+ *
+ * Returns: bMaxPacketSize0 or a negative error code.
+ */
+static int get_bMaxPacketSize0(struct usb_device *udev,
+		struct usb_device_descriptor *buf, int size, bool first_time)
+{
+	int i, rc;
+
+	/*
+	 * Retry on all errors; some devices are flakey.
+	 * 255 is for WUSB devices, we actually need to use
+	 * 512 (WUSB1.0[4.8.1]).
+	 */
+	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
+		/* Start with invalid values in case the transfer fails */
+		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
+		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+				USB_DT_DEVICE << 8, 0,
+				buf, size,
+				initial_descriptor_timeout);
+		switch (buf->bMaxPacketSize0) {
+		case 8: case 16: case 32: case 64: case 9:
+			if (buf->bDescriptorType == USB_DT_DEVICE) {
+				rc = buf->bMaxPacketSize0;
+				break;
+			}
+			fallthrough;
+		default:
+			if (rc >= 0)
+				rc = -EPROTO;
+			break;
+		}
+
+		/*
+		 * Some devices time out if they are powered on
+		 * when already connected. They need a second
+		 * reset, so return early. But only on the first
+		 * attempt, lest we get into a time-out/reset loop.
+		 */
+		if (rc > 0 || (rc == -ETIMEDOUT && first_time &&
+				udev->speed > USB_SPEED_FULL))
+			break;
+	}
+	return rc;
+}
+
+#define GET_DESCRIPTOR_BUFSIZE	64
+
 /* Reset device, (re)assign address, get device descriptor.
  * Device connection must be stable, no more debouncing needed.
  * Returns device in USB_STATE_ADDRESS, except on error.
@@ -4603,10 +4669,17 @@ static int hub_enable_device(struct usb_device *udev)
  * the port lock.  For a newly detected device that is not accessible
  * through any global pointers, it's not necessary to lock the device,
  * but it is still necessary to lock the port.
+ *
+ * For a newly detected device, @dev_descr must be NULL.  The device
+ * descriptor retrieved from the device will then be stored in
+ * @udev->descriptor.  For an already existing device, @dev_descr
+ * must be non-NULL.  The device descriptor will be stored there,
+ * not in @udev->descriptor, because descriptors for registered
+ * devices are meant to be immutable.
  */
 static int
 hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
-		int retry_counter)
+		int retry_counter, struct usb_device_descriptor *dev_descr)
 {
 	struct usb_device	*hdev = hub->hdev;
 	struct usb_hcd		*hcd = bus_to_hcd(hdev->bus);
@@ -4618,6 +4691,13 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	int			devnum = udev->devnum;
 	const char		*driver_name;
 	bool			do_new_scheme;
+	const bool		initial = !dev_descr;
+	int			maxp0;
+	struct usb_device_descriptor	*buf, *descr;
+
+	buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
+	if (!buf)
+		return -ENOMEM;
 
 	/* root hub ports have a slightly longer reset period
 	 * (from USB 2.0 spec, section 7.1.7.5)
@@ -4650,32 +4730,34 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	}
 	oldspeed = udev->speed;
 
-	/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
-	 * it's fixed size except for full speed devices.
-	 * For Wireless USB devices, ep0 max packet is always 512 (tho
-	 * reported as 0xff in the device descriptor). WUSB1.0[4.8.1].
-	 */
-	switch (udev->speed) {
-	case USB_SPEED_SUPER_PLUS:
-	case USB_SPEED_SUPER:
-	case USB_SPEED_WIRELESS:	/* fixed at 512 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
-		break;
-	case USB_SPEED_HIGH:		/* fixed at 64 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-		break;
-	case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
-		/* to determine the ep0 maxpacket size, try to read
-		 * the device descriptor to get bMaxPacketSize0 and
-		 * then correct our initial guess.
+	if (initial) {
+		/* USB 2.0 section 5.5.3 talks about ep0 maxpacket ...
+		 * it's fixed size except for full speed devices.
+		 * For Wireless USB devices, ep0 max packet is always 512 (tho
+		 * reported as 0xff in the device descriptor). WUSB1.0[4.8.1].
 		 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-		break;
-	case USB_SPEED_LOW:		/* fixed at 8 */
-		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
-		break;
-	default:
-		goto fail;
+		switch (udev->speed) {
+		case USB_SPEED_SUPER_PLUS:
+		case USB_SPEED_SUPER:
+		case USB_SPEED_WIRELESS:	/* fixed at 512 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(512);
+			break;
+		case USB_SPEED_HIGH:		/* fixed at 64 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
+			break;
+		case USB_SPEED_FULL:		/* 8, 16, 32, or 64 */
+			/* to determine the ep0 maxpacket size, try to read
+			 * the device descriptor to get bMaxPacketSize0 and
+			 * then correct our initial guess.
+			 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
+			break;
+		case USB_SPEED_LOW:		/* fixed at 8 */
+			udev->ep0.desc.wMaxPacketSize = cpu_to_le16(8);
+			break;
+		default:
+			goto fail;
+		}
 	}
 
 	if (udev->speed == USB_SPEED_WIRELESS)
@@ -4698,22 +4780,24 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	if (udev->speed < USB_SPEED_SUPER)
 		dev_info(&udev->dev,
 				"%s %s USB device number %d using %s\n",
-				(udev->config) ? "reset" : "new", speed,
+				(initial ? "new" : "reset"), speed,
 				devnum, driver_name);
 
-	/* Set up TT records, if needed  */
-	if (hdev->tt) {
-		udev->tt = hdev->tt;
-		udev->ttport = hdev->ttport;
-	} else if (udev->speed != USB_SPEED_HIGH
-			&& hdev->speed == USB_SPEED_HIGH) {
-		if (!hub->tt.hub) {
-			dev_err(&udev->dev, "parent hub has no TT\n");
-			retval = -EINVAL;
-			goto fail;
+	if (initial) {
+		/* Set up TT records, if needed  */
+		if (hdev->tt) {
+			udev->tt = hdev->tt;
+			udev->ttport = hdev->ttport;
+		} else if (udev->speed != USB_SPEED_HIGH
+				&& hdev->speed == USB_SPEED_HIGH) {
+			if (!hub->tt.hub) {
+				dev_err(&udev->dev, "parent hub has no TT\n");
+				retval = -EINVAL;
+				goto fail;
+			}
+			udev->tt = &hub->tt;
+			udev->ttport = port1;
 		}
-		udev->tt = &hub->tt;
-		udev->ttport = port1;
 	}
 
 	/* Why interleave GET_DESCRIPTOR and SET_ADDRESS this way?
@@ -4732,9 +4816,6 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 
 	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
 		if (do_new_scheme) {
-			struct usb_device_descriptor *buf;
-			int r = 0;
-
 			retval = hub_enable_device(udev);
 			if (retval < 0) {
 				dev_err(&udev->dev,
@@ -4743,52 +4824,14 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 				goto fail;
 			}
 
-#define GET_DESCRIPTOR_BUFSIZE	64
-			buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
-			if (!buf) {
-				retval = -ENOMEM;
-				continue;
-			}
-
-			/* Retry on all errors; some devices are flakey.
-			 * 255 is for WUSB devices, we actually need to use
-			 * 512 (WUSB1.0[4.8.1]).
-			 */
-			for (operations = 0; operations < GET_MAXPACKET0_TRIES;
-					++operations) {
-				buf->bMaxPacketSize0 = 0;
-				r = usb_control_msg(udev, usb_rcvaddr0pipe(),
-					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-					USB_DT_DEVICE << 8, 0,
-					buf, GET_DESCRIPTOR_BUFSIZE,
-					initial_descriptor_timeout);
-				switch (buf->bMaxPacketSize0) {
-				case 8: case 16: case 32: case 64: case 255:
-					if (buf->bDescriptorType ==
-							USB_DT_DEVICE) {
-						r = 0;
-						break;
-					}
-					fallthrough;
-				default:
-					if (r == 0)
-						r = -EPROTO;
-					break;
-				}
-				/*
-				 * Some devices time out if they are powered on
-				 * when already connected. They need a second
-				 * reset. But only on the first attempt,
-				 * lest we get into a time out/reset loop
-				 */
-				if (r == 0 || (r == -ETIMEDOUT &&
-						retries == 0 &&
-						udev->speed > USB_SPEED_FULL))
-					break;
+			maxp0 = get_bMaxPacketSize0(udev, buf,
+					GET_DESCRIPTOR_BUFSIZE, retries == 0);
+			if (maxp0 > 0 && !initial &&
+					maxp0 != udev->descriptor.bMaxPacketSize0) {
+				dev_err(&udev->dev, "device reset changed ep0 maxpacket size!\n");
+				retval = -ENODEV;
+				goto fail;
 			}
-			udev->descriptor.bMaxPacketSize0 =
-					buf->bMaxPacketSize0;
-			kfree(buf);
 
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
@@ -4799,14 +4842,13 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 				retval = -ENODEV;
 				goto fail;
 			}
-			if (r) {
-				if (r != -ENODEV)
+			if (maxp0 < 0) {
+				if (maxp0 != -ENODEV)
 					dev_err(&udev->dev, "device descriptor read/64, error %d\n",
-							r);
-				retval = -EMSGSIZE;
+							maxp0);
+				retval = maxp0;
 				continue;
 			}
-#undef GET_DESCRIPTOR_BUFSIZE
 		}
 
 		/*
@@ -4848,18 +4890,22 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 				break;
 		}
 
-		retval = usb_get_device_descriptor(udev, 8);
-		if (retval < 8) {
+		/* !do_new_scheme || wusb */
+		maxp0 = get_bMaxPacketSize0(udev, buf, 8, retries == 0);
+		if (maxp0 < 0) {
+			retval = maxp0;
 			if (retval != -ENODEV)
 				dev_err(&udev->dev,
 					"device descriptor read/8, error %d\n",
 					retval);
-			if (retval >= 0)
-				retval = -EMSGSIZE;
 		} else {
 			u32 delay;
 
-			retval = 0;
+			if (!initial && maxp0 != udev->descriptor.bMaxPacketSize0) {
+				dev_err(&udev->dev, "device reset changed ep0 maxpacket size!\n");
+				retval = -ENODEV;
+				goto fail;
+			}
 
 			delay = udev->parent->hub_delay;
 			udev->hub_delay = min_t(u32, delay,
@@ -4878,48 +4924,61 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		goto fail;
 
 	/*
-	 * Some superspeed devices have finished the link training process
-	 * and attached to a superspeed hub port, but the device descriptor
-	 * got from those devices show they aren't superspeed devices. Warm
-	 * reset the port attached by the devices can fix them.
+	 * Check the ep0 maxpacket guess and correct it if necessary.
+	 * maxp0 is the value stored in the device descriptor;
+	 * i is the value it encodes (logarithmic for SuperSpeed or greater).
 	 */
-	if ((udev->speed >= USB_SPEED_SUPER) &&
-			(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
-		dev_err(&udev->dev, "got a wrong device descriptor, "
-				"warm reset device\n");
-		hub_port_reset(hub, port1, udev,
-				HUB_BH_RESET_TIME, true);
-		retval = -EINVAL;
-		goto fail;
-	}
-
-	if (udev->descriptor.bMaxPacketSize0 == 0xff ||
-			udev->speed >= USB_SPEED_SUPER)
-		i = 512;
-	else
-		i = udev->descriptor.bMaxPacketSize0;
-	if (usb_endpoint_maxp(&udev->ep0.desc) != i) {
-		if (udev->speed == USB_SPEED_LOW ||
-				!(i == 8 || i == 16 || i == 32 || i == 64)) {
-			dev_err(&udev->dev, "Invalid ep0 maxpacket: %d\n", i);
-			retval = -EMSGSIZE;
-			goto fail;
-		}
+	i = maxp0;
+	if (udev->speed >= USB_SPEED_SUPER) {
+		if (maxp0 <= 16)
+			i = 1 << maxp0;
+		else
+			i = 0;		/* Invalid */
+	}
+	if (usb_endpoint_maxp(&udev->ep0.desc) == i) {
+		;	/* Initial ep0 maxpacket guess is right */
+	} else if ((udev->speed == USB_SPEED_FULL ||
+				udev->speed == USB_SPEED_HIGH) &&
+			(i == 8 || i == 16 || i == 32 || i == 64)) {
+		/* Initial guess is wrong; use the descriptor's value */
 		if (udev->speed == USB_SPEED_FULL)
 			dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
 		else
 			dev_warn(&udev->dev, "Using ep0 maxpacket: %d\n", i);
 		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(i);
 		usb_ep0_reinit(udev);
+	} else {
+		/* Initial guess is wrong and descriptor's value is invalid */
+		dev_err(&udev->dev, "Invalid ep0 maxpacket: %d\n", maxp0);
+		retval = -EMSGSIZE;
+		goto fail;
 	}
 
-	retval = usb_get_device_descriptor(udev, USB_DT_DEVICE_SIZE);
-	if (retval < (signed)sizeof(udev->descriptor)) {
+	descr = usb_get_device_descriptor(udev);
+	if (IS_ERR(descr)) {
+		retval = PTR_ERR(descr);
 		if (retval != -ENODEV)
 			dev_err(&udev->dev, "device descriptor read/all, error %d\n",
 					retval);
-		if (retval >= 0)
-			retval = -ENOMSG;
+		goto fail;
+	}
+	if (initial)
+		udev->descriptor = *descr;
+	else
+		*dev_descr = *descr;
+	kfree(descr);
+
+	/*
+	 * Some superspeed devices have finished the link training process
+	 * and attached to a superspeed hub port, but the device descriptor
+	 * got from those devices show they aren't superspeed devices. Warm
+	 * reset the port attached by the devices can fix them.
+	 */
+	if ((udev->speed >= USB_SPEED_SUPER) &&
+			(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
+		dev_err(&udev->dev, "got a wrong device descriptor, warm reset device\n");
+		hub_port_reset(hub, port1, udev, HUB_BH_RESET_TIME, true);
+		retval = -EINVAL;
 		goto fail;
 	}
 
@@ -4943,6 +5002,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		hub_port_disable(hub, port1, 0);
 		update_devnum(udev, devnum);	/* for disconnect processing */
 	}
+	kfree(buf);
 	return retval;
 }
 
@@ -5023,7 +5083,7 @@ hub_power_remaining(struct usb_hub *hub)
 
 
 static int descriptors_changed(struct usb_device *udev,
-		struct usb_device_descriptor *old_device_descriptor,
+		struct usb_device_descriptor *new_device_descriptor,
 		struct usb_host_bos *old_bos)
 {
 	int		changed = 0;
@@ -5034,8 +5094,8 @@ static int descriptors_changed(struct usb_device *udev,
 	int		length;
 	char		*buf;
 
-	if (memcmp(&udev->descriptor, old_device_descriptor,
-			sizeof(*old_device_descriptor)) != 0)
+	if (memcmp(&udev->descriptor, new_device_descriptor,
+			sizeof(*new_device_descriptor)) != 0)
 		return 1;
 
 	if ((old_bos && !udev->bos) || (!old_bos && udev->bos))
@@ -5208,7 +5268,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		}
 
 		/* reset (non-USB 3.0 devices) and get descriptor */
-		status = hub_port_init(hub, udev, port1, i);
+		status = hub_port_init(hub, udev, port1, i, NULL);
 		if (status < 0)
 			goto loop;
 
@@ -5355,9 +5415,8 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 {
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_device *udev = port_dev->child;
-	struct usb_device_descriptor descriptor;
+	struct usb_device_descriptor *descr;
 	int status = -ENODEV;
-	int retval;
 
 	dev_dbg(&port_dev->dev, "status %04x, change %04x, %s\n", portstatus,
 			portchange, portspeed(hub, portstatus));
@@ -5384,23 +5443,20 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 			 * changed device descriptors before resuscitating the
 			 * device.
 			 */
-			descriptor = udev->descriptor;
-			retval = usb_get_device_descriptor(udev,
-					sizeof(udev->descriptor));
-			if (retval < 0) {
+			descr = usb_get_device_descriptor(udev);
+			if (IS_ERR(descr)) {
 				dev_dbg(&udev->dev,
-						"can't read device descriptor %d\n",
-						retval);
+						"can't read device descriptor %ld\n",
+						PTR_ERR(descr));
 			} else {
-				if (descriptors_changed(udev, &descriptor,
+				if (descriptors_changed(udev, descr,
 						udev->bos)) {
 					dev_dbg(&udev->dev,
 							"device descriptor has changed\n");
-					/* for disconnect() calls */
-					udev->descriptor = descriptor;
 				} else {
 					status = 0; /* Nothing to do */
 				}
+				kfree(descr);
 			}
 #ifdef CONFIG_PM
 		} else if (udev->state == USB_STATE_SUSPENDED &&
@@ -5828,7 +5884,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	struct usb_device		*parent_hdev = udev->parent;
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
-	struct usb_device_descriptor	descriptor = udev->descriptor;
+	struct usb_device_descriptor	descriptor;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -5870,7 +5926,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
 		usb_ep0_reinit(udev);
-		ret = hub_port_init(parent_hub, udev, port1, i);
+		ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
 	}
@@ -5882,7 +5938,6 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	/* Device might have changed firmware (DFU or similar) */
 	if (descriptors_changed(udev, &descriptor, bos)) {
 		dev_info(&udev->dev, "device firmware changed\n");
-		udev->descriptor = descriptor;	/* for disconnect() calls */
 		goto re_enumerate;
 	}
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index dba2baca486e..d64aaff223e7 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1039,39 +1039,34 @@ char *usb_cache_string(struct usb_device *udev, int index)
 }
 
 /*
- * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
- * @dev: the device whose device descriptor is being updated
- * @size: how much of the descriptor to read
+ * usb_get_device_descriptor - read the device descriptor
+ * @udev: the device whose device descriptor should be read
  * Context: !in_interrupt ()
  *
- * Updates the copy of the device descriptor stored in the device structure,
- * which dedicates space for this purpose.
- *
  * Not exported, only for use by the core.  If drivers really want to read
  * the device descriptor directly, they can call usb_get_descriptor() with
  * type = USB_DT_DEVICE and index = 0.
  *
- * This call is synchronous, and may not be used in an interrupt context.
- *
- * Return: The number of bytes received on success, or else the status code
- * returned by the underlying usb_control_msg() call.
+ * Returns: a pointer to a dynamically allocated usb_device_descriptor
+ * structure (which the caller must deallocate), or an ERR_PTR value.
  */
-int usb_get_device_descriptor(struct usb_device *dev, unsigned int size)
+struct usb_device_descriptor *usb_get_device_descriptor(struct usb_device *udev)
 {
 	struct usb_device_descriptor *desc;
 	int ret;
 
-	if (size > sizeof(*desc))
-		return -EINVAL;
 	desc = kmalloc(sizeof(*desc), GFP_NOIO);
 	if (!desc)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
+	ret = usb_get_descriptor(udev, USB_DT_DEVICE, 0, desc, sizeof(*desc));
+	if (ret == sizeof(*desc))
+		return desc;
 
-	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
 	if (ret >= 0)
-		memcpy(&dev->descriptor, desc, size);
+		ret = -EMSGSIZE;
 	kfree(desc);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 82538daac8b8..3bb2e1db42b5 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -42,8 +42,8 @@ extern bool usb_endpoint_is_ignored(struct usb_device *udev,
 		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
 
-extern int usb_get_device_descriptor(struct usb_device *dev,
-		unsigned int size);
+extern struct usb_device_descriptor *usb_get_device_descriptor(
+		struct usb_device *udev);
 extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 69ec06efd7f2..2d3ca6e8eb65 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -931,6 +931,12 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 			return ret;
 	}
 
+	if (priv->drvdata->usb_post_init) {
+		ret = priv->drvdata->usb_post_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 950c9435beec..553547f12fd2 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -951,7 +951,7 @@ static void invalidate_sub(struct fsg_lun *curlun)
 {
 	struct file	*filp = curlun->filp;
 	struct inode	*inode = file_inode(filp);
-	unsigned long	rc;
+	unsigned long __maybe_unused	rc;
 
 	rc = invalidate_mapping_pages(inode->i_mapping, 0, -1);
 	VLDBG(curlun, "invalidate_mapping_pages -> %ld\n", rc);
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 67b39dc62b37..70e23334b27f 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -388,14 +388,8 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 
 static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 {
-	void __iomem *base = mxs_phy->phy.io_priv;
-	u32 phyctrl = readl(base + HW_USBPHY_CTRL);
-
-	if (IS_ENABLED(CONFIG_USB_OTG) &&
-			!(phyctrl & BM_USBPHY_CTRL_OTG_ID_VALUE))
-		return true;
-
-	return false;
+	return IS_ENABLED(CONFIG_USB_OTG) &&
+		mxs_phy->phy.last_event == USB_EVENT_ID;
 }
 
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0b3422c06ab9..83567e6e32e0 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -259,6 +259,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM05G			0x030a
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM05G_CS		0x030c
+#define QUECTEL_PRODUCT_EM05GV2			0x030e
 #define QUECTEL_PRODUCT_EM05CN_SG		0x0310
 #define QUECTEL_PRODUCT_EM05G_SG		0x0311
 #define QUECTEL_PRODUCT_EM05CN			0x0312
@@ -1190,6 +1191,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_GR, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05GV2, 0xff),
+	  .driver_info = RSVD(4) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_CS, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_RS, 0xff),
@@ -2232,6 +2235,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(1) | RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0db, 0xff),			/* Foxconn T99W265 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0ee, 0xff),			/* Foxconn T99W368 MBIM */
+	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
+	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index f4e7f4d78b56..7994b46592b9 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -152,12 +152,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
  *
  * Notifies the partner of @adev about Attention command.
  */
-void typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
+int typec_altmode_attention(struct typec_altmode *adev, u32 vdo)
 {
-	struct typec_altmode *pdev = &to_altmode(adev)->partner->adev;
+	struct altmode *partner = to_altmode(adev)->partner;
+	struct typec_altmode *pdev;
+
+	if (!partner)
+		return -ENODEV;
+
+	pdev = &partner->adev;
 
 	if (pdev->ops && pdev->ops->attention)
 		pdev->ops->attention(pdev, vdo);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(typec_altmode_attention);
 
diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 069affa5cb1e..e34e46df8024 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -475,6 +475,10 @@ static int tcpci_init(struct tcpc_dev *tcpc)
 	if (time_after(jiffies, timeout))
 		return -ETIMEDOUT;
 
+	ret = tcpci_write16(tcpci, TCPC_FAULT_STATUS, TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT);
+	if (ret < 0)
+		return ret;
+
 	/* Handle vendor init */
 	if (tcpci->data->init) {
 		ret = tcpci->data->init(tcpci, tcpci->data);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 5ef07a56d67a..95ce89139c6e 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -84,6 +84,7 @@
 #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
 
 #define TCPC_FAULT_STATUS		0x1f
+#define TCPC_FAULT_STATUS_ALL_REG_RST_TO_DEFAULT BIT(7)
 
 #define TCPC_ALERT_EXTENDED		0x21
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index cf0e6a80815a..ac3953a0fa29 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1395,7 +1395,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			if (typec_altmode_attention(adev, p[1]))
+				tcpm_log(port, "typec_altmode_attention no port partner altmode");
 			break;
 		}
 	}
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ec1428dbdf9d..9b01f88ae476 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2659,7 +2659,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
 					   struct vfio_info_cap *caps)
 {
-	struct vfio_iommu_type1_info_cap_migration cap_mig;
+	struct vfio_iommu_type1_info_cap_migration cap_mig = {};
 
 	cap_mig.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION;
 	cap_mig.header.version = 1;
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 515184fbe33a..5c67ef8bd60c 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -104,7 +104,7 @@ static int bd6107_backlight_check_fb(struct backlight_device *backlight,
 {
 	struct bd6107 *bd = bl_get_data(backlight);
 
-	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->dev;
+	return bd->pdata->fbdev == NULL || bd->pdata->fbdev == info->device;
 }
 
 static const struct backlight_ops bd6107_backlight_ops = {
diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 6f78d928f054..30ec5b684533 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -35,7 +35,7 @@ static int gpio_backlight_check_fb(struct backlight_device *bl,
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
 
-	return gbl->fbdev == NULL || gbl->fbdev == info->dev;
+	return gbl->fbdev == NULL || gbl->fbdev == info->device;
 }
 
 static const struct backlight_ops gpio_backlight_ops = {
@@ -87,8 +87,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		/* Not booted with device tree or no phandle link to the node */
 		bl->props.power = def_value ? FB_BLANK_UNBLANK
 					    : FB_BLANK_POWERDOWN;
-	else if (gpiod_get_direction(gbl->gpiod) == 0 &&
-		 gpiod_get_value_cansleep(gbl->gpiod) == 0)
+	else if (gpiod_get_value_cansleep(gbl->gpiod) == 0)
 		bl->props.power = FB_BLANK_POWERDOWN;
 	else
 		bl->props.power = FB_BLANK_UNBLANK;
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index 1842ae9a55f8..720ada475ce5 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -67,7 +67,7 @@ static int lv5207lp_backlight_check_fb(struct backlight_device *backlight,
 {
 	struct lv5207lp *lv = bl_get_data(backlight);
 
-	return lv->pdata->fbdev == NULL || lv->pdata->fbdev == info->dev;
+	return lv->pdata->fbdev == NULL || lv->pdata->fbdev == info->device;
 }
 
 static const struct backlight_ops lv5207lp_backlight_ops = {
diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index ba33b4dce0df..04aac2ad5382 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -474,7 +474,6 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, info);
 	fbi = info->par;
 	fbi->mach_info = mach_info;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3cc2a4ee7152..cf0e8e1893ee 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1190,7 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		}
 	}
 
-	if (i < head)
+	if (i <= head)
 		vq->packed.avail_wrap_counter ^= 1;
 
 	/* We're using some buffers from the free list. */
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 9b2173f765c8..fb7fae750181 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -203,3 +203,4 @@ module_platform_driver(mid_wdt_driver);
 MODULE_AUTHOR("David Cohen <david.a.cohen@linux.intel.com>");
 MODULE_DESCRIPTION("Watchdog Driver for Intel MID platform");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:intel_mid_wdt");
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 608b939a4d28..1bc6909d4de9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2496,11 +2496,10 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
-		   BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
-			fs_info->super_copy->fsid, fs_info->fs_devices->fsid);
+			  sb->fsid, fs_info->fs_devices->fsid);
 		ret = -EINVAL;
 	}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index abd67f984fbc..d23047b23005 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -301,10 +301,11 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_unlock(&fs_info->trans_lock);
 
 	/*
-	 * If we are ATTACH, we just want to catch the current transaction,
-	 * and commit it. If there is no transaction, just return ENOENT.
+	 * If we are ATTACH or TRANS_JOIN_NOSTART, we just want to catch the
+	 * current transaction, and commit it. If there is no transaction, just
+	 * return ENOENT.
 	 */
-	if (type == TRANS_ATTACH)
+	if (type == TRANS_ATTACH || type == TRANS_JOIN_NOSTART)
 		return -ENOENT;
 
 	/*
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 12388ed4faa5..0b7e9ab517d5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -479,6 +479,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
@@ -491,6 +492,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 			break;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	if (!found) {
 		/*
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 28735e8c5e20..5f2e2fa2ba09 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -466,7 +466,8 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		}
 	} else {
 		list_for_each_entry(iter, &recv_list, list) {
-			if (!iter->info.wait) {
+			if (!iter->info.wait &&
+			    iter->info.fsid == info.fsid) {
 				op = iter;
 				break;
 			}
@@ -478,8 +479,7 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		if (info.wait)
 			WARN_ON(op->info.optype != DLM_PLOCK_OP_LOCK);
 		else
-			WARN_ON(op->info.fsid != info.fsid ||
-				op->info.number != info.number ||
+			WARN_ON(op->info.number != info.number ||
 				op->info.owner != info.owner ||
 				op->info.optype != info.optype);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 9cff92738259..da133950d514 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -632,6 +632,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
 	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 		zero_user_segment(page, cur, end);
+		++spiltted;
+		tight = false;
 		goto next_part;
 	}
 
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 4a14295cffe0..3673eb8de035 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -187,11 +187,14 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	return events;
 }
 
-static void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
-	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
+	lockdep_assert_held(&ctx->wqh.lock);
+
+	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
+EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
 
 /**
  * eventfd_ctx_remove_wait_queue - Read the current counter and removes wait queue.
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 4efe71efe127..bdbf130416c7 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -903,11 +903,11 @@ unsigned long ext4_bg_num_gdb(struct super_block *sb, ext4_group_t group)
 }
 
 /*
- * This function returns the number of file system metadata clusters at
+ * This function returns the number of file system metadata blocks at
  * the beginning of a block group, including the reserved gdt blocks.
  */
-static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
-				     ext4_group_t block_group)
+unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
+				       ext4_group_t block_group)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	unsigned num;
@@ -925,8 +925,15 @@ static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
 	} else { /* For META_BG_BLOCK_GROUPS */
 		num += ext4_bg_num_gdb(sb, block_group);
 	}
-	return EXT4_NUM_B2C(sbi, num);
+	return num;
 }
+
+static unsigned int ext4_num_base_meta_clusters(struct super_block *sb,
+						ext4_group_t block_group)
+{
+	return EXT4_NUM_B2C(EXT4_SB(sb), ext4_num_base_meta_blocks(sb, block_group));
+}
+
 /**
  *	ext4_inode_to_goal_block - return a hint for block allocation
  *	@inode: inode for block allocation
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index eed5b855dd94..295e89d93295 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -217,7 +217,6 @@ int ext4_setup_system_zone(struct super_block *sb)
 	struct ext4_system_blocks *system_blks;
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
-	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -225,12 +224,13 @@ int ext4_setup_system_zone(struct super_block *sb)
 		return -ENOMEM;
 
 	for (i=0; i < ngroups; i++) {
+		unsigned int meta_blks = ext4_num_base_meta_blocks(sb, i);
+
 		cond_resched();
-		if (ext4_bg_has_super(sb, i) &&
-		    ((i < 5) || ((i % flex_size) == 0))) {
+		if (meta_blks != 0) {
 			ret = add_system_zone(system_blks,
 					ext4_group_first_block_no(sb, i),
-					ext4_bg_num_gdb(sb, i) + 1, 0);
+					meta_blks, 0);
 			if (ret)
 				goto err;
 		}
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c8fdf127d843..c3e9cb503763 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2967,6 +2967,8 @@ extern const char *ext4_decode_error(struct super_block *sb, int errno,
 extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
+extern unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
+					      ext4_group_t block_group);
 
 extern __printf(6, 7)
 void __ext4_error(struct super_block *, const char *, unsigned int, int, __u64,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3a7192884671..2f6ed59d81f0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2103,7 +2103,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
+	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return false;
 
 	free = grp->bb_free;
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index d5294e663df5..14e99ffa57af 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -243,8 +243,16 @@ static int fuse_direntplus_link(struct file *file,
 			dput(dentry);
 			dentry = alias;
 		}
-		if (IS_ERR(dentry))
+		if (IS_ERR(dentry)) {
+			if (!IS_ERR(inode)) {
+				struct fuse_inode *fi = get_fuse_inode(inode);
+
+				spin_lock(&fi->lock);
+				fi->nlookup--;
+				spin_unlock(&fi->lock);
+			}
 			return PTR_ERR(dentry);
+		}
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index f65bd6b35412..d4e063dbb9a0 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -508,6 +508,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 	 * blocks in the map. in that case, we'll start off with the
 	 * maximum free.
 	 */
+
+	/* give up if no space left */
+	if (bmp->db_maxfreebud == -1)
+		return -ENOSPC;
+
 	max = (s64) 1 << bmp->db_maxfreebud;
 	if (*nblocks >= max && *nblocks > nbperpage)
 		nb = nblks = (max > nbperpage) ? max : nbperpage;
diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index 1d9488cf0534..87a0f207df0b 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -276,6 +276,9 @@ static struct nsm_handle *nsm_create_handle(const struct sockaddr *sap,
 {
 	struct nsm_handle *new;
 
+	if (!hostname)
+		return NULL;
+
 	new = kzalloc(sizeof(*new) + hostname_len + 1, GFP_KERNEL);
 	if (unlikely(new == NULL))
 		return NULL;
diff --git a/fs/namei.c b/fs/namei.c
index bc5e633a5954..3ff954a2bbd1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2640,7 +2640,7 @@ int path_pts(struct path *path)
 	dput(path->dentry);
 	path->dentry = parent;
 	child = d_hash_and_lookup(parent, &this);
-	if (!child)
+	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
 	path->dentry = child;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index dec5880ac6de..6e3a14fdff9c 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -422,7 +422,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->concat.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
@@ -451,7 +451,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
 	int ret, i;
 
 	d->children = kcalloc(v->stripe.volumes_count,
-			sizeof(struct pnfs_block_dev), GFP_KERNEL);
+			sizeof(struct pnfs_block_dev), gfp_mask);
 	if (!d->children)
 		return -ENOMEM;
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index fbc7304bed56..018af6ec97b4 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -509,13 +509,31 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	return result;
 }
 
+static void nfs_direct_add_page_head(struct list_head *list,
+				     struct nfs_page *req)
+{
+	struct nfs_page *head = req->wb_head;
+
+	if (!list_empty(&head->wb_list) || !nfs_lock_request(head))
+		return;
+	if (!list_empty(&head->wb_list)) {
+		nfs_unlock_request(head);
+		return;
+	}
+	list_add(&head->wb_list, list);
+	kref_get(&head->wb_kref);
+	kref_get(&head->wb_kref);
+}
+
 static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
 	list_for_each_entry(req, list, wb_list) {
-		if (req->wb_head != req)
+		if (req->wb_head != req) {
+			nfs_direct_add_page_head(&req->wb_list, req);
 			continue;
+		}
 		subreq = req->wb_this_page;
 		if (subreq == req)
 			continue;
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 5e6453e9b307..b34196da1f94 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -948,7 +948,7 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	/*
 	 * The type (size and byte order) of nfscookie isn't defined in
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index b5a9379b1450..509f32845d7b 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1987,7 +1987,7 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_inline_filename3(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	error = decode_cookie3(xdr, &new_cookie);
 	if (unlikely(error))
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index dad32b171e67..dfeea712014b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -443,8 +443,9 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 				continue;
 			}
 			break;
-		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS && !args.sync) {
-			args.sync = true;
+		} else if (err == -NFS4ERR_OFFLOAD_NO_REQS &&
+				args.sync != res.synchronous) {
+			args.sync = res.synchronous;
 			dst_exception.retry = 1;
 			continue;
 		} else if ((err == -ESTALE ||
diff --git a/fs/nfs/pnfs_dev.c b/fs/nfs/pnfs_dev.c
index 537b80d693f1..d4829f3f2293 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -152,7 +152,7 @@ nfs4_get_device_info(struct nfs_server *server,
 		set_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 
 out_free_pages:
-	for (i = 0; i < max_pages; i++)
+	while (--i >= 0)
 		__free_page(pages[i]);
 	kfree(pages);
 out_free_pdev:
diff --git a/fs/nfsd/blocklayoutxdr.c b/fs/nfsd/blocklayoutxdr.c
index 442543304930..2455dc8be18a 100644
--- a/fs/nfsd/blocklayoutxdr.c
+++ b/fs/nfsd/blocklayoutxdr.c
@@ -82,6 +82,15 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int len = sizeof(__be32), ret, i;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	p = xdr_reserve_space(xdr, len + sizeof(__be32));
 	if (!p)
 		return nfserr_resource;
diff --git a/fs/nfsd/flexfilelayoutxdr.c b/fs/nfsd/flexfilelayoutxdr.c
index e81d2a5cf381..bb205328e043 100644
--- a/fs/nfsd/flexfilelayoutxdr.c
+++ b/fs/nfsd/flexfilelayoutxdr.c
@@ -85,6 +85,15 @@ nfsd4_ff_encode_getdeviceinfo(struct xdr_stream *xdr,
 	int addr_len;
 	__be32 *p;
 
+	/*
+	 * See paragraph 5 of RFC 8881 S18.40.3.
+	 */
+	if (!gdp->gd_maxcount) {
+		if (xdr_stream_encode_u32(xdr, 0) != XDR_UNIT)
+			return nfserr_resource;
+		return nfs_ok;
+	}
+
 	/* len + padding for two strings */
 	addr_len = 16 + da->netaddr.netid_len + da->netaddr.addr_len;
 	ver_len = 20;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c7e8e641d3e5..dbfa24cf3390 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4407,20 +4407,17 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	*p++ = cpu_to_be32(gdev->gd_layout_type);
 
-	/* If maxcount is 0 then just update notifications */
-	if (gdev->gd_maxcount != 0) {
-		ops = nfsd4_layout_ops[gdev->gd_layout_type];
-		nfserr = ops->encode_getdeviceinfo(xdr, gdev);
-		if (nfserr) {
-			/*
-			 * We don't bother to burden the layout drivers with
-			 * enforcing gd_maxcount, just tell the client to
-			 * come back with a bigger buffer if it's not enough.
-			 */
-			if (xdr->buf->len + 4 > gdev->gd_maxcount)
-				goto toosmall;
-			return nfserr;
-		}
+	ops = nfsd4_layout_ops[gdev->gd_layout_type];
+	nfserr = ops->encode_getdeviceinfo(xdr, gdev);
+	if (nfserr) {
+		/*
+		 * We don't bother to burden the layout drivers with
+		 * enforcing gd_maxcount, just tell the client to
+		 * come back with a bigger buffer if it's not enough.
+		 */
+		if (xdr->buf->len + 4 > gdev->gd_maxcount)
+			goto toosmall;
+		return nfserr;
 	}
 
 	if (gdev->gd_notify_types) {
diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index adf3bb0a8048..279d945d4ebe 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -205,7 +205,8 @@ static int nilfs_palloc_get_block(struct inode *inode, unsigned long blkoff,
 	int ret;
 
 	spin_lock(lock);
-	if (prev->bh && blkoff == prev->blkoff) {
+	if (prev->bh && blkoff == prev->blkoff &&
+	    likely(buffer_uptodate(prev->bh))) {
 		get_bh(prev->bh);
 		*bhp = prev->bh;
 		spin_unlock(lock);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 3a3cdc370647..d144e08a9003 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -1027,7 +1027,7 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 	int err;
 
 	spin_lock(&nilfs->ns_inode_lock);
-	if (ii->i_bh == NULL) {
+	if (ii->i_bh == NULL || unlikely(!buffer_uptodate(ii->i_bh))) {
 		spin_unlock(&nilfs->ns_inode_lock);
 		err = nilfs_ifile_get_inode_block(ii->i_root->ifile,
 						  inode->i_ino, pbh);
@@ -1036,7 +1036,10 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 		spin_lock(&nilfs->ns_inode_lock);
 		if (ii->i_bh == NULL)
 			ii->i_bh = *pbh;
-		else {
+		else if (unlikely(!buffer_uptodate(ii->i_bh))) {
+			__brelse(ii->i_bh);
+			ii->i_bh = *pbh;
+		} else {
 			brelse(*pbh);
 			*pbh = ii->i_bh;
 		}
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index e4686e30b1a7..418055ac910b 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -730,6 +730,11 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		struct page *page = pvec.pages[i];
 
 		lock_page(page);
+		if (unlikely(page->mapping != mapping)) {
+			/* Exclude pages removed from the address space */
+			unlock_page(page);
+			continue;
+		}
 		if (!page_has_buffers(page))
 			create_empty_buffers(page, i_blocksize(inode), 0);
 		unlock_page(page);
diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 52ccd34b1e79..a026dbd3593f 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -272,7 +272,7 @@ int unregister_nls(struct nls_table * nls)
 	return -EINVAL;
 }
 
-static struct nls_table *find_nls(char *charset)
+static struct nls_table *find_nls(const char *charset)
 {
 	struct nls_table *nls;
 	spin_lock(&nls_lock);
@@ -288,7 +288,7 @@ static struct nls_table *find_nls(char *charset)
 	return nls;
 }
 
-struct nls_table *load_nls(char *charset)
+struct nls_table *load_nls(const char *charset)
 {
 	return try_then_request_module(find_nls(charset), "nls_%s", charset);
 }
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index d6a0e719b1ad..5c98813b3dca 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1532,6 +1532,10 @@ static int ocfs2_rename(struct inode *old_dir,
 		status = ocfs2_add_entry(handle, new_dentry, old_inode,
 					 OCFS2_I(old_inode)->ip_blkno,
 					 new_dir_bh, &target_insert);
+		if (status < 0) {
+			mlog_errno(status);
+			goto bail;
+		}
 	}
 
 	old_inode->i_ctime = current_time(old_inode);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5d7df839902d..e0384095ca96 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2028,7 +2028,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5d52aea8d7e7..a484c30bd5cf 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3506,7 +3506,8 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index b6183f1f4ebc..a0fa3820ef2a 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -504,7 +504,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
-		if (buffer_size(prz) == 0) {
+		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
 			pr_debug("found existing empty buffer\n");
 			return 0;
 		}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 8d0cd68fc90a..13a9a17d6a13 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -225,13 +225,22 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 /*
  * Dquot List Management:
- * The quota code uses four lists for dquot management: the inuse_list,
- * free_dquots, dqi_dirty_list, and dquot_hash[] array. A single dquot
- * structure may be on some of those lists, depending on its current state.
+ * The quota code uses five lists for dquot management: the inuse_list,
+ * releasing_dquots, free_dquots, dqi_dirty_list, and dquot_hash[] array.
+ * A single dquot structure may be on some of those lists, depending on
+ * its current state.
  *
  * All dquots are placed to the end of inuse_list when first created, and this
  * list is used for invalidate operation, which must look at every dquot.
  *
+ * When the last reference of a dquot will be dropped, the dquot will be
+ * added to releasing_dquots. We'd then queue work item which would call
+ * synchronize_srcu() and after that perform the final cleanup of all the
+ * dquots on the list. Both releasing_dquots and free_dquots use the
+ * dq_free list_head in the dquot struct. When a dquot is removed from
+ * releasing_dquots, a reference count is always subtracted, and if
+ * dq_count == 0 at that point, the dquot will be added to the free_dquots.
+ *
  * Unused dquots (dq_count == 0) are added to the free_dquots list when freed,
  * and this list is searched whenever we need an available dquot.  Dquots are
  * removed from the list as soon as they are used again, and
@@ -250,6 +259,7 @@ static void put_quota_format(struct quota_format_type *fmt)
 
 static LIST_HEAD(inuse_list);
 static LIST_HEAD(free_dquots);
+static LIST_HEAD(releasing_dquots);
 static unsigned int dq_hash_bits, dq_hash_mask;
 static struct hlist_head *dquot_hash;
 
@@ -260,6 +270,9 @@ static qsize_t inode_get_rsv_space(struct inode *inode);
 static qsize_t __inode_get_rsv_space(struct inode *inode);
 static int __dquot_initialize(struct inode *inode, int type);
 
+static void quota_release_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(quota_release_work, quota_release_workfn);
+
 static inline unsigned int
 hashfn(const struct super_block *sb, struct kqid qid)
 {
@@ -307,12 +320,18 @@ static inline void put_dquot_last(struct dquot *dquot)
 	dqstats_inc(DQST_FREE_DQUOTS);
 }
 
+static inline void put_releasing_dquots(struct dquot *dquot)
+{
+	list_add_tail(&dquot->dq_free, &releasing_dquots);
+}
+
 static inline void remove_free_dquot(struct dquot *dquot)
 {
 	if (list_empty(&dquot->dq_free))
 		return;
 	list_del_init(&dquot->dq_free);
-	dqstats_dec(DQST_FREE_DQUOTS);
+	if (!atomic_read(&dquot->dq_count))
+		dqstats_dec(DQST_FREE_DQUOTS);
 }
 
 static inline void put_inuse(struct dquot *dquot)
@@ -338,6 +357,11 @@ static void wait_on_dquot(struct dquot *dquot)
 	mutex_unlock(&dquot->dq_lock);
 }
 
+static inline int dquot_active(struct dquot *dquot)
+{
+	return test_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+}
+
 static inline int dquot_dirty(struct dquot *dquot)
 {
 	return test_bit(DQ_MOD_B, &dquot->dq_flags);
@@ -353,14 +377,14 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
 {
 	int ret = 1;
 
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (!dquot_active(dquot))
 		return 0;
 
 	if (sb_dqopt(dquot->dq_sb)->flags & DQUOT_NOLIST_DIRTY)
 		return test_and_set_bit(DQ_MOD_B, &dquot->dq_flags);
 
 	/* If quota is dirty already, we don't have to acquire dq_list_lock */
-	if (test_bit(DQ_MOD_B, &dquot->dq_flags))
+	if (dquot_dirty(dquot))
 		return 1;
 
 	spin_lock(&dq_list_lock);
@@ -442,7 +466,7 @@ int dquot_acquire(struct dquot *dquot)
 	smp_mb__before_atomic();
 	set_bit(DQ_READ_B, &dquot->dq_flags);
 	/* Instantiate dquot if needed */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && !dquot->dq_off) {
+	if (!dquot_active(dquot) && !dquot->dq_off) {
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 		/* Write the info if needed */
 		if (info_dirty(&dqopt->info[dquot->dq_id.type])) {
@@ -484,7 +508,7 @@ int dquot_commit(struct dquot *dquot)
 		goto out_lock;
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (dquot_active(dquot))
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 	else
 		ret = -EIO;
@@ -549,6 +573,8 @@ static void invalidate_dquots(struct super_block *sb, int type)
 	struct dquot *dquot, *tmp;
 
 restart:
+	flush_delayed_work(&quota_release_work);
+
 	spin_lock(&dq_list_lock);
 	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
@@ -557,6 +583,12 @@ static void invalidate_dquots(struct super_block *sb, int type)
 			continue;
 		/* Wait for dquot users */
 		if (atomic_read(&dquot->dq_count)) {
+			/* dquot in releasing_dquots, flush and retry */
+			if (!list_empty(&dquot->dq_free)) {
+				spin_unlock(&dq_list_lock);
+				goto restart;
+			}
+
 			atomic_inc(&dquot->dq_count);
 			spin_unlock(&dq_list_lock);
 			/*
@@ -599,7 +631,7 @@ int dquot_scan_active(struct super_block *sb,
 
 	spin_lock(&dq_list_lock);
 	list_for_each_entry(dquot, &inuse_list, dq_inuse) {
-		if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+		if (!dquot_active(dquot))
 			continue;
 		if (dquot->dq_sb != sb)
 			continue;
@@ -614,7 +646,7 @@ int dquot_scan_active(struct super_block *sb,
 		 * outstanding call and recheck the DQ_ACTIVE_B after that.
 		 */
 		wait_on_dquot(dquot);
-		if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+		if (dquot_active(dquot)) {
 			ret = fn(dquot, priv);
 			if (ret < 0)
 				goto out;
@@ -630,6 +662,18 @@ int dquot_scan_active(struct super_block *sb,
 }
 EXPORT_SYMBOL(dquot_scan_active);
 
+static inline int dquot_write_dquot(struct dquot *dquot)
+{
+	int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
+	if (ret < 0) {
+		quota_error(dquot->dq_sb, "Can't write quota structure "
+			    "(error %d). Quota may get out of sync!", ret);
+		/* Clear dirty bit anyway to avoid infinite loop. */
+		clear_dquot_dirty(dquot);
+	}
+	return ret;
+}
+
 /* Write all dquot structures to quota files */
 int dquot_writeback_dquots(struct super_block *sb, int type)
 {
@@ -653,23 +697,16 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 			dquot = list_first_entry(&dirty, struct dquot,
 						 dq_dirty);
 
-			WARN_ON(!test_bit(DQ_ACTIVE_B, &dquot->dq_flags));
+			WARN_ON(!dquot_active(dquot));
 
 			/* Now we have active dquot from which someone is
  			 * holding reference so we can safely just increase
 			 * use count */
 			dqgrab(dquot);
 			spin_unlock(&dq_list_lock);
-			err = sb->dq_op->write_dquot(dquot);
-			if (err) {
-				/*
-				 * Clear dirty bit anyway to avoid infinite
-				 * loop here.
-				 */
-				clear_dquot_dirty(dquot);
-				if (!ret)
-					ret = err;
-			}
+			err = dquot_write_dquot(dquot);
+			if (err && !ret)
+				ret = err;
 			dqput(dquot);
 			spin_lock(&dq_list_lock);
 		}
@@ -762,13 +799,54 @@ static struct shrinker dqcache_shrinker = {
 	.seeks = DEFAULT_SEEKS,
 };
 
+/*
+ * Safely release dquot and put reference to dquot.
+ */
+static void quota_release_workfn(struct work_struct *work)
+{
+	struct dquot *dquot;
+	struct list_head rls_head;
+
+	spin_lock(&dq_list_lock);
+	/* Exchange the list head to avoid livelock. */
+	list_replace_init(&releasing_dquots, &rls_head);
+	spin_unlock(&dq_list_lock);
+
+restart:
+	synchronize_srcu(&dquot_srcu);
+	spin_lock(&dq_list_lock);
+	while (!list_empty(&rls_head)) {
+		dquot = list_first_entry(&rls_head, struct dquot, dq_free);
+		/* Dquot got used again? */
+		if (atomic_read(&dquot->dq_count) > 1) {
+			remove_free_dquot(dquot);
+			atomic_dec(&dquot->dq_count);
+			continue;
+		}
+		if (dquot_dirty(dquot)) {
+			spin_unlock(&dq_list_lock);
+			/* Commit dquot before releasing */
+			dquot_write_dquot(dquot);
+			goto restart;
+		}
+		if (dquot_active(dquot)) {
+			spin_unlock(&dq_list_lock);
+			dquot->dq_sb->dq_op->release_dquot(dquot);
+			goto restart;
+		}
+		/* Dquot is inactive and clean, now move it to free list */
+		remove_free_dquot(dquot);
+		atomic_dec(&dquot->dq_count);
+		put_dquot_last(dquot);
+	}
+	spin_unlock(&dq_list_lock);
+}
+
 /*
  * Put reference to dquot
  */
 void dqput(struct dquot *dquot)
 {
-	int ret;
-
 	if (!dquot)
 		return;
 #ifdef CONFIG_QUOTA_DEBUG
@@ -780,7 +858,7 @@ void dqput(struct dquot *dquot)
 	}
 #endif
 	dqstats_inc(DQST_DROPS);
-we_slept:
+
 	spin_lock(&dq_list_lock);
 	if (atomic_read(&dquot->dq_count) > 1) {
 		/* We have more than one user... nothing to do */
@@ -792,35 +870,15 @@ void dqput(struct dquot *dquot)
 		spin_unlock(&dq_list_lock);
 		return;
 	}
+
 	/* Need to release dquot? */
-	if (dquot_dirty(dquot)) {
-		spin_unlock(&dq_list_lock);
-		/* Commit dquot before releasing */
-		ret = dquot->dq_sb->dq_op->write_dquot(dquot);
-		if (ret < 0) {
-			quota_error(dquot->dq_sb, "Can't write quota structure"
-				    " (error %d). Quota may get out of sync!",
-				    ret);
-			/*
-			 * We clear dirty bit anyway, so that we avoid
-			 * infinite loop here
-			 */
-			clear_dquot_dirty(dquot);
-		}
-		goto we_slept;
-	}
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
-		spin_unlock(&dq_list_lock);
-		dquot->dq_sb->dq_op->release_dquot(dquot);
-		goto we_slept;
-	}
-	atomic_dec(&dquot->dq_count);
 #ifdef CONFIG_QUOTA_DEBUG
 	/* sanity check */
 	BUG_ON(!list_empty(&dquot->dq_free));
 #endif
-	put_dquot_last(dquot);
+	put_releasing_dquots(dquot);
 	spin_unlock(&dq_list_lock);
+	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -910,7 +968,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * already finished or it will be canceled due to dq_count > 1 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (!dquot_active(dquot)) {
 		int err;
 
 		err = sb->dq_op->acquire_dquot(dquot);
@@ -1427,7 +1485,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
 	return QUOTA_NL_NOWARN;
 }
 
-static int dquot_active(const struct inode *inode)
+static int inode_quota_active(const struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -1450,7 +1508,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 	qsize_t rsv;
 	int ret = 0;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	dquots = i_dquot(inode);
@@ -1558,7 +1616,7 @@ bool dquot_initialize_needed(struct inode *inode)
 	struct dquot **dquots;
 	int i;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return false;
 
 	dquots = i_dquot(inode);
@@ -1669,7 +1727,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) += number;
@@ -1739,7 +1797,7 @@ int dquot_alloc_inode(struct inode *inode)
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
@@ -1782,7 +1840,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) -= number;
 		__inode_add_bytes(inode, number);
@@ -1824,7 +1882,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) += number;
 		__inode_sub_bytes(inode, number);
@@ -1868,7 +1926,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot **dquots;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) -= number;
@@ -1923,7 +1981,7 @@ void dquot_free_inode(struct inode *inode)
 	struct dquot * const *dquots;
 	int index;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return;
 
 	dquots = i_dquot(inode);
@@ -2094,7 +2152,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 	struct super_block *sb = inode->i_sb;
 	int ret;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	if (iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)){
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index df5fc12a6cee..cfa4defbd040 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2325,7 +2325,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	int i, j;
 
 	bh = __getblk(dev, block, bufsize);
-	if (buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
 	if (block + BUFNR > max_block) {
@@ -2335,6 +2335,8 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	j = 1;
 	for (i = 1; i < blocks; i++) {
 		bh = __getblk(dev, block + i, bufsize);
+		if (!bh)
+			break;
 		if (buffer_uptodate(bh)) {
 			brelse(bh);
 			break;
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 8e597db4d971..f416b7fe092f 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -36,18 +36,41 @@ static int read_block_bitmap(struct super_block *sb,
 			     unsigned long bitmap_nr)
 {
 	struct buffer_head *bh = NULL;
-	int retval = 0;
+	int i;
+	int max_bits, off, count;
 	struct kernel_lb_addr loc;
 
 	loc.logicalBlockNum = bitmap->s_extPosition;
 	loc.partitionReferenceNum = UDF_SB(sb)->s_partition;
 
 	bh = udf_tread(sb, udf_get_lb_pblock(sb, &loc, block));
+	bitmap->s_block_bitmap[bitmap_nr] = bh;
 	if (!bh)
-		retval = -EIO;
+		return -EIO;
 
-	bitmap->s_block_bitmap[bitmap_nr] = bh;
-	return retval;
+	/* Check consistency of Space Bitmap buffer. */
+	max_bits = sb->s_blocksize * 8;
+	if (!bitmap_nr) {
+		off = sizeof(struct spaceBitmapDesc) << 3;
+		count = min(max_bits - off, bitmap->s_nr_groups);
+	} else {
+		/*
+		 * Rough check if bitmap number is too big to have any bitmap
+		 * blocks reserved.
+		 */
+		if (bitmap_nr >
+		    (bitmap->s_nr_groups >> (sb->s_blocksize_bits + 3)) + 2)
+			return 0;
+		off = 0;
+		count = bitmap->s_nr_groups - bitmap_nr * max_bits +
+				(sizeof(struct spaceBitmapDesc) << 3);
+		count = min(count, max_bits);
+	}
+
+	for (i = 0; i < count; i++)
+		if (udf_test_bit(i + off, bh->b_data))
+			return -EFSCORRUPTED;
+	return 0;
 }
 
 static int __load_block_bitmap(struct super_block *sb,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d114774ecdea..499a27372a40 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -57,15 +57,15 @@ static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
 static int udf_alloc_i_data(struct inode *inode, size_t size);
 static sector_t inode_getblk(struct inode *, sector_t, int *, int *);
-static int8_t udf_insert_aext(struct inode *, struct extent_position,
-			      struct kernel_lb_addr, uint32_t);
+static int udf_insert_aext(struct inode *, struct extent_position,
+			   struct kernel_lb_addr, uint32_t);
 static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
 			      struct kernel_long_ad *, int *);
 static void udf_prealloc_extents(struct inode *, int, int,
 				 struct kernel_long_ad *, int *);
 static void udf_merge_extents(struct inode *, struct kernel_long_ad *, int *);
-static void udf_update_extents(struct inode *, struct kernel_long_ad *, int,
-			       int, struct extent_position *);
+static int udf_update_extents(struct inode *, struct kernel_long_ad *, int,
+			      int, struct extent_position *);
 static int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
 
 static void __udf_clear_extent_cache(struct inode *inode)
@@ -695,7 +695,7 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	struct kernel_lb_addr eloc, tmpeloc;
 	int c = 1;
 	loff_t lbcount = 0, b_off = 0;
-	udf_pblk_t newblocknum, newblock;
+	udf_pblk_t newblocknum, newblock = 0;
 	sector_t offset = 0;
 	int8_t etype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -798,7 +798,6 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 		ret = udf_do_extend_file(inode, &prev_epos, laarr, hole_len);
 		if (ret < 0) {
 			*err = ret;
-			newblock = 0;
 			goto out_free;
 		}
 		c = 0;
@@ -861,7 +860,6 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 				goal, err);
 		if (!newblocknum) {
 			*err = -ENOSPC;
-			newblock = 0;
 			goto out_free;
 		}
 		if (isBeyondEOF)
@@ -887,7 +885,9 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	/* write back the new extents, inserting new extents if the new number
 	 * of extents is greater than the old number, and deleting extents if
 	 * the new number of extents is less than the old number */
-	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	*err = udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
+	if (*err < 0)
+		goto out_free;
 
 	newblock = udf_get_pblock(inode->i_sb, newblocknum,
 				iinfo->i_location.partitionReferenceNum, 0);
@@ -1155,21 +1155,30 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 	}
 }
 
-static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
-			       int startnum, int endnum,
-			       struct extent_position *epos)
+static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
+			      int startnum, int endnum,
+			      struct extent_position *epos)
 {
 	int start = 0, i;
 	struct kernel_lb_addr tmploc;
 	uint32_t tmplen;
+	int err;
 
 	if (startnum > endnum) {
 		for (i = 0; i < (startnum - endnum); i++)
 			udf_delete_aext(inode, *epos);
 	} else if (startnum < endnum) {
 		for (i = 0; i < (endnum - startnum); i++) {
-			udf_insert_aext(inode, *epos, laarr[i].extLocation,
-					laarr[i].extLength);
+			err = udf_insert_aext(inode, *epos,
+					      laarr[i].extLocation,
+					      laarr[i].extLength);
+			/*
+			 * If we fail here, we are likely corrupting the extent
+			 * list and leaking blocks. At least stop early to
+			 * limit the damage.
+			 */
+			if (err < 0)
+				return err;
 			udf_next_aext(inode, epos, &laarr[i].extLocation,
 				      &laarr[i].extLength, 1);
 			start++;
@@ -1181,6 +1190,7 @@ static void udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr
 		udf_write_aext(inode, epos, &laarr[i].extLocation,
 			       laarr[i].extLength, 1);
 	}
+	return 0;
 }
 
 struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
@@ -2215,12 +2225,13 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
 	return etype;
 }
 
-static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
-			      struct kernel_lb_addr neloc, uint32_t nelen)
+static int udf_insert_aext(struct inode *inode, struct extent_position epos,
+			   struct kernel_lb_addr neloc, uint32_t nelen)
 {
 	struct kernel_lb_addr oeloc;
 	uint32_t oelen;
 	int8_t etype;
+	int err;
 
 	if (epos.bh)
 		get_bh(epos.bh);
@@ -2230,10 +2241,10 @@ static int8_t udf_insert_aext(struct inode *inode, struct extent_position epos,
 		neloc = oeloc;
 		nelen = (etype << 30) | oelen;
 	}
-	udf_add_aext(inode, &epos, &neloc, nelen, 1);
+	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
 	brelse(epos.bh);
 
-	return (nelen >> 30);
+	return err;
 }
 
 int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
index b14ed96387ec..ed32afc238d2 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -61,6 +61,22 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 		return -EBADMSG;
 	}
 
+	if (fsverity_keyring->keys.nr_leaves_on_tree == 0) {
+		/*
+		 * The ".fs-verity" keyring is empty, due to builtin signatures
+		 * being supported by the kernel but not actually being used.
+		 * In this case, verify_pkcs7_signature() would always return an
+		 * error, usually ENOKEY.  It could also be EBADMSG if the
+		 * PKCS#7 is malformed, but that isn't very important to
+		 * distinguish.  So, just skip to ENOKEY to avoid the attack
+		 * surface of the PKCS#7 parser, which would otherwise be
+		 * reachable by any task able to execute FS_IOC_ENABLE_VERITY.
+		 */
+		fsverity_err(inode,
+			     "fs-verity keyring is empty, rejecting signed file!");
+		return -ENOKEY;
+	}
+
 	d = kzalloc(sizeof(*d) + hash_alg->digest_size, GFP_KERNEL);
 	if (!d)
 		return -ENOMEM;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 680f80960c3d..a6ac2e8b72da 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -27,14 +27,16 @@ extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
 extern bool ghes_disable;
+void __init ghes_init(void);
 #else
 #define ghes_disable 1
+static inline void ghes_init(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
 #else
-static inline void acpi_hest_init(void) { return; }
+static inline void acpi_hest_init(void) { }
 #endif
 
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 18dd7a4aaf7d..96dbd438cc70 100644
--- a/include/crypto/algapi.h
+++ b/include/crypto/algapi.h
@@ -10,6 +10,7 @@
 #include <linux/crypto.h>
 #include <linux/list.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
 
 /*
  * Maximum values for blocksize and alignmask, used to allocate
@@ -55,6 +56,8 @@ struct crypto_instance {
 		struct crypto_spawn *spawns;
 	};
 
+	struct work_struct free_work;
+
 	void *__ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 0a241c5c911d..255701e1251b 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -46,9 +46,13 @@ int sdei_unregister_ghes(struct ghes *ghes);
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
+void __init sdei_init(void);
+void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
+static inline void sdei_init(void) { }
+static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 6cd2a92daf20..c1bd4883e2fa 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -42,6 +42,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n);
 __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, unsigned mask);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
 DECLARE_PER_CPU(int, eventfd_wake_count);
 
@@ -89,6 +90,11 @@ static inline bool eventfd_signal_count(void)
 	return false;
 }
 
+static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
+{
+
+}
+
 #endif
 
 #endif /* _LINUX_EVENTFD_H */
diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index e147ea679467..91db78e67edc 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -52,6 +52,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	/* PPP adds its l2 header automatically in ppp_start_xmit().
+	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
+	 */
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;
diff --git a/include/linux/nls.h b/include/linux/nls.h
index 499e486b3722..e0bf8367b274 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -47,7 +47,7 @@ enum utf16_endian {
 /* nls_base.c */
 extern int __register_nls(struct nls_table *, struct module *);
 extern int unregister_nls(struct nls_table *);
-extern struct nls_table *load_nls(char *);
+extern struct nls_table *load_nls(const char *charset);
 extern void unload_nls(struct nls_table *);
 extern struct nls_table *load_nls_default(void);
 #define register_nls(nls) __register_nls((nls), THIS_MODULE)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e418065c2c90..6fb20722f49b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -745,7 +745,8 @@ extern int  perf_uprobe_init(struct perf_event *event,
 extern void perf_uprobe_destroy(struct perf_event *event);
 extern int bpf_get_uprobe_info(const struct perf_event *event,
 			       u32 *fd_type, const char **filename,
-			       u64 *probe_offset, bool perf_type_tracepoint);
+			       u64 *probe_offset, u64 *probe_addr,
+			       bool perf_type_tracepoint);
 #endif
 extern int  ftrace_profile_set_filter(struct perf_event *event, int event_id,
 				     char *filter_str);
diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 5e0a7b7647c3..22b8ee8f0311 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -67,7 +67,7 @@ struct typec_altmode_ops {
 
 int typec_altmode_enter(struct typec_altmode *altmode, u32 *vdo);
 int typec_altmode_exit(struct typec_altmode *altmode);
-void typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
+int typec_altmode_attention(struct typec_altmode *altmode, u32 vdo);
 int typec_altmode_vdm(struct typec_altmode *altmode,
 		      const u32 header, const u32 *vdo, int count);
 int typec_altmode_notify(struct typec_altmode *altmode, unsigned long conf,
diff --git a/include/net/ip.h b/include/net/ip.h
index 8d1173577fb5..9be2efe00f2c 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -56,6 +56,7 @@ struct inet_skb_parm {
 #define IPSKB_FRAG_PMTU		BIT(6)
 #define IPSKB_L3SLAVE		BIT(7)
 #define IPSKB_NOPOLICY		BIT(8)
+#define IPSKB_MULTIPATH		BIT(9)
 
 	u16			frag_max_size;
 };
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1ddd401a8981..58d8e6260aa1 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -455,15 +455,14 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 		tstats->tx_packets++;
 		u64_stats_update_end(&tstats->syncp);
 		put_cpu_ptr(tstats);
+		return;
+	}
+
+	if (pkt_len < 0) {
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	} else {
-		struct net_device_stats *err_stats = &dev->stats;
-
-		if (pkt_len < 0) {
-			err_stats->tx_errors++;
-			err_stats->tx_aborted_errors++;
-		} else {
-			err_stats->tx_dropped++;
-		}
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 }
 
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 4c8f97a6da5a..47d644de0e47 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1249,7 +1249,7 @@ static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
 	return 0;
 }
 
-static inline int ip6_sock_set_addr_preferences(struct sock *sk, bool val)
+static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
 {
 	int ret;
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 05cfd6ff6528..d4a90eca1921 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -16,9 +16,12 @@
 #define LWTUNNEL_STATE_INPUT_REDIRECT	BIT(1)
 #define LWTUNNEL_STATE_XMIT_REDIRECT	BIT(2)
 
+/* LWTUNNEL_XMIT_CONTINUE should be distinguishable from dst_output return
+ * values (NET_XMIT_xxx and NETDEV_TX_xxx in linux/netdevice.h) for safety.
+ */
 enum {
 	LWTUNNEL_XMIT_DONE,
-	LWTUNNEL_XMIT_CONTINUE,
+	LWTUNNEL_XMIT_CONTINUE = 0x100,
 };
 
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index dcca41f3a224..b56f34602035 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -337,7 +337,6 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index e6a43163ab5b..daf9b07956ab 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -474,10 +474,16 @@ enum service_response {
 };
 
 enum exec_status {
-	/* The SAM_STAT_.. codes fit in the lower 6 bits, alias some of
-	 * them here to silence 'case value not in enumerated type' warnings
+	/*
+	 * Values 0..0x7f are used to return the SAM_STAT_* codes.  To avoid
+	 * 'case value not in enumerated type' compiler warnings every value
+	 * returned through the exec_status enum needs an alias with the SAS_
+	 * prefix here.
 	 */
-	__SAM_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,
+	SAS_SAM_STAT_GOOD = SAM_STAT_GOOD,
+	SAS_SAM_STAT_BUSY = SAM_STAT_BUSY,
+	SAS_SAM_STAT_TASK_ABORTED = SAM_STAT_TASK_ABORTED,
+	SAS_SAM_STAT_CHECK_CONDITION = SAM_STAT_CHECK_CONDITION,
 
 	SAS_DEV_NO_RESPONSE = 0x80,
 	SAS_DATA_UNDERRUN,
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 701f178b20ae..4a9f1e6e3aac 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -745,7 +745,7 @@ extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
 extern void scsi_host_put(struct Scsi_Host *t);
-extern struct Scsi_Host *scsi_host_lookup(unsigned short);
+extern struct Scsi_Host *scsi_host_lookup(unsigned int hostnum);
 extern const char *scsi_host_state_name(enum scsi_host_state);
 extern void scsi_host_complete_all_commands(struct Scsi_Host *shost,
 					    int status);
diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index ee2dcfb3d660..d7f7c04a6e0c 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -52,7 +52,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences:	number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of structs sync_fence_info with all
  *		 fences in the sync_file
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 81485c1a9879..fe8594a0396c 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -176,6 +176,16 @@ static void io_worker_ref_put(struct io_wq *wq)
 		complete(&wq->worker_done);
 }
 
+bool io_wq_worker_stopped(void)
+{
+	struct io_worker *worker = current->pf_io_worker;
+
+	if (WARN_ON_ONCE(!io_wq_current_is_worker()))
+		return true;
+
+	return test_bit(IO_WQ_BIT_EXIT, &worker->wqe->wq->state);
+}
+
 static void io_worker_cancel_cb(struct io_worker *worker)
 {
 	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index bf5c4c533760..48721cbd5f40 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -129,6 +129,7 @@ void io_wq_hash_work(struct io_wq_work *work, void *val);
 
 int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
+bool io_wq_worker_stopped(void);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index dec8a6355f2a..800b5cc385af 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2665,6 +2665,11 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
 				break;
 		}
 		ret = io_do_iopoll(ctx, &nr_events, min);
+
+		if (task_sigpending(current)) {
+			ret = -EINTR;
+			goto out;
+		}
 	} while (!ret && nr_events < min && !need_resched());
 out:
 	mutex_unlock(&ctx->uring_lock);
@@ -5571,6 +5576,7 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
 	if (ret > 0)
 		return;
 
+	io_tw_lock(req->ctx, locked);
 	io_poll_remove_entries(req);
 	spin_lock(&ctx->completion_lock);
 	hash_del(&req->hash_node);
@@ -6897,7 +6903,8 @@ static void io_wq_submit_work(struct io_wq_work *work)
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
-
+			if (io_wq_worker_stopped())
+				break;
 			/*
 			 * If REQ_F_NOWAIT is set, then don't wait or retry with
 			 * poll. -EAGAIN is final for that case.
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 07e2788bbbf1..57b982b44732 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2203,6 +2203,8 @@ void __audit_inode_child(struct inode *parent,
 		}
 	}
 
+	cond_resched();
+
 	/* is there a matching child entry? */
 	list_for_each_entry(n, &context->names_list, list) {
 		/* can only match entries that have a name */
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 812a61afd538..d2b4dd753234 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -149,9 +149,3 @@ const struct proc_ns_operations cgroupns_operations = {
 	.install	= cgroupns_install,
 	.owner		= cgroupns_owner,
 };
-
-static __init int cgroup_namespaces_init(void)
-{
-	return 0;
-}
-subsys_initcall(cgroup_namespaces_init);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 86d71c49b495..f1ea3123f383 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1628,6 +1628,17 @@ int __weak arch_check_ftrace_location(struct kprobe *p)
 	return 0;
 }
 
+static bool is_cfi_preamble_symbol(unsigned long addr)
+{
+	char symbuf[KSYM_NAME_LEN];
+
+	if (lookup_symbol_name(addr, symbuf))
+		return false;
+
+	return str_has_prefix("__cfi_", symbuf) ||
+		str_has_prefix("__pfx_", symbuf);
+}
+
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
 {
@@ -1646,7 +1657,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-	    find_bug((unsigned long)p->addr)) {
+	    find_bug((unsigned long)p->addr) ||
+	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/kernel/module.c b/kernel/module.c
index 82af3ef79135..72a5dcdccf7b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2268,15 +2268,26 @@ static void free_module(struct module *mod)
 void *__symbol_get(const char *symbol)
 {
 	struct module *owner;
+	enum mod_license license;
 	const struct kernel_symbol *sym;
 
 	preempt_disable();
-	sym = find_symbol(symbol, &owner, NULL, NULL, true, true);
-	if (sym && strong_try_module_get(owner))
+	sym = find_symbol(symbol, &owner, NULL, &license, true, true);
+	if (!sym)
+		goto fail;
+	if (license != GPL_ONLY) {
+		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+			symbol);
+		goto fail;
+	}
+	if (strong_try_module_get(owner))
 		sym = NULL;
 	preempt_enable();
 
 	return sym ? (void *)kernel_symbol_value(sym) : NULL;
+fail:
+	preempt_enable();
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 617dd6358965..3e8214e9bf4a 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1726,7 +1726,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	if (!buf || !buf_size)
 		return true;
 
-	data_size = min_t(u16, buf_size, len);
+	data_size = min_t(unsigned int, buf_size, len);
 
 	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
 	return true;
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 4e419ca6d611..dbd670376c42 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -692,12 +692,11 @@ ref_scale_init(void)
 	VERBOSE_SCALEOUT("Starting %d reader threads\n", nreaders);
 
 	for (i = 0; i < nreaders; i++) {
+		init_waitqueue_head(&reader_tasks[i].wq);
 		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
 						  reader_tasks[i].task);
 		if (firsterr)
 			goto unwind;
-
-		init_waitqueue_head(&(reader_tasks[i].wq));
 	}
 
 	// Main Task
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 1de9a6bf8471..71e0c1bc9759 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2174,7 +2174,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_UPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_UPROBE)
 			err = bpf_get_uprobe_info(event, fd_type, buf,
-						  probe_offset,
+						  probe_offset, probe_addr,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 597487a7f1bf..d3e0ae116806 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6255,10 +6255,36 @@ tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 
 #endif
 
+static int open_pipe_on_cpu(struct trace_array *tr, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		if (cpumask_empty(tr->pipe_cpumask)) {
+			cpumask_setall(tr->pipe_cpumask);
+			return 0;
+		}
+	} else if (!cpumask_test_cpu(cpu, tr->pipe_cpumask)) {
+		cpumask_set_cpu(cpu, tr->pipe_cpumask);
+		return 0;
+	}
+	return -EBUSY;
+}
+
+static void close_pipe_on_cpu(struct trace_array *tr, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		WARN_ON(!cpumask_full(tr->pipe_cpumask));
+		cpumask_clear(tr->pipe_cpumask);
+	} else {
+		WARN_ON(!cpumask_test_cpu(cpu, tr->pipe_cpumask));
+		cpumask_clear_cpu(cpu, tr->pipe_cpumask);
+	}
+}
+
 static int tracing_open_pipe(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
 	struct trace_iterator *iter;
+	int cpu;
 	int ret;
 
 	ret = tracing_check_open_get_tr(tr);
@@ -6266,13 +6292,16 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 		return ret;
 
 	mutex_lock(&trace_types_lock);
+	cpu = tracing_get_cpu(inode);
+	ret = open_pipe_on_cpu(tr, cpu);
+	if (ret)
+		goto fail_pipe_on_cpu;
 
 	/* create a buffer to store the information to pass to userspace */
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
 	if (!iter) {
 		ret = -ENOMEM;
-		__trace_array_put(tr);
-		goto out;
+		goto fail_alloc_iter;
 	}
 
 	trace_seq_init(&iter->seq);
@@ -6295,7 +6324,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 
 	iter->tr = tr;
 	iter->array_buffer = &tr->array_buffer;
-	iter->cpu_file = tracing_get_cpu(inode);
+	iter->cpu_file = cpu;
 	mutex_init(&iter->mutex);
 	filp->private_data = iter;
 
@@ -6305,12 +6334,15 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 
 	tr->trace_ref++;
-out:
+
 	mutex_unlock(&trace_types_lock);
 	return ret;
 
 fail:
 	kfree(iter);
+fail_alloc_iter:
+	close_pipe_on_cpu(tr, cpu);
+fail_pipe_on_cpu:
 	__trace_array_put(tr);
 	mutex_unlock(&trace_types_lock);
 	return ret;
@@ -6327,7 +6359,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	if (iter->trace->pipe_close)
 		iter->trace->pipe_close(iter);
-
+	close_pipe_on_cpu(tr, iter->cpu_file);
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(iter->started);
@@ -7132,6 +7164,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static void tracing_swap_cpu_buffer(void *tr)
+{
+	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+}
+
 static ssize_t
 tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		       loff_t *ppos)
@@ -7190,13 +7227,15 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			ret = tracing_alloc_snapshot_instance(tr);
 		if (ret < 0)
 			break;
-		local_irq_disable();
 		/* Now, we're going to swap */
-		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
+		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
+			local_irq_disable();
 			update_max_tr(tr, current, smp_processor_id(), NULL);
-		else
-			update_max_tr_single(tr, current, iter->cpu_file);
-		local_irq_enable();
+			local_irq_enable();
+		} else {
+			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
+						 (void *)tr, 1);
+		}
 		break;
 	default:
 		if (tr->allocated_snapshot) {
@@ -8851,6 +8890,9 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
+	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+		goto out_free_tr;
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -8892,6 +8934,7 @@ static struct trace_array *trace_array_create(const char *name)
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
+	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
@@ -8993,6 +9036,7 @@ static int __remove_instance(struct trace_array *tr)
 	}
 	kfree(tr->topts);
 
+	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
@@ -9692,12 +9736,14 @@ __init static int tracer_alloc_buffers(void)
 	if (trace_create_savedcmd() < 0)
 		goto out_free_temp_buffer;
 
+	if (!zalloc_cpumask_var(&global_trace.pipe_cpumask, GFP_KERNEL))
+		goto out_free_savedcmd;
+
 	/* TODO: make the number of buffers hot pluggable with CPUS */
 	if (allocate_trace_buffers(&global_trace, ring_buf_size) < 0) {
 		MEM_FAIL(1, "tracer: failed to allocate ring buffer!\n");
-		goto out_free_savedcmd;
+		goto out_free_pipe_cpumask;
 	}
-
 	if (global_trace.buffer_disabled)
 		tracing_off();
 
@@ -9748,6 +9794,8 @@ __init static int tracer_alloc_buffers(void)
 
 	return 0;
 
+out_free_pipe_cpumask:
+	free_cpumask_var(global_trace.pipe_cpumask);
 out_free_savedcmd:
 	free_saved_cmdlines_buffer(savedcmd);
 out_free_temp_buffer:
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 892b3d2f33b7..dfde855dafda 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -356,6 +356,8 @@ struct trace_array {
 	struct list_head	events;
 	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
+	/* one per_cpu trace_pipe can be opened by only one user */
+	cpumask_var_t		pipe_cpumask;
 	int			ref;
 	int			trace_ref;
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f6c47361c154..60ff36f5d7f9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1422,7 +1422,7 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **filename, u64 *probe_offset,
-			bool perf_type_tracepoint)
+			u64 *probe_addr, bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1439,6 +1439,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 				    : BPF_FD_TYPE_UPROBE;
 	*filename = tu->filename;
 	*probe_offset = tu->offset;
+	*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
diff --git a/lib/idr.c b/lib/idr.c
index 7ecdfdb5309e..13f2758c2377 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL_GPL(idr_alloc);
  * @end: The maximum ID (exclusive).
  * @gfp: Memory allocation flags.
  *
- * Allocates an unused ID in the range specified by @nextid and @end.  If
+ * Allocates an unused ID in the range specified by @start and @end.  If
  * @end is <= 0, it is treated as one larger than %INT_MAX.  This allows
  * callers to use @start + N as @end as long as N is within integer range.
  * The search for an unused ID will start at the last ID allocated and will
diff --git a/lib/test_meminit.c b/lib/test_meminit.c
index 3ca717f11397..75638404ed57 100644
--- a/lib/test_meminit.c
+++ b/lib/test_meminit.c
@@ -86,7 +86,7 @@ static int __init test_pages(int *total_failures)
 	int failures = 0, num_tests = 0;
 	int i;
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i <= MAX_ORDER; i++)
 		num_tests += do_alloc_pages_order(i, &failures);
 
 	REPORT_FAILURES_IN_FN();
diff --git a/mm/shmem.c b/mm/shmem.c
index cfa8f43cb3a6..e173d83b4448 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3455,6 +3455,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	unsigned long long size;
 	char *rest;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3490,14 +3492,32 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->mode = result.uint_32 & 07777;
 		break;
 	case Opt_uid:
-		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
-		if (!uid_valid(ctx->uid))
+		kuid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(kuid))
 			goto bad_value;
+
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, kuid))
+			goto bad_value;
+
+		ctx->uid = kuid;
 		break;
 	case Opt_gid:
-		ctx->gid = make_kgid(current_user_ns(), result.uint_32);
-		if (!gid_valid(ctx->gid))
+		kgid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(kgid))
 			goto bad_value;
+
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, kgid))
+			goto bad_value;
+
+		ctx->gid = kgid;
 		break;
 	case Opt_huge:
 		ctx->huge = result.uint_32;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index f582351d84ec..36b5f72e2165 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -394,7 +394,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
-	size_t offs;
+	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bd6f20ef13f3..46e1e51ff28e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2343,9 +2343,9 @@ void hci_uuids_clear(struct hci_dev *hdev)
 
 void hci_link_keys_clear(struct hci_dev *hdev)
 {
-	struct link_key *key;
+	struct link_key *key, *tmp;
 
-	list_for_each_entry(key, &hdev->link_keys, list) {
+	list_for_each_entry_safe(key, tmp, &hdev->link_keys, list) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
 	}
@@ -2353,9 +2353,9 @@ void hci_link_keys_clear(struct hci_dev *hdev)
 
 void hci_smp_ltks_clear(struct hci_dev *hdev)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -2363,9 +2363,9 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
 
 void hci_smp_irks_clear(struct hci_dev *hdev)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -2373,9 +2373,9 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
 
 void hci_blocked_keys_clear(struct hci_dev *hdev)
 {
-	struct blocked_key *b;
+	struct blocked_key *b, *tmp;
 
-	list_for_each_entry(b, &hdev->blocked_keys, list) {
+	list_for_each_entry_safe(b, tmp, &hdev->blocked_keys, list) {
 		list_del_rcu(&b->list);
 		kfree_rcu(b, rcu);
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index b9c954182b37..ea8ab9c70483 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6661,6 +6661,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -ENETUNREACH;
 	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
 		return -ESOCKTNOSUPPORT;
+	if (sk_unhashed(sk))
+		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index b8d082f55718..3d5192177560 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1589,8 +1589,7 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 
 	memset(&keys, 0, sizeof(keys));
 	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
-			   &keys, NULL, 0, 0, 0,
-			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			   &keys, NULL, 0, 0, 0, 0);
 
 	return __flow_hash_from_keys(&keys, &hashrnd);
 }
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index 3fd207fe1284..f6c327c7badb 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -59,9 +59,8 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 			ret = BPF_OK;
 		} else {
 			skb_reset_mac_header(skb);
-			ret = skb_do_redirect(skb);
-			if (ret == 0)
-				ret = BPF_REDIRECT;
+			skb_do_redirect(skb);
+			ret = BPF_REDIRECT;
 		}
 		break;
 
@@ -254,7 +253,7 @@ static int bpf_lwt_xmit_reroute(struct sk_buff *skb)
 
 	err = dst_output(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	if (unlikely(err))
-		return err;
+		return net_xmit_errno(err);
 
 	/* ip[6]_finish_output2 understand LWTUNNEL_XMIT_DONE */
 	return LWTUNNEL_XMIT_DONE;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b10285d06a2c..196278a137c0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3799,21 +3799,20 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	struct sk_buff *segs = NULL;
 	struct sk_buff *tail = NULL;
 	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
-	skb_frag_t *frag = skb_shinfo(head_skb)->frags;
 	unsigned int mss = skb_shinfo(head_skb)->gso_size;
 	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
-	struct sk_buff *frag_skb = head_skb;
 	unsigned int offset = doffset;
 	unsigned int tnl_hlen = skb_tnl_header_len(head_skb);
 	unsigned int partial_segs = 0;
 	unsigned int headroom;
 	unsigned int len = head_skb->len;
+	struct sk_buff *frag_skb;
+	skb_frag_t *frag;
 	__be16 proto;
 	bool csum, sg;
-	int nfrags = skb_shinfo(head_skb)->nr_frags;
 	int err = -ENOMEM;
 	int i = 0;
-	int pos;
+	int nfrags, pos;
 
 	if ((skb_shinfo(head_skb)->gso_type & SKB_GSO_DODGY) &&
 	    mss != GSO_BY_FRAGS && mss != skb_headlen(head_skb)) {
@@ -3890,6 +3889,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 	headroom = skb_headroom(head_skb);
 	pos = skb_headlen(head_skb);
 
+	if (skb_orphan_frags(head_skb, GFP_ATOMIC))
+		return ERR_PTR(-ENOMEM);
+
+	nfrags = skb_shinfo(head_skb)->nr_frags;
+	frag = skb_shinfo(head_skb)->frags;
+	frag_skb = head_skb;
+
 	do {
 		struct sk_buff *nskb;
 		skb_frag_t *nskb_frag;
@@ -3914,6 +3920,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
+			nskb = skb_clone(list_skb, GFP_ATOMIC);
+			if (unlikely(!nskb))
+				goto err;
+
 			i = 0;
 			nfrags = skb_shinfo(list_skb)->nr_frags;
 			frag = skb_shinfo(list_skb)->frags;
@@ -3932,12 +3942,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				frag++;
 			}
 
-			nskb = skb_clone(list_skb, GFP_ATOMIC);
 			list_skb = list_skb->next;
 
-			if (unlikely(!nskb))
-				goto err;
-
 			if (unlikely(pskb_trim(nskb, len))) {
 				kfree_skb(nskb);
 				goto err;
@@ -4008,12 +4014,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_shinfo(nskb)->tx_flags |= skb_shinfo(head_skb)->tx_flags &
 					      SKBTX_SHARED_FRAG;
 
-		if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-		    skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
+		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
 			goto err;
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
+				    skb_zerocopy_clone(nskb, list_skb,
+						       GFP_ATOMIC))
+					goto err;
+
 				i = 0;
 				nfrags = skb_shinfo(list_skb)->nr_frags;
 				frag = skb_shinfo(list_skb)->frags;
@@ -4027,10 +4037,6 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 					i--;
 					frag--;
 				}
-				if (skb_orphan_frags(frag_skb, GFP_ATOMIC) ||
-				    skb_zerocopy_clone(nskb, frag_skb,
-						       GFP_ATOMIC))
-					goto err;
 
 				list_skb = list_skb->next;
 			}
diff --git a/net/core/sock.c b/net/core/sock.c
index 742356cfd07c..fcb998dc2dc6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -690,7 +690,8 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	switch (sk->sk_family) {
+	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2314,9 +2315,9 @@ static long sock_wait_for_wmem(struct sock *sk, long timeo)
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 		if (refcount_read(&sk->sk_wmem_alloc) < READ_ONCE(sk->sk_sndbuf))
 			break;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			break;
-		if (sk->sk_err)
+		if (READ_ONCE(sk->sk_err))
 			break;
 		timeo = schedule_timeout(timeo);
 	}
@@ -2344,7 +2345,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 			goto failure;
 
 		err = -EPIPE;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			goto failure;
 
 		if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index a2a8b952b3c5..398dc3e47d0c 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -243,12 +243,17 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* Only need dccph_dport & dccph_sport which are the first
-	 * 4 bytes in dccp header.
+	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
+	 * which is in byte 7 of the dccp header.
 	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
+	 *
+	 * Later on, we want to access the sequence number fields, which are
+	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
 	 */
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
+	dh = (struct dccp_hdr *)(skb->data + offset);
+	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
+		return -EINVAL;
+	iph = (struct iphdr *)skb->data;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 
 	sk = __inet_lookup_established(net, &dccp_hashinfo,
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 64e91783860d..bfe11e96af7c 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -67,7 +67,7 @@ static inline __u64 dccp_v6_init_sequence(struct sk_buff *skb)
 static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			u8 type, u8 code, int offset, __be32 info)
 {
-	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
+	const struct ipv6hdr *hdr;
 	const struct dccp_hdr *dh;
 	struct dccp_sock *dp;
 	struct ipv6_pinfo *np;
@@ -76,12 +76,17 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* Only need dccph_dport & dccph_sport which are the first
-	 * 4 bytes in dccp header.
+	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
+	 * which is in byte 7 of the dccp header.
 	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
+	 *
+	 * Later on, we want to access the sequence number fields, which are
+	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
 	 */
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_sport) > 8);
-	BUILD_BUG_ON(offsetofend(struct dccp_hdr, dccph_dport) > 8);
+	dh = (struct dccp_hdr *)(skb->data + offset);
+	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
+		return -EINVAL;
+	hdr = (const struct ipv6hdr *)skb->data;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 
 	sk = __inet6_lookup_established(net, &dccp_hashinfo,
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aec48e670fb6..2a02cb2edec2 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -531,6 +531,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
 		netdev_warn_once(skb->dev, "VLAN not yet supported");
+		return -EINVAL;
 	}
 
 	frame->is_from_san = false;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 88b6120878cd..da1ca8081c03 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -351,14 +351,14 @@ static void __inet_del_ifa(struct in_device *in_dev,
 {
 	struct in_ifaddr *promote = NULL;
 	struct in_ifaddr *ifa, *ifa1;
-	struct in_ifaddr *last_prim;
+	struct in_ifaddr __rcu **last_prim;
 	struct in_ifaddr *prev_prom = NULL;
 	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
 
 	ASSERT_RTNL();
 
 	ifa1 = rtnl_dereference(*ifap);
-	last_prim = rtnl_dereference(in_dev->ifa_list);
+	last_prim = ifap;
 	if (in_dev->dead)
 		goto no_promotions;
 
@@ -372,7 +372,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
 		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
 			    ifa1->ifa_scope <= ifa->ifa_scope)
-				last_prim = ifa;
+				last_prim = &ifa->ifa_next;
 
 			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
 			    ifa1->ifa_mask != ifa->ifa_mask ||
@@ -436,9 +436,9 @@ static void __inet_del_ifa(struct in_device *in_dev,
 
 			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
 
-			last_sec = rtnl_dereference(last_prim->ifa_next);
+			last_sec = rtnl_dereference(*last_prim);
 			rcu_assign_pointer(promote->ifa_next, last_sec);
-			rcu_assign_pointer(last_prim->ifa_next, promote);
+			rcu_assign_pointer(*last_prim, promote);
 		}
 
 		promote->ifa_flags &= ~IFA_F_SECONDARY;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 4e94796ccdbd..ed20d6ac10dc 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -278,7 +278,8 @@ void fib_release_info(struct fib_info *fi)
 				hlist_del(&nexthop_nh->nh_hash);
 			} endfor_nexthops(fi)
 		}
-		fi->fib_dead = 1;
+		/* Paired with READ_ONCE() from fib_table_lookup() */
+		WRITE_ONCE(fi->fib_dead, 1);
 		fib_info_put(fi);
 	}
 	spin_unlock_bh(&fib_info_lock);
@@ -1599,6 +1600,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 link_it:
 	ofi = fib_find_info(fi);
 	if (ofi) {
+		/* fib_table_lookup() should not see @fi yet. */
 		fi->fib_dead = 1;
 		free_fib_info(fi);
 		ofi->fib_treeref++;
@@ -1637,6 +1639,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 failure:
 	if (fi) {
+		/* fib_table_lookup() should not see @fi yet. */
 		fi->fib_dead = 1;
 		free_fib_info(fi);
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index d11fb16234a6..456240d2adc1 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1534,7 +1534,8 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
 		}
 		if (fa->fa_tos && fa->fa_tos != flp->flowi4_tos)
 			continue;
-		if (fi->fib_dead)
+		/* Paired with WRITE_ONCE() in fib_release_info() */
+		if (READ_ONCE(fi->fib_dead))
 			continue;
 		if (fa->fa_info->fib_scope < flp->flowi4_scope)
 			continue;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index c71b863093ac..4cffdb9795de 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -353,8 +353,9 @@ static struct sk_buff *igmpv3_newpack(struct net_device *dev, unsigned int mtu)
 	struct flowi4 fl4;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	unsigned int size = mtu;
+	unsigned int size;
 
+	size = min(mtu, IP_MAX_MTU);
 	while (1) {
 		skb = alloc_skb(size + hlen + tlen,
 				GFP_ATOMIC | __GFP_NOWARN);
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index eccd7897e7aa..372579686162 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -566,7 +566,8 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
 					     struct sk_buff *skb, int rt_type)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
+	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	    IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 6fd04f2f8b40..a99c374101fc 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -223,7 +223,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 374647693d7a..3ddeb4fc0d08 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2066,6 +2066,7 @@ static int ip_mkroute_input(struct sk_buff *skb,
 		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
 		fib_select_multipath(res, h);
+		IPCB(skb)->flags |= IPSKB_MULTIPATH;
 	}
 #endif
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d6dfbb88dcf5..b8d2c45edbe0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -286,7 +286,7 @@ static void tcp_incr_quickack(struct sock *sk, unsigned int max_quickacks)
 		icsk->icsk_ack.quick = quickacks;
 }
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
+static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -294,7 +294,6 @@ void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 	inet_csk_exit_pingpong_mode(sk);
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
-EXPORT_SYMBOL(tcp_enter_quickack_mode);
 
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d2e07bb30164..5c7e10939dd9 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -437,6 +437,22 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 			  TCP_TIMEOUT_INIT << req->num_timeout, TCP_RTO_MAX);
 }
 
+static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
+				     const struct sk_buff *skb)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	const int timeout = TCP_RTO_MAX * 2;
+	u32 rcv_delta, rtx_delta;
+
+	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
+	if (rcv_delta <= timeout)
+		return false;
+
+	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
+
+	return rtx_delta > timeout;
+}
 
 /**
  *  tcp_retransmit_timer() - The TCP retransmit timeout handler
@@ -502,7 +518,7 @@ void tcp_retransmit_timer(struct sock *sk)
 					    tp->snd_una, tp->snd_nxt);
 		}
 #endif
-		if (tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX) {
+		if (tcp_rtx_probe0_timed_out(sk, skb)) {
 			tcp_write_err(sk);
 			goto out;
 		}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f0db66e415bd..913966e7703f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -443,14 +443,24 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(result, net, saddr, sport,
+						daddr, hnum, dif, sdif);
+
 		}
 	}
 	return result;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9b414681500a..0eafe26c05f7 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1359,7 +1359,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(long,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index c62e44224bf8..58b5ab5fcdbf 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -131,7 +131,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 788bb19f32e9..5385037209a6 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -189,14 +189,23 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 		score = compute_score(sk, net, saddr, sport,
 				      daddr, hnum, dif, sdif);
 		if (score > badness) {
-			result = lookup_reuseport(net, sk, skb,
-						  saddr, sport, daddr, hnum);
+			badness = score;
+			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+			if (!result) {
+				result = sk;
+				continue;
+			}
+
 			/* Fall back to scoring if group has connections */
-			if (result && !reuseport_has_conns(sk))
+			if (!reuseport_has_conns(sk))
 				return result;
 
-			result = result ? : sk;
-			badness = score;
+			/* Reuseport logic returned an error, keep original score. */
+			if (IS_ERR(result))
+				continue;
+
+			badness = compute_score(sk, net, saddr, sport,
+						daddr, hnum, dif, sdif);
 		}
 	}
 	return result;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 32b516ab9c47..39b3c7fbf9f6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1064,15 +1064,18 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 out_error:
 	kcm_push(kcm);
 
-	if (copied && sock->type == SOCK_SEQPACKET) {
+	if (sock->type == SOCK_SEQPACKET) {
 		/* Wrote some bytes before encountering an
 		 * error, return partial success.
 		 */
-		goto partial_message;
-	}
-
-	if (head != kcm->seq_skb)
+		if (copied)
+			goto partial_message;
+		if (head != kcm->seq_skb)
+			kfree_skb(head);
+	} else {
 		kfree_skb(head);
+		kcm->seq_skb = NULL;
+	}
 
 	err = sk_stream_error(sk, msg->msg_flags, err);
 
@@ -1982,6 +1985,8 @@ static __net_exit void kcm_exit_net(struct net *net)
 	 * that all multiplexors and psocks have been destroyed.
 	 */
 	WARN_ON(!list_empty(&knet->mux_list));
+
+	mutex_destroy(&knet->mutex);
 }
 
 static struct pernet_operations kcm_net_ops = {
diff --git a/net/netfilter/ipset/ip_set_hash_netportnet.c b/net/netfilter/ipset/ip_set_hash_netportnet.c
index 144346faffc1..b8ec2c414a5f 100644
--- a/net/netfilter/ipset/ip_set_hash_netportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
@@ -35,6 +35,7 @@ MODULE_ALIAS("ip_set_hash:net,port,net");
 #define IP_SET_HASH_WITH_PROTO
 #define IP_SET_HASH_WITH_NETS
 #define IPSET_NET_COUNT 2
+#define IP_SET_HASH_WITH_NET0
 
 /* IPv4 variant */
 
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 9dbaa5ce24e5..573a372e760f 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -316,6 +316,14 @@ static int nfnl_osf_add_callback(struct net *net, struct sock *ctnl,
 
 	f = nla_data(osf_attrs[OSF_ATTR_FINGER]);
 
+	if (f->opt_num > ARRAY_SIZE(f->opt))
+		return -EINVAL;
+
+	if (!memchr(f->genre, 0, MAXGENRELEN) ||
+	    !memchr(f->subtype, 0, MAXGENRELEN) ||
+	    !memchr(f->version, 0, MAXGENRELEN))
+		return -EINVAL;
+
 	kf = kmalloc(sizeof(struct nf_osf_finger), GFP_KERNEL);
 	if (!kf)
 		return -ENOMEM;
diff --git a/net/netfilter/xt_sctp.c b/net/netfilter/xt_sctp.c
index 680015ba7cb6..d4bf089c9e3f 100644
--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -150,6 +150,8 @@ static int sctp_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct xt_sctp_info *info = par->matchinfo;
 
+	if (info->flag_count > ARRAY_SIZE(info->flag_info))
+		return -EINVAL;
 	if (info->flags & ~XT_SCTP_VALID_FLAGS)
 		return -EINVAL;
 	if (info->invflags & ~XT_SCTP_VALID_FLAGS)
diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
index 177b40d08098..117d4615d668 100644
--- a/net/netfilter/xt_u32.c
+++ b/net/netfilter/xt_u32.c
@@ -96,11 +96,32 @@ static bool u32_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return ret ^ data->invert;
 }
 
+static int u32_mt_checkentry(const struct xt_mtchk_param *par)
+{
+	const struct xt_u32 *data = par->matchinfo;
+	const struct xt_u32_test *ct;
+	unsigned int i;
+
+	if (data->ntests > ARRAY_SIZE(data->tests))
+		return -EINVAL;
+
+	for (i = 0; i < data->ntests; ++i) {
+		ct = &data->tests[i];
+
+		if (ct->nnums > ARRAY_SIZE(ct->location) ||
+		    ct->nvalues > ARRAY_SIZE(ct->value))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct xt_match xt_u32_mt_reg __read_mostly = {
 	.name       = "u32",
 	.revision   = 0,
 	.family     = NFPROTO_UNSPEC,
 	.match      = u32_mt,
+	.checkentry = u32_mt_checkentry,
 	.matchsize  = sizeof(struct xt_u32),
 	.me         = THIS_MODULE,
 };
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 91b35b7c80d8..96059c99b915 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -857,7 +857,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **catmap,
 
 	offset -= iter->startbit;
 	idx = offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |= bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |= (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
 
 	return 0;
 }
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 5c04da4cfbad..24747163122b 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -660,6 +660,11 @@ static int nr_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_release;
 	}
 
+	if (sock->state == SS_CONNECTING) {
+		err = -EALREADY;
+		goto out_release;
+	}
+
 	sk->sk_state   = TCP_CLOSE;
 	sock->state = SS_UNCONNECTED;
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 4f6b5b6fba3e..a5b63158f081 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -61,6 +61,7 @@ struct fq_pie_sched_data {
 	struct pie_params p_params;
 	u32 ecn_prob;
 	u32 flows_cnt;
+	u32 flows_cursor;
 	u32 quantum;
 	u32 memory_limit;
 	u32 new_flow_count;
@@ -378,21 +379,31 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 static void fq_pie_timer(struct timer_list *t)
 {
 	struct fq_pie_sched_data *q = from_timer(q, t, adapt_timer);
+	unsigned long next, tupdate;
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock; /* to lock qdisc for probability calculations */
-	u32 idx;
+	int max_cnt, i;
 
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
-	for (idx = 0; idx < q->flows_cnt; idx++)
-		pie_calculate_probability(&q->p_params, &q->flows[idx].vars,
-					  q->flows[idx].backlog);
-
-	/* reset the timer to fire after 'tupdate' jiffies. */
-	if (q->p_params.tupdate)
-		mod_timer(&q->adapt_timer, jiffies + q->p_params.tupdate);
+	/* Limit this expensive loop to 2048 flows per round. */
+	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 2048);
+	for (i = 0; i < max_cnt; i++) {
+		pie_calculate_probability(&q->p_params,
+					  &q->flows[q->flows_cursor].vars,
+					  q->flows[q->flows_cursor].backlog);
+		q->flows_cursor++;
+	}
 
+	tupdate = q->p_params.tupdate;
+	next = 0;
+	if (q->flows_cursor >= q->flows_cnt) {
+		q->flows_cursor = 0;
+		next = tupdate;
+	}
+	if (tupdate)
+		mod_timer(&q->adapt_timer, jiffies + next);
 	spin_unlock(root_lock);
 }
 
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index cdc43a06aa9b..6076294a632c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1012,6 +1012,10 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (parent == NULL)
 			return -ENOENT;
 	}
+	if (!(parent->cl_flags & HFSC_FSC) && parent != &q->root) {
+		NL_SET_ERR_MSG(extack, "Invalid parent - parent class must have FSC");
+		return -EINVAL;
+	}
 
 	if (classid == 0 || TC_H_MAJ(classid ^ sch->handle) != 0)
 		return -EINVAL;
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index cbc2ebca4548..339990bb5981 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -210,7 +210,7 @@ static struct Qdisc_ops plug_qdisc_ops __read_mostly = {
 	.priv_size   =       sizeof(struct plug_sched_data),
 	.enqueue     =       plug_enqueue,
 	.dequeue     =       plug_dequeue,
-	.peek        =       qdisc_peek_head,
+	.peek        =       qdisc_peek_dequeued,
 	.init        =       plug_init,
 	.change      =       plug_change,
 	.reset       =	     qdisc_reset_queue,
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index d5a1e4b237b1..ebf9f473c939 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -979,10 +979,13 @@ static void qfq_update_eligible(struct qfq_sched *q)
 }
 
 /* Dequeue head packet of the head class in the DRR queue of the aggregate. */
-static void agg_dequeue(struct qfq_aggregate *agg,
-			struct qfq_class *cl, unsigned int len)
+static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
+				   struct qfq_class *cl, unsigned int len)
 {
-	qdisc_dequeue_peeked(cl->qdisc);
+	struct sk_buff *skb = qdisc_dequeue_peeked(cl->qdisc);
+
+	if (!skb)
+		return NULL;
 
 	cl->deficit -= (int) len;
 
@@ -992,6 +995,8 @@ static void agg_dequeue(struct qfq_aggregate *agg,
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
 	}
+
+	return skb;
 }
 
 static inline struct sk_buff *qfq_peek_skb(struct qfq_aggregate *agg,
@@ -1137,11 +1142,18 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 	if (!skb)
 		return NULL;
 
-	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
+
+	skb = agg_dequeue(in_serv_agg, cl, len);
+
+	if (!skb) {
+		sch->q.qlen++;
+		return NULL;
+	}
+
+	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
 
-	agg_dequeue(in_serv_agg, cl, len);
 	/* If lmax is lowered, through qfq_change_class, for a class
 	 * owning pending packets with larger size than the new value
 	 * of lmax, then the following condition may hold.
diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 982a87b3e11f..963b94517ec2 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -284,7 +284,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq, void *v)
 		assoc->init_retries, assoc->shutdown_retries,
 		assoc->rtx_data_chunks,
 		refcount_read(&sk->sk_wmem_alloc),
-		sk->sk_wmem_queued,
+		READ_ONCE(sk->sk_wmem_queued),
 		sk->sk_sndbuf,
 		sk->sk_rcvbuf);
 	seq_printf(seq, "\n");
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index d4e5969771f0..30e991452633 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1241,7 +1241,10 @@ static int sctp_side_effects(enum sctp_event_type event_type,
 	default:
 		pr_err("impossible disposition %d in state %d, event_type %d, event_id %d\n",
 		       status, state, event_type, subtype.chunk);
-		BUG();
+		error = status;
+		if (error >= 0)
+			error = -EINVAL;
+		WARN_ON_ONCE(1);
 		break;
 	}
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index fa4d31b507f2..68d53e3f0d07 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -68,7 +68,7 @@
 #include <net/sctp/stream_sched.h>
 
 /* Forward declarations for internal helper functions. */
-static bool sctp_writeable(struct sock *sk);
+static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
 static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 				size_t msg_len);
@@ -138,7 +138,7 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
 	refcount_add(sizeof(struct sctp_chunk), &sk->sk_wmem_alloc);
 	asoc->sndbuf_used += chunk->skb->truesize + sizeof(struct sctp_chunk);
-	sk->sk_wmem_queued += chunk->skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, chunk->skb->truesize + sizeof(struct sctp_chunk));
 	sk_mem_charge(sk, chunk->skb->truesize);
 }
 
@@ -8900,7 +8900,7 @@ static void sctp_wfree(struct sk_buff *skb)
 	struct sock *sk = asoc->base.sk;
 
 	sk_mem_uncharge(sk, skb->truesize);
-	sk->sk_wmem_queued -= skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, -(skb->truesize + sizeof(struct sctp_chunk)));
 	asoc->sndbuf_used -= skb->truesize + sizeof(struct sctp_chunk);
 	WARN_ON(refcount_sub_and_test(sizeof(struct sctp_chunk),
 				      &sk->sk_wmem_alloc));
@@ -9055,9 +9055,9 @@ void sctp_write_space(struct sock *sk)
  * UDP-style sockets or TCP-style sockets, this code should work.
  *  - Daisy
  */
-static bool sctp_writeable(struct sock *sk)
+static bool sctp_writeable(const struct sock *sk)
 {
-	return sk->sk_sndbuf > sk->sk_wmem_queued;
+	return READ_ONCE(sk->sk_sndbuf) > READ_ONCE(sk->sk_wmem_queued);
 }
 
 /* Wait for an association to go into ESTABLISHED state. If timeout is 0,
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index e84241ff4ac4..ab9ecdd1af0a 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1101,6 +1101,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr, *n;
 
+	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
 		struct smc_link *link;
 
@@ -1115,6 +1116,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 		if (link)
 			smc_llc_add_link_local(link);
 	}
+	spin_unlock_bh(&smc_lgr_list.lock);
 }
 
 /* link is down - switch connections to alternate link,
diff --git a/net/socket.c b/net/socket.c
index f2172b756c0f..1a4033511703 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3467,7 +3467,11 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return sock->ops->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->connect(sock, (struct sockaddr *)&address, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index ac7feadb4390..50eae668578a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -810,7 +810,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	psock = sk_psock_get(sk);
 	if (!psock || !policy) {
 		err = tls_push_record(sk, flags, record_type);
-		if (err && sk->sk_err == EBADMSG) {
+		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
 			err = -sk->sk_err;
@@ -839,7 +839,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
-		if (err && sk->sk_err == EBADMSG) {
+		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
 			err = -sk->sk_err;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8d941cbba5cb..237488b1b58b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -587,7 +587,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	 *	  What the above comment does talk about? --ANK(980817)
 	 */
 
-	if (unix_tot_inflight)
+	if (READ_ONCE(unix_tot_inflight))
 		unix_gc();		/* Garbage collect fds */
 }
 
diff --git a/net/unix/scm.c b/net/unix/scm.c
index aa27a02478dc..e8e2a00bb0f5 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -63,7 +63,7 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
-	user->unix_inflight++;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -84,7 +84,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
-	user->unix_inflight--;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -98,7 +98,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
 {
 	struct user_struct *user = current_user();
 
-	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
 		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 	return false;
 }
diff --git a/samples/bpf/tracex6_kern.c b/samples/bpf/tracex6_kern.c
index acad5712d8b4..fd602c2774b8 100644
--- a/samples/bpf/tracex6_kern.c
+++ b/samples/bpf/tracex6_kern.c
@@ -2,6 +2,8 @@
 #include <linux/version.h>
 #include <uapi/linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -45,13 +47,24 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kprobe/htab_map_lookup_elem")
-int bpf_prog2(struct pt_regs *ctx)
+/*
+ * Since *_map_lookup_elem can't be expected to trigger bpf programs
+ * due to potential deadlocks (bpf_disable_instrumentation), this bpf
+ * program will be attached to bpf_map_copy_value (which is called
+ * from map_lookup_elem) and will only filter the hashtable type.
+ */
+SEC("kprobe/bpf_map_copy_value")
+int BPF_KPROBE(bpf_prog2, struct bpf_map *map)
 {
 	u32 key = bpf_get_smp_processor_id();
 	struct bpf_perf_event_value *val, buf;
+	enum bpf_map_type type;
 	int error;
 
+	type = BPF_CORE_READ(map, map_type);
+	if (type != BPF_MAP_TYPE_HASH)
+		return 0;
+
 	error = bpf_perf_event_read_value(&counters, key, &buf, sizeof(buf));
 	if (error)
 		return 0;
diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 748da578b418..d1f5bcff4b62 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -396,6 +396,9 @@ static char *eval_clause(const char *str, size_t len, int argc, char *argv[])
 
 		p++;
 	}
+
+	if (new_argc >= FUNCTION_MAX_ARGS)
+		pperror("too many function arguments");
 	new_argv[new_argc++] = prev;
 
 	/*
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 0a5ae1e8da47..05b8f5bcc37a 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -248,18 +248,6 @@ config IMA_APPRAISE_MODSIG
 	   The modsig keyword can be used in the IMA policy to allow a hook
 	   to accept such signatures.
 
-config IMA_TRUSTED_KEYRING
-	bool "Require all keys on the .ima keyring be signed (deprecated)"
-	depends on IMA_APPRAISE && SYSTEM_TRUSTED_KEYRING
-	depends on INTEGRITY_ASYMMETRIC_KEYS
-	select INTEGRITY_TRUSTED_KEYRING
-	default y
-	help
-	   This option requires that all keys added to the .ima
-	   keyring be signed by a key on the system trusted keyring.
-
-	   This option is deprecated in favor of INTEGRITY_TRUSTED_KEYRING
-
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	bool "Permit keys validly signed by a built-in or secondary CA cert (EXPERIMENTAL)"
 	depends on SYSTEM_TRUSTED_KEYRING
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 61a614c21b9b..e3ffaf5ad639 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	ret = -EACCES;
 	down_write(&key->sem);
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	{
+		bool is_privileged_op = false;
+
 		/* only the sysadmin can chown a key to some other UID */
 		if (user != (uid_t) -1 && !uid_eq(key->uid, uid))
-			goto error_put;
+			is_privileged_op = true;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (group != (gid_t) -1 && !gid_eq(gid, key->gid) && !in_group_p(gid))
+			is_privileged_op = true;
+
+		if (is_privileged_op && !capable(CAP_SYS_ADMIN))
 			goto error_put;
 	}
 
@@ -1088,7 +1093,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		notify_key(key, NOTIFY_KEY_SETATTR, 0);
 		ret = 0;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 3eabcc469669..8403c91a6b29 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -895,7 +895,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &catlen);
-	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
+	if (ret != 1 || catlen < 0 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;
 
 	if (format == SMK_FIXED24_FMT &&
diff --git a/sound/Kconfig b/sound/Kconfig
index 36785410fbe1..aaf2022ffc57 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM || UML
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index a226d8f24028..fd644a31c824 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -252,10 +252,14 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
 		goto error;
 	}
 
-	if (refine)
+	if (refine) {
 		err = snd_pcm_hw_refine(substream, data);
-	else
+		if (err < 0)
+			goto error;
+		err = fixup_unreferenced_params(substream, data);
+	} else {
 		err = snd_pcm_hw_params(substream, data);
+	}
 	if (err < 0)
 		goto error;
 	if (copy_to_user(data32, data, sizeof(*data32)) ||
diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index f73ee0798aea..be80ce72e0c7 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -37,6 +37,7 @@ struct seq_oss_midi {
 	struct snd_midi_event *coder;	/* MIDI event coder */
 	struct seq_oss_devinfo *devinfo;	/* assigned OSSseq device */
 	snd_use_lock_t use_lock;
+	struct mutex open_mutex;
 };
 
 
@@ -171,6 +172,7 @@ snd_seq_oss_midi_check_new_port(struct snd_seq_port_info *pinfo)
 	mdev->flags = pinfo->capability;
 	mdev->opened = 0;
 	snd_use_lock_init(&mdev->use_lock);
+	mutex_init(&mdev->open_mutex);
 
 	/* copy and truncate the name of synth device */
 	strlcpy(mdev->name, pinfo->name, sizeof(mdev->name));
@@ -319,14 +321,16 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 	int perm;
 	struct seq_oss_midi *mdev;
 	struct snd_seq_port_subscribe subs;
+	int err;
 
 	if ((mdev = get_mididev(dp, dev)) == NULL)
 		return -ENODEV;
 
+	mutex_lock(&mdev->open_mutex);
 	/* already used? */
 	if (mdev->opened && mdev->devinfo != dp) {
-		snd_use_lock_free(&mdev->use_lock);
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 
 	perm = 0;
@@ -336,14 +340,14 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 		perm |= PERM_READ;
 	perm &= mdev->flags;
 	if (perm == 0) {
-		snd_use_lock_free(&mdev->use_lock);
-		return -ENXIO;
+		err = -ENXIO;
+		goto unlock;
 	}
 
 	/* already opened? */
 	if ((mdev->opened & perm) == perm) {
-		snd_use_lock_free(&mdev->use_lock);
-		return 0;
+		err = 0;
+		goto unlock;
 	}
 
 	perm &= ~mdev->opened;
@@ -368,13 +372,17 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 	}
 
 	if (! mdev->opened) {
-		snd_use_lock_free(&mdev->use_lock);
-		return -ENXIO;
+		err = -ENXIO;
+		goto unlock;
 	}
 
 	mdev->devinfo = dp;
+	err = 0;
+
+ unlock:
+	mutex_unlock(&mdev->open_mutex);
 	snd_use_lock_free(&mdev->use_lock);
-	return 0;
+	return err;
 }
 
 /*
@@ -388,10 +396,9 @@ snd_seq_oss_midi_close(struct seq_oss_devinfo *dp, int dev)
 
 	if ((mdev = get_mididev(dp, dev)) == NULL)
 		return -ENODEV;
-	if (! mdev->opened || mdev->devinfo != dp) {
-		snd_use_lock_free(&mdev->use_lock);
-		return 0;
-	}
+	mutex_lock(&mdev->open_mutex);
+	if (!mdev->opened || mdev->devinfo != dp)
+		goto unlock;
 
 	memset(&subs, 0, sizeof(subs));
 	if (mdev->opened & PERM_WRITE) {
@@ -410,6 +417,8 @@ snd_seq_oss_midi_close(struct seq_oss_devinfo *dp, int dev)
 	mdev->opened = 0;
 	mdev->devinfo = NULL;
 
+ unlock:
+	mutex_unlock(&mdev->open_mutex);
 	snd_use_lock_free(&mdev->use_lock);
 	return 0;
 }
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index e18572eae5e0..d894dcdf38f4 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2007,10 +2007,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
 		.dev_disconnect =	snd_ac97_dev_disconnect,
 	};
 
-	if (!rac97)
-		return -EINVAL;
-	if (snd_BUG_ON(!bus || !template))
+	if (snd_BUG_ON(!bus || !template || !rac97))
 		return -EINVAL;
+	*rac97 = NULL;
 	if (snd_BUG_ON(template->num >= 4))
 		return -EINVAL;
 	if (bus->codec[template->num])
diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index d870f56c44cf..0341b3119767 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -163,11 +163,14 @@ struct atmel_i2s_gck_param {
 
 #define I2S_MCK_12M288		12288000UL
 #define I2S_MCK_11M2896		11289600UL
+#define I2S_MCK_6M144		6144000UL
 
 /* mck = (32 * (imckfs+1) / (imckdiv+1)) * fs */
 static const struct atmel_i2s_gck_param gck_params[] = {
+	/* mck = 6.144Mhz */
+	{  8000, I2S_MCK_6M144,  1, 47},	/* mck =  768 fs */
+
 	/* mck = 12.288MHz */
-	{  8000, I2S_MCK_12M288, 0, 47},	/* mck = 1536 fs */
 	{ 16000, I2S_MCK_12M288, 1, 47},	/* mck =  768 fs */
 	{ 24000, I2S_MCK_12M288, 3, 63},	/* mck =  512 fs */
 	{ 32000, I2S_MCK_12M288, 3, 47},	/* mck =  384 fs */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f1c9e563994b..04a7070c78e2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1295,6 +1295,7 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 48081d71c22c..b316d613a709 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -347,11 +347,15 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void *data)
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	u8 events[DA7219_AAD_IRQ_REG_MAX];
 	u8 statusa;
-	int i, report = 0, mask = 0;
+	int i, ret, report = 0, mask = 0;
 
 	/* Read current IRQ events */
-	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
-			 events, DA7219_AAD_IRQ_REG_MAX);
+	ret = regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
+			       events, DA7219_AAD_IRQ_REG_MAX);
+	if (ret) {
+		dev_warn_ratelimited(component->dev, "Failed to read IRQ events: %d\n", ret);
+		return IRQ_NONE;
+	}
 
 	if (!events[DA7219_AAD_IRQ_REG_A] && !events[DA7219_AAD_IRQ_REG_B])
 		return IRQ_NONE;
@@ -854,6 +858,8 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 			}
 		}
 	}
+
+	synchronize_irq(da7219_aad->irq);
 }
 
 void da7219_aad_resume(struct snd_soc_component *component)
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 03ad34a275da..dafbf73d4eed 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -153,7 +153,7 @@ static const char * const es8316_dmic_txt[] = {
 		"dmic data at high level",
 		"dmic data at low level",
 };
-static const unsigned int es8316_dmic_values[] = { 0, 1, 2 };
+static const unsigned int es8316_dmic_values[] = { 0, 2, 3 };
 static const struct soc_enum es8316_dmic_src_enum =
 	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC, 0, 3,
 			      ARRAY_SIZE(es8316_dmic_txt),
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 2fb6b1edf933..1e9109a95e6e 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -413,9 +413,11 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 		usleep_range(30000, 30005);
 		loop--;
 	}
+
 	if (val != DEVICE_ID) {
 		dev_err(dev, "Device with ID register %x is not rt5682\n", val);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_nodev;
 	}
 
 	rt5682_calibrate(rt5682);
@@ -486,10 +488,11 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 	rt5682->hw_init = true;
 	rt5682->first_hw_init = true;
 
+err_nodev:
 	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
-	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
+	dev_dbg(&slave->dev, "%s hw_init complete: %d\n", __func__, ret);
 
 	return ret;
 }
diff --git a/tools/bpf/bpftool/skeleton/profiler.bpf.c b/tools/bpf/bpftool/skeleton/profiler.bpf.c
index ce5b65e07ab1..2f80edc682f1 100644
--- a/tools/bpf/bpftool/skeleton/profiler.bpf.c
+++ b/tools/bpf/bpftool/skeleton/profiler.bpf.c
@@ -4,6 +4,12 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+struct bpf_perf_event_value___local {
+	__u64 counter;
+	__u64 enabled;
+	__u64 running;
+} __attribute__((preserve_access_index));
+
 /* map of perf event fds, num_cpu * num_metric entries */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
@@ -15,14 +21,14 @@ struct {
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
 } fentry_readings SEC(".maps");
 
 /* accumulated readings */
 struct {
 	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
 	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(value_size, sizeof(struct bpf_perf_event_value___local));
 } accum_readings SEC(".maps");
 
 /* sample counts, one per cpu */
@@ -39,7 +45,7 @@ const volatile __u32 num_metric = 1;
 SEC("fentry/XXX")
 int BPF_PROG(fentry_XXX)
 {
-	struct bpf_perf_event_value *ptrs[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local *ptrs[MAX_NUM_MATRICS];
 	u32 key = bpf_get_smp_processor_id();
 	u32 i;
 
@@ -53,10 +59,10 @@ int BPF_PROG(fentry_XXX)
 	}
 
 	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
-		struct bpf_perf_event_value reading;
+		struct bpf_perf_event_value___local reading;
 		int err;
 
-		err = bpf_perf_event_read_value(&events, key, &reading,
+		err = bpf_perf_event_read_value(&events, key, (void *)&reading,
 						sizeof(reading));
 		if (err)
 			return 0;
@@ -68,14 +74,14 @@ int BPF_PROG(fentry_XXX)
 }
 
 static inline void
-fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
+fexit_update_maps(u32 id, struct bpf_perf_event_value___local *after)
 {
-	struct bpf_perf_event_value *before, diff;
+	struct bpf_perf_event_value___local *before, diff;
 
 	before = bpf_map_lookup_elem(&fentry_readings, &id);
 	/* only account samples with a valid fentry_reading */
 	if (before && before->counter) {
-		struct bpf_perf_event_value *accum;
+		struct bpf_perf_event_value___local *accum;
 
 		diff.counter = after->counter - before->counter;
 		diff.enabled = after->enabled - before->enabled;
@@ -93,7 +99,7 @@ fexit_update_maps(u32 id, struct bpf_perf_event_value *after)
 SEC("fexit/XXX")
 int BPF_PROG(fexit_XXX)
 {
-	struct bpf_perf_event_value readings[MAX_NUM_MATRICS];
+	struct bpf_perf_event_value___local readings[MAX_NUM_MATRICS];
 	u32 cpu = bpf_get_smp_processor_id();
 	u32 i, zero = 0;
 	int err;
@@ -102,7 +108,8 @@ int BPF_PROG(fexit_XXX)
 	/* read all events before updating the maps, to reduce error */
 	for (i = 0; i < num_metric && i < MAX_NUM_MATRICS; i++) {
 		err = bpf_perf_event_read_value(&events, cpu + i * num_cpu,
-						readings + i, sizeof(*readings));
+						(void *)(readings + i),
+						sizeof(*readings));
 		if (err)
 			return 0;
 	}
diff --git a/tools/hv/vmbus_testing b/tools/hv/vmbus_testing
index e7212903dd1d..4467979d8f69 100755
--- a/tools/hv/vmbus_testing
+++ b/tools/hv/vmbus_testing
@@ -164,7 +164,7 @@ def recursive_file_lookup(path, file_map):
 def get_all_devices_test_status(file_map):
 
         for device in file_map:
-                if (get_test_state(locate_state(device, file_map)) is 1):
+                if (get_test_state(locate_state(device, file_map)) == 1):
                         print("Testing = ON for: {}"
                               .format(device.split("/")[5]))
                 else:
@@ -203,7 +203,7 @@ def write_test_files(path, value):
 def set_test_state(state_path, state_value, quiet):
 
         write_test_files(state_path, state_value)
-        if (get_test_state(state_path) is 1):
+        if (get_test_state(state_path) == 1):
                 if (not quiet):
                         print("Testing = ON for device: {}"
                               .format(state_path.split("/")[5]))
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7c64134472c7..ee30372f7713 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1743,6 +1743,7 @@ int cmd_top(int argc, const char **argv)
 	top.session = perf_session__new(NULL, false, NULL);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
+		top.session = NULL;
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b0e1880cf992..f2586e46d53e 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -407,11 +407,6 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
 
-static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
-{
-	return browser->he_selection ? browser->he_selection->unfolded : false;
-}
-
 static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -584,8 +579,8 @@ static int hierarchy_set_folding(struct hist_browser *hb, struct hist_entry *he,
 	return n;
 }
 
-static void __hist_entry__set_folding(struct hist_entry *he,
-				      struct hist_browser *hb, bool unfold)
+static void hist_entry__set_folding(struct hist_entry *he,
+				    struct hist_browser *hb, bool unfold)
 {
 	hist_entry__init_have_children(he);
 	he->unfolded = unfold ? he->has_children : false;
@@ -603,34 +598,12 @@ static void __hist_entry__set_folding(struct hist_entry *he,
 		he->nr_rows = 0;
 }
 
-static void hist_entry__set_folding(struct hist_entry *he,
-				    struct hist_browser *browser, bool unfold)
-{
-	double percent;
-
-	percent = hist_entry__get_percent_limit(he);
-	if (he->filtered || percent < browser->min_pcnt)
-		return;
-
-	__hist_entry__set_folding(he, browser, unfold);
-
-	if (!he->depth || unfold)
-		browser->nr_hierarchy_entries++;
-	if (he->leaf)
-		browser->nr_callchain_rows += he->nr_rows;
-	else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
-		browser->nr_hierarchy_entries++;
-		he->has_no_entry = true;
-		he->nr_rows = 1;
-	} else
-		he->has_no_entry = false;
-}
-
 static void
 __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 {
 	struct rb_node *nd;
 	struct hist_entry *he;
+	double percent;
 
 	nd = rb_first_cached(&browser->hists->entries);
 	while (nd) {
@@ -640,6 +613,21 @@ __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 		nd = __rb_hierarchy_next(nd, HMD_FORCE_CHILD);
 
 		hist_entry__set_folding(he, browser, unfold);
+
+		percent = hist_entry__get_percent_limit(he);
+		if (he->filtered || percent < browser->min_pcnt)
+			continue;
+
+		if (!he->depth || unfold)
+			browser->nr_hierarchy_entries++;
+		if (he->leaf)
+			browser->nr_callchain_rows += he->nr_rows;
+		else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
+			browser->nr_hierarchy_entries++;
+			he->has_no_entry = true;
+			he->nr_rows = 1;
+		} else
+			he->has_no_entry = false;
 	}
 }
 
@@ -659,8 +647,10 @@ static void hist_browser__set_folding_selected(struct hist_browser *browser, boo
 	if (!browser->he_selection)
 		return;
 
-	hist_entry__set_folding(browser->he_selection, browser, unfold);
-	browser->b.nr_entries = hist_browser__nr_entries(browser);
+	if (unfold == browser->he_selection->unfolded)
+		return;
+
+	hist_browser__toggle_fold(browser);
 }
 
 static void ui_browser__warn_lost_events(struct ui_browser *browser)
@@ -731,8 +721,8 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 		hist_browser__set_folding(browser, true);
 		break;
 	case 'e':
-		/* Expand the selected entry. */
-		hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
+		/* Toggle expand/collapse the selected entry. */
+		hist_browser__toggle_fold(browser);
 		break;
 	case 'H':
 		browser->show_headers = !browser->show_headers;
@@ -1778,7 +1768,7 @@ static void hists_browser__hierarchy_headers(struct hist_browser *browser)
 	hists_browser__scnprintf_hierarchy_headers(browser, headers,
 						   sizeof(headers));
 
-	ui_browser__gotorc(&browser->b, 0, 0);
+	ui_browser__gotorc_title(&browser->b, 0, 0);
 	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 308189454788..c9078cee6be0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1718,8 +1718,11 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 	perf_exe(tpath, sizeof(tpath));
 
 	bfdf = bfd_openr(tpath, NULL);
-	assert(bfdf);
-	assert(bfd_check_format(bfdf, bfd_object));
+	if (bfdf == NULL)
+		abort();
+
+	if (!bfd_check_format(bfdf, bfd_object))
+		abort();
 
 	s = open_memstream(&buf, &buf_size);
 	if (!s) {
@@ -1767,7 +1770,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 #else
 	disassemble = disassembler(bfdf);
 #endif
-	assert(disassemble);
+	if (disassemble == NULL)
+		abort();
 
 	fflush(s);
 	do {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index be850e9f8852..dd06770b43f1 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3987,7 +3987,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
 {
-	u32 i, ids, n_ids;
+	u32 i, n_ids;
+	u64 *ids;
 	struct evsel *evsel;
 	struct evlist *evlist = *pevlist;
 
@@ -4003,9 +4004,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 
 	evlist__add(evlist, evsel);
 
-	ids = event->header.size;
-	ids -= (void *)&event->attr.id - (void *)event;
-	n_ids = ids / sizeof(u64);
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids = n_ids / sizeof(u64);
 	/*
 	 * We don't have the cpu and thread maps on the header, so
 	 * for allocating the perf_sample_id table we fake 1 cpu and
@@ -4014,8 +4014,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
+	ids = (void *)&event->attr.attr + event->attr.attr.size;
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
index 16f774b1cdbe..7b281dbe4165 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in base kprobe kretprobe rawtp fentry fexit fmodret
+for i in base kprobe kretprobe rawtp fentry fexit
 do
 	summary=$(sudo ./bench -w2 -d5 -a rename-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-10s: %s\n" $i "$summary"
diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.h b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
index 76eab0aacba0..233b089d1fba 100644
--- a/tools/testing/selftests/bpf/progs/test_cls_redirect.h
+++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.h
@@ -12,6 +12,15 @@
 #include <linux/ipv6.h>
 #include <linux/udp.h>
 
+/* offsetof() is used in static asserts, and the libbpf-redefined CO-RE
+ * friendly version breaks compilation for older clang versions <= 15
+ * when invoked in a static assert.  Restore original here.
+ */
+#ifdef offsetof
+#undef offsetof
+#define offsetof(type, member) __builtin_offsetof(type, member)
+#endif
+
 struct gre_base_hdr {
 	uint16_t flags;
 	uint16_t protocol;
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index cc9c846585f0..83616f0779a7 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,9 +33,10 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
+		/usr/bin/timeout --foreground "$kselftest_timeout" \
+			/usr/bin/timeout "$kselftest_timeout" $1
 	else
-		"$1"
+		$1
 	fi
 }
 
@@ -65,17 +66,25 @@ run_one()
 
 	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
 	echo "# $TEST_HDR_MSG"
-	if [ ! -x "$TEST" ]; then
-		echo -n "# Warning: file $TEST is "
-		if [ ! -e "$TEST" ]; then
-			echo "missing!"
-		else
-			echo "not executable, correct this."
-		fi
+	if [ ! -e "$TEST" ]; then
+		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
+		cmd="./$BASENAME_TEST"
+		if [ ! -x "$TEST" ]; then
+			echo "# Warning: file $TEST is not executable"
+
+			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
+			then
+				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
+				cmd="$interpreter ./$BASENAME_TEST"
+			else
+				echo "not ok $test_num $TEST_HDR_MSG"
+				return
+			fi
+		fi
 		cd `dirname $TEST` > /dev/null
-		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
+		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
 			tap_prefix >&4) 3>&1) |
 			(read xs; exit $xs)) 4>>"$logfile" &&
 		echo "ok $test_num $TEST_HDR_MSG") ||
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 3e7b2e521cde..2fadc99d9361 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -910,7 +910,11 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
-		if (t->termsig != -1) {
+		if (WEXITSTATUS(status) == 255) {
+			/* SKIP */
+			t->passed = 1;
+			t->skip = 1;
+		} else if (t->termsig != -1) {
 			t->passed = 0;
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test exited normally instead of by signal (code: %d)\n",
@@ -922,11 +926,6 @@ void __wait_for_test(struct __test_metadata *t)
 			case 0:
 				t->passed = 1;
 				break;
-			/* SKIP */
-			case 255:
-				t->passed = 1;
-				t->skip = 1;
-				break;
 			/* Other failure, assume step report. */
 			default:
 				t->passed = 0;
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 5922cc1b0386..b3c0e858c4e0 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -89,21 +89,19 @@ static int reset_enable_llc_perf(pid_t pid, int cpu_no)
 static int get_llc_perf(unsigned long *llc_perf_miss)
 {
 	__u64 total_misses;
+	int ret;
 
 	/* Stop counters after one span to get miss rate */
 
 	ioctl(fd_lm, PERF_EVENT_IOC_DISABLE, 0);
 
-	if (read(fd_lm, &rf_cqm, sizeof(struct read_format)) == -1) {
+	ret = read(fd_lm, &rf_cqm, sizeof(struct read_format));
+	if (ret == -1) {
 		perror("Could not get llc misses through perf");
-
 		return -1;
 	}
 
 	total_misses = rf_cqm.values[0].value;
-
-	close(fd_lm);
-
 	*llc_perf_miss = total_misses;
 
 	return 0;
@@ -256,17 +254,23 @@ int cat_val(struct resctrl_val_param *param)
 					 memflush, operation, resctrl_val)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
-				break;
+				goto pe_close;
 			}
 
 			sleep(1);
 			ret = measure_cache_vals(param, bm_pid);
 			if (ret)
-				break;
+				goto pe_close;
+
+			close(fd_lm);
 		} else {
 			break;
 		}
 	}
 
 	return ret;
+
+pe_close:
+	close(fd_lm);
+	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index c20d0a7ecbe6..ab1d91328d67 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -184,12 +184,13 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	else
 		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
 
+	free(startptr);
+
 	if (ret) {
 		printf("\n Error in fill cache read/write...\n");
 		return -1;
 	}
 
-	free(startptr);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 36da6136af96..c38f2d58df92 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -33,6 +33,7 @@
 	do {					\
 		perror(err_msg);		\
 		kill(ppid, SIGKILL);		\
+		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
