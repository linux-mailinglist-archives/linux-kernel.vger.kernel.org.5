Return-Path: <linux-kernel+bounces-77393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2B8604B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8431F267DF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6E12D20F;
	Thu, 22 Feb 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="McFYw/77"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BBB73F35;
	Thu, 22 Feb 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637048; cv=fail; b=cBwAeOW26OJWuI8IOkPx7ly/uRT1Py1hvtpLwfzcrqGqBmM+ZF0o8i8MK8FXkV/p/CDWRzDsMWZ+quGqfpls2lCMnH2VFTbf+mRFgPcnPeMhXXWtJMPSpJJbLhO1I9tmFd8Vp9AsaxadXi+3Qo1eV8OMMi/z2Dzzrc+AAl6Bt08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637048; c=relaxed/simple;
	bh=D8bCjACiAr3gyIL13jZY5k17i/XuVagx8K0yf/jCNxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1Mr51B/V/iknOL74HwnqmBulKCJams6VEORoL4uV441Y1UhcAvYkpX1jUJP3I4fRrydwggBJFEa/TNL8BOG3LI/94Y7O4menhBMEDP44eb+cpPLn49BkZu2vH4QdspbzmjfY+q/cBi1R4I4RyW8THwMJI3GNvfJJVeAud5NSzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=McFYw/77; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITVgaiNJDDdaftPbPySrunCdtfA3Ss6MDbZ88/lnnaVPktxgbwFPiMYhhyl+qT4wN9KZulQ10Ga4PHg2dOoyDr7YTSSfvYArkLO+nwqcKQU35KdB8r36LiqM+1WxrZSQE6g3tNqRdF5PiWF+JNUmud3VehnayT2h7fI+oSVRcK3vrSmrev3chxu2+DqwA2OslP56AQwAPtXnNGRP9lDinxZF02LtOkjw4txGaJdmb0tSAke995nfKI6TQrWRAN2FWQv4zIKlYouDOiQojtT13Pm89Nz5vgGBz7bwZ+ECdx6Z0wFp1a+g4l/xdYZ5o0jbd8MV8D7Eh1qMd58WNMQSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORtLZL5Ga6nP2AjaBmDDZ/vU6ZMnsORJC3gdvFr6NOs=;
 b=HGLvVgUOQ71H3CdREkwvSFNXEj6ySz3xFBL1NsMscBB5d7OONT8sKX7x/q7yvaTeS5k9+VLOb66GlAyqqItkWQ4QME+1X80EK0JXC4ztuGZMFjEIaIfCbt+2n0qEVNTiW71fBQpSr/oOYUzVw7+a5gtyfbMCxZyJvBfG3eQUi4+/59E8ThDPy/EZWP9YfeGokeHIR4hy2fZMBLMZnYrKeFAHOrFgV6eTwFfcoqF5DEMGkMoPwQiU3cS6c9wrND/8JD8RpTbDqsPa1acR++scWjqZYD5n4u1YCzZ2o77cN2OhgqkyLYEtxqyNjuE37k7P+GgcmaXbYAzMrlW9YaCa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORtLZL5Ga6nP2AjaBmDDZ/vU6ZMnsORJC3gdvFr6NOs=;
 b=McFYw/77T7+m9qZLhac58G99fFCUw6UMaiNu9EV8ZSlWzcbdbFSvYbvN6JZpQm5rNrN5P+YsQ1Rb70vIVAC5Xsok7ogCqblEDKHhd3nvf+5Ig0ZG9TbegTI0+Bts9o7eZzRQBOCa11COki5eNsfIsc/FL0dJdincNyotcRQdBAg629q4+y47XUKiBEgqGAZQpEpCpjC2z540Pn/MrdWk1TSj04Eww/ITZ2/Nny7CxymrMNua60jBAXVCjG/7BLnWU0xPrCjT2YMYz+4GKOlNVDB8deTia4itIzvJi1tbhezgeHdloj0PCLrzATKrTYE0LAhlFJj5ab7QXM4tkeSZUQ==
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Thu, 22 Feb 2024 21:24:02 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::11) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:24:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 22 Feb
 2024 13:23:50 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 22 Feb 2024 13:23:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Feb 2024 13:23:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: [PATCH rc 1/3] iommufd: Fix iopt_access_list_id overwrite bug
Date: Thu, 22 Feb 2024 13:23:45 -0800
Message-ID: <2dda7acb25b8562ec5f1310de828ef5da9ef509c.1708636627.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708636627.git.nicolinc@nvidia.com>
References: <cover.1708636627.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM6PR12MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 465afc7a-ad59-453e-cd9d-08dc33ec9690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5KDBc9bQQg7HEE9DcMbZb5/T76QmS2p/zChWMH15d7096V1GoDlWP/UWdvj5RkjKQpmFJE97wDUN/Rz7JlkT4lqEzOUL4iYOoSBm1Tc2ZTXBtn6KytA6ZXxrB1mcayxfCG/OODR+nCLL5ueBwJsg1nhJ9BOEP1CmhjP/smU6vTm90U1nN22zxOC0x94XNis2rNqpIupcS+mMAxMlmwMk+3QR+aZ3NazkQx0K3iMzl6ZS31vNh5TihNNGduo7dq/fOPDfZN9b6xGtU6Mh+OfktESK518opwH1ALVzcyo9hjPz4v2nb6NaGJ8Un7kH131NivFHsd3q1eTuHqT4IhsxZSJSwBWV78L7c4I7GW/XN4jvlO2LiX8hAtzHqgUSLMR5XCh4PdRnmQmgwrpJ9xV+MStOQ2b1hSF2DyKO3x80nd/N+8v7H1cBpFh/yE4SJQWJv3TwXXhCEAYqDHb3UVa0apnxpCiBzy9XJgyEIYTu5zkqsi3h1iU7Au9A5JIfi9vg3tSZLwc+SJ+0JKGiF3XO0GEPNhc9YUKvUGjzjhmwlbN9W14kpBrueVAWGABLy+3E2klUuiuCSbS60rK8JAgNFy8gQJpv6Fiw6bWBT5QE2C+V9BjkkYntfVdUHHeulf4RZTiY9nOtYFpBRNDum0XhrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(230273577357003)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:24:00.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465afc7a-ad59-453e-cd9d-08dc33ec9690
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546

Jason has been running Syzkaller that reported the following WARN_ON:
  WARNING: CPU: 1 PID: 4738 at drivers/iommu/iommufd/io_pagetable.c:1360
that is a bug of mismatched access pointers.

Call Trace:
 iommufd_access_change_ioas+0x2fe/0x4e0
 iommufd_access_destroy_object+0x50/0xb0
 iommufd_object_remove+0x2a3/0x490
 iommufd_object_destroy_user
 iommufd_access_destroy+0x71/0xb0
 iommufd_test_staccess_release+0x89/0xd0
 __fput+0x272/0xb50
 __fput_sync+0x4b/0x60
 __do_sys_close
 __se_sys_close
 __x64_sys_close+0x8b/0x110
 do_syscall_x64

The mismatch between the access pointer in the list and the passed-in
pointer is resulted from an overwrite at access->iopt_access_list_id,
in iopt_add_access(), called from iommufd_access_change_ioas(), when
xa_alloc() succeeds while iopt_calculate_iova_alignment() fails.

Add a new_id in iopt_add_access() and only update iopt_access_list_id
when returning successfully.

Fixes: 9227da7816dd ("iommufd: Add iommufd_access_change_ioas(_id) helpers")
Cc: stable@vger.kernel.org
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 504ac1b01b2d..05fd9d3abf1b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1330,20 +1330,23 @@ int iopt_disable_large_pages(struct io_pagetable *iopt)
 
 int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
 {
+	u32 new_id;
 	int rc;
 
 	down_write(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
-	rc = xa_alloc(&iopt->access_list, &access->iopt_access_list_id, access,
-		      xa_limit_16b, GFP_KERNEL_ACCOUNT);
+	rc = xa_alloc(&iopt->access_list, &new_id, access, xa_limit_16b,
+		      GFP_KERNEL_ACCOUNT);
+
 	if (rc)
 		goto out_unlock;
 
 	rc = iopt_calculate_iova_alignment(iopt);
 	if (rc) {
-		xa_erase(&iopt->access_list, access->iopt_access_list_id);
+		xa_erase(&iopt->access_list, new_id);
 		goto out_unlock;
 	}
+	access->iopt_access_list_id = new_id;
 
 out_unlock:
 	up_write(&iopt->iova_rwsem);
-- 
2.43.0


