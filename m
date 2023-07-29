Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56BC767F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjG2Noh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjG2Nof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:44:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E193C1D;
        Sat, 29 Jul 2023 06:44:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686bc261111so2269444b3a.3;
        Sat, 29 Jul 2023 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638239; x=1691243039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vf4uoVxmxjVyFsNv7LekxyZhL/lwoeo6l/0kyaltBQg=;
        b=cshoYCbe/aYZ0e3GG8vWNJhAuanXPGYa3ha0gHQPiJgcm5gqnVckgLFMHZZDFqOfk9
         j8B5xFJ10FT6Y9bRSY7cqtZZrv2LNrKgsen6tejMJ+gmMCtzumLsaVSfVKZ0ErXX7mVu
         RCDywbv/IxoczANYd0mVUFHLClIjKqNxLYJZG2HbLSaQV0ZPXNIY9XAO6sWZmkZKuo+5
         FtxEDstJ3vYgvBpd6O2nU45W0dqJ5RHqY5VNuAiRz8rPVr44mHizd2G1xWtEeTN89NHf
         cen8MkZBeeONxOIfBsJrks8BH9z5PzmtL3TGhwz1NGLlVMn9lho/w2pjZxvqio+u4S04
         hSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638239; x=1691243039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf4uoVxmxjVyFsNv7LekxyZhL/lwoeo6l/0kyaltBQg=;
        b=O/+yE0DLcAgqQywVaJ1I1dPdq+To3U9hUraa81F9nC++kmikMRmA8gRPQL0cg/y3kW
         9Xhfw8Y/tj9QGuB1bmDbuPRWOGfPiqNRdmvYD96z2PTzruIKywpqL1RtmYeuzdavI7Vt
         5NL3NDE8xEF6diUoH0Wx2w3QKrtdgs7rfEVKR6xcq/hm1wD/5Rdty/1RkoFsT1rZzR0b
         dPaGiFxExJbIF45X6jx/5H0pL5X56VciOHiMUFmO9aqPi9QRPfCgLxuo6ZHivD7DV7TL
         7bZA8q0Z86vhejTfLk1MfBP+v0+ZX3YJdkJj69JAig6zhCf5UCgDyi/0Z8Z2oAFbPVHq
         8v6g==
X-Gm-Message-State: ABy/qLacPhHonoi96FMhM6XRLQSTlRqEe1uszyUjsrb9qxxnHACJ9Mse
        C/CNYpPgycEy59SBwFbCeiAfLNaSTt99Hg==
X-Google-Smtp-Source: APBJJlFkn1cfc5bzkjWP9ow3/UbWj7TMMWEA6R+SYm6Vyt4uf7J0QS7ZEs5XMrRAr/V6R7+ufXYK0Q==
X-Received: by 2002:a05:6a20:4299:b0:133:2fb2:917d with SMTP id o25-20020a056a20429900b001332fb2917dmr5703463pzj.5.1690638238925;
        Sat, 29 Jul 2023 06:43:58 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:58 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 07/17] MIPS: loongson32: Convert UART platform device to DT
Date:   Sat, 29 Jul 2023 21:43:08 +0800
Message-Id: <20230729134318.1694467-8-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART device nodes for Loongson-1 boards,
and drop the legacy platform devices and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1.dtsi    | 54 +++++++++++++++++++
 arch/mips/boot/dts/loongson/loongson1b.dtsi   | 12 +++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   | 12 +++++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   | 20 +++++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts | 20 +++++++
 arch/mips/loongson32/common/platform.c        | 44 ---------------
 arch/mips/loongson32/ls1b/board.c             |  3 --
 arch/mips/loongson32/ls1c/board.c             |  3 --
 8 files changed, 118 insertions(+), 50 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
index 711c88fd2781..c77aa2d0f66c 100644
--- a/arch/mips/boot/dts/loongson/loongson1.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
@@ -72,4 +72,58 @@ intc3: interrupt-controller@1fd01088 {
 			interrupts = <5>;
 		};
 	};
+
+	apb: bus@1fe40000 {
+		compatible = "simple-bus";
+		reg = <0x1fe40000 0x40000>;
+		ranges;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uart0: serial@1fe40000 {
+			compatible = "ns16550a";
+			reg = <0x1fe40000 0x8>;
+
+			interrupt-parent = <&intc0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&clkc LS1X_CLKID_APB>;
+
+			status = "disabled";
+		};
+
+		uart1: serial@1fe44000 {
+			compatible = "ns16550a";
+			reg = <0x1fe44000 0x8>;
+
+			interrupt-parent = <&intc0>;
+
+			clocks = <&clkc LS1X_CLKID_APB>;
+
+			status = "disabled";
+		};
+
+		uart2: serial@1fe48000 {
+			compatible = "ns16550a";
+			reg = <0x1fe48000 0x8>;
+
+			interrupt-parent = <&intc0>;
+
+			clocks = <&clkc LS1X_CLKID_APB>;
+
+			status = "disabled";
+		};
+
+		uart3: serial@1fe4c000 {
+			compatible = "ns16550a";
+			reg = <0x1fe4c000 0x8>;
+
+			interrupt-parent = <&intc0>;
+
+			clocks = <&clkc LS1X_CLKID_APB>;
+
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index 784ae9b6572d..437a77cee163 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -73,3 +73,15 @@ clkc: clock-controller@1fe78030 {
 		#clock-cells = <1>;
 	};
 };
+
+&uart1 {
+	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart2 {
+	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart3 {
+	interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index 8570c4c72677..1dd575b7b2f9 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -40,3 +40,15 @@ intc4: interrupt-controller@1fd010a0 {
 		interrupts = <6>;
 	};
 };
+
+&uart1 {
+	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart2 {
+	interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart3 {
+	interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
index d12c723b0a2b..89c3dfa574f7 100644
--- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -11,6 +11,10 @@ / {
 	compatible = "loongson,lsgz-1b-dev", "loongson,ls1b";
 	model = "LSGZ_1B_DEV Board";
 
+	chosen {
+		bootargs = "console=ttyS2,115200";
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x4000000>;
@@ -23,3 +27,19 @@ xtal: xtal {
 		#clock-cells = <0>;
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
index 64e869acfd86..188aab9e3685 100644
--- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -11,6 +11,10 @@ / {
 	compatible = "loongmasses,smartloong-1c", "loongson,ls1c";
 	model = "Smartloong_1C Board";
 
+	chosen {
+		bootargs = "console=ttyS2,115200";
+	};
+
 	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x2000000>;
@@ -23,3 +27,19 @@ xtal: xtal {
 		#clock-cells = <0>;
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 8075590a9f83..8272b4133e25 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -9,7 +9,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/sizes.h>
 #include <linux/phy.h>
-#include <linux/serial_8250.h>
 #include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
 
@@ -18,49 +17,6 @@
 #include <dma.h>
 #include <nand.h>
 
-/* 8250/16550 compatible UART */
-#define LS1X_UART(_id)						\
-	{							\
-		.mapbase	= LS1X_UART ## _id ## _BASE,	\
-		.irq		= LS1X_UART ## _id ## _IRQ,	\
-		.iotype		= UPIO_MEM,			\
-		.flags		= UPF_IOREMAP | UPF_FIXED_TYPE, \
-		.type		= PORT_16550A,			\
-	}
-
-static struct plat_serial8250_port ls1x_serial8250_pdata[] = {
-	LS1X_UART(0),
-	LS1X_UART(1),
-	LS1X_UART(2),
-	LS1X_UART(3),
-	{},
-};
-
-struct platform_device ls1x_uart_pdev = {
-	.name		= "serial8250",
-	.id		= PLAT8250_DEV_PLATFORM,
-	.dev		= {
-		.platform_data = ls1x_serial8250_pdata,
-	},
-};
-
-void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
-{
-	struct clk *clk;
-	struct plat_serial8250_port *p;
-
-	clk = clk_get(&pdev->dev, pdev->name);
-	if (IS_ERR(clk)) {
-		pr_err("unable to get %s clock, err=%ld",
-		       pdev->name, PTR_ERR(clk));
-		return;
-	}
-	clk_prepare_enable(clk);
-
-	for (p = pdev->dev.platform_data; p->flags != 0; ++p)
-		p->uartclk = clk_get_rate(clk);
-}
-
 /* Synopsys Ethernet GMAC */
 static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
 	.phy_mask	= 0,
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index fed8d432ef20..e8290f200096 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -34,7 +34,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
 };
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
-	&ls1x_uart_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_eth1_pdev,
 	&ls1x_ehci_pdev,
@@ -46,8 +45,6 @@ static struct platform_device *ls1b_platform_devices[] __initdata = {
 
 static int __init ls1b_platform_init(void)
 {
-	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
-
 	gpio_led_register_device(-1, &ls1x_led_pdata);
 
 	return platform_add_devices(ls1b_platform_devices,
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index 9dcfe9de55b0..a7096964fb30 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -6,7 +6,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1c_platform_devices[] __initdata = {
-	&ls1x_uart_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
@@ -14,8 +13,6 @@ static struct platform_device *ls1c_platform_devices[] __initdata = {
 
 static int __init ls1c_platform_init(void)
 {
-	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
-
 	return platform_add_devices(ls1c_platform_devices,
 				   ARRAY_SIZE(ls1c_platform_devices));
 }
-- 
2.39.2

