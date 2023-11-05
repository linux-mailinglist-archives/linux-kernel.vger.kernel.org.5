Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484817E15A3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjKERpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKERpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:45:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFADAF2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:45:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5056059e0so53371811fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699206307; x=1699811107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbWYJQhIsB+Tb1jwxwFcUUflIu3DiRZ3/+WTM6wt7Zk=;
        b=rH3Im3ZrEzqbAHnJ4Lqy3+Jhm5/yFZm7FlU1IEmzrDde0xr/dL0eXXL4tHryVMoHmB
         3W6m9TzU2KQEYyjlSwZ9uOfrPCb7s514aMZAAlrdR/kF5R2sshXIe23gqxOCWQAtlYm9
         H7UWztbzk2mpL7X3P9hJBYmrkdpPAnvbD/YVRvaPtNpnPPYFiZLzWxIBluJmsv0i069E
         a6p1UCoOns0FfdZk9mMhiA8i8J2njLpJCx3GfWIFSlFENbiHNTgdlqzh7TmSpJvjOa+O
         tRFlZi4KeRD1iXH4LUOe2ISZlcS+WKsIqGRT/ML5aY+14ljXXzceCLD+yKXpPME4kndF
         f1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699206307; x=1699811107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbWYJQhIsB+Tb1jwxwFcUUflIu3DiRZ3/+WTM6wt7Zk=;
        b=w25CL3TSfFFpcVP3YuBZ7ZgY2C5bvYKE+25yj6rQxZGcWNKn8hGIBfGzbw8ZG4bbnI
         ow7boVR+YsJyE1nQw3HDV9dmyb5l6N7Ih0hbpUlMSmUb6U+DiN1e7aamWJG3pR3QqtRG
         mt/TfaGQC+b+TdHZfm24y0DL37gaJTUsPpQZ1nsTHO+g4UCkLMlEfm2oA01k2eLp0u1Y
         V8Gf/TWGNazev6JIy7d0MRP+oUdfncsZk5ic9lLNW0RaBACcewR276m91pCpnFufSsBE
         nhJaDC32/tlqd8d9+hnlbdfuA3hYbFa1IWIBWihReUo5BzuU0pQiHT2kAXHav+B8gbP1
         r38w==
X-Gm-Message-State: AOJu0YxSXq0+uR4FdLKhGBahh1t16KMOTIbBoWHNc5RPQloColh7DtAH
        sDeoV57nxAkOiwRXxHZOC5T5QA==
X-Google-Smtp-Source: AGHT+IH+EF2TguNRB1Hizt+ecDjdV+yoSebZRlvXdgm4b9qeqefvADdMOmCXcbijUowlHxW8v3Avjw==
X-Received: by 2002:a2e:be0f:0:b0:2c6:f6cf:aaf6 with SMTP id z15-20020a2ebe0f000000b002c6f6cfaaf6mr8826924ljq.46.1699206306906;
        Sun, 05 Nov 2023 09:45:06 -0800 (PST)
Received: from [127.0.0.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c198a00b004064ac107cfsm9553346wmq.39.2023.11.05.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:45:06 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date:   Sun, 05 Nov 2023 17:45:02 +0000
Subject: [PATCH v3 3/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.1
 two-phase MIPI CSI-2 DPHY init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-b4-camss-sc8280xp-v3-3-4b3c372ff0f4@linaro.org>
References: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
In-Reply-To: <20231105-b4-camss-sc8280xp-v3-0-4b3c372ff0f4@linaro.org>
To:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-26615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a PHY configuration sequence for the sc8280xp which uses a Qualcomm
Gen 2 version 1.1 CSI-2 PHY.

The PHY can be configured as two phase or three phase in C-PHY or D-PHY
mode. This configuration supports two-phase D-PHY mode.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index f50e2235c37fc..2eb3531ffd00b 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -148,6 +148,91 @@ csiphy_reg_t lane_regs_sdm845[5][14] = {
 	},
 };
 
+/* GEN2 1.1 2PH */
+static const struct
+csiphy_reg_t lane_regs_sc8280xp[5][14] = {
+	{
+		{0x0004, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x002C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0034, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x001C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0014, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0028, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x003C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0000, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0008, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x000c, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0010, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0038, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0060, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0064, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0704, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x072C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0734, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x071C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0714, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0728, 0x04, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x073C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0700, 0x80, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0708, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x070C, 0xA5, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0710, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0738, 0x1F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0760, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0764, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0204, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x022C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0234, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x021C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0214, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0228, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x023C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0200, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0208, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x020C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0210, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0238, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0260, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0264, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0404, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x042C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0434, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x041C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0414, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0428, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x043C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0400, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0408, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x040C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0410, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0438, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0460, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0464, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+	{
+		{0x0604, 0x0C, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x062C, 0x01, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0634, 0x0F, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x061C, 0x0A, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0614, 0x60, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0628, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x063C, 0xB8, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0600, 0x90, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0608, 0x0E, 0x00, CSIPHY_SETTLE_CNT_LOWER_BYTE},
+		{0x060C, 0x00, 0x00, CSIPHY_DNP_PARAMS},
+		{0x0610, 0x52, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0638, 0xFE, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0660, 0x00, 0x00, CSIPHY_DEFAULT_PARAMS},
+		{0x0664, 0x7F, 0x00, CSIPHY_DEFAULT_PARAMS},
+	},
+};
+
 /* GEN2 1.2.1 2PH */
 static const struct
 csiphy_reg_t lane_regs_sm8250[5][20] = {

-- 
2.42.0

