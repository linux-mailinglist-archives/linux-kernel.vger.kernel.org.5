Return-Path: <linux-kernel+bounces-74629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25F85D714
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704B71C22E3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDA847A6B;
	Wed, 21 Feb 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOo6yhNv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9847A48;
	Wed, 21 Feb 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515325; cv=none; b=BhpWoZPVctLFOp2RkPk6689vDWHdAUv85eNmTLmV8jjXnnjDsBMfZmnqYIF8QLCoJxvUU0OqiJeFCJpI/UKIe3D5lFS+FFOvSiVZ+BqxHeaWtzgyqqY8AcIlhHRI669xQSw/8Fbma7jPW6uYSWJFsGCJWa0VuajKMb1i1r9XQ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515325; c=relaxed/simple;
	bh=tme5Bcu1kmkgKcTRsUL+dtCitanw38/NkbYErn3Nj2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3ChHse7lMGsi8dJw5sxQg5q8UbV+qg6neDCi045WNpLp9dpjaatINnNHZ6t97nAkItTsoDF5kQBJIVAgfWAOClpdf3FwoEgGVpphZbzELff5jrDSjHlez00IjslTkrMHxkmlkapmRv6FeBmXkIbYkaysKPWeSIkZi7fS6EFeU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOo6yhNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EFFC433C7;
	Wed, 21 Feb 2024 11:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515324;
	bh=tme5Bcu1kmkgKcTRsUL+dtCitanw38/NkbYErn3Nj2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOo6yhNvqRON3GEiSyeQg497wNAQR9efRB1LG8MEA41J47ZbVcgKLSp6JFyA6ffM1
	 vOOsgkvNTUvaXPDO7FwKdJx94Gr+BVB4zl2MgBJ7o9qPJc+L59hNzgd3so+zWO1MCZ
	 xa0ukx54zHqqH/+vD9Ls00XlK86l3el5kbcrP/whwe59Ijr62yn60LMblUoVM7NXT8
	 25Ds0o/c6tg3oZX1q5taHI+zubZwTNZgblLennFqm3KCsgMUum/nSNhHHkbvM5TKRH
	 ps2wHDQTHkOa/Y5TjOUVST781XSfIjk3Z2Eos6k8Y/IT+Dbwww9wuxSn/5ChSM/rna
	 0Xw3eEAvDEyPg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an untrusted device
Date: Wed, 21 Feb 2024 11:35:04 +0000
Message-Id: <20240221113504.7161-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240221113504.7161-1-will@kernel.org>
References: <20240221113504.7161-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

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

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Link: https://lore.kernel.org/r/ee51a3a5c32cf885b18f6416171802669f4a718a.1707851466.git.nicolinc@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
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
2.44.0.rc0.258.g7320e95886-goog


