Return-Path: <linux-kernel+bounces-97232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA9876760
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D31D1C2189C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10B2577B;
	Fri,  8 Mar 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw1bQR64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C086250F3;
	Fri,  8 Mar 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911725; cv=none; b=fIrEKoqdoPlSQuggCwdPKo4wa78LYzZ4XRrcIMLx9KZpRJDFw/xRsMczNM0VlXCCkAsfXUJMOw+bMEJpRQP9EcTyBRm9LprtCN5MgAm9mu1FGQ4pAH0kFvHDleAIQAYfjKa3Kc7dmMQR/FxitYrIRImeCnE6SEIiX87TJcgVH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911725; c=relaxed/simple;
	bh=Ow9SAlH4+n7rZYPGZozjvHYRa/8sNh9HhIRpID4khJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gysD9VMnDuMDt5ylEIX0mp5rPxXGAQ8WULKv6gdgzKnD2500ugaxFCIHk9lo2KYqC5S/l8y+gQKxwYvUJ3XY50dVQ8YyomA8K7ABwaK2fBlVrJBtMTyRj6Jea/ygtKCo69fkezlJ1uIDxShyK8L2YfDTDREOtqZwEVaN20GJvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw1bQR64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF7FC43394;
	Fri,  8 Mar 2024 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709911724;
	bh=Ow9SAlH4+n7rZYPGZozjvHYRa/8sNh9HhIRpID4khJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iw1bQR64cRNIugB/M++lMYhdds6aAyuYjHFy/xL/Q/MPZU0xLKAqIIc5LyKOud1Ca
	 Fj+I8H4cqEse5HtWYHmCtj0xqJx3m5duWWck29kK/BX8NzOtfem5CKeyMSJ47JLPzX
	 f/N4k6UnKPLon3uxounK1uVGwOm9WJBmQKuEHH9oS5pVzIFRhye+yj0HYzQp41rTzE
	 t/h5LCGix5T+eWrKJM/G+ytqq7cqAs7vV05cz60RvMjAuhAZEMnnBFdaSaRMI7cewn
	 kw2KyUypJWVXd3U+t+pSad6ZJ2FOuo+0jbAlIA1J29K5fzNpcXgIT0oU0raecjL0MM
	 iJUW3y67dkWqw==
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
Subject: [PATCH v6 2/6] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Fri,  8 Mar 2024 15:28:25 +0000
Message-Id: <20240308152829.25754-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240308152829.25754-1-will@kernel.org>
References: <20240308152829.25754-1-will@kernel.org>
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
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
2.44.0.278.ge034bb2e1d-goog


