Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7B7A6034
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjISKxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjISKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:52:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD0AF1;
        Tue, 19 Sep 2023 03:51:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F77BC433C8;
        Tue, 19 Sep 2023 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695120691;
        bh=965aForhvOWActOsUpAYJhav2QYTTIvae5q7cJ7mOiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vl98kCJMkZIZDKzzEGfQ4Ip8XrkZQVuz7hMKPf3Q7RBRuXNxtLhGdaYji8arnC2lh
         2wBE4rkN+yyQsYxN3elI1MXakOML7aTxmHfxZAYQFQgF+21bMWjCcEKW7YPSOaMIvC
         ye5j/wIn7Uqv9u6m+gtKM+Z70QfYIdDXkxaHiv8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.132
Date:   Tue, 19 Sep 2023 12:51:21 +0200
Message-ID: <2023091920-unwashed-outback-573a@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023091920-ducktail-desolate-594b@gregkh>
References: <2023091920-ducktail-desolate-594b@gregkh>
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
index 63ddea2b9640..7c06e7fb9a31 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -1190,11 +1190,11 @@ Members of interest:
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
index 1f537b7286b5..b2ff07a0176b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 131
+SUBLEVEL = 132
 EXTRAVERSION =
 NAME = Trick or Treat
 
@@ -1835,7 +1835,9 @@ quiet_cmd_depmod = DEPMOD  $(MODLIB)
 
 modules_install:
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
+ifndef modules_sign_only
 	$(call cmd,depmod)
+endif
 
 else # CONFIG_MODULES
 
diff --git a/arch/arc/include/asm/atomic-llsc.h b/arch/arc/include/asm/atomic-llsc.h
index 088d348781c1..0b7c902c72ba 100644
--- a/arch/arc/include/asm/atomic-llsc.h
+++ b/arch/arc/include/asm/atomic-llsc.h
@@ -18,7 +18,7 @@ static inline void arch_atomic_##op(int i, atomic_t *v)			\
 	: [val]	"=&r"	(val) /* Early clobber to prevent reg reuse */	\
 	: [ctr]	"r"	(&v->counter), /* Not "m": llock only supports reg direct addr mode */	\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
@@ -34,7 +34,7 @@ static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 	: [val]	"=&r"	(val)						\
 	: [ctr]	"r"	(&v->counter),					\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 									\
 	return val;							\
 }
@@ -56,7 +56,7 @@ static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 	  [orig] "=&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 									\
 	return orig;							\
 }
diff --git a/arch/arc/include/asm/atomic64-arcv2.h b/arch/arc/include/asm/atomic64-arcv2.h
index c5a8010fdc97..9089f34baac3 100644
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -60,7 +60,7 @@ static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
 	"	bnz     1b		\n"				\
 	: "=&r"(val)							\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");							\
+	: "cc", "memory");						\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
@@ -77,7 +77,7 @@ static inline s64 arch_atomic64_##op##_return_relaxed(s64 a, atomic64_t *v)	\
 	"	bnz     1b		\n"				\
 	: [val] "=&r"(val)						\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
+	: "cc", "memory");						\
 									\
 	return val;							\
 }
@@ -99,7 +99,7 @@ static inline s64 arch_atomic64_fetch_##op##_relaxed(s64 a, atomic64_t *v)	\
 	"	bnz     1b		\n"				\
 	: "=&r"(orig), "=&r"(val)					\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
+	: "cc", "memory");						\
 									\
 	return orig;							\
 }
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
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 51546fccc616..933b6a380c36 100644
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
index 5f5d9b135736..93880bdbcad9 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -200,8 +200,8 @@ lcd@0 {
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
index fdcca82c9986..bd8ea2ec2457 100644
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
index 84d0176d5193..10eab221bc05 100644
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
index 948d2a543f8d..c85866e73a7b 100644
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
index 8e41c8b7bd70..d650f54c3fc6 100644
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
index a969f335b240..2560f8514ebe 100644
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
index 01cfcbe5928e..b3ab0c000d9d 100644
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
index 2cf3909cca2f..ca1bea42cc0e 100644
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
index 8520ffc1779b..8b6327e64819 100644
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
@@ -930,7 +930,7 @@ dcic2: dcic@20e8000 {
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
index 3e779fd0a396..7a3d85e7a5fa 100644
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
index eca8bf89ab88..ad92409349fa 100644
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
@@ -744,7 +744,7 @@ gpt2: timer@20e8000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@20ec000 {
+			sdma: dma-controller@20ec000 {
 				compatible = "fsl,imx6ul-sdma", "fsl,imx6q-sdma",
 					     "fsl,imx35-sdma";
 				reg = <0x020ec000 0x4000>;
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index f4d2009d998b..c978aab1d0e3 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1166,6 +1166,8 @@ usdhc1: mmc@30b40000 {
 					<&clks IMX7D_USDHC1_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1178,6 +1180,8 @@ usdhc2: mmc@30b50000 {
 					<&clks IMX7D_USDHC2_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1190,6 +1194,8 @@ usdhc3: mmc@30b60000 {
 					<&clks IMX7D_USDHC3_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1206,7 +1212,7 @@ qspi: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma: sdma@30bd0000 {
+			sdma: dma-controller@30bd0000 {
 				compatible = "fsl,imx7d-sdma", "fsl,imx35-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
@@ -1239,14 +1245,13 @@ fec1: ethernet@30be0000 {
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
diff --git a/arch/arm/boot/dts/s5pv210-smdkv210.dts b/arch/arm/boot/dts/s5pv210-smdkv210.dts
index fbae768d65e2..901e7197b136 100644
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
 
diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index 24c19d63ff0a..95bf70ebd878 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -25,6 +25,9 @@ static inline int syscall_get_nr(struct task_struct *task,
 	if (IS_ENABLED(CONFIG_AEABI) && !IS_ENABLED(CONFIG_OABI_COMPAT))
 		return task_thread_info(task)->abi_syscall;
 
+	if (task_thread_info(task)->abi_syscall == -1)
+		return -1;
+
 	return task_thread_info(task)->abi_syscall & __NR_SYSCALL_MASK;
 }
 
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index fde7ac271b14..e7bfdd10bbcd 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -101,6 +101,7 @@ slow_work_pending:
 	cmp	r0, #0
 	beq	no_work_pending
 	movlt	scno, #(__NR_restart_syscall - __NR_SYSCALL_BASE)
+	str	scno, [tsk, #TI_ABI_SYSCALL]	@ make sure tracers see update
 	ldmia	sp, {r0 - r6}			@ have to reload r0 - r6
 	b	local_restart			@ ... and off we go
 ENDPROC(ret_fast_syscall)
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 43b963ea4a0e..71c98ca3a455 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -786,8 +786,9 @@ long arch_ptrace(struct task_struct *child, long request,
 			break;
 
 		case PTRACE_SET_SYSCALL:
-			task_thread_info(child)->abi_syscall = data &
-							__NR_SYSCALL_MASK;
+			if (data != -1)
+				data &= __NR_SYSCALL_MASK;
+			task_thread_info(child)->abi_syscall = data;
 			ret = 0;
 			break;
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 0a5b87e2a4b0..37d23ae2e9db 100644
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
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index c6e8bf18defc..ad4c2ccec63e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -280,9 +280,9 @@ camera_rear@3b {
 		clock-names = "xclk";
 		clock-frequency = <23880000>;
 
-		vdddo-supply = <&camera_vdddo_1v8>;
-		vdda-supply = <&camera_vdda_2v8>;
-		vddd-supply = <&camera_vddd_1v5>;
+		DOVDD-supply = <&camera_vdddo_1v8>;
+		AVDD-supply = <&camera_vdda_2v8>;
+		DVDD-supply = <&camera_vddd_1v5>;
 
 		/* No camera mezzanine by default */
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 7802abac39fa..e85f7cf4a56c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -620,6 +620,7 @@ pmi8994_s11: s11 {
 &pmi8994_wled {
 	status = "okay";
 	default-brightness = <512>;
+	qcom,num-strings = <3>;
 };
 
 &rpm_requests {
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index ec3ef14048cc..8a7c65178507 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2902,6 +2902,9 @@ usb2: usb@76f8800 {
 			#size-cells = <1>;
 			ranges;
 
+			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
 			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
 				<&gcc GCC_USB20_MASTER_CLK>,
 				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 05086cbe573b..902e15d05a95 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -67,9 +67,10 @@ pmic@3 {
 
 		pm660l_wled: leds@d800 {
 			compatible = "qcom,pm660l-wled";
-			reg = <0xd800 0xd900>;
-			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "ovp";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
 			label = "backlight";
 
 			qcom,switching-freq = <800>;
diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index a06ea9adae81..38cf0f14e879 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -35,12 +35,10 @@ pmi8994_spmi_regulators: regulators {
 
 		pmi8994_wled: wled@d800 {
 			compatible = "qcom,pmi8994-wled";
-			reg = <0xd800 0xd900>;
-			interrupts = <3 0xd8 0x02 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "short";
-			qcom,num-strings = <3>;
-			/* Yes, all four strings *have to* be defined or things won't work. */
-			qcom,enabled-strings = <0 1 2 3>;
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
 			qcom,cabc;
 			qcom,external-pfet;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index d230c510d4b7..ef29e80c442c 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -41,5 +41,17 @@ lab: lab {
 				interrupt-names = "sc-err", "ocp";
 			};
 		};
+
+		pmi8998_wled: leds@d800 {
+			compatible = "qcom,pmi8998-wled";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
+			label = "backlight";
+
+			status = "disabled";
+		};
+
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index fc38f77d12a3..9e99fcf269df 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -45,7 +45,7 @@ pmk8350_vadc: adc@3100 {
 		};
 
 		pmk8350_adc_tm: adc-tm@3400 {
-			compatible = "qcom,adc-tm7";
+			compatible = "qcom,spmi-adc-tm5-gen2";
 			reg = <0x3400>;
 			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "threshold";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index a0489a45aafb..6a0e30cbf88f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1074,6 +1074,7 @@ gcc: clock-controller@100000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			power-domains = <&rpmhpd SDM845_CX>;
 		};
 
 		qfprom@784000 {
@@ -2282,7 +2283,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 300000000>;
+				<75000000 300000000>;
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 292e40d6162d..e8cb20c4cbf2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1131,7 +1131,7 @@ i2c7: i2c@89c000 {
 				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_i2c7_default>;
-				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
index 79afeb07f4a2..792911af1637 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
@@ -13,3 +13,236 @@ / {
 };
 
 /delete-node/ &vreg_l7f_1p8;
+
+&pm8009_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "CAM_PWR_LD_EN",
+			  "WIDEC_PWR_EN",
+			  "NC";
+};
+
+&pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "OPTION_2",
+			  "NC",
+			  "PM_SLP_CLK_IN",
+			  "OPTION_1",
+			  "NC",
+			  "NC",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+};
+
+&pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "LCD_ID",
+			  "NC",
+			  "WLC_EN_N", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+};
+
+&pm8150l_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "PM3003A_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "AUX2_THERM",
+			  "BB_HP_EN",
+			  "FP_LDO_EN",
+			  "PMX_RESET_N",
+			  "AUX3_THERM", /* GPIO_10 */
+			  "DTV_PWR_EN",
+			  "PM3003A_MODE";
+};
+
+&tlmm {
+	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
+			  "MDM2AP_ERR_FATAL",
+			  "AP_CTI_OUT",
+			  "MDM2AP_STATUS",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_PWR_REQ",
+			  "DVDT_WRT_DET_AND",
+			  "SPK_AMP_RESET_N", /* GPIO_10 */
+			  "SPK_AMP_INT_N",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "TX_GTR_THRES_IN",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_20 */
+			  "HST_BT_EN",
+			  "RGBC_IR_PWR_EN",
+			  "FP_INT_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK", /* GPIO_30 */
+			  "NFC_ESE_SPI_CS_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "SDM_DEBUG_UART_TX",
+			  "SDM_DEBUG_UART_RX",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_INT_N",
+			  "FP_SPI_MISO", /* GPIO_40 */
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "DISP_ERR_FG",
+			  "UIM2_DETECT_EN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "MDM_UART_CTS",
+			  "MDM_UART_RFR",
+			  "MDM_UART_TX",
+			  "MDM_UART_RX",
+			  "AP2MDM_STATUS",
+			  "AP2MDM_ERR_FATAL",
+			  "MDM_IPC_HS_UART_TX",
+			  "MDM_IPC_HS_UART_RX",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_PWR_B_CS",
+			  "NC", /* GPIO_70 */
+			  "CAM_PWR_A_CS",
+			  "SBU_SW_SEL",
+			  "SBU_SW_OE",
+			  "FP_RESET_N",
+			  "FP_RESET_N",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "TRAY_DET",
+			  "CAM2_RST_N",
+			  "PCIE0_RST_N",
+			  "PCIE0_CLK_REQ_N", /* GPIO_80 */
+			  "PCIE0_WAKE_N",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_OR",
+			  "NC",
+			  "PCIE2_RST_N",
+			  "PCIE2_CLK_REQ_N",
+			  "PCIE2_WAKE_N",
+			  "MDM_VFR_IRQ0",
+			  "MDM_VFR_IRQ1",
+			  "SW_SERVICE", /* GPIO_90 */
+			  "CAM_SOF",
+			  "CAM1_RST_N",
+			  "CAM0_RST_N",
+			  "CAM0_MCLK",
+			  "CAM1_MCLK",
+			  "CAM2_MCLK",
+			  "CAM3_MCLK",
+			  "CAM4_MCLK",
+			  "TOF_RST_N",
+			  "NC", /* GPIO_100 */
+			  "CCI0_I2C_SDA",
+			  "CCI0_I2C_SCL",
+			  "CCI1_I2C_SDA",
+			  "CCI1_I2C_SCL_",
+			  "CCI2_I2C_SDA",
+			  "CCI2_I2C_SCL",
+			  "CCI3_I2C_SDA",
+			  "CCI3_I2C_SCL",
+			  "CAM3_RST_N",
+			  "NFC_DWL_REQ", /* GPIO_110 */
+			  "NFC_IRQ",
+			  "XVS",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "WLC_I2C_SDA",
+			  "WLC_I2C_SCL", /* GPIO_120 */
+			  "ACC_COVER_OPEN",
+			  "ALS_PROX_INT_N",
+			  "ACCEL_INT",
+			  "WLAN_SW_CTRL",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "UDON_SWITCH_SEL",
+			  "WDOG_DISABLE",
+			  "BAROMETER_INT",
+			  "NC", /* GPIO_130 */
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "WLC_INT_N",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "BT_SLIMBUS_CLK",
+			  "BT_SLIMBUS_DATA",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0", /* GPIO_150 */
+			  "WCD_SWR_RX_DATA1",
+			  "SDM_DMIC_CLK1",
+			  "SDM_DMIC_DATA1",
+			  "SDM_DMIC_CLK2",
+			  "SDM_DMIC_DATA2",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN",
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "COMPASS_I2C_SDA", /* GPIO_160 */
+			  "COMPASS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N",
+			  "NC",
+			  "NC",
+			  "SSC_SENSOR_I2C_SDA", /* GPIO_170 */
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_SNS_UART6_TX",
+			  "HST_BLE_SNS_UART6_RX",
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index 16c96e838534..b0f4ecc91114 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -19,6 +19,8 @@ &framebuffer {
 };
 
 &gpio_keys {
+	pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
+
 	g-assist-key {
 		label = "Google Assistant Key";
 		linux,code = <KEY_LEFTMETA>;
@@ -29,6 +31,247 @@ g-assist-key {
 	};
 };
 
+&pm8009_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "WIDEC_PWR_EN",
+			  "NC";
+};
+
+&pm8150_gpios {
+	gpio-line-names = "VOL_DOWN_N", /* GPIO_1 */
+			  "OPTION_2",
+			  "NC",
+			  "PM_SLP_CLK_IN",
+			  "OPTION_1",
+			  "G_ASSIST_N",
+			  "NC",
+			  "SP_ARI_PWR_ALARM",
+			  "NC",
+			  "NC"; /* GPIO_10 */
+
+	g_assist_n: g-assist-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8150b_gpios {
+	gpio-line-names = "SNAPSHOT_N", /* GPIO_1 */
+			  "FOCUS_N",
+			  "NC",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "LCD_ID",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "RF_ID";
+};
+
+&pm8150l_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "PM3003A_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "AUX2_THERM",
+			  "BB_HP_EN",
+			  "FP_LDO_EN",
+			  "PMX_RESET_N",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "PM3003A_MODE";
+};
+
+&tlmm {
+	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
+			  "MDM2AP_ERR_FATAL",
+			  "AP_CTI_OUT",
+			  "MDM2AP_STATUS",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_PWR_REQ",
+			  "DVDT_WRT_DET_AND",
+			  "SPK_AMP_RESET_N", /* GPIO_10 */
+			  "SPK_AMP_INT_N",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "TX_GTR_THRES_IN",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_20 */
+			  "HST_BT_EN",
+			  "RGBC_IR_PWR_EN",
+			  "FP_INT_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK", /* GPIO_30 */
+			  "NFC_ESE_SPI_CS_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "SDM_DEBUG_UART_TX",
+			  "SDM_DEBUG_UART_RX",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_INT_N",
+			  "FP_SPI_MISO", /* GPIO_40 */
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "DISP_ERR_FG",
+			  "UIM2_DETECT_EN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "MDM_UART_CTS",
+			  "MDM_UART_RFR",
+			  "MDM_UART_TX",
+			  "MDM_UART_RX",
+			  "AP2MDM_STATUS",
+			  "AP2MDM_ERR_FATAL",
+			  "MDM_IPC_HS_UART_TX",
+			  "MDM_IPC_HS_UART_RX",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_PWR_B_CS",
+			  "NC", /* GPIO_70 */
+			  "FRONTC_PWR_EN",
+			  "SBU_SW_SEL",
+			  "SBU_SW_OE",
+			  "FP_RESET_N",
+			  "FP_RESET_N",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "TRAY_DET",
+			  "CAM2_RST_N",
+			  "PCIE0_RST_N",
+			  "PCIE0_CLK_REQ_N", /* GPIO_80 */
+			  "PCIE0_WAKE_N",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_OR",
+			  "NC",
+			  "PCIE2_RST_N",
+			  "PCIE2_CLK_REQ_N",
+			  "PCIE2_WAKE_N",
+			  "MDM_VFR_IRQ0",
+			  "MDM_VFR_IRQ1",
+			  "SW_SERVICE", /* GPIO_90 */
+			  "CAM_SOF",
+			  "CAM1_RST_N",
+			  "CAM0_RST_N",
+			  "CAM0_MCLK",
+			  "CAM1_MCLK",
+			  "CAM2_MCLK",
+			  "CAM3_MCLK",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_100 */
+			  "CCI0_I2C_SDA",
+			  "CCI0_I2C_SCL",
+			  "CCI1_I2C_SDA",
+			  "CCI1_I2C_SCL_",
+			  "CCI2_I2C_SDA",
+			  "CCI2_I2C_SCL",
+			  "CCI3_I2C_SDA",
+			  "CCI3_I2C_SCL",
+			  "CAM3_RST_N",
+			  "NFC_DWL_REQ", /* GPIO_110 */
+			  "NFC_IRQ",
+			  "XVS",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "ACC_COVER_OPEN",
+			  "ALS_PROX_INT_N",
+			  "ACCEL_INT",
+			  "WLAN_SW_CTRL",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "UDON_SWITCH_SEL",
+			  "WDOG_DISABLE",
+			  "BAROMETER_INT",
+			  "NC", /* GPIO_130 */
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "BT_SLIMBUS_CLK",
+			  "BT_SLIMBUS_DATA",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0", /* GPIO_150 */
+			  "WCD_SWR_RX_DATA1",
+			  "SDM_DMIC_CLK1",
+			  "SDM_DMIC_DATA1",
+			  "SDM_DMIC_CLK2",
+			  "SDM_DMIC_DATA2",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN",
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "COMPASS_I2C_SDA", /* GPIO_160 */
+			  "COMPASS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N",
+			  "NC",
+			  "NC",
+			  "SSC_SENSOR_I2C_SDA", /* GPIO_170 */
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_SNS_UART6_TX",
+			  "HST_BLE_SNS_UART6_RX",
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
+
 &vreg_l2f_1p3 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index b093f2a02a9c..e622cbe167b0 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -51,12 +51,26 @@ framebuffer: framebuffer@9c000000 {
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		/*
-		 * Camera focus (light press) and camera snapshot (full press)
-		 * seem not to work properly.. Adding the former one stalls the CPU
-		 * and the latter kills the volume down key for whatever reason. In any
-		 * case, they are both on &pm8150b_gpios: camera focus(2), camera snapshot(1).
-		 */
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
+		pinctrl-names = "default";
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8150b_gpios 2 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			linux,code = <KEY_CAMERA>;
+			gpios = <&pm8150b_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
 
 		vol-down {
 			label = "Volume Down";
@@ -518,6 +532,34 @@ &pcie2_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pm8150_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8150b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio2";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 181e32b8a272..5d6551e1fcd8 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -97,7 +97,7 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -116,7 +116,7 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -132,7 +132,7 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -148,7 +148,7 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			#cooling-cells = <2>;
@@ -1439,6 +1439,7 @@ pcie0: pci@1c00000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -1545,6 +1546,7 @@ pcie1: pci@1c08000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -1653,6 +1655,7 @@ pcie2: pci@1c10000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie2_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1ef16975d13a..b0ba63b5869d 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -61,7 +61,7 @@ cpus {
 
 		CPU0: cpu@0 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
@@ -78,7 +78,7 @@ L3_0: l3-cache {
 
 		CPU1: cpu@100 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
@@ -92,7 +92,7 @@ L2_100: l2-cache {
 
 		CPU2: cpu@200 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
@@ -106,7 +106,7 @@ L2_200: l2-cache {
 
 		CPU3: cpu@300 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
@@ -120,7 +120,7 @@ L2_300: l2-cache {
 
 		CPU4: cpu@400 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a78";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
@@ -134,7 +134,7 @@ L2_400: l2-cache {
 
 		CPU5: cpu@500 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a78";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
@@ -149,7 +149,7 @@ L2_500: l2-cache {
 
 		CPU6: cpu@600 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a78";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
@@ -163,7 +163,7 @@ L2_600: l2-cache {
 
 		CPU7: cpu@700 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-x1";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
@@ -1052,6 +1052,13 @@ cpufreq_hw: cpufreq@18591000 {
 			      <0 0x18593000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
 
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1",
+					  "dcvsh-irq-2";
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 
diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index 7bea1d705dd6..6bb0258fb4aa 100644
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
index c56b262a2749..bdc5f744249b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1005,9 +1005,13 @@ SYM_CODE_START(__sdei_asm_handler)
 
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
@@ -1072,6 +1076,14 @@ SYM_CODE_START(__sdei_asm_handler)
 
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
@@ -1082,4 +1094,15 @@ alternative_else_nop_endif
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
index 47f77d1234cb..532611d07bdc 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -47,6 +47,9 @@ DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_normal_ptr);
 DEFINE_PER_CPU(unsigned long *, sdei_shadow_call_stack_critical_ptr);
 #endif
 
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
+DEFINE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
+
 static void _free_sdei_stack(unsigned long * __percpu *ptr, int cpu)
 {
 	unsigned long *p;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3beaa6640ab3..bc29cc044a4d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1073,10 +1073,8 @@ void crash_smp_send_stop(void)
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
@@ -1095,7 +1093,9 @@ void crash_smp_send_stop(void)
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
diff --git a/arch/arm64/lib/strncmp.S b/arch/arm64/lib/strncmp.S
index e42bcfcd37e6..a4884b97e9a8 100644
--- a/arch/arm64/lib/strncmp.S
+++ b/arch/arm64/lib/strncmp.S
@@ -1,9 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2013-2021, Arm Limited.
+ * Copyright (c) 2013-2022, Arm Limited.
  *
  * Adapted from the original at:
- * https://github.com/ARM-software/optimized-routines/blob/e823e3abf5f89ecb/string/aarch64/strncmp.S
+ * https://github.com/ARM-software/optimized-routines/blob/189dfefe37d54c5b/string/aarch64/strncmp.S
  */
 
 #include <linux/linkage.h>
@@ -11,14 +11,14 @@
 
 /* Assumptions:
  *
- * ARMv8-a, AArch64
+ * ARMv8-a, AArch64.
+ * MTE compatible.
  */
 
 #define L(label) .L ## label
 
 #define REP8_01 0x0101010101010101
 #define REP8_7f 0x7f7f7f7f7f7f7f7f
-#define REP8_80 0x8080808080808080
 
 /* Parameters and result.  */
 #define src1		x0
@@ -39,10 +39,24 @@
 #define tmp3		x10
 #define zeroones	x11
 #define pos		x12
-#define limit_wd	x13
-#define mask		x14
-#define endloop		x15
+#define mask		x13
+#define endloop		x14
 #define count		mask
+#define offset		pos
+#define neg_offset	x15
+
+/* Define endian dependent shift operations.
+   On big-endian early bytes are at MSB and on little-endian LSB.
+   LS_FW means shifting towards early bytes.
+   LS_BK means shifting towards later bytes.
+   */
+#ifdef __AARCH64EB__
+#define LS_FW lsl
+#define LS_BK lsr
+#else
+#define LS_FW lsr
+#define LS_BK lsl
+#endif
 
 SYM_FUNC_START_WEAK_PI(strncmp)
 	cbz	limit, L(ret0)
@@ -52,9 +66,6 @@ SYM_FUNC_START_WEAK_PI(strncmp)
 	and	count, src1, #7
 	b.ne	L(misaligned8)
 	cbnz	count, L(mutual_align)
-	/* Calculate the number of full and partial words -1.  */
-	sub	limit_wd, limit, #1	/* limit != 0, so no underflow.  */
-	lsr	limit_wd, limit_wd, #3	/* Convert to Dwords.  */
 
 	/* NUL detection works on the principle that (X - 1) & (~X) & 0x80
 	   (=> (X - 1) & ~(X | 0x7f)) is non-zero iff a byte is zero, and
@@ -64,56 +75,52 @@ L(loop_aligned):
 	ldr	data1, [src1], #8
 	ldr	data2, [src2], #8
 L(start_realigned):
-	subs	limit_wd, limit_wd, #1
+	subs	limit, limit, #8
 	sub	tmp1, data1, zeroones
 	orr	tmp2, data1, #REP8_7f
 	eor	diff, data1, data2	/* Non-zero if differences found.  */
-	csinv	endloop, diff, xzr, pl	/* Last Dword or differences.  */
+	csinv	endloop, diff, xzr, hi	/* Last Dword or differences.  */
 	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
 	ccmp	endloop, #0, #0, eq
 	b.eq	L(loop_aligned)
 	/* End of main loop */
 
-	/* Not reached the limit, must have found the end or a diff.  */
-	tbz	limit_wd, #63, L(not_limit)
-
-	/* Limit % 8 == 0 => all bytes significant.  */
-	ands	limit, limit, #7
-	b.eq	L(not_limit)
-
-	lsl	limit, limit, #3	/* Bits -> bytes.  */
-	mov	mask, #~0
-#ifdef __AARCH64EB__
-	lsr	mask, mask, limit
-#else
-	lsl	mask, mask, limit
-#endif
-	bic	data1, data1, mask
-	bic	data2, data2, mask
-
-	/* Make sure that the NUL byte is marked in the syndrome.  */
-	orr	has_nul, has_nul, mask
-
-L(not_limit):
+L(full_check):
+#ifndef __AARCH64EB__
 	orr	syndrome, diff, has_nul
-
-#ifndef	__AARCH64EB__
+	add	limit, limit, 8	/* Rewind limit to before last subs. */
+L(syndrome_check):
+	/* Limit was reached. Check if the NUL byte or the difference
+	   is before the limit. */
 	rev	syndrome, syndrome
 	rev	data1, data1
-	/* The MS-non-zero bit of the syndrome marks either the first bit
-	   that is different, or the top bit of the first zero byte.
-	   Shifting left now will bring the critical information into the
-	   top bits.  */
 	clz	pos, syndrome
 	rev	data2, data2
 	lsl	data1, data1, pos
+	cmp	limit, pos, lsr #3
 	lsl	data2, data2, pos
 	/* But we need to zero-extend (char is unsigned) the value and then
 	   perform a signed 32-bit subtraction.  */
 	lsr	data1, data1, #56
 	sub	result, data1, data2, lsr #56
+	csel result, result, xzr, hi
 	ret
 #else
+	/* Not reached the limit, must have found the end or a diff.  */
+	tbz	limit, #63, L(not_limit)
+	add	tmp1, limit, 8
+	cbz	limit, L(not_limit)
+
+	lsl	limit, tmp1, #3	/* Bits -> bytes.  */
+	mov	mask, #~0
+	lsr	mask, mask, limit
+	bic	data1, data1, mask
+	bic	data2, data2, mask
+
+	/* Make sure that the NUL byte is marked in the syndrome.  */
+	orr	has_nul, has_nul, mask
+
+L(not_limit):
 	/* For big-endian we cannot use the trick with the syndrome value
 	   as carry-propagation can corrupt the upper bits if the trailing
 	   bytes in the string contain 0x01.  */
@@ -134,10 +141,11 @@ L(not_limit):
 	rev	has_nul, has_nul
 	orr	syndrome, diff, has_nul
 	clz	pos, syndrome
-	/* The MS-non-zero bit of the syndrome marks either the first bit
-	   that is different, or the top bit of the first zero byte.
+	/* The most-significant-non-zero bit of the syndrome marks either the
+	   first bit that is different, or the top bit of the first zero byte.
 	   Shifting left now will bring the critical information into the
 	   top bits.  */
+L(end_quick):
 	lsl	data1, data1, pos
 	lsl	data2, data2, pos
 	/* But we need to zero-extend (char is unsigned) the value and then
@@ -159,22 +167,12 @@ L(mutual_align):
 	neg	tmp3, count, lsl #3	/* 64 - bits(bytes beyond align). */
 	ldr	data2, [src2], #8
 	mov	tmp2, #~0
-	sub	limit_wd, limit, #1	/* limit != 0, so no underflow.  */
-#ifdef __AARCH64EB__
-	/* Big-endian.  Early bytes are at MSB.  */
-	lsl	tmp2, tmp2, tmp3	/* Shift (count & 63).  */
-#else
-	/* Little-endian.  Early bytes are at LSB.  */
-	lsr	tmp2, tmp2, tmp3	/* Shift (count & 63).  */
-#endif
-	and	tmp3, limit_wd, #7
-	lsr	limit_wd, limit_wd, #3
-	/* Adjust the limit. Only low 3 bits used, so overflow irrelevant.  */
-	add	limit, limit, count
-	add	tmp3, tmp3, count
+	LS_FW	tmp2, tmp2, tmp3	/* Shift (count & 63).  */
+	/* Adjust the limit and ensure it doesn't overflow.  */
+	adds	limit, limit, count
+	csinv	limit, limit, xzr, lo
 	orr	data1, data1, tmp2
 	orr	data2, data2, tmp2
-	add	limit_wd, limit_wd, tmp3, lsr #3
 	b	L(start_realigned)
 
 	.p2align 4
@@ -197,13 +195,11 @@ L(done):
 	/* Align the SRC1 to a dword by doing a bytewise compare and then do
 	   the dword loop.  */
 L(try_misaligned_words):
-	lsr	limit_wd, limit, #3
-	cbz	count, L(do_misaligned)
+	cbz	count, L(src1_aligned)
 
 	neg	count, count
 	and	count, count, #7
 	sub	limit, limit, count
-	lsr	limit_wd, limit, #3
 
 L(page_end_loop):
 	ldrb	data1w, [src1], #1
@@ -214,48 +210,100 @@ L(page_end_loop):
 	subs	count, count, #1
 	b.hi	L(page_end_loop)
 
-L(do_misaligned):
-	/* Prepare ourselves for the next page crossing.  Unlike the aligned
-	   loop, we fetch 1 less dword because we risk crossing bounds on
-	   SRC2.  */
-	mov	count, #8
-	subs	limit_wd, limit_wd, #1
-	b.lo	L(done_loop)
-L(loop_misaligned):
-	and	tmp2, src2, #0xff8
-	eor	tmp2, tmp2, #0xff8
-	cbz	tmp2, L(page_end_loop)
+	/* The following diagram explains the comparison of misaligned strings.
+	   The bytes are shown in natural order. For little-endian, it is
+	   reversed in the registers. The "x" bytes are before the string.
+	   The "|" separates data that is loaded at one time.
+	   src1     | a a a a a a a a | b b b c c c c c | . . .
+	   src2     | x x x x x a a a   a a a a a b b b | c c c c c . . .
+
+	   After shifting in each step, the data looks like this:
+	                STEP_A              STEP_B              STEP_C
+	   data1    a a a a a a a a     b b b c c c c c     b b b c c c c c
+	   data2    a a a a a a a a     b b b 0 0 0 0 0     0 0 0 c c c c c
 
+	   The bytes with "0" are eliminated from the syndrome via mask.
+
+	   Align SRC2 down to 16 bytes. This way we can read 16 bytes at a
+	   time from SRC2. The comparison happens in 3 steps. After each step
+	   the loop can exit, or read from SRC1 or SRC2. */
+L(src1_aligned):
+	/* Calculate offset from 8 byte alignment to string start in bits. No
+	   need to mask offset since shifts are ignoring upper bits. */
+	lsl	offset, src2, #3
+	bic	src2, src2, #0xf
+	mov	mask, -1
+	neg	neg_offset, offset
 	ldr	data1, [src1], #8
-	ldr	data2, [src2], #8
-	sub	tmp1, data1, zeroones
-	orr	tmp2, data1, #REP8_7f
-	eor	diff, data1, data2	/* Non-zero if differences found.  */
-	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
-	ccmp	diff, #0, #0, eq
-	b.ne	L(not_limit)
-	subs	limit_wd, limit_wd, #1
-	b.pl	L(loop_misaligned)
+	ldp	tmp1, tmp2, [src2], #16
+	LS_BK	mask, mask, neg_offset
+	and	neg_offset, neg_offset, #63	/* Need actual value for cmp later. */
+	/* Skip the first compare if data in tmp1 is irrelevant. */
+	tbnz	offset, 6, L(misaligned_mid_loop)
 
-L(done_loop):
-	/* We found a difference or a NULL before the limit was reached.  */
-	and	limit, limit, #7
-	cbz	limit, L(not_limit)
-	/* Read the last word.  */
-	sub	src1, src1, 8
-	sub	src2, src2, 8
-	ldr	data1, [src1, limit]
-	ldr	data2, [src2, limit]
-	sub	tmp1, data1, zeroones
-	orr	tmp2, data1, #REP8_7f
+L(loop_misaligned):
+	/* STEP_A: Compare full 8 bytes when there is enough data from SRC2.*/
+	LS_FW	data2, tmp1, offset
+	LS_BK	tmp1, tmp2, neg_offset
+	subs	limit, limit, #8
+	orr	data2, data2, tmp1	/* 8 bytes from SRC2 combined from two regs.*/
+	sub	has_nul, data1, zeroones
 	eor	diff, data1, data2	/* Non-zero if differences found.  */
-	bics	has_nul, tmp1, tmp2	/* Non-zero if NUL terminator.  */
-	ccmp	diff, #0, #0, eq
-	b.ne	L(not_limit)
+	orr	tmp3, data1, #REP8_7f
+	csinv	endloop, diff, xzr, hi	/* If limit, set to all ones. */
+	bic	has_nul, has_nul, tmp3	/* Non-zero if NUL byte found in SRC1. */
+	orr	tmp3, endloop, has_nul
+	cbnz	tmp3, L(full_check)
+
+	ldr	data1, [src1], #8
+L(misaligned_mid_loop):
+	/* STEP_B: Compare first part of data1 to second part of tmp2. */
+	LS_FW	data2, tmp2, offset
+#ifdef __AARCH64EB__
+	/* For big-endian we do a byte reverse to avoid carry-propagation
+	problem described above. This way we can reuse the has_nul in the
+	next step and also use syndrome value trick at the end. */
+	rev	tmp3, data1
+	#define data1_fixed tmp3
+#else
+	#define data1_fixed data1
+#endif
+	sub	has_nul, data1_fixed, zeroones
+	orr	tmp3, data1_fixed, #REP8_7f
+	eor	diff, data2, data1	/* Non-zero if differences found.  */
+	bic	has_nul, has_nul, tmp3	/* Non-zero if NUL terminator.  */
+#ifdef __AARCH64EB__
+	rev	has_nul, has_nul
+#endif
+	cmp	limit, neg_offset, lsr #3
+	orr	syndrome, diff, has_nul
+	bic	syndrome, syndrome, mask	/* Ignore later bytes. */
+	csinv	tmp3, syndrome, xzr, hi	/* If limit, set to all ones. */
+	cbnz	tmp3, L(syndrome_check)
+
+	/* STEP_C: Compare second part of data1 to first part of tmp1. */
+	ldp	tmp1, tmp2, [src2], #16
+	cmp	limit, #8
+	LS_BK	data2, tmp1, neg_offset
+	eor	diff, data2, data1	/* Non-zero if differences found.  */
+	orr	syndrome, diff, has_nul
+	and	syndrome, syndrome, mask	/* Ignore earlier bytes. */
+	csinv	tmp3, syndrome, xzr, hi	/* If limit, set to all ones. */
+	cbnz	tmp3, L(syndrome_check)
+
+	ldr	data1, [src1], #8
+	sub	limit, limit, #8
+	b	L(loop_misaligned)
+
+#ifdef	__AARCH64EB__
+L(syndrome_check):
+	clz	pos, syndrome
+	cmp	pos, limit, lsl #3
+	b.lo	L(end_quick)
+#endif
 
 L(ret0):
 	mov	result, #0
 	ret
-
 SYM_FUNC_END_PI(strncmp)
 EXPORT_SYMBOL_NOHWKASAN(strncmp)
diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index 439395aa6fb4..081922c72daa 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -499,13 +499,13 @@ in_ea:
 	dbf	%d0,morein
 	rts
 
-	.section .fixup,#alloc,#execinstr
+	.section .fixup,"ax"
 	.even
 1:
 	jbsr	fpsp040_die
 	jbra	.Lnotkern
 
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
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index f7b58da2f388..151e98698f76 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -279,8 +279,8 @@ ifdef CONFIG_64BIT
     endif
   endif
 
-  ifeq ($(KBUILD_SYM32)$(call cc-option-yn,-msym32), yy)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+  ifeq ($(KBUILD_SYM32), y)
+    cflags-$(KBUILD_SYM32) += -msym32 -DKBUILD_64BIT_SYM32
   else
     ifeq ($(CONFIG_CPU_DADDI_WORKAROUNDS), y)
       $(error CONFIG_CPU_DADDI_WORKAROUNDS unsupported without -msym32)
@@ -321,7 +321,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
-ifdef CONFIG_MIPS
+ifdef need-compiler
 CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
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
 
diff --git a/arch/parisc/kernel/processor.c b/arch/parisc/kernel/processor.c
index b861bbbc8717..ccdbcfdfe4e2 100644
--- a/arch/parisc/kernel/processor.c
+++ b/arch/parisc/kernel/processor.c
@@ -372,10 +372,18 @@ int
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
@@ -420,8 +428,7 @@ show_cpuinfo (struct seq_file *m, void *v)
 
 		seq_printf(m, "model\t\t: %s - %s\n",
 				 boot_cpu_data.pdc.sys_model_name,
-				 cpuinfo->dev ?
-				 cpuinfo->dev->name : "Unknown");
+				 cpu_name);
 
 		seq_printf(m, "hversion\t: 0x%08x\n"
 			        "sversion\t: 0x%08x\n",
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
index c5c9e2515315..02c089c5493a 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -14,7 +14,6 @@
 
 #include <linux/string.h>
 #include <asm/types.h>
-#include <asm/lppaca.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #ifdef CONFIG_PPC_BOOK3E
@@ -46,14 +45,11 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
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
index b325022ffa2b..0a333ac716e0 100644
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
index 83e0f701ebc6..217d8fb24635 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -9,6 +9,7 @@
 
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #include <asm/page.h>
 
 static inline long poll_pending(void)
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ad1c4575c61c..d496dc5151aa 100644
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
index 8bea336fa5b7..b858f186e9a7 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -172,17 +172,28 @@ static int fail_iommu_bus_notify(struct notifier_block *nb,
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
index d4bca93b79f6..6fa634599bc9 100644
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
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 5172d5cec2c0..6972fd5d423c 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -127,21 +127,6 @@ static __always_inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_pid_lpid(unsigned long pid,
-					     unsigned long lpid,
-					     unsigned long ric)
-{
-	unsigned long rb, rs, prs, r;
-
-	rb = PPC_BIT(53); /* IS = 1 */
-	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
-	prs = 1; /* process scoped */
-	r = 1;   /* radix format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
 static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -202,23 +187,6 @@ static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
-					    unsigned long lpid,
-					    unsigned long ap, unsigned long ric)
-{
-	unsigned long rb, rs, prs, r;
-
-	rb = va & ~(PPC_BITMASK(52, 63));
-	rb |= ap << PPC_BITLSHIFT(58);
-	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
-	prs = 1; /* process scoped */
-	r = 1;   /* radix format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
-
 static __always_inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
 					    unsigned long ap, unsigned long ric)
 {
@@ -264,22 +232,6 @@ static inline void fixup_tlbie_va_range(unsigned long va, unsigned long pid,
 	}
 }
 
-static inline void fixup_tlbie_va_range_lpid(unsigned long va,
-					     unsigned long pid,
-					     unsigned long lpid,
-					     unsigned long ap)
-{
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
-	}
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
-	}
-}
-
 static inline void fixup_tlbie_pid(unsigned long pid)
 {
 	/*
@@ -299,26 +251,6 @@ static inline void fixup_tlbie_pid(unsigned long pid)
 	}
 }
 
-static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
-{
-	/*
-	 * We can use any address for the invalidation, pick one which is
-	 * probably unused as an optimisation.
-	 */
-	unsigned long va = ((1UL << 52) - 1);
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
-	}
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
-				RIC_FLUSH_TLB);
-	}
-}
-
 static inline void fixup_tlbie_lpid_va(unsigned long va, unsigned long lpid,
 				       unsigned long ap)
 {
@@ -416,31 +348,6 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
-				   unsigned long ric)
-{
-	asm volatile("ptesync" : : : "memory");
-
-	/*
-	 * Workaround the fact that the "ric" argument to __tlbie_pid
-	 * must be a compile-time contraint to match the "i" constraint
-	 * in the asm statement.
-	 */
-	switch (ric) {
-	case RIC_FLUSH_TLB:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
-		fixup_tlbie_pid_lpid(pid, lpid);
-		break;
-	case RIC_FLUSH_PWC:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-		break;
-	case RIC_FLUSH_ALL:
-	default:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
-		fixup_tlbie_pid_lpid(pid, lpid);
-	}
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
 struct tlbiel_pid {
 	unsigned long pid;
 	unsigned long ric;
@@ -566,20 +473,6 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
 	fixup_tlbie_va_range(addr - page_size, pid, ap);
 }
 
-static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
-					 unsigned long pid, unsigned long lpid,
-					 unsigned long page_size,
-					 unsigned long psize)
-{
-	unsigned long addr;
-	unsigned long ap = mmu_get_ap(psize);
-
-	for (addr = start; addr < end; addr += page_size)
-		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
-
-	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
-}
-
 static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
 				      unsigned long psize, unsigned long ric)
 {
@@ -660,18 +553,6 @@ static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
-					unsigned long pid, unsigned long lpid,
-					unsigned long page_size,
-					unsigned long psize, bool also_pwc)
-{
-	asm volatile("ptesync" : : : "memory");
-	if (also_pwc)
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
-
 static inline void _tlbiel_va_range_multicast(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				unsigned long pid, unsigned long page_size,
@@ -1468,6 +1349,127 @@ void radix__flush_tlb_all(void)
 }
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+static __always_inline void __tlbie_pid_lpid(unsigned long pid,
+					     unsigned long lpid,
+					     unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = PPC_BIT(53); /* IS = 1 */
+	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
+static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
+					    unsigned long lpid,
+					    unsigned long ap, unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
+static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
+{
+	/*
+	 * We can use any address for the invalidation, pick one which is
+	 * probably unused as an optimisation.
+	 */
+	unsigned long va = ((1UL << 52) - 1);
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
+	}
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
+				RIC_FLUSH_TLB);
+	}
+}
+
+static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
+				   unsigned long ric)
+{
+	asm volatile("ptesync" : : : "memory");
+
+	/*
+	 * Workaround the fact that the "ric" argument to __tlbie_pid
+	 * must be a compile-time contraint to match the "i" constraint
+	 * in the asm statement.
+	 */
+	switch (ric) {
+	case RIC_FLUSH_TLB:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
+		fixup_tlbie_pid_lpid(pid, lpid);
+		break;
+	case RIC_FLUSH_PWC:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
+		break;
+	case RIC_FLUSH_ALL:
+	default:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
+		fixup_tlbie_pid_lpid(pid, lpid);
+	}
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+
+static inline void fixup_tlbie_va_range_lpid(unsigned long va,
+					     unsigned long pid,
+					     unsigned long lpid,
+					     unsigned long ap)
+{
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
+	}
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
+	}
+}
+
+static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
+					 unsigned long pid, unsigned long lpid,
+					 unsigned long page_size,
+					 unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	for (addr = start; addr < end; addr += page_size)
+		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
+
+	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
+}
+
+static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
+					unsigned long pid, unsigned long lpid,
+					unsigned long page_size,
+					unsigned long psize, bool also_pwc)
+{
+	asm volatile("ptesync" : : : "memory");
+	if (also_pwc)
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
+	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+
 /*
  * Performs process-scoped invalidations for a given LPID
  * as part of H_RPT_INVALIDATE hcall.
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index f0037bcc47a0..a4fd2901189c 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -14,6 +14,7 @@
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
index 3df6bdfea475..d133597a84ca 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -638,16 +638,8 @@ static const struct proc_ops vcpudispatch_stats_freq_proc_ops = {
 
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
index f71eac74ea92..19503a879782 100644
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
index c2b3752684b5..d25053755c8b 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -816,7 +816,7 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca())) {
+		if (lppaca_shared_proc()) {
 			static_branch_enable(&shared_processor);
 			pv_spinlocks_init();
 		}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3c085e1e5232..8b5277c3b147 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -59,6 +59,7 @@
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
 #include <asm/paca.h>
+#include <asm/lppaca.h>
 #endif
 
 #include "nonstdio.h"
diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index a279b7d23a5e..621322eb0e68 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -35,7 +35,7 @@
  * and padding is also possible, the limits need to be generous.
  */
 #define PAES_MIN_KEYSIZE 16
-#define PAES_MAX_KEYSIZE 320
+#define PAES_MAX_KEYSIZE MAXEP11AESKEYBLOBSIZE
 
 static u8 *ctrblk;
 static DEFINE_MUTEX(ctrblk_lock);
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index ba2988783d66..834b1ec5dd7a 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -502,6 +502,8 @@ static struct attribute_group ipl_ccw_attr_group_lpar = {
 
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
index f145842c40b9..3dd74d369f99 100644
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
index cd1a58bb3e9c..dc0e6fe77de1 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -54,7 +54,7 @@ obj-$(CONFIG_UML_NET) += net.o
 obj-$(CONFIG_MCONSOLE) += mconsole.o
 obj-$(CONFIG_MMAPPER) += mmapper_kern.o 
 obj-$(CONFIG_BLK_DEV_UBD) += ubd.o 
-obj-$(CONFIG_HOSTAUDIO) += hostaudio.o
+obj-$(CONFIG_UML_SOUND) += hostaudio.o
 obj-$(CONFIG_NULL_CHAN) += null.o 
 obj-$(CONFIG_PORT_CHAN) += port.o
 obj-$(CONFIG_PTY_CHAN) += pty.o
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fd9441f40457..c3d427c817c7 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -468,11 +468,25 @@ SYM_CODE_START(startup_64)
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
@@ -480,6 +494,11 @@ SYM_CODE_START(startup_64)
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
 
@@ -600,7 +619,7 @@ SYM_FUNC_END(.Lrelocated)
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
  *
- * RDI contains the return address (might be above 4G).
+ * Return address is at the top of the stack (might be above 4G).
  * ECX contains the base address of the trampoline memory.
  * Non zero RDX means trampoline needs to enable 5-level paging.
  */
@@ -610,9 +629,6 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %ds
 	movl	%eax, %ss
 
-	/* Set up new stack */
-	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
-
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
@@ -672,7 +688,7 @@ SYM_CODE_END(trampoline_32bit_src)
 	.code64
 SYM_FUNC_START_LOCAL_NOALIGN(.Lpaging_enabled)
 	/* Return from the trampoline */
-	jmp	*%rdi
+	retq
 SYM_FUNC_END(.Lpaging_enabled)
 
 	/*
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 935081ddf60b..9b5859812f4f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6078,8 +6078,18 @@ void spr_uncore_cpu_init(void)
 
 	type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
 	if (type) {
+		/*
+		 * The value from the discovery table (stored in the type->num_boxes
+		 * of UNCORE_SPR_CHA) is incorrect on some SPR variants because of a
+		 * firmware bug. Using the value from SPR_MSR_UNC_CBO_CONFIG to replace it.
+		 */
 		rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
-		type->num_boxes = num_cbo;
+		/*
+		 * The MSR doesn't work on the EMR XCC, but the firmware bug doesn't impact
+		 * the EMR XCC. Don't let the value from the MSR replace the existing value.
+		 */
+		if (num_cbo)
+			type->num_boxes = num_cbo;
 	}
 	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
 }
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 40497a9020c6..28e59576c75b 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -123,11 +123,12 @@
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
index 3b12e6b99412..6c2e3ff3cb28 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -101,12 +101,6 @@ static inline int cpu_has_svm(const char **msg)
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
index 241dda687eb9..06978a1194f2 100644
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
index 54a0b3833ffe..3151c08bb54a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1149,11 +1149,11 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
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
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 64511c4a5200..155091020123 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -167,6 +167,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			continue;
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -185,6 +186,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			list_add_tail(&epc_page->list, &secs_pages);
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -206,6 +208,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 
 		if (sgx_vepc_free_page(epc_page))
 			list_add_tail(&epc_page->list, &secs_pages);
+		cond_resched();
 	}
 
 	if (!list_empty(&secs_pages))
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
 
diff --git a/block/bdev.c b/block/bdev.c
index 18abafb135e0..b8599a408884 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -835,7 +835,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		 * used in blkdev_get/put().
 		 */
 		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
-		    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
+		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
 			bdev->bd_write_holder = true;
 			unblock_events = false;
 		}
diff --git a/block/genhd.c b/block/genhd.c
index a1d9e785dcf7..6123f13e148e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -495,7 +495,7 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
 		 * and don't bother scanning for partitions either.
 		 */
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
-		disk->flags |= GENHD_FL_NO_PART_SCAN;
+		disk->flags |= GENHD_FL_NO_PART;
 	} else {
 		ret = bdi_register(disk->bdi, "%u:%u",
 				   disk->major, disk->first_minor);
diff --git a/block/ioctl.c b/block/ioctl.c
index cd506a902963..8f39e413f12a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -20,6 +20,8 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	struct blkpg_partition p;
 	long long start, length;
 
+	if (disk->flags & GENHD_FL_NO_PART)
+		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b9e9af84f518..1ead8c001561 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -526,18 +526,15 @@ int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 
 static bool disk_unlock_native_capacity(struct gendisk *disk)
 {
-	const struct block_device_operations *bdops = disk->fops;
-
-	if (bdops->unlock_native_capacity &&
-	    !(disk->flags & GENHD_FL_NATIVE_CAPACITY)) {
-		printk(KERN_CONT "enabling native capacity\n");
-		bdops->unlock_native_capacity(disk);
-		disk->flags |= GENHD_FL_NATIVE_CAPACITY;
-		return true;
-	} else {
+	if (!disk->fops->unlock_native_capacity ||
+	    test_and_set_bit(GD_NATIVE_CAPACITY, &disk->state)) {
 		printk(KERN_CONT "truncated\n");
 		return false;
 	}
+
+	printk(KERN_CONT "enabling native capacity\n");
+	disk->fops->unlock_native_capacity(disk);
+	return true;
 }
 
 void blk_drop_partitions(struct gendisk *disk)
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 3920c4b1e9c1..c390a79c5a66 100644
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
index 7fd56df8b919..99fe28663f94 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -128,6 +128,11 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 			goto out;
 	}
 
+	if (cert->unsupported_sig) {
+		ret = 0;
+		goto out;
+	}
+
 	ret = public_key_verify_signature(cert->pub, cert->sig);
 	if (ret < 0) {
 		if (ret == -ENOPKG) {
diff --git a/crypto/rsa-pkcs1pad.c b/crypto/rsa-pkcs1pad.c
index a4ebbb889274..e2f4ccbd71dd 100644
--- a/crypto/rsa-pkcs1pad.c
+++ b/crypto/rsa-pkcs1pad.c
@@ -574,6 +574,10 @@ static int pkcs1pad_init_tfm(struct crypto_akcipher *tfm)
 		return PTR_ERR(child_tfm);
 
 	ctx->child = child_tfm;
+
+	akcipher_set_reqsize(tfm, sizeof(struct pkcs1pad_request) +
+				  crypto_akcipher_reqsize(child_tfm));
+
 	return 0;
 }
 
@@ -669,7 +673,6 @@ static int pkcs1pad_create(struct crypto_template *tmpl, struct rtattr **tb)
 	inst->alg.set_pub_key = pkcs1pad_set_pub_key;
 	inst->alg.set_priv_key = pkcs1pad_set_priv_key;
 	inst->alg.max_size = pkcs1pad_get_max_size;
-	inst->alg.reqsize = sizeof(struct pkcs1pad_request) + rsa_alg->reqsize;
 
 	inst->free = pkcs1pad_free;
 
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 4a11a3876432..946e0160ad3b 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -121,17 +121,16 @@ static void lpi_device_get_constraints_amd(void)
 			acpi_handle_debug(lps0_device_handle,
 					  "LPI: constraints list begin:\n");
 
-			for (j = 0; j < package->package.count; ++j) {
+			for (j = 0; j < package->package.count; j++) {
 				union acpi_object *info_obj = &package->package.elements[j];
 				struct lpi_device_constraint_amd dev_info = {};
 				struct lpi_constraints *list;
 				acpi_status status;
 
-				for (k = 0; k < info_obj->package.count; ++k) {
-					union acpi_object *obj = &info_obj->package.elements[k];
+				list = &lpi_constraints_table[lpi_constraints_table_size];
 
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
+				for (k = 0; k < info_obj->package.count; k++) {
+					union acpi_object *obj = &info_obj->package.elements[k];
 
 					switch (k) {
 					case 0:
@@ -147,27 +146,21 @@ static void lpi_device_get_constraints_amd(void)
 						dev_info.min_dstate = obj->integer.value;
 						break;
 					}
+				}
 
-					if (!dev_info.enabled || !dev_info.name ||
-					    !dev_info.min_dstate)
-						continue;
+				if (!dev_info.enabled || !dev_info.name ||
+				    !dev_info.min_dstate)
+					continue;
 
-					status = acpi_get_handle(NULL, dev_info.name,
-								 &list->handle);
-					if (ACPI_FAILURE(status))
-						continue;
+				status = acpi_get_handle(NULL, dev_info.name, &list->handle);
+				if (ACPI_FAILURE(status))
+					continue;
 
-					acpi_handle_debug(lps0_device_handle,
-							  "Name:%s\n", dev_info.name);
+				acpi_handle_debug(lps0_device_handle,
+						  "Name:%s\n", dev_info.name);
 
-					list->min_dstate = dev_info.min_dstate;
+				list->min_dstate = dev_info.min_dstate;
 
-					if (list->min_dstate < 0) {
-						acpi_handle_debug(lps0_device_handle,
-								  "Incomplete constraint defined\n");
-						continue;
-					}
-				}
 				lpi_constraints_table_size++;
 			}
 		}
@@ -212,7 +205,7 @@ static void lpi_device_get_constraints(void)
 		if (!package)
 			continue;
 
-		for (j = 0; j < package->package.count; ++j) {
+		for (j = 0; j < package->package.count; j++) {
 			union acpi_object *element =
 					&(package->package.elements[j]);
 
@@ -244,7 +237,7 @@ static void lpi_device_get_constraints(void)
 
 		constraint->min_dstate = -1;
 
-		for (j = 0; j < package_count; ++j) {
+		for (j = 0; j < package_count; j++) {
 			union acpi_object *info_obj = &info.package[j];
 			union acpi_object *cnstr_pkg;
 			union acpi_object *obj;
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6c0f7f4f7d1d..1af5ff9231eb 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -366,6 +366,7 @@ static void amba_device_release(struct device *dev)
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
diff --git a/drivers/ata/pata_falcon.c b/drivers/ata/pata_falcon.c
index 121635aa8c00..a7745a2be905 100644
--- a/drivers/ata/pata_falcon.c
+++ b/drivers/ata/pata_falcon.c
@@ -123,8 +123,8 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	struct resource *base_res, *ctl_res, *irq_res;
 	struct ata_host *host;
 	struct ata_port *ap;
-	void __iomem *base;
-	int irq = 0;
+	void __iomem *base, *ctl_base;
+	int irq = 0, io_offset = 1, reg_shift = 2; /* Falcon defaults */
 
 	dev_info(&pdev->dev, "Atari Falcon and Q40/Q60 PATA controller\n");
 
@@ -165,26 +165,34 @@ static int __init pata_falcon_init_one(struct platform_device *pdev)
 	ap->pio_mask = ATA_PIO4;
 	ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
 
-	base = (void __iomem *)base_mem_res->start;
 	/* N.B. this assumes data_addr will be used for word-sized I/O only */
-	ap->ioaddr.data_addr		= base + 0 + 0 * 4;
-	ap->ioaddr.error_addr		= base + 1 + 1 * 4;
-	ap->ioaddr.feature_addr		= base + 1 + 1 * 4;
-	ap->ioaddr.nsect_addr		= base + 1 + 2 * 4;
-	ap->ioaddr.lbal_addr		= base + 1 + 3 * 4;
-	ap->ioaddr.lbam_addr		= base + 1 + 4 * 4;
-	ap->ioaddr.lbah_addr		= base + 1 + 5 * 4;
-	ap->ioaddr.device_addr		= base + 1 + 6 * 4;
-	ap->ioaddr.status_addr		= base + 1 + 7 * 4;
-	ap->ioaddr.command_addr		= base + 1 + 7 * 4;
-
-	base = (void __iomem *)ctl_mem_res->start;
-	ap->ioaddr.altstatus_addr	= base + 1;
-	ap->ioaddr.ctl_addr		= base + 1;
-
-	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
-		      (unsigned long)base_mem_res->start,
-		      (unsigned long)ctl_mem_res->start);
+	ap->ioaddr.data_addr = (void __iomem *)base_mem_res->start;
+
+	if (base_res) {		/* only Q40 has IO resources */
+		io_offset = 0x10000;
+		reg_shift = 0;
+		base = (void __iomem *)base_res->start;
+		ctl_base = (void __iomem *)ctl_res->start;
+	} else {
+		base = (void __iomem *)base_mem_res->start;
+		ctl_base = (void __iomem *)ctl_mem_res->start;
+	}
+
+	ap->ioaddr.error_addr	= base + io_offset + (1 << reg_shift);
+	ap->ioaddr.feature_addr	= base + io_offset + (1 << reg_shift);
+	ap->ioaddr.nsect_addr	= base + io_offset + (2 << reg_shift);
+	ap->ioaddr.lbal_addr	= base + io_offset + (3 << reg_shift);
+	ap->ioaddr.lbam_addr	= base + io_offset + (4 << reg_shift);
+	ap->ioaddr.lbah_addr	= base + io_offset + (5 << reg_shift);
+	ap->ioaddr.device_addr	= base + io_offset + (6 << reg_shift);
+	ap->ioaddr.status_addr	= base + io_offset + (7 << reg_shift);
+	ap->ioaddr.command_addr	= base + io_offset + (7 << reg_shift);
+
+	ap->ioaddr.altstatus_addr	= ctl_base + io_offset;
+	ap->ioaddr.ctl_addr		= ctl_base + io_offset;
+
+	ata_port_desc(ap, "cmd %px ctl %px data %px",
+		      base, ctl_base, ap->ioaddr.data_addr);
 
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq_res && irq_res->start > 0) {
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
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c96bdb3e7ac5..1d60d5ac0db8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1314,7 +1314,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	if (partscan)
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
 
 	/* enable and uncork uevent now that we are done */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
@@ -1463,7 +1463,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_flags = 0;
 	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 
@@ -1580,7 +1580,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (!err && (lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 	     !(prev_lo_flags & LO_FLAGS_PARTSCAN)) {
-		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART;
 		partscan = true;
 	}
 out_unlock:
@@ -2410,7 +2410,7 @@ static int loop_add(int i)
 	 * userspace tools. Parameters like this in general should be avoided.
 	 */
 	if (!part_shift)
-		disk->flags |= GENHD_FL_NO_PART_SCAN;
+		disk->flags |= GENHD_FL_NO_PART;
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	atomic_set(&lo->lo_refcnt, 0);
 	mutex_init(&lo->lo_mutex);
diff --git a/drivers/block/n64cart.c b/drivers/block/n64cart.c
index bcaabf038947..0bda4a468c66 100644
--- a/drivers/block/n64cart.c
+++ b/drivers/block/n64cart.c
@@ -137,7 +137,7 @@ static int __init n64cart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	disk->first_minor = 0;
-	disk->flags = GENHD_FL_NO_PART_SCAN;
+	disk->flags = GENHD_FL_NO_PART;
 	disk->fops = &n64cart_fops;
 	disk->private_data = &pdev->dev;
 	strcpy(disk->disk_name, "n64cart");
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index f9cdd11f02f5..91369084e127 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -183,8 +183,6 @@ static int pcd_audio_ioctl(struct cdrom_device_info *cdi,
 static int pcd_packet(struct cdrom_device_info *cdi,
 		      struct packet_command *cgc);
 
-static int pcd_detect(void);
-static void pcd_probe_capabilities(void);
 static void do_pcd_read_drq(void);
 static blk_status_t pcd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd);
@@ -302,53 +300,6 @@ static const struct blk_mq_ops pcd_mq_ops = {
 	.queue_rq	= pcd_queue_rq,
 };
 
-static void pcd_init_units(void)
-{
-	struct pcd_unit *cd;
-	int unit;
-
-	pcd_drive_count = 0;
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-		struct gendisk *disk;
-
-		if (blk_mq_alloc_sq_tag_set(&cd->tag_set, &pcd_mq_ops, 1,
-				BLK_MQ_F_SHOULD_MERGE))
-			continue;
-
-		disk = blk_mq_alloc_disk(&cd->tag_set, cd);
-		if (IS_ERR(disk)) {
-			blk_mq_free_tag_set(&cd->tag_set);
-			continue;
-		}
-
-		INIT_LIST_HEAD(&cd->rq_list);
-		blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
-		cd->disk = disk;
-		cd->pi = &cd->pia;
-		cd->present = 0;
-		cd->last_sense = 0;
-		cd->changed = 1;
-		cd->drive = (*drives[unit])[D_SLV];
-		if ((*drives[unit])[D_PRT])
-			pcd_drive_count++;
-
-		cd->name = &cd->info.name[0];
-		snprintf(cd->name, sizeof(cd->info.name), "%s%d", name, unit);
-		cd->info.ops = &pcd_dops;
-		cd->info.handle = cd;
-		cd->info.speed = 0;
-		cd->info.capacity = 1;
-		cd->info.mask = 0;
-		disk->major = major;
-		disk->first_minor = unit;
-		disk->minors = 1;
-		strcpy(disk->disk_name, cd->name);	/* umm... */
-		disk->fops = &pcd_bdops;
-		disk->flags = GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
-		disk->events = DISK_EVENT_MEDIA_CHANGE;
-	}
-}
-
 static int pcd_open(struct cdrom_device_info *cdi, int purpose)
 {
 	struct pcd_unit *cd = cdi->handle;
@@ -630,10 +581,11 @@ static int pcd_drive_status(struct cdrom_device_info *cdi, int slot_nr)
 	return CDS_DISC_OK;
 }
 
-static int pcd_identify(struct pcd_unit *cd, char *id)
+static int pcd_identify(struct pcd_unit *cd)
 {
-	int k, s;
 	char id_cmd[12] = { 0x12, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0 };
+	char id[18];
+	int k, s;
 
 	pcd_bufblk = -1;
 
@@ -661,108 +613,47 @@ static int pcd_identify(struct pcd_unit *cd, char *id)
 }
 
 /*
- * returns  0, with id set if drive is detected
- *	    -1, if drive detection failed
+ * returns 0, with id set if drive is detected, otherwise an error code.
  */
-static int pcd_probe(struct pcd_unit *cd, int ms, char *id)
+static int pcd_probe(struct pcd_unit *cd, int ms)
 {
 	if (ms == -1) {
 		for (cd->drive = 0; cd->drive <= 1; cd->drive++)
-			if (!pcd_reset(cd) && !pcd_identify(cd, id))
+			if (!pcd_reset(cd) && !pcd_identify(cd))
 				return 0;
 	} else {
 		cd->drive = ms;
-		if (!pcd_reset(cd) && !pcd_identify(cd, id))
+		if (!pcd_reset(cd) && !pcd_identify(cd))
 			return 0;
 	}
-	return -1;
+	return -ENODEV;
 }
 
-static void pcd_probe_capabilities(void)
+static int pcd_probe_capabilities(struct pcd_unit *cd)
 {
-	int unit, r;
-	char buffer[32];
 	char cmd[12] = { 0x5a, 1 << 3, 0x2a, 0, 0, 0, 0, 18, 0, 0, 0, 0 };
-	struct pcd_unit *cd;
-
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-		if (!cd->present)
-			continue;
-		r = pcd_atapi(cd, cmd, 18, buffer, "mode sense capabilities");
-		if (r)
-			continue;
-		/* we should now have the cap page */
-		if ((buffer[11] & 1) == 0)
-			cd->info.mask |= CDC_CD_R;
-		if ((buffer[11] & 2) == 0)
-			cd->info.mask |= CDC_CD_RW;
-		if ((buffer[12] & 1) == 0)
-			cd->info.mask |= CDC_PLAY_AUDIO;
-		if ((buffer[14] & 1) == 0)
-			cd->info.mask |= CDC_LOCK;
-		if ((buffer[14] & 8) == 0)
-			cd->info.mask |= CDC_OPEN_TRAY;
-		if ((buffer[14] >> 6) == 0)
-			cd->info.mask |= CDC_CLOSE_TRAY;
-	}
-}
-
-static int pcd_detect(void)
-{
-	char id[18];
-	int k, unit;
-	struct pcd_unit *cd;
+	char buffer[32];
+	int ret;
 
-	printk("%s: %s version %s, major %d, nice %d\n",
-	       name, name, PCD_VERSION, major, nice);
+	ret = pcd_atapi(cd, cmd, 18, buffer, "mode sense capabilities");
+	if (ret)
+		return ret;
+
+	/* we should now have the cap page */
+	if ((buffer[11] & 1) == 0)
+		cd->info.mask |= CDC_CD_R;
+	if ((buffer[11] & 2) == 0)
+		cd->info.mask |= CDC_CD_RW;
+	if ((buffer[12] & 1) == 0)
+		cd->info.mask |= CDC_PLAY_AUDIO;
+	if ((buffer[14] & 1) == 0)
+		cd->info.mask |= CDC_LOCK;
+	if ((buffer[14] & 8) == 0)
+		cd->info.mask |= CDC_OPEN_TRAY;
+	if ((buffer[14] >> 6) == 0)
+		cd->info.mask |= CDC_CLOSE_TRAY;
 
-	par_drv = pi_register_driver(name);
-	if (!par_drv) {
-		pr_err("failed to register %s driver\n", name);
-		return -1;
-	}
-
-	k = 0;
-	if (pcd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
-		cd = pcd;
-		if (cd->disk && pi_init(cd->pi, 1, -1, -1, -1, -1, -1,
-			    pcd_buffer, PI_PCD, verbose, cd->name)) {
-			if (!pcd_probe(cd, -1, id)) {
-				cd->present = 1;
-				k++;
-			} else
-				pi_release(cd->pi);
-		}
-	} else {
-		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-			int *conf = *drives[unit];
-			if (!conf[D_PRT])
-				continue;
-			if (!cd->disk)
-				continue;
-			if (!pi_init(cd->pi, 0, conf[D_PRT], conf[D_MOD],
-				     conf[D_UNI], conf[D_PRO], conf[D_DLY],
-				     pcd_buffer, PI_PCD, verbose, cd->name)) 
-				continue;
-			if (!pcd_probe(cd, conf[D_SLV], id)) {
-				cd->present = 1;
-				k++;
-			} else
-				pi_release(cd->pi);
-		}
-	}
-	if (k)
-		return 0;
-
-	printk("%s: No CD-ROM drive found\n", name);
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-		if (!cd->disk)
-			continue;
-		blk_cleanup_disk(cd->disk);
-		blk_mq_free_tag_set(&cd->tag_set);
-	}
-	pi_unregister_driver(par_drv);
-	return -1;
+	return 0;
 }
 
 /* I/O request processing */
@@ -999,43 +890,124 @@ static int pcd_get_mcn(struct cdrom_device_info *cdi, struct cdrom_mcn *mcn)
 	return 0;
 }
 
+static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
+		int mode, int unit, int protocol, int delay, int ms)
+{
+	struct gendisk *disk;
+	int ret;
+
+	ret = blk_mq_alloc_sq_tag_set(&cd->tag_set, &pcd_mq_ops, 1,
+				      BLK_MQ_F_SHOULD_MERGE);
+	if (ret)
+		return ret;
+
+	disk = blk_mq_alloc_disk(&cd->tag_set, cd);
+	if (IS_ERR(disk)) {
+		ret = PTR_ERR(disk);
+		goto out_free_tag_set;
+	}
+
+	INIT_LIST_HEAD(&cd->rq_list);
+	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
+	cd->disk = disk;
+	cd->pi = &cd->pia;
+	cd->present = 0;
+	cd->last_sense = 0;
+	cd->changed = 1;
+	cd->drive = (*drives[cd - pcd])[D_SLV];
+
+	cd->name = &cd->info.name[0];
+	snprintf(cd->name, sizeof(cd->info.name), "%s%d", name, unit);
+	cd->info.ops = &pcd_dops;
+	cd->info.handle = cd;
+	cd->info.speed = 0;
+	cd->info.capacity = 1;
+	cd->info.mask = 0;
+	disk->major = major;
+	disk->first_minor = unit;
+	disk->minors = 1;
+	strcpy(disk->disk_name, cd->name);	/* umm... */
+	disk->fops = &pcd_bdops;
+	disk->events = DISK_EVENT_MEDIA_CHANGE;
+	disk->event_flags = DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE;
+
+	if (!pi_init(cd->pi, autoprobe, port, mode, unit, protocol, delay,
+			pcd_buffer, PI_PCD, verbose, cd->name)) {
+		ret = -ENODEV;
+		goto out_free_disk;
+	}
+	ret = pcd_probe(cd, ms);
+	if (ret)
+		goto out_pi_release;
+
+	cd->present = 1;
+	pcd_probe_capabilities(cd);
+	register_cdrom(cd->disk, &cd->info);
+	add_disk(cd->disk);
+	return 0;
+
+out_pi_release:
+	pi_release(cd->pi);
+out_free_disk:
+	blk_cleanup_disk(cd->disk);
+out_free_tag_set:
+	blk_mq_free_tag_set(&cd->tag_set);
+	return ret;
+}
+
 static int __init pcd_init(void)
 {
-	struct pcd_unit *cd;
-	int unit;
+	int found = 0, unit;
 
 	if (disable)
 		return -EINVAL;
 
-	pcd_init_units();
+	if (register_blkdev(major, name))
+		return -EBUSY;
 
-	if (pcd_detect())
-		return -ENODEV;
+	pr_info("%s: %s version %s, major %d, nice %d\n",
+		name, name, PCD_VERSION, major, nice);
 
-	/* get the atapi capabilities page */
-	pcd_probe_capabilities();
+	par_drv = pi_register_driver(name);
+	if (!par_drv) {
+		pr_err("failed to register %s driver\n", name);
+		goto out_unregister_blkdev;
+	}
 
-	if (register_blkdev(major, name)) {
-		for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-			if (!cd->disk)
-				continue;
+	for (unit = 0; unit < PCD_UNITS; unit++) {
+		if ((*drives[unit])[D_PRT])
+			pcd_drive_count++;
+	}
+
+	if (pcd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
+		if (!pcd_init_unit(pcd, 1, -1, -1, -1, -1, -1, -1))
+			found++;
+	} else {
+		for (unit = 0; unit < PCD_UNITS; unit++) {
+			struct pcd_unit *cd = &pcd[unit];
+			int *conf = *drives[unit];
 
-			blk_cleanup_queue(cd->disk->queue);
-			blk_mq_free_tag_set(&cd->tag_set);
-			put_disk(cd->disk);
+			if (!conf[D_PRT])
+				continue;
+			if (!pcd_init_unit(cd, 0, conf[D_PRT], conf[D_MOD],
+					conf[D_UNI], conf[D_PRO], conf[D_DLY],
+					conf[D_SLV]))
+				found++;
 		}
-		return -EBUSY;
 	}
 
-	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-		if (cd->present) {
-			register_cdrom(cd->disk, &cd->info);
-			cd->disk->private_data = cd;
-			add_disk(cd->disk);
-		}
+	if (!found) {
+		pr_info("%s: No CD-ROM drive found\n", name);
+		goto out_unregister_pi_driver;
 	}
 
 	return 0;
+
+out_unregister_pi_driver:
+	pi_unregister_driver(par_drv);
+out_unregister_blkdev:
+	unregister_blkdev(major, name);
+	return -ENODEV;
 }
 
 static void __exit pcd_exit(void)
@@ -1044,20 +1016,18 @@ static void __exit pcd_exit(void)
 	int unit;
 
 	for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
-		if (!cd->disk)
+		if (!cd->present)
 			continue;
 
-		if (cd->present) {
-			del_gendisk(cd->disk);
-			pi_release(cd->pi);
-			unregister_cdrom(&cd->info);
-		}
-		blk_cleanup_queue(cd->disk->queue);
+		del_gendisk(cd->disk);
+		pi_release(cd->pi);
+		unregister_cdrom(&cd->info);
+		blk_cleanup_disk(cd->disk);
+
 		blk_mq_free_tag_set(&cd->tag_set);
-		put_disk(cd->disk);
 	}
-	unregister_blkdev(major, name);
 	pi_unregister_driver(par_drv);
+	unregister_blkdev(major, name);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15d253325fd8..84a42348b3bc 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1756,7 +1756,7 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
index 1a87b9c6c2f8..470dddca025d 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -466,6 +466,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 
 	/* Trigger MHI RESET so that the device will not access host memory */
 	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
+		/* Skip MHI RESET if in RDDM state */
+		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
+			goto skip_mhi_reset;
+
 		dev_dbg(dev, "Triggering MHI Reset in device\n");
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 
@@ -483,6 +487,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
 	}
 
+skip_mhi_reset:
 	dev_dbg(dev,
 		 "Waiting for all pending event ring processing to complete\n");
 	mhi_event = mhi_cntrl->mhi_event;
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 71b541538801..436c0f3563d7 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3055,7 +3055,7 @@ static int sysc_init_static_data(struct sysc *ddata)
 
 	match = soc_device_match(sysc_soc_match);
 	if (match && match->data)
-		sysc_soc->soc = (int)match->data;
+		sysc_soc->soc = (enum sysc_soc)(uintptr_t)match->data;
 
 	/*
 	 * Check and warn about possible old incomplete dtb. We now want to see
diff --git a/drivers/char/hw_random/iproc-rng200.c b/drivers/char/hw_random/iproc-rng200.c
index a43743887db1..9142a63b92b3 100644
--- a/drivers/char/hw_random/iproc-rng200.c
+++ b/drivers/char/hw_random/iproc-rng200.c
@@ -189,6 +189,8 @@ static int iproc_rng200_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 	}
 
+	dev_set_drvdata(dev, priv);
+
 	priv->rng.name = "iproc-rng200";
 	priv->rng.read = iproc_rng200_read;
 	priv->rng.init = iproc_rng200_init;
@@ -206,6 +208,28 @@ static int iproc_rng200_probe(struct platform_device *pdev)
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
@@ -219,6 +243,7 @@ static struct platform_driver iproc_rng200_driver = {
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
diff --git a/drivers/char/hw_random/pic32-rng.c b/drivers/char/hw_random/pic32-rng.c
index 99c8bd0859a1..e04a054e8930 100644
--- a/drivers/char/hw_random/pic32-rng.c
+++ b/drivers/char/hw_random/pic32-rng.c
@@ -36,7 +36,6 @@
 struct pic32_rng {
 	void __iomem	*base;
 	struct hwrng	rng;
-	struct clk	*clk;
 };
 
 /*
@@ -70,6 +69,7 @@ static int pic32_rng_read(struct hwrng *rng, void *buf, size_t max,
 static int pic32_rng_probe(struct platform_device *pdev)
 {
 	struct pic32_rng *priv;
+	struct clk *clk;
 	u32 v;
 	int ret;
 
@@ -81,13 +81,9 @@ static int pic32_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		return ret;
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* enable TRNG in enhanced mode */
 	v = TRNGEN | TRNGMOD;
@@ -98,15 +94,11 @@ static int pic32_rng_probe(struct platform_device *pdev)
 
 	ret = devm_hwrng_register(&pdev->dev, &priv->rng);
 	if (ret)
-		goto err_register;
+		return ret;
 
 	platform_set_drvdata(pdev, priv);
 
 	return 0;
-
-err_register:
-	clk_disable_unprepare(priv->clk);
-	return ret;
 }
 
 static int pic32_rng_remove(struct platform_device *pdev)
@@ -114,7 +106,6 @@ static int pic32_rng_remove(struct platform_device *pdev)
 	struct pic32_rng *rng = platform_get_drvdata(pdev);
 
 	writel(0, rng->base + RNGCON);
-	clk_disable_unprepare(rng->clk);
 	return 0;
 }
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 17255e705cb0..f4360fbddbff 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2081,6 +2081,11 @@ static int try_smi_init(struct smi_info *new_smi)
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
index 100e474ff3dc..d12465c22751 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -380,6 +380,7 @@ config COMMON_CLK_BD718XX
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
index 0191457fb3cf..2f898c0bc867 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -176,10 +176,6 @@ static const char * const imx8mp_sai3_sels[] = {"osc_24m", "audio_pll1_out", "au
 						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext3", "clk_ext4", };
 
-static const char * const imx8mp_sai4_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
-						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
-						"clk_ext1", "clk_ext2", };
-
 static const char * const imx8mp_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
 						"video_pll1_out", "sys_pll1_133m", "osc_hdmi",
 						"clk_ext2", "clk_ext3", };
@@ -566,7 +562,6 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mp_sai1_sels, ccm_base + 0xa580);
 	hws[IMX8MP_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mp_sai2_sels, ccm_base + 0xa600);
 	hws[IMX8MP_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mp_sai3_sels, ccm_base + 0xa680);
-	hws[IMX8MP_CLK_SAI4] = imx8m_clk_hw_composite("sai4", imx8mp_sai4_sels, ccm_base + 0xa700);
 	hws[IMX8MP_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mp_sai5_sels, ccm_base + 0xa780);
 	hws[IMX8MP_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mp_sai6_sels, ccm_base + 0xa800);
 	hws[IMX8MP_CLK_ENET_QOS] = imx8m_clk_hw_composite("enet_qos", imx8mp_enet_qos_sels, ccm_base + 0xa880);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 2b5ed86b9dbb..483f496f437a 100644
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
diff --git a/drivers/clk/qcom/camcc-sc7180.c b/drivers/clk/qcom/camcc-sc7180.c
index 4b3e3902b7ee..ee99e3a85312 100644
--- a/drivers/clk/qcom/camcc-sc7180.c
+++ b/drivers/clk/qcom/camcc-sc7180.c
@@ -1677,7 +1677,7 @@ static int cam_cc_sc7180_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pm_runtime_get(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret)
 		return ret;
 
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
index c2ea09945c47..a38394b4739a 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -667,6 +667,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 3236706771b1..e32ad7499285 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -640,6 +640,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index a0ba37656b07..30bd56146107 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -721,6 +721,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
diff --git a/drivers/clk/qcom/mss-sc7180.c b/drivers/clk/qcom/mss-sc7180.c
index 5a1407440662..d106bc65470e 100644
--- a/drivers/clk/qcom/mss-sc7180.c
+++ b/drivers/clk/qcom/mss-sc7180.c
@@ -87,11 +87,22 @@ static int mss_sc7180_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &mss_sc7180_desc);
 	if (ret < 0)
-		return ret;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
+	return ret;
 }
 
 static const struct dev_pm_ops mss_sc7180_pm_ops = {
diff --git a/drivers/clk/qcom/q6sstop-qcs404.c b/drivers/clk/qcom/q6sstop-qcs404.c
index 507386bee07d..eb86fec29927 100644
--- a/drivers/clk/qcom/q6sstop-qcs404.c
+++ b/drivers/clk/qcom/q6sstop-qcs404.c
@@ -173,21 +173,32 @@ static int q6sstopcc_qcs404_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	q6sstop_regmap_config.name = "q6sstop_tcsr";
 	desc = &tcsr_qcs404_desc;
 
 	ret = qcom_cc_probe_by_index(pdev, 1, desc);
 	if (ret)
-		return ret;
+		goto err_put_rpm;
 
 	q6sstop_regmap_config.name = "q6sstop_cc";
 	desc = &q6sstop_qcs404_desc;
 
 	ret = qcom_cc_probe_by_index(pdev, 0, desc);
 	if (ret)
-		return ret;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
+	return ret;
 }
 
 static const struct dev_pm_ops q6sstopcc_pm_ops = {
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
diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
index 4543bda793f4..c76d36a1fcfd 100644
--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -124,11 +124,22 @@ static int turingcc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = qcom_cc_probe(pdev, &turingcc_desc);
 	if (ret < 0)
-		return ret;
+		goto err_put_rpm;
+
+	pm_runtime_put(&pdev->dev);
 
 	return 0;
+
+err_put_rpm:
+	pm_runtime_put_sync(&pdev->dev);
+
+	return ret;
 }
 
 static const struct dev_pm_ops turingcc_pm_ops = {
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
index ae7b95e15ac7..c2227be7bad8 100644
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
index 12ab4014af71..94fe0e15623e 100644
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
index 7e7ab5597d7a..0590001db653 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -410,13 +410,7 @@ static int __init pseries_idle_probe(void)
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
index 886727576710..51b48b57266a 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -223,7 +223,9 @@ static int caam_rsa_count_leading_zeros(struct scatterlist *sgl,
 		if (len && *buff)
 			break;
 
-		sg_miter_next(&miter);
+		if (!sg_miter_next(&miter))
+			break;
+
 		buff = miter.addr;
 		len = miter.length;
 
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d33006d43f76..4df5330afaa1 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -565,9 +565,9 @@ static int stm32_hash_dma_send(struct stm32_hash_dev *hdev)
 	}
 
 	for_each_sg(rctx->sg, tsg, rctx->nents, i) {
+		sg[0] = *tsg;
 		len = sg->length;
 
-		sg[0] = *tsg;
 		if (sg_is_last(sg)) {
 			if (hdev->dma_mode == 1) {
 				len = (ALIGN(sg->length, 16) - 16);
@@ -1566,9 +1566,7 @@ static int stm32_hash_remove(struct platform_device *pdev)
 	if (!hdev)
 		return -ENODEV;
 
-	ret = pm_runtime_resume_and_get(hdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(hdev->dev);
 
 	stm32_hash_unregister_algs(hdev);
 
@@ -1584,7 +1582,8 @@ static int stm32_hash_remove(struct platform_device *pdev)
 	pm_runtime_disable(hdev->dev);
 	pm_runtime_put_noidle(hdev->dev);
 
-	clk_disable_unprepare(hdev->clk);
+	if (ret >= 0)
+		clk_disable_unprepare(hdev->clk);
 
 	return 0;
 }
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a473b640c40a..29a14b0ffe33 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -762,6 +762,7 @@ static void devfreq_dev_release(struct device *dev)
 		dev_pm_opp_put_opp_table(devfreq->opp_table);
 
 	mutex_destroy(&devfreq->lock);
+	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
 }
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 95344ae49e53..e1beddcc8c84 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -202,6 +202,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -271,6 +272,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f9f30cbeccbe..941a7ef475f4 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -9,6 +9,7 @@
  * Copyright 2012 Javier Martin, Vista Silicon <javier.martin@vista-silicon.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -143,8 +144,8 @@ struct rz_dmac {
 #define CHCFG_REQD			BIT(3)
 #define CHCFG_SEL(bits)			((bits) & 0x07)
 #define CHCFG_MEM_COPY			(0x80400008)
-#define CHCFG_FILL_DDS(a)		(((a) << 16) & GENMASK(19, 16))
-#define CHCFG_FILL_SDS(a)		(((a) << 12) & GENMASK(15, 12))
+#define CHCFG_FILL_DDS_MASK		GENMASK(19, 16)
+#define CHCFG_FILL_SDS_MASK		GENMASK(15, 12)
 #define CHCFG_FILL_TM(a)		(((a) & BIT(5)) << 22)
 #define CHCFG_FILL_AM(a)		(((a) & GENMASK(4, 2)) << 6)
 #define CHCFG_FILL_LVL(a)		(((a) & BIT(1)) << 5)
@@ -607,13 +608,15 @@ static int rz_dmac_config(struct dma_chan *chan,
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_DDS(val);
+	channel->chcfg &= ~CHCFG_FILL_DDS_MASK;
+	channel->chcfg |= FIELD_PREP(CHCFG_FILL_DDS_MASK, val);
 
 	val = rz_dmac_ds_to_val_mapping(config->src_addr_width);
 	if (val == CHCFG_DS_INVALID)
 		return -EINVAL;
 
-	channel->chcfg |= CHCFG_FILL_SDS(val);
+	channel->chcfg &= ~CHCFG_FILL_SDS_MASK;
+	channel->chcfg |= FIELD_PREP(CHCFG_FILL_SDS_MASK, val);
 
 	return 0;
 }
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e1827393143f..cb6b0e9ed5ad 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3597,6 +3597,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	spin_lock_init(&base->lcla_pool.lock);
 
 	base->irq = platform_get_irq(pdev, 0);
+	if (base->irq < 0) {
+		ret = base->irq;
+		goto destroy_cache;
+	}
 
 	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index a07bbfd075d0..8ec70da8d84f 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -27,7 +27,7 @@
 #include "edac_mc.h"
 #include "edac_module.h"
 
-#define IGEN6_REVISION	"v2.5"
+#define IGEN6_REVISION	"v2.5.1"
 
 #define EDAC_MOD_STR	"igen6_edac"
 #define IGEN6_NMI_NAME	"igen6_ibecc"
@@ -1216,9 +1216,6 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&ecclog_work, ecclog_work_cb);
 	init_irq_work(&ecclog_irq_work, ecclog_irq_work_cb);
 
-	/* Check if any pending errors before registering the NMI handler */
-	ecclog_handler();
-
 	rc = register_err_handler();
 	if (rc)
 		goto fail3;
@@ -1230,6 +1227,9 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto fail4;
 	}
 
+	/* Check if any pending errors before/during the registration of the error handler */
+	ecclog_handler();
+
 	igen6_debug_setup();
 	return 0;
 fail4:
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index f9040bd61081..285fe7ad490d 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1095,3 +1095,22 @@ int sdei_event_handler(struct pt_regs *regs,
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
index 72162645b553..1cb4466e3c10 100644
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
index 77aa5c6398aa..d081a6312627 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -292,6 +292,8 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip = of_match_device(meson_sm_ids, dev)->data;
+	if (!chip)
+		return -EINVAL;
 
 	if (chip->cmd_shmem_in_base) {
 		fw->sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 0bed2fab8055..a3645da1f1bf 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -453,6 +453,8 @@ static ssize_t cfam_reset_store(struct device *dev, struct device_attribute *att
 	gpiod_set_value(aspeed->cfam_reset_gpio, 1);
 	usleep_range(900, 1000);
 	gpiod_set_value(aspeed->cfam_reset_gpio, 0);
+	usleep_range(900, 1000);
+	opb_writel(aspeed, ctrl_base + FSI_MRESP0, cpu_to_be32(FSI_MRESP_RST_ALL_MASTER));
 	mutex_unlock(&aspeed->lock);
 
 	return count;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b5766d3789b..8b6b47fd9b88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1195,6 +1195,9 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	u16 cmd;
 	int r;
 
+	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
+		return 0;
+
 	/* Bypass for VF */
 	if (amdgpu_sriov_vf(adev))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 43e30b9a2e02..e8485b1f02ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -582,6 +582,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			crtc = (struct drm_crtc *)minfo->crtcs[i];
 			if (crtc && crtc->base.id == info->mode_crtc.id) {
 				struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+
 				ui32 = amdgpu_crtc->crtc_id;
 				found = 1;
 				break;
@@ -600,7 +601,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		if (ret)
 			return ret;
 
-		ret = copy_to_user(out, &ip, min((size_t)size, sizeof(ip)));
+		ret = copy_to_user(out, &ip, min_t(size_t, size, sizeof(ip)));
 		return ret ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_HW_IP_COUNT: {
@@ -748,17 +749,18 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
@@ -882,7 +884,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		return ret;
 	}
 	case AMDGPU_INFO_VCE_CLOCK_TABLE: {
-		unsigned i;
+		unsigned int i;
 		struct drm_amdgpu_info_vce_clock_table vce_clk_table = {};
 		struct amd_vce_state *vce_state;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 788611a50a68..0e4554950e07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2260,7 +2260,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	amdgpu_vm_bo_base_init(&bo_va->base, vm, bo);
 
 	bo_va->ref_count = 1;
-	bo_va->last_pt_update = dma_fence_get_stub();
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
@@ -2975,8 +2974,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	else
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
-
-	vm->last_update = dma_fence_get_stub();
+	vm->last_update = NULL;
 	vm->last_unlocked = dma_fence_get_stub();
 
 	mutex_init(&vm->eviction_lock);
@@ -3119,7 +3117,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
 	dma_fence_put(vm->last_update);
-	vm->last_update = dma_fence_get_stub();
+	vm->last_update = NULL;
 	vm->is_compute_context = true;
 
 	/* Free the shadow bo for compute VM */
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index de6d10390ab2..9be6da37032a 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1574,17 +1574,8 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
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
@@ -1637,21 +1628,14 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
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
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 47a500f64db2..bcf356df1ef3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -101,14 +101,15 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	int ret;
 	int retry_loop;
 
+	/* Wait for bootloader to signify that it is ready having bit 31 of
+	 * C2PMSG_35 set to 1. All other bits are expected to be cleared.
+	 * If there is an error in processing command, bits[7:0] will be set.
+	 * This is applicable for PSP v13.0.6 and newer.
+	 */
 	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
-		/* Wait for bootloader to signify that is
-		    ready having bit 31 of C2PMSG_35 set to 1 */
-		ret = psp_wait_for(psp,
-				   SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
-				   0x80000000,
-				   0x80000000,
-				   false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
+			0x80000000, 0xffffffff, false);
 
 		if (ret == 0)
 			return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 7f99e130acd0..fd34c2100bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2276,17 +2276,8 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
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
@@ -2331,21 +2322,14 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 
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
index 46d7e75e4553..52142d272c86 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1744,10 +1744,13 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
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
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 1);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index 8192f1967e92..d3681db36c30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -207,8 +207,9 @@ struct mpcc *mpc1_insert_plane(
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
index 4bee6d018bfa..6230861e78d1 100644
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
index 6aaf1230655f..73794c1c1208 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2134,15 +2134,19 @@ static int amdgpu_device_attr_create(struct amdgpu_device *adev,
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
 
 	attr_update = attr->attr_update ? attr->attr_update : default_attr_update;
 
diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index 424250535fed..0383deb970bb 100644
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
@@ -451,8 +453,8 @@ static int armada_overlay_get_property(struct drm_plane *plane,
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
index b5d92f652fd8..1dac7f987a61 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -291,7 +291,7 @@ static void ast_init_dram_reg(struct drm_device *dev)
 				;
 			} while (ast_read32(ast, 0x10100) != 0xa8);
 		} else {/* AST2100/1100 */
-			if (ast->chip == AST2100 || ast->chip == 2200)
+			if (ast->chip == AST2100 || ast->chip == AST2200)
 				dram_reg_info = ast2100_dram_table_data;
 			else
 				dram_reg_info = ast1100_dram_table_data;
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 44762116aac9..ce40cd1ae167 100644
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
index c1e35bdf9232..ba4e869f58a4 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -181,7 +181,7 @@ static void tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)
 	if (ret >= 0)
 		le32_to_cpus(val);
 
-	dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
+	dev_dbg(ctx->dev, "read: addr=0x%04x data=0x%08x\n", addr, *val);
 }
 
 static void tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
index f418e0b75772..0edcf8ceb4a7 100644
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
index 7ea7abef6143..0344a0eef95c 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -2864,24 +2864,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old)
 	ggtt_invalidate(gvt->gt);
 }
 
-/**
- * intel_vgpu_reset_gtt - reset the all GTT related status
- * @vgpu: a vGPU
- *
- * This function is called from vfio core to reset reset all
- * GTT related status, including GGTT, PPGTT, scratch page.
- *
- */
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu)
-{
-	/* Shadow pages are only created when there is no page
-	 * table tracking data, so remove page tracking data after
-	 * removing the shadow pages.
-	 */
-	intel_vgpu_destroy_all_ppgtt_mm(vgpu);
-	intel_vgpu_reset_ggtt(vgpu, true);
-}
-
 /**
  * intel_gvt_restore_ggtt - restore all vGPU's ggtt entries
  * @gvt: intel gvt device
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index 3bf45672ef98..8e8fe2118624 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -224,7 +224,6 @@ void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old);
 void intel_vgpu_invalidate_ppgtt(struct intel_vgpu *vgpu);
 
 int intel_gvt_init_gtt(struct intel_gvt *gvt);
-void intel_vgpu_reset_gtt(struct intel_vgpu *vgpu);
 void intel_gvt_clean_gtt(struct intel_gvt *gvt);
 
 struct intel_vgpu_mm *intel_gvt_find_ppgtt_mm(struct intel_vgpu *vgpu,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 6497c9fcd2af..0b93013061e6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -116,10 +116,9 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
 	dma_addr_t dma_addr;
 
 	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
+	if (!pkt->va_base)
 		return -ENOMEM;
-	}
+
 	pkt->buf_size = size;
 	pkt->cl = (void *)client;
 
@@ -129,7 +128,6 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
 	if (dma_mapping_error(dev, dma_addr)) {
 		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
 		kfree(pkt->va_base);
-		kfree(pkt);
 		return -ENOMEM;
 	}
 
@@ -145,7 +143,6 @@ static void mtk_drm_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
 	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
 			 DMA_TO_DEVICE);
 	kfree(pkt->va_base);
-	kfree(pkt);
 }
 #endif
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 726a34c4725c..b983adffa392 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -242,7 +242,11 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 
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
 	dma_buf_map_set_vaddr(map, mtk_gem->kvaddr);
diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index bdc989183c64..17d6a1ecb111 100644
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
 		if (!allow_vram_carveout) {
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 9c42776cb9a8..f9cae6460c3b 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -128,8 +128,7 @@ static void mdp5_plane_destroy_state(struct drm_plane *plane,
 {
 	struct mdp5_plane_state *pstate = to_mdp5_plane_state(state);
 
-	if (state->fb)
-		drm_framebuffer_put(state->fb);
+	__drm_atomic_helper_plane_destroy_state(state);
 
 	kfree(pstate);
 }
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 369e57f73a47..8746ceae8fca 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -185,5 +185,5 @@ void msm_disp_snapshot_add_block(struct msm_disp_state *disp_state, u32 len,
 	new_blk->base_addr = base_addr;
 
 	msm_disp_state_dump_regs(&new_blk->state, new_blk->size, base_addr);
-	list_add(&new_blk->node, &disp_state->blocks);
+	list_add_tail(&new_blk->node, &disp_state->blocks);
 }
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7cf0af78b7bc..e58eb93e9bc9 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1448,7 +1448,9 @@ static const struct panel_desc auo_t215hvn01 = {
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
index 81b4de7be9f2..a42f29b6ed7c 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -9534,17 +9534,8 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
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
@@ -9591,21 +9582,14 @@ static void cik_pcie_gen3_enable(struct radeon_device *rdev)
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
index 013e44ed0f39..4679b798a038 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -7131,17 +7131,8 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
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
@@ -7188,22 +7179,14 @@ static void si_pcie_gen3_enable(struct radeon_device *rdev)
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
index 1f96e416fa08..c96c07c6458c 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -468,7 +468,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 
 	dpaux->irq = platform_get_irq(pdev, 0);
 	if (dpaux->irq < 0)
-		return -ENXIO;
+		return dpaux->irq;
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index ac37053412a1..5bb42d0a2de9 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -200,7 +200,9 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	dpsub->dev = &pdev->dev;
 	platform_set_drvdata(pdev, dpsub);
 
-	dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
+	ret = dma_set_mask(dpsub->dev, DMA_BIT_MASK(ZYNQMP_DISP_MAX_DMA_BIT));
+	if (ret)
+		return ret;
 
 	/* Try the reserved memory. Proceed if there's none. */
 	of_reserved_mem_device_init(&pdev->dev);
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index c358778e070b..08768e5acced 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1285,6 +1285,9 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 		 * 50 msec should gives enough time to the receiver to be ready.
 		 */
 		msleep(50);
+
+		if (retval)
+			return retval;
 	}
 
 	/*
@@ -1306,7 +1309,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
 	buf[5] = 0x09;
 	buf[6] = 0x00;
 
-	hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
+	retval = hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
 			HIDPP_REPORT_SHORT_LENGTH, HID_OUTPUT_REPORT,
 			HID_REQ_SET_REPORT);
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 592ffdd546fb..a5bc11750bdc 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1594,7 +1594,6 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app)
 static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	char *name;
 	const char *suffix = NULL;
 	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
@@ -1648,15 +1647,9 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
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
index cd0fb7bfba68..e9c2b0796f37 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -428,7 +428,7 @@ static int tmc_set_etf_buffer(struct coresight_device *csdev,
 		return -EINVAL;
 
 	/* wrap head around to the amount of space we have */
-	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+	head = handle->head & (((unsigned long)buf->nr_pages << PAGE_SHIFT) - 1);
 
 	/* find the page to write to */
 	buf->cur = head / PAGE_SIZE;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 0000d0c6068f..b9cd1f955552 100644
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
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 879e5a64acaf..d495c6186381 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -723,6 +723,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 */
 				break;
 			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
+				/* No I3C devices attached */
+				if (dev_nb == 0)
+					break;
+
 				/*
 				 * A slave device nacked the address, this is
 				 * allowed only once, DAA will be stopped and
@@ -1152,11 +1156,17 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	bool broadcast = cmd->id < 0x80;
+	int ret;
 
 	if (broadcast)
-		return svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
 	else
-		return svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+
+	if (ret)
+		cmd->err = I3C_ERROR_M2;
+
+	return ret;
 }
 
 static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index 999da9c79866..381aa5797641 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -107,6 +107,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 		return ret;
 
 	uattr = uverbs_attr_get(attrs, UVERBS_ATTR_READ_COUNTERS_BUFF);
+	if (IS_ERR(uattr))
+		return PTR_ERR(uattr);
 	read_attr.ncounters = uattr->ptr_attr.len / sizeof(u64);
 	read_attr.counters_buff = uverbs_zalloc(
 		attrs, array_size(read_attr.ncounters, sizeof(u64)));
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index c94991356a2e..e02107123c97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -121,6 +121,7 @@
 #define HNS_ROCE_CQ_BANK_NUM 4
 
 #define CQ_BANKID_SHIFT 2
+#define CQ_BANKID_MASK GENMASK(1, 0)
 
 /* The chip implementation of the consumer index is calculated
  * according to twice the actual EQ depth
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8c02b51c8bff..4554d3e78b37 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -731,7 +731,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->sq.head += nreq;
 		qp->next_sge = sge_idx;
 
-		if (nreq == 1 && (qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
+		if (nreq == 1 && !ret &&
+		    (qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
 			write_dwqe(hr_dev, qp, wqe);
 		else
 			update_sq_db(hr_dev, qp);
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 13c8195b5c3a..80b9a9a45c68 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -222,6 +222,7 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 	unsigned long flags;
 	enum ib_mtu mtu;
 	u32 port;
+	int ret;
 
 	port = port_num - 1;
 
@@ -234,8 +235,10 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u32 port_num,
 				IB_PORT_BOOT_MGMT_SUP;
 	props->max_msg_sz = HNS_ROCE_MAX_MSG_LEN;
 	props->pkey_tbl_len = 1;
-	props->active_width = IB_WIDTH_4X;
-	props->active_speed = 1;
+	ret = ib_get_eth_speed(ib_dev, port_num, &props->active_speed,
+			       &props->active_width);
+	if (ret)
+		ibdev_warn(ib_dev, "failed to get speed, ret = %d.\n", ret);
 
 	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5d50d2d1deca..00dade1cfff2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -172,14 +172,29 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 	}
 }
 
-static u8 get_least_load_bankid_for_qp(struct hns_roce_bank *bank)
+static u8 get_affinity_cq_bank(u8 qp_bank)
 {
-	u32 least_load = bank[0].inuse;
+	return (qp_bank >> 1) & CQ_BANKID_MASK;
+}
+
+static u8 get_least_load_bankid_for_qp(struct ib_qp_init_attr *init_attr,
+					struct hns_roce_bank *bank)
+{
+#define INVALID_LOAD_QPNUM 0xFFFFFFFF
+	struct ib_cq *scq = init_attr->send_cq;
+	u32 least_load = INVALID_LOAD_QPNUM;
+	unsigned long cqn = 0;
 	u8 bankid = 0;
 	u32 bankcnt;
 	u8 i;
 
-	for (i = 1; i < HNS_ROCE_QP_BANK_NUM; i++) {
+	if (scq)
+		cqn = to_hr_cq(scq)->cqn;
+
+	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
+		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
+			continue;
+
 		bankcnt = bank[i].inuse;
 		if (bankcnt < least_load) {
 			least_load = bankcnt;
@@ -211,7 +226,8 @@ static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
 
 	return 0;
 }
-static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+		     struct ib_qp_init_attr *init_attr)
 {
 	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
 	unsigned long num = 0;
@@ -229,7 +245,7 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		hr_qp->doorbell_qpn = 1;
 	} else {
 		mutex_lock(&qp_table->bank_mutex);
-		bankid = get_least_load_bankid_for_qp(qp_table->bank);
+		bankid = get_least_load_bankid_for_qp(init_attr, qp_table->bank);
 
 		ret = alloc_qpn_with_bankid(&qp_table->bank[bankid], bankid,
 					    &num);
@@ -1067,7 +1083,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		goto err_buf;
 	}
 
-	ret = alloc_qpn(hr_dev, hr_qp);
+	ret = alloc_qpn(hr_dev, hr_qp, init_attr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QPN, ret = %d.\n", ret);
 		goto err_qpn;
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index f2e2bc50c6f7..bd13cc38e5ae 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -237,7 +237,7 @@ struct irdma_qv_info {
 
 struct irdma_qvlist_info {
 	u32 num_vectors;
-	struct irdma_qv_info qv_info[1];
+	struct irdma_qv_info qv_info[];
 };
 
 struct irdma_gen_ops {
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 60cf83c4119e..8ccbe761b860 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4310,7 +4310,6 @@ static int irdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 		ah_attr->grh.traffic_class = ah->sc_ah.ah_info.tc_tos;
 		ah_attr->grh.hop_limit = ah->sc_ah.ah_info.hop_ttl;
 		ah_attr->grh.sgid_index = ah->sgid_index;
-		ah_attr->grh.sgid_index = ah->sgid_index;
 		memcpy(&ah_attr->grh.dgid, &ah->dgid,
 		       sizeof(ah_attr->grh.dgid));
 	}
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b71711defb81..6082695a02d8 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2570,6 +2570,8 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_put_unsol_pending_cmds(conn);
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
+
+	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
 static void isert_free_conn(struct iscsi_conn *conn)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index a6117a7d0ab1..7701204fe542 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1978,12 +1978,8 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
 
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
diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 2a9755910065..508d84f6d00c 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -148,7 +148,7 @@ static int tca6416_keys_open(struct input_dev *dev)
 	if (chip->use_polling)
 		schedule_delayed_work(&chip->dwork, msecs_to_jiffies(100));
 	else
-		enable_irq(chip->irqnum);
+		enable_irq(chip->client->irq);
 
 	return 0;
 }
@@ -160,7 +160,7 @@ static void tca6416_keys_close(struct input_dev *dev)
 	if (chip->use_polling)
 		cancel_delayed_work_sync(&chip->dwork);
 	else
-		disable_irq(chip->irqnum);
+		disable_irq(chip->client->irq);
 }
 
 static int tca6416_setup_registers(struct tca6416_keypad_chip *chip)
@@ -266,12 +266,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 		goto fail1;
 
 	if (!chip->use_polling) {
-		if (pdata->irq_is_gpio)
-			chip->irqnum = gpio_to_irq(client->irq);
-		else
-			chip->irqnum = client->irq;
-
-		error = request_threaded_irq(chip->irqnum, NULL,
+		error = request_threaded_irq(client->irq, NULL,
 					     tca6416_keys_isr,
 					     IRQF_TRIGGER_FALLING |
 					     IRQF_ONESHOT | IRQF_NO_AUTOEN,
@@ -279,7 +274,7 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 		if (error) {
 			dev_dbg(&client->dev,
 				"Unable to claim irq %d; error %d\n",
-				chip->irqnum, error);
+				client->irq, error);
 			goto fail1;
 		}
 	}
@@ -297,10 +292,8 @@ static int tca6416_keypad_probe(struct i2c_client *client,
 	return 0;
 
 fail2:
-	if (!chip->use_polling) {
-		free_irq(chip->irqnum, chip);
-		enable_irq(chip->irqnum);
-	}
+	if (!chip->use_polling)
+		free_irq(client->irq, chip);
 fail1:
 	input_free_device(input);
 	kfree(chip);
@@ -311,10 +304,8 @@ static int tca6416_keypad_remove(struct i2c_client *client)
 {
 	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
-	if (!chip->use_polling) {
-		free_irq(chip->irqnum, chip);
-		enable_irq(chip->irqnum);
-	}
+	if (!chip->use_polling)
+		free_irq(client->irq, chip);
 
 	input_unregister_device(chip->input);
 	kfree(chip);
@@ -326,10 +317,9 @@ static int tca6416_keypad_remove(struct i2c_client *client)
 static int tca6416_keypad_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
-		enable_irq_wake(chip->irqnum);
+		enable_irq_wake(client->irq);
 
 	return 0;
 }
@@ -337,10 +327,9 @@ static int tca6416_keypad_suspend(struct device *dev)
 static int tca6416_keypad_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct tca6416_keypad_chip *chip = i2c_get_clientdata(client);
 
 	if (device_may_wakeup(dev))
-		disable_irq_wake(chip->irqnum);
+		disable_irq_wake(client->irq);
 
 	return 0;
 }
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index c96cf9b21719..29a3a62b7a3a 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -264,8 +264,8 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	refcount_dec(&pasid_state->count);
-	wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
+	if (!refcount_dec_and_test(&pasid_state->count))
+		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index a47cb654b704..9438203f08de 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -273,6 +273,13 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
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
index 6dbc43b414ca..dc9d665d7365 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -187,7 +187,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	device_attach_pasid_table(info, pasid_table);
 
 	if (!ecap_coherent(info->iommu->ecap))
-		clflush_cache_range(pasid_table->table, size);
+		clflush_cache_range(pasid_table->table, (1 << order) * PAGE_SIZE);
 
 	return 0;
 }
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e3557f8dc44e..f9f6492c430d 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -98,8 +98,6 @@ struct rk_iommu_ops {
 	phys_addr_t (*pt_address)(u32 dte);
 	u32 (*mk_dtentries)(dma_addr_t pt_dma);
 	u32 (*mk_ptentries)(phys_addr_t page, int prot);
-	phys_addr_t (*dte_addr_phys)(u32 addr);
-	u32 (*dma_addr_dte)(dma_addr_t dt_dma);
 	u64 dma_bit_mask;
 };
 
@@ -277,8 +275,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
 /*
  * In v2:
  * 31:12 - Page address bit 31:0
- *  11:9 - Page address bit 34:32
- *   8:4 - Page address bit 39:35
+ * 11: 8 - Page address bit 35:32
+ *  7: 4 - Page address bit 39:36
  *     3 - Security
  *     2 - Writable
  *     1 - Readable
@@ -505,7 +503,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 
 	/*
 	 * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMMY
-	 * and verifying that upper 5 nybbles are read back.
+	 * and verifying that upper 5 (v1) or 7 (v2) nybbles are read back.
 	 */
 	for (i = 0; i < iommu->num_mmu; i++) {
 		dte_addr = rk_ops->pt_address(DTE_ADDR_DUMMY);
@@ -530,33 +528,6 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
-static inline phys_addr_t rk_dte_addr_phys(u32 addr)
-{
-	return (phys_addr_t)addr;
-}
-
-static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
-{
-	return dt_dma;
-}
-
-#define DT_HI_MASK GENMASK_ULL(39, 32)
-#define DTE_BASE_HI_MASK GENMASK(11, 4)
-#define DT_SHIFT   28
-
-static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
-{
-	u64 addr64 = addr;
-	return (phys_addr_t)(addr64 & RK_DTE_PT_ADDRESS_MASK) |
-	       ((addr64 & DTE_BASE_HI_MASK) << DT_SHIFT);
-}
-
-static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
-{
-	return (dt_dma & RK_DTE_PT_ADDRESS_MASK) |
-	       ((dt_dma & DT_HI_MASK) >> DT_SHIFT);
-}
-
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -576,7 +547,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
+	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -966,7 +937,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
+			       rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
@@ -1373,8 +1344,6 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
 	.pt_address = &rk_dte_pt_address,
 	.mk_dtentries = &rk_mk_dte,
 	.mk_ptentries = &rk_mk_pte,
-	.dte_addr_phys = &rk_dte_addr_phys,
-	.dma_addr_dte = &rk_dma_addr_dte,
 	.dma_bit_mask = DMA_BIT_MASK(32),
 };
 
@@ -1382,8 +1351,6 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
 	.pt_address = &rk_dte_pt_address_v2,
 	.mk_dtentries = &rk_mk_dte_v2,
 	.mk_ptentries = &rk_mk_pte_v2,
-	.dte_addr_phys = &rk_dte_addr_phys_v2,
-	.dma_addr_dte = &rk_dma_addr_dte_v2,
 	.dma_bit_mask = DMA_BIT_MASK(40),
 };
 
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 723940e84161..6b11770e3d75 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -147,6 +147,7 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 
 	dom->domain.geometry.aperture_start = 0;
 	dom->domain.geometry.aperture_end = SZ_256M - 1;
+	dom->domain.geometry.force_aperture = true;
 
 	return &dom->domain;
 }
diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index e317408583df..ec62a4811613 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/led-class-multicolor.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -19,9 +20,10 @@ int led_mc_calc_color_components(struct led_classdev_mc *mcled_cdev,
 	int i;
 
 	for (i = 0; i < mcled_cdev->num_colors; i++)
-		mcled_cdev->subled_info[i].brightness = brightness *
-					mcled_cdev->subled_info[i].intensity /
-					led_cdev->max_brightness;
+		mcled_cdev->subled_info[i].brightness =
+			DIV_ROUND_CLOSEST(brightness *
+					  mcled_cdev->subled_info[i].intensity,
+					  led_cdev->max_brightness);
 
 	return 0;
 }
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 6832180c1c54..cc892ecd5240 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -146,7 +146,7 @@ static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 			led.name = to_of_node(fwnode)->name;
 
 		if (!led.name) {
-			ret = EINVAL;
+			ret = -EINVAL;
 			goto err_child_out;
 		}
 
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index f62db7e520b5..8ae0d2d284af 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -7,6 +7,8 @@
 #include <linux/tty.h>
 #include <uapi/linux/serial.h>
 
+#define LEDTRIG_TTY_INTERVAL	50
+
 struct ledtrig_tty_data {
 	struct led_classdev *led_cdev;
 	struct delayed_work dwork;
@@ -122,17 +124,19 @@ static void ledtrig_tty_work(struct work_struct *work)
 
 	if (icount.rx != trigger_data->rx ||
 	    icount.tx != trigger_data->tx) {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+		unsigned long interval = LEDTRIG_TTY_INTERVAL;
+
+		led_blink_set_oneshot(trigger_data->led_cdev, &interval,
+				      &interval, 0);
 
 		trigger_data->rx = icount.rx;
 		trigger_data->tx = icount.tx;
-	} else {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
 	}
 
 out:
 	mutex_unlock(&trigger_data->mutex);
-	schedule_delayed_work(&trigger_data->dwork, msecs_to_jiffies(100));
+	schedule_delayed_work(&trigger_data->dwork,
+			      msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 2));
 }
 
 static struct attribute *ledtrig_tty_attrs[] = {
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index adada558a1b0..49c46f3aea57 100644
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
 
diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 1ff51647a682..c33cd28f1dba 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -233,7 +233,8 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		     bio_sector < start_sector))
 		goto out_of_bounds;
 
-	if (unlikely(is_mddev_broken(tmp_dev->rdev, "linear"))) {
+	if (unlikely(is_rdev_broken(tmp_dev->rdev))) {
+		md_error(mddev, tmp_dev->rdev);
 		bio_io_error(bio);
 		return true;
 	}
@@ -281,6 +282,16 @@ static void linear_status (struct seq_file *seq, struct mddev *mddev)
 	seq_printf(seq, " %dk rounding", mddev->chunk_sectors / 2);
 }
 
+static void linear_error(struct mddev *mddev, struct md_rdev *rdev)
+{
+	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
+		char *md_name = mdname(mddev);
+
+		pr_crit("md/linear%s: Disk failure on %pg detected, failing array.\n",
+			md_name, rdev->bdev);
+	}
+}
+
 static void linear_quiesce(struct mddev *mddev, int state)
 {
 }
@@ -297,6 +308,7 @@ static struct md_personality linear_personality =
 	.hot_add_disk	= linear_add,
 	.size		= linear_size,
 	.quiesce	= linear_quiesce,
+	.error_handler	= linear_error,
 };
 
 static int __init linear_init (void)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 89a270d29369..b585b642a076 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2992,10 +2992,11 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 
 	if (cmd_match(buf, "faulty") && rdev->mddev->pers) {
 		md_error(rdev->mddev, rdev);
-		if (test_bit(Faulty, &rdev->flags))
-			err = 0;
-		else
+
+		if (test_bit(MD_BROKEN, &rdev->mddev->flags))
 			err = -EBUSY;
+		else
+			err = 0;
 	} else if (cmd_match(buf, "remove")) {
 		if (rdev->mddev->pers) {
 			clear_bit(Blocked, &rdev->flags);
@@ -4364,10 +4365,9 @@ __ATTR_PREALLOC(resync_start, S_IRUGO|S_IWUSR,
  *     like active, but no writes have been seen for a while (100msec).
  *
  * broken
- *     RAID0/LINEAR-only: same as clean, but array is missing a member.
- *     It's useful because RAID0/LINEAR mounted-arrays aren't stopped
- *     when a member is gone, so this state will at least alert the
- *     user that something is wrong.
+*     Array is failed. It's useful because mounted-arrays aren't stopped
+*     when array is failed, so this state will at least alert the user that
+*     something is wrong.
  */
 enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
 		   write_pending, active_idle, broken, bad_word};
@@ -7439,7 +7439,7 @@ static int set_disk_faulty(struct mddev *mddev, dev_t dev)
 		err =  -ENODEV;
 	else {
 		md_error(mddev, rdev);
-		if (!test_bit(Faulty, &rdev->flags))
+		if (test_bit(MD_BROKEN, &mddev->flags))
 			err = -EBUSY;
 	}
 	rcu_read_unlock();
@@ -7985,13 +7985,19 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (!mddev->pers || !mddev->pers->error_handler)
 		return;
-	mddev->pers->error_handler(mddev,rdev);
-	if (mddev->degraded)
+	mddev->pers->error_handler(mddev, rdev);
+
+	if (mddev->pers->level == 0 || mddev->pers->level == LEVEL_LINEAR)
+		return;
+
+	if (mddev->degraded && !test_bit(MD_BROKEN, &mddev->flags))
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	sysfs_notify_dirent_safe(rdev->sysfs_state);
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	if (!test_bit(MD_BROKEN, &mddev->flags)) {
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		md_wakeup_thread(mddev->thread);
+	}
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
 	md_new_event(mddev);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 62852d701145..99780e89531e 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -234,34 +234,42 @@ extern int rdev_clear_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 				int is_new);
 struct md_cluster_info;
 
-/* change UNSUPPORTED_MDDEV_FLAGS for each array type if new flag is added */
+/**
+ * enum mddev_flags - md device flags.
+ * @MD_ARRAY_FIRST_USE: First use of array, needs initialization.
+ * @MD_CLOSING: If set, we are closing the array, do not open it then.
+ * @MD_JOURNAL_CLEAN: A raid with journal is already clean.
+ * @MD_HAS_JOURNAL: The raid array has journal feature set.
+ * @MD_CLUSTER_RESYNC_LOCKED: cluster raid only, which means node, already took
+ *			       resync lock, need to release the lock.
+ * @MD_FAILFAST_SUPPORTED: Using MD_FAILFAST on metadata writes is supported as
+ *			    calls to md_error() will never cause the array to
+ *			    become failed.
+ * @MD_HAS_PPL:  The raid array has PPL feature set.
+ * @MD_HAS_MULTIPLE_PPLS: The raid array has multiple PPLs feature set.
+ * @MD_ALLOW_SB_UPDATE: md_check_recovery is allowed to update the metadata
+ *			 without taking reconfig_mutex.
+ * @MD_UPDATING_SB: md_check_recovery is updating the metadata without
+ *		     explicitly holding reconfig_mutex.
+ * @MD_NOT_READY: do_md_run() is active, so 'array_state', ust not report that
+ *		   array is ready yet.
+ * @MD_BROKEN: This is used to stop writes and mark array as failed.
+ *
+ * change UNSUPPORTED_MDDEV_FLAGS for each array type if new flag is added
+ */
 enum mddev_flags {
-	MD_ARRAY_FIRST_USE,	/* First use of array, needs initialization */
-	MD_CLOSING,		/* If set, we are closing the array, do not open
-				 * it then */
-	MD_JOURNAL_CLEAN,	/* A raid with journal is already clean */
-	MD_HAS_JOURNAL,		/* The raid array has journal feature set */
-	MD_CLUSTER_RESYNC_LOCKED, /* cluster raid only, which means node
-				   * already took resync lock, need to
-				   * release the lock */
-	MD_FAILFAST_SUPPORTED,	/* Using MD_FAILFAST on metadata writes is
-				 * supported as calls to md_error() will
-				 * never cause the array to become failed.
-				 */
-	MD_HAS_PPL,		/* The raid array has PPL feature set */
-	MD_HAS_MULTIPLE_PPLS,	/* The raid array has multiple PPLs feature set */
-	MD_ALLOW_SB_UPDATE,	/* md_check_recovery is allowed to update
-				 * the metadata without taking reconfig_mutex.
-				 */
-	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
-				 * without explicitly holding reconfig_mutex.
-				 */
-	MD_NOT_READY,		/* do_md_run() is active, so 'array_state'
-				 * must not report that array is ready yet
-				 */
-	MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
-				 * I/O in case an array member is gone/failed.
-				 */
+	MD_ARRAY_FIRST_USE,
+	MD_CLOSING,
+	MD_JOURNAL_CLEAN,
+	MD_HAS_JOURNAL,
+	MD_CLUSTER_RESYNC_LOCKED,
+	MD_FAILFAST_SUPPORTED,
+	MD_HAS_PPL,
+	MD_HAS_MULTIPLE_PPLS,
+	MD_ALLOW_SB_UPDATE,
+	MD_UPDATING_SB,
+	MD_NOT_READY,
+	MD_BROKEN,
 };
 
 enum mddev_sb_flags {
@@ -764,15 +772,9 @@ extern void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
+static inline bool is_rdev_broken(struct md_rdev *rdev)
 {
-	if (!disk_live(rdev->bdev->bd_disk)) {
-		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
-			pr_warn("md: %s: %s array has a missing/failed member\n",
-				mdname(rdev->mddev), md_type);
-		return true;
-	}
-	return false;
+	return !disk_live(rdev->bdev->bd_disk);
 }
 
 static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *mddev)
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index dca912387ec1..2290307e0910 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -570,54 +570,20 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 	bio_endio(bio);
 }
 
-static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
+static void raid0_map_submit_bio(struct mddev *mddev, struct bio *bio)
 {
 	struct r0conf *conf = mddev->private;
 	struct strip_zone *zone;
 	struct md_rdev *tmp_dev;
-	sector_t bio_sector;
-	sector_t sector;
-	sector_t orig_sector;
-	unsigned chunk_sects;
-	unsigned sectors;
-
-	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
-	    && md_flush_request(mddev, bio))
-		return true;
-
-	if (unlikely((bio_op(bio) == REQ_OP_DISCARD))) {
-		raid0_handle_discard(mddev, bio);
-		return true;
-	}
-
-	bio_sector = bio->bi_iter.bi_sector;
-	sector = bio_sector;
-	chunk_sects = mddev->chunk_sectors;
-
-	sectors = chunk_sects -
-		(likely(is_power_of_2(chunk_sects))
-		 ? (sector & (chunk_sects-1))
-		 : sector_div(sector, chunk_sects));
+	sector_t bio_sector = bio->bi_iter.bi_sector;
+	sector_t sector = bio_sector;
 
-	/* Restore due to sector_div */
-	sector = bio_sector;
+	md_account_bio(mddev, &bio);
 
-	if (sectors < bio_sectors(bio)) {
-		struct bio *split = bio_split(bio, sectors, GFP_NOIO,
-					      &mddev->bio_set);
-		bio_chain(split, bio);
-		submit_bio_noacct(bio);
-		bio = split;
-	}
-
-	if (bio->bi_pool != &mddev->bio_set)
-		md_account_bio(mddev, &bio);
-
-	orig_sector = sector;
 	zone = find_zone(mddev->private, &sector);
 	switch (conf->layout) {
 	case RAID0_ORIG_LAYOUT:
-		tmp_dev = map_sector(mddev, zone, orig_sector, &sector);
+		tmp_dev = map_sector(mddev, zone, bio_sector, &sector);
 		break;
 	case RAID0_ALT_MULTIZONE_LAYOUT:
 		tmp_dev = map_sector(mddev, zone, sector, &sector);
@@ -625,12 +591,13 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 	default:
 		WARN(1, "md/raid0:%s: Invalid layout\n", mdname(mddev));
 		bio_io_error(bio);
-		return true;
+		return;
 	}
 
-	if (unlikely(is_mddev_broken(tmp_dev, "raid0"))) {
+	if (unlikely(is_rdev_broken(tmp_dev))) {
 		bio_io_error(bio);
-		return true;
+		md_error(mddev, tmp_dev);
+		return;
 	}
 
 	bio_set_dev(bio, tmp_dev->bdev);
@@ -643,6 +610,40 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 	mddev_check_writesame(mddev, bio);
 	mddev_check_write_zeroes(mddev, bio);
 	submit_bio_noacct(bio);
+}
+
+static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
+{
+	sector_t sector;
+	unsigned chunk_sects;
+	unsigned sectors;
+
+	if (unlikely(bio->bi_opf & REQ_PREFLUSH)
+	    && md_flush_request(mddev, bio))
+		return true;
+
+	if (unlikely((bio_op(bio) == REQ_OP_DISCARD))) {
+		raid0_handle_discard(mddev, bio);
+		return true;
+	}
+
+	sector = bio->bi_iter.bi_sector;
+	chunk_sects = mddev->chunk_sectors;
+
+	sectors = chunk_sects -
+		(likely(is_power_of_2(chunk_sects))
+		 ? (sector & (chunk_sects-1))
+		 : sector_div(sector, chunk_sects));
+
+	if (sectors < bio_sectors(bio)) {
+		struct bio *split = bio_split(bio, sectors, GFP_NOIO,
+					      &mddev->bio_set);
+		bio_chain(split, bio);
+		raid0_map_submit_bio(mddev, bio);
+		bio = split;
+	}
+
+	raid0_map_submit_bio(mddev, bio);
 	return true;
 }
 
@@ -652,6 +653,16 @@ static void raid0_status(struct seq_file *seq, struct mddev *mddev)
 	return;
 }
 
+static void raid0_error(struct mddev *mddev, struct md_rdev *rdev)
+{
+	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
+		char *md_name = mdname(mddev);
+
+		pr_crit("md/raid0%s: Disk failure on %pg detected, failing array.\n",
+			md_name, rdev->bdev);
+	}
+}
+
 static void *raid0_takeover_raid45(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
@@ -827,6 +838,7 @@ static struct md_personality raid0_personality=
 	.size		= raid0_size,
 	.takeover	= raid0_takeover,
 	.quiesce	= raid0_quiesce,
+	.error_handler	= raid0_error,
 };
 
 static int __init raid0_init (void)
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 47997a9a3ca1..084bfea6ad31 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1611,30 +1611,39 @@ static void raid1_status(struct seq_file *seq, struct mddev *mddev)
 	seq_printf(seq, "]");
 }
 
+/**
+ * raid1_error() - RAID1 error handler.
+ * @mddev: affected md device.
+ * @rdev: member device to fail.
+ *
+ * The routine acknowledges &rdev failure and determines new @mddev state.
+ * If it failed, then:
+ *	- &MD_BROKEN flag is set in &mddev->flags.
+ *	- recovery is disabled.
+ * Otherwise, it must be degraded:
+ *	- recovery is interrupted.
+ *	- &mddev->degraded is bumped.
+ *
+ * @rdev is marked as &Faulty excluding case when array is failed and
+ * &mddev->fail_last_dev is off.
+ */
 static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
 {
 	char b[BDEVNAME_SIZE];
 	struct r1conf *conf = mddev->private;
 	unsigned long flags;
 
-	/*
-	 * If it is not operational, then we have already marked it as dead
-	 * else if it is the last working disks with "fail_last_dev == false",
-	 * ignore the error, let the next level up know.
-	 * else mark the drive as failed
-	 */
 	spin_lock_irqsave(&conf->device_lock, flags);
-	if (test_bit(In_sync, &rdev->flags) && !mddev->fail_last_dev
-	    && (conf->raid_disks - mddev->degraded) == 1) {
-		/*
-		 * Don't fail the drive, act as though we were just a
-		 * normal single drive.
-		 * However don't try a recovery from this drive as
-		 * it is very likely to fail.
-		 */
-		conf->recovery_disabled = mddev->recovery_disabled;
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-		return;
+
+	if (test_bit(In_sync, &rdev->flags) &&
+	    (conf->raid_disks - mddev->degraded) == 1) {
+		set_bit(MD_BROKEN, &mddev->flags);
+
+		if (!mddev->fail_last_dev) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			spin_unlock_irqrestore(&conf->device_lock, flags);
+			return;
+		}
 	}
 	set_bit(Blocked, &rdev->flags);
 	if (test_and_clear_bit(In_sync, &rdev->flags))
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index edd3b65c447d..910e7db7d573 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1316,6 +1316,25 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	}
 }
 
+static struct md_rdev *dereference_rdev_and_rrdev(struct raid10_info *mirror,
+						  struct md_rdev **prrdev)
+{
+	struct md_rdev *rdev, *rrdev;
+
+	rrdev = rcu_dereference(mirror->replacement);
+	/*
+	 * Read replacement first to prevent reading both rdev and
+	 * replacement as NULL during replacement replace rdev.
+	 */
+	smp_mb();
+	rdev = rcu_dereference(mirror->rdev);
+	if (rdev == rrdev)
+		rrdev = NULL;
+
+	*prrdev = rrdev;
+	return rdev;
+}
+
 static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int i;
@@ -1326,11 +1345,9 @@ static void wait_blocked_dev(struct mddev *mddev, struct r10bio *r10_bio)
 	blocked_rdev = NULL;
 	rcu_read_lock();
 	for (i = 0; i < conf->copies; i++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[i].replacement);
-		if (rdev == rrdev)
-			rrdev = NULL;
+		struct md_rdev *rdev, *rrdev;
+
+		rdev = dereference_rdev_and_rrdev(&conf->mirrors[i], &rrdev);
 		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
 			atomic_inc(&rdev->nr_pending);
 			blocked_rdev = rdev;
@@ -1459,15 +1476,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		int d = r10_bio->devs[i].devnum;
 		struct md_rdev *rdev, *rrdev;
 
-		rrdev = rcu_dereference(conf->mirrors[d].replacement);
-		/*
-		 * Read replacement first to prevent reading both rdev and
-		 * replacement as NULL during replacement replace rdev.
-		 */
-		smp_mb();
-		rdev = rcu_dereference(conf->mirrors[d].rdev);
-		if (rdev == rrdev)
-			rrdev = NULL;
+		rdev = dereference_rdev_and_rrdev(&conf->mirrors[d], &rrdev);
 		if (rdev && (test_bit(Faulty, &rdev->flags)))
 			rdev = NULL;
 		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
@@ -1774,10 +1783,9 @@ static int raid10_handle_discard(struct mddev *mddev, struct bio *bio)
 	 */
 	rcu_read_lock();
 	for (disk = 0; disk < geo->raid_disks; disk++) {
-		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
-		struct md_rdev *rrdev = rcu_dereference(
-			conf->mirrors[disk].replacement);
+		struct md_rdev *rdev, *rrdev;
 
+		rdev = dereference_rdev_and_rrdev(&conf->mirrors[disk], &rrdev);
 		r10_bio->devs[disk].bio = NULL;
 		r10_bio->devs[disk].repl_bio = NULL;
 
@@ -2000,32 +2008,40 @@ static int enough(struct r10conf *conf, int ignore)
 		_enough(conf, 1, ignore);
 }
 
+/**
+ * raid10_error() - RAID10 error handler.
+ * @mddev: affected md device.
+ * @rdev: member device to fail.
+ *
+ * The routine acknowledges &rdev failure and determines new @mddev state.
+ * If it failed, then:
+ *	- &MD_BROKEN flag is set in &mddev->flags.
+ * Otherwise, it must be degraded:
+ *	- recovery is interrupted.
+ *	- &mddev->degraded is bumped.
+
+ * @rdev is marked as &Faulty excluding case when array is failed and
+ * &mddev->fail_last_dev is off.
+ */
 static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
 {
 	char b[BDEVNAME_SIZE];
 	struct r10conf *conf = mddev->private;
 	unsigned long flags;
 
-	/*
-	 * If it is not operational, then we have already marked it as dead
-	 * else if it is the last working disks with "fail_last_dev == false",
-	 * ignore the error, let the next level up know.
-	 * else mark the drive as failed
-	 */
 	spin_lock_irqsave(&conf->device_lock, flags);
-	if (test_bit(In_sync, &rdev->flags) && !mddev->fail_last_dev
-	    && !enough(conf, rdev->raid_disk)) {
-		/*
-		 * Don't fail the drive, just return an IO error.
-		 */
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-		return;
+
+	if (test_bit(In_sync, &rdev->flags) && !enough(conf, rdev->raid_disk)) {
+		set_bit(MD_BROKEN, &mddev->flags);
+
+		if (!mddev->fail_last_dev) {
+			spin_unlock_irqrestore(&conf->device_lock, flags);
+			return;
+		}
 	}
 	if (test_and_clear_bit(In_sync, &rdev->flags))
 		mddev->degraded++;
-	/*
-	 * If recovery is running, make sure it aborts.
-	 */
+
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	set_bit(Blocked, &rdev->flags);
 	set_bit(Faulty, &rdev->flags);
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
index d8acd582c711..44515fdbe91d 100644
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
@@ -973,7 +973,9 @@ static void cx24120_set_clock_ratios(struct dvb_frontend *fe)
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
index 5431f922f55e..e9d1eef40c62 100644
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
index 903da33642df..c958bcff026e 100644
--- a/drivers/media/dvb-frontends/dib0090.c
+++ b/drivers/media/dvb-frontends/dib0090.c
@@ -2634,7 +2634,7 @@ struct dvb_frontend *dib0090_register(struct dvb_frontend *fe, struct i2c_adapte
 	return NULL;
 }
 
-EXPORT_SYMBOL(dib0090_register);
+EXPORT_SYMBOL_GPL(dib0090_register);
 
 struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_adapter *i2c, const struct dib0090_config *config)
 {
@@ -2660,7 +2660,7 @@ struct dvb_frontend *dib0090_fw_register(struct dvb_frontend *fe, struct i2c_ada
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
index bf9e4ef35684..88860d08f9c1 100644
--- a/drivers/media/dvb-frontends/drx39xyj/drxj.c
+++ b/drivers/media/dvb-frontends/drx39xyj/drxj.c
@@ -12368,7 +12368,7 @@ struct dvb_frontend *drx39xxj_attach(struct i2c_adapter *i2c)
 
 	return NULL;
 }
-EXPORT_SYMBOL(drx39xxj_attach);
+EXPORT_SYMBOL_GPL(drx39xxj_attach);
 
 static const struct dvb_frontend_ops drx39xxj_ops = {
 	.delsys = { SYS_ATSC, SYS_DVBC_ANNEX_B },
diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
index a7eb81df88c2..45487d1080b7 100644
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -2947,7 +2947,7 @@ struct dvb_frontend *drxd_attach(const struct drxd_config *config,
 	kfree(state);
 	return NULL;
 }
-EXPORT_SYMBOL(drxd_attach);
+EXPORT_SYMBOL_GPL(drxd_attach);
 
 MODULE_DESCRIPTION("DRXD driver");
 MODULE_AUTHOR("Micronas");
diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index efe92eef67db..e8afd5305b54 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -6846,7 +6846,7 @@ struct dvb_frontend *drxk_attach(const struct drxk_config *config,
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
index 136b76cb4807..f6e83a38738d 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -1859,7 +1859,7 @@ struct dvb_frontend *lgdt3306a_attach(const struct lgdt3306a_config *config,
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
index 02e8aa11e36e..e03fac025b51 100644
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
index b294ba87e934..2aa98203cd65 100644
--- a/drivers/media/dvb-frontends/m88rs2000.c
+++ b/drivers/media/dvb-frontends/m88rs2000.c
@@ -808,7 +808,7 @@ struct dvb_frontend *m88rs2000_attach(const struct m88rs2000_config *config,
 
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
index 200b6dbc75f8..1c549ada6ebf 100644
--- a/drivers/media/dvb-frontends/nxt200x.c
+++ b/drivers/media/dvb-frontends/nxt200x.c
@@ -1216,5 +1216,5 @@ MODULE_DESCRIPTION("NXT200X (ATSC 8VSB & ITU-T J.83 AnnexB 64/256 QAM) Demodulat
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
index e31eb2c5cc4c..a35ab007a0b3 100644
--- a/drivers/media/dvb-frontends/si21xx.c
+++ b/drivers/media/dvb-frontends/si21xx.c
@@ -936,7 +936,7 @@ struct dvb_frontend *si21xx_attach(const struct si21xx_config *config,
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
index 3e383912bcfd..4e89193f8e6a 100644
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
index 07639ecc85aa..63b5bf1fae76 100644
--- a/drivers/media/i2c/ad5820.c
+++ b/drivers/media/i2c/ad5820.c
@@ -357,7 +357,6 @@ static int ad5820_remove(struct i2c_client *client)
 static const struct i2c_device_id ad5820_id_table[] = {
 	{ "ad5820", 0 },
 	{ "ad5821", 0 },
-	{ "ad5823", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
@@ -365,7 +364,6 @@ MODULE_DEVICE_TABLE(i2c, ad5820_id_table);
 static const struct of_device_id ad5820_of_table[] = {
 	{ .compatible = "adi,ad5820" },
 	{ .compatible = "adi,ad5821" },
-	{ .compatible = "adi,ad5823" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5820_of_table);
diff --git a/drivers/media/i2c/ccs/ccs-data.c b/drivers/media/i2c/ccs/ccs-data.c
index 45f2b2f55ec5..08400edf77ce 100644
--- a/drivers/media/i2c/ccs/ccs-data.c
+++ b/drivers/media/i2c/ccs/ccs-data.c
@@ -464,8 +464,7 @@ static int ccs_data_parse_rules(struct bin_container *bin,
 		rule_payload = __rule_type + 1;
 		rule_plen2 = rule_plen - sizeof(*__rule_type);
 
-		switch (*__rule_type) {
-		case CCS_DATA_BLOCK_RULE_ID_IF: {
+		if (*__rule_type == CCS_DATA_BLOCK_RULE_ID_IF) {
 			const struct __ccs_data_block_rule_if *__if_rules =
 				rule_payload;
 			const size_t __num_if_rules =
@@ -514,49 +513,61 @@ static int ccs_data_parse_rules(struct bin_container *bin,
 				rules->if_rules = if_rule;
 				rules->num_if_rules = __num_if_rules;
 			}
-			break;
-		}
-		case CCS_DATA_BLOCK_RULE_ID_READ_ONLY_REGS:
-			rval = ccs_data_parse_reg_rules(bin, &rules->read_only_regs,
-							&rules->num_read_only_regs,
-							rule_payload,
-							rule_payload + rule_plen2,
-							dev);
-			if (rval)
-				return rval;
-			break;
-		case CCS_DATA_BLOCK_RULE_ID_FFD:
-			rval = ccs_data_parse_ffd(bin, &rules->frame_format,
-						  rule_payload,
-						  rule_payload + rule_plen2,
-						  dev);
-			if (rval)
-				return rval;
-			break;
-		case CCS_DATA_BLOCK_RULE_ID_MSR:
-			rval = ccs_data_parse_reg_rules(bin,
-							&rules->manufacturer_regs,
-							&rules->num_manufacturer_regs,
-							rule_payload,
-							rule_payload + rule_plen2,
-							dev);
-			if (rval)
-				return rval;
-			break;
-		case CCS_DATA_BLOCK_RULE_ID_PDAF_READOUT:
-			rval = ccs_data_parse_pdaf_readout(bin,
-							   &rules->pdaf_readout,
-							   rule_payload,
-							   rule_payload + rule_plen2,
-							   dev);
-			if (rval)
-				return rval;
-			break;
-		default:
-			dev_dbg(dev,
-				"Don't know how to handle rule type %u!\n",
-				*__rule_type);
-			return -EINVAL;
+		} else {
+			/* Check there was an if rule before any other rules */
+			if (bin->base && !rules)
+				return -EINVAL;
+
+			switch (*__rule_type) {
+			case CCS_DATA_BLOCK_RULE_ID_READ_ONLY_REGS:
+				rval = ccs_data_parse_reg_rules(bin,
+								rules ?
+								&rules->read_only_regs : NULL,
+								rules ?
+								&rules->num_read_only_regs : NULL,
+								rule_payload,
+								rule_payload + rule_plen2,
+								dev);
+				if (rval)
+					return rval;
+				break;
+			case CCS_DATA_BLOCK_RULE_ID_FFD:
+				rval = ccs_data_parse_ffd(bin, rules ?
+							  &rules->frame_format : NULL,
+							  rule_payload,
+							  rule_payload + rule_plen2,
+							  dev);
+				if (rval)
+					return rval;
+				break;
+			case CCS_DATA_BLOCK_RULE_ID_MSR:
+				rval = ccs_data_parse_reg_rules(bin,
+								rules ?
+								&rules->manufacturer_regs : NULL,
+								rules ?
+								&rules->num_manufacturer_regs : NULL,
+								rule_payload,
+								rule_payload + rule_plen2,
+								dev);
+				if (rval)
+					return rval;
+				break;
+			case CCS_DATA_BLOCK_RULE_ID_PDAF_READOUT:
+				rval = ccs_data_parse_pdaf_readout(bin,
+								   rules ?
+								   &rules->pdaf_readout : NULL,
+								   rule_payload,
+								   rule_payload + rule_plen2,
+								   dev);
+				if (rval)
+					return rval;
+				break;
+			default:
+				dev_dbg(dev,
+					"Don't know how to handle rule type %u!\n",
+					*__rule_type);
+				return -EINVAL;
+			}
 		}
 		__next_rule = __next_rule + rule_hlen + rule_plen;
 	}
diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 906c711f6821..3059d1157bac 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -54,6 +54,9 @@
 #define OV2680_WIDTH_MAX		1600
 #define OV2680_HEIGHT_MAX		1200
 
+#define OV2680_DEFAULT_WIDTH			800
+#define OV2680_DEFAULT_HEIGHT			600
+
 enum ov2680_mode_id {
 	OV2680_MODE_QUXGA_800_600,
 	OV2680_MODE_720P_1280_720,
@@ -85,15 +88,8 @@ struct ov2680_mode_info {
 
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
@@ -143,6 +139,7 @@ static const struct reg_value ov2680_setting_30fps_QUXGA_800_600[] = {
 	{0x380e, 0x02}, {0x380f, 0x84}, {0x3811, 0x04}, {0x3813, 0x04},
 	{0x3814, 0x31}, {0x3815, 0x31}, {0x3820, 0xc0}, {0x4008, 0x00},
 	{0x4009, 0x03}, {0x4837, 0x1e}, {0x3501, 0x4e}, {0x3502, 0xe0},
+	{0x3503, 0x03},
 };
 
 static const struct reg_value ov2680_setting_30fps_720P_1280_720[] = {
@@ -321,70 +318,62 @@ static void ov2680_power_down(struct ov2680_dev *sensor)
 	usleep_range(5000, 10000);
 }
 
-static int ov2680_bayer_order(struct ov2680_dev *sensor)
+static void ov2680_set_bayer_order(struct ov2680_dev *sensor,
+				   struct v4l2_mbus_framefmt *fmt)
 {
-	u32 format1;
-	u32 format2;
-	u32 hv_flip;
-	int ret;
-
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT1, &format1);
-	if (ret < 0)
-		return ret;
-
-	ret = ov2680_read_reg(sensor, OV2680_REG_FORMAT2, &format2);
-	if (ret < 0)
-		return ret;
+	int hv_flip = 0;
 
-	hv_flip = (format2 & BIT(2)  << 1) | (format1 & BIT(2));
+	if (sensor->ctrls.vflip && sensor->ctrls.vflip->val)
+		hv_flip += 1;
 
-	sensor->fmt.code = ov2680_hv_flip_bayer_order[hv_flip];
+	if (sensor->ctrls.hflip && sensor->ctrls.hflip->val)
+		hv_flip += 2;
 
-	return 0;
+	fmt->code = ov2680_hv_flip_bayer_order[hv_flip];
 }
 
-static int ov2680_vflip_enable(struct ov2680_dev *sensor)
+static void ov2680_fill_format(struct ov2680_dev *sensor,
+			       struct v4l2_mbus_framefmt *fmt,
+			       unsigned int width, unsigned int height)
 {
-	int ret;
-
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(2));
-	if (ret < 0)
-		return ret;
-
-	return ov2680_bayer_order(sensor);
+	memset(fmt, 0, sizeof(*fmt));
+	fmt->width = width;
+	fmt->height = height;
+	fmt->field = V4L2_FIELD_NONE;
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	ov2680_set_bayer_order(sensor, fmt);
 }
 
-static int ov2680_vflip_disable(struct ov2680_dev *sensor)
+static int ov2680_set_vflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1, BIT(2), BIT(0));
-	if (ret < 0)
-		return ret;
-
-	return ov2680_bayer_order(sensor);
-}
-
-static int ov2680_hflip_enable(struct ov2680_dev *sensor)
-{
-	int ret;
+	if (sensor->is_streaming)
+		return -EBUSY;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(2));
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT1,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor, &sensor->fmt);
+	return 0;
 }
 
-static int ov2680_hflip_disable(struct ov2680_dev *sensor)
+static int ov2680_set_hflip(struct ov2680_dev *sensor, s32 val)
 {
 	int ret;
 
-	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2, BIT(2), BIT(0));
+	if (sensor->is_streaming)
+		return -EBUSY;
+
+	ret = ov2680_mod_reg(sensor, OV2680_REG_FORMAT2,
+			     BIT(2), val ? BIT(2) : 0);
 	if (ret < 0)
 		return ret;
 
-	return ov2680_bayer_order(sensor);
+	ov2680_set_bayer_order(sensor, &sensor->fmt);
+	return 0;
 }
 
 static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
@@ -405,69 +394,15 @@ static int ov2680_test_pattern_set(struct ov2680_dev *sensor, int value)
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
-}
-
-static int ov2680_gain_get(struct ov2680_dev *sensor)
-{
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
+	return ov2680_write_reg16(sensor, OV2680_REG_GAIN_PK, gain);
 }
 
-static int ov2680_exposure_get(struct ov2680_dev *sensor)
+static int ov2680_exposure_set(struct ov2680_dev *sensor, u32 exp)
 {
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
@@ -482,33 +417,17 @@ static int ov2680_stream_disable(struct ov2680_dev *sensor)
 
 static int ov2680_mode_set(struct ov2680_dev *sensor)
 {
-	struct ov2680_ctrls *ctrls = &sensor->ctrls;
 	int ret;
 
-	ret = ov2680_gain_set(sensor, false);
-	if (ret < 0)
-		return ret;
-
-	ret = ov2680_exposure_set(sensor, false);
+	ret = ov2680_load_regs(sensor, sensor->current_mode);
 	if (ret < 0)
 		return ret;
 
-	ret = ov2680_load_regs(sensor, sensor->current_mode);
+	/* Restore value of all ctrls */
+	ret = __v4l2_ctrl_handler_setup(&sensor->ctrls.handler);
 	if (ret < 0)
 		return ret;
 
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
@@ -556,7 +475,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 		ret = ov2680_write_reg(sensor, OV2680_REG_SOFT_RESET, 0x01);
 		if (ret != 0) {
 			dev_err(dev, "sensor soft reset failed\n");
-			return ret;
+			goto err_disable_regulators;
 		}
 		usleep_range(1000, 2000);
 	} else {
@@ -566,7 +485,7 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 
 	ret = clk_prepare_enable(sensor->xvclk);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	sensor->is_enabled = true;
 
@@ -576,6 +495,10 @@ static int ov2680_power_on(struct ov2680_dev *sensor)
 	ov2680_stream_disable(sensor);
 
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(OV2680_NUM_SUPPLIES, sensor->supplies);
+	return ret;
 }
 
 static int ov2680_s_power(struct v4l2_subdev *sd, int on)
@@ -590,15 +513,10 @@ static int ov2680_s_power(struct v4l2_subdev *sd, int on)
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
@@ -664,7 +582,6 @@ static int ov2680_get_fmt(struct v4l2_subdev *sd,
 {
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 	struct v4l2_mbus_framefmt *fmt = NULL;
-	int ret = 0;
 
 	if (format->pad != 0)
 		return -EINVAL;
@@ -672,22 +589,17 @@ static int ov2680_get_fmt(struct v4l2_subdev *sd,
 	mutex_lock(&sensor->lock);
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		fmt = v4l2_subdev_get_try_format(&sensor->sd, sd_state,
 						 format->pad);
-#else
-		ret = -EINVAL;
-#endif
 	} else {
 		fmt = &sensor->fmt;
 	}
 
-	if (fmt)
-		format->format = *fmt;
+	format->format = *fmt;
 
 	mutex_unlock(&sensor->lock);
 
-	return ret;
+	return 0;
 }
 
 static int ov2680_set_fmt(struct v4l2_subdev *sd,
@@ -695,43 +607,35 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_format *format)
 {
 	struct ov2680_dev *sensor = to_ov2680_dev(sd);
-	struct v4l2_mbus_framefmt *fmt = &format->format;
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	struct v4l2_mbus_framefmt *try_fmt;
-#endif
 	const struct ov2680_mode_info *mode;
 	int ret = 0;
 
 	if (format->pad != 0)
 		return -EINVAL;
 
-	mutex_lock(&sensor->lock);
-
-	if (sensor->is_streaming) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
 	mode = v4l2_find_nearest_size(ov2680_mode_data,
-				      ARRAY_SIZE(ov2680_mode_data), width,
-				      height, fmt->width, fmt->height);
-	if (!mode) {
-		ret = -EINVAL;
-		goto unlock;
-	}
+				      ARRAY_SIZE(ov2680_mode_data),
+				      width, height,
+				      format->format.width,
+				      format->format.height);
+	if (!mode)
+		return -EINVAL;
+
+	ov2680_fill_format(sensor, &format->format, mode->width, mode->height);
 
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 		try_fmt = v4l2_subdev_get_try_format(sd, sd_state, 0);
-		format->format = *try_fmt;
-#endif
-		goto unlock;
+		*try_fmt = format->format;
+		return 0;
 	}
 
-	fmt->width = mode->width;
-	fmt->height = mode->height;
-	fmt->code = sensor->fmt.code;
-	fmt->colorspace = sensor->fmt.colorspace;
+	mutex_lock(&sensor->lock);
+
+	if (sensor->is_streaming) {
+		ret = -EBUSY;
+		goto unlock;
+	}
 
 	sensor->current_mode = mode;
 	sensor->fmt = format->format;
@@ -746,16 +650,11 @@ static int ov2680_set_fmt(struct v4l2_subdev *sd,
 static int ov2680_init_cfg(struct v4l2_subdev *sd,
 			   struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_subdev_format fmt = {
-		.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY
-		: V4L2_SUBDEV_FORMAT_ACTIVE,
-		.format = {
-			.width = 800,
-			.height = 600,
-		}
-	};
+	struct ov2680_dev *sensor = to_ov2680_dev(sd);
 
-	return ov2680_set_fmt(sd, sd_state, &fmt);
+	ov2680_fill_format(sensor, &sd_state->pads[0].try_fmt,
+			   OV2680_DEFAULT_WIDTH, OV2680_DEFAULT_HEIGHT);
+	return 0;
 }
 
 static int ov2680_enum_frame_size(struct v4l2_subdev *sd,
@@ -794,66 +693,23 @@ static int ov2680_enum_frame_interval(struct v4l2_subdev *sd,
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
@@ -864,7 +720,6 @@ static int ov2680_s_ctrl(struct v4l2_ctrl *ctrl)
 }
 
 static const struct v4l2_ctrl_ops ov2680_ctrl_ops = {
-	.g_volatile_ctrl = ov2680_g_volatile_ctrl,
 	.s_ctrl = ov2680_s_ctrl,
 };
 
@@ -898,11 +753,8 @@ static int ov2680_mode_init(struct ov2680_dev *sensor)
 	const struct ov2680_mode_info *init_mode;
 
 	/* set initial mode */
-	sensor->fmt.code = MEDIA_BUS_FMT_SBGGR10_1X10;
-	sensor->fmt.width = 800;
-	sensor->fmt.height = 600;
-	sensor->fmt.field = V4L2_FIELD_NONE;
-	sensor->fmt.colorspace = V4L2_COLORSPACE_SRGB;
+	ov2680_fill_format(sensor, &sensor->fmt,
+			   OV2680_DEFAULT_WIDTH, OV2680_DEFAULT_HEIGHT);
 
 	sensor->frame_interval.denominator = OV2680_FRAME_RATE;
 	sensor->frame_interval.numerator = 1;
@@ -926,9 +778,7 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 	v4l2_i2c_subdev_init(&sensor->sd, sensor->i2c_client,
 			     &ov2680_subdev_ops);
 
-#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
 	sensor->sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
-#endif
 	sensor->pad.flags = MEDIA_PAD_FL_SOURCE;
 	sensor->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
@@ -936,7 +786,7 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
 	if (ret < 0)
 		return ret;
 
-	v4l2_ctrl_handler_init(hdl, 7);
+	v4l2_ctrl_handler_init(hdl, 5);
 
 	hdl->lock = &sensor->lock;
 
@@ -948,16 +798,9 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
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
@@ -965,11 +808,8 @@ static int ov2680_v4l2_register(struct ov2680_dev *sensor)
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
index a141552531f7..13144e87f47a 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -1968,9 +1968,9 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
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
 
diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
index ef31cf5f23ca..7995cb956aa7 100644
--- a/drivers/media/i2c/rdacm21.c
+++ b/drivers/media/i2c/rdacm21.c
@@ -351,7 +351,7 @@ static void ov10640_power_up(struct rdacm21_device *dev)
 static int ov10640_check_id(struct rdacm21_device *dev)
 {
 	unsigned int i;
-	u8 val;
+	u8 val = 0;
 
 	/* Read OV10640 ID to test communications. */
 	for (i = 0; i < OV10640_PID_TIMEOUT; ++i) {
diff --git a/drivers/media/i2c/tvp5150.c b/drivers/media/i2c/tvp5150.c
index 4b16ffcaef98..b0dc21ba25c3 100644
--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -2066,6 +2066,10 @@ static int tvp5150_parse_dt(struct tvp5150 *decoder, struct device_node *np)
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
index 71cdc3ddafcb..0b2cde3b3439 100644
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
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index ce98c523b3c6..c1e44cd2ef6d 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -131,7 +131,6 @@ struct venus_hfi_device {
 
 static bool venus_pkt_debug;
 int venus_fw_debug = HFI_DEBUG_MSG_ERROR | HFI_DEBUG_MSG_FATAL;
-static bool venus_sys_idle_indicator;
 static bool venus_fw_low_power_mode = true;
 static int venus_hw_rsp_timeout = 1000;
 static bool venus_fw_coverage;
@@ -454,7 +453,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	void __iomem *wrapper_base = hdev->core->wrapper_base;
 	int ret = 0;
 
-	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	if (IS_V6(hdev->core)) {
 		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
 		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
@@ -465,6 +463,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
 	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
 	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
 
+	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
 		if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
@@ -924,17 +923,12 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
-	/*
-	 * Idle indicator is disabled by default on some 4xx firmware versions,
-	 * enable it explicitly in order to make suspend functional by checking
-	 * WFI (wait-for-interrupt) bit.
-	 */
-	if (IS_V4(hdev->core) || IS_V6(hdev->core))
-		venus_sys_idle_indicator = true;
-
-	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
-	if (ret)
-		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
+	/* HFI_PROPERTY_SYS_IDLE_INDICATOR is not supported beyond 8916 (HFI V1) */
+	if (IS_V1(hdev->core)) {
+		ret = venus_sys_set_idle_message(hdev, false);
+		if (ret)
+			dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
+	}
 
 	ret = venus_sys_set_power_control(hdev, venus_fw_low_power_mode);
 	if (ret)
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
index 204e6186bf71..907c06224e5a 100644
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
index f6e82a8e7d37..f50fc161a80d 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -4128,7 +4128,7 @@ struct dvb_frontend *mxl5005s_attach(struct dvb_frontend *fe,
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
index 843259c304bb..5d2eaad1fa68 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -549,19 +549,29 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
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
 
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 965b44a09507..25077a1a3d82 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2447,8 +2447,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
-		md->disk->flags |= GENHD_FL_NO_PART_SCAN
-				   | GENHD_FL_SUPPRESS_PARTITION_INFO;
+		md->disk->flags |= GENHD_FL_NO_PART |
+				   GENHD_FL_SUPPRESS_PARTITION_INFO;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 12921fba4f52..3ff95ed8513a 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -975,6 +975,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
 		host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
 		host->reset = renesas_sdhi_reset;
+	} else {
+		host->sdcard_irq_mask_all = TMIO_MASK_ALL;
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -1071,9 +1073,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.hs400_complete = renesas_sdhi_hs400_complete;
 	}
 
-	ret = tmio_mmc_host_probe(host);
-	if (ret < 0)
-		goto edisclk;
+	sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
 
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
@@ -1100,6 +1100,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			goto eirq;
 	}
 
+	ret = tmio_mmc_host_probe(host);
+	if (ret < 0)
+		goto edisclk;
+
 	dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
 
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index aee78f5f4f15..c1afadb50eec 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1043,6 +1043,14 @@ static int bcmnand_ctrl_poll_status(struct brcmnand_controller *ctrl,
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
 
@@ -1432,19 +1440,33 @@ static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
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
 
@@ -1563,7 +1585,17 @@ static void brcmnand_send_cmd(struct brcmnand_host *host, int cmd)
 
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
@@ -2583,6 +2615,8 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	struct nand_chip *chip = &host->chip;
 	const struct nand_ecc_props *requirements =
 		nanddev_get_ecc_requirements(&chip->base);
+	struct nand_memory_organization *memorg =
+		nanddev_get_memorg(&chip->base);
 	struct brcmnand_controller *ctrl = host->ctrl;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
 	char msg[128];
@@ -2604,10 +2638,11 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
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
index 6b2bda815b88..17786e1331e6 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1202,9 +1202,14 @@ static int fsmc_nand_suspend(struct device *dev)
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
index 1e61c2364622..e115aab7243e 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -980,21 +980,22 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
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
index 1bad1866ae46..a48220f91a2d 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -468,7 +468,7 @@ static void arcnet_reply_tasklet(struct tasklet_struct *t)
 
 	ret = sock_queue_err_skb(sk, ackskb);
 	if (ret)
-		kfree_skb(ackskb);
+		dev_kfree_skb_irq(ackskb);
 
 	local_irq_enable();
 };
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 5d6062fbebfc..7dc4fb574e45 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -382,6 +382,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
 		skb = alloc_can_err_skb(netdev, &cf);
 		if (!skb)
 			goto resubmit_urb;
@@ -389,8 +392,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		stats->rx_over_errors++;
-		stats->rx_errors++;
 		netif_rx(skb);
 	}
 
diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 5e5d24e7c02b..548d585256fb 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -111,6 +111,8 @@ struct sja1105_info {
 	int max_frame_mem;
 	int num_ports;
 	bool multiple_cascade_ports;
+	/* Every {port, TXQ} has its own CBS shaper */
+	bool fixed_cbs_mapping;
 	enum dsa_tag_protocol tag_proto;
 	const struct sja1105_dynamic_table_ops *dyn_ops;
 	const struct sja1105_table_ops *static_ops;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index ef4d8d6c2bd7..493192a8000c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1794,13 +1794,14 @@ static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 		if (!(l2_lookup.destports & BIT(port)))
 			continue;
 
-		/* We need to hide the FDB entry for unknown multicast */
-		if (l2_lookup.macaddr == SJA1105_UNKNOWN_MULTICAST &&
-		    l2_lookup.mask_macaddr == SJA1105_UNKNOWN_MULTICAST)
-			continue;
-
 		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
 
+		/* Hardware FDB is shared for fdb and mdb, "bridge fdb show"
+		 * only wants to see unicast
+		 */
+		if (is_multicast_ether_addr(macaddr))
+			continue;
+
 		/* We need to hide the dsa_8021q VLANs from the user. */
 		if (!priv->vlan_aware)
 			l2_lookup.vlanid = 0;
@@ -2014,11 +2015,36 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 }
 
 #define BYTES_PER_KBIT (1000LL / 8)
+/* Port 0 (the uC port) does not have CBS shapers */
+#define SJA1110_FIXED_CBS(port, prio) ((((port) - 1) * SJA1105_NUM_TC) + (prio))
+
+static int sja1105_find_cbs_shaper(struct sja1105_private *priv,
+				   int port, int prio)
+{
+	int i;
+
+	if (priv->info->fixed_cbs_mapping) {
+		i = SJA1110_FIXED_CBS(port, prio);
+		if (i >= 0 && i < priv->info->num_cbs_shapers)
+			return i;
+
+		return -1;
+	}
+
+	for (i = 0; i < priv->info->num_cbs_shapers; i++)
+		if (priv->cbs[i].port == port && priv->cbs[i].prio == prio)
+			return i;
+
+	return -1;
+}
 
 static int sja1105_find_unused_cbs_shaper(struct sja1105_private *priv)
 {
 	int i;
 
+	if (priv->info->fixed_cbs_mapping)
+		return -1;
+
 	for (i = 0; i < priv->info->num_cbs_shapers; i++)
 		if (!priv->cbs[i].idle_slope && !priv->cbs[i].send_slope)
 			return i;
@@ -2049,14 +2075,20 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
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
@@ -2066,9 +2098,17 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
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
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index d3c9ad6d39d4..e6b61aef4127 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -781,6 +781,7 @@ const struct sja1105_info sja1110a_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -831,6 +832,7 @@ const struct sja1105_info sja1110b_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -881,6 +883,7 @@ const struct sja1105_info sja1110c_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -931,6 +934,7 @@ const struct sja1105_info sja1110d_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 5cbd815c737e..dad21b4fbc0b 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2104,8 +2104,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
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
index 553f3de93957..9c26c46771f5 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -14317,11 +14317,16 @@ static void bnx2x_io_resume(struct pci_dev *pdev)
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
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 9204f5ecd415..695e299f534d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -757,6 +757,7 @@ struct hnae3_tc_info {
 	u16 tqp_offset[HNAE3_MAX_TC];
 	u8 num_tc; /* Total number of enabled TCs */
 	bool mqprio_active;
+	bool dcb_ets_active;
 };
 
 struct hnae3_knic_private_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 3158c08a3aa9..45f245b1d331 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1171,9 +1171,9 @@ int hns3_dbg_init(struct hnae3_handle *handle)
 	return 0;
 
 out:
-	mutex_destroy(&handle->dbgfs_lock);
 	debugfs_remove_recursive(handle->hnae3_dbgfs);
 	handle->hnae3_dbgfs = NULL;
+	mutex_destroy(&handle->dbgfs_lock);
 	return ret;
 }
 
@@ -1181,6 +1181,9 @@ void hns3_dbg_uninit(struct hnae3_handle *handle)
 {
 	u32 i;
 
+	debugfs_remove_recursive(handle->hnae3_dbgfs);
+	handle->hnae3_dbgfs = NULL;
+
 	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd); i++)
 		if (handle->dbgfs_buf[i]) {
 			kvfree(handle->dbgfs_buf[i]);
@@ -1188,8 +1191,6 @@ void hns3_dbg_uninit(struct hnae3_handle *handle)
 		}
 
 	mutex_destroy(&handle->dbgfs_lock);
-	debugfs_remove_recursive(handle->hnae3_dbgfs);
-	handle->hnae3_dbgfs = NULL;
 }
 
 void hns3_dbg_register_debugfs(const char *debugfs_dir_name)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2acf50ed6025..3693ff55197d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3118,8 +3118,6 @@ static void hns3_set_default_feature(struct net_device *netdev)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
-	netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
-
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER |
 		NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
 		NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 526fb56c84f2..17fa4e7684cd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -739,7 +739,9 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 87640a2e1794..a15f2ed268a8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -251,7 +251,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	int ret;
 
 	if (!(hdev->dcbx_cap & DCB_CAP_DCBX_VER_IEEE) ||
-	    hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
+	    h->kinfo.tc_info.mqprio_active)
 		return -EINVAL;
 
 	ret = hclge_ets_validate(hdev, ets, &num_tc, &map_changed);
@@ -267,10 +267,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	}
 
 	hclge_tm_schd_info_update(hdev, num_tc);
-	if (num_tc > 1)
-		hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
-	else
-		hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
+	h->kinfo.tc_info.dcb_ets_active = num_tc > 1;
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
 	if (ret)
@@ -376,7 +373,7 @@ static u8 hclge_getdcbx(struct hnae3_handle *h)
 	struct hclge_vport *vport = hclge_get_vport(h);
 	struct hclge_dev *hdev = vport->back;
 
-	if (hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
+	if (h->kinfo.tc_info.mqprio_active)
 		return 0;
 
 	return hdev->dcbx_cap;
@@ -500,7 +497,8 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (!test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state))
 		return -EBUSY;
 
-	if (hdev->flag & HCLGE_FLAG_DCB_ENABLE)
+	kinfo = &vport->nic.kinfo;
+	if (kinfo->tc_info.dcb_ets_active)
 		return -EINVAL;
 
 	ret = hclge_mqprio_qopt_check(hdev, mqprio_qopt);
@@ -514,7 +512,6 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (ret)
 		return ret;
 
-	kinfo = &vport->nic.kinfo;
 	memcpy(&old_tc_info, &kinfo->tc_info, sizeof(old_tc_info));
 	hclge_sync_mqprio_qopt(&kinfo->tc_info, mqprio_qopt);
 	kinfo->tc_info.mqprio_active = tc > 0;
@@ -523,13 +520,6 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (ret)
 		goto err_out;
 
-	hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
-
-	if (tc > 1)
-		hdev->flag |= HCLGE_FLAG_MQPRIO_ENABLE;
-	else
-		hdev->flag &= ~HCLGE_FLAG_MQPRIO_ENABLE;
-
 	return hclge_notify_init_up(hdev);
 
 err_out:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index dd8b73aebe6a..63665e8a7c71 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -1450,7 +1450,7 @@ static int hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, bool sel_x,
 	struct hclge_desc desc[3];
 	int pos = 0;
 	int ret, i;
-	u32 *req;
+	__le32 *req;
 
 	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_FD_TCAM_OP, true);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
@@ -1475,22 +1475,22 @@ static int hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, bool sel_x,
 			 tcam_msg.loc);
 
 	/* tcam_data0 ~ tcam_data1 */
-	req = (u32 *)req1->tcam_data;
+	req = (__le32 *)req1->tcam_data;
 	for (i = 0; i < 2; i++)
 		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", *req++);
+				 "%08x\n", le32_to_cpu(*req++));
 
 	/* tcam_data2 ~ tcam_data7 */
-	req = (u32 *)req2->tcam_data;
+	req = (__le32 *)req2->tcam_data;
 	for (i = 0; i < 6; i++)
 		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", *req++);
+				 "%08x\n", le32_to_cpu(*req++));
 
 	/* tcam_data8 ~ tcam_data12 */
-	req = (u32 *)req3->tcam_data;
+	req = (__le32 *)req3->tcam_data;
 	for (i = 0; i < 5; i++)
 		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", *req++);
+				 "%08x\n", le32_to_cpu(*req++));
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 847ebb31d470..a415760505ab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -10993,9 +10993,12 @@ int hclge_cfg_flowctrl(struct hclge_dev *hdev)
 	u32 rx_pause, tx_pause;
 	u8 flowctl;
 
-	if (!phydev->link || !phydev->autoneg)
+	if (!phydev->link)
 		return 0;
 
+	if (!phydev->autoneg)
+		return hclge_mac_pause_setup_hw(hdev);
+
 	local_advertising = linkmode_adv_to_lcl_adv_t(phydev->advertising);
 
 	if (phydev->pause)
@@ -11184,6 +11187,7 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 
 static void hclge_info_show(struct hclge_dev *hdev)
 {
+	struct hnae3_handle *handle = &hdev->vport->nic;
 	struct device *dev = &hdev->pdev->dev;
 
 	dev_info(dev, "PF info begin:\n");
@@ -11200,9 +11204,9 @@ static void hclge_info_show(struct hclge_dev *hdev)
 	dev_info(dev, "This is %s PF\n",
 		 hdev->flag & HCLGE_FLAG_MAIN ? "main" : "not main");
 	dev_info(dev, "DCB %s\n",
-		 hdev->flag & HCLGE_FLAG_DCB_ENABLE ? "enable" : "disable");
+		 handle->kinfo.tc_info.dcb_ets_active ? "enable" : "disable");
 	dev_info(dev, "MQPRIO %s\n",
-		 hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE ? "enable" : "disable");
+		 handle->kinfo.tc_info.mqprio_active ? "enable" : "disable");
 	dev_info(dev, "Default tx spare buffer size: %u\n",
 		 hdev->tx_spare_buf_size);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 4d6dbfe0be7a..a716027df0ed 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -902,8 +902,6 @@ struct hclge_dev {
 
 #define HCLGE_FLAG_MAIN			BIT(0)
 #define HCLGE_FLAG_DCB_CAPABLE		BIT(1)
-#define HCLGE_FLAG_DCB_ENABLE		BIT(2)
-#define HCLGE_FLAG_MQPRIO_ENABLE	BIT(3)
 	u32 flag;
 
 	u32 pkt_buf_size; /* Total pf buf size for tx/rx */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index e7cb6a81e5b6..f5fe5e437bcd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1429,7 +1429,7 @@ static int hclge_bp_setup_hw(struct hclge_dev *hdev, u8 tc)
 	return 0;
 }
 
-static int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
+int hclge_mac_pause_setup_hw(struct hclge_dev *hdev)
 {
 	bool tx_en, rx_en;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 2c5256d7f996..e1f2feaba545 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -233,6 +233,7 @@ int hclge_pfc_pause_en_cfg(struct hclge_dev *hdev, u8 tx_rx_bitmap,
 			   u8 pfc_bitmap);
 int hclge_mac_pause_en_cfg(struct hclge_dev *hdev, bool tx, bool rx);
 int hclge_pause_addr_cfg(struct hclge_dev *hdev, const u8 *mac_addr);
+int hclge_mac_pause_setup_hw(struct hclge_dev *hdev);
 void hclge_pfc_rx_stats_get(struct hclge_dev *hdev, u64 *stats);
 void hclge_pfc_tx_stats_get(struct hclge_dev *hdev, u64 *stats);
 int hclge_tm_qs_shaper_cfg(struct hclge_vport *vport, int max_tx_rate);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a18fa054b4fa..deba18cdc5ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1177,6 +1177,7 @@ int ice_aq_wait_for_event(struct ice_pf *pf, u16 opcode, unsigned long timeout,
 static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
 				struct ice_rq_event_info *event)
 {
+	struct ice_rq_event_info *task_ev;
 	struct ice_aq_task *task;
 	bool found = false;
 
@@ -1185,15 +1186,15 @@ static void ice_aq_check_events(struct ice_pf *pf, u16 opcode,
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
index 015b78144114..a2b759531cb7 100644
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
index bff9649d8abd..c01114cabbb0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3856,8 +3856,9 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	struct pci_dev *pdev = adapter->pdev;
 	struct e1000_hw *hw = &adapter->hw;
 
-	/* Virtualization features not supported on i210 family. */
-	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
+	/* Virtualization features not supported on i210 and 82580 family. */
+	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211) ||
+	    (hw->mac.type == e1000_82580))
 		return;
 
 	/* Of the below we really only want the effect of getting
@@ -4737,6 +4738,10 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
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
@@ -4747,10 +4752,9 @@ static void igb_set_rx_buffer_len(struct igb_adapter *adapter,
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
index 192fee9e72b0..e09ca21b8e3f 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -359,11 +359,11 @@ static inline u32 igc_rss_type(const union igc_adv_rx_desc *rx_desc)
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
index 29be1d6eca43..affd132534ea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -989,6 +989,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	u32 tsync_tx_ctl = IXGBE_TSYNCTXCTL_ENABLED;
 	u32 tsync_rx_ctl = IXGBE_TSYNCRXCTL_ENABLED;
 	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
+	u32 aflags = adapter->flags;
 	bool is_l2 = false;
 	u32 regval;
 
@@ -1010,20 +1011,20 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
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
@@ -1037,8 +1038,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
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
@@ -1049,7 +1050,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		if (hw->mac.type >= ixgbe_mac_X550) {
 			tsync_rx_ctl |= IXGBE_TSYNCRXCTL_TYPE_ALL;
 			config->rx_filter = HWTSTAMP_FILTER_ALL;
-			adapter->flags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
+			aflags |= IXGBE_FLAG_RX_HWTSTAMP_ENABLED;
 			break;
 		}
 		fallthrough;
@@ -1060,8 +1061,6 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 		 * Delay_Req messages and hardware does not support
 		 * timestamping all packets => return error
 		 */
-		adapter->flags &= ~(IXGBE_FLAG_RX_HWTSTAMP_ENABLED |
-				    IXGBE_FLAG_RX_HWTSTAMP_IN_REGISTER);
 		config->rx_filter = HWTSTAMP_FILTER_NONE;
 		return -ERANGE;
 	}
@@ -1093,8 +1092,8 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
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
@@ -1127,6 +1126,9 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 
 	IXGBE_WRITE_FLUSH(hw);
 
+	/* configure adapter flags only when HW is actually configured */
+	adapter->flags = aflags;
+
 	/* clear TX/RX time stamp registers, just to be sure */
 	ixgbe_ptp_clear_tx_timestamp(adapter);
 	IXGBE_READ_REG(hw, IXGBE_RXSTMPH);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ddd4ed34b0f2..31b3ede563c0 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5572,6 +5572,11 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index f5922d63e33e..1593efc4502b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -841,6 +841,21 @@ static int nix_aq_enqueue_wait(struct rvu *rvu, struct rvu_block *block,
 	return 0;
 }
 
+static void nix_get_aq_req_smq(struct rvu *rvu, struct nix_aq_enq_req *req,
+			       u16 *smq, u16 *smq_mask)
+{
+	struct nix_cn10k_aq_enq_req *aq_req;
+
+	if (!is_rvu_otx2(rvu)) {
+		aq_req = (struct nix_cn10k_aq_enq_req *)req;
+		*smq = aq_req->sq.smq;
+		*smq_mask = aq_req->sq_mask.smq;
+	} else {
+		*smq = req->sq.smq;
+		*smq_mask = req->sq_mask.smq;
+	}
+}
+
 static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 				   struct nix_aq_enq_req *req,
 				   struct nix_aq_enq_rsp *rsp)
@@ -852,6 +867,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	struct rvu_block *block;
 	struct admin_queue *aq;
 	struct rvu_pfvf *pfvf;
+	u16 smq, smq_mask;
 	void *ctx, *mask;
 	bool ena;
 	u64 cfg;
@@ -923,13 +939,14 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	if (rc)
 		return rc;
 
+	nix_get_aq_req_smq(rvu, req, &smq, &smq_mask);
 	/* Check if SQ pointed SMQ belongs to this PF/VF or not */
 	if (req->ctype == NIX_AQ_CTYPE_SQ &&
 	    ((req->op == NIX_AQ_INSTOP_INIT && req->sq.ena) ||
 	     (req->op == NIX_AQ_INSTOP_WRITE &&
-	      req->sq_mask.ena && req->sq_mask.smq && req->sq.ena))) {
+	      req->sq_mask.ena && req->sq.ena && smq_mask))) {
 		if (!is_valid_txschq(rvu, blkaddr, NIX_TXSCH_LVL_SMQ,
-				     pcifunc, req->sq.smq))
+				     pcifunc, smq))
 			return NIX_AF_ERR_AQ_ENQUEUE;
 	}
 
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 50ee9d3d4c84..139dfdb1e58b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2038,6 +2038,9 @@ static int mtk_hwlro_get_fdir_all(struct net_device *dev,
 	int i;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (cnt == cmd->rule_cnt)
+			return -EMSGSIZE;
+
 		if (mac->hwlro_ip[i]) {
 			rule_locs[cnt] = i;
 			cnt++;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 8c2b249949b9..8ed1549a99c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -274,16 +274,11 @@ static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
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
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index df16dc35bb04..2fa84556bc20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -138,18 +138,23 @@ int mlx5_set_msix_vec_count(struct mlx5_core_dev *dev, int function_id,
 	return ret;
 }
 
-static void irq_release(struct mlx5_irq *irq)
+static void mlx5_system_free_irq(struct mlx5_irq *irq)
 {
-	struct mlx5_irq_pool *pool = irq->pool;
-
-	xa_erase(&pool->irqs, irq->index);
 	/* free_irq requires that affinity and rmap will be cleared
 	 * before calling it. This is why there is asymmetry with set_rmap
 	 * which should be called after alloc_irq but before request_irq.
 	 */
 	irq_set_affinity_hint(irq->irqn, NULL);
-	free_cpumask_var(irq->mask);
 	free_irq(irq->irqn, &irq->nh);
+}
+
+static void irq_release(struct mlx5_irq *irq)
+{
+	struct mlx5_irq_pool *pool = irq->pool;
+
+	xa_erase(&pool->irqs, irq->index);
+	mlx5_system_free_irq(irq);
+	free_cpumask_var(irq->mask);
 	kfree(irq);
 }
 
@@ -556,7 +561,7 @@ static void mlx5_irq_pool_free_irqs(struct mlx5_irq_pool *pool)
 	unsigned long index;
 
 	xa_for_each(&pool->irqs, index, irq)
-		free_irq(irq->irqn, &irq->nh);
+		mlx5_system_free_irq(irq);
 }
 
 static void mlx5_irq_pools_free_irqs(struct mlx5_irq_table *table)
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
index 98ce24422424..21f41f25a8ab 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1343,8 +1343,7 @@ static struct crypto_aead *macsec_alloc_tfm(char *key, int key_len, int icv_len)
 	struct crypto_aead *tfm;
 	int ret;
 
-	/* Pick a sync gcm(aes) cipher to ensure order is preserved. */
-	tfm = crypto_alloc_aead("gcm(aes)", 0, CRYPTO_ALG_ASYNC);
+	tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
 
 	if (IS_ERR(tfm))
 		return tfm;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 9dde1f8358e3..5c516bf4d3a5 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1412,6 +1412,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x030e, 4)},	/* Quectel EM05GV2 */
 	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 	{QMI_FIXED_INTF(0x0489, 0xe0b4, 0)},	/* Foxconn T77W968 LTE */
 	{QMI_FIXED_INTF(0x0489, 0xe0b5, 0)},	/* Foxconn T77W968 LTE with eSIM support*/
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 579524cb5d9b..4cd9bcca84c5 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2625,6 +2625,9 @@ static int r8152_poll(struct napi_struct *napi, int budget)
 	struct r8152 *tp = container_of(napi, struct r8152, napi);
 	int work_done;
 
+	if (!budget)
+		return 0;
+
 	work_done = rx_bottom(tp, budget);
 
 	if (work_done < budget) {
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 45ee44f66e77..984a15380409 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -320,6 +320,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
+	int ret = NETDEV_TX_OK;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
@@ -352,6 +353,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
+		ret = NET_XMIT_DROP;
 	}
 
 	if (use_napi)
@@ -359,7 +361,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	rcu_read_unlock();
 
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static u64 veth_stats_tx(struct net_device *dev, u64 *packets, u64 *bytes)
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 106b66570e04..41b1b23fdd3e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -730,6 +730,32 @@ static int vxlan_fdb_append(struct vxlan_fdb *f,
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
@@ -1738,35 +1764,6 @@ static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
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
@@ -1867,8 +1864,9 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
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
index 85a30c301dad..3a62f6697313 100644
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
@@ -2821,8 +2822,8 @@ static int ath10k_pci_hif_power_up(struct ath10k *ar,
 
 	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
 				  &ar_pci->link_ctl);
-	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
-				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ar_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	/*
 	 * Bring the target up cleanly.
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index bfa7f8d96d82..b8e4c7425464 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1000,8 +1000,8 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 		   u16_get_bits(ab_pci->link_ctl, PCI_EXP_LNKCTL_ASPM_L1));
 
 	/* disable L0s and L1 */
-	pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-				   ab_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
+	pcie_capability_clear_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_ASPMC);
 
 	set_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags);
 }
@@ -1009,8 +1009,10 @@ static void ath11k_pci_aspm_disable(struct ath11k_pci *ab_pci)
 static void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
-		pcie_capability_write_word(ab_pci->pdev, PCI_EXP_LNKCTL,
-					   ab_pci->link_ctl);
+		pcie_capability_clear_and_set_word(ab_pci->pdev, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   ab_pci->link_ctl &
+						   PCI_EXP_LNKCTL_ASPMC);
 }
 
 static int ath11k_pci_power_up(struct ath11k_base *ab)
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
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
index ff2ef557f0ea..2a1590cc73ab 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
@@ -383,7 +383,12 @@ struct brcmf_scan_params_le {
 				 * fixed parameter portion is assumed, otherwise
 				 * ssid in the fixed portion is ignored
 				 */
-	__le16 channel_list[1];	/* list of chanspecs */
+	union {
+		__le16 padding;	/* Reserve space for at least 1 entry for abort
+				 * which uses an on stack brcmf_scan_params_le
+				 */
+		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
+	};
 };
 
 struct brcmf_scan_results {
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
index 94a6bbcae2d3..8b3f46586654 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -201,6 +201,8 @@ static int mwifiex_pcie_probe_of(struct device *dev)
 }
 
 static void mwifiex_pcie_work(struct work_struct *work);
+static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter);
+static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter);
 
 static int
 mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
@@ -804,14 +806,15 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
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
 
@@ -861,7 +864,6 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for EVENT buf.\n");
-			kfree(card->evtbd_ring_vbase);
 			return -ENOMEM;
 		}
 		skb_put(skb, MAX_EVENT_SIZE);
@@ -869,8 +871,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
 					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
-			kfree(card->evtbd_ring_vbase);
-			return -1;
+			return -ENOMEM;
 		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -1070,6 +1071,7 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -1108,7 +1110,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->rxbd_ring_pbase >> 32),
 		    card->rxbd_ring_size);
 
-	return mwifiex_init_rxq_ring(adapter);
+	ret = mwifiex_init_rxq_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_rxbd_ring(adapter);
+	return ret;
 }
 
 /*
@@ -1139,6 +1144,7 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -1173,7 +1179,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
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
index 245ff644f81e..8a5d0125a1ab 100644
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 7a4f277a1622..09ea97a81fb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -441,7 +441,8 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 		ieee80211_wake_queues(hw);
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_POWER) {
+	if (changed & (IEEE80211_CONF_CHANGE_POWER |
+		       IEEE80211_CONF_CHANGE_CHANNEL)) {
 		ret = mt7915_mcu_set_txpower_sku(phy);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index f73ffbd6e622..0109433e8c2f 100644
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
index 2abd2235bbca..9532108d2dce 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -909,7 +909,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	return 0;
 }
 
-static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
 	qp->active = false;
@@ -932,6 +932,13 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
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
@@ -1174,7 +1181,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
-	ntb_qp_link_down_reset(qp);
+	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
 		num_qps_mw = qp_count / mw_count + 1;
@@ -2276,9 +2283,13 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
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
@@ -2418,7 +2429,7 @@ unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 	unsigned int head = qp->tx_index;
 	unsigned int tail = qp->remote_rx_info->entry;
 
-	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 3a07cc58e7d7..d10fd54415c2 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -165,7 +165,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 /**
  * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-int ima_free_kexec_buffer(void)
+int __init ima_free_kexec_buffer(void)
 {
 	int ret;
 	unsigned long addr;
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 8f2ddba3947e..ee7f3659b353 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -752,8 +752,6 @@ static int init_overlay_changeset(struct overlay_changeset *ovcs)
 	if (!of_node_is_root(ovcs->overlay_root))
 		pr_debug("%s() ovcs->overlay_root is not root\n", __func__);
 
-	of_changeset_init(&ovcs->cset);
-
 	cnt = 0;
 
 	/* fragment nodes */
@@ -995,6 +993,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 
 	INIT_LIST_HEAD(&ovcs->ovcs_list);
 	list_add_tail(&ovcs->ovcs_list, &ovcs_list);
+	of_changeset_init(&ovcs->cset);
 
 	/*
 	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index a9871e2f0a0b..073a3f44c404 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -70,7 +70,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("/testcase-data");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data", name),
+	unittest(np && name && !strcmp("/testcase-data", name),
 		"find /testcase-data failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -81,14 +81,14 @@ static void __init of_unittest_find_node_by_name(void)
 
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
@@ -99,7 +99,7 @@ static void __init of_unittest_find_node_by_name(void)
 
 	np = of_find_node_by_path("testcase-alias/phandle-tests/consumer-a");
 	name = kasprintf(GFP_KERNEL, "%pOF", np);
-	unittest(np && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name),
 		"find testcase-alias/phandle-tests/consumer-a failed\n");
 	of_node_put(np);
 	kfree(name);
@@ -1373,6 +1373,8 @@ static void attach_node_and_children(struct device_node *np)
 	const char *full_name;
 
 	full_name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!full_name)
+		return;
 
 	if (!strcmp(full_name, "/__local_fixups__") ||
 	    !strcmp(full_name, "/__fixups__")) {
@@ -2071,7 +2073,7 @@ static int __init of_unittest_apply_revert_overlay_check(int overlay_nr,
 	of_unittest_untrack_overlay(save_id);
 
 	/* unittest device must be again in before state */
-	if (of_unittest_device_exists(unittest_nr, PDEV_OVERLAY) != before) {
+	if (of_unittest_device_exists(unittest_nr, ovtype) != before) {
 		unittest(0, "%s with device @\"%s\" %s\n",
 				overlay_name_from_nr(overlay_nr),
 				unittest_path(unittest_nr, ovtype),
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4960d5f8c8bc..dbd69d8e44e4 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2392,7 +2392,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 
 		virt_dev = dev_pm_domain_attach_by_name(dev, *name);
 		if (IS_ERR_OR_NULL(virt_dev)) {
-			ret = PTR_ERR(virt_dev) ? : -ENODEV;
+			ret = virt_dev ? PTR_ERR(virt_dev) : -ENODEV;
 			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
 			goto err;
 		}
diff --git a/drivers/parisc/led.c b/drivers/parisc/led.c
index 4c0551f89c44..d4dc7f6addf2 100644
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
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 39f4664bd84c..dd7d74fecc48 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -18,6 +18,20 @@
 
 #include "pcie-designware.h"
 
+#define PEX_PF0_CONFIG			0xC0014
+#define PEX_PF0_CFG_READY		BIT(0)
+
+/* PEX PFa PCIE PME and message interrupt registers*/
+#define PEX_PF0_PME_MES_DR		0xC0020
+#define PEX_PF0_PME_MES_DR_LUD		BIT(7)
+#define PEX_PF0_PME_MES_DR_LDD		BIT(9)
+#define PEX_PF0_PME_MES_DR_HRD		BIT(10)
+
+#define PEX_PF0_PME_MES_IER		0xC0028
+#define PEX_PF0_PME_MES_IER_LUDIE	BIT(7)
+#define PEX_PF0_PME_MES_IER_LDDIE	BIT(9)
+#define PEX_PF0_PME_MES_IER_HRDIE	BIT(10)
+
 #define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
 
 struct ls_pcie_ep_drvdata {
@@ -30,16 +44,98 @@ struct ls_pcie_ep {
 	struct dw_pcie			*pci;
 	struct pci_epc_features		*ls_epc;
 	const struct ls_pcie_ep_drvdata *drvdata;
+	int				irq;
+	u32				lnkcap;
+	bool				big_endian;
 };
 
-static int ls_pcie_establish_link(struct dw_pcie *pci)
+static u32 ls_lut_readl(struct ls_pcie_ep *pcie, u32 offset)
 {
-	return 0;
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pcie->big_endian)
+		return ioread32be(pci->dbi_base + offset);
+	else
+		return ioread32(pci->dbi_base + offset);
 }
 
-static const struct dw_pcie_ops dw_ls_pcie_ep_ops = {
-	.start_link = ls_pcie_establish_link,
-};
+static void ls_lut_writel(struct ls_pcie_ep *pcie, u32 offset, u32 value)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	if (pcie->big_endian)
+		iowrite32be(value, pci->dbi_base + offset);
+	else
+		iowrite32(value, pci->dbi_base + offset);
+}
+
+static irqreturn_t ls_pcie_ep_event_handler(int irq, void *dev_id)
+{
+	struct ls_pcie_ep *pcie = dev_id;
+	struct dw_pcie *pci = pcie->pci;
+	u32 val, cfg;
+	u8 offset;
+
+	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
+	ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
+
+	if (!val)
+		return IRQ_NONE;
+
+	if (val & PEX_PF0_PME_MES_DR_LUD) {
+
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+		/*
+		 * The values of the Maximum Link Width and Supported Link
+		 * Speed from the Link Capabilities Register will be lost
+		 * during link down or hot reset. Restore initial value
+		 * that configured by the Reset Configuration Word (RCW).
+		 */
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+
+		cfg = ls_lut_readl(pcie, PEX_PF0_CONFIG);
+		cfg |= PEX_PF0_CFG_READY;
+		ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
+		dw_pcie_ep_linkup(&pci->ep);
+
+		dev_dbg(pci->dev, "Link up\n");
+	} else if (val & PEX_PF0_PME_MES_DR_LDD) {
+		dev_dbg(pci->dev, "Link down\n");
+	} else if (val & PEX_PF0_PME_MES_DR_HRD) {
+		dev_dbg(pci->dev, "Hot reset\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ls_pcie_ep_interrupt_init(struct ls_pcie_ep *pcie,
+				     struct platform_device *pdev)
+{
+	u32 val;
+	int ret;
+
+	pcie->irq = platform_get_irq_byname(pdev, "pme");
+	if (pcie->irq < 0)
+		return pcie->irq;
+
+	ret = devm_request_irq(&pdev->dev, pcie->irq, ls_pcie_ep_event_handler,
+			       IRQF_SHARED, pdev->name, pcie);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't register PCIe IRQ\n");
+		return ret;
+	}
+
+	/* Enable interrupts */
+	val = ls_lut_readl(pcie, PEX_PF0_PME_MES_IER);
+	val |=  PEX_PF0_PME_MES_IER_LDDIE | PEX_PF0_PME_MES_IER_HRDIE |
+		PEX_PF0_PME_MES_IER_LUDIE;
+	ls_lut_writel(pcie, PEX_PF0_PME_MES_IER, val);
+
+	return 0;
+}
 
 static const struct pci_epc_features*
 ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
@@ -106,19 +202,16 @@ static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 
 static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
 	.func_offset = 0x20000,
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct ls_pcie_ep_drvdata lx2_ep_drvdata = {
 	.func_offset = 0x8000,
 	.ops = &ls_pcie_ep_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
 };
 
 static const struct of_device_id ls_pcie_ep_of_match[] = {
@@ -136,6 +229,8 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	struct ls_pcie_ep *pcie;
 	struct pci_epc_features *ls_epc;
 	struct resource *dbi_base;
+	u8 offset;
+	int ret;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -155,6 +250,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
+	ls_epc->linkup_notifier = true;
 
 	pcie->pci = pci;
 	pcie->ls_epc = ls_epc;
@@ -166,9 +262,18 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 
 	pci->ep.ops = &ls_pcie_ep_ops;
 
+	pcie->big_endian = of_property_read_bool(dev->of_node, "big-endian");
+
 	platform_set_drvdata(pdev, pcie);
 
-	return dw_pcie_ep_init(&pci->ep);
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	pcie->lnkcap = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+
+	ret = dw_pcie_ep_init(&pci->ep);
+	if (ret)
+		return ret;
+
+	return ls_pcie_ep_interrupt_init(pcie, pdev);
 }
 
 static struct platform_driver ls_pcie_ep_driver = {
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2af4ed90e12b..5023b7f704d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -434,8 +434,7 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 }
 
 static int dw_pcie_ep_start(struct pci_epc *epc)
@@ -443,10 +442,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops || !pci->ops->start_link)
-		return -EINVAL;
-
-	return pci->ops->start_link(pci);
+	return dw_pcie_start_link(pci);
 }
 
 static const struct pci_epc_features*
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7cd4593ad12f..f561e87cd5f6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -402,8 +402,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
-		ret = pci->ops->start_link(pci);
+	if (!dw_pcie_link_up(pci)) {
+		ret = dw_pcie_start_link(pci);
 		if (ret)
 			goto err_free_msi;
 	}
@@ -420,8 +420,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 
 err_stop_link:
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 
 err_free_msi:
 	if (pp->has_msi_ctrl)
@@ -437,8 +436,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
 
-	if (pci->ops && pci->ops->stop_link)
-		pci->ops->stop_link(pci);
+	dw_pcie_stop_link(pci);
 
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 8851eb161a0e..107318ad2281 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -36,15 +36,6 @@ static const struct of_device_id dw_plat_pcie_of_match[];
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 };
 
-static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
-{
-	return 0;
-}
-
-static const struct dw_pcie_ops dw_pcie_ops = {
-	.start_link = dw_plat_pcie_establish_link,
-};
-
 static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -142,7 +133,6 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
 	dw_plat_pcie->pci = pci;
 	dw_plat_pcie->mode = mode;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7d6e9b7576be..8ba239292634 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -365,6 +365,20 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 	dw_pcie_writel_dbi(pci, reg, val);
 }
 
+static inline int dw_pcie_start_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->start_link)
+		return pci->ops->start_link(pci);
+
+	return 0;
+}
+
+static inline void dw_pcie_stop_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 6e8a6540b377..8eb049c839ca 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -167,12 +167,12 @@
 #define EVENT_PCIE_DLUP_EXIT			2
 #define EVENT_SEC_TX_RAM_SEC_ERR		3
 #define EVENT_SEC_RX_RAM_SEC_ERR		4
-#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		5
-#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		6
+#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		5
+#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		6
 #define EVENT_DED_TX_RAM_DED_ERR		7
 #define EVENT_DED_RX_RAM_DED_ERR		8
-#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		9
-#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		10
+#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		9
+#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		10
 #define EVENT_LOCAL_DMA_END_ENGINE_0		11
 #define EVENT_LOCAL_DMA_END_ENGINE_1		12
 #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 88e2bf65e433..e3a9292f2dbe 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -159,7 +159,9 @@
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
 
-#define PCIE_ADDR_MASK			0xffffff00
+#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
+#define MIN_AXI_ADDR_BITS_PASSED		8
+#define PCIE_ADDR_MASK			GENMASK_ULL(63, MIN_AXI_ADDR_BITS_PASSED)
 #define PCIE_CORE_AXI_CONF_BASE		0xc00000
 #define PCIE_CORE_OB_REGION_ADDR0	(PCIE_CORE_AXI_CONF_BASE + 0x0)
 #define   PCIE_CORE_OB_REGION_ADDR0_NUM_BITS	0x3f
@@ -186,8 +188,6 @@
 #define AXI_WRAPPER_TYPE1_CFG			0xb
 #define AXI_WRAPPER_NOR_MSG			0xc
 
-#define MAX_AXI_IB_ROOTPORT_REGION_NUM		3
-#define MIN_AXI_ADDR_BITS_PASSED		8
 #define PCIE_RC_SEND_PME_OFF			0x11960
 #define ROCKCHIP_VENDOR_ID			0x1d87
 #define PCIE_LINK_IS_L2(x) \
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 60098a701e83..7773009b8b32 100644
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
index 3078de668f91..4a2c229205fd 100644
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
index b1b2a55de77f..4daa782c48df 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -102,6 +102,7 @@ struct ddr_pmu {
 	const struct fsl_ddr_devtype_data *devtype_data;
 	int irq;
 	int id;
+	int active_counter;
 };
 
 static ssize_t ddr_perf_identifier_show(struct device *dev,
@@ -496,6 +497,10 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 
 	ddr_perf_counter_enable(pmu, event->attr.config, counter, true);
 
+	if (!pmu->active_counter++)
+		ddr_perf_counter_enable(pmu, EVENT_CYCLES_ID,
+			EVENT_CYCLES_COUNTER, true);
+
 	hwc->state = 0;
 }
 
@@ -550,6 +555,10 @@ static void ddr_perf_event_stop(struct perf_event *event, int flags)
 	ddr_perf_counter_enable(pmu, event->attr.config, counter, false);
 	ddr_perf_event_update(event);
 
+	if (!--pmu->active_counter)
+		ddr_perf_counter_enable(pmu, EVENT_CYCLES_ID,
+			EVENT_CYCLES_COUNTER, false);
+
 	hwc->state |= PERF_HES_STOPPED;
 }
 
@@ -568,25 +577,10 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 
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
index 80acca4e9e14..2556caf475c0 100644
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
index 34f0ec784dbe..1b993b33d60f 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1624,7 +1624,6 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	const struct intel_pinctrl_soc_data *soc_data;
 	struct intel_community *community;
 	struct device *dev = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct intel_pinctrl *pctrl;
 	acpi_status status;
 	int ret, irq;
@@ -1687,7 +1686,7 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	status = acpi_install_address_space_handler(adev->handle,
+	status = acpi_install_address_space_handler(ACPI_HANDLE(dev),
 					community->acpi_space_id,
 					chv_pinctrl_mmio_access_handler,
 					NULL, pctrl);
@@ -1704,7 +1703,7 @@ static int chv_pinctrl_remove(struct platform_device *pdev)
 	struct intel_pinctrl *pctrl = platform_get_drvdata(pdev);
 	const struct intel_community *community = &pctrl->communities[0];
 
-	acpi_remove_address_space_handler(ACPI_COMPANION(&pdev->dev),
+	acpi_remove_address_space_handler(ACPI_HANDLE(&pdev->dev),
 					  community->acpi_space_id,
 					  chv_pinctrl_mmio_access_handler);
 
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
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index be967d797c28..2d4bbe99959e 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -191,6 +191,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_smgen_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xa0, "TPIO_DATA_BEAT" },
 	{ 0xa1, "TDMA_DATA_BEAT" },
 	{ 0xa2, "MAP_DATA_BEAT" },
@@ -214,6 +215,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_1[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xa0, "TPIO_DATA_BEAT" },
 	{ 0xa1, "TDMA_DATA_BEAT" },
 	{ 0xa2, "MAP_DATA_BEAT" },
@@ -246,6 +248,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_trio_events_2[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x100, "ECC_SINGLE_ERROR_CNT" },
 	{ 0x104, "ECC_DOUBLE_ERROR_CNT" },
 	{ 0x114, "SERR_INJ" },
@@ -258,6 +261,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_ecc_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0xc0, "RXREQ_MSS" },
 	{ 0xc1, "RXDAT_MSS" },
 	{ 0xc2, "TXRSP_MSS" },
@@ -265,6 +269,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_mss_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x45, "HNF_REQUESTS" },
 	{ 0x46, "HNF_REJECTS" },
 	{ 0x47, "ALL_BUSY" },
@@ -323,6 +328,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_hnf_events[] = {
 };
 
 static const struct mlxbf_pmc_events mlxbf_pmc_hnfnet_events[] = {
+	{ 0x0, "DISABLE" },
 	{ 0x12, "CDN_REQ" },
 	{ 0x13, "DDN_REQ" },
 	{ 0x14, "NDN_REQ" },
@@ -892,7 +898,7 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 				uint64_t *result)
 {
 	uint32_t perfcfg_offset, perfval_offset;
-	uint64_t perfmon_cfg, perfevt, perfctl;
+	uint64_t perfmon_cfg, perfevt;
 
 	if (cnt_num >= pmc->block[blk_num].counters)
 		return -EINVAL;
@@ -904,25 +910,6 @@ static int mlxbf_pmc_read_event(int blk_num, uint32_t cnt_num, bool is_l3,
 	perfval_offset = perfcfg_offset +
 			 pmc->block[blk_num].counters * MLXBF_PMC_REG_SIZE;
 
-	/* Set counter in "read" mode */
-	perfmon_cfg = FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
-				 MLXBF_PMC_PERFCTL);
-	perfmon_cfg |= FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_STROBE, 1);
-	perfmon_cfg |= FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_WR_R_B, 0);
-
-	if (mlxbf_pmc_write(pmc->block[blk_num].mmio_base + perfcfg_offset,
-			    MLXBF_PMC_WRITE_REG_64, perfmon_cfg))
-		return -EFAULT;
-
-	/* Check if the counter is enabled */
-
-	if (mlxbf_pmc_read(pmc->block[blk_num].mmio_base + perfval_offset,
-			   MLXBF_PMC_READ_REG_64, &perfctl))
-		return -EFAULT;
-
-	if (!FIELD_GET(MLXBF_PMC_PERFCTL_EN0, perfctl))
-		return -EINVAL;
-
 	/* Set counter in "read" mode */
 	perfmon_cfg = FIELD_PREP(MLXBF_PMC_PERFMON_CONFIG_ADDR,
 				 MLXBF_PMC_PERFEVT);
@@ -1008,7 +995,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 	} else
 		return -EINVAL;
 
-	return sprintf(buf, "0x%llx\n", value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 
 /* Store function for "counter" sysfs files */
@@ -1078,13 +1065,13 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
 
 	err = mlxbf_pmc_read_event(blk_num, cnt_num, is_l3, &evt_num);
 	if (err)
-		return sprintf(buf, "No event being monitored\n");
+		return sysfs_emit(buf, "No event being monitored\n");
 
 	evt_name = mlxbf_pmc_get_event_name(pmc->block_name[blk_num], evt_num);
 	if (!evt_name)
 		return -EINVAL;
 
-	return sprintf(buf, "0x%llx: %s\n", evt_num, evt_name);
+	return sysfs_emit(buf, "0x%llx: %s\n", evt_num, evt_name);
 }
 
 /* Store function for "event" sysfs files */
@@ -1139,9 +1126,9 @@ static ssize_t mlxbf_pmc_event_list_show(struct device *dev,
 		return -EINVAL;
 
 	for (i = 0, buf[0] = '\0'; i < size; ++i) {
-		len += sprintf(e_info, "0x%x: %s\n", events[i].evt_num,
-			       events[i].evt_name);
-		if (len > PAGE_SIZE)
+		len += snprintf(e_info, sizeof(e_info), "0x%x: %s\n",
+				events[i].evt_num, events[i].evt_name);
+		if (len >= PAGE_SIZE)
 			break;
 		strcat(buf, e_info);
 		ret = len;
@@ -1168,7 +1155,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 
 	value = FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN, perfcnt_cfg);
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 /* Store function for "enable" sysfs files - only for l3cache */
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
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 636bdfa83284..907fde53e95c 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -396,6 +396,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
 	struct kobject *attr_name_kobj; //individual attribute names
 	union acpi_object *obj = NULL;
 	union acpi_object *elements;
+	struct kobject *duplicate;
 	struct kset *tmp_set;
 	int min_elements;
 
@@ -454,9 +455,11 @@ static int init_bios_attributes(int attr_type, const char *guid)
 		else
 			tmp_set = wmi_priv.main_dir_kset;
 
-		if (kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer)) {
-			pr_debug("duplicate attribute name found - %s\n",
-				elements[ATTR_NAME].string.pointer);
+		duplicate = kset_find_obj(tmp_set, elements[ATTR_NAME].string.pointer);
+		if (duplicate) {
+			pr_debug("Duplicate attribute name found - %s\n",
+				 elements[ATTR_NAME].string.pointer);
+			kobject_put(duplicate);
 			goto nextobj;
 		}
 
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
 
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 4d1c78635114..f59a3cc9767b 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -138,6 +138,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite Dragonfly G2 Notebook PC"),
+		},
+	},
 	{ }
 };
 
@@ -608,7 +614,7 @@ static bool button_array_present(struct platform_device *device)
 static int intel_hid_probe(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
-	unsigned long long mode;
+	unsigned long long mode, dummy;
 	struct intel_hid_priv *priv;
 	acpi_status status;
 	int err;
@@ -673,18 +679,15 @@ static int intel_hid_probe(struct platform_device *device)
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
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 36f7ea381838..bb415be73bbe 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -422,13 +422,14 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
-	struct regmap *regmap;
-	struct clk *clk, *gclk = NULL;
-	struct clk *slow_clk;
 	char clk_name[] = "t0_clk";
 	int err;
 	int channel;
 
+	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
+	if (tcbpwm == NULL)
+		return -ENOMEM;
+
 	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
 		dev_err(&pdev->dev,
@@ -437,49 +438,43 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	regmap = syscon_node_to_regmap(np->parent);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	tcbpwm->regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(tcbpwm->regmap))
+		return PTR_ERR(tcbpwm->regmap);
 
-	slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
-	if (IS_ERR(slow_clk))
-		return PTR_ERR(slow_clk);
+	tcbpwm->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
+	if (IS_ERR(tcbpwm->slow_clk))
+		return PTR_ERR(tcbpwm->slow_clk);
 
 	clk_name[1] += channel;
-	clk = of_clk_get_by_name(np->parent, clk_name);
-	if (IS_ERR(clk))
-		clk = of_clk_get_by_name(np->parent, "t0_clk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
+	if (IS_ERR(tcbpwm->clk))
+		tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
+	if (IS_ERR(tcbpwm->clk)) {
+		err = PTR_ERR(tcbpwm->clk);
+		goto err_slow_clk;
+	}
 
 	match = of_match_node(atmel_tcb_of_match, np->parent);
 	config = match->data;
 
 	if (config->has_gclk) {
-		gclk = of_clk_get_by_name(np->parent, "gclk");
-		if (IS_ERR(gclk))
-			return PTR_ERR(gclk);
-	}
-
-	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
-	if (tcbpwm == NULL) {
-		err = -ENOMEM;
-		goto err_slow_clk;
+		tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
+		if (IS_ERR(tcbpwm->gclk)) {
+			err = PTR_ERR(tcbpwm->gclk);
+			goto err_clk;
+		}
 	}
 
 	tcbpwm->chip.dev = &pdev->dev;
 	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->channel = channel;
-	tcbpwm->regmap = regmap;
-	tcbpwm->clk = clk;
-	tcbpwm->gclk = gclk;
-	tcbpwm->slow_clk = slow_clk;
 	tcbpwm->width = config->counter_width;
 
-	err = clk_prepare_enable(slow_clk);
+	err = clk_prepare_enable(tcbpwm->slow_clk);
 	if (err)
-		goto err_slow_clk;
+		goto err_gclk;
 
 	spin_lock_init(&tcbpwm->lock);
 
@@ -494,23 +489,28 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 err_disable_clk:
 	clk_disable_unprepare(tcbpwm->slow_clk);
 
+err_gclk:
+	clk_put(tcbpwm->gclk);
+
+err_clk:
+	clk_put(tcbpwm->clk);
+
 err_slow_clk:
-	clk_put(slow_clk);
+	clk_put(tcbpwm->slow_clk);
 
 	return err;
 }
 
-static int atmel_tcb_pwm_remove(struct platform_device *pdev)
+static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&tcbpwm->chip);
 
 	clk_disable_unprepare(tcbpwm->slow_clk);
-	clk_put(tcbpwm->slow_clk);
+	clk_put(tcbpwm->gclk);
 	clk_put(tcbpwm->clk);
-
-	return 0;
+	clk_put(tcbpwm->slow_clk);
 }
 
 static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
@@ -564,7 +564,7 @@ static struct platform_driver atmel_tcb_pwm_driver = {
 		.pm = &atmel_tcb_pwm_pm_ops,
 	},
 	.probe = atmel_tcb_pwm_probe,
-	.remove = atmel_tcb_pwm_remove,
+	.remove_new = atmel_tcb_pwm_remove,
 };
 module_platform_driver(atmel_tcb_pwm_driver);
 
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index ddeab5687cb8..45b613dbc1c7 100644
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
@@ -118,9 +118,9 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.npwm = 1;
 
 	/* If PWM is disabled, configure the output to the default value */
-	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
-	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	ret = devm_pwmchip_add(&pdev->dev, &lpc32xx->chip);
 	if (ret < 0) {
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index fd4c2f0fa4b1..d37fd1f431fe 100644
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
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index ed897dc499ff..0c6ab288201e 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2948,41 +2948,32 @@ static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
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
@@ -2997,13 +2988,32 @@ static int dasd_flush_block_queue(struct dasd_block *block)
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
@@ -3926,75 +3936,36 @@ EXPORT_SYMBOL_GPL(dasd_generic_space_avail);
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
index 83b335f962c8..34e1d1b339c1 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -744,7 +744,7 @@ static int pkey_verifykey2(const u8 *key, size_t keylen,
 		if (ktype)
 			*ktype = PKEY_TYPE_EP11;
 		if (ksize)
-			*ksize = kb->head.keybitlen;
+			*ksize = kb->head.bitlen;
 
 		rc = ep11_findcard2(&_apqns, &_nr_apqns, *cardnr, *domain,
 				    ZCRYPT_CEX7, EP11_API_V, kb->wkvp);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 356318746dd1..17b3f1ea3a5c 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -398,6 +398,7 @@ static int zcdn_create(const char *name)
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
diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 8aeaddc93b16..8d374ae863ba 100644
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
index 558f3f4e1859..303ecbd86b68 100644
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
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index b0b2361e63fe..c40588ed68a5 100644
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
@@ -2442,7 +2448,8 @@ static void slot_complete_v2_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 	{
 		ts->stat = SAS_SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	}
 	default:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 9515ab66a778..b8a12d3ad5f2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -405,6 +405,8 @@
 #define CMPLT_HDR_ERROR_PHASE_MSK   (0xff << CMPLT_HDR_ERROR_PHASE_OFF)
 #define CMPLT_HDR_RSPNS_XFRD_OFF	10
 #define CMPLT_HDR_RSPNS_XFRD_MSK	(0x1 << CMPLT_HDR_RSPNS_XFRD_OFF)
+#define CMPLT_HDR_RSPNS_GOOD_OFF	11
+#define CMPLT_HDR_RSPNS_GOOD_MSK	(0x1 << CMPLT_HDR_RSPNS_GOOD_OFF)
 #define CMPLT_HDR_ERX_OFF		12
 #define CMPLT_HDR_ERX_MSK		(0x1 << CMPLT_HDR_ERX_OFF)
 #define CMPLT_HDR_ABORT_STAT_OFF	13
@@ -478,6 +480,9 @@ struct hisi_sas_err_record_v3 {
 #define RX_DATA_LEN_UNDERFLOW_OFF	6
 #define RX_DATA_LEN_UNDERFLOW_MSK	(1 << RX_DATA_LEN_UNDERFLOW_OFF)
 
+#define RX_FIS_STATUS_ERR_OFF		0
+#define RX_FIS_STATUS_ERR_MSK		(1 << RX_FIS_STATUS_ERR_OFF)
+
 #define HISI_SAS_COMMAND_ENTRIES_V3_HW 4096
 #define HISI_SAS_MSI_COUNT_V3_HW 32
 
@@ -2136,7 +2141,7 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	return IRQ_HANDLED;
 }
 
-static void
+static bool
 slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	       struct hisi_sas_slot *slot)
 {
@@ -2149,11 +2154,22 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
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
@@ -2167,7 +2183,10 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
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
@@ -2177,7 +2196,8 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 			ts->stat = SAS_OPEN_REJECT;
 			ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
 		}
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	case SAS_PROTOCOL_SMP:
 		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
@@ -2185,6 +2205,7 @@ slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
 	default:
 		break;
 	}
+	return true;
 }
 
 static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
@@ -2259,19 +2280,20 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	if ((dw0 & CMPLT_HDR_CMPLT_MSK) == 0x3) {
 		u32 *error_info = hisi_sas_status_buf_addr_mem(slot);
 
-		slot_err_v3_hw(hisi_hba, task, slot);
-		if (ts->stat != SAS_DATA_UNDERRUN)
-			dev_info(dev, "erroneous completion iptt=%d task=%pK dev id=%d addr=%016llx CQ hdr: 0x%x 0x%x 0x%x 0x%x Error info: 0x%x 0x%x 0x%x 0x%x\n",
-				 slot->idx, task, sas_dev->device_id,
-				 SAS_ADDR(device->sas_addr),
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
@@ -2301,7 +2323,8 @@ static void slot_complete_v3_hw(struct hisi_hba *hisi_hba,
 	case SAS_PROTOCOL_STP:
 	case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
 		ts->stat = SAS_SAM_STAT_GOOD;
-		hisi_sas_sata_done(task, slot);
+		if (dw0 & CMPLT_HDR_RSPNS_XFRD_MSK)
+			hisi_sas_sata_done(task, slot);
 		break;
 	default:
 		ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 7dc42d0e2a0d..1b285ce62f8a 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -518,7 +518,7 @@ EXPORT_SYMBOL(scsi_host_alloc);
 static int __scsi_host_match(struct device *dev, const void *data)
 {
 	struct Scsi_Host *p;
-	const unsigned short *hostnum = data;
+	const unsigned int *hostnum = data;
 
 	p = class_to_shost(dev);
 	return p->host_no == *hostnum;
@@ -535,7 +535,7 @@ static int __scsi_host_match(struct device *dev, const void *data)
  *	that scsi_host_get() took. The put_device() below dropped
  *	the reference from class_find_device().
  **/
-struct Scsi_Host *scsi_host_lookup(unsigned short hostnum)
+struct Scsi_Host *scsi_host_lookup(unsigned int hostnum)
 {
 	struct device *cdev;
 	struct Scsi_Host *shost = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index fdf08cb57207..ed827f198cb6 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -911,7 +911,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 			struct lpfc_iocbq *piocbq)
 {
 	uint32_t evt_req_id = 0;
-	uint32_t cmd;
+	u16 cmd;
 	struct lpfc_dmabuf *dmabuf = NULL;
 	struct lpfc_bsg_event *evt;
 	struct event_data *evt_dat = NULL;
@@ -936,7 +936,7 @@ lpfc_bsg_ct_unsol_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	ct_req = (struct lpfc_sli_ct_request *)bdeBuf1->virt;
 	evt_req_id = ct_req->FsType;
-	cmd = ct_req->CommandResponse.bits.CmdRsp;
+	cmd = be16_to_cpu(ct_req->CommandResponse.bits.CmdRsp);
 
 	spin_lock_irqsave(&phba->ct_ev_lock, flags);
 	list_for_each_entry(evt, &phba->ct_ev_waiters, node) {
@@ -3243,8 +3243,8 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
 			ctreq->RevisionId.bits.InId = 0;
 			ctreq->FsType = SLI_CT_ELX_LOOPBACK;
 			ctreq->FsSubType = 0;
-			ctreq->CommandResponse.bits.CmdRsp = ELX_LOOPBACK_DATA;
-			ctreq->CommandResponse.bits.Size   = size;
+			ctreq->CommandResponse.bits.CmdRsp = cpu_to_be16(ELX_LOOPBACK_DATA);
+			ctreq->CommandResponse.bits.Size   = cpu_to_be16(size);
 			segment_offset = ELX_LOOPBACK_HEADER_SZ;
 		} else
 			segment_offset = 0;
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index edae98a35fc3..4813adec0301 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -117,8 +117,6 @@ lpfc_sli4_set_rsp_sgl_last(struct lpfc_hba *phba,
 	}
 }
 
-#define LPFC_INVALID_REFTAG ((u32)-1)
-
 /**
  * lpfc_update_stats - Update statistical data for the command completion
  * @vport: The virtual port on which this call is executing.
@@ -1042,8 +1040,6 @@ lpfc_bg_err_inject(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	sgpe = scsi_prot_sglist(sc);
 	lba = scsi_prot_ref_tag(sc);
-	if (lba == LPFC_INVALID_REFTAG)
-		return 0;
 
 	/* First check if we need to match the LBA */
 	if (phba->lpfc_injerr_lba != LPFC_INJERR_LBA_OFF) {
@@ -1624,8 +1620,6 @@ lpfc_bg_setup_bpl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -1787,8 +1781,6 @@ lpfc_bg_setup_bpl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2018,8 +2010,6 @@ lpfc_bg_setup_sgl(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 
 	/* extract some info from the scsi command for pde*/
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2219,8 +2209,6 @@ lpfc_bg_setup_sgl_prot(struct lpfc_hba *phba, struct scsi_cmnd *sc,
 	/* extract some info from the scsi command */
 	blksize = scsi_prot_interval(sc);
 	reftag = scsi_prot_ref_tag(sc);
-	if (reftag == LPFC_INVALID_REFTAG)
-		goto out;
 
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	rc = lpfc_bg_err_inject(phba, sc, &reftag, NULL, 1);
@@ -2812,8 +2800,6 @@ lpfc_calc_bg_err(struct lpfc_hba *phba, struct lpfc_io_buf *lpfc_cmd)
 
 		src = (struct scsi_dif_tuple *)sg_virt(sgpe);
 		start_ref_tag = scsi_prot_ref_tag(cmd);
-		if (start_ref_tag == LPFC_INVALID_REFTAG)
-			goto out;
 		start_app_tag = src->app_tag;
 		len = sgpe->length;
 		while (src && protsegcnt) {
@@ -3660,11 +3646,11 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 			     scsi_cmnd->sc_data_direction);
 
 	lpfc_printf_log(phba, KERN_ERR, LOG_TRACE_EVENT,
-			"9084 Cannot setup S/G List for HBA"
-			"IO segs %d/%d SGL %d SCSI %d: %d %d\n",
+			"9084 Cannot setup S/G List for HBA "
+			"IO segs %d/%d SGL %d SCSI %d: %d %d %d\n",
 			lpfc_cmd->seg_cnt, lpfc_cmd->prot_seg_cnt,
 			phba->cfg_total_seg_cnt, phba->cfg_sg_seg_cnt,
-			prot_group_type, num_sge);
+			prot_group_type, num_sge, ret);
 
 	lpfc_cmd->seg_cnt = 0;
 	lpfc_cmd->prot_seg_cnt = 0;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 5aa4ae0b0607..d7dabf53a0d5 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -139,6 +139,9 @@ _base_get_ioc_facts(struct MPT3SAS_ADAPTER *ioc);
 static void
 _base_clear_outstanding_commands(struct MPT3SAS_ADAPTER *ioc);
 
+static u32
+_base_readl_ext_retry(const volatile void __iomem *addr);
+
 /**
  * mpt3sas_base_check_cmd_timeout - Function
  *		to check timeout and command termination due
@@ -214,6 +217,20 @@ _base_readl_aero(const volatile void __iomem *addr)
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
@@ -941,7 +958,7 @@ mpt3sas_halt_firmware(struct MPT3SAS_ADAPTER *ioc)
 
 	dump_stack();
 
-	doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+	doorbell = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 	if ((doorbell & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT) {
 		mpt3sas_print_fault_code(ioc, doorbell &
 		    MPI2_DOORBELL_DATA_MASK);
@@ -6537,7 +6554,7 @@ mpt3sas_base_get_iocstate(struct MPT3SAS_ADAPTER *ioc, int cooked)
 {
 	u32 s, sc;
 
-	s = ioc->base_readl(&ioc->chip->Doorbell);
+	s = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 	sc = s & MPI2_IOC_STATE_MASK;
 	return cooked ? sc : s;
 }
@@ -6682,7 +6699,7 @@ _base_wait_for_doorbell_ack(struct MPT3SAS_ADAPTER *ioc, int timeout)
 					   __func__, count, timeout));
 			return 0;
 		} else if (int_status & MPI2_HIS_IOC2SYS_DB_STATUS) {
-			doorbell = ioc->base_readl(&ioc->chip->Doorbell);
+			doorbell = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 			if ((doorbell & MPI2_IOC_STATE_MASK) ==
 			    MPI2_IOC_STATE_FAULT) {
 				mpt3sas_print_fault_code(ioc, doorbell);
@@ -6722,7 +6739,7 @@ _base_wait_for_doorbell_not_used(struct MPT3SAS_ADAPTER *ioc, int timeout)
 	count = 0;
 	cntdn = 1000 * timeout;
 	do {
-		doorbell_reg = ioc->base_readl(&ioc->chip->Doorbell);
+		doorbell_reg = ioc->base_readl_ext_retry(&ioc->chip->Doorbell);
 		if (!(doorbell_reg & MPI2_DOORBELL_USED)) {
 			dhsprintk(ioc,
 				  ioc_info(ioc, "%s: successful count(%d), timeout(%d)\n",
@@ -6870,7 +6887,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	__le32 *mfp;
 
 	/* make sure doorbell is not in use */
-	if ((ioc->base_readl(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
+	if ((ioc->base_readl_ext_retry(&ioc->chip->Doorbell) & MPI2_DOORBELL_USED)) {
 		ioc_err(ioc, "doorbell is in use (line=%d)\n", __LINE__);
 		return -EFAULT;
 	}
@@ -6919,7 +6936,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 	}
 
 	/* read the first two 16-bits, it gives the total length of the reply */
-	reply[0] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[0] = le16_to_cpu(ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 	if ((_base_wait_for_doorbell_int(ioc, 5))) {
@@ -6927,7 +6944,7 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
 			__LINE__);
 		return -EFAULT;
 	}
-	reply[1] = le16_to_cpu(ioc->base_readl(&ioc->chip->Doorbell)
+	reply[1] = le16_to_cpu(ioc->base_readl_ext_retry(&ioc->chip->Doorbell)
 	    & MPI2_DOORBELL_DATA_MASK);
 	writel(0, &ioc->chip->HostInterruptStatus);
 
@@ -6938,10 +6955,10 @@ _base_handshake_req_reply_wait(struct MPT3SAS_ADAPTER *ioc, int request_bytes,
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
@@ -7800,7 +7817,7 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 			goto out;
 		}
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl_ext_retry(&ioc->chip->HostDiagnostic);
 		drsprintk(ioc,
 			  ioc_info(ioc, "wrote magic sequence: count(%d), host_diagnostic(0x%08x)\n",
 				   count, host_diagnostic));
@@ -7820,7 +7837,7 @@ _base_diag_reset(struct MPT3SAS_ADAPTER *ioc)
 	for (count = 0; count < (300000000 /
 		MPI2_HARD_RESET_PCIE_SECOND_READ_DELAY_MICRO_SEC); count++) {
 
-		host_diagnostic = ioc->base_readl(&ioc->chip->HostDiagnostic);
+		host_diagnostic = ioc->base_readl_ext_retry(&ioc->chip->HostDiagnostic);
 
 		if (host_diagnostic == 0xFFFFFFFF) {
 			ioc_info(ioc,
@@ -8210,10 +8227,13 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
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
index 1b3a44ce65aa..0ff208a41a47 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1618,6 +1618,7 @@ struct MPT3SAS_ADAPTER {
 	u8		diag_trigger_active;
 	u8		atomic_desc_capable;
 	BASE_READ_REG	base_readl;
+	BASE_READ_REG	base_readl_ext_retry;
 	struct SL_WH_MASTER_TRIGGER_T diag_trigger_master;
 	struct SL_WH_EVENT_TRIGGERS_T diag_trigger_event;
 	struct SL_WH_SCSI_TRIGGERS_T diag_trigger_scsi;
diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index f4d81127239e..5ec2b817c694 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -59,6 +59,8 @@ extern uint qedf_debug;
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
index d2fe8ae97abc..b36edbef5b82 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -1979,8 +1979,9 @@ static int qedi_cpu_offline(unsigned int cpu)
 	struct qedi_percpu_s *p = this_cpu_ptr(&qedi_percpu);
 	struct qedi_work *work, *tmp;
 	struct task_struct *thread;
+	unsigned long flags;
 
-	spin_lock_bh(&p->p_work_lock);
+	spin_lock_irqsave(&p->p_work_lock, flags);
 	thread = p->iothread;
 	p->iothread = NULL;
 
@@ -1991,7 +1992,7 @@ static int qedi_cpu_offline(unsigned int cpu)
 			kfree(work);
 	}
 
-	spin_unlock_bh(&p->p_work_lock);
+	spin_unlock_irqrestore(&p->p_work_lock, flags);
 	if (thread)
 		kthread_stop(thread);
 	return 0;
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 4a5df867057b..fe0e8b23a805 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -3084,8 +3084,6 @@ qla24xx_vport_create(struct fc_vport *fc_vport, bool disable)
 			vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_user, vha, 0x7082,
 			    "Registered for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			scsi_host_set_prot(vha->host,
 			    prot | SHOST_DIF_TYPE1_PROTECTION
 			    | SHOST_DIF_TYPE2_PROTECTION
diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 7cf1f78cbaee..8e9ffbec6643 100644
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
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 83228ce822af..d70c2f4ba718 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -453,6 +453,7 @@ static inline be_id_t port_id_to_be_id(port_id_t port_id)
 }
 
 struct tmf_arg {
+	struct list_head tmf_elem;
 	struct qla_qpair *qpair;
 	struct fc_port *fcport;
 	struct scsi_qla_host *vha;
@@ -2523,7 +2524,6 @@ enum rscn_addr_format {
 typedef struct fc_port {
 	struct list_head list;
 	struct scsi_qla_host *vha;
-	struct list_head tmf_pending;
 
 	unsigned int conf_compl_supported:1;
 	unsigned int deleted:2;
@@ -2544,9 +2544,6 @@ typedef struct fc_port {
 	unsigned int do_prli_nvme:1;
 
 	uint8_t nvme_flag;
-	uint8_t active_tmf;
-#define MAX_ACTIVE_TMF 8
-
 	uint8_t node_name[WWN_SIZE];
 	uint8_t port_name[WWN_SIZE];
 	port_id_t d_id;
@@ -3729,6 +3726,16 @@ struct qla_fw_resources {
 	u16 pad;
 };
 
+struct qla_fw_res {
+	u16      iocb_total;
+	u16      iocb_limit;
+	atomic_t iocb_used;
+
+	u16      exch_total;
+	u16      exch_limit;
+	atomic_t exch_used;
+};
+
 #define QLA_IOCB_PCT_LIMIT 95
 
 /*Queue pair data structure */
@@ -4356,7 +4363,6 @@ struct qla_hw_data {
 	uint8_t		aen_mbx_count;
 	atomic_t	num_pend_mbx_stage1;
 	atomic_t	num_pend_mbx_stage2;
-	atomic_t	num_pend_mbx_stage3;
 	uint16_t	frame_payload_size;
 
 	uint32_t	login_retry_count;
@@ -4626,6 +4632,8 @@ struct qla_hw_data {
 		uint32_t	flt_region_aux_img_status_sec;
 	};
 	uint8_t         active_image;
+	uint8_t active_tmf;
+#define MAX_ACTIVE_TMF 8
 
 	/* Needed for BEACON */
 	uint16_t        beacon_blink_led;
@@ -4640,6 +4648,8 @@ struct qla_hw_data {
 
 	struct qla_msix_entry *msix_entries;
 
+	struct list_head tmf_pending;
+	struct list_head tmf_active;
 	struct list_head        vp_list;        /* list of VP */
 	unsigned long   vp_idx_map[(MAX_MULTI_ID_FABRIC / 8) /
 			sizeof(unsigned long)];
@@ -4768,6 +4778,7 @@ struct qla_hw_data {
 	spinlock_t sadb_lock;	/* protects list */
 	struct els_reject elsrej;
 	u8 edif_post_stop_cnt_down;
+	struct qla_fw_res fwres ____cacheline_aligned;
 };
 
 #define RX_ELS_SIZE (roundup(sizeof(struct enode) + ELS_MAX_PAYLOAD, SMP_CACHE_BYTES))
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 8f6f56c9584c..aa9d69e5274d 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -276,6 +276,16 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 
 		seq_printf(s, "estimate exchange used[%d] high water limit [%d] n",
 			   exch_used, ha->base_qpair->fwres.exch_limit);
+
+		if (ql2xenforce_iocb_limit == 2) {
+			iocbs_used = atomic_read(&ha->fwres.iocb_used);
+			exch_used  = atomic_read(&ha->fwres.exch_used);
+			seq_printf(s, "        estimate iocb2 used [%d] high water limit [%d]\n",
+					iocbs_used, ha->fwres.iocb_limit);
+
+			seq_printf(s, "        estimate exchange2 used[%d] high water limit [%d] \n",
+					exch_used, ha->fwres.exch_limit);
+		}
 	}
 
 	return 0;
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 9e467262c0f1..3861e41a8d2c 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -143,6 +143,7 @@ void qla_edif_sess_down(struct scsi_qla_host *vha, struct fc_port *sess);
 void qla_edif_clear_appdata(struct scsi_qla_host *vha,
 			    struct fc_port *fcport);
 const char *sc_to_str(uint16_t cmd);
+void qla_adjust_iocb_limit(scsi_qla_host_t *vha);
 
 /*
  * Global Data in qla_os.c source file.
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index a97872b6350c..1a2ceef92bf0 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -503,6 +503,7 @@ static
 void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	struct fc_port *fcport = ea->fcport;
+	unsigned long flags;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d2,
 	    "%s %8phC DS %d LS %d rc %d login %d|%d rscn %d|%d lid %d\n",
@@ -517,9 +518,15 @@ void qla24xx_handle_adisc_event(scsi_qla_host_t *vha, struct event_arg *ea)
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
@@ -1129,7 +1136,7 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 	u16 *mb;
 
 	if (!vha->flags.online || (fcport->flags & FCF_ASYNC_SENT))
-		return rval;
+		goto done;
 
 	ql_dbg(ql_dbg_disc, vha, 0x20d9,
 	    "Async-gnlist WWPN %8phC \n", fcport->port_name);
@@ -1183,8 +1190,9 @@ int qla24xx_async_gnl(struct scsi_qla_host *vha, fc_port_t *fcport)
 done_free_sp:
 	/* ref: INIT */
 	kref_put(&sp->cmd_kref, qla2x00_sp_release);
+	fcport->flags &= ~(FCF_ASYNC_SENT);
 done:
-	fcport->flags &= ~(FCF_ASYNC_ACTIVE | FCF_ASYNC_SENT);
+	fcport->flags &= ~(FCF_ASYNC_ACTIVE);
 	return rval;
 }
 
@@ -1441,7 +1449,6 @@ void __qla24xx_handle_gpdb_event(scsi_qla_host_t *vha, struct event_arg *ea)
 
 	spin_lock_irqsave(&vha->hw->tgt.sess_lock, flags);
 	ea->fcport->login_gen++;
-	ea->fcport->deleted = 0;
 	ea->fcport->logout_on_delete = 1;
 
 	if (!ea->fcport->login_succ && !IS_SW_RESV_ADDR(ea->fcport->d_id)) {
@@ -1998,12 +2005,11 @@ qla2x00_tmf_iocb_timeout(void *data)
 	int rc, h;
 	unsigned long flags;
 
-	if (sp->type == SRB_MARKER) {
-		complete(&tmf->u.tmf.comp);
-		return;
-	}
+	if (sp->type == SRB_MARKER)
+		rc = QLA_FUNCTION_FAILED;
+	else
+		rc = qla24xx_async_abort_cmd(sp, false);
 
-	rc = qla24xx_async_abort_cmd(sp, false);
 	if (rc) {
 		spin_lock_irqsave(sp->qpair->qp_lock_ptr, flags);
 		for (h = 1; h < sp->qpair->req->num_outstanding_cmds; h++) {
@@ -2034,10 +2040,14 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 	complete(&tmf->u.tmf.comp);
 }
 
-#define  START_SP_W_RETRIES(_sp, _rval) \
+#define  START_SP_W_RETRIES(_sp, _rval, _chip_gen, _login_gen) \
 {\
 	int cnt = 5; \
 	do { \
+		if (_chip_gen != sp->vha->hw->chip_reset || _login_gen != sp->fcport->login_gen) {\
+			_rval = EINVAL; \
+			break; \
+		} \
 		_rval = qla2x00_start_sp(_sp); \
 		if (_rval == EAGAIN) \
 			msleep(1); \
@@ -2060,6 +2070,7 @@ qla26xx_marker(struct tmf_arg *arg)
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
 	fc_port_t *fcport = arg->fcport;
+	u32 chip_gen, login_gen;
 
 	if (TMF_NOT_READY(arg->fcport)) {
 		ql_dbg(ql_dbg_taskm, vha, 0x8039,
@@ -2069,6 +2080,9 @@ qla26xx_marker(struct tmf_arg *arg)
 		return QLA_SUSPENDED;
 	}
 
+	chip_gen = vha->hw->chip_reset;
+	login_gen = fcport->login_gen;
+
 	/* ref: INIT */
 	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
@@ -2086,7 +2100,7 @@ qla26xx_marker(struct tmf_arg *arg)
 	tm_iocb->u.tmf.loop_id = fcport->loop_id;
 	tm_iocb->u.tmf.vp_index = vha->vp_idx;
 
-	START_SP_W_RETRIES(sp, rval);
+	START_SP_W_RETRIES(sp, rval, chip_gen, login_gen);
 
 	ql_dbg(ql_dbg_taskm, vha, 0x8006,
 	    "Async-marker hdl=%x loop-id=%x portid=%06x modifier=%x lun=%lld qp=%d rval %d.\n",
@@ -2125,6 +2139,17 @@ static void qla2x00_tmf_sp_done(srb_t *sp, int res)
 	complete(&tmf->u.tmf.comp);
 }
 
+static int qla_tmf_wait(struct tmf_arg *arg)
+{
+	/* there are only 2 types of error handling that reaches here, lun or target reset */
+	if (arg->flags & (TCF_LUN_RESET | TCF_ABORT_TASK_SET | TCF_CLEAR_TASK_SET))
+		return qla2x00_eh_wait_for_pending_commands(arg->vha,
+		    arg->fcport->d_id.b24, arg->lun, WAIT_LUN);
+	else
+		return qla2x00_eh_wait_for_pending_commands(arg->vha,
+		    arg->fcport->d_id.b24, arg->lun, WAIT_TARGET);
+}
+
 static int
 __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 {
@@ -2132,8 +2157,9 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 	struct srb_iocb *tm_iocb;
 	srb_t *sp;
 	int rval = QLA_FUNCTION_FAILED;
-
 	fc_port_t *fcport = arg->fcport;
+	u32 chip_gen, login_gen;
+	u64 jif;
 
 	if (TMF_NOT_READY(arg->fcport)) {
 		ql_dbg(ql_dbg_taskm, vha, 0x8032,
@@ -2143,6 +2169,9 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 		return QLA_SUSPENDED;
 	}
 
+	chip_gen = vha->hw->chip_reset;
+	login_gen = fcport->login_gen;
+
 	/* ref: INIT */
 	sp = qla2xxx_get_qpair_sp(vha, arg->qpair, fcport, GFP_KERNEL);
 	if (!sp)
@@ -2160,7 +2189,7 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 	tm_iocb->u.tmf.flags = arg->flags;
 	tm_iocb->u.tmf.lun = arg->lun;
 
-	START_SP_W_RETRIES(sp, rval);
+	START_SP_W_RETRIES(sp, rval, chip_gen, login_gen);
 
 	ql_dbg(ql_dbg_taskm, vha, 0x802f,
 	    "Async-tmf hdl=%x loop-id=%x portid=%06x ctrl=%x lun=%lld qp=%d rval=%x.\n",
@@ -2178,8 +2207,26 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 		    "TM IOCB failed (%x).\n", rval);
 	}
 
-	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw))
-		rval = qla26xx_marker(arg);
+	if (!test_bit(UNLOADING, &vha->dpc_flags) && !IS_QLAFX00(vha->hw)) {
+		jif = jiffies;
+		if (qla_tmf_wait(arg)) {
+			ql_log(ql_log_info, vha, 0x803e,
+			       "Waited %u ms Nexus=%ld:%06x:%llu.\n",
+			       jiffies_to_msecs(jiffies - jif), vha->host_no,
+			       fcport->d_id.b24, arg->lun);
+		}
+
+		if (chip_gen == vha->hw->chip_reset && login_gen == fcport->login_gen) {
+			rval = qla26xx_marker(arg);
+		} else {
+			ql_log(ql_log_info, vha, 0x803e,
+			       "Skip Marker due to disruption. Nexus=%ld:%06x:%llu.\n",
+			       vha->host_no, fcport->d_id.b24, arg->lun);
+			rval = QLA_FUNCTION_FAILED;
+		}
+	}
+	if (tm_iocb->u.tmf.data)
+		rval = tm_iocb->u.tmf.data;
 
 done_free_sp:
 	/* ref: INIT */
@@ -2188,30 +2235,42 @@ __qla2x00_async_tm_cmd(struct tmf_arg *arg)
 	return rval;
 }
 
-static void qla_put_tmf(fc_port_t *fcport)
+static void qla_put_tmf(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	fcport->active_tmf--;
+	ha->active_tmf--;
+	list_del(&arg->tmf_elem);
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 }
 
 static
-int qla_get_tmf(fc_port_t *fcport)
+int qla_get_tmf(struct tmf_arg *arg)
 {
-	struct scsi_qla_host *vha = fcport->vha;
+	struct scsi_qla_host *vha = arg->vha;
 	struct qla_hw_data *ha = vha->hw;
 	unsigned long flags;
+	fc_port_t *fcport = arg->fcport;
 	int rc = 0;
-	LIST_HEAD(tmf_elem);
+	struct tmf_arg *t;
 
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
-	list_add_tail(&tmf_elem, &fcport->tmf_pending);
+	list_for_each_entry(t, &ha->tmf_active, tmf_elem) {
+		if (t->fcport == arg->fcport && t->lun == arg->lun) {
+			/* reject duplicate TMF */
+			ql_log(ql_log_warn, vha, 0x802c,
+			       "found duplicate TMF.  Nexus=%ld:%06x:%llu.\n",
+			       vha->host_no, fcport->d_id.b24, arg->lun);
+			spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
+			return -EINVAL;
+		}
+	}
 
-	while (fcport->active_tmf >= MAX_ACTIVE_TMF) {
+	list_add_tail(&arg->tmf_elem, &ha->tmf_pending);
+	while (ha->active_tmf >= MAX_ACTIVE_TMF) {
 		spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
 		msleep(1);
@@ -2223,15 +2282,17 @@ int qla_get_tmf(fc_port_t *fcport)
 			rc = EIO;
 			break;
 		}
-		if (fcport->active_tmf < MAX_ACTIVE_TMF &&
-		    list_is_first(&tmf_elem, &fcport->tmf_pending))
+		if (ha->active_tmf < MAX_ACTIVE_TMF &&
+		    list_is_first(&arg->tmf_elem, &ha->tmf_pending))
 			break;
 	}
 
-	list_del(&tmf_elem);
+	list_del(&arg->tmf_elem);
 
-	if (!rc)
-		fcport->active_tmf++;
+	if (!rc) {
+		ha->active_tmf++;
+		list_add_tail(&arg->tmf_elem, &ha->tmf_active);
+	}
 
 	spin_unlock_irqrestore(&ha->tgt.sess_lock, flags);
 
@@ -2243,9 +2304,8 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 		     uint32_t tag)
 {
 	struct scsi_qla_host *vha = fcport->vha;
-	struct qla_qpair *qpair;
 	struct tmf_arg a;
-	int i, rval = QLA_SUCCESS;
+	int rval = QLA_SUCCESS;
 
 	if (TMF_NOT_READY(fcport))
 		return QLA_SUSPENDED;
@@ -2253,47 +2313,22 @@ qla2x00_async_tm_cmd(fc_port_t *fcport, uint32_t flags, uint64_t lun,
 	a.vha = fcport->vha;
 	a.fcport = fcport;
 	a.lun = lun;
+	a.flags = flags;
+	INIT_LIST_HEAD(&a.tmf_elem);
+
 	if (flags & (TCF_LUN_RESET|TCF_ABORT_TASK_SET|TCF_CLEAR_TASK_SET|TCF_CLEAR_ACA)) {
 		a.modifier = MK_SYNC_ID_LUN;
-
-		if (qla_get_tmf(fcport))
-			return QLA_FUNCTION_FAILED;
 	} else {
 		a.modifier = MK_SYNC_ID;
 	}
 
-	if (vha->hw->mqenable) {
-		for (i = 0; i < vha->hw->num_qpairs; i++) {
-			qpair = vha->hw->queue_pair_map[i];
-			if (!qpair)
-				continue;
-
-			if (TMF_NOT_READY(fcport)) {
-				ql_log(ql_log_warn, vha, 0x8026,
-				    "Unable to send TM due to disruption.\n");
-				rval = QLA_SUSPENDED;
-				break;
-			}
-
-			a.qpair = qpair;
-			a.flags = flags|TCF_NOTMCMD_TO_TARGET;
-			rval = __qla2x00_async_tm_cmd(&a);
-			if (rval)
-				break;
-		}
-	}
-
-	if (rval)
-		goto bailout;
+	if (qla_get_tmf(&a))
+		return QLA_FUNCTION_FAILED;
 
 	a.qpair = vha->hw->base_qpair;
-	a.flags = flags;
 	rval = __qla2x00_async_tm_cmd(&a);
 
-bailout:
-	if (a.modifier == MK_SYNC_ID_LUN)
-		qla_put_tmf(fcport);
-
+	qla_put_tmf(&a);
 	return rval;
 }
 
@@ -4149,39 +4184,61 @@ qla24xx_detect_sfp(scsi_qla_host_t *vha)
 	return ha->flags.lr_detected;
 }
 
-void qla_init_iocb_limit(scsi_qla_host_t *vha)
+static void __qla_adjust_iocb_limit(struct qla_qpair *qpair)
 {
-	u16 i, num_qps;
-	u32 limit;
-	struct qla_hw_data *ha = vha->hw;
+	u8 num_qps;
+	u16 limit;
+	struct qla_hw_data *ha = qpair->vha->hw;
 
 	num_qps = ha->num_qpairs + 1;
 	limit = (ha->orig_fw_iocb_count * QLA_IOCB_PCT_LIMIT) / 100;
 
-	ha->base_qpair->fwres.iocbs_total = ha->orig_fw_iocb_count;
-	ha->base_qpair->fwres.iocbs_limit = limit;
-	ha->base_qpair->fwres.iocbs_qp_limit = limit / num_qps;
-	ha->base_qpair->fwres.iocbs_used = 0;
+	qpair->fwres.iocbs_total = ha->orig_fw_iocb_count;
+	qpair->fwres.iocbs_limit = limit;
+	qpair->fwres.iocbs_qp_limit = limit / num_qps;
+
+	qpair->fwres.exch_total = ha->orig_fw_xcb_count;
+	qpair->fwres.exch_limit = (ha->orig_fw_xcb_count *
+				   QLA_IOCB_PCT_LIMIT) / 100;
+}
+
+void qla_init_iocb_limit(scsi_qla_host_t *vha)
+{
+	u8 i;
+	struct qla_hw_data *ha = vha->hw;
 
-	ha->base_qpair->fwres.exch_total = ha->orig_fw_xcb_count;
-	ha->base_qpair->fwres.exch_limit = (ha->orig_fw_xcb_count *
-					    QLA_IOCB_PCT_LIMIT) / 100;
+	__qla_adjust_iocb_limit(ha->base_qpair);
+	ha->base_qpair->fwres.iocbs_used = 0;
 	ha->base_qpair->fwres.exch_used  = 0;
 
 	for (i = 0; i < ha->max_qpairs; i++) {
 		if (ha->queue_pair_map[i])  {
-			ha->queue_pair_map[i]->fwres.iocbs_total =
-				ha->orig_fw_iocb_count;
-			ha->queue_pair_map[i]->fwres.iocbs_limit = limit;
-			ha->queue_pair_map[i]->fwres.iocbs_qp_limit =
-				limit / num_qps;
+			__qla_adjust_iocb_limit(ha->queue_pair_map[i]);
 			ha->queue_pair_map[i]->fwres.iocbs_used = 0;
-			ha->queue_pair_map[i]->fwres.exch_total = ha->orig_fw_xcb_count;
-			ha->queue_pair_map[i]->fwres.exch_limit =
-				(ha->orig_fw_xcb_count * QLA_IOCB_PCT_LIMIT) / 100;
 			ha->queue_pair_map[i]->fwres.exch_used = 0;
 		}
 	}
+
+	ha->fwres.iocb_total = ha->orig_fw_iocb_count;
+	ha->fwres.iocb_limit = (ha->orig_fw_iocb_count * QLA_IOCB_PCT_LIMIT) / 100;
+	ha->fwres.exch_total = ha->orig_fw_xcb_count;
+	ha->fwres.exch_limit = (ha->orig_fw_xcb_count * QLA_IOCB_PCT_LIMIT) / 100;
+
+	atomic_set(&ha->fwres.iocb_used, 0);
+	atomic_set(&ha->fwres.exch_used, 0);
+}
+
+void qla_adjust_iocb_limit(scsi_qla_host_t *vha)
+{
+	u8 i;
+	struct qla_hw_data *ha = vha->hw;
+
+	__qla_adjust_iocb_limit(ha->base_qpair);
+
+	for (i = 0; i < ha->max_qpairs; i++) {
+		if (ha->queue_pair_map[i])
+			__qla_adjust_iocb_limit(ha->queue_pair_map[i]);
+	}
 }
 
 /**
@@ -4779,15 +4836,16 @@ qla2x00_init_rings(scsi_qla_host_t *vha)
 	if (ha->flags.edif_enabled)
 		mid_init_cb->init_cb.frame_payload_size = cpu_to_le16(ELS_MAX_PAYLOAD);
 
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
 
@@ -5529,7 +5587,6 @@ qla2x00_alloc_fcport(scsi_qla_host_t *vha, gfp_t flags)
 	INIT_WORK(&fcport->reg_work, qla_register_fcport_fn);
 	INIT_LIST_HEAD(&fcport->gnl_entry);
 	INIT_LIST_HEAD(&fcport->list);
-	INIT_LIST_HEAD(&fcport->tmf_pending);
 
 	INIT_LIST_HEAD(&fcport->sess_cmd_list);
 	spin_lock_init(&fcport->sess_cmd_lock);
@@ -5575,7 +5632,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
@@ -6120,6 +6177,8 @@ qla2x00_reg_remote_port(scsi_qla_host_t *vha, fc_port_t *fcport)
 void
 qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 {
+	unsigned long flags;
+
 	if (IS_SW_RESV_ADDR(fcport->d_id))
 		return;
 
@@ -6129,7 +6188,11 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
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
@@ -7419,14 +7482,15 @@ qla2x00_abort_isp_cleanup(scsi_qla_host_t *vha)
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
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index a034699e58ae..a7b5d1114682 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -386,6 +386,7 @@ enum {
 	RESOURCE_IOCB = BIT_0,
 	RESOURCE_EXCH = BIT_1,  /* exchange */
 	RESOURCE_FORCE = BIT_2,
+	RESOURCE_HA = BIT_3,
 };
 
 static inline int
@@ -393,7 +394,7 @@ qla_get_fw_resources(struct qla_qpair *qp, struct iocb_resource *iores)
 {
 	u16 iocbs_used, i;
 	u16 exch_used;
-	struct qla_hw_data *ha = qp->vha->hw;
+	struct qla_hw_data *ha = qp->hw;
 
 	if (!ql2xenforce_iocb_limit) {
 		iores->res_type = RESOURCE_NONE;
@@ -428,15 +429,69 @@ qla_get_fw_resources(struct qla_qpair *qp, struct iocb_resource *iores)
 			return -ENOSPC;
 		}
 	}
+
+	if (ql2xenforce_iocb_limit == 2) {
+		if ((iores->iocb_cnt + atomic_read(&ha->fwres.iocb_used)) >=
+		    ha->fwres.iocb_limit) {
+			iores->res_type = RESOURCE_NONE;
+			return -ENOSPC;
+		}
+
+		if (iores->res_type & RESOURCE_EXCH) {
+			if ((iores->exch_cnt + atomic_read(&ha->fwres.exch_used)) >=
+			    ha->fwres.exch_limit) {
+				iores->res_type = RESOURCE_NONE;
+				return -ENOSPC;
+			}
+		}
+	}
+
 force:
 	qp->fwres.iocbs_used += iores->iocb_cnt;
 	qp->fwres.exch_used += iores->exch_cnt;
+	if (ql2xenforce_iocb_limit == 2) {
+		atomic_add(iores->iocb_cnt, &ha->fwres.iocb_used);
+		atomic_add(iores->exch_cnt, &ha->fwres.exch_used);
+		iores->res_type |= RESOURCE_HA;
+	}
 	return 0;
 }
 
+/*
+ * decrement to zero.  This routine will not decrement below zero
+ * @v:  pointer of type atomic_t
+ * @amount: amount to decrement from v
+ */
+static void qla_atomic_dtz(atomic_t *v, int amount)
+{
+	int c, old, dec;
+
+	c = atomic_read(v);
+	for (;;) {
+		dec = c - amount;
+		if (unlikely(dec < 0))
+			dec = 0;
+
+		old = atomic_cmpxchg((v), c, dec);
+		if (likely(old == c))
+			break;
+		c = old;
+	}
+}
+
 static inline void
 qla_put_fw_resources(struct qla_qpair *qp, struct iocb_resource *iores)
 {
+	struct qla_hw_data *ha = qp->hw;
+
+	if (iores->res_type & RESOURCE_HA) {
+		if (iores->res_type & RESOURCE_IOCB)
+			qla_atomic_dtz(&ha->fwres.iocb_used, iores->iocb_cnt);
+
+		if (iores->res_type & RESOURCE_EXCH)
+			qla_atomic_dtz(&ha->fwres.exch_used, iores->exch_cnt);
+	}
+
 	if (iores->res_type & RESOURCE_IOCB) {
 		if (qp->fwres.iocbs_used >= iores->iocb_cnt) {
 			qp->fwres.iocbs_used -= iores->iocb_cnt;
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index c9a686f06d29..9e524d52dc86 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3887,6 +3887,7 @@ qla_marker_iocb(srb_t *sp, struct mrk_entry_24xx *mrk)
 {
 	mrk->entry_type = MARKER_TYPE;
 	mrk->modifier = sp->u.iocb_cmd.u.tmf.modifier;
+	mrk->handle = make_handle(sp->qpair->req->id, sp->handle);
 	if (sp->u.iocb_cmd.u.tmf.modifier != MK_SYNC_ALL) {
 		mrk->nport_handle = cpu_to_le16(sp->u.iocb_cmd.u.tmf.loop_id);
 		int_to_scsilun(sp->u.iocb_cmd.u.tmf.lun, (struct scsi_lun *)&mrk->lun);
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 08d43f43995e..80c2dcf567b0 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1121,8 +1121,12 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
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
@@ -2513,7 +2517,6 @@ qla24xx_tm_iocb_entry(scsi_qla_host_t *vha, struct req_que *req, void *tsk)
 	case CS_PORT_BUSY:
 	case CS_INCOMPLETE:
 	case CS_PORT_UNAVAILABLE:
-	case CS_TIMEOUT:
 	case CS_RESET:
 		if (atomic_read(&fcport->state) == FCS_ONLINE) {
 			ql_dbg(ql_dbg_disc, fcport->vha, 0x3021,
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 5bcb8da4360f..511f31611aed 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -273,7 +273,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 		spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
 		wait_time = jiffies;
-		atomic_inc(&ha->num_pend_mbx_stage3);
 		if (!wait_for_completion_timeout(&ha->mbx_intr_comp,
 		    mcp->tov * HZ)) {
 			ql_dbg(ql_dbg_mbx, vha, 0x117a,
@@ -290,7 +289,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 				spin_unlock_irqrestore(&ha->hardware_lock,
 				    flags);
 				atomic_dec(&ha->num_pend_mbx_stage2);
-				atomic_dec(&ha->num_pend_mbx_stage3);
 				rval = QLA_ABORTED;
 				goto premature_exit;
 			}
@@ -302,11 +300,9 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
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
@@ -2207,6 +2203,9 @@ qla2x00_get_firmware_state(scsi_qla_host_t *vha, uint16_t *states)
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1054,
 	    "Entered %s.\n", __func__);
 
+	if (!ha->flags.fw_started)
+		return QLA_FUNCTION_FAILED;
+
 	mcp->mb[0] = MBC_GET_FIRMWARE_STATE;
 	mcp->out_mb = MBX_0;
 	if (IS_FWI2_CAPABLE(vha->hw))
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 53a54e8a4d97..f535f478e37c 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -127,6 +127,7 @@ static int qla_nvme_alloc_queue(struct nvme_fc_local_port *lport,
 			       "Failed to allocate qpair\n");
 			return -EINVAL;
 		}
+		qla_adjust_iocb_limit(vha);
 	}
 	*handle = qpair;
 
@@ -652,7 +653,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 
 	rval = qla2x00_start_nvme_mq(sp);
 	if (rval != QLA_SUCCESS) {
-		ql_log(ql_log_warn, vha, 0x212d,
+		ql_dbg(ql_dbg_io + ql_dbg_verbose, vha, 0x212d,
 		    "qla2x00_start_nvme_mq failed = %d\n", rval);
 		sp->priv = NULL;
 		priv->sp = NULL;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 30325fd4c120..a40af9b832ab 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -40,10 +40,11 @@ module_param(ql2xfulldump_on_mpifail, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ql2xfulldump_on_mpifail,
 		 "Set this to take full dump on MPI hang.");
 
-int ql2xenforce_iocb_limit = 1;
+int ql2xenforce_iocb_limit = 2;
 module_param(ql2xenforce_iocb_limit, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ql2xenforce_iocb_limit,
-		 "Enforce IOCB throttling, to avoid FW congestion. (default: 1)");
+		 "Enforce IOCB throttling, to avoid FW congestion. (default: 2) "
+		 "1: track usage per queue, 2: track usage per adapter");
 
 /*
  * CT6 CTX allocation cache
@@ -1470,8 +1471,9 @@ qla2xxx_eh_device_reset(struct scsi_cmnd *cmd)
 		goto eh_reset_failed;
 	}
 	err = 3;
-	if (qla2x00_eh_wait_for_pending_commands(vha, sdev->id,
-	    sdev->lun, WAIT_LUN) != QLA_SUCCESS) {
+	if (qla2x00_eh_wait_for_pending_commands(vha, fcport->d_id.b24,
+						 cmd->device->lun,
+						 WAIT_LUN) != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x800d,
 		    "wait for pending cmds failed for cmd=%p.\n", cmd);
 		goto eh_reset_failed;
@@ -1537,8 +1539,8 @@ qla2xxx_eh_target_reset(struct scsi_cmnd *cmd)
 		goto eh_reset_failed;
 	}
 	err = 3;
-	if (qla2x00_eh_wait_for_pending_commands(vha, sdev->id,
-	    0, WAIT_TARGET) != QLA_SUCCESS) {
+	if (qla2x00_eh_wait_for_pending_commands(vha, fcport->d_id.b24, 0,
+						 WAIT_TARGET) != QLA_SUCCESS) {
 		ql_log(ql_log_warn, vha, 0x800d,
 		    "wait for pending cmds failed for cmd=%p.\n", cmd);
 		goto eh_reset_failed;
@@ -2970,9 +2972,10 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	ha->max_exchg = FW_MAX_EXCHANGES_CNT;
 	atomic_set(&ha->num_pend_mbx_stage1, 0);
 	atomic_set(&ha->num_pend_mbx_stage2, 0);
-	atomic_set(&ha->num_pend_mbx_stage3, 0);
 	atomic_set(&ha->zio_threshold, DEFAULT_ZIO_THRESHOLD);
 	ha->last_zio_threshold = DEFAULT_ZIO_THRESHOLD;
+	INIT_LIST_HEAD(&ha->tmf_pending);
+	INIT_LIST_HEAD(&ha->tmf_active);
 
 	/* Assign ISP specific operations. */
 	if (IS_QLA2100(ha)) {
@@ -3249,6 +3252,13 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -3482,8 +3492,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 			base_vha->flags.difdix_supported = 1;
 			ql_dbg(ql_dbg_init, base_vha, 0x00f1,
 			    "Registering for DIF/DIX type 1 and 3 protection.\n");
-			if (ql2xenabledif == 1)
-				prot = SHOST_DIX_TYPE0_PROTECTION;
 			if (ql2xprotmask)
 				scsi_host_set_prot(host, ql2xprotmask);
 			else
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 4b4ca2a9524d..2ce041fdec75 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1089,10 +1089,6 @@ void qlt_free_session_done(struct work_struct *work)
 			(struct imm_ntfy_from_isp *)sess->iocb, SRB_NACK_LOGO);
 	}
 
-	spin_lock_irqsave(&vha->work_lock, flags);
-	sess->flags &= ~FCF_ASYNC_SENT;
-	spin_unlock_irqrestore(&vha->work_lock, flags);
-
 	spin_lock_irqsave(&ha->tgt.sess_lock, flags);
 	if (sess->se_sess) {
 		sess->se_sess = NULL;
@@ -1102,7 +1098,6 @@ void qlt_free_session_done(struct work_struct *work)
 
 	qla2x00_set_fcport_disc_state(sess, DSC_DELETED);
 	sess->fw_login_state = DSC_LS_PORT_UNAVAIL;
-	sess->deleted = QLA_SESS_DELETED;
 
 	if (sess->login_succ && !IS_SW_RESV_ADDR(sess->d_id)) {
 		vha->fcport_count--;
@@ -1154,10 +1149,15 @@ void qlt_free_session_done(struct work_struct *work)
 
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
@@ -1206,12 +1206,12 @@ void qlt_unreg_sess(struct fc_port *sess)
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
index f1ea65c6e5f5..dc466a364fb1 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -968,6 +968,11 @@ static int qla4xxx_set_chap_entry(struct Scsi_Host *shost, void *data, int len)
 	memset(&chap_rec, 0, sizeof(chap_rec));
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*param_info)) {
+			rc = -EINVAL;
+			goto exit_set_chap;
+		}
+
 		param_info = nla_data(attr);
 
 		switch (param_info->param) {
@@ -2750,6 +2755,11 @@ qla4xxx_iface_set_param(struct Scsi_Host *shost, void *data, uint32_t len)
 	}
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*iface_param)) {
+			rval = -EINVAL;
+			goto exit_init_fw_cb;
+		}
+
 		iface_param = nla_data(attr);
 
 		if (iface_param->param_type == ISCSI_NET_PARAM) {
@@ -8105,6 +8115,11 @@ qla4xxx_sysfs_ddb_set_param(struct iscsi_bus_flash_session *fnode_sess,
 
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
index 4d23e5af20d3..e044b65ee0d0 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3034,14 +3034,15 @@ iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev
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
@@ -3049,6 +3050,10 @@ iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 	if (!conn || !session)
 		return -EINVAL;
 
+	/* data will be regarded as NULL-ended string, do length check */
+	if (strlen(data) > ev->u.set_param.len)
+		return -EINVAL;
+
 	switch (ev->u.set_param.param) {
 	case ISCSI_PARAM_SESS_RECOVERY_TMO:
 		sscanf(data, "%d", &value);
@@ -3138,7 +3143,7 @@ static int iscsi_if_ep_disconnect(struct iscsi_transport *transport,
 
 static int
 iscsi_if_transport_ep(struct iscsi_transport *transport,
-		      struct iscsi_uevent *ev, int msg_type)
+		      struct iscsi_uevent *ev, int msg_type, u32 rlen)
 {
 	struct iscsi_endpoint *ep;
 	int rc = 0;
@@ -3146,7 +3151,10 @@ iscsi_if_transport_ep(struct iscsi_transport *transport,
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
@@ -3170,12 +3178,15 @@ iscsi_if_transport_ep(struct iscsi_transport *transport,
 
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
 
@@ -3196,7 +3207,7 @@ iscsi_tgt_dscvr(struct iscsi_transport *transport,
 
 static int
 iscsi_set_host_param(struct iscsi_transport *transport,
-		     struct iscsi_uevent *ev)
+		     struct iscsi_uevent *ev, u32 rlen)
 {
 	char *data = (char*)ev + sizeof(*ev);
 	struct Scsi_Host *shost;
@@ -3205,7 +3216,8 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 	if (!transport->set_host_param)
 		return -ENOSYS;
 
-	if (ev->u.set_host_param.len > PAGE_SIZE)
+	if (ev->u.set_host_param.len > rlen ||
+	    ev->u.set_host_param.len > PAGE_SIZE)
 		return -EINVAL;
 
 	shost = scsi_host_lookup(ev->u.set_host_param.host_no);
@@ -3215,6 +3227,10 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 		return -ENODEV;
 	}
 
+	/* see similar check in iscsi_if_set_param() */
+	if (strlen(data) > ev->u.set_host_param.len)
+		return -EINVAL;
+
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
 	scsi_host_put(shost);
@@ -3222,12 +3238,15 @@ iscsi_set_host_param(struct iscsi_transport *transport,
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
 
@@ -3287,12 +3306,15 @@ iscsi_set_iface_params(struct iscsi_transport *transport,
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
 
@@ -3790,13 +3812,12 @@ iscsi_get_host_stats(struct iscsi_transport *transport, struct nlmsghdr *nlh)
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
@@ -3881,8 +3902,6 @@ static int iscsi_if_transport_conn(struct iscsi_transport *transport,
 
 		break;
 	case ISCSI_UEVENT_SEND_PDU:
-		pdu_len = nlh->nlmsg_len - sizeof(*nlh) - sizeof(*ev);
-
 		if ((ev->u.send_pdu.hdr_size > pdu_len) ||
 		    (ev->u.send_pdu.data_size > (pdu_len - ev->u.send_pdu.hdr_size))) {
 			err = -EINVAL;
@@ -3912,6 +3931,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	struct iscsi_internal *priv;
 	struct iscsi_cls_session *session;
 	struct iscsi_endpoint *ep = NULL;
+	u32 rlen;
 
 	if (!netlink_capable(skb, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3931,6 +3951,13 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 
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
@@ -3988,7 +4015,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			err = -EINVAL;
 		break;
 	case ISCSI_UEVENT_SET_PARAM:
-		err = iscsi_set_param(transport, ev);
+		err = iscsi_if_set_param(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_CREATE_CONN:
 	case ISCSI_UEVENT_DESTROY_CONN:
@@ -3996,7 +4023,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 	case ISCSI_UEVENT_START_CONN:
 	case ISCSI_UEVENT_BIND_CONN:
 	case ISCSI_UEVENT_SEND_PDU:
-		err = iscsi_if_transport_conn(transport, nlh);
+		err = iscsi_if_transport_conn(transport, nlh, rlen);
 		break;
 	case ISCSI_UEVENT_GET_STATS:
 		err = iscsi_if_get_stats(transport, nlh);
@@ -4005,23 +4032,22 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
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
@@ -4030,13 +4056,10 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
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
@@ -4051,8 +4074,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 		err = iscsi_logout_flashnode_sid(transport, ev);
 		break;
 	case ISCSI_UEVENT_SET_CHAP:
-		err = iscsi_set_chap(transport, ev,
-				     nlmsg_attrlen(nlh, sizeof(*ev)));
+		err = iscsi_set_chap(transport, ev, rlen);
 		break;
 	case ISCSI_UEVENT_GET_HOST_STATS:
 		err = iscsi_get_host_stats(transport, nlh);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 652cd81d7775..af210910dadf 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -684,9 +684,10 @@ static int sr_probe(struct device *dev)
 	disk->minors = 1;
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
-	disk->flags = GENHD_FL_CD | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
+	disk->flags = GENHD_FL_CD;
 	disk->events = DISK_EVENT_MEDIA_CHANGE | DISK_EVENT_EJECT_REQUEST;
-	disk->event_flags = DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
+	disk->event_flags = DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT |
+				DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE;
 
 	blk_queue_rq_timeout(sdev->request_queue, SR_TIMEOUT);
 
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 9f8ebbec7bc3..5caf7bd5877f 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1627,6 +1627,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
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
index 328cc8237191..9f9a5ad3eb22 100644
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
index 2888d8a8dc6d..6915451cc93e 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -455,7 +455,11 @@ static int tegra_sflash_probe(struct platform_device *pdev)
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
diff --git a/drivers/staging/media/av7110/sp8870.c b/drivers/staging/media/av7110/sp8870.c
index 9767159aeb9b..abf5c72607b6 100644
--- a/drivers/staging/media/av7110/sp8870.c
+++ b/drivers/staging/media/av7110/sp8870.c
@@ -606,4 +606,4 @@ MODULE_DESCRIPTION("Spase SP8870 DVB-T Demodulator driver");
 MODULE_AUTHOR("Juergen Peitz");
 MODULE_LICENSE("GPL");
 
-EXPORT_SYMBOL(sp8870_attach);
+EXPORT_SYMBOL_GPL(sp8870_attach);
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index bc4683a75e61..29b68a13674e 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -111,7 +111,7 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 			.max_width = 4096,
 			.step_width = 16,
 			.min_height = 48,
-			.max_height = 2304,
+			.max_height = 2560,
 			.step_height = 16,
 		},
 		.ctrls = &rkvdec_h264_ctrls,
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 25f34f86a085..52d5c72227e7 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -999,7 +999,11 @@ static int tegra_uart_hw_init(struct tegra_uart_port *tup)
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
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 6c5934dbe9b3..8cbabc39f818 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -983,6 +983,7 @@ static int register_root_hub(struct usb_hcd *hcd)
 {
 	struct device *parent_dev = hcd->self.controller;
 	struct usb_device *usb_dev = hcd->self.root_hub;
+	struct usb_device_descriptor *descr;
 	const int devnum = 1;
 	int retval;
 
@@ -994,13 +995,16 @@ static int register_root_hub(struct usb_hcd *hcd)
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
index 2295d69b4cd2..4eb453d7e6f8 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2649,12 +2649,17 @@ int usb_authorize_device(struct usb_device *usb_dev)
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
@@ -4666,6 +4671,67 @@ static int hub_enable_device(struct usb_device *udev)
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
@@ -4675,10 +4741,17 @@ static int hub_enable_device(struct usb_device *udev)
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
@@ -4690,6 +4763,13 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
@@ -4722,32 +4802,34 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
@@ -4770,22 +4852,24 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
@@ -4804,9 +4888,6 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 
 	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
 		if (do_new_scheme) {
-			struct usb_device_descriptor *buf;
-			int r = 0;
-
 			retval = hub_enable_device(udev);
 			if (retval < 0) {
 				dev_err(&udev->dev,
@@ -4815,52 +4896,14 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
@@ -4871,14 +4914,13 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
@@ -4924,18 +4966,22 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
@@ -4954,48 +5000,61 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
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
 
@@ -5019,6 +5078,7 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 		hub_port_disable(hub, port1, 0);
 		update_devnum(udev, devnum);	/* for disconnect processing */
 	}
+	kfree(buf);
 	return retval;
 }
 
@@ -5099,7 +5159,7 @@ hub_power_remaining(struct usb_hub *hub)
 
 
 static int descriptors_changed(struct usb_device *udev,
-		struct usb_device_descriptor *old_device_descriptor,
+		struct usb_device_descriptor *new_device_descriptor,
 		struct usb_host_bos *old_bos)
 {
 	int		changed = 0;
@@ -5110,8 +5170,8 @@ static int descriptors_changed(struct usb_device *udev,
 	int		length;
 	char		*buf;
 
-	if (memcmp(&udev->descriptor, old_device_descriptor,
-			sizeof(*old_device_descriptor)) != 0)
+	if (memcmp(&udev->descriptor, new_device_descriptor,
+			sizeof(*new_device_descriptor)) != 0)
 		return 1;
 
 	if ((old_bos && !udev->bos) || (!old_bos && udev->bos))
@@ -5284,7 +5344,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		}
 
 		/* reset (non-USB 3.0 devices) and get descriptor */
-		status = hub_port_init(hub, udev, port1, i);
+		status = hub_port_init(hub, udev, port1, i, NULL);
 		if (status < 0)
 			goto loop;
 
@@ -5431,9 +5491,8 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
 {
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_device *udev = port_dev->child;
-	struct usb_device_descriptor descriptor;
+	struct usb_device_descriptor *descr;
 	int status = -ENODEV;
-	int retval;
 
 	dev_dbg(&port_dev->dev, "status %04x, change %04x, %s\n", portstatus,
 			portchange, portspeed(hub, portstatus));
@@ -5460,23 +5519,20 @@ static void hub_port_connect_change(struct usb_hub *hub, int port1,
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
@@ -5904,7 +5960,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	struct usb_device		*parent_hdev = udev->parent;
 	struct usb_hub			*parent_hub;
 	struct usb_hcd			*hcd = bus_to_hcd(udev->bus);
-	struct usb_device_descriptor	descriptor = udev->descriptor;
+	struct usb_device_descriptor	descriptor;
 	struct usb_host_bos		*bos;
 	int				i, j, ret = 0;
 	int				port1 = udev->portnum;
@@ -5946,7 +6002,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
 		usb_ep0_reinit(udev);
-		ret = hub_port_init(parent_hub, udev, port1, i);
+		ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
 	}
@@ -5958,7 +6014,6 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	/* Device might have changed firmware (DFU or similar) */
 	if (descriptors_changed(udev, &descriptor, bos)) {
 		dev_info(&udev->dev, "device firmware changed\n");
-		udev->descriptor = descriptor;	/* for disconnect() calls */
 		goto re_enumerate;
 	}
 
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 4d59d927ae3e..1673e5d08926 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1039,40 +1039,35 @@ char *usb_cache_string(struct usb_device *udev, int index)
 }
 
 /*
- * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
- * @dev: the device whose device descriptor is being updated
- * @size: how much of the descriptor to read
+ * usb_get_device_descriptor - read the device descriptor
+ * @udev: the device whose device descriptor should be read
  *
  * Context: task context, might sleep.
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
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 6ad669dde41c..5bd76c6d38e7 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -919,7 +919,7 @@ static void invalidate_sub(struct fsg_lun *curlun)
 {
 	struct file	*filp = curlun->filp;
 	struct inode	*inode = file_inode(filp);
-	unsigned long	rc;
+	unsigned long __maybe_unused	rc;
 
 	rc = invalidate_mapping_pages(inode->i_mapping, 0, -1);
 	VLDBG(curlun, "invalidate_mapping_pages -> %ld\n", rc);
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 8a262c5a0408..7a7eb8af6044 100644
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
diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 0aefb9e14f22..407d2a84633a 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -154,12 +154,20 @@ EXPORT_SYMBOL_GPL(typec_altmode_exit);
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
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4f38b2d609f1..7833518c6038 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1863,7 +1863,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
 			}
 			break;
 		case ADEV_ATTENTION:
-			typec_altmode_attention(adev, p[1]);
+			if (typec_altmode_attention(adev, p[1]))
+				tcpm_log(port, "typec_altmode_attention no port partner altmode");
 			break;
 		}
 	}
@@ -3862,6 +3863,29 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
 	}
 }
 
+static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
+{
+	switch (port->negotiated_rev) {
+	case PD_REV30:
+		break;
+	/*
+	 * 6.4.4.2.3 Structured VDM Version
+	 * 2.0 states "At this time, there is only one version (1.0) defined.
+	 * This field Shall be set to zero to indicate Version 1.0."
+	 * 3.0 states "This field Shall be set to 01b to indicate Version 2.0."
+	 * To ensure that we follow the Power Delivery revision we are currently
+	 * operating on, downgrade the SVDM version to the highest one supported
+	 * by the Power Delivery revision.
+	 */
+	case PD_REV20:
+		typec_partner_set_svdm_version(port->partner, SVDM_VER_1_0);
+		break;
+	default:
+		typec_partner_set_svdm_version(port->partner, SVDM_VER_1_0);
+		break;
+	}
+}
+
 static void run_state_machine(struct tcpm_port *port)
 {
 	int ret;
@@ -4086,10 +4110,12 @@ static void run_state_machine(struct tcpm_port *port)
 		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
 		 * port->explicit_contract to decide whether to send the command.
 		 */
-		if (port->explicit_contract)
+		if (port->explicit_contract) {
+			tcpm_set_initial_svdm_version(port);
 			mod_send_discover_delayed_work(port, 0);
-		else
+		} else {
 			port->send_discover = false;
+		}
 
 		/*
 		 * 6.3.5
@@ -4372,10 +4398,12 @@ static void run_state_machine(struct tcpm_port *port)
 		 * For now, this driver only supports SOP for DISCOVER_IDENTITY, thus using
 		 * port->explicit_contract.
 		 */
-		if (port->explicit_contract)
+		if (port->explicit_contract) {
+			tcpm_set_initial_svdm_version(port);
 			mod_send_discover_delayed_work(port, 0);
-		else
+		} else {
 			port->send_discover = false;
+		}
 
 		power_supply_changed(port->psy);
 		break;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5623fc28b1ea..66bbb125d761 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2866,7 +2866,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
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
index 305f1587bd89..8b2bc4adc50f 100644
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
index 800df63c5869..067b68168f93 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1271,7 +1271,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
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
index 4e35c6fb7be7..6e0fdfd98f23 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2598,11 +2598,10 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
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
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8a01964a216..95af29634e55 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3226,6 +3226,13 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, 1);
+			/*
+			 * Actually free the qgroup rsv which was released when
+			 * the ordered extent was created.
+			 */
+			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+						  ordered_extent->qgroup_rsv,
+						  BTRFS_QGROUP_RSV_DATA);
 		}
 	}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index daaed37bba9e..99cdd1d6a4bf 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -311,10 +311,11 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
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
 
diff --git a/fs/eventfd.c b/fs/eventfd.c
index 249ca6c0b784..4a60ea932e3d 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -189,7 +189,7 @@ void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 {
 	lockdep_assert_held(&ctx->wqh.lock);
 
-	*cnt = (ctx->flags & EFD_SEMAPHORE) ? 1 : ctx->count;
+	*cnt = ((ctx->flags & EFD_SEMAPHORE) && ctx->count) ? 1 : ctx->count;
 	ctx->count -= *cnt;
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_do_read);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 7649376fd93d..c23ac149601e 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -909,11 +909,11 @@ unsigned long ext4_bg_num_gdb(struct super_block *sb, ext4_group_t group)
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
@@ -931,8 +931,15 @@ static unsigned ext4_num_base_meta_clusters(struct super_block *sb,
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
index 5504f72bbbbe..6fe3c941b565 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -215,7 +215,6 @@ int ext4_setup_system_zone(struct super_block *sb)
 	struct ext4_system_blocks *system_blks;
 	struct ext4_group_desc *gdp;
 	ext4_group_t i;
-	int flex_size = ext4_flex_bg_size(sbi);
 	int ret;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -223,12 +222,13 @@ int ext4_setup_system_zone(struct super_block *sb)
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
index 5e8d3d53777e..976cb4b3ff66 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3120,6 +3120,8 @@ extern const char *ext4_decode_error(struct super_block *sb, int errno,
 extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     ext4_group_t block_group,
 					     unsigned int flags);
+extern unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
+					      ext4_group_t block_group);
 
 extern __printf(7, 8)
 void __ext4_error(struct super_block *, const char *, unsigned int, bool,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 47c28e3582fd..7e7153c673c0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1011,8 +1011,9 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
  * Return next linear group for allocation. If linear traversal should not be
  * performed, this function just returns the same group
  */
-static int
-next_linear_group(struct ext4_allocation_context *ac, int group, int ngroups)
+static ext4_group_t
+next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
+		  ext4_group_t ngroups)
 {
 	if (!should_optimize_scan(ac))
 		goto inc_and_return;
@@ -2445,7 +2446,7 @@ static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
 
 	BUG_ON(cr < 0 || cr >= 4);
 
-	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp) || !grp))
+	if (unlikely(!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		return false;
 
 	free = grp->bb_free;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2629e90f8dbb..d44fe5b1a725 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2799,6 +2799,7 @@ static int ext4_add_nondir(handle_t *handle,
 		return err;
 	}
 	drop_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	ext4_orphan_add(handle, inode);
 	unlock_new_inode(inode);
 	return err;
@@ -3455,6 +3456,7 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (handle)
 		ext4_journal_stop(handle);
 	clear_nlink(inode);
+	ext4_mark_inode_dirty(handle, inode);
 	unlock_new_inode(inode);
 	iput(inode);
 out_free_encrypted_link:
@@ -4028,6 +4030,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 			ext4_resetent(handle, &old,
 				      old.inode->i_ino, old_file_type);
 			drop_nlink(whiteout);
+			ext4_mark_inode_dirty(handle, whiteout);
 			ext4_orphan_add(handle, whiteout);
 		}
 		unlock_new_inode(whiteout);
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
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index ee212c9310ad..2b654c3b918a 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -207,13 +207,13 @@ static int gfs2_writepages(struct address_space *mapping,
 	int ret;
 
 	/*
-	 * Even if we didn't write any pages here, we might still be holding
+	 * Even if we didn't write enough pages here, we might still be holding
 	 * dirty pages in the ail. We forcibly flush the ail because we don't
 	 * want balance_dirty_pages() to loop indefinitely trying to write out
 	 * pages held in the ail that it can't find.
 	 */
 	ret = iomap_writepages(mapping, wbc, &wpc, &gfs2_writeback_ops);
-	if (ret == 0)
+	if (ret == 0 && wbc->nr_to_write > 0)
 		set_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 	return ret;
 }
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index f0ee3ff6f9a8..9a96842aeab3 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1277,9 +1277,6 @@ static inline int gfs2_ail_flush_reqd(struct gfs2_sbd *sdp)
 {
 	unsigned int used_blocks = sdp->sd_jdesc->jd_blocks - atomic_read(&sdp->sd_log_blks_free);
 
-	if (test_and_clear_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags))
-		return 1;
-
 	return used_blocks + atomic_read(&sdp->sd_log_blks_needed) >=
 		atomic_read(&sdp->sd_log_thresh2);
 }
@@ -1296,7 +1293,6 @@ int gfs2_logd(void *data)
 {
 	struct gfs2_sbd *sdp = data;
 	unsigned long t = 1;
-	DEFINE_WAIT(wait);
 
 	while (!kthread_should_stop()) {
 
@@ -1321,7 +1317,9 @@ int gfs2_logd(void *data)
 						  GFS2_LFC_LOGD_JFLUSH_REQD);
 		}
 
-		if (gfs2_ail_flush_reqd(sdp)) {
+		if (test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
+		    gfs2_ail_flush_reqd(sdp)) {
+			clear_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags);
 			gfs2_ail1_start(sdp);
 			gfs2_ail1_wait(sdp);
 			gfs2_ail1_empty(sdp, 0);
@@ -1333,17 +1331,12 @@ int gfs2_logd(void *data)
 
 		try_to_freeze();
 
-		do {
-			prepare_to_wait(&sdp->sd_logd_waitq, &wait,
-					TASK_INTERRUPTIBLE);
-			if (!gfs2_ail_flush_reqd(sdp) &&
-			    !gfs2_jrnl_flush_reqd(sdp) &&
-			    !kthread_should_stop())
-				t = schedule_timeout(t);
-		} while(t && !gfs2_ail_flush_reqd(sdp) &&
-			!gfs2_jrnl_flush_reqd(sdp) &&
-			!kthread_should_stop());
-		finish_wait(&sdp->sd_logd_waitq, &wait);
+		t = wait_event_interruptible_timeout(sdp->sd_logd_waitq,
+				test_bit(SDF_FORCE_AIL_FLUSH, &sdp->sd_flags) ||
+				gfs2_ail_flush_reqd(sdp) ||
+				gfs2_jrnl_flush_reqd(sdp) ||
+				kthread_should_stop(),
+				t);
 	}
 
 	return 0;
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index fc6989e7a8c5..95d5bb7d825a 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -349,6 +349,8 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
+enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+
 /*
  * journal_shrink_one_cp_list
  *
@@ -360,7 +362,8 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						bool destroy, bool *released)
+						enum shrink_type type,
+						bool *released)
 {
 	struct journal_head *last_jh;
 	struct journal_head *next_jh = jh;
@@ -376,12 +379,15 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (destroy) {
+		if (type == SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
 		} else {
 			ret = jbd2_journal_try_remove_checkpoint(jh);
-			if (ret < 0)
-				continue;
+			if (ret < 0) {
+				if (type == SHRINK_BUSY_SKIP)
+					continue;
+				break;
+			}
 		}
 
 		nr_freed++;
@@ -445,7 +451,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		tid = transaction->t_tid;
 
 		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   false, &released);
+						   SHRINK_BUSY_SKIP, &released);
 		nr_freed += freed;
 		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
@@ -485,19 +491,21 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
+	enum shrink_type type;
 	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
 		return;
 
+	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
 		transaction = next_transaction;
 		next_transaction = transaction->t_cpnext;
 		journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-					   destroy, &released);
+					   type, &released);
 		/*
 		 * This function only frees up some memory if possible so we
 		 * dont have an obligation to finish processing. Bail out if
@@ -631,6 +639,8 @@ int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
 {
 	struct buffer_head *bh = jh2bh(jh);
 
+	if (jh->b_transaction)
+		return -EBUSY;
 	if (!trylock_buffer(bh))
 		return -EBUSY;
 	if (buffer_dirty(bh)) {
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index bb4a342a193d..6420b6749d48 100644
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
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7983e8c9c89d..b763c6ba636f 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6245,7 +6245,7 @@ int smb2_read(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_read_req *req;
 	struct smb2_read_rsp *rsp, *rsp_org;
-	struct ksmbd_file *fp;
+	struct ksmbd_file *fp = NULL;
 	loff_t offset;
 	size_t length, mincount;
 	ssize_t nbytes = 0, remain_bytes = 0;
@@ -6253,6 +6253,11 @@ int smb2_read(struct ksmbd_work *work)
 
 	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
+	if (work->next_smb2_rcv_hdr_off) {
+		work->send_no_response = 1;
+		err = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
@@ -8649,7 +8654,8 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
 	int rc = 0;
 
-	if (buf_data_size < sizeof(struct smb2_hdr)) {
+	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
+	    buf_data_size < sizeof(struct smb2_hdr)) {
 		pr_err("Transform message is too small (%u)\n",
 		       pdu_length);
 		return -ECONNABORTED;
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
index 885b0e93ee96..ea2785103376 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2836,7 +2836,7 @@ int path_pts(struct path *path)
 	dput(path->dentry);
 	path->dentry = parent;
 	child = d_hash_and_lookup(parent, &this);
-	if (!child)
+	if (IS_ERR_OR_NULL(child))
 		return -ENOENT;
 
 	path->dentry = child;
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index acb1d22907da..16412d6636e8 100644
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
index 3d5ba43f44bb..266a4badf1df 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -949,7 +949,7 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	/*
 	 * The type (size and byte order) of nfscookie isn't defined in
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 7ab60ad98776..d48db2f6f4f0 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1990,7 +1990,7 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_inline_filename3(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return -EAGAIN;
+		return error == -ENAMETOOLONG ? -ENAMETOOLONG : -EAGAIN;
 
 	error = decode_cookie3(xdr, &new_cookie);
 	if (unlikely(error))
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index bc07012741cb..2975bbc33d28 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -462,8 +462,9 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
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
index ddbbf4fcda86..178001c90156 100644
--- a/fs/nfs/pnfs_dev.c
+++ b/fs/nfs/pnfs_dev.c
@@ -154,7 +154,7 @@ nfs4_get_device_info(struct nfs_server *server,
 		set_bit(NFS_DEVICEID_NOCACHE, &d->flags);
 
 out_free_pages:
-	for (i = 0; i < max_pages; i++)
+	while (--i >= 0)
 		__free_page(pages[i]);
 	kfree(pages);
 out_free_pdev:
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 657c242a18ff..6b681f0c5df0 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -943,7 +943,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct nfs_server *mds_srv,
 			* Test this address for session trunking and
 			* add as an alias
 			*/
-			xprtdata.cred = nfs4_get_clid_cred(clp),
+			xprtdata.cred = nfs4_get_clid_cred(clp);
 			rpc_clnt_add_xprt(clp->cl_rpcclient, &xprt_args,
 					  rpc_clnt_setup_test_and_add_xprt,
 					  &rpcdata);
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
index e8132a17eeb3..d28b75909de8 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4533,20 +4533,17 @@ nfsd4_encode_getdeviceinfo(struct nfsd4_compoundres *resp, __be32 nfserr,
 
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
index 3c24eceeb4ff..0b4f3d287cbc 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1535,6 +1535,10 @@ static int ocfs2_rename(struct user_namespace *mnt_userns,
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
index 5310271cf2e3..e18025b5c887 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2140,7 +2140,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 300d53ee7040..e5d7a5a75aff 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3544,7 +3544,8 @@ static int proc_tid_comm_permission(struct user_namespace *mnt_userns,
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
-		.permission = proc_tid_comm_permission,
+		.setattr	= proc_setattr,
+		.permission	= proc_tid_comm_permission,
 };
 
 /*
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index fd9bab137685..ccdb71c3dc51 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -518,7 +518,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
-		if (buffer_size(prz) == 0) {
+		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
 			pr_debug("found existing empty buffer\n");
 			return 0;
 		}
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b88f5a2f6032..889eaea56a78 100644
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
@@ -305,12 +318,18 @@ static inline void put_dquot_last(struct dquot *dquot)
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
@@ -336,6 +355,11 @@ static void wait_on_dquot(struct dquot *dquot)
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
@@ -351,14 +375,14 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
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
@@ -440,7 +464,7 @@ int dquot_acquire(struct dquot *dquot)
 	smp_mb__before_atomic();
 	set_bit(DQ_READ_B, &dquot->dq_flags);
 	/* Instantiate dquot if needed */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags) && !dquot->dq_off) {
+	if (!dquot_active(dquot) && !dquot->dq_off) {
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 		/* Write the info if needed */
 		if (info_dirty(&dqopt->info[dquot->dq_id.type])) {
@@ -482,7 +506,7 @@ int dquot_commit(struct dquot *dquot)
 		goto out_lock;
 	/* Inactive dquot can be only if there was error during read/init
 	 * => we have better not writing it */
-	if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+	if (dquot_active(dquot))
 		ret = dqopt->ops[dquot->dq_id.type]->commit_dqblk(dquot);
 	else
 		ret = -EIO;
@@ -547,6 +571,8 @@ static void invalidate_dquots(struct super_block *sb, int type)
 	struct dquot *dquot, *tmp;
 
 restart:
+	flush_delayed_work(&quota_release_work);
+
 	spin_lock(&dq_list_lock);
 	list_for_each_entry_safe(dquot, tmp, &inuse_list, dq_inuse) {
 		if (dquot->dq_sb != sb)
@@ -555,6 +581,12 @@ static void invalidate_dquots(struct super_block *sb, int type)
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
@@ -597,7 +629,7 @@ int dquot_scan_active(struct super_block *sb,
 
 	spin_lock(&dq_list_lock);
 	list_for_each_entry(dquot, &inuse_list, dq_inuse) {
-		if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
+		if (!dquot_active(dquot))
 			continue;
 		if (dquot->dq_sb != sb)
 			continue;
@@ -612,7 +644,7 @@ int dquot_scan_active(struct super_block *sb,
 		 * outstanding call and recheck the DQ_ACTIVE_B after that.
 		 */
 		wait_on_dquot(dquot);
-		if (test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+		if (dquot_active(dquot)) {
 			ret = fn(dquot, priv);
 			if (ret < 0)
 				goto out;
@@ -628,6 +660,18 @@ int dquot_scan_active(struct super_block *sb,
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
@@ -651,23 +695,16 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
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
@@ -760,13 +797,54 @@ static struct shrinker dqcache_shrinker = {
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
@@ -778,7 +856,7 @@ void dqput(struct dquot *dquot)
 	}
 #endif
 	dqstats_inc(DQST_DROPS);
-we_slept:
+
 	spin_lock(&dq_list_lock);
 	if (atomic_read(&dquot->dq_count) > 1) {
 		/* We have more than one user... nothing to do */
@@ -790,35 +868,15 @@ void dqput(struct dquot *dquot)
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
 
@@ -908,7 +966,7 @@ struct dquot *dqget(struct super_block *sb, struct kqid qid)
 	 * already finished or it will be canceled due to dq_count > 1 test */
 	wait_on_dquot(dquot);
 	/* Read the dquot / allocate space in quota file */
-	if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags)) {
+	if (!dquot_active(dquot)) {
 		int err;
 
 		err = sb->dq_op->acquire_dquot(dquot);
@@ -1425,7 +1483,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
 	return QUOTA_NL_NOWARN;
 }
 
-static int dquot_active(const struct inode *inode)
+static int inode_quota_active(const struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -1448,7 +1506,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 	qsize_t rsv;
 	int ret = 0;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	dquots = i_dquot(inode);
@@ -1556,7 +1614,7 @@ bool dquot_initialize_needed(struct inode *inode)
 	struct dquot **dquots;
 	int i;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return false;
 
 	dquots = i_dquot(inode);
@@ -1667,7 +1725,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
 	int reserve = flags & DQUOT_SPACE_RESERVE;
 	struct dquot **dquots;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) += number;
@@ -1737,7 +1795,7 @@ int dquot_alloc_inode(struct inode *inode)
 	struct dquot_warn warn[MAXQUOTAS];
 	struct dquot * const *dquots;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		warn[cnt].w_type = QUOTA_NL_NOWARN;
@@ -1780,7 +1838,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) -= number;
 		__inode_add_bytes(inode, number);
@@ -1822,7 +1880,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
 	struct dquot **dquots;
 	int cnt, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		spin_lock(&inode->i_lock);
 		*inode_reserved_space(inode) += number;
 		__inode_sub_bytes(inode, number);
@@ -1866,7 +1924,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
 	struct dquot **dquots;
 	int reserve = flags & DQUOT_SPACE_RESERVE, index;
 
-	if (!dquot_active(inode)) {
+	if (!inode_quota_active(inode)) {
 		if (reserve) {
 			spin_lock(&inode->i_lock);
 			*inode_reserved_space(inode) -= number;
@@ -1921,7 +1979,7 @@ void dquot_free_inode(struct inode *inode)
 	struct dquot * const *dquots;
 	int index;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return;
 
 	dquots = i_dquot(inode);
@@ -2092,7 +2150,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 	struct super_block *sb = inode->i_sb;
 	int ret;
 
-	if (!dquot_active(inode))
+	if (!inode_quota_active(inode))
 		return 0;
 
 	if (iattr->ia_valid & ATTR_UID && !uid_eq(iattr->ia_uid, inode->i_uid)){
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 0834b101c316..86a1dee6e2e7 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2323,7 +2323,7 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 	int i, j;
 
 	bh = __getblk(dev, block, bufsize);
-	if (buffer_uptodate(bh))
+	if (!bh || buffer_uptodate(bh))
 		return (bh);
 
 	if (block + BUFNR > max_block) {
@@ -2333,6 +2333,8 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
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
index 594d22458881..da6fb28b4eea 100644
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
index 143a530a8008..b59de03055e1 100644
--- a/fs/verity/signature.c
+++ b/fs/verity/signature.c
@@ -54,6 +54,22 @@ int fsverity_verify_signature(const struct fsverity_info *vi,
 		return 0;
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
diff --git a/include/crypto/algapi.h b/include/crypto/algapi.h
index 0ffd61930e18..62fa7e82ff5b 100644
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
index 14dc461b0e82..255701e1251b 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -47,10 +47,12 @@ int sdei_unregister_ghes(struct ghes *ghes);
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
 void __init sdei_init(void);
+void sdei_handler_abort(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
 static inline void sdei_init(void) { }
+static inline void sdei_handler_abort(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0b48a0cf4262..690b7f7996d1 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -60,24 +60,15 @@ struct partition_meta_info {
  * (``BLOCK_EXT_MAJOR``).
  * This affects the maximum number of partitions.
  *
- * ``GENHD_FL_NATIVE_CAPACITY`` (0x0080): based on information in the
- * partition table, the device's capacity has been extended to its
- * native capacity; i.e. the device has hidden capacity used by one
- * of the partitions (this is a flag used so that native capacity is
- * only ever unlocked once).
- *
- * ``GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE`` (0x0100): event polling is
- * blocked whenever a writer holds an exclusive lock.
- *
- * ``GENHD_FL_NO_PART_SCAN`` (0x0200): partition scanning is disabled.
- * Used for loop devices in their default settings and some MMC
- * devices.
+ * ``GENHD_FL_NO_PART`` (0x0200): partition support is disabled.
+ * The kernel will not scan for partitions from add_disk, and users
+ * can't add partitions manually.
  *
  * ``GENHD_FL_HIDDEN`` (0x0400): the block device is hidden; it
  * doesn't produce events, doesn't appear in sysfs, and doesn't have
  * an associated ``bdev``.
  * Implies ``GENHD_FL_SUPPRESS_PARTITION_INFO`` and
- * ``GENHD_FL_NO_PART_SCAN``.
+ * ``GENHD_FL_NO_PART``.
  * Used for multipath devices.
  */
 #define GENHD_FL_REMOVABLE			0x0001
@@ -86,9 +77,7 @@ struct partition_meta_info {
 #define GENHD_FL_CD				0x0008
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	0x0020
 #define GENHD_FL_EXT_DEVT			0x0040
-#define GENHD_FL_NATIVE_CAPACITY		0x0080
-#define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
-#define GENHD_FL_NO_PART_SCAN			0x0200
+#define GENHD_FL_NO_PART			0x0200
 #define GENHD_FL_HIDDEN				0x0400
 
 enum {
@@ -101,6 +90,8 @@ enum {
 	DISK_EVENT_FLAG_POLL			= 1 << 0,
 	/* Forward events to udev */
 	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
+	/* Block event polling when open for exclusive write */
+	DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE	= 1 << 2,
 };
 
 struct disk_events;
@@ -140,6 +131,7 @@ struct gendisk {
 #define GD_NEED_PART_SCAN		0
 #define GD_READ_ONLY			1
 #define GD_DEAD				2
+#define GD_NATIVE_CAPACITY		3
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
@@ -193,8 +185,7 @@ static inline int disk_max_parts(struct gendisk *disk)
 
 static inline bool disk_part_scan_enabled(struct gendisk *disk)
 {
-	return disk_max_parts(disk) > 1 &&
-		!(disk->flags & GENHD_FL_NO_PART_SCAN);
+	return disk_max_parts(disk) > 1 && !(disk->flags & GENHD_FL_NO_PART);
 }
 
 static inline dev_t disk_devt(struct gendisk *disk)
diff --git a/include/linux/if_arp.h b/include/linux/if_arp.h
index 1ed52441972f..10a1e81434cb 100644
--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -53,6 +53,10 @@ static inline bool dev_is_mac_header_xmit(const struct net_device *dev)
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
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4f189b17dafc..94df87cb69c3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -310,6 +310,11 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+	/*
+	 * Hint of reclaim pressure for socket memroy management. Note
+	 * that this indicator should NOT be used in legacy cgroup mode
+	 * where socket memory is accounted/charged separately.
+	 */
 	unsigned long		socket_pressure;
 
 	/* Legacy tcp memory accounting */
@@ -1627,8 +1632,8 @@ void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && memcg->tcpmem_pressure)
-		return true;
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return !!memcg->tcpmem_pressure;
 	do {
 		if (time_before(jiffies, memcg->socket_pressure))
 			return true;
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 3d43c60b49fa..2d0f75ffa323 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -37,9 +37,9 @@
 #define	PHY_ID_KSZ9477		0x00221631
 
 /* struct phy_device dev_flags definitions */
-#define MICREL_PHY_50MHZ_CLK	0x00000001
-#define MICREL_PHY_FXEN		0x00000002
-#define MICREL_KSZ8_P1_ERRATA	0x00000003
+#define MICREL_PHY_50MHZ_CLK	BIT(0)
+#define MICREL_PHY_FXEN		BIT(1)
+#define MICREL_KSZ8_P1_ERRATA	BIT(2)
 
 #define MICREL_KSZ9021_EXTREG_CTRL	0xB
 #define MICREL_KSZ9021_EXTREG_DATA_WRITE	0xC
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
diff --git a/include/linux/of.h b/include/linux/of.h
index 140671cb746a..6f15e8b0f9d1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -574,7 +574,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size);
 int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
+int __init ima_free_kexec_buffer(void);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
diff --git a/include/linux/tca6416_keypad.h b/include/linux/tca6416_keypad.h
index b0d36a9934cc..5cf6f6f82aa7 100644
--- a/include/linux/tca6416_keypad.h
+++ b/include/linux/tca6416_keypad.h
@@ -25,7 +25,6 @@ struct tca6416_keys_platform_data {
 	unsigned int rep:1;	/* enable input subsystem auto repeat */
 	uint16_t pinmask;
 	uint16_t invert;
-	int irq_is_gpio;
 	int use_polling;	/* use polling if Interrupt is not connected*/
 };
 #endif
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index ff137179e0c3..9c91c3531d83 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -846,7 +846,8 @@ extern int  perf_uprobe_init(struct perf_event *event,
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
index 65933cbe9129..c33a8bc626d3 100644
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
index fc05e016be06..e1a93c339109 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -56,6 +56,7 @@ struct inet_skb_parm {
 #define IPSKB_FRAG_PMTU		BIT(6)
 #define IPSKB_L3SLAVE		BIT(7)
 #define IPSKB_NOPOLICY		BIT(8)
+#define IPSKB_MULTIPATH		BIT(9)
 
 	u16			frag_max_size;
 };
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index bbb27639f293..d72cee4dff70 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -610,7 +610,10 @@ static inline bool fib6_rules_early_flow_dissect(struct net *net,
 	if (!net->ipv6.fib6_rules_require_fldissect)
 		return false;
 
-	skb_flow_dissect_flow_keys(skb, flkeys, flag);
+	memset(flkeys, 0, sizeof(*flkeys));
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   flkeys, NULL, 0, 0, 0, flag);
+
 	fl6->fl6_sport = flkeys->ports.src;
 	fl6->fl6_dport = flkeys->ports.dst;
 	fl6->flowi6_proto = flkeys->basic.ip_proto;
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 3417ba2d27ad..c3324a1949c3 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -415,7 +415,10 @@ static inline bool fib4_rules_early_flow_dissect(struct net *net,
 	if (!net->ipv4.fib_rules_require_fldissect)
 		return false;
 
-	skb_flow_dissect_flow_keys(skb, flkeys, flag);
+	memset(flkeys, 0, sizeof(*flkeys));
+	__skb_flow_dissect(net, skb, &flow_keys_dissector,
+			   flkeys, NULL, 0, 0, 0, flag);
+
 	fl4->fl4_sport = flkeys->ports.src;
 	fl4->fl4_dport = flkeys->ports.dst;
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 4eb0edc6640d..17ec652e8f12 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -454,15 +454,14 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
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
index 20930086b228..6b3309e55dcb 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1258,7 +1258,7 @@ static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
 	return 0;
 }
 
-static inline int ip6_sock_set_addr_preferences(struct sock *sk, bool val)
+static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
 {
 	int ret;
 
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 6f15e6fa154e..53bd2d02a4f0 100644
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
index d8920f84f0a8..4aafda05a646 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -340,7 +340,6 @@ ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks);
 static inline void tcp_dec_quickack_mode(struct sock *sk,
 					 const unsigned int pkts)
 {
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 1a02e58eb4e4..f50861e4e88a 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -762,7 +762,7 @@ extern void scsi_remove_host(struct Scsi_Host *);
 extern struct Scsi_Host *scsi_host_get(struct Scsi_Host *);
 extern int scsi_host_busy(struct Scsi_Host *shost);
 extern void scsi_host_put(struct Scsi_Host *t);
-extern struct Scsi_Host *scsi_host_lookup(unsigned short);
+extern struct Scsi_Host *scsi_host_lookup(unsigned int hostnum);
 extern const char *scsi_host_state_name(enum scsi_host_state);
 extern void scsi_host_complete_all_commands(struct Scsi_Host *shost,
 					    enum scsi_host_status status);
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
index 7c98a820c8dd..1519125b9814 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2668,6 +2668,11 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
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
@@ -5716,6 +5721,7 @@ static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
 	if (ret > 0)
 		return;
 
+	io_tw_lock(req->ctx, locked);
 	io_poll_remove_entries(req);
 	spin_lock(&ctx->completion_lock);
 	hash_del(&req->hash_node);
@@ -7068,7 +7074,8 @@ static void io_wq_submit_work(struct io_wq_work *work)
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
-
+			if (io_wq_worker_stopped())
+				break;
 			/*
 			 * If REQ_F_NOWAIT is set, then don't wait or retry with
 			 * poll. -EAGAIN is final for that case.
@@ -7531,7 +7538,9 @@ static const struct io_uring_sqe *io_get_sqe(struct io_ring_ctx *ctx)
 		return &ctx->sq_sqes[head];
 
 	/* drop invalid entries */
+	spin_lock(&ctx->completion_lock);
 	ctx->cq_extra--;
+	spin_unlock(&ctx->completion_lock);
 	WRITE_ONCE(ctx->rings->sq_dropped,
 		   READ_ONCE(ctx->rings->sq_dropped) + 1);
 	return NULL;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2f036bab3c28..e7fedf504f76 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2200,6 +2200,8 @@ void __audit_inode_child(struct inode *parent,
 		}
 	}
 
+	cond_resched();
+
 	/* is there a matching child entry? */
 	list_for_each_entry(n, &context->names_list, list) {
 		/* can only match entries that have a name */
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index 0d5c29879a50..144a464e45c6 100644
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
index 7e9fa1b7ff67..6cf561322bbe 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1545,6 +1545,17 @@ int __weak arch_check_ftrace_location(struct kprobe *p)
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
@@ -1563,7 +1574,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-	    find_bug((unsigned long)p->addr)) {
+	    find_bug((unsigned long)p->addr) ||
+	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 8a7b7362c0dd..d069e0d3768b 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1724,7 +1724,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	if (!buf || !buf_size)
 		return true;
 
-	data_size = min_t(u16, buf_size, len);
+	data_size = min_t(unsigned int, buf_size, len);
 
 	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
 	return true;
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 5abb0cf52803..fda220e2c042 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -849,12 +849,11 @@ ref_scale_init(void)
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
index 6352a41380e5..85a36b19c2b8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1996,7 +1996,7 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 #ifdef CONFIG_UPROBE_EVENTS
 		if (flags & TRACE_EVENT_FL_UPROBE)
 			err = bpf_get_uprobe_info(event, fd_type, buf,
-						  probe_offset,
+						  probe_offset, probe_addr,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 	}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8769cd18f622..f3f1e3c2f421 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6587,10 +6587,36 @@ tracing_max_lat_write(struct file *filp, const char __user *ubuf,
 
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
@@ -6598,13 +6624,16 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
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
@@ -6627,7 +6656,7 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 
 	iter->tr = tr;
 	iter->array_buffer = &tr->array_buffer;
-	iter->cpu_file = tracing_get_cpu(inode);
+	iter->cpu_file = cpu;
 	mutex_init(&iter->mutex);
 	filp->private_data = iter;
 
@@ -6637,12 +6666,15 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
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
@@ -6659,7 +6691,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 
 	if (iter->trace->pipe_close)
 		iter->trace->pipe_close(iter);
-
+	close_pipe_on_cpu(tr, iter->cpu_file);
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(iter->started);
@@ -7464,6 +7496,11 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
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
@@ -7522,13 +7559,15 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
@@ -9311,6 +9350,9 @@ static struct trace_array *trace_array_create(const char *name)
 	if (!alloc_cpumask_var(&tr->tracing_cpumask, GFP_KERNEL))
 		goto out_free_tr;
 
+	if (!zalloc_cpumask_var(&tr->pipe_cpumask, GFP_KERNEL))
+		goto out_free_tr;
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9352,6 +9394,7 @@ static struct trace_array *trace_array_create(const char *name)
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
+	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
@@ -9454,6 +9497,7 @@ static int __remove_instance(struct trace_array *tr)
 	}
 	kfree(tr->topts);
 
+	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
 	kfree(tr);
@@ -10164,12 +10208,14 @@ __init static int tracer_alloc_buffers(void)
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
 
@@ -10222,6 +10268,8 @@ __init static int tracer_alloc_buffers(void)
 
 	return 0;
 
+out_free_pipe_cpumask:
+	free_cpumask_var(global_trace.pipe_cpumask);
 out_free_savedcmd:
 	free_saved_cmdlines_buffer(savedcmd);
 out_free_temp_buffer:
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 43058077a4de..90ab921884b1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -367,6 +367,8 @@ struct trace_array {
 	struct list_head	events;
 	struct trace_event_file *trace_marker_file;
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
+	/* one per_cpu trace_pipe can be opened by only one user */
+	cpumask_var_t		pipe_cpumask;
 	int			ref;
 	int			trace_ref;
 #ifdef CONFIG_FUNCTION_TRACER
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 9ec032f22531..3a994bd8520c 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -635,7 +635,7 @@ static int s_mode_show(struct seq_file *s, void *v)
 	else
 		seq_printf(s, "%s", thread_mode_str[mode]);
 
-	if (mode != MODE_MAX)
+	if (mode < MODE_MAX - 1) /* if mode is any but last */
 		seq_puts(s, " ");
 
 	return 0;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index debc65101548..720b46b34ab9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1423,7 +1423,7 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
 			const char **filename, u64 *probe_offset,
-			bool perf_type_tracepoint)
+			u64 *probe_addr, bool perf_type_tracepoint)
 {
 	const char *pevent = trace_event_name(event->tp_event);
 	const char *group = event->tp_event->class->system;
@@ -1440,6 +1440,7 @@ int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
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
diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index b620cf7de503..a2707af2951a 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -606,7 +606,7 @@ static void __init numbers_slice(void)
 #define test_number_prefix(T, str, scan_fmt, expect0, expect1, n_args, fn)	\
 do {										\
 	const T expect[2] = { expect0, expect1 };				\
-	T result[2] = {~expect[0], ~expect[1]};					\
+	T result[2] = { (T)~expect[0], (T)~expect[1] };				\
 										\
 	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
 } while (0)
diff --git a/mm/shmem.c b/mm/shmem.c
index 41efb92c4e38..663fb117cd87 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3394,6 +3394,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	unsigned long long size;
 	char *rest;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3429,14 +3431,32 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
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
diff --git a/mm/util.c b/mm/util.c
index ea04979f131e..e89ef15085de 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1110,7 +1110,9 @@ void mem_dump_obj(void *object)
 	if (vmalloc_dump_obj(object))
 		return;
 
-	if (virt_addr_valid(object))
+	if (is_vmalloc_addr(object))
+		type = "vmalloc memory";
+	else if (virt_addr_valid(object))
 		type = "non-slab/vmalloc memory";
 	else if (object == NULL)
 		type = "NULL pointer";
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b36d94ef337d..cd434f0ec47f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3823,14 +3823,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
-	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+	const void *caller;
+	struct vm_struct *vm;
+	struct vmap_area *va;
+	unsigned long addr;
+	unsigned int nr_pages;
+
+	if (!spin_trylock(&vmap_area_lock))
+		return false;
+	va = __find_vmap_area((unsigned long)objp);
+	if (!va) {
+		spin_unlock(&vmap_area_lock);
+		return false;
+	}
 
-	vm = find_vm_area(objp);
-	if (!vm)
+	vm = va->vm;
+	if (!vm) {
+		spin_unlock(&vmap_area_lock);
 		return false;
+	}
+	addr = (unsigned long)vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vmap_area_lock);
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
+		nr_pages, addr, caller);
 	return true;
 }
 #endif
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 76518e4166dc..383e0463c025 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -244,6 +244,14 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 	if (mem_cgroup_disabled())
 		return;
 
+	/*
+	 * The in-kernel users only care about the reclaim efficiency
+	 * for this @memcg rather than the whole subtree, and there
+	 * isn't and won't be any in-kernel user in a legacy cgroup.
+	 */
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !tree)
+		return;
+
 	vmpr = memcg_to_vmpressure(memcg);
 
 	/*
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index d110df3cb4e1..96eecc2dcaa3 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -399,7 +399,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
-	size_t offs;
+	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 682a09e7fea6..e777ccf76b2b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2355,9 +2355,9 @@ void hci_uuids_clear(struct hci_dev *hdev)
 
 void hci_link_keys_clear(struct hci_dev *hdev)
 {
-	struct link_key *key;
+	struct link_key *key, *tmp;
 
-	list_for_each_entry(key, &hdev->link_keys, list) {
+	list_for_each_entry_safe(key, tmp, &hdev->link_keys, list) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
 	}
@@ -2365,9 +2365,9 @@ void hci_link_keys_clear(struct hci_dev *hdev)
 
 void hci_smp_ltks_clear(struct hci_dev *hdev)
 {
-	struct smp_ltk *k;
+	struct smp_ltk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->long_term_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->long_term_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -2375,9 +2375,9 @@ void hci_smp_ltks_clear(struct hci_dev *hdev)
 
 void hci_smp_irks_clear(struct hci_dev *hdev)
 {
-	struct smp_irk *k;
+	struct smp_irk *k, *tmp;
 
-	list_for_each_entry(k, &hdev->identity_resolving_keys, list) {
+	list_for_each_entry_safe(k, tmp, &hdev->identity_resolving_keys, list) {
 		list_del_rcu(&k->list);
 		kfree_rcu(k, rcu);
 	}
@@ -2385,9 +2385,9 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
 
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
index 458756334c4f..76432aa3b717 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6959,6 +6959,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -ENETUNREACH;
 	if (unlikely(sk_fullsock(sk) && sk->sk_reuseport))
 		return -ESOCKTNOSUPPORT;
+	if (sk_unhashed(sk))
+		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
 	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 		return -ENOENT;
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1d230f041386..2596a54c2fe7 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1614,8 +1614,7 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 
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
index e01dd4cad0fc..7090844af499 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4001,21 +4001,20 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4092,6 +4091,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4112,6 +4118,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		    (skb_headlen(list_skb) == len || sg)) {
 			BUG_ON(skb_headlen(list_skb) > len);
 
+			nskb = skb_clone(list_skb, GFP_ATOMIC);
+			if (unlikely(!nskb))
+				goto err;
+
 			i = 0;
 			nfrags = skb_shinfo(list_skb)->nr_frags;
 			frag = skb_shinfo(list_skb)->frags;
@@ -4130,12 +4140,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
@@ -4211,12 +4217,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
 					   SKBFL_SHARED_FRAG;
 
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
@@ -4230,10 +4240,6 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
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
index ae1e9e2b8255..8faa0f9cc083 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -717,7 +717,8 @@ bool sk_mc_loop(struct sock *sk)
 		return false;
 	if (!sk)
 		return true;
-	switch (sk->sk_family) {
+	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+	switch (READ_ONCE(sk->sk_family)) {
 	case AF_INET:
 		return inet_sk(sk)->mc_loop;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2463,9 +2464,9 @@ static long sock_wait_for_wmem(struct sock *sk, long timeo)
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
@@ -2493,7 +2494,7 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 			goto failure;
 
 		err = -EPIPE;
-		if (sk->sk_shutdown & SEND_SHUTDOWN)
+		if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 			goto failure;
 
 		if (sk_wmem_alloc_get(sk) < READ_ONCE(sk->sk_sndbuf))
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 5bcfa1e9a941..1490ba960365 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -250,12 +250,17 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
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
index b1fa335e0b52..c9f11f86266c 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -74,7 +74,7 @@ static inline __u64 dccp_v6_init_sequence(struct sk_buff *skb)
 static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			u8 type, u8 code, int offset, __be32 info)
 {
-	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
+	const struct ipv6hdr *hdr;
 	const struct dccp_hdr *dh;
 	struct dccp_sock *dp;
 	struct ipv6_pinfo *np;
@@ -83,12 +83,17 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
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
index 35382ed686d1..12ba43023d30 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -552,6 +552,7 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
 		netdev_warn_once(skb->dev, "VLAN not yet supported");
+		return -EINVAL;
 	}
 
 	frame->is_from_san = false;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 9ac41ffdc634..c511751c2f41 100644
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
index 607a4f816155..799370bcc70c 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -276,7 +276,8 @@ void fib_release_info(struct fib_info *fi)
 				hlist_del(&nexthop_nh->nh_hash);
 			} endfor_nexthops(fi)
 		}
-		fi->fib_dead = 1;
+		/* Paired with READ_ONCE() from fib_table_lookup() */
+		WRITE_ONCE(fi->fib_dead, 1);
 		fib_info_put(fi);
 	}
 	spin_unlock_bh(&fib_info_lock);
@@ -1598,6 +1599,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 link_it:
 	ofi = fib_find_info(fi);
 	if (ofi) {
+		/* fib_table_lookup() should not see @fi yet. */
 		fi->fib_dead = 1;
 		free_fib_info(fi);
 		refcount_inc(&ofi->fib_treeref);
@@ -1636,6 +1638,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 
 failure:
 	if (fi) {
+		/* fib_table_lookup() should not see @fi yet. */
 		fi->fib_dead = 1;
 		free_fib_info(fi);
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 52f9f69f57b3..22531aac0ccb 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1578,7 +1578,8 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
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
index e07d10b2c486..1f63dc8897a4 100644
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
index 124bf8fdf924..5d0bc0dbdb4d 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -581,7 +581,8 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
 					     struct sk_buff *skb, int rt_type)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
+	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	    IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ae8a456df5ab..a5f09d64c6ed 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -214,7 +214,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ca59b61fd3a3..bc6240d327a8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2151,6 +2151,7 @@ static int ip_mkroute_input(struct sk_buff *skb,
 		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
 		fib_select_multipath(res, h);
+		IPCB(skb)->flags |= IPSKB_MULTIPATH;
 	}
 #endif
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6849094e5e5e..94633f499e14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -287,7 +287,7 @@ static void tcp_incr_quickack(struct sock *sk, unsigned int max_quickacks)
 		icsk->icsk_ack.quick = quickacks;
 }
 
-void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
+static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -295,7 +295,6 @@ void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 	inet_csk_exit_pingpong_mode(sk);
 	icsk->icsk_ack.ato = TCP_ATO_MIN;
 }
-EXPORT_SYMBOL(tcp_enter_quickack_mode);
 
 /* Send ACKs quickly, if "quick" count is not exhausted
  * and the session is not interactive.
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index a8592c187b32..40a354dcfec5 100644
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
index 73bf63d719f8..198d8e07413d 100644
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
index 0c0b7969840f..6572174e2115 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1368,7 +1368,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(long,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index be63929b1ac5..2207acd7108c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -112,7 +112,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
 		int res = lwtunnel_xmit(skb);
 
-		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
+		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index a746abbe81b5..d5d254ca2dfe 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -190,14 +190,23 @@ static struct sock *udp6_lib_lookup2(struct net *net,
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
@@ -927,6 +936,7 @@ static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
 	struct net *net = dev_net(skb->dev);
 	struct udphdr *uh;
@@ -1003,6 +1013,8 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
 
+	reason = SKB_DROP_REASON_NO_SOCKET;
+
 	if (!uh->check)
 		goto report_csum_error;
 
@@ -1015,10 +1027,12 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_NOPORTS, proto == IPPROTO_UDPLITE);
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 
 short_packet:
+	if (reason == SKB_DROP_REASON_NOT_SPECIFIED)
+		reason = SKB_DROP_REASON_PKT_TOO_SMALL;
 	net_dbg_ratelimited("UDP%sv6: short packet: From [%pI6c]:%u %d/%d to [%pI6c]:%u\n",
 			    proto == IPPROTO_UDPLITE ? "-Lite" : "",
 			    saddr, ntohs(uh->source),
@@ -1029,10 +1043,12 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 report_csum_error:
 	udp6_csum_zero_error(skb);
 csum_error:
+	if (reason == SKB_DROP_REASON_NOT_SPECIFIED)
+		reason = SKB_DROP_REASON_UDP_CSUM;
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:
 	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 9c60c0c18b4d..0d1ab4149553 100644
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
index 005a7ce87217..bf4f91b78e1d 100644
--- a/net/netfilter/ipset/ip_set_hash_netportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
@@ -36,6 +36,7 @@ MODULE_ALIAS("ip_set_hash:net,port,net");
 #define IP_SET_HASH_WITH_PROTO
 #define IP_SET_HASH_WITH_NETS
 #define IPSET_NET_COUNT 2
+#define IP_SET_HASH_WITH_NET0
 
 /* IPv4 variant */
 
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 8f1bfa6ccc2d..50723ba08289 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -315,6 +315,14 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 
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
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 9e927ab4df15..3609680831a1 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -35,6 +35,14 @@ static unsigned int optlen(const u8 *opt, unsigned int offset)
 		return opt[offset + 1];
 }
 
+static int nft_skb_copy_to_reg(const struct sk_buff *skb, int offset, u32 *dest, unsigned int len)
+{
+	if (len % NFT_REG32_SIZE)
+		dest[len / NFT_REG32_SIZE] = 0;
+
+	return skb_copy_bits(skb, offset, dest, len);
+}
+
 static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -56,8 +64,7 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -153,8 +160,7 @@ static void nft_exthdr_ipv4_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -210,7 +216,8 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
 			*dest = 1;
 		} else {
-			dest[priv->len / NFT_REG32_SIZE] = 0;
+			if (priv->len % NFT_REG32_SIZE)
+				dest[priv->len / NFT_REG32_SIZE] = 0;
 			memcpy(dest, opt + offset, priv->len);
 		}
 
@@ -335,9 +342,8 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 			    offset + ntohs(sch->length) > pkt->skb->len)
 				break;
 
-			dest[priv->len / NFT_REG32_SIZE] = 0;
-			if (skb_copy_bits(pkt->skb, offset + priv->offset,
-					  dest, priv->len) < 0)
+			if (nft_skb_copy_to_reg(pkt->skb, offset + priv->offset,
+						dest, priv->len) < 0)
 				break;
 			return;
 		}
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
index 54c083003947..27511c90a26f 100644
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
index ce7833f95214..1fb68c973f45 100644
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
index c802a027b4f3..01126e285f94 100644
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
index 905c86b50215..b1dbe03dde1b 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -980,10 +980,13 @@ static void qfq_update_eligible(struct qfq_sched *q)
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
 
@@ -993,6 +996,8 @@ static void agg_dequeue(struct qfq_aggregate *agg,
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
 	}
+
+	return skb;
 }
 
 static inline struct sk_buff *qfq_peek_skb(struct qfq_aggregate *agg,
@@ -1138,11 +1143,18 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
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
index 463c4a58d2c3..970c6a486a9b 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1251,7 +1251,10 @@ static int sctp_side_effects(enum sctp_event_type event_type,
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
index 717e2f60370b..36a37fef2771 100644
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
 
@@ -9148,7 +9148,7 @@ static void sctp_wfree(struct sk_buff *skb)
 	struct sock *sk = asoc->base.sk;
 
 	sk_mem_uncharge(sk, skb->truesize);
-	sk->sk_wmem_queued -= skb->truesize + sizeof(struct sctp_chunk);
+	sk_wmem_queued_add(sk, -(skb->truesize + sizeof(struct sctp_chunk)));
 	asoc->sndbuf_used -= skb->truesize + sizeof(struct sctp_chunk);
 	WARN_ON(refcount_sub_and_test(sizeof(struct sctp_chunk),
 				      &sk->sk_wmem_alloc));
@@ -9303,9 +9303,9 @@ void sctp_write_space(struct sock *sk)
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
index f08fcc50fad3..b84896acd473 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1486,6 +1486,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 {
 	struct smc_link_group *lgr, *n;
 
+	spin_lock_bh(&smc_lgr_list.lock);
 	list_for_each_entry_safe(lgr, n, &smc_lgr_list.list, list) {
 		struct smc_link *link;
 
@@ -1500,6 +1501,7 @@ void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
 		if (link)
 			smc_llc_add_link_local(link);
 	}
+	spin_unlock_bh(&smc_lgr_list.lock);
 }
 
 /* link is down - switch connections to alternate link,
diff --git a/net/socket.c b/net/socket.c
index 5c49074ef7f2..8b8182cdb4bf 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3453,7 +3453,11 @@ EXPORT_SYMBOL(kernel_accept);
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
index bc897ff56e78..101d231c1b61 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -809,7 +809,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	psock = sk_psock_get(sk);
 	if (!psock || !policy) {
 		err = tls_push_record(sk, flags, record_type);
-		if (err && sk->sk_err == EBADMSG) {
+		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
 			err = -sk->sk_err;
@@ -838,7 +838,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
-		if (err && sk->sk_err == EBADMSG) {
+		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
 			err = -sk->sk_err;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5264fe82e6ec..748769f4ba05 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -603,7 +603,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
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
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1b91a9c20896..ed3ec7e320ce 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -314,6 +314,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR] = { .type = NLA_U8 },
 };
 
 static const struct nla_policy
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index c014217f5fa7..22b36c8143cf 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	sock_diag_save_cookie(sk, msg->xdiag_cookie);
 
 	mutex_lock(&xs->mutex);
+	if (READ_ONCE(xs->state) == XSK_UNBOUND)
+		goto out_nlmsg_trim;
+
 	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
 		goto out_nlmsg_trim;
 
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
index 5d2c8990d1ac..7bc416c17211 100644
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
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..0afe413dda68 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -122,7 +122,7 @@ struct ima_kexec_hdr {
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
-void ima_load_kexec_buffer(void);
+void __init ima_load_kexec_buffer(void);
 #else
 static inline void ima_load_kexec_buffer(void) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index f799cc278a9a..f3b10851bbbf 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 /*
  * Restore the measurement list from the previous kernel.
  */
-void ima_load_kexec_buffer(void)
+void __init ima_load_kexec_buffer(void)
 {
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 96a92a645216..cfb500087692 100644
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
index 658eab05599e..27fd7744e0fc 100644
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
index e56d96d2b11c..1903c35d799e 100644
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
index dfe5a64e19d2..7af9fa133189 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -253,10 +253,14 @@ static int snd_pcm_ioctl_hw_params_compat(struct snd_pcm_substream *substream,
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
index 07efb38f58ac..f2940b29595f 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -37,6 +37,7 @@ struct seq_oss_midi {
 	struct snd_midi_event *coder;	/* MIDI event coder */
 	struct seq_oss_devinfo *devinfo;	/* assigned OSSseq device */
 	snd_use_lock_t use_lock;
+	struct mutex open_mutex;
 };
 
 
@@ -172,6 +173,7 @@ snd_seq_oss_midi_check_new_port(struct snd_seq_port_info *pinfo)
 	mdev->flags = pinfo->capability;
 	mdev->opened = 0;
 	snd_use_lock_init(&mdev->use_lock);
+	mutex_init(&mdev->open_mutex);
 
 	/* copy and truncate the name of synth device */
 	strscpy(mdev->name, pinfo->name, sizeof(mdev->name));
@@ -322,15 +324,17 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
 	int perm;
 	struct seq_oss_midi *mdev;
 	struct snd_seq_port_subscribe subs;
+	int err;
 
 	mdev = get_mididev(dp, dev);
 	if (!mdev)
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
@@ -340,14 +344,14 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
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
@@ -372,13 +376,17 @@ snd_seq_oss_midi_open(struct seq_oss_devinfo *dp, int dev, int fmode)
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
@@ -393,10 +401,9 @@ snd_seq_oss_midi_close(struct seq_oss_devinfo *dp, int dev)
 	mdev = get_mididev(dp, dev);
 	if (!mdev)
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
@@ -415,6 +422,8 @@ snd_seq_oss_midi_close(struct seq_oss_devinfo *dp, int dev)
 	mdev->opened = 0;
 	mdev->devinfo = NULL;
 
+ unlock:
+	mutex_unlock(&mdev->open_mutex);
 	snd_use_lock_free(&mdev->use_lock);
 	return 0;
 }
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 58ae0c3ce1e4..b81b3c1f7649 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2070,10 +2070,9 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
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
index 6b3d9c05eaf2..4cb0605f6daa 100644
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
index c3deb82c5da3..1750cc888bbe 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1383,6 +1383,7 @@ config SND_SOC_STA529
 config SND_SOC_STAC9766
 	tristate
 	depends on SND_SOC_AC97_BUS
+	select REGMAP_AC97
 
 config SND_SOC_STI_SAS
 	tristate "codec Audio support for STI SAS codec"
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 7998fdd3b378..7d18de959439 100644
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
index b36ccfc54cd6..93549f8ee130 100644
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
index f04e18c32489..9fdd9afe00da 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -786,8 +786,15 @@ static int __maybe_unused rt5682_dev_resume(struct device *dev)
 	if (!rt5682->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt5682->disable_irq == true) {
+			mutex_lock(&rt5682->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
+			rt5682->disable_irq = false;
+			mutex_unlock(&rt5682->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT5682_PROBE_TIMEOUT));
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index 31e77d462ef3..4faf6b8544dd 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -442,8 +442,16 @@ static int __maybe_unused rt711_sdca_dev_resume(struct device *dev)
 	if (!rt711->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt711->disable_irq == true) {
+			mutex_lock(&rt711->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK1, SDW_SCP_SDCA_INTMASK_SDCA_0);
+			sdw_write_no_pm(slave, SDW_SCP_SDCA_INTMASK2, SDW_SCP_SDCA_INTMASK_SDCA_8);
+			rt711->disable_irq = false;
+			mutex_unlock(&rt711->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT711_PROBE_TIMEOUT));
diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 4fe68bcf2a7c..9545b8a7eb19 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -541,8 +541,15 @@ static int __maybe_unused rt711_dev_resume(struct device *dev)
 	if (!rt711->first_hw_init)
 		return 0;
 
-	if (!slave->unattach_request)
+	if (!slave->unattach_request) {
+		if (rt711->disable_irq == true) {
+			mutex_lock(&rt711->disable_irq_lock);
+			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
+			rt711->disable_irq = false;
+			mutex_unlock(&rt711->disable_irq_lock);
+		}
 		goto regmap_sync;
+	}
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
 				msecs_to_jiffies(RT711_PROBE_TIMEOUT));
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
index a3ae9176a83e..6fdd401ec9c5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1743,6 +1743,7 @@ int cmd_top(int argc, const char **argv)
 	top.session = perf_session__new(NULL, NULL);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
+		top.session = NULL;
 		goto out_delete_evlist;
 	}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d9ea546850cd..6755370483b0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2287,7 +2287,7 @@ static void syscall__exit(struct syscall *sc)
 	if (!sc)
 		return;
 
-	free(sc->arg_fmt);
+	zfree(&sc->arg_fmt);
 }
 
 static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
@@ -3124,13 +3124,8 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		struct evsel_trace *et = evsel->priv;
-
-		if (!et || !evsel->tp_format || strcmp(evsel->tp_format->system, "syscalls"))
-			continue;
-
-		free(et->fmt);
-		free(et);
+		evsel_trace__delete(evsel->priv);
+		evsel->priv = NULL;
 	}
 }
 
@@ -4748,11 +4743,11 @@ static void trace__exit(struct trace *trace)
 	int i;
 
 	strlist__delete(trace->ev_qualifier);
-	free(trace->ev_qualifier_ids.entries);
+	zfree(&trace->ev_qualifier_ids.entries);
 	if (trace->syscalls.table) {
 		for (i = 0; i <= trace->sctbl->syscalls.max_id; i++)
 			syscall__exit(&trace->syscalls.table[i]);
-		free(trace->syscalls.table);
+		zfree(&trace->syscalls.table);
 	}
 	syscalltbl__delete(trace->sctbl);
 	zfree(&trace->perfconfig_events);
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/cache.json b/tools/perf/pmu-events/arch/powerpc/power10/cache.json
index 605be14f441c..9cb929bb64af 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/cache.json
@@ -17,7 +17,7 @@
   {
     "EventCode": "0x34056",
     "EventName": "PM_EXEC_STALL_LOAD_FINISH",
-    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was finishing a load after its data was reloaded from a data source beyond the local L1; cycles in which the LSU was processing an L1-hit; cycles in which the NTF instruction merged with another load in the LMQ; cycles in which the NTF instruction is waiting for a data reload for a load miss, but the data comes back with a non-NTF instruction."
+    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was finishing a load after its data was reloaded from a data source beyond the local L1; cycles in which the LSU was processing an L1-hit; cycles in which the next-to-finish (NTF) instruction merged with another load in the LMQ; cycles in which the NTF instruction is waiting for a data reload for a load miss, but the data comes back with a non-NTF instruction."
   },
   {
     "EventCode": "0x3006C",
@@ -27,7 +27,7 @@
   {
     "EventCode": "0x300F4",
     "EventName": "PM_RUN_INST_CMPL_CONC",
-    "BriefDescription": "PowerPC instructions completed by this thread when all threads in the core had the run-latch set."
+    "BriefDescription": "PowerPC instruction completed by this thread when all threads in the core had the run-latch set."
   },
   {
     "EventCode": "0x4C016",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/floating_point.json b/tools/perf/pmu-events/arch/powerpc/power10/floating_point.json
deleted file mode 100644
index 54acb55e2c8c..000000000000
--- a/tools/perf/pmu-events/arch/powerpc/power10/floating_point.json
+++ /dev/null
@@ -1,7 +0,0 @@
-[
-  {
-    "EventCode": "0x4016E",
-    "EventName": "PM_THRESH_NOT_MET",
-    "BriefDescription": "Threshold counter did not meet threshold."
-  }
-]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
index 558f9530f54e..61e9e0222c87 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
@@ -7,7 +7,7 @@
   {
     "EventCode": "0x10006",
     "EventName": "PM_DISP_STALL_HELD_OTHER_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch for any other reason."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch for any other reason."
   },
   {
     "EventCode": "0x10010",
@@ -32,12 +32,12 @@
   {
     "EventCode": "0x1D05E",
     "EventName": "PM_DISP_STALL_HELD_HALT_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch because of power management."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch because of power management."
   },
   {
     "EventCode": "0x1E050",
     "EventName": "PM_DISP_STALL_HELD_STF_MAPPER_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch because the STF mapper/SRB was full. Includes GPR (count, link, tar), VSR, VMR, FPR."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch because the STF mapper/SRB was full. Includes GPR (count, link, tar), VSR, VMR, FPR."
   },
   {
     "EventCode": "0x1F054",
@@ -67,7 +67,7 @@
   {
     "EventCode": "0x100F6",
     "EventName": "PM_IERAT_MISS",
-    "BriefDescription": "IERAT Reloaded to satisfy an IERAT miss. All page sizes are counted by this event."
+    "BriefDescription": "IERAT Reloaded to satisfy an IERAT miss. All page sizes are counted by this event. This event only counts instruction demand access."
   },
   {
     "EventCode": "0x100F8",
@@ -77,7 +77,7 @@
   {
     "EventCode": "0x20006",
     "EventName": "PM_DISP_STALL_HELD_ISSQ_FULL_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch due to Issue queue full. Includes issue queue and branch queue."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch due to Issue queue full. Includes issue queue and branch queue."
   },
   {
     "EventCode": "0x20114",
@@ -102,7 +102,7 @@
   {
     "EventCode": "0x2D01A",
     "EventName": "PM_DISP_STALL_IC_MISS",
-    "BriefDescription": "Cycles when dispatch was stalled for this thread due to an Icache Miss."
+    "BriefDescription": "Cycles when dispatch was stalled for this thread due to an instruction cache miss."
   },
   {
     "EventCode": "0x2E018",
@@ -112,7 +112,7 @@
   {
     "EventCode": "0x2E01A",
     "EventName": "PM_DISP_STALL_HELD_XVFC_MAPPER_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch because the XVFC mapper/SRB was full."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch because the XVFC mapper/SRB was full."
   },
   {
     "EventCode": "0x2C142",
@@ -137,7 +137,7 @@
   {
     "EventCode": "0x30004",
     "EventName": "PM_DISP_STALL_FLUSH",
-    "BriefDescription": "Cycles when dispatch was stalled because of a flush that happened to an instruction(s) that was not yet NTC. PM_EXEC_STALL_NTC_FLUSH only includes instructions that were flushed after becoming NTC."
+    "BriefDescription": "Cycles when dispatch was stalled because of a flush that happened to an instruction(s) that was not yet next-to-complete (NTC). PM_EXEC_STALL_NTC_FLUSH only includes instructions that were flushed after becoming NTC."
   },
   {
     "EventCode": "0x3000A",
@@ -157,7 +157,7 @@
   {
     "EventCode": "0x30018",
     "EventName": "PM_DISP_STALL_HELD_SCOREBOARD_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch while waiting on the Scoreboard. This event combines VSCR and FPSCR together."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch while waiting on the Scoreboard. This event combines VSCR and FPSCR together."
   },
   {
     "EventCode": "0x30026",
@@ -182,7 +182,7 @@
   {
     "EventCode": "0x3D05C",
     "EventName": "PM_DISP_STALL_HELD_RENAME_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch because the mapper/SRB was full. Includes GPR (count, link, tar), VSR, VMR, FPR and XVFC."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch because the mapper/SRB was full. Includes GPR (count, link, tar), VSR, VMR, FPR and XVFC."
   },
   {
     "EventCode": "0x3E052",
@@ -192,7 +192,7 @@
   {
     "EventCode": "0x3E054",
     "EventName": "PM_LD_MISS_L1",
-    "BriefDescription": "Load Missed L1, counted at execution time (can be greater than loads finished). LMQ merges are not included in this count. i.e. if a load instruction misses on an address that is already allocated on the LMQ, this event will not increment for that load). Note that this count is per slice, so if a load spans multiple slices this event will increment multiple times for a single load."
+    "BriefDescription": "Load missed L1, counted at finish time. LMQ merges are not included in this count. i.e. if a load instruction misses on an address that is already allocated on the LMQ, this event will not increment for that load). Note that this count is per slice, so if a load spans multiple slices this event will increment multiple times for a single load."
   },
   {
     "EventCode": "0x301EA",
@@ -202,7 +202,7 @@
   {
     "EventCode": "0x300FA",
     "EventName": "PM_INST_FROM_L3MISS",
-    "BriefDescription": "The processor's instruction cache was reloaded from a source other than the local core's L1, L2, or L3 due to a demand miss."
+    "BriefDescription": "The processor's instruction cache was reloaded from beyond the local core's L3 due to a demand miss."
   },
   {
     "EventCode": "0x40006",
@@ -232,16 +232,16 @@
   {
     "EventCode": "0x4E01A",
     "EventName": "PM_DISP_STALL_HELD_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch for any reason."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch for any reason."
   },
   {
     "EventCode": "0x4003C",
     "EventName": "PM_DISP_STALL_HELD_SYNC_CYC",
-    "BriefDescription": "Cycles in which the NTC instruction is held at dispatch because of a synchronizing instruction that requires the ICT to be empty before dispatch."
+    "BriefDescription": "Cycles in which the next-to-complete (NTC) instruction is held at dispatch because of a synchronizing instruction that requires the ICT to be empty before dispatch."
   },
   {
     "EventCode": "0x44056",
     "EventName": "PM_VECTOR_ST_CMPL",
-    "BriefDescription": "Vector store instructions completed."
+    "BriefDescription": "Vector store instruction completed."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/marked.json b/tools/perf/pmu-events/arch/powerpc/power10/marked.json
index 58b5dfe3a273..f2436fc5537c 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/marked.json
@@ -19,11 +19,6 @@
     "EventName": "PM_MRK_BR_TAKEN_CMPL",
     "BriefDescription": "Marked Branch Taken instruction completed."
   },
-  {
-    "EventCode": "0x20112",
-    "EventName": "PM_MRK_NTF_FIN",
-    "BriefDescription": "The marked instruction became the oldest in the pipeline before it finished. It excludes instructions that finish at dispatch."
-  },
   {
     "EventCode": "0x2C01C",
     "EventName": "PM_EXEC_STALL_DMISS_OFF_CHIP",
@@ -62,17 +57,12 @@
   {
     "EventCode": "0x200FD",
     "EventName": "PM_L1_ICACHE_MISS",
-    "BriefDescription": "Demand iCache Miss."
-  },
-  {
-    "EventCode": "0x30130",
-    "EventName": "PM_MRK_INST_FIN",
-    "BriefDescription": "marked instruction finished. Excludes instructions that finish at dispatch. Note that stores always finish twice since the address gets issued to the LSU and the data gets issued to the VSU."
+    "BriefDescription": "Demand instruction cache miss."
   },
   {
     "EventCode": "0x34146",
     "EventName": "PM_MRK_LD_CMPL",
-    "BriefDescription": "Marked loads completed."
+    "BriefDescription": "Marked load instruction completed."
   },
   {
     "EventCode": "0x3E158",
@@ -82,12 +72,12 @@
   {
     "EventCode": "0x3E15A",
     "EventName": "PM_MRK_ST_FIN",
-    "BriefDescription": "The marked instruction was a store of any kind."
+    "BriefDescription": "Marked store instruction finished."
   },
   {
     "EventCode": "0x30068",
     "EventName": "PM_L1_ICACHE_RELOADED_PREF",
-    "BriefDescription": "Counts all Icache prefetch reloads ( includes demand turned into prefetch)."
+    "BriefDescription": "Counts all instruction cache prefetch reloads (includes demand turned into prefetch)."
   },
   {
     "EventCode": "0x301E4",
@@ -102,12 +92,12 @@
   {
     "EventCode": "0x300FE",
     "EventName": "PM_DATA_FROM_L3MISS",
-    "BriefDescription": "The processor's data cache was reloaded from a source other than the local core's L1, L2, or L3 due to a demand miss."
+    "BriefDescription": "The processor's L1 data cache was reloaded from beyond the local core's L3 due to a demand miss."
   },
   {
     "EventCode": "0x40012",
     "EventName": "PM_L1_ICACHE_RELOADED_ALL",
-    "BriefDescription": "Counts all Icache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch."
+    "BriefDescription": "Counts all instruction cache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch."
   },
   {
     "EventCode": "0x40134",
@@ -117,22 +107,22 @@
   {
     "EventCode": "0x4505A",
     "EventName": "PM_SP_FLOP_CMPL",
-    "BriefDescription": "Single Precision floating point instructions completed."
+    "BriefDescription": "Single Precision floating point instruction completed."
   },
   {
     "EventCode": "0x4D058",
     "EventName": "PM_VECTOR_FLOP_CMPL",
-    "BriefDescription": "Vector floating point instructions completed."
+    "BriefDescription": "Vector floating point instruction completed."
   },
   {
     "EventCode": "0x4D05A",
     "EventName": "PM_NON_MATH_FLOP_CMPL",
-    "BriefDescription": "Non Math instructions completed."
+    "BriefDescription": "Non Math instruction completed."
   },
   {
     "EventCode": "0x401E0",
     "EventName": "PM_MRK_INST_CMPL",
-    "BriefDescription": "marked instruction completed."
+    "BriefDescription": "Marked instruction completed."
   },
   {
     "EventCode": "0x400FE",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/memory.json b/tools/perf/pmu-events/arch/powerpc/power10/memory.json
index 843b51f531e9..c4c10ca98cad 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/memory.json
@@ -47,7 +47,7 @@
   {
     "EventCode": "0x10062",
     "EventName": "PM_LD_L3MISS_PEND_CYC",
-    "BriefDescription": "Cycles L3 miss was pending for this thread."
+    "BriefDescription": "Cycles in which an L3 miss was pending for this thread."
   },
   {
     "EventCode": "0x20010",
@@ -132,7 +132,7 @@
   {
     "EventCode": "0x300FC",
     "EventName": "PM_DTLB_MISS",
-    "BriefDescription": "The DPTEG required for the load/store instruction in execution was missing from the TLB. It includes pages of all sizes for demand and prefetch activity."
+    "BriefDescription": "The DPTEG required for the load/store instruction in execution was missing from the TLB. This event only counts for demand misses."
   },
   {
     "EventCode": "0x4D02C",
@@ -142,7 +142,7 @@
   {
     "EventCode": "0x4003E",
     "EventName": "PM_LD_CMPL",
-    "BriefDescription": "Loads completed."
+    "BriefDescription": "Load instruction completed."
   },
   {
     "EventCode": "0x4C040",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/tools/perf/pmu-events/arch/powerpc/power10/others.json
index 7d0de1a2860b..36c5bbc64c3b 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
@@ -2,12 +2,12 @@
   {
     "EventCode": "0x10016",
     "EventName": "PM_VSU0_ISSUE",
-    "BriefDescription": "VSU instructions issued to VSU pipe 0."
+    "BriefDescription": "VSU instruction issued to VSU pipe 0."
   },
   {
     "EventCode": "0x1001C",
     "EventName": "PM_ULTRAVISOR_INST_CMPL",
-    "BriefDescription": "PowerPC instructions that completed while the thread was in ultravisor state."
+    "BriefDescription": "PowerPC instruction completed while the thread was in ultravisor state."
   },
   {
     "EventCode": "0x100F0",
@@ -17,23 +17,18 @@
   {
     "EventCode": "0x10134",
     "EventName": "PM_MRK_ST_DONE_L2",
-    "BriefDescription": "Marked stores completed in L2 (RC machine done)."
+    "BriefDescription": "Marked store completed in L2."
   },
   {
     "EventCode": "0x1505E",
     "EventName": "PM_LD_HIT_L1",
-    "BriefDescription": "Loads that finished without experiencing an L1 miss."
+    "BriefDescription": "Load finished without experiencing an L1 miss."
   },
   {
     "EventCode": "0x1F056",
     "EventName": "PM_DISP_SS0_2_INSTR_CYC",
     "BriefDescription": "Cycles in which Superslice 0 dispatches either 1 or 2 instructions."
   },
-  {
-    "EventCode": "0x1F15C",
-    "EventName": "PM_MRK_STCX_L2_CYC",
-    "BriefDescription": "Cycles spent in the nest portion of a marked Stcx instruction. It starts counting when the operation starts to drain to the L2 and it stops counting when the instruction retires from the Instruction Completion Table (ICT) in the Instruction Sequencing Unit (ISU)."
-  },
   {
     "EventCode": "0x10066",
     "EventName": "PM_ADJUNCT_CYC",
@@ -42,7 +37,7 @@
   {
     "EventCode": "0x101E4",
     "EventName": "PM_MRK_L1_ICACHE_MISS",
-    "BriefDescription": "Marked Instruction suffered an icache Miss."
+    "BriefDescription": "Marked instruction suffered an instruction cache miss."
   },
   {
     "EventCode": "0x101EA",
@@ -72,7 +67,7 @@
   {
     "EventCode": "0x2E010",
     "EventName": "PM_ADJUNCT_INST_CMPL",
-    "BriefDescription": "PowerPC instructions that completed while the thread is in Adjunct state."
+    "BriefDescription": "PowerPC instruction completed while the thread was in Adjunct state."
   },
   {
     "EventCode": "0x2E014",
@@ -122,7 +117,7 @@
   {
     "EventCode": "0x201E4",
     "EventName": "PM_MRK_DATA_FROM_L3MISS",
-    "BriefDescription": "The processor's data cache was reloaded from a source other than the local core's L1, L2, or L3 due to a demand miss for a marked load."
+    "BriefDescription": "The processor's L1 data cache was reloaded from beyond the local core's L3 due to a demand miss for a marked instruction."
   },
   {
     "EventCode": "0x201E8",
@@ -132,17 +127,17 @@
   {
     "EventCode": "0x200F2",
     "EventName": "PM_INST_DISP",
-    "BriefDescription": "PowerPC instructions dispatched."
+    "BriefDescription": "PowerPC instruction dispatched."
   },
   {
     "EventCode": "0x30132",
     "EventName": "PM_MRK_VSU_FIN",
-    "BriefDescription": "VSU marked instructions finished. Excludes simple FX instructions issued to the Store Unit."
+    "BriefDescription": "VSU marked instruction finished. Excludes simple FX instructions issued to the Store Unit."
   },
   {
     "EventCode": "0x30038",
     "EventName": "PM_EXEC_STALL_DMISS_LMEM",
-    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was waiting for a load miss to resolve from the local memory, local OpenCapp cache, or local OpenCapp memory."
+    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was waiting for a load miss to resolve from the local memory, local OpenCAPI cache, or local OpenCAPI memory."
   },
   {
     "EventCode": "0x3F04A",
@@ -152,12 +147,12 @@
   {
     "EventCode": "0x3405A",
     "EventName": "PM_PRIVILEGED_INST_CMPL",
-    "BriefDescription": "PowerPC Instructions that completed while the thread is in Privileged state."
+    "BriefDescription": "PowerPC instruction completed while the thread was in Privileged state."
   },
   {
     "EventCode": "0x3F150",
     "EventName": "PM_MRK_ST_DRAIN_CYC",
-    "BriefDescription": "cycles to drain st from core to L2."
+    "BriefDescription": "Cycles in which the marked store drained from the core to the L2."
   },
   {
     "EventCode": "0x3F054",
@@ -182,7 +177,7 @@
   {
     "EventCode": "0x4001C",
     "EventName": "PM_VSU_FIN",
-    "BriefDescription": "VSU instructions finished."
+    "BriefDescription": "VSU instruction finished."
   },
   {
     "EventCode": "0x4C01A",
@@ -197,7 +192,7 @@
   {
     "EventCode": "0x4D022",
     "EventName": "PM_HYPERVISOR_INST_CMPL",
-    "BriefDescription": "PowerPC instructions that completed while the thread is in hypervisor state."
+    "BriefDescription": "PowerPC instruction completed while the thread was in hypervisor state."
   },
   {
     "EventCode": "0x4D026",
@@ -212,32 +207,32 @@
   {
     "EventCode": "0x40030",
     "EventName": "PM_INST_FIN",
-    "BriefDescription": "Instructions finished."
+    "BriefDescription": "Instruction finished."
   },
   {
     "EventCode": "0x44146",
     "EventName": "PM_MRK_STCX_CORE_CYC",
-    "BriefDescription": "Cycles spent in the core portion of a marked Stcx instruction. It starts counting when the instruction is decoded and stops counting when it drains into the L2."
+    "BriefDescription": "Cycles spent in the core portion of a marked STCX instruction. It starts counting when the instruction is decoded and stops counting when it drains into the L2."
   },
   {
     "EventCode": "0x44054",
     "EventName": "PM_VECTOR_LD_CMPL",
-    "BriefDescription": "Vector load instructions completed."
+    "BriefDescription": "Vector load instruction completed."
   },
   {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
-    "BriefDescription": "Two floating point instructions completed (FMA class of instructions: fmadd, fnmadd, fmsub, fnmsub). Scalar instructions only."
+    "BriefDescription": "Two floating point instruction completed (FMA class of instructions: fmadd, fnmadd, fmsub, fnmsub). Scalar instructions only."
   },
   {
     "EventCode": "0x45056",
     "EventName": "PM_SCALAR_FLOP_CMPL",
-    "BriefDescription": "Scalar floating point instructions completed."
+    "BriefDescription": "Scalar floating point instruction completed."
   },
   {
     "EventCode": "0x4505C",
     "EventName": "PM_MATH_FLOP_CMPL",
-    "BriefDescription": "Math floating point instructions completed."
+    "BriefDescription": "Math floating point instruction completed."
   },
   {
     "EventCode": "0x4D05E",
@@ -252,21 +247,21 @@
   {
     "EventCode": "0x401E6",
     "EventName": "PM_MRK_INST_FROM_L3MISS",
-    "BriefDescription": "The processor's instruction cache was reloaded from a source other than the local core's L1, L2, or L3 due to a demand miss for a marked instruction."
+    "BriefDescription": "The processor's instruction cache was reloaded from beyond the local core's L3 due to a demand miss for a marked instruction."
   },
   {
     "EventCode": "0x401E8",
     "EventName": "PM_MRK_DATA_FROM_L2MISS",
-    "BriefDescription": "The processor's data cache was reloaded from a source other than the local core's L1 or L2 due to a demand miss for a marked load."
+    "BriefDescription": "The processor's L1 data cache was reloaded from a source beyond the local core's L2 due to a demand miss for a marked instruction."
   },
   {
     "EventCode": "0x400F0",
     "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
-    "BriefDescription": "Load Missed L1, counted at finish time."
+    "BriefDescription": "Load missed L1, counted at finish time."
   },
   {
     "EventCode": "0x400FA",
     "EventName": "PM_RUN_INST_CMPL",
-    "BriefDescription": "Completed PowerPC instructions gated by the run latch."
+    "BriefDescription": "PowerPC instruction completed while the run latch is set."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
index b8aded6045fa..799893c56f32 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
@@ -2,7 +2,7 @@
   {
     "EventCode": "0x100FE",
     "EventName": "PM_INST_CMPL",
-    "BriefDescription": "PowerPC instructions completed."
+    "BriefDescription": "PowerPC instruction completed."
   },
   {
     "EventCode": "0x1000C",
@@ -12,7 +12,7 @@
   {
     "EventCode": "0x1000E",
     "EventName": "PM_MMA_ISSUED",
-    "BriefDescription": "MMA instructions issued."
+    "BriefDescription": "MMA instruction issued."
   },
   {
     "EventCode": "0x10012",
@@ -107,7 +107,7 @@
   {
     "EventCode": "0x2D012",
     "EventName": "PM_VSU1_ISSUE",
-    "BriefDescription": "VSU instructions issued to VSU pipe 1."
+    "BriefDescription": "VSU instruction issued to VSU pipe 1."
   },
   {
     "EventCode": "0x2D018",
@@ -122,7 +122,7 @@
   {
     "EventCode": "0x2E01E",
     "EventName": "PM_EXEC_STALL_NTC_FLUSH",
-    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was executing in any unit before it was flushed. Note that if the flush of the oldest instruction happens after finish, the cycles from dispatch to issue will be included in PM_DISP_STALL and the cycles from issue to finish will be included in PM_EXEC_STALL and its corresponding children. This event will also count cycles when the previous NTF instruction is still completing and the new NTF instruction is stalled at dispatch."
+    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was executing in any unit before it was flushed. Note that if the flush of the oldest instruction happens after finish, the cycles from dispatch to issue will be included in PM_DISP_STALL and the cycles from issue to finish will be included in PM_EXEC_STALL and its corresponding children. This event will also count cycles when the previous next-to-finish (NTF) instruction is still completing and the new NTF instruction is stalled at dispatch."
   },
   {
     "EventCode": "0x2013C",
@@ -137,7 +137,7 @@
   {
     "EventCode": "0x201E2",
     "EventName": "PM_MRK_LD_MISS_L1",
-    "BriefDescription": "Marked DL1 Demand Miss counted at finish time."
+    "BriefDescription": "Marked demand data load miss counted at finish time."
   },
   {
     "EventCode": "0x200F4",
@@ -172,7 +172,7 @@
   {
     "EventCode": "0x30028",
     "EventName": "PM_CMPL_STALL_MEM_ECC",
-    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was waiting for the non-speculative finish of either a stcx waiting for its result or a load waiting for non-critical sectors of data and ECC."
+    "BriefDescription": "Cycles in which the oldest instruction in the pipeline was waiting for the non-speculative finish of either a STCX waiting for its result or a load waiting for non-critical sectors of data and ECC."
   },
   {
     "EventCode": "0x30036",
@@ -187,17 +187,12 @@
   {
     "EventCode": "0x3F044",
     "EventName": "PM_VSU2_ISSUE",
-    "BriefDescription": "VSU instructions issued to VSU pipe 2."
+    "BriefDescription": "VSU instruction issued to VSU pipe 2."
   },
   {
     "EventCode": "0x30058",
     "EventName": "PM_TLBIE_FIN",
-    "BriefDescription": "TLBIE instructions finished in the LSU. Two TLBIEs can finish each cycle. All will be counted."
-  },
-  {
-    "EventCode": "0x3D058",
-    "EventName": "PM_SCALAR_FSQRT_FDIV_ISSUE",
-    "BriefDescription": "Scalar versions of four floating point operations: fdiv,fsqrt (xvdivdp, xvdivsp, xvsqrtdp, xvsqrtsp)."
+    "BriefDescription": "TLBIE instruction finished in the LSU. Two TLBIEs can finish each cycle. All will be counted."
   },
   {
     "EventCode": "0x30066",
@@ -252,7 +247,7 @@
   {
     "EventCode": "0x4E012",
     "EventName": "PM_EXEC_STALL_UNKNOWN",
-    "BriefDescription": "Cycles in which the oldest instruction in the pipeline completed without an ntf_type pulse. The ntf_pulse was missed by the ISU because the NTF finishes and completions came too close together."
+    "BriefDescription": "Cycles in which the oldest instruction in the pipeline completed without an ntf_type pulse. The ntf_pulse was missed by the ISU because the next-to-finish (NTF) instruction finishes and completions came too close together."
   },
   {
     "EventCode": "0x4D020",
@@ -267,12 +262,7 @@
   {
     "EventCode": "0x45058",
     "EventName": "PM_IC_MISS_CMPL",
-    "BriefDescription": "Non-speculative icache miss, counted at completion."
-  },
-  {
-    "EventCode": "0x4D050",
-    "EventName": "PM_VSU_NON_FLOP_CMPL",
-    "BriefDescription": "Non-floating point VSU instructions completed."
+    "BriefDescription": "Non-speculative instruction cache miss, counted at completion."
   },
   {
     "EventCode": "0x4D052",
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
index b5d1bd39cfb2..364fedbfb490 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
@@ -12,11 +12,11 @@
   {
     "EventCode": "0x45052",
     "EventName": "PM_4FLOP_CMPL",
-    "BriefDescription": "Four floating point instructions completed (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg)."
+    "BriefDescription": "Four floating point instruction completed (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg)."
   },
   {
     "EventCode": "0x4D054",
     "EventName": "PM_8FLOP_CMPL",
-    "BriefDescription": "Four Double Precision vector instructions completed."
+    "BriefDescription": "Four Double Precision vector instruction completed."
   }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power10/translation.json b/tools/perf/pmu-events/arch/powerpc/power10/translation.json
index db3766dca07c..961e2491e73f 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/translation.json
@@ -4,11 +4,6 @@
     "EventName": "PM_MRK_START_PROBE_NOP_CMPL",
     "BriefDescription": "Marked Start probe nop (AND R0,R0,R0) completed."
   },
-  {
-    "EventCode": "0x20016",
-    "EventName": "PM_ST_FIN",
-    "BriefDescription": "Store finish count. Includes speculative activity."
-  },
   {
     "EventCode": "0x20018",
     "EventName": "PM_ST_FWD",
@@ -17,7 +12,7 @@
   {
     "EventCode": "0x2011C",
     "EventName": "PM_MRK_NTF_CYC",
-    "BriefDescription": "Cycles during which the marked instruction is the oldest in the pipeline (NTF or NTC)."
+    "BriefDescription": "Cycles in which the marked instruction is the oldest in the pipeline (next-to-finish or next-to-complete)."
   },
   {
     "EventCode": "0x2E01C",
@@ -37,7 +32,7 @@
   {
     "EventCode": "0x200FE",
     "EventName": "PM_DATA_FROM_L2MISS",
-    "BriefDescription": "The processor's data cache was reloaded from a source other than the local core's L1 or L2 due to a demand miss."
+    "BriefDescription": "The processor's L1 data cache was reloaded from a source beyond the local core's L2 due to a demand miss."
   },
   {
     "EventCode": "0x30010",
@@ -52,6 +47,6 @@
   {
     "EventCode": "0x4D05C",
     "EventName": "PM_DPP_FLOP_CMPL",
-    "BriefDescription": "Double-Precision or Quad-Precision instructions completed."
+    "BriefDescription": "Double-Precision or Quad-Precision instruction completed."
   }
 ]
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b72ee6822222..fd3e67d2c6bd 100644
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
@@ -732,8 +722,8 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
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
@@ -1779,7 +1769,7 @@ static void hists_browser__hierarchy_headers(struct hist_browser *browser)
 	hists_browser__scnprintf_hierarchy_headers(browser, headers,
 						   sizeof(headers));
 
-	ui_browser__gotorc(&browser->b, 0, 0);
+	ui_browser__gotorc_title(&browser->b, 0, 0);
 	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a5e87c7f4f4e..60b232eba5c8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1729,8 +1729,11 @@ static int symbol__disassemble_bpf(struct symbol *sym,
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
@@ -1778,7 +1781,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 #else
 	disassemble = disassembler(bfdf);
 #endif
-	assert(disassemble);
+	if (disassemble == NULL)
+		abort();
 
 	fflush(s);
 	do {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1c7414f66655..25947d013603 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4200,7 +4200,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
 {
-	u32 i, ids, n_ids;
+	u32 i, n_ids;
+	u64 *ids;
 	struct evsel *evsel;
 	struct evlist *evlist = *pevlist;
 
@@ -4216,9 +4217,8 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 
 	evlist__add(evlist, evsel);
 
-	ids = event->header.size;
-	ids -= (void *)&event->attr.id - (void *)event;
-	n_ids = ids / sizeof(u64);
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids = n_ids / sizeof(u64);
 	/*
 	 * We don't have the cpu and thread maps on the header, so
 	 * for allocating the perf_sample_id table we fake 1 cpu and
@@ -4227,8 +4227,9 @@ int perf_event__process_attr(struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
+	ids = (void *)&event->attr.attr + event->attr.attr.size;
 	for (i = 0; i < n_ids; i++) {
-		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, event->attr.id[i]);
+		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 56a4873a343c..c16e4da98825 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -52,6 +52,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += resctrl
 TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
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
diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 1f8f6daaf1e7..86ac205ea8e1 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -23,6 +23,7 @@
 
 static long timeout_ns = 100000;	/* 100us default timeout */
 static futex_t futex_pi;
+static pthread_barrier_t barrier;
 
 void usage(char *prog)
 {
@@ -47,6 +48,8 @@ void *get_pi_lock(void *arg)
 	if (ret != 0)
 		error("futex_lock_pi failed\n", ret);
 
+	pthread_barrier_wait(&barrier);
+
 	/* Blocks forever */
 	ret = futex_wait(&lock, 0, NULL, 0);
 	error("futex_wait failed\n", ret);
@@ -123,6 +126,7 @@ int main(int argc, char *argv[])
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
 
+	pthread_barrier_init(&barrier, NULL, 2);
 	pthread_create(&thread, NULL, get_pi_lock, NULL);
 
 	/* initialize relative timeout */
@@ -156,6 +160,9 @@ int main(int argc, char *argv[])
 	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
 	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
 
+	/* Wait until the other thread calls futex_lock_pi() */
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
 	/*
 	 * FUTEX_LOCK_PI with CLOCK_REALTIME
 	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index a9ba782d8ca0..83616f0779a7 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,7 +33,8 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" $1
+		/usr/bin/timeout --foreground "$kselftest_timeout" \
+			/usr/bin/timeout "$kselftest_timeout" $1
 	else
 		$1
 	fi
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 11779405dc80..a6ea2bd63a83 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -916,7 +916,11 @@ void __wait_for_test(struct __test_metadata *t)
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
@@ -928,11 +932,6 @@ void __wait_for_test(struct __test_metadata *t)
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
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 6bcee2ec91a9..9cc7e0108c8b 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,17 +1,8 @@
-CC = $(CROSS_COMPILE)gcc
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
-SRCS=$(wildcard *.c)
-OBJS=$(SRCS:.c=.o)
+CFLAGS += $(KHDR_INCLUDES)
 
-all: resctrl_tests
+TEST_GEN_PROGS := resctrl_tests
 
-$(OBJS): $(SRCS)
-	$(CC) $(CFLAGS) -c $(SRCS)
+include ../lib.mk
 
-resctrl_tests: $(OBJS)
-	$(CC) $(CFLAGS) -o $@ $^
-
-.PHONY: clean
-
-clean:
-	$(RM) $(OBJS) resctrl_tests
+$(OUTPUT)/resctrl_tests: $(wildcard *.[ch])
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 0485863a169f..338f71445393 100644
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
@@ -258,19 +256,25 @@ int cat_val(struct resctrl_val_param *param)
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
 
 /*
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
index f44fa2de4d98..dbe5cfb54558 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -43,6 +43,7 @@
 	do {					\
 		perror(err_msg);		\
 		kill(ppid, SIGKILL);		\
+		umount_resctrlfs();		\
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
