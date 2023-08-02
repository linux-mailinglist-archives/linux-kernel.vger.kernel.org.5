Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E8476D49F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjHBRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjHBRCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:02:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F92101;
        Wed,  2 Aug 2023 10:02:42 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 30992238C43B;
        Wed,  2 Aug 2023 10:02:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30992238C43B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690995762;
        bh=oeSc+GkK/ZLJKOD7kmtbAT61HWgiUosa2UOiw2GfqGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hx+FXt8AW8JLtFEijOcaoT2b1eGBYaTP/edQHmJIogR6ryn6qxbSSJSjoKcCw2BnC
         58kdLAw8DgwpSiuwo/jD5CUjwPZZwhfdAxdVT+TNCWb+2nozwB9FOtZSVGrtAro1mf
         OqRA+tMcW8PqXNH7ZtP89uQunwUAroBWFzUIKGSc=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Sasha Levin <sashal@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        iommu@lists.linux.dev (open list:IOMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5.15 5/6] iommu/arm-smmu-v3: Add explicit feature for nesting
Date:   Wed,  2 Aug 2023 17:02:26 +0000
Message-Id: <20230802170227.1590187-6-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
References: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

commit 1d9777b9f3d55b4b6faf186ba4f1d6fb560c0523 upstream

In certain cases we may want to refuse to allow nested translation even
when both stages are implemented, so let's add an explicit feature for
nesting support which we can control in its own right. For now this
merely serves as documentation, but it means a nice convenient check
will be ready and waiting for the future nesting code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/136c3f4a3a84cc14a5a1978ace57dfd3ed67b688.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a551a48d271..7cec4a457d91 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3703,6 +3703,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	smmu->ias = max(smmu->ias, smmu->oas);
 
+	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
+	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+		smmu->features |= ARM_SMMU_FEAT_NESTING;
+
 	arm_smmu_device_iidr_probe(smmu);
 
 	if (arm_smmu_sva_supported(smmu))
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index abaecdf8d5d2..c594a9b46999 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -646,6 +646,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BTM		(1 << 16)
 #define ARM_SMMU_FEAT_SVA		(1 << 17)
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
+#define ARM_SMMU_FEAT_NESTING		(1 << 19)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.25.1

