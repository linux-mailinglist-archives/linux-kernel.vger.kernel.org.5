Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE108809CAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjLHG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjLHG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7032A1981
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d069b1d127so13389295ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018760; x=1702623560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxwk551dNXF7eGBqSesuNZZ5bUVezIJLfHSd1F1iOFQ=;
        b=WDJ/1kBsMY4hucIVyMGLZqtb5blAeDeb+dRrxlyvUMKhh9FEBEYu4Fa2XHxy3MKQE6
         Z1et48zOaAXOk10VXh6qxGFez9ZBUapHZ93rZLO0QXqD9mZA9C8GVux+FGP6Ge+B7aG0
         5wt4XPwgVQSqxYMwogpJk+644daI3bL/+DYStIgStbDQOMXfwHESX/FLYDNkuoRCrxFV
         uLhiSouAJuR8rGzPt9L5z4bSmOp2IJk7T8ipC03TRLolG4W1TtB7L+m6uIGYLTbfMYdW
         84BrUhlRaWdQDMkgwQKrd8tG3LQTdXiKTbx6DE/Co9M2fHWinLnkJSSxthaBcU5nGVhP
         0aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018760; x=1702623560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxwk551dNXF7eGBqSesuNZZ5bUVezIJLfHSd1F1iOFQ=;
        b=PkE0L6HWUCQuUNeY9COG+UW2uHfIAPS7KSzdMcWl/0nMzz7ihCBTvECh46aybuZJI3
         lQx4WG61qxwBvNM+unl5zwgDQ5nmAxg2Tn/Jw5Spb6mAsXMreAzBPYV2iP7oylAWpq/P
         jwyL+lUIunFzMnZkPdBDsxMnY71J8o8sLSMuu0QLWs4+prbgZYtbW/LPRreSDPNz6lT8
         yjreH6BuSq2oaFVNt/jYf5JTSIofMBFyPXovspxiBInu/QKpUyjkxawCc4YEo8jK6fCj
         LdSR5haWw44lDRBkccy+S+BtTikoQtyDCwx19wLIDxyQv8LO6IdDsKVoAz04737krTm2
         p5UA==
X-Gm-Message-State: AOJu0YzioysoAresIk9mfHeH2xeBdwx/lMBRFeMZccYguZCSQZ4mywuf
        vgRiOjLfrtIYq4EqTC3+Umzs
X-Google-Smtp-Source: AGHT+IEkoR7dWArUlpalfnxds9mQVbxsXb/Ae51VkkL95E/8Ul7u+C4yDK+IX+0+FLByp5ZxPxQ5wA==
X-Received: by 2002:a17:902:e811:b0:1d0:c229:a01b with SMTP id u17-20020a170902e81100b001d0c229a01bmr3939511plg.48.1702018759791;
        Thu, 07 Dec 2023 22:59:19 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:19 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 01/17] scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks
Date:   Fri,  8 Dec 2023 12:28:46 +0530
Message-Id: <20231208065902.11006-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lane clock handling can be simplified by using the clk_bulk APIs. So let's
make use of them. This also get's rid of the clock validation in the driver
as kernel should just rely on the firmware (DT/ACPI) to provide the clocks
required for proper functioning.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 94 ++-----------------------------------
 drivers/ufs/host/ufs-qcom.h |  6 +--
 2 files changed, 7 insertions(+), 93 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 96cb8b5b4e66..cbb6a696cd97 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -194,52 +194,12 @@ static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
 }
 #endif
 
-static int ufs_qcom_host_clk_get(struct device *dev,
-		const char *name, struct clk **clk_out, bool optional)
-{
-	struct clk *clk;
-	int err = 0;
-
-	clk = devm_clk_get(dev, name);
-	if (!IS_ERR(clk)) {
-		*clk_out = clk;
-		return 0;
-	}
-
-	err = PTR_ERR(clk);
-
-	if (optional && err == -ENOENT) {
-		*clk_out = NULL;
-		return 0;
-	}
-
-	if (err != -EPROBE_DEFER)
-		dev_err(dev, "failed to get %s err %d\n", name, err);
-
-	return err;
-}
-
-static int ufs_qcom_host_clk_enable(struct device *dev,
-		const char *name, struct clk *clk)
-{
-	int err = 0;
-
-	err = clk_prepare_enable(clk);
-	if (err)
-		dev_err(dev, "%s: %s enable failed %d\n", __func__, name, err);
-
-	return err;
-}
-
 static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
 {
 	if (!host->is_lane_clks_enabled)
 		return;
 
-	clk_disable_unprepare(host->tx_l1_sync_clk);
-	clk_disable_unprepare(host->tx_l0_sync_clk);
-	clk_disable_unprepare(host->rx_l1_sync_clk);
-	clk_disable_unprepare(host->rx_l0_sync_clk);
+	clk_bulk_disable_unprepare(host->num_clks, host->clks);
 
 	host->is_lane_clks_enabled = false;
 }
@@ -247,43 +207,14 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
 static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 {
 	int err;
-	struct device *dev = host->hba->dev;
-
-	if (host->is_lane_clks_enabled)
-		return 0;
 
-	err = ufs_qcom_host_clk_enable(dev, "rx_lane0_sync_clk",
-		host->rx_l0_sync_clk);
+	err = clk_bulk_prepare_enable(host->num_clks, host->clks);
 	if (err)
 		return err;
 
-	err = ufs_qcom_host_clk_enable(dev, "tx_lane0_sync_clk",
-		host->tx_l0_sync_clk);
-	if (err)
-		goto disable_rx_l0;
-
-	err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
-			host->rx_l1_sync_clk);
-	if (err)
-		goto disable_tx_l0;
-
-	err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
-			host->tx_l1_sync_clk);
-	if (err)
-		goto disable_rx_l1;
-
 	host->is_lane_clks_enabled = true;
 
 	return 0;
-
-disable_rx_l1:
-	clk_disable_unprepare(host->rx_l1_sync_clk);
-disable_tx_l0:
-	clk_disable_unprepare(host->tx_l0_sync_clk);
-disable_rx_l0:
-	clk_disable_unprepare(host->rx_l0_sync_clk);
-
-	return err;
 }
 
 static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
@@ -294,26 +225,11 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 	if (has_acpi_companion(dev))
 		return 0;
 
-	err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
-					&host->rx_l0_sync_clk, false);
-	if (err)
-		return err;
-
-	err = ufs_qcom_host_clk_get(dev, "tx_lane0_sync_clk",
-					&host->tx_l0_sync_clk, false);
-	if (err)
+	err = devm_clk_bulk_get_all(dev, &host->clks);
+	if (err <= 0)
 		return err;
 
-	/* In case of single lane per direction, don't read lane1 clocks */
-	if (host->hba->lanes_per_direction > 1) {
-		err = ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
-			&host->rx_l1_sync_clk, false);
-		if (err)
-			return err;
-
-		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
-			&host->tx_l1_sync_clk, true);
-	}
+	host->num_clks = err;
 
 	return 0;
 }
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 9950a0089475..e2df4c528a2a 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -213,10 +213,8 @@ struct ufs_qcom_host {
 	struct phy *generic_phy;
 	struct ufs_hba *hba;
 	struct ufs_pa_layer_attr dev_req_params;
-	struct clk *rx_l0_sync_clk;
-	struct clk *tx_l0_sync_clk;
-	struct clk *rx_l1_sync_clk;
-	struct clk *tx_l1_sync_clk;
+	struct clk_bulk_data *clks;
+	u32 num_clks;
 	bool is_lane_clks_enabled;
 
 	struct icc_path *icc_ddr;
-- 
2.25.1

