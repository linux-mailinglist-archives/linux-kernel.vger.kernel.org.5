Return-Path: <linux-kernel+bounces-77392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06C08604B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630C71F26747
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89D73F28;
	Thu, 22 Feb 2024 21:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOlGns/z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D486373F02;
	Thu, 22 Feb 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637045; cv=fail; b=m0FI5kTwCHqErdagDfQ+NGCvm86RcMV/0yFHeo4l0O/4ndbg9ene5YQjeMjMxOgkRoi3osBu1gJRAfQ5HT35HQvmvPWIZ1XD/Tzvq8GsjpBLF1KXk78NLm1g1dmxIzVMU0gFRb4y2uXj7D4LcwKeLyvx7b0Qa/kzpWxzvkX3yhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637045; c=relaxed/simple;
	bh=2VWHsO8eiZ+k512qv6/59xkYcqTSCCTn13EP0Ayb1C8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=idmeMmucxBRhTZcv568c8XSDqGon61GMgEP6WnAdsBKvUvQKcJRkAXU/U+k3Us36iSqy1404IKchdI7HZJ+o9eq8CONqIx7/IRlXRs9pzQ+7Mki4FoaQQ9uYKGoGnwdiOxMmaNRdC2SXRen7SuP5Gphs/Al5l+MV/N8wrFDbBFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOlGns/z; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxXWTu4YkK1pdqEvsMEJ6tOOOJe3vvv0fPJLMCesstjFC/i93HjNUyzh/9WgdlYchxCLlP/Ifa0L7gnNQcsqopaFitnJLpiW4dZVgwwIAebY04niHaEanshCVXRDe2yCw5Pd9Edb0uY6zAE/1VniEfGfWTClz5zV8VqQ00FCmy03jLsnQOjJPotLJOe2xPLVNi47cSFdjlAlqp2d9ge5UDcSrGuDnsK3LDJ8AQfXJ/ZJn4H6kASj2oLoVGW83Zc92nLhaaIIEoS02Eg6HA5YY9Pltgg/oPZD7JfaAj47vg1WslPDHisUR5teBnBXad/FqWW5pK9GxvzHzlRUCVt7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do3tPKVoS0rIH2c8R0h09/5glxyQgXXZPq8L4axdOkU=;
 b=BMtd2U2jV8VQY6Uy0DCqg8Mr+JgMPk2RGEuHI3/O3eIVXWpuj1pLWmnGPn1OTCWmEayR88lWtx49VLoaTXCpFWm5qJsVWWudF+K+yDAh6K98dmzExEBqT5Zg9+PX3pJhWGl2C7XglODIx8J9L41GppwFKUadnufH88l+VrH6VZQ6qYUyhNRhej+UTA7PNYAfCwIU9mmwho5uSCyE4gNLDFYXpkx+t+4irM5v1WbEymZY31mbT7+HDhkvcDhQQO0XQtyBr+UyejBl3v3MD7T566IBE9oS05VcMXxKHYSQwM8XsO0UXjHYUfj8FdGKsaQfnXEn8TJjUcf9+L/mpNBNWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do3tPKVoS0rIH2c8R0h09/5glxyQgXXZPq8L4axdOkU=;
 b=fOlGns/zRS+doCKo5VEj0mKqeoNavTfYbyWLMJwwUB2hKbn/iG28hXBAgrNZ/5AGrFNi2VfLzJct2vuq+wWuvK4SzD3nrOCoFp4tiVlhWqVh1+f7M7vTzB8u1z/jyO6Ul1WPppSR+9Avb+57E+aAvoaa+Xj7eBtSIiSsL2Gt21ZispF0xIhPqXaNle0Ld6dbgvm6UUdVjlA91D5XvUiKmlw5ow+f9zcOvyZHW2SoWUQIJhrZVMKGxaGu2mdXBQifU4yOH7Q7vr4K+SPxxwRhGr0Vf7D5/GOAjnA35BXKXI0bSb1NUPJQJmzo14bLYNkO/ssNkj87mlr1jof9ANiNCQ==
Received: from DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33) by
 PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 21:24:00 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::6e) by DS7P222CA0018.outlook.office365.com
 (2603:10b6:8:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:24:00 +0000
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
 2024 13:23:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 22 Feb 2024 13:23:49 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 22 Feb 2024 13:23:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: [PATCH rc 0/3] iommufd: Fix three bugs found by Syzkaller
Date: Thu, 22 Feb 2024 13:23:44 -0800
Message-ID: <cover.1708636627.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e7e454-a64b-404a-acb4-08dc33ec960d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WOKUsfgXr5F6vZigztHFTLiJb2fG0n3nt+xjL5qBRhVjh7fXXwrqu6ZNvYvjrdgXob+O6QMMC1kGO8x2FIlQ/3voNh3/oN9nMx+M7cQr+Fjn0pDj1T3yulzymlnt7K//Vr2U3oBi8vJPz277Kslt1Qg2rRrF7T6/FfIwZSV+/40NUael4iP4VwbvYTWMUpcGZSRwa3o9+JTnNOQ45vk/FDkVxx9z8E7oOcJ9ax0W/dVQqAHtYRxZDlcp2xtAsewxqqiT5YdTAbJfQkTzKCNL9KrhOEbQCSbKld+mPbNDSN3qVL+pN8RHyxuwWMJh6iOH4Y/rRha5caOwKk85VsWIzsgXxRZVn8xfs5WwIY4YHesx7ewydQuEJdj+66WINcu9CrxObGLXXkndvY+ElXQuAogH0IYZ1q0HuXjsSiuNj/bFA7/7q/f531ZWrPK2P2SmWt8gJEl9NFHfeHnD0Kd8sPhwMOoSFvwY/4N26prMyfwXXeE73x9AimL5zVzyv0zzK8StaL3++2X8ec+Sr3B0XczhrqBVlvgsIPoYUF/4EeZusO+hUMyJrAiZ+Tu9ONFHgz1SwSPA0exlp1wMPi8exKJXgetE78ef065oSE3VAqa0EDyulLee/A7ZtXI8am4BBljMDab+Od65wGVm7MqJ7XifEClLiAFCs5YwEnssqpA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:24:00.1138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7e454-a64b-404a-acb4-08dc33ec960d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

Jason has been running Syzkaller that found three bugs.

Fix them properly.

Nicolin Chen (3):
  iommufd: Fix iopt_access_list_id overwrite bug
  iommufd/selftest: Fix mock_dev_num bug
  iommufd: Fix protection fault in iommufd_test_syz_conv_iova

 drivers/iommu/iommufd/io_pagetable.c |  9 ++++---
 drivers/iommu/iommufd/selftest.c     | 40 +++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.43.0


