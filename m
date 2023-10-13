Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DBD7C84FD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjJMLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjJMLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724F103
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40666aa674fso20736975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197745; x=1697802545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGMo0XfPtT2eoS0TClJYKLLiBxw0PNFjU9Xb0WM0Oqk=;
        b=qNm9zAkbBPZhVbbY+7nTBnQcoLTa/cwAGiZxGsgQ2hkTfSNyEJHTUbupX4doSrNq1w
         yNycH5tKvQt6iAB3eGSSPWhNJJsF8RGwLm2D6aIR5ZAeYG3VYELuesz6+JAjQJqXMTvj
         u5wtmBVgC5grAsG5/ux4A2A0G63IKDgbc1S2vGezMoG54khejdL7bv65hXNtFRObWCfB
         niuLekQM+7hEoxeXw7CmAFiSE+9/D/MxUvq7nonRn4Yv251zvJWRCo7TUXB7LrIihveH
         3x7iRXL+/c9Y+IozENScRa8jcVqi6TBEJws6XLXV6Fw3dCT8/ruyV9IKizMxRWv/j289
         B3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197745; x=1697802545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGMo0XfPtT2eoS0TClJYKLLiBxw0PNFjU9Xb0WM0Oqk=;
        b=aUWEOENEDfH5CWyiqbjZhAPxtKt5czYzssTPiGKd9U7QAplzm+MnJzdFTN0aqyGV24
         bND5FO7jsICHlVWigCkQa1DEIprK8kGXAAobXn2BBgWDtZnw09yZTXN1MX+r68s62l9L
         uhs95q7k+PAslzl9LJI8aoD5EfaluDX8tjuYaExf9XcNQmVVhv38BwpWrhPZ46DfCtjr
         MDmCs5rObi3C1eb7Hf8CLX3iJ7HhNCVNxfRGSgIKZ2rRfCeL5Kd9GE6xr3HYFxZ3aoIS
         WeLmCabW+huzDGSJCXjXO9hCvRi3RL0e3x17vAWmQHwcMm1fWs0ekVeXC6bUIRZ/SO8u
         B0UA==
X-Gm-Message-State: AOJu0YwiO24eZXw3txsy1ThBCf4siUkkc7kwh32EiaNNngZU9MjmZLbS
        acHrsrqWCSI2dn/Q5Z0vOZWT/Q==
X-Google-Smtp-Source: AGHT+IHL+JnqG9VRTnC2qee6NXKNNw4sjMUhEXf9wZ+4bLiyAwulp1PRme4XW3GsjZXweellxZf2mg==
X-Received: by 2002:a05:600c:2146:b0:401:daf2:2735 with SMTP id v6-20020a05600c214600b00401daf22735mr22506011wml.31.1697197745234;
        Fri, 13 Oct 2023 04:49:05 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:49:04 -0700 (PDT)
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
Subject: [PATCH v4 12/15] firmware: qcom: scm: add support for SHM bridge operations
Date:   Fri, 13 Oct 2023 13:48:40 +0200
Message-Id: <20231013114843.63205-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
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

Add low-level primitives for enabling SHM bridge support as well as
creating and destroying SHM bridge pools to qcom-scm.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 60 ++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |  3 ++
 include/linux/firmware/qcom/qcom_scm.h |  6 +++
 3 files changed, 69 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 318d7d398e5f..839773270a21 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1323,6 +1323,66 @@ bool qcom_scm_lmh_dcvsh_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
 
+int qcom_scm_shm_bridge_enable(void)
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
+EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
+
+int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
+			       u64 ns_vmids, u64 *handle)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRIDGE_CREATE,
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
+	if (handle && !ret)
+		*handle = res.result[1];
+
+	return ret ?: res.result[0];
+}
+EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_create);
+
+int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRIDGE_DELETE,
+		.owner = ARM_SMCCC_OWNER_SIP,
+		.args[0] = handle,
+		.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL),
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_delete);
+
 int qcom_scm_lmh_profile_change(u32 profile_id)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index aa7d06939f8e..cb7273aa0a5e 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -116,6 +116,9 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
 #define QCOM_SCM_MP_VIDEO_VAR			0x08
 #define QCOM_SCM_MP_ASSIGN			0x16
+#define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
+#define QCOM_SCM_MP_SHM_BRIDGE_DELETE		0x1d
+#define QCOM_SCM_MP_SHM_BRIDGE_CREATE		0x1e
 
 #define QCOM_SCM_SVC_OCMEM		0x0f
 #define QCOM_SCM_OCMEM_LOCK_CMD		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index ccaf28846054..9b6054813f59 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -115,6 +115,12 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 int qcom_scm_lmh_profile_change(u32 profile_id);
 bool qcom_scm_lmh_dcvsh_available(void);
 
+int qcom_scm_shm_bridge_enable(void);
+int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
+			       u64 ns_vmids, u64 *handle);
+int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle);
+
 #ifdef CONFIG_QCOM_QSEECOM
 
 int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);
-- 
2.39.2

