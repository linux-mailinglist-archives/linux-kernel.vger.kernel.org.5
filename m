Return-Path: <linux-kernel+bounces-64385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD35853DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3A51F2BB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2230C61686;
	Tue, 13 Feb 2024 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UUvSM5RV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C462156
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861259; cv=fail; b=gxmZZIA4kG5at1R7mLgyZa2ANJ3y5ycZxuB7jXzuE5y4GB1y6iIf89sncHAkORk1R9y1awoEQIDRkm+J5X3wSawMXn7oVRqgEQ5ipudOI062Kc0PW12WSfzo4QwgH3fzS7b+7HhHxsuKrZ8Q6kKuFy2ttBifS5PXwCjd2VPPdjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861259; c=relaxed/simple;
	bh=kcg8O0L4suv1ERSOQaQK/QCFzehFtSGvTZcJJGxRqwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtFz/OMAoKxEE+ckNLPv1r7wCLsJqmHxsFp7LAgoTyqYWGAFSMAzucH3pLyKvcFn58CDuooqzHTxRUufuTNwIREJ3u8c1370/4nHXQBILuNX1gohhFQ4zNO+aFYbNowS3jzO5kjnyPMF/Wr9YMMQbFpfaKJFocej1jqeuAmQOJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UUvSM5RV; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJO+1e8doX8ftrl6RbzHaUOguz+jLnScK1FbxAGfKi/nlodNYtl2Wybj3OwjXEzX0GgwguHEKEKebOKLCr9jdQz1W3MkcLlXOrQXiYpJj2hFgR2qUEJYqGCf8P/IeXQYMJFC8F+8QNPf4FOSdDsVCtBVb3gm+MThibQFZMUXeaQmY5Ekvgk3d7IKuDVGaPmhX2mB6MJqjyDF+7AYDfg2fTs1yObahVZQVwbF6xl/kmJbaoFcVeEF2XwLdg8eSZfzGhg6gfP/HW2KTGmBa6Sd3JgWDO+CMFMSpzjz8qkGVCNKewhvninE+PD5dauljROcyZs6dHvnvd92Xtjv8GxJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8afUVDl1rcB4DggJtL7Tcs05elmC4von+4AUycjYwc=;
 b=jzOEO597+7XI3G+wWtHHv6ku3w+NqJjM5W0+/LT4bYLAr3WUK6/oZwaiBhVARnZWYeCz9UrfSBhytgaqy3DC1NUqtisY/0J/9hpwLOBCGK3ZFTSJKsJ1UEz/Osoahp+A726Vvs8JvusSQnOHOTyQt7qaVBfQ5gadFpCzBjxC1HceHAI9wT6pMGCEcNfqhWLLbZkvq3rqdgI6pbAJKYi94HDT12i55oWQYg8Xtgm6byPWlHN377dcq/9zU2NJJ2QK+h5tNyKMN4Nn9+NaQaTY0tpCd9SYYWLAR0F2YMp6+7K+xiHA0WYaOSsMouaazZtYPVLxy63C9VOKuriAHnxjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8afUVDl1rcB4DggJtL7Tcs05elmC4von+4AUycjYwc=;
 b=UUvSM5RVCZLs4j7zt0Rj447HpkhVszPl1RzFCSM+c23K5rCFIXB4tXHz8PdaSdeHS0c29qmgXiu0uOJjpRjWQNRNYGenlL8nInfRR1ILpl7g+Vhtpl8F2kpeA7PhnqYTbwnkCYgKezLwraV4XPRs8M5MUZk73o6HQuXFmfUUmrAmgXLJrJJd4uQkW9QPBEqoHIZuwlNW7iuiiLjv+lTp0WF4A74rnCKuADvD017cpEXDW0emdWPBXju3QWw8duMX8iKiu51yL8sjqZNwTr1JERDu+wI79QUcoubPGsGP2vnzWKmXUa/QKvhPltBT+AXX+XUsvQB5+QeUTzFQuNLYrA==
Received: from DS7PR05CA0011.namprd05.prod.outlook.com (2603:10b6:5:3b9::16)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 21:54:11 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::1e) by DS7PR05CA0011.outlook.office365.com
 (2603:10b6:5:3b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Tue, 13 Feb 2024 21:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 21:54:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 13:54:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 13:54:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Feb 2024 13:54:00 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <murphyt7@tcd.ie>,
	<baolu.lu@linux.intel.com>
Subject: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when PAGE_SIZE=64KB
Date: Tue, 13 Feb 2024 13:53:55 -0800
Message-ID: <cover.1707851466.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 64456894-769f-4e65-0897-08dc2cde4fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yU2wNLu5DYnzYHMfWi5NQ9B2pN0xTTJvM7mO4ZizxjsmPkf0/F79lWmYm+1RoIDZx20rP1aG2LA478Xk7AapyIi49nsERz0KbI/s/Ba78Jh02PV/G+3X4mKSbqE7qSCUN9KIvpvEsjQkekx+LairJ/HCFD9J41Q5ulVKq90g7v+/5KyNcggYEQc1z8zQgfbrWlbQHrA89DeuBISHpgmcTQ+ZvnyEQ7OJVC9nHhfS5BygBacBgc7ZOrTRZ5JdmvYabM+Owz2LuFbtt6u0hY4a27TTvLzL98vUQtvPiB4V1UlTK75B5zBBeDGQWLC5lN3SN0VEanqFeVr3c5ualkQLFR+wPospgB9eRKEKdQaqyVH6/i6WAPeH6Xl15u5EL1dZko1AmbnyRbwdyQ9PJhxGdKY5WvdNanABgD7kY3JAoEVX3fxwYUEyStgcAv5z8FdD+IFrp5A+zYNQc3NJKr5qvKYGe1G+MJRoskZvsob4LxFZRh+QTWumYiOD3b/jwgEXt0RqN+ak3iVII5bGSGHiVf9yQ6i82ejbG90vK6W783GriqOFdVY/Q+1VCf79nnpX5eOcthOPq3rLvctYgmqo845JFR/9ff2XEUmiMD44m0Y=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(2616005)(26005)(336012)(426003)(2906002)(4326008)(70586007)(70206006)(8936002)(7416002)(8676002)(5660300002)(316002)(478600001)(54906003)(6666004)(7696005)(86362001)(7636003)(356005)(83380400001)(82740400003)(110136005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:54:11.1348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64456894-769f-4e65-0897-08dc2cde4fc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333

It's observed that an NVME device is causing timeouts when Ubuntu boots
with a kernel configured with PAGE_SIZE=64KB due to failures in swiotlb:
    systemd[1]: Started Journal Service.
 => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
    note: journal-offline[392] exited with irqs disabled
    note: journal-offline[392] exited with preempt_count 1

An NVME device under a PCIe bus can be behind an IOMMU, so dma mappings
going through dma-iommu might be also redirected to swiotlb allocations.
Similar to dma_direct_max_mapping_size(), dma-iommu should implement its
dma_map_ops->max_mapping_size to return swiotlb_max_mapping_size() too.

Though an iommu_dma_max_mapping_size() is a must, it alone can't fix the
issue. The swiotlb_max_mapping_size() returns 252KB, calculated from the
default pool 256KB subtracted by min_align_mask NVME_CTRL_PAGE_SIZE=4KB,
while dma-iommu can roundup a 252KB mapping to 256KB at its "alloc_size"
when PAGE_SIZE=64KB via iova->granule that is often set to PAGE_SIZE. So
this mismatch between NVME_CTRL_PAGE_SIZE=4KB and PAGE_SIZE=64KB results
in a similar failure, though its signature has a fixed size "256KB":
    systemd[1]: Started Journal Service.
 => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
    note: journal-offline[392] exited with irqs disabled
    note: journal-offline[392] exited with preempt_count 1

Both failures above occur to NVME behind IOMMU when PAGE_SIZE=64KB. They
were likely introduced for the security feature by:
commit 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers"),

So, this series bundles two fixes together against that. They should be
taken at the same time to entirely fix the mapping failures.

Thanks
Nicolin

Nicolin Chen (2):
  iommu/dma: Force swiotlb_max_mapping_size on an untrusted device
  nvme-pci: Fix iommu map (via swiotlb) failures when PAGE_SIZE=64KB

 drivers/iommu/dma-iommu.c | 8 ++++++++
 drivers/nvme/host/pci.c   | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0


