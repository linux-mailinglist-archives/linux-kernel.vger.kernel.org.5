Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B697CBF36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343728AbjJQJ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjJQJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793AFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:50 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5071165d5so40889381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534868; x=1698139668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMI+v5JGEkAeGE6amxnpwA2cqSf6wNCzc4JGdgBy3X4=;
        b=KAkp/MwwI/V2bscZGIksbdbyL+N+COCdQ45SHryXFt1iAyrerswS8GPl6EWr8XlUAI
         /Otkw44x9v+fGQ4ix3bbqG/VIOW/kpC7YeN6QYXwgbCP3QpV9+BF0kl95KHh/KRtextt
         ypPQlgWq8WBSDnViP7cXaeE91ksia0yzRsADGJr2NBQ/NpqjcdkouD/jpiamsB++cXLi
         01SB3xgyUSX8A+apj2O5q9mBvyIsm5j+kz/Q/r6MjgZgHF/m/bdEP7K9kO8REBe4l2bR
         TWXKX0TZHU/6Ox2bub3PKCabyrpLKBTsKw9f6yfPpKKE/lFODRZ3Mv/j/NquZTUECBoE
         UCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534868; x=1698139668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMI+v5JGEkAeGE6amxnpwA2cqSf6wNCzc4JGdgBy3X4=;
        b=gFO/sJyjrHnAEq1VUShFRNecrrRKB4NOQQ3KXCMe0j/lzR8oR7CtHwP5ux22v6Wt/D
         Cw+udXrx/5hQ4nfPO5mZ/dFdssMVkP1fr5pDIJYDxlF0YTNJv0dEt9+UuGCjPSmDMzxV
         yNxGHMggz/bWLiuIlMN5jwPVaII56SCqzoCufX3OezoSGixawDgYo2ekNNI/532jdry6
         nXWQKuV431M3FS0Im3XuMaBxKSYCsYzMffuHpmyt6qjL4c52O8k8nBr9AsBjSPdyhJTO
         UEMO6NiB0Zpjz8eiVDnzYR6k7kqotvUhfYDivdLGm1DaNW2UGPiAdmYooKuc0oqBmWVq
         RdQQ==
X-Gm-Message-State: AOJu0YyLJe64ZEr0uJDKF956A16eM34F622ukm+gVJ/E5Ag5rN71gs4y
        4LxrswPEgqmOt6x4zCJwMwGPzA==
X-Google-Smtp-Source: AGHT+IHNNereFp3sYYFj5YQWzN8ujHjmEFC1efFd1F3L5LClgjZ/rCYZ7GPiGczXfXxmwm2eWJN4pQ==
X-Received: by 2002:a2e:920b:0:b0:2c5:aff:f936 with SMTP id k11-20020a2e920b000000b002c50afff936mr1161859ljg.53.1697534868374;
        Tue, 17 Oct 2023 02:27:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:47 -0700 (PDT)
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
Subject: [PATCH v5 09/15] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date:   Tue, 17 Oct 2023 11:27:26 +0200
Message-Id: <20231017092732.19983-10-brgl@bgdev.pl>
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
2.39.2

