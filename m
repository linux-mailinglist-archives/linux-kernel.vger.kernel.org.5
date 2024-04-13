Return-Path: <linux-kernel+bounces-143556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F28A3ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7291F21B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406E1C2BD;
	Sat, 13 Apr 2024 03:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biQF7hcf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E111AAA5;
	Sat, 13 Apr 2024 03:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980073; cv=fail; b=BMKiuYIubLefVKA0MHQsTrNaTIXmUf1LGPYJK9k57Xfiu2B8K10uHO1wCBNxLbJQo5WENZlBCVfI5C1tuOZGf6RlYr7LTfVorVUlSWCtiyy/SF/tGenow3XqqjrfMAJNioHTrSI8KUBqG470DPUtrmQfmevIMCzYMADFplj1BWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980073; c=relaxed/simple;
	bh=OtEYSs7/WzPNHhXMU3enY2MSX8ou37I3EFQp8oQmHp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvIletgoLmBot4cP0WwWWeWpMyVtASIONoEAeA8TLr7DEO4Uc2Inxd0uCo/F9/bBYjZrSlqbRCfpV8rJ7OXYziGhYnvJ320jb+ni9epihOiegOMTNSaThMIKmVBnQ9CJmNCNz1LJZmRknUNEC2sSla/GONQo+eh8/P2+sftnniI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biQF7hcf; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQB8N0FYioOM7nsJGcyM9DLLo+H0KaNhfDVBqO3stFUZPtmo3EKRMzpi/O8y4jbky+eOTAPFEEqy37qSg38S6vttnTmi+Pfv34CRdn46jU64kxbwvI9VCI6WVRtJDQMTKfrfhaIL0tBw0VYRibzPItJjHvsSmD5rVzxtkDDlIr2cqq5ud3s6MpoZW1o2gK8RUkPeEUJwj7rlqx7MEikfDBnSliS5E0QzEsbBc4Gfygu3ew/BFBh++5FDvqkt+5RYJeh+cdZqzH62bMcqNOHRxC+ZX0slG25Y/cQwTg9DmjePX7LDa4U41CdsTiELLjzqcTrVj/76F2OgDmz76uEHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DykR0sWjCFDsH3IG3FOXGv9pSKsNcKFS9B085pED9TA=;
 b=BxmZ2FF5SHGF3jHvZ46QyLGSAGxp3uWoKa52iPy84GZi5IOhgoKiHNBMVI0NSAWUgr8npyMFnqviUeL71zTAuMnKBRS/V/CwgFCFamfFTwh/oSaWaEED+dEpXPCwQ5NfvgZCQ3V0V9mDqnqr0UzfjqkCAmIdxh+mSLU3e9t8queY+Hmf8t+Zc/465tj6b1gYsf+0xJUOdnpH+GqdNpuA+GYWIQq9AshoMGDdsWZw3iuJCsaPn3Esbp7ks4RR4ISZQ0KfJXKdPTm+5hx/Qusb9gqhBlhTUG1KN1U0vr4AN/Vi1aqzV8ouynxlxMiPwrAk96Pb0O9A84F914MFGhZxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DykR0sWjCFDsH3IG3FOXGv9pSKsNcKFS9B085pED9TA=;
 b=biQF7hcfs073FzELzR8CNL7wFY18+xUMbA2OzxQTBilvl17vn2vtEcouAqD+HWFqnTkvC12HOOrSRIMJrqTO+BduBsuzikQSfBmc28a7u2OzVAz7uzgDz7Vq5KrVF6AUqp0tTj0Ov8cT36t7S7WCACGrr3biTCDZJg0ORZVpXdXIZnh1pwyh5YxmNAdwIecDXslaWxg9cxas2PPSzccRaWPxQoTrrRcXi3+SHfn4T9QEbuRoV9O9K8qhaSC5BczGapsuBICEWP1a1IN1e81zmK3QImpe9u0jacdMX02ky32YCz4iKMCbWa2sH3xO3gBQ2zXEmJcnDi4rKcBGQu5RIA==
Received: from DS7PR03CA0218.namprd03.prod.outlook.com (2603:10b6:5:3ba::13)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:47:48 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::2a) by DS7PR03CA0218.outlook.office365.com
 (2603:10b6:5:3ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:47:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 06/14] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test coverage
Date: Fri, 12 Apr 2024 20:47:03 -0700
Message-ID: <d62af7748534e31e02569f33664d3e8e082ff563.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 756dacc5-73f2-4d46-8979-08dc5b6c7c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+mMCi8j7Ix+rsMSr21RsnD/OWDKzVqB2C3rm0Rh5W0f17aXWihPJclxBLYViKrN70sVJgb8eKQjM6+GC1eWFlZZTE+lHarUUISZ9875pUDZdcI7OcoYfX3qW22warL1WXSpH2Cwf3uboLhMFXxf7eZfT6B6TkxRNmVjNDFqFBj09znnN/qjeRxvSvXaAdVsC8upeDoJLEvFeoR199/c/Tq5qYiyHhxtTdL8YVZ9oN2k8Rb491P/fq3FYj4hIpJBHFDmMYv5Y5AxnylPIKo1BbdOzKohHwvG3WG09d1SPlns52+p7Sc/od+ZxvV5sLyYPNqduLMxs78k++OLvApKFqzYFTq4grIggCqz8lMFE6aNCOOGGxoS3YXkKXFwrw/Q6MjCk4JL5fgp2KjruDhIJcP8fMVtr7s1LoWenmpezmlIMH69CCt4dbn4fifgiNFbnO7GVHfQegBsfH5HOFCH3FV/i0cnUODDnby28aqSq1QMIKKtOKOUu9EsGF9Vl1n8YUWcYUk//AyDHA20OmSSO6BWSiv3kirh9ipMGeOeZK2X9PIGBMcZZFumVBv6yEgKUl0S4G04ep2y3XhzrKniEVa+/n5mBb2L8iso2I0FlFRueZgiMvrnVh9rYHeMACNJAog/V0G4KRxmMtXdm1DgVJo1xZT9Io7ZOA8VPlPSbDU/Aqw0ZnPySO1v9OhMXxyuc2nuaWz1xRAjvqpxmGdjG7A9aRyONDzFGtdBzFIPeJEJL9F2oUXmqWPBvorA87ed1
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:47.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756dacc5-73f2-4d46-8979-08dc5b6c7c60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

Add mock_viommu to cover the new IOMMU_VIOMMU_ALLOC ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c              | 18 +++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 23 ++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 26 +++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7a2199470f31..e2fc2ec23093 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -514,6 +514,23 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 	return &mock_iommu_device;
 }
 
+struct mock_viommu {
+	struct iommufd_viommu core;
+};
+
+static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
+						unsigned int viommu_type,
+						struct iommu_domain *domain)
+{
+	struct mock_viommu *mv;
+
+	mv = iommufd_viommu_alloc(mock_viommu, core);
+	if (!mv)
+		return ERR_PTR(-ENOMEM);
+
+	return &mv->core;
+}
+
 static const struct iommu_ops mock_ops = {
 	/*
 	 * IOMMU_DOMAIN_BLOCKED cannot be returned from def_domain_type()
@@ -529,6 +546,7 @@ static const struct iommu_ops mock_ops = {
 	.capable = mock_domain_capable,
 	.device_group = generic_device_group,
 	.probe_device = mock_probe_device,
+	.viommu_alloc = mock_viommu_alloc,
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index edf1c99c9936..dd7b7c7a06c6 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -266,6 +266,29 @@ TEST_F(iommufd_ioas, ioas_destroy)
 	}
 }
 
+TEST_F(iommufd_ioas, viommu)
+{
+	uint32_t dev_id = self->device_id;
+	uint32_t viommu_id = 0;
+	uint32_t hwpt_id = 0;
+
+	if (dev_id) {
+		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id, &viommu_id);
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id, 0, &hwpt_id);
+		test_err_viommu_alloc(EINVAL, dev_id, hwpt_id, &viommu_id);
+		test_ioctl_destroy(hwpt_id);
+
+		test_cmd_hwpt_alloc(dev_id, self->ioas_id,
+				    IOMMU_HWPT_ALLOC_NEST_PARENT,
+				    &hwpt_id);
+		test_cmd_viommu_alloc(dev_id, hwpt_id, &viommu_id);
+		test_ioctl_destroy(viommu_id);
+		test_ioctl_destroy(hwpt_id);
+	} else {
+		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id, &viommu_id);
+	}
+}
+
 TEST_F(iommufd_ioas, alloc_hwpt_nested)
 {
 	const uint32_t min_data_len =
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8d2b46b2114d..037c84189d50 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -684,3 +684,29 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id, void *data,
 
 #define test_cmd_get_hw_capabilities(device_id, caps, mask) \
 	ASSERT_EQ(0, _test_cmd_get_hw_info(self->fd, device_id, NULL, 0, &caps))
+
+static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
+				  __u32 flags, __u32 *viommu_id)
+{
+	struct iommu_viommu_alloc cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.dev_id = device_id,
+		.hwpt_id = hwpt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (viommu_id)
+		*viommu_id = cmd.out_viommu_id;
+	return 0;
+}
+
+#define test_cmd_viommu_alloc(device_id, hwpt_id, viommu_id)              \
+	ASSERT_EQ(0, _test_cmd_viommu_alloc(self->fd, device_id, hwpt_id, \
+					    0, viommu_id))
+#define test_err_viommu_alloc(_errno, device_id, hwpt_id, viommu_id)     \
+	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id, \
+						    hwpt_id, 0, viommu_id))
-- 
2.43.0


