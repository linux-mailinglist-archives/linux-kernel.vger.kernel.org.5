Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DE79BB30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjIKVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244329AbjIKUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:07:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F731A7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:07:20 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so79758161fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694462839; x=1695067639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIPY3ZeD9RZYBeo46KSBRi4oVhTY3fvnq69UA3KgJ1g=;
        b=C8o9LsTRQrCCSfzm/BgvdS94wvxTZ6Y+0+m54ZedHVo5mP672dCJ6/Z9KscpkC8AyH
         4YMmts6zfjjF5T/n93q9nrxvpclcDK/R/bYxOHBeVMM6SWbjVLJQ2anqrNtRE8YT5J1d
         WX2hTthtd4UbhdFGckhEjsOLBDmWFsACGWK41HmW7VwcRhRzciYAGd8bESFgFCU9CWMp
         WctarFl+bWeGppCYX483ecnjaOkWpEi2iVaAAusffZv4SD3/WASLlTJFGabfpB4HaZm3
         5JQNQZ0RVDq1eF4y1mvv967Jrd+xX6ttg9kJdCB558N3BGK3DFIVp5kRkloCSOzB0fsm
         YR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694462839; x=1695067639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIPY3ZeD9RZYBeo46KSBRi4oVhTY3fvnq69UA3KgJ1g=;
        b=an3Y9EMljPxcAubkpyQrfdlf1KKSOThbLsaP92/9b0BaiaMHhCevDCX2uYxL83xK2p
         vDt9T3rX5HfUuHFguFjLPjp8WB0d0E6emn8hlyiyo7NQiXDaoRBa6zTLa8L1PIJLep/6
         i5QJjmoIidj/NS5yEFuItP3tN7c7bKjA1bm71D2p4YjZEFGPUXexVX78OKs/1Kf/foHR
         f5HTOcN76+I3gkoVqOzXXV9oOVWL+T+8oUoP9V+1KPWhCCyYsXIDq9E1LkBZgRjm3UTk
         2+PLvrSi093E98OSGFCJEJybZfrXABadKMrE3htkp+ErBNoaBSpJYhkqsjeiCQhIokfH
         6rSg==
X-Gm-Message-State: AOJu0Yy95Fomlb4/cdKql+purCllBpFloQ2/3tpi63A4lQ/YmjjmY7Yy
        0Pw8ipmfkaIf/Se5AYQFhmJN3A==
X-Google-Smtp-Source: AGHT+IE/1HDfzOTAP8eklU+C4JP9+PukuBtRDRhCVtswxDlcEQKjXGZUD+Jm3ckfgmPb3O6tj3N1rg==
X-Received: by 2002:a2e:86c4:0:b0:2bd:beb:4aca with SMTP id n4-20020a2e86c4000000b002bd0beb4acamr8490191ljj.13.1694462838979;
        Mon, 11 Sep 2023 13:07:18 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id z19-20020a170906715300b00992e14af9b9sm5753258ejj.134.2023.09.11.13.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 13:07:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 22:07:14 +0200
Subject: [PATCH v3 1/2] phy: qcom-qmp-combo: Square out 8550
 POWER_STATE_CONFIG1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-topic-8550_usbphy-v3-1-34ec434194c5@linaro.org>
References: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v3-0-34ec434194c5@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694462835; l=2669;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=P24s4MTH43feXZouHmdX2bCNRD1wRxSGhxRPf9k16jM=;
 b=vMUGLlQHGkFe3DFvN4KoE43ckcfBy/90CByfwT9ra/44i5nIRrzDaj7uPHK5DAfehq7nCPHRW
 o4m2sVpOy/EB97pa6o5MRqcmKaH1gWQiL5iXtqQOBYA0yNQyDQQyedS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
index cbb28afce135..8fd240dd5127 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -859,10 +859,10 @@ static const struct qmp_phy_init_tbl sm8550_usb3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_PCS_TX_RX_CONFIG, 0x0c),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG1, 0x4b),
 	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_EQ_CONFIG5, 0x10),
-	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
 };
 
 static const struct qmp_phy_init_tbl sm8550_usb3_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_USB_V6_PCS_USB3_POWER_STATE_CONFIG1, 0x68),
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

