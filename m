Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D77C84FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjJMLtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJMLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536DADC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4066241289bso21022385e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197742; x=1697802542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/0qKoBBzx1o8heobCmZaZFWvw6elFeS/Pei4C+kHSs=;
        b=s/g0csrclmz3GozRG0l5wyE/Lttb9W3OTncNXhgdsDZ1NlYbdblXzvxmstNm1KXlf3
         VyGmLNQRy9a5I3oEP9dkkom19lij7iEWQzEDpUt4byNMFMSGKmyLVeUZmviPFNSnlDtO
         bVIP+GWJEX2EGjzpvFaDYnZfZgSFpN91why1wiVmRvfOqhy0wLFlIaq8K+hdKViJvkYV
         xQtIoNKh/uWpzwNGZBXxfhh9WgXFDxH+mRKVPfoGzBPi2PgCQfYwH8XM0j2kwgNwarFb
         Ba2RRX7nleM7XZg+g3nN7vnRELqNQlKf8TXHREE9x8FSBAk4C3zPzy2ahV9Wq9eSY9cR
         bOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197742; x=1697802542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/0qKoBBzx1o8heobCmZaZFWvw6elFeS/Pei4C+kHSs=;
        b=ZfQx7rKWEcC64yj2qi9JQccQ6Ex8hZWHPK0OH2jTcnowbWoz07KS4ODbmiY+nyqMDR
         wxbT8CPb8PFMBSARVHezemvuoz5bwcIchYn/0KkrVixB3YJz0OC9f0xAwXCHNELrACVb
         1zWbZnaRffTzTsFI8uAhuKS9c2ye4CcvvlsoVAL/XZeqvgUTj1iDcTsiaiVc8EZZTGMd
         8apuwIhEO+WDHN8R0dgssbqqtTFhRddgm3DanKPFi33m1yXyd2zNqm7rhpEJwNaw/2+a
         RbMvkIblijiTkCa7jTotHLefhVh+gIxOmwcq7/32LJn2dXXqZW/73eI5/+Ym8w3jF4WQ
         0pMw==
X-Gm-Message-State: AOJu0YyMgzc7tHgu862ocM+4bXuWdhRqMeXz3d2EN5MqOdBsFSHHkXhA
        P4MFc7vOEJ6mpNTmEzJchKKbRw==
X-Google-Smtp-Source: AGHT+IHoBO8HhGjm81+tFaTERty06vctUqUtTt7LVjwozBsdYYmJBEYr6WrYmoqnx9XpNk3164HUaQ==
X-Received: by 2002:a1c:f718:0:b0:405:3a63:6d12 with SMTP id v24-20020a1cf718000000b004053a636d12mr23826471wmh.17.1697197741772;
        Fri, 13 Oct 2023 04:49:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:49:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 09/15] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date:   Fri, 13 Oct 2023 13:48:37 +0200
Message-Id: <20231013114843.63205-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 31071a714cf1..11638daa2fe5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
 {
-	dma_addr_t payload_phys;
-	u32 *payload_buf;
 	int ret, payload_size = 5 * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
@@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       payload_size,
+							       GFP_KERNEL);
 	if (!payload_buf)
 		return -ENOMEM;
 
@@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[3] = 1;
 	payload_buf[4] = payload_val;
 
-	desc.args[0] = payload_phys;
+	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
-	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
-- 
2.39.2

