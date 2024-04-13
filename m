Return-Path: <linux-kernel+bounces-143562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B758A3ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10521F21907
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9563F8C7;
	Sat, 13 Apr 2024 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7hRhHrk"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC829408;
	Sat, 13 Apr 2024 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980079; cv=fail; b=oc1wCv9LBimv0dP9T2IAh8qUE9A2AlkRQB7rA6wkmO5rKi4bB5rghEBPo5mpGVW36h3IRTxUwORvRv4FSYRuDxPE2mYVzPJh44bRHoadH9GvQ/52iYhnnG5Pn8zMm/cNHx5sZdx1oi0tYVDlf7oylS6oQlMO8dZJedDehI+JF3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980079; c=relaxed/simple;
	bh=cLv7bhpyMdlQeiFfVZvMYh4oTufqbXUehbwC/976GpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yx8AYNNJVd7hCB/c08Mt6QHTCJqf2h3FVexSUBdqfOsK4Hs0DLwTw0/AuqSdukvSaojwIbx2OVCAXiGud9jQNHdLq1zlwD1wcwZBBqV/IqFqjV7e77P7u2K7Es84LYBtwIWiS4iiv7IXUq0nlJImdzlt3QP6jd2HfDDWstkpbiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7hRhHrk; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZLHE1B3hYZ+Tj35N8hjZKoIquWQxqhnT/wYS0z+yIIk6Wnyc2OhUMdNqUcFxkkIS8LwX6l0Nou0s6Xmrh1O1f1Nq49fu5FXK6EUiqIsfcvFuELAG8hhUHfoHAiImobXNohTdOKamYn/0zpX70ilfUmk8MB2DqW7ysNykLkytaLX/FyAdjf41ETVkwZ191Pv34P1DWnA+QDiJPYPNTNPMXdsm72U7m+toApZ1G10t1PPJOQgmXTlkZkrIzmuN7JYlSgZKwSLhos3nF9/rOYkw8e00iXFklxcBDjli11Tje3KMJdiOk42dOR1i+ikV35Lb6J1vD6Iu31dePFVotgPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzZqrFppC6X7toG0TEeFer/MB5b6m3HHjcTbrrHF9RY=;
 b=iZVsXMITARiqzmtUvYMumV1bsYqy3jMDpBk1+3GCyZFU8+LkRKvn9wAazfB59qChbg9pbwRPv0NR7fARN2j/FVHi5X8evnG+i7LfMfU5vKecZrM1MntCk/psSEVjH2s/Yw4OaZzYMEF8cxrPORy9X8axqYAlXTleQ9fszqn8aoLlZV88znq1yk10UplurutDXJYd5XCG+asVhipOADCBjo96ELgGKco1jRpeNdHQ+AB3pzg+uuctlVLtKtXgqhk8iB1CQ18SrKE1LGBOHz1M305YXfLgwIl3DaB9xwtLXXKbl7n9mnOyajblesG5q7wnKLm115Xnv8woFSs+H8mSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzZqrFppC6X7toG0TEeFer/MB5b6m3HHjcTbrrHF9RY=;
 b=d7hRhHrkOGj24MJmBet4Gg0p4VNXcHrkE7B2FUdCSsGkz6sz8FfPzr/loQBqJ5K/v69XUezCadUPGE4KaecG35JJUwuJqEoS/qTFcck438/T/hXK7LrE+HsSje764NTTpS1WXrPeIaNzKBMiuuFdSTG7Gss46WAxQxxgHBXYNVawhsr7uduyUOIbutEcc3t8BGaVmNzVWs04jA6HsBBdv5SQEfLHTp7BlyYqJoJeYMXwVa8gl17JNCdttK3HNiXtnqY/u8l3KjdsgKfO55wZa7h4836Ln+l3lbw6sT+lLUZSogGrK4E2CYiqYzJvh5m5etDjRxy9nVz1AQsgZZT6YQ==
Received: from BL1P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::19)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:47:54 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::aa) by BL1P221CA0005.outlook.office365.com
 (2603:10b6:208:2c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:47:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 05/14] iommufd: Add IOMMUFD_OBJ_VIOMMU and IOMMUFD_CMD_VIOMMU_ALLOC
Date: Fri, 12 Apr 2024 20:47:02 -0700
Message-ID: <3aa9bc1df6a2ee58a03c6ea6ededbc210a2d23a8.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 17023489-6d24-4a6a-e17b-08dc5b6c8059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EEs+9QuF7f7lESZgkrqjvNRWpQZsMOKSJbefk73CxbnRnfLneCTTMLEEHhI?=
 =?us-ascii?Q?hMYRSoyGfkQ4i4TKfVD2MZkJzkLVo6/WII1ez/ORCR8YCpqimm+1sw1evHU+?=
 =?us-ascii?Q?z1aJxR2R/pBsoAv2HAVEGDjwH/KFdKVhLX4TUGrBuoNc2FYytsK70fFe0d/T?=
 =?us-ascii?Q?E2A0MCcn8WsmLmK4oZpUMPM7yIarqD5icFp0UtUSq+q3Gvz/yMIHy8aJ3EJh?=
 =?us-ascii?Q?GbJlU19EiyFxMOM4CDdIavk6ggZHeRN8vf1qc89UlAfYafrZWNd+iblvBZqX?=
 =?us-ascii?Q?r1ybKAwgqoqQB3sXQ1S44748qRofKif30GkB1MKtuKw02wRp+ex1X4SFvj7/?=
 =?us-ascii?Q?K7uup5OD8Bze0OKBrlWhvENLDeD/wr9Le265/szNm+zUHmY0an3bkX0ZKZji?=
 =?us-ascii?Q?NZeNOPfKeKvBonmyPz24gn+bm8f/iu+hoFz+FHb90iV4h/5WLmFeZi0ZgkO6?=
 =?us-ascii?Q?DgiNT3DCnE1ptielbiRJNlGtKwSvV5V8C+7qgREXVBczsupwTY2jOhGPDWqz?=
 =?us-ascii?Q?W93QK8H4D9OI7B67s3HVF2qZoaFmzCQFu6SR9nz9W5/FzMMWcAGEXritIc7D?=
 =?us-ascii?Q?ttUDfSIEltmHNka0sMaKKj/Qwem3Ws89JPoGD30OHlcaYzz1djNc6il0FBF8?=
 =?us-ascii?Q?2ajB1/14rginS+3nlPnfttB0sTYoVTBHWa6isPrcHu7/L5n+4kKusdk8d+vh?=
 =?us-ascii?Q?Dfz+um3K/gdUnh7PdchHaN8vuyWlwbKH8alTQisRs2GGCv1iL5lDVqRHKN+a?=
 =?us-ascii?Q?v/zquG8ChoqYV4bE9l6AVsWh07jUAkZN1xLndLNvW3IIhnoZVtVziJvlkvbr?=
 =?us-ascii?Q?LAjiEa0W6uiFA6RyLhzkWnbD2Lr1vPs+zVzp2xPv7SPB+9in1IqUpL35T6oJ?=
 =?us-ascii?Q?8bT+WjgUMmc2uLuNW5x/S8lDTculRbUhzkQTuzzldY6o1gZTNula/aDWA6PK?=
 =?us-ascii?Q?10rXMXagPxsYSDQ/Q2Iv45dqfOPZLFC6YlrKPWPxo/bf/pcguGqqNfIsa/b4?=
 =?us-ascii?Q?F8DP0onZSjPDcV1JjcLMaOFYyg3q3ayfJJqfYWLgRL8vsWkNoSK+P9UOPplA?=
 =?us-ascii?Q?SX0UEl4yPwZqeiHF8m8wyGarKCjX8/fIfHcJdgIFy/BNkrBp6mxKV1G3Mi4U?=
 =?us-ascii?Q?8oGIWyBV8N4R13Qys5LSQzOj2YMFQGoxcgrrIeGuGC7h2vHvw2/mXk1UDvNP?=
 =?us-ascii?Q?lflCrBebz/1aX4yKX+YFofxM64HusC28bxo3tlGQvpKKeMGak57qbV5JQkWI?=
 =?us-ascii?Q?DNOHOSxxsnZhlHy9+Ix5rof5eqST9Edq+IbL+346gLpHe2IsniPMK/zGuHhx?=
 =?us-ascii?Q?aTa6XG71QAlu57/lXcpCfgDI0a+7ChPoCycO8azQRzJbj0rpN8fGNhZBQ40l?=
 =?us-ascii?Q?R40IPwXzNKdALZ+I5JNWZnQsFKx2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:54.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17023489-6d24-4a6a-e17b-08dc5b6c8059
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988

Corresponding to the new iommufd_viommu core structure that represents a
vIOMMU instance in the user space for HW-accelerated features, add a new
IOMMUFD_OBJ_VIOMMU and its ioctl for user space to allocate it.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  3 +
 drivers/iommu/iommufd/main.c            |  6 ++
 drivers/iommu/iommufd/viommu.c          | 83 +++++++++++++++++++++++++
 include/linux/iommufd.h                 |  1 +
 include/uapi/linux/iommufd.h            | 30 +++++++++
 5 files changed, 123 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eccc565ed38e..ae90b4493109 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -424,6 +424,9 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
+void iommufd_viommu_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 5187942b375d..9de7e3e63ce4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -323,6 +323,7 @@ union ucmd_buffer {
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
+	struct iommu_viommu_alloc viommu;
 	struct iommu_ioas_copy ioas_copy;
 	struct iommu_ioas_iova_ranges iova_ranges;
 	struct iommu_ioas_map map;
@@ -378,6 +379,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
+		 struct iommu_viommu_alloc, out_viommu_id),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -510,6 +513,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
+	[IOMMUFD_OBJ_VIOMMU] = {
+		.destroy = iommufd_viommu_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 3886b1dd1f13..079e0ff79942 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -19,3 +19,86 @@
 	}
 
 viommu_struct_alloc(viommu);
+
+void iommufd_viommu_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_viommu *viommu =
+		container_of(obj, struct iommufd_viommu, obj);
+
+	if (viommu->ops && viommu->ops->free)
+		viommu->ops->free(viommu);
+	refcount_dec(&viommu->hwpt->common.obj.users);
+}
+
+int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_viommu_alloc *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommu_device *iommu_dev;
+	struct iommufd_viommu *viommu;
+	struct iommufd_device *idev;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	iommu_dev = idev->dev->iommu->iommu_dev;
+
+	if (!iommu_dev->ops->viommu_alloc) {
+		rc = -EOPNOTSUPP;
+		goto out_put_idev;
+	}
+
+	hwpt_paging = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_paging)) {
+		rc = PTR_ERR(hwpt_paging);
+		goto out_put_idev;
+	}
+
+	if (!hwpt_paging->nest_parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	viommu = iommu_dev->ops->viommu_alloc(idev->dev, cmd->type,
+					      hwpt_paging->common.domain);
+	if (IS_ERR(viommu)) {
+		rc = PTR_ERR(viommu);
+		goto out_put_hwpt;
+	}
+
+	/* iommufd_object_finalize will store the viommu->obj.id */
+	rc = xa_alloc(&ucmd->ictx->objects, &viommu->obj.id, XA_ZERO_ENTRY,
+		      xa_limit_31b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_free;
+
+	viommu->obj.type = IOMMUFD_OBJ_VIOMMU;
+	viommu->type = cmd->type;
+
+	viommu->ictx = ucmd->ictx;
+	viommu->hwpt = hwpt_paging;
+	viommu->iommu_dev = idev->dev->iommu->iommu_dev;
+	cmd->out_viommu_id = viommu->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_erase_xa;
+	iommufd_object_finalize(ucmd->ictx, &viommu->obj);
+	refcount_inc(&viommu->hwpt->common.obj.users);
+	goto out_put_hwpt;
+
+out_erase_xa:
+	xa_erase(&ucmd->ictx->objects, viommu->obj.id);
+out_free:
+	if (viommu->ops && viommu->ops->free)
+		viommu->ops->free(viommu);
+	kfree(viommu);
+out_put_hwpt:
+	iommufd_put_object(ucmd->ictx, &hwpt_paging->common.obj);
+out_put_idev:
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+	return rc;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 650acfac307a..dec10c6bb261 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -28,6 +28,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+	IOMMUFD_OBJ_VIOMMU,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..2b0825d69846 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -50,6 +50,7 @@ enum {
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_VIOMMU_ALLOC,
 };
 
 /**
@@ -692,4 +693,33 @@ struct iommu_hwpt_invalidate {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * enum iommu_viommu_type - VIOMMU Type
+ * @IOMMU_VIOMMU_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV Extension for SMMUv3
+ */
+enum iommu_viommu_type {
+	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
+};
+
+/**
+ * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
+ * @size: sizeof(struct iommu_viommu_alloc)
+ * @flags: Must be 0
+ * @type: Type of the VIOMMU object. Must be defined in enum iommu_viommu_type
+ * @dev_id: The device to allocate this virtual IOMMU for
+ * @hwpt_id: ID of a nested parent HWPT
+ * @out_viommu_id: Output virtual IOMMU ID for the allocated object
+ *
+ * Allocate an virtual IOMMU object that holds a (shared) nested parent HWPT
+ */
+struct iommu_viommu_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 type;
+	__u32 dev_id;
+	__u32 hwpt_id;
+	__u32 out_viommu_id;
+};
+#define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
 #endif
-- 
2.43.0


