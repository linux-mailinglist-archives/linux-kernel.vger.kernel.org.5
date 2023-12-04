Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D1D8033E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjLDNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjLDNHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B6B181
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:07:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso10882335e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695277; x=1702300077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYTIUUHiytME6HHkOk4RzGB1GaR7pCi9XLlIPgVcPvw=;
        b=Uuw8Z9ivGFpihPG2N+6MDbAo/Pdlz/WW++jBbDipRk3VkEnMekln/iKl0whlx1VlEz
         nXNtLLLyUTODI0Q3qL45D5lZFoMvLH1+hJVBHJQJV6wtgXio6UdajOxo7fwsIUFGDGv8
         6//CQesU9HLOq7vqSW/T3ortw3L2VqZvtYslOvd+jMcW3bBe41jwtcdJSA4A+w4NkaYI
         XpVWVFsbmBgfwx+E0OhiSi1YOINL12uYi6D/gvS5wekDzs3Dcf2yI2XGH0XQJa83vvzG
         K8FRHKUzVBvQw8rascCY7gGfyJ+aWzPWxf+jYBp5eG9aTyxE+DW6/8wXq9LKJoQ2CgaG
         gvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695277; x=1702300077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYTIUUHiytME6HHkOk4RzGB1GaR7pCi9XLlIPgVcPvw=;
        b=tFV2CHEieGnhbgoqrryRk/m8DbRL1x12fXYvmNFpFlER9bn5P0KCEu8OLVLTHf0yv+
         o0/CMNR4z6/zOSEBfaqhBVnhp9zfQ9/bJ2EIuUk38cqnKtVUX9HptZi59SuDaM+hFO0g
         Pmcma9L+TysrB6xjbH67g1QmSUno/y6fFSDRupWFbJvz+/p+NwoHxu7DrZgRqCo6GMPn
         L7v+s6Ig1pb3FIkM83MlrlBLS7xMVCSQtR41/UItckyxXJAPXoIMMVa1sXODm1eFXi3y
         rZy/4B4p6IOQiAx4JysIY6ClQbwT4+Ecc7hNLT8XXkOA42H5rgiU4+IphrL+MHUE0E/T
         HqOQ==
X-Gm-Message-State: AOJu0YwTra7oFl9he7FL22/n+yr8+t7uyxjbaDWnMdDtJyKuyfpcqJz4
        LiNeJzVgjPdpYoHKRZ26NdZF1w==
X-Google-Smtp-Source: AGHT+IGHEbLxB7kwJD+HY8ANZui0bV7DQgbo04InN4Q1iJFmQjtR8eL3vuUo0zkI8axsqPuKTpG9MQ==
X-Received: by 2002:a05:600c:4393:b0:40c:909:fdb4 with SMTP id e19-20020a05600c439300b0040c0909fdb4mr1331537wmn.90.1701695277321;
        Mon, 04 Dec 2023 05:07:57 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:07:56 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:37 +0200
Subject: [PATCH v2 3/7] phy: qcom-qmp: pcs: Add v7 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-3-21956ae0c5c3@linaro.org>
References: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-0-21956ae0c5c3@linaro.org>
In-Reply-To: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-0-21956ae0c5c3@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=5K0HigAQKC0oyxjTSpG30ffVBm+lPmYjMEQc16Bq5cE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8i7St5K2ZBrjZ0LoUVpg8T4IHiDP3uLKGA5
 x+p3NKf+DqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PIgAKCRAbX0TJAJUV
 Vs1cEACVP8YI8AAq24ge00exuvKTxrdkNZ3gtRVMdEf/jjjabXSHTV7aRSZOI0Rv/skhKgpEVLN
 kmRIN2Q5LUUWluH30XDUX2v/O87Rz+P/08KKObNFNSk0ny7H/hM5IvDRZjYIRB6uqcp+4i4QDrG
 bM6ZAvpz7x7ZMcVkb/kCx6lBOxqDginw534sMaEZm8veyOoCcWjwhenmNu3EnjTDF7KzUu+U2Fk
 S+yuqtQoxeZCcH8a3+plkrBnFo9O3EjygYlI1EcWqaiHvSygjoqMBTqro8UWGb/33zQVezDt6Fo
 zsVMX/G82tvY0lqQFwfr1drx5icpCN3kb9ghExRFD++Unh8DukSF6E0wyLQ+mBk1hDMFN5pjsb8
 p4kiAIix6TUa4uew923sNOWTxh8Z6lYoVStrKAAVK6KlbC7ksYEoARghL0KJ48L4Fr867hdthF4
 B1ioWr3Wdnuzcll31mRvD3R8bKv0SWcMqmtJ/PHdLLxt3CnTX3cX3A78+ySfmh+s8YkhECMeCVD
 gYpC7fVdaCRpJ25b0yV/Tr8iTkKpLdlNpRxWj/FkEK0DAauRPCrGBG5p8W/7V1j1sKa0tC92/py
 bSl2DZT5daerb4n7P8odWEwrVHEMvHWDLi7nbwu2ROQd2vuMMV8izGphbwbuOJ4VRZGNcl/fAPR
 JKm8wLHHvNfgOlQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1E80100 platform bumps the HW version of QMP phy to v7 for USB,
and PCIe. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h | 28 ++++++++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h        |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
new file mode 100644
index 000000000000..1967cfe595b5
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v7.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V7_H_
+#define QCOM_PHY_QMP_PCS_V7_H_
+
+/* Only for QMP V7 PHY - USB/PCIe PCS registers */
+
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG1			0xc4
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG2			0xc8
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG3			0xcc
+#define QPHY_V7_PCS_LOCK_DETECT_CONFIG6			0xd8
+#define QPHY_V7_PCS_REFGEN_REQ_CONFIG1			0xdc
+#define QPHY_V7_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_L		0x190
+#define QPHY_V7_PCS_RCVR_DTCT_DLY_P1U2_H		0x194
+#define QPHY_V7_PCS_RATE_SLEW_CNTRL1			0x198
+#define QPHY_V7_PCS_CDR_RESET_TIME			0x1b0
+#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG1		0x1c0
+#define QPHY_V7_PCS_ALIGN_DETECT_CONFIG2		0x1c4
+#define QPHY_V7_PCS_PCS_TX_RX_CONFIG			0x1d0
+#define QPHY_V7_PCS_EQ_CONFIG1				0x1dc
+#define QPHY_V7_PCS_EQ_CONFIG2				0x1e0
+#define QPHY_V7_PCS_EQ_CONFIG5				0x1ec
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 71f063f4a56e..21f6a56e7ae3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -44,6 +44,8 @@
 
 #include "phy-qcom-qmp-pcs-v6_20.h"
 
+#include "phy-qcom-qmp-pcs-v7.h"
+
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
 #define QPHY_V3_DP_COM_SW_RESET				0x04

-- 
2.34.1

