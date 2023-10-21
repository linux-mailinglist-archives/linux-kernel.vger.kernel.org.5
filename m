Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922CF7D19F5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJUAhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjJUAht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:37:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4590D5E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmfLJ2mbYgYSaEYUPmiRcawBzDSyOyGseCe+5zEuM0pJWUttXR8dI4gWKr8YE7NED28K70OCL1iGZ1b/WGy4KVAUiVPWQaVIdoIaIV8W8q0KfRvt/sc8XNBsLNL9tBMZ/4rqMSgklqSRF/9GoyNqNCVVVtof7uzBbgqauI1Na3HFog5lQ2xxstOV6FqnXaWwm90lBaTfFaRgQEVO7XaJrGxx0/37QosUKidPRLZxcrdIYqYsR/IsZDLVsRn6Jamqh6AQdW3xYhINn8EATK9EhcylZ0bAs/BYxZiId0n8qbNXgSFnuWOEAurIR8FhKG5G/cLzo/6gYkhwY+7rybwviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O62+6okMYox98i2Xpwmw9LZ8f7GEqBojjmF7ctQflQM=;
 b=civi55JwHU/MiqSYwEQvdG/dCXnxUl33IlfuuIlJ9wrDpGQ8C29qY/StwfDs+E05qCtg0gp2feMHgUYE4T6yqKGwsE0a/S9x64OSO4lbM16JTDr4VJPYKKoTG/3WkKsVzY1uVaqbWq9+LMLTIy0eESmAGReLe2M0RHNiaxgGd9d/nplFH6YkxKlH53fLd5sBb9MYb0+/SpZSqk+jjSke96mUopRq1wCr7JIW0cjwmQWkc+3AZMLjURhWnE70Vwh+a5iSQrsnV/MqvQn6Swrcsr6ycZUni5e8J33g00W6NQ+UcpvNvoxmtVbxZE7Q5ZNxrQdyUZYEm4YJ9NEtzZPTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O62+6okMYox98i2Xpwmw9LZ8f7GEqBojjmF7ctQflQM=;
 b=JptZhB/l3onB6YZx0b/iC5Y/OM1fNs8IOGoNz2chnoVqUVxYdFC8by1jHl7bDkeLrtCRMNcgZoo4o1ZK4Y8hNtpzOoMYyMY7vxPj81NGQCUrNz1ln+bNDJyswdEH12iinaZSNiwjvYDCKdLYMQtK9lEHElTldWt57H1cLmlc5ugouWmxGp+KsQ/BBM6voaG8bSSlOIl6uRDghHavzLt4h67Oc4J2JTAJBHMgPo3MJOXoTJzhFZmz1hUw22t/J8NoC5DiUOH4WVyFKKQpM343QT7N3chaQ39SbpiyAgtlejfYqcWEaUJX5PJwN4HhYPSRVg2/h8mqmzyFeTbAiVxvfQ==
Received: from BL0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:2d::28)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sat, 21 Oct
 2023 00:37:41 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2d:cafe::4c) by BL0PR03CA0015.outlook.office365.com
 (2603:10b6:208:2d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Sat, 21 Oct 2023 00:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 21 Oct 2023 00:37:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 17:37:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 20 Oct
 2023 17:37:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Fri, 20 Oct 2023 17:37:23 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: [PATCH 1/2] iommufd/device: Drop enforce_cache_coherency in iommufd_device_do_replace
Date:   Fri, 20 Oct 2023 17:37:10 -0700
Message-ID: <5593200da9015fee7b2e8195c2998f36148d83de.1697848510.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697848510.git.nicolinc@nvidia.com>
References: <cover.1697848510.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: be22294c-5fd4-4cce-6c46-08dbd1cdeea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSJp0yuFnabwZ5Xd/D81jAepc0xi94U2Y3a6HUfXnT1yisCpSC/BwyNeFJIlJ1PTGGbLeMMiBg7KnP4hQeHHgABJUfAT1IKRqHSijdRHVwqdpxFf/HXKRbMLhPzx9A3S2Yw7SksK7v/zDw8etTSmI6oo4/u0V+UO7qGnTnQetHXCKlfxqOeT8bEcYnq/6B06pH99M0glUBgXiDera7PPxgbCG6kcIBcZJMJnGK2nPI+P/DupgAShHmXlcQvMvWzA2ZEcTSr9DdAxuuh8V3vBv5zX1odSWTyB2BX6p5T52lSxNoCvv3vzyUQtJ5EiaMweqFQbs8CiPGTewtJG0mWFzepgqF2YI2qGDbfHrtwXHRx4AFfPORV7IzD1iL67Bo/zFvZwLqOtnus8iXvujLB+asSo3IxXdTtBYLa4bZeQL0xJOF/ahD6/U7S8kBxBV3UDEZUcspARUFakdV38jtxzeO3BJ0AvO+tVLiD6IIWjRC8eE4987CXnyuDUZlioY2a7d152vKbzquuuPiydseUC6YMxQmRpEka4emRkVuUjn7Ni+Fw2fmZS0Qjmf0BhQjT5/n/CTY2EQcGNvjSaSLsJZOSf9SP8sPPKIxyi4UgeHBiE7CFxc8PZhJiugbxl6l4tnWvSIKVbSoKC0px3Jv/XCTjFNqf0BTw75Cxb0ob18ZjrjECgkVbHB8eUcG8EIAUnNrj+gltCcRrfBFumk3s/7lg69D5W4NJTgB9ikJtRP53jjQOpaESawmgdEywAFRPvciEuO8vpPoXsFQUBvG7Lj97oegvDB9eXlpm4uJnbj8E=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(426003)(2616005)(8676002)(6666004)(7696005)(4326008)(8936002)(966005)(47076005)(478600001)(336012)(83380400001)(26005)(36860700001)(86362001)(36756003)(70586007)(54906003)(316002)(110136005)(70206006)(82740400003)(2906002)(41300700001)(40460700003)(7636003)(40480700001)(5660300002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 00:37:40.3607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be22294c-5fd4-4cce-6c46-08dbd1cdeea9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the conversion in the following link:
https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/

The enforce_cache_coherency should be set/enforced in the hwpt allocation
routine. The iommu driver in its attach_dev() op should decide whether to
reject or not a device that doesn't match with the configuration of cache
coherency. Drop the enforce_cache_coherency piece in replace(). Also move
the remaining "num_devices++" piece closer to the refcount that uses this
num_devices.

Cc: stable@vger.kernel.org
Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
Suggested-by: Tian, Kevin <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e88fa73a45e6..c93f3478f808 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -429,16 +429,6 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 		return NULL;
 	}
 
-	/* Try to upgrade the domain we have */
-	list_for_each_entry(cur, &igroup->device_list, group_item) {
-		num_devices++;
-		if (cur->enforce_cache_coherency) {
-			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
-			if (rc)
-				goto err_unlock;
-		}
-	}
-
 	old_hwpt = igroup->hwpt;
 	if (hwpt->ioas != old_hwpt->ioas) {
 		list_for_each_entry(cur, &igroup->device_list, group_item) {
@@ -465,6 +455,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	igroup->hwpt = hwpt;
 
+	list_for_each_entry(cur, &igroup->device_list, group_item)
+		num_devices++;
 	/*
 	 * Move the refcounts held by the device_list to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
-- 
2.42.0

