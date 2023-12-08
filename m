Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8313809CBE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573222AbjLHHAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjLHG7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DE173F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d1e1edb10bso16237245ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018791; x=1702623591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkWOwl1gLnVxHW9Sk9i4VGOJ3Gf+zYB/UjGbRoXR81c=;
        b=wmE7sC409h0Z1AqzsfGRreFRBGN9XqN7GgJKdxVly1q2zyWBByCUtVJEoGQcYc5TFN
         OqXM+odAuee2nH+pe2dqXLKwx9fFUKHsjWOCAMRO6wg/3NtKKfak2UmfpFqK5CLAj65Y
         n+M0cBeSYXis8tiN4jPERzm0tXbkVMMCH1RgDrh715roDpTeRJcI3QlDH4dkVGk3PiiS
         LVZz17f5Jvxt642jhNrRyRcxm+rYDGUFNNXtboBflfvxsFtq3gr6X7LrbbdtoCnCsPsH
         m3ul8303tWm6G6+7MgCWfXuKkK/faqrrVS6j4XPNvj6b3552RUlb50Ej8AGG3D3fMq5I
         Eq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018791; x=1702623591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkWOwl1gLnVxHW9Sk9i4VGOJ3Gf+zYB/UjGbRoXR81c=;
        b=T/Cs/5jSoOiJ3V7t5R8NGdVRJJQ2vIZcwrnwECWufrFCVaphllzckANe8YFmppPZih
         0tCC7JMp7fSr/xOXRb/kMz4P7Vos5/o0Xys7v97vIpgilLf1ZqYOL7VAN9VHTSECTHPy
         BV9JhNcLiOi3Dlqi7G5HCjNnNBV6ArQ614zGJKzz3y/ZUSh1FYUnC/guBzGBe48NiCSS
         GvGNs2LUn89FfYLhdNmGcViGrBVhQDz6qupyzG2X4cVrgeasev6V7fA522SjuDzgpaVj
         LtVGc8T2wwbnXwu9ObTCSXiYeIEUhUbArZsEvOEQJPMnEotya1putxFQTZfHpcLlopNR
         BbAA==
X-Gm-Message-State: AOJu0YzWNsZ2gyg0vyeCAtyGRc7gzpGKd4aF5QcDyyy91k/TEZU90qMn
        PzxWkyBTJwjX4apmKtQI1gHB
X-Google-Smtp-Source: AGHT+IHLDjHVaFMfxqHVlQylAA59l3ygh31Wv41zWg5H31h364vHz17oNOarusJYQLvTDusipO2sYA==
X-Received: by 2002:a17:902:8d85:b0:1d0:6ffd:e2d8 with SMTP id v5-20020a1709028d8500b001d06ffde2d8mr3844469plo.114.1702018791539;
        Thu, 07 Dec 2023 22:59:51 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 07/17] scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset fails
Date:   Fri,  8 Dec 2023 12:28:52 +0530
Message-Id: <20231208065902.11006-8-manivannan.sadhasivam@linaro.org>
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

Even though core_reset is optional, a failure during assert/deassert should
be considered fatal, if core_reset is available. So fail
ufs_qcom_power_up_sequence() if an error happens during reset and also get
rid of the redundant warning as the ufs_qcom_host_reset() function itself
prints error messages.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 604273a22afd..365a61dbf7ea 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -317,9 +317,11 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 	usleep_range(200, 210);
 
 	ret = reset_control_deassert(host->core_reset);
-	if (ret)
+	if (ret) {
 		dev_err(hba->dev, "%s: core_reset deassert failed, err = %d\n",
 				 __func__, ret);
+		return ret;
+	}
 
 	usleep_range(1000, 1100);
 
@@ -359,8 +361,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
 	if (ret)
-		dev_warn(hba->dev, "%s: host reset returned %d\n",
-				  __func__, ret);
+		return ret;
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
-- 
2.25.1

