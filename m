Return-Path: <linux-kernel+bounces-116795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF588A3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908941C3AF2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C938E183BB8;
	Mon, 25 Mar 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1vmAQSOj"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD619669A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361058; cv=none; b=JgYw8uW0UBkjXJsunpmUH4C90iDKgEsp7iKqUHk8HJJtYnhpYVdVLuzRNLoncQ5Cf+KXvfcAa5ELfGYT7fnt1+N2GURYtydsXr2bBvjDhGhr20+fjWVYKkY22jYB0rHHdB++s8Xx8GyHhc+wjkXyErEs0xID5gPNz+Y2BmBZXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361058; c=relaxed/simple;
	bh=83Fdc076bYj/s1yygqLvmZ2+L9RmSnvcYSYKgD+dn7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPErFD94FDznrGYX4OfX8UMN17Popt8d6LI7jeGv80q2LpImuE56elTwf0AUrq5AU01YD+u3jnx81CjcL4/SimpqJZiVk/lers7a+wglrUWEzJ70HFZMKn+SQ+Ro5s0/gui7FB5tqikg/D2tcVEoIUIlr6Lp7sZic4E3eKN3vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1vmAQSOj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515a97846b5so1120799e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361054; x=1711965854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwbZht4rYHsS/RI3RkjDueLnk3zhqu+HloBw+ugNiVI=;
        b=1vmAQSOjvnKT321Vmteqyj++U20Gh1naoUNDBdIGxgW66YUsMmESZzJ9bMefXWudHQ
         o0d1BwmgkVI7+7y+CGrUyBbo6ozWb3K4O/H2eRJSFdUntkipUk1IPFoKqmf4T0HtiyBT
         q+dLDY1x2pYe+TMCexL8U2qRv+JkOPx87JEl5HryyNRImkh7ljwfi1oFwMJD/6k8wn+D
         hq1t0oHqLtYYrot3Cn/QQeLPaE+ASlmWaqfVMh2/CBcqRvGQun75GCjtQFBHVji9GMhc
         wU67XfA9v5EMtcKxb2CcrKB8SaM6B/P+imn61sG8vqAwEla8PBOtfi0qmxkBw+0+lpOi
         5sfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361054; x=1711965854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwbZht4rYHsS/RI3RkjDueLnk3zhqu+HloBw+ugNiVI=;
        b=teLV9c+taiCh9WMds7M40wbD87g9HbFR5iODRYu5k+Em1NaydBetnYzusuLjS8hqen
         8HG8Z9qO4HglgeeV8Q/4NQHlflbmz5D61s2c5f6TzFQPIrPpaGTw3j8Xv9O65FOzQ0pe
         zMnfd4bxlel9yNLlyuLsm2spUrjJdTmUNlp3hOkxM4J43VqJNU7VMuypI7zPjHMzHap7
         HZC8rOHmwSUNTekKzG9TtinXrudL9VNgzfR/yNDhe+pfp0pkd/6reTKNOniNqvrOy5vL
         KuuRjIeqFP0Yelot4AdFIRoyCMIA2I1MtvhSdlcLqtmiDjDIC16NHotX67T47edyOBtz
         mUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0W9sZWK+sIcNjF2F2zp9Gj0lGKiOssk3gaH1nr8xixoD9ca7TsG6r04npO5sBFTGG1k8zS65JdTjGaaw+i+P6+eOYrwOjEI/zmR/J
X-Gm-Message-State: AOJu0YwIqK/cNzN8CiSeGQu0Q8TmbjyH9aoXZNq5zDiusH5HqEzjfJ0v
	zLggPNTRLgSat7KIbN5XKidO7YMVOYW2NWwiXVlPgffyb9oo9dbeu2mi4TXkic0=
X-Google-Smtp-Source: AGHT+IHMP2uK2wz3NAx31rx5eJAUjH/6YZmMgjVGlyT85kOIpxVJPnLjJbFnQREqPfYkJzQ+ySDEBw==
X-Received: by 2002:a05:6512:3e7:b0:513:d5b5:78e9 with SMTP id n7-20020a05651203e700b00513d5b578e9mr4317348lfq.26.1711361054359;
        Mon, 25 Mar 2024 03:04:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:13 -0700 (PDT)
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 08/13] firmware: qcom: qseecom: convert to using the cleanup helpers
Date: Mon, 25 Mar 2024 11:03:54 +0100
Message-Id: <20240325100359.17001-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325100359.17001-1-brgl@bgdev.pl>
References: <20240325100359.17001-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Shrink the code by using __free() for allocations that are freed within
the same functions.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 254 ++++++------------
 1 file changed, 84 insertions(+), 170 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 32188f098ef3..1f8c5efc2b5a 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2023 Maximilian Luz <luzmaximilian@gmail.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -272,11 +273,11 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 					   const efi_guid_t *guid, u32 *attributes,
 					   unsigned long *data_size, void *data)
 {
-	struct qsee_req_uefi_get_variable *req_data;
-	struct qsee_rsp_uefi_get_variable *rsp_data;
+	struct qsee_req_uefi_get_variable *req_data __free(kfree) = NULL;
+	struct qsee_rsp_uefi_get_variable *rsp_data __free(kfree) = NULL;
 	unsigned long buffer_size = *data_size;
-	efi_status_t efi_status = EFI_SUCCESS;
 	unsigned long name_length;
+	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
@@ -305,16 +306,12 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	);
 
 	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
 	req_data->data_size = buffer_size;
@@ -325,28 +322,20 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
@@ -360,18 +349,14 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
@@ -394,33 +379,23 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
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
+	struct qsee_req_uefi_set_variable *req_data __free(kfree) = NULL;
+	struct qsee_rsp_uefi_set_variable *rsp_data __free(kfree) = NULL;
 	unsigned long name_length;
 	size_t name_offs;
 	size_t guid_offs;
@@ -451,16 +426,12 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	);
 
 	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
 	req_data->attributes = attributes;
@@ -473,10 +444,8 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	req_data->length = req_size;
 
 	status = ucs2_strscpy(((void *)req_data) + req_data->name_offset, name, name_length);
-	if (status < 0) {
-		efi_status = EFI_INVALID_PARAMETER;
-		goto out_free;
-	}
+	if (status < 0)
+		return EFI_INVALID_PARAMETER;
 
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 
@@ -485,42 +454,31 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 
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
+	struct qsee_req_uefi_get_next_variable *req_data __free(kfree) = NULL;
+	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(kfree) = NULL;
+	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
@@ -546,16 +504,12 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 	);
 
 	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
 	req_data->guid_offset = guid_offs;
@@ -567,26 +521,18 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
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
@@ -601,77 +547,57 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
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
+	struct qsee_req_uefi_query_variable_info *req_data __free(kfree) = NULL;
+	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(kfree) = NULL;
 	int status;
 
 	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
-	if (!req_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out;
-	}
+	if (!req_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	if (!rsp_data)
+		return EFI_OUT_OF_RESOURCES;
 
 	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
 	req_data->attributes = attr;
@@ -679,26 +605,19 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 
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
@@ -710,12 +629,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
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
-- 
2.40.1


