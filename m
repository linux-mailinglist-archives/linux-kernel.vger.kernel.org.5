Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94276D505
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjHBRVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjHBRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:21:14 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C9D1194;
        Wed,  2 Aug 2023 10:21:12 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id 10D65238C437;
        Wed,  2 Aug 2023 10:21:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10D65238C437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690996872;
        bh=sKKApMwyJFmWVhauSK1wQoyrcn+Ery6qaOjHGnd/wxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFRZfOUrXSilQF9dK36C5+89dh5FfAmYc/wfeo2Do8HUdlLrhcWUQbXcNyhp+Q6AH
         +200YcpSKOs5MfmddMtf5WuHQwK5k0++8LeiDEqjQ6BJDNfW820boRjbfK9kfYnqeK
         2Zg/d+ic7XjuGxHI8XMCrVA1faAgf5LXXymvvB4o=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <joro@8bytes.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM)
Subject: [PATCH v3 6.1 2/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Date:   Wed,  2 Aug 2023 17:20:58 +0000
Message-Id: <20230802172100.1599164-3-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802172100.1599164-1-eahariha@linux.microsoft.com>
References: <20230802172100.1599164-1-eahariha@linux.microsoft.com>
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

commit 309a15cb16bb075da1c99d46fb457db6a1a2669e upstream

To work around MMU-700 erratum 2812531 we need to ensure that certain
sequences of commands cannot be issued without an intervening sync. In
practice this falls out of our current command-batching machinery
anyway - each batch only contains a single type of invalidation command,
and ends with a sync. The only exception is when a batch is sufficiently
large to need issuing across multiple command queue slots, wherein the
earlier slots will not contain a sync and thus may in theory interleave
with another batch being issued in parallel to create an affected
sequence across the slot boundary.

Since MMU-700 supports range invalidate commands and thus we will prefer
to use them (which also happens to avoid conditions for other errata),
I'm not entirely sure it's even possible for a single high-level
invalidate call to generate a batch of more than 63 commands, but for
the sake of robustness and documentation, wire up an option to enforce
that a sync is always inserted for every slot issued.

The other aspect is that the relative order of DVM commands cannot be
controlled, so DVM cannot be used. Again that is already the status quo,
but since we have at least defined ARM_SMMU_FEAT_BTM, we can explicitly
disable it for documentation purposes even if it's not wired up anywhere
yet.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/330221cdfd0003cd51b6c04e7ff3566741ad8374.1683731256.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arm64/silicon-errata.rst      |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index d7f664c5bd75..120784507bc0 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -140,6 +140,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-700         | #2812531        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c12b57910c51..aed038f7d66c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -882,6 +882,12 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 {
 	int index;
 
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		cmds->num = 0;
+	}
+
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
@@ -3412,6 +3418,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 #define IIDR_IMPLEMENTER_ARM		0x43b
 #define IIDR_PRODUCTID_ARM_MMU_600	0x483
+#define IIDR_PRODUCTID_ARM_MMU_700	0x487
 
 static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 {
@@ -3432,6 +3439,11 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 			if (variant == 0 && revision <= 2)
 				smmu->features &= ~ARM_SMMU_FEAT_SEV;
 			break;
+		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* Arm erratum 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			break;
 		}
 		break;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ce5e44a13d84..d9e4357c6869 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -650,6 +650,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.25.1

