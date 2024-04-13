Return-Path: <linux-kernel+bounces-143563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160D8A3ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6728EB20CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BCC1BDCD;
	Sat, 13 Apr 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAGrEZtg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA71C6B5;
	Sat, 13 Apr 2024 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980080; cv=fail; b=sCsZ0Ji3gwZf3IGy/lmRZWqTVOzdzKJaNH02++u0VwmnCbUo3EqW+OUJ44i16qbmkwRiGV06P1oG8K08+Ht/fFNlvKLqLsfy9WXUXwAMJAU7nRiUl9nWv7kcTjPDcAjKzQxyNWAfEs2MWUAQen9oN6c9E7tqclae1n6ay9zFgBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980080; c=relaxed/simple;
	bh=b3xjtLDLuRco/bZKSRDXk/br/n9W7PT/dCx6/PVDIf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k97DW3F7rp99tYYN7ECeed/2DbmzPcZIwH0l1rZ6/jvfTTiujKycanIka6n6QvqDqHcaONsiUK4IGjYDVlaUci74AkeNTV/1GiCF8wnuUTE4JMkdoKmTsyESpLli14p1dO+acu5S+6q0Q257BL1++bH1NvyP34KZOmD0NoGkTnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IAGrEZtg; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHGWwLZziLavYp5LUlLLSROonbTxZ6ySsmTCXWO9eCSqySQAmtKn6DPI2W5hwwtgiMxnQKt337PjzoBmRD2Tj96iAIlWQjKs0oE1ahRxqn8+5QjeaYXsuvYnqGILw6NdaO+TYDvx5CwuInwVekAbSQEAXv0FE+7eMKB2qjkS05YbBfQzcr+muQagckxfynGIK1++lTcaKHZRBaEvxE6s70LLD3XLY0wDTbBwxLnv1i+YUwGHFP9naHaDfZRK0t3Nfvi1xfF+4dGhm7ayHd5XFqzZiqcDwQfNaNvT01PkJXhtWJ9/8YfaepZ3X9Ce1bkdqSsjJ94LqK8Ejm+PHOGKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqfqFp82lmsFd1lLg/Xv9Jkby6Fi89A91ad5ECMSq0Y=;
 b=MPuJ3lMX7fq+8tu+ul+DBxFu2iDpN2youWmelU2jt/jVYSzILt8aTvSPEUEDKaSItwWKqwcxEISii0oS0L3+rTK+6/HT58YCLqDOwTjSWlwWEvqa3HDUzHb5nupvI0pJUV8EM5Oow2A5xiJr6QHvt9moJkLFw+xBqvC7Z9i87DucJR4TMDUlVVlSp0p8CHL8dBh42V0AADBiwHZiIKrAHnQVm/0di3XBgDQd/siOJRBJwRdPEADS+bp4Lk9fYb/RuU7H2ZepbjXp14wfcxftPv82Vg8IDkihvIyPlXR9nrddjyrXBgfZvZshWw7jBOuI9hgzx6uspZfqwnRNyy9ZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqfqFp82lmsFd1lLg/Xv9Jkby6Fi89A91ad5ECMSq0Y=;
 b=IAGrEZtg7Rf728es/3vkGE9PEyu17zLo6AIWmCsJBnN5h3p+cJVzFcWA+0J2RpIkb+xaoQ0zziFTJP8jaciwkCDmFbuvsDg9V7708qPnOuiAd7zDIBQNh0ePrn2wx0uVn4vFhRJTi32sx0vSah8ILUn7UAD4DHZzPUfzL+cR5eNw7s942c8TbgWwPSPGnkYvYgyHlhbgDaj0oCLecQ0rlDfThR9E2zuuI/0wsnMntJw0QAvwMo/kS+jN/x+btFFKBlly3WmtJNUeaVBvbKWsino+QNcdegDGVYfmf+FGmGR0AbeuZw6FkmUpJ5pe4nybkqF3FoLonnxpZc5ngPkFXA==
Received: from CH2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610::29) by
 DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Sat, 13 Apr 2024 03:47:54 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::5d) by CH2PR05CA0016.outlook.office365.com
 (2603:10b6:610::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.16 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:47:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Date: Fri, 12 Apr 2024 20:47:05 -0700
Message-ID: <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 67439758-7edd-4b8d-1041-08dc5b6c8010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wrGZXr4wIkAv8BUJkKt/WqQwC8xhjCj7Ks/CvXu/5CowVvxnsuad1iFBJWHE2Y9xsSBHkIr83TS5ptf7ujtZ0ialNzLBEZ+/BwkhvJRYeN8JaQXBeLY45suvCYpYXW1R7F3yTjLPlj0tBXPXAnXXz/Lsj3r7qm9ZO/nUmWTi15LOzq9kAd7NhNfjX4kihbv11mSY4njKC0Mq0hJlzaSWQCxhMwfBJBZ7GAVQd4NjkbW+nW4ue2V0i9h+RTKz/hu02sHY2Djxg6v4gmcuI3NIvIUA/GPvNH3YQn46NFTGS/3EYVBqVfZThOGKxU+vUTOC1QhyMMvurEZ+gpBbTgzyy5M8MHPfVO7rQQEeFk7o+N2i6+9/XmirWdIFs2BCtOAO7JjGgQ2Ckh1KSc8HxrDk8bmdRGiXh0tM/fmWU9jjEZXn3HJ8k9Ih89KAcLEmjaBazToUifn8evfW/mgeHUWzLdRJeBMIz6HseURTcZglwdFGJRFANtbN17XkjE2pPhYRZsPfAZ8pWOjJ/QlOYUffyGSIHW6AnXVX7djkfhhG0Bau9zVliP9kdu3zVTaU+ewFTNgJZiOZmmfZWmMkGFPt7GJNzJ68X8InRx5lxw9b9R341Sece67k4YmfVCWExUpUnVVUDANgkUQY8YJmQXvImn7Fsc4tobFAuwmdM85+zEcTjjjbSvxqXwslhJaCLFYjNCEw7e7yHPosS0Olgwlvt6/etGYLLFZhx/KxUObKAjlEiFa4fOsvhICZOuXxqFzS
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:54.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67439758-7edd-4b8d-1041-08dc5b6c8010
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

Introduce a new ioctl to set a per-viommu device virtual id that should be
linked to the physical device id (or just a struct device pointer).

Since a viommu (user space IOMMU instance) can have multiple devices while
it's not ideal to confine a device to one single user space IOMMU instance
either, these two shouldn't just do a 1:1 mapping. Add two xarrays in their
structures to bind them bidirectionally.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 11 +++++
 drivers/iommu/iommufd/iommufd_private.h | 10 +++++
 drivers/iommu/iommufd/main.c            |  2 +
 drivers/iommu/iommufd/viommu.c          | 58 +++++++++++++++++++++++++
 include/linux/iommufd.h                 |  2 +
 include/uapi/linux/iommufd.h            | 20 +++++++++
 6 files changed, 103 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..68086f3074b6 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -135,7 +135,16 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
+	struct iommufd_viommu *viommu;
+	unsigned long index;
 
+	xa_for_each(&idev->viommus, index, viommu) {
+		if (viommu->ops->unset_dev_id)
+			viommu->ops->unset_dev_id(viommu, idev->dev);
+		xa_erase(&viommu->idevs, idev->obj.id);
+		xa_erase(&idev->viommus, index);
+	}
+	xa_destroy(&idev->viommus);
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
@@ -216,6 +225,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
 
+	xa_init_flags(&idev->viommus, XA_FLAGS_ALLOC1);
+
 	/*
 	 * If the caller fails after this success it must call
 	 * iommufd_unbind_device() which is safe since we hold this refcount.
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index ae90b4493109..9ba8f4ecc221 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -392,6 +392,7 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	struct xarray viommus;
 	bool enforce_cache_coherency;
 };
 
@@ -424,8 +425,17 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+static inline struct iommufd_viommu *
+iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_VIOMMU),
+			    struct iommufd_viommu, obj);
+}
+
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
+int iommufd_viommu_set_device_id(struct iommufd_ucmd *ucmd);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9de7e3e63ce4..16efc3346a2a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -381,6 +381,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_VIOMMU_SET_DEV_ID, iommufd_viommu_set_device_id,
+		 struct iommu_viommu_set_dev_id, id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 079e0ff79942..71baca0c75de 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -69,6 +69,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		rc = PTR_ERR(viommu);
 		goto out_put_hwpt;
 	}
+	xa_init_flags(&viommu->idevs, XA_FLAGS_ALLOC1);
 
 	/* iommufd_object_finalize will store the viommu->obj.id */
 	rc = xa_alloc(&ucmd->ictx->objects, &viommu->obj.id, XA_ZERO_ENTRY,
@@ -102,3 +103,60 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+int iommufd_viommu_set_device_id(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_set_dev_id *cmd = ucmd->cmd;
+	unsigned int dev_id, viommu_id;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	int rc;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	dev_id = idev->obj.id;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_idev;
+	}
+
+	if (viommu->iommu_dev != idev->dev->iommu->iommu_dev) {
+		rc = -EINVAL;
+		goto out_put_viommu;
+	}
+
+	if (!viommu->ops->set_dev_id || !viommu->ops->unset_dev_id) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	rc = xa_alloc(&idev->viommus, &viommu_id, viommu,
+		      XA_LIMIT(viommu->obj.id, viommu->obj.id),
+		      GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_put_viommu;
+
+	rc = xa_alloc(&viommu->idevs, &dev_id, idev,
+		      XA_LIMIT(dev_id, dev_id), GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_xa_erase_viommu;
+
+	rc = viommu->ops->set_dev_id(viommu, idev->dev, cmd->id);
+	if (rc)
+		goto out_xa_erase_idev;
+
+	goto out_put_viommu;
+
+out_xa_erase_idev:
+	xa_erase(&viommu->idevs, idev->obj.id);
+out_xa_erase_viommu:
+	xa_erase(&idev->viommus, viommu->obj.id);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ca6ac8a1ffd0..2be302b82f47 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/refcount.h>
+#include <linux/xarray.h>
 
 struct device;
 struct iommufd_device;
@@ -88,6 +89,7 @@ struct iommufd_viommu {
 	const struct iommufd_viommu_ops *ops;
 
 	unsigned int type;
+	struct xarray idevs;
 };
 
 /**
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2b0825d69846..eaa192de63d3 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
 	IOMMUFD_CMD_VIOMMU_ALLOC,
+	IOMMUFD_CMD_VIOMMU_SET_DEV_ID,
 };
 
 /**
@@ -722,4 +723,23 @@ struct iommu_viommu_alloc {
 	__u32 out_viommu_id;
 };
 #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
+
+/**
+ * struct iommu_viommu_set_dev_id - ioctl(IOMMU_VIOMMU_SET_DEV_ID)
+ * @size: sizeof(struct iommu_viommu_set_dev_id)
+ * @viommu_id: viommu ID to associate with the device to store its virtual ID
+ * @dev_id: device ID to set a device virtual ID
+ * @__reserved: Must be 0
+ * @id: Device virtual ID
+ *
+ * Set a viommu-specific virtual ID of a device
+ */
+struct iommu_viommu_set_dev_id {
+	__u32 size;
+	__u32 viommu_id;
+	__u32 dev_id;
+	__u32 __reserved;
+	__aligned_u64 id;
+};
+#define IOMMU_VIOMMU_SET_DEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_DEV_ID)
 #endif
-- 
2.43.0


