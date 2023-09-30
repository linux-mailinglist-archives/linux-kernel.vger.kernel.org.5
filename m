Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE37B40A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjI3Nle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbjI3Nl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:41:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC2193
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:41:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso123637515e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696081282; x=1696686082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDowXY6cxzdYaftN/+GmjnHI0E+uTiEbtngHcqAkijM=;
        b=IEfBc0R7IzgKcN4x6+6ncQVxIDECP4J6XW5qCdMbwtWNLhcxg3GktuejOTpKs2h5pH
         UsqsZL0PMKqAssOBRpFvw4CRhy70NjPwFRyiYxuuUVBqDfwzWsly4DHA7p1WkttB/54C
         RC7MzY/xyAykBbvFbx533EUpAxy2cxnEDBTMRPXyR3o3KepAz5Rqs2XU/mE4P6RDXExk
         kpw0dn2ErXawwnEQtWJ0DahgUTdXdjMiVUWPtrtXG/QTjghl7z/MZrOnwl41QqFqS1mA
         +7PkCdtzhiDDSSWtNklxTOaQlguy5JJNeoOwvmYndSIFucKQ/9ZLhrAnfqQGAYmwcB7c
         9jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696081282; x=1696686082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDowXY6cxzdYaftN/+GmjnHI0E+uTiEbtngHcqAkijM=;
        b=nKg7s17aJWsGGi4kwpqHLhY0iVw2KP//JwDCqn6Sb73VJd83XHPkEnBIN1Tyj58eBv
         hVK40G1eFbNQ+Zz3Ui/mJUWUTaHpqngXd3jeuYt0VaFByMhxhtEKi3MxKUOaWPDuJw/C
         Ddz2L8kCiCjvnamoKBzSqrrQ+iwRef4oezKRqGT+kuZcKiZenyZHZMCAHBPQlFepMsro
         f3+Xn19FVXwjOLY0XAAqPgqMaksUyZxlJDh3fB0aQYnscZljEMY99okpCU/yNt0A8bGx
         D1zOLT88gCUBgB5iuRZzHekVJLVgT4GvKydsadaPJFW4vOhsJuL28oWmxHkpfVhgKRC3
         dWSw==
X-Gm-Message-State: AOJu0YzdK/XM5DsnZRBmVHn0lezRx0dL2bpWH+W+BubzwsiOsrOQ3CkE
        n+j2g/rv+7Ro/3HdWusqglFZSw==
X-Google-Smtp-Source: AGHT+IEpM56M7SwTRssiHk87Hydx/PZo5lsZCUu9DEWj/Gw1btYNbr04D19s9aYMEuX9jRmvcNYthg==
X-Received: by 2002:a1c:7219:0:b0:403:8fb9:8d69 with SMTP id n25-20020a1c7219000000b004038fb98d69mr6423800wmc.25.1696081281966;
        Sat, 30 Sep 2023 06:41:21 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b003fe2b081661sm3408261wmi.30.2023.09.30.06.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 06:41:21 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 3/5] dt-bindings: clock: Add SC8280XP CAMCC
Date:   Sat, 30 Sep 2023 14:41:12 +0100
Message-Id: <20230930134114.1816590-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230930134114.1816590-1-bryan.odonoghue@linaro.org>
References: <20230930134114.1816590-1-bryan.odonoghue@linaro.org>
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

Add device tree bindings for the camera clock controller on
Qualcomm SC8280XP platform.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/clock/qcom,sc8280xp-camcc.yaml   |  57 ++++++
 .../dt-bindings/clock/qcom,sc8280xp-camcc.h   | 179 ++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-camcc.yaml
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc8280xp-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-camcc.yaml
new file mode 100644
index 000000000000..12017d209b8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sc8280xp-camcc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sc8280xp-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on SC8280XP
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and power
+  domains on SC8280XP.
+
+  See also::
+    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
+
+allOf:
+  - $ref: qcom,camcc-common.yaml#
+
+properties:
+  compatible:
+    - const: qcom,sc8280xp-camcc
+
+  clocks:
+    items:
+      - description: Camera AHB clock from GCC
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Sleep clock source
+
+required:
+  - power-domains
+  - required-opps
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@ade0000 {
+      compatible = "qcom,sc8280xp-camcc";
+      reg = <0xade0000 0x20000>;
+      clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sc8280xp-camcc.h b/include/dt-bindings/clock/qcom,sc8280xp-camcc.h
new file mode 100644
index 000000000000..867fbd146ee4
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sc8280xp-camcc.h
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

