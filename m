Return-Path: <linux-kernel+bounces-143564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BEA8A3ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EDD1C22D84
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1E1446BD;
	Sat, 13 Apr 2024 03:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TGUcBNp8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43A3E476;
	Sat, 13 Apr 2024 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980081; cv=fail; b=mpY9JU6LrhMUk2ed0k1QYwhQpuf+rUfb6ppbeuBugeH2j9iAs2VgUDDoMvQ8uERJIoJ0dLhFi8ebhhQFHnHQlPw/9dqmbuhITwEZUc8NS0HHF2lrSuuueOR0F8IZnEVfwDBw7GfhEyuwR3Lda/B7NOzk5ncwfhYEXWEQToHeTTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980081; c=relaxed/simple;
	bh=bdt+fCdWMxDVPd1WMZzMhjblywOR2jr2gGzzvxwXGlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWufi9l1zksbAAP2XjyZ/dpGe/lJjO4th/gsCgKd0v2Ep/eEB6qMk14hT6P5ywcJxrPHSWb4SQgG4jq3WkWIY8tZUX+UEj7Ck9b0xAx0UyMugDR6lv9iUp9edgpOTixJgNvSuw0F8xsKSNb4RWn2HmHR85wO27MegOU5vsUqAKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TGUcBNp8; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C19fObg/Kw+If8Y44pWWr8vC1VtKwmvbYvOAomajqcetadVIvpCgrI6dD8wHQ490eht3gQs2LZhN5Aw0fUft7OSqhHDdhXZ3oDGRt/cQ91KfCBCbbjw9ayJdqwi0e/bFVN1LnOVcEgtS6e9QeKWtpn64azrPTEqWI3H9hqZBeBk4w9YCJWHkRd7PXVhGXTrF4yCKH2cglAp+NmkapRwd8a60C2v84hW26TJNCPUZlsxkX7QPrVHiFS50mCYaNybNuSuLJAFb9tu4y13AL4ADf33hE7GPyDrg2GsEPk1N8DyysGijB/4MK0qOasDKtHc4lmAJGSvMOvSgT4ScS96eaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV2YKrMCqKwNq604f0AmVBlZsF+4Z51ZwJFOxrnx4vk=;
 b=mxIXX2w0Uf2XzuaG9ZE7lNHr21p4NXQViHsgeG+GTTe+vuNGzZ1oIlkamuzmSE0nzJuznsaBHdAYrSeVHGvjbKuqxSbXpQ9vaxOpUrkDU0r7v/nUNLC3upEddLXUPyEz0Iv+sTRqgwSY4+yLn/MHcFrQ+KPHj+bskdifn8pI5fzuhJQ0oVOm90Lu5qRnMvGxmnnDc3axmambnRpSmNjPSPXx9sEuD4fU6lKQ2kqxDeD6wqjhrIIl150EDO8Yu5SP5KFThvMPqnB0a9zukO12iXZ8Ce7RnvTt47VhSRgz7Jlzp6vwrpPrx4OJYc8CzqydJUsVP84QDu/T33japhxCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV2YKrMCqKwNq604f0AmVBlZsF+4Z51ZwJFOxrnx4vk=;
 b=TGUcBNp8Yw7fB59Q4PqaH0wgzeC1JrgjGX83XxEyCeLxRD5ZlY1/aCAPPI6dWBeFq18yUOr/zG0DwpJANX0Ysf+qaXi6VfyxPfBw7CvK2PQoC5XJc/m5rP34z6pFCsBOStGVgKmyCGFz2AzJVk7ZWr2q+L63G+MiLGZYP8ItR/3m6ZIfBdpl2ZmS97kQjxdhIW8SjMS4Ou2GmqpkpnKlqNDkgKrDiABxE21lCR1Thr2UBJIwGRBSLm2stOgtZfyMBsiNVJuImKJ7KSMVMqjSpIKbIotQhxPF1mP/7csMXTp84brohwAT1RqJ+KXCxwpf04cOQw+9JLSXc0pCmo+XHQ==
Received: from CH2PR05CA0036.namprd05.prod.outlook.com (2603:10b6:610::49) by
 PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 03:47:56 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::2a) by CH2PR05CA0036.outlook.office365.com
 (2603:10b6:610::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:47:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:49 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 10/14] iommufd/selftest: Add IOMMU_TEST_OP_MV_CHECK_DEV_ID
Date: Fri, 12 Apr 2024 20:47:07 -0700
Message-ID: <25795ef3ef187b1d2fda3d385b0d678ffefce875.1712978213.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 05085a7d-d773-4cf1-8a85-08dc5b6c814f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DDwD7WaHGe8yqbLT5IHEt921OMiAE/Nqfosjs1ZsKIqatHsW1E0MnJh/hkL0K/XQZukaH8jGmsH3JgvIBYcar2zWsPZcBVkVHOJd56peivFNlR63oWw78G3Q/0q2lU3h9q18crDyRFHaFMUNDeZJGU8/j+mW09K0giQ0ljl7u3mb/g44+eUnzVuSkHOkSFxpSusVSw3oP5ZMxRtZCXo411d2P4u+eFKqYTVm4VnOcndrmP8hJe2ECJcI3cS3nd4OQDmFDkFZQ/67vqZkgd+anbakQ87/wLEILRFBFxuYv/G5vm11ClVMVMLkNbA6YYp7LjmdF24A8DfRHqzXwvmsp8gwuce9q0F4QFp3FA672j5Eel5ZYkn7Ias/LAdc0p+uxL0iWEomZpKuigXB3RVlsIDzWRkw9l5diSNYLQbncnOrr+SdS19qCklcpwC65owQ6wHO8W4Neto0TvLwG0MB6s3F6gZjLGrwyNDvMxTRSPRfSaFeUmcSVMLsZ23jV2apaPQ8VInt7WNNdWIOtvDyPWUKc0ASN0tpP70LeQOVxgr/MuKsLbovzzRgEYyFN7OiZ8CWaV8v0GgfXNfSzCeQ2W+ELctzJExhZTzFUA7Te1d3tocGi6IxnKE3ZBx7u+swSs+OwuWtu7lNzd9vEZ5zTPCwXIlH+NbAW2BAyFNtsp/O8kuEfyJBH7TWUHVva2wGIFdpIvb7PSchJreaSefj+ZaTq7JVkMTp+/GHy47JQXcmu97GU9FluOU/b3OLH4/V
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:56.2587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05085a7d-d773-4cf1-8a85-08dc5b6c814f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954

This allows verifying the ids xarray of struct mock_viommu, and confirming
the correctness of an IOMMU_VIOMMU_SET_DEV_ID call.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  5 +++
 drivers/iommu/iommufd/selftest.c              | 32 +++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  7 ++++
 tools/testing/selftests/iommu/iommufd_utils.h | 24 ++++++++++++++
 4 files changed, 68 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e854d3f67205..91af979a0c23 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -22,6 +22,7 @@ enum {
 	IOMMU_TEST_OP_MOCK_DOMAIN_FLAGS,
 	IOMMU_TEST_OP_DIRTY,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
+	IOMMU_TEST_OP_MV_CHECK_DEVID,
 };
 
 enum {
@@ -127,6 +128,10 @@ struct iommu_test_cmd {
 			__u32 id;
 			__u32 iotlb;
 		} check_iotlb;
+		struct {
+			__u32 idev_id;
+			__u32 dev_id;
+		} check_dev_id;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 4caed9304065..b7d0ce3d3659 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -999,6 +999,34 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_mv_check_dev_id(struct iommufd_ucmd *ucmd,
+					u32 viommu_id, unsigned int idev_id,
+					u32 dev_id)
+{
+	struct iommufd_device *idev;
+	struct mock_viommu *mv;
+	int rc = 0;
+
+	mv = container_of(iommufd_get_viommu(ucmd, viommu_id),
+			  struct mock_viommu, core);
+	if (IS_ERR(mv))
+		return PTR_ERR(mv);
+
+	idev = iommufd_get_device(ucmd, idev_id);
+	if (IS_ERR(idev)) {
+		rc = PTR_ERR(idev);
+		goto out_put_viommu;
+	}
+
+	if (idev->dev != xa_load(&mv->ids, dev_id))
+		rc = -EINVAL;
+
+	iommufd_put_object(ucmd->ictx, &idev->obj);
+out_put_viommu:
+	iommufd_put_object(ucmd->ictx, &mv->core.obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1484,6 +1512,10 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
 						   cmd->check_iotlb.id,
 						   cmd->check_iotlb.iotlb);
+	case IOMMU_TEST_OP_MV_CHECK_DEVID:
+		return iommufd_test_mv_check_dev_id(ucmd, cmd->id,
+						    cmd->check_dev_id.idev_id,
+						    cmd->check_dev_id.dev_id);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 378fbf00730e..3af5932c227c 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -288,14 +288,21 @@ TEST_F(iommufd_ioas, viommu)
 		test_err_viommu_set_dev_id(EINVAL, dev_id, viommu_id, 1ULL << 32);
 		test_cmd_viommu_set_dev_id(dev_id, viommu_id, 0x99);
 		test_err_viommu_set_dev_id(EBUSY, dev_id, viommu_id, 0x99);
+		test_cmd_viommu_check_dev_id(viommu_id, dev_id, 0x99);
 
 		test_cmd_mock_domain(self->ioas_id, &stdev2, &hwpt2, &device2);
 		test_err_viommu_set_dev_id(EBUSY, device2, viommu_id, 0x99);
 		test_cmd_viommu_set_dev_id(device2, viommu_id, 0xaa);
 		test_err_viommu_set_dev_id(EBUSY, device2, viommu_id, 0xaa);
+		test_cmd_viommu_check_dev_id(viommu_id, dev_id, 0x99);
+		test_cmd_viommu_check_dev_id(viommu_id, device2, 0xaa);
+
 		test_ioctl_destroy(stdev2);
+		test_cmd_viommu_check_dev_id(viommu_id, dev_id, 0x99);
+		test_err_viommu_check_dev_id(ENOENT, viommu_id, device2, 0xaa);
 
 		test_ioctl_destroy(viommu_id);
+		test_err_viommu_check_dev_id(ENOENT, viommu_id, dev_id, 0x99);
 		test_ioctl_destroy(hwpt_id);
 	} else {
 		test_err_viommu_alloc(ENOENT, dev_id, hwpt_id, &viommu_id);
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 81e9184fd1d5..e926fa289baa 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -731,3 +731,27 @@ static int _test_cmd_viommu_set_dev_id(int fd, __u32 device_id,
 	EXPECT_ERRNO(_errno,                                                 \
 		     _test_cmd_viommu_set_dev_id(self->fd, device_id,        \
 						  viommu_id, virtual_id))
+
+static int _test_cmd_viommu_check_dev_id(int fd, __u32 viommu_id,
+					 __u32 device_id, __u64 virtual_id)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MV_CHECK_DEVID,
+		.id = viommu_id,
+		.check_dev_id = {
+			.idev_id = device_id,
+			.dev_id = virtual_id,
+		},
+	};
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MV_CHECK_DEVID),
+		     &test_cmd);
+}
+#define test_cmd_viommu_check_dev_id(viommu_id, device_id, expected)    \
+	ASSERT_EQ(0, _test_cmd_viommu_check_dev_id(self->fd, viommu_id, \
+						   device_id, expected))
+
+#define test_err_viommu_check_dev_id(_errno, viommu_id, device_id, expected) \
+	EXPECT_ERRNO(_errno,                                                 \
+		     _test_cmd_viommu_check_dev_id(self->fd, viommu_id,      \
+						  device_id, expected))
-- 
2.43.0


