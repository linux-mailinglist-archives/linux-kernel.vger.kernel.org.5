Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50364759E90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGST2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGST2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:28:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953111FD6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:28:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99313a34b2dso9953066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689794895; x=1692386895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXORDHgGhZ0UNUEfOGNvNVT4D4Hu/uTaxuOqQHkAbdc=;
        b=mtBQ06YHDjGD1HTOpO6/bWft1bPcY5CjVFMBEn0GXmOxdMlSMgt0pCHQEBkqKwBIa9
         giDYD8tEbuR21B8jMesh+mEOXXKEsXy+o9tWMsXPDnSCqlbcma5+EeKJqw7FWFzmLOjL
         2xykcP1olnehWFO7aJ93vJk3s4KwoZGz/EvpogRxMxVPBQq1weXLr+G/aJXAxczIBKC0
         gFUIxTmzkkSvwoV+RzYkM+yA9UODtgT/k2gC5Z80mklzds7rRdC/lgo34g9bFmsIt1Km
         VAkQ199XT20mfDJjwvuOGME+gqSl6M/5vVoUnGajs5r8WhT7fr1Gqt/lxK/qEZkKboqY
         DKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689794895; x=1692386895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXORDHgGhZ0UNUEfOGNvNVT4D4Hu/uTaxuOqQHkAbdc=;
        b=gcD1/4m+7nwW//7mexgUdbZtpfgAXGwnQpMmp92iPKIKHtGV47ZPEUcv/zVms9zrqf
         ku+QXGf3wvaz5T4mQOmDCihl9zlnhfH7uqmYGIxdwizxSlNE6V1hQn833qYi/UheDyOk
         5bXj/e7LW+ZY4wOTH0bzfRP91E6cWrLXTm76WxwXfN0ZZxpyy4ieTlpsFU3b5xQC0k+K
         yN26g4/cbPRDFG3W33FpYlQ9+AqbqqHXjbUBELziYc9spa/hknQ00zCBhaNKLaZzWmdB
         4eQ7SUX4MoDQaxbbKHsYfEyV62qhSyj0DLuGQ7bH1RAAggL5UmPO8FNjf2x8EqMf2pGp
         PTSQ==
X-Gm-Message-State: ABy/qLZ33tQRqZq0yAiOsRgKYi0+XPhSc3UyUxKWD5q/LsKU9XXjNSMo
        +AjbPWiedfZ3PfjTQvuR+90J3w==
X-Google-Smtp-Source: APBJJlEgGgmpGVrHEX9XLHujnSQpbhecvErcWD7txG7y/st29hNQEf7W5HzDhgqBZGQC7X+XqemC0w==
X-Received: by 2002:a17:906:f9c2:b0:989:34a0:45b0 with SMTP id lj2-20020a170906f9c200b0098934a045b0mr2878863ejb.49.1689794894977;
        Wed, 19 Jul 2023 12:28:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906119a00b00991e2b5a27dsm2720966eja.37.2023.07.19.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:28:14 -0700 (PDT)
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
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8350-hdk: add uSD card
Date:   Wed, 19 Jul 2023 21:28:08 +0200
Message-Id: <20230719192809.434709-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719192809.434709-1-krzysztof.kozlowski@linaro.org>
References: <20230719192809.434709-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uSD card to HDK8350.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Add Rb
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 94e923962700..79d832058cfe 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -468,6 +468,18 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_n>;
+	vmmc-supply = <&vreg_l9c_2p96>;
+	vqmmc-supply = <&vreg_l6c_1p8>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
 &slpi {
 	status = "okay";
 	firmware-name = "qcom/sm8350/slpi.mbn";
@@ -726,6 +738,13 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart2 {
-- 
2.34.1

