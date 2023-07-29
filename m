Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DD767F9F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjG2NpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjG2NpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB6944B7;
        Sat, 29 Jul 2023 06:44:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686efdeabaeso2056360b3a.3;
        Sat, 29 Jul 2023 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638251; x=1691243051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUGEXW4DwSyYOcjUa9J13P2442xDIu3qgDD1y6kZszU=;
        b=J0qayWk0rl4r00wHsAONhn1p7jYf9BxkqQsca506iY58Ln+gjRCFO1kT/YB7+u3ML0
         GhJPBC4MDgkyeo4uAbNFFP2HRRWZioLuVXyIMWEqPd3dvJBvQh+Hp3kj4vIbSC2fbcT4
         AVWfQ4TrJjTsw1sqhldvwOHOWcewg1/EE1T2pQe8z0JN8bCQiBsNNGb3KMHfRkCJSO2+
         HvbeXZ/NMWSyxd8zca38XHfjUbjTmKsEITWy/56YdHerNn/qdEUz2NMHZd+2Sy/FXYqk
         3g9bdt534dd4AXUfmEdkxPxQeyZAse/85lCbBNot5ZSwfmzwxGBKhC7EzHda1CgBEKpu
         JvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638251; x=1691243051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUGEXW4DwSyYOcjUa9J13P2442xDIu3qgDD1y6kZszU=;
        b=BnawKom6Wq3Qiw4qopOl9XYf5aXR/rAdac2cfomlQ9H5N6hCrVRO5P8JAeFtlZy5KI
         vLqRpE1q5VEicDVh450/mbThPVDovf87wKwTmPSHsDf5PxeitXeMDBqT3LFPFgnBs2Di
         ZAE6Z1Ex5104CGXmJVstObHbsQpJv1/ry1Vfz7CjGIq/9+ZI0JYbzbQc72/n2y1jWqFO
         /i+xGX99Jozf/1W8JY5rxs+NH+8f92dPY9i+kRBlrtTH+LKUsMXPJukX4o3xFBK0iaLa
         bRyAnSOixo02l4YBNR2sHTAj65bLBC4NB05YIUsoJTavufvLXed14et+4ePgN1XllZC4
         AeQA==
X-Gm-Message-State: ABy/qLZeaafBD9LYySX2tU+g7novUGWU8p7DnFM+NI0iq9r3PrUqKvCx
        wL9N2h15c4faYoV7pn+tdVBK+V8X2smfYw==
X-Google-Smtp-Source: APBJJlELwFC4WsN9k5NA9qez+HY7cULIknTU98f01DxzkDm1q5PtXPLWoKivHqoxRaEZ4+zI1sZSxA==
X-Received: by 2002:a05:6a00:1ac9:b0:67e:4313:811e with SMTP id f9-20020a056a001ac900b0067e4313811emr5600773pfv.0.1690638250902;
        Sat, 29 Jul 2023 06:44:10 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:10 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 11/17] MIPS: loongson32: Convert USB host platform device to DT
Date:   Sat, 29 Jul 2023 21:43:12 +0800
Message-Id: <20230729134318.1694467-12-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB host device nodes for Loongson-1 boards,
and drop the legacy platform devices and data accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1b.dtsi   | 20 +++++++++++++
 arch/mips/boot/dts/loongson/loongson1c.dtsi   | 20 +++++++++++++
 arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |  8 +++++
 arch/mips/boot/dts/loongson/smartloong_1c.dts |  8 +++++
 arch/mips/loongson32/common/platform.c        | 29 -------------------
 arch/mips/loongson32/ls1b/board.c             |  1 -
 6 files changed, 56 insertions(+), 30 deletions(-)

diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index 7010d3f3511b..7b4914c358df 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -82,6 +82,26 @@ clkc: clock-controller@1fe78030 {
 };
 
 &ahb {
+	ehci0: usb@1fe00000 {
+		compatible = "generic-ehci";
+		reg = <0x1fe00000 0x100>;
+
+		interrupt-parent = <&intc1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+	};
+
+	ohci0: usb@1fe08000 {
+		compatible = "generic-ohci";
+		reg = <0x1fe08000 0x100>;
+
+		interrupt-parent = <&intc1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+	};
+
 	gmac1: ethernet@1fe20000 {
 		compatible = "snps,dwmac-3.70a";
 		reg = <0x1fe20000 0x10000>;
diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
index a5bc2c5093ca..7204b829c801 100644
--- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
@@ -66,6 +66,26 @@ gpio3: gpio@1fd010cc {
 
 		ngpios = <32>;
 	};
+
+	ehci0: usb@1fe20000 {
+		compatible = "generic-ehci";
+		reg = <0x1fe20000 0x100>;
+
+		interrupt-parent = <&intc1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+	};
+
+	ohci0: usb@1fe28000 {
+		compatible = "generic-ohci";
+		reg = <0x1fe28000 0x100>;
+
+		interrupt-parent = <&intc1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+
+		status = "disabled";
+	};
 };
 
 &gpio0 {
diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
index 8ee76ecdafbb..71838f867f8c 100644
--- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
+++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
@@ -55,6 +55,14 @@ &gmac1 {
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
index 96387cc814ca..3277770c33fe 100644
--- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
+++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
@@ -51,6 +51,14 @@ &gmac0 {
 	status = "okay";
 };
 
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 37302bcfb9ab..3b984c805eb0 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -16,35 +16,6 @@
 #include <nand.h>
 #include <irq.h>
 
-/* USB EHCI */
-static u64 ls1x_ehci_dmamask = DMA_BIT_MASK(32);
-
-static struct resource ls1x_ehci_resources[] = {
-	[0] = {
-		.start	= LS1X_EHCI_BASE,
-		.end	= LS1X_EHCI_BASE + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= LS1X_EHCI_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct usb_ehci_pdata ls1x_ehci_pdata = {
-};
-
-struct platform_device ls1x_ehci_pdev = {
-	.name		= "ehci-platform",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(ls1x_ehci_resources),
-	.resource	= ls1x_ehci_resources,
-	.dev		= {
-		.dma_mask = &ls1x_ehci_dmamask,
-		.platform_data = &ls1x_ehci_pdata,
-	},
-};
-
 /* Real Time Clock */
 struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 4cad019d655f..ecc405aa9016 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -13,7 +13,6 @@
 #include <platform.h>
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
-	&ls1x_ehci_pdev,
 	&ls1x_rtc_pdev,
 	&ls1x_wdt_pdev,
 };
-- 
2.39.2

