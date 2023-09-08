Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D59798949
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244166AbjIHOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243458AbjIHOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:54:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C52101
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:54:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68c0cb00fb3so1984778b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694184867; x=1694789667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0/IfcD+bVp+TwfTl9BonGyGe+3MQ6GUS3Cq64UrgTs=;
        b=i/prfLoQBAJv5JeNcRoJ0k7D8scN144PeGCyyS0LqUMlyJwGCJ9Toh40FXN1kjxNpS
         0xFIQ8REKv/o6Qe8uxTEjjBwPTYXxORatEKbKfTpTOINPzclQoMh6E3eHxvsXd/xDWK0
         GGBM0/SyY0sCKHkWQzvk5KGrjEySG+kWQm7QQ8LNU7IeTi1WBcWTeVj1etOWpAOLAb9d
         GoqCbVcINuwhPyBOIXU/Afqw5FLsBySQT+g1QzaEMnAuTHlHsPTjKm3O+kLw409svJDv
         8drIGiIpHrOI53of/ec616ewcAq+GaufzLAfjfN5dR8ACp/3ovufiAfRfXADcFEKFj1O
         PUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184867; x=1694789667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0/IfcD+bVp+TwfTl9BonGyGe+3MQ6GUS3Cq64UrgTs=;
        b=QrreFfFUYKOkBw+r5A1du1enBs5/3og29+pDR2BtLOBbIDT92EUh1Rkyf+Fxd4Khhm
         mp68NkIKCzFrCI7KmJezUVHvWStfeewMDcbOuCnKZDrfHrHZmF4xvsHN74/noqMzoABb
         2QJYCGDerFqURkrrmIGBIXDcatCLYFVQcHBOEKVLBigzd8BCkCXOQOW+M7g0vXUdlxR8
         hLCUvtUX7J0AdYm8D6GBS65DjiDs2evOpQOejyhncnfoJE3htIoWc6ploxXDYwiBUXBS
         LKo3ZiaaMNHGIdTuo2hBu41SyUymHVGzypDfDc1ke4aENHkqd55/26J5s5OoUL5dTsD8
         7FbQ==
X-Gm-Message-State: AOJu0YzT+38/gTjlqPT5p/Ct23y/b9UWlnZjGAz9IhmMlwWmRZGebSwH
        2InMAwy+actDlCeZrSNaAi1X
X-Google-Smtp-Source: AGHT+IHYIFo3OMAOQfRI0s5oC0CJ3wzrb/Rkg+Xten7sB/lRtfVzRDXX2fUj57YnJVr4eUxM1qFMjg==
X-Received: by 2002:a05:6a00:1825:b0:68e:2dad:13a5 with SMTP id y37-20020a056a00182500b0068e2dad13a5mr2811724pfa.10.1694184866738;
        Fri, 08 Sep 2023 07:54:26 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.15])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b0068a30f6cf32sm1463212pfh.143.2023.09.08.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:54:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     bvanassche@acm.org, avri.altman@wdc.com, alim.akhtar@samsung.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] scsi: ufs: ufs-qcom: Update PHY settings only when scaling to higher gears
Date:   Fri,  8 Sep 2023 20:23:28 +0530
Message-Id: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The "hs_gear" variable is used to program the PHY settings (submode) during
ufs_qcom_power_up_sequence(). Currently, it is being updated every time the
agreed gear changes. Due to this, if the gear got downscaled before suspend
(runtime/system), then while resuming, the PHY settings for the lower gear
will be applied first and later when scaling to max gear with REINIT, the
PHY settings for the max gear will be applied.

This adds a latency while resuming and also really not needed as the PHY
gear settings are backwards compatible i.e., we can continue using the PHY
settings for max gear with lower gear speed.

So let's update the "hs_gear" variable _only_ when the agreed gear is
greater than the current one. This guarantees that the PHY settings will be
changed only during probe time and fatal error condition.

Due to this, UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH can now be skipped
when the PM operation is in progress.

Cc: stable@vger.kernel.org
Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
Reported-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c   | 3 ++-
 drivers/ufs/host/ufs-qcom.c | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 34472871610d..1f0a9d96e613 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8782,7 +8782,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	if (ret)
 		goto out;
 
-	if (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH) {
+	if (!hba->pm_op_in_progress &&
+	    (hba->quirks & UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH)) {
 		/* Reset the device and controller before doing reinit */
 		ufshcd_device_reset(hba);
 		ufshcd_hba_stop(hba);
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 78689d3479e4..ebb8054a3b3e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -909,8 +909,13 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 			return ret;
 		}
 
-		/* Use the agreed gear */
-		host->hs_gear = dev_req_params->gear_tx;
+		/*
+		 * Update hs_gear only when the gears are scaled to a higher value. This is because,
+		 * the PHY gear settings are backwards compatible and we only need to change the PHY
+		 * settings while scaling to higher gears.
+		 */
+		if (dev_req_params->gear_tx > host->hs_gear)
+			host->hs_gear = dev_req_params->gear_tx;
 
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
-- 
2.25.1

