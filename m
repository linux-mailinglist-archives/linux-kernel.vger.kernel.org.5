Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782A0765DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjG0VK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjG0VKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A760130E2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHV71sn2ox1AcWuqZ12UxE14ZqYIjmqU/feimkvLhJhxoKDU2PgiOW0GjwfaVnMSxwfE8r0+ZE6itjNLiHAwQGLuaM42Bs3H2lhrkOoC9qIMAX5beVJWlYCGfQ6apdx8w9FXWLgZVAeatrYkDGzjAskmgIqyh3Me0Db1zFOatJzHHPoIKdpYsPPpCYVe5VBO9O3B18Poa+NpU/XfsZRU0O9AeOZ894txvMghe172AIcn/9x34cK9JXrOwHAPqajLkcjxNn9+um14Lyg8jaCb3w5MhJjoq/yE33u0CmEDGbBcGGKGA22vdhVlaHuJmFdaB6z4bEvNxEch2Hy/zIh7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVUp7tyth7M0dMVM+B5NVgjDD9OgyJpbL/BoepjgWIg=;
 b=WVPmDmhO1giWQnwVZMY0FKNQY4nxD/Mq78aXkr44MqQH2nIrCtYrDDQI2/+NVTZzAdVqrFlqv49pY+C+zabqcn0cGg8llO2ulcd9/dcStVPMjDYBhBTa7pz72TW6IRRkUylVfv6jj0bAmeYkiW8CNoNRHWKJEQkJMNnlQgGKyfNRZKCXLt/RB10DXBHQvW31IWPeI7idmSk5PVedfQvF/86pA4wG1IJ7/WwlzS1XD4pd9mMP9QWhftBqzHrv9Hh97mxQ7hIxozfWfTwhSdIKYGWBrdmrDshIx0VQkiJOZusKKOikF7nj6ZXI4/T5DymxvGoINsUuJ1YnOTPqTe+gjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVUp7tyth7M0dMVM+B5NVgjDD9OgyJpbL/BoepjgWIg=;
 b=c2gBRigCV6T/+ianLCbfwm2t/Gs9vx5l7srsHY7IjTu+gOWGaJ+WAuEq8AWYp7MPXRbQ3G1kV1pLI5XzAnnc0Qx9/HzaUdtYLkLXUS0cnMVFpgiiAU759Y+DKmEhTfLTtzz4ER6Eo5XNSWsA0eTqdg3jFBs/95gH4Nau6hAeXLehCNWRxSj7CY67wAHHq6Cv40JFSExtfJYRXyvEv8LSCMeuPgFJeqPhr8r0W6IDUZC1QGNR3kvksiOmojTdHfLB4aXvBuyAcM/MZxTbBmsOVpOa9NQpT9S1k8109x72/HnJglQnBzI7b+OiZva+Kjdb9cbwXz5LdfIM44+ZIlWFdQ==
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 21:10:14 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::6e) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 21:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 21:10:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 14:10:03 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 14:10:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 14:10:02 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/4] iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_DATA
Date:   Thu, 27 Jul 2023 14:09:42 -0700
Message-ID: <dad673c2f4b50a046bc8cc48c4cb21e97e2e06ed.1690487690.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690487690.git.nicolinc@nvidia.com>
References: <cover.1690487690.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 044d7da4-35ae-446b-4f29-08db8ee5de9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2nCkDJeaIDaZYKs5ficREnaN5aQAX+EsYyxlv/aEf1hkQso9uBL6dI9UkR36+nCQIz2c7QNNI4+q1TiDhLXZkU9dVSceZOtqefkeyJfJ3XLyUOjrAx39QM3Yl0q74SXXqyl/MseE2X9z8cmZ+7oTfmo3BcWXUsDp+9gQVEpm0hs71PhnuLKu8TJRi+UIq6pzMBMiIz+XMXa/dIDyRVOrDiocY+q8aHmkSU844HqP0mF0w4T2gO/5q8X+qNRsfQY22tEDHPNlZAaIgYIpvEKjVdJmmz0yxedPFctvJWnTr59OAsFENbjPr5ya/qZr2DQ6mzIQ/FAocMnxp+c/yh0Ple4gQ4FcoM4RC1gS0qAJbInz2jmBfmbnc6+HQ4qeodj5yuw/byKDQWAUaT+QW/M5HdAHTrxVPydAPQI+zOFSe/jYo6oguLKGzsTlfMwG+ri0aUMdG3cIqssVSRR+go5oZ1RUGiPywowUjWLlhpnZurHC9vX8BAj3ZLju+JiggVw2MpxmDJhvySW1SOqk7tr01qrq83C8tKInp7Pn4gxEb9Et6rEKxHjIPcpISbrcK84NMrXhuC+AYyWQ6U67OZYfzkDQyvpFNnwi6nHfLXFVhkKTb2b/K8gPkYuAuD+OxLOQtZN0uKINlpmmlCTdy/ttyUjbmAF4DOtdzP/CxeSNHCTvxzoI9Gvh/Ex1SmiD+RoA3CnMg0IYZ80pC2xjN8wniV7auC8rY9gQovW+H0fi4BA3tQFDgmq2UJLgbWU+8zN
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(426003)(316002)(7416002)(40480700001)(40460700003)(356005)(47076005)(86362001)(83380400001)(70206006)(336012)(26005)(41300700001)(186003)(70586007)(8936002)(8676002)(4326008)(2906002)(7696005)(6666004)(82740400003)(5660300002)(2616005)(36756003)(54906003)(110136005)(478600001)(7636003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:10:13.4935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 044d7da4-35ae-446b-4f29-08db8ee5de9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mock_domain_set/unset_dev_user_data and iommufd_test_dev_check_data to
allow testing on IOMMUFD_CMD_SET/UNSET_DEV_DATA ioctls from the user space
selftest via IOMMU_TEST_OP_DEV_CHECK_DATA.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h | 15 ++++++++++
 drivers/iommu/iommufd/selftest.c     | 42 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 9768d0c9e347..b191d7417719 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -22,6 +22,7 @@ enum {
 	IOMMU_TEST_OP_DEV_ADD_RESERVED,
 	IOMMU_TEST_OP_DEV_DEL_RESERVED,
 	IOMMU_TEST_OP_MD_CHECK_IOTLB,
+	IOMMU_TEST_OP_DEV_CHECK_DATA,
 };
 
 enum {
@@ -105,6 +106,9 @@ struct iommu_test_cmd {
 		struct {
 			__u32 iotlb;
 		} check_iotlb;
+		struct {
+			__u32 val;
+		} check_dev_data;
 	};
 	__u32 last;
 };
@@ -119,6 +123,17 @@ struct iommu_test_hw_info {
 	__u32 test_reg;
 };
 
+#define IOMMU_DEVICE_DATA_SELFTEST	0xdadbeef
+
+/**
+ * struct iommu_test_device_data
+ *
+ * @val: Should be set to IOMMU_DEVICE_DATA_SELFTEST or unset to 0x0
+ */
+struct iommu_test_device_data {
+	__u32 val;
+};
+
 /* Should not be equal to any defined value in enum iommu_hwpt_type */
 #define IOMMU_HWPT_TYPE_SELFTTEST		0xdead
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 5f3e1f2a24e7..526ec6066d17 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -97,6 +97,7 @@ struct mock_dev {
 	struct device dev;
 	struct rw_semaphore reserved_rwsem;
 	struct rb_root_cached reserved_itree;
+	u32 dev_data;
 };
 
 struct selftest_obj {
@@ -375,6 +376,23 @@ static void iommufd_test_get_resv_regions(struct device *dev,
 	up_read(&mdev->reserved_rwsem);
 }
 
+static int mock_domain_set_dev_user_data(struct device *dev,
+					 const void *user_data)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+	const struct iommu_test_device_data *data = user_data;
+
+	mdev->dev_data = data->val;
+	return 0;
+}
+
+static void mock_domain_unset_dev_user_data(struct device *dev)
+{
+	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
+
+	mdev->dev_data = 0;
+}
+
 static const struct iommu_ops mock_ops = {
 	.owner = THIS_MODULE,
 	.pgsize_bitmap = MOCK_IO_PAGE_SIZE,
@@ -385,6 +403,9 @@ static const struct iommu_ops mock_ops = {
 	.capable = mock_domain_capable,
 	.get_resv_regions = iommufd_test_get_resv_regions,
 	.set_platform_dma_ops = mock_domain_set_plaform_dma_ops,
+	.set_dev_user_data = mock_domain_set_dev_user_data,
+	.unset_dev_user_data = mock_domain_unset_dev_user_data,
+	.dev_user_data_len = sizeof(struct iommu_test_device_data),
 	.default_domain_ops =
 		&(struct iommu_domain_ops){
 			.free = mock_domain_free,
@@ -833,6 +854,24 @@ static int iommufd_test_md_check_iotlb(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+static int iommufd_test_dev_check_data(struct iommufd_ucmd *ucmd,
+				       u32 dev_id, u32 val)
+{
+	struct iommufd_device *idev;
+	struct mock_dev *mdev;
+	int rc = 0;
+
+	idev = iommufd_get_device(ucmd, dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+	mdev = container_of(idev->dev, struct mock_dev, dev);
+
+	if (mdev->dev_data != val)
+		rc = -EINVAL;
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
+
 struct selftest_access {
 	struct iommufd_access *access;
 	struct file *file;
@@ -1255,6 +1294,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 	case IOMMU_TEST_OP_MD_CHECK_IOTLB:
 		return iommufd_test_md_check_iotlb(ucmd, cmd->id,
 						   cmd->check_iotlb.iotlb);
+	case IOMMU_TEST_OP_DEV_CHECK_DATA:
+		return iommufd_test_dev_check_data(ucmd, cmd->id,
+						   cmd->check_dev_data.val);
 	case IOMMU_TEST_OP_CREATE_ACCESS:
 		return iommufd_test_create_access(ucmd, cmd->id,
 						  cmd->create_access.flags);
-- 
2.41.0

