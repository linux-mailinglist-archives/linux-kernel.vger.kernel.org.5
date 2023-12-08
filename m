Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA4809CB6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjLHG7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjLHG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB01999
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0538d9bbcso16073505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018776; x=1702623576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/bMqCyLLdfMkDU85bt2E75wE3lerFemV/MhNkgYmEE=;
        b=thNME0t4ywjX5IyZcUIUWlWrFK44+snjghh1r3LwEEFBw5VAZxwUDPsghxhja6JMPO
         qffRlDremEfzOg3mzkkvoKHj97zYHqwj4TI7gjWTNRy+OdnC1CKi5y/hSMDL8qlNUvL6
         +TH3irKNr3Z3Va7EsnoUoK3a0cSJyDL4W/X94IhR29RI0VtjGhXEpbTM0iA19LuM/MrQ
         TCj5IIGr+7A/Af3YnFbypgPAzIuQhltirheSYbKKVcUD9KZLT1w6aY5jxSPZlvA4NkWL
         kuAeuk4+UIUuyZuN0BqgwDKVH2JNlARdTPj+mI9FSq393bgTiE8gVS+s3xIPZywkov9W
         tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018776; x=1702623576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/bMqCyLLdfMkDU85bt2E75wE3lerFemV/MhNkgYmEE=;
        b=IDeuwr5kFan1MWq2hZ9gDYJyBCkiNKu9o5+6XMn1qZSJDL0pFvwi721TM5WlCAlfP8
         4bUia/z3fDHU8MXYqJPCjzvido55TkXGykoHB+g5OsWRfSSjIPMH4GzelSpfhO8rNDQR
         9KRVxdOukNb2h7pS+80g/dDFnoYOy7lCbBhYrM7MgsXfXPdNZKRR5PXx4FODJFTcbiHG
         a5xwC5K8W1YUOpCm9aRNbhlqo0ecM74TAes/AeXJI3N7p+zfhA6KoYmc9xmQwgxbJ9yD
         gJ0qIZFGx9Plz/MqjKE4bAd0a3/OCJ/wfAdtTn+6sdhE1EN7YU6k2WA78Rc4tdxClt4H
         2riw==
X-Gm-Message-State: AOJu0Yz0HnSm5yHqvzIacNXMKuyr1LdE6EADI++cw6I036ftkMkW93/7
        SKA100kC8iSe4592ZQCGxZak
X-Google-Smtp-Source: AGHT+IHdRf8hSF3MUhiCDn1Qa06CDosVbrjd15lsXlxGB6/Ryg4WbtmLcO7jnw0BZs30130/5cIHYQ==
X-Received: by 2002:a17:903:22cf:b0:1d0:ab0e:9154 with SMTP id y15-20020a17090322cf00b001d0ab0e9154mr4514103plg.125.1702018775695;
        Thu, 07 Dec 2023 22:59:35 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 04/17] scsi: ufs: qcom: Remove superfluous variable assignments
Date:   Fri,  8 Dec 2023 12:28:49 +0530
Message-Id: <20231208065902.11006-5-manivannan.sadhasivam@linaro.org>
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

There are many instances where the variable assignments are not needed.
Remove them.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 778df0a9c65e..dc93b1c5ca74 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -219,7 +219,7 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
 
 static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 {
-	int err = 0;
+	int err;
 	struct device *dev = host->hba->dev;
 
 	if (has_acpi_companion(dev))
@@ -237,7 +237,7 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
 static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
 {
 	int err;
-	u32 tx_fsm_val = 0;
+	u32 tx_fsm_val;
 	unsigned long timeout = jiffies + msecs_to_jiffies(HBRN8_POLL_TOUT_MS);
 
 	do {
@@ -292,9 +292,9 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
  */
 static int ufs_qcom_host_reset(struct ufs_hba *hba)
 {
-	int ret = 0;
+	int ret;
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	bool reenable_intr = false;
+	bool reenable_intr;
 
 	if (!host->core_reset) {
 		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
@@ -417,7 +417,7 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 				      enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	int err = 0;
+	int err;
 
 	switch (status) {
 	case PRE_CHANGE:
@@ -463,7 +463,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 	u32 core_clk_period_in_ns;
 	u32 tx_clk_cycles_per_us = 0;
 	unsigned long core_clk_rate = 0;
-	u32 core_clk_cycles_per_us = 0;
+	u32 core_clk_cycles_per_us;
 
 	static u32 pwm_fr_table[][2] = {
 		{UFS_PWM_G1, 0x1},
@@ -1418,7 +1418,7 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 		bool scale_up, enum ufs_notify_change_status status)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	int err = 0;
+	int err;
 
 	/* check the host controller state before sending hibern8 cmd */
 	if (!ufshcd_is_hba_active(hba))
@@ -1689,7 +1689,7 @@ static int ufs_qcom_mcq_config_resource(struct ufs_hba *hba)
 	struct platform_device *pdev = to_platform_device(hba->dev);
 	struct ufshcd_res_info *res;
 	struct resource *res_mem, *res_mcq;
-	int i, ret = 0;
+	int i, ret;
 
 	memcpy(hba->res, ufs_res_info, sizeof(ufs_res_info));
 
-- 
2.25.1

