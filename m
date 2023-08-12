Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64DA77A0A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjHLPMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:12:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C951984;
        Sat, 12 Aug 2023 08:12:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bcad794ad4so19845635ad.3;
        Sat, 12 Aug 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853129; x=1692457929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdbUNkku7p7EjUqwDMY1rwpQnBjCJuEzhk5BzNxLshM=;
        b=Wsr8ZcmiWcKPNmBmmJfvjR9UghArhBb0EGxghNU90G+bnwqxTD753ekuLb+AWZqzH+
         UiF22Ib+QnWNMd/5XZUEdETXaubacEWdxl2jw/ArzWlcFrFWVS1crtaJ0zFiOo9cXnk1
         1Vr03dKlmFXWfRLfAaENr4ihzQs0peBFeylu30AVCOxL2UX9i3n/1N8FJxRK9K8CaRNb
         6vPaJioWXjc7iMiTvg0yoNZIu4CsNfYb97C9SizhISM5rF45DX591QayPNhWxgbItn9l
         Uj88dFZJRcI2r4yTgnD4vULk+MkWyYEQR6rs8Hc6vmYBe++xRNtQCxlBTg9LCl1yNAHS
         Nxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853129; x=1692457929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdbUNkku7p7EjUqwDMY1rwpQnBjCJuEzhk5BzNxLshM=;
        b=Eh9ccIb7BuceTQraKkagyRTaba3U78XA0zpAOQapEEnMYqSnJ3THNNuHiGY8KlZOb7
         xh/qZz+DWxbu3Ka/67/spP70X1Kw1oTgCu7/lOL88ZBBs1srGtsPggQwYtC53JYTi3fT
         b83YzMqxQJIT35mFMIwEGkdyArtk/ArENYeVUgUzVbPjmewjpjUsKJ7SW06xhLMKdZ3w
         iWc9Sg6b7OgdS2sPLcIoFvyyz+Wb/+wSDUo1zc840aQMS8hvM6tHrru7x08973Y1aU20
         ZRJEBipwPay/EWPeKCGiHBneOqeBzooEtPDXrI3Wh51mTO/OdiK+kxUs+ZDiZzI/iz/6
         pTag==
X-Gm-Message-State: AOJu0YxXpqLOFFU7XASVGHqFbRAdMojPAwNnoqF9TCyl9GfOE3Agr1i5
        euYBr8uD/yHL/3jTxxH1oWyMX9M8u9mYj3T2
X-Google-Smtp-Source: AGHT+IEiDAiPR0YpiPHCuRK8/M603XfedzSYj6efGlRqNuDOXUIUTHtpmBYa8M50vwtLBxBO+kBwvg==
X-Received: by 2002:a17:903:11c3:b0:1bb:4861:d3a7 with SMTP id q3-20020a17090311c300b001bb4861d3a7mr3715888plh.16.1691853128608;
        Sat, 12 Aug 2023 08:12:08 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0026b41363887sm1040927pjh.27.2023.08.12.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:12:08 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/5] MIPS: loongson32: Remove Loongson1 MAC arch-code
Date:   Sat, 12 Aug 2023 23:11:31 +0800
Message-Id: <20230812151135.1028780-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230812151135.1028780-1-keguang.zhang@gmail.com>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson1 MAC arch-code should be moved to the driver dir.
Therefore, remove the deprecated implementation.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/common/platform.c | 127 +++++--------------------
 1 file changed, 23 insertions(+), 104 deletions(-)

diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 8075590a9f83..37dcda402680 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -10,7 +10,6 @@
 #include <linux/sizes.h>
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
-#include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
 
 #include <platform.h>
@@ -62,87 +61,7 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 }
 
 /* Synopsys Ethernet GMAC */
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
+#ifdef CONFIG_LOONGSON1_LS1B
 static struct resource ls1x_eth0_resources[] = {
 	[0] = {
 		.start	= LS1X_GMAC0_BASE,
@@ -157,27 +76,10 @@ static struct resource ls1x_eth0_resources[] = {
 };
 
 struct platform_device ls1x_eth0_pdev = {
-	.name		= "stmmaceth",
+	.name		= "loongson,ls1b-dwmac",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
 	.resource	= ls1x_eth0_resources,
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
 };
 
 static struct resource ls1x_eth1_resources[] = {
@@ -194,15 +96,32 @@ static struct resource ls1x_eth1_resources[] = {
 };
 
 struct platform_device ls1x_eth1_pdev = {
-	.name		= "stmmaceth",
+	.name		= "loongson,ls1b-dwmac",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(ls1x_eth1_resources),
 	.resource	= ls1x_eth1_resources,
-	.dev		= {
-		.platform_data = &ls1x_eth1_pdata,
+};
+#elif defined(CONFIG_LOONGSON1_LS1C)
+static struct resource ls1x_eth0_resources[] = {
+	[0] = {
+		.start	= LS1X_GMAC0_BASE,
+		.end	= LS1X_GMAC0_BASE + SZ_64K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "macirq",
+		.start	= LS1X_GMAC0_IRQ,
+		.flags	= IORESOURCE_IRQ,
 	},
 };
-#endif	/* CONFIG_LOONGSON1_LS1B */
+
+struct platform_device ls1x_eth0_pdev = {
+	.name		= "loongson,ls1c-dwmac",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
+	.resource	= ls1x_eth0_resources,
+};
+#endif
 
 /* GPIO */
 static struct resource ls1x_gpio0_resources[] = {
-- 
2.39.2

