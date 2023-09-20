Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06197A8E05
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjITUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjITUxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:53:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7AEB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4dmCj6OsnbrwXe2vPhkAumhvel5GIX+zHbolijeAHlYKH41uZzljIt2cNtrswNVwbr1lr4QKq0FJZgyj3WasVk2B14QhtZNCROrJ9sKfapNpcTKGNp1L40bEqxAWb+G60546f+llOF9G4p6dxfXj8LG9p9WYsnWHX7jRkBLk2VXljU0YrmQ05/8B0NsBsy6U/pAF4NWIWfT/MZ7Ylfb5WJmhXVpIOqpuIUh7CdNHsjbK3bHKRoabuB/hYNMGNrUfJ1vMi9OR8JUUBa4+OWFGlvbit3xz+V41gisR3C8KfTqqDMAWT321tZid5P3uirgeQWX1sX0A3G3x6tufIluxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DnqDJXDY6DhUBwUNLTWqExL+B0pxcCwjXPWFxk1aig=;
 b=SamQqg/9cu6oCvQV1Kk6VB1YtC3Pk8rnBv4YUHgNBNSMGv+0BAnZNU0HU8deplizIJ6XSxTiro2YPkLV5KkcmieB7ZsddEC9XfrX0UpVTDThdYAb19kGpiCioBIIPM5TmKM2qNxHT5QX4HPAwDjay0ObUPTS7RpdrON/C7TZPRy70G2yriQ1l5shI4ClTo8DVVlNiNFjlDI3Lw/ma5MIZUGv8UFyif9huFw6wGbYPP8PhOGG3fsN29ZqJG50mk6yffxsQMPooi3yDuv+9hVcSzcI3Z4TWDFbALizFoNzrAysmcEyMQmNcPgMC7fZqDke+gXrSLIb+He3yCVa/xrxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DnqDJXDY6DhUBwUNLTWqExL+B0pxcCwjXPWFxk1aig=;
 b=LFfem6hl7j/gqaMlClhP5caWawZy3FQoODONZVTcnVg4rXxMHqw7RmBjeYwzX3DlnfPSxKXPkAa9ni45XQTvbUZrQQtNGnlR5o/QPFbudeeZ0GWqAYrHOi9m2hksOsXaogRyffdkZmFzM/NRVxV0w/KPQOZIk5ZIuaC9t+I8+2w+AGg/TOZFHxVNZNu+i4LikBJi0YwpvARNWBU4hU4R3kY7yiHgwhVYojEjk6JeIXtf55IIRJD+i582YFvLpIEebIpPMvQ3LWL6oAUqblviWNQOlivbtDtI0YWUrM/iie53MnHoeoy80hy+JV3m4uF3kofIOYu918NbppyRq44QBw==
Received: from BL1PR13CA0242.namprd13.prod.outlook.com (2603:10b6:208:2ba::7)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 20:52:52 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::22) by BL1PR13CA0242.outlook.office365.com
 (2603:10b6:208:2ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Wed, 20 Sep 2023 20:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 20:52:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 13:52:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 20 Sep 2023 13:52:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 20 Sep 2023 13:52:38 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <mshavit@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v4 1/2] iommu/arm-smmu-v3: Add boolean bypass_ste and skip_cdtab flags
Date:   Wed, 20 Sep 2023 13:52:03 -0700
Message-ID: <45b65b0a774068be805b7e1b45063fe10ec51d3a.1695242337.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695242337.git.nicolinc@nvidia.com>
References: <cover.1695242337.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ0PR12MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e5e92e-4237-4ea3-e21b-08dbba1b8ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8wbMBXynwgCQ57rDo0mwUFwk7TFl0rLzQK5p0FZTMOOZspM7ulhiDsk31wM0Pb7dny6NK0S+VCJM4xCpBSvlbLGDCDUO6fw8oqEM5Xjr5xJNgaj3s3WCFnJJE1cjLdPq/0hczhjLF7n3VX4IQzz3FD25iQCS8+aPUKZurGC6dOFWJkdt512KVABYolD9AKPrjK4xFqkEaKmFKsPGfRNLg7MJv1pYqu3o1d1sPw0BuYF5K+kzFxC/73xyQ+AAWoHGexwEdGufCtZ8k7ysIIXMGJKVSin7tb4YCHfOMZQBv1TtLPc7wGwrHGfkCkpEyD6MSASSvKHB+U+kmQSzXI+48HyAmABXpjTbnZEeB5+x7ILi+wSqdW+W3BQZ8vual6WEbUOx/IbHTuwR2CYGUkPasRSHG0yIx8YO+CB3GEKSw2HZ41p+At9gPMCSdEMioR5YrqUj39yBn0H6IP1dZabcja+QOexwPpwd3Zn5eqrJkYAEMbAYXKJzac5xfAsYqS48hzqHMakH7rgPQk2Wv/7QMBXH8ATPD/lxvOaLClPEOucb66Yoqi1M9G8tXgRtaBG34YfuugHFUvg4xGpNEiPP2h7DehbQYcY3C/7G5MZM8++tx8EDVqYjpCyR1h5mBW3mhmqfXMWw8lvM7QrhiFDWIlOla9dRPRwHhyNpeCNsWpkdrSNSiJs/XXwTgEPZ192tHB9Fkb0O6JiXc7c7U+uu13LzExPu3VW8jZKq2O03IekAXO3YdcpCvF3I0FPhats
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(316002)(70206006)(26005)(426003)(336012)(70586007)(110136005)(54906003)(6636002)(478600001)(40460700003)(6666004)(7696005)(2616005)(83380400001)(36756003)(47076005)(36860700001)(82740400003)(356005)(86362001)(7636003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:52:52.5142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e5e92e-4237-4ea3-e21b-08dbba1b8ee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a master has only a default substream, it can skip CD/translation table
allocations when being attached to an IDENTITY domain, by simply setting
STE to the "bypass" mode (STE.Config[2:0] == 0b100).

If a master has multiple substreams, it will still need a CD table for the
non-default substreams when being attached to an IDENTITY domain, in which
case the STE.Config is set to the "stage-1 translate" mode while STE.S1DSS
field instead is set to the "bypass" mode (STE.S1DSS[1:0] == 0b01).

If a master is attached to a stage-2 domain, it does not need a CD table,
while the STE.Config is set to the "stage-2 translate" mode.

Add boolean bypass_ste and skip_cdtab flags in arm_smmu_attach_dev(), to
handle clearly the cases above, which also corrects the conditions at the
ats_enabled setting and arm_smmu_alloc_cd_tables() callback to cover the
second use case.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 ++++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index df6409017127..dbe11997b4b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2381,6 +2381,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
+	bool byapss_ste, skip_cdtab;
 
 	if (!fwspec)
 		return -ENOENT;
@@ -2416,6 +2417,24 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	master->domain = smmu_domain;
 
+	/*
+	 * When master attaches ARM_SMMU_DOMAIN_BYPASS to its single substream,
+	 * set STE.Config to "bypass" and skip a CD table allocation. Otherwise,
+	 * set STE.Config to "stage-1 translate" and allocate a CD table for its
+	 * multiple stage-1 substream support, unless with a stage-2 domain in
+	 * which case set STE.config to "stage-2 translate" and skip a CD table.
+	 */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS && !master->ssid_bits) {
+		byapss_ste = true;
+		skip_cdtab = true;
+	} else {
+		byapss_ste = false;
+		if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
+			skip_cdtab = true;
+		else
+			skip_cdtab = false;
+	}
+
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
 	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
@@ -2423,22 +2442,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * stream (STE.EATS == 0b00), causing F_BAD_ATS_TREQ and
 	 * F_TRANSL_FORBIDDEN events (IHI0070Ea 5.2 Stream Table Entry).
 	 */
-	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
+	if (!byapss_ste)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_add(&master->domain_head, &smmu_domain->devices);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		if (!master->cd_table.cdtab) {
-			ret = arm_smmu_alloc_cd_tables(master);
-			if (ret) {
-				master->domain = NULL;
-				goto out_list_del;
-			}
+	if (!skip_cdtab && !master->cd_table.cdtab) {
+		ret = arm_smmu_alloc_cd_tables(master);
+		if (ret) {
+			master->domain = NULL;
+			goto out_list_del;
 		}
+	}
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		/*
 		 * Prevent SVA from concurrently modifying the CD or writing to
 		 * the CD entry
-- 
2.42.0

