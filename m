Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95F7FA264
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjK0OTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjK0OSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:18:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2AB3C01
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:21 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b472f99a0so6017375e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701094580; x=1701699380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkxpnfZSZT5EN0UFZSvV8zs0Wwv4/j6hiBpdKDk1HxA=;
        b=0mVI+iDAJgxg6XwiCvCPssrs22QZco0Y19B0HO8OBqq8OdqxNCd9tOFnLG7gwAbscJ
         3ZMT3u7CD6oJZKw0giKA1BLhN9ImGSEPZWOs1t7CLy1rcV/lnkSgJn/HpLrlMKDR8Iim
         XHnBkYlqtG8LHTZ9zjVEFm9A8fvZsdtWshV3FWz7udFhOSS4FjfnE4X8/SKWHFw/sRjN
         BM93c4lYBvKn1QL2XPyNzToB0Fhinrf+I+9M/6BWuxTy+mIuD8AkmgIYN2DQyPRjXbuU
         VVS/8mfHEPa4LdIa9FQcoZz8XzEy8t0d2Zt/Hz8mKjUX+wRZaLVlJLH5bJCkjUexkuUh
         9uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094580; x=1701699380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkxpnfZSZT5EN0UFZSvV8zs0Wwv4/j6hiBpdKDk1HxA=;
        b=uF4Ydv7r5doUXY535sMNJw5cHdeYk73AiPJTGzKT+wT3f8Y5yTFKkzTaBROsH4/w8H
         SKGRV7mT0yK83o9XN5xexHFme0gh1ThS0WmKnkSlVX7D3riaJKv7lzcvx2gXmnJ/uHEz
         aJjY6jIw2yVMIq7F0KeTDvjoFfI4ewm/xvYDC11M1kgi0kfgA9EhMWj+QTZTy6/0znCB
         aY+FHm8bKuGr3ZMIRFolZRXv4KTIz5nisgiXV6jstUkLMMA5Y3ReMSBFzu9cCTecCGW2
         dYBKR+hT9H8aXawhCGQGHuhh0FS6RSvZmJjx4/+odJkfE87+psunGhRMQ5ZAV2RzZ7Sn
         BEKQ==
X-Gm-Message-State: AOJu0YzXwLw8h/rOZsxnBAGFT28om9ICcFllWEFuk0GGpNYd5HekpxBw
        gl+v0tQoyA7c1/rpLjMxdK7pQg==
X-Google-Smtp-Source: AGHT+IHVgZ20gEmhmev1RX2eoTA9+8mg2/svsRYqUISptDWvOxDB3DOBPlKuaLgRVJ814cwcmx9shQ==
X-Received: by 2002:a05:600c:444b:b0:40a:3e41:7df1 with SMTP id v11-20020a05600c444b00b0040a3e417df1mr8884896wmn.37.1701094578887;
        Mon, 27 Nov 2023 06:16:18 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:bf33:77c7:8131:5e64])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b00405442edc69sm14658830wmb.14.2023.11.27.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:16:18 -0800 (PST)
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
Subject: [PATCH v6 08/13] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date:   Mon, 27 Nov 2023 15:15:55 +0100
Message-Id: <20231127141600.20929-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
References: <20231127141600.20929-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
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
2.40.1

