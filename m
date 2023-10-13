Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91E7C84EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjJMLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjJMLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44787BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40572aeb673so21336285e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197739; x=1697802539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV1cLbdTk/GE2Km4ovXWtuC2kb2GNoS6blKXRgh+nGM=;
        b=JIoef3sS+L2OYH7a3A8dB3I83w/96L9XaQ9M3/x8/7TgSCWCcTmicpB8gM3J5gOqbC
         mOnfd5fdrBgjDup/Sh5/JdbVdQJ3/GLgz8dkc6AvsOwMoUpVKZ6N3S7GAXWXId4YRGoe
         UQbbIpVJt37S1b1g3kLrWL73hqwXNxMG+5QZF2TGwcDwTN2iKcHsueIbmSYrMz/MEMqU
         ZQGR8r8Z3BlhyqpeKXPfn9rYNwuZS4q9Yfxtk4IPTsrYx3DTp5+xQNMTuxTJU0xvynZc
         yZjSiMGEAvT3fY78HKY6MOzhmTPBgoJllZi8+crMbztVN3Cu6nXXC2DFN6EeoA8xZAkm
         TGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197739; x=1697802539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bV1cLbdTk/GE2Km4ovXWtuC2kb2GNoS6blKXRgh+nGM=;
        b=ji8eWmhWChKi4gClykGCZ1+DNqlqm1JibPyfNE8q+SiIhl4KPRs8yk3oK3xVm9rs0o
         RMyKAVFNo7UwPy7n42CaWzWIWJJBxkN0a6t/K0OBDXiOTJ0l78R2NQjyxh5AWqfRSz0/
         +ZXtm3fT4c8xgSRiof2QEk4CijHYzUIr/cD0DOz/lL5zL/e7jbHj5+HEsnKmd10U2kn7
         m815XmDaIlMluEY+frUgbLWJAL1q/bX4GpmJg5YRbKWenyf2i6VkvoiTRnOKdo+e4OFe
         F/FwhOzq+KxUOOQO2kzASZe4o+N3KTCq+d42Ul7BG7zwTiG/ov0A/s7qIHUr9cQLxixo
         a1Cg==
X-Gm-Message-State: AOJu0Yw/m2d2arYwcBlqZyuoqvlDYDoVFeVE/RXCgF31p6dbvwYu85/F
        VpZjvMYfCOaM71PsPKxUsGxfLA==
X-Google-Smtp-Source: AGHT+IF3Nc8zH3sJY1OaHMo2jowvbl+hoUS1tU4HC3QwtdngqoGeSR6CToOVOsJr2nxuoMDYK/6OdA==
X-Received: by 2002:a05:600c:2197:b0:406:5227:86f0 with SMTP id e23-20020a05600c219700b00406522786f0mr22042117wme.5.1697197739744;
        Fri, 13 Oct 2023 04:48:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:48:59 -0700 (PDT)
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
Subject: [PATCH v4 07/15] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date:   Fri, 13 Oct 2023 13:48:35 +0200
Message-Id: <20231013114843.63205-8-brgl@bgdev.pl>
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

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/firmware/qcom/qcom_scm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 71e98b666391..754f6056b99f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -998,14 +999,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	struct qcom_scm_mem_map_info *mem_to_map;
 	phys_addr_t mem_to_map_phys;
 	phys_addr_t dest_phys;
-	dma_addr_t ptr_phys;
+	phys_addr_t ptr_phys;
 	size_t mem_to_map_sz;
 	size_t dest_sz;
 	size_t src_sz;
 	size_t ptr_sz;
 	int next_vm;
 	__le32 *src;
-	void *ptr;
 	int ret, i, b;
 	u64 srcvm_bits = *srcvm;
 
@@ -1015,10 +1015,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
 			ALIGN(dest_sz, SZ_64);
 
-	ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
+	void *ptr __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							ptr_sz, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
+	ptr_phys = qcom_tzmem_to_phys(ptr);
+
 	/* Fill source vmid detail */
 	src = ptr;
 	i = 0;
@@ -1047,7 +1050,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 
 	ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
 				    ptr_phys, src_sz, dest_phys, dest_sz);
-	dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
 	if (ret) {
 		dev_err(__scm->dev,
 			"Assign memory protection call failed %d\n", ret);
-- 
2.39.2

