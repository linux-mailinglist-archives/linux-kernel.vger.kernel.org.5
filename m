Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA32813104
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573267AbjLNNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573249AbjLNNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:10:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D5098
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:27 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso6245687e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702559425; x=1703164225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zv75S7w86iylwPFGSxZB3llZQ1CBvgYvd4ByAnD/noo=;
        b=ooozgHBCLPG7b5uiAjlgreD4y/TbzVDVOKHh6n2gOPqt9yoiLZxSU0GIm80wcrnpfN
         v785ozc2D54bEgNo4Ad3sBsqjQ3EW/GnbVau6U5WwWTXOseky6e+vAqW26HVMxnJDTHi
         RN6HZ534+trJnwlOIq1MKKc3hCpX4zSo6AwPb8d7LFh3RsQYDn37MRONFemyf1ngeFrp
         L7+Z4O4t3MvKjpu+kRLJ3od+1oGOwxapTwIabu61wfhdbC57pOFtjTGP6fFRg8eTSYXr
         fq85FADEuKH5fQbhigx+qUFS7CsgAD1ILNfzv/2sb6tqIuvwP37P/tG8Jhu3ZUxU+0HV
         l+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559425; x=1703164225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv75S7w86iylwPFGSxZB3llZQ1CBvgYvd4ByAnD/noo=;
        b=Ghz/i8LEybHINwpt63lJJMfFDog8eu1L3Hq5CKndU0RBCVqR1w75ZoegIhS7VCM1Uy
         36Il4PXJO7n4hA91jPNCqJJQYlG6KC8003bHJZrakBV9MBlcym/9AP6XuUpiX/pSzc01
         D2HLSYFvi9uzliSuzkGo7BAhjTOO7pOfIF9p+DMjzu1mZJMqNqwoM7PCwUo5erM0yyVs
         2HbdZkUKwxXBqRZ1QIAZTu8zNPqbMlfmkbiB5qC42LpdD8rFUXv6G151pgmT/zHj6PCJ
         NhoJDOIGZNcIsKKh7D+ibzsmVsbTv/VTb7Ckv43FCu36yqEfUUAUPZZKcRjFikKo8xoF
         zv3Q==
X-Gm-Message-State: AOJu0YyAghEl+Kio8/442sSZhWf1pr2isFjeAi9a2thlYgY00vbzR99t
        WdMPOjX69NgFdUXxOZBaYICsZA==
X-Google-Smtp-Source: AGHT+IF0vB1K8s/4fuVHqhai7UgCQdRmqfPqB9YHWPZoeT+Mr22NJijQycQ9o1jR1Qugup8i4kwm9A==
X-Received: by 2002:a19:5211:0:b0:50d:1679:5a50 with SMTP id m17-20020a195211000000b0050d16795a50mr4560724lfb.40.1702559425766;
        Thu, 14 Dec 2023 05:10:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b00a22faee6649sm2547776ejc.117.2023.12.14.05.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:10:25 -0800 (PST)
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
Subject: [PATCH 4/4] arm64: dts: qcom: x1e80100-crd: add WSA8845 speakers
Date:   Thu, 14 Dec 2023 14:10:16 +0100
Message-Id: <20231214131016.30502-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
References: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
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

Add nodes for four WSA8845 speakers.  Unlike previous boards like
SM8550-QRD, this board has four speakers spread over two Soundwire buses
instead of two speakers on one bus.  Each pair of speakers shares the
reset GPIO thus pinctrl property is only in one of them.

Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 76 +++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index aa5c4199bd2c..8b4e5577048a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -543,6 +543,24 @@ touchscreen@10 {
 	};
 };
 
+&lpass_tlmm {
+	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -633,6 +651,35 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Left Woofer */
+	left_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		pinctrl-0 = <&spkr_01_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+	};
+
+	/* WSA8845, Left Tweeter */
+	left_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		/* pinctrl in left_woofer node because of sharing the GPIO*/
+		powerdown-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TwitterLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+	};
+};
+
 &swr1 {
 	status = "okay";
 
@@ -655,6 +702,35 @@ wcd_tx: codec@0,3 {
 	};
 };
 
+&swr3 {
+	status = "okay";
+
+	/* WSA8845, Right Woofer */
+	right_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		pinctrl-0 = <&spkr_23_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+	};
+
+	/* WSA8845, Right Tweeter */
+	right_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		/* pinctrl in right_woofer node because of sharing the GPIO*/
+		powerdown-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TwitterRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
-- 
2.34.1

