Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09107F708D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjKXJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbjKXJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:51:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454561989
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:51:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a00191363c1so250407366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819471; x=1701424271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuDOFshCyU3coVU446XYIMnSf85Dt0KIkrnt8ifjQVE=;
        b=VnFZTfHNGJf/2wVUiJQ5e0a12QNPA4mNA/xCwK7Olcz+38TGUG2I5Al5WBn5rht9Uz
         Hc8GWwGE0ki+ZGNanhaVEn5DebRH5017cyMt0qMY55qxKgCbzW7K5j7AkAwugkIIB7yo
         PTs7mHQWrj0mNzAF6/UqkSmektmYszb44yN/dP3VIwEEHLjlDbjzJcxgZAlu8d4IHdiP
         eJ0Hc5C4f9SL/dK57v/zIwLi6ny/TWrhsV8QYmWa0IHUhYO+isZ9Z3qdFNH4xRwWexGW
         Dk4A/y14ipFN3Kmt2TWfZyW1PvW+ixEUJGCvEwo9hbb1eUveYHKuZ7QdJ/+R/YZENyil
         XhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819471; x=1701424271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuDOFshCyU3coVU446XYIMnSf85Dt0KIkrnt8ifjQVE=;
        b=RjZJAGoTGk/3uzAirCiKyjFb4qc/rGpGbvduq3tWqc5DADNTp4XIDwGc5FymIb/S5G
         mI3ZsX/YavgPqjjpTwYS6CgWpM0m9X1zHeo6C8wROW8AkjpcyKf91B+KjgtzGgRiSo42
         XCVyIHh2v0dpkD5syWA/Ite+n6tgRcfuueO1CMzyTumto/GX9oZrRgyIBEXYTffrgQUW
         Co/qDJRep2drgrlAw/m06sA9/uRRjhyN3k7Y563NPZM8QMT5ymQXPa/AGoD/6hGk8Hkg
         zeT1Ar+BDpCz1swrqwgwVP5bOIwMhvfbYp5vggEbe1enHO4XEMwR8WF5/fwlo103f6MQ
         g+9A==
X-Gm-Message-State: AOJu0Yx9vkjgv3i90O9AQbds5rb110t7ytApIWJs+Bfzz6rWyCdsc5cJ
        D+XknYy+/Sy4ZbncOeBVJ9P3Kg==
X-Google-Smtp-Source: AGHT+IFnYUEpxM6+MO4FHi8gA7/3IXWQ5LtYjgtsMjqaoP5O6widfgKgio/Ol9NNPz9PpvhuAF02Qg==
X-Received: by 2002:a17:906:3915:b0:9ff:9db9:1da7 with SMTP id f21-20020a170906391500b009ff9db91da7mr1597217eje.29.1700819470822;
        Fri, 24 Nov 2023 01:51:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id ga10-20020a170906b84a00b009fd0102f71asm1860789ejb.176.2023.11.24.01.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:51:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Li Yang <leoyang.li@nxp.com>, Stefan Agner <stefan@agner.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: freescale: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:51:04 +0100
Message-Id: <20231124095104.58772-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124095104.58772-1-krzysztof.kozlowski@linaro.org>
References: <20231124095104.58772-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi             | 4 ++--
 arch/arm64/boot/dts/freescale/imx93.dtsi              | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
index e4215c83ee0f..da4b1807c275 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
@@ -57,8 +57,8 @@ sgtl5000: audio-codec@a {
 		clocks = <&clk IMX8MP_CLK_CLKOUT1>;
 		#sound-dai-cells = <0>;
 
-		VDDA-supply  = <&reg_vcc_3v3_audio>;
-		VDDD-supply  = <&reg_vcc_1v8_audio>;
+		VDDA-supply = <&reg_vcc_3v3_audio>;
+		VDDD-supply = <&reg_vcc_1v8_audio>;
 		VDDIO-supply = <&reg_vcc_1v8_audio>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index c9a610ba4836..5070dff253c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -793,8 +793,8 @@ pgc_audio: power-domain@5 {
 							 <&clk IMX8MP_CLK_AUDIO_AXI>;
 						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
 								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
-						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
-									  <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>,
+									 <&clk IMX8MP_SYS_PLL1_800M>;
 						assigned-clock-rates = <400000000>,
 								       <600000000>;
 					};
diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf4766440..18a1c36f05d9 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -755,7 +755,7 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
 				clock-names = "ipg";
-				dmas =  <&edma2 90 0 1>, <&edma2 89 0 0>;
+				dmas = <&edma2 90 0 1>, <&edma2 89 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
-- 
2.34.1

