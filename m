Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552767C5D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbjJKSz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJKSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:55:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BF9B0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:55:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406609df1a6so2322785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697050545; x=1697655345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82Kqf0UBYM8c+UzHOY9T7/SD0aaAr6GxwSoS4++hAHg=;
        b=hQP+TLVuikwIdHYhkqGAk92054ldijooPV0JtzUH11yod67JrP92oiQm73KaJjUA7k
         Jui/n/dkvUC+DNNmTVABIpOnGOdctiD5PrE228h44WcDQ7fO4tjlbtryF4LOO2DpBigM
         kZ/kQbMXQghYp89pKwBL9TJJE1LCrrD6CjJ8FG+WmofSeTqLrf6O9CF8OdVba/nsCrZJ
         n/APHvt2tW3arPFyR23qLQyOP4Xd31qXPXi6l8FJbe7LLSwl3dxY1mMhZMh6TfwfcWLk
         DaRIeSSV5j0Kj6XOaQ8KAe4w8RuUowwKik2qCM5z6zMp3jezv3g22ejUXzt495rcvLOK
         gCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697050545; x=1697655345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82Kqf0UBYM8c+UzHOY9T7/SD0aaAr6GxwSoS4++hAHg=;
        b=ElYBVA1eNKPBf4m9Jl5F+i6wwH67nPGMeIG6SX8tziQJwDsdxnO2woZD6do977Yudm
         +6fVz25XQocAYgKkewADhuBbFRCtciffB6f9PsRYHyeBjrqv+ic+9dDgulzQGQeLazen
         78179sAHdwaLy8bfPdtC8ACfpkcqsNL1VVYpuLny5VjfVv6idBYAufTnnBXXNB2vM3uY
         PbXr8YpmRgGBCsjqz7Nzs6eVGh2chgqPDMp05uu3/lrZBW/OCzhSZO+NY9/dGf/+xUMM
         aMW/4eH2NE/f0Vxu/FlZZccHtbqZh67o89/HaL2aVe7casVT6q6NV+2K/E6b0VGIq5Qs
         AH4w==
X-Gm-Message-State: AOJu0YzyaledB2FJm0nLMCzx2Xd1qqBrRhWgKgGL+3WAssK7/lohsC7+
        Q+rYuVoShgyEVGlQcn+jsKKw8A==
X-Google-Smtp-Source: AGHT+IG7mwdySNgdPY5aORKiVHGGeWPjL5iVkku1uuWMYD0j1q5Xe4+r5a9UjJqfCoxYF8OZBAb2Zw==
X-Received: by 2002:a7b:cbd5:0:b0:403:9b7:a720 with SMTP id n21-20020a7bcbd5000000b0040309b7a720mr20161241wmi.1.1697050545181;
        Wed, 11 Oct 2023 11:55:45 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b004060f0a0fdbsm19928294wmi.41.2023.10.11.11.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:55:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 1/4] arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
Date:   Wed, 11 Oct 2023 19:55:37 +0100
Message-Id: <20231011185540.2282975-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011185540.2282975-1-bryan.odonoghue@linaro.org>
References: <20231011185540.2282975-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in CAMCC for sc8280xp. The sc8280xp Camera Clock Controller looks
similar to most of the sdmX, smX and now scX controllers.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index cad59af7ccef..fafea0f34fd9 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
 #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
@@ -3450,6 +3451,20 @@ usb_1_role_switch: endpoint {
 			};
 		};
 
+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,sc8280xp-camcc";
+			reg = <0 0x0ad00000 0 0x20000>;
+			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>;
+			power-domains = <&rpmhpd SC8280XP_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mdss0: display-subsystem@ae00000 {
 			compatible = "qcom,sc8280xp-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.40.1

