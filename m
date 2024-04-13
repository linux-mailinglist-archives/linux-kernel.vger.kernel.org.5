Return-Path: <linux-kernel+bounces-143567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CE8A3AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E112C28508A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9851C6A0;
	Sat, 13 Apr 2024 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bysLjFDQ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657453E476;
	Sat, 13 Apr 2024 03:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980088; cv=fail; b=bk89ognGUrKRdCAySTwQ3et6TyWRlFj2Nm+cMBb9pphjIAMXiDQChzCwWCuTaxF5p0ALk8QSUEr1YAGFLokeFa2uiLZLIhvbADIcHkMoX7Uwtunwa2vkQjs+j/v5/OwIgm1HPKVvZacA0Vz1kkwMoUHSS09KMja1tgNT2SsIO8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980088; c=relaxed/simple;
	bh=QibNWNuH66GmDXL6tnfu3sBAF7nQoUEPQN/BSQbaAlE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4Piw2cToRM812+yrMAAO0DrzDdZ0g7lsJFwUJzFwGpaFESDMYgugO1eIkscqL+43Wj34VyYzWbLC229VbyuDlxqh7Z8XpTzfGQFbFl33NwE+HTGMlejH7fH0rjs7Vk3HnV4YFLZpIIM+8bjgqUzZtwiR378YxrF4xrMrzWDyIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bysLjFDQ; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA8bj8gVKRnrri20+qUUfkmCGJ+cn8/E1MpLoigFdikt+KnzJgaSbKVK0VHrW4BuAJsc2bwuAvR7poEkraAgdt+ngjPH2/pPf8PFFJou4mXCB6KukqA4DVf+dFqU4DlcVic3F9Ey0SKN6D01GBfvZ9qIJS/l6hdUpncSQIZugJOTRtlUP6bJZrA2zeRHDoqvK+n60XFvcnvPKk+ypbf1LUGQcUwSlxdz2Jk+lRHe1LD/LjsLn9bAPfsmxO2E3nAsU/4Mzj5vVTKWolopWaCn6uH4zJXj3dWonpaOhj9F0Ujwz1/bsC+QpmZZOMQq4kF9tHGFWNCJWHlvEKrw9SycMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhHwRjG2chsqimqZJLtcDUGvdYbpjq6vAxXV6IdKSqY=;
 b=emHomlRVgYKcRsufAiLJApSWegBVfx8wwBnlW8zqzt3/yaU9sCL3pQZdkmjmzvOW8mVium+GEvlc9DtPzbx5bR1wRmZTYz5Bzmr/XJ3zELy6wuWm/kutPZ5Zd5qo8/Uav5sYQ0aN2pJXYRvz8h7BVOwMCrMkDErcjuxCO5oSPhs8GamJE2q3AC6ybm1qXK6B0Ef8N8RHpXVO5bGsNG1olkaPx9IeVLyxi31QXsBBWu01bq382AzjTGaXioXv2jAy7ksZksc0GUqVFpPiwVGDMDkl2ByOo9dBBIUcXCzsigPeo2a1E7VwK4nwSwPGFcwDwIa7rfzdO/KzO+n52YpPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhHwRjG2chsqimqZJLtcDUGvdYbpjq6vAxXV6IdKSqY=;
 b=bysLjFDQmYiCRr0n924XukMELC6dxBhYHfJFKsgHdnUaDsjl2z3xx/w7VArQQSbAfGvkK/Je7iaNjocgD+sbOcUMEs57V00ZLjzJ6o6VRPfrZFRDA4wBrkjFyHSZBeXPSvARf6pPbpzLGNjf6Bhz8BilKhDPFS3iMpHvkaQ7JhMVokXmIHOO0lZ1z6BYprEDDxLmmA2gdUqBTNLRtRUmZWCD8OxA3FtSDOQzTv+wBaxtZVmx1bfzIEOUZ+npN9D67KukS/p/T90woYA1XexFLuLjMu7nUUSqGFNmMUNZxa1ptn7S4vO14lARDr9s09IqqmFYg6uYwbifoda86xkgEw==
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:48:04 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::cc) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Sat, 13 Apr 2024 03:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:48:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 11/14] iommufd: Add struct iommufd_vqueue and its related viommu ops
Date: Fri, 12 Apr 2024 20:47:08 -0700
Message-ID: <eb4966e6b5324b61d029b12d6afdbd9dbf91dbd1.1712978213.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc6d07f-dda5-49d6-0a7e-08dc5b6c861c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DDQ5iYvW1kUCpugY3HnNYOJUbqMovcc9aDz0WUAI0coIWbnBRdvvGsMKcNmakBWsIJeEiGXJJLL2nFfFkPxVA83enFK5Rq+8ZNOmXXb2O8fUZmRIuXaKmHYyGMwG+RLfN4r2o1cxr/mttuJR8b5SeO3KB+OBUzChZ/bL8QrVqHBlgzbV+Rf87jQ9k1YRmSprfi8puga2kor3ljFWErPY315MeU18gfkABDCMdgeLUnRKWNusgrgVSq4fJOf1hKGKy3TYRYiHcJTyVc+PVJ86E+tyGdUFtEYi+vyOb5BuLOmYJBJdqfWdGoOQaNIbptgvh6rFoW5FGU5nI0/KJgdkAMWU+z35wROlq5WBP4MMHYE65DZzh2+A9DZRKu/stMCcoHSshQ70s8++CxRIqNlwt/5dsrNTgWWOWO1xoHDYWhWXk2zM6MexzkSKsRjtUQD9bYiWpOETUiI0xyouWWXlmzyfmSEWSIwLO42xCqiYSS3KXhxYsJYSyJiwkTq6ppF6yBMvnf30mOQpDmJYoZ/K93E0PvDIre3iI+HvBLnZQcR49led3AIVzMg6PAcgJ16t41+LLxJ/2QWzipMFMmwlAMge+rwQw6NEgJ1L3c4p52har4GbICeAhNUzKoL4WhJB/XdUU6/VQOmmujLQJYJpSL6IViTpDxWA8X4bmWcCWMhoI/dfBYWSinf1vXzmqHvmix0GM8NElS7Wnpy4pVp13KX0/8Ei4/5amWkUpYsENysmFv3A0ArTPG8EGvPr7wMx
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:48:04.2316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc6d07f-dda5-49d6-0a7e-08dc5b6c861c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

Inroduce a new core structure and its allocator iommufd_vqueue_alloc().

This can be used for a viommu to allocate a HW-accelerated queue, e.g.
NVIDIA's virtual command queue and AMD vIOMMU's command buffer.

Also add a pair of viommu ops for iommufd to forward user space ioctls
to IOMMU drivers.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c |  1 +
 include/linux/iommu.h          |  1 +
 include/linux/iommufd.h        | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 71baca0c75de..8894878c1e73 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -19,6 +19,7 @@
 	}
 
 viommu_struct_alloc(viommu);
+viommu_struct_alloc(vqueue);
 
 void iommufd_viommu_destroy(struct iommufd_object *obj)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d4461146288..475f41f2d41f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -146,6 +146,7 @@ struct iopf_queue {
 };
 
 struct iommufd_viommu;
+struct iommufd_vqueue;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2be302b82f47..5b97b04aa145 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -20,6 +20,7 @@ struct iommufd_access;
 struct iommufd_hwpt_paging;
 struct file;
 struct iommu_group;
+struct iommu_user_data;
 
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
@@ -97,12 +98,27 @@ struct iommufd_viommu {
  * @free: Free all driver-specific parts of an iommufd_viommu. The memory
  *        of the entire viommu will be free-ed by iommufd core
  * @set/unset_dev_id: set/unset a user space virtual id for a device
+ * @vqueue_alloc: Allocate an iommufd_vqueue as a user space command queue for a
+ *                @viommu instance. Queue specific @user_data must be defined in
+ *                the include/uapi/linux/iommufd.h header.
+ * @vqueue_free: Free all driver-specific parts of an iommufd_vqueue. The memory
+ *               of the iommufd_vqueue will be free-ed by iommufd core
  */
 struct iommufd_viommu_ops {
 	void (*free)(struct iommufd_viommu *viommu);
 	int (*set_dev_id)(struct iommufd_viommu *viommu,
 			  struct device *dev, u64 dev_id);
 	void (*unset_dev_id)(struct iommufd_viommu *viommu, struct device *dev);
+	struct iommufd_vqueue *(*vqueue_alloc)(
+		struct iommufd_viommu *viommu,
+		const struct iommu_user_data *user_data);
+	void (*vqueue_free)(struct iommufd_vqueue *vqueue);
+};
+
+struct iommufd_vqueue {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_viommu *viommu;
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
@@ -123,6 +139,7 @@ int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
 
 struct iommufd_viommu *_iommufd_viommu_alloc(size_t size);
+struct iommufd_vqueue *_iommufd_vqueue_alloc(size_t size);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -168,6 +185,11 @@ static inline struct iommufd_viommu *_iommufd_viommu_alloc(size_t size)
 {
 	return NULL;
 }
+
+static inline struct iommufd_vqueue *_iommufd_vqueue_alloc(size_t size)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
 
 /*
@@ -179,4 +201,9 @@ static inline struct iommufd_viommu *_iommufd_viommu_alloc(size_t size)
 					   BUILD_BUG_ON_ZERO(offsetof(        \
 						struct drv_struct, member))), \
 		     struct drv_struct, member)
+#define iommufd_vqueue_alloc(drv_struct, member) \
+	container_of(_iommufd_vqueue_alloc(sizeof(struct drv_struct) +        \
+					   BUILD_BUG_ON_ZERO(offsetof(        \
+						struct drv_struct, member))), \
+		     struct drv_struct, member)
 #endif
-- 
2.43.0


