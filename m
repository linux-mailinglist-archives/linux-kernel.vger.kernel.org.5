Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958ED7FC630
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbjK1Uuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346284AbjK1Utz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:49:55 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F1210A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:57 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a0d865738so30228246d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204596; x=1701809396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSGX0jW3To7/xuABL7QXXsr1KCFhu7Z9tThr0mLMrMc=;
        b=mu35PtE5c/9BIjstdYyMmHY7Fsp4p47cAFfxKfLsRGnfxku0i2aSW554C1uqlvpsQG
         7n+YTN7UVvy9Da+sXvjnrRbhflbjotnxSYc46MNpmRLi4IO0BtuqyB4DTLVKFRZBCQT6
         Gem7H6rBonm0+z37Y3eiO2PmFX83B5wvl1i16H3zAMIqCd+ebFYbcpQsJs88KGdQ3aQo
         dilQXr6/WXD8tF4AcdIY0AMHMjtiN5cKy4+xcwwc8ETsP9hjskymCjjVw3r727nJcZ4l
         P7VdPRIIVUXbGZOMRd7My622YMXRlrcltPLBtBUm4FJxlJ4gez9R4x93FrfNE6OSIGVC
         3cTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204596; x=1701809396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSGX0jW3To7/xuABL7QXXsr1KCFhu7Z9tThr0mLMrMc=;
        b=G3E1jce41JoyYH29N49nTMFHG8gTeKW4GBYLPiG9qXGUXsaA1CyfFKvEWiYpoPkopJ
         +uJNBOW+tBWQy+a+4oRevnCuFWo/o0iSQx1P7Q4lAQVOGgkOPe83TKVMGsBH9MQZN3S/
         KgYBBu0NqFNaUTuFOMB6nOitoaFec+Bx6Q+T3Oxoyd2jc2l+mhiIw/wdICkmAeMEzGFl
         BdnuaUtAhhHpviOWZpEMeLaQIH8Cd042IvrP7hQZVEPpCo1SUHf+fvX/W/N69vGVsxnW
         ZCrh8JzTe1eJvR0MX6qqSDadt42HciJ43zNwdghc6jD3ChxgiTIL2DLf/yYXHWX+XR2Y
         7nwA==
X-Gm-Message-State: AOJu0YxsY1iLHfl8qrbS/ow+9UgqouiuZy5WyUvHxqiP9w1DAt9A70UJ
        edJko5O3IY2nQm4TzcXbaKNXCg==
X-Google-Smtp-Source: AGHT+IH3XyzLx3HqaxxWdryJd33MqMJHkx6z6Xt3swBEGkMdx9JQSLka9GW0WH1FkTVqo27TzFUimQ==
X-Received: by 2002:a05:6214:246f:b0:67a:4ba1:84d5 with SMTP id im15-20020a056214246f00b0067a4ba184d5mr7928400qvb.16.1701204596396;
        Tue, 28 Nov 2023 12:49:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:56 -0800 (PST)
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
Subject: [PATCH 16/16] vfio: account iommu allocations
Date:   Tue, 28 Nov 2023 20:49:38 +0000
Message-ID: <20231128204938.1453583-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu allocations should be accounted in order to allow admins to
monitor and limit the amount of iommu memory.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/vfio/vfio_iommu_type1.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index eacd6ec04de5..b2854d7939ce 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1436,7 +1436,7 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		ret = iommu_map(d->domain, iova, (phys_addr_t)pfn << PAGE_SHIFT,
 				npage << PAGE_SHIFT, prot | IOMMU_CACHE,
-				GFP_KERNEL);
+				GFP_KERNEL_ACCOUNT);
 		if (ret)
 			goto unwind;
 
@@ -1750,7 +1750,8 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			}
 
 			ret = iommu_map(domain->domain, iova, phys, size,
-					dma->prot | IOMMU_CACHE, GFP_KERNEL);
+					dma->prot | IOMMU_CACHE,
+					GFP_KERNEL_ACCOUNT);
 			if (ret) {
 				if (!dma->iommu_mapped) {
 					vfio_unpin_pages_remote(dma, iova,
@@ -1845,7 +1846,8 @@ static void vfio_test_domain_fgsp(struct vfio_domain *domain, struct list_head *
 			continue;
 
 		ret = iommu_map(domain->domain, start, page_to_phys(pages), PAGE_SIZE * 2,
-				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE,
+				GFP_KERNEL_ACCOUNT);
 		if (!ret) {
 			size_t unmapped = iommu_unmap(domain->domain, start, PAGE_SIZE);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

