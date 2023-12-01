Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEEF800E47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379378AbjLAPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379364AbjLAPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E95194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:14:49 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6cb749044a2so2234877b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443689; x=1702048489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnOqh3tKVGxzLKVliMslkL85vI3TlFUJ6BYDSjXWVCM=;
        b=piBUBkG9uHOi7mSVIxeCLVNiNuoR5BzdVQJJ7IgkhhSgJjpokyXpjW2euko5Ymd/SB
         jK5xDHPEq5Mn56qcprjXt28xqoT5HfhEzxXE9NC5Js/i9wbU66PPB2kjie0Wxwu2zhkn
         k7UoEqaUPYReoaMozX1s4wB5Gp4iNk3bKnaN3KnaHyP0MEimdy9iYl+i1Fyhwyry6SaZ
         0ybrqzZEfpe1kV1H/h0rjb+9gScTZcPDb48biWNU3fyPC+OBL6KSpYYC3or3JY8Dtma0
         8hI0e0Vkkcw6gmtBP9RPUoidPKMNckytaBj2QySybHla8YZ2i0xPPxHnml5lOnyYGSuO
         QmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443689; x=1702048489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnOqh3tKVGxzLKVliMslkL85vI3TlFUJ6BYDSjXWVCM=;
        b=ws0ZzRZ57bvx2cFH6KyQF5pdtdRiF2hv85gcYmS7+ubPYvRjLSwu83mXhcEgh9/AmU
         IFdySX6DJckf3Kgn6qZ0cePM4WKDa4owbjDVYzfr+1ugmdsIuPBGntvGgLp/gMJHXTiN
         gto57raBx7WG7/Hv3lB6EY5xAmTRHY6N/T69Ercmbaia+Zreom1svMiz1XRu2OruMP4h
         3hLFvWJ9vS2LahFpzsKFVuwRHB9gCQ762a8VabC1nr2NFFUjFlOu+RiZTOfTJ2M9EAnF
         6uCBHq1/sC0qtWjyZiEeXCbXh5K8pUGiMQ3/Zd0W+zkuuV8sdwKcU+WQGIFyUZl/FblL
         lOug==
X-Gm-Message-State: AOJu0YwSDNAQXDhy66vh0lwwu1JYKig+Rf687atJhACnkXDd01skj2ar
        exQ5OcPiRjfqw/7iDwhJb2At
X-Google-Smtp-Source: AGHT+IFRok/PPbeYz1jt5sDzaQAYKwisws8ppClXIyJSzhqJBqHMFReTc4GN3X4WZgb17WbfSDMXFw==
X-Received: by 2002:a05:6a21:150a:b0:18a:f462:5d3c with SMTP id nq10-20020a056a21150a00b0018af4625d3cmr30375005pzb.12.1701443689407;
        Fri, 01 Dec 2023 07:14:49 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/13] scsi: ufs: qcom: Remove the warning message when core_reset is not available
Date:   Fri,  1 Dec 2023 20:44:09 +0530
Message-Id: <20231201151417.65500-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

core_reset is optional, so there is no need to warn the user if it is not
available (that too not while doing host reset each time).

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

