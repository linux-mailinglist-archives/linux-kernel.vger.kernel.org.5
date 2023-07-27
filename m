Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0F765DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjG0VKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0VKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:10:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965D30DC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPktB2Xbk53KJ/0QScfStOI2DhRVPJWC+DAylmg5uYicofbTBQuLOOthvQR4XtsSJJv2Lflgivr2hA6uuqkZIwKxRA2LVFeSyZDubZTN4NpJZWk6ayv6Q6jFEJj1Eeib4S87Ss2Yf8QhY2pXMNtnqXXZ2Rvi/3AqR0N6eRuZ3SF8M+pzlYFUuDpUDrxu/H7BGHJI85iLhECvnv5caj7ffHcGVY0YAG/Xj6XXRrWbz3JULgH4T+WTwc+kNLE+56VtlKvFwP26oKLJhC8XxE++cs1ypKceAGMJMEBfBj38sDMyXeabApaniMFSxn84xV5i5Mu1/OlcyzGXw+dYbJCcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri7L3Hw/A5KeDrdH3l0dkLhCMQTNk23gWQFUjAXFL1o=;
 b=mCHNVkPO9OMIDoZ6ZCKEIILknNbL9B8hyZPxupKun194je1tKKiTJhbYyjBM8rISvt12akhaPnfFNGyDQVVh3IDh0MbyFudN1vD7XZnuzngGdPBeaV0QnOn9XOJppHCX7YKCIBe+7lo9aNtNdUI4cEPkk6C/yNJZEYCiSVwcUfKWhikIzecSfTc+gMUhnQ530ZFiAQDgAwmFELXNEd1f8z9DUxgHfnGk0pBc9bZZ6M+nz/IJ8v+Rad6YWuh7AlxfJs5GmDC/f76tQ2J0zHKhO6LuaNIU1MYst+4NFRM94mvE6zeqkuNMEnQq+Ck4bA9M7EC8ig7HBzVzgcxtLb592A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri7L3Hw/A5KeDrdH3l0dkLhCMQTNk23gWQFUjAXFL1o=;
 b=X7gLSfffnCuYovbJNRoEpTIzdA86eJj90RHZH28dotUsHSHCgkS0OxHmaCAjZb3u1UJTPVZy+6n5F3qhuvFhOXJL8w1G9GkTpXxts1WUzWtpVpCXRJsI8XlFHLZqyRCKTsjvFLmqY3r0/4NjIzU0GKwFF5Bv9rDYEoOKzFGsBKyRPk6s2Nwwov0WiEUwLrAbKwQPHxk7lNmq1XTpgrdZjEqGWIStIWS2Qk3FzL12yI4Ad+CvPYBWMwMNtwYlrZfUcdzC690yiUxJ8r9eYoiPNIj290C9YeQNDAzQRnHBSdIrKp2uvijp7o1dcWSCWLuRCx91aqIpvGnl+w3i0ZQ5ag==
Received: from DM6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:333::9) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 21:10:09 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::c2) by DM6PR03CA0076.outlook.office365.com
 (2603:10b6:5:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 21:10:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 21:10:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 14:10:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 14:10:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 14:10:00 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>,
        <will@kernel.org>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/4] iommu: Add set/unset_dev_user_data ops
Date:   Thu, 27 Jul 2023 14:09:40 -0700
Message-ID: <6772ccfb71cd1eb3d402d82836ae7e98a853a793.1690487690.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690487690.git.nicolinc@nvidia.com>
References: <cover.1690487690.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa2da08-4126-4f0f-8a98-08db8ee5dc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7T05ls9kJ24Zsidefw9jYSUw22VJ6gIcXkYLaD5OCKh8MVdhBs7JbP+Xmu9Mm6a1VSj11E09WNhyHKyAP3nckjHQABf0YyXI1FJYev3R3HbHRc3ZhlxXs4pb5CsFL41kkRSr7uJEL2ghjSBttBYoP1QhCs8HgjxNQQyIsvZCMgRUFm+cO39zSHdBXBIbdNn/Ma0jJPopVsDeY28WiAeCb34Dus0BOgPQF7qRag/3kXropz9b5TeYr4/6nlCOoNdzmmb8oM+9eerfS3jHGg3pWeyKZ1iJO/RaDljnta69dBWYSo824itH65zubnGybaiIuAtc4zZe1A6rVwhnFClHdMxdNWuSkvOJ1pz2QtFWP9iXz+vbheyMS1CXuhOtckBFxeNo1QkGOr6cZKvEqGT084aPdCnSwRLlqgsy7yhf+2vZPnOTgXGK4APxz5boFyovyVuMAc7yT1uOkyc/IFmbKeFkxXE6V+GpeC7GJdraKhFPRq5ALXwwnovN5zeCMjj2mgjN9m1B+PGpxk4RKq62CrCg45N8fVSVs3Zrhm+eHMOEz3mfkU4iaW6HjTOMA4q9u5ex7JBFnegLYLB8RfZdZ3CHG48K/8A/g+yyjTh2YqERHueg+/VFM2GLZKX6pHWE5Hqr4Soq/HPtpzU4NL73jpzY/5bV+1UIcBPx4AnTsmoM9yblNFJHbyOt6Dx40GUPSQyWHPL+72rgXcsDwKRTtL02wcBw5pJV+viYLYWZgq8GdhH3cMpeJqnp0LQToC2H
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(36860700001)(478600001)(5660300002)(110136005)(54906003)(47076005)(8676002)(7416002)(8936002)(36756003)(86362001)(426003)(2906002)(41300700001)(2616005)(7636003)(70586007)(40480700001)(70206006)(356005)(316002)(4326008)(40460700003)(336012)(7696005)(26005)(6666004)(82740400003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 21:10:09.2024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa2da08-4126-4f0f-8a98-08db8ee5dc0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device behind an IOMMU might be used in the user space by a VM. So, it
might have some user space data. For example, a device behind an SMMU has
a static stream ID. In a virtualization use case, both a host environment
and a guest environment have their own Stream IDs. A link (a lookup table)
between the physical Stream ID and the virtual (user) Stream ID is needed
when the host handles the user cache invalidation commands.

Add a pair of new ops to allow user space to forward user_data of a device
via iommufd, and a new dev_user_data_len for data structure sanity done by
the iommufd core.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e4835230d5f0..231920efab84 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -281,6 +281,15 @@ union iommu_domain_user_data {
  * @remove_dev_pasid: Remove any translation configurations of a specific
  *                    pasid, so that any DMA transactions with this pasid
  *                    will be blocked by the hardware.
+ * @set/unset_dev_user_data: set/unset an iommu specific device data from user
+ *                           space. The user device data info will be used by
+ *                           the driver to take care of user space requests.
+ *                           The device data structure must be defined in
+ *                           include/uapi/linux/iommufd.h.
+ * @dev_user_data_len: Length of the device data from user space (in bytes),
+ *                     simply the "sizeof" the data structure defined in the
+ *                     include/uapi/linux/iommufd.h. This is used by iommufd
+ *                     core to run a data length validation.
  * @hw_info_type: One of enum iommu_hw_info_type defined in
  *                include/uapi/linux/iommufd.h. It is used to tag the type
  *                of data returned by .hw_info callback. The drivers that
@@ -326,6 +335,10 @@ struct iommu_ops {
 	int (*def_domain_type)(struct device *dev);
 	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
 
+	int (*set_dev_user_data)(struct device *dev, const void *user_data);
+	void (*unset_dev_user_data)(struct device *dev);
+	size_t dev_user_data_len;
+
 	const struct iommu_domain_ops *default_domain_ops;
 	enum iommu_hw_info_type hw_info_type;
 	unsigned long pgsize_bitmap;
-- 
2.41.0

