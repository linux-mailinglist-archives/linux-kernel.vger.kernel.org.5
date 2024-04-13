Return-Path: <linux-kernel+bounces-143557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C558A3AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BEA1F2190C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D451CD06;
	Sat, 13 Apr 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEZE0AAL"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415518EB1;
	Sat, 13 Apr 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980074; cv=fail; b=ENPFNELk+PaEqY8iAPRnTwtdQ7eirWBwclj+7sivsaWsFgZ5gaRM8fnBodcWklEY0cztfLglCk9YRHB0cQzgZi9d0Q1Vc75+TVkqnKWqhAgpwqvU81YN8KJSCM9D7xpzN2EXc+UfJ7NzIIhXTxfigRx7h15mK8eN3YvWqRjknws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980074; c=relaxed/simple;
	bh=ah8Bo2ynACeA+AnP5xBoxcw3M9zKz6JQ1O16W5ShkS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9A50YUIvP0hw5L8kMqBc8lOXDg1nWdxa+GYAQVK9imuh0SbxiqJS4iuSsW6KcLUsDtOv0sB19hYTElhdN8BVd1ClmkJZz/zF0kxQ5cT92T+0FgolUSt1qZohCpnC8TG6vmEp/pjDj7PnzZ52wrO8SB5V8B5r1nah/zTbSCEr+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEZE0AAL; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUsUoiOCqDfp50LrBjtYxZIX+AjtEMX/UaSpf+Uz5sQn2zslHRelccp9blZ0e3Mh99bI0adwkcqZQPLBtwi2U6O2SQPDQpIBZ3x6O40khkaq1VLPYUQ3Tzjgz1FhP8ydvb5bY+VWIcf/r2amZpSTXm1R4c6JQEM8j09jREzYKEIspFA13NTkHQ5lMvyJVkde9ZMEeTKJ2Fvlp3VEerpu3AyEMgCMSBefiZ0Hus7H0Me3rxOAcT+6OkGL5igeHLaMhidSjCPaEl9/JVDL42RZSm7sK6iw9PlXofRFyaRdKH+tmMi/TiRhuVkedhmFxOGDHkL+HGdcW/WdY11GjT+4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMg+57M7e2GtR1pVUomtLGsv+rdjb5POSVJd/BF7Tlc=;
 b=Ei0TXYeku+97NchlRq2uHIrsxAQTvx+kXOfQ9Tm3se9jtSTIAR9XSXUYHDqVXriapFjnOkVwCbF5kNK30u5QLI5QUSzPWjdKrW1HQU467LfnMfgh4XNsVQeJXe6QfF7JscvgocfYPEduRpdZ1uaIGmRVTLNSqI57Gx9V7hehPox+Q5iK0WYtvyggmkeqrT0mmKNDuNdoRHNCbPyDO0via8PJQeJsrL2RlSx7gbIcDjOuId3MLvaxjawGb66vU4gWfXgTxAvJAWCJtCYb5VOp81UGnBBNiq/QE6GhGCW0hQne9QcsRhwELXKF0Xqrebi23lkqlHqMon6ICYvlXL6bOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMg+57M7e2GtR1pVUomtLGsv+rdjb5POSVJd/BF7Tlc=;
 b=hEZE0AALirJeZBiaRIWPgpu3dDRBqDlbE/O5+xljkEI6gJcOaZmrDXRZKXMRct0V7C50/5LCjUO7Up6Jws6wMoXSgNCtd/7pGefpZ/GNrZJbuF9MnoCG5phJ/bRpfPpk685zaYHsuqDvc1LPbaCdar4SCwfOMnLjRRsR1im60XcrbwKuwh9u+MdUyo8+eGHTjM65qOebfYQgZFGE+QQz5t/qavJQaaVrLwGnHamDFRdJVT2JCCXGW87mGkg5Hpz74xs6rC21AhQWPFsHIMwBDz2gcQR8pItc/lD+urcALAJctzTUWjOoSKcg56FeR3YJ5a58lPH/vwBdkOgYPpV72A==
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:47:50 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::33) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:47:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Date: Fri, 12 Apr 2024 20:47:04 -0700
Message-ID: <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712978212.git.nicolinc@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e530c6-808b-435d-4364-08dc5b6c7d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wdGXpSB2/FKLgo2Lzf6ejuPaRQ3Zbn9j0hTF0Z4cl/El5BomMu/koj+W3Ew?=
 =?us-ascii?Q?dRT230VrhsxTdeO41SfxwbTVeSgt56da/qHkCEHYIg1nZrkC7riHPW3Rjakc?=
 =?us-ascii?Q?ZDrOsdulOmSj61yq0lw71nCXbGbIcP+mfFAlhRO8KpWrXdGP8aMTRWGw4bh7?=
 =?us-ascii?Q?5qFTNC7QN3fLPUbHTEoQ0J5McOfrX5pxiHpr4ywnoedsd4JfxlBdOr4w8TDO?=
 =?us-ascii?Q?NJKIi+XbMCPbxmoXIMkp60YY2TUdxi6fKj73ENYtX224H+1nar9lnpI014E9?=
 =?us-ascii?Q?mgNkpUbPrV9h7+jSvPcXaAxI84mclgIDd6EONfDBiY+ycBxxAAOj6XuadX9z?=
 =?us-ascii?Q?et0368cmyaCrQi/ioG2unKObcf1SZQ5qx1Il6AkilWUsgEZ2EMMjQZx+Gkd5?=
 =?us-ascii?Q?mkt6UYWvHsE3mRx/40twbpFukjWUYT+Fs4qu2a0dx1TSllcqzpfrxEAcUcnm?=
 =?us-ascii?Q?nv66Ld3DICdWEGzPR9QbQld1F+yhAvgilhTV4TTF90V6x4LngkSeU7r/arnO?=
 =?us-ascii?Q?NlpBCw0cRmQigv4buORIWM8Gw8oNgCf5YotvcWz3/3ajokXZo535Bqr241F0?=
 =?us-ascii?Q?78/WHc6pRm+bdUOoaT4Wo5pOGJr9YNvv41M/b6qH8usWL/8b5ichZbLxVlrQ?=
 =?us-ascii?Q?9tza/rbxk60JNeBuqRv08d/Ei9XQD5K697+rWgsVgE4t69Gc+6u0D/cifI4N?=
 =?us-ascii?Q?Ej/XMnCBWwGhHPmllA2eQYmqXlnoWTv3SEMZgQYgK8U+0av0MRnzTUiJzw4Z?=
 =?us-ascii?Q?y5yqpczPueSE8+dVX5k4R4WHRcnN9W9TNs40K77NDl7XZcMCOvpHIMWTvX3l?=
 =?us-ascii?Q?fWKHVHmIAwuxmNvDNlrtMBXdhCT1pUqqnWMoGaGRSnmsgPauG/s47fYSRIGO?=
 =?us-ascii?Q?FlX44XHlp5znK5tk7PLpmFgtnOGbxgTpESDIv/ser3+8sOuFRuHWjBh9n6If?=
 =?us-ascii?Q?c7dkAUym1NBXXOsZ3SoO5aly3sQQeKTkrBoYECQRwamZXRbrlAm0TkdQL/O1?=
 =?us-ascii?Q?DZxuoMlX9emg3IyOpnTd8AVOERTF0HSp/biQhwwhZHAYp+DFmooBxA+iX1Po?=
 =?us-ascii?Q?d687/6GFjHAcWM6LTJXsDRbLHxr8tA7TxP8rNlFMYJTAOPkt6QgJaEXTM6a9?=
 =?us-ascii?Q?ZiY9gTmsa0nxcjBT144QOmPU4a89IVRf5WWk6PabXESzpIbsBIpkpEZYvcfL?=
 =?us-ascii?Q?oM8Y8izdPR0ORnR/DrAPI2PTCr7flELxAEe2JlG/l1ym3FlwwSJ6ZoO/EPW6?=
 =?us-ascii?Q?ma+1Pcn059v4AVD2z4h70gXrQnUN5/sIO5X+g3kCWVTHgzSqYpj8DuBFeKYj?=
 =?us-ascii?Q?vpAfPuuUC0vIkVLZl7N311CYDHrKkOC6VtShaj9gQ+/aLubMosRs3sQoFkBW?=
 =?us-ascii?Q?ap9KDxZPdH6njBRwdF3ZbpChWCxI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:49.6377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e530c6-808b-435d-4364-08dc5b6c7d5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925

Add a pair of ops to set and unet device's virtual ID that belongs to
a viommu object. They will be used, in the following patch, by iommufd
to support some HW-acceleration feature from the host level.

For instance, every device behind an ARM SMMU has a Stream ID. The ID
is used by ATC invalidation commands so SMMU HW can direct invalidation
requests to the corresponding PCI device where the ID belongs to. In a
virtualization use case, a passthroughed device in the VM will have a
virtuail Stream ID, used by the ATC invalidation commands in the guest
system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface to
execute the guest-level ATC invalidation commands directly, yet needs
the HW to be aware of its virtual Stream ID so it can replace with its
physical Stream ID.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommufd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index dec10c6bb261..ca6ac8a1ffd0 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -94,9 +94,13 @@ struct iommufd_viommu {
  * struct iommufd_viommu_ops - viommu specific operations
  * @free: Free all driver-specific parts of an iommufd_viommu. The memory
  *        of the entire viommu will be free-ed by iommufd core
+ * @set/unset_dev_id: set/unset a user space virtual id for a device
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
+	int (*set_dev_id)(struct iommufd_viommu *viommu,
+			  struct device *dev, u64 dev_id);
+	void (*unset_dev_id)(struct iommufd_viommu *viommu, struct device *dev);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.0


