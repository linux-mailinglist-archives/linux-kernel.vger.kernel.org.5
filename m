Return-Path: <linux-kernel+bounces-143559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B234F8A3AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C24A1F21D85
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD51CD1B;
	Sat, 13 Apr 2024 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MytOF2iw"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027651B59A;
	Sat, 13 Apr 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980074; cv=fail; b=hQIAeYW5REEbU+MB1IN6X0Od330DgZKjUi3u+0W98FjRnjkZs20dIC67rgNO6jKtuapgIbFzj+jpovYdey8ZUFGxxVj5mfoUrUFm88ieI+ZJxaUK0xL46QFgutMKjyxE8m7edkHN9uCoIW/JQvkTMW9UZQFzrJZIC8vg4JEiFzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980074; c=relaxed/simple;
	bh=dGMSFQWjX9HbPdzXo3yCAIopZwk2a8xGanq3j/9jXqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHt5tQ6dMt0XIuLyvGwtcaAfWQcfT/LaYO3X0okQArrFBpA1wQ699YaRu/2N0EYDaUN/t4gp5J+wmxEIdCmGGHx6rcxE3I27PeUbmAwMr7OERHImTgwNU5Pr4Zoz53rw9QvPG0kgifDF4AHxKPI4Atgv0yMdL8Rb4u8SpurLEXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MytOF2iw; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qyd0EQGf1e2EtyphOBbyEV6zd7B8yH+zQ+VwHbgu+hl1ArV3PpBelU5p96+GgcMwkDk+LJppmnzWCLQpp3R7KOH0z0/M9n6h4Jp/Nhevan3xDU4l6u3TZ0Sns7703zVgLWU1Hcbb7FqY4NjdHG+j2Oofm9v69mNNKwM2QuD8MWzfN+RNWhxgfgMvOD72X5YomrVKiZ/LXAL8Xp+RQMu1lMDB5VGk5JqbtFOeZm5G6FMt2pfbkF23R2ZiJpAGAJOPpfh6wtzSEoqZk+mL4QzTxz20FPcIW1Fot2hRbTl4FvGDTEZtfVX7JGqRY2W8wtKTDqjo9It4+V1+dowh9Lc6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJoBKqRkwspRof3jmQTOPgC8dPdj3D3ZlnxKyO2ZqRU=;
 b=Q4LLkwlAyizNVwEY8emzDlnlW84Ag1ml/cJGvmDm2+yq2JfiakDXZAVxjDUtgrntM6Qe6yhUEAY+u8eiVLU/5DhaMeTBpVLMohTVpbxgNZmaIPm1Pnt0U5T4KwF/mG4AM9H2MxCqyYBsOatBuuUj+VNHDlWwhO1wgk1vo7ttHojlIPyh+ujjzMqI1dmFju0Sh/0axrOREI1O1pW1sIXo1AQZvpzP80ZqeuZE2F39LoITgNzZdDjK4L8dLHFBPwiYK9C57dimlrkHaFoXlvsf+eQW/Ajw+xbO9PzBPvul0Jz4t1zXR5btrTSrMZ5ulBfEbIrIf7PTP3i0wfQnqhN8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJoBKqRkwspRof3jmQTOPgC8dPdj3D3ZlnxKyO2ZqRU=;
 b=MytOF2iw44KNa8Agmnea4dDDQ8rd+4RTztNkKXUgk6+Aa4/SruTUwhOablOMaZruJFM+7rm2hS9kL99+P9BZUCkaT2wileM+VaZ9ECWdCrZMy6C5E33Eqoj9l14zVSJT83BBfDJTgKr6YwPH65FAk+1twFo7/pbhdm6Qe54/AQKFl+RJEgQXwo5hxKPyN/AcViEmGjcJ4gZxIHyxrbceTlLRPufMu6H5N9L+SXspqFXZG0ypbcaUtoC787aVdw1V/KFsyqYpzp/Tk/GipKrGlOVLtrbhcIjl65M35uyrcQb169XiujR8ryvJcC7C/4WdwPObxkTXOx8m14tVQoXkOw==
Received: from DS7PR03CA0239.namprd03.prod.outlook.com (2603:10b6:5:3ba::34)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 03:47:47 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::97) by DS7PR03CA0239.outlook.office365.com
 (2603:10b6:5:3ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:47:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 03/14] iommufd: Prepare for viommu structures and functions
Date: Fri, 12 Apr 2024 20:47:00 -0700
Message-ID: <734ef2f4b2b3e743e276d65f775062c5996064f4.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9728d9-3aae-4db8-2dbf-08dc5b6c7bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CKR2MnrkJTpah/9ClbeqwAnsgUigMdqqkNNJsXoSmDgsJhhTAEI6dc/RSJKyNQI+CLPmXCnW4brhNhfba+IMQFDuVYeM2Cp69O+FNPOo25J+ZFr30aeRd6je+VbsPHiQnOusuU5p8uexj8QOWJQK/QVSf3gFL+xam1xYY2EHEhecHwhBHEH8YyFRXKUWmlrFjecbDFQEDvTS6tOvxGwQuAt0GzWgQRD819EdfBv/ieY5E1otSdJqAoxez4dhUTaPle42/HezHxoUpeFPOG65MrgVEwbabm5l0yLSNWOhFenUZv6hMvYkUcLmoutl+N6/CYloLcybcf7MQLGyJchJBF8HvceYvqy3hcMHg9J7Tbwv5+8GaP2IPBsl3FZCF6HUwZ8wI846PLorJ02X2ZWIY9TosC02osnKm6yOQx2gWQvrteX8d7EHzoLSS/z4gKWKpXFF0RLH9VE8CzwwnNdXsYy7I0hGhTl3onHn+4nN0Ig/hfiQ0BwrSpaVxtSikQA8hiI/A2iboOlCXb4VcnfUCynCpckJz+E1zPhJGYaHkKNt6Jib+sIuVYagC/Nq1WlWVQ0Qx3NsAbIUVGImukb1o2HDl2RvrNxIBDnk6+2NKsI7YPcKYAhkqHl6SmpGHm56XFppk3qWEwNRpa69X1QolUdnYwfyMF0RcD9M8OGaA6SoQTOinmRq3eRH7/7IVqvvfsYJT8uW/6WgSk9d7krX6DhihsU6QmhleR/6iI+N3QHC888MiLeYSc7/BWkONEWN
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:46.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9728d9-3aae-4db8-2dbf-08dc5b6c7bc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745

The following changes will introduce a new iommufd_viommu and its related
structures and functions. These new core-level structures will be embedded
in the driver-level structures. So a helper to allocate the bundle of core
and driver strucutres will be nice to have.

As a preparatory change, introduce a viommu.c file and put a new structure
allocator in it. Since some of the object allocation will be similar, also
move the common part to a new level-3 allocator ___iommufd_object_alloc().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |  3 ++-
 drivers/iommu/iommufd/iommufd_private.h | 20 ++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  9 +++------
 drivers/iommu/iommufd/viommu.c          | 19 +++++++++++++++++++
 4 files changed, 44 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iommu/iommufd/viommu.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 34b446146961..76c2bc41af40 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -6,7 +6,8 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
-	vfio_compat.o
+	vfio_compat.o \
+	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 3acbc67dd5f0..eccc565ed38e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -156,6 +156,26 @@ void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
+static inline struct iommufd_object *___iommufd_object_alloc(size_t size)
+{
+	struct iommufd_object *obj;
+
+	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	/* Starts out bias'd by 1 until it is removed from the xarray */
+	refcount_set(&obj->shortterm_users, 1);
+	refcount_set(&obj->users, 1);
+
+	/*
+	 * The allocation of an obj->id needs an ictx, so it has to be done
+	 * after this ___iommufd_object_alloc() callback.
+	 */
+
+	return obj;
+}
+
 enum {
 	REMOVE_WAIT_SHORTTERM = 1,
 };
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index a51ab766e183..5187942b375d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -36,13 +36,10 @@ struct iommufd_object *__iommufd_object_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_object *obj;
 	int rc;
 
-	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
-	if (!obj)
-		return ERR_PTR(-ENOMEM);
+	obj = ___iommufd_object_alloc(size);
+	if (IS_ERR(obj))
+		return obj;
 	obj->type = type;
-	/* Starts out bias'd by 1 until it is removed from the xarray */
-	refcount_set(&obj->shortterm_users, 1);
-	refcount_set(&obj->users, 1);
 
 	/*
 	 * Reserve an ID in the xarray but do not publish the pointer yet since
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
new file mode 100644
index 000000000000..f77d6972d552
--- /dev/null
+++ b/drivers/iommu/iommufd/viommu.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/iommufd.h>
+
+#include "iommufd_private.h"
+
+#define viommu_struct_alloc(name)                                              \
+	struct iommufd_##name *_iommufd_##name##_alloc(size_t size)            \
+	{                                                                      \
+		struct iommufd_object *obj;                                    \
+		if (WARN_ON(size < sizeof(struct iommufd_##name)))             \
+			return NULL;                                           \
+		obj = ___iommufd_object_alloc(size);                           \
+		if (IS_ERR(obj))                                               \
+			return NULL;                                           \
+		return container_of(obj, struct iommufd_##name, obj);          \
+	}
-- 
2.43.0


