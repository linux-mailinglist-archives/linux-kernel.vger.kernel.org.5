Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414375E289
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGWOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:19:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDC295
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:19:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99342a599e9so613250366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690121949; x=1690726749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5FB5ZO/DLK/TJzYNBRV/vPk/ZU5q9dvWvxl0g1I8Eg=;
        b=eMwZMbUGBJL5dYGR0ZzrWk1O6sCm8LVrA9X2i2caa0kkEBeH/WxUs8dUi0O5pFiOdL
         D9EPFXw2zniUZID7lZU7YmDBrmphWcjb2U64ECPcti5Ez53bj3u1SbAt/Q2VvMcLS6i6
         I+OqftSS8BKBE3QmqHgvj9m/ZFlRuBA60oTckSknHRslT75gHB4vXj9r+ugm8RPGdYVI
         BfMY9IElIW49sgqkP262UNv1TbQ4ezx9OIg2uPtToUXHtvDC9x764A+kgB/v2kzvAo3y
         cMwphj3p+V2GLg3fPPSsUbtTOpqA/fIHPfByTByL5rK4vP+f+xWbGSEnUN8nzX3uBX55
         WDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690121949; x=1690726749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5FB5ZO/DLK/TJzYNBRV/vPk/ZU5q9dvWvxl0g1I8Eg=;
        b=daGNIY62xN38uOWgNEDxENtWEmp3n7WynmR4jFtt7mqmKnUiiAdJWXVCGMGj39IPOM
         8q9FKhVHnztnLebl6JicGlru4mDPjuzfbmZf0lgHNluO7IEH+f49qgQfpfwgQc4yB94j
         zlnIQ+dT7/F+1Ih9Phj7KwcGXc2ryWnlK218E5C1Ay1UhowIfYr26AegEIcfCcLrGXvN
         jJuK1U1LPnBOd8CO94SiV5ybTljTli7NNAnpJu5rbvZXGYREsHLBLsc+b4aenN1v7GsH
         miBXuMpEwM1TdeWoB2Vl417m90/lF4MiwKZCfhyqKi0LdbCclSg5gdYjW2hsowsYr5Gt
         Z2ew==
X-Gm-Message-State: ABy/qLYZ72wSQ5F/JcbrK08MiGwvzzQ/5Oo32n4EgkjfKPO9LlS9WZGz
        4TlyXfRasCmFPlkwYBJd7UNaJg==
X-Google-Smtp-Source: APBJJlF1SsqMRL2/Wp7qV0zpZP1xcyF6wEFnHKCxgEUm4AlM4OIo2d9TFKNbUJwwuv2GLXRXJRXnww==
X-Received: by 2002:a17:906:25d:b0:992:a80e:e5bd with SMTP id 29-20020a170906025d00b00992a80ee5bdmr7928460ejl.48.1690121949438;
        Sun, 23 Jul 2023 07:19:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cb14-20020a170906a44e00b00992eabc0ad8sm5172438ejb.42.2023.07.23.07.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 07:19:07 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: qcom: sc8180x: align USB DWC3 clocks with bindings
Date:   Sun, 23 Jul 2023 16:18:48 +0200
Message-Id: <20230723141849.93078-1-krzysztof.kozlowski@linaro.org>
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

Bindings require different order of clocks for USB DWC3 nodes (sleep
before mock_utmi).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index e39341435289..87c00450f068 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2572,14 +2572,14 @@ usb_prim: usb@a6f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
-				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
 			clock-names = "cfg_noc",
 				      "core",
 				      "iface",
-				      "mock_utmi",
 				      "sleep",
+				      "mock_utmi",
 				      "xo";
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 			power-domains = <&gcc USB30_PRIM_GDSC>;
@@ -2618,14 +2618,14 @@ usb_sec: usb@a8f8800 {
 			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
 				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
 				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
-				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
 				 <&gcc GCC_USB3_SEC_CLKREF_CLK>;
 			clock-names = "cfg_noc",
 				      "core",
 				      "iface",
-				      "mock_utmi",
 				      "sleep",
+				      "mock_utmi",
 				      "xo";
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 			power-domains = <&gcc USB30_SEC_GDSC>;
-- 
2.34.1

