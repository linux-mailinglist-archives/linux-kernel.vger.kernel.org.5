Return-Path: <linux-kernel+bounces-116789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E4D88A3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D1A2E27A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E1182EF6;
	Mon, 25 Mar 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MGi6tJ92"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8D196692
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361052; cv=none; b=rmFps7o1k5gyy0BkWrKyzBVNp6XwVvgvYf2j++vxG7Z6ZYMnAboXCkaCyk0WyyAn6Pex8BWHbp2OWJ1djJ9kyPACUgb5HK0QNizYqk7ly4pQ7AglQNZksOKoY1MHb+WMqsz7GMfwpuI6zFRFFu9eT8QtPsVBGq9v7iyw0MsV4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361052; c=relaxed/simple;
	bh=gjtc7kuMPVWBR1xygn+O8e1ryqKK2QsIDOKZu70ikE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDBWK7OyBcm4NmkXktSPgBDTy5tFWVxrODGvsavv7yKaa5sA2VBk9qGLdjlk0shALPdT8x7Z+BwkDR1MozLbo+XCF4q3nQfSI61qcS2+43cqQ9x6MyHMSCCygtDuDn+pXM8I4+7reBMP352LTg+gcJF5HsMwazDw09mVSy/I9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MGi6tJ92; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so3188394f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711361048; x=1711965848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBh/o5m6dd9oNmfjtpvQfXgCJqAsfnjpIKpx8z60vmU=;
        b=MGi6tJ92cLVJ9VJIMsUQF1WEb6zN+1afPNBRQFzm35QwzxgdUftfI/ChJsklcWmYRc
         uU9GhOPTUSKvfDjT9aYtlwh+F6Or7+4yV4IfpG7ccggzrhdigMA03OptySK9VnjaJ+nf
         VHEnnKUkpeQSduuz3+uLDYS0OtyNNwQREfO1s+p2QATbRti4i3X4TrxAedwMbhmuF0yC
         wYRIf7wwat5sOig7suBgoKbEmI90MhYVoe9tMmG1+838XnV6gs7fwvqZ2kf3Glmn8tdo
         6rhXcoCLRZQVDx/V4La8ZynWOcjhYZ5fCgNnhKeXssniYgIE9yzXW8bVG2YE6+2kwKd1
         7JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361048; x=1711965848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBh/o5m6dd9oNmfjtpvQfXgCJqAsfnjpIKpx8z60vmU=;
        b=hsgFMa+qI5f5ayDWY7wN98OCMkCd4r+w7nC+588Y88/8oV9KJ0rNIdgAuMTGzZNOof
         RAsGZZ5IXzweAEDlHToAHzcedM8R+CaNgZWdp+2B3z5/ePuGiAR2uiofuOPb/dMj6i2B
         8MX40BQiyxcw6/D7PhrQIxjoo4/SjTX+ivo3cuDJj+t9+qlYmqeUa43gIh8V2GM/rRMp
         DScDdnmiPtE81x82AAlS/920ljtUN4VMzC45kkqtmziUDb7bqJ03mwY79fBQ5RMZU/fn
         O/kITg4QdUCIRAyNr10gyq7xPEfe6ic2iwdede/dFXyNth3aB1Lf+7UxAUs4rOWqqvwb
         Ez9w==
X-Forwarded-Encrypted: i=1; AJvYcCXuyI4leFvLJ6qkV2IzWV8dX3Jf9w54H3WDfBXLCDJhNKkSKPJfN19RJ6t6gROoIoHuZlPWaT9Gfew6kLdx7SbuIgSLrx2uTFvMnOPK
X-Gm-Message-State: AOJu0YxGvDtBQGLyqYlKI1BBNtT4FV2AxxLJe7tuJYJJ1Eod55f0yuw6
	/WGLm4aYZ8iRmoksHy9kNKYJkAwlydH5auL4y6M+6gl/M6HL1Ty0MCdcqGqVpAU=
X-Google-Smtp-Source: AGHT+IFDAvbnwfO3vxkVXDkPeRQRMfrgnNOP6fhuZPWvolTxNjZRaR5F1AHlxJ1vqOjqlgTRsxuItA==
X-Received: by 2002:adf:e505:0:b0:33e:cbec:e98 with SMTP id j5-20020adfe505000000b0033ecbec0e98mr5502602wrm.13.1711361048027;
        Mon, 25 Mar 2024 03:04:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id dv13-20020a0560000d8d00b0033e25c39ac3sm9086874wrb.80.2024.03.25.03.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:04:07 -0700 (PDT)
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
Subject: [PATCH v9 03/13] firmware: qcom: scm: smc: switch to using the SCM allocator
Date: Mon, 25 Mar 2024 11:03:49 +0100
Message-Id: <20240325100359.17001-4-brgl@bgdev.pl>
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

We need to allocate, map and pass a buffer to the trustzone if we have
more than 4 arguments for a given SCM call. Let's use the new TrustZone
allocator for that memory and shrink the code in process.

As this code lives in a different compilation unit than the rest of the
SCM code, we need to provide a helper in the form of
qcom_scm_get_tzmem_pool() that allows the SMC low-level routines to
access the SCM memory pool.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm-smc.c | 30 ++++++++--------------------
 drivers/firmware/qcom/qcom_scm.c     |  5 +++++
 drivers/firmware/qcom/qcom_scm.h     |  3 +++
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 16cf88acfa8e..dca5f3f1883b 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -9,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/qcom_tzmem.h>
 #include <linux/arm-smccc.h>
 #include <linux/dma-mapping.h>
 
@@ -150,11 +152,10 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		   enum qcom_scm_convention qcom_convention,
 		   struct qcom_scm_res *res, bool atomic)
 {
+	struct qcom_tzmem_pool *mempool = qcom_scm_get_tzmem_pool();
 	int arglen = desc->arginfo & 0xf;
 	int i, ret;
-	dma_addr_t args_phys = 0;
-	void *args_virt = NULL;
-	size_t alloc_len;
+	void *args_virt __free(qcom_tzmem) = NULL;
 	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
 	u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
 	u32 qcom_smccc_convention = (qcom_convention == SMC_CONVENTION_ARM_32) ?
@@ -172,9 +173,9 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 		smc.args[i + SCM_SMC_FIRST_REG_IDX] = desc->args[i];
 
 	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
-		alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
-		args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
-
+		args_virt = qcom_tzmem_alloc(mempool,
+					     SCM_SMC_N_EXT_ARGS * sizeof(u64),
+					     flag);
 		if (!args_virt)
 			return -ENOMEM;
 
@@ -192,25 +193,10 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 						      SCM_SMC_FIRST_EXT_IDX]);
 		}
 
-		args_phys = dma_map_single(dev, args_virt, alloc_len,
-					   DMA_TO_DEVICE);
-
-		if (dma_mapping_error(dev, args_phys)) {
-			kfree(args_virt);
-			return -ENOMEM;
-		}
-
-		smc.args[SCM_SMC_LAST_REG_IDX] = args_phys;
+		smc.args[SCM_SMC_LAST_REG_IDX] = qcom_tzmem_to_phys(args_virt);
 	}
 
-	/* ret error check follows after args_virt cleanup*/
 	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
-
-	if (args_virt) {
-		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
-		kfree(args_virt);
-	}
-
 	if (ret)
 		return ret;
 
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index ebb1141f8be4..21c22d306aac 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -198,6 +198,11 @@ static void qcom_scm_bw_disable(void)
 enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
 static DEFINE_SPINLOCK(scm_query_lock);
 
+struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void)
+{
+	return __scm->mempool;
+}
+
 static enum qcom_scm_convention __get_convention(void)
 {
 	unsigned long flags;
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 4532907e8489..aa7d06939f8e 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -5,6 +5,7 @@
 #define __QCOM_SCM_INT_H
 
 struct device;
+struct qcom_tzmem_pool;
 
 enum qcom_scm_convention {
 	SMC_CONVENTION_UNKNOWN,
@@ -78,6 +79,8 @@ int scm_legacy_call_atomic(struct device *dev, const struct qcom_scm_desc *desc,
 int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 		    struct qcom_scm_res *res);
 
+struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
+
 #define QCOM_SCM_SVC_BOOT		0x01
 #define QCOM_SCM_BOOT_SET_ADDR		0x01
 #define QCOM_SCM_BOOT_TERMINATE_PC	0x02
-- 
2.40.1


