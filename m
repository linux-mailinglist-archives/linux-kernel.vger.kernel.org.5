Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB57F1448
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjKTNV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjKTNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:21:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BF192
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:33 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40842752c6eso15997005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700486492; x=1701091292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfx4u4aIdA8tlpL52Vj3Y1awkdo1nUXo/Cn10wDXNcc=;
        b=DSfL/qGRpr3nc11bwcFJlXIsDkm/jthBIFEj0KPBsS6qJvFYy4zfM0sU50+TkDljH0
         97mWzqVjhJDB+mrLaP0P0ZqPwNB5PjnZN7hxa4PBiASdsjq0PNV8G6/OyUA2MtErposV
         NLxT6K0wagKEKyB0ydkXgYpTUtzo9ha6/8zTxv3KNqBMn5l6me/IHEt3W+cWnt5fMaye
         B/nh6X+PT3nsLDcb+EMjUkuJo55bG+miwTn0s0S8i4zy9s67f31rEpY02QPrDg50u4A3
         zKN2/aHP6UwAE9OB8UM+E/IVPnHpueeGjm/aWBMVtEiB/MpE3Mk46GD74qaKuxbmZan7
         iPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486492; x=1701091292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfx4u4aIdA8tlpL52Vj3Y1awkdo1nUXo/Cn10wDXNcc=;
        b=oEH6XHIR+kSpCgdWT/3gNQQUoKWatneY7hvZXQHrMr8ZsKHKQp1BFjWXXSA+6CTzBN
         uk5lnEDLvQr+veYm4qXcujNK6/Lv9IhtaxdzLJSB4Ao2yiyiOXKJf2S5kU7LKPLv1v16
         ocxj8zWeLQDWSf0TNLDpBjxtPkFEYv0QIHkq2Ct7GbEmEkv5D4I+6K2wrUWA/Sw5T2z2
         tcjYAAiYftrUCNi0qUpDnv5ofvIHTMtgYHwn1akbxrNQ0kNbDTQuxDZVtsZs0A00AwvD
         rJ4YuFhl8cA99G9Sui3NUi7QhI8KU0HHugxy0JwI3Iue9lF7tCo7RT6l0A5/o2T5rqI1
         AJbA==
X-Gm-Message-State: AOJu0YwX03PCcNrXogvw9LDBm82gaMlUYYyF0MpVDxVpo2XqvEtqhWT/
        YZiMoCJqxpBl4Nu+GLRM5HzfOw==
X-Google-Smtp-Source: AGHT+IGrYf8flqVkae8z0y1X+EEpufUnZ9jCR8+56OgQ7QOkz7qeRigg5d2bE9dDDwbPVJoQknlX+Q==
X-Received: by 2002:a05:600c:3b02:b0:408:389d:c22e with SMTP id m2-20020a05600c3b0200b00408389dc22emr5452471wms.25.1700486492341;
        Mon, 20 Nov 2023 05:21:32 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c590:a7ce:883:eba3])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b004065e235417sm17329192wmr.21.2023.11.20.05.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:21:31 -0800 (PST)
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
Subject: [RESEND PATCH v5 08/12] firmware: qcom: qseecom: convert to using the TZ allocator
Date:   Mon, 20 Nov 2023 14:21:14 +0100
Message-Id: <20231120132118.30473-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120132118.30473-1-brgl@bgdev.pl>
References: <20231120132118.30473-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
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
index 5c28298a98be..e868fac55675 100644
--- a/include/linux/firmware/qcom/qcom_qseecom.h
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -27,9 +27,9 @@ struct qseecom_client {
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
2.40.1

