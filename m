Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF5768506
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjG3LUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjG3LUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:20:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA2198C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:20:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so4741779a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690716027; x=1691320827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbkpHrgM0RLW6a5i0Umen1/SqpOGIJ8G6Jf/9uq8g3E=;
        b=nt03HVzw5EXg69Ewy3rrz3GN1JLFq5DCnlZyobLskkNSdssz0FuLPSlBtkbOvS0XoS
         gQFY+yhsoQ8BNpH1zAjfoUOYGVXyDHW9f+0mfcyZMaexy4FVApO/ysnRW1ZbS3bLO8og
         GrY5naK0lixL2J872qg1GH/MLY4hfeNnsn4mvFz+P7XN1bfkzN8UASYRek4haGsydlix
         7dc1Zcjn7OQlvvJNp7JsNjpq9fmiD3ZjCB8nm95Lth9SQQITwKhnY385k4X1A9xS2BZJ
         esP0Do10+VXNlfEgPuMeLceY+E5AkXmIbNf3EQtcinnXYJbIppxDNZUBVjXZjFEjr4nX
         fiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690716027; x=1691320827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbkpHrgM0RLW6a5i0Umen1/SqpOGIJ8G6Jf/9uq8g3E=;
        b=J76D6TkgEhezt69S0xlhxuwL4ATHysFoPJ1eUhLzeyz8zKxUHz0j3fogLVSq1N3xev
         YyBlEqJ8NjnkCF/9TEMnZf1d7CHX0SlOFg6PkSHc2ACsS2Kh3py4DpqkEUBdZBK/8h9N
         JAALmMyorVrgjOJNXIXoIiTBelYhGlCodMCTXCfGsz1b41U7Dux3yJ0d2xRvLXuT/NAE
         JF09ETPg0geyKm6PB5XXAGl24BzVHFuhSuiRCEVxVbxP2uq5BZnjG6zVIfRo5qH5H7YL
         EAKtX1Bz6rP95VY92xOZevIdSjYMp87Spfa0N5A+ZhV0Y6S32k3xq9uFGqzEP8JyQ+uf
         JEWQ==
X-Gm-Message-State: ABy/qLY5e/1l9PAMErdWMBVqTyoAgn84iUz+njE/+h+piwIkUtEcmOmY
        PVEn6WONweEN/kJLTOIp30SK8g==
X-Google-Smtp-Source: APBJJlF2tcexHoMj9D2Oec55kG3jzWL3qJq3OWDY0EKRIftui9QDxkRuHi2rQ7xkKU/JkGeVN8s7vQ==
X-Received: by 2002:a05:6402:50d:b0:522:2a3c:6eb with SMTP id m13-20020a056402050d00b005222a3c06ebmr5353777edv.39.1690716027593;
        Sun, 30 Jul 2023 04:20:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7cac5000000b005222dd0b2fbsm1643569edt.92.2023.07.30.04.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 04:20:27 -0700 (PDT)
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
Subject: [PATCH] arm64: dts: qcom: use defines for interrupts
Date:   Sun, 30 Jul 2023 13:20:24 +0200
Message-Id: <20230730112024.120903-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard-coded interrupt parts (GIC, flags) with standard defines
for readability.  No changes in resulting DTBs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi  | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index af6d644a5d38..6e24f0f2374f 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1975,7 +1975,7 @@ wcnss_iris: iris {
 			};
 
 			smd-edge {
-				interrupts = <GIC_SPI 142 1>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
 				qcom,ipc = <&apcs1_mbox 8 17>;
 				qcom,smd-edge = <6>;
 				qcom,remote-pid = <4>;
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 25124acf705f..1b2c82a1db43 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2290,50 +2290,50 @@ timer@17920000 {
 
 			frame@17921000 {
 				frame-number = <0>;
-				interrupts = <0 8 0x4>,
-						<0 7 0x4>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17921000 0x1000>,
 					<0x17922000 0x1000>;
 			};
 
 			frame@17923000 {
 				frame-number = <1>;
-				interrupts = <0 9 0x4>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17923000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17924000 {
 				frame-number = <2>;
-				interrupts = <0 10 0x4>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17924000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17925000 {
 				frame-number = <3>;
-				interrupts = <0 11 0x4>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17925000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17926000 {
 				frame-number = <4>;
-				interrupts = <0 12 0x4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17926000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17927000 {
 				frame-number = <5>;
-				interrupts = <0 13 0x4>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17927000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@17928000 {
 				frame-number = <6>;
-				interrupts = <0 14 0x4>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x17928000 0x1000>;
 				status = "disabled";
 			};
-- 
2.34.1

