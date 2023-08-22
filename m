Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19061783C19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjHVIrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjHVIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:47:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC57CE1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gydNOHO/GYHf5Wn1Umw2FNgb2GHc72j1jJoNKsryECrojXSScWpjGhFWljtMkLPKWOX6F8tFL1UHNohROWitFMRX/VeHT0x3BIR7BEzgZoW+np8xvLKggyYLNyiH/QjOP0xpvpOT6kTOqKVe6VzWZ1zP+8pxFGmfklH62iXwsox4oClXNyhO8KlLwEjPWIHjbfr7aesxiSIMWPhQS07H/QfQZuPdkGcNkk3F+WQpG+s9wWsHU1jQx0vwk2ZisUtpUnGPrP0okWJc48rd++m6WKUv6i66+8CbAyuGm42BTeseq54drm8kifGoOUG5RzMYPSwsnp5yvxIQeMJJJKAhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exbFn+06LxGydnN9f3efOq+WhuDJHyoZOkF8RLssHmE=;
 b=kC1/0VA7PGe+QE9mQMG8hvBhBHAYiSbF8MaNLP7RJipHDX9PZuuj88Tx7FyVe+AWljlUKliSexNUxXW92pS25tm6EwP/zxQFKkRNdaBoFpEX7XUsS+N2XnDZnESucFVZXVLpdFPWnbirf8XvKXdD5wqhl4l9EzI11JQxugtRrO5vaHUzlgwNe365AW0eo/UYRTUF8SnuoMlIxgwfbzD9YUG7KrbkmUMAm6SSaAuzYCY6tgwiZn5Nrpe0XKVnMZKw2f3ag1D+TIahHb9QMbiXpkgatWTEoKycAdXB17EHZjfT5X3pFfJexcMu3X25lvSj+zl3wYb88BdXB1yDFzHlgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exbFn+06LxGydnN9f3efOq+WhuDJHyoZOkF8RLssHmE=;
 b=px9yANd000IGTlO9V5Mi+sMISTTUbL50ZZAkL9Q3sfhHfN/Rd7Z+FQt9wGLCLP1MHhYz8hWbH7dnwpYK1R558YFL8l+qAii+Ddzi5JMnvbnqrifH/3ZhsgddHgdHerUttMmOyHELH1jF+Ohs/oQ92MJBB5PEN6A2GNlCwIKK0WzW5qITHCOUBNnjbanK9azHh8hgGIqONmrFE5UAq9ek5r/Xe7+n7Km/pi3apwPusESMIr+7uWV0OAqkk+ncRTE7lU0E2Syjc2hrD8iGy3QhaoKhWzVWWpojp00PxSHvRe2ezX2kjtwoMkofIptNEps6VcQEIw7kRDyvmVTnBozX7A==
Received: from CY8PR10CA0028.namprd10.prod.outlook.com (2603:10b6:930:4b::18)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 08:46:16 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::9a) by CY8PR10CA0028.outlook.office365.com
 (2603:10b6:930:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 08:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 08:46:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 01:46:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 01:46:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 01:46:05 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH 3/3] iommu/arm-smmu-v3: Add a max_tlbi_ops for __arm_smmu_tlb_inv_range()
Date:   Tue, 22 Aug 2023 01:45:53 -0700
Message-ID: <3ba332e141102d31b756326cdc4078cac1f5ab1c.1692693557.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692693557.git.nicolinc@nvidia.com>
References: <cover.1692693557.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d623d5-b85b-41b3-c450-08dba2ec3faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gacf5GrHIILcwjkqNSkdcDUiArWzmPyj28PITy8IXXt5d+va2HWnOTusGYEAmz1ViFQEvRWUaOjKfyPaskrv8QaoPs0m/mAGv0BtrTtiFPtYlDLlXn1OJ8cepcWe5WNLskoBNmXk4OsXyUdnhVE5rUdRQAoFpKPoD/nJP6gSLSyorBN2j1iwWFOXG++r0vV7767tJ32c+1PRUBapE8oCFxEpym1utyVhsMJJBGnOa9Jhn0EsQCjU6qyO63AjlWgazdsB2aXqMZQrLscxErIvsp3cUib+MhPmqN4iFRzEkXYj5tUtR9LoakCsNSwR6QUcnlIEqIwtpwplgT53Iu4OI3bDJ9Ej6a4n2IX7XxeF9huyiwx69z+EgtRIpX0RLNxZENgqnrz/FdchEK7lS0tsXjKmyZohwzHJ9hnt+LbUZ/fS7RzikjDPjWKpgyUshbfHb0ctGFINBRw7S1KFvt8vMPNs2O5BVPdyd/uihfHZWmGAGXgS92eQ5VjyhqBR4lIED5DVrzKrF5sptzLnDg4erSUSS562OxBb1KJ7MF0TmaADar/aSCvBAQ9sqi0aFWLfnBTuy7h4jqH73ZEmzWO/V0/kCRTPeQtz3h01+q3GBhsR2GgKes5hlYi8jBO5keV5onpxOfj+3qu9GtuImbnJ3xGR7gKVPOr8+yFvquJDP9xGwDkTwn3UmUgdUTUA5HKN1reVAyedVrI9m08Ks638ZaX1i5irvRDx1waYGtRUKlA=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70206006)(70586007)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(7636003)(40460700003)(36756003)(41300700001)(82740400003)(356005)(478600001)(6666004)(40480700001)(83380400001)(2906002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 08:46:16.6257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d623d5-b85b-41b3-c450-08dba2ec3faa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
commands with one single per-asid or per-vmid invalidation command, if an
invalidation size reaches a preset threshold using the number of entries
per io-pgtable, similar to the MAX_TLBI_OPS in arm64's tlbflush.h.

Add a max_tlbi_ops in arm_smmu_domain, and convert a large number of per-
granule TLBI commands to one single per-asid or per-vmid TLBI command, on
SMMUs without ARM_SMMU_FEAT_RANGE_INV.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d6c647e1eb01..3f0db30932bd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1897,7 +1897,14 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	if (!size)
 		return;
 
-	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+	if (!(smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
+		/*
+		 * When the size reaches a threshold, replace per-granule TLBI
+		 * commands with one single per-asid or per-vmid TLBI command.
+		 */
+		if (size >= granule * smmu_domain->max_tlbi_ops)
+			return arm_smmu_tlb_inv_domain(smmu_domain);
+	} else {
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
 
@@ -2258,6 +2265,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	}
 
 	smmu_domain->pgtbl_ops = pgtbl_ops;
+	smmu_domain->max_tlbi_ops = pgtbl_cfg.nents_per_pgtable;
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dcab85698a4e..f68c95a2e24f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -721,6 +721,7 @@ struct arm_smmu_domain {
 	struct io_pgtable_ops		*pgtbl_ops;
 	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
+	unsigned long			max_tlbi_ops;
 
 	enum arm_smmu_domain_stage	stage;
 	union {
-- 
2.41.0

