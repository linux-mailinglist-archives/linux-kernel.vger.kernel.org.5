Return-Path: <linux-kernel+bounces-85110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AABF86B08C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC34B23B02
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F0153512;
	Wed, 28 Feb 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxi0zrK2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E00B151CF9;
	Wed, 28 Feb 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127582; cv=none; b=WZrOiRASfEPXVXkQFGRFiTI1DDBVxqkfozwhoLRTblsORLudfRTonqTISiU2jhDoxD4TI2bIYL1v3fsMImogkbOBdKYH4Kl5Q3x3j6S+3YnG4J1wklQ8Hm4cIpsVajGZA+CtqBMSPEWUQOyteoURxjUxcj/X5tFbPfD6EXvRJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127582; c=relaxed/simple;
	bh=JqSwzF4JV3f0dyOOThKfJ10MqkgAb5PBoxHTEu2M6eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5W7imoC8C5ThSPNr+Ko2rHuge0iqKfyBbUy8lLQJJYTONgTOanAZQ5UsryC7lLZgNT9mzlVM0fobTL2AY2fGwt+zmMNG2B0+6WPeQTY30MMGNAWx3Eti8phyaDZuW5HclJUiymTUuEcM+bBstPpNujSwrbb7CU/NWxda7L0T20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jxi0zrK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B80C43394;
	Wed, 28 Feb 2024 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709127581;
	bh=JqSwzF4JV3f0dyOOThKfJ10MqkgAb5PBoxHTEu2M6eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jxi0zrK22NyJ2K60C8LRKYeTxeUHMJEq7GqPktlk5+DIsCkQIAr+TGTo9D4W6SdNp
	 DG6L/DLwEdTtaeomm5mlZU/EQ29z0bvJpMhgo87TEeI99ayBh2zS6049zeu6mU8JL+
	 lCWFgcY/rgwS2x0fXiNevJ8b17JGZUS2kD2iwsSzBjA6b/n0Xc4YMIztZcFANd+MFo
	 G4PQ71ToheQ78cyICvgvOX7KDBjYxh21tll2HifVEQKmJmgRmXxXMTGAL9u4LkubtN
	 vVgNU54CFM7rSubQVGftxnILgKwLu5Utx/zVHoj5y4dUbsNoEs6Kpur7vDG6a6WmDe
	 eOOPet1TtYmLQ==
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
Subject: [PATCH v5 2/6] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Wed, 28 Feb 2024 13:39:26 +0000
Message-Id: <20240228133930.15400-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240228133930.15400-1-will@kernel.org>
References: <20240228133930.15400-1-will@kernel.org>
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
2.44.0.rc1.240.g4c46232300-goog


