Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849E7C84FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJMLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjJMLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EECE6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405524e6769so12849785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197743; x=1697802543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1+SqUu3MEUpRvP0zkJ91SMCh/hUg62w85Orn9bNfZQ=;
        b=iiC4B+4BMLo8n0lvIhn4Pqn5G9B5rg/KkSUXId0vkYWVj+p9Aannl4x7fTxkxd+ig+
         ipt07JwXCtDVfBegfW4GzCyeejHtFJ9J4YSzLxCT/yg+4jPLqJGLS3rd1gav+8hKpUzv
         XKFYZXjYQpDK853jUbmItDr6A7XBpGVTzI/5TrUVXmLm7UhleFmPbnZdorgDqTR2tCYC
         440YeCyYJk3MBVvxbWb1FT5TnZhZRv1VOqSiKhzkqQv5BdJugj5a9C/CH1VJ79htk8l1
         MXyQL+EUEd9ynbj7LcYuTLqHiLLi07IpKqppoIwQLR1ZHsmna1XCRWRDWMvyAlH7Dxf3
         qFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197743; x=1697802543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1+SqUu3MEUpRvP0zkJ91SMCh/hUg62w85Orn9bNfZQ=;
        b=ZpHfT7O3ilLkPgGG5oKE1Juh5TwmYm/DHmj97uqeLS/8n3YE/3HUgea3F7sVERa4q4
         sEC8Ez4S1nzIWaSuotj9S3Eh+6+ji7HyIYSDu3lEk1ANu9XyJAg13rDxfqtAVbmVjv4M
         TjMmchyufKLCnYl7w4q3nAT+QGqE+kS++MQHL1Dj9ZGanDlRQYo2ago5OFijYU7vkeB9
         LKBTMA3MJ7GZmXP1C7TN0E8D28dV324F9of1mrQK4EO04HPS2IMvB886R1mfSmlg0Uxi
         xZAuyX68qcCvHdysmTSXcaecxNV5nM4kxH99CkJd2eUB1DLC3iVNcygMGyJQGvkFLrCq
         3PZQ==
X-Gm-Message-State: AOJu0YzKQ3N9kXKdsictapQinuyfwVITFtZtAPcYOX1fHse3mla37UtM
        8wEN6KOCxWsM0PGhlDMJ34U0lg==
X-Google-Smtp-Source: AGHT+IHDwKNnkQ4WyyEUpEb+olLuPuuRdwsgI6TaMaTMotsUWqpHhmc5CD14COCyN8ypkhuiPDZtdg==
X-Received: by 2002:a05:600c:450a:b0:401:c7ec:b930 with SMTP id t10-20020a05600c450a00b00401c7ecb930mr18683731wmo.10.1697197743011;
        Fri, 13 Oct 2023 04:49:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:49:02 -0700 (PDT)
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
Subject: [PATCH v4 10/15] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date:   Fri, 13 Oct 2023 13:48:38 +0200
Message-Id: <20231013114843.63205-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of manually kmalloc()ing it and then mapping to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/firmware/qcom/qcom_scm.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 11638daa2fe5..3a6cefb4eb2e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1525,37 +1525,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
 	unsigned long app_name_len = strlen(app_name);
 	struct qcom_scm_desc desc = {};
 	struct qcom_scm_qseecom_resp res = {};
-	dma_addr_t name_buf_phys;
-	char *name_buf;
 	int status;
 
 	if (app_name_len >= name_buf_size)
 		return -EINVAL;
 
-	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	char *name_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							     name_buf_size,
+							     GFP_KERNEL);
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
+	desc.args[0] = qcom_tzmem_to_phys(name_buf);
 	desc.args[1] = app_name_len;
 
 	status = qcom_scm_qseecom_call(&desc, &res);
-	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
-	kfree(name_buf);
 
 	if (status)
 		return status;
-- 
2.39.2

