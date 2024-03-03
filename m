Return-Path: <linux-kernel+bounces-89788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5486F5B2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB19A1F22B71
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E49BE5B;
	Sun,  3 Mar 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qMJDCGit"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B969DEC
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478095; cv=none; b=JtB4PcjyQWh4H88O1a/WIJmkTAvWxzmNpPel409tVcVp36dStb2qHK7f5cPgocFGT2KlDqtquUQgc+TpeFnj5cInydnrFMukq+6LwH1hbFbvv97ItTdVNAW5FKaPUART0i0NNwD8/n+Ql5R8ZvVVxTPcXRLL4m9+jmcxOIXvt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478095; c=relaxed/simple;
	bh=JzOml6c2V28hQVwZ5HkSztWfEi02ismkb1ZVE583aP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+DkE+kp1Th3ZP81UaXl/VpVK8NpvgXugqaaQtwGq3iHpXOgWp/pExd3WhIPjwA7Kd6lP+iN7wE4iF7JGNFRZeUXT/gg/0hf0aMXNyKLRGcYnkCJTJkjaQDfV48k+ORC55VDhKWR/a3igvhdADNab13l8CqF9GlnGK5jKPm/odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qMJDCGit; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d27184197cso49551081fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478091; x=1710082891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvxbHPzpiDWwdWBrzUR22pLvzfzBM3Zj0U9nhwJP3FQ=;
        b=qMJDCGitK89ccgnKKcNV69dloldZYAWc5QIA/qYKJCpXLNWpc1RDUaYQZfqR3yfDDa
         63Llw1cd/U8AV95h5D/B1B92Hl5c9AoYEA3/UJZJAVWcXSXDCdRoPiunk8Q1yonNBmv2
         /n7q7XwQP2UUC2fsVqDerMvZQ9QapDTY8x4kNOdbVb1bxNjvRd77sWdK993M9oHsn2Y5
         hXSVkaxMuHJvQsX/Q1iL3Ky3N77bKTKBx1rPgTlATm+JGJVXEyoWGRbHIU2z4cOdvDTV
         DXD333ACM8XzEtqUMHCzzBOHUDuEIDckqIIouVxgqOLupium79YI8t47uG3Xu8dAUIKZ
         Dthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478091; x=1710082891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvxbHPzpiDWwdWBrzUR22pLvzfzBM3Zj0U9nhwJP3FQ=;
        b=BgfQrx8KWrdZ85bj55Be97XpoNiysObhTKg8lgDWalqe6pmB1Oh3dmKPbiOFUeTx4e
         /TlLm/a8u/2KJIge5b8/OfG3QsWs1US1k6HI/R0275lmmQyug7VmPzmCQYouhh6n0BO2
         kupaloNBXooBP9XynljW45Zo7GoLBoCdQm3MxI0Pw1yXeYUkF8L56uiYvRlJPUmXIg4k
         72J+dYUNRJSNhkM3qqXZdGTr0bGPT7TvvRzeilrUZQhxN73r7S7LqcCl/YFnoM8uJhZ8
         JB2bIgOHmxWLR3RlbtnFCGcfjFaC134YI4cH6bVTTFbV0MLa4H64JnsIxmZSvI+qg2Gg
         JOtA==
X-Forwarded-Encrypted: i=1; AJvYcCXe6SJPnAaDLtR6XDdexXRb6jKOUtrA96mQzw4tU8ls+r4dl3GfjunqL+dbQ+ZAwF99fa2ucjG/eeAEbVPMkM09r9iIVNEYh8JvWdDT
X-Gm-Message-State: AOJu0YxSCik7y7PULJ7rrOZu7FyIGrn0Cxqhp5sH6BykTKVhf/VwbNg/
	v1YUTb1xjYBzrzfnV6yUOssg7a4RYkcm0HF5Nqx7E0u2Vmbs7yDnBB1c4num+1Q=
X-Google-Smtp-Source: AGHT+IGirOm2qCTPRK1BB6qTA+a5ED4GMu6hVFtsl2HMZq0eXFWkokV4SAN8NJdzS6p9Br9+E229wg==
X-Received: by 2002:a05:6512:2209:b0:512:bce5:5564 with SMTP id h9-20020a056512220900b00512bce55564mr5614087lfu.43.1709478090989;
        Sun, 03 Mar 2024 07:01:30 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:30 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v8 08/12] firmware: qcom: qseecom: convert to using the TZ allocator
Date: Sun,  3 Mar 2024 16:01:11 +0100
Message-Id: <20240303150115.133633-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
convert all users of it in the qseecom module to using the TZ allocator
for creating SCM call buffers. Together with using the cleanup macros,
it has the added benefit of a significant code shrink. As this is
largely a module separate from the SCM driver, let's use a separate
memory pool. Set the initial size to 4K and - if we run out - add twice
the current amount to the pool.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 288 +++++++-----------
 drivers/firmware/qcom/qcom_scm.c              |  30 +-
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 3 files changed, 118 insertions(+), 204 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 32188f098ef3..cf258a884c20 100644
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
@@ -325,28 +326,20 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	req_data->length = req_size;
 
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
-	if (status < 0) {
-		efi_status = EFI_INVALID_PARAMETER;
-		goto out_free;
-	}
+	if (status < 0)
+		return EFI_INVALID_PARAMETER;
 
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
@@ -360,18 +353,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
@@ -394,33 +383,23 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
@@ -450,17 +429,14 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
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
@@ -473,10 +449,8 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	req_data->length = req_size;
 
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
-	if (status < 0) {
-		efi_status = EFI_INVALID_PARAMETER;
-		goto out_free;
-	}
+	if (status < 0)
+		return EFI_INVALID_PARAMETER;
 
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 
@@ -485,42 +459,31 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 
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
@@ -545,17 +508,13 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
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
@@ -567,26 +526,18 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name,
 			      *name_size / sizeof(*name));
-	if (status < 0) {
-		efi_status = EFI_INVALID_PARAMETER;
-		goto out_free;
-	}
+	if (status < 0)
+		return EFI_INVALID_PARAMETER;
 
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
@@ -601,77 +552,59 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
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
-		efi_status = EFI_DEVICE_ERROR;
-	}
+		return EFI_DEVICE_ERROR;
 
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
@@ -679,26 +612,19 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 
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
@@ -710,12 +636,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
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
@@ -826,6 +747,7 @@ static const struct efivar_operations qcom_efivar_ops = {
 static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 				 const struct auxiliary_device_id *aux_dev_id)
 {
+	struct qcom_tzmem_pool_config pool_config;
 	struct qcuefi_client *qcuefi;
 	int status;
 
@@ -844,6 +766,16 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 	if (status)
 		qcuefi_set_reference(NULL);
 
+	memset(&pool_config, 0, sizeof(pool_config));
+	pool_config.initial_size = SZ_4K;
+	pool_config.policy = QCOM_TZMEM_POLICY_MULTIPLIER;
+	pool_config.increment = 2;
+	pool_config.max_size = SZ_256K;
+
+	qcuefi->mempool = devm_qcom_tzmem_pool_new(&aux_dev->dev, &pool_config);
+	if (IS_ERR(qcuefi->mempool))
+		return PTR_ERR(qcuefi->mempool);
+
 	return status;
 }
 
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index b0fc0727d090..6578fe9c8d62 100644
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


