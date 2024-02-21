Return-Path: <linux-kernel+bounces-74626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDB85D711
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7949E1C22F40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C8E45BFE;
	Wed, 21 Feb 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7lVKM9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35545BE3;
	Wed, 21 Feb 2024 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515317; cv=none; b=OeJAV+jVStidBVpIlb55HhQz0fzUQWwwQu34fJfQMbv5xWYi/wbknlMh/HnVs5Dg57OHb6YrNvPV9c94Ga/GPmafP4wiUm4Z+5SAHjsrphgLUp4dqZG/YRuDpXoMjssSGt0hQ+7qdVyTORuZUHo44+hfRfiwo0ZpA5rDSrk2Xk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515317; c=relaxed/simple;
	bh=E1k4A1Ppx138Pm5Tuk5+a08g4wuk3s7KWHOxJ3SgNxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ps/3JgfCbFOqxtXgcRB/rNH/Q4hZ5GTrAuadPAUIw8Vl+0o04dNlPOFYZnj4Pa6eiV2VXt70wwUQjaD7PwKaKjwJi47UO+TQY3RwL9nJ5K/Dy0Fi+FwVHZhUhZ7HfJryBh/FmG0x6ljhiG2MDpXUk3w2CVncfawp87EEp/AvQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7lVKM9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FF9C433F1;
	Wed, 21 Feb 2024 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515317;
	bh=E1k4A1Ppx138Pm5Tuk5+a08g4wuk3s7KWHOxJ3SgNxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7lVKM9mW0eOPd7Z7L8Sci+7dRRS5SYzVi7djmh1te6RU4EO7uXYko2hb05EiHxRl
	 WMHYWNCE5ctRJpXh1aHPoxbOufpcrWemNyMEH+zcvUhacqARTYtSB+4F0bwKDONsW8
	 xaQlRge7TKqehUCMJ6d1qFxh3kFYRB3oHsFPJLO5ytfyiUvuQqTrnAJI7U/rS8whqR
	 UtWzPkur31+3Xu2I6RTYkbNW7K6V1TMC2nbPEPJSxJxfi3j2bvqUzZf0A069pvLSbv
	 07Q/cCavfmcNgMzEh8e1AtA2fISLjKqkXqMp5uQ4iQ+a0P1ksbGFTRFRRNOUXvfi32
	 EpxqduiXZCBdQ==
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
Subject: [PATCH v4 2/5] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Wed, 21 Feb 2024 11:35:01 +0000
Message-Id: <20240221113504.7161-3-will@kernel.org>
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

When allocating pages from a restricted DMA pool in swiotlb_alloc(),
the buffer address is blindly converted to a 'struct page *' that is
returned to the caller. In the unlikely event of an allocation bug,
page-unaligned addresses are not detected and slots can silently be
double-allocated.

Add a simple check of the buffer alignment in swiotlb_alloc() to make
debugging a little easier if something has gone wonky.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2ec2cc81f1a2..ab7fbb40bc55 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1643,6 +1643,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 		return NULL;
 
 	tlb_addr = slot_addr(pool->start, index);
+	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
+		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
+			      &tlb_addr);
+		swiotlb_release_slots(dev, tlb_addr);
+		return NULL;
+	}
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
 }
-- 
2.44.0.rc0.258.g7320e95886-goog


