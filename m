Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9F7884F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243115AbjHYKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjHYKcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:32:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A084133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ng3M8ntryBW5g/HfW0IiXDDS979wtUPJFxCA87RMGmxn0SDM3fosOHkvp7wzvlXT1ItrWzbQuE3GFInRCU5yf0rK+mqCdFh2U8OvZIdEZWK65u8KM+/xYiHestK0fmpmeIIiOjKnJ6kS9jAKCnZ2bpWQWLME57ncuhNgPTgBiLY4DbQ5utBlRu5dhmXEOFaOecGvyZTys9zmzhEEFgISKTHpDvwDiI7Ah0o9aH7K9RNKACs2uTr01hu9fdWTIr2ZyGxCqjUaOUShdGr1xb3JPBXDwoaZVrcB2YXpGScXTIzZYzTI14ikThreGdjGOux0xPfs7DIayUqESDM/5rFIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbCaYsxCTvP6rgJooO2hh9lUv7cAU8Qf2+1cQBH1qHY=;
 b=DxfBQm4HfigPUa7P0W8nOt6gGxRoForYTgzfdMuMUGOEWmKIRPRrg/qCrHwL5obVRsWjfDkKvW1T7Touo/GEnS3Xlcuj+ZRKA/Q5zo7mrSlz8t1NNE0FlB5j1KGgSJ47O4kPlVKQ97IO0hhRSVrIoO4n9vpUs8sB0RK1HU9XVLXHWJ5zb3v39js9aF4UeZatJtNgeu+JVD0jXG77rrjx71SPjv08S+H1NN/grn6FnPnblz+UpnG3rXzOUReu7e1rFOTUvfhbRf7eHEGDUwJlWczQGyl5Qk8EbgECVSD2jFMYEwUsbEzbhMGTLiY3pdxws+VFXBmD5XDV+4WyHg9Gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbCaYsxCTvP6rgJooO2hh9lUv7cAU8Qf2+1cQBH1qHY=;
 b=O/emNH1br/axSPmCW0wyKyPvK44/h0tC6n6ajzmbELatcqsSXvlyEKGA2n+IyBuMCrvdUMUSEJ9iCkWn4GrXP7G7B1uHB5LJkrSryf3g5grBBTJJYOO6ClgGXbOCiYQWvMDzZO3Ip2JU3Hq6DWH1GWxXtCM+ChG2KN9tfpXeh4zyC9tLqAqF7blh08aWa1phtoiOh6aMmU/nYU7oFxpamB1TwZMbW753PmAQn096O+/dzCm3CSUyh5fFtfLYMCmlCbsx87nRnnmyn7JUxdlwe+ArlVnTVI9G4Hic2TzB0OHB9SRhySJFQXBRuCI2fPTvCx7er/uZoRhXNroUNWBdLw==
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 10:31:50 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::5c) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 10:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.2 via Frontend Transport; Fri, 25 Aug 2023 10:31:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 03:31:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 25 Aug 2023 03:31:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 03:31:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v3 1/2] iommu/arm-smmu-v3: Add boolean bypass_ste and skip_cdtab flags
Date:   Fri, 25 Aug 2023 03:31:23 -0700
Message-ID: <c8ebc0d5ffd5a4d498a3a3b1b35d19cb70e7feab.1692959239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692959239.git.nicolinc@nvidia.com>
References: <cover.1692959239.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee07a61-e34b-4eb6-829b-08dba5567df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUsN8vvYi7CESkLJg4UDSVp4O0NPKhtfpHFn/hJpipnSAveURPrbrAgUANlAmZFWE/mh0ynn+kmeQ/R514j2cTTpNrxcIkGWMN8gkQZJ3/GCl9Fp6lPK7VKabMK8p29f57zixmcIvsa9JqxXKKdFt2glp3yA061cxM6FgnbFNLe9bz+jXdAnZUwcWVSvzwIHCTnSCilC7RieWGTFBpqPHuN6KjWa0PePrXXN80LLvBRzKGaO2/GP8mSEZpLmLYLYzk0Chl3sHSz04MvcWEv4VAVtxMcy6z4e6CsZMs2mbmus5zBvur7eTJuKCk0ZWWOqhNVXqilZKbV3zIutc2qD5OFCdyzEvUs8NTtOZztE9ceYURzg1zlAXbXdFvbJZx2q7wZI6td0tQM4g9fR3YI5Am6W6gvGa+b62RemciFtqRtyabZhNO21PTK335dXEfSgfR+7McZ2i2IEmSvbZaGW5o5koGbtcO+k7FQFbVWdmEKqiP/D9/05zWl5//brcw+Vuehpf8CAWeF0aEs8EPrDl775G38rX8bSlJfDAtSH8OLpOZUcQ+MsX1t4bZ8SmbaNH7CIUjk8Re6xuWT1afUL2qWwKLtsHscUaaGmpIwncbBuqZHDyIknrzW/PFx8/ZvhsG3EZRI/9X2FCzADk0Yr+7zKtBvZDG9IV3QoxOGMeh+nAFwxx3nfTtSpYzSjpy/NzBPnr2wU3nU9B0DKNmErhAlaY26gfxQuvA612JPthobDkwHI/bzHQCTc0Rh+mUlR
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(336012)(36860700001)(83380400001)(26005)(478600001)(47076005)(40480700001)(2616005)(5660300002)(426003)(2906002)(8936002)(4326008)(8676002)(356005)(7636003)(82740400003)(40460700003)(6636002)(110136005)(70206006)(70586007)(86362001)(41300700001)(54906003)(36756003)(7696005)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:31:50.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee07a61-e34b-4eb6-829b-08dba5567df1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
index ffd430948e9e..de8bc4c3ad7a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2406,6 +2406,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
+	bool byapss_ste, skip_cdtab;
 
 	if (!fwspec)
 		return -ENOENT;
@@ -2441,6 +2442,24 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
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
@@ -2448,22 +2467,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

