Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74445811E35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442117AbjLMTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjLMTIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:08:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB2139
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:08:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49246C433CC;
        Wed, 13 Dec 2023 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702494481;
        bh=nfpsWg+agJ6eCwqW9VsyTGYU5uIq3vgFSunW1btG7T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wIsumDxvd8943mb4TtKXlcFLQBajwWqQSVojajvchJtxLP4JMn+NqM1E8F3MybHsV
         TjCl5UdHOgZeZ1QR4o5Lueh4VO5zQEqY2cMK9oQ7Z9VdhNbNbgIe6nMhB48WaJF+le
         2wsiezbOPZybcFVhOtH1Ju/IFCJz9QB4Onx6C7ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.143
Date:   Wed, 13 Dec 2023 20:06:04 +0100
Message-ID: <2023121304-strongman-uneven-ce71@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121303-parameter-slapstick-7ab4@gregkh>
References: <2023121303-parameter-slapstick-7ab4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
index 0f58701367b6..af31e5a22d89 100644
--- a/Documentation/ABI/testing/sysfs-bus-optee-devices
+++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -6,3 +6,12 @@ Description:
 		OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
 		matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
 		are free to create needed API under optee-ta-<uuid> directory.
+
+What:		/sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
+Date:		November 2023
+KernelVersion:	6.7
+Contact:	op-tee@lists.trustedfirmware.org
+Description:
+		Allows to distinguish whether an OP-TEE based TA/device requires user-space
+		tee-supplicant to function properly or not. This attribute will be present for
+		devices which depend on tee-supplicant to be running.
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index e4beeca57e5f..12a4e7ebcbab 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -36,7 +36,7 @@ experience, the following books are good for, if anything, reference:
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
 
 The kernel is written using GNU C and the GNU toolchain.  While it
-adheres to the ISO C89 standard, it uses a number of extensions that are
+adheres to the ISO C11 standard, it uses a number of extensions that are
 not featured in the standard.  The kernel is a freestanding C
 environment, with no reliance on the standard C library, so some
 portions of the C standard are not supported.  Arbitrary long long
diff --git a/Documentation/translations/it_IT/process/howto.rst b/Documentation/translations/it_IT/process/howto.rst
index 9554368a2ae2..d02df35d0f6b 100644
--- a/Documentation/translations/it_IT/process/howto.rst
+++ b/Documentation/translations/it_IT/process/howto.rst
@@ -44,7 +44,7 @@ altro, utili riferimenti:
 - "C:  A Reference Manual" di Harbison and Steele [Prentice Hall]
 
 Il kernel è stato scritto usando GNU C e la toolchain GNU.
-Sebbene si attenga allo standard ISO C89, esso utilizza una serie di
+Sebbene si attenga allo standard ISO C11, esso utilizza una serie di
 estensioni che non sono previste in questo standard. Il kernel è un
 ambiente C indipendente, che non ha alcuna dipendenza dalle librerie
 C standard, così alcune parti del C standard non sono supportate.
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index d667f9d8a02a..6a00e43868a2 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -65,7 +65,7 @@ Linux カーネル開発のやり方
  - 『新・詳説 C 言語 H&S リファレンス』 (サミュエル P ハービソン/ガイ L スティール共著 斉藤 信男監訳)[ソフトバンク]
 
 カーネルは GNU C と GNU ツールチェインを使って書かれています。カーネル
-は ISO C89 仕様に準拠して書く一方で、標準には無い言語拡張を多く使って
+は ISO C11 仕様に準拠して書く一方で、標準には無い言語拡張を多く使って
 います。カーネルは標準 C ライブラリに依存しない、C 言語非依存環境です。
 そのため、C の標準の中で使えないものもあります。特に任意の long long
 の除算や浮動小数点は使えません。カーネルがツールチェインや C 言語拡張
diff --git a/Documentation/translations/ko_KR/howto.rst b/Documentation/translations/ko_KR/howto.rst
index e3cdf0c84892..a787d31dcdbf 100644
--- a/Documentation/translations/ko_KR/howto.rst
+++ b/Documentation/translations/ko_KR/howto.rst
@@ -62,7 +62,7 @@ Documentation/process/howto.rst
  - "Practical C Programming" by Steve Oualline [O'Reilly]
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
 
-커널은 GNU C와 GNU 툴체인을 사용하여 작성되었다. 이 툴들은 ISO C89 표준을
+커널은 GNU C와 GNU 툴체인을 사용하여 작성되었다. 이 툴들은 ISO C11 표준을
 따르는 반면 표준에 있지 않은 많은 확장기능도 가지고 있다. 커널은 표준 C
 라이브러리와는 관계없이 freestanding C 환경이어서 C 표준의 일부는
 지원되지 않는다. 임의의 long long 나누기나 floating point는 지원되지 않는다.
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index ee3dee476d57..2a910e3e904e 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -45,7 +45,7 @@ Linux内核大部分是由C语言写成的，一些体系结构相关的代码
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
    《C语言参考手册（原书第5版）》（邱仲潘 等译）[机械工业出版社]
 
-Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C89标准，但也用到了一些
+Linux内核使用GNU C和GNU工具链开发。虽然它遵循ISO C11标准，但也用到了一些
 标准中没有定义的扩展。内核是自给自足的C环境，不依赖于标准C库的支持，所以
 并不支持C标准中的部分定义。比如long long类型的大数除法和浮点运算就不允许
 使用。有时候确实很难弄清楚内核对工具链的要求和它所使用的扩展，不幸的是目
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index 2043691b92e3..ce14d4ed5c5b 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -48,7 +48,7 @@ Linux內核大部分是由C語言寫成的，一些體系結構相關的代碼
  - "C:  A Reference Manual" by Harbison and Steele [Prentice Hall]
    《C語言參考手冊（原書第5版）》（邱仲潘 等譯）[機械工業出版社]
 
-Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C89標準，但也用到了一些
+Linux內核使用GNU C和GNU工具鏈開發。雖然它遵循ISO C11標準，但也用到了一些
 標準中沒有定義的擴展。內核是自給自足的C環境，不依賴於標準C庫的支持，所以
 並不支持C標準中的部分定義。比如long long類型的大數除法和浮點運算就不允許
 使用。有時候確實很難弄清楚內核對工具鏈的要求和它所使用的擴展，不幸的是目
diff --git a/Makefile b/Makefile
index 678e712591f8..3e6550575904 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 142
+SUBLEVEL = 143
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/imx28-xea.dts b/arch/arm/boot/dts/imx28-xea.dts
index a400c108f66a..6c5e6856648a 100644
--- a/arch/arm/boot/dts/imx28-xea.dts
+++ b/arch/arm/boot/dts/imx28-xea.dts
@@ -8,6 +8,7 @@
 #include "imx28-lwe.dtsi"
 
 / {
+	model = "Liebherr XEA board";
 	compatible = "lwn,imx28-xea", "fsl,imx28";
 };
 
diff --git a/arch/arm/boot/dts/imx6ul-pico.dtsi b/arch/arm/boot/dts/imx6ul-pico.dtsi
index 357ffb2f5ad6..dd6790852b0d 100644
--- a/arch/arm/boot/dts/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/imx6ul-pico.dtsi
@@ -121,6 +121,8 @@ ethphy1: ethernet-phy@1 {
 			max-speed = <100>;
 			interrupt-parent = <&gpio5>;
 			interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index c978aab1d0e3..406e8870c680 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -438,7 +438,7 @@ iomuxc_lpsr: iomuxc-lpsr@302c0000 {
 			};
 
 			gpt1: timer@302d0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302d0000 0x10000>;
 				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT1_ROOT_CLK>,
@@ -447,7 +447,7 @@ gpt1: timer@302d0000 {
 			};
 
 			gpt2: timer@302e0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302e0000 0x10000>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT2_ROOT_CLK>,
@@ -457,7 +457,7 @@ gpt2: timer@302e0000 {
 			};
 
 			gpt3: timer@302f0000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x302f0000 0x10000>;
 				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT3_ROOT_CLK>,
@@ -467,7 +467,7 @@ gpt3: timer@302f0000 {
 			};
 
 			gpt4: timer@30300000 {
-				compatible = "fsl,imx7d-gpt", "fsl,imx6sx-gpt";
+				compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";
 				reg = <0x30300000 0x10000>;
 				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_GPT4_ROOT_CLK>,
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index b9efe9da06e0..3d76e8c28c51 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -502,6 +502,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 	name = devm_kasprintf(&pdev->dev,
 				GFP_KERNEL, "mmdc%d", ret);
+	if (!name) {
+		ret = -ENOMEM;
+		goto pmu_release_id;
+	}
 
 	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
 	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
@@ -524,9 +528,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
 
 pmu_register_err:
 	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
-	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 	cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, &pmu_mmdc->node);
 	hrtimer_cancel(&pmu_mmdc->hrtimer);
+pmu_release_id:
+	ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
 pmu_free:
 	kfree(pmu_mmdc);
 	return ret;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ab670b5d641b..4e8cde8972e8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -913,6 +913,7 @@ usb_dwc3_0: usb@38100000 {
 				phys = <&usb3_phy0>, <&usb3_phy0>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,gfladj-refclk-lpm-sel-quirk;
+				snps,parkmode-disable-ss-quirk;
 			};
 
 		};
@@ -954,6 +955,7 @@ usb_dwc3_1: usb@38200000 {
 				phys = <&usb3_phy1>, <&usb3_phy1>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,gfladj-refclk-lpm-sel-quirk;
+				snps,parkmode-disable-ss-quirk;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 2a698c5b87bc..e41e1c553bd3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1382,7 +1382,7 @@ usb_dwc3_0: usb@38100000 {
 			phys = <&usb3_phy0>, <&usb3_phy0>;
 			phy-names = "usb2-phy", "usb3-phy";
 			power-domains = <&pgc_otg1>;
-			usb3-resume-missing-cas;
+			snps,parkmode-disable-ss-quirk;
 			status = "disabled";
 		};
 
@@ -1414,7 +1414,7 @@ usb_dwc3_1: usb@38200000 {
 			phys = <&usb3_phy1>, <&usb3_phy1>;
 			phy-names = "usb2-phy", "usb3-phy";
 			power-domains = <&pgc_otg2>;
-			usb3-resume-missing-cas;
+			snps,parkmode-disable-ss-quirk;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 6b99d903b479..cdbd70bf5dd9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -69,7 +69,7 @@ red {
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index f2dc850010f1..ee454a26b459 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -55,7 +55,7 @@ wps {
 		};
 	};
 
-	memory {
+	memory@40000000 {
 		reg = <0 0x40000000 0 0x20000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 4fa1e93302c7..4e0c3aa264a5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -43,7 +43,7 @@ extcon_usb: extcon_iddig {
 		id-gpio = <&pio 16 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb_p1_vbus: regulator@0 {
+	usb_p1_vbus: regulator-usb-p1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -52,7 +52,7 @@ usb_p1_vbus: regulator@0 {
 		enable-active-high;
 	};
 
-	usb_p0_vbus: regulator@1 {
+	usb_p0_vbus: regulator-usb-p0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbus";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d9e005ae5bb0..c71a5155702d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -273,7 +273,7 @@ cpum_ck: oscillator2 {
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu_thermal {
+		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <1000>; /* milliseconds */
 			polling-delay = <1000>; /* milliseconds */
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 7bc0a6a7fadf..69aee79d36d4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -30,7 +30,7 @@ reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: memory@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
@@ -131,8 +131,8 @@ &mmc1 {
 };
 
 &pio {
-	i2c_pins_0: i2c0{
-		pins_i2c{
+	i2c_pins_0: i2c0 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -140,8 +140,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_1: i2c1{
-		pins_i2c{
+	i2c_pins_1: i2c1 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -149,8 +149,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_2: i2c2{
-		pins_i2c{
+	i2c_pins_2: i2c2 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
@@ -158,8 +158,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_3: i2c3{
-		pins_i2c{
+	i2c_pins_3: i2c3 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -167,8 +167,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_4: i2c4{
-		pins_i2c{
+	i2c_pins_4: i2c4 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
@@ -176,8 +176,8 @@ pins_i2c{
 		};
 	};
 
-	i2c_pins_5: i2c5{
-		pins_i2c{
+	i2c_pins_5: i2c5 {
+		pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
@@ -185,8 +185,8 @@ pins_i2c{
 		};
 	};
 
-	spi_pins_0: spi0{
-		pins_spi{
+	spi_pins_0: spi0 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_SPI0_CSB>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -300,8 +300,8 @@ pins_clk {
 		};
 	};
 
-	spi_pins_1: spi1{
-		pins_spi{
+	spi_pins_1: spi1 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -310,8 +310,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_2: spi2{
-		pins_spi{
+	spi_pins_2: spi2 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>,
@@ -320,8 +320,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_3: spi3{
-		pins_spi{
+	spi_pins_3: spi3 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -330,8 +330,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_4: spi4{
-		pins_spi{
+	spi_pins_4: spi4 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -340,8 +340,8 @@ pins_spi{
 		};
 	};
 
-	spi_pins_5: spi5{
-		pins_spi{
+	spi_pins_5: spi5 {
+		pins_spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index d8826c82bcda..c1153580ef95 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -102,6 +102,8 @@ cros_ec_pwm: ec-pwm {
 
 &dsi0 {
 	status = "okay";
+	/delete-property/#size-cells;
+	/delete-property/#address-cells;
 	/delete-node/panel@0;
 	ports {
 		port {
@@ -438,20 +440,20 @@ pins2 {
 	};
 
 	touchscreen_pins: touchscreen-pins {
-		touch_int_odl {
+		touch-int-odl {
 			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
 			input-enable;
 			bias-pull-up;
 		};
 
-		touch_rst_l {
+		touch-rst-l {
 			pinmux = <PINMUX_GPIO156__FUNC_GPIO156>;
 			output-high;
 		};
 	};
 
 	trackpad_pins: trackpad-pins {
-		trackpad_int {
+		trackpad-int {
 			pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
 			input-enable;
 			bias-disable; /* pulled externally */
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6529962edd4e..6b7a42c5d515 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -108,7 +108,7 @@ reserved_memory: reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		scp_mem_reserved: scp_mem_region {
+		scp_mem_reserved: memory@50000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x50000000 0 0x2900000>;
 			no-map;
@@ -407,13 +407,13 @@ &mt6358_vsim2_reg {
 
 &pio {
 	bt_pins: bt-pins {
-		pins_bt_en {
+		pins-bt-en {
 			pinmux = <PINMUX_GPIO120__FUNC_GPIO120>;
 			output-low;
 		};
 	};
 
-	ec_ap_int_odl: ec_ap_int_odl {
+	ec_ap_int_odl: ec-ap-int-odl {
 		pins1 {
 			pinmux = <PINMUX_GPIO151__FUNC_GPIO151>;
 			input-enable;
@@ -421,7 +421,7 @@ pins1 {
 		};
 	};
 
-	h1_int_od_l: h1_int_od_l {
+	h1_int_od_l: h1-int-od-l {
 		pins1 {
 			pinmux = <PINMUX_GPIO153__FUNC_GPIO153>;
 			input-enable;
@@ -429,7 +429,7 @@ pins1 {
 	};
 
 	i2c0_pins: i2c0 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -438,7 +438,7 @@ pins_bus {
 	};
 
 	i2c1_pins: i2c1 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -447,7 +447,7 @@ pins_bus {
 	};
 
 	i2c2_pins: i2c2 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			bias-disable;
@@ -456,7 +456,7 @@ pins_bus {
 	};
 
 	i2c3_pins: i2c3 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -465,7 +465,7 @@ pins_bus {
 	};
 
 	i2c4_pins: i2c4 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			bias-disable;
@@ -474,7 +474,7 @@ pins_bus {
 	};
 
 	i2c5_pins: i2c5 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
@@ -483,7 +483,7 @@ pins_bus {
 	};
 
 	i2c6_pins: i2c6 {
-		pins_bus {
+		pins-bus {
 			pinmux = <PINMUX_GPIO11__FUNC_SCL6>,
 				 <PINMUX_GPIO12__FUNC_SDA6>;
 			bias-disable;
@@ -491,7 +491,7 @@ pins_bus {
 	};
 
 	mmc0_pins_default: mmc0-pins-default {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
 				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
@@ -506,13 +506,13 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <01>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_rst {
+		pins-rst {
 			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <01>;
@@ -520,7 +520,7 @@ pins_rst {
 	};
 
 	mmc0_pins_uhs: mmc0-pins-uhs {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_DAT0>,
 				 <PINMUX_GPIO128__FUNC_MSDC0_DAT1>,
 				 <PINMUX_GPIO125__FUNC_MSDC0_DAT2>,
@@ -535,19 +535,19 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <01>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_ds {
+		pins-ds {
 			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-down-adv = <10>;
 		};
 
-		pins_rst {
+		pins-rst {
 			pinmux = <PINMUX_GPIO133__FUNC_MSDC0_RSTB>;
 			drive-strength = <MTK_DRIVE_14mA>;
 			mediatek,pull-up-adv = <01>;
@@ -555,7 +555,7 @@ pins_rst {
 	};
 
 	mmc1_pins_default: mmc1-pins-default {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
@@ -565,7 +565,7 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <10>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			input-enable;
 			mediatek,pull-down-adv = <10>;
@@ -573,7 +573,7 @@ pins_clk {
 	};
 
 	mmc1_pins_uhs: mmc1-pins-uhs {
-		pins_cmd_dat {
+		pins-cmd-dat {
 			pinmux = <PINMUX_GPIO31__FUNC_MSDC1_CMD>,
 				 <PINMUX_GPIO32__FUNC_MSDC1_DAT0>,
 				 <PINMUX_GPIO34__FUNC_MSDC1_DAT1>,
@@ -584,7 +584,7 @@ pins_cmd_dat {
 			mediatek,pull-up-adv = <10>;
 		};
 
-		pins_clk {
+		pins-clk {
 			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
 			drive-strength = <MTK_DRIVE_8mA>;
 			mediatek,pull-down-adv = <10>;
@@ -592,15 +592,15 @@ pins_clk {
 		};
 	};
 
-	panel_pins_default: panel_pins_default {
-		panel_reset {
+	panel_pins_default: panel-pins-default {
+		panel-reset {
 			pinmux = <PINMUX_GPIO45__FUNC_GPIO45>;
 			output-low;
 			bias-pull-up;
 		};
 	};
 
-	pwm0_pin_default: pwm0_pin_default {
+	pwm0_pin_default: pwm0-pin-default {
 		pins1 {
 			pinmux = <PINMUX_GPIO176__FUNC_GPIO176>;
 			output-high;
@@ -612,14 +612,14 @@ pins2 {
 	};
 
 	scp_pins: scp {
-		pins_scp_uart {
+		pins-scp-uart {
 			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
 				 <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
 		};
 	};
 
 	spi0_pins: spi0 {
-		pins_spi{
+		pins-spi {
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
 				 <PINMUX_GPIO86__FUNC_GPIO86>,
 				 <PINMUX_GPIO87__FUNC_SPI0_MO>,
@@ -629,7 +629,7 @@ pins_spi{
 	};
 
 	spi1_pins: spi1 {
-		pins_spi{
+		pins-spi {
 			pinmux = <PINMUX_GPIO161__FUNC_SPI1_A_MI>,
 				 <PINMUX_GPIO162__FUNC_SPI1_A_CSB>,
 				 <PINMUX_GPIO163__FUNC_SPI1_A_MO>,
@@ -639,20 +639,20 @@ pins_spi{
 	};
 
 	spi2_pins: spi2 {
-		pins_spi{
+		pins-spi {
 			pinmux = <PINMUX_GPIO0__FUNC_SPI2_CSB>,
 				 <PINMUX_GPIO1__FUNC_SPI2_MO>,
 				 <PINMUX_GPIO2__FUNC_SPI2_CLK>;
 			bias-disable;
 		};
-		pins_spi_mi {
+		pins-spi-mi {
 			pinmux = <PINMUX_GPIO94__FUNC_SPI2_MI>;
 			mediatek,pull-down-adv = <00>;
 		};
 	};
 
 	spi3_pins: spi3 {
-		pins_spi{
+		pins-spi {
 			pinmux = <PINMUX_GPIO21__FUNC_SPI3_MI>,
 				 <PINMUX_GPIO22__FUNC_SPI3_CSB>,
 				 <PINMUX_GPIO23__FUNC_SPI3_MO>,
@@ -662,7 +662,7 @@ pins_spi{
 	};
 
 	spi4_pins: spi4 {
-		pins_spi{
+		pins-spi {
 			pinmux = <PINMUX_GPIO17__FUNC_SPI4_MI>,
 				 <PINMUX_GPIO18__FUNC_SPI4_CSB>,
 				 <PINMUX_GPIO19__FUNC_SPI4_MO>,
@@ -672,7 +672,7 @@ pins_spi{
 	};
 
 	spi5_pins: spi5 {
-		pins_spi{
+		pins-spi {
 			pinmux = <PINMUX_GPIO13__FUNC_SPI5_MI>,
 				 <PINMUX_GPIO14__FUNC_SPI5_CSB>,
 				 <PINMUX_GPIO15__FUNC_SPI5_MO>,
@@ -682,63 +682,63 @@ pins_spi{
 	};
 
 	uart0_pins_default: uart0-pins-default {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO95__FUNC_URXD0>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO96__FUNC_UTXD0>;
 		};
 	};
 
 	uart1_pins_default: uart1-pins-default {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO121__FUNC_URXD1>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO115__FUNC_UTXD1>;
 		};
-		pins_rts {
+		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
 			output-enable;
 		};
-		pins_cts {
+		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
 			input-enable;
 		};
 	};
 
 	uart1_pins_sleep: uart1-pins-sleep {
-		pins_rx {
+		pins-rx {
 			pinmux = <PINMUX_GPIO121__FUNC_GPIO121>;
 			input-enable;
 			bias-pull-up;
 		};
-		pins_tx {
+		pins-tx {
 			pinmux = <PINMUX_GPIO115__FUNC_UTXD1>;
 		};
-		pins_rts {
+		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
 			output-enable;
 		};
-		pins_cts {
+		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
 			input-enable;
 		};
 	};
 
 	wifi_pins_pwrseq: wifi-pins-pwrseq {
-		pins_wifi_enable {
+		pins-wifi-enable {
 			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
 			output-low;
 		};
 	};
 
 	wifi_pins_wakeup: wifi-pins-wakeup {
-		pins_wifi_wakeup {
+		pins-wifi-wakeup {
 			pinmux = <PINMUX_GPIO113__FUNC_GPIO113>;
 			input-enable;
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index ee912825cfc6..b7f3c266d3dd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -165,7 +165,7 @@ &mmc1 {
 
 &pio {
 	i2c_pins_0: i2c0 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO82__FUNC_SDA0>,
 				 <PINMUX_GPIO83__FUNC_SCL0>;
 			mediatek,pull-up-adv = <3>;
@@ -174,7 +174,7 @@ pins_i2c{
 	};
 
 	i2c_pins_1: i2c1 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO81__FUNC_SDA1>,
 				 <PINMUX_GPIO84__FUNC_SCL1>;
 			mediatek,pull-up-adv = <3>;
@@ -183,7 +183,7 @@ pins_i2c{
 	};
 
 	i2c_pins_2: i2c2 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO103__FUNC_SCL2>,
 				 <PINMUX_GPIO104__FUNC_SDA2>;
 			mediatek,pull-up-adv = <3>;
@@ -192,7 +192,7 @@ pins_i2c{
 	};
 
 	i2c_pins_3: i2c3 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
 				 <PINMUX_GPIO51__FUNC_SDA3>;
 			mediatek,pull-up-adv = <3>;
@@ -201,7 +201,7 @@ pins_i2c{
 	};
 
 	i2c_pins_4: i2c4 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO105__FUNC_SCL4>,
 				 <PINMUX_GPIO106__FUNC_SDA4>;
 			mediatek,pull-up-adv = <3>;
@@ -210,7 +210,7 @@ pins_i2c{
 	};
 
 	i2c_pins_5: i2c5 {
-		pins_i2c{
+		pins_i2c {
 			pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
 				 <PINMUX_GPIO49__FUNC_SDA5>;
 			mediatek,pull-up-adv = <3>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 81fde34ffd52..2d33f4a583b4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -766,127 +766,6 @@ thermal: thermal@1100b000 {
 			nvmem-cell-names = "calibration-data";
 		};
 
-		thermal_zones: thermal-zones {
-			cpu_thermal: cpu_thermal {
-				polling-delay-passive = <100>;
-				polling-delay = <500>;
-				thermal-sensors = <&thermal 0>;
-				sustainable-power = <5000>;
-
-				trips {
-					threshold: trip-point0 {
-						temperature = <68000>;
-						hysteresis = <2000>;
-						type = "passive";
-					};
-
-					target: trip-point1 {
-						temperature = <80000>;
-						hysteresis = <2000>;
-						type = "passive";
-					};
-
-					cpu_crit: cpu-crit {
-						temperature = <115000>;
-						hysteresis = <2000>;
-						type = "critical";
-					};
-				};
-
-				cooling-maps {
-					map0 {
-						trip = <&target>;
-						cooling-device = <&cpu0
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu1
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu2
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu3
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-						contribution = <3072>;
-					};
-					map1 {
-						trip = <&target>;
-						cooling-device = <&cpu4
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu5
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu6
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>,
-								 <&cpu7
-							THERMAL_NO_LIMIT
-							THERMAL_NO_LIMIT>;
-						contribution = <1024>;
-					};
-				};
-			};
-
-			/* The tzts1 ~ tzts6 don't need to polling */
-			/* The tzts1 ~ tzts6 don't need to thermal throttle */
-
-			tzts1: tzts1 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 1>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts2: tzts2 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 2>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts3: tzts3 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 3>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts4: tzts4 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 4>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts5: tzts5 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 5>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tztsABB: tztsABB {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 6>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-		};
-
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -1495,4 +1374,125 @@ larb3: larb@1a002000 {
 			power-domains = <&spm MT8183_POWER_DOMAIN_CAM>;
 		};
 	};
+
+	thermal_zones: thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <500>;
+			thermal-sensors = <&thermal 0>;
+			sustainable-power = <5000>;
+
+			trips {
+				threshold: trip-point0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: trip-point1 {
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu-crit {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu1
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu2
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu3
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <3072>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&cpu4
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu5
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu6
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu7
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+
+		/* The tzts1 ~ tzts6 don't need to polling */
+		/* The tzts1 ~ tzts6 don't need to thermal throttle */
+
+		tzts1: tzts1 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 1>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts2: tzts2 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 2>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts3: tzts3 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 3>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts4: tzts4 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 4>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tzts5: tzts5 {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 5>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+
+		tztsABB: tztsABB {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 6>;
+			sustainable-power = <5000>;
+			trips {};
+			cooling-maps {};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4255e2d7a72f..9e33f0e6ed50 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -993,7 +993,9 @@ power-domain@RK3399_PD_VCODEC {
 			power-domain@RK3399_PD_VDU {
 				reg = <RK3399_PD_VDU>;
 				clocks = <&cru ACLK_VDU>,
-					 <&cru HCLK_VDU>;
+					 <&cru HCLK_VDU>,
+					 <&cru SCLK_VDU_CA>,
+					 <&cru SCLK_VDU_CORE>;
 				pm_qos = <&qos_video_m1_r>,
 					 <&qos_video_m1_w>;
 				#power-domain-cells = <0>;
@@ -1260,7 +1262,7 @@ vpu_mmu: iommu@ff650800 {
 
 	vdec: video-codec@ff660000 {
 		compatible = "rockchip,rk3399-vdec";
-		reg = <0x0 0xff660000 0x0 0x400>;
+		reg = <0x0 0xff660000 0x0 0x480>;
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
 			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 13b09c7516e9..b2869b606fd8 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -480,6 +480,7 @@ config MACH_LOONGSON2EF
 
 config MACH_LOONGSON64
 	bool "Loongson 64-bit family of machines"
+	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
@@ -1379,6 +1380,7 @@ config CPU_LOONGSON64
 	select CPU_SUPPORTS_MSA
 	select CPU_DIEI_BROKEN if !LOONGSON3_ENHANCEMENT
 	select CPU_MIPSR2_IRQ_VI
+	select DMA_NONCOHERENT
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_ASID_BITS_VARIABLE
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index 035b1a69e2d0..c454ef734c45 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -117,7 +117,8 @@ struct irq_source_routing_table {
 	u64 pci_io_start_addr;
 	u64 pci_io_end_addr;
 	u64 pci_config_addr;
-	u32 dma_mask_bits;
+	u16 dma_mask_bits;
+	u16 dma_noncoherent;
 } __packed;
 
 struct interface_info {
diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index c961e2999f15..ef3750a6ffac 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -13,6 +13,8 @@
  * Copyright (C) 2009 Lemote Inc.
  * Author: Wu Zhangjin, wuzhangjin@gmail.com
  */
+
+#include <linux/dma-map-ops.h>
 #include <linux/export.h>
 #include <linux/pci_ids.h>
 #include <asm/bootinfo.h>
@@ -147,8 +149,14 @@ void __init prom_lefi_init_env(void)
 
 	loongson_sysconf.dma_mask_bits = eirq_source->dma_mask_bits;
 	if (loongson_sysconf.dma_mask_bits < 32 ||
-		loongson_sysconf.dma_mask_bits > 64)
+			loongson_sysconf.dma_mask_bits > 64) {
 		loongson_sysconf.dma_mask_bits = 32;
+		dma_default_coherent = true;
+	} else {
+		dma_default_coherent = !eirq_source->dma_noncoherent;
+	}
+
+	pr_info("Firmware: Coherent DMA: %s\n", dma_default_coherent ? "on" : "off");
 
 	loongson_sysconf.restart_addr = boot_p->reset_system.ResetWarm;
 	loongson_sysconf.poweroff_addr = boot_p->reset_system.Shutdown;
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index 76e0a9636a0e..c1498fdd5c79 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -86,6 +86,11 @@ void __init szmem(unsigned int node)
 			break;
 		}
 	}
+
+	/* Reserve vgabios if it comes from firmware */
+	if (loongson_sysconf.vgabios_addr)
+		memblock_reserve(virt_to_phys((void *)loongson_sysconf.vgabios_addr),
+				SZ_256K);
 }
 
 #ifndef CONFIG_NUMA
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 46c4dafe3ba0..b246c3dc6993 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -344,16 +344,14 @@ int handle_misaligned_store(struct pt_regs *regs)
 	} else if ((insn & INSN_MASK_C_SD) == INSN_MATCH_C_SD) {
 		len = 8;
 		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+	} else if ((insn & INSN_MASK_C_SDSP) == INSN_MATCH_C_SDSP) {
 		len = 8;
 		val.data_ulong = GET_RS2C(insn, regs);
 #endif
 	} else if ((insn & INSN_MASK_C_SW) == INSN_MATCH_C_SW) {
 		len = 4;
 		val.data_ulong = GET_RS2S(insn, regs);
-	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP &&
-		   ((insn >> SH_RD) & 0x1f)) {
+	} else if ((insn & INSN_MASK_C_SWSP) == INSN_MATCH_C_SWSP) {
 		len = 4;
 		val.data_ulong = GET_RS2C(insn, regs);
 	} else {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index df0adb7e2fe8..c5ea4dedc1e1 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -731,7 +731,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
-		pgste_val(pgste) &= ~_PGSTE_GPS_USAGE_MASK;
+		pgste_val(pgste) &= ~(_PGSTE_GPS_USAGE_MASK | _PGSTE_GPS_NODAT);
 	pgste_set_unlock(ptep, pgste);
 	preempt_enable();
 }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 39f038956108..dba7fe7ecea9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1316,6 +1316,9 @@ static void zenbleed_check_cpu(void *unused)
 
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8e9a6c41f9ee..059d9c255e01 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1750,15 +1750,17 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	bool old_paging = is_paging(vcpu);
 
 #ifdef CONFIG_X86_64
-	if (vcpu->arch.efer & EFER_LME && !vcpu->arch.guest_state_protected) {
+	if (vcpu->arch.efer & EFER_LME) {
 		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
 			vcpu->arch.efer |= EFER_LMA;
-			svm->vmcb->save.efer |= EFER_LMA | EFER_LME;
+			if (!vcpu->arch.guest_state_protected)
+				svm->vmcb->save.efer |= EFER_LMA | EFER_LME;
 		}
 
 		if (is_paging(vcpu) && !(cr0 & X86_CR0_PG)) {
 			vcpu->arch.efer &= ~EFER_LMA;
-			svm->vmcb->save.efer &= ~(EFER_LMA | EFER_LME);
+			if (!vcpu->arch.guest_state_protected)
+				svm->vmcb->save.efer &= ~(EFER_LMA | EFER_LME);
 		}
 	}
 #endif
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cbbed43baf05..b63322e7e101 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4620,6 +4620,7 @@ static void binder_release_work(struct binder_proc *proc,
 				"undelivered TRANSACTION_ERROR: %u\n",
 				e->cmd);
 		} break;
+		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT:
 		case BINDER_WORK_TRANSACTION_COMPLETE: {
 			binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
 				"undelivered TRANSACTION_COMPLETE\n");
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f4d794d6bb85..f3bd9f104bd1 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -25,6 +25,47 @@ struct devcd_entry {
 	struct device devcd_dev;
 	void *data;
 	size_t datalen;
+	/*
+	 * Here, mutex is required to serialize the calls to del_wk work between
+	 * user/kernel space which happens when devcd is added with device_add()
+	 * and that sends uevent to user space. User space reads the uevents,
+	 * and calls to devcd_data_write() which try to modify the work which is
+	 * not even initialized/queued from devcoredump.
+	 *
+	 *
+	 *
+	 *        cpu0(X)                                 cpu1(Y)
+	 *
+	 *        dev_coredump() uevent sent to user space
+	 *        device_add()  ======================> user space process Y reads the
+	 *                                              uevents writes to devcd fd
+	 *                                              which results into writes to
+	 *
+	 *                                             devcd_data_write()
+	 *                                               mod_delayed_work()
+	 *                                                 try_to_grab_pending()
+	 *                                                   del_timer()
+	 *                                                     debug_assert_init()
+	 *       INIT_DELAYED_WORK()
+	 *       schedule_delayed_work()
+	 *
+	 *
+	 * Also, mutex alone would not be enough to avoid scheduling of
+	 * del_wk work after it get flush from a call to devcd_free()
+	 * mentioned as below.
+	 *
+	 *	disabled_store()
+	 *        devcd_free()
+	 *          mutex_lock()             devcd_data_write()
+	 *          flush_delayed_work()
+	 *          mutex_unlock()
+	 *                                   mutex_lock()
+	 *                                   mod_delayed_work()
+	 *                                   mutex_unlock()
+	 * So, delete_work flag is required.
+	 */
+	struct mutex mutex;
+	bool delete_work;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
@@ -84,7 +125,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work) {
+		devcd->delete_work = true;
+		mod_delayed_work(system_wq, &devcd->del_wk, 0);
+	}
+	mutex_unlock(&devcd->mutex);
 
 	return count;
 }
@@ -112,7 +158,12 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	mutex_lock(&devcd->mutex);
+	if (!devcd->delete_work)
+		devcd->delete_work = true;
+
 	flush_delayed_work(&devcd->del_wk);
+	mutex_unlock(&devcd->mutex);
 	return 0;
 }
 
@@ -122,6 +173,30 @@ static ssize_t disabled_show(struct class *class, struct class_attribute *attr,
 	return sysfs_emit(buf, "%d\n", devcd_disabled);
 }
 
+/*
+ *
+ *	disabled_store()                                	worker()
+ *	 class_for_each_device(&devcd_class,
+ *		NULL, NULL, devcd_free)
+ *         ...
+ *         ...
+ *	   while ((dev = class_dev_iter_next(&iter))
+ *                                                             devcd_del()
+ *                                                               device_del()
+ *                                                                 put_device() <- last reference
+ *             error = fn(dev, data)                           devcd_dev_release()
+ *             devcd_free(dev, data)                           kfree(devcd)
+ *             mutex_lock(&devcd->mutex);
+ *
+ *
+ * In the above diagram, It looks like disabled_store() would be racing with parallely
+ * running devcd_del() and result in memory abort while acquiring devcd->mutex which
+ * is called after kfree of devcd memory  after dropping its last reference with
+ * put_device(). However, this will not happens as fn(dev, data) runs
+ * with its own reference to device via klist_node so it is not its last reference.
+ * so, above situation would not occur.
+ */
+
 static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -278,13 +353,17 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
+	devcd->delete_work = false;
 
+	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
 
 	dev_set_name(&devcd->devcd_dev, "devcd%d",
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
+	mutex_lock(&devcd->mutex);
+	dev_set_uevent_suppress(&devcd->devcd_dev, true);
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -299,12 +378,15 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 		              "devcoredump"))
 		dev_warn(dev, "devcoredump create_link failed\n");
 
+	dev_set_uevent_suppress(&devcd->devcd_dev, false);
+	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-
+	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
 	put_device(&devcd->devcd_dev);
+	mutex_unlock(&devcd->mutex);
  put_module:
 	module_put(owner);
  free:
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index b04e8c90aca2..aff2cd48305f 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -404,8 +404,7 @@ int regcache_sync(struct regmap *map)
 			rb_entry(node, struct regmap_range_node, node);
 
 		/* If there's nothing in the cache there's nothing to sync */
-		ret = regcache_read(map, this->selector_reg, &i);
-		if (ret != 0)
+		if (regcache_read(map, this->selector_reg, &i) != 0)
 			continue;
 
 		ret = _regmap_write(map, this->selector_reg, i);
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 44c1ad51b3fe..95bd1a4a08d1 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -480,14 +480,17 @@ static ssize_t export_store(struct class *class,
 		goto done;
 
 	status = gpiod_set_transitory(desc, false);
-	if (!status) {
-		status = gpiod_export(desc, true);
-		if (status < 0)
-			gpiod_free(desc);
-		else
-			set_bit(FLAG_SYSFS, &desc->flags);
+	if (status) {
+		gpiod_free(desc);
+		goto done;
 	}
 
+	status = gpiod_export(desc, true);
+	if (status < 0)
+		gpiod_free(desc);
+	else
+		set_bit(FLAG_SYSFS, &desc->flags);
+
 done:
 	if (status)
 		pr_debug("%s: status %d\n", __func__, status);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2d8f71dde980..f293d0dfec61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -142,7 +142,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	}
 
 	for (i = 0; i < p->nchunks; i++) {
-		struct drm_amdgpu_cs_chunk __user **chunk_ptr = NULL;
+		struct drm_amdgpu_cs_chunk __user *chunk_ptr = NULL;
 		struct drm_amdgpu_cs_chunk user_chunk;
 		uint32_t __user *cdata;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index d2286a83e302..11413b3e80c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -80,7 +80,7 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 
 	struct drm_crtc *crtc = &amdgpu_crtc->base;
 	unsigned long flags;
-	unsigned i;
+	unsigned int i;
 	int vpos, hpos;
 
 	if (amdgpu_display_flip_handle_fence(work, &work->excl))
@@ -159,7 +159,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	u64 tiling_flags;
 	int i, r;
 
-	work = kzalloc(sizeof *work, GFP_KERNEL);
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
 	if (work == NULL)
 		return -ENOMEM;
 
@@ -290,18 +290,17 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 
 	adev = drm_to_adev(dev);
 	/* if we have active crtcs and we don't have a power ref,
-	   take the current one */
+	 * take the current one
+	 */
 	if (active && !adev->have_disp_power_ref) {
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
-	/* if we have no active crtcs, then drop the power ref
-	   we got before */
-	if (!active && adev->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
+	/* if we have no active crtcs, then go to
+	 * drop the power ref we got before
+	 */
+	if (!active && adev->have_disp_power_ref)
 		adev->have_disp_power_ref = false;
-	}
-
 out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);
@@ -465,11 +464,10 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	if (amdgpu_connector->router.ddc_valid)
 		amdgpu_i2c_router_select_ddc_port(amdgpu_connector);
 
-	if (use_aux) {
+	if (use_aux)
 		ret = i2c_transfer(&amdgpu_connector->ddc_bus->aux.ddc, msgs, 2);
-	} else {
+	else
 		ret = i2c_transfer(&amdgpu_connector->ddc_bus->adapter, msgs, 2);
-	}
 
 	if (ret != 2)
 		/* Couldn't find an accessible DDC on this connector */
@@ -478,10 +476,12 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
 	 * EDID header starts with:
 	 * 0x00,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00.
 	 * Only the first 6 bytes must be valid as
-	 * drm_edid_block_valid() can fix the last 2 bytes */
+	 * drm_edid_block_valid() can fix the last 2 bytes
+	 */
 	if (drm_edid_header_is_valid(buf) < 6) {
 		/* Couldn't find an accessible EDID on this
-		 * connector */
+		 * connector
+		 */
 		return false;
 	}
 	return true;
@@ -1189,8 +1189,10 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 
 	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
 	if (obj ==  NULL) {
-		drm_dbg_kms(dev, "No GEM object associated to handle 0x%08X, "
-			    "can't create framebuffer\n", mode_cmd->handles[0]);
+		drm_dbg_kms(dev,
+			    "No GEM object associated to handle 0x%08X, can't create framebuffer\n",
+			    mode_cmd->handles[0]);
+
 		return ERR_PTR(-ENOENT);
 	}
 
@@ -1384,6 +1386,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
 	}
 	if (amdgpu_crtc->rmx_type != RMX_OFF) {
 		fixed20_12 a, b;
+
 		a.full = dfixed_const(src_v);
 		b.full = dfixed_const(dst_v);
 		amdgpu_crtc->vsc.full = dfixed_div(a, b);
@@ -1403,7 +1406,7 @@ bool amdgpu_display_crtc_scaling_mode_fixup(struct drm_crtc *crtc,
  *
  * \param dev Device to query.
  * \param pipe Crtc to query.
- * \param flags Flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
+ * \param flags from caller (DRM_CALLED_FROM_VBLIRQ or 0).
  *              For driver internal use only also supports these flags:
  *
  *              USE_REAL_VBLANKSTART to use the real start of vblank instead
@@ -1479,8 +1482,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
-	    /* Caller wants distance from real vbl_start in *hpos */
-	    *hpos = *vpos - vbl_start;
+		/* Caller wants distance from real vbl_start in *hpos */
+		*hpos = *vpos - vbl_start;
 	}
 
 	/* Fudge vblank to start a few scanlines earlier to handle the
@@ -1502,7 +1505,7 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* In vblank? */
 	if (in_vbl)
-	    ret |= DRM_SCANOUTPOS_IN_VBLANK;
+		ret |= DRM_SCANOUTPOS_IN_VBLANK;
 
 	/* Called from driver internal vblank counter query code? */
 	if (flags & GET_DISTANCE_TO_VBLANKSTART) {
@@ -1593,6 +1596,7 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				amdgpu_bo_unpin(aobj);
@@ -1600,9 +1604,9 @@ int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
 			}
 		}
 
-		if (fb == NULL || fb->obj[0] == NULL) {
+		if (!fb || !fb->obj[0])
 			continue;
-		}
+
 		robj = gem_to_amdgpu_bo(fb->obj[0]);
 		/* don't unpin kernel fb objects */
 		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
@@ -1630,6 +1634,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
 
 		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
 			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+
 			r = amdgpu_bo_reserve(aobj, true);
 			if (r == 0) {
 				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 014505b1faf7..1336f7710617 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -31,6 +31,7 @@
 #define POWER_METER_CAN_NOTIFY	(1 << 3)
 #define POWER_METER_IS_BATTERY	(1 << 8)
 #define UNKNOWN_HYSTERESIS	0xFFFFFFFF
+#define UNKNOWN_POWER		0xFFFFFFFF
 
 #define METER_NOTIFY_CONFIG	0x80
 #define METER_NOTIFY_TRIP	0x81
@@ -348,6 +349,9 @@ static ssize_t show_power(struct device *dev,
 	update_meter(resource);
 	mutex_unlock(&resource->lock);
 
+	if (resource->power == UNKNOWN_POWER)
+		return -ENODATA;
+
 	return sprintf(buf, "%llu\n", resource->power * 1000);
 }
 
diff --git a/drivers/hwmon/nzxt-kraken2.c b/drivers/hwmon/nzxt-kraken2.c
index 89f7ea4f42d4..badbcaf01f90 100644
--- a/drivers/hwmon/nzxt-kraken2.c
+++ b/drivers/hwmon/nzxt-kraken2.c
@@ -161,13 +161,13 @@ static int kraken2_probe(struct hid_device *hdev,
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret) {
 		hid_err(hdev, "hid hw start failed with %d\n", ret);
-		goto fail_and_stop;
+		return ret;
 	}
 
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "hid hw open failed with %d\n", ret);
-		goto fail_and_close;
+		goto fail_and_stop;
 	}
 
 	priv->hwmon_dev = hwmon_device_register_with_info(&hdev->dev, "kraken2",
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 2b22343918d6..26d0d4485ae9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2041,7 +2041,7 @@ static void clear_etmdrvdata(void *info)
 	etmdrvdata[cpu] = NULL;
 }
 
-static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
+static void etm4_remove_dev(struct etmv4_drvdata *drvdata)
 {
 	etm_perf_symlink(drvdata->csdev, false);
 	/*
@@ -2062,11 +2062,9 @@ static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
 
 	cscfg_unregister_csdev(drvdata->csdev);
 	coresight_unregister(drvdata->csdev);
-
-	return 0;
 }
 
-static void __exit etm4_remove_amba(struct amba_device *adev)
+static void etm4_remove_amba(struct amba_device *adev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
@@ -2074,15 +2072,14 @@ static void __exit etm4_remove_amba(struct amba_device *adev)
 		etm4_remove_dev(drvdata);
 }
 
-static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
+static int etm4_remove_platform_dev(struct platform_device *pdev)
 {
-	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
 
 	if (drvdata)
-		ret = etm4_remove_dev(drvdata);
+		etm4_remove_dev(drvdata);
 	pm_runtime_disable(&pdev->dev);
-	return ret;
+	return 0;
 }
 
 static const struct amba_id etm4_ids[] = {
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 4e752321b95e..cb1d8d192ac0 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -63,7 +63,7 @@ static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readl_relaxed(dev->base + reg);
+	*val = readl(dev->base + reg);
 
 	return 0;
 }
@@ -72,7 +72,7 @@ static int dw_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel_relaxed(val, dev->base + reg);
+	writel(val, dev->base + reg);
 
 	return 0;
 }
@@ -81,7 +81,7 @@ static int dw_reg_read_swab(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = swab32(readl_relaxed(dev->base + reg));
+	*val = swab32(readl(dev->base + reg));
 
 	return 0;
 }
@@ -90,7 +90,7 @@ static int dw_reg_write_swab(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel_relaxed(swab32(val), dev->base + reg);
+	writel(swab32(val), dev->base + reg);
 
 	return 0;
 }
@@ -99,8 +99,8 @@ static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readw_relaxed(dev->base + reg) |
-		(readw_relaxed(dev->base + reg + 2) << 16);
+	*val = readw(dev->base + reg) |
+		(readw(dev->base + reg + 2) << 16);
 
 	return 0;
 }
@@ -109,8 +109,8 @@ static int dw_reg_write_word(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writew_relaxed(val, dev->base + reg);
-	writew_relaxed(val >> 16, dev->base + reg + 2);
+	writew(val, dev->base + reg);
+	writew(val >> 16, dev->base + reg + 2);
 
 	return 0;
 }
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 957634eceba8..8ce569bf7525 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -96,12 +96,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 		return page_size;
 	}
 
-	/* rdma_for_each_block() has a bug if the page size is smaller than the
-	 * page size used to build the umem. For now prevent smaller page sizes
-	 * from being returned.
-	 */
-	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
-
 	/* The best result is the smallest page size that results in the minimum
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 7b85eef113fc..c7ea2eedd60c 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -70,7 +70,7 @@ static char version[] =
 		BNXT_RE_DESC "\n";
 
 MODULE_AUTHOR("Eddie Wai <eddie.wai@broadcom.com>");
-MODULE_DESCRIPTION(BNXT_RE_DESC " Driver");
+MODULE_DESCRIPTION(BNXT_RE_DESC);
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* globals */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f034021f3adc..6d8f3aa9d6aa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4586,10 +4586,15 @@ static int check_cong_type(struct ib_qp *ibqp,
 		cong_alg->wnd_mode_sel = WND_LIMIT;
 		break;
 	default:
-		ibdev_err(&hr_dev->ib_dev,
-			  "error type(%u) for congestion selection.\n",
-			  hr_dev->caps.cong_type);
-		return -EINVAL;
+		ibdev_warn(&hr_dev->ib_dev,
+			   "invalid type(%u) for congestion selection.\n",
+			   hr_dev->caps.cong_type);
+		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+		cong_alg->alg_sel = CONG_DCQCN;
+		cong_alg->alg_sub_sel = UNSUPPORT_CONG_LEVEL;
+		cong_alg->dip_vld = DIP_INVALID;
+		cong_alg->wnd_mode_sel = WND_LIMIT;
+		break;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 70dffa9a9f67..0359f415280c 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -322,7 +322,11 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			break;
 		case IRDMA_AE_QP_SUSPEND_COMPLETE:
 			if (iwqp->iwdev->vsi.tc_change_pending) {
-				atomic_dec(&iwqp->sc_qp.vsi->qp_suspend_reqs);
+				if (!atomic_dec_return(&qp->vsi->qp_suspend_reqs))
+					wake_up(&iwqp->iwdev->suspend_wq);
+			}
+			if (iwqp->suspend_pending) {
+				iwqp->suspend_pending = false;
 				wake_up(&iwqp->iwdev->suspend_wq);
 			}
 			break;
@@ -1165,7 +1169,6 @@ static enum irdma_status_code irdma_create_ceq(struct irdma_pci_f *rf,
 	enum irdma_status_code status;
 	struct irdma_ceq_init_info info = {};
 	struct irdma_sc_dev *dev = &rf->sc_dev;
-	u64 scratch;
 	u32 ceq_size;
 
 	info.ceq_id = ceq_id;
@@ -1186,14 +1189,13 @@ static enum irdma_status_code irdma_create_ceq(struct irdma_pci_f *rf,
 	iwceq->sc_ceq.ceq_id = ceq_id;
 	info.dev = dev;
 	info.vsi = vsi;
-	scratch = (uintptr_t)&rf->cqp.sc_cqp;
 	status = irdma_sc_ceq_init(&iwceq->sc_ceq, &info);
 	if (!status) {
 		if (dev->ceq_valid)
 			status = irdma_cqp_ceq_cmd(&rf->sc_dev, &iwceq->sc_ceq,
 						   IRDMA_OP_CEQ_CREATE);
 		else
-			status = irdma_sc_cceq_create(&iwceq->sc_ceq, scratch);
+			status = irdma_sc_cceq_create(&iwceq->sc_ceq, 0);
 	}
 
 	if (status) {
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index c556a36e7670..232db2c8b6ae 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -48,7 +48,7 @@ static void irdma_prep_tc_change(struct irdma_device *iwdev)
 	/* Wait for all qp's to suspend */
 	wait_event_timeout(iwdev->suspend_wq,
 			   !atomic_read(&iwdev->vsi.qp_suspend_reqs),
-			   IRDMA_EVENT_TIMEOUT);
+			   msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS));
 	irdma_ws_reset(&iwdev->vsi);
 }
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index bd13cc38e5ae..0e998e080198 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -79,7 +79,7 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
 
 #define MAX_DPC_ITERATIONS	128
 
-#define IRDMA_EVENT_TIMEOUT		50000
+#define IRDMA_EVENT_TIMEOUT_MS		5000
 #define IRDMA_VCHNL_EVENT_TIMEOUT	100000
 #define IRDMA_RST_TIMEOUT_HZ		4
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8ccbe761b860..1af1df8a734b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1082,6 +1082,21 @@ static int irdma_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
 	return 0;
 }
 
+static int irdma_wait_for_suspend(struct irdma_qp *iwqp)
+{
+	if (!wait_event_timeout(iwqp->iwdev->suspend_wq,
+				!iwqp->suspend_pending,
+				msecs_to_jiffies(IRDMA_EVENT_TIMEOUT_MS))) {
+		iwqp->suspend_pending = false;
+		ibdev_warn(&iwqp->iwdev->ibdev,
+			   "modify_qp timed out waiting for suspend. qp_id = %d, last_ae = 0x%x\n",
+			   iwqp->ibqp.qp_num, iwqp->last_aeq);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * irdma_modify_qp_roce - modify qp request
  * @ibqp: qp's pointer for modify
@@ -1330,17 +1345,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 			info.next_iwarp_state = IRDMA_QP_STATE_SQD;
 			issue_modify_qp = 1;
+			iwqp->suspend_pending = true;
 			break;
 		case IB_QPS_SQE:
 		case IB_QPS_ERR:
 		case IB_QPS_RESET:
-			if (iwqp->iwarp_state == IRDMA_QP_STATE_RTS) {
-				spin_unlock_irqrestore(&iwqp->lock, flags);
-				info.next_iwarp_state = IRDMA_QP_STATE_SQD;
-				irdma_hw_modify_qp(iwdev, iwqp, &info, true);
-				spin_lock_irqsave(&iwqp->lock, flags);
-			}
-
 			if (iwqp->iwarp_state == IRDMA_QP_STATE_ERROR) {
 				spin_unlock_irqrestore(&iwqp->lock, flags);
 				if (udata) {
@@ -1377,6 +1386,11 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			ctx_info->rem_endpoint_idx = udp_info->arp_idx;
 			if (irdma_hw_modify_qp(iwdev, iwqp, &info, true))
 				return -EINVAL;
+			if (info.next_iwarp_state == IRDMA_QP_STATE_SQD) {
+				ret = irdma_wait_for_suspend(iwqp);
+				if (ret)
+					return ret;
+			}
 			spin_lock_irqsave(&iwqp->lock, flags);
 			if (iwqp->iwarp_state == info.curr_iwarp_state) {
 				iwqp->iwarp_state = info.next_iwarp_state;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 5af3c8e9b394..a934c985dbb4 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -188,6 +188,7 @@ struct irdma_qp {
 	u8 flush_issued : 1;
 	u8 sig_all : 1;
 	u8 pau_mode : 1;
+	u8 suspend_pending : 1;
 	u8 rsvd : 1;
 	u8 iwarp_state;
 	u16 term_sq_flush_code;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index afe8670f9e55..3f4ef6e4a89b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -383,7 +383,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	struct rtrs_clt_path *clt_path;
 	int err;
 
-	if (WARN_ON(!req->in_use))
+	if (!req->in_use)
 		return;
 	if (WARN_ON(!req->con))
 		return;
@@ -1682,7 +1682,7 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 		clt_path->s.dev_ref++;
 		max_send_wr = min_t(int, wr_limit,
 			      /* QD * (REQ + RSP + FR REGS or INVS) + drain */
-			      clt_path->queue_depth * 3 + 1);
+			      clt_path->queue_depth * 4 + 1);
 		max_recv_wr = min_t(int, wr_limit,
 			      clt_path->queue_depth * 3 + 1);
 		max_send_sge = 2;
@@ -2341,8 +2341,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 	if (err)
 		goto destroy;
 
-	rtrs_start_hb(&clt_path->s);
-
 	return 0;
 
 destroy:
@@ -2616,6 +2614,7 @@ static int init_path(struct rtrs_clt_path *clt_path)
 		goto out;
 	}
 	rtrs_clt_path_up(clt_path);
+	rtrs_start_hb(&clt_path->s);
 out:
 	mutex_unlock(&clt_path->init_mutex);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 733116554e0b..27bf2b2da9fd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -72,8 +72,9 @@ static bool rtrs_srv_change_state(struct rtrs_srv_path *srv_path,
 {
 	enum rtrs_srv_state old_state;
 	bool changed = false;
+	unsigned long flags;
 
-	spin_lock_irq(&srv_path->state_lock);
+	spin_lock_irqsave(&srv_path->state_lock, flags);
 	old_state = srv_path->state;
 	switch (new_state) {
 	case RTRS_SRV_CONNECTED:
@@ -94,7 +95,7 @@ static bool rtrs_srv_change_state(struct rtrs_srv_path *srv_path,
 	}
 	if (changed)
 		srv_path->state = new_state;
-	spin_unlock_irq(&srv_path->state_lock);
+	spin_unlock_irqrestore(&srv_path->state_lock, flags);
 
 	return changed;
 }
@@ -555,7 +556,10 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 		struct rtrs_srv_mr *srv_mr;
 
 		srv_mr = &srv_path->mrs[i];
-		rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
+		if (always_invalidate)
+			rtrs_iu_free(srv_mr->iu, srv_path->s.dev->ib_dev, 1);
+
 		ib_dereg_mr(srv_mr->mr);
 		ib_dma_unmap_sg(srv_path->s.dev->ib_dev, srv_mr->sgt.sgl,
 				srv_mr->sgt.nents, DMA_BIDIRECTIONAL);
@@ -721,20 +725,23 @@ static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
 	WARN_ON(wc->opcode != IB_WC_SEND);
 }
 
-static void rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
+static int rtrs_srv_path_up(struct rtrs_srv_path *srv_path)
 {
 	struct rtrs_srv *srv = srv_path->srv;
 	struct rtrs_srv_ctx *ctx = srv->ctx;
-	int up;
+	int up, ret = 0;
 
 	mutex_lock(&srv->paths_ev_mutex);
 	up = ++srv->paths_up;
 	if (up == 1)
-		ctx->ops.link_ev(srv, RTRS_SRV_LINK_EV_CONNECTED, NULL);
+		ret = ctx->ops.link_ev(srv, RTRS_SRV_LINK_EV_CONNECTED, NULL);
 	mutex_unlock(&srv->paths_ev_mutex);
 
 	/* Mark session as established */
-	srv_path->established = true;
+	if (!ret)
+		srv_path->established = true;
+
+	return ret;
 }
 
 static void rtrs_srv_path_down(struct rtrs_srv_path *srv_path)
@@ -863,7 +870,12 @@ static int process_info_req(struct rtrs_srv_con *con,
 		goto iu_free;
 	kobject_get(&srv_path->kobj);
 	get_device(&srv_path->srv->dev);
-	rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
+	err = rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
+	if (!err) {
+		rtrs_err(s, "rtrs_srv_change_state(), err: %d\n", err);
+		goto iu_free;
+	}
+
 	rtrs_srv_start_hb(srv_path);
 
 	/*
@@ -872,7 +884,11 @@ static int process_info_req(struct rtrs_srv_con *con,
 	 * all connections are successfully established.  Thus, simply notify
 	 * listener with a proper event if we are the first path.
 	 */
-	rtrs_srv_path_up(srv_path);
+	err = rtrs_srv_path_up(srv_path);
+	if (err) {
+		rtrs_err(s, "rtrs_srv_path_up(), err: %d\n", err);
+		goto iu_free;
+	}
 
 	ib_dma_sync_single_for_device(srv_path->s.dev->ib_dev,
 				      tx_iu->dma_addr,
@@ -1525,7 +1541,6 @@ static void rtrs_srv_close_work(struct work_struct *work)
 
 	srv_path = container_of(work, typeof(*srv_path), close_work);
 
-	rtrs_srv_destroy_path_files(srv_path);
 	rtrs_srv_stop_hb(srv_path);
 
 	for (i = 0; i < srv_path->s.con_num; i++) {
@@ -1545,6 +1560,8 @@ static void rtrs_srv_close_work(struct work_struct *work)
 	/* Wait for all completion */
 	wait_for_completion(&srv_path->complete_done);
 
+	rtrs_srv_destroy_path_files(srv_path);
+
 	/* Notify upper layer if we are the last path */
 	rtrs_srv_path_down(srv_path);
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index a2d985636595..aae9ec78c0e8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -92,6 +92,18 @@ static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
 
+enum md_ro_state {
+	MD_RDWR,
+	MD_RDONLY,
+	MD_AUTO_READ,
+	MD_MAX_STATE
+};
+
+static bool md_is_rdwr(struct mddev *mddev)
+{
+	return (mddev->ro == MD_RDWR);
+}
+
 /*
  * Default number of read corrections we'll attempt on an rdev
  * before ejecting it from the array. We divide the read error
@@ -461,7 +473,7 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 	if (!bio)
 		return BLK_QC_T_NONE;
 
-	if (mddev->ro == 1 && unlikely(rw == WRITE)) {
+	if (mddev->ro == MD_RDONLY && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
 			bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
@@ -2680,7 +2692,7 @@ void md_update_sb(struct mddev *mddev, int force_change)
 	int any_badblocks_changed = 0;
 	int ret = -1;
 
-	if (mddev->ro) {
+	if (!md_is_rdwr(mddev)) {
 		if (force_change)
 			set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 		return;
@@ -3953,7 +3965,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 		goto out_unlock;
 	}
 	rv = -EROFS;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		goto out_unlock;
 
 	/* request to change the personality.  Need to ensure:
@@ -4159,7 +4171,7 @@ layout_store(struct mddev *mddev, const char *buf, size_t len)
 	if (mddev->pers) {
 		if (mddev->pers->check_reshape == NULL)
 			err = -EBUSY;
-		else if (mddev->ro)
+		else if (!md_is_rdwr(mddev))
 			err = -EROFS;
 		else {
 			mddev->new_layout = n;
@@ -4268,7 +4280,7 @@ chunk_size_store(struct mddev *mddev, const char *buf, size_t len)
 	if (mddev->pers) {
 		if (mddev->pers->check_reshape == NULL)
 			err = -EBUSY;
-		else if (mddev->ro)
+		else if (!md_is_rdwr(mddev))
 			err = -EROFS;
 		else {
 			mddev->new_chunk_sectors = n >> 9;
@@ -4391,13 +4403,13 @@ array_state_show(struct mddev *mddev, char *page)
 
 	if (mddev->pers && !test_bit(MD_NOT_READY, &mddev->flags)) {
 		switch(mddev->ro) {
-		case 1:
+		case MD_RDONLY:
 			st = readonly;
 			break;
-		case 2:
+		case MD_AUTO_READ:
 			st = read_auto;
 			break;
-		case 0:
+		case MD_RDWR:
 			spin_lock(&mddev->lock);
 			if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 				st = write_pending;
@@ -4433,7 +4445,8 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 	int err = 0;
 	enum array_state st = match_word(buf, array_states);
 
-	if (mddev->pers && (st == active || st == clean) && mddev->ro != 1) {
+	if (mddev->pers && (st == active || st == clean) &&
+	    mddev->ro != MD_RDONLY) {
 		/* don't take reconfig_mutex when toggling between
 		 * clean and active
 		 */
@@ -4477,23 +4490,23 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		if (mddev->pers)
 			err = md_set_readonly(mddev, NULL);
 		else {
-			mddev->ro = 1;
+			mddev->ro = MD_RDONLY;
 			set_disk_ro(mddev->gendisk, 1);
 			err = do_md_run(mddev);
 		}
 		break;
 	case read_auto:
 		if (mddev->pers) {
-			if (mddev->ro == 0)
+			if (md_is_rdwr(mddev))
 				err = md_set_readonly(mddev, NULL);
-			else if (mddev->ro == 1)
+			else if (mddev->ro == MD_RDONLY)
 				err = restart_array(mddev);
 			if (err == 0) {
-				mddev->ro = 2;
+				mddev->ro = MD_AUTO_READ;
 				set_disk_ro(mddev->gendisk, 0);
 			}
 		} else {
-			mddev->ro = 2;
+			mddev->ro = MD_AUTO_READ;
 			err = do_md_run(mddev);
 		}
 		break;
@@ -4518,7 +4531,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 			wake_up(&mddev->sb_wait);
 			err = 0;
 		} else {
-			mddev->ro = 0;
+			mddev->ro = MD_RDWR;
 			set_disk_ro(mddev->gendisk, 0);
 			err = do_md_run(mddev);
 		}
@@ -4819,7 +4832,7 @@ action_show(struct mddev *mddev, char *page)
 	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
 		type = "frozen";
 	else if (test_bit(MD_RECOVERY_RUNNING, &recovery) ||
-	    (!mddev->ro && test_bit(MD_RECOVERY_NEEDED, &recovery))) {
+	    (md_is_rdwr(mddev) && test_bit(MD_RECOVERY_NEEDED, &recovery))) {
 		if (test_bit(MD_RECOVERY_RESHAPE, &recovery))
 			type = "reshape";
 		else if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
@@ -4892,11 +4905,11 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 	}
-	if (mddev->ro == 2) {
+	if (mddev->ro == MD_AUTO_READ) {
 		/* A write to sync_action is enough to justify
 		 * canceling read-auto mode
 		 */
-		mddev->ro = 0;
+		mddev->ro = MD_RDWR;
 		md_wakeup_thread(mddev->sync_thread);
 	}
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -5124,8 +5137,7 @@ max_sync_store(struct mddev *mddev, const char *buf, size_t len)
 			goto out_unlock;
 
 		err = -EBUSY;
-		if (max < mddev->resync_max &&
-		    mddev->ro == 0 &&
+		if (max < mddev->resync_max && md_is_rdwr(mddev) &&
 		    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 			goto out_unlock;
 
@@ -5841,8 +5853,8 @@ int md_run(struct mddev *mddev)
 			continue;
 		sync_blockdev(rdev->bdev);
 		invalidate_bdev(rdev->bdev);
-		if (mddev->ro != 1 && rdev_read_only(rdev)) {
-			mddev->ro = 1;
+		if (mddev->ro != MD_RDONLY && rdev_read_only(rdev)) {
+			mddev->ro = MD_RDONLY;
 			if (mddev->gendisk)
 				set_disk_ro(mddev->gendisk, 1);
 		}
@@ -5945,8 +5957,8 @@ int md_run(struct mddev *mddev)
 
 	mddev->ok_start_degraded = start_dirty_degraded;
 
-	if (start_readonly && mddev->ro == 0)
-		mddev->ro = 2; /* read-only, but switch on first write */
+	if (start_readonly && md_is_rdwr(mddev))
+		mddev->ro = MD_AUTO_READ; /* read-only, but switch on first write */
 
 	err = pers->run(mddev);
 	if (err)
@@ -6021,8 +6033,8 @@ int md_run(struct mddev *mddev)
 		mddev->sysfs_action = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_action");
 		mddev->sysfs_completed = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_completed");
 		mddev->sysfs_degraded = sysfs_get_dirent_safe(mddev->kobj.sd, "degraded");
-	} else if (mddev->ro == 2) /* auto-readonly not meaningful */
-		mddev->ro = 0;
+	} else if (mddev->ro == MD_AUTO_READ)
+		mddev->ro = MD_RDWR;
 
 	atomic_set(&mddev->max_corr_read_errors,
 		   MD_DEFAULT_MAX_CORRECTED_READ_ERRORS);
@@ -6040,7 +6052,7 @@ int md_run(struct mddev *mddev)
 		if (rdev->raid_disk >= 0)
 			sysfs_link_rdev(mddev, rdev); /* failure here is OK */
 
-	if (mddev->degraded && !mddev->ro)
+	if (mddev->degraded && md_is_rdwr(mddev))
 		/* This ensures that recovering status is reported immediately
 		 * via sysfs - until a lack of spares is confirmed.
 		 */
@@ -6130,7 +6142,7 @@ static int restart_array(struct mddev *mddev)
 		return -ENXIO;
 	if (!mddev->pers)
 		return -EINVAL;
-	if (!mddev->ro)
+	if (md_is_rdwr(mddev))
 		return -EBUSY;
 
 	rcu_read_lock();
@@ -6149,7 +6161,7 @@ static int restart_array(struct mddev *mddev)
 		return -EROFS;
 
 	mddev->safemode = 0;
-	mddev->ro = 0;
+	mddev->ro = MD_RDWR;
 	set_disk_ro(disk, 0);
 	pr_debug("md: %s switched to read-write mode.\n", mdname(mddev));
 	/* Kick recovery or resync if necessary */
@@ -6176,7 +6188,7 @@ static void md_clean(struct mddev *mddev)
 	mddev->clevel[0] = 0;
 	mddev->flags = 0;
 	mddev->sb_flags = 0;
-	mddev->ro = 0;
+	mddev->ro = MD_RDWR;
 	mddev->metadata_type[0] = 0;
 	mddev->chunk_sectors = 0;
 	mddev->ctime = mddev->utime = 0;
@@ -6227,7 +6239,7 @@ static void __md_stop_writes(struct mddev *mddev)
 	}
 	md_bitmap_flush(mddev);
 
-	if (mddev->ro == 0 &&
+	if (md_is_rdwr(mddev) &&
 	    ((!mddev->in_sync && !mddev_is_clustered(mddev)) ||
 	     mddev->sb_flags)) {
 		/* mark array as shutdown cleanly */
@@ -6299,6 +6311,9 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	int err = 0;
 	int did_freeze = 0;
 
+	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+		return -EBUSY;
+
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
@@ -6311,8 +6326,6 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		 * which will now never happen */
 		wake_up_process(mddev->sync_thread->tsk);
 
-	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
-		return -EBUSY;
 	mddev_unlock(mddev);
 	wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
 					  &mddev->recovery));
@@ -6325,29 +6338,30 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	    mddev->sync_thread ||
 	    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 		pr_warn("md: %s still in use.\n",mdname(mddev));
-		if (did_freeze) {
-			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
-		}
 		err = -EBUSY;
 		goto out;
 	}
+
 	if (mddev->pers) {
 		__md_stop_writes(mddev);
 
-		err  = -ENXIO;
-		if (mddev->ro==1)
+		if (mddev->ro == MD_RDONLY) {
+			err  = -ENXIO;
 			goto out;
-		mddev->ro = 1;
+		}
+
+		mddev->ro = MD_RDONLY;
 		set_disk_ro(mddev->gendisk, 1);
+	}
+
+out:
+	if ((mddev->pers && !err) || did_freeze) {
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
-		err = 0;
 	}
-out:
+
 	mutex_unlock(&mddev->open_mutex);
 	return err;
 }
@@ -6396,7 +6410,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		return -EBUSY;
 	}
 	if (mddev->pers) {
-		if (mddev->ro)
+		if (!md_is_rdwr(mddev))
 			set_disk_ro(disk, 0);
 
 		__md_stop_writes(mddev);
@@ -6413,8 +6427,8 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		mutex_unlock(&mddev->open_mutex);
 		mddev->changed = 1;
 
-		if (mddev->ro)
-			mddev->ro = 0;
+		if (!md_is_rdwr(mddev))
+			mddev->ro = MD_RDWR;
 	} else
 		mutex_unlock(&mddev->open_mutex);
 	/*
@@ -7226,7 +7240,7 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 	    mddev->sync_thread)
 		return -EBUSY;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		return -EROFS;
 
 	rdev_for_each(rdev, mddev) {
@@ -7256,7 +7270,7 @@ static int update_raid_disks(struct mddev *mddev, int raid_disks)
 	/* change the number of raid disks */
 	if (mddev->pers->check_reshape == NULL)
 		return -EINVAL;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		return -EROFS;
 	if (raid_disks <= 0 ||
 	    (mddev->max_disks && raid_disks >= mddev->max_disks))
@@ -7680,26 +7694,25 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	 * The remaining ioctls are changing the state of the
 	 * superblock, so we do not allow them on read-only arrays.
 	 */
-	if (mddev->ro && mddev->pers) {
-		if (mddev->ro == 2) {
-			mddev->ro = 0;
-			sysfs_notify_dirent_safe(mddev->sysfs_state);
-			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			/* mddev_unlock will wake thread */
-			/* If a device failed while we were read-only, we
-			 * need to make sure the metadata is updated now.
-			 */
-			if (test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags)) {
-				mddev_unlock(mddev);
-				wait_event(mddev->sb_wait,
-					   !test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags) &&
-					   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
-				mddev_lock_nointr(mddev);
-			}
-		} else {
+	if (!md_is_rdwr(mddev) && mddev->pers) {
+		if (mddev->ro != MD_AUTO_READ) {
 			err = -EROFS;
 			goto unlock;
 		}
+		mddev->ro = MD_RDWR;
+		sysfs_notify_dirent_safe(mddev->sysfs_state);
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		/* mddev_unlock will wake thread */
+		/* If a device failed while we were read-only, we
+		 * need to make sure the metadata is updated now.
+		 */
+		if (test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags)) {
+			mddev_unlock(mddev);
+			wait_event(mddev->sb_wait,
+				   !test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags) &&
+				   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
+			mddev_lock_nointr(mddev);
+		}
 	}
 
 	switch (cmd) {
@@ -7785,11 +7798,11 @@ static int md_set_read_only(struct block_device *bdev, bool ro)
 	 * Transitioning to read-auto need only happen for arrays that call
 	 * md_write_start and which are not ready for writes yet.
 	 */
-	if (!ro && mddev->ro == 1 && mddev->pers) {
+	if (!ro && mddev->ro == MD_RDONLY && mddev->pers) {
 		err = restart_array(mddev);
 		if (err)
 			goto out_unlock;
-		mddev->ro = 2;
+		mddev->ro = MD_AUTO_READ;
 	}
 
 out_unlock:
@@ -8247,9 +8260,9 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
 						mddev->pers ? "" : "in");
 		if (mddev->pers) {
-			if (mddev->ro==1)
+			if (mddev->ro == MD_RDONLY)
 				seq_printf(seq, " (read-only)");
-			if (mddev->ro==2)
+			if (mddev->ro == MD_AUTO_READ)
 				seq_printf(seq, " (auto-read-only)");
 			seq_printf(seq, " %s", mddev->pers->name);
 		}
@@ -8509,10 +8522,10 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 	if (bio_data_dir(bi) != WRITE)
 		return true;
 
-	BUG_ON(mddev->ro == 1);
-	if (mddev->ro == 2) {
+	BUG_ON(mddev->ro == MD_RDONLY);
+	if (mddev->ro == MD_AUTO_READ) {
 		/* need to switch to read/write */
-		mddev->ro = 0;
+		mddev->ro = MD_RDWR;
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
 		md_wakeup_thread(mddev->sync_thread);
@@ -8563,7 +8576,7 @@ void md_write_inc(struct mddev *mddev, struct bio *bi)
 {
 	if (bio_data_dir(bi) != WRITE)
 		return;
-	WARN_ON_ONCE(mddev->in_sync || mddev->ro);
+	WARN_ON_ONCE(mddev->in_sync || !md_is_rdwr(mddev));
 	percpu_ref_get(&mddev->writes_pending);
 }
 EXPORT_SYMBOL(md_write_inc);
@@ -8668,7 +8681,7 @@ void md_allow_write(struct mddev *mddev)
 {
 	if (!mddev->pers)
 		return;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		return;
 	if (!mddev->pers->sync_request)
 		return;
@@ -8717,7 +8730,7 @@ void md_do_sync(struct md_thread *thread)
 	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
 	    test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
 		return;
-	if (mddev->ro) {/* never try to sync a read-only array */
+	if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array */
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		return;
 	}
@@ -9185,9 +9198,9 @@ static int remove_and_add_spares(struct mddev *mddev,
 		if (test_bit(Faulty, &rdev->flags))
 			continue;
 		if (!test_bit(Journal, &rdev->flags)) {
-			if (mddev->ro &&
-			    ! (rdev->saved_raid_disk >= 0 &&
-			       !test_bit(Bitmap_sync, &rdev->flags)))
+			if (!md_is_rdwr(mddev) &&
+			    !(rdev->saved_raid_disk >= 0 &&
+			      !test_bit(Bitmap_sync, &rdev->flags)))
 				continue;
 
 			rdev->recovery_offset = 0;
@@ -9285,7 +9298,8 @@ void md_check_recovery(struct mddev *mddev)
 		flush_signals(current);
 	}
 
-	if (mddev->ro && !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	if (!md_is_rdwr(mddev) &&
+	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
@@ -9304,7 +9318,7 @@ void md_check_recovery(struct mddev *mddev)
 		if (!mddev->external && mddev->safemode == 1)
 			mddev->safemode = 0;
 
-		if (mddev->ro) {
+		if (!md_is_rdwr(mddev)) {
 			struct md_rdev *rdev;
 			if (!mddev->external && mddev->in_sync)
 				/* 'Blocked' flag not needed as failed devices
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 96f4e59c32a5..d179273586be 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1975,7 +1975,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	mei_hdr = mei_msg_hdr_init(cb);
 	if (IS_ERR(mei_hdr)) {
-		rets = -PTR_ERR(mei_hdr);
+		rets = PTR_ERR(mei_hdr);
 		mei_hdr = NULL;
 		goto err;
 	}
@@ -1999,7 +1999,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 
 	hbuf_slots = mei_hbuf_empty_slots(dev);
 	if (hbuf_slots < 0) {
-		rets = -EOVERFLOW;
+		buf_len = -EOVERFLOW;
 		goto out;
 	}
 
diff --git a/drivers/net/arcnet/arcdevice.h b/drivers/net/arcnet/arcdevice.h
index 5d4a4c7efbbf..deeabd6ec2e8 100644
--- a/drivers/net/arcnet/arcdevice.h
+++ b/drivers/net/arcnet/arcdevice.h
@@ -186,6 +186,8 @@ do {									\
 #define ARC_IS_5MBIT    1   /* card default speed is 5MBit */
 #define ARC_CAN_10MBIT  2   /* card uses COM20022, supporting 10MBit,
 				 but default is 2.5MBit. */
+#define ARC_HAS_LED     4   /* card has software controlled LEDs */
+#define ARC_HAS_ROTARY  8   /* card has rotary encoder */
 
 /* information needed to define an encapsulation driver */
 struct ArcProto {
diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 28dccbc0e8d8..9d9e4200064f 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -213,12 +213,13 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		if (!strncmp(ci->name, "EAE PLX-PCI FB2", 15))
 			lp->backplane = 1;
 
-		/* Get the dev_id from the PLX rotary coder */
-		if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
-			dev_id_mask = 0x3;
-		dev->dev_id = (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
-
-		snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		if (ci->flags & ARC_HAS_ROTARY) {
+			/* Get the dev_id from the PLX rotary coder */
+			if (!strncmp(ci->name, "EAE PLX-PCI MA1", 15))
+				dev_id_mask = 0x3;
+			dev->dev_id = (inb(priv->misc + ci->rotary) >> 4) & dev_id_mask;
+			snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);
+		}
 
 		if (arcnet_inb(ioaddr, COM20020_REG_R_STATUS) == 0xFF) {
 			pr_err("IO address %Xh is empty!\n", ioaddr);
@@ -230,6 +231,10 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			goto err_free_arcdev;
 		}
 
+		ret = com20020_found(dev, IRQF_SHARED);
+		if (ret)
+			goto err_free_arcdev;
+
 		card = devm_kzalloc(&pdev->dev, sizeof(struct com20020_dev),
 				    GFP_KERNEL);
 		if (!card) {
@@ -239,41 +244,39 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 		card->index = i;
 		card->pci_priv = priv;
-		card->tx_led.brightness_set = led_tx_set;
-		card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-tx",
-						dev->dev_id, i);
-		card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:green:tx:%d-%d",
-						dev->dev_id, i);
-
-		card->tx_led.dev = &dev->dev;
-		card->recon_led.brightness_set = led_recon_set;
-		card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
-						GFP_KERNEL, "arc%d-%d-recon",
-						dev->dev_id, i);
-		card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-						"pci:red:recon:%d-%d",
-						dev->dev_id, i);
-		card->recon_led.dev = &dev->dev;
-		card->dev = dev;
-
-		ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-		if (ret)
-			goto err_free_arcdev;
 
-		ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
-		if (ret)
-			goto err_free_arcdev;
-
-		dev_set_drvdata(&dev->dev, card);
-
-		ret = com20020_found(dev, IRQF_SHARED);
-		if (ret)
-			goto err_free_arcdev;
-
-		devm_arcnet_led_init(dev, dev->dev_id, i);
+		if (ci->flags & ARC_HAS_LED) {
+			card->tx_led.brightness_set = led_tx_set;
+			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-tx",
+							dev->dev_id, i);
+			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:green:tx:%d-%d",
+							dev->dev_id, i);
+
+			card->tx_led.dev = &dev->dev;
+			card->recon_led.brightness_set = led_recon_set;
+			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
+							GFP_KERNEL, "arc%d-%d-recon",
+							dev->dev_id, i);
+			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+							"pci:red:recon:%d-%d",
+							dev->dev_id, i);
+			card->recon_led.dev = &dev->dev;
+
+			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			ret = devm_led_classdev_register(&pdev->dev, &card->recon_led);
+			if (ret)
+				goto err_free_arcdev;
+
+			dev_set_drvdata(&dev->dev, card);
+			devm_arcnet_led_init(dev, dev->dev_id, i);
+		}
 
+		card->dev = dev;
 		list_add(&card->list, &priv->list_dev);
 		continue;
 
@@ -329,7 +332,7 @@ static struct com20020_pci_card_info card_info_5mbit = {
 };
 
 static struct com20020_pci_card_info card_info_sohard = {
-	.name = "PLX-PCI",
+	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
 	/* SOHARD needs PCI base addr 4 */
 	.chan_map_tbl = {
@@ -364,7 +367,7 @@ static struct com20020_pci_card_info card_info_eae_arc1 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static struct com20020_pci_card_info card_info_eae_ma1 = {
@@ -396,7 +399,7 @@ static struct com20020_pci_card_info card_info_eae_ma1 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static struct com20020_pci_card_info card_info_eae_fb2 = {
@@ -421,7 +424,7 @@ static struct com20020_pci_card_info card_info_eae_fb2 = {
 		},
 	},
 	.rotary = 0x0,
-	.flags = ARC_CAN_10MBIT,
+	.flags = ARC_HAS_ROTARY | ARC_HAS_LED | ARC_CAN_10MBIT,
 };
 
 static const struct pci_device_id com20020pci_id_table[] = {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 1471b6130a2b..b3473883eae6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -2075,6 +2075,7 @@ int bnxt_init_tc(struct bnxt *bp)
 	rhashtable_destroy(&tc_info->flow_table);
 free_tc_info:
 	kfree(tc_info);
+	bp->tc_info = NULL;
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 2c41852a082b..fc487a6f050a 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -6854,7 +6854,7 @@ static int tg3_rx(struct tg3_napi *tnapi, int budget)
 				       desc_idx, *post_ptr);
 		drop_it_no_recycle:
 			/* Other statistics kept track of by card. */
-			tp->rx_dropped++;
+			tnapi->rx_dropped++;
 			goto next_pkt;
 		}
 
@@ -7880,8 +7880,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
@@ -8152,7 +8154,7 @@ static netdev_tx_t tg3_start_xmit(struct sk_buff *skb, struct net_device *dev)
 drop:
 	dev_kfree_skb_any(skb);
 drop_nofree:
-	tp->tx_dropped++;
+	tnapi->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
@@ -9331,7 +9333,7 @@ static void __tg3_set_rx_mode(struct net_device *);
 /* tp->lock is held. */
 static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 {
-	int err;
+	int err, i;
 
 	tg3_stop_fw(tp);
 
@@ -9352,6 +9354,13 @@ static int tg3_halt(struct tg3 *tp, int kind, bool silent)
 
 		/* And make sure the next sample is new data */
 		memset(tp->hw_stats, 0, sizeof(struct tg3_hw_stats));
+
+		for (i = 0; i < TG3_IRQ_MAX_VECS; ++i) {
+			struct tg3_napi *tnapi = &tp->napi[i];
+
+			tnapi->rx_dropped = 0;
+			tnapi->tx_dropped = 0;
+		}
 	}
 
 	return err;
@@ -11906,6 +11915,9 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 {
 	struct rtnl_link_stats64 *old_stats = &tp->net_stats_prev;
 	struct tg3_hw_stats *hw_stats = tp->hw_stats;
+	unsigned long rx_dropped;
+	unsigned long tx_dropped;
+	int i;
 
 	stats->rx_packets = old_stats->rx_packets +
 		get_stat64(&hw_stats->rx_ucast_packets) +
@@ -11952,8 +11964,26 @@ static void tg3_get_nstats(struct tg3 *tp, struct rtnl_link_stats64 *stats)
 	stats->rx_missed_errors = old_stats->rx_missed_errors +
 		get_stat64(&hw_stats->rx_discards);
 
-	stats->rx_dropped = tp->rx_dropped;
-	stats->tx_dropped = tp->tx_dropped;
+	/* Aggregate per-queue counters. The per-queue counters are updated
+	 * by a single writer, race-free. The result computed by this loop
+	 * might not be 100% accurate (counters can be updated in the middle of
+	 * the loop) but the next tg3_get_nstats() will recompute the current
+	 * value so it is acceptable.
+	 *
+	 * Note that these counters wrap around at 4G on 32bit machines.
+	 */
+	rx_dropped = (unsigned long)(old_stats->rx_dropped);
+	tx_dropped = (unsigned long)(old_stats->tx_dropped);
+
+	for (i = 0; i < tp->irq_cnt; i++) {
+		struct tg3_napi *tnapi = &tp->napi[i];
+
+		rx_dropped += tnapi->rx_dropped;
+		tx_dropped += tnapi->tx_dropped;
+	}
+
+	stats->rx_dropped = rx_dropped;
+	stats->tx_dropped = tx_dropped;
 }
 
 static int tg3_get_regs_len(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 1000c894064f..8d753f8c5b06 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -3018,6 +3018,7 @@ struct tg3_napi {
 	u16				*rx_rcb_prod_idx;
 	struct tg3_rx_prodring_set	prodring;
 	struct tg3_rx_buffer_desc	*rx_rcb;
+	unsigned long			rx_dropped;
 
 	u32				tx_prod	____cacheline_aligned;
 	u32				tx_cons;
@@ -3026,6 +3027,7 @@ struct tg3_napi {
 	u32				prodmbox;
 	struct tg3_tx_buffer_desc	*tx_ring;
 	struct tg3_tx_ring_info		*tx_buffers;
+	unsigned long			tx_dropped;
 
 	dma_addr_t			status_mapping;
 	dma_addr_t			rx_rcb_mapping;
@@ -3219,8 +3221,6 @@ struct tg3 {
 
 
 	/* begin "everything else" cacheline(s) section */
-	unsigned long			rx_dropped;
-	unsigned long			tx_dropped;
 	struct rtnl_link_stats64	net_stats_prev;
 	struct tg3_ethtool_stats	estats_prev;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index f41379de2186..ec9a02495df4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -66,6 +66,27 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
 	}
 }
 
+static u32 hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv)
+{
+#define HNS_MAC_LINK_WAIT_TIME 5
+#define HNS_MAC_LINK_WAIT_CNT 40
+
+	u32 link_status = 0;
+	int i;
+
+	if (!mac_ctrl_drv->get_link_status)
+		return link_status;
+
+	for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
+		msleep(HNS_MAC_LINK_WAIT_TIME);
+		mac_ctrl_drv->get_link_status(mac_ctrl_drv, &link_status);
+		if (!link_status)
+			break;
+	}
+
+	return link_status;
+}
+
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 {
 	struct mac_driver *mac_ctrl_drv;
@@ -83,6 +104,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
 							       &sfp_prsnt);
 		if (!ret)
 			*link_status = *link_status && sfp_prsnt;
+
+		/* for FIBER port, it may have a fake link up.
+		 * when the link status changes from down to up, we need to do
+		 * anti-shake. the anti-shake time is base on tests.
+		 * only FIBER port need to do this.
+		 */
+		if (*link_status && !mac_cb->link)
+			*link_status = hns_mac_link_anti_shake(mac_ctrl_drv);
 	}
 
 	mac_cb->link = *link_status;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 20e26aa5b81c..cf085bd8d790 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16132,7 +16132,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
 		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 i, val);
+			 pf->hw.port, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 274d3abe30eb..ba7ff776760d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1284,7 +1284,7 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
-		goto err;
+		return -ENOMEM;
 
 	INIT_WORK(&rvu_reporters->intr_work, rvu_npa_intr_work);
 	INIT_WORK(&rvu_reporters->err_work, rvu_npa_err_work);
@@ -1292,9 +1292,6 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	INIT_WORK(&rvu_reporters->ras_work, rvu_npa_ras_work);
 
 	return 0;
-err:
-	rvu_npa_health_reporters_destroy(rvu_dl);
-	return -ENOMEM;
 }
 
 static int rvu_npa_health_reporters_create(struct rvu_devlink *rvu_dl)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index d1249da7a18f..a3fd20d26b94 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -388,7 +388,13 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank, nixlf, index;
 
 	/* get ucast entry rule entry index */
-	nix_get_nixlf(rvu, pf_func, &nixlf, NULL);
+	if (nix_get_nixlf(rvu, pf_func, &nixlf, NULL)) {
+		dev_err(rvu->dev, "%s: nixlf not attached to pcifunc:0x%x\n",
+			__func__, pf_func);
+		/* Action 0 is drop */
+		return 0;
+	}
+
 	index = npc_get_nixlf_mcam_index(mcam, pf_func, nixlf,
 					 NIXLF_UCAST_ENTRY);
 	bank = npc_get_bank(mcam, index);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
index b3150f053291..d46ac29adb96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
@@ -31,8 +31,8 @@ static struct hw_reg_map txsch_reg_map[NIX_TXSCH_LVL_CNT] = {
 	{NIX_TXSCH_LVL_TL4, 3, 0xFFFF, {{0x0B00, 0x0B08}, {0x0B10, 0x0B18},
 			      {0x1200, 0x12E0} } },
 	{NIX_TXSCH_LVL_TL3, 4, 0xFFFF, {{0x1000, 0x10E0}, {0x1600, 0x1608},
-			      {0x1610, 0x1618}, {0x1700, 0x17B0} } },
-	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17B0} } },
+			      {0x1610, 0x1618}, {0x1700, 0x17C8} } },
+	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17C8} } },
 	{NIX_TXSCH_LVL_TL1, 1, 0xFFFF, {{0x0C00, 0x0D98} } },
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index dbfa3bc39e34..fa4b2d833d77 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -316,9 +316,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 	if (is_otx2_lbkvf(pfvf->pdev))
 		return;
 
+	mutex_lock(&pfvf->mbox.lock);
 	req = otx2_mbox_alloc_msg_cgx_cfg_pause_frm(&pfvf->mbox);
-	if (!req)
+	if (!req) {
+		mutex_unlock(&pfvf->mbox.lock);
 		return;
+	}
 
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pause_frm_cfg *)
@@ -326,6 +329,7 @@ static void otx2_get_pauseparam(struct net_device *netdev,
 		pause->rx_pause = rsp->rx_pause;
 		pause->tx_pause = rsp->tx_pause;
 	}
+	mutex_unlock(&pfvf->mbox.lock);
 }
 
 static int otx2_set_pauseparam(struct net_device *netdev,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 676c58dc1981..38f38fe8f21d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -208,7 +208,7 @@ struct ionic_desc_info {
 	void *cb_arg;
 };
 
-#define IONIC_QUEUE_NAME_MAX_SZ		32
+#define IONIC_QUEUE_NAME_MAX_SZ		16
 
 struct ionic_queue {
 	struct device *dev;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 2cc126d37835..63181866809f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -44,24 +44,24 @@ static void ionic_lif_queue_identify(struct ionic_lif *lif);
 static void ionic_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
+	struct ionic_intr_info *intr;
 	struct dim_cq_moder cur_moder;
 	struct ionic_qcq *qcq;
+	struct ionic_lif *lif;
 	u32 new_coal;
 
 	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	qcq = container_of(dim, struct ionic_qcq, dim);
-	new_coal = ionic_coal_usec_to_hw(qcq->q.lif->ionic, cur_moder.usec);
+	lif = qcq->q.lif;
+	new_coal = ionic_coal_usec_to_hw(lif->ionic, cur_moder.usec);
 	new_coal = new_coal ? new_coal : 1;
 
-	if (qcq->intr.dim_coal_hw != new_coal) {
-		unsigned int qi = qcq->cq.bound_q->index;
-		struct ionic_lif *lif = qcq->q.lif;
-
-		qcq->intr.dim_coal_hw = new_coal;
+	intr = &qcq->intr;
+	if (intr->dim_coal_hw != new_coal) {
+		intr->dim_coal_hw = new_coal;
 
 		ionic_intr_coal_init(lif->ionic->idev.intr_ctrl,
-				     lif->rxqcqs[qi]->intr.index,
-				     qcq->intr.dim_coal_hw);
+				     intr->index, intr->dim_coal_hw);
 	}
 
 	dim->state = DIM_START_MEASURE;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d2fbd169f25b..c0a339ff43a6 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -205,6 +205,7 @@ enum rtl_registers {
 					/* No threshold before first PCI xfer */
 #define	RX_FIFO_THRESH			(7 << RXCFG_FIFO_SHIFT)
 #define	RX_EARLY_OFF			(1 << 11)
+#define	RX_PAUSE_SLOT_ON		(1 << 11)	/* 8125b and later */
 #define	RXCFG_DMA_SHIFT			8
 					/* Unlimited maximum PCI burst. */
 #define	RX_DMA_BURST			(7 << RXCFG_DMA_SHIFT)
@@ -2268,9 +2269,13 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_53:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST | RX_EARLY_OFF);
 		break;
-	case RTL_GIGA_MAC_VER_60 ... RTL_GIGA_MAC_VER_63:
+	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
+	case RTL_GIGA_MAC_VER_63:
+		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
+			RX_PAUSE_SLOT_ON);
+		break;
 	default:
 		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_DMA_BURST);
 		break;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index e95d35f1e5a0..8fd167501fa0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 	}
 }
 
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable)
 {
 	u32 value;
 
-	if (!enable) {
-		value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-		value &= ~EFPE;
-
-		writel(value, ioaddr + MAC_FPE_CTRL_STS);
-		return;
+	if (enable) {
+		cfg->fpe_csr = EFPE;
+		value = readl(ioaddr + GMAC_RXQ_CTRL1);
+		value &= ~GMAC_RXQCTRL_FPRQ;
+		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
+		writel(value, ioaddr + GMAC_RXQ_CTRL1);
+	} else {
+		cfg->fpe_csr = 0;
 	}
-
-	value = readl(ioaddr + GMAC_RXQ_CTRL1);
-	value &= ~GMAC_RXQCTRL_FPRQ;
-	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
-	writel(value, ioaddr + GMAC_RXQ_CTRL1);
-
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-	value |= EFPE;
-	writel(value, ioaddr + MAC_FPE_CTRL_STS);
+	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
 }
 
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
@@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
 	status = FPE_EVENT_UNKNOWN;
 
+	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
+	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
+	 */
 	value = readl(ioaddr + MAC_FPE_CTRL_STS);
 
 	if (value & TRSP) {
@@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 	return status;
 }
 
-void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
+void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			     enum stmmac_mpacket_type type)
 {
-	u32 value;
+	u32 value = cfg->fpe_csr;
 
-	value = readl(ioaddr + MAC_FPE_CTRL_STS);
-
-	if (type == MPACKET_VERIFY) {
-		value &= ~SRSP;
+	if (type == MPACKET_VERIFY)
 		value |= SVER;
-	} else {
-		value &= ~SVER;
+	else if (type == MPACKET_RESPONSE)
 		value |= SRSP;
-	}
 
 	writel(value, ioaddr + MAC_FPE_CTRL_STS);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
index 53c138d0ff48..34e620790eb3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
@@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 			 unsigned int ptp_rate);
 void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
-void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			  u32 num_txq, u32 num_rxq,
 			  bool enable);
 void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
+			     struct stmmac_fpe_cfg *cfg,
 			     enum stmmac_mpacket_type type);
 int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 54aa0fbd1bf6..3568bf3ccfbe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1440,7 +1440,8 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 	return 0;
 }
 
-static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
+static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+				   u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index fe2660d5694d..cc229ccd5d81 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -395,9 +395,11 @@ struct stmmac_ops {
 			     unsigned int ptp_rate);
 	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
 			       struct stmmac_extra_stats *x, u32 txqcnt);
-	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
+	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
+			      u32 num_txq, u32 num_rxq,
 			      bool enable);
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
+				 struct stmmac_fpe_cfg *cfg,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2b4c30a5ffcd..7042abc6979a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1054,7 +1054,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
 	bool *hs_enable = &fpe_cfg->hs_enable;
 
 	if (is_up && *hs_enable) {
-		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
+		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
+					MPACKET_VERIFY);
 	} else {
 		*lo_state = FPE_STATE_OFF;
 		*lp_state = FPE_STATE_OFF;
@@ -5621,6 +5622,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
 		/* If user has requested FPE enable, quickly response */
 		if (*hs_enable)
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_RESPONSE);
 	}
 
@@ -6958,6 +6960,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 		if (*lo_state == FPE_STATE_ENTERING_ON &&
 		    *lp_state == FPE_STATE_ENTERING_ON) {
 			stmmac_fpe_configure(priv, priv->ioaddr,
+					     fpe_cfg,
 					     priv->plat->tx_queues_to_use,
 					     priv->plat->rx_queues_to_use,
 					     *enable);
@@ -6976,6 +6979,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
 				    *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						fpe_cfg,
 						MPACKET_VERIFY);
 		}
 		/* Sleep then retry */
@@ -6990,6 +6994,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
 	if (priv->plat->fpe_cfg->hs_enable != enable) {
 		if (enable) {
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
+						priv->plat->fpe_cfg,
 						MPACKET_VERIFY);
 		} else {
 			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
@@ -7399,6 +7404,7 @@ int stmmac_suspend(struct device *dev)
 	if (priv->dma_cap.fpesel) {
 		/* Disable FPE */
 		stmmac_fpe_configure(priv, priv->ioaddr,
+				     priv->plat->fpe_cfg,
 				     priv->plat->tx_queues_to_use,
 				     priv->plat->rx_queues_to_use, false);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index d0a2b289f460..08cffc055874 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -952,6 +952,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 
 	priv->plat->fpe_cfg->enable = false;
 	stmmac_fpe_configure(priv, priv->ioaddr,
+			     priv->plat->fpe_cfg,
 			     priv->plat->tx_queues_to_use,
 			     priv->plat->rx_queues_to_use,
 			     false);
diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index ca7bf7f897d3..c8cbd85adcf9 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -3,5 +3,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 663e3880bf71..54779caf18f9 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -763,7 +763,7 @@ enum rtl_register_content {
 
 /* rtl8152 flags */
 enum rtl8152_flags {
-	RTL8152_UNPLUG = 0,
+	RTL8152_INACCESSIBLE = 0,
 	RTL8152_SET_RX_MODE,
 	WORK_ENABLE,
 	RTL8152_LINK_CHG,
@@ -1241,7 +1241,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 static void rtl_set_unplug(struct r8152 *tp)
 {
 	if (tp->udev->state == USB_STATE_NOTATTACHED) {
-		set_bit(RTL8152_UNPLUG, &tp->flags);
+		set_bit(RTL8152_INACCESSIBLE, &tp->flags);
 		smp_mb__after_atomic();
 	}
 }
@@ -1252,7 +1252,7 @@ static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
 	u16 limit = 64;
 	int ret = 0;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	/* both size and indix must be 4 bytes align */
@@ -1296,7 +1296,7 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
 	u16 byteen_start, byteen_end, byen;
 	u16 limit = 512;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	/* both size and indix must be 4 bytes align */
@@ -1526,7 +1526,7 @@ static int read_mii_word(struct net_device *netdev, int phy_id, int reg)
 	struct r8152 *tp = netdev_priv(netdev);
 	int ret;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	if (phy_id != R8152_PHY_ID)
@@ -1542,7 +1542,7 @@ void write_mii_word(struct net_device *netdev, int phy_id, int reg, int val)
 {
 	struct r8152 *tp = netdev_priv(netdev);
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (phy_id != R8152_PHY_ID)
@@ -1747,7 +1747,7 @@ static void read_bulk_callback(struct urb *urb)
 	if (!tp)
 		return;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (!test_bit(WORK_ENABLE, &tp->flags))
@@ -1839,7 +1839,7 @@ static void write_bulk_callback(struct urb *urb)
 	if (!test_bit(WORK_ENABLE, &tp->flags))
 		return;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (!skb_queue_empty(&tp->tx_queue))
@@ -1860,7 +1860,7 @@ static void intr_callback(struct urb *urb)
 	if (!test_bit(WORK_ENABLE, &tp->flags))
 		return;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	switch (status) {
@@ -2604,7 +2604,7 @@ static void bottom_half(struct tasklet_struct *t)
 {
 	struct r8152 *tp = from_tasklet(tp, t, tx_tl);
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (!test_bit(WORK_ENABLE, &tp->flags))
@@ -2647,7 +2647,7 @@ int r8152_submit_rx(struct r8152 *tp, struct rx_agg *agg, gfp_t mem_flags)
 	int ret;
 
 	/* The rx would be stopped, so skip submitting */
-	if (test_bit(RTL8152_UNPLUG, &tp->flags) ||
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
 	    !test_bit(WORK_ENABLE, &tp->flags) || !netif_carrier_ok(tp->netdev))
 		return 0;
 
@@ -2850,6 +2850,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
 
 		for (i = 0; i < 1000; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				break;
 			if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) & CR_RST))
 				break;
 			usleep_range(100, 400);
@@ -3043,7 +3045,7 @@ static int rtl_enable(struct r8152 *tp)
 
 static int rtl8152_enable(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	set_tx_qlen(tp);
@@ -3130,7 +3132,7 @@ static int rtl8153_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	set_tx_qlen(tp);
@@ -3162,7 +3164,7 @@ static void rtl_disable(struct r8152 *tp)
 	u32 ocp_data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -3179,6 +3181,8 @@ static void rtl_disable(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if ((ocp_data & FIFO_EMPTY) == FIFO_EMPTY)
 			break;
@@ -3186,6 +3190,8 @@ static void rtl_disable(struct r8152 *tp)
 	}
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0) & TCR0_TX_EMPTY)
 			break;
 		usleep_range(1000, 2000);
@@ -3616,7 +3622,7 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 desired)
 		}
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			break;
 	}
 
@@ -3648,7 +3654,7 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
@@ -3690,7 +3696,7 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
-				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+				if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
@@ -4055,8 +4061,8 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
-			break;
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return -ENODEV;
 
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
@@ -5374,6 +5380,8 @@ static void wait_oob_link_list_ready(struct r8152 *tp)
 	int i;
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if (ocp_data & LINK_LIST_READY)
 			break;
@@ -5388,6 +5396,8 @@ static void r8156b_wait_loading_flash(struct r8152 *tp)
 		int i;
 
 		for (i = 0; i < 100; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				break;
 			if (ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL) & GPHY_PATCH_DONE)
 				break;
 			usleep_range(1000, 2000);
@@ -5510,6 +5520,8 @@ static int r8153_pre_firmware_1(struct r8152 *tp)
 	for (i = 0; i < 104; i++) {
 		u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_WDT1_CTRL);
 
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return -ENODEV;
 		if (!(ocp_data & WTD1_EN))
 			break;
 		usleep_range(1000, 2000);
@@ -5666,6 +5678,8 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 		data &= ~EN_ALDPS;
 		ocp_reg_write(tp, OCP_POWER_CFG, data);
 		for (i = 0; i < 20; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			usleep_range(1000, 2000);
 			if (ocp_read_word(tp, MCU_TYPE_PLA, 0xe000) & 0x0100)
 				break;
@@ -6019,7 +6033,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	u32 ocp_data;
 	u16 speed;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	r8156_fc_parameter(tp);
@@ -6077,7 +6091,7 @@ static int rtl8156b_enable(struct r8152 *tp)
 	u32 ocp_data;
 	u16 speed;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	set_tx_qlen(tp);
@@ -6263,7 +6277,7 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 autoneg, u32 speed, u8 duplex,
 
 static void rtl8152_up(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8152_aldps_en(tp, false);
@@ -6273,7 +6287,7 @@ static void rtl8152_up(struct r8152 *tp)
 
 static void rtl8152_down(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6288,7 +6302,7 @@ static void rtl8153_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_u1u2en(tp, false);
@@ -6328,7 +6342,7 @@ static void rtl8153_down(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6349,7 +6363,7 @@ static void rtl8153b_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -6373,7 +6387,7 @@ static void rtl8153b_down(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6410,7 +6424,7 @@ static void rtl8153c_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -6491,7 +6505,7 @@ static void rtl8156_up(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -6564,7 +6578,7 @@ static void rtl8156_down(struct r8152 *tp)
 {
 	u32 ocp_data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		return;
 	}
@@ -6702,7 +6716,7 @@ static void rtl_work_func_t(struct work_struct *work)
 	/* If the device is unplugged or !netif_running(), the workqueue
 	 * doesn't need to wake the device, and could return directly.
 	 */
-	if (test_bit(RTL8152_UNPLUG, &tp->flags) || !netif_running(tp->netdev))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) || !netif_running(tp->netdev))
 		return;
 
 	if (usb_autopm_get_interface(tp->intf) < 0)
@@ -6741,7 +6755,7 @@ static void rtl_hw_phy_work_func_t(struct work_struct *work)
 {
 	struct r8152 *tp = container_of(work, struct r8152, hw_phy_work.work);
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (usb_autopm_get_interface(tp->intf) < 0)
@@ -6868,7 +6882,7 @@ static int rtl8152_close(struct net_device *netdev)
 	netif_stop_queue(netdev);
 
 	res = usb_autopm_get_interface(tp->intf);
-	if (res < 0 || test_bit(RTL8152_UNPLUG, &tp->flags)) {
+	if (res < 0 || test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
 		rtl_drop_queued_tx(tp);
 		rtl_stop_rx(tp);
 	} else {
@@ -6901,7 +6915,7 @@ static void r8152b_init(struct r8152 *tp)
 	u32 ocp_data;
 	u16 data;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	data = r8152_mdio_read(tp, MII_BMCR);
@@ -6945,7 +6959,7 @@ static void r8153_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_u1u2en(tp, false);
@@ -6956,7 +6970,7 @@ static void r8153_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			break;
 	}
 
@@ -7085,7 +7099,7 @@ static void r8153b_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -7096,7 +7110,7 @@ static void r8153b_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			break;
 	}
 
@@ -7167,7 +7181,7 @@ static void r8153c_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_u1u2en(tp, false);
@@ -7187,7 +7201,7 @@ static void r8153c_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return;
 	}
 
@@ -8016,7 +8030,7 @@ static void r8156_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
@@ -8037,7 +8051,7 @@ static void r8156_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return;
 	}
 
@@ -8112,7 +8126,7 @@ static void r8156b_init(struct r8152 *tp)
 	u16 data;
 	int i;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
@@ -8146,7 +8160,7 @@ static void r8156b_init(struct r8152 *tp)
 			break;
 
 		msleep(20);
-		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 			return;
 	}
 
@@ -9208,7 +9222,7 @@ static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 	struct mii_ioctl_data *data = if_mii(rq);
 	int res;
 
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return -ENODEV;
 
 	res = usb_autopm_get_interface(tp->intf);
@@ -9310,7 +9324,7 @@ static const struct net_device_ops rtl8152_netdev_ops = {
 
 static void rtl8152_unload(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	if (tp->version != RTL_VER_01)
@@ -9319,7 +9333,7 @@ static void rtl8152_unload(struct r8152 *tp)
 
 static void rtl8153_unload(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153_power_cut_en(tp, false);
@@ -9327,7 +9341,7 @@ static void rtl8153_unload(struct r8152 *tp)
 
 static void rtl8153b_unload(struct r8152 *tp)
 {
-	if (test_bit(RTL8152_UNPLUG, &tp->flags))
+	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
 		return;
 
 	r8153b_power_cut_en(tp, false);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 590ffa3e1c49..415b01707599 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -154,6 +154,11 @@ enum nvme_quirks {
 	 * No temperature thresholds for channels other than 0 (Composite).
 	 */
 	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
+
+	/*
+	 * Disables simple suspend/resume path.
+	 */
+	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 19a61cddb56d..fd20f3fdb159 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2953,6 +2953,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 			return NVME_QUIRK_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x2646 && (pdev->device == 0x2263 ||
+		   pdev->device == 0x500f)) {
+		/*
+		 * Exclude some Kingston NV1 and A2000 devices from
+		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
+		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
+		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	return 0;
@@ -2993,7 +3005,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	dev->dev = get_device(&pdev->dev);
 
 	quirks |= check_vendor_combination_bug(pdev);
-	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
+	if (!noacpi &&
+	    !(quirks & NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND) &&
+	    acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 0dfbfae15d6a..ffb7b0446afd 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -104,8 +104,9 @@ int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
  *
  * Returns the new state of a device based on the notifier used.
  *
- * Return: 0 on device going from enabled to disabled, 1 on device
- * going from disabled to enabled and -1 on no change.
+ * Return: OF_RECONFIG_CHANGE_REMOVE on device going from enabled to
+ * disabled, OF_RECONFIG_CHANGE_ADD on device going from disabled to
+ * enabled and OF_RECONFIG_NO_CHANGE on no change.
  */
 int of_reconfig_get_state_change(unsigned long action, struct of_reconfig_data *pr)
 {
diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 925be41eeebe..de5a823f3031 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2613,6 +2613,8 @@ enum parport_pc_pci_cards {
 	netmos_9865,
 	quatech_sppxp100,
 	wch_ch382l,
+	brainboxes_uc146,
+	brainboxes_px203,
 };
 
 
@@ -2676,6 +2678,8 @@ static struct parport_pc_pci {
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
 	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
+	/* brainboxes_uc146 */	{ 1, { { 3, -1 }, } },
+	/* brainboxes_px203 */	{ 1, { { 0, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2767,6 +2771,23 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
 	/* WCH CH382L PCI-E single parallel port card */
 	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
+	/* Brainboxes IX-500/550 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x402a,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes UC-146/UC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	{ PCI_VENDOR_ID_INTASHIELD, 0x0be2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_uc146 },
+	/* Brainboxes PX-146/PX-257 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401c,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes PX-203 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4007,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, brainboxes_px203 },
+	/* Brainboxes PX-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x401f,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1c7a288b59a5..6a171a4f9dc6 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -17,6 +17,7 @@
 
 #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
 #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
+#define MLXBF_BOOTCTL_SB_DEV_MASK		BIT(4)
 
 #define MLXBF_SB_KEY_NUM			4
 
@@ -37,11 +38,18 @@ static struct mlxbf_bootctl_name boot_names[] = {
 	{ MLXBF_BOOTCTL_NONE, "none" },
 };
 
+enum {
+	MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION = 0,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE = 1,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE = 2,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_RMA = 3
+};
+
 static const char * const mlxbf_bootctl_lifecycle_states[] = {
-	[0] = "Production",
-	[1] = "GA Secured",
-	[2] = "GA Non-Secured",
-	[3] = "RMA",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION] = "Production",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE] = "GA Secured",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE] = "GA Non-Secured",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_RMA] = "RMA",
 };
 
 /* ARM SMC call which is atomic and no need for lock. */
@@ -165,25 +173,30 @@ static ssize_t second_reset_action_store(struct device *dev,
 static ssize_t lifecycle_state_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	int status_bits;
+	int use_dev_key;
+	int test_state;
 	int lc_state;
 
-	lc_state = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
-				     MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
-	if (lc_state < 0)
-		return lc_state;
+	status_bits = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
+					MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
+	if (status_bits < 0)
+		return status_bits;
 
-	lc_state &=
-		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
+	use_dev_key = status_bits & MLXBF_BOOTCTL_SB_DEV_MASK;
+	test_state = status_bits & MLXBF_BOOTCTL_SB_TEST_MASK;
+	lc_state = status_bits & MLXBF_BOOTCTL_SB_SECURE_MASK;
 
 	/*
 	 * If the test bits are set, we specify that the current state may be
 	 * due to using the test bits.
 	 */
-	if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
-		lc_state &= MLXBF_BOOTCTL_SB_SECURE_MASK;
-
+	if (test_state) {
 		return sprintf(buf, "%s(test)\n",
 			       mlxbf_bootctl_lifecycle_states[lc_state]);
+	} else if (use_dev_key &&
+		   (lc_state == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE)) {
+		return sprintf(buf, "Secured (development)\n");
 	}
 
 	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 2d4bbe99959e..db7a1d360cd2 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1202,6 +1202,8 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 	attr->dev_attr.show = mlxbf_pmc_event_list_show;
 	attr->nr = blk_num;
 	attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL, "event_list");
+	if (!attr->dev_attr.attr.name)
+		return -ENOMEM;
 	pmc->block[blk_num].block_attr[i] = &attr->dev_attr.attr;
 	attr = NULL;
 
@@ -1214,6 +1216,8 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
 							  "enable");
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
 		attr = NULL;
 	}
@@ -1240,6 +1244,8 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
 							  "counter%d", j);
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
 		attr = NULL;
 
@@ -1251,6 +1257,8 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, int blk_num)
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
 							  "event%d", j);
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
 		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
 		attr = NULL;
 	}
@@ -1283,6 +1291,8 @@ static int mlxbf_pmc_init_perftype_reg(struct device *dev, int blk_num)
 		attr->nr = blk_num;
 		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
 							  events[j].evt_name);
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
 		pmc->block[blk_num].block_attr[i] = &attr->dev_attr.attr;
 		attr = NULL;
 		i++;
@@ -1311,6 +1321,8 @@ static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
 	pmc->block[blk_num].block_attr_grp.attrs = pmc->block[blk_num].block_attr;
 	pmc->block[blk_num].block_attr_grp.name = devm_kasprintf(
 		dev, GFP_KERNEL, pmc->block_name[blk_num]);
+	if (!pmc->block[blk_num].block_attr_grp.name)
+		return -ENOMEM;
 	pmc->groups[blk_num] = &pmc->block[blk_num].block_attr_grp;
 
 	return 0;
@@ -1442,6 +1454,8 @@ static int mlxbf_pmc_probe(struct platform_device *pdev)
 
 	pmc->hwmon_dev = devm_hwmon_device_register_with_groups(
 		dev, "bfperf", pmc, pmc->groups);
+	if (IS_ERR(pmc->hwmon_dev))
+		return PTR_ERR(pmc->hwmon_dev);
 	platform_set_drvdata(pdev, pmc);
 
 	return 0;
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 54f86df77a37..b14e36871793 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -230,9 +230,12 @@ static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
 			    size_t n)
 {
 	struct ssam_controller *ctrl;
+	int ret;
 
 	ctrl = serdev_device_get_drvdata(dev);
-	return ssam_controller_receive_buf(ctrl, buf, n);
+	ret = ssam_controller_receive_buf(ctrl, buf, n);
+
+	return ret < 0 ? 0 : ret;
 }
 
 static void ssam_write_wakeup(struct serdev_device *dev)
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 50abcf0c483c..c03367b13db6 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -257,6 +257,7 @@ config ASUS_WMI
 	depends on RFKILL || RFKILL = n
 	depends on HOTPLUG_PCI
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on SERIO_I8042 || SERIO_I8042 = n
 	select INPUT_SPARSEKMAP
 	select LEDS_CLASS
 	select NEW_LEDS
@@ -271,7 +272,6 @@ config ASUS_WMI
 config ASUS_NB_WMI
 	tristate "Asus Notebook WMI Driver"
 	depends on ASUS_WMI
-	depends on SERIO_I8042 || SERIO_I8042 = n
 	help
 	  This is a driver for newer Asus notebooks. It adds extra features
 	  like wireless radio and bluetooth control, leds, hotkeys, backlight...
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 59ca3dab59e1..49505939352a 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -115,12 +115,17 @@ static struct quirk_entry quirk_asus_forceals = {
 };
 
 static struct quirk_entry quirk_asus_use_kbd_dock_devid = {
-	.use_kbd_dock_devid = true,
+	.tablet_switch_mode = asus_wmi_kbd_dock_devid,
 };
 
 static struct quirk_entry quirk_asus_use_lid_flip_devid = {
 	.wmi_backlight_set_devstate = true,
-	.use_lid_flip_devid = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_devid,
+};
+
+static struct quirk_entry quirk_asus_tablet_mode = {
+	.wmi_backlight_set_devstate = true,
+	.tablet_switch_mode = asus_wmi_lid_flip_rog_devid,
 };
 
 static int dmi_matched(const struct dmi_system_id *dmi)
@@ -471,13 +476,20 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_use_lid_flip_devid,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS ROG FLOW X13",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GV301Q"),
+		},
+		.driver_data = &quirk_asus_tablet_mode,
+	},
 	{},
 };
 
 static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 {
-	int ret;
-
 	quirks = &quirk_asus_unknown;
 	dmi_check_system(asus_quirks);
 
@@ -490,29 +502,8 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 	else
 		wapf = quirks->wapf;
 
-	switch (tablet_mode_sw) {
-	case 0:
-		quirks->use_kbd_dock_devid = false;
-		quirks->use_lid_flip_devid = false;
-		break;
-	case 1:
-		quirks->use_kbd_dock_devid = true;
-		quirks->use_lid_flip_devid = false;
-		break;
-	case 2:
-		quirks->use_kbd_dock_devid = false;
-		quirks->use_lid_flip_devid = true;
-		break;
-	}
-
-	if (quirks->i8042_filter) {
-		ret = i8042_install_filter(quirks->i8042_filter);
-		if (ret) {
-			pr_warn("Unable to install key filter\n");
-			return;
-		}
-		pr_info("Using i8042 filter function for receiving events\n");
-	}
+	if (tablet_mode_sw != -1)
+		quirks->tablet_switch_mode = tablet_mode_sw;
 }
 
 static const struct key_entry asus_nb_wmi_keymap[] = {
@@ -584,6 +575,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
+	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
 };
 
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f030ea97f126..a34d0f53ad16 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -68,6 +68,7 @@ module_param(fnlock_default, bool, 0444);
 #define NOTIFY_KBD_FBM			0x99
 #define NOTIFY_KBD_TTP			0xae
 #define NOTIFY_LID_FLIP			0xfa
+#define NOTIFY_LID_FLIP_ROG		0xbd
 
 #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
 
@@ -203,6 +204,10 @@ struct asus_wmi {
 	struct asus_rfkill gps;
 	struct asus_rfkill uwb;
 
+	int tablet_switch_event_code;
+	u32 tablet_switch_dev_id;
+	bool tablet_switch_inverted;
+
 	enum fan_type fan_type;
 	int fan_pwm_mode;
 	int agfn_pwm;
@@ -363,10 +368,35 @@ static bool asus_wmi_dev_is_present(struct asus_wmi *asus, u32 dev_id)
 }
 
 /* Input **********************************************************************/
+static void asus_wmi_tablet_sw_report(struct asus_wmi *asus, bool value)
+{
+	input_report_switch(asus->inputdev, SW_TABLET_MODE,
+			    asus->tablet_switch_inverted ? !value : value);
+	input_sync(asus->inputdev);
+}
+
+static void asus_wmi_tablet_sw_init(struct asus_wmi *asus, u32 dev_id, int event_code)
+{
+	struct device *dev = &asus->platform_device->dev;
+	int result;
+
+	result = asus_wmi_get_devstate_simple(asus, dev_id);
+	if (result >= 0) {
+		input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
+		asus_wmi_tablet_sw_report(asus, result);
+		asus->tablet_switch_dev_id = dev_id;
+		asus->tablet_switch_event_code = event_code;
+	} else if (result == -ENODEV) {
+		dev_err(dev, "This device has tablet-mode-switch quirk but got ENODEV checking it. This is a bug.");
+	} else {
+		dev_err(dev, "Error checking for tablet-mode-switch: %d\n", result);
+	}
+}
 
 static int asus_wmi_input_init(struct asus_wmi *asus)
 {
-	int err, result;
+	struct device *dev = &asus->platform_device->dev;
+	int err;
 
 	asus->inputdev = input_allocate_device();
 	if (!asus->inputdev)
@@ -375,35 +405,26 @@ static int asus_wmi_input_init(struct asus_wmi *asus)
 	asus->inputdev->name = asus->driver->input_name;
 	asus->inputdev->phys = asus->driver->input_phys;
 	asus->inputdev->id.bustype = BUS_HOST;
-	asus->inputdev->dev.parent = &asus->platform_device->dev;
+	asus->inputdev->dev.parent = dev;
 	set_bit(EV_REP, asus->inputdev->evbit);
 
 	err = sparse_keymap_setup(asus->inputdev, asus->driver->keymap, NULL);
 	if (err)
 		goto err_free_dev;
 
-	if (asus->driver->quirks->use_kbd_dock_devid) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_KBD_DOCK);
-		if (result >= 0) {
-			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
-			input_report_switch(asus->inputdev, SW_TABLET_MODE, !result);
-		} else if (result != -ENODEV) {
-			pr_err("Error checking for keyboard-dock: %d\n", result);
-		}
-	}
-
-	if (asus->driver->quirks->use_lid_flip_devid) {
-		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
-		if (result < 0)
-			asus->driver->quirks->use_lid_flip_devid = 0;
-		if (result >= 0) {
-			input_set_capability(asus->inputdev, EV_SW, SW_TABLET_MODE);
-			input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
-		} else if (result == -ENODEV) {
-			pr_err("This device has lid_flip quirk but got ENODEV checking it. This is a bug.");
-		} else {
-			pr_err("Error checking for lid-flip: %d\n", result);
-		}
+	switch (asus->driver->quirks->tablet_switch_mode) {
+	case asus_wmi_no_tablet_switch:
+		break;
+	case asus_wmi_kbd_dock_devid:
+		asus->tablet_switch_inverted = true;
+		asus_wmi_tablet_sw_init(asus, ASUS_WMI_DEVID_KBD_DOCK, NOTIFY_KBD_DOCK_CHANGE);
+		break;
+	case asus_wmi_lid_flip_devid:
+		asus_wmi_tablet_sw_init(asus, ASUS_WMI_DEVID_LID_FLIP, NOTIFY_LID_FLIP);
+		break;
+	case asus_wmi_lid_flip_rog_devid:
+		asus_wmi_tablet_sw_init(asus, ASUS_WMI_DEVID_LID_FLIP_ROG, NOTIFY_LID_FLIP_ROG);
+		break;
 	}
 
 	err = input_register_device(asus->inputdev);
@@ -427,14 +448,16 @@ static void asus_wmi_input_exit(struct asus_wmi *asus)
 
 /* Tablet mode ****************************************************************/
 
-static void lid_flip_tablet_mode_get_state(struct asus_wmi *asus)
+static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 {
-	int result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_LID_FLIP);
+	int result;
 
-	if (result >= 0) {
-		input_report_switch(asus->inputdev, SW_TABLET_MODE, result);
-		input_sync(asus->inputdev);
-	}
+	if (!asus->tablet_switch_dev_id)
+		return;
+
+	result = asus_wmi_get_devstate_simple(asus, asus->tablet_switch_dev_id);
+	if (result >= 0)
+		asus_wmi_tablet_sw_report(asus, result);
 }
 
 /* dGPU ********************************************************************/
@@ -2486,9 +2509,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 {
 	unsigned int key_value = 1;
 	bool autorelease = 1;
-	int result, orig_code;
-
-	orig_code = code;
+	int orig_code = code;
 
 	if (asus->driver->key_filter) {
 		asus->driver->key_filter(asus->driver, &code, &key_value,
@@ -2531,19 +2552,8 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->driver->quirks->use_kbd_dock_devid && code == NOTIFY_KBD_DOCK_CHANGE) {
-		result = asus_wmi_get_devstate_simple(asus,
-						      ASUS_WMI_DEVID_KBD_DOCK);
-		if (result >= 0) {
-			input_report_switch(asus->inputdev, SW_TABLET_MODE,
-					    !result);
-			input_sync(asus->inputdev);
-		}
-		return;
-	}
-
-	if (asus->driver->quirks->use_lid_flip_devid && code == NOTIFY_LID_FLIP) {
-		lid_flip_tablet_mode_get_state(asus);
+	if (code == asus->tablet_switch_event_code) {
+		asus_wmi_tablet_mode_get_state(asus);
 		return;
 	}
 
@@ -3089,6 +3099,12 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_wmi_handler;
 	}
 
+	if (asus->driver->quirks->i8042_filter) {
+		err = i8042_install_filter(asus->driver->quirks->i8042_filter);
+		if (err)
+			pr_warn("Unable to install key filter - %d\n", err);
+	}
+
 	asus_wmi_battery_init(asus);
 
 	asus_wmi_debugfs_init(asus);
@@ -3125,6 +3141,8 @@ static int asus_wmi_remove(struct platform_device *device)
 	struct asus_wmi *asus;
 
 	asus = platform_get_drvdata(device);
+	if (asus->driver->quirks->i8042_filter)
+		i8042_remove_filter(asus->driver->quirks->i8042_filter);
 	wmi_remove_notify_handler(asus->driver->event_guid);
 	asus_wmi_backlight_exit(asus);
 	asus_wmi_input_exit(asus);
@@ -3173,9 +3191,7 @@ static int asus_hotk_resume(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	if (asus->driver->quirks->use_lid_flip_devid)
-		lid_flip_tablet_mode_get_state(asus);
-
+	asus_wmi_tablet_mode_get_state(asus);
 	return 0;
 }
 
@@ -3215,9 +3231,7 @@ static int asus_hotk_restore(struct device *device)
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
 
-	if (asus->driver->quirks->use_lid_flip_devid)
-		lid_flip_tablet_mode_get_state(asus);
-
+	asus_wmi_tablet_mode_get_state(asus);
 	return 0;
 }
 
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 49f2b8f8ad3e..b817a312f2e1 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -25,6 +25,13 @@ struct module;
 struct key_entry;
 struct asus_wmi;
 
+enum asus_wmi_tablet_switch_mode {
+	asus_wmi_no_tablet_switch,
+	asus_wmi_kbd_dock_devid,
+	asus_wmi_lid_flip_devid,
+	asus_wmi_lid_flip_rog_devid,
+};
+
 struct quirk_entry {
 	bool hotplug_wireless;
 	bool scalar_panel_brightness;
@@ -33,8 +40,7 @@ struct quirk_entry {
 	bool wmi_backlight_native;
 	bool wmi_backlight_set_devstate;
 	bool wmi_force_als_set;
-	bool use_kbd_dock_devid;
-	bool use_lid_flip_devid;
+	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
 	 * For machines with AMD graphic chips, it will send out WMI event
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 63265ab96424..b1cbe280d2a6 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -99,6 +99,12 @@ static const struct acpi_device_id wmi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 
+/* allow duplicate GUIDs as these device drivers use struct wmi_driver */
+static const char * const allow_duplicates[] = {
+	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
+	NULL
+};
+
 static struct platform_driver acpi_wmi_driver = {
 	.driver = {
 		.name = "acpi-wmi",
@@ -1039,6 +1045,23 @@ static const struct device_type wmi_type_data = {
 	.release = wmi_dev_release,
 };
 
+/*
+ * _WDG is a static list that is only parsed at startup,
+ * so it's safe to count entries without extra protection.
+ */
+static int guid_count(const guid_t *guid)
+{
+	struct wmi_block *wblock;
+	int count = 0;
+
+	list_for_each_entry(wblock, &wmi_block_list, list) {
+		if (guid_equal(&wblock->gblock.guid, guid))
+			count++;
+	}
+
+	return count;
+}
+
 static int wmi_create_device(struct device *wmi_bus_dev,
 			     struct wmi_block *wblock,
 			     struct acpi_device *device)
@@ -1046,6 +1069,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	struct acpi_device_info *info;
 	char method[5];
 	int result;
+	uint count;
 
 	if (wblock->gblock.flags & ACPI_WMI_EVENT) {
 		wblock->dev.dev.type = &wmi_type_event;
@@ -1102,7 +1126,11 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 	wblock->dev.dev.bus = &wmi_bus_type;
 	wblock->dev.dev.parent = wmi_bus_dev;
 
-	dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
+	count = guid_count(&wblock->gblock.guid);
+	if (count)
+		dev_set_name(&wblock->dev.dev, "%pUL-%d", &wblock->gblock.guid, count);
+	else
+		dev_set_name(&wblock->dev.dev, "%pUL", &wblock->gblock.guid);
 
 	device_initialize(&wblock->dev.dev);
 
@@ -1122,11 +1150,22 @@ static void wmi_free_devices(struct acpi_device *device)
 	}
 }
 
-static bool guid_already_parsed(struct acpi_device *device, const guid_t *guid)
+static bool guid_already_parsed_for_legacy(struct acpi_device *device, const guid_t *guid)
 {
 	struct wmi_block *wblock;
 
 	list_for_each_entry(wblock, &wmi_block_list, list) {
+		int i;
+
+		/* skip warning and register if we know the driver will use struct wmi_driver */
+		for (i = 0; allow_duplicates[i] != NULL; i++) {
+			guid_t tmp;
+
+			if (guid_parse(allow_duplicates[i], &tmp))
+				continue;
+			if (guid_equal(&tmp, guid))
+				return false;
+		}
 		if (guid_equal(&wblock->gblock.guid, guid)) {
 			/*
 			 * Because we historically didn't track the relationship
@@ -1176,13 +1215,12 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		if (debug_dump_wdg)
 			wmi_dump_wdg(&gblock[i]);
 
-		/*
-		 * Some WMI devices, like those for nVidia hooks, have a
-		 * duplicate GUID. It's not clear what we should do in this
-		 * case yet, so for now, we'll just ignore the duplicate
-		 * for device creation.
-		 */
-		if (guid_already_parsed(device, &gblock[i].guid))
+		if (!gblock[i].instance_count) {
+			dev_info(wmi_bus_dev, FW_INFO "%pUL has zero instances\n", &gblock[i].guid);
+			continue;
+		}
+
+		if (guid_already_parsed_for_legacy(device, &gblock[i].guid))
 			continue;
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 7974c1326d46..27e73cd54bea 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2691,6 +2691,7 @@ static int beiscsi_init_wrb_handle(struct beiscsi_hba *phba)
 		kfree(pwrb_context->pwrb_handle_base);
 		kfree(pwrb_context->pwrb_handle_basestd);
 	}
+	kfree(phwi_ctxt->be_wrbq);
 	return -ENOMEM;
 }
 
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index a74d82e230e3..8957065ea730 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
 	kfree(optee_device);
 }
 
-static int optee_register_device(const uuid_t *device_uuid)
+static ssize_t need_supplicant_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	return 0;
+}
+
+static DEVICE_ATTR_RO(need_supplicant);
+
+static int optee_register_device(const uuid_t *device_uuid, u32 func)
 {
 	struct tee_client_device *optee_device = NULL;
 	int rc;
@@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
 		put_device(&optee_device->dev);
 	}
 
+	if (func == PTA_CMD_GET_DEVICES_SUPP)
+		device_create_file(&optee_device->dev,
+				   &dev_attr_need_supplicant);
+
 	return rc;
 }
 
@@ -143,7 +156,7 @@ static int __optee_enumerate_devices(u32 func)
 	num_devices = shm_size / sizeof(uuid_t);
 
 	for (idx = 0; idx < num_devices; idx++) {
-		rc = optee_register_device(&device_uuid[idx]);
+		rc = optee_register_device(&device_uuid[idx], func);
 		if (rc)
 			goto out_shm;
 	}
diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index c171ce6db691..8a16510d086b 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -199,6 +199,7 @@ static int __init early_omap8250_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);
 
 #endif
 
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index f114847331fe..20e0703f1def 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -839,7 +839,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg = serial_in(p, UART_OMAP_IER2);
 		reg &= ~UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}
 
 	dmaengine_tx_status(rxchan, cookie, &state);
@@ -981,7 +981,7 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
 		reg = serial_in(p, UART_OMAP_IER2);
 		reg |= UART_OMAP_IER2_RHR_IT_DIS;
-		serial_out(p, UART_OMAP_IER2, UART_OMAP_IER2_RHR_IT_DIS);
+		serial_out(p, UART_OMAP_IER2, reg);
 	}
 
 	dma_async_issue_pending(dma->rxchan);
@@ -1203,10 +1203,12 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (priv->habit & UART_HAS_EFR2)
-		am654_8250_handle_rx_dma(up, iir, status);
-	else
-		status = omap_8250_handle_rx_dma(up, iir, status);
+	if ((iir & 0x3f) != UART_IIR_THRI) {
+		if (priv->habit & UART_HAS_EFR2)
+			am654_8250_handle_rx_dma(up, iir, status);
+		else
+			status = omap_8250_handle_rx_dma(up, iir, status);
+	}
 
 	serial8250_modem_status(up);
 	if (status & UART_LSR_THRE && up->dma->tx_err) {
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b91fe25a64a1..39c711afe4cd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -222,17 +222,18 @@ static struct vendor_data vendor_zte = {
 
 /* Deals with DMA transactions */
 
-struct pl011_sgbuf {
-	struct scatterlist sg;
-	char *buf;
+struct pl011_dmabuf {
+	dma_addr_t		dma;
+	size_t			len;
+	char			*buf;
 };
 
 struct pl011_dmarx_data {
 	struct dma_chan		*chan;
 	struct completion	complete;
 	bool			use_buf_b;
-	struct pl011_sgbuf	sgbuf_a;
-	struct pl011_sgbuf	sgbuf_b;
+	struct pl011_dmabuf	dbuf_a;
+	struct pl011_dmabuf	dbuf_b;
 	dma_cookie_t		cookie;
 	bool			running;
 	struct timer_list	timer;
@@ -245,7 +246,8 @@ struct pl011_dmarx_data {
 
 struct pl011_dmatx_data {
 	struct dma_chan		*chan;
-	struct scatterlist	sg;
+	dma_addr_t		dma;
+	size_t			len;
 	char			*buf;
 	bool			queued;
 };
@@ -370,32 +372,24 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 
 #define PL011_DMA_BUFFER_SIZE PAGE_SIZE
 
-static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static int pl011_dmabuf_init(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	dma_addr_t dma_addr;
-
-	sg->buf = dma_alloc_coherent(chan->device->dev,
-		PL011_DMA_BUFFER_SIZE, &dma_addr, GFP_KERNEL);
-	if (!sg->buf)
+	db->buf = dma_alloc_coherent(chan->device->dev, PL011_DMA_BUFFER_SIZE,
+				     &db->dma, GFP_KERNEL);
+	if (!db->buf)
 		return -ENOMEM;
-
-	sg_init_table(&sg->sg, 1);
-	sg_set_page(&sg->sg, phys_to_page(dma_addr),
-		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
-	sg_dma_address(&sg->sg) = dma_addr;
-	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
+	db->len = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
 
-static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
+static void pl011_dmabuf_free(struct dma_chan *chan, struct pl011_dmabuf *db,
 	enum dma_data_direction dir)
 {
-	if (sg->buf) {
+	if (db->buf) {
 		dma_free_coherent(chan->device->dev,
-			PL011_DMA_BUFFER_SIZE, sg->buf,
-			sg_dma_address(&sg->sg));
+				  PL011_DMA_BUFFER_SIZE, db->buf, db->dma);
 	}
 }
 
@@ -556,8 +550,8 @@ static void pl011_dma_tx_callback(void *data)
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 	if (uap->dmatx.queued)
-		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
+				dmatx->len, DMA_TO_DEVICE);
 
 	dmacr = uap->dmacr;
 	uap->dmacr = dmacr & ~UART011_TXDMAE;
@@ -643,18 +637,19 @@ static int pl011_dma_tx_refill(struct uart_amba_port *uap)
 			memcpy(&dmatx->buf[first], &xmit->buf[0], second);
 	}
 
-	dmatx->sg.length = count;
-
-	if (dma_map_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE) != 1) {
+	dmatx->len = count;
+	dmatx->dma = dma_map_single(dma_dev->dev, dmatx->buf, count,
+				    DMA_TO_DEVICE);
+	if (dmatx->dma == DMA_MAPPING_ERROR) {
 		uap->dmatx.queued = false;
 		dev_dbg(uap->port.dev, "unable to map TX DMA\n");
 		return -EBUSY;
 	}
 
-	desc = dmaengine_prep_slave_sg(chan, &dmatx->sg, 1, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, dmatx->dma, dmatx->len, DMA_MEM_TO_DEV,
 					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
-		dma_unmap_sg(dma_dev->dev, &dmatx->sg, 1, DMA_TO_DEVICE);
+		dma_unmap_single(dma_dev->dev, dmatx->dma, dmatx->len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		/*
 		 * If DMA cannot be used right now, we complete this
@@ -818,8 +813,8 @@ __acquires(&uap->port.lock)
 	dmaengine_terminate_async(uap->dmatx.chan);
 
 	if (uap->dmatx.queued) {
-		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-			     DMA_TO_DEVICE);
+		dma_unmap_single(uap->dmatx.chan->device->dev, uap->dmatx.dma,
+				 uap->dmatx.len, DMA_TO_DEVICE);
 		uap->dmatx.queued = false;
 		uap->dmacr &= ~UART011_TXDMAE;
 		pl011_write(uap->dmacr, uap, REG_DMACR);
@@ -833,15 +828,15 @@ static int pl011_dma_rx_trigger_dma(struct uart_amba_port *uap)
 	struct dma_chan *rxchan = uap->dmarx.chan;
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_async_tx_descriptor *desc;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 
 	if (!rxchan)
 		return -EIO;
 
 	/* Start the RX DMA job */
-	sgbuf = uap->dmarx.use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
-	desc = dmaengine_prep_slave_sg(rxchan, &sgbuf->sg, 1,
+	dbuf = uap->dmarx.use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
+	desc = dmaengine_prep_slave_single(rxchan, dbuf->dma, dbuf->len,
 					DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	/*
@@ -881,8 +876,8 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 			       bool readfifo)
 {
 	struct tty_port *port = &uap->port.state->port;
-	struct pl011_sgbuf *sgbuf = use_buf_b ?
-		&uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	struct pl011_dmabuf *dbuf = use_buf_b ?
+		&uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	int dma_count = 0;
 	u32 fifotaken = 0; /* only used for vdbg() */
 
@@ -891,7 +886,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	if (uap->dmarx.poll_rate) {
 		/* The data can be taken by polling */
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		/* Recalculate the pending size */
 		if (pending >= dmataken)
 			pending -= dmataken;
@@ -905,7 +900,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 		 * Note that tty_insert_flip_buf() tries to take as many chars
 		 * as it can.
 		 */
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				pending);
 
 		uap->port.icount.rx += dma_count;
@@ -916,7 +911,7 @@ static void pl011_dma_rx_chars(struct uart_amba_port *uap,
 
 	/* Reset the last_residue for Rx DMA poll */
 	if (uap->dmarx.poll_rate)
-		dmarx->last_residue = sgbuf->sg.length;
+		dmarx->last_residue = dbuf->len;
 
 	/*
 	 * Only continue with trying to read the FIFO if all DMA chars have
@@ -951,8 +946,8 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 {
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	enum dma_status dmastat;
@@ -974,7 +969,7 @@ static void pl011_dma_rx_irq(struct uart_amba_port *uap)
 	pl011_write(uap->dmacr, uap, REG_DMACR);
 	uap->dmarx.running = false;
 
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1001,8 +996,8 @@ static void pl011_dma_rx_callback(void *data)
 	struct pl011_dmarx_data *dmarx = &uap->dmarx;
 	struct dma_chan *rxchan = dmarx->chan;
 	bool lastbuf = dmarx->use_buf_b;
-	struct pl011_sgbuf *sgbuf = dmarx->use_buf_b ?
-		&dmarx->sgbuf_b : &dmarx->sgbuf_a;
+	struct pl011_dmabuf *dbuf = dmarx->use_buf_b ?
+		&dmarx->dbuf_b : &dmarx->dbuf_a;
 	size_t pending;
 	struct dma_tx_state state;
 	int ret;
@@ -1020,7 +1015,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * the DMA irq handler. So we check the residue here.
 	 */
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
-	pending = sgbuf->sg.length - state.residue;
+	pending = dbuf->len - state.residue;
 	BUG_ON(pending > PL011_DMA_BUFFER_SIZE);
 	/* Then we terminate the transfer - we now know our residue */
 	dmaengine_terminate_all(rxchan);
@@ -1072,16 +1067,16 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	unsigned long flags;
 	unsigned int dmataken = 0;
 	unsigned int size = 0;
-	struct pl011_sgbuf *sgbuf;
+	struct pl011_dmabuf *dbuf;
 	int dma_count;
 	struct dma_tx_state state;
 
-	sgbuf = dmarx->use_buf_b ? &uap->dmarx.sgbuf_b : &uap->dmarx.sgbuf_a;
+	dbuf = dmarx->use_buf_b ? &uap->dmarx.dbuf_b : &uap->dmarx.dbuf_a;
 	rxchan->device->device_tx_status(rxchan, dmarx->cookie, &state);
 	if (likely(state.residue < dmarx->last_residue)) {
-		dmataken = sgbuf->sg.length - dmarx->last_residue;
+		dmataken = dbuf->len - dmarx->last_residue;
 		size = dmarx->last_residue - state.residue;
-		dma_count = tty_insert_flip_string(port, sgbuf->buf + dmataken,
+		dma_count = tty_insert_flip_string(port, dbuf->buf + dmataken,
 				size);
 		if (dma_count == size)
 			dmarx->last_residue =  state.residue;
@@ -1128,7 +1123,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		return;
 	}
 
-	sg_init_one(&uap->dmatx.sg, uap->dmatx.buf, PL011_DMA_BUFFER_SIZE);
+	uap->dmatx.len = PL011_DMA_BUFFER_SIZE;
 
 	/* The DMA buffer is now the FIFO the TTY subsystem can use */
 	uap->port.fifosize = PL011_DMA_BUFFER_SIZE;
@@ -1138,7 +1133,7 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 
 	/* Allocate and map DMA RX buffers */
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
@@ -1146,12 +1141,12 @@ static void pl011_dma_startup(struct uart_amba_port *uap)
 		goto skip_rx;
 	}
 
-	ret = pl011_sgbuf_init(uap->dmarx.chan, &uap->dmarx.sgbuf_b,
+	ret = pl011_dmabuf_init(uap->dmarx.chan, &uap->dmarx.dbuf_b,
 			       DMA_FROM_DEVICE);
 	if (ret) {
 		dev_err(uap->port.dev, "failed to init DMA %s: %d\n",
 			"RX buffer B", ret);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a,
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a,
 				 DMA_FROM_DEVICE);
 		goto skip_rx;
 	}
@@ -1205,8 +1200,9 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
 		dmaengine_terminate_all(uap->dmatx.chan);
 		if (uap->dmatx.queued) {
-			dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
-				     DMA_TO_DEVICE);
+			dma_unmap_single(uap->dmatx.chan->device->dev,
+					 uap->dmatx.dma, uap->dmatx.len,
+					 DMA_TO_DEVICE);
 			uap->dmatx.queued = false;
 		}
 
@@ -1217,8 +1213,8 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	if (uap->using_rx_dma) {
 		dmaengine_terminate_all(uap->dmarx.chan);
 		/* Clean up the RX DMA */
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_a, DMA_FROM_DEVICE);
-		pl011_sgbuf_free(uap->dmarx.chan, &uap->dmarx.sgbuf_b, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_a, DMA_FROM_DEVICE);
+		pl011_dmabuf_free(uap->dmarx.chan, &uap->dmarx.dbuf_b, DMA_FROM_DEVICE);
 		if (uap->dmarx.poll_rate)
 			del_timer_sync(&uap->dmarx.timer);
 		uap->using_rx_dma = false;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e8f8a94ad606..adaccbdc10c3 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -694,6 +694,18 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		case SC16IS7XX_IIR_RTOI_SRC:
 		case SC16IS7XX_IIR_XOFFI_SRC:
 			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+
+			/*
+			 * There is a silicon bug that makes the chip report a
+			 * time-out interrupt but no data in the FIFO. This is
+			 * described in errata section 18.1.4.
+			 *
+			 * When this happens, read one byte from the FIFO to
+			 * clear the interrupt.
+			 */
+			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+				rxlen = 1;
+
 			if (rxlen)
 				sc16is7xx_handle_rx(port, rxlen, iir);
 			break;
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 6be6009f911e..f1ca9250cad9 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -88,6 +88,7 @@ static void hidg_release(struct device *dev)
 {
 	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
 
+	kfree(hidg->report_desc);
 	kfree(hidg->set_report_buf);
 	kfree(hidg);
 }
@@ -1287,9 +1288,9 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->report_length = opts->report_length;
 	hidg->report_desc_length = opts->report_desc_length;
 	if (opts->report_desc) {
-		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
-						 opts->report_desc_length,
-						 GFP_KERNEL);
+		hidg->report_desc = kmemdup(opts->report_desc,
+					    opts->report_desc_length,
+					    GFP_KERNEL);
 		if (!hidg->report_desc) {
 			put_device(&hidg->dev);
 			--opts->refcnt;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index af5b5b4fa5d1..f501eb3efca7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -349,8 +349,6 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-	else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
-		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 339752fef65e..ea86195c75b8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -265,7 +265,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -495,7 +495,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e748c00789f0..46c72e6d3a29 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2178,13 +2178,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 	struct mlx5_control_vq *cvq = &mvdev->cvq;
 	int err = 0;
 
-	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
+	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
+		u16 idx = cvq->vring.last_avail_idx;
+
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
 					MLX5_CVQ_MAX_ENT, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
 
+		if (!err)
+			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
+	}
 	return err;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 24d10b541a13..f0654fe80b34 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3204,7 +3204,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 718119e3830d..2fd0ee0e6e93 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -337,10 +337,7 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-
-	btrfs_info(fs_info, "last unmount of filesystem %pU", fs_info->fs_devices->fsid);
-	close_ctree(fs_info);
+	close_ctree(btrfs_sb(sb));
 }
 
 enum {
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index af688e39f31a..9bbead15a028 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1144,7 +1144,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	unsigned int xid;
 	int rc;
 
-	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
+	if (remap_flags & REMAP_FILE_DEDUP)
+		return -EOPNOTSUPP;
+	if (remap_flags & ~REMAP_FILE_ADVISORY)
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clone range\n");
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index d8ce079ba909..7c2ecbb17f54 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2926,6 +2926,8 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 		usleep_range(512, 2048);
 	} while (++retry_count < 5);
 
+	if (!rc && !dfs_rsp)
+		rc = -EIO;
 	if (rc) {
 		if (!is_retryable_error(rc) && rc != -ENOENT && rc != -EOPNOTSUPP)
 			cifs_tcon_dbg(VFS, "%s: ioctl error: rc=%d\n", __func__, rc);
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index b3abe69382fd..23b4b8863e7f 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -501,15 +501,38 @@ int nilfs_sufile_mark_dirty(struct inode *sufile, __u64 segnum)
 
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	ret = nilfs_sufile_get_segment_usage_block(sufile, segnum, 0, &bh);
-	if (!ret) {
-		mark_buffer_dirty(bh);
-		nilfs_mdt_mark_dirty(sufile);
-		kaddr = kmap_atomic(bh->b_page);
-		su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (ret)
+		goto out_sem;
+
+	kaddr = kmap_atomic(bh->b_page);
+	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
+	if (unlikely(nilfs_segment_usage_error(su))) {
+		struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+
+		kunmap_atomic(kaddr);
+		brelse(bh);
+		if (nilfs_segment_is_active(nilfs, segnum)) {
+			nilfs_error(sufile->i_sb,
+				    "active segment %llu is erroneous",
+				    (unsigned long long)segnum);
+		} else {
+			/*
+			 * Segments marked erroneous are never allocated by
+			 * nilfs_sufile_alloc(); only active segments, ie,
+			 * the segments indexed by ns_segnum or ns_nextnum,
+			 * can be erroneous here.
+			 */
+			WARN_ON_ONCE(1);
+		}
+		ret = -EIO;
+	} else {
 		nilfs_segment_usage_set_dirty(su);
 		kunmap_atomic(kaddr);
+		mark_buffer_dirty(bh);
+		nilfs_mdt_mark_dirty(sufile);
 		brelse(bh);
 	}
+out_sem:
 	up_write(&NILFS_MDT(sufile)->mi_sem);
 	return ret;
 }
@@ -536,9 +559,14 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 
 	kaddr = kmap_atomic(bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, bh, kaddr);
-	WARN_ON(nilfs_segment_usage_error(su));
-	if (modtime)
+	if (modtime) {
+		/*
+		 * Check segusage error and set su_lastmod only when updating
+		 * this entry with a valid timestamp, not for cancellation.
+		 */
+		WARN_ON_ONCE(nilfs_segment_usage_error(su));
 		su->su_lastmod = cpu_to_le64(modtime);
+	}
 	su->su_nblocks = cpu_to_le32(nblocks);
 	kunmap_atomic(kaddr);
 
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index fe2e7197268b..a07e20147abc 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -717,7 +717,11 @@ int init_nilfs(struct the_nilfs *nilfs, struct super_block *sb, char *data)
 			goto failed_sbh;
 		}
 		nilfs_release_super_block(nilfs);
-		sb_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize)) {
+			nilfs_err(sb, "bad blocksize %d", blocksize);
+			err = -EINVAL;
+			goto out;
+		}
 
 		err = nilfs_load_super_block(nilfs, sb, blocksize, &sbp);
 		if (err)
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index c7156bb56e83..c1ecc843b97d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -193,6 +193,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
 	CPUHP_AP_SMPCFD_DYING,
+	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..f2044d5a652b 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -531,9 +531,9 @@ extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
-int hrtimers_dead_cpu(unsigned int cpu);
+int hrtimers_cpu_dying(unsigned int cpu);
 #else
-#define hrtimers_dead_cpu	NULL
+#define hrtimers_cpu_dying	NULL
 #endif
 
 #endif
diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index a1d6fc82d7f0..eae9f423bd64 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -74,11 +74,11 @@ static inline void *dereference_symbol_descriptor(void *ptr)
 	return ptr;
 }
 
+#ifdef CONFIG_KALLSYMS
 int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 				      unsigned long),
 			    void *data);
 
-#ifdef CONFIG_KALLSYMS
 /* Lookup the address for a symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name);
 
@@ -172,6 +172,11 @@ static inline bool kallsyms_show_value(const struct cred *cred)
 	return false;
 }
 
+static inline int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
+					  unsigned long), void *data)
+{
+	return -EOPNOTSUPP;
+}
 #endif /*CONFIG_KALLSYMS*/
 
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 2cbb6a51c291..24b0eaa5de30 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -139,7 +139,7 @@ static inline int kprobe_ftrace(struct kprobe *p)
  *
  */
 struct kretprobe_holder {
-	struct kretprobe	*rp;
+	struct kretprobe __rcu *rp;
 	refcount_t		ref;
 };
 
@@ -224,10 +224,7 @@ unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
 
 static nokprobe_inline struct kretprobe *get_kretprobe(struct kretprobe_instance *ri)
 {
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held(),
-		"Kretprobe is accessed from instance under preemptive context");
-
-	return READ_ONCE(ri->rph->rp);
+	return rcu_dereference_check(ri->rph->rp, rcu_read_lock_any_held());
 }
 
 #else /* CONFIG_KRETPROBES */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index dbf6ba59fbd0..200995c5210e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -750,6 +750,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 17dc5cb6f3f2..1b20b5e7a76b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
 #define ASUS_WMI_DEVID_CAMERA		0x00060013
 #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
+#define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
 
 /* Storage */
 #define ASUS_WMI_DEVID_CARDREADER	0x00080013
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 24bc3f7967c3..a266e1152522 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -172,6 +172,7 @@ struct stmmac_fpe_cfg {
 	bool hs_enable;				/* FPE handshake enable */
 	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
 	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
+	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
 };
 
 struct stmmac_safety_feature_cfg {
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 7cb3fa8310ed..8043594a7f84 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -11,10 +11,13 @@
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
+ * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
+ * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
 	u8			flags;
+	u8			cap_sys_admin:1;
 };
 
 struct genl_ops;
@@ -116,7 +119,7 @@ enum genl_validate_flags {
  * struct genl_small_ops - generic netlink operations (small version)
  * @cmd: command identifier
  * @internal_flags: flags used by the family
- * @flags: flags
+ * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
  * @validate: validation flags from enum genl_validate_flags
  * @doit: standard command callback
  * @dumpit: callback for dumpers
@@ -137,7 +140,7 @@ struct genl_small_ops {
  * struct genl_ops - generic netlink operations
  * @cmd: command identifier
  * @internal_flags: flags used by the family
- * @flags: flags
+ * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
  * @maxattr: maximum number of attributes supported
  * @policy: netlink policy (takes precedence over family policy)
  * @validate: validation flags from enum genl_validate_flags
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 5ae9dff74dac..2381e482fab3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -77,6 +77,13 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
 {
 	__rdma_block_iter_start(biter, umem->sgt_append.sgt.sgl,
 				umem->sgt_append.sgt.nents, pgsz);
+	biter->__sg_advance = ib_umem_offset(umem) & ~(pgsz - 1);
+	biter->__sg_numblocks = ib_umem_num_dma_blocks(umem, pgsz);
+}
+
+static inline bool __rdma_umem_block_iter_next(struct ib_block_iter *biter)
+{
+	return __rdma_block_iter_next(biter) && biter->__sg_numblocks--;
 }
 
 /**
@@ -92,7 +99,7 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
  */
 #define rdma_umem_for_each_dma_block(umem, biter, pgsz)                        \
 	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
-	     __rdma_block_iter_next(biter);)
+	     __rdma_umem_block_iter_next(biter);)
 
 #ifdef CONFIG_INFINIBAND_USER_MEM
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4ba642fc8a19..fa13bf15feb3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2817,6 +2817,7 @@ struct ib_block_iter {
 	/* internal states */
 	struct scatterlist *__sg;	/* sg holding the current aligned block */
 	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
+	size_t __sg_numblocks;		/* ib_umem_num_dma_blocks() */
 	unsigned int __sg_nents;	/* number of SG entries */
 	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
 	unsigned int __pg_bit;		/* alignment of current block */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index a7fb8d2b7709..25bc59231961 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -301,6 +301,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -308,6 +309,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -317,8 +319,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5b2dbd3dc2de..30535d4edee7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2601,6 +2601,7 @@ static void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 	if (!(ctx->flags & IORING_SETUP_IOPOLL))
 		return;
 
+	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
 	while (!list_empty(&ctx->iopoll_list)) {
 		unsigned int nr_events = 0;
@@ -2622,6 +2623,7 @@ static void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 		}
 	}
 	mutex_unlock(&ctx->uring_lock);
+	percpu_ref_put(&ctx->refs);
 }
 
 static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
@@ -8625,49 +8627,6 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	return ret;
 }
 
-static int io_sqe_file_register(struct io_ring_ctx *ctx, struct file *file,
-				int index)
-{
-#if defined(CONFIG_UNIX)
-	struct sock *sock = ctx->ring_sock->sk;
-	struct sk_buff_head *head = &sock->sk_receive_queue;
-	struct sk_buff *skb;
-
-	/*
-	 * See if we can merge this file into an existing skb SCM_RIGHTS
-	 * file set. If there's no room, fall back to allocating a new skb
-	 * and filling it in.
-	 */
-	spin_lock_irq(&head->lock);
-	skb = skb_peek(head);
-	if (skb) {
-		struct scm_fp_list *fpl = UNIXCB(skb).fp;
-
-		if (fpl->count < SCM_MAX_FD) {
-			__skb_unlink(skb, head);
-			spin_unlock_irq(&head->lock);
-			fpl->fp[fpl->count] = get_file(file);
-			unix_inflight(fpl->user, fpl->fp[fpl->count]);
-			fpl->count++;
-			spin_lock_irq(&head->lock);
-			__skb_queue_head(head, skb);
-		} else {
-			skb = NULL;
-		}
-	}
-	spin_unlock_irq(&head->lock);
-
-	if (skb) {
-		fput(file);
-		return 0;
-	}
-
-	return __io_sqe_files_scm(ctx, 1, index);
-#else
-	return 0;
-#endif
-}
-
 static int io_queue_rsrc_removal(struct io_rsrc_data *data, unsigned idx,
 				 struct io_rsrc_node *node, void *rsrc)
 {
@@ -8725,12 +8684,6 @@ static int io_install_fixed_file(struct io_kiocb *req, struct file *file,
 
 	*io_get_tag_slot(ctx->file_data, slot_index) = 0;
 	io_fixed_file_set(file_slot, file);
-	ret = io_sqe_file_register(ctx, file, slot_index);
-	if (ret) {
-		file_slot->file_ptr = 0;
-		goto err;
-	}
-
 	ret = 0;
 err:
 	if (needs_switch)
@@ -8844,12 +8797,6 @@ static int __io_sqe_files_update(struct io_ring_ctx *ctx,
 			}
 			*io_get_tag_slot(data, i) = tag;
 			io_fixed_file_set(file_slot, file);
-			err = io_sqe_file_register(ctx, file, i);
-			if (err) {
-				file_slot->file_ptr = 0;
-				fput(file);
-				break;
-			}
 		}
 	}
 
@@ -9771,12 +9718,7 @@ static void io_ring_exit_work(struct work_struct *work)
 	init_completion(&exit.completion);
 	init_task_work(&exit.task_work, io_tctx_exit_cb);
 	exit.ctx = ctx;
-	/*
-	 * Some may use context even when all refs and requests have been put,
-	 * and they are free to do so while still holding uring_lock or
-	 * completion_lock, see io_req_task_submit(). Apart from other work,
-	 * this lock/unlock section also waits them to finish.
-	 */
+
 	mutex_lock(&ctx->uring_lock);
 	while (!list_empty(&ctx->tctx_list)) {
 		WARN_ON_ONCE(time_after(jiffies, timeout));
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 393114c10c28..0e786de993e0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1697,7 +1697,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	[CPUHP_HRTIMERS_PREPARE] = {
 		.name			= "hrtimers:prepare",
 		.startup.single		= hrtimers_prepare_cpu,
-		.teardown.single	= hrtimers_dead_cpu,
+		.teardown.single	= NULL,
 	},
 	[CPUHP_SMPCFD_PREPARE] = {
 		.name			= "smpcfd:prepare",
@@ -1764,6 +1764,12 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 		.startup.single		= NULL,
 		.teardown.single	= smpcfd_dying_cpu,
 	},
+	[CPUHP_AP_HRTIMERS_DYING] = {
+		.name			= "hrtimers:dying",
+		.startup.single		= NULL,
+		.teardown.single	= hrtimers_cpu_dying,
+	},
+
 	/* Entry state on starting. Interrupts enabled from here on. Transient
 	 * state for synchronsization */
 	[CPUHP_AP_ONLINE] = {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8e1290340aaf..521d64b355ef 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1899,28 +1899,34 @@ static inline void perf_event__state_init(struct perf_event *event)
 					      PERF_EVENT_STATE_INACTIVE;
 }
 
-static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
+static int __perf_event_read_size(u64 read_format, int nr_siblings)
 {
 	int entry = sizeof(u64); /* value */
 	int size = 0;
 	int nr = 1;
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		size += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_ID)
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_LOST)
 		entry += sizeof(u64);
 
-	if (event->attr.read_format & PERF_FORMAT_GROUP) {
+	if (read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
 	}
 
-	size += entry * nr;
-	event->read_size = size;
+	/*
+	 * Since perf_event_validate_size() limits this to 16k and inhibits
+	 * adding more siblings, this will never overflow.
+	 */
+	return size + nr * entry;
 }
 
 static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
@@ -1970,8 +1976,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
  */
 static void perf_event__header_size(struct perf_event *event)
 {
-	__perf_event_read_size(event,
-			       event->group_leader->nr_siblings);
+	event->read_size =
+		__perf_event_read_size(event->attr.read_format,
+				       event->group_leader->nr_siblings);
 	__perf_event_header_size(event, event->attr.sample_type);
 }
 
@@ -2002,24 +2009,35 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
+/*
+ * Check that adding an event to the group does not result in anybody
+ * overflowing the 64k event limit imposed by the output buffer.
+ *
+ * Specifically, check that the read_size for the event does not exceed 16k,
+ * read_size being the one term that grows with groups size. Since read_size
+ * depends on per-event read_format, also (re)check the existing events.
+ *
+ * This leaves 48k for the constant size fields and things like callchains,
+ * branch stacks and register sets.
+ */
 static bool perf_event_validate_size(struct perf_event *event)
 {
-	/*
-	 * The values computed here will be over-written when we actually
-	 * attach the event.
-	 */
-	__perf_event_read_size(event, event->group_leader->nr_siblings + 1);
-	__perf_event_header_size(event, event->attr.sample_type & ~PERF_SAMPLE_READ);
-	perf_event__id_header_size(event);
+	struct perf_event *sibling, *group_leader = event->group_leader;
 
-	/*
-	 * Sum the lot; should not exceed the 64k limit we have on records.
-	 * Conservative limit to allow for callchains and other variable fields.
-	 */
-	if (event->read_size + event->header_size +
-	    event->id_header_size + sizeof(struct perf_event_header) >= 16*1024)
+	if (__perf_event_read_size(event->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
+		return false;
+
+	if (__perf_event_read_size(group_leader->attr.read_format,
+				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	for_each_sibling_event(sibling, group_leader) {
+		if (__perf_event_read_size(sibling->attr.read_format,
+					   group_leader->nr_siblings + 1) > 16*1024)
+			return false;
+	}
+
 	return true;
 }
 
@@ -5431,11 +5449,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
 unlock:
@@ -5489,7 +5511,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5499,6 +5521,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -7059,7 +7083,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -7073,6 +7097,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -7083,7 +7109,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -7101,6 +7127,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -7114,6 +7142,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 6808873555f0..45965f13757e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..e0d9f77cf2d4 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -204,7 +204,6 @@ unsigned long kallsyms_lookup_name(const char *name)
 	return module_kallsyms_lookup_name(name);
 }
 
-#ifdef CONFIG_LIVEPATCH
 /*
  * Iterate over all symbols in vmlinux.  For symbols from modules use
  * module_kallsyms_on_each_symbol instead.
@@ -226,7 +225,6 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 	}
 	return 0;
 }
-#endif /* CONFIG_LIVEPATCH */
 
 static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6cf561322bbe..07d36cee2a80 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2044,7 +2044,7 @@ int register_kretprobe(struct kretprobe *rp)
 	if (!rp->rph)
 		return -ENOMEM;
 
-	rp->rph->rp = rp;
+	rcu_assign_pointer(rp->rph->rp, rp);
 	for (i = 0; i < rp->maxactive; i++) {
 		inst = kzalloc(sizeof(struct kretprobe_instance) +
 			       rp->data_size, GFP_KERNEL);
@@ -2101,7 +2101,7 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 	for (i = 0; i < num; i++) {
 		if (__unregister_kprobe_top(&rps[i]->kp) < 0)
 			rps[i]->kp.addr = NULL;
-		rps[i]->rph->rp = NULL;
+		rcu_assign_pointer(rps[i]->rph->rp, NULL);
 	}
 	mutex_unlock(&kprobe_mutex);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 97409581e9da..eebd0f31daa8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2216,29 +2216,22 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 	}
 }
 
-int hrtimers_dead_cpu(unsigned int scpu)
+int hrtimers_cpu_dying(unsigned int dying_cpu)
 {
 	struct hrtimer_cpu_base *old_base, *new_base;
-	int i;
+	int i, ncpu = cpumask_first(cpu_active_mask);
 
-	BUG_ON(cpu_online(scpu));
-	tick_cancel_sched_timer(scpu);
+	tick_cancel_sched_timer(dying_cpu);
+
+	old_base = this_cpu_ptr(&hrtimer_bases);
+	new_base = &per_cpu(hrtimer_bases, ncpu);
 
-	/*
-	 * this BH disable ensures that raise_softirq_irqoff() does
-	 * not wakeup ksoftirqd (and acquire the pi-lock) while
-	 * holding the cpu_base lock
-	 */
-	local_bh_disable();
-	local_irq_disable();
-	old_base = &per_cpu(hrtimer_bases, scpu);
-	new_base = this_cpu_ptr(&hrtimer_bases);
 	/*
 	 * The caller is globally serialized and nobody else
 	 * takes two locks at once, deadlock is not possible.
 	 */
-	raw_spin_lock(&new_base->lock);
-	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
+	raw_spin_lock(&old_base->lock);
+	raw_spin_lock_nested(&new_base->lock, SINGLE_DEPTH_NESTING);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		migrate_hrtimer_list(&old_base->clock_base[i],
@@ -2249,15 +2242,13 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	 * The migration might have changed the first expiring softirq
 	 * timer on this CPU. Update it.
 	 */
-	hrtimer_update_softirq_timer(new_base, false);
+	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
+	/* Tell the other CPU to retrigger the next event */
+	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
-	raw_spin_unlock(&old_base->lock);
 	raw_spin_unlock(&new_base->lock);
+	raw_spin_unlock(&old_base->lock);
 
-	/* Check, if we got expired work to do */
-	__hrtimer_peek_ahead_timers();
-	local_irq_enable();
-	local_bh_enable();
 	return 0;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a930a9d7d834..16fce72a7601 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2982,22 +2982,19 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 			local_read(&bpage->write) & ~RB_WRITE_MASK;
 		unsigned long event_length = rb_event_length(event);
 
+		/*
+		 * For the before_stamp to be different than the write_stamp
+		 * to make sure that the next event adds an absolute
+		 * value and does not rely on the saved write stamp, which
+		 * is now going to be bogus.
+		 */
+		rb_time_set(&cpu_buffer->before_stamp, 0);
+
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
 			return 0;
 
-		/*
-		 * It's possible that the event time delta is zero
-		 * (has the same time stamp as the previous event)
-		 * in which case write_stamp and before_stamp could
-		 * be the same. In such a case, force before_stamp
-		 * to be different than write_stamp. It doesn't
-		 * matter what it is, as long as its different.
-		 */
-		if (!delta)
-			rb_time_set(&cpu_buffer->before_stamp, 0);
-
 		/*
 		 * If an event were to come in now, it would see that the
 		 * write_stamp and the before_stamp are different, and assume
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c35c805e4ab1..657ecb8f0354 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2284,13 +2284,7 @@ int is_tracing_stopped(void)
 	return global_trace.stop_count;
 }
 
-/**
- * tracing_start - quick start of the tracer
- *
- * If tracing is enabled but was stopped by tracing_stop,
- * this will start the tracer back up.
- */
-void tracing_start(void)
+static void tracing_start_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
 	unsigned long flags;
@@ -2298,119 +2292,83 @@ void tracing_start(void)
 	if (tracing_disabled)
 		return;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (--global_trace.stop_count) {
-		if (global_trace.stop_count < 0) {
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (--tr->stop_count) {
+		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			global_trace.stop_count = 0;
+			tr->stop_count = 0;
 		}
 		goto out;
 	}
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
-}
-
-static void tracing_start_tr(struct trace_array *tr)
-{
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	if (tracing_disabled)
-		return;
-
-	/* If global, we need to also start the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_start();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-
-	if (--tr->stop_count) {
-		if (tr->stop_count < 0) {
-			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			tr->stop_count = 0;
-		}
-		goto out;
-	}
-
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_enable(buffer);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
 	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
- * tracing_stop - quick stop of the tracer
+ * tracing_start - quick start of the tracer
  *
- * Light weight way to stop tracing. Use in conjunction with
- * tracing_start.
+ * If tracing is enabled but was stopped by tracing_stop,
+ * this will start the tracer back up.
  */
-void tracing_stop(void)
+void tracing_start(void)
+
+{
+	return tracing_start_tr(&global_trace);
+}
+
+static void tracing_stop_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (global_trace.stop_count++)
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (tr->stop_count++)
 		goto out;
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.array_buffer.buffer;
+	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
+	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
-static void tracing_stop_tr(struct trace_array *tr)
+/**
+ * tracing_stop - quick stop of the tracer
+ *
+ * Light weight way to stop tracing. Use in conjunction with
+ * tracing_start.
+ */
+void tracing_stop(void)
 {
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	/* If global, we need to also stop the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_stop();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-	if (tr->stop_count++)
-		goto out;
-
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
+	return tracing_stop_tr(&global_trace);
 }
 
 static int trace_save_cmdline(struct task_struct *tsk)
@@ -2692,8 +2650,11 @@ void trace_buffered_event_enable(void)
 	for_each_tracing_cpu(cpu) {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_NORETRY, 0);
-		if (!page)
-			goto failed;
+		/* This is just an optimization and can handle failures */
+		if (!page) {
+			pr_err("Failed to allocate event buffer\n");
+			break;
+		}
 
 		event = page_address(page);
 		memset(event, 0, sizeof(*event));
@@ -2707,10 +2668,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
@@ -2745,11 +2702,9 @@ void trace_buffered_event_disable(void)
 	if (--trace_buffered_event_ref)
 		return;
 
-	preempt_disable();
 	/* For each CPU, set the buffer as used. */
-	smp_call_function_many(tracing_buffer_mask,
-			       disable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	on_each_cpu_mask(tracing_buffer_mask, disable_trace_buffered_event,
+			 NULL, true);
 
 	/* Wait for all current users to finish */
 	synchronize_rcu();
@@ -2758,17 +2713,19 @@ void trace_buffered_event_disable(void)
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
+
 	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
+	 * Wait for all CPUs that potentially started checking if they can use
+	 * their event buffer only after the previous synchronize_rcu() call and
+	 * they still read a valid pointer from trace_buffered_event. It must be
+	 * ensured they don't see cleared trace_buffered_event_cnt else they
+	 * could wrongly decide to use the pointed-to buffer which is now freed.
 	 */
-	smp_wmb();
+	synchronize_rcu();
 
-	preempt_disable();
-	/* Do the work on each cpu */
-	smp_call_function_many(tracing_buffer_mask,
-			       enable_trace_buffered_event, NULL, 1);
-	preempt_enable();
+	/* For each CPU, relinquish the buffer */
+	on_each_cpu_mask(tracing_buffer_mask, enable_trace_buffered_event, NULL,
+			 true);
 }
 
 static struct trace_buffer *temp_buffer;
@@ -6233,6 +6190,15 @@ static void set_buffer_entries(struct array_buffer *buf, unsigned long val)
 		per_cpu_ptr(buf->data, cpu)->entries = val;
 }
 
+static void update_buffer_entries(struct array_buffer *buf, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
+	} else {
+		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
+	}
+}
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /* resize @tr's buffer to the size of @size_tr's entries */
 static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
@@ -6277,13 +6243,15 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
+	/* Do not allow tracing while resizng ring buffer */
+	tracing_stop_tr(tr);
+
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
 	if (ret < 0)
-		return ret;
+		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!(tr->flags & TRACE_ARRAY_FL_GLOBAL) ||
-	    !tr->current_trace->use_max_tr)
+	if (!tr->current_trace->use_max_tr)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
@@ -6308,22 +6276,17 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 			WARN_ON(1);
 			tracing_disabled = 1;
 		}
-		return ret;
+		goto out_start;
 	}
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->max_buffer, size);
-	else
-		per_cpu_ptr(tr->max_buffer.data, cpu)->entries = size;
+	update_buffer_entries(&tr->max_buffer, cpu);
 
  out:
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->array_buffer, size);
-	else
-		per_cpu_ptr(tr->array_buffer.data, cpu)->entries = size;
-
+	update_buffer_entries(&tr->array_buffer, cpu);
+ out_start:
+	tracing_start_tr(tr);
 	return ret;
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 81e28722edfa..84a5b0213e0e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3209,7 +3209,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	    }
 	}
 
-	if (pmd_none(*vmf->pmd)) {
+	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte) {
 		vmf->ptl = pmd_lock(mm, vmf->pmd);
 		if (likely(pmd_none(*vmf->pmd))) {
 			mm_inc_nr_ptes(mm);
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 22015ebc1dd5..937d74aeef54 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -184,7 +184,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -1618,11 +1618,13 @@ static const struct genl_small_ops dropmon_ops[] = {
 		.cmd = NET_DM_CMD_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_CONFIG_GET,
diff --git a/net/core/filter.c b/net/core/filter.c
index 76432aa3b717..0f5faa876fd1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2576,6 +2576,22 @@ BPF_CALL_2(bpf_msg_cork_bytes, struct sk_msg *, msg, u32, bytes)
 	return 0;
 }
 
+static void sk_msg_reset_curr(struct sk_msg *msg)
+{
+	u32 i = msg->sg.start;
+	u32 len = 0;
+
+	do {
+		len += sk_msg_elem(msg, i)->length;
+		sk_msg_iter_var_next(i);
+		if (len >= msg->sg.size)
+			break;
+	} while (i != msg->sg.end);
+
+	msg->sg.curr = i;
+	msg->sg.copybreak = 0;
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2695,6 +2711,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
 out:
+	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
 	msg->data_end = msg->data + bytes;
 	return 0;
@@ -2831,6 +2848,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 		msg->sg.data[new] = rsge;
 	}
 
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
@@ -2999,6 +3017,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 
 	sk_mem_uncharge(msg->sk, len - pop);
 	msg->sg.size -= (len - pop);
+	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
 	return 0;
 }
diff --git a/net/core/scm.c b/net/core/scm.c
index acb7d776fa6e..e762a4b8a1d2 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -26,6 +26,7 @@
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
+#include <linux/io_uring.h>
 
 #include <linux/uaccess.h>
 
@@ -103,6 +104,11 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
+		/* don't allow io_uring files */
+		if (io_uring_get_socket(file)) {
+			fput(file);
+			return -EINVAL;
+		}
 		*fpp++ = file;
 		fpl->count++;
 	}
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index c094963a86f1..5d17e5f5d090 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -634,15 +634,18 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->header_ops) {
+		int pull_len = tunnel->hlen + sizeof(struct iphdr);
+
 		if (skb_cow_head(skb, 0))
 			goto free_skb;
 
 		tnl_params = (const struct iphdr *)skb->data;
 
-		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
-		 * to gre header.
-		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!pskb_network_may_pull(skb, pull_len))
+			goto free_skb;
+
+		/* ip_tunnel_xmit() needs skb->data pointing to gre header. */
+		skb_pull(skb, pull_len);
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a3453b4ac339..e51b5d887c24 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3796,8 +3796,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * then we can probably ignore it.
 	 */
 	if (before(ack, prior_snd_una)) {
+		u32 max_window;
+
+		/* do not accept ACK for bytes we never sent. */
+		max_window = min_t(u64, tp->max_window, tp->bytes_acked);
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
-		if (before(ack, prior_snd_una - tp->max_window)) {
+		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
 				tcp_send_challenge_ack(sk, skb);
 			return -1;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a506e57c4032..7e0a30380be0 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1501,13 +1501,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			if (!pn_leaf && !(pn->fn_flags & RTN_RTINFO)) {
 				pn_leaf = fib6_find_prefix(info->nl_net, table,
 							   pn);
-#if RT6_DEBUG >= 2
-				if (!pn_leaf) {
-					WARN_ON(!pn_leaf);
+				if (!pn_leaf)
 					pn_leaf =
 					    info->nl_net->ipv6.fib6_null_entry;
-				}
-#endif
 				fib6_info_hold(pn_leaf);
 				rcu_assign_pointer(pn->leaf, pn_leaf);
 			}
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 33869db42bb6..978014928d07 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -61,6 +61,8 @@ MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 	ip_set_dereference((inst)->ip_set_list)[id]
 #define ip_set_ref_netlink(inst,id)	\
 	rcu_dereference_raw((inst)->ip_set_list)[id]
+#define ip_set_dereference_nfnl(p)	\
+	rcu_dereference_check(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -708,15 +710,10 @@ __ip_set_put_netlink(struct ip_set *set)
 static struct ip_set *
 ip_set_rcu_get(struct net *net, ip_set_id_t index)
 {
-	struct ip_set *set;
 	struct ip_set_net *inst = ip_set_pernet(net);
 
-	rcu_read_lock();
-	/* ip_set_list itself needs to be protected */
-	set = rcu_dereference(inst->ip_set_list)[index];
-	rcu_read_unlock();
-
-	return set;
+	/* ip_set_list and the set pointer need to be protected */
+	return ip_set_dereference_nfnl(inst->ip_set_list)[index];
 }
 
 static inline void
@@ -1399,6 +1396,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 	ip_set(inst, to_id) = from;
 	write_unlock_bh(&ip_set_ref_lock);
 
+	/* Make sure all readers of the old set pointers are completed. */
+	synchronize_rcu();
+
 	return 0;
 }
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index bf0bd44f2fb3..20c2b4f5e893 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -753,7 +753,7 @@ static struct nft_table *nft_table_lookup(const struct net *net,
 
 static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 						   const struct nlattr *nla,
-						   u8 genmask, u32 nlpid)
+						   int family, u8 genmask, u32 nlpid)
 {
 	struct nftables_pernet *nft_net;
 	struct nft_table *table;
@@ -761,6 +761,7 @@ static struct nft_table *nft_table_lookup_byhandle(const struct net *net,
 	nft_net = nft_pernet(net);
 	list_for_each_entry(table, &nft_net->tables, list) {
 		if (be64_to_cpu(nla_get_be64(nla)) == table->handle &&
+		    table->family == family &&
 		    nft_active_genmask(table, genmask)) {
 			if (nft_table_has_owner(table) &&
 			    nlpid && table->nlpid != nlpid)
@@ -1458,7 +1459,7 @@ static int nf_tables_deltable(struct sk_buff *skb, const struct nfnl_info *info,
 
 	if (nla[NFTA_TABLE_HANDLE]) {
 		attr = nla[NFTA_TABLE_HANDLE];
-		table = nft_table_lookup_byhandle(net, attr, genmask,
+		table = nft_table_lookup_byhandle(net, attr, family, genmask,
 						  NETLINK_CB(skb).portid);
 	} else {
 		attr = nla[NFTA_TABLE_NAME];
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 73e606372b05..e714e0efa736 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -279,10 +279,15 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 			priv->expr_array[i] = dynset_expr;
 			priv->num_exprs++;
 
-			if (set->num_exprs &&
-			    dynset_expr->ops != set->exprs[i]->ops) {
-				err = -EOPNOTSUPP;
-				goto err_expr_free;
+			if (set->num_exprs) {
+				if (i >= set->num_exprs) {
+					err = -EINVAL;
+					goto err_expr_free;
+				}
+				if (dynset_expr->ops != set->exprs[i]->ops) {
+					err = -EOPNOTSUPP;
+					goto err_expr_free;
+				}
 			}
 			i++;
 		}
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index deea6196d992..4e1cc31729b8 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2042,6 +2042,9 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		e = f->mt[r].e;
 
+		if (!nft_set_elem_active(&e->ext, iter->genmask))
+			goto cont;
+
 		elem.priv = e;
 
 		iter->err = iter->fn(ctx, set, iter, &elem);
diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index e85ce69924ae..50332888c8d2 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,18 +76,23 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	filp = sk->sk_socket->file;
-	if (filp == NULL)
+	read_lock_bh(&sk->sk_callback_lock);
+	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
+	if (filp == NULL) {
+		read_unlock_bh(&sk->sk_callback_lock);
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -112,10 +117,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 57010927e20a..69b3a6b82f68 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1379,6 +1379,9 @@ static int genl_bind(struct net *net, int group)
 		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
+		if (grp->cap_sys_admin &&
+		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
+			ret = -EPERM;
 
 		break;
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 62c0fbb9de81..e7b54f721411 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4244,7 +4244,7 @@ static void packet_mm_open(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_inc(&pkt_sk(sk)->mapped);
+		atomic_long_inc(&pkt_sk(sk)->mapped);
 }
 
 static void packet_mm_close(struct vm_area_struct *vma)
@@ -4254,7 +4254,7 @@ static void packet_mm_close(struct vm_area_struct *vma)
 	struct sock *sk = sock->sk;
 
 	if (sk)
-		atomic_dec(&pkt_sk(sk)->mapped);
+		atomic_long_dec(&pkt_sk(sk)->mapped);
 }
 
 static const struct vm_operations_struct packet_mmap_ops = {
@@ -4349,7 +4349,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	if (!closing) {
-		if (atomic_read(&po->mapped))
+		if (atomic_long_read(&po->mapped))
 			goto out;
 		if (packet_read_pending(rb))
 			goto out;
@@ -4452,7 +4452,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
-	if (closing || atomic_read(&po->mapped) == 0) {
+	if (closing || atomic_long_read(&po->mapped) == 0) {
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4470,9 +4470,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		po->prot_hook.func = (po->rx_ring.pg_vec) ?
 						tpacket_rcv : packet_rcv;
 		skb_queue_purge(rb_queue);
-		if (atomic_read(&po->mapped))
-			pr_err("packet_mmap: vma is busy: %d\n",
-			       atomic_read(&po->mapped));
+		if (atomic_long_read(&po->mapped))
+			pr_err("packet_mmap: vma is busy: %ld\n",
+			       atomic_long_read(&po->mapped));
 	}
 	mutex_unlock(&po->pg_vec_lock);
 
@@ -4550,7 +4550,7 @@ static int packet_mmap(struct file *file, struct socket *sock,
 		}
 	}
 
-	atomic_inc(&po->mapped);
+	atomic_long_inc(&po->mapped);
 	vma->vm_ops = &packet_mmap_ops;
 	err = 0;
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 3bae8ea7a36f..b2edfe6fc8e7 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -126,7 +126,7 @@ struct packet_sock {
 	__be16			num;
 	struct packet_rollover	*rollover;
 	struct packet_mclist	*mclist;
-	atomic_t		mapped;
+	atomic_long_t		mapped;
 	enum tpacket_versions	tp_version;
 	unsigned int		tp_hdrlen;
 	unsigned int		tp_reserve;
diff --git a/net/psample/psample.c b/net/psample/psample.c
index 118d5d2a81a0..0d9d9936579e 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index d2c38584ece6..758884b61f92 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -142,15 +142,11 @@ $total_size = 0;
 while (my $line = <STDIN>) {
 	if ($line =~ m/$funcre/) {
 		$func = $1;
-		next if $line !~ m/^($xs*)/;
+		next if $line !~ m/^($x*)/;
 		if ($total_size > $min_stack) {
 			push @stack, "$intro$total_size\n";
 		}
-
-		$addr = $1;
-		$addr =~ s/ /0/g;
-		$addr = "0x$addr";
-
+		$addr = "0x$1";
 		$intro = "$addr $func [$file]:";
 		my $padlen = 56 - length($intro);
 		while ($padlen > 0) {
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 5844d636d38f..7f8013dcef00 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -122,9 +122,9 @@ static long long sym_get_range_val(struct symbol *sym, int base)
 static void sym_validate_range(struct symbol *sym)
 {
 	struct property *prop;
+	struct symbol *range_sym;
 	int base;
 	long long val, val2;
-	char str[64];
 
 	switch (sym->type) {
 	case S_INT:
@@ -140,17 +140,15 @@ static void sym_validate_range(struct symbol *sym)
 	if (!prop)
 		return;
 	val = strtoll(sym->curr.val, NULL, base);
-	val2 = sym_get_range_val(prop->expr->left.sym, base);
+	range_sym = prop->expr->left.sym;
+	val2 = sym_get_range_val(range_sym, base);
 	if (val >= val2) {
-		val2 = sym_get_range_val(prop->expr->right.sym, base);
+		range_sym = prop->expr->right.sym;
+		val2 = sym_get_range_val(range_sym, base);
 		if (val <= val2)
 			return;
 	}
-	if (sym->type == S_INT)
-		sprintf(str, "%lld", val2);
-	else
-		sprintf(str, "0x%llx", val2);
-	sym->curr.val = xstrdup(str);
+	sym->curr.val = range_sym->curr.val;
 }
 
 static void sym_set_changed(struct symbol *sym)
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 977d54320a5c..1ce21677d030 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -251,6 +251,7 @@ static const char * const snd_pcm_state_names[] = {
 	STATE(DRAINING),
 	STATE(PAUSED),
 	STATE(SUSPENDED),
+	STATE(DISCONNECTED),
 };
 
 static const char * const snd_pcm_access_names[] = {
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 463e8d1eae68..1309f8775b84 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11317,6 +11317,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3364, "Lenovo ThinkCentre M90 Gen5", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 08fc1a025b1a..df86cf4f4cae 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3766,12 +3766,12 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].base_offset,
 					  &region->base_addr);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		ret = wm_adsp_buffer_read(buf, caps->region_defs[i].size_offset,
 					  &offset);
 		if (ret < 0)
-			return ret;
+			goto err;
 
 		region->cumulative_size = offset;
 
@@ -3782,6 +3782,10 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	}
 
 	return 0;
+
+err:
+	kfree(buf->regions);
+	return ret;
 }
 
 static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index d12b87e52d22..9d58f8d20f6a 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -2796,6 +2796,7 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 #define SND_DJM_850_IDX		0x2
 #define SND_DJM_900NXS2_IDX	0x3
 #define SND_DJM_750MK2_IDX	0x4
+#define SND_DJM_450_IDX		0x5
 
 
 #define SND_DJM_CTL(_name, suffix, _default_value, _windex) { \
@@ -2926,6 +2927,31 @@ static const struct snd_djm_ctl snd_djm_ctls_250mk2[] = {
 };
 
 
+// DJM-450
+static const u16 snd_djm_opts_450_cap1[] = {
+	0x0103, 0x0100, 0x0106, 0x0107, 0x0108, 0x0109, 0x010d, 0x010a };
+
+static const u16 snd_djm_opts_450_cap2[] = {
+	0x0203, 0x0200, 0x0206, 0x0207, 0x0208, 0x0209, 0x020d, 0x020a };
+
+static const u16 snd_djm_opts_450_cap3[] = {
+	0x030a, 0x0311, 0x0312, 0x0307, 0x0308, 0x0309, 0x030d };
+
+static const u16 snd_djm_opts_450_pb1[] = { 0x0100, 0x0101, 0x0104 };
+static const u16 snd_djm_opts_450_pb2[] = { 0x0200, 0x0201, 0x0204 };
+static const u16 snd_djm_opts_450_pb3[] = { 0x0300, 0x0301, 0x0304 };
+
+static const struct snd_djm_ctl snd_djm_ctls_450[] = {
+	SND_DJM_CTL("Capture Level", cap_level, 0, SND_DJM_WINDEX_CAPLVL),
+	SND_DJM_CTL("Ch1 Input",   450_cap1, 2, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch2 Input",   450_cap2, 2, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch3 Input",   450_cap3, 0, SND_DJM_WINDEX_CAP),
+	SND_DJM_CTL("Ch1 Output",   450_pb1, 0, SND_DJM_WINDEX_PB),
+	SND_DJM_CTL("Ch2 Output",   450_pb2, 1, SND_DJM_WINDEX_PB),
+	SND_DJM_CTL("Ch3 Output",   450_pb3, 2, SND_DJM_WINDEX_PB)
+};
+
+
 // DJM-750
 static const u16 snd_djm_opts_750_cap1[] = {
 	0x0101, 0x0103, 0x0106, 0x0107, 0x0108, 0x0109, 0x010a, 0x010f };
@@ -3021,6 +3047,7 @@ static const struct snd_djm_device snd_djm_devices[] = {
 	[SND_DJM_850_IDX] = SND_DJM_DEVICE(850),
 	[SND_DJM_900NXS2_IDX] = SND_DJM_DEVICE(900nxs2),
 	[SND_DJM_750MK2_IDX] = SND_DJM_DEVICE(750mk2),
+	[SND_DJM_450_IDX] = SND_DJM_DEVICE(450),
 };
 
 
@@ -3263,6 +3290,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 	case USB_ID(0x2b73, 0x0017): /* Pioneer DJ DJM-250MK2 */
 		err = snd_djm_controls_create(mixer, SND_DJM_250MK2_IDX);
 		break;
+	case USB_ID(0x2b73, 0x0013): /* Pioneer DJ DJM-450 */
+		err = snd_djm_controls_create(mixer, SND_DJM_450_IDX);
+		break;
 	case USB_ID(0x08e4, 0x017f): /* Pioneer DJ DJM-750 */
 		err = snd_djm_controls_create(mixer, SND_DJM_750_IDX);
 		break;
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index a7fb8d2b7709..25bc59231961 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -301,6 +301,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -308,6 +309,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -317,8 +319,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
