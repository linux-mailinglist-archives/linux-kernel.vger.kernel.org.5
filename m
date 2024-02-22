Return-Path: <linux-kernel+bounces-77395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985648604BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25F828A695
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C812D203;
	Thu, 22 Feb 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tEuxKpka"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CF412D1F7;
	Thu, 22 Feb 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637050; cv=fail; b=WLaOexFS4e6ZSw3Gn2Egq0jPUuqBoIlMo6NwL8sV5kaS0IcCUeBqvwIFfCQZMA541v9hKWZ5pn0gEiXDuZNZlWfIjjA7/7I+O3W/1vmvRouHKV0QJs/cwsas+ydcqIC+P3AeVaxDHsD0xmMSve8IwnoJCUsfze3fhhcm8N9yEOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637050; c=relaxed/simple;
	bh=nxuqavFmUafOV6nwxMr7abbtQryf0eGGYq17hFLNDCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKTfduv/76LFnEtXEqm1mZH5YJwOsX+vnLkAYEayOczGx6toYYUl+D1H2PNLVNGPKnd+NtpTmcloXffwqT5q2V74No+VSf04fZAfgJKulyU3NNeK1FLgkK5S75XMc1vwUHR+HKev4/7PS0X62gDZpstt6zNrdsIffUPVdd7NApQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tEuxKpka; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMCyPh4GvuzawHSEliSoexW0STIQcNVyuvrg4WUcRpfz+V7VOhFflGIhL5tqoR8tYEEIv4yWQsfL6MnCN/gEIqirBiEyOirYiL5qffRLxuZtcVDjAD8pSfQQWK1IQfV4Mx9p5z8ltM/GN8QPoxGjcg1IBusbkfQvKu//tZxCamo1YjO7Wn0rdk5m0CgvUQQKbJKZ5LpVhw7cBH8xfh46TFlk2gVbS7CPBrOP+nKD9K8tWSCcRw4+EUq59j2KK3ClRe4jFeA8gsPEEekmq0v/I3vNbSEfOFF22Gtuy0cNghdmAjA7ifwYlk6tCtucWVrzQVQeT+qy7jeX6BOaECDiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqVQ5ptS5EIYcKnMPZL8+89QjJAIM06thQdPpK2WrR8=;
 b=EdfelgKvbOC+I45+4TzMoj8kA4dIModWNP5Cw3iJKNLtEoXXcMcQ4dYbvbPNhMCBSSJCWqkyln8MbXPU1eZFoaO0h+Iy2fOcPV0t8iwMkjUIJBHDCqemXzG3hl3ZeYuvc8C6rgPzWclMHzIOBg2NFGF2iFUe+QN3y3psx0kpvmav104r4F6xlWsRGN2FLG3Szw2hQ9OkFuB//evzGkbIVpRIp+ETKEVm87NwGy7NPRHiaeFuE5dIx6YmjFgbvsZIq24nFlXIz9BaQfZMC9fYC4yzXvxPxG4Ob4qbwumgZwxiqeQgy3Yz9VfgUOlm5uVdLvG+9MqZ6kTrrrsADxvfAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqVQ5ptS5EIYcKnMPZL8+89QjJAIM06thQdPpK2WrR8=;
 b=tEuxKpkae12Z3uUUg1Vd7oeFiJT+Zt5VxOApVPRzVvfiBNo+AFvk11dCk81vflQ032+r9vFnPNd4UgYmYkcXw290qpD+rOop52ia8ajCN5VAUaME1TqQ+oXJ8RNJSMbiutmuP1Bams0jFE1KlNzwZA4dPZd2Iz5mIKRskuCVmdtpa7pRblw3sZ8eoeAPoLKkBTdj6WU5q5QTa7cIXoAuXtHGQ/ucMwraFqBQaj71Sogx67+zhuBGWwBG/gmg/cU8yKvMUI8UHnLzgHlm/OYr4ROxrV8mAm7a4AA6G9iwIOJmGcQhAA0qEVoJOZTClizoBkhKuTiTmZDt1wNT3es49Q==
Received: from DS7P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::32) by
 DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.20; Thu, 22 Feb 2024 21:24:05 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::e3) by DS7P222CA0026.outlook.office365.com
 (2603:10b6:8:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:24:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 22 Feb
 2024 13:23:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 22 Feb 2024 13:23:51 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Feb 2024 13:23:51 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: [PATCH rc 3/3] iommufd: Fix protection fault in iommufd_test_syz_conv_iova
Date: Thu, 22 Feb 2024 13:23:47 -0800
Message-ID: <3f1932acaf1dd494d404c04364d73ce8f57f3e5e.1708636627.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5ae20d-19ac-4a97-2423-08dc33ec9931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zRz20f8/JTBjxNvBq9QuYJD96SyOQuqCiXf3avTlv6xPgKStMhZpjq6CSp8SKlse2j1q/xWy5kS/zlGqdUhF01v7ttHwWqMtpWMZh1loaWyoVOFCo/1MilBRqR9BiJG6Su9ZMHT7gIici77tyw/BHqD1brXHLpFvHB2XMor/u0arPKHBONAxytAk+phLbSbs0YbnN8urChsrYKIGwhCq+aBiwFzFSskJc7P0iEY5bHPOVFIoWBeGMwZVTlaByPz4NMNr0PwRn6WIXmUfkWvT5Yn7sLmvWINnGydZSAX3vkD+H0O3SZjQjWLa5Zo/q8KVKYyqsuw7EvE0CaOlBAahu4zDJW/3Aj7zdOoAYasOQ24A8A9xVWRXkV6EVgokltKmDcS+RHboQGD7sLu+EwDOouk+BibWiKK8OfIjmMb5K26vF+y4vpiymUx8Dm1cJ41sZRXpIS0kaDudovCGR08XSCFfyJPySL+flGE9hI8q1RYzjPHPfRIngc3kSJIRSaP/lRXumhGQknRi1pU5rUTZ/dQ7pdm1m3eT4L1CjIVPOOInkvWAdiOjc6XtEtn+OHj+x1kLdX2PGhtOYoECtkEZxStqSSA6EdPbymwYYwXPVUfDZVTsQX4p2ltQT4axX7PRM5qokREk1EIzZtd1ofFTAQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:24:05.3794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5ae20d-19ac-4a97-2423-08dc33ec9931
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

Jason has been running Syzkaller that reported the following bug:
  general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]

Call Trace:
 lock_acquire
 lock_acquire+0x1ce/0x4f0
 down_read+0x93/0x4a0
 iommufd_test_syz_conv_iova+0x56/0x1f0
 iommufd_test_access_rw.isra.0+0x2ec/0x390
 iommufd_test+0x1058/0x1e30
 iommufd_fops_ioctl+0x381/0x510
 vfs_ioctl
 __do_sys_ioctl
 __se_sys_ioctl
 __x64_sys_ioctl+0x170/0x1e0
 do_syscall_x64
 do_syscall_64+0x71/0x140

This is because the new iommufd_access_change_ioas() sets access->ioas
to NULL during its process, so the lock might be gone in a concurrent
racing context.

Fix this by doing the same access->ioas sanity as iommufd_access_rw and
iommufd_access_pin_pages functions do.

Fixes: 9227da7816dd ("iommufd: Add iommufd_access_change_ioas(_id) helpers")
Cc: stable@vger.kernel.org
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 2bfe77bd351d..d59e199a8705 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -63,8 +63,8 @@ enum {
  * In syzkaller mode the 64 bit IOVA is converted into an nth area and offset
  * value. This has a much smaller randomization space and syzkaller can hit it.
  */
-static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
-						u64 *iova)
+static unsigned long __iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
+						  u64 *iova)
 {
 	struct syz_layout {
 		__u32 nth_area;
@@ -88,6 +88,21 @@ static unsigned long iommufd_test_syz_conv_iova(struct io_pagetable *iopt,
 	return 0;
 }
 
+static unsigned long iommufd_test_syz_conv_iova(struct iommufd_access *access,
+						u64 *iova)
+{
+	unsigned long ret;
+
+	mutex_lock(&access->ioas_lock);
+	if (!access->ioas) {
+		mutex_unlock(&access->ioas_lock);
+		return 0;
+	}
+	ret = __iommufd_test_syz_conv_iova(&access->ioas->iopt, iova);
+	mutex_unlock(&access->ioas_lock);
+	return ret;
+}
+
 void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 				   unsigned int ioas_id, u64 *iova, u32 *flags)
 {
@@ -100,7 +115,7 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 	ioas = iommufd_get_ioas(ucmd->ictx, ioas_id);
 	if (IS_ERR(ioas))
 		return;
-	*iova = iommufd_test_syz_conv_iova(&ioas->iopt, iova);
+	*iova = __iommufd_test_syz_conv_iova(&ioas->iopt, iova);
 	iommufd_put_object(ucmd->ictx, &ioas->obj);
 }
 
@@ -1161,7 +1176,7 @@ static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
+		iova = iommufd_test_syz_conv_iova(staccess->access,
 					&cmd->access_pages.iova);
 
 	npages = (ALIGN(iova + length, PAGE_SIZE) -
@@ -1263,8 +1278,8 @@ static int iommufd_test_access_rw(struct iommufd_ucmd *ucmd,
 	}
 
 	if (flags & MOCK_FLAGS_ACCESS_SYZ)
-		iova = iommufd_test_syz_conv_iova(&staccess->access->ioas->iopt,
-					&cmd->access_rw.iova);
+		iova = iommufd_test_syz_conv_iova(staccess->access,
+				&cmd->access_rw.iova);
 
 	rc = iommufd_access_rw(staccess->access, iova, tmp, length, flags);
 	if (rc)
-- 
2.43.0


