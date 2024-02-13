Return-Path: <linux-kernel+bounces-64384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193D9853DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45D3290014
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5E6168D;
	Tue, 13 Feb 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2wJA3t9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FD6168C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861258; cv=fail; b=rYkMXZ6nWjmXj13dMLtTu+sJnCxpaSGbG2ta4HHyz6LST2V4F4Ltu6HTbGQRp2OaUm0NuH5l4S0h9CZQCejvj/+BLY/k5xymGCEa6OAGKA+1t4P47BKAWsjPMhokYGrkmpaOtCU8H8JrdPja9f3Wu7bniw9L/BXXLwCt/6eUNuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861258; c=relaxed/simple;
	bh=DM3z2oBGZwnip5ixDzY9UTWBm7bHgPx0cYcsAX/QbLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RohZllrhaoDFscPlz9V6OTBpq8zX9Km/ZVZ+S/nrQhIUZwXuFWCuVs8vHwbLRWdv+cy0szw4YCurzjhw7QGvxo3KozHBWorsSvRyORzYxkVh3xg1Gmq/vFugXcPXuOPsg/fAGDFMoVOa48+aOJZXk/yohj19ISf+Ufrj1wLoVn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2wJA3t9; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5EQBmMHJl8q/Ruwge4nPjyJzUNns1wzpz6uBu4DRKXg2Epe3xZ4O23x91Ri02/L0YsNiUneMUCwLfXUZYcR4x1eMTPqDyUbYabl4RMWJQhqNzjLnmqWZxTcUNj2py6/IOgWY8Tr3g3Pi8iWKuJay8bddaWv36kEmONxi/EKC3KHyjDdHuVVEQsQPFIARV68oI7mYGanflrMTebLr7EkejVqKkPE10SZTfOho5mgYwOfxMFoiMNq6+i+LQ+Zsq/p+moTfn40BPHlmcURFP/8xLCQ1pvfATul0esFqWZJI+TFAJuYqa2fCtI3G7cuzOM5M2Sr2Hi4uloVqj+FWgTQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEQSJ2vGtIyPL6oWRdHO4lUhtEmKV+UyaAhKn4HzE2A=;
 b=bPQH20b6RFtmtGXFu7G93TJdaOHFDZoRbMIbFVEE2yN/94S2/BKPUQhR4eFmPtWFi3CK6t1Bm09QuB2C758qmxvzilkU03B8RI7DnRZL7yjRiJ/MBtvD9BjFAK5TFkdB4Dh4MTARlJS2895A05Hx8mExRy4fKEp75hkR/UYYDUdv7ICQXijABJ74PVojv5fJKvQbzLXMuW7RhTk4/381oQFtvgwJzPzfBqTUJZ3HGtWVMALiW+JLu3nj0sKTwhm1V7YgzjErAiiCq+jhxWP0vmAH3s+khTb5C9hFf64pUMTAW0G1lEN6BBkQw+LHeTobQLPvv/NpMjTkd3iKlywKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEQSJ2vGtIyPL6oWRdHO4lUhtEmKV+UyaAhKn4HzE2A=;
 b=g2wJA3t9G4rtXBhpxa2RGF+CPRWA3063O/zoWgc6gZSZ2b1cu0lQ64yCVnk5haH400+KnnJGsPtIb7RMvVht1u2eNt/rrKJ4PhgUh4jIIMFuzGhppY486XTtS/YlFkprsuaGTD2Ut19PJTsPATuXjTk4xJzGZf1TepcaHQXS//aXcQMCv+hUhGGsPgCndRlE03KZZO0etXHGl8vTQR+cYF89brgDy6pJFJtOUTKHxn+JXnsgeOSjbC1RW4CMgBkIxKgVpD2UjPhMqIR5+Zn/qyD35GdIUkvEOR9seDmJOM1qE1l3CGa4mGz8GFHQy43SVoi/TXY6xp0XWK3wpi81Tw==
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 13 Feb
 2024 21:54:13 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::c8) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 21:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 21:54:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 13 Feb
 2024 13:54:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 13:54:02 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Feb 2024 13:54:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <axboe@kernel.dk>, <kbusch@kernel.org>,
	<will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <murphyt7@tcd.ie>,
	<baolu.lu@linux.intel.com>
Subject: [PATCH v1 1/2] iommu/dma: Force swiotlb_max_mapping_size on an untrusted device
Date: Tue, 13 Feb 2024 13:53:56 -0800
Message-ID: <ee51a3a5c32cf885b18f6416171802669f4a718a.1707851466.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 03649d23-6aca-42fa-c611-08dc2cde50c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	poxM167Njd4Xun86ZxpOcB5ovKYEuT30poz2AdlW5w/psi0iOiyJ9wn7azHgQ2oseY7v9RcPBajwsJSpzv6d0kKj/dcEe5+0Su0MPlUaxsnqpFX2sCC/Xd0l88shuv057JzLEugPQocsJBq3JFaOXNOoKRQn0t+NAk3nrR6TLajbco/HC1vnRLUs+5NabwFkJgHx1yq78WJosvqm74RguOK454ruLA04ZsrZVeTvH74EUtV9aYRYd3C9qgLnpxm63/LRJynMt0c34IPWT33GgC+q40l+BQxSs/1+6M7fsSHYUhalvypl+KCWndwLFALvsgfWlGg+uHysIG5QrvRsVFGKP2XN/lxN1Y18g8n3gFv25VyFGXC6EtHhZ9sE0x+50O3FwjlobbfncJygbdRD1oEaQeAhbsQZFHb+WuWABBMbvdvgo1O5SblM4hp2VVJb9ghN1UWucFRzSmyAvZtFHLlPjJCMCwy0KR7kuKpO4+UGKNnjAWJL1outVglRaI+fz6ATePBVPzunrMN8dxlI9JdqsKcZILQ86VHWtT0eV3oKgRbGR1x1kuNtrUvC8Q2uPPEZsOPVUtOrFiHDGkX/+1JvtpuUE+HdsYeEa/axkII=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(2616005)(336012)(426003)(356005)(7636003)(82740400003)(4326008)(7416002)(70586007)(5660300002)(8936002)(8676002)(70206006)(26005)(2906002)(478600001)(7696005)(41300700001)(54906003)(110136005)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:54:12.7524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03649d23-6aca-42fa-c611-08dc2cde50c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422

The swiotlb does not support a mapping size > swiotlb_max_mapping_size().
On the other hand, with a 64KB PAGE_SIZE configuration, it's observed that
an NVME device can map a size between 300KB~512KB, which certainly failed
the swiotlb mappings, though the default pool of swiotlb has many slots:
    systemd[1]: Started Journal Service.
 => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
    note: journal-offline[392] exited with irqs disabled
    note: journal-offline[392] exited with preempt_count 1

Call trace:
[    3.099918]  swiotlb_tbl_map_single+0x214/0x240
[    3.099921]  iommu_dma_map_page+0x218/0x328
[    3.099928]  dma_map_page_attrs+0x2e8/0x3a0
[    3.101985]  nvme_prep_rq.part.0+0x408/0x878 [nvme]
[    3.102308]  nvme_queue_rqs+0xc0/0x300 [nvme]
[    3.102313]  blk_mq_flush_plug_list.part.0+0x57c/0x600
[    3.102321]  blk_add_rq_to_plug+0x180/0x2a0
[    3.102323]  blk_mq_submit_bio+0x4c8/0x6b8
[    3.103463]  __submit_bio+0x44/0x220
[    3.103468]  submit_bio_noacct_nocheck+0x2b8/0x360
[    3.103470]  submit_bio_noacct+0x180/0x6c8
[    3.103471]  submit_bio+0x34/0x130
[    3.103473]  ext4_bio_write_folio+0x5a4/0x8c8
[    3.104766]  mpage_submit_folio+0xa0/0x100
[    3.104769]  mpage_map_and_submit_buffers+0x1a4/0x400
[    3.104771]  ext4_do_writepages+0x6a0/0xd78
[    3.105615]  ext4_writepages+0x80/0x118
[    3.105616]  do_writepages+0x90/0x1e8
[    3.105619]  filemap_fdatawrite_wbc+0x94/0xe0
[    3.105622]  __filemap_fdatawrite_range+0x68/0xb8
[    3.106656]  file_write_and_wait_range+0x84/0x120
[    3.106658]  ext4_sync_file+0x7c/0x4c0
[    3.106660]  vfs_fsync_range+0x3c/0xa8
[    3.106663]  do_fsync+0x44/0xc0

Since untrusted devices might go down the swiotlb pathway with dma-iommu,
these devices should not map a size larger than swiotlb_max_mapping_size.

To fix this bug, add iommu_dma_max_mapping_size() for untrusted devices to
take into account swiotlb_max_mapping_size() v.s. iova_rcache_range() from
the iommu_dma_opt_mapping_size().

Note that the other patch "nvme-pci: Fix iommu map (via swiotlb) failures
when PAGE_SIZE=64KB" is required to entirely fix this mapping failure.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..7d1a20da6d94 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1706,6 +1706,13 @@ static size_t iommu_dma_opt_mapping_size(void)
 	return iova_rcache_range();
 }
 
+static size_t iommu_dma_max_mapping_size(struct device *dev)
+{
+	if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
+		return swiotlb_max_mapping_size(dev);
+	return SIZE_MAX;
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
@@ -1728,6 +1735,7 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
 	.opt_mapping_size	= iommu_dma_opt_mapping_size,
+	.max_mapping_size       = iommu_dma_max_mapping_size,
 };
 
 /*
-- 
2.43.0


