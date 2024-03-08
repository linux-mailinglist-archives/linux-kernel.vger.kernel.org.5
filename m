Return-Path: <linux-kernel+bounces-97230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF81787675E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD701C21724
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37301EA91;
	Fri,  8 Mar 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYvFtZ2v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A795234;
	Fri,  8 Mar 2024 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911720; cv=none; b=EbdZ1D9Dh3lL77hadZ5DLbCk/5elrLBOPuytCbCuC/pqVOx1F+WheRannc/HApMVVX9cjiyv9nBH3d6Vlk97Pt2pA6Q2/aNekAyDoUmnBruKmDlezwDSIPkHs8DoCKWgJ8P6PBnNR/myyKzOuiMzPyTx96DBZh7dHf9c+ShcuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911720; c=relaxed/simple;
	bh=dpGKlN2KaGZ30/KsUVnrfV0KTRmmZdACO4l8BVar75Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYCtdZA4O4L97FXF1BwjXH/t6UemxHUI0SKGSmBo225iCkqOMN3oCYu9bN+K68oqYScgBBg1TqoJGl5LykqZfofmqH31LiYK8v1xJh2IQoU2q3+qoYhxlxPiTUxAixEy2xoxi1toRZTNX4cjYUVO6ACc30lWeeOmPjHjGBnkubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYvFtZ2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A78C433F1;
	Fri,  8 Mar 2024 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911719;
	bh=dpGKlN2KaGZ30/KsUVnrfV0KTRmmZdACO4l8BVar75Q=;
	h=From:To:Cc:Subject:Date:From;
	b=eYvFtZ2vlSSCilQVEn1E9lsGMUPpx52jS3qCTN2mHjiWwj90xGfTQMOHlic5ClGHr
	 LskiwsTJhWmYpURnc83ZXYrHDmuXfDdxMg8bO2T05NbUrm24YP6Tbs270dQNyB60xC
	 KYH95KO6WHGDAjn8mL0IdEfdNcvZd0tLBh9N3eYUEFVKbPxKBiNNnqhp6riRTHuokB
	 lDMoBunsoIBJKGysHUtf3aOUKyMyHRaDP+HfvbHnwTuGU4F7jt+uR9ttJeA2rO9ssW
	 jbYzPt+GHVvILVT+yecirHpYXg9yHaNqb+rjBzmjFqYOI9YI7IS1ccUzxXwFG9mBh/
	 x1GwhY7kLGbFg==
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
Subject: [PATCH v6 0/6] Fix double allocation in swiotlb_alloc()
Date: Fri,  8 Mar 2024 15:28:23 +0000
Message-Id: <20240308152829.25754-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi again, folks,

This is version six of the patches which I previously posted at:

v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
v3: https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
v4: https://lore.kernel.org/r/20240221113504.7161-1-will@kernel.org
v5: https://lore.kernel.org/r/20240228133930.15400-1-will@kernel.org

Changes since v5 include:

  - Rework the final patch to preserve page-alignment for streaming
    requests without a DMA alignment mask

  - Added Reviewed-by tags from Michael

Cheers,

Will

Cc: iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Michael Kelley <mhklinux@outlook.com>

--->8

Nicolin Chen (1):
  iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

Will Deacon (5):
  swiotlb: Fix double-allocation of slots due to broken alignment
    handling
  swiotlb: Enforce page alignment in swiotlb_alloc()
  swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
  swiotlb: Fix alignment checks when both allocation and DMA masks are
    present
  swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE

 drivers/iommu/dma-iommu.c |  9 ++++++++
 kernel/dma/swiotlb.c      | 47 ++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


