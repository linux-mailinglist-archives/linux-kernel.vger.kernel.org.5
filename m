Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0724800E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379353AbjLAPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379355AbjLAPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A6D4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:14:32 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso2228476b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443671; x=1702048471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvLkGXNQshvzZU680OmMrA5c7oAf7WIO0uWnCsVQkig=;
        b=M/72Xi7LtlcaLyxOdtc4W175e5smNQovEC4vDu2GqlgfWJWMjdUOx6hntqSCeQpnUq
         Xo65QX9+aNbQuQQCJRcXzv34xSD/vPTGtAPRs+9mKtGARv/XUlqPEC6J1HuepwjYD49k
         sXGv9g1kb/XoYQh1s9yv89vJnCW8XSfWiWtXtjOMWfCyyKnOxASVaVyBu9NCNB80pyk8
         mzcTxH3ic9hGqOehjaww7qhc5kuemW/bph53cg+RmEIos6BtV56jwVKWW+HyJsK5Vw44
         NQS5VgwFRFoqz7w6FrHjF0+XieN3EDCWvn4Y5H1AOWCy5P7KEa5sVpBzY5zXmAdxiHRc
         E/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443671; x=1702048471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvLkGXNQshvzZU680OmMrA5c7oAf7WIO0uWnCsVQkig=;
        b=QHRmmd+Je1YzbHAHhCqIweT5YEe7tQLja85Jsw68rjK8bp07qfqvkCrQQ6Fu2PiDXF
         OEpbdQwpFkMGuSCztNl+pcEKoa3zQYacIiy9el4cHZs5dRum+0b3L71CK4Udq8sphE94
         I/Tnuy5FrMmqb2vt55OJYtxT/dieHns183gOR6kJZ2Gl7ZvJlU4d7fsUoqNQYSzaTGob
         mqEDmE6faKNlyVGLEEP//bYkzMA9My3XBP8GVQzNw7ozDkfIwWuRwWNE2GUOx7ffyWIG
         EmSdRDKshMKOeNuinwnjFlAXZ9f87ADysEp5tS/fTIT0A+a7Ino/ZK2lIw44u3j+s/fA
         Iahg==
X-Gm-Message-State: AOJu0YwDNsj5pMIsvcuBZ9Gu2CT8D4Fkjq9j/N1GNeO/Cr0TBCCrk2Ar
        gy6sfsQlqDZkx3MLc9JzRp+nztfHjHLZNZBlrA==
X-Google-Smtp-Source: AGHT+IHfg55fjDOeogk5wYiCzOSIR5XBMDXPS6dtqYKnYjDL4+dYx/9pbpMpF4BYl4nFFNl2hYsOGA==
X-Received: by 2002:a05:6a20:8e26:b0:18c:abeb:b0db with SMTP id y38-20020a056a208e2600b0018cabebb0dbmr18760847pzj.49.1701443671549;
        Fri, 01 Dec 2023 07:14:31 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/13] scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks
Date:   Fri,  1 Dec 2023 20:44:05 +0530
Message-Id: <20231201151417.65500-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
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

