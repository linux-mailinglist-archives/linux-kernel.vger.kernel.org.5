Return-Path: <linux-kernel+bounces-40262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987783DD52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09EAB21256
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C571DFDE;
	Fri, 26 Jan 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beJRQC/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB41DDFA;
	Fri, 26 Jan 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282408; cv=none; b=VJvzAe6gxItBJJo6toVpA3a9YMw3fEanxDP2/a2HJtRgMPskbrjll5I9r5lrqbUzNykPEfO4EAJmCpxklzO9ZX/3dgAvu2xRS/s+1lfOla8Laq9chGVBHfhPUs9XyAO1svafER5hJggVsHMtHi2y+MVnBkP5BfFsK/ALWTKJSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282408; c=relaxed/simple;
	bh=t6tVLr88lHsU9jH1kug5zqXilXYDgE+NKYSfWIblYK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSeDBNScrvRrGbDWXU5s8GDBDTsHlL9nAXZVRYOlqkHmpM3w8Df551HK7rh/HbdznTxYdRtDfMeHqAB1WwhOlOYUIUWtHjTxeGwnCaW/eXzG55xNEuy6DO6GoWgufLkvM8WaqDVXwk5YMaEN5KEiKFO7yqjOepUOUc0mEa/Rm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beJRQC/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC3C433A6;
	Fri, 26 Jan 2024 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282407;
	bh=t6tVLr88lHsU9jH1kug5zqXilXYDgE+NKYSfWIblYK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beJRQC/+Q3Kb8nzVOp4Raf61+0zFGFzMo1iG2HHlKGag0edBFTqYDcUugDYzgdoUZ
	 Vj3oh4+rEQYj2Cdr2o1HB/NnvuWtoSEgdoJMi6WpxTNc060GdrNwImsdDxPprx29+7
	 RGQAacXMLvhD6bx6aObOjzotA1v/Dxb71pglXI9vlVkgtZhjdt+8qIcEqaV83sQz3C
	 97JwQZ6YaBweaHAlZra27T7ISP5TuBq8qzbjjCbj4HJWw3kJY809rZZeViYXzJSoJJ
	 ucptjt+b2tTAbFUnfUybnaYry1UVlR9UOeYO+gKIlajsg+BP+gh2+CND9XT97gGUp8
	 0TY1PprbfoNhw==
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
Subject: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Fri, 26 Jan 2024 15:19:56 +0000
Message-Id: <20240126151956.10014-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240126151956.10014-1-will@kernel.org>
References: <20240126151956.10014-1-will@kernel.org>
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
index 25febb9e670c..92433ea9f2d2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1647,6 +1647,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 		return NULL;
 
 	tlb_addr = slot_addr(pool->start, index);
+	if (!PAGE_ALIGNED(tlb_addr)) {
+		dev_WARN_ONCE(dev, 1, "Cannot return 'struct page *' for non page-aligned swiotlb addr 0x%pa.\n",
+			      &tlb_addr);
+		swiotlb_release_slots(dev, tlb_addr);
+		return NULL;
+	}
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
 }
-- 
2.43.0.429.g432eaa2c6b-goog


