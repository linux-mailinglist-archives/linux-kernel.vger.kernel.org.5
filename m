Return-Path: <linux-kernel+bounces-53222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF384A252
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A4287FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3A4F882;
	Mon,  5 Feb 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KkunZihV"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FDC482F4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157706; cv=none; b=ZXOAH++9KrjFxPhGLkWPlgfS472DA1Wjpw3O2xe60dlKlJ01AnhIT0Sf3TkcAo7VDwifngy+aTRm5u1aohpy485ApYMRhY63WcdbGAJTEcf6BJ0o0M7OkxoEl0JJZYSLodw6caoTATCcOJEkS4nfa6sMc3/yCfby+9hqCBb1PgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157706; c=relaxed/simple;
	bh=ZpGV2VJFHUgG8JkEU54hepfIDRO8lwBoWxz2kXXXit4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSKF0jMDhTu+BqLO2G78HQYHBhC4ulcfnbZeUDnydIP6JxC+zaDNXm+5t+o/lXPOryPnz6wlWH9WVE90IYiBjvyo8G0KKp32DUbUfaWIhBeixZsfDPgxkXYhzn/sYFK7rboDal/iuis6NyY5i2GreWu4jm/cCoA3B6PUTOBa24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KkunZihV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso704340f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707157703; x=1707762503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4erhe8goMZDE7TLr/dsCJoHJXktIjwgA8fkMwhmJPgI=;
        b=KkunZihVuKPzojuPy4YgwgC8b3n//WsyS+YDc55z8woC2ZNLs5Mi3eRDnjhwM+sBks
         SoGU1js6n5LvNHWO4lRw78KzTMUJMcZW14/MI18KOlGP0X+JoSQay1B9C88stm2v8/mx
         UELFlxRYRR5be0IV2XXDC3J4uRBKbM6XhJvmk1P2Huuo9fPwtCwDqz2QleF3bG8In5g0
         Uxc1qx8OwwjvNcjwc9zM8nHh2j6ZPWvuvcx97EN7J8+X7WO3uS8O3bGoskFp30GrBn1x
         1K3FrU1GUO9IBQb3eLR0wgOhnjV/mlXu6VqX69cwNLIlxK9XHYU7qQq65DkMQcVvrXI3
         I/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157703; x=1707762503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4erhe8goMZDE7TLr/dsCJoHJXktIjwgA8fkMwhmJPgI=;
        b=aCAoc2eZ5rKToUdIAtqE0BIXYNZor8YQyRGqXeZ0qhL3KEjt3peL/eFK7PjoQlCQf8
         EpBx3FsrItNhSNaBirSuepv/jWwNsrzPJXYOkpPR2MQ1eb+vb4VJacZmVbZGQj9NY4X5
         CrcViNP3DNjn+yt0Tt51d5mNeG5Ty5UZ2mG2mPaZNK0sWLMFAV2XpVe+oXNm9fVdWcxo
         FEMLWOc1O/wrTPEXHChssPw50IKZrrFQQvHl1Kjvrpj4IHhWbN1iPgf9iXmCCXicY2TS
         ouRpfUn2Ii4bQMTZkYU0loZS+1AhR7vuDzir6NzrtznaIm4O25oeE/IgzZ1zCU/8C+H4
         WHMQ==
X-Gm-Message-State: AOJu0YwCZXXqtxCrVxFis9jScz1/R5camHYnWMMIhVmfaUfV4s16bGHG
	nK/rgcIpQ01gxgXpm3RsUIX810O67aOiZmYuO8/QZsCrYZYLP8G3bfhP2gY5UTY=
X-Google-Smtp-Source: AGHT+IGKP5WP3LJxKwWq8VqGtQqQKQUIgUbNeqbbetBbxeSkGGTeDvm/kta8S7D9mdz8FJyEy4JUKw==
X-Received: by 2002:a5d:64c5:0:b0:33a:ef2c:7a4e with SMTP id f5-20020a5d64c5000000b0033aef2c7a4emr309426wri.49.1707157702951;
        Mon, 05 Feb 2024 10:28:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5Hkb2S7GtTbqOeCv8VPamd8tigkjXeJLcSVnraO2i6DUO3BkAxNh5YYC4cLU3LB7hW+DYQeg44+UnkN7OyISbJo4tImjcnkcMmPfon1Gi/gBmb6sYt+QQ7Vc8PLWFVO39pgcfAUu5kRjAXL4J5wn2vgn3OPSq9h78DqcUqZ2RNdjNxfNBOMV7AJU0rmel2hwrnAOw0peESkcb2IRieTc1+sof7qvYavDVGH7QRzjLJcFaFGdFLbDRR3/oAtTGUFm+eXK1EVG6dIOVJAAlncaF5wtrj37idXzBBd7IK3ZIsJPfw2UgxM9tsBdurZq7pnAgpTtIw/aVD7QeI4vvq9BPriDsyXAzKriDSMklveN9tlNG7UP5qivbfRHfvCjFYzBvfyLq6pdghmWEGDLzbjyL1k5DxT6pKXoM6hBDEjOE6RXO6iUSSJu+rGnLFfQuuIKF3ZGf0JMCwijiI8w3Ubqz7VKKm0xARYEQs4Sw72/+k2I+taF8ZCmv9glhg5ji1T7+futsqwTLLfHPFwul3+lR9bMzn/KzbOeM++n+NaqIyN2bbVJQ3Ts5eWIo/ucq7FI=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0033b17e18df8sm203229wru.12.2024.02.05.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:28:22 -0800 (PST)
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
Subject: [PATCH v7 03/12] firmware: qcom: scm: smc: switch to using the SCM allocator
Date: Mon,  5 Feb 2024 19:28:01 +0100
Message-Id: <20240205182810.58382-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>
References: <20240205182810.58382-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.40.1


