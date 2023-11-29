Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7C7FD7F0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjK2NXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjK2NWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:22:52 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7CD19BE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso1677534a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701264175; x=1701868975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlzLVTMs92fwwEwaB8T7DJx+dwVSGFo+h22EKZkAkLQ=;
        b=CinnIAUVBQ+UDUoGmPVrk7UjsVmNH4gNa5Y+8nq5WB/74dqqDeDfAy1mfYTdtuLHW0
         u4bZotmLlknbf+PyDrkRus4rpaB5OiNGuXxoWy5qE9vy0a2Nj0D60tErPgGdGIuxhY3A
         Yr/TRuHAGId/SHkI/KRWV3dtYXWU7usOnwgPoQFPWpgjOIcXGDY/9jykTBs+MLS/YYzY
         JfUata8pAgnJ9/mxmGnJ5flSPQD/dK2dv7+PuIJIOTb95rdBc/SJV06cRxx0VckzT0du
         nfxZuUysEacNAJ9op1nIMt9FPlpGNlBEtrGc+z4ZEwIyK8sCqvpdYkUdEeevSnIBMv0x
         vivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264175; x=1701868975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlzLVTMs92fwwEwaB8T7DJx+dwVSGFo+h22EKZkAkLQ=;
        b=Qjmjn7NLhAXog06VaRk4lgbanaaCbmuL8a8Crs/9kClVHtS+2PG63iUWuTbNCC7/gi
         GotqF4YqCmtbCnXbf/ctE0DBtBheEwttm8WPkMRUzl29JP7Yz04Ynwr4CLDVSSwXI5R+
         7yPzkROrCiKNUC7eod64YCkLkb4IEFPH5LNjhvFk1psHIBOygQ3tPZOvOLwfGAqZTub3
         LuHrnrZXrMlz7toEuQpgkvGrpasMAlyOpDEBD0in6RZwiGC73Bhtiko1bu20wnz1XE66
         HodjYa95ap5Xx9lCCDPPLsGmBY+s0RvoTI24hb+fxC3IkMaMm5kNxGcdHVQkp2NyODJc
         17Mg==
X-Gm-Message-State: AOJu0Yy2xQgSiMZ0YJJf1PFbmQ1FqRNUvbT1oHD5bLUMXZ6cIlP9q9Tq
        OU+jl6Qe8vQsBiqzi/2p8muNrA==
X-Google-Smtp-Source: AGHT+IGRHjDlG833IMCkZNY8/R8yds6YdmKWjfneh699twb912CYx4++MyR+8Sy4h2rKSfvTh8Z5tQ==
X-Received: by 2002:a17:906:2212:b0:9fd:fdae:a9d0 with SMTP id s18-20020a170906221200b009fdfdaea9d0mr20603479ejs.5.1701264174985;
        Wed, 29 Nov 2023 05:22:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm7844842ejc.22.2023.11.29.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:22:54 -0800 (PST)
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
Subject: [PATCH 2/5] arm64: dts: qcom: sm8650: add LPASS LPI pin controller
Date:   Wed, 29 Nov 2023 14:22:44 +0100
Message-Id: <20231129132247.63721-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129132247.63721-1-krzysztof.kozlowski@linaro.org>
References: <20231129132247.63721-1-krzysztof.kozlowski@linaro.org>
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
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 9df79297dad7..e926329cf3f9 100644
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

