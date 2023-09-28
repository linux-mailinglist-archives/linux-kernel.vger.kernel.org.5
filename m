Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA27B172A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjI1JVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjI1JVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB6091
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32164a6af64so11128384f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892869; x=1696497669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DChZlKiRZBb+j9T+a7xaqTe29l5ns2EGQ+8Evv55SQ0=;
        b=VGhcNMGLASdza++zjFMauVKYRrcfGSkWDYO01/+Uv4R/4gY6YG7G4g7XdTciEuk5GZ
         9/OOfY93zl8jLqoY8Iaiv1YmadoYnY+sS2zpvbouUjre/aiKnS7oH6XB/3j9hiIl1M/H
         TaxDEuLPhwTvr2gxYR7hcukjoAsYyicYtFmyUZ6nxTGZmRiVIE6ZRFXnjb217WahXvja
         g1Kn4fxg5ZDflcrLeBwEG+S/4LrNJ3WABfqT0+Ctb8tf6nFRS86wW/coJCwCcPP1VKwI
         LZPABht6nA5r2RPsKv0JWOEN2tnL6dBX/vHi1Orli7h0EyIpnuDQ+GZqoUW5pWfKRrIA
         bbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892869; x=1696497669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DChZlKiRZBb+j9T+a7xaqTe29l5ns2EGQ+8Evv55SQ0=;
        b=RUyWGlwxXpysNcffsrrqIjAoS/yINbCUiDT2dXK0MZG4Tg4ACL4NHPUPW++Q0qlIN7
         cLyu21wf4ekVw1zvAPxfUGfXDeMAN5DpIjOjwD6/i5NghrgToYOnX8AomZ+2MBLNd0wa
         HymzXQaD0PP7wLmpiBaetJcbBkL0W45h73jyS3iUuqtaVxBNGwz34i9RujIkmkrhcnGd
         0wzN7hVMdbtihyRFnJNaVicq/S4jEV3nMo3NdZ2Aq0i+1Owo9KiOIfe7R8oH/0dlt4cr
         dP+MxLlUEUaXL75pFWxrO2QEvCrWBJzAxJD1Eot6XcBOSSaiFxWYl9Y3L7H+RqbzSLYh
         gMZQ==
X-Gm-Message-State: AOJu0YzBWiNOw5L7jMJzI3Wp3d6mr/TjPCPPfJ5hAMx91Zxhyt02Oi36
        y5gsuWtt0xHNGYRFWUSQJdVutg==
X-Google-Smtp-Source: AGHT+IEAP7K95Ly9Ht0h5K6DYb82jnr0aCxin44ahWlMIIyaupj/cgxOA20sBwxNMoVTZAFK/dBK+A==
X-Received: by 2002:adf:e683:0:b0:321:6f5f:789f with SMTP id r3-20020adfe683000000b003216f5f789fmr689014wrm.39.1695892869429;
        Thu, 28 Sep 2023 02:21:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH v2 09/11] firmware: qcom: qseecom: convert to using the SCM allocator
Date:   Thu, 28 Sep 2023 11:20:38 +0200
Message-Id: <20230928092040.9420-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
References: <20230928092040.9420-1-brgl@bgdev.pl>
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
convert all users of it in the qseecom module to using the SCM allocator
for creating SCM call buffers. Together with using the cleanup macros,
it has the added benefit of a significant code shrink

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 251 ++++++------------
 drivers/firmware/qcom/qcom_scm.c              |  31 +--
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 3 files changed, 94 insertions(+), 192 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index a33acdaf7b78..59193716161d 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -18,6 +19,7 @@
 #include <linux/ucs2_string.h>
 
 #include <linux/firmware/qcom/qcom_qseecom.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 
 /* -- Qualcomm "uefisecapp" interface definitions. -------------------------- */
 
@@ -272,11 +274,11 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 					   const efi_guid_t *guid, u32 *attributes,
 					   unsigned long *data_size, void *data)
 {
-	struct qsee_req_uefi_get_variable *req_data;
-	struct qsee_rsp_uefi_get_variable *rsp_data;
+	struct qsee_req_uefi_get_variable *req_data __free(qcom_scm_mem) = NULL;
+	struct qsee_rsp_uefi_get_variable *rsp_data __free(qcom_scm_mem) = NULL;
 	unsigned long buffer_size = *data_size;
-	efi_status_t efi_status = EFI_SUCCESS;
 	unsigned long name_length;
+	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
@@ -304,17 +306,13 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 		__array(u8, buffer_size)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_scm_mem_alloc(req_size, GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_scm_mem_alloc(rsp_size, GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
 	req_data->data_size = buffer_size;
@@ -331,20 +329,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
@@ -358,18 +350,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
@@ -392,33 +380,23 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
+	struct qsee_req_uefi_set_variable *req_data __free(qcom_scm_mem) = NULL;
+	struct qsee_rsp_uefi_set_variable *rsp_data __free(qcom_scm_mem) = NULL;
 	unsigned long name_length;
 	size_t name_offs;
 	size_t guid_offs;
@@ -448,17 +426,13 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 		__array_offs(u8, data_size, &data_offs)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_scm_mem_alloc(req_size, GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_scm_mem_alloc(sizeof(*rsp_data), GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
 	req_data->attributes = attributes;
@@ -481,42 +455,31 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 
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
+	struct qsee_req_uefi_get_next_variable *req_data __free(qcom_scm_mem) = NULL;
+	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(qcom_scm_mem) = NULL;
+	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
@@ -541,17 +504,13 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		__array(*name, *name_size / sizeof(*name))
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_scm_mem_alloc(req_size, GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_scm_mem_alloc(rsp_size, GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
 	req_data->guid_offset = guid_offs;
@@ -567,20 +526,14 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
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
@@ -595,77 +548,57 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
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
+	struct qsee_req_uefi_query_variable_info *req_data __free(qcom_scm_mem) = NULL;
+	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(qcom_scm_mem) = NULL;
 	int status;
 
-	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	req_data = qcom_scm_mem_alloc(sizeof(*req_data), GFP_KERNEL);
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	rsp_data = qcom_scm_mem_alloc(sizeof(*rsp_data), GFP_KERNEL);
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
 	req_data->attributes = attr;
@@ -673,26 +606,19 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 
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
@@ -704,12 +630,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
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
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 37e876437a3e..1fa27c44f472 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -8,7 +8,6 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
-#include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/init.h>
@@ -1539,9 +1538,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
 /**
  * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @app_id:   The ID of the target app.
- * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req:      Request buffer sent to the app (must be SCM memory)
  * @req_size: Size of the request buffer.
- * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp:      Response buffer, written to by the app (must be SCM memory)
  * @rsp_size: Size of the response buffer.
  *
  * Sends a request to the QSEE app associated with the given ID and read back
@@ -1557,26 +1556,12 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
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
+	req_phys = qcom_scm_mem_to_phys(req);
+	rsp_phys = qcom_scm_mem_to_phys(rsp);
 
 	/* Set up SCM call data */
 	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS;
@@ -1594,10 +1579,6 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
 	/* Perform call */
 	status = qcom_scm_qseecom_call(&desc, &res);
 
-	/* Unmap buffers */
-	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
-	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
-
 	if (status)
 		return status;
 
diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
index b531547e1dc9..9b9803f78f03 100644
--- a/include/linux/firmware/qcom/qcom_qseecom.h
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -23,9 +23,9 @@ struct qseecom_client {
 /**
  * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @client:   The QSEECOM client associated with the target app.
- * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req:      Request buffer sent to the app (must be SCM memory).
  * @req_size: Size of the request buffer.
- * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp:      Response buffer, written to by the app (must be SCM memory).
  * @rsp_size: Size of the response buffer.
  *
  * Sends a request to the QSEE app associated with the given client and read
-- 
2.39.2

