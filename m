Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B3811961
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjLMQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjLMQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:29:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759993
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:29:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso7015920e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484944; x=1703089744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEzLaoNa4BA2w8OvaI5sizwaYC3nqK5NDpqXu6xPo90=;
        b=EPaCDW3X65pt9lfhQDirUMYk6SCoBK/3UDqFB0I/I4ffRoHzcZgU/2n/oE3Y8VJ1ST
         09QWKkA3NX+8kwydIeMpnuL1Tic5bu6GdW32RMYHKCTFDkhcQu/uEya/clUz9upHQG36
         vmY7SPwX7Dg65keGSow7WOFAk6MRnUrywU2g0RYMuEkXCa19Ku6luR09CVKDAz1cgsOA
         9VKgkj5OJgXoBwPcrcrLNIJd34Ib3aoanBKNwsO5zaczD1lzxGUP84mSLx2VaA/mG8wA
         UHu5Am8ufx7NHpWmsY9wskoPFxCughn9IKmGm9fGnjq2IS9gsLcWY6zSzeJ59JIRZPUV
         Q3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484944; x=1703089744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEzLaoNa4BA2w8OvaI5sizwaYC3nqK5NDpqXu6xPo90=;
        b=uF5OmfxNkPDqPl+z1QY89bHpsEAYLKYbNpCCLhhWk/vUQJMnl+xKAia1y2P2SvE1Ov
         L8f3wtcL+P0xm3vvPIT6uaLiToECvYBpNCCbozjaT+XCmnTFp+Ti3FIcmAzN+6UTF2/Y
         v3hbCpp74kuQyaGwdEt45ASk2U90oK64+pNVRRvn2UzVMHy55W3GRnt/O3PU3uuq4Ixr
         IPpLoAw0j4gSEm0k69X6UCvj9bSKwPal9e/OGXyKXHyBtEuFnOBn8qt+6ivzyy5OZxVM
         ZAdg/WumpkxqibrQCDskYLSk2LSuKnUd07ix/1dZlxWJGAUCqPnYVEUCpJ6wfIee/blg
         dNuA==
X-Gm-Message-State: AOJu0YyWsZ7Nt/DXDySgdK/FjDgoyhn56V4Zdwn1v6DFMWrwzSoPxr5H
        3/zi6YjkomXONwGUG+S4gHK1hg==
X-Google-Smtp-Source: AGHT+IHtY5gkQmmJhndNfLTuymBN96U+PgF076ivxPPJWBCxoTTijgt9TkViwC9hvJ0o+aI9ZxUjpA==
X-Received: by 2002:a19:5e1d:0:b0:50b:f03c:1eb2 with SMTP id s29-20020a195e1d000000b0050bf03c1eb2mr3934707lfb.20.1702484944075;
        Wed, 13 Dec 2023 08:29:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id br7-20020a056512400700b0050bfe37d28asm1641026lfb.34.2023.12.13.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:29:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm8450: move Soundwire pinctrl to its nodes
Date:   Wed, 13 Dec 2023 17:28:53 +0100
Message-Id: <20231213162856.188566-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
References: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin configuration for Soundwire bus should be set in Soundwire
controller nodes, not in the associated macro codec node.  This
placement change should not have big impact in general, because macro
codec is a clock provider for Soundwire controller, thus its devices is
probed first.  However it will have impact for disabled Soundwire buses,
e.g. WSA2, because after this change the pins will be left in default
state.

We also follow similar approach in newer SoCs, like Qualcomm SM8650.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 12e55a0c7417..3b6ea9653d2a 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2160,8 +2160,6 @@ wsa2macro: codec@31e0000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa2_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2173,6 +2171,9 @@ swr4: soundwire-controller@31f0000 {
 			clock-names = "iface";
 			label = "WSA2";
 
+			pinctrl-0 = <&wsa2_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <2>;
 			qcom,dout-ports = <6>;
 
@@ -2208,8 +2209,6 @@ rxmacro: codec@3200000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&rx_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2223,6 +2222,9 @@ swr1: soundwire-controller@3210000 {
 			qcom,din-ports = <0>;
 			qcom,dout-ports = <5>;
 
+			pinctrl-0 = <&rx_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1f 0x1f 0x07 0x00>;
 			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
@@ -2254,8 +2256,6 @@ txmacro: codec@3220000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&tx_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2275,8 +2275,6 @@ wsamacro: codec@3240000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2288,6 +2286,9 @@ swr0: soundwire-controller@3250000 {
 			clock-names = "iface";
 			label = "WSA";
 
+			pinctrl-0 = <&wsa_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <2>;
 			qcom,dout-ports = <6>;
 
@@ -2318,6 +2319,9 @@ swr2: soundwire-controller@33b0000 {
 			clock-names = "iface";
 			label = "TX";
 
+			pinctrl-0 = <&tx_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <0>;
 			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
-- 
2.34.1

