Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9609E783C17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjHVIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjHVIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:47:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D37E5B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhkaQbGrIy+TcObRyBYaqGbMKPsL2/bCpwvq/BEYi46RxGX+tBvwJ3S4zDhOqced1q0mqnDYaTgy0qi2r9itUXjmHcd+jnjwmC4qUHB6f2IpdTaSbnjOMcYWsxKKoUe3Xe6g33bqbUVL103KSBdjAvZRg08iKJ/CPFAgj4KEF0M1ZlhSEmsr0BInCF1iPO8y3o8rhSk8MdF3QKTR9lpl7XC6zOlpzvEQPD2Xz4RIefsYntlpVTqbFvs2dV/WOyYCPJI8QBq+Q+kbYTfFAicOxhojI4wqehvC/AyHkp27/v1fEhXoTfflSe73qEfcbA52HvGX27QrM9ad4IfWPMNPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eamSOcKZWUG1lnF2mDtgEkgGCJKL1dPNlHgiCcR/NNE=;
 b=ccVgA5+XCyYbKfjxmMN3RiY3EjD7bCnI4YkfNt0FDG2hCXhbv5G6BbEjsmGgCATd1NrwDEx7BLGpH70eMom3g/G5iTJW6cuCVTD+r5AJPC2Yg5EW3u2nlioh+FIJ0XB9GQCwHzLr0EzjZQu0JaBoSxSIGVT2jj3SYV3CoRAlY+lb61wNm69SZFideDZEVW5eyGmIZlsEfhtFJxdmnv3GeW5zmhJEy4LluL9zZCYGzFdFFITZdtoHhnFBix24izAMkq4q9HjE4SsMwXPTb6itGM0Eq59Sdxy8zhhKjBJXzLu3Tb4AOmoiSWC4EmhvUIw1dn2+VZbTnVJmTg7xrBEq0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eamSOcKZWUG1lnF2mDtgEkgGCJKL1dPNlHgiCcR/NNE=;
 b=aiVbH6cy/iXzu6n5GGs6yIrL6nMDzdiJm0NGvaREIVdK69gqVtOwx28shbe+9niZc3aaXd1sNWbgAE4ulkrqHE4Mx7cVvoznfjRLJEc3vcaOCU2XGNLr7CsfFG30HLUUGLhUdGUaVVYfYPOs4mpH1yza3A6A/ONOcw5XbaoAX3Gwvr3afo4ARjFYsHZQsQemuTHkb0jR9yMwBg48bYtUiRhxD+EYGVcm2h8KRGHFN605I/kT+GwAG6gNHLsP/jrKqRhvqymBj7w4aAxBkkITCqUz7BztD/R7E/BA8xJf7MX5JKqvJ2Rxpos8kv4qB1gDIy68/ioKKFWBiailxgwUaA==
Received: from MW4PR03CA0050.namprd03.prod.outlook.com (2603:10b6:303:8e::25)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 08:46:12 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::af) by MW4PR03CA0050.outlook.office365.com
 (2603:10b6:303:8e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25 via Frontend
 Transport; Tue, 22 Aug 2023 08:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 08:46:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 01:46:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 01:46:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 01:46:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in struct io_pgtable_cfg
Date:   Tue, 22 Aug 2023 01:45:51 -0700
Message-ID: <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692693557.git.nicolinc@nvidia.com>
References: <cover.1692693557.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0300ed99-22d9-4fc0-1de5-08dba2ec3cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUKZtFODv4Jg3BTa60wuS1zggqlPXMonFpgPhEgBSKfZQmZF63Tvuk6jvrnXbyxBh+jYvMtxK0KkyTX4HuqqAfnUnIjapTC5eXb7/QJ/87IOA44JJixFZjZDTijixdAcx0w3xGkoQO9v8gY+GfkjO8802VY4KfKIoAoKoO9CF4bh6lymoBU/YKECX1AQcuZRZINCeHYDfP/YHaCSeOzBywh3B2NRRrLxBlf1la9ggZ9ZIzO6AI7Ot+OonsRPLG1peDN05mSaRcEe8cV/coBAsMybUnMnlI7usP8nF5t0AuxlzeiMNDo713Gkbb4Q2Y4DgA4iYZ3L+/Y+6m9E1/tFqCE91zqwMREeWcqdztwMSHzEP3Ox0o0Kvbb8itQjr0zINyZkVmjSEhR/HurioFZi+785Rv1eJpnmDO3XpKmT8WNxl5ODasY8wzzmogEhxOVIu4EpSz3UPQ742YIdtr+mNnrIRZrjh6qw/q/J5dXmFVWtgPcMUvBPU0Qi2bA70FhgyOZ5vZB9cEkoyQ/lcq2ScLYouaRRrQP55CN8eMkmhjRGMepXi/AFSOD0yt6CUQs14VoIosZD59P0nrVQyPZVm3MdhWpmiGn/VljI2Cukj6BTSBF6xEv+G0pJ7VMxSqVsvmYdx04IW2sbRxDCXqk8BUC/BzI8kHDysHDxY6rnCDnFvBIXUPfSjqPFCm8gL9QzDcqfNSJRM3ku4dgEK3j5aZ02e7a2MXbHp4LmRi9DVTsR1tTBIzObVKDWVHpFtC6T
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70206006)(70586007)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(7636003)(40460700003)(36756003)(41300700001)(82740400003)(356005)(478600001)(6666004)(40480700001)(2906002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 08:46:11.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0300ed99-22d9-4fc0-1de5-08dba2ec3cb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new nents_per_pgtable in struct io_pgtable_cfg to store the number
of entries per IO pagetable, so it can be passed back to an IOMMU driver.
It will be used by one of the following changes to set the maximum number
of TLBI operations in the arm-smmu-v3 driver.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/io-pgtable-arm.c | 3 +++
 include/linux/io-pgtable.h     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 72dcdd468cf3..7583d9ecca2b 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -891,6 +891,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 
 	/* TTBR */
 	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
+	cfg->nents_per_pgtable = 1 << data->bits_per_level;
 	return &data->iop;
 
 out_free_data:
@@ -993,6 +994,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 
 	/* VTTBR */
 	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
+	cfg->nents_per_pgtable = 1 << data->bits_per_level;
 	return &data->iop;
 
 out_free_data:
@@ -1071,6 +1073,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
 	if (cfg->coherent_walk)
 		cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
+	cfg->nents_per_pgtable = 1 << data->bits_per_level;
 
 	return &data->iop;
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 1b7a44b35616..4b55a327abc1 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -55,6 +55,7 @@ struct iommu_flush_ops {
  *                 tables.
  * @ias:           Input address (iova) size, in bits.
  * @oas:           Output address (paddr) size, in bits.
+ * @nents_per_pgtable: Number of entries per page table.
  * @coherent_walk  A flag to indicate whether or not page table walks made
  *                 by the IOMMU are coherent with the CPU caches.
  * @tlb:           TLB management callbacks for this set of tables.
@@ -96,6 +97,7 @@ struct io_pgtable_cfg {
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
 	unsigned int			oas;
+	unsigned int			nents_per_pgtable;
 	bool				coherent_walk;
 	const struct iommu_flush_ops	*tlb;
 	struct device			*iommu_dev;
-- 
2.41.0

