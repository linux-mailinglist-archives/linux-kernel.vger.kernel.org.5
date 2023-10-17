Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABB67CBF30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbjJQJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjJQJ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4060b623e64so34088685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534864; x=1698139664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1CbllhVp2OW4IWOAZO20mv5yal3Ji0MpQSHQu6sgzM=;
        b=bwCv7fatG2+G3hMVd1EB6ccB9mn9r0OMqipKaE4i2aNidGqdQxXDmmsATrureukR2Z
         pHaZc5bLWBX7PGYj14OZNYO4jgPcXT4WgMDprdJozjdHubw+CaqhpgBZK4P5KCQIEvqB
         V3viJD1o9ItVt54BPFWGZHI0eVBJjYOdBWiBhlvXwC+293ju4DcOUOiKXeZ7tJKa9POZ
         1tlusJC3ZKxt2p1O5PVJNcnQnpGHCEkA1EeKD+uT0j731xykQtmwZePX9MwVlFhDoJZ3
         ouaLyR1GGIngtyeVjfT8wEFyuvchL3eL778D5kebZ4iBgSNVpSWGzDfCMyF4F28e1Zwj
         0N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534864; x=1698139664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1CbllhVp2OW4IWOAZO20mv5yal3Ji0MpQSHQu6sgzM=;
        b=DOGqQdZGU/z1KjnFxiTs6kV99ap+uxQLGA6di/GoydKrNZYczV1P36s6B+ruFr5Qnr
         YbryzfBMdUIgsvay3aUpf0Hst+fOS9sC6oaxgOKYNBoHSMe77rmS92HsvgJbyHo0xBH/
         J9Yrsn45vb42vufHbKrSTdUavh2pLwbjhioy3VYtKl/xUCk/r9RgqWv0oJLxKj8J5rRB
         KpRyGmpf15dqDg9ahGOpoiIWw4JflR6jwOO4kyunhFK35icSbYKGeymdrPTt8w5i7vGl
         +7nZle5GVD1VE1/GQ7ZfUB8zGZch8MkSGcdSlXwEGQSVybtsmI+cDYuwfnyPDTkNgQqS
         Rlsw==
X-Gm-Message-State: AOJu0YysxhNPDoTQOem+pNI2Io2Efja2RFr5WBv/2Wp7kgC8QU700zCP
        yggw6LSGfDR75S+a2q1K0kXAFA==
X-Google-Smtp-Source: AGHT+IG0saDedMt9qaVolTW9RqgfZdkEhG8Uv+BgnyugI8IQplqRddVmL20mM4432fnzw8E0yAPuyQ==
X-Received: by 2002:a05:600c:4e86:b0:402:ea8c:ea57 with SMTP id f6-20020a05600c4e8600b00402ea8cea57mr1120135wmq.7.1697534864321;
        Tue, 17 Oct 2023 02:27:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:43 -0700 (PDT)
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
Subject: [PATCH v5 06/15] firmware: qcom: scm: smc: switch to using the SCM allocator
Date:   Tue, 17 Oct 2023 11:27:23 +0200
Message-Id: <20231017092732.19983-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017092732.19983-1-brgl@bgdev.pl>
References: <20231017092732.19983-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We need to allocate, map and pass a buffer to the trustzone if we have
more than 4 arguments for a given SCM calls. Let's use the new TrustZone
allocator for that memory and shrink the code in process.

As this code lives in a different compilation unit than the rest of the
SCM code, we need to provide a helper in the form of
qcom_scm_get_tzmem_pool() that allows the SMC low-level routines to
access the SCM memory pool.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
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
index 0d4c028be0c1..71e98b666391 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -201,6 +201,11 @@ static void qcom_scm_bw_disable(void)
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
2.39.2

