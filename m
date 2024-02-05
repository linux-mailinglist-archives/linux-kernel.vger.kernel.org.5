Return-Path: <linux-kernel+bounces-53275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199A84A2FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144F0B26D74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659FC4CE06;
	Mon,  5 Feb 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkLGdqbt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B074BA96;
	Mon,  5 Feb 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159701; cv=none; b=kx56FlHZKSe4uRgzTJ988OG0o4roD/27K4Q5AWgJxMLtnY0Yc9OarIuP5MUw7o++ISqQxq+UQRy6JtvEK4yIK+w+ZUtPerU6wQ4DBpcAQCNpLG8GFjn5unF9e4idV88UV/6UX65V952t3mbf/6hLmht0l74L3FDrTITIjK8HTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159701; c=relaxed/simple;
	bh=Xm+zNHaI1L6yDroz8J/2SUT0P9yQzO240Q33Rj/NF8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xwt8at4/6Rz9UNBXi2kixRqCskCGhp/X1zWjqo2MPgZZhK1ne1dckibKeCKqu0GWmcMqlTC/akhSD160ctkXQ7qoHE5jrnT2AAYDCf9gorT8hSK4AthGsMeykiCY480p8c16l4HzAsy9qU0TBR/NfS9Z3QaDNUeRKt9jiVFXgho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkLGdqbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CA9C43390;
	Mon,  5 Feb 2024 19:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159701;
	bh=Xm+zNHaI1L6yDroz8J/2SUT0P9yQzO240Q33Rj/NF8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkLGdqbtVBK2Cn0h+xSZ/PXnBH9ZzuzbPxDZyJevoa4KTz2c2JKWo1J2L05OMfoS4
	 yE2WSQWMmIr+86D8xLTHJrok/gyrBAGAuVSDbJfev3T4Mcxq4ey++Ii6xYQfBWJgJ7
	 ppbmSp9LecvqGB8aOHD4Iz2LQZOpnoPbcFjjgh6dZfFO0sOan7u5OnFvMFCnrgLcKj
	 L20sMxRTnQakMyFSO7MkjdfUERnK3w63JicuVJcWO3zHLWTmH1pK4/uc6K2KZJGaLJ
	 7XHeeFFe0RO8KFvhdwCa3HHZWuL8rJMcM8DBSsgLZqmZ4dYC9A5VTsYUJzHrJfd78Y
	 x7YJ6seoe6whw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 2/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Mon,  5 Feb 2024 19:01:26 +0000
Message-Id: <20240205190127.20685-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240205190127.20685-1-will@kernel.org>
References: <20240205190127.20685-1-will@kernel.org>
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
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9ff909a0039a..adbb3143238b 100644
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
2.43.0.594.gd9cf4e227d-goog


