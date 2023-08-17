Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AAA77EFD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 06:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348004AbjHQEW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 00:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348002AbjHQEWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:22:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6A7272B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 21:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMc7NZ1Ekjl125R1Zk77Yku1wmDzDzfD0BcRbNy2NEuMraU0qMN6NOVkLvnrBZjJ7sGdylnA1g//buVMKUD44pOIR33beaHBpey+5M2OrPGkSNKWyxGWntVlauFnsjWNpnezd6qYo32VHhGxuFcJ2aMZLGStdEZGQ/S/OhKoAjrNs4dFUdYQxvZ0oaZFSJkJoUeB+HJl7Jlf8kc9W2QJCtTPrT3WD5UP7fYqnJiY0hInyQP+9+F27eJokRDgLNVcYFFZrhYs1cTids/DbZp10aGGW2sXZZv3+9Fg/zit/2B3NQ/wO8WjoNTjKiYNhBBLQYple3iKMFizns7gwk2hQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAMjW9pv1Jio7l5u/vxgjosOfTxgYtml0RIUhQIpAsc=;
 b=cRabQvivTxUYSNcauvWsK6fIBxHxvCXwi/45oIDNqq78neP+tbxs2WN2q1cqrcE9wHTBidY8/VIjm7IpqahTf+C0mtdLO2KkrdfPiiD7SsF66YToUSlwMGT3BE66Dz8v9O+mElyv39FxJKZz+a7wAc+r8LnCPnQNrEpmHW9FMASm3dSPWJ/jCeMet+I7oi8uUzAG9vbb44FIcYcm7DqeNz+FDXlwOnqNOZ8skqykjRdaiRLLuQjXdY0NoUjXG/YvADhXA1QQhUW9yj5+TT4NJvvcT5kBIz9iSZ4ArpXYwD7NY2I8yeNqvehO/Pe9PLqU1Qxkpt6pQqS6LPRaihQKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAMjW9pv1Jio7l5u/vxgjosOfTxgYtml0RIUhQIpAsc=;
 b=etlHYao4WRNZhp9R4rZ2X9qbPIIn/VfraHmmUQXdZjG0YjDiwwxqXejG04E0C7salQtJrRjolWD63r28V0xeoy/4p1OAV4HxDIW1QqbmWrcx0w/pYF6qjKynRdrwO5Dd+iV/UCDqJPITZFtSyzswvpmy1775bCljYkpzK8uZ2aFQ3r4CrYuKq4nnerwx4X9MVTcSngHmoUMkdqn/F1UXHVZiD2XzGGReD9rIB0//2YqvDavhyYMAWKUQ8e2Nv9r1nNPHkhvSlwhaLcstuVkzQP33BAGccxTM6Ee7t1xee71TV8wEG/WcL8K8rL0NbKD2rXxVWuS63Qky+ay4GrJ3LQ==
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 04:22:26 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::f9) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 04:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 04:22:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 21:22:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 21:22:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 21:22:09 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v2] iommu/arm-smmu-v3: Allow default substream bypass with a pasid support
Date:   Wed, 16 Aug 2023 21:21:35 -0700
Message-ID: <20230817042135.32822-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 234a582a-c4e7-4739-ef76-08db9ed98fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7KrlOURmzVwGJTRX+fJOslic5WYLFhLJodX1SzNeC+sHpYcq6ntK16QQ+SCa+jXw9E8pts1rWm1Bqa4PzHttSMdnOS1s4KdQxqvCKW9CiD5RHUfEMahsiaHVbHsR5c2QUXukL/q34n2HJEZPWwsDGPvdvlIJac6mKTh9/aPzfZzwG+C/dSHmzrlm7XjwDX0aDgULXknB6Vwnh77qYVsrGdB4BqXlfOZ4OZdjBcWMATHDjyd6IMOgHV7iqR8jsBEmVUMFetqdSI7AowAivmbzJmmWa4KEzecabxk9YGCwvU88GeLDcMCNqnFecryQy20eDaDWAKB/OxgIALNvycg9WxL8fbzALoBnnekkTUM9a3JEcM+Nl+njtYljKDCKdsAjSK4dda5+f4svQeevk2KhYcLnSm2JwuhJXFpk1KFsWFbg9qmK+w2EYUrD0mujH0ouNBxea7hRnuc+UI3VbGpS7hyDUqnR1icxvsFrOlCVh8ydsSb93HNfcLAur2lmuFiQ270D/phNnDPlePW4oB2T6bBunU1Y58LIdGJJEH6Rcziih+THo2jAidMwD24NmXegYbqkVmZG10PiREzKJPbl0iVe6edyBEpTbMA4CcEk32vLwAwoeelQqzFhtMqfrkDGVOo7VcoxXPa6GlXZPdOV72HnBFQbbjrksLvawcxSgyHa11OQbtwwAqudG/hKEU54XTEyam2bw7Xfpe3YtPIz6VOgFcHovPvARSDGLhMJnC6Lb7Dmwsya5R8m2cDE3ZBHMnIOHbLaLXo27ABhdVgg5JGe5kFiNJrFcMPfKgsdKXWFRv3SYqCcRigey37blTAwdxNtVLVlzrQtvfFohuUewpcyO19T4JmnBa69JdoU4VkCjknplpsmHtTBurox9w6
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7636003)(316002)(110136005)(54906003)(6636002)(356005)(82740400003)(70586007)(70206006)(966005)(5660300002)(41300700001)(36860700001)(47076005)(4326008)(8936002)(8676002)(26005)(2906002)(40460700003)(83380400001)(40480700001)(426003)(336012)(478600001)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 04:22:26.0142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234a582a-c4e7-4739-ef76-08db9ed98fdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver sets the
arm_smmu_domain->stage to ARM_SMMU_DOMAIN_BYPASS and skips the allocation
of a CD table, and then sets STRTAB_STE_0_CFG_BYPASS to the CONFIG field
of the STE. This works well for devices that only have one substream, i.e.
pasid disabled.

With a pasid-capable device, however, there could be a use case where it
allows an IDENTITY domain attachment without disabling its pasid feature.
This requires the driver to allocate a multi-entry CD table to attach the
IDENTITY domain to its default substream and to configure the S1DSS filed
of the STE to STRTAB_STE_1_S1DSS_BYPASS. So, there is a missing link here
between the STE setup and an IDENTITY domain attachment.

Add a new stage ARM_SMMU_DOMAIN_BYPASS_S1DSS to tag this configuration by
overriding the ARM_SMMU_DOMAIN_BYPASS if the device has pasid capability.
This new tag will allow the driver allocating a CD table yet skipping an
CD insertion from the IDENTITY domain, and setting up the STE accordingly.

In a use case of ARM_SMMU_DOMAIN_BYPASS_S1DSS, the SHCFG field of the STE
should be set to STRTAB_STE_1_SHCFG_INCOMING. In other cases of having a
CD table, the shareability comes from a CD, not the SHCFG field: according
to "13.5 Summary of attribute/permission configuration fields" in the spec
the SHCFG field value is irrelevant. So, always configure the SHCFG field
of the STE to STRTAB_STE_1_SHCFG_INCOMING when a CD table is present, for
simplification.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---

Changelog
v2:
 * Rebased on top of Michael's series reworking CD table ownership:
   https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
 * Added a new ARM_SMMU_DOMAIN_BYPASS_S1DSS stage to tag the use case
v1: https://lore.kernel.org/all/20230627033326.5236-1-nicolinc@nvidia.com/

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b27011b2bec9..860db4fbb995 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1271,6 +1271,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 * 3. Update Config, sync
 	 */
 	u64 val = le64_to_cpu(dst[0]);
+	u8 s1dss = STRTAB_STE_1_S1DSS_SSID0;
 	bool ste_live = false;
 	struct arm_smmu_device *smmu = NULL;
 	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
@@ -1290,6 +1291,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
+		case ARM_SMMU_DOMAIN_BYPASS_S1DSS:
+			s1dss = STRTAB_STE_1_S1DSS_BYPASS;
+			fallthrough;
 		case ARM_SMMU_DOMAIN_S1:
 			cd_table = &master->cd_table;
 			break;
@@ -1348,7 +1352,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
+			 FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
+			 FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
@@ -2435,6 +2440,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
 
+	/*
+	 * When attaching an IDENTITY domain to a master with pasid capability,
+	 * the master can still enable SVA feature by allocating a multi-entry
+	 * CD table and attaching the IDENTITY domain to its default substream
+	 * that alone can be byassed using the S1DSS field of the STE.
+	 */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS && master->ssid_bits &&
+	    smmu->features & ARM_SMMU_FEAT_TRANS_S1)
+		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS_S1DSS;
+
 	mutex_unlock(&smmu_domain->init_mutex);
 	if (ret)
 		return ret;
@@ -2456,7 +2471,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
+	    smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS_S1DSS) {
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
 			if (ret) {
@@ -2464,7 +2480,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 				goto out_list_del;
 			}
 		}
+	}
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		/*
 		 * Prevent SVA from concurrently modifying the CD or writing to
 		 * the CD entry
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index b7a91c8e9b52..e9361f85c91c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -714,6 +714,7 @@ enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S2,
 	ARM_SMMU_DOMAIN_NESTED,
 	ARM_SMMU_DOMAIN_BYPASS,
+	ARM_SMMU_DOMAIN_BYPASS_S1DSS, /* Bypass S1 default substream only */
 };
 
 struct arm_smmu_domain {

base-commit: aed5d77d0c3d55d1949db89f27cf7a3981261ef4
-- 
2.41.0

