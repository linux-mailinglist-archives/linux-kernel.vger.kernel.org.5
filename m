Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8456765DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjG0VKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjG0VKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1024030E8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hju7zAfzntqKqJyObzsJOZahojfNvUh6tK03CugQ/Flvha39RtF1ikXjWBCc4HEiKH9utrk9rEBdy+KvYtFEITMrgqLhx2KJKRbI053Xsk06+IkRbHkM2RYfJmkAHx2WI4lW6QuFGbKGzFIH8w1qN3DnM5763z/29vsJJWs9UvnjIhFvlG/l1sV59OrZ0CLtu6scbcXOJjZPWB36QbOBugThNV+QvEy4eWDT+gOVEerNjMJncObP2M3+dzniJDcARmcsCG8igOwNkoeKfunqLIBVz0+Ofv21L9cs1xu/CD/nNwveJrsEtGG+BqPDMf1ysodzYQZcGEmoqaI3l2pLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxHpZOXrXPISX7kfANEyB4/sA9KUi6B6vgPuNZZqFdI=;
 b=flyu+3xqtJ44xyXFDRTdwmyCyZ4cQa3OWmbzbDNRTeb0+Qj/kOY3q9t0cWqs2djSwdaAId119WIQWApbZh41oBCiC/LA2HlDSbuF2D3UOBQ4tYE3qjNM4duxdiYY4S1kVVj9tzVgjdqWFZY/pqFPZBMpwyOgl49tbHP55oUVDLZTXw/s/AXATs+ZK3IuAa4ziOgMvZTvtTepoS9vgQFkufCvtRsQYo31RUQLtnD7pdpZCr0RlhlVovVtmiwnib9PiE3BcKTjYqNjm5eC3mCz8bHqev5eC6kIfPCXDD3SZJGHxW+dy2Rtv3IKAbz66oHMUJj+pT9Tu8LqR0e4gU2tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxHpZOXrXPISX7kfANEyB4/sA9KUi6B6vgPuNZZqFdI=;
 b=iU8XLqco5+BjywZe8+9woeUstWpcb1ZHclYzEvdZFCAh2bp86smU1K55p0/6jqrJ3v3hxLwzWNczGf8J6xCctju6QEDzzxEasCo0a2O7XGZZXGufnUcv5zTvG1vsj8ubtnwAp1LCnnzfg3lOaTSXTopB8FOqxOR2NmX1np0WoYBHTrAtkcbc0Rfe7FB+v8UEtMhZyZHuSY5o4++xAB6LUcyDNZZTr1GRo/9MydTVJRgdJo5vQpZzsgPg9onkYJCnJNyj80u/vugIwomSW8tE/fSUP6EDpANg7bKa24o1EWA1EcthyOq8ji4K1jepbQGGsuIWzj04t4npRg2VbUcWjg==
Received: from DM6PR02CA0086.namprd02.prod.outlook.com (2603:10b6:5:1f4::27)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Thu, 27 Jul
 2023 21:10:19 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::40) by DM6PR02CA0086.outlook.office365.com
 (2603:10b6:5:1f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 21:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 21:10:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 14:10:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 14:10:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 14:10:03 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/4] iommufd/selftest: Add coverage for IOMMU_SET/UNSET_DEV_DATA
Date:   Thu, 27 Jul 2023 14:09:43 -0700
Message-ID: <5b192832f6a8a02e24ba0712b1f9ab20735fd583.1690487690.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690487690.git.nicolinc@nvidia.com>
References: <cover.1690487690.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa4579a-ec9f-441d-c6e8-08db8ee5e1b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fNsa/t6YnpsWPRb3H9BRXbViLqL6NwuF7ZPdE7lXPYnqBNOwbS1OxvGbbh5wAGPanKO62jUJUgqk6TLwOzHS9HNltyFiTtYkHQndg9LDh75x5RzBKuChLGn48D4qoWjewkQm4XwWVftNW2qCEjufETziTWyaTAlo7CUd/eGtR30uuqMeepO9A+qHKliyTKyqp50nMGY1Nn0Z5xtgkLvN/M7rVJSRziCnl77YQ/e51MBDv850pxrwqO4ntQ+WvLgf5QqC9u3EZCPIjTH/7bD0hohlBN+GFa9udeFXoSMF2TRyPx9RiX49LLs/hXO4KL60gNaetEv3zZDVJkVZR6T2Vkz+tifuUZCX9NIkwVipamkfV9EY96ElYLtTIM9ID1kKag1T3utGLWQypf1l++Mo34epiFpeHSHcd+upMH7wTPRB/9sgfEeI501vOfK0B0LgjEOeatFQJfsyeIZb+5bfvJmNALwk4JtNwD6KradSHTWYDRkTXVQvKZn4fUS0VkdKGYf3Ta4OAKx+LcHpkEFlxm1l5fskJFkSmSx6Izo29Tqsq1mDvIbuRu7+BuaK85aUSifXhBj2HdJEiy/73ZA5yplPvtkZAwWwEqFzdOhcGJV3WsmUmvV4b9mSufy8tEVdLxv8ULtiPj3SJfSnSak6Uh6hr0o/gWjb6p4iKuQVW9yBtjZM7r5PpqTFKS13AwxjHXoU8A72cu67DgArlM/I7d2peLG9476Yt5wOVRDTw0yXmyzoVmSV2eNPcclkG/Z
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(6666004)(7696005)(356005)(82740400003)(83380400001)(478600001)(47076005)(26005)(70586007)(7636003)(4326008)(54906003)(70206006)(110136005)(336012)(2616005)(186003)(36860700001)(426003)(5660300002)(7416002)(8936002)(8676002)(40460700003)(2906002)(41300700001)(316002)(40480700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:10:18.7158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa4579a-ec9f-441d-c6e8-08db8ee5e1b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new IOMMU_TEST_OP_DEV_CHECK_DATA to verify whether the dev_data
is properly set/unset by the IOMMU_SET/UNSET_DEV_DATA.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 22 +++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 59 +++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index bf0082d88a38..b437b890e4f5 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -123,6 +123,8 @@ TEST_F(iommufd, cmd_length)
 	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY);
 	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
 	TEST_LENGTH(iommu_option, IOMMU_OPTION);
+	TEST_LENGTH(iommu_set_dev_data, IOMMU_SET_DEV_DATA);
+	TEST_LENGTH(iommu_unset_dev_data, IOMMU_UNSET_DEV_DATA);
 	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
 #undef TEST_LENGTH
 }
@@ -1517,6 +1519,26 @@ TEST_F(iommufd_mock_domain, alloc_hwpt)
 	}
 }
 
+TEST_F(iommufd_mock_domain, set_dev_data)
+{
+	struct iommu_test_device_data dev_data = {
+		.val = IOMMU_DEVICE_DATA_SELFTEST,
+	};
+	int i;
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		test_err_set_dev_data(ENOENT, 0, &dev_data);
+		test_err_set_dev_data(EINVAL, self->idev_ids[i], NULL);
+		test_cmd_set_dev_data(self->idev_ids[i], &dev_data);
+		test_err_set_dev_data(EEXIST, self->idev_ids[i], &dev_data);
+		test_cmd_dev_check_data(self->idev_ids[i], dev_data.val);
+		test_err_unset_dev_data(ENOENT, 0);
+		test_cmd_unset_dev_data(self->idev_ids[i]);
+		test_err_unset_dev_data(ENOENT, self->idev_ids[i]);
+		test_cmd_dev_check_data(self->idev_ids[i], 0);
+	}
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 9b3e5f36c4a3..eb756fffbc89 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -444,3 +444,62 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id,
 	EXPECT_ERRNO(_errno,                                    \
 		     _test_cmd_get_hw_info(self->fd, device_id, \
 						  data_len, data))
+
+#define test_cmd_dev_check_data(device_id, expected)                           \
+	({                                                                     \
+		struct iommu_test_cmd test_cmd = {                             \
+			.size = sizeof(test_cmd),                              \
+			.op = IOMMU_TEST_OP_DEV_CHECK_DATA,                    \
+			.id = device_id,                                       \
+			.check_dev_data = { .val = expected },                 \
+		};                                                             \
+		ASSERT_EQ(0,                                                   \
+			  ioctl(self->fd,                                      \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_DEV_CHECK_DATA), \
+				&test_cmd));                                   \
+	})
+
+static int _test_cmd_set_dev_data(int fd, __u32 device_id,
+				  struct iommu_test_device_data *dev_data)
+{
+	struct iommu_set_dev_data cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.data_uptr = (uint64_t)dev_data,
+		.data_len = sizeof(*dev_data),
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_SET_DEV_DATA, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_set_dev_data(device_id, dev_data) \
+	ASSERT_EQ(0, _test_cmd_set_dev_data(self->fd, device_id, dev_data))
+
+#define test_err_set_dev_data(_errno, device_id, dev_data) \
+	EXPECT_ERRNO(_errno,                               \
+		     _test_cmd_set_dev_data(self->fd, device_id, dev_data))
+
+static int _test_cmd_unset_dev_data(int fd, __u32 device_id)
+{
+	struct iommu_unset_dev_data cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_UNSET_DEV_DATA, &cmd);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+#define test_cmd_unset_dev_data(device_id) \
+	ASSERT_EQ(0, _test_cmd_unset_dev_data(self->fd, device_id))
+
+#define test_err_unset_dev_data(_errno, device_id) \
+	EXPECT_ERRNO(_errno,                       \
+		     _test_cmd_unset_dev_data(self->fd, device_id))
-- 
2.41.0

