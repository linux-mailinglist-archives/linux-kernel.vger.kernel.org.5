Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204FE767F94
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjG2NpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjG2NpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275754228;
        Sat, 29 Jul 2023 06:44:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b9920362so2219528b3a.1;
        Sat, 29 Jul 2023 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638245; x=1691243045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9jtabGYslD2mSJ5G1TpbUQgEy1o5I+I4rYH0s+9gkw=;
        b=K6WOR8Q4FdxculfAM5ufZ/qZnAnVIGMrYnLFcb5bQM/khPnNDWNCcIwwqxbb93CAoq
         0/NkbWY8EdzZX1d/XZI0X1ZeSKFrVIhPQEYYaQjomhmbRRY35S6p+gq8dkz31lUH/fKL
         EMz3Smi6JsUepNcYABZ7ibtkLNyOVz1409W88vjGQonPEZ7rASi0pZ1Gbucg/IAGVdK3
         TXp8r8B/lq0jTCd38kKN8rHUGZpPP/XNZbNOc0jTQMTaDV69xqbJ7WjZj7EIFJl+k3Eh
         WFu0WCeJHGXSxH6uwGlpTI4ufr19DEvQHaQqgTXTEFxOHWM53sqjGVWD2LoC+uEpXz0b
         dNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638245; x=1691243045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9jtabGYslD2mSJ5G1TpbUQgEy1o5I+I4rYH0s+9gkw=;
        b=B66nXVt87QR/kVCEF3wT6oI07zxRWEemJlOhCAb8DJbmZJqXpEB0N/9l9RllO5p61T
         TdP4NeDdEIYQS2GYzUJ6BBfIVUEvLpu15ht4UMIDupNievDezve3987KH8bhymZ9QPoJ
         Bk3sMCgStG1WGZhD4O98ywPM7lT1X4+Ig95EbVxMIjwqFf/hCHNXCtIDtXOHvMZ9n0cB
         Mi08AI0UeBZj3MWAVlKPBqpTOq56GIXV7y12boKfkF1ihQoy9AW4IiYZNviwNRrwwUAE
         J3SmI174dxSzlxdhj4nw4nXMYlNGPNoLYnxdyT2L1hqfGpDroEnuo+mKwx04RnYITGod
         BZpA==
X-Gm-Message-State: ABy/qLYZ7HYsJwpd4qr3QtngsAQaXGt7Fxow5YzBFbZR/dWWNvyHub2g
        gR6aCa+nJ5WTu+m5uRnFs8UPG+eCaj1zRw==
X-Google-Smtp-Source: APBJJlF+w1uTAIe2UGIpwj6KR0u0/B2HKMz1V+s2kkBfrbBrpxs4r1FQDdFBrg7N+hGtdkvcJYdouQ==
X-Received: by 2002:a05:6a00:1147:b0:668:90f2:6988 with SMTP id b7-20020a056a00114700b0066890f26988mr5048775pfm.6.1690638244932;
        Sat, 29 Jul 2023 06:44:04 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:04 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 09/17] MIPS: loongson32: Convert GPIO platform device to DT
Date:   Sat, 29 Jul 2023 21:43:10 +0800
Message-Id: <20230729134318.1694467-10-keguang.zhang@gmail.com>
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

Add GPIO device nodes for Loongson-1 boards,
and drop the legacy platform devices and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1.dtsi  | 16 ++++++++++
 arch/mips/boot/dts/loongson/loongson1b.dtsi | 10 ++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi | 35 +++++++++++++++++++++
 arch/mips/loongson32/common/platform.c      | 31 ------------------
 arch/mips/loongson32/ls1b/board.c           |  2 --
 5 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
index 48bb786bbf10..abe8170fa1b1 100644
--- a/arch/mips/boot/dts/loongson/loongson1.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
@@ -72,6 +72,22 @@ intc3: interrupt-controller@1fd01088 {
 			interrupts = <5>;
 		};
 
+		gpio0: gpio@1fd010c0 {
+			compatible = "loongson,ls1x-gpio";
+			reg = <0x1fd010c0 0x4>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio1: gpio@1fd010c4 {
+			compatible = "loongson,ls1x-gpio";
+			reg = <0x1fd010c4 0x4>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		gmac0: ethernet@1fe10000 {
 			compatible = "snps,dwmac-3.70a";
 			reg = <0x1fe10000 0x10000>;
diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index 42b96c557660..7010d3f3511b 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -10,6 +10,8 @@ / {
 	aliases {
 		ethernet0 = &gmac0;
 		ethernet1 = &gmac1;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
 	};
 
 	cpus {
@@ -110,6 +112,14 @@ phy1: ethernet-phy@0 {
 	};
 };
 
+&gpio0 {
+	ngpios = <31>;
+};
+
+&gpio1 {
+	ngpios = <30>;
+};
+
 &gmac0 {
 	interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index 5b3e0f9280f6..a5bc2c5093ca 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -7,6 +7,13 @@
 #include "loongson1.dtsi"
 
 / {
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -39,6 +46,34 @@ intc4: interrupt-controller@1fd010a0 {
 		interrupt-parent = <&cpu_intc>;
 		interrupts = <6>;
 	};
+
+	gpio2: gpio@1fd010c8 {
+		compatible = "loongson,ls1x-gpio";
+		reg = <0x1fd010c8 0x4>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		ngpios = <32>;
+	};
+
+	gpio3: gpio@1fd010cc {
+		compatible = "loongson,ls1x-gpio";
+		reg = <0x1fd010cc 0x4>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		ngpios = <32>;
+	};
+};
+
+&gpio0 {
+	ngpios = <32>;
+};
+
+&gpio1 {
+	ngpios = <32>;
 };
 
 &gmac0 {
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 817518531b9b..37302bcfb9ab 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -16,37 +16,6 @@
 #include <nand.h>
 #include <irq.h>
 
-/* GPIO */
-static struct resource ls1x_gpio0_resources[] = {
-	[0] = {
-		.start	= LS1X_GPIO0_BASE,
-		.end	= LS1X_GPIO0_BASE + SZ_4 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device ls1x_gpio0_pdev = {
-	.name		= "ls1x-gpio",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(ls1x_gpio0_resources),
-	.resource	= ls1x_gpio0_resources,
-};
-
-static struct resource ls1x_gpio1_resources[] = {
-	[0] = {
-		.start	= LS1X_GPIO1_BASE,
-		.end	= LS1X_GPIO1_BASE + SZ_4 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device ls1x_gpio1_pdev = {
-	.name		= "ls1x-gpio",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(ls1x_gpio1_resources),
-	.resource	= ls1x_gpio1_resources,
-};
-
 /* USB EHCI */
 static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
 
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index f23e4e5c96ee..baadc524cc88 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -35,8 +35,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_ehci_pdev,
-	&ls1x_gpio0_pdev,
-	&ls1x_gpio1_pdev,
 	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
-- 
2.39.2

