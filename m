Return-Path: <linux-kernel+bounces-124181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7C7891380
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E46287D65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8DE3DBA1;
	Fri, 29 Mar 2024 06:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BfBoVlI2"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D805381AC;
	Fri, 29 Mar 2024 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711692929; cv=fail; b=YS7z1wytmqyHONWy8ekCenAqi96qucMR8ZbcORACnOSrJEWKqOv6ErKHTzI+fmVoPs4E/b1QrOSNF+BYFcgeeN2aYNYWegW4GlFb+h1QvjwTq1CWlf6jX/+vChmahrmPihy0p7ugcpi+M4WRr8biO5fsx1VJ167JQzy6/0+8Oc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711692929; c=relaxed/simple;
	bh=6VoYThgNQ8A9aApyYWww2+qO/wXhUPHxPV5cbGasGTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ElBb7EjCbS5OCen3rLG84u1dl3FyGbWKsfTRI8S7IIC1jPSfV9aKJEm0UwAUSZXX0iWJoGd1Me3JRNLMw09QCKvcCqTSaDN78Bwua+o9u5V3ADP4Uhd3VyQ/xwLOjfpd+1P6Md2ktA/YPOUurO0fiG1ZISw85La7SkA5jlx7IsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BfBoVlI2; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh4OADqEhqWX7B0EmqiRdO+2wi0c14hy3Wv6G8YY0cut3Zck6j+3w4JYJd7jx5kY+aHGBVdoOs0/bJieMc+4GawYS5pVhyeR2J/pxC8POlMe3yQ5rVjSArC6+J6+os1rUIurXhsWcP3rHI51dgezUhzQHOPflLkremRu9DypV/ZN/md6UnzIRznmT30P+dro9ie8I7o2mA7lGYOnaz7U/NBoBo9ZGoSTh/gvfpZXRNyI9wRuVH7ONwqt+paTRbM9sgcrzmbKa6sZ1ottX4cYcuO4Pd35aHYB3fTq3J+b+bcNKBpY9cDwlPQUC+97TPpdNI8edxefNLgL6aWkDQkGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGK8DKajc7utb3MwOjva2VuWYqk1zj4zaBdVvSjzUjQ=;
 b=C3kzWTUE8zCZDDWEkqcqO2x3/aC+OZvCiFh10tkwr7jtG8o0OyDfu9Cq+76vLVrMhL58pobSpEWe1jEbvwvChcrSFXpHlaDdiscXZon0U+hkhfKBEV/rEPGuBoVjxL4Z0DRBPeXXAIt9e2O0D6UZU6f3tH8wYoRfPJdrsbmLhyjb0/PvmQ9Yn7r21yRIMCqI2in8TvMNZSTblM9+O0thPb4xtnFVL6fnU4sT+ZPr6AOHLgSJ0gwIr+BRs84ZDiPB21rhTLxjkN5YqDR+xQGOSJytSqAD0+BcAjHaF1gy/Aqo5TinX8eEVrOCVwVTPd0wfNULJGICCuOSPppKCkNshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGK8DKajc7utb3MwOjva2VuWYqk1zj4zaBdVvSjzUjQ=;
 b=BfBoVlI2rdpRvwsH3IgQOvY5ZOCDwFeq+o2m1rAJBW4AQY6sJJHCirXC+uwQU2fCuMYpeLm594prJGTkx+d7Qd2X/lYsvGksdHhMsQdGh6iMk7nMJnx/1FYCn1o5oHBkcYx2q5sRunu3qGdJUQhFeJDdPH3KcpzrWmxNaFsMvuRrZZbLYPkPsP+BqjPEIEcUCREsqKZPA60Gy6SDRWrRCi5WnixKwbvjK5SeuWk/Vom9y3x7UPfmUrHYS3bzSxc0giT9/WrOjN2kPtmuOixqvM/Txj3xJSpOaxMt8F8uTD3I3GzquXpWiB344LBBad1XAuu/59nBSoTvy79vWJwjfQ==
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 06:15:24 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::46) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 06:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 06:15:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Mar
 2024 23:15:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 28 Mar 2024 23:15:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 28 Mar 2024 23:15:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v4 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Date: Thu, 28 Mar 2024 23:14:04 -0700
Message-ID: <cover.1711690673.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a7b4f1-7edb-49c2-1713-08dc4fb79ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vIYsA02cirRd6Ae4efi+axrqXGroh9R+rNi4W38Sn8LZKX9s2GqeIr8VjE7RMiO1S1NSkJXdmm8pfu+Cp4VwDGsHRpmhGNM716jtm8PxaYCppJTvm2ZjradLR7+A6h9W7/qQjXL5juSjsYSvV2tTv56XdiYs6bB9aBNcHTi+iNNfCd1vC4tR1H3CSsDYjpArXKeUXeXfOm4oy7WxE9ryeNy2e+OsJWbwYMvr4ZGGCQyL32nVB5wKQFc+ynfBzcXemjpJj2zKAwiefi1j9ISE6xlE43doknb5Iex1mQmnr9X5FxBT0oPYX2bvc6mfg5QW/8nlRFPzViWXi8MEtQ7uGuZtGpRGN70Nz0B+tzeILKDHJEH30oX+lfG2IW+f/pLpZIfdEuQQChBCxzgveWApWJ/fJ/g7hmCNEeGrvL+ffu2ncNKjRKhxjtGpQCfgQszhMr8qrSeLkK7l3BKMaJno3pTlD5iBzrpVbNP5/am5uvHs4o3Ruy+eOV6dM4/NJNu/NDy7sz4lfAMgy3xQmwSDJdj/txz8IKSuWys5d1TCqL6H4NarEgRrBkSjpFtt2od6ZOOAGN1kkGCmTBHRdkHvrqCc9zUaZ9bNSTRpo862BHtRIKbCdjSY0HibKPHoiqipvLUZIR2xw1i7A2YwHw2GwhKlxlXRx43n2UMEC6muaNpoVm6mC0c7XiVnDtQP11pv2q4i7kRZGt6aQy841vI6VycjOfXrBoWj3eAHHZ3ZBoyURSIWymoHoDoODDSHlXuwHoH58hxfTrwjqko3SdKfKg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:15:24.1023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a7b4f1-7edb-49c2-1713-08dc4fb79ed7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

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
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-v1

And the part-2 series is currently WIP, with a pair of drafts available:
https://github.com/nicolinc/linux-nvidia-6.5/commits/iommufd_nesting-vcmdq/
https://github.com/nicolinc/qemu/commits/wip/iommufd_vcmdq/
It's planned to send for review after nested SMMU kernel patches.

Note that this in-kernel support isn't confined to host kernels running
on Grace-powered servers, but is also used by guest kernels running on
VMs virtualized on those servers. So, those VMs must install the driver,
ideally before the part 2 is merged. So, later those servers would only
need to upgrade their host kernels without bothering the VMs.

Thank you!

Changelog
v4:
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  46 ++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 665 ++++++++++++++++++
 6 files changed, 772 insertions(+), 27 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

-- 
2.43.0


