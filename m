Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E590781722
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbjHSDSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbjHSDRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:17:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9098E4234
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:39 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bd066b0fd4so1119155a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692415059; x=1693019859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywK7pB708RT05aho6K2AOf9O+jr+/GhY6QVOujUXjMg=;
        b=EAZxwFR8lr75hZef4yV93yyy5z5t8tw9oKH2WVZ2wwOMgzmUVIYvH703v31wBZj0st
         LWMrUKiz5dAgnhiO0ai8AQHy2iMW7J5oKVZGNq7jSeeahKCLYS5+Ll7EOGFiTozrskkI
         qe+Mzc3emKcI55upfommCOLnspYnqrHMx2uAoVFR9DcJ2g0fpReUmPOSG7Ox3GzuB8Eg
         xXmwjV+q4q7eXYWttkXSYW4apafoyGauvIGc115/GDxQes6eQ/4m0qvRHvxAn8FxBkZ1
         8UWE6UFCDFaKmHM9iyOMICW1/Z0dVu8h7/kvs+HWhydVnwz2RfLZ45GhyBm1f6mNn0K8
         MoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415059; x=1693019859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywK7pB708RT05aho6K2AOf9O+jr+/GhY6QVOujUXjMg=;
        b=N+y7qzBndOvnaz9CYcf7Ex5dbuRIPbga/QSG9q2qrbx5hnXwDZC0IIJsFEkft0vz1p
         QcSq0ESmuk3bUDxz/nCN5KFxuND7panRp/gXXymAqNQT77LH4c6apXNipWEOXt8nxswN
         QvymofC/+s5H5LpjZPGycmly/aHfW47gvYnFUNDm2jO8J8+GwjlexCUWGwimp59AWJwq
         J9tWV8cljsDBXPjUOavklNV0POVsuJ567lxCDzFrnJeTos9ClUDAk1fl7yAiXFPsyWJQ
         tuvNDgVAyINeggyFNv9hLiKapTBWduo71Ne1LntH6V4m/wBSmZeqV7y1ADwzd74qenrz
         dXOw==
X-Gm-Message-State: AOJu0YxTRyCilkBK2L3gF7fKVEW+EIu0y2aoYLOf1PZmBDmpYlwj8Imm
        c+yS3NA0mzU4NCoSPIfiT0QBrQ==
X-Google-Smtp-Source: AGHT+IG3z/ftxlbhvKK3KIvkDqJPuSJNBah1zdTEDQNOh/hmITzg8KUBCrce/hks+OrDeNQugdBdNg==
X-Received: by 2002:a05:6870:b48c:b0:1b0:e98:163b with SMTP id y12-20020a056870b48c00b001b00e98163bmr1412828oap.21.1692415058935;
        Fri, 18 Aug 2023 20:17:38 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id bg8-20020a056871940800b001c530b51082sm1706780oac.46.2023.08.18.20.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:17:38 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     JaeHun Jung <jh0801.jung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: exynos: Enable USB in Exynos850
Date:   Fri, 18 Aug 2023 22:17:30 -0500
Message-Id: <20230819031731.22618-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819031731.22618-1-semen.protsenko@linaro.org>
References: <20230819031731.22618-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index aa077008b3be..198d1dfcc672 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -570,6 +570,36 @@ sysreg_cmgp: syscon@11c20000 {
 			clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
 		};
 
+		usbdrd: usb@13600000 {
+			compatible = "samsung,exynos850-dwusb3";
+			clocks = <&cmu_hsi CLK_GOUT_USB_BUS_EARLY_CLK>,
+				 <&cmu_hsi CLK_GOUT_USB_REF_CLK>;
+			clock-names = "bus_early", "ref";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x13600000 0x10000>;
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

