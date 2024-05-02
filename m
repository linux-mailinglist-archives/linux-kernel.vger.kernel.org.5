Return-Path: <linux-kernel+bounces-166235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C2C8B97E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846611C23379
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA355C29;
	Thu,  2 May 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyfe5fbM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AEA171AA;
	Thu,  2 May 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642650; cv=none; b=QupKBFNN0BcH1vsOoq92Tkfg5y+xX9eF+BR2KSWqOTyOLQ0fjUYdiR8H9KCJzDpPy+oyeUzCASDa2XSt+x4xqkfhjvs1oxlxswXxXLwJn4dG83RtO9ZdCq2uiVxKME7b6pqRMWtjj68vhiKrpxSSUt2jrVvUL9E+BVVDVti2Wf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642650; c=relaxed/simple;
	bh=3zvGW/fNYeFraVxsq2aoI463CmBHv/uMIxo/dy6oEV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oHMP6dIjeOnFtudOcBhw13Cy2hwXkfkMk96C/ItE22P+J7dWijKtubPkCfq2f+OudlsJoC+Ja9Gfo0KQtUicg6Jg1TXvEBP/FHbV8j+vZ6d3/AzPvnp8rmDszsmGw3qebtZFsqMV4zXCquneWGxpaty8Smkmx8HfdT12aUD+/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyfe5fbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F417C113CC;
	Thu,  2 May 2024 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642650;
	bh=3zvGW/fNYeFraVxsq2aoI463CmBHv/uMIxo/dy6oEV8=;
	h=From:To:Cc:Subject:Date:From;
	b=Fyfe5fbM19OSri66B9sGMaAwpNh+ZUkWsWPakeoxNMlTW8c5X9T/sQj6De+JKfKTH
	 2+XzU2Erujkt0iMuR3IWRYF7gwRrnzXp/fsNumvzLglSuffCPvoBhgzjUv6z0QucXp
	 0y1bKrCIObrtHzJz5zIR3kdb8+hUHjSDhYZCORdzbZ8bf8cSgCFaMLV1eMZHle8Da6
	 9TFANNA9BRYTuU7N/Sx+6UmbIhc2i8+e7kNYjjacp/6QGfIr+g+621kAFR7tqm4JSB
	 q+Bp2WP5NDi2x+5iGNfn8pzQkfX8RBNeAyYoqHOsASy7upUrubdgL9YmUJZhuuJ5Zb
	 lZ0V4h8x9wQzg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikita Ioffe <ioffe@google.com>
Subject: [PATCH] swiotlb: Initialise restricted pool list_head when SWIOTLB_DYNAMIC=y
Date: Thu,  2 May 2024 10:37:23 +0100
Message-Id: <20240502093723.16820-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using restricted DMA pools (CONFIG_DMA_RESTRICTED_POOL=y) in conjunction
with dynamic SWIOTLB (CONFIG_SWIOTLB_DYNAMIC=y) leads to the following
crash when initialising the restricted pools at boot-time:

  | Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
  | Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
  | pc : rmem_swiotlb_device_init+0xfc/0x1ec
  | lr : rmem_swiotlb_device_init+0xf0/0x1ec
  | Call trace:
  |  rmem_swiotlb_device_init+0xfc/0x1ec
  |  of_reserved_mem_device_init_by_idx+0x18c/0x238
  |  of_dma_configure_id+0x31c/0x33c
  |  platform_dma_configure+0x34/0x80

faddr2line reveals that the crash is in the list validation code:

  include/linux/list.h:83
  include/linux/rculist.h:79
  include/linux/rculist.h:106
  kernel/dma/swiotlb.c:306
  kernel/dma/swiotlb.c:1695

because add_mem_pool() is trying to list_add_rcu() to a NULL
'mem->pools'.

Fix the crash by initialising the 'mem->pools' list_head in
rmem_swiotlb_device_init() before calling add_mem_pool().

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesařík <petr@tesarici.cz>
Cc: Michael Kelley <mhkelley58@gmail.com>
Reported-by: Nikita Ioffe <ioffe@google.com>
Tested-by: Nikita Ioffe <ioffe@google.com>
Fixes: 1aaa736815eb ("swiotlb: allocate a new memory pool when existing pools are full")
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 86fe172b5958..87dd3301dde3 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1773,6 +1773,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 		mem->for_alloc = true;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 		spin_lock_init(&mem->lock);
+		INIT_LIST_HEAD_RCU(&mem->pools);
 #endif
 		add_mem_pool(mem, pool);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


