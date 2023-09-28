Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAE97B1726
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjI1JVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjI1JVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ADA180
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405361bba99so124787445e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892868; x=1696497668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7e3uVvAU/9XxRD0WWB/UR6KH+g5Ytg3FZjMRpb3BmQ=;
        b=W9T4z9ZQ+Qcn35oxemG3I1bDWjfrEMLol/kezXmKOKgPMscV43tFkENsSp1gEgUVuU
         FUAP2hVvYqPn3ptc/4699PpDsG+btbJMlAEVQ1UdcoB5V6w53/S2KZDsb1Nl4i9vaWy2
         lgEL7ajqywW5RwL3uUnHC0XjyT1nhQQfnDJ5/ACnc+b1ljnJpb+tInkhXvDQLagWZOzO
         QfT3YAaqJoVUGbupp6lYyyNuExhhqvJHSJrzXhmaTD9FMTyIWGvGRcFy9CvVZll+57or
         tYE8l43JKlvPMYyvsHfkNSstQwM+jd8Ec26jabqxZ9pauQwTyWt1NUhmPYcYvO1ghjfb
         N20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892868; x=1696497668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7e3uVvAU/9XxRD0WWB/UR6KH+g5Ytg3FZjMRpb3BmQ=;
        b=GgR+HHa9GAR1e2gcsklE2ZCcxGpRifooCjvzWDwWIPc9JwPEHTphwXTECrSy6nWVMI
         LcXuHWVsswBX8ZSaBpR8WdPZMb7h+xr3RNMOlTjw5QJG5oRH+1eItDMOmatKx+tOF4OM
         fIOAlgOORh8Nb+EBacDiLNHOfnpx1NELH7/aYQFbfNj7grOLyPxOS14YXhTAWt6m0Jyc
         Rl938JnQZDvv0ZNCxuuqvvTf717Q3Hwb6EIdPdgSiGl3jTA/mhfmE/mSRtIojzBoMX9N
         jUs0ObGMQXxMiXq8dK9arRiup3ocE2ROvCXeRajgiUQ/9NAzRkVXyIEFoTa0yKgPxYUi
         IpyA==
X-Gm-Message-State: AOJu0Yyd5vyJMXVbEqdJ6xB8+UeWvkIoMntcqtiqxf4ZuE8eYy3agXKV
        v0kFEYpdjawA9hlX6hAYPOPy0Q==
X-Google-Smtp-Source: AGHT+IHvPdg1US9zOhiS3vntMewiD0dIhRhPvx/9zL+4s/NAyPLZSQZEFla7sCsnTQM4eWM79WOwvA==
X-Received: by 2002:a5d:6188:0:b0:321:707a:8ca5 with SMTP id j8-20020a5d6188000000b00321707a8ca5mr681117wru.38.1695892868485;
        Thu, 28 Sep 2023 02:21:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH v2 08/11] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the SCM allocator
Date:   Thu, 28 Sep 2023 11:20:37 +0200
Message-Id: <20230928092040.9420-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
References: <20230928092040.9420-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new SCM memory allocator to obtain a buffer for this call
instead of manually kmalloc()ing it and then mapping to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 41095bf1d4d7..37e876437a3e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1498,37 +1498,26 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
 	unsigned long app_name_len = strlen(app_name);
 	struct qcom_scm_desc desc = {};
 	struct qcom_scm_qseecom_resp res = {};
-	dma_addr_t name_buf_phys;
-	char *name_buf;
 	int status;
 
 	if (app_name_len >= name_buf_size)
 		return -EINVAL;
 
-	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	char *name_buf __free(qcom_scm_mem) = qcom_scm_mem_alloc(name_buf_size,
+								 GFP_KERNEL);
 	if (!name_buf)
 		return -ENOMEM;
 
 	memcpy(name_buf, app_name, app_name_len);
 
-	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
-	status = dma_mapping_error(__scm->dev, name_buf_phys);
-	if (status) {
-		kfree(name_buf);
-		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
-		return status;
-	}
-
 	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
 	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
 	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
-	desc.args[0] = name_buf_phys;
+	desc.args[0] = qcom_scm_mem_to_phys(name_buf);
 	desc.args[1] = app_name_len;
 
 	status = qcom_scm_qseecom_call(&desc, &res);
-	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
-	kfree(name_buf);
 
 	if (status)
 		return status;
-- 
2.39.2

