Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A87F708A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjKXJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbjKXJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:50:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEEC1726
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a00c200782dso247638766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700819454; x=1701424254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx18rA2y6Wad6extsCB/aaPxXeVqimMyu9sQYRVs6ZU=;
        b=wiK3GR4Jp0hUfrRS7ZXjDNiDUw+aOi/xz30ckm0+U1IXDi2l1M22covXXUeWQu+1vF
         YqYpe60INbUrN3Bzz769wmQb26eZwEBp3YcaL4MP8Nw8a29LA4GBjXhIdjFAIFfOBNIf
         HZ2ICsuxFMiO/NQJ2F5GBbRDUOE85M9P41Z4jEjy921XpCvdaW3gp3hCL5DcyHI3NUgz
         8Y0bOPpBjWtIZ3VIDKdVBLggHEYBQ7OINIwDjoi4QA1vMtqzq40xJrW8AsJj52YpWBE3
         0HPBGhDY+bskUZpZZNZgkY0MPpxXCGSs516oS40FkCUophG95WSsAha3sS1apmOlDswm
         x8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819454; x=1701424254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx18rA2y6Wad6extsCB/aaPxXeVqimMyu9sQYRVs6ZU=;
        b=d3i5dn1/l7oWX3Y9oapYbRPNgp11lM1A2jpHSSW13YRcAzVvG/QOGslDJ9FIWtsZZQ
         OqkeLpRJWf9nPA1Avf1N7ErPnVrMEkCICodCl9OOEYnFXOc+GwPVMfXseyAYGU7/RJjM
         FAzFhGDkkkYjXFoOZWAKztrwz6AZHpQGaP0hBaF9gR5iMSkoOToscwRMbquDS2b01MOF
         wBzn6h94YBtJlu8Djn092NpSMcwHKu/f1A5UCSreO8pBF8pKahZEepf8ygHyOe4psetx
         XRTgBqWqilbHRP1BAsQqXfj0Km7Wf2cdwQziwb2/QO/1BrEJBR6m/qWwzC8Pa2BZuWo3
         ecfA==
X-Gm-Message-State: AOJu0YxX6h2J8vj8lkDlxtli5wFTNOyKCFGFQOrO7m5mWAUlM9h1T/jY
        tUsjTRv86pEZ6qTn1H1Chv/PVg==
X-Google-Smtp-Source: AGHT+IF/Kj151aZl65Ec3MTWrsorvLgbVuYtcq5C+dh8wsePro42bdrA/qCyqBaitU44u3s3bi7D3w==
X-Received: by 2002:a17:907:9728:b0:9be:7b67:1673 with SMTP id jg40-20020a170907972800b009be7b671673mr1845816ejc.1.1700819454216;
        Fri, 24 Nov 2023 01:50:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id w21-20020a170906481500b00977cad140a8sm1854824ejq.218.2023.11.24.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:50:53 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: qcom: minor whitespace cleanup around '='
Date:   Fri, 24 Nov 2023 10:50:49 +0100
Message-Id: <20231124095049.58618-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124095049.58618-1-krzysztof.kozlowski@linaro.org>
References: <20231124095049.58618-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts               | 2 +-
 arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts               | 2 +-
 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts               | 2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
index e89e2e948603..846413817e9a 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts
@@ -15,7 +15,7 @@ / {
 };
 
 &blsp1_i2c1 {
-	clock-frequency  = <400000>;
+	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c_1_pins>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
index efd480a7afdf..ed8a54eb95c0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
@@ -15,7 +15,7 @@ / {
 };
 
 &blsp1_i2c1 {
-	clock-frequency  = <400000>;
+	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c_1_pins>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
index eb1fa33d6fe4..d5f99e741ae5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
@@ -15,7 +15,7 @@ / {
 };
 
 &blsp1_i2c1 {
-	clock-frequency  = <400000>;
+	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c_1_pins>;
 	pinctrl-names = "default";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index e7de7632669a..ef7a4e285897 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1004,7 +1004,7 @@ mdss_dsi1_phy: phy@1a96400 {
 
 		apps_iommu: iommu@1e20000 {
 			compatible = "qcom,msm8953-iommu", "qcom,msm-iommu-v1";
-			ranges  = <0 0x01e20000 0x20000>;
+			ranges = <0 0x01e20000 0x20000>;
 
 			clocks = <&gcc GCC_SMMU_CFG_CLK>,
 				 <&gcc GCC_APSS_TCU_ASYNC_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts
index bb149e577914..edc0e42ee017 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts
@@ -46,7 +46,7 @@ camera@1a {
 		assigned-clocks = <&camcc CAM_CC_MCLK2_CLK>;
 		assigned-clock-rates = <24000000>;
 
-		dovdd-supply  = <&vreg_l7f_1p8>;
+		dovdd-supply = <&vreg_l7f_1p8>;
 		avdd-supply = <&vdc_5v>;
 		dvdd-supply = <&vdc_5v>;
 
-- 
2.34.1

