Return-Path: <linux-kernel+bounces-133927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D2789AAFD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FE12826D9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF562E645;
	Sat,  6 Apr 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgBB5kpP"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2FB1EB48;
	Sat,  6 Apr 2024 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712408496; cv=none; b=aXAnYJg4CFTP5rfRCxWwf2EsOsaM2hW78k/3SCoi8dhI0mGt2Zakt9kD1u81abxK6rD8uFmmegSwCMIJ+6u+7J5hIy0N5luBGk7TwC6OZFdxxK3KkPexfi6cPc97jnYBTqQWfnaBQR52f6UrhOUsA+j7WdEyRvk/b8+olhxA8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712408496; c=relaxed/simple;
	bh=M/HaV2o+gMj9oKlxOeKW/AIU0O60vUzl7v5m/GWBQPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXuOzOX/AbYc4Pfep0vy8poYz5llfZCMVYbOtc0LT+hCcDcHXucEiuYbXCe3G37yMgxX2IPJN1r+z329X4LbdkP4kHStKhZIm2lXA5jFM+ImcsYennp1f0Fpy9sMR0QO+BLuYYJQbEJANEMPgvs51/fM4DRipsDBHCtW7dStiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgBB5kpP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4156c4fe401so19846745e9.1;
        Sat, 06 Apr 2024 06:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712408493; x=1713013293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGB7kbfNaKoq3FysIwjHALAS0bUuU9oCcRobKO/8ZGk=;
        b=IgBB5kpPBRbVPeSmVKUBITsHgCfKu9zNsKregHWEoHUK8w2/wEYz0lLU5B7HyM7rrU
         jh2rqznJeUngJ35B8KHAiPNDnHLAGhykikd2Tv3twTvIqZ3TwBOppJitfZ09pQIOmRNv
         lZUcb3msclaaQpmRekh2GMHyv/NPiFjYBxoNyk/DTLxF67H7XbD3AW7RnZCONyfbJ7fG
         WI+qe9UQWOsigYPfwvCZfaHUXLLfPpqmegGiuMHy9iDAl2005d4MJgFjXbpzGsk8Xere
         RtLimni8H2oDCagfMARxAVwuX7I8uUghRsgzmevaTirouEQyUiGsqmkKSQ9k/13ZCVhi
         Q0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712408493; x=1713013293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGB7kbfNaKoq3FysIwjHALAS0bUuU9oCcRobKO/8ZGk=;
        b=Fj8FvyJzWw2Hy3MUI039pyNOQhtQTGYXp7AiYIeuBdq5IJJFIJmVNzXdEY/YxBdKS5
         eQEx+XoAsNNs7b7rcp/lRu5hIXtkz325jxECN3Cm9EkypMvqa4vrQx2NXsbcwAswLJJv
         JeSm5Xiq5VQikfO8YF/Wc+aUf1QEHi001Z7LeV7iYCCM5Yp+W+sZqON9S1lsEDT4PbCt
         kYfrbybg69A3iD/UOuifO93SUWTGQihsZGgxVg/UhSTQNYrV9kc8zTano297KYINVypj
         y5fFR8PZnZc/h2TCLF20+bfepz4f73VKp8ciNVFnHwQeNkB9AhW0SjV0n/IBZcS91ASQ
         +LVA==
X-Forwarded-Encrypted: i=1; AJvYcCWESeFoQjN1neYPP9cYXXBjhXB2C04pQQgs3qi3s55NWhJdOsAOXfCzk1Z7TrOxxCxdKy3abBEUT1xu2nOq88coJK8GMHewTQBp7tTeaBVi0XyXzosZtfmEINxdFiFFrKjMITSV2Jxv4k3DLRRPcpN9/nbCIzNgYt7mIq7wsV33zcTkzw==
X-Gm-Message-State: AOJu0YxD+E6/TpS+i5ooXj1W+XhJYkoe9P4EYe9gKIsd6vSe2Ao9JMR5
	3OuQIVWLC2kNdwaN5o5fK91nVcAlF9zLcaXUNgvnNQoHruPafLCA
X-Google-Smtp-Source: AGHT+IFiX0UFEZ4jsF/piT/yAPXpPk8g9Np9tOoDvw6CJc6VT5QryNZpWxeWK4X+QJXrVhFBXdkzuA==
X-Received: by 2002:a05:600c:3584:b0:416:4933:c8be with SMTP id p4-20020a05600c358400b004164933c8bemr167787wmq.28.1712408492358;
        Sat, 06 Apr 2024 06:01:32 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id fm13-20020a05600c0c0d00b00416458c71f2sm701672wmb.45.2024.04.06.06.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 06:01:31 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] firmware: qcom: uefisecapp: Fix memory related IO errors and crashes
Date: Sat,  6 Apr 2024 15:01:09 +0200
Message-ID: <20240406130125.1047436-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that while the QSEECOM APP_SEND command has specific fields
for request and response buffers, uefisecapp expects them both to be in
a single memory region. Failure to adhere to this has (so far) resulted
in either no response being written to the response buffer (causing an
EIO to be emitted down the line), the SCM call to fail with EINVAL
(i.e., directly from TZ/firmware), or the device to be hard-reset.

While this issue can be triggered deterministically, in the current form
it seems to happen rather sporadically (which is why it has gone
unnoticed during earlier testing). This is likely due to the two
kzalloc() calls (for request and response) being directly after each
other. Which means that those likely return consecutive regions most of
the time, especially when not much else is going on in the system.

Fix this by allocating a single memory region for both request and
response buffers, properly aligning both structs inside it. This
unfortunately also means that the qcom_scm_qseecom_app_send() interface
needs to be restructured, as it should no longer map the DMA regions
separately. Therefore, move the responsibility of DMA allocation (or
mapping) to the caller.

Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
Cc: stable@vger.kernel.org  # 6.7
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
- rename DMA related variables
  - replace _phys suffix with _dma
  - drop _virt suffix
- use DMA-based naming in comments instead of referring to physical
  addresses/memory

---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 137 ++++++++++++------
 drivers/firmware/qcom/qcom_scm.c              |  37 +----
 include/linux/firmware/qcom/qcom_qseecom.h    |  55 ++++++-
 include/linux/firmware/qcom/qcom_scm.h        |  10 +-
 4 files changed, 153 insertions(+), 86 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 32188f098ef34..bc550ad0dbe0c 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -221,6 +221,19 @@ struct qsee_rsp_uefi_query_variable_info {
  * alignment of 8 bytes (64 bits) for GUIDs. Our definition of efi_guid_t,
  * however, has an alignment of 4 byte (32 bits). So far, this seems to work
  * fine here. See also the comment on the typedef of efi_guid_t.
+ *
+ * Note: It looks like uefisecapp is quite picky about how the memory passed to
+ * it is structured and aligned. In particular the request/response setup used
+ * for QSEE_CMD_UEFI_GET_VARIABLE. While qcom_qseecom_app_send(), in theory,
+ * accepts separate buffers/addresses for the request and response parts, in
+ * practice, however, it seems to expect them to be both part of a larger
+ * contiguous block. We initially allocated separate buffers for the request
+ * and response but this caused the QSEE_CMD_UEFI_GET_VARIABLE command to
+ * either not write any response to the response buffer or outright crash the
+ * device. Therefore, we now allocate a single contiguous block of DMA memory
+ * for both and properly align the data using the macros below. In particular,
+ * request and response structs are aligned at 8 byte (via __reqdata_offs()),
+ * following the driver that this has been reverse-engineered from.
  */
 #define qcuefi_buf_align_fields(fields...)					\
 	({									\
@@ -244,6 +257,12 @@ struct qsee_rsp_uefi_query_variable_info {
 #define __array_offs(type, count, offset)					\
 	__field_impl(sizeof(type) * (count), __alignof__(type), offset)
 
+#define __array_offs_aligned(type, count, align, offset)			\
+	__field_impl(sizeof(type) * (count), align, offset)
+
+#define __reqdata_offs(size, offset)						\
+	__array_offs_aligned(u8, size, 8, offset)
+
 #define __array(type, count)		__array_offs(type, count, NULL)
 #define __field_offs(type, offset)	__array_offs(type, 1, offset)
 #define __field(type)			__array_offs(type, 1, NULL)
@@ -277,10 +296,15 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	unsigned long buffer_size = *data_size;
 	efi_status_t efi_status = EFI_SUCCESS;
 	unsigned long name_length;
+	dma_addr_t cmd_buf_dma;
+	size_t cmd_buf_size;
+	void *cmd_buf;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
 	size_t rsp_size;
+	size_t req_offs;
+	size_t rsp_offs;
 	ssize_t status;
 
 	if (!name || !guid)
@@ -304,17 +328,19 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 		__array(u8, buffer_size)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
+	cmd_buf_size = qcuefi_buf_align_fields(
+		__reqdata_offs(req_size, &req_offs)
+		__reqdata_offs(rsp_size, &rsp_offs)
+	);
+
+	cmd_buf = qseecom_dma_alloc(qcuefi->client, cmd_buf_size, &cmd_buf_dma, GFP_KERNEL);
+	if (!cmd_buf) {
 		efi_status = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	req_data = cmd_buf + req_offs;
+	rsp_data = cmd_buf + rsp_offs;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_VARIABLE;
 	req_data->data_size = buffer_size;
@@ -332,7 +358,9 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 
 	memcpy(((void *)req_data) + req_data->guid_offset, guid, req_data->guid_size);
 
-	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
+	status = qcom_qseecom_app_send(qcuefi->client,
+				       cmd_buf_dma + req_offs, req_size,
+				       cmd_buf_dma + rsp_offs, rsp_size);
 	if (status) {
 		efi_status = EFI_DEVICE_ERROR;
 		goto out_free;
@@ -407,9 +435,7 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 	memcpy(data, ((void *)rsp_data) + rsp_data->data_offset, rsp_data->data_size);
 
 out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
+	qseecom_dma_free(qcuefi->client, cmd_buf_size, cmd_buf, cmd_buf_dma);
 out:
 	return efi_status;
 }
@@ -422,10 +448,15 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	struct qsee_rsp_uefi_set_variable *rsp_data;
 	efi_status_t efi_status = EFI_SUCCESS;
 	unsigned long name_length;
+	dma_addr_t cmd_buf_dma;
+	size_t cmd_buf_size;
+	void *cmd_buf;
 	size_t name_offs;
 	size_t guid_offs;
 	size_t data_offs;
 	size_t req_size;
+	size_t req_offs;
+	size_t rsp_offs;
 	ssize_t status;
 
 	if (!name || !guid)
@@ -450,17 +481,19 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 		__array_offs(u8, data_size, &data_offs)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
+	cmd_buf_size = qcuefi_buf_align_fields(
+		__reqdata_offs(req_size, &req_offs)
+		__reqdata_offs(sizeof(*rsp_data), &rsp_offs)
+	);
+
+	cmd_buf = qseecom_dma_alloc(qcuefi->client, cmd_buf_size, &cmd_buf_dma, GFP_KERNEL);
+	if (!cmd_buf) {
 		efi_status = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	req_data = cmd_buf + req_offs;
+	rsp_data = cmd_buf + rsp_offs;
 
 	req_data->command_id = QSEE_CMD_UEFI_SET_VARIABLE;
 	req_data->attributes = attributes;
@@ -483,8 +516,9 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	if (data_size)
 		memcpy(((void *)req_data) + req_data->data_offset, data, req_data->data_size);
 
-	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data,
-				       sizeof(*rsp_data));
+	status = qcom_qseecom_app_send(qcuefi->client,
+				       cmd_buf_dma + req_offs, req_size,
+				       cmd_buf_dma + rsp_offs, sizeof(*rsp_data));
 	if (status) {
 		efi_status = EFI_DEVICE_ERROR;
 		goto out_free;
@@ -507,9 +541,7 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 	}
 
 out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
+	qseecom_dma_free(qcuefi->client, cmd_buf_size, cmd_buf, cmd_buf_dma);
 out:
 	return efi_status;
 }
@@ -521,10 +553,15 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 	struct qsee_req_uefi_get_next_variable *req_data;
 	struct qsee_rsp_uefi_get_next_variable *rsp_data;
 	efi_status_t efi_status = EFI_SUCCESS;
+	dma_addr_t cmd_buf_dma;
+	size_t cmd_buf_size;
+	void *cmd_buf;
 	size_t guid_offs;
 	size_t name_offs;
 	size_t req_size;
 	size_t rsp_size;
+	size_t req_offs;
+	size_t rsp_offs;
 	ssize_t status;
 
 	if (!name_size || !name || !guid)
@@ -545,17 +582,19 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		__array(*name, *name_size / sizeof(*name))
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
-	if (!req_data) {
+	cmd_buf_size = qcuefi_buf_align_fields(
+		__reqdata_offs(req_size, &req_offs)
+		__reqdata_offs(rsp_size, &rsp_offs)
+	);
+
+	cmd_buf = qseecom_dma_alloc(qcuefi->client, cmd_buf_size, &cmd_buf_dma, GFP_KERNEL);
+	if (!cmd_buf) {
 		efi_status = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	req_data = cmd_buf + req_offs;
+	rsp_data = cmd_buf + rsp_offs;
 
 	req_data->command_id = QSEE_CMD_UEFI_GET_NEXT_VARIABLE;
 	req_data->guid_offset = guid_offs;
@@ -572,7 +611,9 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		goto out_free;
 	}
 
-	status = qcom_qseecom_app_send(qcuefi->client, req_data, req_size, rsp_data, rsp_size);
+	status = qcom_qseecom_app_send(qcuefi->client,
+				       cmd_buf_dma + req_offs, req_size,
+				       cmd_buf_dma + rsp_offs, rsp_size);
 	if (status) {
 		efi_status = EFI_DEVICE_ERROR;
 		goto out_free;
@@ -645,9 +686,7 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 	}
 
 out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
+	qseecom_dma_free(qcuefi->client, cmd_buf_size, cmd_buf, cmd_buf_dma);
 out:
 	return efi_status;
 }
@@ -659,26 +698,34 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 	struct qsee_req_uefi_query_variable_info *req_data;
 	struct qsee_rsp_uefi_query_variable_info *rsp_data;
 	efi_status_t efi_status = EFI_SUCCESS;
+	dma_addr_t cmd_buf_dma;
+	size_t cmd_buf_size;
+	void *cmd_buf;
+	size_t req_offs;
+	size_t rsp_offs;
 	int status;
 
-	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
-	if (!req_data) {
+	cmd_buf_size = qcuefi_buf_align_fields(
+		__reqdata_offs(sizeof(*req_data), &req_offs)
+		__reqdata_offs(sizeof(*rsp_data), &rsp_offs)
+	);
+
+	cmd_buf = qseecom_dma_alloc(qcuefi->client, cmd_buf_size, &cmd_buf_dma, GFP_KERNEL);
+	if (!cmd_buf) {
 		efi_status = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
-	if (!rsp_data) {
-		efi_status = EFI_OUT_OF_RESOURCES;
-		goto out_free_req;
-	}
+	req_data = cmd_buf + req_offs;
+	rsp_data = cmd_buf + rsp_offs;
 
 	req_data->command_id = QSEE_CMD_UEFI_QUERY_VARIABLE_INFO;
 	req_data->attributes = attr;
 	req_data->length = sizeof(*req_data);
 
-	status = qcom_qseecom_app_send(qcuefi->client, req_data, sizeof(*req_data), rsp_data,
-				       sizeof(*rsp_data));
+	status = qcom_qseecom_app_send(qcuefi->client,
+				       cmd_buf_dma + req_offs, sizeof(*req_data),
+				       cmd_buf_dma + rsp_offs, sizeof(*rsp_data));
 	if (status) {
 		efi_status = EFI_DEVICE_ERROR;
 		goto out_free;
@@ -711,9 +758,7 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 		*max_variable_size = rsp_data->max_variable_size;
 
 out_free:
-	kfree(rsp_data);
-out_free_req:
-	kfree(req_data);
+	qseecom_dma_free(qcuefi->client, cmd_buf_size, cmd_buf, cmd_buf_dma);
 out:
 	return efi_status;
 }
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 81c15aeff934a..f9c9fcfeaadaf 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1579,9 +1579,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
 /**
  * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @app_id:   The ID of the target app.
- * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req:      DMA address of the request buffer sent to the app.
  * @req_size: Size of the request buffer.
- * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp:      DMA address of the response buffer, written to by the app.
  * @rsp_size: Size of the response buffer.
  *
  * Sends a request to the QSEE app associated with the given ID and read back
@@ -1592,33 +1592,13 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
  *
  * Return: Zero on success, nonzero on failure.
  */
-int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
-			      size_t rsp_size)
+int qcom_scm_qseecom_app_send(u32 app_id, dma_addr_t req, size_t req_size,
+			      dma_addr_t rsp, size_t rsp_size)
 {
 	struct qcom_scm_qseecom_resp res = {};
 	struct qcom_scm_desc desc = {};
-	dma_addr_t req_phys;
-	dma_addr_t rsp_phys;
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
-
-	/* Set up SCM call data */
 	desc.owner = QSEECOM_TZ_OWNER_TZ_APPS;
 	desc.svc = QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER;
 	desc.cmd = QSEECOM_TZ_CMD_APP_SEND;
@@ -1626,18 +1606,13 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
 				     QCOM_SCM_RW, QCOM_SCM_VAL,
 				     QCOM_SCM_RW, QCOM_SCM_VAL);
 	desc.args[0] = app_id;
-	desc.args[1] = req_phys;
+	desc.args[1] = req;
 	desc.args[2] = req_size;
-	desc.args[3] = rsp_phys;
+	desc.args[3] = rsp;
 	desc.args[4] = rsp_size;
 
-	/* Perform call */
 	status = qcom_scm_qseecom_call(&desc, &res);
 
-	/* Unmap buffers */
-	dma_unmap_single(__scm->dev, rsp_phys, rsp_size, DMA_FROM_DEVICE);
-	dma_unmap_single(__scm->dev, req_phys, req_size, DMA_TO_DEVICE);
-
 	if (status)
 		return status;
 
diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
index 5c28298a98bec..366243ee96096 100644
--- a/include/linux/firmware/qcom/qcom_qseecom.h
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -10,6 +10,7 @@
 #define __QCOM_QSEECOM_H
 
 #include <linux/auxiliary_bus.h>
+#include <linux/dma-mapping.h>
 #include <linux/types.h>
 
 #include <linux/firmware/qcom/qcom_scm.h>
@@ -24,12 +25,57 @@ struct qseecom_client {
 	u32 app_id;
 };
 
+/**
+ * qseecom_scm_dev() - Get the SCM device associated with the QSEECOM client.
+ * @client: The QSEECOM client device.
+ *
+ * Returns the SCM device under which the provided QSEECOM client device
+ * operates. This function is intended to be used for DMA allocations.
+ */
+static inline struct device *qseecom_scm_dev(struct qseecom_client *client)
+{
+	return client->aux_dev.dev.parent->parent;
+}
+
+/**
+ * qseecom_dma_alloc() - Allocate DMA memory for a QSEECOM client.
+ * @client:     The QSEECOM client to allocate the memory for.
+ * @size:       The number of bytes to allocate.
+ * @dma_handle: Pointer to where the DMA address should be stored.
+ * @gfp:        Allocation flags.
+ *
+ * Wrapper function for dma_alloc_coherent(), allocating DMA memory usable for
+ * TZ/QSEECOM communication. Refer to dma_alloc_coherent() for details.
+ */
+static inline void *qseecom_dma_alloc(struct qseecom_client *client, size_t size,
+				      dma_addr_t *dma_handle, gfp_t gfp)
+{
+	return dma_alloc_coherent(qseecom_scm_dev(client), size, dma_handle, gfp);
+}
+
+/**
+ * dma_free_coherent() - Free QSEECOM DMA memory.
+ * @client:     The QSEECOM client for which the memory has been allocated.
+ * @size:       The number of bytes allocated.
+ * @cpu_addr:   Virtual memory address to free.
+ * @dma_handle: DMA memory address to free.
+ *
+ * Wrapper function for dma_free_coherent(), freeing memory previously
+ * allocated with qseecom_dma_alloc(). Refer to dma_free_coherent() for
+ * details.
+ */
+static inline void qseecom_dma_free(struct qseecom_client *client, size_t size,
+				    void *cpu_addr, dma_addr_t dma_handle)
+{
+	return dma_free_coherent(qseecom_scm_dev(client), size, cpu_addr, dma_handle);
+}
+
 /**
  * qcom_qseecom_app_send() - Send to and receive data from a given QSEE app.
  * @client:   The QSEECOM client associated with the target app.
- * @req:      Request buffer sent to the app (must be DMA-mappable).
+ * @req:      DMA address of the request buffer sent to the app.
  * @req_size: Size of the request buffer.
- * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
+ * @rsp:      DMA address of the response buffer, written to by the app.
  * @rsp_size: Size of the response buffer.
  *
  * Sends a request to the QSEE app associated with the given client and read
@@ -43,8 +89,9 @@ struct qseecom_client {
  *
  * Return: Zero on success, nonzero on failure.
  */
-static inline int qcom_qseecom_app_send(struct qseecom_client *client, void *req, size_t req_size,
-					void *rsp, size_t rsp_size)
+static inline int qcom_qseecom_app_send(struct qseecom_client *client,
+					dma_addr_t req, size_t req_size,
+					dma_addr_t rsp, size_t rsp_size)
 {
 	return qcom_scm_qseecom_app_send(client->app_id, req, req_size, rsp, rsp_size);
 }
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index ccaf288460546..aaa19f93ac430 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -118,8 +118,8 @@ bool qcom_scm_lmh_dcvsh_available(void);
 #ifdef CONFIG_QCOM_QSEECOM
 
 int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
-int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
-			      size_t rsp_size);
+int qcom_scm_qseecom_app_send(u32 app_id, dma_addr_t req, size_t req_size,
+			      dma_addr_t rsp, size_t rsp_size);
 
 #else /* CONFIG_QCOM_QSEECOM */
 
@@ -128,9 +128,9 @@ static inline int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
 	return -EINVAL;
 }
 
-static inline int qcom_scm_qseecom_app_send(u32 app_id, void *req,
-					    size_t req_size, void *rsp,
-					    size_t rsp_size)
+static inline int qcom_scm_qseecom_app_send(u32 app_id,
+					    dma_addr_t req, size_t req_size,
+					    dma_addr_t rsp, size_t rsp_size)
 {
 	return -EINVAL;
 }
-- 
2.44.0


