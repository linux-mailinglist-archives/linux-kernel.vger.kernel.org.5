Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314FE7C84F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjJMLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjJMLtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A35F3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50325ce89e9so2746422e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197744; x=1697802544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41VI8KmeE6u7QeFzUVy2dJM+rNPhWh8a/KDGfSZmgfE=;
        b=F0qQO8dXFm8E6YmuSCVCW2Re42o2yQqerxdh3vqZ8skWmSr8WHD/Yt4da3GI1IWJi/
         tMDGK2EVwXMTm7SjTzltidPOhOJvlE/tGafJfQY+pXencBwcE1D75skiUe9yGJPXTdx9
         HNOo4YmU7FnrW0Tg8qygvdlXzvSms1rqJAMdld8P3ZCEpvlU2G1Zj8XquGX3Tzh9WMX7
         lWhhuPkuVqAWbUkvDi2zgJRH4jusEqUk2H592a9Koeg2yGcy0bzXrGb8u1PFO3xufWII
         xZ7oPEhxpFjWQzmbTCmwbF4IXFpfhXxlhZkPd5o8yZCHTBA+BWk4MbiLBLHLcuBb0Yxd
         UtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197744; x=1697802544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41VI8KmeE6u7QeFzUVy2dJM+rNPhWh8a/KDGfSZmgfE=;
        b=VykgIgQPbZE+xYnml3Q6GF4zngd2kwHfwLs5tsW/U55dmkEKpbnbl1kIN2/CSN4mZg
         rcff6r9NXyx439p13r4RUeFV9FAEZF4+2rCZ5PjthZM0tbxAE/JHBNUYKk/L0yQFFuEm
         Vt7YmUegqEYs2jnXUushy+5zYyuuCPooAy/Dvry/JeIu1Cbn9/0DwxNmGJbib5/CaYrU
         gGbVx2HG8LPLuBetC9obh5ZmaeKuiKK2stO7R87Gw18fD2rApHMtBnVrVAPLbWOJW316
         jnD3HX/Lp5nsx9yjKjHgdaBcpYyTX/Oa6l9Y7dNCqfMu/j72YAsJqSuvFKCI7s43ialh
         wv/w==
X-Gm-Message-State: AOJu0Yz0or983ZhSm8RXETHQiSlWl6LnW9/EhV7VtC14fcgrtqIsNu52
        vNFbTYIg31NqQfDi635cVMCDDQ==
X-Google-Smtp-Source: AGHT+IE0D6+77y6Dv1lkam9mI8hiw9zqgGFDERMfB5/S0MW/bJaWj2c4bsozNzXSmAjkfFwlH89rKQ==
X-Received: by 2002:a05:6512:3b8c:b0:4fe:af1:c3ae with SMTP id g12-20020a0565123b8c00b004fe0af1c3aemr25220906lfv.15.1697197744060;
        Fri, 13 Oct 2023 04:49:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:49:03 -0700 (PDT)
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
Subject: [PATCH v4 11/15] firmware: qcom: qseecom: convert to using the TZ allocator
Date:   Fri, 13 Oct 2023 13:48:39 +0200
Message-Id: <20231013114843.63205-12-brgl@bgdev.pl>
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

Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
convert all users of it in the qseecom module to using the TZ allocator
for creating SCM call buffers. Together with using the cleanup macros,
it has the added benefit of a significant code shrink. As this is
largely a module separate from the SCM driver, let's use a separate
memory pool.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 261 +++++++-----------
 drivers/firmware/qcom/qcom_scm.c              |  30 +-
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 3 files changed, 104 insertions(+), 191 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index a33acdaf7b78..3a068f8b6990 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -7,17 +7,21 @@
  * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/ucs2_string.h>
 
 #include <linux/firmware/qcom/qcom_qseecom.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_tzmem.h>
 
 /* -- Qualcomm "uefisecapp" interface definitions. -------------------------- */
 
@@ -253,6 +257,7 @@ struct qsee_rsp_uefi_query_variable_info {
 struct qcuefi_client {
 	struct qseecom_client *client;
 	struct efivars efivars;
+	struct qcom_tzmem_pool *mempool;
 };
 
 static struct device *qcuefi_dev(struct qcuefi_client *qcuefi)
@@ -272,11 +277,11 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 					   const efi_guid_t *guid, u32 *attributes,
 					   unsigned long *data_size, void *data)
 {
-	struct qsee_req_uefi_get_variable *req_data;
-	struct qsee_rsp_uefi_get_variable *rsp_data;
+	struct qsee_req_uefi_get_variable *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_get_variable *rsp_data __free(qcom_tzmem) = NULL;
 	unsigned long buffer_size = *data_size;
-	efi_status_t efi_status = EFI_SUCCESS;
 	unsigned long name_length;
+	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
@@ -304,17 +309,13 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 		__array(u8, buffer_size)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, rsp_size, GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
 	req_data->data_size = buffer_size;
@@ -331,20 +332,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 
 	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
-	if (status) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (status)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_VARIABLE)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->length < sizeof(*rsp_data)) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->length < sizeof(*rsp_data))
+		return EFI_DEVICE_ERROR;
 
 	if (rsp_data->status) {
 		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
@@ -358,18 +353,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 				*attributes = rsp_data->attributes;
 		}
 
-		goto out_free;
+		return efi_status;
 	}
 
-	if (rsp_data->length > rsp_size) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->length > rsp_size)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->data_offset + rsp_data->data_size > rsp_data->length)
+		return EFI_DEVICE_ERROR;
 
 	/*
 	 * Note: We need to set attributes and data size even if the buffer is
@@ -392,33 +383,23 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	if (attributes)
 		*attributes = rsp_data->attributes;
 
-	if (buffer_size == 0 && !data) {
-		efi_status = EFI_SUCCESS;
-		goto out_free;
-	}
+	if (buffer_size == 0 && !data)
+		return EFI_SUCCESS;
 
-	if (buffer_size < rsp_data->data_size) {
-		efi_status = EFI_BUFFER_TOO_SMALL;
-		goto out_free;
-	}
+	if (buffer_size < rsp_data->data_size)
+		return EFI_BUFFER_TOO_SMALL;
 
 	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
 
-out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
-out:
-	return efi_status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
 					   const efi_guid_t *guid, u32 attributes,
 					   unsigned long data_size, const void *data)
 {
-	struct qsee_req_uefi_set_variable *req_data;
-	struct qsee_rsp_uefi_set_variable *rsp_data;
-	efi_status_t efi_status = EFI_SUCCESS;
+	struct qsee_req_uefi_set_variable *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_set_variable *rsp_data __free(qcom_tzmem) = NULL;
 	unsigned long name_length;
 	size_t name_offs;
 	size_t guid_offs;
@@ -448,17 +429,14 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 		__array_offs(u8, data_size, &data_offs)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*rsp_data),
+				    GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
 	req_data->attributes = attributes;
@@ -481,42 +459,31 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 
 	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data,
 				       sizeof(*rsp_data));
-	if (status) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (status)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->command_id != QSEE_CMD_UEFI_SET_VARIABLE)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->length != sizeof(*rsp_data)) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->length != sizeof(*rsp_data))
+		return EFI_DEVICE_ERROR;
 
 	if (rsp_data->status) {
 		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
 			__func__, rsp_data->status);
-		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
+		return qsee_uefi_status_to_efi(rsp_data->status);
 	}
 
-out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
-out:
-	return efi_status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 						unsigned long *name_size, efi_char16_t *name,
 						efi_guid_t *guid)
 {
-	struct qsee_req_uefi_get_next_variable *req_data;
-	struct qsee_rsp_uefi_get_next_variable *rsp_data;
-	efi_status_t efi_status = EFI_SUCCESS;
+	struct qsee_req_uefi_get_next_variable *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(qcom_tzmem) = NULL;
+	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
@@ -541,17 +508,13 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		__array(*name, *name_size / sizeof(*name))
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, rsp_size, GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
 	req_data->guid_offset = guid_offs;
@@ -567,20 +530,14 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		return EFI_INVALID_PARAMETER;
 
 	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
-	if (status) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (status)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->command_id != QSEE_CMD_UEFI_GET_NEXT_VARIABLE)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->length < sizeof(*rsp_data)) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->length < sizeof(*rsp_data))
+		return EFI_DEVICE_ERROR;
 
 	if (rsp_data->status) {
 		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
@@ -595,77 +552,59 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		if (efi_status == EFI_BUFFER_TOO_SMALL)
 			*name_size = rsp_data->name_size;
 
-		goto out_free;
+		return efi_status;
 	}
 
-	if (rsp_data->length > rsp_size) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->length > rsp_size)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->name_offset + rsp_data->name_size > rsp_data->length)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->guid_offset + rsp_data->guid_size > rsp_data->length)
+		return EFI_DEVICE_ERROR;
 
 	if (rsp_data->name_size > *name_size) {
 		*name_size = rsp_data->name_size;
-		efi_status = EFI_BUFFER_TOO_SMALL;
-		goto out_free;
+		return EFI_BUFFER_TOO_SMALL;
 	}
 
-	if (rsp_data->guid_size != sizeof(*guid)) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->guid_size != sizeof(*guid))
+		return EFI_DEVICE_ERROR;
 
 	memcpy(guid, ((void *)rsp_data) + rsp_data->guid_offset, rsp_data->guid_size);
 	status = ucs2_strscpy(name, ((void *)rsp_data) + rsp_data->name_offset,
 			      rsp_data->name_size / sizeof(*name));
 	*name_size = rsp_data->name_size;
 
-	if (status < 0) {
+	if (status < 0)
 		/*
 		 * Return EFI_DEVICE_ERROR here because the buffer size should
 		 * have already been validated above, causing this function to
 		 * bail with EFI_BUFFER_TOO_SMALL.
 		 */
 		return EFI_DEVICE_ERROR;
-	}
 
-out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
-out:
-	return efi_status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi, u32 attr,
 						  u64 *storage_space, u64 *remaining_space,
 						  u64 *max_variable_size)
 {
-	struct qsee_req_uefi_query_variable_info *req_data;
-	struct qsee_rsp_uefi_query_variable_info *rsp_data;
-	efi_status_t efi_status = EFI_SUCCESS;
+	struct qsee_req_uefi_query_variable_info *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(qcom_tzmem) = NULL;
 	int status;
 
-	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*req_data),
+				    GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*rsp_data),
+				    GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
 	req_data->attributes = attr;
@@ -673,26 +612,19 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 
 	status = qcom_qseecom_app_send(qcuefi->client, req_data, sizeof(*req_data), rsp_data,
 				       sizeof(*rsp_data));
-	if (status) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (status)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->command_id != QSEE_CMD_UEFI_QUERY_VARIABLE_INFO) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->command_id != QSEE_CMD_UEFI_QUERY_VARIABLE_INFO)
+		return EFI_DEVICE_ERROR;
 
-	if (rsp_data->length != sizeof(*rsp_data)) {
-		efi_status = EFI_DEVICE_ERROR;
-		goto out_free;
-	}
+	if (rsp_data->length != sizeof(*rsp_data))
+		return EFI_DEVICE_ERROR;
 
 	if (rsp_data->status) {
 		dev_dbg(qcuefi_dev(qcuefi), "%s: uefisecapp error: 0x%x\n",
 			__func__, rsp_data->status);
-		efi_status = qsee_uefi_status_to_efi(rsp_data->status);
-		goto out_free;
+		return qsee_uefi_status_to_efi(rsp_data->status);
 	}
 
 	if (storage_space)
@@ -704,12 +636,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 	if (max_variable_size)
 		*max_variable_size = rsp_data->max_variable_size;
 
-out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
-out:
-	return efi_status;
+	return EFI_SUCCESS;
 }
 
 /* -- Global efivar interface. ---------------------------------------------- */
@@ -838,6 +765,10 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 	if (status)
 		qcuefi_set_reference(NULL);
 
+	qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, SZ_256K);
+	if (IS_ERR(qcuefi->mempool))
+		return PTR_ERR(qcuefi->mempool);
+
 	return status;
 }
 
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 3a6cefb4eb2e..318d7d398e5f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1567,9 +1567,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
 /**
  * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @app_id:   The ID of the target app.
- * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req:      Request buffer sent to the app (must be TZ memory)
  * @req_size: Size of the request buffer.
- * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp:      Response buffer, written to by the app (must be TZ memory)
  * @rsp_size: Size of the response buffer.
  *
  * Sends a request to the QSEE app associated with the given ID and read back
@@ -1585,26 +1585,12 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
 {
 	struct qcom_scm_qseecom_resp res = {};
 	struct qcom_scm_desc desc = {};
-	dma_addr_t req_phys;
-	dma_addr_t rsp_phys;
+	phys_addr_t req_phys;
+	phys_addr_t rsp_phys;
 	int status;
 
-	/* Map request buffer */
-	req_phys = dma_map_single(__scm->dev, req, req_size, DMA_TO_DEVICE);
-	status = dma_mapping_error(__scm->dev, req_phys);
-	if (status) {
-		dev_err(__scm->dev, "qseecom: failed to map request buffer\n");
-		return status;
-	}
-
-	/* Map response buffer */
-	rsp_phys = dma_map_single(__scm->dev, rsp, rsp_size, DMA_FROM_DEVICE);
-	status = dma_mapping_error(__scm->dev, rsp_phys);
-	if (status) {
-		dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
-		dev_err(__scm->dev, "qseecom: failed to map response buffer\n");
-		return status;
-	}
+	req_phys = qcom_tzmem_to_phys(req);
+	rsp_phys = qcom_tzmem_to_phys(rsp);
 
 	/* Set up SCM call data */
 	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS;
@@ -1622,10 +1608,6 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
 	/* Perform call */
 	status = qcom_scm_qseecom_call(&desc, &res);
 
-	/* Unmap buffers */
-	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
-	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
-
 	if (status)
 		return status;
 
diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
index b531547e1dc9..26af1e778f00 100644
--- a/include/linux/firmware/qcom/qcom_qseecom.h
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -23,9 +23,9 @@ struct qseecom_client {
 /**
  * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @client:   The QSEECOM client associated with the target app.
- * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req:      Request buffer sent to the app (must be TZ memory).
  * @req_size: Size of the request buffer.
- * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp:      Response buffer, written to by the app (must be TZ memory).
  * @rsp_size: Size of the response buffer.
  *
  * Sends a request to the QSEE app associated with the given client and read
-- 
2.39.2

