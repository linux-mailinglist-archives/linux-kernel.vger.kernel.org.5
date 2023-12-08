Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742D2809CD1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbjLHHAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573236AbjLHHAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:00:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C8173F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:00:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06fffdb65so13715735ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018821; x=1702623621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGLbsXXGOS5hXbJdfbXpRGohhCcqKUKVxgEMXEAy08s=;
        b=YeyAgzSGcDH+2e7mqUPgeHxqYUjbbNguQ3NgSgLy8KXb37NZm2krkB/+f9OXYjUqMK
         sEXsPwQzfm+uGCGugVgye7qgyHpoIzFi30oGTubgjjR0Zb8aaZ0KMwJR9dGmm56SqqUu
         /PAijbv9nP/ZhIk4Lz2utUCTppKLSyXOX3Vnk/nIBpa1NGVPbMrBA04ecUlpVuXFjhHu
         JP2mo+qGTG4ljzQyXS279N6RjvkcSP+2IErsnn6ErgYnFc0H6HHYA/3SWJpTgMVMB9qP
         8o0frzK1OfXLKkrwI4GsYdojndt1+IH2U3HGknpFhmBlzlG6oo39RQvQXbx2z2mqXxsT
         73cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018821; x=1702623621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGLbsXXGOS5hXbJdfbXpRGohhCcqKUKVxgEMXEAy08s=;
        b=eWAAwf1ZLCq1qdJO35QA9D/9UooxBaVAXtjdXUYcs7ut1+zeDuSrWSbpgw6ZejFXnM
         xztfyiC9Q4VpzB/a32ijMFJA5ABDr6tx/GaNvkRkxf+04K8lXj6aUZr5g1AZX7nwtVXT
         omMKa9SXC5fkHXx5OzIIO94jYizs/KKRs5RHd2xu2TBYXi25eS1EJhvJTJwZAyh+jJpo
         JdGHPxSd49YdQ5SW8zcoFXkkn0Qb8gFzmZPFypaBLCd8U5IDzz6tdb9I4pA/Q7YHpkEU
         AxXUsuZRId5r4Cfi45JK+Yv8z7yXdbj+SVgFV/J8DntRmlHkRuPW4aT4dnSJ5BWq6ZRj
         HYuQ==
X-Gm-Message-State: AOJu0YwQ7jZNPZfewrn002JwjlYdq0kHlYTLZP6OfzF+VFS/W4ltfsEa
        Fa3WOcTnObPaZHCckHFnYXsR
X-Google-Smtp-Source: AGHT+IFVUyG4dUS2LcbHQXN+dYuFi0KCByDG/dbfAzTMOhqxdP9LZSqbkTlmoGdGcQDFMbhwvqbFcw==
X-Received: by 2002:a17:902:b70d:b0:1d0:8c3c:a123 with SMTP id d13-20020a170902b70d00b001d08c3ca123mr3278106pls.38.1702018821392;
        Thu, 07 Dec 2023 23:00:21 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.23.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:00:20 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/17] scsi: ufs: qcom: Initialize cycles_in_1us variable in ufs_qcom_set_core_clk_ctrl()
Date:   Fri,  8 Dec 2023 12:28:58 +0530
Message-Id: <20231208065902.11006-14-manivannan.sadhasivam@linaro.org>
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

In case the "core_clk_unipro" clock is not provided, "cycles_in_1us"
variable will be used as uninitialized. So initialize it with 0.

Issue reported by Smatch tool:

drivers/ufs/host/ufs-qcom.c:1336 ufs_qcom_set_core_clk_ctrl() error: uninitialized symbol 'cycles_in_1us'.
drivers/ufs/host/ufs-qcom.c:1341 ufs_qcom_set_core_clk_ctrl() error: uninitialized symbol 'cycles_in_1us'.

Reviewed-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 7fbd35a3eb81..9b3d6d3609c9 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1298,7 +1298,7 @@ static int ufs_qcom_set_core_clk_ctrl(struct ufs_hba *hba, bool is_scale_up)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct list_head *head = &hba->clk_list_head;
 	struct ufs_clk_info *clki;
-	u32 cycles_in_1us;
+	u32 cycles_in_1us = 0;
 	u32 core_clk_ctrl_reg;
 	int err;
 
-- 
2.25.1

