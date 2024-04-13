Return-Path: <linux-kernel+bounces-143545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E778A3AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C3B2831D9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432891B960;
	Sat, 13 Apr 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ufBrSK1Z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B8AFC0E;
	Sat, 13 Apr 2024 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712979851; cv=fail; b=FYyR87oK7QpNEJVV6NLMNMvHUsgWy0Hn1BS7quSoKrQ7b9KPPcsXODfb67+QTdQ8a7yKKz3EMH9AcMGEK/ysxo7d1LkoANkXuvG3hq0orTo+U2GDVnd9qlOTgqSZThQoCO0Ttifje8G0GCjrbQpvKz8BvYqEXoKx86cqXWEI5Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712979851; c=relaxed/simple;
	bh=2S0/C3BPq89jxi81CytNV01ZNhIBNPGWYQ9l70bYB6c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IyqcGqWH5Y2JtMpCeCcIESrGGzB9TZbcMzWfq9KP974XsH2GPv8cyyhsHoonN/xxyl9liA1SF+o9RagOSscJw2xq2kuywhW8NlJjSe0fgGXmbGrgO2qUBfwdvmkGEzAftsvYXxgj5X6HgEGHihz5GMqdmnW8ogdFFVAXNgrxxmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ufBrSK1Z; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQExnK/a4wyA4HgwtlZ9Bupon2mHv7on9W8PXmLhmZYIRuMJLAW/E7oQm7UVOgDL4zYhMCsjRnHKC471oc690JPmWdFg3xWQDbnHORIluRhl9ZcwX8i0qxtkmVaw1f3h/+WfjWr1k/9QRngItvMH/DCzJ/tzviKlIelcP8qaK4E8rMC+I2G24Ql3Xcf6y+w/481lSIgYDcU+Gy27dGy3/2sfK+llqI21CoZ3nGeiIcT/egdglsxIEQn/vkeqSpEW1AbEvh3q+XQfEp8GvZDAMRBe4KQlxouwvB5gbQbjv70wVDgmOoh+7RkvVoGZBQlWjpOeSmTm2Zm2klwTKU1TTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt1rdOyUNs4A0bwW1L/df6uNfsERDiK+VlzPccgW5cE=;
 b=DGYyfX/cAVON2W4cGVGymc52mg19mbfEuybO+DMbD9lDCXSbVGvU1/mzXDT1migtZPqfmOurNkyuY5B1JwZc7eJjYKev+s3p7fTyb556DEDcObjqNNjzW3TIChgg6l09kcP3Kshmu7U12PFTUCLX9WCH9fckgAgHyOGUzkBgQ2BYWGdpqqsm8hCqavrGkAitbeHPJnVx20ak/ioO0qhRQuia+eli7E8Tpiz9hW2z+D+7Nb/USdUkFXw7+1LQY86tp2AwHj8c5Tu56qaoDjKglXzVCxbYxT/qZ6rMlKj5HiKlXfNIMtmCkD49vWgpzu3lDEr1mlZucyPJeqGRciX9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt1rdOyUNs4A0bwW1L/df6uNfsERDiK+VlzPccgW5cE=;
 b=ufBrSK1ZOzPSRy9TPlIdGlqGtLSYpvz6tSvLnVjQW8oGTkcd99qlSgRsIDpwt06a5rbOB3V3OI/4A/ikE6pFu0IE1WACsUr2YTF94Udm/vo80oNU1j3xAWYyjk1ZiDBwH5nYwmlZt1BmE21XftGgr3w6W9XtdRlgh/LArqEB6eI80ACFZdFkulfQ5v11QHm7IH1X4ucRG1H14TJ5uJ3B0ExCpROPB878aUQ68ECSxD8mB2t5qACymrKicho59t9DxSufLmhEfyT2F2F3tzVYVx/4uvjjENF9zO7lZRycv9GveXX83kjc3VtfkdZmu5GnE8npiefxD0w/ilKJ6OLLwA==
Received: from BL0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:207:3c::29)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:44:04 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::4c) by BL0PR02CA0016.outlook.office365.com
 (2603:10b6:207:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:44:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:44:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:44:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:44:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Fri, 12 Apr 2024 20:43:48 -0700
Message-ID: <cover.1712977210.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7964de-1a27-430c-4d37-08dc5b6bf6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fymSb9m7M5H2Te9kcdjFMzeWHITlzPzIQDoE9sZsJ8uuBZYnGbL3UcDmEMaKLAnr2Ft8eWbc+W/35c/0O+5YF/FaDknxU/K+B9Axx/eIeB1w1rzFDFkLCfB61L599D/b/+Y7bzf14/ASI8Yt8c4e2cfXvmR4bOzFYluEXUztn8eedeB7zY7Y+GCXw3RJBZKzHoesOGQ2iPI6GAuSsHTAlxmURZao/YBfoDAHjA8sJHjVbPIm8bcMGGhFkoENGVjRuRmISD+jPy97CgqEA7kI3aj2fb02XzRUYlHbi7ZCV3+Vq3AptLdq5qE2+oonA9jMELKDMzrb5tV619Wzh/vUU/Wd0F8NN3cg0Sy+ZCNJXSsFBtTy6D9toQ2uXiKxUgI1v/un2I+fdqQ3tklVwm/HMafuXGFJqHqa24fKvIsu9hqD6OZQuSuZ5UMp/Oe/JX9VRwDAN/0lqsMlJRRffe4CLNWBiRO6i9Bs9Hpc+iyr1DFdCUaQ2GgoNy+xBFSi7RWTrQ3j51CzFqDHTQozh6onlQpAd/vkdGay+9FdMFL6QDP2/wMpdoQ/ABu7SFdrtN35Y8G/Cih33EPmfNBB7A/ZAPUpYmCoKqkOSVogeqkU+0Z/f6becEv2aln5AuYeKrYYdw1o4WYXELxY7aIPw1f8KykDx48jNJgglBk1oW4S7f1QrVlO2Vwba4xmKxatg7T3Uw0b0PSObODcxVepYEaOQBxz/3y0a+5iBhenzYdBeF3mBPEtvxRfryj5pL4fIuc8mEDOyZmgDu2pJ8tK60PsZg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:44:04.0333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7964de-1a27-430c-4d37-08dc5b6bf6ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v5

And the part-2 RFC series is also prepared and will be sent soon:
https://github.com/nicolinc/iommufd/commits/vcmdq_user_space-rfc-v1/

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v5:
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
  iommu/arm-smmu-v3: Add CS_NONE quirk
  iommu/arm-smmu-v3: Make arm_smmu_cmdq_init reusable
  iommu/arm-smmu-v3: Make __arm_smmu_cmdq_skip_err reusable
  iommu/arm-smmu-v3: Pass in cmdq pointer to
    arm_smmu_cmdq_issue_cmdlist()
  iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF

 MAINTAINERS                                   |   1 +
 drivers/iommu/Kconfig                         |  12 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  74 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  46 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 845 ++++++++++++++++++
 6 files changed, 952 insertions(+), 27 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0


