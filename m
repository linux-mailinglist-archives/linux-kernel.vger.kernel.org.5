Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F87D3FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjJWS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjJWS5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:57:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE3103
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie0eGRWpR74PcodsrL0DYhjjDpvdVjF58iGv/yMFqdmph8j1k+KZU1Dnx/jYkrJiyYdvfUClARPbDW3pAGt4dKrrMC5OCDVlZM1Et7gzt3xQtvnJ7jEogkVKvcvf1kH4MSd3/gZupYrUvTrbpQzfAhJEYymubZZAcAewKBez7hkl9yC3nkr13Y3OrSA4CreUTj1vL8bGQH8wBimnBbKjQckrgEmPfPa2LEugHL+s1VZuexQMm7kFGhn8O7FospcD/FwaYkK1DgrPYsaoC7yeGW8SVVqEXyGu8nh1ysdWq38pR9GDTiGASRGySRCethwx6tqh5HeVdKfFrCBbtnr+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a33w2pcQDclfmHVZwwSyZOYM+VuJ0kuRGDg04Ycyq2E=;
 b=CSs2miR7/Uz+uprvZxGmwUeolWtzCf4QjoBUQ9AV0m6PvUC3c4vV3je42uN7bMiBqI8InDj7m/aYpTvmEbyGbosAImd0gY0YrXt+ghgbxG/KhaPu4DX9yTykcG1U6AOn6mW2RVMtdh2RkGNypD/71+G/Kz+gYtfYqzhvbogGAwVyjcSof/n94y9lsFqu8aAJSpUcYXljfhO8G0gH6WJ8mHyPGUnQZzK86mtZRjoJ9KV9oHBd4hkqFOQQkMdmPz6HGjmE1RvkIhbk2Jo5W394K20LZUzO3ws4gel6pN1KNzIVJIJ20hTu6oH6nzdbpDVNg+hv3BNUbxMRBzqcYcw9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a33w2pcQDclfmHVZwwSyZOYM+VuJ0kuRGDg04Ycyq2E=;
 b=HgAQJ4U5toPGvschtF6ywwh+/iIzhbA09vY6pvtAv+hAY3clFVnpnmo/li+P/y4ezWE/Q8W7iquHNO64DT1qoQiz9YLHAQe5yHKwC/DCyb94Eacu1feE9qSV0+vH8pZ0ZazjXyYqR7QqlzDtuuRZOaNf2Yhh0e6+wegN+CqjocWGUa3za7W6b4rMuIyufccN/MClKi1G0O9Rvh1rLgXyJqkViRk6AEe2U33OeTfwxeAioKG8uFC23GUpGFf2tPGgI5NoShHnVrkycFWdAZYMWNaFxaHLe+vRikT1FjofNyOHhD20rM3pkeFPl3Xi8g4Sh9YQv8sdBVHVNEuy4j22Kg==
Received: from CY5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:930:11::7)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 18:57:12 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:11:cafe::38) by CY5PR13CA0055.outlook.office365.com
 (2603:10b6:930:11::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16 via Frontend
 Transport; Mon, 23 Oct 2023 18:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 18:57:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 11:57:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 11:57:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 11:57:02 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: [PATCH v3] iommufd: Only enforce cache coherency in iommufd_hw_pagetable_alloc
Date:   Mon, 23 Oct 2023 11:57:00 -0700
Message-ID: <20231023185700.11407-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab46b80-53df-4919-ac57-08dbd3f9dddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTsBqNN61u+gx0IikompVnOSi2uf7Q+c0nDi+uq8vO8sGc72/Wc0zMzSGwnZzN0DW1g8B8dhovbnVLIkDy3fFwrYhBZ+FVHwnwe2nultyY6qtWvH1ko+AxQSt5Xyq38tZ8VtjB6J/NoJ1pLpelFnblpTyy+cLnTumEsuEHWW6XzW6iKYPIOUsRSAHTlzy6CDmgess6y8hCb1wpV95d0ppJmbe6F5faGEMVFBpqChgyo5onWWvltHNCfqR/Lo+ABBaoYsp8UVAklvca8Z0cbUkyEglGzI/LkaSs4YLxnmTvysHtm1fWdbabX4Q6bSiGSQzrGtuOBPG+bLC4mFzKkhPvOEQ17rvwXNkvFz42GqCwRksmtvW/bYn0GzrMJgW8hPHih/9nYJvCKpDCHvBxsKiGpBHbQ+ghkUhdaatBJs0De0+7W3bE7av5o6+3gDROaPe9mEUPAUWLkN3A4L0HWz5AzDB32nFILyB9BvxqGl3d5W+/uYtHWVq9ZFPutYoodHXX2EkrkUIZH53j3+tz2x5srfMM28qRAvbvJSOFMldjrzageaXMjBtv0do7mNccWOxPa15VlXCbWGgsXZzf9Qzy9Dy0cMtCNt1uvck+YHaAXvBk/ziuMpxh2LEuTpDa4MYQQ37ViW8jdylCBJGkYvP9QuVJJGe3lYRb5xL+g21LqgF8PguMCW9RuM+jAxUy5IrPPce3BhGDJZUMzjoQJpr2+jhIbX8qrEPb+ZHwRDLgC3p05BD+528cIBpR+p2cuh0LESIkcWW9jyTXPkNICWsaAwWfWafMCdXsk2S5b3QeB3nlodwKzSHAHmJjDZ1A6z
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(70206006)(70586007)(40460700003)(110136005)(316002)(54906003)(2906002)(966005)(478600001)(36756003)(86362001)(40480700001)(82740400003)(7696005)(7636003)(47076005)(26005)(356005)(5660300002)(83380400001)(1076003)(4326008)(8676002)(8936002)(336012)(426003)(2616005)(41300700001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:57:12.4598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab46b80-53df-4919-ac57-08dbd3f9dddb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
coherency. Drop the enforce_cache_coherency piece in the attach/replace()
and move the remaining "num_devices" piece closer to the refcount that is
using it.

Accordingly drop its function prototype in the header and mark it static.
Also add some extra comments to clarify the expected behaviors.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog
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

base-commit: dc7ce51ff88569b95d8764b0cf76405511f693d5
-- 
2.42.0

