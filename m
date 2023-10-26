Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36147D8061
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjJZKOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjJZKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:13:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B00ADC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:13:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32df66c691dso466588f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698315233; x=1698920033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4XZNPM68jw0wXa2l6ywigfz2ladHhOAMBv/JP8ne0E=;
        b=wGJWXOZbf1ln/fCy64FdunvhjGkXCjwU7HbaQpP5xjn68e3mzvazxj9tZnxd+xczZI
         iHYt95WwnrUF0KI8WOjvWycZb4ZgH5BBfgJcLE7XQjDQ5nA2E+BWj3usZQsi51tzYNTY
         Por69Vcv21fEN+YD8r7gW5UtEzJqIhRbhdrqYN3Ybl3M7e4PmdPS7ofBgsaQcb3Eycgy
         m2VBHfuMgOpP0QoiA/H3F9Xl+baQHDPt+nAd4hGjH40/zzJCig63kkDFK+Dvq7Lx+DZ0
         9EwzrpTyBJXz0bWeUPPa3AKKNoY6dGHjqcmWEK7IXF0obIGxN0fXnvtt7CqkK2z/dSXa
         C48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698315233; x=1698920033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4XZNPM68jw0wXa2l6ywigfz2ladHhOAMBv/JP8ne0E=;
        b=mJNmvbyiJlPDGLtIPqFnjNdcXFO7bAGE2jf4Qtq4iNylv5QJpVD65mj9DeaVSmukY9
         MbG3rGUemB4Sy7AEc2LuvCd1opaYkKU36bquNGfXWQWnibYQLwQIyN+7V7bP1z8v8MtH
         EwkhNOBnhEz6I3DU6lP4xUdYIiuNTME8V2apY+odRYzKSj2q9FWhoaHOusj4w2wbFHmq
         jzPnZS5dia8snMnuS4fUPSDNJx981ytGvNGhwgM+wdh837msiTfis7PrKP/+1VJkjOH5
         GAUnvqe86hFgzOg6UGm+W83rvkwxM2Zth6r69N+B9ovrJuqFkzXPpwn9aBPmat5/OZDk
         vuhQ==
X-Gm-Message-State: AOJu0YzrUo5D9TY8EByTSZROPfS+ErpCXdSUi4NKlKhO0SODs3tWHHxb
        6Th78qku+D2cz9VdlsS0tLdBhQ==
X-Google-Smtp-Source: AGHT+IEGJ2uegAflR38fHVrLoRc/do/mtHA2TH+lTghEbSIE0fgDk62ETt2iT8nupLXY66fALpEzxg==
X-Received: by 2002:adf:e8c9:0:b0:323:16c0:9531 with SMTP id k9-20020adfe8c9000000b0032316c09531mr12760675wrn.13.1698315233140;
        Thu, 26 Oct 2023 03:13:53 -0700 (PDT)
Received: from x13s-linux.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m21-20020a056000181500b003271be8440csm13913103wrh.101.2023.10.26.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:13:52 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: clock: Add SC8280XP CAMCC
Date:   Thu, 26 Oct 2023 11:13:41 +0100
Message-Id: <20231026101343.3300-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231026101343.3300-1-bryan.odonoghue@linaro.org>
References: <aef93a48cf270d5078ccdc39d95113a4.sboyd@kernel.org>
 <20231026101343.3300-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the camera clock controller on
Qualcomm SC8280XP platform.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm8450-camcc.yaml     |   2 +
 .../dt-bindings/clock/qcom,sc8280xp-camcc.h   | 179 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-camcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index 6915498deacf..48986460f994 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -16,6 +16,7 @@ description: |
   See also::
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
+    include/dt-bindings/clock/qcom,sc8280xp-camcc.h
 
 allOf:
   - $ref: qcom,gcc.yaml#
@@ -23,6 +24,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - qcom,sc8280xp-camcc
       - qcom,sm8450-camcc
       - qcom,sm8550-camcc
 
diff --git a/include/dt-bindings/clock/qcom,sc8280xp-camcc.h b/include/dt-bindings/clock/qcom,sc8280xp-camcc.h
new file mode 100644
index 000000000000..ea5ec73c8c6a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sc8280xp-camcc.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#ifndef __DT_BINDINGS_CLK_QCOM_CAMCC_SC8280XP_H__
+#define __DT_BINDINGS_CLK_QCOM_CAMCC_SC8280XP_H__
+
+/* CAMCC clocks */
+#define CAMCC_PLL0					0
+#define CAMCC_PLL0_OUT_EVEN				1
+#define CAMCC_PLL0_OUT_ODD				2
+#define CAMCC_PLL1					3
+#define CAMCC_PLL1_OUT_EVEN				4
+#define CAMCC_PLL2					5
+#define CAMCC_PLL3					6
+#define CAMCC_PLL3_OUT_EVEN				7
+#define CAMCC_PLL4					8
+#define CAMCC_PLL4_OUT_EVEN				9
+#define CAMCC_PLL5					10
+#define CAMCC_PLL5_OUT_EVEN				11
+#define CAMCC_PLL6					12
+#define CAMCC_PLL6_OUT_EVEN				13
+#define CAMCC_PLL7					14
+#define CAMCC_PLL7_OUT_EVEN				15
+#define CAMCC_PLL7_OUT_ODD				16
+#define CAMCC_BPS_AHB_CLK				17
+#define CAMCC_BPS_AREG_CLK				18
+#define CAMCC_BPS_AXI_CLK				19
+#define CAMCC_BPS_CLK					20
+#define CAMCC_BPS_CLK_SRC				21
+#define CAMCC_CAMNOC_AXI_CLK				22
+#define CAMCC_CAMNOC_AXI_CLK_SRC			23
+#define CAMCC_CAMNOC_DCD_XO_CLK				24
+#define CAMCC_CCI_0_CLK					25
+#define CAMCC_CCI_0_CLK_SRC				26
+#define CAMCC_CCI_1_CLK					27
+#define CAMCC_CCI_1_CLK_SRC				28
+#define CAMCC_CCI_2_CLK					29
+#define CAMCC_CCI_2_CLK_SRC				30
+#define CAMCC_CCI_3_CLK					31
+#define CAMCC_CCI_3_CLK_SRC				32
+#define CAMCC_CORE_AHB_CLK				33
+#define CAMCC_CPAS_AHB_CLK				34
+#define CAMCC_CPHY_RX_CLK_SRC				35
+#define CAMCC_CSI0PHYTIMER_CLK				36
+#define CAMCC_CSI0PHYTIMER_CLK_SRC			37
+#define CAMCC_CSI1PHYTIMER_CLK				38
+#define CAMCC_CSI1PHYTIMER_CLK_SRC			39
+#define CAMCC_CSI2PHYTIMER_CLK				40
+#define CAMCC_CSI2PHYTIMER_CLK_SRC			41
+#define CAMCC_CSI3PHYTIMER_CLK				42
+#define CAMCC_CSI3PHYTIMER_CLK_SRC			43
+#define CAMCC_CSIPHY0_CLK				44
+#define CAMCC_CSIPHY1_CLK				45
+#define CAMCC_CSIPHY2_CLK				46
+#define CAMCC_CSIPHY3_CLK				47
+#define CAMCC_FAST_AHB_CLK_SRC				48
+#define CAMCC_GDSC_CLK					49
+#define CAMCC_ICP_AHB_CLK				50
+#define CAMCC_ICP_CLK					51
+#define CAMCC_ICP_CLK_SRC				52
+#define CAMCC_IFE_0_AXI_CLK				53
+#define CAMCC_IFE_0_CLK					54
+#define CAMCC_IFE_0_CLK_SRC				55
+#define CAMCC_IFE_0_CPHY_RX_CLK				56
+#define CAMCC_IFE_0_CSID_CLK				57
+#define CAMCC_IFE_0_CSID_CLK_SRC			58
+#define CAMCC_IFE_0_DSP_CLK				59
+#define CAMCC_IFE_1_AXI_CLK				60
+#define CAMCC_IFE_1_CLK					61
+#define CAMCC_IFE_1_CLK_SRC				62
+#define CAMCC_IFE_1_CPHY_RX_CLK				63
+#define CAMCC_IFE_1_CSID_CLK				64
+#define CAMCC_IFE_1_CSID_CLK_SRC			65
+#define CAMCC_IFE_1_DSP_CLK				66
+#define CAMCC_IFE_2_AXI_CLK				67
+#define CAMCC_IFE_2_CLK					68
+#define CAMCC_IFE_2_CLK_SRC				69
+#define CAMCC_IFE_2_CPHY_RX_CLK				70
+#define CAMCC_IFE_2_CSID_CLK				71
+#define CAMCC_IFE_2_CSID_CLK_SRC			72
+#define CAMCC_IFE_2_DSP_CLK				73
+#define CAMCC_IFE_3_AXI_CLK				74
+#define CAMCC_IFE_3_CLK					75
+#define CAMCC_IFE_3_CLK_SRC				76
+#define CAMCC_IFE_3_CPHY_RX_CLK				77
+#define CAMCC_IFE_3_CSID_CLK				78
+#define CAMCC_IFE_3_CSID_CLK_SRC			79
+#define CAMCC_IFE_3_DSP_CLK				80
+#define CAMCC_IFE_LITE_0_CLK				81
+#define CAMCC_IFE_LITE_0_CLK_SRC			82
+#define CAMCC_IFE_LITE_0_CPHY_RX_CLK			83
+#define CAMCC_IFE_LITE_0_CSID_CLK			84
+#define CAMCC_IFE_LITE_0_CSID_CLK_SRC			85
+#define CAMCC_IFE_LITE_1_CLK				86
+#define CAMCC_IFE_LITE_1_CLK_SRC			87
+#define CAMCC_IFE_LITE_1_CPHY_RX_CLK			88
+#define CAMCC_IFE_LITE_1_CSID_CLK			89
+#define CAMCC_IFE_LITE_1_CSID_CLK_SRC			90
+#define CAMCC_IFE_LITE_2_CLK				91
+#define CAMCC_IFE_LITE_2_CLK_SRC			92
+#define CAMCC_IFE_LITE_2_CPHY_RX_CLK			93
+#define CAMCC_IFE_LITE_2_CSID_CLK			94
+#define CAMCC_IFE_LITE_2_CSID_CLK_SRC			95
+#define CAMCC_IFE_LITE_3_CLK				96
+#define CAMCC_IFE_LITE_3_CLK_SRC			97
+#define CAMCC_IFE_LITE_3_CPHY_RX_CLK			98
+#define CAMCC_IFE_LITE_3_CSID_CLK			99
+#define CAMCC_IFE_LITE_3_CSID_CLK_SRC			100
+#define CAMCC_IPE_0_AHB_CLK				101
+#define CAMCC_IPE_0_AREG_CLK				102
+#define CAMCC_IPE_0_AXI_CLK				103
+#define CAMCC_IPE_0_CLK					104
+#define CAMCC_IPE_0_CLK_SRC				105
+#define CAMCC_IPE_1_AHB_CLK				106
+#define CAMCC_IPE_1_AREG_CLK				107
+#define CAMCC_IPE_1_AXI_CLK				108
+#define CAMCC_IPE_1_CLK					109
+#define CAMCC_JPEG_CLK					110
+#define CAMCC_JPEG_CLK_SRC				111
+#define CAMCC_LRME_CLK					112
+#define CAMCC_LRME_CLK_SRC				113
+#define CAMCC_MCLK0_CLK					114
+#define CAMCC_MCLK0_CLK_SRC				115
+#define CAMCC_MCLK1_CLK					116
+#define CAMCC_MCLK1_CLK_SRC				117
+#define CAMCC_MCLK2_CLK					118
+#define CAMCC_MCLK2_CLK_SRC				119
+#define CAMCC_MCLK3_CLK					120
+#define CAMCC_MCLK3_CLK_SRC				121
+#define CAMCC_MCLK4_CLK					122
+#define CAMCC_MCLK4_CLK_SRC				123
+#define CAMCC_MCLK5_CLK					124
+#define CAMCC_MCLK5_CLK_SRC				125
+#define CAMCC_MCLK6_CLK					126
+#define CAMCC_MCLK6_CLK_SRC				127
+#define CAMCC_MCLK7_CLK					128
+#define CAMCC_MCLK7_CLK_SRC				129
+#define CAMCC_SLEEP_CLK					130
+#define CAMCC_SLEEP_CLK_SRC				131
+#define CAMCC_SLOW_AHB_CLK_SRC				132
+#define CAMCC_XO_CLK_SRC				133
+
+/* CAMCC resets */
+#define CAMCC_BPS_BCR					0
+#define CAMCC_CAMNOC_BCR				1
+#define CAMCC_CCI_BCR					2
+#define CAMCC_CPAS_BCR					3
+#define CAMCC_CSI0PHY_BCR				4
+#define CAMCC_CSI1PHY_BCR				5
+#define CAMCC_CSI2PHY_BCR				6
+#define CAMCC_CSI3PHY_BCR				7
+#define CAMCC_ICP_BCR					8
+#define CAMCC_IFE_0_BCR					9
+#define CAMCC_IFE_1_BCR					10
+#define CAMCC_IFE_2_BCR					11
+#define CAMCC_IFE_3_BCR					12
+#define CAMCC_IFE_LITE_0_BCR				13
+#define CAMCC_IFE_LITE_1_BCR				14
+#define CAMCC_IFE_LITE_2_BCR				15
+#define CAMCC_IFE_LITE_3_BCR				16
+#define CAMCC_IPE_0_BCR					17
+#define CAMCC_IPE_1_BCR					18
+#define CAMCC_JPEG_BCR					19
+#define CAMCC_LRME_BCR					20
+
+/* CAMCC GDSCRs */
+#define BPS_GDSC					0
+#define IFE_0_GDSC					1
+#define IFE_1_GDSC					2
+#define IFE_2_GDSC					3
+#define IFE_3_GDSC					4
+#define IPE_0_GDSC					5
+#define IPE_1_GDSC					6
+#define TITAN_TOP_GDSC					7
+
+#endif /* __DT_BINDINGS_CLK_QCOM_CAMCC_SC8280XP_H__ */
-- 
2.40.1

