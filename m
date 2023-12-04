Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3896803951
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbjLDP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjLDP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:57:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82388C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:57:53 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50abbb23122so6140183e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701705472; x=1702310272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQOtEmHXb0hG9Hj++5MR1VfQrm4gcBlK+VGaFI1BUhk=;
        b=X22j2NGbBi742hi7tOQYqnMAlAQO4D9dt2jStfN4Ej3TuVd5caf5pT3O4BFGT3oLpM
         8lXnFqZapC254mPiUXe90/ilAjMTV4oWR565Oiuhsv5VRKtVsLEk4ObArIPt4jERyUAn
         eHo3kMtT5qo69WXw7j5qyjRKnUbkZkJbTAvYmwer6lZUCy0+AbWbxiNr1Da53wOPFTAf
         Zk+EVsNXxGqa7YZBO6lpzUJI+0i+JdipLNgFyfumE606U8gtrquN4uxulxBIwXyXVu9Z
         SC/DV2vayDERRefAnj/Ys8TNSMkq1JqjK18UFxzG8nSNKtyagEVXyg/vXA3W9Oy0y3XX
         L5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705472; x=1702310272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQOtEmHXb0hG9Hj++5MR1VfQrm4gcBlK+VGaFI1BUhk=;
        b=oySuAkLmqGY+B85rslIBJjRSh2ONIKMERJhs7wZnqOyDc+3LBIATDuxC5KR5xCJ+T1
         dKhatuQlfdd095BEVvpyiEcFFQ4a1W3jlnKM8JD5JF0xsoEcxACK/1jfuFkKFVlnKUbj
         OQe20t6xEg52Z1bH0BrwavBZWQtAtazGopNKvGOI4p0XZmhzz6jFX7AVCzp1tg+caG+4
         Y/HNV58of9gaPb+30CCBFpxXk0CzSOcwEH9hAeP4RuTiGMe8W+1V3ugnne8/bRzYBWK8
         fzP6sYDCsRk43B9DzUFDYpZcVZ2MjoiTvd9c4u7pQmqp80dep3VeXxfQiwphMI4jNEso
         sG8A==
X-Gm-Message-State: AOJu0YxFX4VtGPCnYzyAs6T5njEc+We/vznnOmYj7lmwXSjqCdVJv2ds
        +ALIevFW7/3SorWW4Fyt3wnoMQ==
X-Google-Smtp-Source: AGHT+IEx8U2H9+BCLXOYX4SoZsOC5OCmB9AgD7KUq+ArgqA7l+8D+5dasOTJ+EagrW1svXn+te9TxA==
X-Received: by 2002:ac2:455c:0:b0:50b:fdfe:11d with SMTP id j28-20020ac2455c000000b0050bfdfe011dmr420453lfm.1.1701705470830;
        Mon, 04 Dec 2023 07:57:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id q19-20020a1709060e5300b009a19701e7b5sm5429304eji.96.2023.12.04.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:57:50 -0800 (PST)
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
Subject: [PATCH v2 2/5] arm64: dts: qcom: sm8650: add LPASS LPI pin controller
Date:   Mon,  4 Dec 2023 16:57:43 +0100
Message-Id: <20231204155746.302323-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
References: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
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

Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
controller device node as part of audio subsystem in Qualcomm SM8650
SoC.

Cc: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 8d327f83edc8..bef4582f2a26 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -21,6 +21,7 @@
 #include <dt-bindings/reset/qcom,sm8650-gpucc.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -2610,6 +2611,19 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
+		lpass_tlmm: pinctrl@6e80000 {
+			compatible = "qcom,sm8650-lpass-lpi-pinctrl";
+			reg = <0 0x06e80000 0 0x20000>;
+
+			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 23>;
+		};
+
 		lpass_lpiaon_noc: interconnect@7400000 {
 			compatible = "qcom,sm8650-lpass-lpiaon-noc";
 			reg = <0 0x07400000 0 0x19080>;
-- 
2.34.1

