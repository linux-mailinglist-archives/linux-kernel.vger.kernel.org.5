Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F79813105
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573253AbjLNNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573217AbjLNNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:10:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03CD123
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso11209712a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702559423; x=1703164223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkPjyOsSUhY6dxE7NSMeG9MG/tOgoWLSmdJD8Lb9JH4=;
        b=d6Dn4NbbLduEbBf3tZmaQN6gYTrh7UMdEIhoaZpzyvz8F8NwC/N/jXQU+YtoXT2/Ge
         rPWXORcQVq0CEeYVUzAuI9r4aie+nlhN7QMCAf/3Yc8gUd6C6Flf2SgGoFMP+radGWF4
         GbfPa+EW83brexc4wceg7r9fRRTpM19NdiCCB4NQX8BXC7dmU+n4+joejvmnyzwdS6RP
         JuCT5T+3F1lAUSmXWJhyAO+YsaS8rcSsfjnUSSghOemZsHfmjly+jlrwj+J+m8YuNGw8
         fIknQDpW9OKcVdfUS82wcKQFoQh9zhuwDi93tXMdlRM/U7WLgrKO9v8CPMFbDq93YQAl
         QrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559423; x=1703164223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkPjyOsSUhY6dxE7NSMeG9MG/tOgoWLSmdJD8Lb9JH4=;
        b=YDxageRSWWT0VF+TmQgCE++0eNQejwo9D31i7HEaEXpd4tz+gNYZhPuDFC7Uhv3E1I
         MeK7O0nvQ3SWPPU3vogQcAFQ+tmV4Sz0xB47epeyezwlwswbf+K8eFvgbFY8r1sDg+qI
         HUo5nAWz80VhXOrtBO2IHLM6lhfx6Ce5RGGtmHM5h53ME7bNerThhKDC0K6rBZSqFnaj
         Pcm83/dqiwuguNIDtRnIlK0WKsMwXuhe47w+IhXV7v8pe2MCoVijgbVEbv37a+F2oE1y
         SHe1a0hMW4U6dn5UTkolL47fUPf5gveLgs+k/hbjnFIEs9c8TzbAnwZNUtu3eiiKVSpP
         O7gA==
X-Gm-Message-State: AOJu0YyR8F87w2P0xFpV5PDRW8gYxCULGF25WZ/UEMRbQbI3CfFzobFB
        lmdzOw4dNQs8EDCadV9ew2BKKQ==
X-Google-Smtp-Source: AGHT+IEFHXXYgoqipM/5rt4EspAmID/okCklXrRpwYK6KijcoyztanaEmv4kfCE6cVXTxExfOcXj/w==
X-Received: by 2002:a17:906:498:b0:a1f:6c1c:2016 with SMTP id f24-20020a170906049800b00a1f6c1c2016mr5117549eja.89.1702559423091;
        Thu, 14 Dec 2023 05:10:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b00a22faee6649sm2547776ejc.117.2023.12.14.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:10:22 -0800 (PST)
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
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: x1e80100: add Soundwire controllers
Date:   Thu, 14 Dec 2023 14:10:14 +0100
Message-Id: <20231214131016.30502-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
References: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
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

Add nodes for LPASS Soundwire v2.0.0 controllers.  Difference against
SM8550:
1. Update port configs to match reference implementation,
2. LPASS TLMM GPIO14 is not used as WCD_SR_TX_DATA2 pin but as GPIO
   (camera).

Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 226 +++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 8bc6e544bbc9..262ff4700194 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2999,6 +2999,36 @@ lpass_wsa2macro: codec@6aa0000 {
 			sound-name-prefix = "WSA2";
 		};
 
+		swr3: soundwire@6ab0000 {
+			compatible = "qcom,soundwire-v2.0.0";
+			reg = <0 0x06ab0000 0 0x10000>;
+			clocks = <&lpass_wsa2macro>;
+			clock-names = "iface";
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			label = "WSA2";
+
+			pinctrl-0 = <&wsa2_swr_active>;
+			pinctrl-names = "default";
+
+			qcom,din-ports = <4>;
+			qcom,dout-ports = <9>;
+
+			qcom,ports-sinterval =		/bits/ 16 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0xc8 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
+			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x18>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0x00 0x01 0x01 0x00 0x01 0x01 0x00 0x00 0x00 0x01 0x01 0x00 0x00>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
 		lpass_rxmacro: codec@6ac0000 {
 			compatible = "qcom,x1e80100-lpass-rx-macro", "qcom,sm8550-lpass-rx-macro";
 			reg = <0 0x06ac0000 0 0x1000>;
@@ -3016,6 +3046,36 @@ lpass_rxmacro: codec@6ac0000 {
 			#sound-dai-cells = <1>;
 		};
 
+		swr1: soundwire@6ad0000 {
+			compatible = "qcom,soundwire-v2.0.0";
+			reg = <0 0x06ad0000 0 0x10000>;
+			clocks = <&lpass_rxmacro>;
+			clock-names = "iface";
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			label = "RX";
+
+			pinctrl-0 = <&rx_swr_active>;
+			pinctrl-names = "default";
+
+			qcom,din-ports = <1>;
+			qcom,dout-ports = <11>;
+
+			qcom,ports-sinterval =		/bits/ 16 <0x03 0x1f 0x1f 0x07 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0x0f 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
 		lpass_txmacro: codec@6ae0000 {
 			compatible = "qcom,x1e80100-lpass-tx-macro", "qcom,sm8550-lpass-tx-macro";
 			reg = <0 0x06ae0000 0 0x1000>;
@@ -3051,6 +3111,68 @@ lpass_wsamacro: codec@6b00000 {
 			sound-name-prefix = "WSA";
 		};
 
+		swr0: soundwire@6b10000 {
+			compatible = "qcom,soundwire-v2.0.0";
+			reg = <0 0x06b10000 0 0x10000>;
+			clocks = <&lpass_wsamacro>;
+			clock-names = "iface";
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			label = "WSA";
+
+			pinctrl-0 = <&wsa_swr_active>;
+			pinctrl-names = "default";
+
+			qcom,din-ports = <4>;
+			qcom,dout-ports = <9>;
+
+			qcom,ports-sinterval =		/bits/ 16 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0xc8 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
+			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x18>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0x00 0x01 0x01 0x00 0x01 0x01 0x00 0x00 0x00 0x01 0x01 0x00 0x00>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
+		swr2: soundwire@6d30000 {
+			compatible = "qcom,soundwire-v2.0.0";
+			reg = <0 0x06d30000 0 0x10000>;
+			clocks = <&lpass_txmacro>;
+			clock-names = "iface";
+			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "core", "wakeup";
+			label = "TX";
+
+			pinctrl-0 = <&tx_swr_active>;
+			pinctrl-names = "default";
+
+			qcom,din-ports = <4>;
+			qcom,dout-ports = <1>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x00 0x01 0x03 0x03 0x00>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x01 0x02 0x00 0x00>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0xff 0x00 0x00 0x01 0xff>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
 		lpass_vamacro: codec@6d44000 {
 			compatible = "qcom,x1e80100-lpass-va-macro", "qcom,sm8550-lpass-va-macro";
 			reg = <0 0x06d44000 0 0x1000>;
@@ -3078,6 +3200,110 @@ lpass_tlmm: pinctrl@6e80000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 23>;
+
+			tx_swr_active: tx-swr-active-state {
+				clk-pins {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio1", "gpio2";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			rx_swr_active: rx-swr-active-state {
+				clk-pins {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			dmic01_default: dmic01-default-state {
+				clk-pins {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			dmic02_default: dmic02-default-state {
+				clk-pins {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			wsa_swr_active: wsa-swr-active-state {
+				clk-pins {
+					pins = "gpio10";
+					function = "wsa_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio11";
+					function = "wsa_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			wsa2_swr_active: wsa2-swr-active-state {
+				clk-pins {
+					pins = "gpio15";
+					function = "wsa2_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio16";
+					function = "wsa2_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
 		};
 
 		lpass_ag_noc: interconnect@7e40000 {
-- 
2.34.1

