Return-Path: <linux-kernel+bounces-64386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD9853DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093DC290298
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35737626D2;
	Tue, 13 Feb 2024 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VYY93TFG"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE36216E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861260; cv=fail; b=a+uL2igEVZNmHNQODdDlHBowNJYrbhORwuqQwUHM7FZfKw7pNSmd9K0q9Zosb9bPIQwoJACXuTpW7kzapPIy6454Q/3pcVEvcuOE34keA1hkO4mXw+euvQsdP6bUHcR1sYeIqBDAk99Jn+Qf3udFJNdmHJGdw2eWLCPgtu8ZVuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861260; c=relaxed/simple;
	bh=hH1YHZS+VzHPth/4ds3SUackDjp8aJ997V/y+/ego5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9Hxov+H0Xdmjrd7xmAskGoGbzJNk2Lg4L6y6nnEWf9lQWL343egDgXHNRKY+56Wwh87zDFCyYJ4iIhFJl9tCurPJhC/kccgGt6jNvSErl+EZRkJlCDgcmgSq1l7VsoJaakBBNMojMcZDv0zGv+/wOHW5s6+L+joPTKe52Mz1QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VYY93TFG; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGheCozM3GiG7fg6NN5BVqGqYoYor4YRVQle9lYX1YLf6LOFoNMBWU3nbpSJVN/iMA7liouAwYWmQTtBHgwnCZJ/qeeY2LOYAQmO2ltWJ/tK3nlLdylooUnKiSPyxjT02DCKvhHTknnqzY8wIAcbOmYCnw7auIb+Z8SpqQuYYzlXbE7MeYIvefj/e2zoeC40Fce2mNWL2yC2yyoTIqmqywOhVgiORCYb8+IQt2hDV9MN+DM7a+X4k+Q7j0+lVJ4z7OuOcI1nYyLcc7LIQD4vYHH6HyxZPUG7OzowSY1insVDdm+H+JAiX9KtcznDteUdi37ryipbZkrmdLbnC4L5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6JHQ7jy8l8fMl0qyFX+tUdXmkJDwjxBXPyhLlACAso=;
 b=aE7IKxEXnzjVC2Fmglp2v3iCxDyEAGKCdMJ4iUPO8BHOteXJnSf8snmjKIN7kzs+8ZXua5EF8Bpy2aD7jeUMWgSXTFV9+uqoY/odC94wiBQQU8ar8ku3V91z6W+CkPCaaNdL2QvG14lIyQgrOPzNEyW36BaRk/Lvz6o4f2cGRUPZlYUAA41KvqhaCU4aCQIFtkgxnZWKvh2NyhPwmjr6sKDTnSs6WfacZ6DQ1WYLqnUHFFNy6jxA0tsPsCKyZV/paykd4Jv8ix3FXXdSWl+UfTleQCae3vB6JwCqJ7vJNVuejWt2g3ScuJh3Dyk9WIblfO0jgMHS5EvEMz8CQDVPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6JHQ7jy8l8fMl0qyFX+tUdXmkJDwjxBXPyhLlACAso=;
 b=VYY93TFGi5UTdAgUNusAuO7UZ7H7o6rlMPfgOHPmfMBhGO20q9NzzBrEcicpPmzEk0ymDrERR+MlHJEjsOcL14gJB5j7wHoHUgdhg3ASO02lihBWXwM7PIOLiaiJl510u60yzcrNTQc1ZJt0x49O1a6MjBxeHCsC4bWt/tbH9Ioy8h/MtN15aZm62AHoytmdv0eou7fiqxJKWjSd7lsOb89EToymSLZ3++8YsSicBHRZz6wwJNAtiv6ePDW+n2kueCoPUAnmzzS3oqYP50nceGe3cDuwifD/ag3fMPNTjzz7bZsnh3tB11AUhMYpjyki9XaoScesnWfCppfG936W6g==
Received: from BN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:ee::26)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 13 Feb
 2024 21:54:15 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::5b) by BN0PR04CA0021.outlook.office365.com
 (2603:10b6:408:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 21:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 21:54:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 13:54:03 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 13:54:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Feb 2024 13:54:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <murphyt7@tcd.ie>,
	<baolu.lu@linux.intel.com>
Subject: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures when PAGE_SIZE=64KB
Date: Tue, 13 Feb 2024 13:53:57 -0800
Message-ID: <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707851466.git.nicolinc@nvidia.com>
References: <cover.1707851466.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd58479-14a4-463c-9e79-08dc2cde525b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5r8gm1q106gA+v9xkUzewPRrDHkZoZN1BLK/2YmumOnqo/4xgNyED1a7xL9q+jCqBVmHXMuk29mwmlMQNE0qPXUbZ/RE9iX/GJ8wKnKlHrCbJj4FcK9D4x8kSANOMqJN0sZstaMEpV45bOPtbpJUnV/gY92o1W2e4ipKXBHJHywF8u5pxQ1LP0kArEZFSWQEjWVGt1mz/RH/qxLLVzM40XW5LjahKbZ4KIkKCWjiGpSdm9QokAU5M8h51Xlk0X7PuLkHU14Iu0X2h1trsZu4GMv+KNYAVpFBcLf5eeVaUqB4luZHYgHOzzWrinZyT66Guu5r1hgQ9Z0E5M11c7VV/MGorKhtJ4IqaNVDrg9iOWb2z+qsfES0Xs52JwWEp7J8ebeUopITKzc/Flw0VV1cwOhKbpVi4p/Q0/YXUL3gfSPVlkRVzqOmAibG488ddoruTAqCB7jzhWcrWaqGb3Ht3HsYcodyermaQNWzn8WXeLsgMXDb9GnMAdqgORD1nWrPwQyqoB84srnWPma8a/id+QZ192DfURQxFAk23Nm1QhVvKldpS7rTy2EzZAWw8OzwI79MEz7ejgUEVEck+GBVykqqzzjffwKYyk5KRBosfX8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(83380400001)(86362001)(41300700001)(316002)(110136005)(54906003)(26005)(7696005)(2616005)(478600001)(6666004)(36756003)(5660300002)(2906002)(8936002)(70586007)(70206006)(8676002)(4326008)(7416002)(426003)(336012)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:54:15.3834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd58479-14a4-463c-9e79-08dc2cde525b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576

The min_align_mask is set for swiotlb_max_mapping_size calculation used
by dma_opt_mapping_size in the a few lines behind.

By default, the swiotlb_max_mapping_size() returns 256KB subtracted by
roundup(min_align_mask, IO_TLB_SIZE). Since NVME_CTRL_PAGE_SIZE=4KB, in
this case the swiotlb_max_mapping_size() returns 252KB (256KB - 4KB).

Meanwhile, the alloc_size eventually passed in to swiotlb_tbl_map_single
in dma-iommu is aligned with its attaching domain's iova->granule. If the
domain (backed by an IO page table) is using a 64KB page size, alloc_size
can still ask for 256KB v.s. 252KB, which fails the mapping request:
    systemd[1]: Started Journal Service.
 => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
    note: journal-offline[392] exited with irqs disabled
    note: journal-offline[392] exited with preempt_count 1

Another factor is that the attached domain of an NVME device can change,
so can the value of iova->granule, meaning that the min_align_mask cannot
be set simply using the iova->granule value from its attached domain.

Since the iova->granule usually picks the smallest one from pgsize_bitmap
and it oftens matches with CPU's PAGE_SIZE, simply set min_align_mask to
"PAGE_SIZE - 1".

Note that the other patch "iommu/dma: Force swiotlb_max_mapping_size on
an untrusted device" is required to entirely fix this mapping failure.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..ad41fe0bf2e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	else
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
 	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
 
 	/*
-- 
2.43.0


