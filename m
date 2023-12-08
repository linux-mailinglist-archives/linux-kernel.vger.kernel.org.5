Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0761809CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjLHHAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjLHHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:00:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4FD1734
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:00:12 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d03bcf27e9so14973905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018812; x=1702623612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdbM2PfYii852DpHOsW1XBn04AhqRFyeEuBtlshPQPM=;
        b=i0ARUHZIMZo3TUvm3DwNHIDr/NbD045vDQfkr+NwCagtWvBDh+YCk7qXGqv1vasn33
         169Y9Kf9/+7TqODM+Gfc6eCXo1ik3h221iInYdO/xD3BTc/YR4m2VILeMSyvp9tktLuq
         EI6pNvaJ+bKijhMCWbqyZUmGZLSieTm1DIlJfnLsOxxBwaXIARaH1kcfzeAW5PkeQmB4
         ApHH2FICEypauGNsRCEmzu28k6ydo4HLH7lDCBXwGxu+xq3UWk+IzJgVn4dnfPLytKnZ
         y0ILhJtutPFvAgf5SDeGCHzMmYPZsa9mM4nbTjyCDeaS62kFYAWs/knyxaFYiMaE/znw
         NQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018812; x=1702623612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdbM2PfYii852DpHOsW1XBn04AhqRFyeEuBtlshPQPM=;
        b=AWoSsZsBRdo0W6qxbmscDLgJZWqXim6zQC63gIC6Q7m44rORJadpkVl1fYCKb0zxBt
         CLEQVF/GLj7pUVJwY7k9UqZF52kXtcRQN1nc2XCbcjzuM/HYqjiRYaiN6CUMmmPh1fJL
         jlEDvEa6Oay5/cxRCSbbTUebC7dQ/xJvSdIvsynzMKnjnhyZsc3zaymusLSpiduvjRKb
         9ekKRL1Gqt3ymVIIbxiJvTxS+svELZfVLxStD0D8kqBLe1TskxTjCSyyyQnR3R8VpP3A
         WJsefBSN2pdECdU14kMxzZI/PSscxB7V4czb6k2qbPyRVNTiIrVvXxPb+D40zF0v++1Z
         y9lQ==
X-Gm-Message-State: AOJu0Ywm2LfrbJLEfzJ5Cm6oOCdU9h3Ue6HpexXAHe9Oz79WQKHjXwtE
        mvsAbld/BHVmbuGmBOdHCKAv
X-Google-Smtp-Source: AGHT+IGv+GAPa6Ypg344o0UlsXWILp6Hb3RQcQuHpl5BD9CYuBn23Qp5TZa5x8eqFhl33IaLmcYJxg==
X-Received: by 2002:a17:903:2115:b0:1d0:a0dd:7d3b with SMTP id o21-20020a170903211500b001d0a0dd7d3bmr2951714ple.65.1702018811863;
        Thu, 07 Dec 2023 23:00:11 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.23.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:00:11 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 11/17] scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
Date:   Fri,  8 Dec 2023 12:28:56 +0530
Message-Id: <20231208065902.11006-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufs_qcom_hosts array is assigned, but not used anywhere. So let's remove
it.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 5 -----
 drivers/ufs/host/ufs-qcom.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ae9fafa49ded..18ea41f5bae9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -90,8 +90,6 @@ static const struct __ufs_qcom_bw_table {
 	[MODE_MAX][0][0]		    = { 7643136,	307200 },
 };
 
-static struct ufs_qcom_host *ufs_qcom_hosts[MAX_UFS_QCOM_HOSTS];
-
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
 static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up);
 
@@ -1194,9 +1192,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 
 	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
 
-	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
-		ufs_qcom_hosts[hba->dev->id] = host;
-
 	ufs_qcom_get_default_testbus_cfg(host);
 	err = ufs_qcom_testbus_config(host);
 	if (err)
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index e2df4c528a2a..53db424a0bcb 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -10,7 +10,6 @@
 #include <soc/qcom/ice.h>
 #include <ufs/ufshcd.h>
 
-#define MAX_UFS_QCOM_HOSTS	1
 #define MAX_U32                 (~(u32)0)
 #define MPHY_TX_FSM_STATE       0x41
 #define TX_FSM_HIBERN8          0x1
-- 
2.25.1

