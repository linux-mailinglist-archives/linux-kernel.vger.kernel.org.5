Return-Path: <linux-kernel+bounces-143560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F188A3AD7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2461F21906
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF53C46B;
	Sat, 13 Apr 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZNh90z/"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DBC1D54F;
	Sat, 13 Apr 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980078; cv=fail; b=qSz6txlYbvc7JB8v3jOPAFAFgrsHNY+HRKr4AfiCVCXPL8xsvrYzwfAMlEckFmlYA7RUG4hd9rQQJtpYetrZIGANiov6Jq2ZwBE2bhCTz+Xv35Mu1ajxgrAHNev/dr92flx8tQpMpVujRcd/3ew0+60nqTkbclz/zzZyy14/BaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980078; c=relaxed/simple;
	bh=qfpSQwI3u/KzQj7hXio8OJzg65RizE+jocoCl32aukY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tt0bOLPovjVY3hAXBiW/LQydIFz8dLi/X5QbRTsI1DiYpL16GJQXqinC14ly2Ow1PenZC4W40wm5bE04NndeN1tjkOO3o1WSWoMnSgaS8KA0CI49K/lWL9Wg10bZokm7F9wSDPlY/Npbi+iZ5yp5rWisawIdh9YwhmvAsK1Eiss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZNh90z/; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPDItA3SXSx9+/Z8JHuBhGjqHiY/yhvvixWiyxtkkWBxfvA5xJAZRlU4rfHls6RHJkSeRgsuU8deFUOOxPPIJQzNQntaJG+vykJDM1cttLNeNaf1X8W7rdVcR1zwat4HrykVioh2JbOuU7DkEPOqqw62vcngnvwDWsG5nOFdpaIX3VCVlst/jnt3K//VRyc7DxAcLH2VDkFDnh5lmgt8Jcr/87biQ0GBINIcG4cP7WTVnM6t3Qzm27sdse++ukS8+OdFt1G9n/y8oNfsm3U20QwHe5n1WFSD6kOju1rES9svEhUmqC26evvopz9lOt7A9qpRkMtEKabmBQ2R9wCihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KfnMJPeoOw7WPhSw5/zh2OX8v4sdRkl/zxthe1/+3k=;
 b=SwcAZ1xdp+Yjz5QUiHMge/p3+sq5qWfJXEcMVGov/XkACyhjmd6nFmtQQnK978JGVr51RCqRscSyb52IYyEv1OZzs3D0aIJML4BaX7cIFTmIAXB2LKtN5dfM33DlmP8MrEvldc4uLn7Fad/LgGjoAF4oS8wkv4RHSCwCl5ge/8hk43xgoetOg3sMJUehCVm2FMq51Rnq8T2lrLLAbw6UJ6zDviQkot8apHjHkobbihvKznwEzb5xw4pEx7H4UbHXCXN8+HZid88U7A5mkVBppyAqlt34zsJsX58LUEtI0JUcp5/XCgBvxIOgaTBIUDOG5rLUKHOZXFkHnRJqN310PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KfnMJPeoOw7WPhSw5/zh2OX8v4sdRkl/zxthe1/+3k=;
 b=gZNh90z/76zeh20mXjst/EK3Ti8eUQePCbXYVpCIMgSJJQJ3PED+RIz3FFmTsJj0Zzn0/jCRgTDisoghtiqEmlK4FNVquzir7yRfSNtV50CzIGXspOD9uJhwMg+5SoKLisFpiTx+JE5ezXUINnhhXZ1s5Co5BcL6aQZt+AqAFMg42OASLv+eYh0YWodXsEXhqSpKkH2x5hMHTZph74NweP+Xnhm+0e2vvchcWqHwhE8A/A6092paz93MNgqX1Pn8gRIIKi6D0mZkyGIOkMoDkORT+Jv64ZX5bl0gona9TzJhsebk5CcruyIv3oewkq1/KWK2dHfQ2ceJv5g5Zd2hrg==
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:47:51 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::5c) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:47:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 02/14] iommufd: Swap _iommufd_object_alloc and __iommufd_object_alloc
Date: Fri, 12 Apr 2024 20:46:59 -0700
Message-ID: <43bab81816a7bb08fde868a43d62c439ede91f9f.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: f60fc3fd-a296-4e40-0f77-08dc5b6c7e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hbuBZT0FA46toSL0yCvZW46TdfV0/IULjmqcMxoQora/p29N/33zJpbW80ce4X5g6wEBoZBvU4EA7jKUX6/1eOfT7lZ2d2ZYBdatzUdqms/LGRwky6zx6DZD91R82IcAxGv/3axv/lL1Vw4d+S9P75GKC1WUiVe+kEqr46Ta+u0vU6cZKHyxIQWsXDM7d0G/v+tBdro24DlWf7v4/Bxg2AK4X8dtqZUlSxIsCSB1aMFY57lvWrx5sRWzaN3lC8XFcYM/uyXaj4E+3qj4xULWkG6hunrbikupEI5gbUI5k3JrX9pKz+29jn1VuEqGKn2+0vAer3qFBSjC+mT4334redOqCL81lWTb/5n/pITSlMmFTBxvFOFUNYKnFn9e7azGy4gCLd07rAhGb+k1smpCQQN5Ma0VM7uQHjr7U9zrImmCCictADZOz+NXZAPC9mHneDfp3AHWTMDaCg7RR6qMq1yHGpoZZ82hA/u40gevQrIkoC80ggTdL7AXkMJS76ctx+WjR/RTxa3oDXIIBA1DoPyPF3WrlI87gJoIkPm/0UGyYv1irbNU8fCh/Q5CMUvPQfzSYRiBW9zqDyXF1qK6tUecD7H2bf+U5I/fyqOYlMfX5kd8Sy5xsJ+bwAlJ3ReNU5XvTGV2HShuh611El1xYIYtILiQHX4Wid6wnmt0Lp0rJ1Ysf4yNdlrjDMQvklffrzFD2VBCUHdS9ZZQdfGUUBEe4dUgYZgmMUNNC/+9tc2e51c7wIuRJnJlltcvmczr
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:50.8362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60fc3fd-a296-4e40-0f77-08dc5b6c7e20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

Currently, the object allocation function calls:
level-0: iommufd_object_alloc()
level-1:     ___iommufd_object_alloc()
level-2:         _iommufd_object_alloc()

So the level-1 and level-2 look inverted.

As the following change will add another level-3 helper, to make it clear:
level-0: iommufd_object_alloc()
level-1:     _iommufd_object_alloc()
level-2:         __iommufd_object_alloc()
level-3:             ___iommufd_object_alloc()

Swap the names of the level-1 and level-2 functions.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    |  4 ++--
 drivers/iommu/iommufd/iommufd_private.h | 12 ++++++------
 drivers/iommu/iommufd/main.c            |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..111b8154cce8 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -115,7 +115,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (flags & ~valid_flags)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	hwpt_paging = __iommufd_object_alloc(
+	hwpt_paging = _iommufd_object_alloc(
 		ictx, hwpt_paging, IOMMUFD_OBJ_HWPT_PAGING, common.obj);
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
@@ -218,7 +218,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	if (parent->auto_domain || !parent->nest_parent)
 		return ERR_PTR(-EINVAL);
 
-	hwpt_nested = __iommufd_object_alloc(
+	hwpt_nested = _iommufd_object_alloc(
 		ictx, hwpt_nested, IOMMUFD_OBJ_HWPT_NESTED, common.obj);
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3ea0a093ee50..3acbc67dd5f0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -200,12 +200,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
 	iommufd_object_remove(ictx, obj, obj->id, 0);
 }
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type);
+struct iommufd_object *__iommufd_object_alloc(struct iommufd_ctx *ictx,
+					      size_t size,
+					      enum iommufd_object_type type);
 
-#define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
-	container_of(_iommufd_object_alloc(                                    \
+#define _iommufd_object_alloc(ictx, ptr, type, obj)                            \
+	container_of(__iommufd_object_alloc(                                   \
 			     ictx,                                             \
 			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
 						      offsetof(typeof(*(ptr)), \
@@ -214,7 +214,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 		     typeof(*(ptr)), obj)
 
 #define iommufd_object_alloc(ictx, ptr, type) \
-	__iommufd_object_alloc(ictx, ptr, type, obj)
+	_iommufd_object_alloc(ictx, ptr, type, obj)
 
 /*
  * The IO Address Space (IOAS) pagetable is a virtual page table backed by the
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 39b32932c61e..a51ab766e183 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -29,9 +29,9 @@ struct iommufd_object_ops {
 static const struct iommufd_object_ops iommufd_object_ops[];
 static struct miscdevice vfio_misc_dev;
 
-struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
-					     size_t size,
-					     enum iommufd_object_type type)
+struct iommufd_object *__iommufd_object_alloc(struct iommufd_ctx *ictx,
+					      size_t size,
+					      enum iommufd_object_type type)
 {
 	struct iommufd_object *obj;
 	int rc;
-- 
2.43.0


