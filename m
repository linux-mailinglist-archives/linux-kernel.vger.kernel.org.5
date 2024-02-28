Return-Path: <linux-kernel+bounces-85108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE786B08A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20D12841C8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCB14DFD6;
	Wed, 28 Feb 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW0JH05C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876614AD07;
	Wed, 28 Feb 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127577; cv=none; b=krx7+4sGD7piDDlwCy+9YJB0I52fRhYujwdyLZqzrr9mjnyix6flJeghiEXP09BscxrtLwfUaS2q7nIrKfZhONr/mJ6obctoEtM2z+U9yWYgB2IdvHcgFcWNME1+w4MoCH7owCTghoN9z0RNxBNpK5dhhVbmOlFb5xqvLOpMPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127577; c=relaxed/simple;
	bh=9M5IeUXf3IQoeSYqVlOLU709MVkE93Tw2opRABbT/bs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C9drTXMmEcJJtB2fvPrmZM+1OXYsm5S4BkjjOyht7sXd1iDjzbvwIjO6Q7oAulIa7HUdJdVx11iWkeyrz+w1zT5BD2YAg1M33jFbDi0B+H+onIYMT4o3FaT/ywQ+n5QCTMwSmiQw8gSIJy0dD9L8A7s82fjMNio5XxzLtWD1Tn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW0JH05C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEE5C433F1;
	Wed, 28 Feb 2024 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127576;
	bh=9M5IeUXf3IQoeSYqVlOLU709MVkE93Tw2opRABbT/bs=;
	h=From:To:Cc:Subject:Date:From;
	b=cW0JH05Cslh9hwgukH/5vLo/F5orXfPEP+8a7EHwdeehPxmWkap/0tEVqXTtv9pns
	 98mvJ19iHQ/ltGsOEQvIReTkQxhbSKJmeOXc6BYj/A0X8xuNVtf2KDhgssuKh0Qp+t
	 4sYuVtBBveyEYvccu9XT4erREGsWwxnNUF84TgA5D78cPy/2iOg1K5oCeYyMjPDgSr
	 bg3JJ3M2mcYK7mqzts4irrJpnN6IaHNs8VUZo2CVsIxwfVamxI39kAWRXSOUGy7RWx
	 CJ5KKhPOY/9kJhGIvggJHF2HGI5k+4/w+9Av1vc3zjfw6otCXmNy5rQ50rRXKbuXlH
	 b/TUkZ73XzlCQ==
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
Subject: [PATCH v5 0/6] Fix double allocation in swiotlb_alloc()
Date: Wed, 28 Feb 2024 13:39:24 +0000
Message-Id: <20240228133930.15400-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is version five of the patches which I previously posted at:

v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org
v3: https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
v4: https://lore.kernel.org/r/20240221113504.7161-1-will@kernel.org

Cheers again to everybody who helped to review and test the last
version.

Changes since v4 include:

  - Remove unnecessary 'is_swiotlb_active()' from patch 5.
    Nicolin: I didn't add your Tested-by because of this, so if you can
    take it for another spin, that would be fantastic.

  - New patch removing redundant stride adjustment for allocations
    of PAGE_SIZE or more.

  - Commit message tweaks and addition of tags from reviewers and
    testers.

The final patch is a cleanup, so I'm happy to post it again after the
merge window if it doesn't make it this time around. The rest are fixes
and, even though patch five doesn't solve the general problem, it's
sufficient to fix NVME for Nicolin and is definitely an improvement over
what we currently have.

Thanks,

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
  swiotlb: Remove pointless stride adjustment for allocations >=
    PAGE_SIZE

 drivers/iommu/dma-iommu.c |  9 +++++++++
 kernel/dma/swiotlb.c      | 36 +++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


