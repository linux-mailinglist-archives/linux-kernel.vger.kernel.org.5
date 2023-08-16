Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B043577EAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjHPUoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbjHPUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:44:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFDF2711
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBD5hAkuJeqKH+HLz6l56K8yLuh/jz7QpD2a9VQ88t3NUoV1Ga1QbZFAtQ8EoamzyzZ+MXYUuoPx84VElnShWl2HXiSsduelM5Yih3qB7pMv4WiwTXvdKidzi1A2Cw5WJ2486FFsQftPsqr5C/F4WVMAL6IBwq7Pd9E2+tiTRpufuhE9x5x0mV0qG60P6lUvT4zMcJPxVj0LGTgAhLHqYZ/MrTbCELJ6Abq0/oviquwLxHRR4af2E4G+hLmMQrUd6n1Xp2CCyqeYr8NAcRMsZOFfOalagHjwhuOKfapM0MtK+/mIQBDZouOS3/Mkfa4Bc6IP/9HtVIt7MRT/kA0Trw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dacav0U4vsHOQ64r1S+qHLIve50VJheW/ItzPAB8E3s=;
 b=iZzZX0xuDgTxeJLx1UfZ4se4PtVBfHlNl/ViDJU3MsLVv3+9QzZDKoMdTqBM8OH6zCuTbsyCg44O/3OdV89+RoJ5BoE90xSzYBMnnZojsnhyPd4cd3Ki3MDbSbd0JGyjcMz9ut39kRbY7BhrVoBVZECNGbEjJTn2KzVOXmlPCfwuwyWSUMvkm8s4mfeqv0EqjypxKE/sAbLPnjGfPnEV4ini1rs4rpPtIFpLIEytySRjBX59ZtE/OzcLlTj+t36uk45Or9azVlieGECmi5knq+NcSjC+IGa2H8YWcX8x71IUgs8RLFM8E6v7p7IT+qsR+ycGJbYNEsfFeJCA6F/XWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dacav0U4vsHOQ64r1S+qHLIve50VJheW/ItzPAB8E3s=;
 b=QRppNsZSZRBmHxRoy3Q6hkIfULwRs8Ep/bHNd10S5l6Q7+lTJnONXBKdIAgAIcYoFeRJfZUULM5btrcj5TXi8JfYFxl5Hqj7+NmugCYvystFTpIHAyi0Fo0MESTb9d2SIZuEfRQmpPP2LN4QctTSMHhy4mByOmnR4fB5ZV1DfOM/KrI8QXSiJ2YZ1OmCvb+ultG7vFDJGN6o5uVBABgAYzpa+/bhkUfWHdEmn0VELQcAoq65FkzVOUHXfilMZE5iU8UX4GoDra7fsgcyOJLTKNmsKZq93VDnIhWivpfRyvRjmtnjsyJjlJ6SpH6+S2L1jxaSLDg0LMXlw6EdwfaR0Q==
Received: from SA9PR13CA0149.namprd13.prod.outlook.com (2603:10b6:806:27::34)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Wed, 16 Aug
 2023 20:44:11 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::ab) by SA9PR13CA0149.outlook.office365.com
 (2603:10b6:806:27::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 20:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 20:44:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 13:44:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 13:44:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 13:43:59 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v2] iommu/arm-smmu-v3: Add a user-configurable tlb_invalidate_threshold
Date:   Wed, 16 Aug 2023 13:43:50 -0700
Message-ID: <20230816204350.29150-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: ee13ad29-2a47-46ea-8e9c-08db9e998b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o27Rjn1EI/0cyw5CC9odOzm2hNT4HBhNN3y/s05nJtCHlUHGndvs9k5ufkxUN+nephuFTQqMrziVgz3Dnv7q1bwGmDBhUu8IFdNX9DVQGkkaIYDxsxZEDyLd/c/2hBFz6aCV1CA1Zzb/g9Hc8R2rLm+goz47aJVUvR3fa0PL8fvppjsB/sP3CYO7d8lbEmp2HtNV6DmzeTUaq48p6UtNo+nPdAqz/oyBn3I0kRz57vdlVKQVqtWzc+mClOUTzmCeYYwxJ/pbqDNwZG8MyUHrzqdt9w/YnGiAzGHOAx79VQ/Sqbyq2R2Ri7nGHNSkHw3c0LIqDch0XgAnczxzM/qAIKmhJ4h2wajE0leYnp6WmcQCRW9EcgM5zVFXUYrcrOfSsZXMIDOuhzep4B6tl/lBW4QzczPiUykGSi/Le2TekPPjq8wyLF36fbMsSP7HOi/uhvGKuwpSb5F8gAa+J709sEKvuKyl7j/mwjn0i8y2KeLXadm25NRCu0aKbZ99BLMPFmFozLfIbuoVPdOD2wJq6efHxUtIzumvlEu06sce64p3wQt8qAxchmxDD8sAa4SFecoq8TT6cy9nFhakqcmPQ0xq8EM3IiaubftOQuTm+BfVvmtKyiB57QQYjyjLFSfvdK1R0nMmk7thQp8GIB9sF6fxyyrctDmrU928V/Y/S+hm8hec9Z4Na2x7r7SclkyQiNG7E9m8lFY5SO2pwCvLAyjmQ6u9kB3FCesCSqIfTeCuObHhxSMJVMZqhCM6Vp07gFXDKBiWO/+t219NWngqGA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(7636003)(316002)(54906003)(356005)(82740400003)(6636002)(110136005)(70586007)(70206006)(966005)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(83380400001)(26005)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 20:44:11.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee13ad29-2a47-46ea-8e9c-08db9e998b94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When receiving an __arm_smmu_tlb_inv_range() call with a large size, there
could be a long latency at this function call: one part is coming from a
large software overhead in the routine of building commands, and the other
part is coming from CMDQ hardware consuming the large number of commands.
This latency could be significantly large on an SMMU that does not support
range invalidation commands, i.e. no ARM_SMMU_FEAT_RANGE_INV.

One way to optimize this is to replace a large number of VA invalidation
commands with one single per-asid invalidation command, when the requested
size reaches a threshold. This threshold can be configurable depending on
the SMMU implementaion.

Add a tlb_invalidate_threshold threshold per SMMU device, and allow it to
be configured via an SYSFS node. Set its default value next to the highest
address SMMU translates, meaning by default there would be no replacement
until a user sets the threshold. Also, add an ABI doc for this new node
with a "%llu" format so the threshold can be 4GB size on a 32-bit kernel.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v2:
 * Renamed the sysfs node and changed it to represent size in bytes
 * Set the upper/lower values of the threshold to be more related to SMMU
 * Revised the ABI description accordingly and added upper/lower values
 * Dropped the "arm-smmu-v3" subdirectory for the new sysfs node
 * Some minor coding style and doc/comments updating
v1: https://lore.kernel.org/all/20230814215701.5455-1-nicolinc@nvidia.com/

 .../ABI/testing/sysfs-class-iommu-arm-smmu-v3 | 13 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 54 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 ++
 3 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3

diff --git a/Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3 b/Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3
new file mode 100644
index 000000000000..2509bc90487c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3
@@ -0,0 +1,13 @@
+What:		/sys/class/iommu/<iommu>/tlb_invalidate_threshold
+Date:		August 2023
+KernelVersion:	6.6
+Contact:	Nicolin Chen <nicolinc@nvidia.com>
+Description:
+		Size threshold in bytes for SMMU to replace VA TLB-invalidation
+		commands with one single per-asid TLB-invalidation command. Its
+		default value is set next to the highest address that the SMMU
+		translates, so there will be no replacement of TLB-invalidation
+		commands by default. It is also the maximum value the threshold
+		can be set to. Its minimum value is the smallest page size SMMU
+		supports.
+		Format: %llu
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..96cc2f4d8a2e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1891,6 +1891,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	if (!size)
 		return;
 
+	/*
+	 * Convert a large range/number of VA invalidation(s) to one single ASID
+	 * invalidation when the input size reaches the threshold. It simplifies
+	 * the command issuing, especially on SMMU w/o ARM_SMMU_FEAT_RANGE_INV.
+	 */
+	if (cmd->tlbi.asid && size >= smmu->tlb_invalidate_threshold)
+		return arm_smmu_tlb_inv_asid(smmu, cmd->tlbi.asid);
+
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
@@ -3683,6 +3691,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			 "failed to set DMA mask for table walker\n");
 
 	smmu->ias = max(smmu->ias, smmu->oas);
+	smmu->tlb_invalidate_threshold = 1UL << smmu->ias;
 
 	if ((smmu->features & ARM_SMMU_FEAT_TRANS_S1) &&
 	    (smmu->features & ARM_SMMU_FEAT_TRANS_S2))
@@ -3808,6 +3817,49 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 }
 
+static ssize_t tlb_invalidate_threshold_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "%llu\n", smmu->tlb_invalidate_threshold);
+}
+
+static ssize_t tlb_invalidate_threshold_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t size)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
+	unsigned long long tlb_invalidate_threshold;
+	int ret;
+
+	ret = kstrtoull(buf, 0, &tlb_invalidate_threshold);
+	if (ret)
+		return ret;
+	if (tlb_invalidate_threshold > 1UL << smmu->ias ||
+	    tlb_invalidate_threshold < 1 << __ffs(smmu->pgsize_bitmap))
+		return -EINVAL;
+	smmu->tlb_invalidate_threshold = tlb_invalidate_threshold;
+	return size;
+}
+
+static DEVICE_ATTR_RW(tlb_invalidate_threshold);
+
+static struct attribute *arm_smmu_attrs[] = {
+	&dev_attr_tlb_invalidate_threshold.attr,
+	NULL,
+};
+
+static struct attribute_group arm_smmu_group = {
+	.attrs = arm_smmu_attrs,
+};
+
+static const struct attribute_group *arm_smmu_groups[] = {
+	&arm_smmu_group,
+	NULL,
+};
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3900,7 +3952,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 
 	/* And we're up. Go go go! */
-	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
+	ret = iommu_device_sysfs_add(&smmu->iommu, dev, arm_smmu_groups,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e..9af8d543aab0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -665,6 +665,9 @@ struct arm_smmu_device {
 	unsigned long			oas; /* PA */
 	unsigned long			pgsize_bitmap;
 
+	/* Size threshold in bytes to convert VA range TLBI to asid TLBI */
+	unsigned long long		tlb_invalidate_threshold;
+
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
 
-- 
2.41.0

