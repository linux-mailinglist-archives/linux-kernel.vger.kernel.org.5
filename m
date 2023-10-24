Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F257D44FE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjJXBaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJXBaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:30:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE4DDE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 18:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8iU+e0fwNvvJ/gKYWfy126VL+9av66xAuSgPIJIisgWrjSmMV1fUPnr+rS1oEYn8PyIXcnpj2PdP9vnL0h6RNI+3DsviGIJboqaxO/On/QdcNPmX50IKdm6BdtAgR3mcPizgV8RBWQlTgVGevVAnyylEewlvF8fkha54A1m9oQosH8+JxzSdF/xCgtboPEBNJXDMSvmkV5XTnzJXQsQ77TZeRQYsKhBHzLLlnOYj+STdDdXVRg+LxVS2SnPMmKoRwnVXirN9oWvlVPWjBPmjETFIVbntangNWKITAFVA7gp9QeCvp7l6Jklh9MOJbYJixjAx2R6AGbF7pBPi0z00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVWTRdAFrAoQUfm3ho3E57DlF9pc42pbnKcxTtyJDkU=;
 b=JbIMZY0wWHH8Xc1EtEf+aY+d7yUsvQ0s8h6NkJL+q16/khnRkpb8BRGk2Z1mOMRTksIWsSkoOGIm6ApWCRRtUK+31xbWexEYu2KFFm0MqLNsSSH70AsToP+HOu4Y83D/x7xavRM3vV0vq0S13VBe5fhMiZRFoPobEybn+oV0vZv4J1u4jWTIv4Iq0j5RKNhxzpeXV5lr0SItka6ohVTR9rcmCx4AWNMbWu6AzEr5YNtc+ZP67HG5QIZSVFx9E7lYHyGW8auO8m4N6DElslRVi9TG7mHqAlJgZOaL2V/zuByPygAXoiK/p3kA7FQb+UhOrtxFWcec0K0OQjyzCEeBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVWTRdAFrAoQUfm3ho3E57DlF9pc42pbnKcxTtyJDkU=;
 b=CtkqnY6OFe5xYfLptiwLaHGVoWL/T5HKOrAbNr44o31LbZlQ9kbbpxqTY0+XZEteEDVijPicFsAckUrhdUiY/0fScttRIC0V+FyKgYgWR+mw9HjjfBVUDZ+YL143NUNHrraIHrGNJbQfjkrmmxmUyGCRSpy71qGZjSLJ2Qi+BD1C/oQ2sFHl9zauluMJXWTgpNhBbG4tU1m3Y/rYKXuagehhEd8zv/VRG7f2fY7ZiuyaUY8jYGy8iSICMafmJko8Xndc93vqCiXUBj85W/IiNplOqdiHDVqh/28402aABCGP3Q0qNPwgDfSQRioNvd3XVKAMhHf6LS5ZtXf+r5OjuA==
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 01:30:08 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::83) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 01:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Tue, 24 Oct 2023 01:30:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 18:30:01 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 18:30:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 18:30:00 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: [PATCH v4] iommufd: Only enforce cache coherency in iommufd_hw_pagetable_alloc
Date:   Mon, 23 Oct 2023 18:29:58 -0700
Message-ID: <20231024012958.30842-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3226a8eb-9741-47e6-a86b-08dbd430c208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRAFVgAolFff8TZCcGWW02GvaiDNqBCEykMFxlUjCyX+T58060PTGKuuIA2NnFm+NQarSMIr0Qg1laYevp6RPVeYXByklkfSd9nCvZ576dLc/F7ratr44EGa8hf99BHRrxrr/TMJr91KDKS79oUH1b0Y+GNrsmNO5FKXvX0A5FHawRCKnrX48TUdHlENKAmEbJYfsotj2jYX6ibGICwlB4y16eDL7/iQcX/a+rhfA224GViJjjKQ+cAXpvYtGDnejmR902fw6mOLwPi6fBPL7Sv7Wd0gK+V9gJHwb5rXbNwoFZ34/iaEjEl8PeGXf6cQJ5m+4aV0HtVSbingPadekSWscdJyS2N3pHLL3Qqrti0S8fpiuwYznYvbKDKh7RkuaBjmiXS3bvEfNwbv4bZ6sMujK9ykSDCmHc0KRoUcgdqdO1pWceOyVKeKPCVIDRX1vl1lWMoFmDH3XyXnMajA7AFEYnHkOlTghd5kSZ3E/amOqZQDMTuXMFE7bHUCpppX/0nIvJkb4fWz8eipmGa9zghyhXDaEpQj69I8v+/rFEBkisOJQhXaMkAuCxgRHbOws+MNflSv0n397i7Evooxb5VeLY1AYoasx7Pwa6mnSJosULSlUU7A/DsVPt9mDl6ESPSxvb0lmpGAiog59WYU5kBClFBicSS6jtLZsbSv9z7XW4dgxDln8Xez2/6eQFe/j1C5yPWd2amvQjAHp3F62gMiYQg6E88otIdxEill2Qresa6b80620VZcXWfTfPOl4WluW9l0LtDVelqtUNkuKROS3UrJEFpS+z9j7p8ndqD/zAt9j6YJQ4Sc/LfvOTHv
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(36756003)(70206006)(4326008)(8676002)(8936002)(5660300002)(86362001)(966005)(41300700001)(316002)(70586007)(54906003)(110136005)(478600001)(2906002)(7636003)(36860700001)(356005)(82740400003)(2616005)(1076003)(7696005)(26005)(47076005)(83380400001)(426003)(336012)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 01:30:08.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3226a8eb-9741-47e6-a86b-08dbd430c208
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the conversation in the following link:
https://lore.kernel.org/linux-iommu/20231020135501.GG3952@nvidia.com/

The enforce_cache_coherency should be set/enforced in the hwpt allocation
routine. The iommu driver in its attach_dev() op should decide whether to
reject or not a device that doesn't match with the configuration of cache
coherency. Drop the enforce_cache_coherency piece in the attach/replace()
and move the remaining "num_devices" piece closer to the refcount that is
using it.

Accordingly drop its function prototype in the header and mark it static.
Also add some extra comments to clarify the expected behaviors.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
v4:
 * Fixed a typo in commit log
 * Added Reviewed-by from Kevin
v3:
 * Reworked the first line of the added commets.
v2: https://lore.kernel.org/all/20231023035733.27378-1-nicolinc@nvidia.com/
 * Dropped "fixes" tags and merged two patches into one (Jason)
 * Added comments to the remaining enforce_cache_coherency call (Jason)
   [Please feel free to rephrase, or let me know what to change.]
 * Replace "num_devices++" with list_for_each_entry (Baolu)
v1: https://lore.kernel.org/all/cover.1697848510.git.nicolinc@nvidia.com/
 drivers/iommu/iommufd/device.c          | 20 ++------------------
 drivers/iommu/iommufd/hw_pagetable.c    |  9 ++++++++-
 drivers/iommu/iommufd/iommufd_private.h |  1 -
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2a41fd2b6ef8..0a8867487508 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -337,13 +337,6 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
-	/* Try to upgrade the domain we have */
-	if (idev->enforce_cache_coherency) {
-		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
-		if (rc)
-			goto err_unlock;
-	}
-
 	rc = iopt_table_enforce_dev_resv_regions(&hwpt->ioas->iopt, idev->dev,
 						 &idev->igroup->sw_msi_start);
 	if (rc)
@@ -413,8 +406,8 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 {
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
-	unsigned int num_devices = 0;
 	struct iommufd_device *cur;
+	unsigned int num_devices;
 	int rc;
 
 	mutex_lock(&idev->igroup->lock);
@@ -429,16 +422,6 @@ iommufd_device_do_replace(struct iommufd_device *idev,
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
@@ -465,6 +448,7 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 
 	igroup->hwpt = hwpt;
 
+	num_devices = list_count_nodes(&igroup->device_list);
 	/*
 	 * Move the refcounts held by the device_list to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fbfab638efea..2c55b808eed5 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -42,7 +42,7 @@ void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
 	iommufd_hw_pagetable_destroy(obj);
 }
 
-int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+static int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
 {
 	if (hwpt->enforce_cache_coherency)
 		return 0;
@@ -116,6 +116,13 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	 * doing any maps. It is an iommu driver bug to report
 	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
 	 * a new domain.
+	 *
+	 * The cache coherency mode must be configured here and unchanged later.
+	 * Note that a HWPT (non-CC) created for a device (non-CC) can be later
+	 * reused by another device (either non-CC or CC). However, A HWPT (CC)
+	 * created for a device (CC) cannot be reused by another device (non-CC)
+	 * but only devices (CC). Instead user space in this case would need to
+	 * allocate a separate HWPT (non-CC).
 	 */
 	if (idev->enforce_cache_coherency) {
 		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1cc429a5227b..44828bba9e2c 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -266,7 +266,6 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, u32 flags,
 			   bool immediate_attach);
-int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.42.0

