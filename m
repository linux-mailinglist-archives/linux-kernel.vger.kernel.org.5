Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518D7D8158
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjJZKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344687AbjJZKx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:53:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F121AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:53:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso5916895e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698317634; x=1698922434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/dkqG7TFqhS22WCtOJCYFAnzbujpg+JGXvYF9Z8Jtw=;
        b=suyFaL/xKzuUOBIRlxos6yDaCHsSgyEnja4hnRO7Wb0YByWcKsYFqTEIWP1FbpZORr
         nO7I5pI53f2ggjNXiztGWzyZVbsii5/dooQ6VNRWxU9wf5NJ8x9yJYozT+w53f2kpvJk
         ffhwOChxBiuAF10H+DuVbuGxWHC8d2YFLDi1vSZxMC2RzvWrrppi0F25sN/tuXcYJpKQ
         bI1YPMKtSnd1fQqAs2JNEBuDr9EV3xRrk3bDsJj9PW5vewP87iKV72x2OsA7JY6tuFHQ
         v0ybsjCIaWuxeNSnq1OGw3a6g0TnKnOlJyzL9DG2Jh9BeVp+26ZXj537eL/PygbpzF7j
         1aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698317634; x=1698922434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/dkqG7TFqhS22WCtOJCYFAnzbujpg+JGXvYF9Z8Jtw=;
        b=u3fDlvemvVL+a6eaUmVnG+YSGKef2+102L8NuOsNlgSIW9I7V9Wj2d5S9Mrt6JU08N
         dyIXwTe2sPm79vCpnmzGGo/mFrwbCxt630b0Y9KGzMHi1+xgGBWM0rX4aTw7YAHeSDae
         vdlo9Ch7UtC/ChlYYu3YEBQuBNvIWPWgdhJWYMzYGAY5Arqvre+b6im0SLJ1BH3HtweE
         QWDJgbqL3FIYx0fM5Hwq7mYyX1ZwqqW2rx/nnZ/y2NfYqGNO6/N8aW6IQidNgdeBRPM1
         +73LKWRwOEdwkqBy2AjcmgQAEOf56uBupu2RoTJzc5VL+FH6i/YszOCydFPh6zpcmLV3
         gF5A==
X-Gm-Message-State: AOJu0YwMOnciAq0cttxy529x1ZRA90Zcrle4CzdjhxAx8tYBXHMFvRET
        /TKbgA4zNmwtsGMsnjjxF/mIKg==
X-Google-Smtp-Source: AGHT+IGILeSVmfxEYcvyxYx8c/ToHYzzKbHFTRzMfsA0M6T3gDBJJCkVI8EHXkclA6oZ3lYIhHayXA==
X-Received: by 2002:a05:600c:468d:b0:409:ca6:d79d with SMTP id p13-20020a05600c468d00b004090ca6d79dmr6542090wmo.18.1698317633936;
        Thu, 26 Oct 2023 03:53:53 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b00407efbc4361sm2239465wmj.9.2023.10.26.03.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:53:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v4 4/4] arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
Date:   Thu, 26 Oct 2023 11:53:45 +0100
Message-Id: <20231026105345.3376-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
References: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in CAMCC for sc8280xp. The sc8280xp Camera Clock Controller looks
similar to most of the sdmX, smX and now scX controllers.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

