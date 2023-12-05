Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4D8052F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbjLELdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbjLELdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:33:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9749E0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:23:55 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3333224c7b9so3418061f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701775404; x=1702380204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws3CIsjXWSfN6YwtDvaoTEO5x+PGXRNs+10Uc6B7SBs=;
        b=F/jjh+2SbO/nDuRw1+DNL3qRyJRMZ3O5jVHjnl5qxYS5mmWW1cSBYQSuFSQpTE/JSG
         5se6XGHYQKxxlv6LLCNYGie/UcbaY5LerxWvqP+2sI4Wp0dd0aw7q2F07Wo25L6O4VfJ
         o5+BlHSW01mV5a21rLj2ksIY5so3Uuy6wVPYDleL9IjJqqnXrqhmZKksz3W5S84MxVsv
         4+WrHEDTgiK2E0Jmz69woawQO4t16gW9M1fknalqFcXIOnHapKNsycda5MY659lBYCEb
         +kdWQg0giqnFidPdHtZHPxA3cYHnAvRQl4wSa0D1xJb/Q1HADjg4RN48TfGnGJRe22s0
         siOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775404; x=1702380204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws3CIsjXWSfN6YwtDvaoTEO5x+PGXRNs+10Uc6B7SBs=;
        b=YW5yO6Wcwu1/OgNq220VYq/ga67GyeBHmMs9kjQ5mRCAZo2n5ynJ5uglEAiSVMgl4Q
         nvReATWCAbvaYdjYWQaOkQFAC1XWwNMyTNV6MOpO9mFnoiJZLL5gxVTGNeb2HpET2iyH
         bGev2ViZ6jH8uP6HpnNjCB5IS5mZOI+XsDQ2Rk9y7SDARva00Jl2EGp96zkZepSco08b
         E08G/R7T2KHpkwXs457SgthCQFFlvweYAk0AT5uai8p0kCR4litQh1YLt5U952Pbu+hy
         MhSEarSt/kuVrRLRV91DCHDyZpA4fgfUMfTmAG4R4dT/XJN0vozRrCUhBp/0CcwDWHw8
         xTyA==
X-Gm-Message-State: AOJu0YyaQbU1NAMhzEMjTex64Uw+wajjVBFbvihx/MJroKjaGzdNchUb
        xinpmZ3ugUVrNnY+QdfGjOhtCg==
X-Google-Smtp-Source: AGHT+IGZrmoqP+nMIa/3cBLgBOq9hwyxZg/PZmzJay6finlPfcxRqwVG7R5axg0/t55/zRkDaEQxBw==
X-Received: by 2002:a5d:66c1:0:b0:333:a27:2326 with SMTP id k1-20020a5d66c1000000b003330a272326mr3908774wrw.25.1701775404274;
        Tue, 05 Dec 2023 03:23:24 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2dd9:dce:96c5:9e9a])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b003333ed23356sm8127775wrr.4.2023.12.05.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:23:23 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node
Date:   Tue,  5 Dec 2023 12:23:11 +0100
Message-Id: <20231205112311.16391-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205112311.16391-1-brgl@bgdev.pl>
References: <20231205112311.16391-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the Bluetooth node for RB5.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index ead0c45ba60c..fbdf8fdb532c 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1308,6 +1308,26 @@ sdc2_card_det_n: sd-card-det-n-state {
 	};
 };
 
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>;
+
+		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddrfa1-supply = <&vreg_s2f_0p95>;
+		vddrfa2-supply = <&vreg_s8c_1p3>;
+		vddrfa3-supply = <&vreg_s5a_1p9>;
+	};
+};
+
 &uart12 {
 	status = "okay";
 };
-- 
2.40.1

