Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B471C809CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjLHG7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjLHG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:43 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F11199E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:41 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c68da9d639so1370179a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018781; x=1702623581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5bBF/sQbySCYPg7WmDeYMVJLCmITb9mfETbIB5H8fc=;
        b=bIuWUZwDoM+8k8PEx/f7kPnNqpxLPkvkh+4Q5i2cT79IuqAG+tHePzik/VKmr6y1+N
         avvvPlGhMw4IR7+1SIw06XkWQhnPhAM+pISfC8v/IN1o6WY8wDP/m5gR7RxKJxrJkFUV
         V1UkyiKMq4MhiphhAiwT2IUF1+uJke5qmbEKr1SNsyJUAeng0EGTE5OdPdf3U73n7Xti
         6k0V3p+awVtjYKFbQWb+kOMNcQlLW+XWi9Y0Of1uVMH9dE/JoxBHFeDBgMPCfgqnYlhp
         Gpx9phsOa2q9xMj5VR/yplv0ovboJGW0OqxJ+y5Jp4K84om0KpbUAxPCE1kp6aTc29F/
         RuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018781; x=1702623581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5bBF/sQbySCYPg7WmDeYMVJLCmITb9mfETbIB5H8fc=;
        b=SxaBGPcqOX6TPU8WIuksCC460wV/zS/dws8KOrJ3I1X4u9w2042t+BicJqtpjMyucH
         0UKLazvrkViMPTZyvgN79m8Uj5AEbhMhQdKYo1DP7eHwQgeEBgRP0XWKJXLY6wPxbLkY
         NgGOvdKWYAxxj9u5bgFDUTL3FW1AhcEr12qut4wqCDP60MH+HG5fOB7m66ly/7j8OME7
         ISnoKMMYKJNz16tKhYt7aCXAe9YUZSeD9aYj83srlaPFpQGiJ8nABeDANGEa5PPGEzeH
         2Ou/2/i0SEwXzXMA0Klsr8NORghCvAUCttjtjqhG0b2CwuhhBE8MGobN9UT6Q/OnjTaB
         eFow==
X-Gm-Message-State: AOJu0Yw5LirCerLoHKGC69gCp+24XRAJqYAWlfSdanqUMp1oVvWcCoUt
        0dGj/gY34h3+LOTUwwj/XMgU
X-Google-Smtp-Source: AGHT+IHXYrZKT2ATj4oKtlQJr6YZvfZhqey7ziao9xfgNWvfFicMV4V7v7/6dsujySPQoidr6LTevA==
X-Received: by 2002:a05:6a21:32a0:b0:18f:c6ac:807f with SMTP id yt32-20020a056a2132a000b0018fc6ac807fmr3439182pzb.51.1702018781119;
        Thu, 07 Dec 2023 22:59:41 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:40 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 05/17] scsi: ufs: qcom: Remove the warning message when core_reset is not available
Date:   Fri,  8 Dec 2023 12:28:50 +0530
Message-Id: <20231208065902.11006-6-manivannan.sadhasivam@linaro.org>
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

core_reset is optional, so there is no need to warn the user if it is not
available.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index dc93b1c5ca74..d474de0739e4 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -296,10 +296,8 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	bool reenable_intr;
 
-	if (!host->core_reset) {
-		dev_warn(hba->dev, "%s: reset control not set\n", __func__);
+	if (!host->core_reset)
 		return 0;
-	}
 
 	reenable_intr = hba->is_irq_enabled;
 	disable_irq(hba->irq);
-- 
2.25.1

