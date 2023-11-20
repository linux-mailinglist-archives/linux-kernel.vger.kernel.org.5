Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC67F143A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjKTNVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjKTNVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:21:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7877194
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40a48775c58so17078675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700486488; x=1701091288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3T+Nz29XwJpeLbYrWkBbO8epnldil1IzN2t5jt5R90=;
        b=LDFugB4paiSlagxsN6rZsh3XxaKiE74dENjHWNTQB55eTwp73sG1DdfemiMAkOBtVB
         fBNT2huZp2e84BXG/zUwdfogViLJlTW+cuRmgdu0GAmsvAaGg9raBkv+QXw+LVw91KIo
         nwI1Oa4e3niRMx4R/eSlDlC0YUab73PltEGWvQvEAE5aAIGpdZMunrrIPW3zZC6UhLVV
         JSmyYcHdfKnmBlHZTvKLLUMtbrKGN7Q+Sbz9iaJHBjVLiUv9c8UrWsObM4Op8QHF3bSI
         ZQjwGG5VWAKNMxtD/yd4fIK6qjsVgKMcD0ngEn44C1Pz+AJym2GoT5NEiTwZo5xLBldy
         XdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486488; x=1701091288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3T+Nz29XwJpeLbYrWkBbO8epnldil1IzN2t5jt5R90=;
        b=ufuDbdbdVw/i7UWCzjH54cTYYasSBalTSixjrtSCVxJX6yK/LtvDqbw96sMEikNSzc
         t7uyJWsuV23Tk2TRZ0t+4gu5wxspqb627wSOw/ZhyV/bn/0HvNonwbLBDNx4IwXNupXX
         i1MmghNm1WpKhiGgd+ZGJk+rJy49VF1C4rJwpaHVjPuM32dSnMPp+Z5J7JNHP7oHtEus
         6DuNe1Sz5l6RrH3Ml/PM4DuvLy3kKGXI8bsHDkB6/5CstKij9dnBz86cWbLWWxK07BFK
         CjRAt/1MWIYWBsQITrRzvNr216PLtVyyxDLDmQInmRZJNs9SFjgEXhtmKMskiikjWEEc
         /Jkg==
X-Gm-Message-State: AOJu0Yz40uBo2pCquNfKivja8DGywfn1T/WAmd6FOGigj9Pp0ipGVKEs
        y+mBOaTe22Oc4av8wEKkI+V4xA==
X-Google-Smtp-Source: AGHT+IFRA88nEMXJKwXyYF/iRXHh9CqhMXr1fsKvoyCjONkDa+uClAulwokgGhNy/KnwbPKGcRZEMg==
X-Received: by 2002:a05:600c:3d95:b0:40b:22de:b89a with SMTP id bi21-20020a05600c3d9500b0040b22deb89amr1639516wmb.31.1700486488069;
        Mon, 20 Nov 2023 05:21:28 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c590:a7ce:883:eba3])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c0b5200b004065e235417sm17329192wmr.21.2023.11.20.05.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:21:27 -0800 (PST)
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
Subject: [RESEND PATCH v5 04/12] firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
Date:   Mon, 20 Nov 2023 14:21:10 +0100
Message-Id: <20231120132118.30473-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120132118.30473-1-brgl@bgdev.pl>
References: <20231120132118.30473-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

