Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612E776FD52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjHDJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHDJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:31:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074149EC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:31:24 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHL3d3LknztRs2;
        Fri,  4 Aug 2023 17:27:57 +0800 (CST)
Received: from [10.67.145.224] (10.67.145.224) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 17:31:21 +0800
Subject: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
From:   zhurui <zhurui3@huawei.com>
To:     Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tomas Krcka <krckatom@amazon.de>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
 <20230801085504.GA26130@willie-the-truck>
 <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
Message-ID: <d5fc1f72-7428-4fef-d868-d06b85add635@huawei.com>
Date:   Fri, 4 Aug 2023 17:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <27c895b8-1fb0-be88-8bc3-878d754684c8@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.145.224]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tg != 0 but ttl, scale, num all 0 in a range tlbi command, it
is reserved and will cause the CERROR_ILL error. This case means
that the size to be invalidated is only one page size, and the
range invalidation is meaningless here. So we set tg to 0 in this
case to do an non-range invalidation instead.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Tomas Krcka <krckatom@amazon.de>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Rui Zhu <zhurui3@huawei.com>

Signed-off-by: Rui Zhu <zhurui3@huawei.com>
---
ChangeLog:
v1-->v2:
	1. Change from "Revert" to modify the problematic case

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..5e56c7e85819 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1895,9 +1895,6 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
                /* Get the leaf page size */
                tg = __ffs(smmu_domain->domain.pgsize_bitmap);

-               /* Convert page size of 12,14,16 (log2) to 1,2,3 */
-               cmd->tlbi.tg = (tg - 10) / 2;
-
                /*
                 * Determine what level the granule is at. For non-leaf, io-pgtable
                 * assumes .tlb_flush_walk can invalidate multiple levels at once,
@@ -1930,6 +1927,12 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
                        num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
                        cmd->tlbi.num = num - 1;

+                       /* Prevent error caused by one page tlbi with leaf 0 */
+                       if (scale == 0 && num == 1 && cmd->tlbi.leaf == 0)
+                               cmd->tlbi.tg = 0;
+                       else /* Convert page size of 12,14,16 (log2) to 1,2,3 */
+                               cmd->tlbi.tg = (tg - 10) / 2;
+
                        /* range is num * 2^scale * pgsize */
                        inv_range = num << (scale + tg);

--
1.8.3.1
