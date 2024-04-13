Return-Path: <linux-kernel+bounces-143565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219828A3AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436BB1C20FCF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31164C63A;
	Sat, 13 Apr 2024 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HBF5BDMQ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B2481A3;
	Sat, 13 Apr 2024 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980085; cv=fail; b=H7Do4Zopmbl5yW/IWR5OcY2YQQhaMukbpd4g2zeHlGyfZ8f1Y3iREEsVFYToLr6wpkp/GVoCeR/2e6FEJ37+69olpMW6JH+IdKULxl6ORZI1FlEsZhquPc1OoZv1TANIiZb+DY1fZolIAwrPnRxyrmj0j09lkNpLvUTBydcexJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980085; c=relaxed/simple;
	bh=AkvQjPvi9CGj+k12hGhbKqzTsKlUEmcEZO0bYQmjv2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfAFIJ2xUIkFq6paoHYk+bBVS+Kz05Q7PMI5qPeSBhVJ38IqhL6AiJCTolc6ARCd45rT/H2RRQITLqdf3zdw4Q5KyYriZ77/fI8hEJvTJwXBT+cEq7DGHuiqUOjJCirQhAr2ifU4ZRe3k0rZwNLKuQ+z3Z5SmPR2YNeMwGERKEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HBF5BDMQ; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab9VfksID5XPxqcqDGBRxyxeHmN47KtyojHvauCWyv2jW9kQKuNmV7k+xIRFl8WImpJ0cStWSikkJ3S6mnflMqbWy76fcZGEepFD69FF2IGdP916ABxHbSEYdxwYoJiJZ3k0WF84pSrwoO+3gXeQKPbryvwj1SHX6FYq6gJarhXFGngCmaSUNkMylvJE12AhNuoaPvVhgGT/M4uj6l+misHsAwxk7/qsPYjbUi5Q6vVxMn/YfTGRhHtFlfCAFpBPTq3luvvFdSYnlAFYzkPW9KdReC0MsD+KlcaiRG6sCh+E0YKGhQ32KN7m3KI+4cBhuDhVYwsF4vZhb1KfA7rp0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xDtFihtRtz00OwDytggfVbJxDkLc/Ke5E3kGfMOqbE=;
 b=IyiDTcSo6mRW17v3HPrifXZqqm6pZApE5qwu4M8PJRwvcLQxreEtj8jkaUHIOfUq+AaQkzZD1TLP+vFC9081KvMLESAqJNdFs/mSNvTKeQYvUt4H5k0023BnoekXxXVp8GOwNvDZa2IbZVgnpINWvO8LM5ZT/5/uXmTtfP8r+QfxdV6oxpurvlutN55LPFlagHqII3hktzLohcb7WlubfeReKbNMLnmm2dUzYssBAVUzEPZo5eBM2nDtjIMX62Pe1Kl5zEtwxC0xf4bDuCNW8SctkyJ0xXB8PLbw5zYHS/c9ltcGMbGrRzaiqluMObZEyco4vCF1JmUbbtz70RI5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xDtFihtRtz00OwDytggfVbJxDkLc/Ke5E3kGfMOqbE=;
 b=HBF5BDMQ6jAjWWAY2SEE4KunS++mQsAz4iCrZSvLudFxe/I+1t/5NnvbPuQBd3k9Ddj7aRnmkDcy+w9J8gH/MG1nwr73/Rodo7heqLDa1H+i6izJswxMnkqQMj/CoesX4V+qQif02mVFV+AGVFJz5rVnp6ba5IbCdbnK9AfoEenfuc/Kb6MWYEq4Eet44LSilVDcNoi1dKoGPFV++x1VNx+SdQ4pIo0N7sInG/vE/Kr6lk1g8Qgq0CzgGhrWYgG+ykYmddjyDnFmadKoNV0U9Kh4hesmtRz4D06yCQI0Pc6zh6ho+6CHKrgwkHWlzfHuvxEdHrk9iypiZlo4c1nQiA==
Received: from BL1PR13CA0089.namprd13.prod.outlook.com (2603:10b6:208:2b8::34)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:48:00 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1) by BL1PR13CA0089.outlook.office365.com
 (2603:10b6:208:2b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.7 via Frontend
 Transport; Sat, 13 Apr 2024 03:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Sat, 13 Apr 2024 03:48:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 09/14] iommufd/selftest: Add IOMMU_VIOMMU_SET_DEV_ID test coverage
Date: Fri, 12 Apr 2024 20:47:06 -0700
Message-ID: <80bd0cdd1108ff9247098b82a5b6bb0ea43c5ad1.1712978213.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: fe42fe63-b3d2-4fac-c616-08dc5b6c83cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TOTjdGRReF/f9W3Opqjv9UgZ8lETF+kVSLZNDBzRuVUDxsZ4FlBaZ7drVWGAk5WxqfrNt4W5qhbdQ/Aqp60AKwoeb+q443d9v3Mgy2zU7NSzPoqNMoxPpILKJ9nG5AFM6kIPWrHON1TncjAhOHSEzii45PUks4N7xPssWKPiBhKf2Yy0o0umTBY3uOLmc4vrQj7DfL+F054jomlBMHmmfWGmoq8bCGYJY4UB/ckERu0trjKYD16KK43Rwkn+kA3l6JA2ToEY6dYRXKk5tjX8YviFcEsfKqZcy0fCZjlfp0ou69vaaD5TCvi2bIV5P+rLBLuFbquKgcai0/qyXEUCHZrsSEl5d8lorW2cWI0aD3LpzwlFT+nhbkIVSZqHPOi8y4X4Ke2aVSCHdudIZf+cAaBpJbbuepKfiMVdzOeawYoEesb+PKFDL+tg3A0GgD7gKTwUCCzV9VmtZ3EOJDuF7G62w56pK3dLXwGHAVjDkbD9qrszlrg+AeM0BjXhH9uMIbVBpihgCqLJoGNySKkHFtB+oe1mENgUw1aOLdxSMHuii6unKrL+S8+FqvBzb6tqYNNPUAZKSPIr9J/SpCoz+T2g+D631k3gb2EdllPg2ZetJnNBuWQxdmOU+5c6rgxd+3YTsfjDWuB7QFsfJ0pxDaE2X7zCeINvAT5ZBrYkaEMeubjsB7FQ2B7etQeM+rMlC/C2kCBH0sK9+ooEKHkCTV+qkz/7lZ48fUQIPgCwkowANM/XJ5iGNr4ebMbKHFtb
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:48:00.3723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe42fe63-b3d2-4fac-c616-08dc5b6c83cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

Add an xarray to store the array of virtual ids to mock_devs, to cover the
new IOMMU_VIOMMU_SET_DEV_ID ioctl.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c              | 50 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 14 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 21 ++++++++
 3 files changed, 85 insertions(+)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index e2fc2ec23093..4caed9304065 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -139,6 +139,7 @@ struct mock_dev {
 	struct device dev;
 	unsigned long flags;
 	int id;
+	unsigned int id_user;
 };
 
 struct selftest_obj {
@@ -516,6 +517,53 @@ static struct iommu_device *mock_probe_device(struct device *dev)
 
 struct mock_viommu {
 	struct iommufd_viommu core;
+	struct xarray ids;
+};
+
+static void mock_viommu_free(struct iommufd_viommu *viommu)
+{
+	struct mock_viommu *mv = container_of(viommu, struct mock_viommu, core);
+	struct device *dev;
+	unsigned long index;
+
+	xa_for_each(&mv->ids, index, dev)
+		xa_erase(&mv->ids, index);
+	xa_destroy(&mv->ids);
+}
+
+static int mock_viommu_set_dev_id(struct iommufd_viommu *viommu,
+				  struct device *dev, u64 dev_id)
+{
+	struct mock_viommu *mv = container_of(viommu, struct mock_viommu, core);
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	u32 id = (u32)dev_id;
+	int rc;
+
+	if (dev_id > UINT_MAX)
+		return -EINVAL;
+	if (mdev->id_user > 0)
+		return -EBUSY;
+	rc = xa_alloc(&mv->ids, &id, dev, XA_LIMIT(id, id), GFP_KERNEL);
+	if (rc)
+		return rc;
+	mdev->id_user = (unsigned int)dev_id;
+	return 0;
+}
+
+static void mock_viommu_unset_dev_id(struct iommufd_viommu *viommu,
+				     struct device *dev)
+{
+	struct mock_viommu *mv = container_of(viommu, struct mock_viommu, core);
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+
+	WARN_ON(dev != xa_erase(&mv->ids, mdev->id_user));
+	mdev->id_user = 0;
+}
+
+static const struct iommufd_viommu_ops mock_viommu_ops = {
+	.free = mock_viommu_free,
+	.set_dev_id = mock_viommu_set_dev_id,
+	.unset_dev_id = mock_viommu_unset_dev_id,
 };
 
 static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
@@ -527,6 +575,8 @@ static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
 	mv = iommufd_viommu_alloc(mock_viommu, core);
 	if (!mv)
 		return ERR_PTR(-ENOMEM);
+	mv->core.ops = &mock_viommu_ops;
+	xa_init_flags(&mv->ids, XA_FLAGS_ALLOC1);
 
 	return &mv->core;
 }
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index dd7b7c7a06c6..378fbf00730e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -271,6 +271,9 @@ TEST_F(iommufd_ioas, viommu)
 	uint32_t dev_id = self->device_id;
 	uint32_t viommu_id = 0;
 	uint32_t hwpt_id = 0;
+	uint32_t device2;
+	uint32_t stdev2;
+	uint32_t hwpt2;
 
 	if (dev_id) {
 		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id, &viommu_id);
@@ -282,10 +285,21 @@ TEST_F(iommufd_ioas, viommu)
 				    IOMMU_HWPT_ALLOC_NEST_PARENT,
 				    &hwpt_id);
 		test_cmd_viommu_alloc(dev_id, hwpt_id, &viommu_id);
+		test_err_viommu_set_dev_id(EINVAL, dev_id, viommu_id, 1ULL << 32);
+		test_cmd_viommu_set_dev_id(dev_id, viommu_id, 0x99);
+		test_err_viommu_set_dev_id(EBUSY, dev_id, viommu_id, 0x99);
+
+		test_cmd_mock_domain(self->ioas_id, &stdev2, &hwpt2, &device2);
+		test_err_viommu_set_dev_id(EBUSY, device2, viommu_id, 0x99);
+		test_cmd_viommu_set_dev_id(device2, viommu_id, 0xaa);
+		test_err_viommu_set_dev_id(EBUSY, device2, viommu_id, 0xaa);
+		test_ioctl_destroy(stdev2);
+
 		test_ioctl_destroy(viommu_id);
 		test_ioctl_destroy(hwpt_id);
 	} else {
 		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id, &viommu_id);
+		test_err_viommu_set_dev_id(ENOENT, dev_id, viommu_id, 99);
 	}
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 037c84189d50..81e9184fd1d5 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -710,3 +710,24 @@ static int _test_cmd_viommu_alloc(int fd, __u32 device_id, __u32 hwpt_id,
 #define test_err_viommu_alloc(_errno, device_id, hwpt_id, viommu_id)     \
 	EXPECT_ERRNO(_errno, _test_cmd_viommu_alloc(self->fd, device_id, \
 						    hwpt_id, 0, viommu_id))
+
+static int _test_cmd_viommu_set_dev_id(int fd, __u32 device_id,
+					__u32 viommu_id, __u64 virtual_id)
+{
+	struct iommu_viommu_set_dev_id cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.viommu_id = viommu_id,
+		.id = virtual_id,
+	};
+
+	return ioctl(fd, IOMMU_VIOMMU_SET_DEV_ID, &cmd);
+}
+
+#define test_cmd_viommu_set_dev_id(device_id, viommu_id, virtual_id)  \
+	ASSERT_EQ(0, _test_cmd_viommu_set_dev_id(self->fd, device_id, \
+						  viommu_id, virtual_id))
+#define test_err_viommu_set_dev_id(_errno, device_id, viommu_id, virtual_id) \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_viommu_set_dev_id(self->fd, device_id,        \
+						  viommu_id, virtual_id))
-- 
2.43.0


