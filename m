Return-Path: <linux-kernel+bounces-143555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1228A3ACD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA281C20DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC011C286;
	Sat, 13 Apr 2024 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JnZeHKhC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D010F4;
	Sat, 13 Apr 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712980072; cv=fail; b=FW2gxZ94xi6Z+1wJIn2jZGecU4WIeVUealik/gRVvbJ75LbTHUZJfwbDvVlZCTsTveSdCT91M2A+NhAmaxi76hq9dNVML+W72psfu/duN2EDUqQ9uvsaxMPX4++6eGZh3wV2f7pscY47mxDKKamIHMuzLnRyexnC2SAofrbZrxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712980072; c=relaxed/simple;
	bh=CBaqBsuBn6DlP3gm9kY91bUOaVGT8cPwZaBpYcXaBGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SImOoND6Cl5g/29a/y48COYwpV1fUpGY5pZSLnEBbWrxc4sbcO4AYuGADTIEN8Tf5XlsKwPcniB3K+fUSICAynpXF25Zzb/QRFhk/hVIngF7jcAz+s6nVYumYl+ef9VjYYPbSZ5tUycq/Agm7HbnvsTrfuO+f6NlZCbTKaweltc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JnZeHKhC; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPrjEVBYF+pf08soZmszu6TE+3DIeC17lFm5maHBUjLOn7o4JDd4dq35M372/pbF8Yn4SfZtVUMRX/wshws3Y6xlAfdlUIIujR7l5bLKGdzv1sKEAI7DfjW1d6VSWWhRzuzMJjC8TqslMhRWNkEfSJpp8nA5lmQySCsD2gjmHF67cgp3WpgPsH6X4hKYGQXIIfHHiPpqkm47kOIlqXIm3INxYurJwLKOs7uA4iNRpXoQADRPgl+u0DvRIUSw+TzJCvVxdBEE2wqlefa2dj/GIJxyMrMEqz/XV81C80PH/smqTY3cVHLsPil+zrP1qv5xdJ/rFcIJFYxw7HY33PECrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAEvQovCIWDLFGbnK7th4ZKXiChbda5YHPIwN9Mo8ZA=;
 b=Vmy0WiD6G8zds4c9CnyUFtVXyALn7DXRg4BsD0TFnm4bDIxYL+L0mx9o1yKliILrGIXaWoOok229S+FrZ4M6Z+9fwh8mlWo3btxkSIhAR43laCIOc+AiCSd5Vpixt6nxbXOBOzlvQZQ9YPVefDj8ns2ab/k4qQMLAuBrT5o4uiQ8NqQWrBxOFitbJaXYt6hhA8oXRESrQEZQZipvRa3S+xSKrYn/oOGGK7i+6GAvEXKRN3cZtfAixub0+p6JSOdf+cpMy3j9RyGva5jTtgaLI0RYXa9r8sUK3wshY5OTdNkLm3GmzG4iI+KGyZphXpgVKgaHHym9UN8wVbZ3EnqLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAEvQovCIWDLFGbnK7th4ZKXiChbda5YHPIwN9Mo8ZA=;
 b=JnZeHKhChlot4CV/+Uf68hUnvQDW06pBdTs9FucyvTKxSdlcRkMwknpJzV9/KhwPTdmK/k97hkofoYZMnN3qSJ7bxqSIbChtPNxUDswMTasviyNJf0v+GiU+8CL7DpuFYYqL7hTxeGlr8CRUVjImTu84VNGaqcMbGGY83qM+Uu5PATW8VQkpJKRvd+SYzYJkgz0AAnzv+DiKVm5O3EvTCNu3AsTxJ8hqahzhBO3xs1BF6OqcsAZ437vjZMUuY9MJf/hSa+TKa/ySpccsEtrNiQeFpwjxknZWEXAFv1OcYbzQM038c+zIuXhew3ETLZqwZGqG6/g7S462beunIBOGhw==
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Sat, 13 Apr 2024 03:47:46 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::df) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Sat, 13 Apr 2024 03:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 03:47:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 20:47:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 12 Apr 2024 20:47:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 12 Apr 2024 20:47:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <suravee.suthikulpanit@amd.com>
CC: <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>, <yi.l.liu@intel.com>, <eric.auger@redhat.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Dhaval.Giani@amd.com>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH RFCv1 01/14] iommufd: Move iommufd_object to public iommufd header
Date: Fri, 12 Apr 2024 20:46:58 -0700
Message-ID: <09e84c7c9099aba07b24b113c70d57d4574aee08.1712978212.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 243d9255-a8b6-446d-d242-08dc5b6c7b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mOmYH++OhQzs4mWHHPkpaVgyYy9cIXEfaRgETEzZ5GqipKsIUuOccbjR6RSMPPFtTstRxrk2CzruBp88HFct3VPsj003Q5qJjt3EM87q6NZQP6hfV9Mims3+sgKb7308rwxkLWPMlAZL4Xb/xsh6LkRdBpgrwe4wcvEzS5VApecIFJqcCEh6XBefzxBNOWo2JMsC+TGg2u3dOqYDh5pmdzYpMJQP8eecUMaHmUWgb8DK0GGsGk/AoUc3Hrh9lLN9lWqjAUTZgbMjEN8aEwnhxbpbIAIlEvTs8unCNhjMoIOSOzetAGlLOUqKh+x2Qh+nZvP5bHGUjGsc0S9ZzCFW9bBsO/lR9LjERPNCEereIorD6QZ2JNzNYeEVRfXR+3m0ix0fxxvQnuEv59gvkhyorvMtAV8gEDf598+9YF95F6sysKnWKUO6keuZ9PoCJu8ak1un9yUVmPeKXHLnX2Ki2sDCV7DAFSvBhTWGsMoECM3pXcvqT5Hmm1ynI03XFF+WJWeRaAHbxZFO8Ab4gFeRvduB0mMetTVo94ySKXtV1xw6tR30y5TNoWIa+V2S6874yYPFcovOMrP+ZHa9Fsllp/vO5UU/J1WgftP5pXkO5mXKpNX599Tl8XqAeki9rHyTk4hRdZSF76yI/Y4tiU7Lnu2BF6McKQU4xhXp7dDt0hIJJjCVF/vMnVBtKgXvXhtAEr4V3FeMSTWJfa0R7vhf6J0o0wFsgvOmWJ3JsEegEQuSZ9IhaVfCMVwUhgC65j8l
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 03:47:45.9033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243d9255-a8b6-446d-d242-08dc5b6c7b25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112

To prepare for a new public iommufd_viommu structure that will be an
embedded object in a driver's viommu structure:
    // include/linux/iommufd.h
    struct iommufd_viommu {
        struct iommufd_object obj;
        ....
    };

    // Some IOMMU driver
    struct iommu_driver_viommu {
        struct iommufd_viommu core;
        ....
    };

Move iommufd_object and iommufd_object_type to the public header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 24 +-----------------------
 include/linux/iommufd.h                 | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..3ea0a093ee50 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -6,9 +6,9 @@
 
 #include <linux/rwsem.h>
 #include <linux/xarray.h>
-#include <linux/refcount.h>
 #include <linux/uaccess.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/iova_bitmap.h>
 #include <uapi/linux/iommufd.h>
 
@@ -120,28 +120,6 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 	return 0;
 }
 
-enum iommufd_object_type {
-	IOMMUFD_OBJ_NONE,
-	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
-	IOMMUFD_OBJ_DEVICE,
-	IOMMUFD_OBJ_HWPT_PAGING,
-	IOMMUFD_OBJ_HWPT_NESTED,
-	IOMMUFD_OBJ_IOAS,
-	IOMMUFD_OBJ_ACCESS,
-#ifdef CONFIG_IOMMUFD_TEST
-	IOMMUFD_OBJ_SELFTEST,
-#endif
-	IOMMUFD_OBJ_MAX,
-};
-
-/* Base struct for all objects with a userspace ID handle. */
-struct iommufd_object {
-	refcount_t shortterm_users;
-	refcount_t users;
-	enum iommufd_object_type type;
-	unsigned int id;
-};
-
 static inline bool iommufd_lock_obj(struct iommufd_object *obj)
 {
 	if (!refcount_inc_not_zero(&obj->users))
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index ffc3a949f837..a0cb08a4b653 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/refcount.h>
 
 struct device;
 struct iommufd_device;
@@ -18,6 +19,28 @@ struct iommufd_access;
 struct file;
 struct iommu_group;
 
+enum iommufd_object_type {
+	IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
+	IOMMUFD_OBJ_DEVICE,
+	IOMMUFD_OBJ_HWPT_PAGING,
+	IOMMUFD_OBJ_HWPT_NESTED,
+	IOMMUFD_OBJ_IOAS,
+	IOMMUFD_OBJ_ACCESS,
+#ifdef CONFIG_IOMMUFD_TEST
+	IOMMUFD_OBJ_SELFTEST,
+#endif
+	IOMMUFD_OBJ_MAX,
+};
+
+/* Base struct for all objects with a userspace ID handle. */
+struct iommufd_object {
+	refcount_t shortterm_users;
+	refcount_t users;
+	enum iommufd_object_type type;
+	unsigned int id;
+};
+
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 					   struct device *dev, u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
-- 
2.43.0


