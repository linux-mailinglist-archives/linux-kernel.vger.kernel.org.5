Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E3776053
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjHINNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjHINNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:13:35 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D65E5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:13:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RLVqV0gcxz4f3jXm
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 21:13:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6n1kNNkTII5AQ--.15907S4;
        Wed, 09 Aug 2023 21:13:28 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Add support for ECMDQ register mode
Date:   Wed,  9 Aug 2023 21:13:01 +0800
Message-Id: <20230809131303.1355-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6n1kNNkTII5AQ--.15907S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWxWF4rKw45CryfXw4rAFb_yoW8XFyUpa
        18WF90kr1DJFn7CwnxXryxZr98Kan5ua4Utw45W3s0v3WUtFy8XF4xKas5K34kCrW7t3W3
        ArsFqrW5Cr47AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1SfO7UUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

v1 --> v2:
1. Drop patch "iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared ECMDQ" in v1
2. Drop patch "iommu/arm-smmu-v3: Add support for less than one ECMDQ per core" in v1
3. Replace rwlock with IPI to support lockless protection against the write operation to bit
   'ERRACK' during error handling and the read operation to bit 'ERRACK' during command insertion. 
4. Standardize variable names.
-	struct arm_smmu_ecmdq *__percpu	*ecmdq;
+	struct arm_smmu_ecmdq *__percpu	*ecmdqs;

5. Add member 'iobase' to struct arm_smmu_device to record the start physical
   address of the SMMU, to replace translation operation (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT)
+	phys_addr_t			iobase;
-	smmu_dma_base = (vmalloc_to_pfn(smmu->base) << PAGE_SHIFT);

6. Cancel below union. Whether ECMDQ is enabled is determined only based on 'ecmdq_enabled'.
-	union {
-		u32			nr_ecmdq;
-		u32			ecmdq_enabled;
-	};
+	u32				nr_ecmdq;
+	bool				ecmdq_enabled;

7. Eliminate some sparse check warnings. For example.
-	struct arm_smmu_ecmdq *ecmdq;
+	struct arm_smmu_ecmdq __percpu *ecmdq;



Zhen Lei (2):
  iommu/arm-smmu-v3: Add support for ECMDQ register mode
  iommu/arm-smmu-v3: Ensure that a set of associated commands are
    inserted in the same ECMDQ

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 260 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  33 +++
 2 files changed, 285 insertions(+), 8 deletions(-)

-- 
2.34.1

