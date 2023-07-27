Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D04765DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjG0VKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjG0VKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C230E1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntA5uPuwtrQYbVfBHVm+Hhn+2nXugfDZ4ikxu/4Y7yG31Mq+rS5cfYanDxkrnuz1xjBNTnMjGrOGpl8YyG4gVNH/yxN/d60rIi4AgeromLNWLSYbOuTmdzy5fpW/2MtocCfUJJkmQPZ9MrqTxQdRf0nzOi5oJP8zYKy378aS2a6Jw7lxhc1rK/oMPrkjh5OORiOx02n8AAJSLVXfynn6iGcrEKl2onogQgYN30nUBUzuct/3xBu96UWlk7t2qrcWBVKMg4kie8eG5Dk5IK2T7ALBRZb5iwRiwa+hqBPRSpB3JamqUcH1LQq06sZ9dAyFVk2ATtIW9vLMSqjlDWfZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPtzgSNN1DVBfV1HRnOQyh1oJme15U55RGAgDKNIn4I=;
 b=R30j6LMZJlrfdz8UJzWvd+zIpFM1GV7zvVcLT6Dt+P54Zb4RVNoBFVL3KS4WoX1PVNzlT8JnMFCCX0tJeeqPZ2Fg5DufQ9HwYt1m0HXfMyRp2J9LVJzys33AHRrXSUnwuO31FzOvk7e0IAswK/zMjVYW7MnzVGNWHoSNA2Ju5mvWoMGVCNhxR3OQ2h3QK1fbyN1MUc7W4tvYrUIORiwWxGmeGOnJ169C91Qi8wRcMnq8+q3Q/YX4A93SoE4KnHYvilj1sejOnOlSnrHRNL7EbF+Dt8PWfTL7ZFbm099nLdxxphM86CgzsDjG5KqToK1uH9YaFk4EEkCXuWzpZRCZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPtzgSNN1DVBfV1HRnOQyh1oJme15U55RGAgDKNIn4I=;
 b=hJ1SaDlmRZ2tfT6BE70k/GzlRdaGCpR+ITuGXJRSVU15uaecEVxNiRICqLbQk1KMIIxWdIcAxvj9AQV8Ao1shTcsfdYaDD2H8Musg3hVg9iKN6iQnjuHP3rYzUNjAHWkU7iGQM4wBOOhM1emZhzdH7Dmk97fP3x1FdSQjU6/RdkryhE664QdIbr1QXKgXTkOpmmHXeuCCNQhEy8Eq15Ytxf0jUcpYRZEec8trtMG14s2kHqnfuUV7oJgrjsL+LUlEL5yBp/dJmFiOV0+EcbqkdhIKHp1KLwJyC8ztGE9853ZfbNXF6wGmaFoIJ+R+/0p4Ox3Bw8ksBDK5LUP5+FIVg==
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 DM6PR12MB4122.namprd12.prod.outlook.com (2603:10b6:5:214::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 21:10:15 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::3d) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 21:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 21:10:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 14:10:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 14:10:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 14:10:01 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/4] iommufd: Add IOMMUFD_CMD_SET_DEV_DATA and IOMMUFD_CMD_UNSET_DEV_DATA
Date:   Thu, 27 Jul 2023 14:09:41 -0700
Message-ID: <664cae4552da90eceacf02cf00bd29183cd1960b.1690487690.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690487690.git.nicolinc@nvidia.com>
References: <cover.1690487690.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|DM6PR12MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a0c027-147e-4ffa-d1b3-08db8ee5df9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLEz+9/Vs2xamO8UtBAmS2ORWJaXN3AYH9SwWvACIdY4GOQn5f3Ma1XaGndaCJpo9N5nJpkydKSDKrtSbLJ28fbtkTeF6yFBag5GwlAgG5g7U7GLCwdY8ZoC5EkGRVbUhdg+rAl1OLONUvpzw5nNVpkYM3baTDgNrK4e+7CQNQiLUVi4q3vrlzovvxGuTOr9Kz1uQ8H7C/InTOZgqH9ZRNMndNqf3Ru7iDrGU5RMpXPJ/G96UlC9QHwYn1PsuhUevTtG71mus1g8gRsx1wC27zwdq5deLlmlPODOh1UMQO52yAurZWe9zUSBvBC2TRDU4sN0sy+iQsczKDq9ZB+R2SmPF75ufNZdXRmLQxvo3xnNB0/z8u9t6yETTaBr5WbabVsBcguKo//6jYCAySU2cXuSQRlnTCp2i/NPhHKYAry8tstV9WJRrHV5ZPZWmT1YbXsXmWpCyJXN7aerWEehrD3g//pNV6Rjzr33I3+iIF3TIv8Wq9gETKSuKD0NNc62lYqafNdW5RwnDj+Kok6ExQKwgp0ow4R2z+c37TKnwIN02UVSS19ndFddKGWiHsWYAJ0xL5+rTtRWtg8VIp4B553FNCFzgm3Ea9t26ASfp3Hjbc0har9nn0qeVjuKyZ6FrUhu10CxiRHSWDi/be6VbVuOMo1op1B0Hb4Y0iHv2wYdKgOC+XehSN3Pk+I+T5CcSsk7X7jlv8+LAyqLZXs3GZzILr2GaIg7Gav3zIU8EFwuZCoq7BVQSPwca9iAT49O
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(83380400001)(5660300002)(36860700001)(478600001)(54906003)(110136005)(356005)(47076005)(8676002)(8936002)(426003)(36756003)(41300700001)(2616005)(2906002)(40480700001)(7636003)(4326008)(70206006)(86362001)(70586007)(316002)(26005)(40460700003)(7696005)(82740400003)(336012)(186003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:10:15.1746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a0c027-147e-4ffa-d1b3-08db8ee5df9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4122
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new pair of ioctls to allow user space to set and unset its iommu-
specific device data at the iommu that a passthrough device is behind.

On platforms with SMMUv3, this new uAPIs will be used to forward a user
space virtual Stream ID of a passthrough device to link to its physical
Stream ID and log into a lookup table, in order for the host kernel to
later run sanity on ATC invalidation requests from the user space, with
ATC_INV commands that have SID fields (virtual Stream IDs).

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          |  2 +
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            | 85 +++++++++++++++++++++++++
 include/uapi/linux/iommufd.h            | 32 ++++++++++
 4 files changed, 120 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7f238c583b61..37a234371645 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -136,6 +136,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	if (idev->has_user_data)
+		dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ae6edea697f..b8abf664d3f8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -313,6 +313,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	bool has_user_data;
 };
 
 static inline struct iommufd_device *
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 255e8a3c5b0e..d49837397dfa 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -387,6 +387,85 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 	return 0;
 }
 
+static int iommufd_set_dev_data(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_set_dev_data *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	const struct iommu_ops *ops;
+	void *data = NULL;
+	int rc;
+
+	if (!cmd->data_uptr || !cmd->data_len)
+		return -EINVAL;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+	if (idev->has_user_data) {
+		rc = -EEXIST;
+		goto out_unlock;
+	}
+
+	ops = dev_iommu_ops(idev->dev);
+	if (!ops->dev_user_data_len ||
+	    !ops->set_dev_user_data ||
+	    !ops->unset_dev_user_data) {
+		rc = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	data = kzalloc(ops->dev_user_data_len, GFP_KERNEL);
+	if (!data) {
+		rc = -ENOMEM;
+		goto out_unlock;
+	}
+
+	if (copy_struct_from_user(data, ops->dev_user_data_len,
+				  u64_to_user_ptr(cmd->data_uptr),
+				  cmd->data_len)) {
+		rc = -EFAULT;
+		goto out_free_data;
+	}
+
+	rc = ops->set_dev_user_data(idev->dev, data);
+	if (rc)
+		goto out_free_data;
+
+	idev->has_user_data = true;
+out_free_data:
+	kfree(data);
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
+static int iommufd_unset_dev_data(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_unset_dev_data *cmd = ucmd->cmd;
+	struct iommufd_device *idev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	mutex_lock(&idev->igroup->lock);
+	if (!idev->has_user_data) {
+		rc = -ENOENT;
+		goto out_unlock;
+	}
+
+	dev_iommu_ops(idev->dev)->unset_dev_user_data(idev->dev);
+	idev->has_user_data = false;
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_hw_info info;
@@ -400,6 +479,8 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_resv_iova_ranges resv_ranges;
+	struct iommu_set_dev_data set_dev_data;
+	struct iommu_unset_dev_data unset_dev_data;
 	struct iommu_vfio_ioas vfio_ioas;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
@@ -446,6 +527,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_RESV_IOVA_RANGES, iommufd_resv_iova_ranges,
 		 struct iommu_resv_iova_ranges, resv_iovas),
+	IOCTL_OP(IOMMU_SET_DEV_DATA, iommufd_set_dev_data,
+		 struct iommu_set_dev_data, data_len),
+	IOCTL_OP(IOMMU_UNSET_DEV_DATA, iommufd_unset_dev_data,
+		 struct iommu_unset_dev_data, dev_id),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
 #ifdef CONFIG_IOMMUFD_TEST
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 034da283cd3a..ede822e5acbb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -49,6 +49,8 @@ enum {
 	IOMMUFD_CMD_GET_HW_INFO,
 	IOMMUFD_CMD_RESV_IOVA_RANGES,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_SET_DEV_DATA,
+	IOMMUFD_CMD_UNSET_DEV_DATA,
 };
 
 /**
@@ -508,4 +510,34 @@ struct iommu_hwpt_invalidate {
 	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+/**
+ * struct iommu_set_dev_data - ioctl(IOMMU_SET_DEV_DATA)
+ * @size: sizeof(struct iommu_set_dev_data)
+ * @dev_id: The device to set an iommu specific device data
+ * @data_uptr: User pointer of the device user data
+ * @data_len: Length of the device user data
+ *
+ * The device data must be unset using ioctl(IOMMU_UNSET_DEV_DATA), before
+ * another ioctl(IOMMU_SET_DEV_DATA) call or before the device itself gets
+ * unbind'd from the iommufd context.
+ */
+struct iommu_set_dev_data {
+	__u32 size;
+	__u32 dev_id;
+	__aligned_u64 data_uptr;
+	__u32 data_len;
+};
+#define IOMMU_SET_DEV_DATA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_SET_DEV_DATA)
+
+/**
+ * struct iommu_unset_dev_data - ioctl(IOMMU_UNSET_DEV_DATA)
+ * @size: sizeof(struct iommu_unset_dev_data)
+ * @dev_id: The device to unset its device user data
+ */
+struct iommu_unset_dev_data {
+	__u32 size;
+	__u32 dev_id;
+};
+#define IOMMU_UNSET_DEV_DATA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_UNSET_DEV_DATA)
 #endif
-- 
2.41.0

