Return-Path: <linux-kernel+bounces-163331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A28B698B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5945E1C21AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6017BC2;
	Tue, 30 Apr 2024 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDXNsAan"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22945134CE;
	Tue, 30 Apr 2024 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452259; cv=fail; b=mrPXc8zbybDmI21KfnQvdsLNwvSkJDwstXnftlkHPh/BEp2q9C/DGv13lQzSccpYcBuoYIro8fLxpjsQsSWlq1Ck+0jFt2sYvc+ROJxGVYvISxfl+fnmcHnipBWosgtn6FynEtVIwvE8BBji7YJmgGR++TuAKoKlRBsb7ZHsJNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452259; c=relaxed/simple;
	bh=+RegpGXNEslSMAmcpY9wZq7qdMwg5Atf5h9x4vDRU84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g5xTZhdK9V0JP5dFFmix80YNsyxkeANkRS11wa8DvPFDJmQqPLy3KyVcwij42BkwCS5u2M2fy19OIquclH2u7ioVhjgXsXs+xGxzJXgOiiISCGTViOvzIGYt2lJj+n0hO2GoK058VOpsHAg+LqlPbGZiohYad+oPMSLxqqWGFzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mDXNsAan; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF3HL2nKXypye1gEUMnUfbuHM5SDRgYZIMObmZP+QLR79OpVBtRd/pIpXnVzn/wumlxrk+JooGyKJ0VSJmZWnqlzY4B2Z9mebNvnPQBu2LYRgD8PD2wVdsXcrLgD+2E+ZO87QjfCHPMA8c53dn08pl6AarWomKy0OP0YJFoihAl99ee38T4rnHF6LPvkhCVbJq39TBJGD9DszFtmygmttw/wav1gwMlQXwMxxsTD0xVNVWhFVcaXQHKNyU5RkT+QtYWwggVLsYWS9tR+TIG2qOIMn00fsAxC0RIWLoeazODCsIruN2IJkHyIvh2MzlXNXOKuA9aCS0Y3I/plYqQmbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p04CspnNZ6SnK1gi0OcNpDASXU8B804huVCxUg/BlTQ=;
 b=VEwDVBITqDT+Lt7zy47QUWVwM0hujMfZ/y/DxKFPLS+TFCKV2go12E6ZG8mwbyV9JKckfyATYkpDV7mo7erqXRnBNmawI25XX4DDbBJ8UDb/FnNHzCdVbbCTiQcmzvRO3FeFBCLs5CTfFUy2ZOlVHxOdM65KX5oWDEImiP9NFZqOdht7LFedGy/fOy1CrbeAszKDFx3ab9zl+4j47J3rFDdHj4rKlHo8sORJHGBuRTKYpyRWM1E1A+J56dwNy/DpTS8f9Qg7IMiiVVUsD9PJaHknMGtVMo2T+tu5x0bVYjmO05zemLA34TJntM1oxPGOgeDdYW9HI5hABZYF0QTF8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p04CspnNZ6SnK1gi0OcNpDASXU8B804huVCxUg/BlTQ=;
 b=mDXNsAanIDSPtjRAmgBYfDdEFthuBgkZsoS1N3Djn9qhbY+jE8+sqMUN0zBSDZ6zOr1o3R9WXNEDf7/YHQ2pcKmblDDG7i7GyE6X5wql0caCwzSE88n6Ykee7pxG8SzVDbZdgl+hTo8QGvfyWe8TML6HJFcW6AtWSiyPLosAi1l8kc82mxIuVmSVPNQhYdD4uAvxCtnCH6hO5OukMNUji3F18AYmxtoLjOMEqTR6z8FnD+JKYOazg1UJfd9klm355ZUcpZazWdtl1+rDrgyqbuiDvh3IYS0d7L+xqlJer9JTIyTaRAPxBYmWBoXtjYoupvpvTix2b5pU1pIqnnWm3Q==
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 04:44:12 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::77) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Tue, 30 Apr 2024 04:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:44:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Apr
 2024 21:44:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 29 Apr 2024 21:44:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Apr 2024 21:44:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v6 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Mon, 29 Apr 2024 21:43:43 -0700
Message-ID: <cover.1714451595.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 885271eb-f1a7-4d71-80af-08dc68d02e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYH2sK0jjeLLFXTcPlKp4u1zBq2PjyD8AKrqC7RzR8L+ND8ErRp1vELT2vvS?=
 =?us-ascii?Q?c+/iXGpgAJ16cH4uXI9xVDYll1kozL0NJx78wPdRnMusgvCilshlQVWRvN+y?=
 =?us-ascii?Q?hHWzlPYnQDRzm59Yghx0WC5Wl9Sy0OgdbJqbZuNB6u49qmKfnXvbx0E9cS7U?=
 =?us-ascii?Q?CblQtCJz5BQF6hjF7bB5jOKT4Efzsd1jX77zSys8LKF/VBgEe7YGpmDNwQTf?=
 =?us-ascii?Q?jhriBw32Ia57sUP9ejgTj8dHpuWG6AJ2jd/FTR4FadjicmNPyYrToruhscfG?=
 =?us-ascii?Q?YzqMUcVs/+dkf6rU6ZL4HhG5WbDJr7/eRY5jVG5BlzrSoGzlKufZftjgXTpM?=
 =?us-ascii?Q?45h+YROzNvAo0T0op/ax8cv6nB2+mqdUREBJfiLb3XYAV25vetWGl9Y8uYFS?=
 =?us-ascii?Q?UsKWjd3Y1RkixEXQT8Qe7wz2JwNrtUDSXELVTRgtcyr+iIOlsUZHQGsILY0+?=
 =?us-ascii?Q?whU87iFU7rxb3yMG/sY6cdsCBPSf0f+QFpx4j4w0Rw4oggWfwraOUqWbl4Sy?=
 =?us-ascii?Q?f8t+PJwgFTM+Ftjk2wL2hNAnp8I4t7B8ahp/L41TMA9b+8WH1gsRos+W8bzV?=
 =?us-ascii?Q?yNl5pkqQkeS0X7tlLX+d9pUqRdllbSPDjjcMpWFpdo/7DMv2x2QtxhI3p/Bg?=
 =?us-ascii?Q?+zfv5Hmri/Z0SJlWLOJxk2ywhv0fFrCsTT4nj2p5F+8aacGvnotx2Y3TJcsx?=
 =?us-ascii?Q?KEADlKC3GfqJgTgzPOb9Ayxncsz+OurInfjqcMd121Od5wmn1haOshn0IUIF?=
 =?us-ascii?Q?sPftOyOP27W1jew1cNbptQXTtpiwnn10mnhEADzHxhwY2f9mowf0iTw/fNN7?=
 =?us-ascii?Q?Xr2dJkAsnr6gRX/K+unrNCZLeAlCyLUdxuLjxGY1lT+0wnWm1ykiQfiv7K+v?=
 =?us-ascii?Q?ULJBXre/6Bvj7lbHoRulIZb/QZcph3x44kFGIsfCS71067jNkArgWctUn7RF?=
 =?us-ascii?Q?eenQdW0tVEiy30pQ9s6XKRNqvOOsdjvYcgBHOb2leIYcIs73OB3gde4OvHjk?=
 =?us-ascii?Q?91BbHd6HUBD/+eeIUm42kTAWzw4g/a+qj9g/KYkEgwW72fTU8SRHCBN8bvp7?=
 =?us-ascii?Q?Hb6LSy9782oaPZglXio/cgSZatjwfgjrTj7EX15pKrCCq+fD+D5kJdnfoxj3?=
 =?us-ascii?Q?qk+TaRDUxgEFioMRkawneNKIO4QwOJk0HSQoU0kdQ6v71+lKMKmYrqc/7oHk?=
 =?us-ascii?Q?sLw5RfwQZkjFPP9KMGqaHCw075V5FhMaRUGZWnxutxIh5CQG8L9W9ZuSa+ba?=
 =?us-ascii?Q?4MJ3dNtsJrmXGp5VQWfhFyeyv2RETsfFU0j2y+aWfPthU9vIflCl00p6iu5S?=
 =?us-ascii?Q?VfqzKGXXg2BZQ0+dxfFv5+97MOWHGfrJ3BPISBaJzTFMnINLtglqzdG9uTuq?=
 =?us-ascii?Q?xFvQlXDqHghVqB8m/qlc6+Ad8asr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:44:11.9110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 885271eb-f1a7-4d71-80af-08dc68d02e6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

NVIDIA's Tegra241 (Grace) SoC has a CMDQ-Virtualization (CMDQV) hardware
that extends standard ARM SMMUv3 to support multiple command queues with
virtualization capabilities. Though this is similar to the ECMDQ in SMMU
v3.3, CMDQV provides additional Virtual Interfaces (VINTFs) allowing VMs
to have their own VINTFs and Virtual Command Queues (VCMDQs). The VCMDQs
can only execute a limited set of commands, mainly invalidation commands
when exclusively used by the VMs, compared to the standard SMMUv3 CMDQ.

Thus, there are two parts of patch series to add its support: the basic
in-kernel support as part 1, and the user-space support as part 2.

The in-kernel support is to detect/configure the CMDQV hardware and then
allocate a VINTF with some VCMDQs for the kernel/hypervisor to use. Like
ECMDQ, CMDQV also allows the kernel to use multiple VCMDQs, giving some
limited performance improvement: up to 20% reduction of TLB invalidation
time was measured by a multi-threaded DMA unmap benchmark, compared to a
single queue.

The user-space support is to provide uAPIs (via IOMMUFD) for hypervisors
in user space to passthrough VCMDQs to VMs, allowing these VMs to access
the VCMDQs directly without trappings, i.e. no VM Exits. This gives huge
performance improvements: 70% to 90% reductions of TLB invalidation time
were measured by various DMA unmap tests running in a guest OS, compared
to a nested SMMU CMDQ (with trappings).

This is the part-1 series:
 - Preparatory changes to share the existing SMMU functions
 - A new CMDQV driver and extending the SMMUv3 driver to interact with
   the new driver
 - Limit the commands for a guest kernel.

It's available on Github:
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v6

And the part-2 RFC series is also sent for discussion:
https://lore.kernel.org/all/cover.1712978212.git.nicolinc@nvidia.com/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v6:
 * Reordered the patch sequence to fix git-bisect break
 * Added a status cache to cmdqv/vintf/vcmdq structure
 * Added gerror/gerrorn value match in hw_deinit()
 * Minimized changes in __arm_smmu_cmdq_skip_err()
 * Preallocated VCMDQs to VINTFs for stablility
v5:
 https://lore.kernel.org/all/cover.1712977210.git.nicolinc@nvidia.com/
 * Improved print/mmio helpers
 * Added proper register reset routines
 * Reorganized init/deinit functions to share with VIOMMU callbacks in
   the upcoming part-2 user-space series (RFC)
v4:
 https://lore.kernel.org/all/cover.1711690673.git.nicolinc@nvidia.com/
 * Rebased on v6.9-rc1
 * Renamed to "tegra241-cmdqv", following other Grace kernel patches
 * Added a set of print and MMIO helpers
 * Reworked the guest limitation patch
v3:
 https://lore.kernel.org/all/20211119071959.16706-1-nicolinc@nvidia.com/
 * Dropped VMID and mdev patches to redesign later based on IOMMUFD
 * Separated HYP_OWN part for guest support into a new patch
 * Added new preparatory changes
v2:
 https://lore.kernel.org/all/20210831025923.15812-1-nicolinc@nvidia.com/
 * Added mdev interface support for hypervisor and VMs
 * Added preparatory changes for mdev interface implementation
 * PATCH-12 Changed ->issue_cmdlist() to ->get_cmdq() for a better
   integration with recently merged ECMDQ-related changes
v1:
 https://lore.kernel.org/all/20210723193140.9690-1-nicolinc@nvidia.com/

Nate Watterson (1):
  iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace)
    CMDQV

Nicolin Chen (5):
  iommu/arm-smmu-v3: Pass in cmdq pointer to
    arm_smmu_cmdq_issue_cmdlist()
  iommu/arm-smmu-v3: Add CS_NONE quirk
  iommu/arm-smmu-v3: Make arm_smmu_cmdq_init reusable
  iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err reusable
  iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  65 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  47 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 857 ++++++++++++++++++
 6 files changed, 961 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0


