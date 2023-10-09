Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52E7BE4E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376992AbjJIPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377547AbjJIPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:34:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E4E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:34:50 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32615eaa312so4296247f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696865688; x=1697470488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVGoERFE3fa+HCgKC7RA440wyH71tSjIV08rhDsASMw=;
        b=X7vybApTRgCjfCDK1DL3z+8qOfAjmQpAea0AsTSC8GuBNiPjdoTrzjNj+vs1ShvKXC
         Z0o0txg24FT4aWBJs25b5vjNz+cTf/PrSCVZHqW/Gba8NnPeb5VpV3sGtXZhhdlgQU8H
         P8B7ybdSFjIzd5Au4zeMb4CN/TvsYV/7YXmX+JXSxhvCnNHQ2f2+lLQ2FYPBsdOteSua
         sOeo62NmHZ7BP1wYBLjReVfVDGSzp56yVPp8bab0wc//K7NsHhw9wQ0tmwH7RNN5hMPN
         RiHxoS2AG1owiRRTsQv1PETs3vx6OCFbhVZwdZ0c/y0Q39zpupaXbfu/8W8GzqiY1qoM
         wuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865688; x=1697470488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVGoERFE3fa+HCgKC7RA440wyH71tSjIV08rhDsASMw=;
        b=ZpWg569oHXyt5BL8k2VXoE9ALR8FqPclF5lxyMCFyAWfIUOWt3X+oCEwRY/rIRc2Le
         IIa6+sEyO3GQDHwyKSuxNOlzvudLWAdS7FGcMKTx1R5ERBff0mYWZxKr57MGT1iqnuZI
         1TTUrLpz28b6L7HHDNNhsyE/OunoBnmhZ2zrYr3bmNsHp3ryN2FVEA+AkaQip+0Ty3k4
         79uqvvIJ7KH9N77+5+GTEAlb/ePTiw6xXMSZiuOzsd8Bvc5Tgnhff6wzsg7uF7oeqES0
         0vRSHXjToy0WQDuD2pCGwt8H4ScbNk/zAvCp0jFOESfB8y/NoT9TzENEAwRUY5UC9UTu
         ckfg==
X-Gm-Message-State: AOJu0YwnPQaFmCW78qHT08y+75YvLd3Qh+TL5tXjojeR9RHwjXleMO8x
        rVkGa7F315tOyvRMcu9giBYn5g==
X-Google-Smtp-Source: AGHT+IGmR2OVbb8Xjr+DkHBylNE3rUpt0NZEh1/jquLYFhGjN/bGj4/O5LQWquHImkG2t/Wp9xDlbw==
X-Received: by 2002:adf:e6ce:0:b0:31f:b7b2:d4e1 with SMTP id y14-20020adfe6ce000000b0031fb7b2d4e1mr13710904wrm.20.1696865688018;
        Mon, 09 Oct 2023 08:34:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f20d:2959:7545:e99f])
        by smtp.gmail.com with ESMTPSA id b3-20020adff243000000b0031431fb40fasm10016521wrp.89.2023.10.09.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:34:47 -0700 (PDT)
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
Subject: [PATCH v3 07/15] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date:   Mon,  9 Oct 2023 17:34:19 +0200
Message-Id: <20231009153427.20951-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009153427.20951-1-brgl@bgdev.pl>
References: <20231009153427.20951-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

