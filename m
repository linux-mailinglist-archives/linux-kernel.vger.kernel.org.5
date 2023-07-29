Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143C767F90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjG2NpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjG2No6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:44:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E944BD;
        Sat, 29 Jul 2023 06:44:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f090316dso2063739b3a.2;
        Sat, 29 Jul 2023 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638242; x=1691243042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38zxaKr+2PJFRjzMHvc1QAAsYfBhANxuRljuHPzm8a8=;
        b=IxIVKe6M6LAqs5FmKfPwOO4i+iSV/6sfcNfWM5LDsGJsPkD9jYGQCk7IMNdab9mJhw
         4rcd5EpWk4M3AVf2B3b1KHIGVMtESbi76uXoR4I0LL0P8f182n+Ur73dhziRpGjoy9iw
         H9HE7jvDfhYLQDrtM0ohbZfEn60akiSZPPRWyx3gMYJl9QJO0hAGyJTGifC5z0S9hP0u
         c22VGJaY0iWJLlY62rirpPl3KIzJhU6FRv2Hg3kOr+DytfqgLwtEjfmAJppjzL+EO+/u
         ykcmzlCQ8KlxilwWZCeu44XwteBa1/AJjiV2VeGoe2dPqyGvWIxrfKDLWqTdmqYoVm7u
         Mjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638242; x=1691243042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38zxaKr+2PJFRjzMHvc1QAAsYfBhANxuRljuHPzm8a8=;
        b=dVNBB2YFP4M35soYMSgSL2k9XfxxugfK/GR0y+oKD45ofRhaKVxtkUWejqt+EbJO5Y
         NMiv4tXZLKdESO2bhFMhf0MbFr2wRZ3HMVHCGUlnjcSio8f+UP+MY9lvot5zcIkK7Squ
         LUAG/6OT38272Y1p4O9LA4b2+qxsI7o5giJLmNZFNBYIphDqZuL0Vb1FGgtt5orpHDdc
         8eYDUpsHjHHyfHaUlJtvm0jF71dLBA8n+rrxqLyJbnJr6JAI62fHUwypQYIotZv6Fbo0
         Mf9cU4AUgfZfzUGSZEnGiqUruUKUNAklHM0QtWGd6iSnFRqLBRVBkVgaXmV5HL1FrbYd
         tbBA==
X-Gm-Message-State: ABy/qLbFF+FWFtbahneK4kttrBnxpSVN/zc/iDkJVBPGk8q6/Sc04iUC
        OzoK5aB6WR6aQEgtj4y+/lBQZfCZyLaPUQ==
X-Google-Smtp-Source: APBJJlH02HHbYQvHL1lodIMsFCNp2q69k6HGmdys1FAZK0oolVyIlr3o8BHXXFuRbLJg+JifvnHapw==
X-Received: by 2002:a05:6a20:9195:b0:13c:988c:e885 with SMTP id v21-20020a056a20919500b0013c988ce885mr4492258pzd.56.1690638241919;
        Sat, 29 Jul 2023 06:44:01 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:01 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 08/17] MIPS: loongson32: Convert Ethernet platform device to DT
Date:   Sat, 29 Jul 2023 21:43:09 +0800
Message-Id: <20230729134318.1694467-9-keguang.zhang@gmail.com>
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

Add Ethernet device nodes for Loongson-1 boards,
and drop the legacy platform devices and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1.dtsi    |  16 ++
 arch/mips/boot/dts/loongson/loongson1b.dtsi   |  53 +++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   |  17 ++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |   8 +
 arch/mips/boot/dts/loongson/smartloong_1c.dts |   4 +
 arch/mips/loongson32/common/platform.c        | 146 +-----------------
 arch/mips/loongson32/ls1b/board.c             |   2 -
 arch/mips/loongson32/ls1c/board.c             |   1 -
 8 files changed, 99 insertions(+), 148 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
index c77aa2d0f66c..48bb786bbf10 100644
--- a/arch/mips/boot/dts/loongson/loongson1.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
@@ -71,6 +71,22 @@ intc3: interrupt-controller@1fd01088 {
 			interrupt-parent = <&cpu_intc>;
 			interrupts = <5>;
 		};
+
+		gmac0: ethernet@1fe10000 {
+			compatible = "snps,dwmac-3.70a";
+			reg = <0x1fe10000 0x10000>;
+
+			interrupt-parent = <&intc1>;
+			interrupt-names = "macirq";
+
+			clocks = <&clkc LS1X_CLKID_AHB>;
+			clock-names = "stmmaceth";
+
+			snps,pbl = <1>;
+
+			status = "disabled";
+		};
+
 	};
 
 	apb: bus@1fe40000 {
diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index 437a77cee163..42b96c557660 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -7,6 +7,11 @@
 #include "loongson1.dtsi"
 
 / {
+	aliases {
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -74,6 +79,54 @@ clkc: clock-controller@1fe78030 {
 	};
 };
 
+&ahb {
+	gmac1: ethernet@1fe20000 {
+		compatible = "snps,dwmac-3.70a";
+		reg = <0x1fe20000 0x10000>;
+
+		interrupt-parent = <&intc1>;
+		interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+
+		clocks = <&clkc LS1X_CLKID_AHB>;
+		clock-names = "stmmaceth";
+
+		phy-handle = <&phy1>;
+		phy-mode = "mii";
+
+		snps,pbl = <1>;
+
+		status = "disabled";
+
+		mdio1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,dwmac-mdio";
+
+			phy1: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+		};
+	};
+};
+
+&gmac0 {
+	interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+
+	phy-handle = <&phy0>;
+	phy-mode = "mii";
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@0 {
+			reg = <0x0>;
+		};
+	};
+};
+
 &uart1 {
 	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index 1dd575b7b2f9..5b3e0f9280f6 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -41,6 +41,23 @@ intc4: interrupt-controller@1fd010a0 {
 	};
 };
 
+&gmac0 {
+	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+
+	phy-handle = <&phy0>;
+	phy-mode = "rmii";
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@13 {
+			reg = <0x13>;
+		};
+	};
+};
+
 &uart1 {
 	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
index 89c3dfa574f7..a43df21f2904 100644
--- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -28,6 +28,14 @@ xtal: xtal {
 	};
 };
 
+&gmac0 {
+	status = "okay";
+};
+
+&gmac1 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
index 188aab9e3685..2d8f304aa2c4 100644
--- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -28,6 +28,10 @@ xtal: xtal {
 	};
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 8272b4133e25..817518531b9b 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -8,157 +8,13 @@
 #include <linux/err.h>
 #include <linux/mtd/partitions.h>
 #include <linux/sizes.h>
-#include <linux/phy.h>
-#include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
 
 #include <platform.h>
 #include <loongson1.h>
 #include <dma.h>
 #include <nand.h>
-
-/* Synopsys Ethernet GMAC */
-static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
-	.phy_mask	= 0,
-};
-
-static struct stmmac_dma_cfg ls1x_eth_dma_cfg = {
-	.pbl		= 1,
-};
-
-int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
-{
-	struct plat_stmmacenet_data *plat_dat = NULL;
-	u32 val;
-
-	val = __raw_readl(LS1X_MUX_CTRL1);
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-	plat_dat = dev_get_platdata(&pdev->dev);
-	if (plat_dat->bus_id) {
-		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
-			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
-		switch (plat_dat->phy_interface) {
-		case PHY_INTERFACE_MODE_RGMII:
-			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
-			break;
-		case PHY_INTERFACE_MODE_MII:
-			val |= (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
-			break;
-		default:
-			pr_err("unsupported mii mode %d\n",
-			       plat_dat->phy_interface);
-			return -ENOTSUPP;
-		}
-		val &= ~GMAC1_SHUT;
-	} else {
-		switch (plat_dat->phy_interface) {
-		case PHY_INTERFACE_MODE_RGMII:
-			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
-			break;
-		case PHY_INTERFACE_MODE_MII:
-			val |= (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
-			break;
-		default:
-			pr_err("unsupported mii mode %d\n",
-			       plat_dat->phy_interface);
-			return -ENOTSUPP;
-		}
-		val &= ~GMAC0_SHUT;
-	}
-	__raw_writel(val, LS1X_MUX_CTRL1);
-#elif defined(CONFIG_LOONGSON1_LS1C)
-	plat_dat = dev_get_platdata(&pdev->dev);
-
-	val &= ~PHY_INTF_SELI;
-	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
-		val |= 0x4 << PHY_INTF_SELI_SHIFT;
-	__raw_writel(val, LS1X_MUX_CTRL1);
-
-	val = __raw_readl(LS1X_MUX_CTRL0);
-	__raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
-#endif
-
-	return 0;
-}
-
-static struct plat_stmmacenet_data ls1x_eth0_pdata = {
-	.bus_id			= 0,
-	.phy_addr		= -1,
-#if defined(CONFIG_LOONGSON1_LS1B)
-	.phy_interface		= PHY_INTERFACE_MODE_MII,
-#elif defined(CONFIG_LOONGSON1_LS1C)
-	.phy_interface		= PHY_INTERFACE_MODE_RMII,
-#endif
-	.mdio_bus_data		= &ls1x_mdio_bus_data,
-	.dma_cfg		= &ls1x_eth_dma_cfg,
-	.has_gmac		= 1,
-	.tx_coe			= 1,
-	.rx_queues_to_use	= 1,
-	.tx_queues_to_use	= 1,
-	.init			= ls1x_eth_mux_init,
-};
-
-static struct resource ls1x_eth0_resources[] = {
-	[0] = {
-		.start	= LS1X_GMAC0_BASE,
-		.end	= LS1X_GMAC0_BASE + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.name	= "macirq",
-		.start	= LS1X_GMAC0_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device ls1x_eth0_pdev = {
-	.name		= "stmmaceth",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
-	.resource	= ls1x_eth0_resources,
-	.dev		= {
-		.platform_data = &ls1x_eth0_pdata,
-	},
-};
-
-#ifdef CONFIG_LOONGSON1_LS1B
-static struct plat_stmmacenet_data ls1x_eth1_pdata = {
-	.bus_id			= 1,
-	.phy_addr		= -1,
-	.phy_interface		= PHY_INTERFACE_MODE_MII,
-	.mdio_bus_data		= &ls1x_mdio_bus_data,
-	.dma_cfg		= &ls1x_eth_dma_cfg,
-	.has_gmac		= 1,
-	.tx_coe			= 1,
-	.rx_queues_to_use	= 1,
-	.tx_queues_to_use	= 1,
-	.init			= ls1x_eth_mux_init,
-};
-
-static struct resource ls1x_eth1_resources[] = {
-	[0] = {
-		.start	= LS1X_GMAC1_BASE,
-		.end	= LS1X_GMAC1_BASE + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.name	= "macirq",
-		.start	= LS1X_GMAC1_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device ls1x_eth1_pdev = {
-	.name		= "stmmaceth",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(ls1x_eth1_resources),
-	.resource	= ls1x_eth1_resources,
-	.dev		= {
-		.platform_data = &ls1x_eth1_pdata,
-	},
-};
-#endif	/* CONFIG_LOONGSON1_LS1B */
+#include <irq.h>
 
 /* GPIO */
 static struct resource ls1x_gpio0_resources[] = {
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index e8290f200096..f23e4e5c96ee 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -34,8 +34,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
 };
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
-	&ls1x_eth0_pdev,
-	&ls1x_eth1_pdev,
 	&ls1x_ehci_pdev,
 	&ls1x_gpio0_pdev,
 	&ls1x_gpio1_pdev,
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index a7096964fb30..29bc467fd149 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -6,7 +6,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1c_platform_devices[] __initdata = {
-	&ls1x_eth0_pdev,
 	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
-- 
2.39.2

