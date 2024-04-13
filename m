Return-Path: <linux-kernel+bounces-143549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDD8A3ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09B2285B41
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81491D559;
	Sat, 13 Apr 2024 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="shxLoncy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF421CAB9;
	Sat, 13 Apr 2024 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979856; cv=fail; b=IAdv6bv89qd+oJ0/KRLGc0eIHaD4w9ij2nbJaemqUlUWzeWsszYxfs4rewyK2d4t3KNZrHQN+gukBkCabw0HkcJuxMwCoe4RXSKUu93zhhpHFzKfpQ664JJGOLOEzev8HSSy0nsEjL+xvxb+/BtOcrN/eDW8e5zNfI8LXD59Db4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979856; c=relaxed/simple;
	bh=F3N2WQZaJT2pq3hOacu/jxk6rv3fZ9nXbR6x4ewAtC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAIM9k9gqvLtRnAVhI7zEIC1rvRti00ToXKEkZeD9wIj6H/S/TWkkCjeGE98n81VQmXEYivon04/+2lFs/jUDgfuOZIwpnaGBjctgqjxDtoPVTAPLqX1EJTj3AhiCJlvCpmA+ZpQTyEsupJqbvJYVgElGrgoajT2aDpoXBv6Xjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=shxLoncy; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLV0njwOy5C9JJzopn/31zPPngu33CIWsBs0KjwQTkz+g+bkXS5i/RGqXJRkwJeHaRKflIoV/U/EZ/iEeOEeFXpDbAN9qodAlMkvI+LU2GNz+vrn7gPbXSRyucIw8Tw39ZISxGRUvdtFltWQl/mnDEKbix49q8TLmq8ETwq5isTMyOo0OVPSlM0Z+uSofA1nNX06O7RhUF0DaJK0LYLwnn/i0V2uRvLsVf/MBVfEn+fPoO5tNN8arvGB1DiyrD5GmvVZl9oy1ywAz/CRD0GVdrG1AnwNb3Je2O9ahjuNUhUAYT+Xw+85X3gkgf8jj4TmcEdbeEC28kqteEd7ClL1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOWY6CGvHrPSV2X7JRu38VtLEYA6iKz0wjsZeeUxh0I=;
 b=miy8TwgvpKPEGlXhJ1wojHdUBQEjwbaLeyx7l1ZAWx5RYTImO+zkTSIJ04IbUTKhiq83w7FO29xVN4+oWUUqDv5HnmntBlNr4rmmbN2/jId4UCfRyqjdKjz+ONHd0KbUP/3Wwl+KmhD+KiX48IGyy5/VApbW6qsbJ79zCnSaqrloQ+j8sxUionIz4uaB5KCmol6Rcoj6eN82V/N8cc2DnYwqBaV5VpeI9TLyuDw7y1d/z1MBWNJA2flFuj2XJAwi7neSVjknB/5XIw0uEmATqXsDxwnrq2DU6qHE+pQnaCWsisgYRTT8idpR8YFd0iRbyyqUg8gYBhWii/5xqHwTUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOWY6CGvHrPSV2X7JRu38VtLEYA6iKz0wjsZeeUxh0I=;
 b=shxLoncy+wN2k3P4CBMCXV2Vn4q73LU2GHGvOASh+0bVb7E5JxoZyNiDGSUbS6SQ4M2f6jaKuLeXidLUKyk+wkdhgO3ctp0sKlB24+Fb4xTsWm7PNkun/yf7pKm2xIas3IzAIhIHdiBMXOU/WFcTdE3KjsoyMaLY7s18pO0b1J2t4sxjXqjZ17cZJsfAWRgf2x6HK6W8NYiJ+MqHVo73TVOqiCyKeHrdnZXVJuT4htGbl3xdCYeMlN8SoxNu9OIHt7BwbqWFcLI48V9dCagnGFDXBsWWqA+Wuhjw2mWQYUr0q9zGRnz18oXY9tiVPKWmB28Z1HFsmgTSxXVFSBUKtg==
Received: from BL0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:207:3c::22)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:44:10 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::e8) by BL0PR02CA0009.outlook.office365.com
 (2603:10b6:207:3c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:44:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 2/6] iommu/arm-smmu-v3: Make arm_smmu_cmdq_init reusable
Date: Fri, 12 Apr 2024 20:43:50 -0700
Message-ID: <5a5dd54c013aafb88c09d087712be2e163b1ff87.1712977210.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712977210.git.nicolinc@nvidia.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: dd46b9ef-7133-4698-57ce-08dc5b6bfae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DKPyNABW29hojha1/FWmMcp9zf8Dw5VR+jTqzvkVtMUEpMU5s6FjsU1Xypx1IQVuUfS3p9FHYl/ASmngaE/EGU2+/Bp75aNIO9C5DqZ2r8ZiZ0hL2WnmyuIOXQW66AKCXy8Hkp2tilgPdO3Mr+W/d5HTGzcPx4y3RTXKEZVlsFTx8SOnpUEoLt/C1LvjzxUjVY+nAskuGqSPoIms/8PXX4+XN4si1o7QPaZeGt9VBZ4GbHfNnBigXyT6osS5u7rGYmFXBCv4UcinLr5WMtQZRPdOy+XC1ehdJh5qDe4SG7tLxRVUNL4EP+iyUxMxUP8kHECYRJFaOuWsQEpQeZqKdoi2ANuYPekNo5Gz58GcwvC9FpFPdYRHWjkBmcjeYW8cnjf70OpJffZbDAen0bLNSdmn5ll2iGVBGhS3IFvcOUxw4m2QpD19sitN1u5izQzER1er36Ga/c+D8GqaP3XKN7hYkqBAMVCiWHVCpmweFrYZ9vwOLI4Dk3Np6oAeqCgXz+O2TaIKv1LnN73LQ/jXfUCUF8QCJYk06Jrgbq+2Rmi983xyyjAUhfgHqCG2zivvCzJ5luMLTAmEoJq2YtIvPcEFIGM2tbKHlBqGEiuCWaQUrX9KyIkguWvjYD/kErEeh17aXmRxN/SkjXtA5nyGMUjng4UPNLKfiyZAx9PV1qHFMze5g6wHq/3ruzl1tmJZQvKAZjk7yZeUhxELUvN0jSnbM/BbrvhTze6K4B8eKb5VNihTTmsCy6wEq9HgEyRW
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:10.7051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd46b9ef-7133-4698-57ce-08dc5b6bfae8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

The CMDQV extension in NVIDIA Tegra241 SoC resues the arm_smmu_cmdq
structure while the queue location isn't same as smmu->cmdq.

Add a cmdq argument to arm_smmu_cmdq_init() function and shares its
define in the header for CMDQV driver to use.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 385a6e72b2f2..18da1a317823 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3144,9 +3144,9 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 
 	atomic_set(&cmdq->owner_prod, 0);
@@ -3171,7 +3171,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index bbee08e82943..ab2824e46ac5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -760,6 +760,9 @@ bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
 
+int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
+		       struct arm_smmu_cmdq *cmdq);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.43.0


