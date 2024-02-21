Return-Path: <linux-kernel+bounces-74624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD2085D70F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C763228311F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45241766;
	Wed, 21 Feb 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRZJaowg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9184122C;
	Wed, 21 Feb 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515312; cv=none; b=ki6EdzV43HBY8wFmBWSrgTztEy/mIPTr/PigaZeWdlbsBWV9vCy5Z9u4QE8CLY4GQaK7toxfSw2FBo+Q1/iHj5LqE2XG79FplhVFD52fh0ERH0qMUjQlBRfrxMWDe4NHhFjVAeU/y1qzTPjLhKkMypsmJjZ8hzGx3CT3/3r46xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515312; c=relaxed/simple;
	bh=LrEFrcKQxsI5oLBY8Ymc3PVuMOoyMrYqGkDaTet93Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ligHBuyVz1OI/lWBNBjU9qeCey34cr69MGXk+MWF8iiksOWc86sQv6mjOaIEzEmRtkjX129Rr9FRAIh5SeAjRhFVktvOdqnx2beIcKDGIxIezNsvhlgpiJdafxKu/y+NvR/smTJdmbufXmXvlg9K9qnMX/+bsZz3Gl07cfia92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRZJaowg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E13C433F1;
	Wed, 21 Feb 2024 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515312;
	bh=LrEFrcKQxsI5oLBY8Ymc3PVuMOoyMrYqGkDaTet93Jg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZRZJaowgWMfnb/UMCjsVUWzFbDnhSdGO16nSgaywmGCTXV5P4a1dZ4t2F7pWsvoXu
	 vDOYmGRbuRUpA65PV01CowgPJ5gFhdTFuegSVK7HhBp9vz87+zuCdF1E15teqU3+pm
	 eDpbf869okiuHAL152YxYK4zGXuGgdMBGUrkFYAuOyIKGBuOzC45197d8GA8pDdBTQ
	 90QGo/OjSWxNoEYIBfURsoHaTUI4zIISXDy/D7o2PGqNFT+MErX6NQYzg7TZBFMwtl
	 1EIzHub3brycH8f+Vsp36jLyicWBClxzpz9kJEU/HE2aNMR/zxKdwohELFY7Sxuhu7
	 fBpKY2D6LFFMw==
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
Subject: [PATCH v4 0/5] Fix double allocation in swiotlb_alloc()
Date: Wed, 21 Feb 2024 11:34:59 +0000
Message-Id: <20240221113504.7161-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi again, folks,

This is version four of the patches which I previously posted at:

v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
v3: https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org

Thanks to Petr for his Reviewed-by tag on the first three.

Changes since v3 include:

  - Use umax() instead of max() to fix a build warning if the first
    patch is applied to older kernels which warn on signedness
    mismatches.

  - Add two new patches to the end of the series to resolve some
    additional issues with NVME and 64KiB pages, reported by Nicolin.
    I've added them to this series, as the first three patches make it
    easier to fix this problem in the SWIOTLB code.

  - Add Reviewed-by tags from Petr

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

Will Deacon (4):
  swiotlb: Fix double-allocation of slots due to broken alignment
    handling
  swiotlb: Enforce page alignment in swiotlb_alloc()
  swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
  swiotlb: Fix alignment checks when both allocation and DMA masks are
    present

 drivers/iommu/dma-iommu.c |  8 ++++++++
 kernel/dma/swiotlb.c      | 43 +++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


