Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650097B171B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjI1JVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjI1JVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2FC198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3231dff4343so5808107f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892864; x=1696497664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+8cU6fa0dkOhujc4CdFNdtWDl3dgQeMzHDKVHwQ4Uk=;
        b=dhOblrfEXhCc8eGhlP1uuRUkq/MRbKiM3rBOvnXbMhGbkurjaNlolnkxz+WsT9X/j+
         PXdTYxYLp6bjl6jI/k2QMS4PvcRi98icXp7QPr+pEfl0nODKi+sfPnhDWmc/VyLYqO2G
         KBXpkq19mSIa6wu+DwhjFdJ9PFYhauOZ4eOdcEYwK/b8BTn3HSjBIx5IFHaXT+g5cglQ
         jqtmNDMQ5Q65p+ffG5WMQbeSgpf2es1pcJ32+LoMlk1n2pW5qOS4py77sb6mGLn1+fnY
         mDGvLmmJRnVqD74BbXuzYQQj9rs+WyGA7Cy7fGt6aHNYBn2j+gOxEahgvDAX6YH9keJB
         wqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892864; x=1696497664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+8cU6fa0dkOhujc4CdFNdtWDl3dgQeMzHDKVHwQ4Uk=;
        b=RPt+SG357Lik/EEYn9lVYxQjKaBpnYYiY0nD1eukwwT9/97hWfPlnXV3EmaN9o5BlE
         yyJHS8l2MGjY4Fn9eA3FSvy7AJTg/sNbpUVkjWaYNZYXjp1DYa0QWGibAV7kHoxD6eiO
         R8D2VDWz1UHHxGJRJ2S7rzSXv2Vc6xD2KVaSG37qfFtZ+RfGRF3iX4VKdGZfCO4RRE5Z
         X0XncEtF+Z2WhLc7BNNSQGexcgwkB48uhgANO+Cbx7tvlJM18IiMV3bPJi4nzh5fgYdH
         8K3NoOyQGdW+SAO5DJ60kthz60CBjrP4o3Daf2ax8xoRuyd32l407uq86DlESnSz1oZg
         sTTw==
X-Gm-Message-State: AOJu0Ywao//+BEPbMR1pU1f11CZ1CeVcqg/d0wcxqOUpal+m5W3rrbEh
        9Z23StmCagjhrMmvD3H0yI9Klw==
X-Google-Smtp-Source: AGHT+IGVetIztwUx9e5fsOM8aoZ5wMthqjBBfRyYVH2TEGcRvOzHPG/fdnn5hKofi6FzRNpM0cutzg==
X-Received: by 2002:a5d:5265:0:b0:314:314e:fdda with SMTP id l5-20020a5d5265000000b00314314efddamr759882wrc.23.1695892864488;
        Thu, 28 Sep 2023 02:21:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 04/11] firmware: qcom: scm: make qcom_scm_assign_mem() use the SCM allocator
Date:   Thu, 28 Sep 2023 11:20:33 +0200
Message-Id: <20230928092040.9420-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
References: <20230928092040.9420-1-brgl@bgdev.pl>
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

Let's use the new SCM memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 258aa0782754..0c532e794b92 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -980,14 +981,13 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
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
 
@@ -997,10 +997,12 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 	ptr_sz = ALIGN(src_sz, SZ_64) + ALIGN(mem_to_map_sz, SZ_64) +
 			ALIGN(dest_sz, SZ_64);
 
-	ptr = dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
+	void *ptr __free(qcom_scm_mem) = qcom_scm_mem_alloc(ptr_sz, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
+	ptr_phys = qcom_scm_mem_to_phys(ptr);
+
 	/* Fill source vmid detail */
 	src = ptr;
 	i = 0;
@@ -1029,7 +1031,6 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 
 	ret = __qcom_scm_assign_mem(__scm->dev, mem_to_map_phys, mem_to_map_sz,
 				    ptr_phys, src_sz, dest_phys, dest_sz);
-	dma_free_coherent(__scm->dev, ptr_sz, ptr, ptr_phys);
 	if (ret) {
 		dev_err(__scm->dev,
 			"Assign memory protection call failed %d\n", ret);
-- 
2.39.2

