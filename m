Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94058800E56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379393AbjLAPPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379442AbjLAPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:15:10 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF97173F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:15:09 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdce15f0a3so2572406b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443709; x=1702048509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64ppbjLuXnC3sRRee6xAp4YeL9+LAF3VOykBfQp43DQ=;
        b=NqcaiHbD9GEc1QdsywbH+1UAg6UVzN8fpEYFb9BqCPy8/OjnHyfEE/WF58C8a4gTkx
         wLcbXFvyQTq9BWcDY7/nuEgaV5OuKl9+L4xbhxUdFNU/KhlDvbNpcvpbgDzXl9NW6C8I
         3Zwg72HTkUQJgwNRYUnnNrzwsBgj3KJUeyzy5JU/ikEYk1kseUj4TkcngNmSa7+VAHHE
         4CD7wcv4fmktMwc/aWiqdm5UWfvfeTQnQ7laJkyUugKJTAQXxT7gK5Jikk23GhffpnZp
         5hMuCRI94o1tvBCms84+ZqzCn5nR3TXnc8TwyNHp6p1ztZV6XB8dSSwraKG+b+Hf7xSv
         sK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443709; x=1702048509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64ppbjLuXnC3sRRee6xAp4YeL9+LAF3VOykBfQp43DQ=;
        b=BFZN36/ebPNF1ol/iwXZsc3EN0be/lWGRChi6V/64cSZx2+lIgm+9tm3M6ChkkMDFQ
         rQqr/WuR2g8hTSgiRVKFQmlX11L2fdFHc13VE2VxWNjdAummvmDS2JbGEH0eQts4DAfV
         F4fgAAg5XBchAv203kPAa2jxNAA+MIHO4aKqUdTpTqYmUe1YqPcjJNkEFBIi44s3Hk1T
         uf3v/+kA4UCWLj2zY2uB58BtcUqRdhpxiWKWoQAm5nZsBMnro/MlfZ44PrNsJPQ41Dg2
         NvbnwEHSE4v8/m4P+iH3809qeBCboK6Fcntwh/DML2YYvNZQxN438EnT9fuGufD8OPac
         pW3g==
X-Gm-Message-State: AOJu0YyHem/7uZ60Dgl8PAgglkFY2OhJ7LgXjZCRJ15Qsq/pNwTPG0jG
        bGS0Z28AKzDeQYPbwJ3XYGxG
X-Google-Smtp-Source: AGHT+IGFEwYFndW1mgX6h47/MbvGBKo00XuXVuSHUaCz6PgUzV+fkCdc8GeBdLKLTyRZDfjr7WGuGA==
X-Received: by 2002:a05:6a20:918b:b0:15d:4cf1:212e with SMTP id v11-20020a056a20918b00b0015d4cf1212emr38989386pzd.4.1701443708902;
        Fri, 01 Dec 2023 07:15:08 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:15:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/13] scsi: ufs: qcom: Use dev_err_probe() to simplify error handling of devm_gpiod_get_optional()
Date:   Fri,  1 Dec 2023 20:44:14 +0530
Message-Id: <20231201151417.65500-11-manivannan.sadhasivam@linaro.org>
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

As done in other places, let's use dev_err_probe() to simplify the error
handling while acquiring the device reset gpio using
devm_gpiod_get_optional().

While at it, let's reword the error message to make it clear that the
failure is due to acquiring "device reset gpio".

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 218d22e1efce..a86f6620abc8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1146,9 +1146,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->device_reset = devm_gpiod_get_optional(dev, "reset",
 						     GPIOD_OUT_HIGH);
 	if (IS_ERR(host->device_reset)) {
-		err = PTR_ERR(host->device_reset);
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "failed to acquire reset gpio: %d\n", err);
+		err = dev_err_probe(dev, PTR_ERR(host->device_reset),
+				    "Failed to acquire device reset gpio\n");
 		goto out_variant_clear;
 	}
 
-- 
2.25.1

