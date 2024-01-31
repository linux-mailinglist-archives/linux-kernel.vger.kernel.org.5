Return-Path: <linux-kernel+bounces-46417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FA843F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B10B2947D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C67AE61;
	Wed, 31 Jan 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psoPX5uw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250757AE43;
	Wed, 31 Jan 2024 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703954; cv=none; b=oYlFCJIPrL/AiPggh29n6+X8ZcJmx3RhANmp5uRX9RLXQuWPhx8le0Q9Hde7HiF4AGhhktjj1Gi3PLrNsQaFPY8CsNbn5HZOF6JNrOa3Bh5bzxnlwZuN2yUGPqoLyVXSQV6ikf3JeB3UfAezpO05X9oW38x31o5etlmjOjCRChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703954; c=relaxed/simple;
	bh=tvZfP5ZDpz93rBnkWzn8NpisHuCrYWdGw0rDfTGSi0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBCC5JC6QIQ4WZkaYHAfzdB49yS88jDXXkjjrb2kSScPCdP0RuRz/LkLNXHGEibV6IDwZ04VnHCq+K/UbtrB5vuaio+pu4SxOJCh1bikLym/Q2wAzGLOaz+SQs/Fwvc0d3ut0BvkmM00TP4idac45nc0j14rP9p9keb7W0X4E2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psoPX5uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF82CC43399;
	Wed, 31 Jan 2024 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706703953;
	bh=tvZfP5ZDpz93rBnkWzn8NpisHuCrYWdGw0rDfTGSi0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psoPX5uw05sqXOPDqQR+NcDpcVMXHTxr+ToULGVDXA91pOO4sDKAW6xGUtj1rRygW
	 D1EtgsNsBW9z5MOfJUcBMMPzBLOjsRe5XTga8bzLOa9b4zvWWAc2G2Q2iTA5t4xNLl
	 KtKJroPbgWfp2SuaPIwX5pRBEAo2p5SdfaIqjyriutK+J0vITqUdA8IevRtxbZ7C04
	 OzPdkiEMEfkJhGuV3ncoGiA+2hyHBoPDwsAJF/MLOQHkHbTppxE4W+zQfG4r1Zm9El
	 u4b0V5kMmLRzZWIqNX2v763gsFq1lQNl7pyDMsvD0ODRbE5iBJ23OxIZf3HL5EqGZG
	 v8VuNBl1Xzb+w==
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
Subject: [PATCH v2 2/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Wed, 31 Jan 2024 12:25:42 +0000
Message-Id: <20240131122543.14791-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240131122543.14791-1-will@kernel.org>
References: <20240131122543.14791-1-will@kernel.org>
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
index 56cc08b1fbd6..4485f216e620 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1642,6 +1642,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
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
2.43.0.429.g432eaa2c6b-goog


