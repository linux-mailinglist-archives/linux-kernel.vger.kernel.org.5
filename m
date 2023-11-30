Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221E7FFC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376689AbjK3UPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376685AbjK3UPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:15:10 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A611995
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:16 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a51ad638eso21300036d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375315; x=1701980115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTqyv+/QBqQRpLXIT6J0+RNMQRf6NZoT619SVstW8Ks=;
        b=Jl12uQ8+8PlkCMR8zLtQCD4lT9s+In1qyYwLdLfsfEMCacSASnWrGt0p3KW/JE2r5M
         R7o3ybf/QPqguwivZy74zrUoIlJn6fF3UvYT3zsTjnEku2XOvoEs+/bOEQb1f4tCPO73
         rU7l4OKXgHr+IcYivqGdJ0WpSsQOkbmBtBKCvaGCb7ikFCZA0oemmtlg6LmPLgCZxZ/H
         BqZfnLdbEylNSX8JThw1VSAJ0Vv9LU1B4q5I/UIByr+L8I/zISt5UsbFxUx0DfnfiluT
         3W/iUP+76z8yhrzqt6HFHexjsTn81eVv/ZiB0hEa5syzPJ0KooHmMCsQsTDmnc6X42eP
         9GpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375315; x=1701980115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTqyv+/QBqQRpLXIT6J0+RNMQRf6NZoT619SVstW8Ks=;
        b=xLEJ6kR1byWmSr045NHXuQQXKZHB47Bbn8sYl7rsG+acHeZoA8tzZxXzxKmaU3WyXk
         gLB5mkc7Pgi9pYEZQ5Ra2zjk99+R2z6CRz2ZH561muhogfxtScSnwmLpUtGlC/sdw8sd
         bAsEmoMNwjwO/kHKVFrLF44ipmXJliRlB/KBBEOj227gRuqgtSixSKZVmTkoGI9Jdjzc
         g2sv+KI1sqKDNzFuM91pzGmRxKRgRHvlatU/3GzWSEAiZ049u4/DAieIJZhgbVoJNUZU
         MtrDq/JS2zKjf1Or1KflC/8tSc+uDrhXwVNJCJaJA2bgmfwmgmJJT9X6C0bdE/Rfoatd
         PShw==
X-Gm-Message-State: AOJu0YxJa04ET66dBgUE2ISTjmDAcfnEhs4sI1wDyFUNt+6zKaQKy3bg
        7QJfUJnytJ7dhWMukYOmEUtZHA==
X-Google-Smtp-Source: AGHT+IE4JYPLoA/tNY4x2pKdpnHf/W/XblnfOPtcPXpbeLos1tHq3JCEAsQT3LPHq1ybHp62KX3VJw==
X-Received: by 2002:a05:6214:4115:b0:67a:3a51:8773 with SMTP id kc21-20020a056214411500b0067a3a518773mr24916856qvb.5.1701375315320;
        Thu, 30 Nov 2023 12:15:15 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:15 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, alim.akhtar@samsung.com,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        baolu.lu@linux.intel.com, bhelgaas@google.com,
        cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
        iommu@lists.linux.dev, jernej.skrabec@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
        pasha.tatashin@soleen.com, paulmck@kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, wens@csie.org, will@kernel.org,
        yu-cheng.yu@intel.com
Subject: [PATCH v2 08/10] iommu/tegra-smmu: use page allocation function provided by iommu-pages.h
Date:   Thu, 30 Nov 2023 20:15:02 +0000
Message-ID: <20231130201504.2322355-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert iommu/tegra-smmu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/tegra-smmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4..5e0730dc1b0e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -19,6 +19,8 @@
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
+#include "iommu-pages.h"
+
 struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
@@ -282,7 +284,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
 
-	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
+	as->pd = __iommu_alloc_page(GFP_KERNEL | __GFP_DMA);
 	if (!as->pd) {
 		kfree(as);
 		return NULL;
@@ -290,7 +292,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 
 	as->count = kcalloc(SMMU_NUM_PDE, sizeof(u32), GFP_KERNEL);
 	if (!as->count) {
-		__free_page(as->pd);
+		__iommu_free_page(as->pd);
 		kfree(as);
 		return NULL;
 	}
@@ -298,7 +300,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc_paging(struct device *dev)
 	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
 	if (!as->pts) {
 		kfree(as->count);
-		__free_page(as->pd);
+		__iommu_free_page(as->pd);
 		kfree(as);
 		return NULL;
 	}
@@ -599,14 +601,14 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
-			__free_page(page);
+			__iommu_free_page(page);
 			return NULL;
 		}
 
 		if (!smmu_dma_addr_valid(smmu, dma)) {
 			dma_unmap_page(smmu->dev, dma, SMMU_SIZE_PT,
 				       DMA_TO_DEVICE);
-			__free_page(page);
+			__iommu_free_page(page);
 			return NULL;
 		}
 
@@ -649,7 +651,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 		tegra_smmu_set_pde(as, iova, 0);
 
 		dma_unmap_page(smmu->dev, pte_dma, SMMU_SIZE_PT, DMA_TO_DEVICE);
-		__free_page(page);
+		__iommu_free_page(page);
 		as->pts[pde] = NULL;
 	}
 }
@@ -688,7 +690,7 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
 	if (gfpflags_allow_blocking(gfp))
 		spin_unlock_irqrestore(&as->lock, *flags);
 
-	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
+	page = __iommu_alloc_page(gfp | __GFP_DMA);
 
 	if (gfpflags_allow_blocking(gfp))
 		spin_lock_irqsave(&as->lock, *flags);
@@ -700,7 +702,7 @@ static struct page *as_get_pde_page(struct tegra_smmu_as *as,
 	 */
 	if (as->pts[pde]) {
 		if (page)
-			__free_page(page);
+			__iommu_free_page(page);
 
 		page = as->pts[pde];
 	}
-- 
2.43.0.rc2.451.g8631bc7472-goog

