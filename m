Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6877D2934
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjJWD6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWD56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:57:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0BED
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VydcVhmZVUL73QzyEwMLxzwFPInxphBNhB+PumwOxqRd64GshYfqHuCnidfQn/A4K4xCptAFl3fZ8B55fDfij2A5fmtS55/CBd1duXGVfxW8N9W6YGaewmRZjgzBITU27wWowXLxQiDmAOcfgqk1L29EDXDuG508a+8bm20f6kEWyJ1F/C0kbavKYw64GlYR0X87uf6j/SjuVFp/FOBdYfglCZUx1bes0PTE1EZv6YfoGtHoA7080Gs+FCX3uoJgDBI4wqeJ8HfQUKxHX69sV8WhfBQcKmnSHPBSJQgg7pOsSLmUPzbu2hjYPw9NeFjcaXSi+7nPaQnVXLTazgbODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu2DtJq3dyCZ5RZHiv2RA5KQrWRQrWM8xV0ugwFzXbw=;
 b=h9C/awmUVr7pJzSSR0bgEkE33Te/PNeCvq9kBCcVis3MrZrCS0uE/OrSug8nU77WvVsxLCKxwi3G2FE9NyLd5qQ3PWn5BZM8psn85sb8uipIavbTmrUo59Y//mLWhRtRnBwoOAbxdDxVCysuV6MfGhXjAwTGJ2WZZzVEHCz3WruVPTqYSpnexnPAKdIeu22LbhbSj4TZyYCgHMBw378UvHeXJnOaQkiSzmoHEeUGkd4f+SyvaDbfw8ATj/OcRt2JZ+oj0i9HvzeY833MFpljPqnII4ukVFJwTJXZ520bwVVgPauXqvTOeBxDF1MLnc/24rEf1Xm++TVpDjlWOYpmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu2DtJq3dyCZ5RZHiv2RA5KQrWRQrWM8xV0ugwFzXbw=;
 b=M9hsP4CIurmTyyI0fO+uY8AXVSWs4OX/8bx/pUmk3ipxZ3vsZdSULSqpwu2K5RxyRqqi0kHDb7WLHWEmiAIDuHW4AIbBq5hoBQttG7/MdXQmasKVuetQU+MAwXtHO0BL0H9A5dkebjfPMO3FRnntexD73e95/Oi7ODeFmkfHRncx0//2PZ16KcBLfHVhvwrKh3HbBA1j25BGfdC7N4KBGGs4WlaEZdfGlcudB8qArwwilS9NmYMwP2dqYNvOM/nNE80eL9Op5dOe4HaG8jebF/4yt29xtp+zGWmEQV96iXHKZqv+++iQ2Mz7ohZwpla+RORBLJozbDMOSi+N5zJ4CQ==
Received: from CH2PR07CA0052.namprd07.prod.outlook.com (2603:10b6:610:5b::26)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 03:57:54 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::c6) by CH2PR07CA0052.outlook.office365.com
 (2603:10b6:610:5b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 03:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 23 Oct 2023 03:57:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 22 Oct
 2023 20:57:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 22 Oct
 2023 20:57:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 22 Oct 2023 20:57:40 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: [PATCH v2] iommufd: Only enforce cache coherency in iommufd_hw_pagetable_alloc
Date:   Sun, 22 Oct 2023 20:57:33 -0700
Message-ID: <20231023035733.27378-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BN9PR12MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c9bfcd-1a48-45a7-bc60-08dbd37c3bc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LnSm2HyUuqsYoMWIHcPVe17wmTtevuD3Qg54vVNMYcR4kHKRrfeWrsvn3KnI2CPsdhpxTutk0Fp851quMjjpmbhhcO50+4haoqdElMsDjZHwqMo5EkbSku+63HxZnFBblpPXZROrXzLh/AZJdYrGtRewKj4oZBW0OhzezIzD1nvJHnyW3jh8LEVeh3ekWAcj/GltmbGnMj9+P7jqucYEMT5Q1gSZFs4niANZXtq4ykMrxzlHUo73mBTQHLSwn9thClkA2PKdMSRtKJjRY4r20Tn4D3q3A62ajpqT05VJCvG3v0LDGM2oCYuGTyDSHJlGFGn0e1yI1lLQEGyE4iVYuJh5rue31yhvxQcnYj5GNouGbn61yoECR+V0gQp+rG1Sol5pQLM7pCZA0sZDFokU0k2zX2X5Jex+ZaX0p2dfMIpGl49zFplD1nJ1x/EAgvK3iqioeltteYrPUhLyHYtFeueBYbjHR+WtO3xU7wGpItP2/lzKrAx+4nH/5WNtD/gn8BD20akQ+jvZjXaUlmEmwwX/9vXr5HEbbC6FRqrdxetkaTSNxHyOaHGugaFVmISO4/TTZHU6f6OPdreXueXwCsFHUpjFRGPGwJhTA8MBJkh7fIjERfPuHGOvM6VM9Xa4uWbCdBM1nGg5hvyBBgQ+y5Yjfkt4nrSrz4PIHvY9kzgM4Cch2C+rFsvvwFbQpKRphUG6dobyhfKwhRogkDxHYlWNpK7tMtuNyBJudqiv4j4Ce95MCz6R/TrsGY7JLMU7tP0gSvFrjTHvGEsDl6o+ZKS1xf3POV/bij0pHgBrEDpNbNQnTVlWHpHFTetH30cO
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(2906002)(36860700001)(110136005)(316002)(70586007)(70206006)(54906003)(82740400003)(356005)(7636003)(2616005)(26005)(1076003)(478600001)(7696005)(6666004)(966005)(40480700001)(47076005)(336012)(426003)(83380400001)(40460700003)(41300700001)(5660300002)(36756003)(86362001)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 03:57:53.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c9bfcd-1a48-45a7-bc60-08dbd37c3bc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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
v2:
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
index fbfab638efea..cc24f86b07af 100644
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
+	 * enforce_cache_coherenc must be determined during the HWPT allocation.
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

