Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ADD79894B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbjIHOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbjIHOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:54:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D4D1FC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:54:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5654051b27fso1614307a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694184871; x=1694789671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86VDfrxrf9fXsAcuShAF/QBfIIcppRCopsc3REU8feU=;
        b=foYCpmudpOYOEyOlgjd/H4GRfBJvwfcvv/eP/3Do/94gnOGy7hQkR/nqa5IKjULOah
         QWSCNRURaRseVKm2OgfPlMjgGuCw0XQXD0mVgTMdxGw+dYwV5kl4HvtGj37l3NVxK6Zt
         wZmTs8vcyEsd9t4sQFsZ4CGKMnu4upyzdAEepMP6AEEwjk7VHWOCVRchGIrwebDTbUP9
         QhB5VwZF30rERCgUwIf+HMGLtOQcI+6HGTVWz5aKB9bZkxWkO1rR8lFhvoyH+THBMHQt
         siVEORQKc3XCxBb/yrOTCgepICeOsYR/d5yAvzOPR4MwYvujibDHdfm/JUmTuSTH6ciR
         TS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184871; x=1694789671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86VDfrxrf9fXsAcuShAF/QBfIIcppRCopsc3REU8feU=;
        b=bQtNscvPbV+j+Ou0jn90MaMiIeSv33EhKMxUUzBfosafaQ0PPAJ4f0EDyifc1BWS0B
         t/dl+YOKrvaUUkTVzjcCLQelqh9yeQZlcgZg3vC8KS1O6l6kp9WZt2sJOJC3RBGazFJ/
         bJI3l9JmpNZJJE3QK00vaJ/g/1oMFwp1QiNkwhxF7TEG8LaoUeo8fEXXDKqxYw/rj8Hy
         BQNXFF6UZEqoX88VxIpqhbwdxRJPRCgyZJCczIO7JUPMff63FhKJzyVDZqSCnPoTxfZ4
         0dN6PAfgnPJC3tq+BtqXHjb2vlJs2g4ZFGoeTZY6v4r862HssfhonbS317NOB8RWGJGI
         PFsw==
X-Gm-Message-State: AOJu0YyCep0vWKpM+dBUBOKDFqX63VqflqFD/gLNzTjasHYEdQP+twr2
        MQsqFeRa8WyEljFDYUKZriIK
X-Google-Smtp-Source: AGHT+IErgGYrFaXUzuw9fd5J4Q7ecSPBMtyBIW0tnDf6+Q6dpLwMXGDBzf1+DEzVXwJkB0T+g/zxqA==
X-Received: by 2002:a05:6a20:7b03:b0:131:a21:9f96 with SMTP id s3-20020a056a207b0300b001310a219f96mr2266797pzh.6.1694184871044;
        Fri, 08 Sep 2023 07:54:31 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.15])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b0068a30f6cf32sm1463212pfh.143.2023.09.08.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:54:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bvanassche@acm.org, avri.altman@wdc.com, alim.akhtar@samsung.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] scsi: ufs: ufs-qcom: Rename "hs_gear" to "phy_gear"
Date:   Fri,  8 Sep 2023 20:23:29 +0530
Message-Id: <20230908145329.154024-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
References: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "hs_gear" variable is used to cache the gear setting for the PHY that
will be used during ufs_qcom_power_up_sequence(). But it creates ambiguity
with the gear setting used by the ufshcd driver.

So let's rename it to "phy_gear" to make it explicit that this variable
caches the gear setting for the PHY.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 14 +++++++-------
 drivers/ufs/host/ufs-qcom.h |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ebb8054a3b3e..93a72d0a1751 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -460,7 +460,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		return ret;
 	}
 
-	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->hs_gear);
+	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->phy_gear);
 
 	/* power on phy - start serdes and phy's power and clocks */
 	ret = phy_power_on(phy);
@@ -910,12 +910,12 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		}
 
 		/*
-		 * Update hs_gear only when the gears are scaled to a higher value. This is because,
-		 * the PHY gear settings are backwards compatible and we only need to change the PHY
-		 * settings while scaling to higher gears.
+		 * Update phy_gear only when the gears are scaled to a higher value. This is
+		 * because, the PHY gear settings are backwards compatible and we only need to
+		 * change the PHY gear settings while scaling to higher gears.
 		 */
-		if (dev_req_params->gear_tx > host->hs_gear)
-			host->hs_gear = dev_req_params->gear_tx;
+		if (dev_req_params->gear_tx > host->phy_gear)
+			host->phy_gear = dev_req_params->gear_tx;
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
@@ -1282,7 +1282,7 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
 	 * Switching to max gear will be performed during reinit if supported.
 	 */
-	host->hs_gear = UFS_HS_G2;
+	host->phy_gear = UFS_HS_G2;
 
 	return 0;
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index dc27395ecba1..8d8613eff959 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -227,7 +227,7 @@ struct ufs_qcom_host {
 
 	struct gpio_desc *device_reset;
 
-	u32 hs_gear;
+	u32 phy_gear;
 
 	int esi_base;
 	bool esi_enabled;
-- 
2.25.1

