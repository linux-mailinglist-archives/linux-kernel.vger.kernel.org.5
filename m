Return-Path: <linux-kernel+bounces-116796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928588A36B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504DB2E15AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3F183BA9;
	Mon, 25 Mar 2024 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zpBD4ilH"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6AF19669E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361059; cv=none; b=EfxaVT0xFHRPOa/NcXUICdkqPdbgYuFVVuL+ynQ1Tv4Gd4dk8DR3cfOurDqklYH6VGke552n/tz9QXSMFAfqSBihWaNIhyRSkGaspIVfaLeNOAnL0GGuMdcwq8VvTjoy6tvVkWBeCBt3jcIgGtGc4Ayz2jWqiRKlUhFX0oA7YiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361059; c=relaxed/simple;
	bh=pnUfGJ3bPKimmOuPRCBCPhxkg+N6CLAxmi+aNOvymxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPCij52J5nSXipTxGdLr4PnrVOGLARbSwsJH1k2qhV3eEpm/Gl2XA7eZOMyqTvmX/bXOn1u3IsVOwlHMm01714nWEVLa/piZHfE2KbdYn/wGQHijLxe6MfYjESsU2q0fy4LObWSjud8mBbI/tC4MxZsNsXZLnbAOvGDbuSxVBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zpBD4ilH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ecb04e018so2910342f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361056; x=1711965856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozfFeJyXaUD6FQQEli0mm3wcSChIOoojk249rH7ELtY=;
        b=zpBD4ilHIak4iVrfRhplyJF4AKtdZ+29USg7Oqq0DsYeVo1M4vIjKPc+21n8XKQBv8
         a5jCDFHVL+gtP5rXu2ElxZ01Pq6jrHz+0YkuFyeWr45FBj76GpBSUqneq76qnVERo6kj
         GSObQizWixVAqZFlBtFIRwRut6NuafzZjyYnsgfUXJLakrTS/V8iX8s+vbkKi7Hm4CF5
         bYlae0BYkPECsasJPBTKJqTYRWH4Dlgd+Brl2Xz8mbjcfYcp7DKOj++tSMlIaXYk03vy
         MzbXdeSSsbP/IeW4+fd0DlMa1VjZOfXVxoCbN4GHgQJzYIrQQKI5NwM3LR069/LcAK+h
         4OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361056; x=1711965856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozfFeJyXaUD6FQQEli0mm3wcSChIOoojk249rH7ELtY=;
        b=nyE2F6m8A67Tw3pMX+gLMZyFEYUNono4e+YtEOREXUwwCam2EfrmwrdsdWWVGtb0I6
         GccEKQLcu78X2J4vgz3Dkq6ewClX+9Znubw6rFp7xiXrPCW51idwdrWDNYLjLku7+s6Z
         T2S785W12HL0Kx1XjmNZUPAFz9ltemjUJ8rig/HQivtzWGE1PpiSXCWvB2toAXG9Xec3
         PCGllCIk0oWTygCqPBphh6Ny7cT9zs3g/CMi24RjYURoxfMOTnzBBJioXSgm+l3HZzDa
         NIDVgtfQT1WjqDch0I1Hd8oZNHWaZT9slyiy2yDEpilfuEiHKZ+t0aaeTLvhO0i4rvO+
         XScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxD5Gu9KMucTmuczyYhJVvv60uKKosHhdoJ7VfJpLaSlDlFRfyd/8Hd2pXRYJTnga1NZmlNIGULtgln7QewMzdL/74AgqUiWPL6J0e
X-Gm-Message-State: AOJu0Ywg+tmb1am5HKzE7D6so8AYRVSWhZ4sAzZM0qbWBrpSdrccOg47
	xQzGhi+rYoe5CNfjKWi5zEAKF3GsRb9kJ1h3LtyPMvCY8XmMq+lHxBAUSgA/4tE=
X-Google-Smtp-Source: AGHT+IG5oeeUmNjJm+e6PyXNNlgVwD4/ExZy6L7LCkX9nZWS0361na1GOzWnhUYhyhO9dtvSAa29gA==
X-Received: by 2002:adf:edd2:0:b0:33e:720e:4a4e with SMTP id v18-20020adfedd2000000b0033e720e4a4emr4442835wro.19.1711361055954;
        Mon, 25 Mar 2024 03:04:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:14 -0700 (PDT)
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
Subject: [PATCH v9 09/13] firmware: qcom: qseecom: convert to using the TZ allocator
Date: Mon, 25 Mar 2024 11:03:55 +0100
Message-Id: <20240325100359.17001-10-brgl@bgdev.pl>
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

Drop the DMA mapping operations from qcom_scm_qseecom_app_send() and
convert all users of it in the qseecom module to using the TZ allocator
for creating SCM call buffers. As this is largely a module separate from
the SCM driver, let's use a separate memory pool. Set the initial size to
4K and - if we run out - add twice the current amount to the pool.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 47 ++++++++++++-------
 drivers/firmware/qcom/qcom_scm.c              | 30 +++---------
 include/linux/firmware/qcom/qcom_qseecom.h    |  4 +-
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 1f8c5efc2b5a..0bb13c8225c2 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -14,11 +14,14 @@
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
 
@@ -254,6 +257,7 @@ struct qsee_rsp_uefi_query_variable_info {
 struct qcuefi_client {
 	struct qseecom_client *client;
 	struct efivars efivars;
+	struct qcom_tzmem_pool *mempool;
 };
 
 static struct device *qcuefi_dev(struct qcuefi_client *qcuefi)
@@ -273,8 +277,8 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 					   const efi_guid_t *guid, u32 *attributes,
 					   unsigned long *data_size, void *data)
 {
-	struct qsee_req_uefi_get_variable *req_data __free(kfree) = NULL;
-	struct qsee_rsp_uefi_get_variable *rsp_data __free(kfree) = NULL;
+	struct qsee_req_uefi_get_variable *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_get_variable *rsp_data __free(qcom_tzmem) = NULL;
 	unsigned long buffer_size = *data_size;
 	unsigned long name_length;
 	efi_status_t efi_status;
@@ -305,11 +309,11 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
 		__array(u8, buffer_size)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
 	if (!req_data)
 		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, rsp_size, GFP_KERNEL);
 	if (!rsp_data)
 		return EFI_OUT_OF_RESOURCES;
 
@@ -394,8 +398,8 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 					   const efi_guid_t *guid, u32 attributes,
 					   unsigned long data_size, const void *data)
 {
-	struct qsee_req_uefi_set_variable *req_data __free(kfree) = NULL;
-	struct qsee_rsp_uefi_set_variable *rsp_data __free(kfree) = NULL;
+	struct qsee_req_uefi_set_variable *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_set_variable *rsp_data __free(qcom_tzmem) = NULL;
 	unsigned long name_length;
 	size_t name_offs;
 	size_t guid_offs;
@@ -425,11 +429,11 @@ static efi_status_t qsee_uefi_set_variable(struct qcuefi_client *qcuefi, const e
 		__array_offs(u8, data_size, &data_offs)
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
 	if (!req_data)
 		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*rsp_data), GFP_KERNEL);
 	if (!rsp_data)
 		return EFI_OUT_OF_RESOURCES;
 
@@ -476,8 +480,8 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 						unsigned long *name_size, efi_char16_t *name,
 						efi_guid_t *guid)
 {
-	struct qsee_req_uefi_get_next_variable *req_data __free(kfree) = NULL;
-	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(kfree) = NULL;
+	struct qsee_req_uefi_get_next_variable *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_get_next_variable *rsp_data __free(qcom_tzmem) = NULL;
 	efi_status_t efi_status;
 	size_t guid_offs;
 	size_t name_offs;
@@ -503,11 +507,11 @@ static efi_status_t qsee_uefi_get_next_variable(struct qcuefi_client *qcuefi,
 		__array(*name, *name_size / sizeof(*name))
 	);
 
-	req_data = kzalloc(req_size, GFP_KERNEL);
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, req_size, GFP_KERNEL);
 	if (!req_data)
 		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(rsp_size, GFP_KERNEL);
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, rsp_size, GFP_KERNEL);
 	if (!rsp_data)
 		return EFI_OUT_OF_RESOURCES;
 
@@ -587,15 +591,15 @@ static efi_status_t qsee_uefi_query_variable_info(struct qcuefi_client *qcuefi,
 						  u64 *storage_space, u64 *remaining_space,
 						  u64 *max_variable_size)
 {
-	struct qsee_req_uefi_query_variable_info *req_data __free(kfree) = NULL;
-	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(kfree) = NULL;
+	struct qsee_req_uefi_query_variable_info *req_data __free(qcom_tzmem) = NULL;
+	struct qsee_rsp_uefi_query_variable_info *rsp_data __free(qcom_tzmem) = NULL;
 	int status;
 
-	req_data = kzalloc(sizeof(*req_data), GFP_KERNEL);
+	req_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*req_data), GFP_KERNEL);
 	if (!req_data)
 		return EFI_OUT_OF_RESOURCES;
 
-	rsp_data = kzalloc(sizeof(*rsp_data), GFP_KERNEL);
+	rsp_data = qcom_tzmem_alloc(qcuefi->mempool, sizeof(*rsp_data), GFP_KERNEL);
 	if (!rsp_data)
 		return EFI_OUT_OF_RESOURCES;
 
@@ -740,6 +744,7 @@ static const struct efivar_operations qcom_efivar_ops = {
 static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 				 const struct auxiliary_device_id *aux_dev_id)
 {
+	struct qcom_tzmem_pool_config pool_config;
 	struct qcuefi_client *qcuefi;
 	int status;
 
@@ -758,6 +763,16 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
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
index d9b189632e61..f871af4af829 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1570,9 +1570,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
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
@@ -1588,26 +1588,12 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
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
@@ -1625,10 +1611,6 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
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


