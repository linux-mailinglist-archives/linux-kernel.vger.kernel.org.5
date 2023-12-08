Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE74080B0AB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjLHXlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:41:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F01712
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:41:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53fec212aso3442713276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702078911; x=1702683711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k7GsY6GT/+tnbArErtPc1f6cs5/DzWiGNX1GnrooOm8=;
        b=K8gDe7e+NlM5dXA3tekfmsM6qM9+PqKWF1pdarRSKxNQLp6Zmo234R6MPjNiZTC7Bd
         Sy2givuIttjJG13JBSjEv1tei319RBdaOfFkhvN8v6DWnaTFFUNds0wcmRjCsalowXot
         OMyFpWUQAzQAR1novnmJ9Vmk6H4Y2rId/IgpkewJqXu8y0YzmDJkNFmYqMUcA8eKo7ZF
         SgDcmELPbDV/IHo/muYmi/NejnD6ff1fSUFLKhWavBao4W+HfVUs/e8v4u0ibVnbvXxb
         0UpLfwUZFTrZYw11OAh/MZBCS91Nwa7wpYrcPnUYawdqHqhVSWGEfnyOTmnu+JO79LS1
         Y9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078911; x=1702683711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7GsY6GT/+tnbArErtPc1f6cs5/DzWiGNX1GnrooOm8=;
        b=OxSWdNFKJlqm+lQgZPtl0T1kPDlyew5PRY41kFcWI2sKWcOX6waRgKOSOD4010qsG8
         FbN/BWjbY9gMEpgxr/XUUR4RDHXt2CgsDjJgDmfA0DDthKLG7f3BKAPX1OLudLDKW3rq
         hYLu+bbLPEmZthSX284VD390r1bvOPQRr1gu546A3ygvvM0paDNIRxmfL8ZxCgqeio/F
         M8c/GltcnS0CX+e63HVHm1f2zn51y0YLmhOPU3iiW8q5GcCQcIgq5li5n78artnL5WRk
         a2Ta4sp/b+jkxcTNisTqpQLoblCsCmnItt5AmXYqnbRgDJy4Y1VlXL5gWPDookOQMQUW
         8N8A==
X-Gm-Message-State: AOJu0YwbaPPY10uVltwvtmTvteTJKU/kIqiGt83Aj3V60QF5oU+pRI7n
        qPiKhhBDnpeYGxapJ32IsQW89rxUhA+hGSgXf8He2Q==
X-Google-Smtp-Source: AGHT+IHGOJeWukTVNuH3xvDlUiPgdeVPjjFBrpqw0bilGbylCV43u5Ik4f0j+Oum1gYfbgenTrdwcI2XwBEmlFpybrySNQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:4a64:6d71:c7b8:4fc3])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:76c8:0:b0:db7:d315:6643 with
 SMTP id r191-20020a2576c8000000b00db7d3156643mr6416ybc.6.1702078911016; Fri,
 08 Dec 2023 15:41:51 -0800 (PST)
Date:   Fri,  8 Dec 2023 15:41:40 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208234141.2356157-1-isaacmanjarres@google.com>
Subject: [PATCH v1] iommu/dma: Trace bounce buffer usage when mapping buffers
From:   "Isaac J. Manjarres" <isaacmanjarres@google.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
use bounce buffers") was introduced, it did not add the logic
for tracing the bounce buffer usage from iommu_dma_map_page().

All of the users of swiotlb_tbl_map_single() trace their bounce
buffer usage, except iommu_dma_map_page(). This makes it difficult
to track SWIOTLB usage from that function. Thus, trace bounce buffer
usage from iommu_dma_map_page().

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Cc: stable@vger.kernel.org # v5.15+
Cc: Tom Murphy <murphyt7@tcd.ie>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f..037fcf826407 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
+#include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
 
@@ -1156,6 +1157,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 			return DMA_MAPPING_ERROR;
 		}
 
+		trace_swiotlb_bounced(dev, phys, size);
+
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
 					      iova_mask(iovad), dir, attrs);
-- 
2.43.0.472.g3155946c3a-goog

