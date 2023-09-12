Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1D79D88B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjILSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbjILSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:19:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAAF10D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:19:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a40cf952dso7875350a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694542788; x=1695147588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbddqXGl2kQi0jX8ldjOAbABA41f9hA36rjyeoF2Ckc=;
        b=siRw+UCUfsFICG23C3+zif8zfTLgJMRilTIeNxTZ8xWI/4RfdzqPVYLvCBABLtBC6B
         6NMi1ZdbF/aNMdmJRHW5eJE3c2ax9m/QssQFI2BLBHfK4B3Tcp7WF6FTbAHy3i+WBwSt
         sxCfb4I7idpQxZJsxK+qtUCnv6gEOCI908npF84XsqT6nYputw+ycRP/pEC++ege7JhH
         zcpxU8lXllBOdg3RxZxszngCFuxTXnTF3lbkLcQDdwdfLHOWXDaci/Jy9CvnGshCJTjR
         EvnlQml3fpBPQT1mLz9ClRYYoIomdwSsUAgQpp5Ntc/b+iofJP+gxzxXscck8+Kbb30P
         14Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542788; x=1695147588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbddqXGl2kQi0jX8ldjOAbABA41f9hA36rjyeoF2Ckc=;
        b=Ft1DGAbR1BEzX7lsuprjFbYTbimR9oe0BHDHtwCHq2pIih401OK/wV+j3k6Kd96RS+
         gVBNTvsULt2cAveGAvtPALvz4ZXnm93mkOs5LXAQ3cch4L/y0tmAwlB3HbVKQdqlIR95
         wOSKVN9BuY6cecQSB4kjulcJYx07pcCArTae5zZzktfRaozae5L5qvQPnQF1Z271gjJH
         TIR7md2tFAmYJGIMR3GDfp6ThXA8pkp88vzP+jcv9smU5kL6CtNci54FqXd/ZkEl422O
         1ZFhEzGZNHOKjJWmG3tg5SdCOxEjh3jeErg4tKEFGMKs1y8zCzm1/zp1dY2CHmXiuTv/
         LByQ==
X-Gm-Message-State: AOJu0YwKz9ooPfM1lZrm0e0F0L81ZR8aTrwVTcJlLT9NX7XSgjnSNfbd
        HE+0vzoOQIjBTQmuhY75doI=
X-Google-Smtp-Source: AGHT+IHe6uQndf+PwueAd+rgdFKpjlWerIStLg26ivu1DPHpgMAmREj657fDN1DRaa6taSHmufTMUQ==
X-Received: by 2002:a17:907:7604:b0:9ad:9225:cee1 with SMTP id jx4-20020a170907760400b009ad9225cee1mr63479ejc.62.1694542787302;
        Tue, 12 Sep 2023 11:19:47 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090652c500b0099bd453357esm7093966ejn.41.2023.09.12.11.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:19:46 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc:     wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] iommu/sun50i: Convert to map_pages/unmap_pages
Date:   Tue, 12 Sep 2023 20:19:41 +0200
Message-ID: <20230912181941.2971036-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use map_pages and unmap_pages. Since functions operate
on page table, extend them to be able to operate on whole table, not
just one entry.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Hi!

I'm not sure if it makes sense to check validity of page table entry when
unmaping pages makes sense. What do you think?

Best regards,
Jernej

 drivers/iommu/sun50i-iommu.c | 55 +++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 74c5cb93e900..be6102730a56 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -589,11 +589,12 @@ static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
 }
 
 static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			    int prot, gfp_t gfp, size_t *mapped)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
-	u32 pte_index;
+	u32 pte_index, count, i;
 	u32 *page_table, *pte_addr;
 	int ret = 0;
 
@@ -604,45 +605,55 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	pte_index = sun50i_iova_get_pte_index(iova);
-	pte_addr = &page_table[pte_index];
-	if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
-		phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
-		dev_err(iommu->dev,
-			"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
-			&iova, &page_phys, &paddr, prot);
-		ret = -EBUSY;
-		goto out;
+	count = min(pgcount, (size_t)NUM_PT_ENTRIES - pte_index);
+	for (i = 0; i < count; i++) {
+		pte_addr = &page_table[pte_index + i];
+		if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
+			phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
+
+			dev_err(iommu->dev,
+				"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
+				&iova, &page_phys, &paddr, prot);
+			ret = -EBUSY;
+			goto out;
+		}
+		*pte_addr = sun50i_mk_pte(paddr, prot);
+		paddr += SPAGE_SIZE;
 	}
 
-	*pte_addr = sun50i_mk_pte(paddr, prot);
-	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_table_flush(sun50i_domain, &page_table[pte_index], i);
+	*mapped = i * SPAGE_SIZE;
 
 out:
 	return ret;
 }
 
 static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-				 size_t size, struct iommu_iotlb_gather *gather)
+				 size_t pgsize, size_t pgcount,
+				 struct iommu_iotlb_gather *gather)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
+	u32 dte, count, i, pte_index;
 	phys_addr_t pt_phys;
 	u32 *pte_addr;
-	u32 dte;
 
 	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
 	if (!sun50i_dte_is_pt_valid(dte))
 		return 0;
 
 	pt_phys = sun50i_dte_get_pt_address(dte);
-	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
+	pte_index = sun50i_iova_get_pte_index(iova);
+	pte_addr = (u32 *)phys_to_virt(pt_phys) + pte_index;
 
-	if (!sun50i_pte_is_page_valid(*pte_addr))
-		return 0;
+	count = min(pgcount, (size_t)NUM_PT_ENTRIES - pte_index);
+	for (i = 0; i < count; i++)
+		if (!sun50i_pte_is_page_valid(pte_addr[i]))
+			break;
 
-	memset(pte_addr, 0, sizeof(*pte_addr));
-	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	memset(pte_addr, 0, sizeof(*pte_addr) * i);
+	sun50i_table_flush(sun50i_domain, pte_addr, i);
 
-	return SZ_4K;
+	return i * SPAGE_SIZE;
 }
 
 static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -838,8 +849,8 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
 		.iova_to_phys	= sun50i_iommu_iova_to_phys,
-		.map		= sun50i_iommu_map,
-		.unmap		= sun50i_iommu_unmap,
+		.map_pages	= sun50i_iommu_map,
+		.unmap_pages	= sun50i_iommu_unmap,
 		.free		= sun50i_iommu_domain_free,
 	}
 };
-- 
2.42.0

