Return-Path: <linux-kernel+bounces-77394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED78604B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E931EB21218
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225312D211;
	Thu, 22 Feb 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JP0Zkfhw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC873F34;
	Thu, 22 Feb 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637048; cv=fail; b=IglMgbrFW8WhLk1n5GUZ5uoFrf1GDAteiGHhKfMKannij4WEbHOQlRqIcxmiMx3jF8ezZipzrCGGUFZYqPIvsBlnvQ2v1goJDeR1wQiAhphSpxVR+aQCHpoeDw+WCxCGQqKzvkAg5lq75J1l7hjzZ+gE7tY33au96zF/yYcKst8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637048; c=relaxed/simple;
	bh=7gYb/Pa7F+IchcPJNpoDmvFaA7AMFCi/jgZyJuMVPwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hq4i2Gd94fNcfWWSDuobCC778OoIkOzLU8UIGEKeJmPuLsgWzxmCxgjMIu4/JKzmzk0OGEeWrMWkQFYgoQDNQP9RcrGbzyKdPqAuqXOuDi2O+A0l50G1RyL7f75rLAPJ2oCzFT1qULL5+sYnKy+Ke8wHU/Le2tJfmAtiFYtXGaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JP0Zkfhw; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxckmzUV6okaYIWjIf5OqGx5ILoxW68QF9amqsDqv8cpur5b9PURopVclu0F+2cQ2u08S2NmrAUWLgFd93DQCxrRhIg9qMmTi/YBUr37mcQBG4s/HGRB9qkIT7fndbz0/f1z8VLyYrVBobfD7O5kEGI8DA2L/H3h24HDxJYo+TOqwnssJLxQrfN4SgACGo9j9PInNqxiWSamTaK2phBNAQS/h+oKdLjcL0VbINAr2qlNH1/p9OX23P74oDcQngFuOyXfMon+HXC4YwMvaBQbTd+lqTdXGpSscBnKf/saT38/kiYM+UUlAmvz17EC7e/fnm468yvZN2ZucmEZtbnIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNjD251+po3w/LiQLxpp7IMemVrG4UuyMR7gGkw2Xmo=;
 b=lXZXJMmQGypAhR+aSL5YanJDkiVStU0tFH0/m7VYcpKFFU4MmBlqY2kldWMb8GrxlVA54yWjI4wtzZCt4XLK32NQAkDeT7rIk4/hT6bVdSiQ6HaplWG7QnKRFO6ouFx+5jyi+lnNhPuWvTljT02gNLVuezMq37ZhJDrm5/jPAmkbNG88EYbAV0fVKlswwJK0JvrNNUuc8D/Jdo/oISv0nTs8bN/Wxz1Cez3eoRxb35koNLJU8JstehisWbotGXHuHwu2wVqcs7SjUSx9d24bs8a21wAs9bgndxYaFpmGY2jZWKpydRr1/UiJLXE/VGOKVj5q2ahHWMGHZwLEyTbzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNjD251+po3w/LiQLxpp7IMemVrG4UuyMR7gGkw2Xmo=;
 b=JP0ZkfhwGjQ0EexCBcyMINq1YczHlNcjUQfIwbJ8gT3kClhYVYsfTR08kn0IqGTb6TqIzOgb4ja3tDygApGg+5wtXmYwbRBJm3WbrvQXuVZJu6C/JhAlySrWvl2PkNOG+jtNgxnEZrGfYsjtHCWVhLg6qt4LrdK0i6PVLZ9+4lbDu2H55grRo3eC65TQbH1bYOogP66rYdz+I5ccfp+vNGgZ4/IBFxrjMaeQkl+25akksYqBcgt7aJvnmzYWoMhhUdz/Ec+2Namqhp0Ip93yWeXQZVZ9C9XL8RFIdauCGIBYUc6lACVr++0ujso6rNWvcCrGo9Nfdvx7t+OSVwus8A==
Received: from BN9PR03CA0150.namprd03.prod.outlook.com (2603:10b6:408:fe::35)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Thu, 22 Feb
 2024 21:24:03 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::63) by BN9PR03CA0150.outlook.office365.com
 (2603:10b6:408:fe::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.0 via Frontend Transport; Thu, 22 Feb 2024 21:24:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 22 Feb
 2024 13:23:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 22 Feb 2024 13:23:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Feb 2024 13:23:50 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: [PATCH rc 2/3] iommufd/selftest: Fix mock_dev_num bug
Date: Thu, 22 Feb 2024 13:23:46 -0800
Message-ID: <5af41d5af6d5c013cc51de01427abb8141b3587e.1708636627.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5be1af-520d-48c8-d335-08dc33ec980a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2izBziPcK759nCqVpsZTG/RBVLfcS7j1gqTfZlgv0v0xaqGtGjFXZl6Asykdp5BACQWuJP6odRcPygp8Z8wvf3FPxKCTec6J3Kc/Vkx5Ntwn0AFKkUvnhOyLwOIoULKwwc/DwkT45elewEVxFLNuUqr/58NjO1Gyd99HTiNvMiz2nBLmZkeaOYecnAxfl6QRldV0bBr+ZPK7ogNgBW+Za3+4RBNsXSCcNNEs0BAY5w9fMHBNIqEnpIDcQrNak+sXN6M4K5O+3oURHnowjDB3f0EsgdRqrZ9YRplsAvgl3814cusHvnixdprs3BIy0UxaIs/KtuMZ37ULBl4QtctcdFgzITdbpwO//XkaJbc+U/6uUwfBTYXkSlaaduMf6Mi/ESGybMbdq7OcedjkG92TqdOsyrEuYXgu0DRfUE4AwUeRo/cTmI034Axj842XQwT6engOj4chPpgXmoLJeLGG4qMUmLlpeFA26nzlaNZIXJPXsVSc5bSP4e87o6+DC5ZdUgTncWDg8YyiWes8tuIe4RIWL0Pj+RlNrcjJl9bP/l4l6bun6gCghRXNw2N0YWt034nn4UOBpQsratJHOwgo1iavZutrCdNO4QIPnXql5dOdSs6aYYsFP8RMprv1nSkZXiOp1lWlFUUiKZ92NuUW3/Wpv6i92IBDXunnl7AEIpk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:24:03.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5be1af-520d-48c8-d335-08dc33ec980a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

Jason has been running Syzkaller that reported the following bug:
  sysfs: cannot create duplicate filename '/devices/iommufd_mock4'

Call Trace:
  sysfs_warn_dup+0x71/0x90
  sysfs_create_dir_ns+0x1ee/0x260
  ? sysfs_create_mount_point+0x80/0x80
  ? spin_bug+0x1d0/0x1d0
  ? do_raw_spin_unlock+0x54/0x220
  kobject_add_internal+0x221/0x970
  kobject_add+0x11c/0x1e0
  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
  ? kset_create_and_add+0x160/0x160
  ? kobject_put+0x5d/0x390
  ? bus_get_dev_root+0x4a/0x60
  ? kobject_put+0x5d/0x390
  device_add+0x1d5/0x1550
  ? __fw_devlink_link_to_consumers.isra.0+0x1f0/0x1f0
  ? __init_waitqueue_head+0xcb/0x150
  iommufd_test+0x462/0x3b60
  ? lock_release+0x1fe/0x640
  ? __might_fault+0x117/0x170
  ? reacquire_held_locks+0x4b0/0x4b0
  ? iommufd_selftest_destroy+0xd0/0xd0
  ? __might_fault+0xbe/0x170
  iommufd_fops_ioctl+0x256/0x350
  ? iommufd_option+0x180/0x180
  ? __lock_acquire+0x1755/0x45f0
  __x64_sys_ioctl+0xa13/0x1640

The bug is triggered when Syzkaller created multiple mock devices but
didn't destroy them in the same sequence, messing up the mock_dev_num
counter. So, fix it with a mock_dev_ida.

Fixes: 23a1b46f15d5 ("iommufd/selftest: Make the mock iommu driver into a real driver")
Cc: stable@vger.kernel.org
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8abf9747773e..2bfe77bd351d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -36,7 +36,7 @@ static struct mock_bus_type iommufd_mock_bus_type = {
 	},
 };
 
-static atomic_t mock_dev_num;
+static DEFINE_IDA(mock_dev_ida);
 
 enum {
 	MOCK_DIRTY_TRACK = 1,
@@ -123,6 +123,7 @@ enum selftest_obj_type {
 struct mock_dev {
 	struct device dev;
 	unsigned long flags;
+	int id;
 };
 
 struct selftest_obj {
@@ -631,7 +632,7 @@ static void mock_dev_release(struct device *dev)
 {
 	struct mock_dev *mdev = container_of(dev, struct mock_dev, dev);
 
-	atomic_dec(&mock_dev_num);
+	ida_free(&mock_dev_ida, mdev->id);
 	kfree(mdev);
 }
 
@@ -653,8 +654,12 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
 	mdev->dev.release = mock_dev_release;
 	mdev->dev.bus = &iommufd_mock_bus_type.bus;
 
-	rc = dev_set_name(&mdev->dev, "iommufd_mock%u",
-			  atomic_inc_return(&mock_dev_num));
+	rc = ida_alloc(&mock_dev_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err_put;
+	mdev->id = rc;
+
+	rc = dev_set_name(&mdev->dev, "iommufd_mock%u", mdev->id);
 	if (rc)
 		goto err_put;
 
-- 
2.43.0


