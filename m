Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21981196A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjLMQ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjLMQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:29:07 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB7110
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:29:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so8248064e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484950; x=1703089750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKKYqdbc3N4hC1UQxae75xN4voBqyRjMYCSX3oX7340=;
        b=JUZy9Kz6HdBfUuhevjMlVkUcD+81IIaH2omoXkJCS1JsxcMzC6q9zmNwONYQ51QFNz
         eaLAiYwH8LH9902JI+F4O6Rh91x9BqkBY/+gIi1uDtwF2RHp0Wfthy3f4PAJOh3ZJCdi
         P7eQD31WO7V3wySlzVr1ktB4WnhbldY/E1rD3Gb+XcgtoZ7fLUUbmksG0jkm/aGB0Eng
         t2sc9gd0JsWnHMPEBr36ut8vuX6Hx8+jcdtFH2xKsiX9YD3VPzmv9p6dyQb2hr/1jXCS
         zgGip/uUbqqHLwZeR7vUtd9EsBU6Bbs2/GLeCyfTHjmPXztAeILAvPAPq7lhcUyHacUV
         Mwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484950; x=1703089750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKKYqdbc3N4hC1UQxae75xN4voBqyRjMYCSX3oX7340=;
        b=RA8Y4b4VfWdFZB+niF+KaxSBmKFOohpB4dhDNPRAkFVgbj9aN2ooeyCNqfUCQY97lV
         W1dIfrGvDGOIn4KYhUPB+nFYEHwNXp4qND/SY/2VOkrc4KEcArI1dAaFnuRC7j6t38Uk
         R+xtuZNqwp1dm4i1iAblkgjlx6Ctv8FIr7QaAEdcdF7Xl8vmwuUFfSlrCZAOopRzMbEX
         Ag3OMNDkLMnlvgxLt63rZIC9yTCBTTM87FLz6iLdfQtWo+v2NfPRAq2aVw1OBFLDljbJ
         s9CqIeUw37VkXRS9d0tWN3D6yk8bznxaqPgK1pdoUefVVLWjo4XqkxkkPLqDzt6HTv5q
         f+5Q==
X-Gm-Message-State: AOJu0YxsXhYth0W+Zp7ySrMqHjF5PHHn83i+JBs3pxiqBhTDgoWvWBjF
        wz2dRG4gpG7PjTH49kzNBBRsbQ==
X-Google-Smtp-Source: AGHT+IFhiIHvz0lgDTjS66FZRNJnwWFEoOQlmEuaGIwBD+A+MfQB0UBwiU1ZeyyiB/CaBHRAQcATAg==
X-Received: by 2002:a05:6512:2211:b0:50c:a89:a70e with SMTP id h17-20020a056512221100b0050c0a89a70emr5033349lfu.94.1702484950440;
        Wed, 13 Dec 2023 08:29:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id br7-20020a056512400700b0050bfe37d28asm1641026lfb.34.2023.12.13.08.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:29:10 -0800 (PST)
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
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8550: drop unneeded assigned-clocks from codec macros
Date:   Wed, 13 Dec 2023 17:28:56 +0100
Message-Id: <20231213162856.188566-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
References: <20231213162856.188566-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCLK clocks of codec macros have fixed 19.2 MHz frequency and
assigning clock rates is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d8f79b5895f5..68b05ab5f65f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2045,8 +2045,6 @@ lpass_wsa2macro: codec@6aa0000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&lpass_vamacro>;
 			clock-names = "mclk", "macro", "dcodec", "fsgen";
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>;
 
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
@@ -2092,9 +2090,6 @@ lpass_rxmacro: codec@6ac0000 {
 				 <&lpass_vamacro>;
 			clock-names = "mclk", "macro", "dcodec", "fsgen";
 
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>;
-
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
@@ -2138,9 +2133,6 @@ lpass_txmacro: codec@6ae0000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&lpass_vamacro>;
 			clock-names = "mclk", "macro", "dcodec", "fsgen";
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-
-			assigned-clock-rates = <19200000>;
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
@@ -2156,9 +2148,6 @@ lpass_wsamacro: codec@6b00000 {
 				 <&lpass_vamacro>;
 			clock-names = "mclk", "macro", "dcodec", "fsgen";
 
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>;
-
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
@@ -2233,9 +2222,6 @@ lpass_vamacro: codec@6d44000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "mclk", "macro", "dcodec";
 
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>;
-
 			#clock-cells = <0>;
 			clock-output-names = "fsgen";
 			#sound-dai-cells = <1>;
-- 
2.34.1

