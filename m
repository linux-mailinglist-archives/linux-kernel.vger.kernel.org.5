Return-Path: <linux-kernel+bounces-143566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B58A3AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258E91F21BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502050A72;
	Sat, 13 Apr 2024 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AoauHmyV"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC14C637;
	Sat, 13 Apr 2024 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980088; cv=fail; b=fTLsYSIJGCZTGqgIYBo8L0SoGnPr4D2lGLFIoGvMeB4Wta/yDx1BDG6A/Mr8VSx3zN7SQyI0CXcevutxGRiA0dbltias4k6VIhAAi8r9RTOblfrboH1BSc6zibRATWZgy2csAZ4MPeaLu32vmJ/chdrceNaO0dDP9sijeRa81mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980088; c=relaxed/simple;
	bh=4dlFI4aV5pX9QckYfYQjc8MChm5lTnkVTabsi4DynRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEYBIuFPh4zIcNF9vxkPKguF+OLm7PGmc9wyjQkl/FniCEuBNYJMAjAHhS83Du+s4Ykkzux4aOZN4xNnghjh5VDTRk9hKgczFl4G7GbApd0SPT07geTqgxiZNpkNUUm/G5YnunVCyUOFo7UbwYKK9Fda9YbfwAFhTxIiTB/6YOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AoauHmyV; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqYRRGufEW4KXPyjkRHoz064gjiyJhr86oGenH5InqhlgUvRBvdQFRztYiIOCkt9rwJALSg2gpSQUrOK2eI/nDTgfbYJU3Kq0BCJqNHcll3ARZrWn+zMoKVVcnFQQD0adWRUPDu+BGBlfU5ZxI2e+2Z1oUYKym0foQplAOlTunARG8sOTFrZ6gT7iCbUGizFWS9qsTUrcqXWnXPdteDqGc20nC59CTfsz4zTsWekgKDFaON0wxg8QBKMo03uTNX69yYx82p0kUjWRhhL3dZcP8APlNB8Wo24s/YBzWcCg7InPuCFa6qQGxjmXwxe3XPK8QOpffbd8Rvuh7DoEUyrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMC8czo5pS8hgRcQxbSx/WEGQ3Mts+dEzaDl96epXTU=;
 b=Mm4r96rDN3UIn/x17F385bdh0Dw4KM+AqO2KKvfxTVW9TcpT5Q/JDx53motM5h7uYaPgIHhasjB8f8324IOry1LcfP3yp1gfOHj01Sj3OnlwL6iyXselIJ3NnGRjseZMotChSKPP0T9VHPo0g0WzR44YNJPkZjzWih8g7YfFUzZEok8f3QKFQE/7VcKjqr3j2yI9UEl0fIeZa3p7FnbPFlzkKmWEyeN/9Zmmog+LFkh6FgMJsziPOK/elJ8kZoCJ4JRq25CXVpMHqTWdgnKGZ5nVK+Si4O8E2djYZHvWHmlMldD8CInNGB+Byv49eOgSd/a8bf/pmeFQ6xLTYe6OEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMC8czo5pS8hgRcQxbSx/WEGQ3Mts+dEzaDl96epXTU=;
 b=AoauHmyVkTGl2ICVBnrbysGKPGcQPFty/RyEbAhafvUZ5jH+uXFdy7p3a3ha6aMHKaq3v/LHVWCj57bmUZKB7hoxjoZkwlxpwx7qIy5xWFWCFRZel3OlxHxrpropMyg/F6FPAf/P17SqNJHL6+7XW24rynntZCG6BWMa9AY6ZepRKfWL6j2aNXPa4qn8Ihn3oAno4708tkdcmk0Ls3QiA1ORem4gk3Y7ODXulfnqji53MhSe4IRLI5rUBAlLfqgWwhE/d3VXvePxGWMIC8DlWd+289TGRyge2somPLoPiPgdxaz4hQtUrv57zZJf9L/OFQFGu1xYbHOC5NqLzCG3KQ==
Received: from CH2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610::37) by
 DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Sat, 13 Apr 2024 03:48:03 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::ec) by CH2PR05CA0024.outlook.office365.com
 (2603:10b6:610::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Sat, 13 Apr 2024 03:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:48:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and IOMMUFD_CMD_VQUEUE_ALLOC
Date: Fri, 12 Apr 2024 20:47:09 -0700
Message-ID: <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 221f229c-1e1c-428f-a2ee-08dc5b6c85b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2SOWIW90e53ozw6GZVQysVab0S+TcbRMDArc5Ir8qg96Rd8E7Q4IqZRorOY?=
 =?us-ascii?Q?a7UiaR7kRWKGpEz28ERo7bBoYQUSzH16aDB6/B37A2ooqW8h4YaiZSw6cZPG?=
 =?us-ascii?Q?O0+i7ybYPvtf3O0IC+TwIwFHFmhRvLAc+nWUbYMIaLy1mTFFDvjg4Uexhvg0?=
 =?us-ascii?Q?g3rJ6+9bcE1Ak/zZAYth/dL9EhecYqBB0bx17ykrzHIjv+YljrM2y0CtH4pH?=
 =?us-ascii?Q?JhlNA2M8VyrJJTWxxtAIomldO8DAWL1Cip0WZRPTR3aKKDIGjjJBspydY7BO?=
 =?us-ascii?Q?wmSOO30jtLiWXvCNwjbUxooKOFpPgXHXcmGYt1Ryy9uSe7R9Cn2rZoB0z/w2?=
 =?us-ascii?Q?IXOmGJNky+VOTy0KsqhO44IWlzX/uMs5u+uFHQerlG/4ROOVz5EwmzGJss6n?=
 =?us-ascii?Q?gOgHGXysipQs3l7JqYv4S09lu5N5x7iCJdq/nPfBMGH/uA+WZWFmTi9ot65Q?=
 =?us-ascii?Q?+8DsIaMWQzBJzx/CUIT7+N8EGm0/XbnxxvuqlzrhbXRXhPWGf8GamJYH5TrA?=
 =?us-ascii?Q?yZzwugXVS1UfUpZM3RCnYIsULe+iY5mo9NfRPbQQk2jRtB+tQRjrE5kmIvZp?=
 =?us-ascii?Q?cGbMAqGxOAUQ9PUKdDYblxNKyrkMKc/PH5numsqkLqcO3xJsM2tlIfV0VUg+?=
 =?us-ascii?Q?J6XEx3LbzYCyHIrFbSsEbD4j0ddLQ1mFh7RQTJf/TJouNiqgpbzxz3uH0/mV?=
 =?us-ascii?Q?j3m+itfOyXlC4MEYAgJnPNYfUI82U+MmnUMSsiKLmPzBzF0ykDDXM/AUkT3e?=
 =?us-ascii?Q?elb+Xf5xzKjmen/kVwvR7n0kJ5m+VkqzgUcLhPn1D0bWz/SSMeaWP+I5LxHw?=
 =?us-ascii?Q?pWFRpeEKB+7AzO3tV0QE95RetziTHmhP1IIx5VB+8iQCsDx6VvqI3m2103Ls?=
 =?us-ascii?Q?5fgW6wNlqiRbBa3ID8YTkvOQwRDuNapITH1reb027vPksLqUClBc0l1eIhR9?=
 =?us-ascii?Q?SQbkyEQ4VllyHlIk5jiFLptKoYGikrNE2kfKmlAOgMG58sAluh0t8i9Rbngv?=
 =?us-ascii?Q?1kpvM4RpIcrDkZ0fNj6cto8OEXBoTc85L1hXubxeymnDv1+sHXeOURk4TpkM?=
 =?us-ascii?Q?yxL39Yb2jdPiOaarmurtwCSiByvViTOWqbwRtdGuaiM8dR+kpQIbURyfab0U?=
 =?us-ascii?Q?bGSASRxR33Bb1JvXMc7VbGki35Neldj4U0dqsmnUMe3/fvrC9BUE0bcduLN9?=
 =?us-ascii?Q?vIIsSYQeJ5C7NRiqICGcVIkabhUcgRayjTCXljpgqf8ckXRiBfRYO+kgSccn?=
 =?us-ascii?Q?Px4wOLbiZ3EoNdlSjCTEgGtb43i/8wzS23aypnIOiXe9RksmOnujqDLAq90f?=
 =?us-ascii?Q?9ZXaT+nmJ7IPAWdYJqczRik3lxITgImHOZ4Rl3m4xD5JXrtN/mCamMaPc6b0?=
 =?us-ascii?Q?GBsL55IotFBZN/D3KXpKrCq6nkZQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:48:03.6492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 221f229c-1e1c-428f-a2ee-08dc5b6c85b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

Introduce a new IOMMUFD_OBJ_VQUEU to represent a virtual command queue
instance. And add a new ioctl for user space to allocate it.

As an initial version, ddd IOMMU_VQUEUE_DATA_TEGRA241_CMDQV to the enum
iommu_vqueue_data_type and the corresponding iommu_vqueue_tegra241_cmdqv
data structure.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  2 +
 drivers/iommu/iommufd/main.c            |  6 +++
 drivers/iommu/iommufd/viommu.c          | 72 +++++++++++++++++++++++++
 include/linux/iommufd.h                 |  1 +
 include/uapi/linux/iommufd.h            | 48 +++++++++++++++++
 5 files changed, 129 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ba8f4ecc221..c994f2db3052 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -436,6 +436,8 @@ iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
 int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_viommu_set_device_id(struct iommufd_ucmd *ucmd);
+int iommufd_vqueue_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_vqueue_destroy(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 16efc3346a2a..96ef81530809 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -324,6 +324,7 @@ union ucmd_buffer {
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_vqueue_alloc vqueue;
 	struct iommu_ioas_copy ioas_copy;
 	struct iommu_ioas_iova_ranges iova_ranges;
 	struct iommu_ioas_map map;
@@ -383,6 +384,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_viommu_alloc, out_viommu_id),
 	IOCTL_OP(IOMMU_VIOMMU_SET_DEV_ID, iommufd_viommu_set_device_id,
 		 struct iommu_viommu_set_dev_id, id),
+	IOCTL_OP(IOMMU_VQUEUE_ALLOC, iommufd_vqueue_alloc_ioctl,
+		 struct iommu_vqueue_alloc, data_uptr),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -518,6 +521,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
 	},
+	[IOMMUFD_OBJ_VQUEUE] = {
+		.destroy = iommufd_vqueue_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 8894878c1e73..56c9ea818bfa 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -161,3 +161,75 @@ int iommufd_viommu_set_device_id(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 	return rc;
 }
+
+void iommufd_vqueue_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vqueue *vqueue =
+		container_of(obj, struct iommufd_vqueue, obj);
+	struct iommufd_viommu *viommu = vqueue->viommu;
+
+	if (viommu->ops->vqueue_free)
+		viommu->ops->vqueue_free(vqueue);
+	refcount_dec(&viommu->obj.users);
+}
+
+int iommufd_vqueue_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vqueue_alloc *cmd = ucmd->cmd;
+	const struct iommu_user_data user_data = {
+		.type = cmd->data_type,
+		.uptr = u64_to_user_ptr(cmd->data_uptr),
+		.len = cmd->data_len,
+	};
+	struct iommufd_vqueue *vqueue;
+	struct iommufd_viommu *viommu;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+	if (!cmd->data_len)
+		return -EINVAL;
+
+	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
+	if (IS_ERR(viommu))
+		return PTR_ERR(viommu);
+
+	if (!viommu->ops || !viommu->ops->vqueue_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_viommu;
+	}
+
+	vqueue = viommu->ops->vqueue_alloc(
+		viommu, user_data.len ? &user_data : NULL);
+	if (IS_ERR(vqueue)) {
+		rc = PTR_ERR(vqueue);
+		goto out_put_viommu;
+	}
+
+	/* iommufd_object_finalize will store the vqueue->obj.id */
+	rc = xa_alloc(&ucmd->ictx->objects, &vqueue->obj.id, XA_ZERO_ENTRY,
+		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_free;
+
+	vqueue->obj.type = IOMMUFD_OBJ_VQUEUE;
+
+	vqueue->ictx = ucmd->ictx;
+	vqueue->viommu = viommu;
+	cmd->out_vqueue_id = vqueue->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_erase_xa;
+	iommufd_object_finalize(ucmd->ictx, &vqueue->obj);
+	refcount_inc(&viommu->obj.users);
+	goto out_put_viommu;
+
+out_erase_xa:
+	xa_erase(&ucmd->ictx->objects, vqueue->obj.id);
+out_free:
+	if (viommu->ops->vqueue_free)
+		viommu->ops->vqueue_free(vqueue);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &viommu->obj);
+	return rc;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5b97b04aa145..707b6d4b20a3 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -31,6 +31,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
 	IOMMUFD_OBJ_VIOMMU,
+	IOMMUFD_OBJ_VQUEUE,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index eaa192de63d3..95abe3100e3b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE,
 	IOMMUFD_CMD_VIOMMU_ALLOC,
 	IOMMUFD_CMD_VIOMMU_SET_DEV_ID,
+	IOMMUFD_CMD_VQUEUE_ALLOC,
 };
 
 /**
@@ -742,4 +743,51 @@ struct iommu_viommu_set_dev_id {
 	__aligned_u64 id;
 };
 #define IOMMU_VIOMMU_SET_DEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_DEV_ID)
+
+/**
+ * struct iommu_vqueue_tegra241_cmdqv - NVIDIA Tegra241's Virtual Command Queue
+ *                                      for its CMDQV Extension for ARM SMMUv3
+ *                                      (IOMMU_VQUEUE_DATA_TEGRA241_CMDQV)
+ * @vcmdq_id: logical ID of a virtual command queue in the VIOMMU instance
+ * @vcmdq_log2size: (1 << @vcmdq_log2size) will be the size of the vcmdq
+ * @vcmdq_base: guest physical address (IPA) to the vcmdq base address
+ */
+struct iommu_vqueue_tegra241_cmdqv {
+	__u32 vcmdq_id;
+	__u32 vcmdq_log2size;
+	__aligned_u64 vcmdq_base;
+};
+
+/**
+ * enum iommu_vqueue_data_type - VQUEUE Data Type
+ * @IOMMU_VQUEUE_DATA_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
+ */
+enum iommu_vqueue_data_type {
+	IOMMU_VQUEUE_DATA_TEGRA241_CMDQV,
+};
+
+/**
+ * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
+ * @size: sizeof(struct iommu_vqueue_alloc)
+ * @flags: Must be 0
+ * @viommu_id: viommu ID to associate the virtual queue with
+ * @out_vqueue_id: The ID of the new virtual queue
+ * @data_type: One of enum iommu_vqueue_data_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
+ *
+ * Allocate an virtual queue object for driver-specific HW-accelerated queue
+ */
+
+struct iommu_vqueue_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 viommu_id;
+	__u32 out_vqueue_id;
+	__u32 data_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
+};
+#define IOMMU_VQUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VQUEUE_ALLOC)
+
 #endif
-- 
2.43.0


