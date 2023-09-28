Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C47B1727
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjI1JVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjI1JVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB261195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4053cf48670so116703465e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892863; x=1696497663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhvnh9OE997tswH9jSZ8GJnXlXkzgsgO3a5Q/DPonFc=;
        b=rvFi8Fj8kRtdFRgW6wXh3179g3cMjGHxkNRoATwjwng8kbLqBx+JJNNqzjHt0P0LBB
         cV8mMkePJka1Ib6SlbVlRclzX+34BIys67X1FehYJvuImv22zkPim20wNH3clLSqEELt
         51YP9pbaIPwLxcSSwvclA/Zom94D/6FMkFyW0yafwHDipLaMHnYsF6qyPup+e8oBcfal
         dZ2zncJxXDll7AM+bSwoFOSXfQTzRfWjS7ryOtECZ4ogFBw4YemmBbeUvJy4C0ZnPFXb
         EoFUXb52iPkCO80aL6shXYYREAadXUpFzn3nJCJpetwa8IJNgOgkRozOI8hCxUxJIi33
         G6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892863; x=1696497663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhvnh9OE997tswH9jSZ8GJnXlXkzgsgO3a5Q/DPonFc=;
        b=t5sJf/hyuYJTAg4EvHSk/L3qZYV/jG9t8nBQBIUMlvgKBAZJ/tPCh3Fr6tg9KECpYG
         VGR3WHQtBt72LxiPbhsGAzLzAIeC/je3B4EoAEJq4TCKnyIweIhKveRueA8kAU5fzNOD
         y3yTWtx/Xb7ybgVzFOGPfRCv04/BwfqnOFvQaAR40zD4WFpyWST8kf69F0K0fHi9FUg+
         fN9zQjMS2ANDclsjmQc3jA0z+nHDppMDwTTfNpxUPw5ODHJXNwivNvEcnBro8W2TrI0X
         zxeeeUVoUPOW0ffIzVounswlqO4y4b5z2fRGwZernMbV4pLV+ffzQjsuQIbWhqAOWnKr
         10pQ==
X-Gm-Message-State: AOJu0YycpN5ZgB8xgnYZhfAsSku+z/64Q4W+UNb3QFbaAqSrt0w73Mqt
        dgVZoubVEBz/rrzjCspYn09PwA==
X-Google-Smtp-Source: AGHT+IGQyggTMr9G3lck9DdE2/M/2/aJTExkk54GkglOS8vF8v+T6QNbn/6+dVleA/C2S/3U7G2ykQ==
X-Received: by 2002:a5d:414e:0:b0:320:1d1:71c4 with SMTP id c14-20020a5d414e000000b0032001d171c4mr646792wrq.23.1695892863407;
        Thu, 28 Sep 2023 02:21:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 03/11] firmware: qcom: scm: switch to using the SCM allocator
Date:   Thu, 28 Sep 2023 11:20:32 +0200
Message-Id: <20230928092040.9420-4-brgl@bgdev.pl>
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

We need to allocate, map and pass a buffer to the trustzone if we have
more than 4 arguments for a given SCM calls. Let's use the new SCM
allocator for that memory and shrink the code in process.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm-smc.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 16cf88acfa8e..0d5554df1321 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -152,8 +153,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 {
 	int arglen = desc->arginfo & 0xf;
 	int i, ret;
-	dma_addr_t args_phys = 0;
-	void *args_virt = NULL;
+	void *args_virt __free(qcom_scm_mem) = NULL;
 	size_t alloc_len;
 	gfp_t flag = atomic ? GFP_ATOMIC : GFP_KERNEL;
 	u32 smccc_call_type = atomic ? ARM_SMCCC_FAST_CALL : ARM_SMCCC_STD_CALL;
@@ -173,7 +173,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 
 	if (unlikely(arglen > SCM_SMC_N_REG_ARGS)) {
 		alloc_len = SCM_SMC_N_EXT_ARGS * sizeof(u64);
-		args_virt = kzalloc(PAGE_ALIGN(alloc_len), flag);
+		args_virt = qcom_scm_mem_alloc(PAGE_ALIGN(alloc_len), flag);
 
 		if (!args_virt)
 			return -ENOMEM;
@@ -192,25 +192,12 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
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
+		smc.args[SCM_SMC_LAST_REG_IDX] = qcom_scm_mem_to_phys(args_virt);
 	}
 
 	/* ret error check follows after args_virt cleanup*/
 	ret = __scm_smc_do(dev, &smc, &smc_res, atomic);
 
-	if (args_virt) {
-		dma_unmap_single(dev, args_phys, alloc_len, DMA_TO_DEVICE);
-		kfree(args_virt);
-	}
-
 	if (ret)
 		return ret;
 
-- 
2.39.2

