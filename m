Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E07811B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379353AbjLMQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjLMQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:25:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1642793
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so2247530a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484744; x=1703089544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKKYqdbc3N4hC1UQxae75xN4voBqyRjMYCSX3oX7340=;
        b=IRjoeVM21R50j1yLy4kKukHS9xBIp55PFTv5n2NJ5jVAs2ihEIzk2K0bsKKXU/ivOk
         CzLqgRosjcL1ahA0KgIt9/bE78pIdsks3PwivTIE06LDuWYhk6YM344kmHLbuXKmgsFh
         KEKxrHldvqMPZnBMMzAVdEE7gW6vavWPQLZWNn4GaV6hyDM2IcNUeQB0yfDixqdHn7sa
         FykaFqlZx1WfLsjACx2NCnFBpmtbWHlGV+nt1ndW2kAqe+JQoIY7JV9YuXkiofFzbWSk
         IaPDA+nMCAGqr8FxCVSkvY6BS4bcrrAUzkElRDvR5HGPb0mMSeiTDWoV2H4oMlKn+j3J
         rOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484744; x=1703089544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKKYqdbc3N4hC1UQxae75xN4voBqyRjMYCSX3oX7340=;
        b=kWF4IQLD/lJzeAFBxPy34fc6lJ5YT8M3ZIzDb35HxXNPaXaDUauZSQKdOQK1dIwv7k
         WcBEN2Q2barlPOcEVtpcruXI3Pail3hpckK7n34Da41fbsis63T626NjmSHP3jzcuXIx
         bSWbcb8PA6qKzQ5fKvmAA6FMA+S2yvL6gXJuAuhvkxaIOeNZ7n7OLl1e2UJQOOQTPVfu
         DVBnQ+O1H4TVRdSka/tY5Zvr8A/8nu9/5XfFnG44kUuAyZCFeLFuRmL2DVDbRc6GsqO1
         TfJd5B02dUEYFN9yv6wrjkNoV6oKn+I1nrqUpO4VmfgPwG1RwRl0tHPjhynsAhf9lmwh
         nvCw==
X-Gm-Message-State: AOJu0YxroOL1E9Eat8utbCaKsu8htttaqYEAIHbmwaIPLrVAkmSG/jBC
        K29Pf20ikKuOLkMF7sErslr5Tw==
X-Google-Smtp-Source: AGHT+IHFG0Jl0N1DKFBn/+nExVQ68zOY5N449WKqehTKJtP9936qUdH+d5NImFZgsBsH6Okeu2Dl4A==
X-Received: by 2002:a17:907:270f:b0:a1e:a558:748c with SMTP id w15-20020a170907270f00b00a1ea558748cmr8642392ejk.18.1702484744603;
        Wed, 13 Dec 2023 08:25:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090778d200b00a1dfc541282sm8048914ejc.225.2023.12.13.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:25:44 -0800 (PST)
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
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550: drop unneeded assigned-clocks from codec macros
Date:   Wed, 13 Dec 2023 17:25:36 +0100
Message-Id: <20231213162536.171475-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
References: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

