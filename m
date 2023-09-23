Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091ED7AC2F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjIWPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIWPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:01:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB831A7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405621baba7so7025055e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695481254; x=1696086054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlHYHeN8rhAE13BXXiCpfp9HWEyKbt9J2UiYw4B7Y+E=;
        b=e5kb/30nW2GaAngzbdDENUVLIGBB28IKCgPGkb+Wo2u0LPD+JbTTM8eXCcykG2thJY
         zMJEVh7+QppYNW8xjwlKBf1GAoNJnuHVw/XkctA/HTtaXXX71103FKEuO4twpGwpBxhx
         L+VnuTDFlT7fy+M4Xc9Oqzc265SFnaKNTOODab/yHgqBQRV3Sj5mv/GjCY4oFA94rpar
         rtOrOWMHlN2+ZoLLEWXWU82qLIf0397YM+4E6a3y5sZ6o1ke/wNdF3wIOGcbLgP8P16s
         MtoKpPevKgHDtoazZ4PQn7cNR7KR8Ca45itMM1E6XNC2i6Duo7hXPwIMs2EcpyN8bSww
         A5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481254; x=1696086054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlHYHeN8rhAE13BXXiCpfp9HWEyKbt9J2UiYw4B7Y+E=;
        b=j8qlk5RV94KS+7znv9bwBTAxY3RqilVTmIumeCvg5OLD1grxltc/1C18Fk9sUXpHA8
         Lw8lX4x4rY/Uf8iITjtjOJUU8hGuomS3nP9nBprM3/UkqMIdq9/RHZOOQU1Bm7CxihkK
         jt2fllw0fihttG1EU1aSu1J3V8GXpdU5qRuriWkgTEkDKJiS3MJXqfq3P8CS6CxcVYYu
         bAtdjaQyFGMCmUeRmUfl0PpikVO/VjbhUGJvDF7kQLczbA8eLaxiXRTAddRHVbGRGEgn
         0zLNTmiFkAMS4R5Gnt7Kv0p57xsJLJhKKcQDnQAEqg9YJkbS2X8JtoVhu1mEfA3TV2Dl
         W3ug==
X-Gm-Message-State: AOJu0Yx0VoqXnw0mEggOWmaqLmFlsX9hba1qrYoWZ51pZR36ay7VjSMb
        439T8i+Flq7QbKvnfJ0BADa4Qg==
X-Google-Smtp-Source: AGHT+IEXQTFDOhwf5HdSXZP8yHNCQvl1V63dLLzx8ObGInj3dZUaefQgREwf1xbepc6zloFUGFX8fg==
X-Received: by 2002:a7b:ce10:0:b0:401:73b2:f043 with SMTP id m16-20020a7bce10000000b0040173b2f043mr1842587wmc.1.1695481253513;
        Sat, 23 Sep 2023 08:00:53 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004053a2138bfsm5787006wms.12.2023.09.23.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 08:00:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 2/4] dt-bindings: clock: qcom,camcc.yaml: Add sc8280xp CAMCC compatible
Date:   Sat, 23 Sep 2023 16:00:43 +0100
Message-Id: <20230923150045.1068556-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
References: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document sc8280xp camcc as a new compat string with the same
requirements as sm8250 and sm8450.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/clock/qcom,camcc.yaml |   2 +
 .../dt-bindings/clock/qcom,camcc-sc8280xp.h   | 179 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sc8280xp.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
index 81807b8e0d24..456d304cbea8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
@@ -30,6 +30,7 @@ properties:
     enum:
       - qcom,sc7180-camcc
       - qcom,sc7280-camcc
+      - qcom,sc8280xp-camcc
       - qcom,sdm845-camcc
       - qcom,sm6350-camcc
       - qcom,sm8250-camcc
@@ -127,6 +128,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,sc8280xp-camcc
             - qcom,sm8250-camcc
             - qcom,sm8450-camcc
     then:
diff --git a/include/dt-bindings/clock/qcom,camcc-sc8280xp.h b/include/dt-bindings/clock/qcom,camcc-sc8280xp.h
new file mode 100644
index 000000000000..867fbd146ee4
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,camcc-sc8280xp.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_SC8280XP_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_SC8280XP_H
+
+/* CAM_CC clocks */
+#define CAM_CC_PLL0					0
+#define CAM_CC_PLL0_OUT_EVEN				1
+#define CAM_CC_PLL0_OUT_ODD				2
+#define CAM_CC_PLL1					3
+#define CAM_CC_PLL1_OUT_EVEN				4
+#define CAM_CC_PLL2					5
+#define CAM_CC_PLL3					6
+#define CAM_CC_PLL3_OUT_EVEN				7
+#define CAM_CC_PLL4					8
+#define CAM_CC_PLL4_OUT_EVEN				9
+#define CAM_CC_PLL5					10
+#define CAM_CC_PLL5_OUT_EVEN				11
+#define CAM_CC_PLL6					12
+#define CAM_CC_PLL6_OUT_EVEN				13
+#define CAM_CC_PLL7					14
+#define CAM_CC_PLL7_OUT_EVEN				15
+#define CAM_CC_PLL7_OUT_ODD				16
+#define CAM_CC_BPS_AHB_CLK				17
+#define CAM_CC_BPS_AREG_CLK				18
+#define CAM_CC_BPS_AXI_CLK				19
+#define CAM_CC_BPS_CLK					20
+#define CAM_CC_BPS_CLK_SRC				21
+#define CAM_CC_CAMNOC_AXI_CLK				22
+#define CAM_CC_CAMNOC_AXI_CLK_SRC			23
+#define CAM_CC_CAMNOC_DCD_XO_CLK			24
+#define CAM_CC_CCI_0_CLK				25
+#define CAM_CC_CCI_0_CLK_SRC				26
+#define CAM_CC_CCI_1_CLK				27
+#define CAM_CC_CCI_1_CLK_SRC				28
+#define CAM_CC_CCI_2_CLK				29
+#define CAM_CC_CCI_2_CLK_SRC				30
+#define CAM_CC_CCI_3_CLK				31
+#define CAM_CC_CCI_3_CLK_SRC				32
+#define CAM_CC_CORE_AHB_CLK				33
+#define CAM_CC_CPAS_AHB_CLK				34
+#define CAM_CC_CPHY_RX_CLK_SRC				35
+#define CAM_CC_CSI0PHYTIMER_CLK				36
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC			37
+#define CAM_CC_CSI1PHYTIMER_CLK				38
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC			39
+#define CAM_CC_CSI2PHYTIMER_CLK				40
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC			41
+#define CAM_CC_CSI3PHYTIMER_CLK				42
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC			43
+#define CAM_CC_CSIPHY0_CLK				44
+#define CAM_CC_CSIPHY1_CLK				45
+#define CAM_CC_CSIPHY2_CLK				46
+#define CAM_CC_CSIPHY3_CLK				47
+#define CAM_CC_FAST_AHB_CLK_SRC				48
+#define CAM_CC_GDSC_CLK					49
+#define CAM_CC_ICP_AHB_CLK				50
+#define CAM_CC_ICP_CLK					51
+#define CAM_CC_ICP_CLK_SRC				52
+#define CAM_CC_IFE_0_AXI_CLK				53
+#define CAM_CC_IFE_0_CLK				54
+#define CAM_CC_IFE_0_CLK_SRC				55
+#define CAM_CC_IFE_0_CPHY_RX_CLK			56
+#define CAM_CC_IFE_0_CSID_CLK				57
+#define CAM_CC_IFE_0_CSID_CLK_SRC			58
+#define CAM_CC_IFE_0_DSP_CLK				59
+#define CAM_CC_IFE_1_AXI_CLK				60
+#define CAM_CC_IFE_1_CLK				61
+#define CAM_CC_IFE_1_CLK_SRC				62
+#define CAM_CC_IFE_1_CPHY_RX_CLK			63
+#define CAM_CC_IFE_1_CSID_CLK				64
+#define CAM_CC_IFE_1_CSID_CLK_SRC			65
+#define CAM_CC_IFE_1_DSP_CLK				66
+#define CAM_CC_IFE_2_AXI_CLK				67
+#define CAM_CC_IFE_2_CLK				68
+#define CAM_CC_IFE_2_CLK_SRC				69
+#define CAM_CC_IFE_2_CPHY_RX_CLK			70
+#define CAM_CC_IFE_2_CSID_CLK				71
+#define CAM_CC_IFE_2_CSID_CLK_SRC			72
+#define CAM_CC_IFE_2_DSP_CLK				73
+#define CAM_CC_IFE_3_AXI_CLK				74
+#define CAM_CC_IFE_3_CLK				75
+#define CAM_CC_IFE_3_CLK_SRC				76
+#define CAM_CC_IFE_3_CPHY_RX_CLK			77
+#define CAM_CC_IFE_3_CSID_CLK				78
+#define CAM_CC_IFE_3_CSID_CLK_SRC			79
+#define CAM_CC_IFE_3_DSP_CLK				80
+#define CAM_CC_IFE_LITE_0_CLK				81
+#define CAM_CC_IFE_LITE_0_CLK_SRC			82
+#define CAM_CC_IFE_LITE_0_CPHY_RX_CLK			83
+#define CAM_CC_IFE_LITE_0_CSID_CLK			84
+#define CAM_CC_IFE_LITE_0_CSID_CLK_SRC			85
+#define CAM_CC_IFE_LITE_1_CLK				86
+#define CAM_CC_IFE_LITE_1_CLK_SRC			87
+#define CAM_CC_IFE_LITE_1_CPHY_RX_CLK			88
+#define CAM_CC_IFE_LITE_1_CSID_CLK			89
+#define CAM_CC_IFE_LITE_1_CSID_CLK_SRC			90
+#define CAM_CC_IFE_LITE_2_CLK				91
+#define CAM_CC_IFE_LITE_2_CLK_SRC			92
+#define CAM_CC_IFE_LITE_2_CPHY_RX_CLK			93
+#define CAM_CC_IFE_LITE_2_CSID_CLK			94
+#define CAM_CC_IFE_LITE_2_CSID_CLK_SRC			95
+#define CAM_CC_IFE_LITE_3_CLK				96
+#define CAM_CC_IFE_LITE_3_CLK_SRC			97
+#define CAM_CC_IFE_LITE_3_CPHY_RX_CLK			98
+#define CAM_CC_IFE_LITE_3_CSID_CLK			99
+#define CAM_CC_IFE_LITE_3_CSID_CLK_SRC			100
+#define CAM_CC_IPE_0_AHB_CLK				101
+#define CAM_CC_IPE_0_AREG_CLK				102
+#define CAM_CC_IPE_0_AXI_CLK				103
+#define CAM_CC_IPE_0_CLK				104
+#define CAM_CC_IPE_0_CLK_SRC				105
+#define CAM_CC_IPE_1_AHB_CLK				106
+#define CAM_CC_IPE_1_AREG_CLK				107
+#define CAM_CC_IPE_1_AXI_CLK				108
+#define CAM_CC_IPE_1_CLK				109
+#define CAM_CC_JPEG_CLK					110
+#define CAM_CC_JPEG_CLK_SRC				111
+#define CAM_CC_LRME_CLK					112
+#define CAM_CC_LRME_CLK_SRC				113
+#define CAM_CC_MCLK0_CLK				114
+#define CAM_CC_MCLK0_CLK_SRC				115
+#define CAM_CC_MCLK1_CLK				116
+#define CAM_CC_MCLK1_CLK_SRC				117
+#define CAM_CC_MCLK2_CLK				118
+#define CAM_CC_MCLK2_CLK_SRC				119
+#define CAM_CC_MCLK3_CLK				120
+#define CAM_CC_MCLK3_CLK_SRC				121
+#define CAM_CC_MCLK4_CLK				122
+#define CAM_CC_MCLK4_CLK_SRC				123
+#define CAM_CC_MCLK5_CLK				124
+#define CAM_CC_MCLK5_CLK_SRC				125
+#define CAM_CC_MCLK6_CLK				126
+#define CAM_CC_MCLK6_CLK_SRC				127
+#define CAM_CC_MCLK7_CLK				128
+#define CAM_CC_MCLK7_CLK_SRC				129
+#define CAM_CC_SLEEP_CLK				130
+#define CAM_CC_SLEEP_CLK_SRC				131
+#define CAM_CC_SLOW_AHB_CLK_SRC				132
+#define CAM_CC_XO_CLK_SRC				133
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR					0
+#define CAM_CC_CAMNOC_BCR				1
+#define CAM_CC_CCI_BCR					2
+#define CAM_CC_CPAS_BCR					3
+#define CAM_CC_CSI0PHY_BCR				4
+#define CAM_CC_CSI1PHY_BCR				5
+#define CAM_CC_CSI2PHY_BCR				6
+#define CAM_CC_CSI3PHY_BCR				7
+#define CAM_CC_ICP_BCR					8
+#define CAM_CC_IFE_0_BCR				9
+#define CAM_CC_IFE_1_BCR				10
+#define CAM_CC_IFE_2_BCR				11
+#define CAM_CC_IFE_3_BCR				12
+#define CAM_CC_IFE_LITE_0_BCR				13
+#define CAM_CC_IFE_LITE_1_BCR				14
+#define CAM_CC_IFE_LITE_2_BCR				15
+#define CAM_CC_IFE_LITE_3_BCR				16
+#define CAM_CC_IPE_0_BCR				17
+#define CAM_CC_IPE_1_BCR				18
+#define CAM_CC_JPEG_BCR					19
+#define CAM_CC_LRME_BCR					20
+
+/* CAM_CC GDSCRs */
+#define BPS_GDSC					0
+#define IFE_0_GDSC					1
+#define IFE_1_GDSC					2
+#define IFE_2_GDSC					3
+#define IFE_3_GDSC					4
+#define IPE_0_GDSC					5
+#define IPE_1_GDSC					6
+#define TITAN_TOP_GDSC					7
+
+#endif
-- 
2.40.1

