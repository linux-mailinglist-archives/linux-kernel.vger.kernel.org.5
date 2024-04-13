Return-Path: <linux-kernel+bounces-143558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7D8A3AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03AB1F21E25
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802EF1CD11;
	Sat, 13 Apr 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phzgkFT/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC4D1B7F4;
	Sat, 13 Apr 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980074; cv=fail; b=JuQ8pz5FInX2ihsv9Nq3PI32M+/e25G1iQFuTR3MtQV2guFNtl+Dtdyz58Gzi487Fr/q9g5EaRHY09C0CXPPqG9bqL58BdCCtoMoCaJxhWJhhgG9yvzZqkAlgYp/MxkrhJitECBrPu0oRFSDjQLd6O/HDOtIM5hgwoqItbFFhcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980074; c=relaxed/simple;
	bh=7l+bGGtWDHVBUMrCnGgSPoHZmm916ro3lUxKzl8pY0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZJDb1XkWQM3tIqRAF8aD2aqrxjm4GBGIIzF95RwlmIyvJuu/ZRYxqzfuG/d5MNWOS9H/VFfiJ/5CZhKk2ixf/K+GbFs79Kexagh9P4bkFo79r6ms/VGWnSNLQyoRT+aoJoPdyTCkMeLraFyauYSdGLnHpjvMiN+AeQNJsmralA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phzgkFT/; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JokTffFN4e2Lj230OAtWaOXk+PluvvQ3432DKs7EFrJPFJP/MvlCoasj2nzXsSHNTDzHDqPFBLbWusnRmusosWtA9mvoSKczlI+VBr/h331ciN5t0I9yrDVxLJzxQnCaNG/6ggBuqGWI6on3kpa5lbGbz+olhFo053VFUCGJcr9iABIcgjQ09sD5a9EGtYGgA9Y/KbpcUKiVCC3I/bOojjuSLKCpTbuqzR0sjj8dLfrMoQNhuHGgMHXqggKpOgQ6eiNsQlUEVnEUgF+ZKdSn31cuO1PONE84/LmD1iGJ2meWdK6oKqWO+DoF0VrwmKSL53EClBvpMapdIw1Gu9D+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtCf7JUFetk9+PUq1uqo38RpXYf6ZzdTTTYjXpPZV4g=;
 b=KjJpm0zY9VVOH7nhMx/jl7+wWxQQj+9YcSy2F7MnybJqKSUu7qPkukj4xqzoXfhx6xUliQqk/GNP+ZrIF8aRnhVcN/xgvdXjbki/jgY6G8FguEEvns+AO4Ts9GvGiZBRy23xFeQRPQbHUQLr5g8yCnBrk2nMbEGufjd9A166xqYCHDTkr3hh7GbuO1r+dwq272Dj169FZC4yeaaUSGK8qUApeDJjpC27HN2z0qd5VBoYjgPREmi2Otn/xPCPFKWtUzSULmVMvosQ2AuxyxhPUf2GBox2bgJTmuttPe9yW+VurTYp5x7wZMpzXm+GA5Tt1XHX8eTB8AP96rb3+G6cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtCf7JUFetk9+PUq1uqo38RpXYf6ZzdTTTYjXpPZV4g=;
 b=phzgkFT/BG9lAliDkd//RTgTPwcV5nRAepWp5oeXPuIwYYVrQHHPccLhDLXskFJ58hcMTdxhK4rynMehjsNWM8AP/ildoxLmv2R4pxG/UMPMpDJqIzJY8Y4lJKugS1XyES3NydvYeTQRIH55rKcNaYKzfGmRmGn6zdIGDXs9vbYv0qFDjTrrhyFU0poQrxsI6M6pBDFU0FWG8FwcCJvgSEBZjf8kYbZjZt8hznKoMk43QD3rGB2QB1O4md6ee8CsGGNE9OUKjAVq/LLQYAI7Up8pW65snx3gBS9YBv7eJJHK9wwy9z1J5sHE9UXzjZiPRHD6EAHYBX8MxTdlss0fsw==
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:47:49 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ec) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:47:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Date: Fri, 12 Apr 2024 20:46:57 -0700
Message-ID: <cover.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: d904244c-c9e0-4fcd-3205-08dc5b6c7cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HWZPqH6Eg+sD9Bn+t8YR2FJ6xfI6+771bNGRsamEE0GZAF6rZMWFSVkHq5yFVqqS5Ou5QiixiNfbkqr5ROVt+vQZmqnGxPkUT/0bnh2QkMAXkl+Au+3mu77J6c3cvw2+Miuy6eH6yz4P2XJUHR6J3NnNAq1dqR1G0WON9J6AaC4vFJPw5MpZi6vDI8UCD0CUagfNG3b5qxLhWZ2lqSjkpVl0dlrd8lbsxz+jcFLtJIaJrOi/Umo92u2O+ycMF//S+YJlwyIl+zUtqrTjmvbYFaC4eduVsrRWE5zVHXjPpHvzGOBjYtp0JXiYu91UmW1RlkywrLCF64W4QJkusGLIr9zQpVjo4IaK7Ueykdf6w+1PW7aUov6749xM8GNvcZ8T8uxH3ouKw+onfgextKDW5IIGhnIQ7e89BCROzWCXhEuIg72Dgh55SDU2nqcliMKbMYD9fAVNco3F4PAeeHfTL1jHRhWiugJOCoFIC616AUfPKRsg8LMS0oqYe6WyhWrggEtqAoyEh/N9yclAMm+k76bOl/kWlAc2Qqxt58qAqCfbWQ2BQGqjyQMn7HE/Ux29YfDPt1sFYD5TIk5f2vJS8awO4poPGyWtTFRo7m4Kj9N3euURYs2YYgWkSE+3NGK3/N7gWWPxOCa9yDjG4mwlOPdalc04H8vTTm+rnxstAc3hVK69dzkrBiPyyPLybrAgw+xbLMAT5+H7QyD7zwR5Ga1Drko7CuYvCuwsL1J1MMulLUVglbOA3Z0ZS7jFYpJxdSitg4l9P7B31rgqht0TAQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:48.7425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d904244c-c9e0-4fcd-3205-08dc5b6c7cde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649

This is an experimental RFC series for VIOMMU infrastructure, using NVIDIA
Tegra241 (Grace) CMDQV as a test instance.

VIOMMU obj is used to represent a virtual interface (iommu) backed by an
underlying IOMMU's HW-accelerated feature for virtualizaion: for example,
NVIDIA's VINTF (v-interface for CMDQV) and AMD"s vIOMMU.

VQUEUE obj is used to represent a virtual command queue (buffer) backed by
an underlying IOMMU command queue to passthrough for VMs to use directly:
for example, NVIDIA's Virtual Command Queue and AMD's Command Buffer.

NVIDIA's CMDQV requires a pair of physical and virtual device Stream IDs
to process ATC invalidation commands by ARM SMMU. So, set/unset_dev_id ops
and ioctls are introduced to VIOMMU.

Also, a passthrough queue has a pair of start and tail pointers/indexes in
the real HW registers, which should be mmaped to user space for hypervisor
to map to VM's mmio region directly. Thus, iommufd needs an mmap op too.

Some todos/opens:
1. Add selftest coverages for new ioctls
2. The mmap needs a way to get viommu_id. Currently it's getting from
   vma->vm_pgoff, which might not be ideal.
3. This series is only verified with a single passthrough device that's
   hehind a physical ARM SMMU. So, devices behind two+ IOMMUs might need
   some additional support (and verifications).
4. Requires for comments from AMD folks to support AMD's vIOMMU feature.

This series is on Github (for review and reference only):
https://github.com/nicolinc/iommufd/commits/vcmdq_user_space-rfc-v1

Real HW tests wre conducted with this QEMU branch:
https://github.com/nicolinc/qemu/commits/wip/iommufd_vcmdq/

Thanks

Nicolin Chen (14):
  iommufd: Move iommufd_object to public iommufd header
  iommufd: Swap _iommufd_object_alloc and __iommufd_object_alloc
  iommufd: Prepare for viommu structures and functions
  iommufd: Add struct iommufd_viommu and iommufd_viommu_ops
  iommufd: Add IOMMUFD_OBJ_VIOMMU and IOMMUFD_CMD_VIOMMU_ALLOC
  iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
  iommufd: Add viommu set/unset_dev_id ops
  iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
  iommufd/selftest: Add IOMMU_VIOMMU_SET_DEV_ID test coverage
  iommufd/selftest: Add IOMMU_TEST_OP_MV_CHECK_DEV_ID
  iommufd: Add struct iommufd_vqueue and its related viommu ops
  iommufd: Add IOMMUFD_OBJ_VQUEUE and IOMMUFD_CMD_VQUEUE_ALLOC
  iommufd: Add mmap infrastructure
  iommu/tegra241-cmdqv: Add user-space use support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  19 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  19 ++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 284 +++++++++++++++++-
 drivers/iommu/iommufd/Makefile                |   3 +-
 drivers/iommu/iommufd/device.c                |  11 +
 drivers/iommu/iommufd/hw_pagetable.c          |   4 +-
 drivers/iommu/iommufd/iommufd_private.h       |  71 +++--
 drivers/iommu/iommufd/iommufd_test.h          |   5 +
 drivers/iommu/iommufd/main.c                  |  69 ++++-
 drivers/iommu/iommufd/selftest.c              | 100 ++++++
 drivers/iommu/iommufd/viommu.c                | 235 +++++++++++++++
 include/linux/iommu.h                         |  16 +
 include/linux/iommufd.h                       | 100 ++++++
 include/uapi/linux/iommufd.h                  |  98 ++++++
 tools/testing/selftests/iommu/iommufd.c       |  44 +++
 tools/testing/selftests/iommu/iommufd_utils.h |  71 +++++
 16 files changed, 1103 insertions(+), 46 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

-- 
2.43.0


