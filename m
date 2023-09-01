Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7211278F9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjIAIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjIAISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:18:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A069510E6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:18:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-991c786369cso201174166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693556299; x=1694161099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTKmHqxdbbgU1JE7lxhnJDHkPsC++RCUQ0vzQOeOdeM=;
        b=bgznRccpBQwxz9X9mMtZPtpk7Bl6Qm7gH0OLkmY0JsAXuhU8gYFJ0hdXbYUpyODYqH
         0eg/v1cedVhrH2OLD7e3QG81Vqa3OWvmp8puRFCUpaIWiJouamd7cYzlZYmELP1AgckG
         lEoIKTQ2eKoqFbkpbp/WcVOkoZRXESjLHyHi2XXma7r9oMA62H0FMPY2Hu9VeT2e2Nbc
         6q4X3mqSq+WxdI2HHL22zFsKomjoc6V908q2veIopff6u9+kj2Foc/KF4yck0Hsz4qwx
         P01nh5h6f5wS+SfKlew5fV8w973dIJuRi73gmuK2Oqme9A+rzdbGfPzRm8G+Xi5fO3PE
         17ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693556299; x=1694161099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKmHqxdbbgU1JE7lxhnJDHkPsC++RCUQ0vzQOeOdeM=;
        b=dv4qBVByN6R7HjPFSGD1USpbpIhV0sl/myJiZdm6DM/deWUNd+hYxSqxqn+YLUT1WY
         qrIjMnMt3QhQzhbSveXza9b6tFcXKbfjaiMq1c3L3rxYaZEe45n3iwPlOBjJqEZotDGu
         a3NBnhechQO9ohZRJ7Ctppl2Eggx2oGFLnG8K6c2PEBYa334+XQ16IMokTjg7vePjh7A
         ID23bXx3Tc3QXSR7fw0vKEqoJMFff97EQcCCKir6riMHNQ79YFkvgAPe7d5dR4gYgP74
         N/XkCAyty+ojqhX9jRW8LMKlUWp1LIDva6cAtFLWa6kHxij3hMDydPGcILB9L+YFhBa4
         li1A==
X-Gm-Message-State: AOJu0YwMqPEEgXsJKMSzgpdPirl3fZm0cTMd0r3iyHcrfkQEl3o3zwv1
        a18Bzer8QwvFVYSDHtYY0S3NxA==
X-Google-Smtp-Source: AGHT+IGqacyPL0i0XUZoFYuwR5IbzcWzdf6+ZY5GzbHzlOO0OAM1K6lJBQyJ1+shNoedmW5/V913tw==
X-Received: by 2002:a17:906:dd:b0:99e:1358:ffdf with SMTP id 29-20020a17090600dd00b0099e1358ffdfmr1154688eji.72.1693556299149;
        Fri, 01 Sep 2023 01:18:19 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id b6-20020a170906d10600b009a57d30df89sm1676657ejz.132.2023.09.01.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 01:18:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        stable@vger.kernel.org
Subject: [RFT PATCH 2/2] arm64: dts: qcom: msm8996-xiaomi: fix missing clock populate
Date:   Fri,  1 Sep 2023 10:18:12 +0200
Message-Id: <20230901081812.19121-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
References: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
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

Commit 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus
from clocks") removed "simple-bus" compatible from "clocks" node, but
one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
CLK_OF_DECLARE.  This means it will not be instantiated if placed in
some subnode.  Move the clocks to the root node, so regular devices will
be populated.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Closes: https://lore.kernel.org/all/CAA8EJprF==p87oN+RiwAiNeURF1JcHGfL2Ez5zxqYPRRbN-hhg@mail.gmail.com/
Cc: <stable@vger.kernel.org>
Fixes: 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus from clocks")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 32 +++++++++----------
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   | 16 ++++------
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index bcd2397eb373..06f8ff624181 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -11,26 +11,24 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
-	clocks {
-		divclk1_cdc: divclk1 {
-			compatible = "gpio-gate-clock";
-			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-			#clock-cells = <0>;
-			enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
+	divclk1_cdc: divclk1 {
+		compatible = "gpio-gate-clock";
+		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+		#clock-cells = <0>;
+		enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk1_default>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk1_default>;
+	};
 
-		divclk4: divclk4 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk4";
+	divclk4: divclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk4";
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk4_pin_a>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk4_pin_a>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index d1066edaea47..f8e9d90afab0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -20,16 +20,14 @@ / {
 	qcom,pmic-id = <0x20009 0x2000a 0x00 0x00>;
 	qcom,board-id = <31 0>;
 
-	clocks {
-		divclk2_haptics: divclk2 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk2";
+	divclk2_haptics: divclk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk2";
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk2_pin_a>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk2_pin_a>;
 	};
 };
 
-- 
2.34.1

