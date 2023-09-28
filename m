Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03337B172B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjI1JVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjI1JVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E2193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so93031395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892870; x=1696497670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVQfW/DeQMI23e+YZyvWhEKH7q5MhV/xZYEf73p8CUQ=;
        b=mOnMowzHxOVocJapqlph1HxIsiyxYNQNB8lK7eAHon55nk0uLBATrSiVGY452MsUh+
         6agFX9OJx4UdV4f4drO+0LPr+a9I7WeoEUWYUoUUmzrt/IVP40xUyyr26Z4/Lq4e6Yxe
         BaHemXivf27EXHZwf4rzjLJfvp1OhJxCWU4w9ggNFt0vMKoHdjFAE2VwGuAGkxT+2t5Q
         oiPMINTLglzLl2b9Od1ZV5q+5BewrOh+huB30PPcDm7gB6CABeDc1kMgvDLcOmFuobvV
         L+pMC1jXHxSB9TlY+P4yxLvZ3aXqa72lKOoqG3F7sB88bgueiyNbZYR1xFCH6hbPEdDs
         1qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892870; x=1696497670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVQfW/DeQMI23e+YZyvWhEKH7q5MhV/xZYEf73p8CUQ=;
        b=wjIV9A7A1K3s8UE+LlAPZ0KRqzGzpmaAJzcTGxSsBqMuXtIWun7KENq2x1zI13R+2T
         tsL3pQyqIGw9HJKt+DHPrE2JQv5+P/uaZowqWYfUHemvsTZW4ZfAtDY4DBUooOjsDdTd
         djfqYlC2GKyjw47mRGRraqFMzF10Sodo5SRJihYjC/QoYGPv7LwjeW24dfrlIzHIFxe3
         49wvLJ97F8DC8Wvmc3wLlm/xMXMd/Y2AKrgR8DvhF2ZiuLE9IhajkAHLN50FoaDqyLdj
         mNIqrmXPrWjtxCnUI11tfuduk32h1NVtb0IT1dhefDL4D14AhWxQeLMVmHyhtLAWr8Kl
         lZgQ==
X-Gm-Message-State: AOJu0YzM1596/yBI4YEPoL1u65FpO2kI4FvcXFfCjhqIupxRFhGT3CQC
        nslV8YpfYI1ZEC61TY78qnkJ5Q==
X-Google-Smtp-Source: AGHT+IGnIdQ7yRyr+P4vm1MevwoFHAaWWIkJWJQ3V2SUXU7ZGOwJ4AfaOd/+nsR9l3kYJBUO/oO4hQ==
X-Received: by 2002:a05:6000:10c4:b0:319:77dd:61f9 with SMTP id b4-20020a05600010c400b0031977dd61f9mr632629wrx.35.1695892870380;
        Thu, 28 Sep 2023 02:21:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.09
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
Subject: [PATCH v2 10/11] firmware: qcom-scm: add support for SHM bridge operations
Date:   Thu, 28 Sep 2023 11:20:39 +0200
Message-Id: <20230928092040.9420-11-brgl@bgdev.pl>
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

Add low-level primitives for enabling SHM bridge support, creating SHM
bridge pools and testing the availability of SHM bridges to qcom-scm. We
don't yet provide a way to destroy the bridges as the first user will
not require it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 43 ++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |  2 ++
 include/linux/firmware/qcom/qcom_scm.h |  6 ++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 1fa27c44f472..5969ff0c0beb 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1296,6 +1296,49 @@ bool qcom_scm_lmh_dcvsh_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
 
+int qcom_scm_enable_shm_bridge(void)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRIDGE_ENABLE,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	struct qcom_scm_res res;
+
+	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
+					  QCOM_SCM_MP_SHM_BRIDGE_ENABLE))
+		return -EOPNOTSUPP;
+
+	return qcom_scm_call(__scm->dev, &desc, &res) ?: res.result[0];
+}
+EXPORT_SYMBOL_GPL(qcom_scm_enable_shm_bridge);
+
+int qcom_scm_create_shm_bridge(struct device *dev, u64 pfn_and_ns_perm_flags,
+			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
+			       u64 ns_vmids)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRDIGE_CREATE,
+		.owner = ARM_SMCCC_OWNER_SIP,
+		.args[0] = pfn_and_ns_perm_flags,
+		.args[1] = ipfn_and_s_perm_flags,
+		.args[2] = size_and_flags,
+		.args[3] = ns_vmids,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
+					 QCOM_SCM_VAL, QCOM_SCM_VAL),
+	};
+
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	return ret ?: res.result[0];
+}
+EXPORT_SYMBOL_GPL(qcom_scm_create_shm_bridge);
+
 int qcom_scm_lmh_profile_change(u32 profile_id)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 8c97e3906afa..f5a29bc0f549 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -116,6 +116,8 @@ extern int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 #define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
 #define QCOM_SCM_MP_VIDEO_VAR			0x08
 #define QCOM_SCM_MP_ASSIGN			0x16
+#define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
+#define QCOM_SCM_MP_SHM_BRDIGE_CREATE		0x1e
 
 #define QCOM_SCM_SVC_OCMEM		0x0f
 #define QCOM_SCM_OCMEM_LOCK_CMD		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 291ef8fd21b0..dc26cfd6d011 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -6,6 +6,7 @@
 #define __QCOM_SCM_H
 
 #include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/types.h>
@@ -122,6 +123,11 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 int qcom_scm_lmh_profile_change(u32 profile_id);
 bool qcom_scm_lmh_dcvsh_available(void);
 
+int qcom_scm_enable_shm_bridge(void);
+int qcom_scm_create_shm_bridge(struct device *dev, u64 pfn_and_ns_perm_flags,
+			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
+			       u64 ns_vmids);
+
 #ifdef CONFIG_QCOM_QSEECOM
 
 int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
-- 
2.39.2

