Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C0811B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjLMQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjLMQZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:25:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80948DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso830913a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484741; x=1703089541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKxXRg/SZys6FO13tqlijkOM+4H33mlk0pHh32bAe4Y=;
        b=Lu+na4VVfszJlk5xn0E0Bxp56SFHLEoYRPFODY968yxiNRPAy3ECzUKbCahZH7kwOz
         xVArhZF+wgkPJnx7DnkIjZ6p0UDKwakNx5iD2RcdKbemdfn3u6FV/IeBdv7WzhuzCUVa
         AY55c/JI43PIQnMeEKdt25WsoYm7erimrlYL7BS8d13zjYdCdOqRQD6xFdNe+dYbrB2K
         BeUbNc829/dHFpRHci4l65IvzQI3trFmvuMOzs583WLta2cdX1nin3o09q7BCJRo1TVm
         BL77qjnrHIh133QijNoGhhUYbIl/1YnQtRvbr5FxZ2bjd//zHEWiTVX1UIsl5L12Y26f
         Grww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484741; x=1703089541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKxXRg/SZys6FO13tqlijkOM+4H33mlk0pHh32bAe4Y=;
        b=SZ5CsrISXlbCraxQqFDyYL72b2iamI38cMlSCmRnbOmUkAqafwDxmMeR9RxHd6XbWP
         /cp9mmjmDRtcRxGVTmDDJT8j2bJ/ZTpCKKGVGWNd/ueSd/HxPR4X6pU1p23r/shMu0MW
         ZIFSZLYEqn3orYfp71OtzAw/H5ViMgwDbH/7zz5J9jI1nHzC8E3SDTGX42JkjFoGO/OD
         3Ofa4dAFbO8M6fB2WisyRWY5W28fER7g39AMR28Gp89sRAN2Az552hHcxlM9nQYRZ0b8
         gR6dogCtDbbcWr4IsqFV3nBePcTFgrNI1bYGjkRPi9uHuc8J5v2Ea3tHTvTJJooTXpCg
         Kmfw==
X-Gm-Message-State: AOJu0YwsIJYvvcb3uqHCCSzL77bmXTzEtgEVrBBKd6O38KFiVScAGeYa
        R86QzdDkRRdQy7HvtgD8aTXD4w==
X-Google-Smtp-Source: AGHT+IFv5LFyq6GSFNmr0clEapUNiqem0EWn7blPPyL1WqT+BoCaSNH81eJ/OylrsOyXgKxtMg++kw==
X-Received: by 2002:a17:907:766f:b0:a19:d40a:d1ff with SMTP id kk15-20020a170907766f00b00a19d40ad1ffmr2128393ejc.203.1702484741003;
        Wed, 13 Dec 2023 08:25:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090778d200b00a1dfc541282sm8048914ejc.225.2023.12.13.08.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:25:40 -0800 (PST)
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
Subject: [PATCH 2/4] arm64: dts: qcom: sm8450: drop unneeded assigned-clocks from codec macros
Date:   Wed, 13 Dec 2023 17:25:33 +0100
Message-Id: <20231213162536.171475-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
References: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
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

The MCLK clocks of codec macros have fixed 19.2 MHz frequency and
assigning clock rates is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on HW.
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 3b6ea9653d2a..52390220d909 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2154,9 +2154,6 @@ wsa2macro: codec@31e0000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&vamacro>;
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-					  <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>, <19200000>;
 
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
@@ -2203,10 +2200,6 @@ rxmacro: codec@3200000 {
 				 <&vamacro>;
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
 
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>, <19200000>;
-
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
@@ -2250,9 +2243,6 @@ txmacro: codec@3220000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&vamacro>;
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>, <19200000>;
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
@@ -2269,10 +2259,6 @@ wsamacro: codec@3240000 {
 				 <&vamacro>;
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
 
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-					  <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>, <19200000>;
-
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
@@ -2348,8 +2334,6 @@ vamacro: codec@33f0000 {
 				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
 				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "mclk", "macro", "dcodec", "npl";
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>;
 
 			#clock-cells = <0>;
 			clock-output-names = "fsgen";
-- 
2.34.1

