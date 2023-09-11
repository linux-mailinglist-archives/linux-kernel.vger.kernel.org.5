Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A2A79BE61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355567AbjIKWA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbjIKTdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:33:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744361B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:32:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so1041083066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694460775; x=1695065575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qv0VFA8AXkB7cRCKN58lE+5+SoQOFu8EkIMD+Q2nh5A=;
        b=gYffvhg+CGbFpoHsmhiatmK3W43qZMkFvnFOuBfkKR2Tqiec0yrvQQjWc6607G0B2Q
         n6tV0pNzQePDEyUvQdO5nCKEqE41PxfqS4hfvJVBa5L6TVgCS8YQfxwXah37Jyx4DDO1
         9xj7bhNJV+H72xafIvLtS5KWI9Yul4ZCo2lNuY42j4VEwee1hgsQfZ0pgh4bFyD+QC+Y
         gjmF0irAWjekSzf9yRhYSNhQMdj0R4w/PHLhFmYAOYFWS5SDw2qMW6UmdvKJcvGGGyqn
         MurW1Feft/HmAq/0n9FyVsZ3IxKPuLgm7yN4tPasaMoBqgOWpat+iCeiS9IKOmWM/q8o
         csaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460775; x=1695065575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qv0VFA8AXkB7cRCKN58lE+5+SoQOFu8EkIMD+Q2nh5A=;
        b=ADEYS0CbRfVYBVb/rJHdDn42yv9x+w1H4FKqAsiBBYUZMmnT/EPC7m2KM9PyugLXnR
         73F/IR1CAcUz9ukr0CS/0iKKFwxBZDY/fx7xSwkwjLARSHLXnLkGOhIviXUlxA+R455t
         0ZraMMrsL3rejG9aJsaQ9GR3Dlmg14ChjiJHQnA3+iaexip8JmBegTvSYQQ6VQoAeOel
         fbND8hhVknvpaZNQ8s7TduSnPJs54UA+OsAShuxIdcujEE3mk2GNz1ID+LRTjFmso/+X
         1HgtLTUVNNokm1NghrNF5x5gAnEMkRZEy36fkcg0l4a+EtbGgwP7xzuAYYcmTqfjZFRz
         tJxw==
X-Gm-Message-State: AOJu0Yzo6LPLGl4WavuxoRm0KQxvFzfjkvn7VziMTC87ikkGQt9xhQv6
        BGN2GsAZyWDpieWODgf4UfM8YQ==
X-Google-Smtp-Source: AGHT+IHp58GrysheyZ4KaZCssvpY0d5GCuHIUswb9q3RrsUP6gg75lzNfzitawynvFr6tipo8V2Kxw==
X-Received: by 2002:a17:907:d17:b0:9a9:e3d2:ae4d with SMTP id gn23-20020a1709070d1700b009a9e3d2ae4dmr854344ejc.25.1694460774861;
        Mon, 11 Sep 2023 12:32:54 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906410400b0099cc402d3ddsm5698607ejk.202.2023.09.11.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:32:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 21:32:48 +0200
Subject: [PATCH v2 1/2] phy: qcom-qmp-combo: Square out 8550
 POWER_STATE_CONFIG1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-topic-8550_usbphy-v2-1-a72f43311d19@linaro.org>
References: <20230829-topic-8550_usbphy-v2-0-a72f43311d19@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v2-0-a72f43311d19@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694460770; l=2669;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JKFDScve4WE4FPTA0n+7atBY834sQWAUXpq8axVVF1o=;
 b=rmZ8TapO3mCnxCvhfMXw7fR47i9OFTqH0Ifon7ChEI1D6VCZ43FRyhfsPWPu+Bb/cwWFXWpKq
 mF1HQnuUQp6Cp33Y0y+iUN3D7zHvYp6gKu/wDUZx7yZ5R8Yc5pYIoIY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two instances of the POWER_STATE_CONFIG1 register: one in
the PCS space and another one in PCS_USB.

The downstream init sequence pokes the latter one while we've been poking
the former one (and misnamed it as the latter one, impostor!). Fix that
up to avoid UB.

Fixes: 49742e9edab3 ("phy: qcom-qmp-combo: Add support for SM8550")
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c      | 2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index cbb28afce135..843099d314bf 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -859,10 +859,10 @@ static const struct qmp_phy_init_tbl sm8550_usb3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG1, 0x4b),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG5, 0x10),
-	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
 };
 
 static const struct qmp_phy_init_tbl sm8550_usb3_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_USB_Q6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
index 9510e63ba9d8..c38530d6776b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v6.h
@@ -12,7 +12,7 @@
 #define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG3		0xcc
 #define QPHY_USB_V6_PCS_LOCK_DETECT_CONFIG6		0xd8
 #define QPHY_USB_V6_PCS_REFGEN_REQ_CONFIG1		0xdc
-#define QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1	0x90
+#define QPHY_USB_V6_PCS_POWER_STATE_CONFIG1		0x90
 #define QPHY_USB_V6_PCS_RX_SIGDET_LVL			0x188
 #define QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_L		0x190
 #define QPHY_USB_V6_PCS_RCVR_DTCT_DLY_P1U2_H		0x194
@@ -23,6 +23,7 @@
 #define QPHY_USB_V6_PCS_EQ_CONFIG1			0x1dc
 #define QPHY_USB_V6_PCS_EQ_CONFIG5			0x1ec
 
+#define QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1	0x00
 #define QPHY_USB_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
 #define QPHY_USB_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
 #define QPHY_USB_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40

-- 
2.42.0

