Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A33809CAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjLHG7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjLHG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:20 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657C81718
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfabcbda7bso21838525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018766; x=1702623566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIWn45Ech+fto22q1XGFNjdWj3hQRi8//sYbCfmx5as=;
        b=tnecBDvi8mgub21fpXNe0w89pKeQ140jqJeww+5fE/T5Iqnn/UBEN9ZrEdtM7IKJTb
         TQ9gCT9xEMXbk7oGshB5cBWIcf0cpbD48tp/JHa2jqf6slp9IYK12YJexpI8UiIUt2Jm
         1R61VPyKVp2pCy0oTKw8EBmLdCcpkuEW1rW9Gsc4sVGIe67O3VfgeGYZzV9tMqGVUoeX
         MafsW9ZbGdbyRvUQenmfY+YcQrZy4Wfa2xK4rc2lsf2pj616SgAM/p7WLvmVGYsS50kC
         ClZrHKwmYQqzrTYQq9bqMSFRuFaFO5l17DHxh+2iN6DsArnlyqMZek//914A/ue+fen4
         Sdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018766; x=1702623566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIWn45Ech+fto22q1XGFNjdWj3hQRi8//sYbCfmx5as=;
        b=et93ZxVQFpE8LAIbVRoyVZFx6dq0nJVvv59DineVPb9knqfaRgj7Vse/DvjR0oumzw
         gRTPTxylBZQQ8VaxZQc/dsbbK4CYiPpL+rQRndjWbpo8gk8nhHcrUwytGo6COgxHlYx4
         74nkjLwERgNNx2W9pVWQRatzf/wzGJ6pDq4wSZBBnx2u9YY2vK8YD9yC6pHk626+ZE5S
         sUT383Qit9DqNZjxN+Y6fZ6+bQgI6N9EMQyMMsbPBXiViQXcnzZdDhIwzdXz1CgpleLd
         KAf0GN7OlrnQZWtCJIHVR6eR5EQDm2aCjVsgARyYP/rnqGVB25yCy6G81FE9wNaWP3zE
         OS6Q==
X-Gm-Message-State: AOJu0YwCjrcyGqRP2QwyhTdc9riyP0sIe1uHlJvMsrUrTtMjC7bCD3Wk
        KUJbiIHwZOHHlQuqRkfr36+9
X-Google-Smtp-Source: AGHT+IERpN0qjwvRGfdxD0ngWc5t5NaEAM8UxB6Ozm+bc5A9ENjr91lOleAtvBMS3kdiWYPeA0VG/A==
X-Received: by 2002:a17:902:ea11:b0:1cf:cc3e:c550 with SMTP id s17-20020a170902ea1100b001cfcc3ec550mr530932plg.5.1702018765889;
        Thu, 07 Dec 2023 22:59:25 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:25 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 02/17] scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
Date:   Fri,  8 Dec 2023 12:28:47 +0530
Message-Id: <20231208065902.11006-3-manivannan.sadhasivam@linaro.org>
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

Currently, the function returns -EINVAL if algorithm other than AES-256-XTS
is requested. But the correct error code is -EOPNOTSUPP. Fix it!

Cc: Abel Vesa <abel.vesa@linaro.org>
Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index cbb6a696cd97..852179e456f2 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -158,7 +158,7 @@ static int ufs_qcom_ice_program_key(struct ufs_hba *hba,
 	cap = hba->crypto_cap_array[cfg->crypto_cap_idx];
 	if (cap.algorithm_id != UFS_CRYPTO_ALG_AES_XTS ||
 	    cap.key_size != UFS_CRYPTO_KEY_SIZE_256)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (config_enable)
 		return qcom_ice_program_key(host->ice,
-- 
2.25.1

