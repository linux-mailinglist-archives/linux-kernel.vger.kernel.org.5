Return-Path: <linux-kernel+bounces-143561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813988A3AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCE61F21D96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8C18EB1;
	Sat, 13 Apr 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hSUcfK1w"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E111D537;
	Sat, 13 Apr 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980078; cv=fail; b=OYxMQgzL8Ns9mw2Yg8OC7W1r78AAxP0HPgNe0VSUTCGp4OwiA4X6WqDd+5QNFIJ006Y45CYlKy9OP9boH+0HH9sKJbzniLTkT0PyLECcOt5xLx9+tS1coHWCHoJI71bM4TKZbq48JQdH8x8IbiIRPiH16dzMFmkZnI0/UyRa0n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980078; c=relaxed/simple;
	bh=d99iBjR9rIrSPuQbbKVyllb6JEDj2jYLnZh0vcwytx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdEKxnFxJL383/mFh227Dvo28U8rTUSLmIGew6IKCVaeXzI6lQMkoa9oCQB4/Sw56d0N3S8EbwPihYGZtIbG7iRoCdgx4QeKCNhDLsynZffVVht1ylXT0lZgrNAvP0gPIH6ctrs8slERV/RfeFVW86Ab4/+N0XfSFUFaxkbUWSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hSUcfK1w; arc=fail smtp.client-ip=40.107.102.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjccV0SPS5+fHeAF99+NAT1ET3bpEi8hGblvnSya79+mctUBZEKknX6bHp2ygt1VYeb/csFGPj7FhvVWpN5lvL+lmW/gxvrs8NnI0nL0a4NfcQmVVMImLHUlaRX17XnJsjo5YsnPl970MzdtBZA1QyHzl2EcxM3WLZoSITJ1cToF3iaK9oXzO6kBQ/PWI/srTssETJakOGNyCjbikXkHQY1oEXp02TWmvbJDnT2I+h9PzHruDcQOlFq1Z6Efa/tJoiEak/jWOoQ0psNCawX4vpEAgt3ULdwJ1uOw2nWpYgBpU+XW7Bp+opKNr0k/LLhaH0Y57/1NoifqnnfkfnySRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM4B8FG5GEwfuAIkKYqRf3sLAHIcdh4j9sDUAtG7p5E=;
 b=cKMcGgcml+gmWWZsFPnDdJYLTrgOpL8Bj5lkskdnDhyzHOavWKZH9W78Vg90jhcOV8SmH+ypCqJ36KpWkh/L9Vv39WXVv9413UhjxpS0wl+enPbjUuuoyU2JFPXHk0CH4UifY4pYYG/hge2hJJk79pnj6U4KliqWN6PBXCM0Txwtqa9tyG67cwCA/CHj10+0rJ3MJFf7Po7l9o+cpqQvQAuTEfUEM+SxSa7lQA2RcJCKsi+Hh9ClQJPNthmIKgyobOZgsCqol2kLnskYYj42hZbMc6BOhIHk7vT4Qc9vKIX6qbTvg04Q98rCmqoHzBEo2cpOEj0ZzLoxxbfyNo7lDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM4B8FG5GEwfuAIkKYqRf3sLAHIcdh4j9sDUAtG7p5E=;
 b=hSUcfK1wXbRSObzA9ENHfp7AgiEJ/B0L2OBE4NzISnTJyOU6FNuaMYBUJDZ+tDyuYagE+Gi9TpEj7tVMICf32bJhCNmKIPevMU2WKNwJQ9ZxJC6FIrPSz/pYqEV/cb+FnQqsJL3tx9lxU0ezHymMGVNeFXLpXeRmxqBmrBEaOXM2s+TknkFKerooSPtt/dfHvJYMj0GKhsFVtEvdt3tRZ9XNyOI4+s70vx4joLHN3WWEZWfG351qcfB8d+MNRIvg8GLiF37BHqyBfvywykS876jr2/aNV6ytwMq6q9rv2xmvt7JPn5QDO/Eul4HSNgq7FrNtKl3XTv/f4XOgO+Pawg==
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Sat, 13 Apr
 2024 03:47:52 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::5c) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:47:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and iommufd_viommu_ops
Date: Fri, 12 Apr 2024 20:47:01 -0700
Message-ID: <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: ea556029-34d3-48fa-f2a1-08dc5b6c7ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+SQ8uJse3AIFFlGVAYr1iZzqgFeJW06iFYfpB1YPmt18llefA0J33Djr6d42wX+1SsPIodQc+57AWgyJ9zNQTY7qvI+AH8UZHfmyol5k5srgRxSBl/cG+xo9U4E6kMAvPNQ4dJjsiuXAlTmR8oSdbgq0aemndgr5P/Bbbmc36/vn/+gjMSvX4yq++IY2zMZo8RZB92JrIJy3h6bXRw/f9R/8iQZSGsswk8Dpm2AsQz8nC4HHLmxGCVgduUuS24+Rz8MKcPKKQ7vllrkaI6VBnLY0/CBHu5pf5fOq9Q4pTBIQMwQj2b/kEhSqTtqAfClvnrkukV8PCBN0FfJKSxR3s1Kh6kkkF9qDoCTIHw4XQJMinKFecn1SbZ4+kNwlbmRV8R5eFlA8l0tBtdG5AmzGR9bDvRFudo5xWsGcGEOBNfQrv/Rk16z3s5NTvJp2NOJ078Hg1zx2Mdg9b6WrfVZTTPeGfsu8XZynoYmNfc/vSIYPcpHyLQ35HdtaXqnTx37qnK97MUhzwql3GPcLZsRNDYpqlvEFOdmmGqJso9NmSHe8/iE4AzlImxEDiza0KoWgxjLCoE/PBp72qFBGPM/KuocfqfCLn1Wx5zGZPqaiOK0z/VYv7oFSu0aRtIHcgpYvm+N8bgyqjuUX0HXvKAHNZToM/DoTaQc+K6qBQUJGX+TM6Uzr9lNBAMNdAXscxJpay55o6hDD0M5+4BzsH9HVcQzIrhfRMxbfEDA8WBZ2kJwkr2A2Poyx2VCewFYxCcPp
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:52.1487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea556029-34d3-48fa-f2a1-08dc5b6c7ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259

Add a new iommufd_viommu core structure to represent a vIOMMU instance in
the user space, typically backed by a HW-accelerated feature of an IOMMU,
e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and AMD Hardware
Accelerated Virtualized IOMMU (vIOMMU).

Define a new iommufd_viommu_ops to hold the free op and any future op.

A driver should embed this core structure in its driver viommu structure
and call the new iommufd_viommu_alloc() helper to allocate a core/driver
structure bundle and fill its core viommu->ops:
    struct my_driver_viommu {
        struct iommufd_viommu core;
	....
    };

    static const struct iommufd_viommu_ops my_driver_viommu_ops = {
        .free = my_driver_viommu_free,
    };

    struct my_driver_viommu *my_viommu =
            iommufd_viommu_alloc(my_driver_viommu, core);
    my_viommu->core.ops = &my_driver_viommu_ops;

Lastly, add viommu_alloc to iommu_ops so iommufd can link to the driver to
allocate a viommu object.

Any future viommu op will be added to the new struct iommufd_viommu_ops.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/viommu.c |  2 ++
 include/linux/iommu.h          | 15 ++++++++++++++
 include/linux/iommufd.h        | 38 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index f77d6972d552..3886b1dd1f13 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -17,3 +17,5 @@
 			return NULL;                                           \
 		return container_of(obj, struct iommufd_##name, obj);          \
 	}
+
+viommu_struct_alloc(viommu);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..4d4461146288 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -145,6 +145,8 @@ struct iopf_queue {
 	struct mutex lock;
 };
 
+struct iommufd_viommu;
+
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
 #define IOMMU_FAULT_WRITE	0x1
@@ -527,6 +529,14 @@ static inline int __iommu_copy_struct_from_user_array(
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
+ * @viommu_alloc: Allocate an iommufd_viommu as a user space IOMMU instance,
+ *                associated to a nested parent @domain, for iommu-specific
+ *                hardware acceleration. The @viommu_type must be defined in
+ *                the include/uapi/linux/iommufd.h header.
+ *                It is suggested to call iommufd_viommu_alloc() helper for
+ *                a bundled allocation of the core and the driver structure,
+ *                and a driver in gernal should assign an iommufd_viommu_ops
+ *                to the core structure's viommu->ops.
  * @dev_enable/disable_feat: per device entries to enable/disable
  *                               iommu specific features.
  * @page_response: handle page request response
@@ -570,6 +580,11 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, const struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
+	/* User space instance allocation by the iommu driver */
+	struct iommufd_viommu *(*viommu_alloc)(struct device *dev,
+					       unsigned int viommu_type,
+					       struct iommu_domain *domain);
+
 	/* Per device IOMMU features */
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index a0cb08a4b653..650acfac307a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -16,6 +16,7 @@ struct iommufd_device;
 struct page;
 struct iommufd_ctx;
 struct iommufd_access;
+struct iommufd_hwpt_paging;
 struct file;
 struct iommu_group;
 
@@ -77,6 +78,26 @@ void iommufd_access_detach(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
+struct iommufd_viommu {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommu_device *iommu_dev;
+	struct iommufd_hwpt_paging *hwpt;
+
+	const struct iommufd_viommu_ops *ops;
+
+	unsigned int type;
+};
+
+/**
+ * struct iommufd_viommu_ops - viommu specific operations
+ * @free: Free all driver-specific parts of an iommufd_viommu. The memory
+ *        of the entire viommu will be free-ed by iommufd core
+ */
+struct iommufd_viommu_ops {
+	void (*free)(struct iommufd_viommu *viommu);
+};
+
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 struct iommufd_ctx *iommufd_ctx_from_fd(int fd);
@@ -93,6 +114,8 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
 int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+
+struct iommufd_viommu *_iommufd_viommu_alloc(size_t size);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -133,5 +156,20 @@ static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline struct iommufd_viommu *_iommufd_viommu_alloc(size_t size)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMUFD */
+
+/*
+ * Helpers for IOMMU driver to allocate driver structures that will be freed by
+ * the iommufd core. A driver is only responsible for its own struct cleanup.
+ */
+#define iommufd_viommu_alloc(drv_struct, member) \
+	container_of(_iommufd_viommu_alloc(sizeof(struct drv_struct) +        \
+					   BUILD_BUG_ON_ZERO(offsetof(        \
+						struct drv_struct, member))), \
+		     struct drv_struct, member)
 #endif
-- 
2.43.0


