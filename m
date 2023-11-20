Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAB7F1440
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjKTNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjKTNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:21:36 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EBA129
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:32 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5071165d5so54159071fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700486490; x=1701091290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVNRTBYkQ35refPua6fnWM3rCBTplvWDVxVAY6Q7+Wo=;
        b=06ENAWdGBeAnHR+lsgGj3XxK1mVXckIWesjfGY03ucUnLrKvBVCmCXeUj03l5U6Bsr
         2wrMSsw3b6YS28rOb8dtzwWyU0G5wk3pTEnHNEa4C4bdvUa01vw9VuiVMMPWu3NiUYdk
         JRgtARoc/sQySnlRXNVJ+icaCx3v5btjtWnnlhCx/48PXElyKNTqWuT0ruYE+YdK86ns
         woEV9DNr+n5jgSDunn847w3QFWDnBF+s7ngYAEh4BROGviCkN26SEVJSRpdACoi/sLY6
         R4PSQ1YFqcYL3u/4MfFF8SUmL96lnKlp9Jdjt/4ZPa+WC1kUQLyOUWHgObcFEERe8iWl
         zXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486490; x=1701091290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVNRTBYkQ35refPua6fnWM3rCBTplvWDVxVAY6Q7+Wo=;
        b=h5LhxhBu0Q0sbjsmRbDjQ9JdNO5XIzuTK/0GRhIW4ArhAhVmAYd5X8dciEe0PDQY3I
         ccb71OPWSc08W1y37BWvbi3mT+GcySaTnC+wcZca0qMV7TFqOUDD9Kaus0hVMYL09CRa
         e9QwyRfxTKiBfX7Qk3SywqQbGtF7OmpotwO7jNM32ALvT3IGBdu6gtafTdiTrF6FftGK
         viRnCEuqC7x3o/7CWi0rfSUbyQldgTOJ0zPAueJtoaMSGxATEkUSffwVl+y/oq6KzwCB
         2qUz4XZzM8QbXFnSvlmU8qobW321Uz9qgXiN4+Tg5oxgPu6wF7GFCxZMTHLFwKbqfE93
         KsyQ==
X-Gm-Message-State: AOJu0YyTOU7Cn2g+u7FiGb0AhCfpUxzl4y2woafquj6ohH4/IQpMXCqc
        Yn7gf+/PKGrp2ABj378iDQ50Mg==
X-Google-Smtp-Source: AGHT+IGZVi5PIyt/naysMy/l3CCxHilzq5RzodgjAfHGRQrkpAQX3VzFLsaHZFvcAI1N+W9PdBBvUg==
X-Received: by 2002:a2e:5314:0:b0:2c2:8efd:a52b with SMTP id h20-20020a2e5314000000b002c28efda52bmr4357960ljb.36.1700486490289;
        Mon, 20 Nov 2023 05:21:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c590:a7ce:883:eba3])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b004065e235417sm17329192wmr.21.2023.11.20.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:21:29 -0800 (PST)
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
Subject: [RESEND PATCH v5 06/12] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date:   Mon, 20 Nov 2023 14:21:12 +0100
Message-Id: <20231120132118.30473-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120132118.30473-1-brgl@bgdev.pl>
References: <20231120132118.30473-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
---
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 31071a714cf1..11638daa2fe5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
 {
-	dma_addr_t payload_phys;
-	u32 *payload_buf;
 	int ret, payload_size = 5 * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
@@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       payload_size,
+							       GFP_KERNEL);
 	if (!payload_buf)
 		return -ENOMEM;
 
@@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[3] = 1;
 	payload_buf[4] = payload_val;
 
-	desc.args[0] = payload_phys;
+	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
-	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
-- 
2.40.1

