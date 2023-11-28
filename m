Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D52D7FC63E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbjK1Ut6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346107AbjK1Utp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:49:45 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EA91BDD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:46 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67a51ad638eso1805776d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204586; x=1701809386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfTMP0IEjMSODjtdYrx10bu5wkmZdOPfzS7HMIYgctc=;
        b=gMvoHxsMwl3EKBWTRWDNRLdQE3hveYRXOohnt401fxWedyItxuNAARW/iplwD5koVA
         PlHohGppo+eRkcsBuFRTHCVSgz+pkX81bU8DBGKNySAROqCU76klbgaBx2lNgSeyC0H0
         QzdLABHAh6PnW3d0jTWJ0/MCGpX+JKs1sQCCssggIYJCWgDRFFoN9/LMYbOTdr8gW/+j
         sVbMeu8/5Z8HrYdyBtB7Wn/BPUorLFYoIqTE4Z9pJOoFYLx052a2wIm+odCt0QMNRHeI
         4HS2Rs9DsIwXgfbOYWKIvkEfJXE7IBVgbBlbLdcjid7Naa3PMZtnyIa9lf3Tv9uT0VeY
         AGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204586; x=1701809386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfTMP0IEjMSODjtdYrx10bu5wkmZdOPfzS7HMIYgctc=;
        b=q4o/BcuwQioPPgidOhShfCyh8Tp0GJBFrRusCgkiVYWokYuo1FgILOpOKp/mBlsqZS
         XcicTjcXv61JiX+6lS/rIA8gz+Qce32xSK4+Dgr8b0QThg4uJUd5hGeVNkxDM8Zz/6rU
         8wS0jL0hUyCQUfq3j78cG9D5Jt8sx+oCWzTTIouS+l08hNQWi9L97dXQOzGKwVUtngI6
         vMlyp1lOXNDP3V7aJguDQBQrR3lPh9XLhwXeRgVkkWKmoAVyBeArPX2SiWNh2Tl5k9QG
         hZ1ZIARxRKLwJo06MHjx2+O1duW1u3ohpkr/DS1f0K8M1PmQwMp6BoGTEGIlgYHmvoSr
         12Dw==
X-Gm-Message-State: AOJu0YwpyxT5T7hpZVX1R0o2xEHAHevqBRmv8j+AiI1Wyq/glaSW/rGy
        XMy8oYSySesnnJxJwJ7MiOQ3ow==
X-Google-Smtp-Source: AGHT+IEKeO0ndku7kDd+vg89Kzhd+WrQKp5SmuH7bGrf2GIbl4sfu3JTwF6Gf3JxLicYu9UrEBSdGQ==
X-Received: by 2002:a05:6214:1c0b:b0:67a:4546:9895 with SMTP id u11-20020a0562141c0b00b0067a45469895mr14672255qvc.12.1701204585983;
        Tue, 28 Nov 2023 12:49:45 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:45 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        pasha.tatashin@soleen.com, paulmck@kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation function provided by iommu-pages.h
Date:   Tue, 28 Nov 2023 20:49:27 +0000
Message-ID: <20231128204938.1453583-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert iommu/io-pgtable-arm-v7s.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 75f244a3e12d..3d494ca1f671 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -34,6 +34,7 @@
 #include <linux/types.h>
 
 #include <asm/barrier.h>
+#include "iommu-pages.h"
 
 /* Struct accessors */
 #define io_pgtable_to_data(x)						\
@@ -255,7 +256,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;
 
 	if (lvl == 1)
-		table = (void *)__get_free_pages(gfp_l1 | __GFP_ZERO, get_order(size));
+		table = iommu_alloc_pages(gfp_l1, get_order(size));
 	else if (lvl == 2)
 		table = kmem_cache_zalloc(data->l2_tables, gfp);
 
@@ -283,6 +284,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	}
 	if (lvl == 2)
 		kmemleak_ignore(table);
+
 	return table;
 
 out_unmap:
@@ -290,7 +292,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
 out_free:
 	if (lvl == 1)
-		free_pages((unsigned long)table, get_order(size));
+		iommu_free_pages(table, get_order(size));
 	else
 		kmem_cache_free(data->l2_tables, table);
 	return NULL;
@@ -306,8 +308,9 @@ static void __arm_v7s_free_table(void *table, int lvl,
 	if (!cfg->coherent_walk)
 		dma_unmap_single(dev, __arm_v7s_dma_addr(table), size,
 				 DMA_TO_DEVICE);
+
 	if (lvl == 1)
-		free_pages((unsigned long)table, get_order(size));
+		iommu_free_pages(table, get_order(size));
 	else
 		kmem_cache_free(data->l2_tables, table);
 }
-- 
2.43.0.rc2.451.g8631bc7472-goog

