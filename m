Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967D77C2E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjHNV6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjHNV5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:57:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D8E7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZEeqgqkaU1GbN7KPpFzvHLL+102dTp246XNcuhtWR4r8PuQ7qIAjZSIQUck8PjKVAe3x19Yd4obU3GcSzz5fwfl3e6WoZ/RVXcberIPWKRbnFrn57Mz4Yrky1wVNSrvyZE6chRpMF9Hqg+HP3B330hx/dn64au3oqSt0ez0xX8sQFX84MrApLnRGFqN1vTcSjwOB1IH+V8WK/IklDQEzms7C/64PiiuyRoIloP2mDGTRp/3pjUDU4joP2MgFNW1KQO/o6aN4D057pvF1RiqMst4yfNfIAQZVQZR/1p53xTbFXGOYoYJXTkzEGNFFMjPYPkiVWJ1r7NKgKa2hhzMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beUQ76tSj5K2D2PwzkA9ovNlIFXynAmvOPgwIE0NMjU=;
 b=h4WnofsFI1yB0cU3DyTSC39RHzKQ0FQtVJgXlmkfJxyEB1VBO/GOOZIwiQFNS7Npg5N3xsvzfDqpiRHBfFXaf3Ev1SqFMArPsPx3eDqLSyKgYe+QWJldyFWWYHuUv7vYGATG9mf04P4dXYPKQgu3wrPwA53KcDNk1tzaFM8umpC4YTVtH20fqXrMsPG92NymvguuR5ZsJNy6glPZ05o2p5VejxZQpqevTtqGqG4Vq+ULNzVQNMicEX1u0+5nAtq0wKwzG1pBzPiC5kw+3dK6ay9g+hUME0no7uyS+5uH5eQ/TMDsP02Mdqe4STwULjzvL3pY4gkd8xKt6iN4PeSvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beUQ76tSj5K2D2PwzkA9ovNlIFXynAmvOPgwIE0NMjU=;
 b=EfmCcsI2NML1shCbG/Xv25jgwNxq8F+Idi3Qdy6hc/t0dkJBU5CmI8rFF4v+oxcTSV1S5ncJfQwAcQJBhVmjfyCuKYQDenYc9TBGh/7IfAD9ZdBFm5LVODoOWk1l1SHTsdkT1e+or3JDATsjGYs2sD083FQ9PoLkHSfMaXjT9mP5GA7rL+ZM0i1F5NqPrQfUA8kE7rst7X/hY29KySV8F4gX/vOdbwVe+vz00MafzRHdKrNdbacbyBPYeW9GbO36r8uxZlsNkafj7QLmSdt16NdJ1jc6MmC1UNN5FW0uPE13xmEyHgEKtPkKjfnAYOwacOmm/n9aW47TgU1W4xmESw==
Received: from CYZPR20CA0017.namprd20.prod.outlook.com (2603:10b6:930:a2::24)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:57:48 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::b3) by CYZPR20CA0017.outlook.office365.com
 (2603:10b6:930:a2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 21:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 21:57:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 14 Aug 2023
 14:57:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 14 Aug
 2023 14:57:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 14 Aug 2023 14:57:34 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jgg@nvidia.com>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH] iommu/arm-smmu-v3: Add a configurable tlbi_range_max_n_shift for TLBI
Date:   Mon, 14 Aug 2023 14:57:01 -0700
Message-ID: <20230814215701.5455-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 3891343b-5611-4016-08b6-08db9d117f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uDY++ddmInAo2+/ywtkf+Bp42W4mhz5xsJLeonYk5D9d0yGeYOIA77cEWqlsGk1Hna67KrnSw9lSJVt2lEHon5EcH68WTfPJ8ga/UMOD+ZJhiz25VDyu5/uuPGQLKYzjwpj4H3ypwShYn2ysYCFaGoYj3iKDxXWFzBamQPHdM0OJqV3RUPfIF0QYE+HDBmxDfoAGnYwEWjJJI/zn3xXj2GH2GELjvjzBlAOYpMN1KQJIabGgQuH019WkKPoZHmTpyD/hlpKNST+jNYO+citkiaBbglagrBEP0FvEEBuh+7YbByP7ZDZtWCVGwTPqHKMJd46Wv7XuvSCtHV+5GV6rnyeWM3HObGIYCS+9upes2pQyCUcwK8v1Sl8KWj68heQIadk/3x12M9okzuT4g+7s8ohoOhnLWvD8cIFUhIL+jDohAbPNlpgigSe3/gJfeVE8zaYfQgy0CirKg3dBl2DK5pzFLZClTtec5Y7tJb+VH42SxV3rJ4Zao3sP/CGg+iB+PJj32pEm+tTMkF5hJ1zU2H2ZQiFakI70aLNCLb18dFBzrrXvBuksFTrFU0Q93dpaccVreW8hTk8VUr/MMhdGGMO9tPjCTsmnbjwiiYuJtrB+Qi5bLq7HOreYVONkn2Fwda/tyPM02+vI7OzUq985Nqtk4xCKFb+9unacv4qAinwCqNtV6do0TelC1urdtsYnwo5QvOdBepI9pd8XYIlg+A35AtEPBpuSucZ93VpahOaKegdBRwKk6KH60QnYD6N6
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(186006)(1800799006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(478600001)(7636003)(356005)(82740400003)(6666004)(8676002)(8936002)(4326008)(41300700001)(316002)(70586007)(70206006)(110136005)(54906003)(83380400001)(36860700001)(47076005)(336012)(7696005)(1076003)(26005)(426003)(2616005)(86362001)(2906002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:57:48.0228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3891343b-5611-4016-08b6-08db9d117f78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
size is above a threshold. This threshold can be configurable depending on
the SMMU implementaion, and its default value can be VA_BITS, so it'd even
make sense for SMMUs with ARM_SMMU_FEAT_RANGE_INV to do such a replacement.

Add a tlbi_range_max_n_shift threshold per SMMU device and allow it to be
configured via an SYSFS node, and then add an ABI doc for this new node.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../ABI/testing/sysfs-class-iommu-arm-smmu-v3 |  8 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 54 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 ++
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3

diff --git a/Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3 b/Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3
new file mode 100644
index 000000000000..ed1a8ead82d3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-iommu-arm-smmu-v3
@@ -0,0 +1,8 @@
+What:		/sys/class/iommu/<iommu>/arm-smmu-v3/tlbi_range_max_n_shift
+Date:		August 2023
+KernelVersion:	6.6
+Contact:	Nicolin Chen <nicolinc@nvidia.com>
+Description:
+		Max number of shift to set up a threshold for SMMU to replace
+		VA invalidation commands with a single per-asid invalidation.
+		Format: %u
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..e52eb8a0ffdf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1886,11 +1886,21 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long end = iova + size, num_pages = 0, tg = 0;
 	size_t inv_range = granule;
+	size_t max_size = 1UL << smmu->tlbi_range_max_n_shift;
 	struct arm_smmu_cmdq_batch cmds;
 
 	if (!size)
 		return;
 
+	/*
+	 * Convert a large range/number of VA invalidation(s) to one single ASID
+	 * invalidation, when the input size is greater than the threshold. This
+	 * simplifies the command building routine, espeicaly on an SMMU without
+	 * ARM_SMMU_FEAT_RANGE_INV.
+	 */
+	if (cmd->tlbi.asid && size >= max_size)
+		return arm_smmu_tlb_inv_asid(smmu, cmd->tlbi.asid);
+
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
@@ -3107,6 +3117,7 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	smmu->tlbi_range_max_n_shift = VA_BITS;
 	mutex_init(&smmu->streams_mutex);
 	smmu->streams = RB_ROOT;
 
@@ -3808,6 +3819,47 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 }
 
+static ssize_t tlbi_range_max_n_shift_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
+
+	return sprintf(buf, "%u\n", smmu->tlbi_range_max_n_shift);
+}
+static ssize_t tlbi_range_max_n_shift_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t size)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev->parent);
+	unsigned int max_n_shift;
+	int ret;
+
+	ret = kstrtou32(buf, 0, &max_n_shift);
+	if (ret)
+		return ret;
+	if (max_n_shift > VA_BITS || max_n_shift < PAGE_SHIFT)
+		return -EINVAL;
+	smmu->tlbi_range_max_n_shift = max_n_shift;
+	return size;
+}
+static DEVICE_ATTR_RW(tlbi_range_max_n_shift);
+
+static struct attribute *arm_smmu_attrs[] = {
+	&dev_attr_tlbi_range_max_n_shift.attr,
+	NULL,
+};
+
+static struct attribute_group arm_smmu_group = {
+	.name = "arm-smmu-v3",
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
index dcab85698a4e..07636d596901 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -665,6 +665,9 @@ struct arm_smmu_device {
 	unsigned long			oas; /* PA */
 	unsigned long			pgsize_bitmap;
 
+	/* Threshold to convert VA range TLBI to asid TLBI */
+	unsigned int			tlbi_range_max_n_shift;
+
 #define ARM_SMMU_MAX_ASIDS		(1 << 16)
 	unsigned int			asid_bits;
 
-- 
2.41.0

