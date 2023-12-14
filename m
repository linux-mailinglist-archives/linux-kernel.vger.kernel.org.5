Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06000813102
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573263AbjLNNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573247AbjLNNKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:10:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958A124
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50e18689828so565138e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702559424; x=1703164224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W/QSsdACA/eA5fQPjydp0vgvxLKWZdDjtl/+3q43lk=;
        b=K/uZIrjz//z8rYU1kFxAOEgqp6KSTw6KzTxlefhfBsupalvjMn/CSSv/ftio1MEDB5
         k/DAKiJGjrnZ93A18fIO8YSIKgCOJyzu4vay/YvKh8Zo7u3R05HWr64+CgItMgzBLHgz
         Gs1nCpeX3bIW0w5a2zaUKeYNDy0YcXeAHFkylJfYOZ9zE5PT65M0fn7aP3S2OPhlhu/D
         rs2c6RHgBwPu/J/RQbGKdIlTTaGra9HG1mxfD/w9wCd0yuFQRdwWD9iVWqyfRugNv2UN
         dYAvwZwEiTPkTsxjkz24+PuqZ6Kqk0LF/xSrtJu3PKeLuFag3DqIHVCYAxwQYxUyu/pn
         rLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559424; x=1703164224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W/QSsdACA/eA5fQPjydp0vgvxLKWZdDjtl/+3q43lk=;
        b=mWXzojot2XoA9V7p5hbq5CDWfiGdLFZuY6bpa/zwQ3xmpeh/Gu3E7/zbgavrKV6FCG
         G/dYjhn4PxA5W5H1Bwfg/iIyuy0y1LRLoXgHDJxK5fvtwu5S6ldhoWLsY5FIB45DtQGp
         tFOUqra5GfFM2v3vxX4I/XeO1zXBE9Fu6dvvjmcZcT1QT5RDJXcg7mG6piBVrjGZAdqE
         72urS6oyMzkV8uGDWTbXjHaGolZHChGjnKe8r+w1NuITGStCBwcEzlIe1AstFAHHDfkI
         NllD5GXTqGxj6l+oLPt86KYoMEzpcFTD9KkmxsSwd7TuCfy1EMzZLqYFXAxOF3GF1ZIH
         nVUQ==
X-Gm-Message-State: AOJu0YxlZakc3Jvk9vTX61aY61wH6u4YRbvDM5NNF1hd7jDaB4JwfZNq
        sQ9ua7/uKFsCjpyKH20EZSIudQ==
X-Google-Smtp-Source: AGHT+IGeoMrQeDi5aSzit+fx94Jr34rs1Zn4BPlT0fYh/FcJK+8FnPOOIGilItyEEuqmlx7DJWEfCA==
X-Received: by 2002:a05:6512:3e19:b0:50b:e4ba:b07d with SMTP id i25-20020a0565123e1900b0050be4bab07dmr6523387lfv.75.1702559424352;
        Thu, 14 Dec 2023 05:10:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b00a22faee6649sm2547776ejc.117.2023.12.14.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:10:23 -0800 (PST)
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
Subject: [PATCH 3/4] arm64: dts: qcom: x1e80100-crd: add WCD9385 Audio Codec
Date:   Thu, 14 Dec 2023 14:10:15 +0100
Message-Id: <20231214131016.30502-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
References: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
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

Add Qualcomm Aqstic WCD9385 audio codec on two Soundwire interfaces: RX
and TX.

Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 56 +++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 4f7f83d49847..aa5c4199bd2c 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -18,6 +18,32 @@ aliases {
 		serial0 = &uart21;
 	};
 
+	audio-codec {
+		compatible = "qcom,wcd9385-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+		#sound-dai-cells = <1>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -607,6 +633,28 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&swr1 {
+	status = "okay";
+
+	/* WCD9385 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9385 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
@@ -649,6 +697,14 @@ reset-n-pins {
 			drive-strength = <16>;
 		};
 	};
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio191";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &uart21 {
-- 
2.34.1

