Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926587FFC21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376732AbjK3UPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376653AbjK3UPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:15:08 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A471732
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:13 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a91751ba8so1831526d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375312; x=1701980112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRGmXGqyJzQ9dzCxzy8J7vcwlH74KXpuX5+P/ckDUHQ=;
        b=ldSfYzldNZeeFRfd6WqclZ7cz8U/LZqMc8MlZSEdzA/tkcRw0K87Pz9aOqUllFGjU0
         DfTC661dc5RXXFDmuFvyoOLfHUKInF0b3P2nyJ48WBX97wyuaU5qU6w+CI/7s3z47OTf
         MqpQhsR6X6sBbtIFFII8Eeoh3aLZAddjGC28enTsVM38svDlowQQlRYE3aTRbnGN8zQz
         QT7vARL2lJMJ3g+Qh9CEhy1iUnbNnjfLa+uK7yvQSeInUpI+8HmN399R8BxWbxd5Fyzv
         Cd03EkbWyNT7XToZwcAm3pt1v2V0MEub0btvEzMCjC3US9HZ2bv2OukHerp98uhXNoLu
         7AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375312; x=1701980112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRGmXGqyJzQ9dzCxzy8J7vcwlH74KXpuX5+P/ckDUHQ=;
        b=snqHBuNKmzSIAK92+9uc7eBtl59xtOvAviuv0I8Yty0KN1dK6sEikO5zPHrPGc9ZBd
         V7g62EGIGnvV6NZyhY5rG+HaSegK6kC6JuwcBGTug/ZATpzCUXEQJ2/Fp8ZeU2w/tuZP
         1rkZi04MTRS7MDQzeaSDdtvKRRjZ05iWy1IYQ5VtPTCpNqvxnfZ3CcGWYCvP/FvMmZSR
         dMhkO9OWIikj39rADNegAZv/RLmST9mYvcpdin76b2uNyJ7biYf4sk07iyN4RuS61Ahe
         qUm4/2R8YBbrpBUKTFW2+xldxOd3aq3/noTM7+wQ7wb06hV+0Dl7EmqQjeX+1JurBI4o
         oPNw==
X-Gm-Message-State: AOJu0Yw0ZZerfhosZGLtmtG6cs2UdbSTo/5mXqbqny4UqsoXNRe/w7At
        OGIdobc24LVkHJAMflFZS/Rt4w==
X-Google-Smtp-Source: AGHT+IGcwSJfMg7Wvu1IirdGyJp85Q7AXnz+gps4Wsq6RDzrMQCHyomSRCyLZSC9k8WgNjE2V5K0wQ==
X-Received: by 2002:a05:6214:2e11:b0:67a:93fa:b331 with SMTP id mx17-20020a0562142e1100b0067a93fab331mr288846qvb.6.1701375312521;
        Thu, 30 Nov 2023 12:15:12 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:12 -0800 (PST)
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
Subject: [PATCH v2 05/10] iommu/exynos: use page allocation function provided by iommu-pages.h
Date:   Thu, 30 Nov 2023 20:14:59 +0000
Message-ID: <20231130201504.2322355-6-pasha.tatashin@soleen.com>
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

Convert iommu/exynos-iommu.c to use the new page allocation functions
provided in iommu-pages.h.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/exynos-iommu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2c6e9094f1e9..3eab0ae65a4f 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -22,6 +22,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
+#include "iommu-pages.h"
+
 typedef u32 sysmmu_iova_t;
 typedef u32 sysmmu_pte_t;
 static struct iommu_domain exynos_identity_domain;
@@ -900,11 +902,11 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	if (!domain)
 		return NULL;
 
-	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
+	domain->pgtable = iommu_alloc_pages(GFP_KERNEL, 2);
 	if (!domain->pgtable)
 		goto err_pgtable;
 
-	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	domain->lv2entcnt = iommu_alloc_pages(GFP_KERNEL, 1);
 	if (!domain->lv2entcnt)
 		goto err_counter;
 
@@ -930,9 +932,9 @@ static struct iommu_domain *exynos_iommu_domain_alloc_paging(struct device *dev)
 	return &domain->domain;
 
 err_lv2ent:
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->lv2entcnt, 1);
 err_counter:
-	free_pages((unsigned long)domain->pgtable, 2);
+	iommu_free_pages(domain->pgtable, 2);
 err_pgtable:
 	kfree(domain);
 	return NULL;
@@ -973,8 +975,8 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 					phys_to_virt(base));
 		}
 
-	free_pages((unsigned long)domain->pgtable, 2);
-	free_pages((unsigned long)domain->lv2entcnt, 1);
+	iommu_free_pages(domain->pgtable, 2);
+	iommu_free_pages(domain->lv2entcnt, 1);
 	kfree(domain);
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

