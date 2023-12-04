Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387038033E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbjLDNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjLDNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:07:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FBE18B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:08:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c0a03eb87so12386085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701695278; x=1702300078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwBpTlor8QGPHD6RCGBwXqu4uW7ps+IkBJil9Sq0JkQ=;
        b=IVg5eeVmzutPkuos9vw4nUZlIvJ/Qec5pTXWc9AVy8VqLyu//QXYfe3+j28Rf+GPuM
         glvYcUDb8Smz69QmDf8sLFf/igEKaRBDxLy+Liq0Rf53shhkP2BVHh9k9SCTQhD+3HJU
         aV6M22F1aVLOn1ZyswAh6Kb8A3tX0EXiAUK4cCOPBffsPlHQKCFNwhWuQbMiGjPhPjJ/
         btaHcQFXOMtV3wkA+J9C8/kV5UpkwvK60B2IzmSgCD42tzkNeAfzeS50S3A9t+lHn3JN
         L3XYqabZimOC4VUiB4+epjniXm2WZHJWZoyJJMNDtAjCSxtLk/JtOZy/0mHEozwCRuYX
         KVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701695278; x=1702300078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwBpTlor8QGPHD6RCGBwXqu4uW7ps+IkBJil9Sq0JkQ=;
        b=k4E9GJyDvINUK8faA1TQdGL4J8iECsJJKz4rWW/yMkjwyYD1nfr2rbrNEuRNOpNDtN
         4O6BWeX4QLNJPm5jCr5CD4SwD+b8Y/Hzv3KnbAueals5VqXNWqrQB4p+/zRGcxOdEMrj
         wr14ESbEs7sV/ctV2zfRCBtAmp77znVTgV1D9RJWG1NcFXQJyMlCCyyMs//uYiNMS6/7
         NcQMcbPisd9jrhDUKm1SgGe+xZF/yU5ncdTSJ/pzx+eRSBKGj3Dh6d0iFCnchqqjs0+Y
         3qr2yVVw2nyYzQS7Pg8ALfDZ8mXbH1dkl1MHX1TgkM46qW7vL+kXO45IjNqX7FALZ/q2
         v7nw==
X-Gm-Message-State: AOJu0YxHAPQxx+AO97Fz14dpWw6MEO6qPuGebMFGYMCMsET2Fj1CZf5J
        EoCTFExPpOZ/OW2XZCY/mzaeOw==
X-Google-Smtp-Source: AGHT+IHz6z9FNxdUY89GlaEKZKo9VT8cN4GSZp+9MkJvNXaV2qURb9hzGEg+cOJVQYnkAzpc1YZTTA==
X-Received: by 2002:a05:600c:4713:b0:40b:5f03:b3db with SMTP id v19-20020a05600c471300b0040b5f03b3dbmr1123061wmo.253.1701695278472;
        Mon, 04 Dec 2023 05:07:58 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm18494166wmq.32.2023.12.04.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:07:58 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 15:07:38 +0200
Subject: [PATCH v2 4/7] phy: qcom-qmp: pcs-usb: Add v7 register offsets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-phy-qualcomm-v6-v6-20-v7-new-offsets-v2-4-21956ae0c5c3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=4M+XfVf6Rbtz4QjGiR/Rgm75VNvkMBMlXyXrx+AsN/Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbc8jlAoI7yS4kGdu5+tw6hM+aSjBAPwyaEbTx
 SwXDvPLVRiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW3PIwAKCRAbX0TJAJUV
 VoLCEADHCXTn+LJx/Z0vGhTOpLqN5JAUkTvZLybJOk3hlMamTWm00izxsZhkYrnJoj2q0jx3aAS
 +XEC555bIMY3TZ5XSUPRxHomlLpWZPjGUqDhQ+d7nWXI5S3haKfA3eRQPKnjOvQpwO1TNpX1Orn
 HMP6gQw66LoCVgQqbKHqFIOp7mnCMpPab7jzgvKcNhYKDvMMWQ+VlI5tSALlwh7j1K7gA/9eED9
 sjINJ4MjgpWnAivi8OcgalTLAJRLvyfZ/xjaS3tkevTRb8uIKCeDO0+TqE4cTDnTu3J1CQy3uib
 67Zwr8bV2HeHsZatkNGYRa+fnuWVkiO7mYyO2/1IfPVlJ0VMG3CsiyUGDLUJHua8Pq2H3I6GN8S
 B3hO0/mkaA0crGmi/0DhWUMOj06rPJv0VA+mgi2YpRVOG3OEe7YPVXRiTyfj8aBfy2Uuz+B5dup
 ikBBb8ntBjwcy3N4T9L4hwM8j7Qe3p0Hfy0jaCwZfhYFlT5XPCZc0hj8znCHYBwDdE4+1AcEwnl
 Dg6yG3WLV8aJk8KiUxN/mBtjudEiwiys443mQk3zgCx+29etM/3LzkOv1sK+eya5OtidEhpiCg+
 GvInk2ac/f9XhSI6zpj+uE7zrwnqefqJg8UKWO7Bugso7RBiaLCZrbbKUJXcAGWps1HpVrAHiAr
 PhlcqqREJq6Kyhw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1E80100 platform bumps the HW version of QMP phy to v7 for USB.
Add the new PCS USB specific offsets in a dedicated header file.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
new file mode 100644
index 000000000000..6e785c73f4da
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v7.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V7_H_
+#define QCOM_PHY_QMP_PCS_USB_V7_H_
+
+/* Only for QMP V7 PHY - USB3 have different offsets than V6 */
+#define QPHY_V7_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x18
+#define QPHY_V7_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x3c
+#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x40
+#define QPHY_V7_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x44
+
+#endif

-- 
2.34.1

