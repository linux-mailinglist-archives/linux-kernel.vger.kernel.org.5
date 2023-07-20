Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE475BB1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGTXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGTXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:23:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96D74270D;
        Thu, 20 Jul 2023 16:23:53 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B603236EBEE;
        Thu, 20 Jul 2023 16:23:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B603236EBEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689895433;
        bh=IGGYFXNUvMQx09Tnw6sJKKjcZi3QrY5MCquaxh4wmqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRPhxgbgNRdD4NZWGJGJDGHeHVSh5117liIEIAHzo4Vhkk0hnlnwgHEt0Dp2IT5MM
         8ClFRZOaFW7Hozi8IBPrV32GTdVgXrmamPWbrjevOv6rfuzn59XMhqMT2qWMG2uiYa
         BUcUn7CP6CesQ7hTRX+uQ7J11Pnjeanb5vGoyuog=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, corbet@lwn.net, robin.murphy@arm.com,
        joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [PATCH 5.15 4/4] iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
Date:   Thu, 20 Jul 2023 16:23:34 -0700
Message-Id: <1689895414-17425-5-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
References: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
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
 Documentation/arm64/silicon-errata.rst      |  4 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 3 files changed, 46 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index f64354f8a79f..322df8abbc0e 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -122,6 +122,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-600         | #1076982        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | MMU-700         | #2812531        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bcdb2cbdda97..ba2e5149604c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -897,6 +897,14 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
+	int index;
+
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		cmds->num = 0;
+	}
+
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
@@ -3459,6 +3467,39 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	return 0;
 }
 
+#define IIDR_IMPLEMENTER_ARM		0x43b
+#define IIDR_PRODUCTID_ARM_MMU_600	0x483
+#define IIDR_PRODUCTID_ARM_MMU_700	0x487
+
+static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	unsigned int implementer, productid, variant, revision;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_IIDR);
+	implementer = FIELD_GET(IIDR_IMPLEMENTER, reg);
+	productid = FIELD_GET(IIDR_PRODUCTID, reg);
+	variant = FIELD_GET(IIDR_VARIANT, reg);
+	revision = FIELD_GET(IIDR_REVISION, reg);
+
+	switch (implementer) {
+	case IIDR_IMPLEMENTER_ARM:
+		switch (productid) {
+		case IIDR_PRODUCTID_ARM_MMU_600:
+			/* Arm erratum 1076982 */
+			if (variant == 0 && revision <= 2)
+				smmu->features &= ~ARM_SMMU_FEAT_SEV;
+			break;
+		case IIDR_PRODUCTID_ARM_MMU_700:
+			/* Arm erratum 2812531 */
+			smmu->features &= ~ARM_SMMU_FEAT_BTM;
+			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
+			break;
+		}
+		break;
+	}
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f07914..eeb780c5c1e0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -645,6 +645,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.25.1

