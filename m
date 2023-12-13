Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3A811946
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjLMQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLMQZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:25:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7665AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-55225ed7ef9so919814a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702484743; x=1703089543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDQI7CGNXE5QtDrGTA7vjhneNjlnGJyq3B8Gpd+RnjY=;
        b=pzuNlUOhIoTE4WWFVONCAdtW6UTIvY2igyhxfa08zkdkKM+BAjSBHODmWqaIU+iXcb
         6BnHlv64y7fq50Wn286F5ME9RGmDLbLojh4we1hF2gB+zd0lij1dSWRwZpnq7Wb3DNyX
         NF3nyrE+OH7VljP4LBlyg6Y24cL6QcpCEntCIFCMqnb3rzzd+8S6xKDRPUDRrvf8fofQ
         wWDg+H4ZNGW40RIhmhaCHafBwmmt82LuW2Fjb7o0kLlzSeAhB17gNYJiiSe4fs8eZg7B
         RGA+55w2qEJw1jvjqybp32MLflhvQIDkCmDQ+tMEQj02vzFsOTyayAMGr8uwQQNPyW6A
         0HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484743; x=1703089543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDQI7CGNXE5QtDrGTA7vjhneNjlnGJyq3B8Gpd+RnjY=;
        b=VCJzw60HW83oeHd5FtDV0hO+KoxTaeolH/KxPsNzHLVckoJPxLmr9mGDHKaJCKFSDu
         oCKMT+VOxBumX3Bp/k/ySBPwGR7MwBoPqb7XW26H2hiyKsGFiH5q02fzgpzxSwwFw9DJ
         iMdPj+uXLpxTObAi/7/jDeXtLXjXr/mlvlPNVVPxEwxk9j0ZNFa9Hqjj0gDAbY4Sb/S5
         DRjz4ERiSyIq4uiFIoU8k5cBBKC0/rllwdQefQfb9fkOQ7IHDGJd5QOkhcz3uN9f97sP
         n9rFbwzN3RZFtk/7Ppefilt4DOopdkDhJqG4r9Rm56q3Y+OLhyzImH5zGjdGzjkQ2Lv6
         ldYg==
X-Gm-Message-State: AOJu0YwjH6KoNPyHWPFdSraD3lpsPPpIMwYxd/NokpZTx55EvZ4tbylZ
        2XE+8EHt04dP8vxBJHrzZGEv2A==
X-Google-Smtp-Source: AGHT+IFYR8rsO1VF//8r3xp61FMiOmVTtJhWR3SeKc7XhW8dyZuYFpYd2aa1O950RUJUMP4pn9sS4A==
X-Received: by 2002:a17:906:c30a:b0:a1e:26ae:3ac5 with SMTP id s10-20020a170906c30a00b00a1e26ae3ac5mr4881307ejz.39.1702484743452;
        Wed, 13 Dec 2023 08:25:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id kv18-20020a17090778d200b00a1dfc541282sm8048914ejc.225.2023.12.13.08.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:25:43 -0800 (PST)
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
Subject: [PATCH 3/4] arm64: dts: qcom: sm8550: move Soundwire pinctrl to its nodes
Date:   Wed, 13 Dec 2023 17:25:35 +0100
Message-Id: <20231213162536.171475-4-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 1f06fd33d1ce..d8f79b5895f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2050,8 +2050,6 @@ lpass_wsa2macro: codec@6aa0000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "wsa2-mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa2_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2063,6 +2061,9 @@ swr3: soundwire-controller@6ab0000 {
 			clock-names = "iface";
 			label = "WSA2";
 
+			pinctrl-0 = <&wsa2_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <9>;
 
@@ -2096,8 +2097,6 @@ lpass_rxmacro: codec@6ac0000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&rx_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2109,6 +2108,9 @@ swr1: soundwire-controller@6ad0000 {
 			clock-names = "iface";
 			label = "RX";
 
+			pinctrl-0 = <&rx_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <1>;
 			qcom,dout-ports = <11>;
 
@@ -2142,8 +2144,6 @@ lpass_txmacro: codec@6ae0000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&tx_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2161,8 +2161,6 @@ lpass_wsamacro: codec@6b00000 {
 
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa_swr_active>;
 			#sound-dai-cells = <1>;
 		};
 
@@ -2174,6 +2172,9 @@ swr0: soundwire-controller@6b10000 {
 			clock-names = "iface";
 			label = "WSA";
 
+			pinctrl-0 = <&wsa_swr_active>;
+			pinctrl-names = "default";
+
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <9>;
 
@@ -2203,6 +2204,9 @@ swr2: soundwire-controller@6d30000 {
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

