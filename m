Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E080395A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbjLDP6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbjLDP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:57:53 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114F10E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:57:58 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a18b478e4e9so586255466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701705477; x=1702310277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXiExZXT3jiK99FXcsrgF/kysbafhPV92GlI6Y+M7JY=;
        b=ovEabB8d9siDjDzfG4CR/FH8RADEtJ33jpHr3ErAJbT9GQGplTyqJi8eCLCID6bRXQ
         HVla9Y/ShJmz3cfoDeG25PJf2MbwVw4vru0W1HKCMNtL3HUNybjCF9hiSi4b6PlluE4I
         Sp5+mZRml7dPrbuBNhhvOoTdnSsevwMu7BdGXcx4WUjY9PPc6+qgeRCnMiAZmHfVmnR3
         F9ydB7bVBslCjE+LETacyiQ2w6nOH+FHZv84yTrS6011v1mqz/XECjhrdzW1UmNlZlQF
         T+t/KlMoiiwk12rogaU8CGSl4nxK046MFOCwLrS0YzjCu8S6dyW85vSMimptEQcfRwBH
         xAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705477; x=1702310277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXiExZXT3jiK99FXcsrgF/kysbafhPV92GlI6Y+M7JY=;
        b=g3DqID9RRRdzXIvtdSLqxj5ziphqFwxcYS5mUdCuMA6payr3YiDjfQOIPg6vEglV50
         BmOJlb0b6Nk0gGdC1DMwW31P5cKwRCcjYTQjApG3cA3A2/r53PrL3aByMf7RjX8/sdjC
         eCZVZT6uh34W4w95uKMwooqoYII9+2BW9rdoURNIi9l/ZG7QenByxUYiQon0tjRRjyii
         gKMk20rqp6f0vi680PSmSYCUH1xCF4eW+AsQCr37D0M9UZo2LxygiC+xdH04l655EsXA
         kEdsFwan7VFLt/VvpnmCFM399s2GTNfGn+eM9/wlSdYCruf+wHMy7AR+93BKuTWzUjna
         jhkA==
X-Gm-Message-State: AOJu0Yw3/GnAcxWSDel+PAie4AwhH4TPDXAQC62OlMtmPS0x4/X/qN2U
        4Yh/zdmhN7WNMWx+URx4LMznxw==
X-Google-Smtp-Source: AGHT+IGR+TMm+f3WtNIG4ICe7cOSnOhA/mQqgpW9et2qTwzWCA9fYe5zaxWjGAg+5XSVopn8d/csig==
X-Received: by 2002:a17:907:2da8:b0:a19:a1ba:da60 with SMTP id gt40-20020a1709072da800b00a19a1bada60mr3664010ejc.135.1701705477580;
        Mon, 04 Dec 2023 07:57:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id q19-20020a1709060e5300b009a19701e7b5sm5429304eji.96.2023.12.04.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:57:57 -0800 (PST)
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
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 5/5] arm64: dts: qcom: sm8650-mtp: add WSA8845 speakers
Date:   Mon,  4 Dec 2023 16:57:46 +0100
Message-Id: <20231204155746.302323-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
References: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
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

Add nodes for WSA8845 speakers on SM8650 MTP board.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. pinctrl-n/names order (Konrad)
---
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 656cdbc6f234..9d916edb1c73 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -434,6 +434,16 @@ &dispcc {
 	status = "okay";
 };
 
+&lpass_tlmm {
+	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
+		pins = "gpio21";
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
@@ -580,6 +590,36 @@ &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Speaker Left */
+	left_spkr: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&lpass_tlmm 21 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l3c_1p2>;
+	};
+
+	/* WSA8845, Speaker Right */
+	right_spkr: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		pinctrl-0 = <&spkr_2_sd_n_active>;
+		pinctrl-names = "default";
+		powerdown-gpios = <&tlmm 77 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l3c_1p2>;
+	};
+};
+
 &tlmm {
 	/* Reserved I/Os for NFC */
 	gpio-reserved-ranges = <32 8>;
@@ -611,6 +651,14 @@ mdp_vsync_suspend: mdp-vsync-suspend-state {
 		drive-strength = <2>;
 		bias-pull-down;
 	};
+
+	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
+		pins = "gpio77";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &uart15 {
-- 
2.34.1

