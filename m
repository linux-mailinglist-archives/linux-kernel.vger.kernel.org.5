Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131367FFC27
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbjK3UP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376660AbjK3UPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:15:08 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D99173C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:14 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a44ee7ab3so8311366d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375313; x=1701980113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aM4P70fu6Mpyhz2ZxBL57luN308AqDDoR+bdvrzfCU=;
        b=NWUMOvHfF5rLd3c5ST2+iIXZR5nCsRJ0wYp0dnfs85gdLMbhISzpSivLftTMfyg5/J
         AtFDIDW1AOd0VWmJA866ivlNxLQ38V/wNMZEzVdaDtyjIUVFOEf1gYr5QEYa6bbFQPDG
         Q14+jdqgwlHnkqhc/a4uj2n54iBrf0CWTc4gB2JsPzqn4IuLyJaiQqV+kJT8zTE6NhAI
         enKoM6VYHg6PUUHCGjG3I9gWE/RWacU7uJJi4uxGabqS3yH5f+2GRnMtcsZNKHZmntnB
         /g81BgGLDblriXqtLrbqhc/ygmImT9DMoJ8vUmKeaEpORXcW/o51tMO9EXvDbN1vYy5n
         qKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375313; x=1701980113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aM4P70fu6Mpyhz2ZxBL57luN308AqDDoR+bdvrzfCU=;
        b=u3hbHXzAfq10ZLzG84Sk//fnarIGD5XD/lgFJCh1thnE+HA7XcNWnqBD1diEXmU1oX
         fabo3Bt4jK5den5fl6ilBZwjkkJoqpvxpHn7RgkXflVBQOsxY4dCw13kLEFjYF73yicI
         jnlOcr1V+Xm76HevXCeFPAVId0MoJhB8iXq7Zyw8hJKgCoRrAnTSnqQWMo/eC/Jkvblm
         8mgZ9H2nhf4GJzk1EGn/w6YJxfzGHE892LzYf7n6m7KtqMJTtOE2pHOREXjz/ylbTT0i
         1LyMLIo8rfVOZ9VBsVoI82gyIEoLrYaXvHw2CSkxiEW6rL27Iqrxew+PdfGomWDwELTP
         aJ7g==
X-Gm-Message-State: AOJu0YycWX3ovyMJnVWAb23qFZoEu+R33wF+dDNnxAHSt3EMx5DgnSi1
        GGLHGBP0PDjd6fEhEvxEf06Mpg==
X-Google-Smtp-Source: AGHT+IEBs6D/FyJYqfxI4mL3iV1h7OCPfLZXSrKHIqLtLdmOiu4XOIwm8bZeJ7cSdUFCvrQdbklyMg==
X-Received: by 2002:a05:6214:5294:b0:67a:255c:c43f with SMTP id kj20-20020a056214529400b0067a255cc43fmr20595303qvb.18.1701375313540;
        Thu, 30 Nov 2023 12:15:13 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:13 -0800 (PST)
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
Subject: [PATCH v2 06/10] iommu/rockchip: use page allocation function provided by iommu-pages.h
Date:   Thu, 30 Nov 2023 20:15:00 +0000
Message-ID: <20231130201504.2322355-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert iommu/rockchip-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 2685861c0a12..e04f22d481d0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -26,6 +26,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include "iommu-pages.h"
+
 /** MMU register offsets */
 #define RK_MMU_DTE_ADDR		0x00	/* Directory table address */
 #define RK_MMU_STATUS		0x04
@@ -727,14 +729,14 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
-	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | rk_ops->gfp_flags);
+	page_table = iommu_alloc_page(GFP_ATOMIC | rk_ops->gfp_flags);
 	if (!page_table)
 		return ERR_PTR(-ENOMEM);
 
 	pt_dma = dma_map_single(dma_dev, page_table, SPAGE_SIZE, DMA_TO_DEVICE);
 	if (dma_mapping_error(dma_dev, pt_dma)) {
 		dev_err(dma_dev, "DMA mapping error while allocating page table\n");
-		free_page((unsigned long)page_table);
+		iommu_free_page(page_table);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1061,7 +1063,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
 	 * Allocate one 4 KiB page for each table.
 	 */
-	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | rk_ops->gfp_flags);
+	rk_domain->dt = iommu_alloc_page(GFP_KERNEL | rk_ops->gfp_flags);
 	if (!rk_domain->dt)
 		goto err_free_domain;
 
@@ -1083,7 +1085,7 @@ static struct iommu_domain *rk_iommu_domain_alloc_paging(struct device *dev)
 	return &rk_domain->domain;
 
 err_free_dt:
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 err_free_domain:
 	kfree(rk_domain);
 
@@ -1104,13 +1106,13 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
 			u32 *page_table = phys_to_virt(pt_phys);
 			dma_unmap_single(dma_dev, pt_phys,
 					 SPAGE_SIZE, DMA_TO_DEVICE);
-			free_page((unsigned long)page_table);
+			iommu_free_page(page_table);
 		}
 	}
 
 	dma_unmap_single(dma_dev, rk_domain->dt_dma,
 			 SPAGE_SIZE, DMA_TO_DEVICE);
-	free_page((unsigned long)rk_domain->dt);
+	iommu_free_page(rk_domain->dt);
 
 	kfree(rk_domain);
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

