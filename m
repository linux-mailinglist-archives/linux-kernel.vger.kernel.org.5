Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00E7890E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHYVzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjHYVyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:54:50 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF35926B8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a7d4030621so880027b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693000487; x=1693605287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biEa1K9qjP5wRSXkBfGSs8U4rFVAjb1zKI5IMPs39Jw=;
        b=xDpZfI4xx12HndT5FhmxsDcpxlYaeOx5ohuFiPuWPgZ7QxicELjJ2qaHYn+x7fyAcx
         clApEhUF5NaVlP/usxb/fJLGK7LTVE3ST2C9dkIIQMzPvPKvnErD/Stp+CIIRuWr/tM8
         /CfWeXYcp41SOIbAHs1KGsNrUFEADcn5K3+eWrLF6FTTgFO1rn9zMUj4+yIJYuIfHd22
         CPW7NqSaGHV254TxXKzfUh5py3WFyT8QCSHBuo4WTwyEBEfWu+UeMRTSMVAyuDyHR1Nn
         YL3fq3f1b41VTmmjbZewb3ZfByxgxBSFjaw7E1RIT+oIKGErDfkxaebVeYbppbCzih1R
         dV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000487; x=1693605287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biEa1K9qjP5wRSXkBfGSs8U4rFVAjb1zKI5IMPs39Jw=;
        b=PTuE93KuHXzVfci+T4ITJU48y4w3XNeafZtgzfjDwAJM8KlhV2X2NKSasBuJmpztC0
         FSWFGwCBhYBonDAa5B1kIyogAWp46ouxVQ8KqhIlTv8IdvOp9qOOx05vDCu43tKKFSoP
         m+MpL6dCuJ4aWvNliIXcPeayfP4/nUUZdGoZ/dUiE61S79hP5sIaBZhdcuf+liVuCqdG
         qsnpnixwAGfqFgozxllVOU8SmrzNugLpfURuquYVWQyhs1vanXdlBzNax2rEo2c8Tj8/
         Rhj1XWt+zIDzoymPG9Xf7vaJMSJFCOAo2R9DkULOuIY2GFr138bswv7BsSxR5ewGbEDg
         GROw==
X-Gm-Message-State: AOJu0Yye+bFL2s4/4IWfhH0gdEaYKsQ/Vw+UayrJHLIeTwU9gFg0x/zB
        heYryKTdZC8q9znCYgfH+LgEDQ==
X-Google-Smtp-Source: AGHT+IEFHhXWOdPz1pvJu2XmLQUai8oqXZdsZwboIzFEgLUHvjMNnfLp5RyprhrihzQcg6pOcQvyZQ==
X-Received: by 2002:a05:6808:144d:b0:3a4:6691:9340 with SMTP id x13-20020a056808144d00b003a466919340mr5353831oiv.41.1693000487314;
        Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id bg20-20020a056808179400b003a7a34a4ed8sm1197752oib.33.2023.08.25.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:54:47 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: exynos: Enable USB in Exynos850
Date:   Fri, 25 Aug 2023 16:54:44 -0500
Message-Id: <20230825215445.28309-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230825215445.28309-1-semen.protsenko@linaro.org>
References: <20230825215445.28309-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB controller and USB PHY controller nodes for Exynos850 SoC.

The USB controller has next features:
  - Dual Role Device (DRD) controller
  - DWC3 compatible
  - Supports USB 2.0 host and USB 2.0 device interfaces
  - Supports  full-speed (12 Mbps) and high-speed (480 Mbps) modes with
    USB device 2.0 interface
  - Supports on-chip USB PHY transceiver
  - Supports up to 16 bi-directional endpoints (that includes control
    endpoint 0)
  - Complies with xHCI 1.00 specification

Only USB 2.0 is supported in Exynos850, so only UTMI+ PHY interface is
specified in "phys" property (index 0) and PIPE3 is omitted (index 1).

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Put ranges after compatible in usbdrd node

 arch/arm64/boot/dts/exynos/exynos850.dtsi | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index aa077008b3be..53104e65b9c6 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -570,6 +570,36 @@ sysreg_cmgp: syscon@11c20000 {
 			clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
 		};
 
+		usbdrd: usb@13600000 {
+			compatible = "samsung,exynos850-dwusb3";
+			ranges = <0x0 0x13600000 0x10000>;
+			clocks = <&cmu_hsi CLK_GOUT_USB_BUS_EARLY_CLK>,
+				 <&cmu_hsi CLK_GOUT_USB_REF_CLK>;
+			clock-names = "bus_early", "ref";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			status = "disabled";
+
+			usbdrd_dwc3: usb@0 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x10000>;
+				interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usbdrd_phy 0>;
+				phy-names = "usb2-phy";
+			};
+		};
+
+		usbdrd_phy: phy@135d0000 {
+			compatible = "samsung,exynos850-usbdrd-phy";
+			reg = <0x135d0000 0x100>;
+			clocks = <&cmu_hsi CLK_GOUT_USB_PHY_ACLK>,
+				 <&cmu_hsi CLK_GOUT_USB_PHY_REF_CLK>;
+			clock-names = "phy", "ref";
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
 		usi_uart: usi@138200c0 {
 			compatible = "samsung,exynos850-usi";
 			reg = <0x138200c0 0x20>;
-- 
2.39.2

