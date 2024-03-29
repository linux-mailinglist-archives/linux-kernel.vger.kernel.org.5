Return-Path: <linux-kernel+bounces-124773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10623891C63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D791B2964D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305BC184103;
	Fri, 29 Mar 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOmRhm4G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7611487CC;
	Fri, 29 Mar 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716117; cv=none; b=Yivp9l2WQVBHZWVGlNjOdSN2hbyLwHIBa0LT8rME+uW+GFjjcG4sLTDhIJ+8bFYE21muRTmgDTp7XAG44yvObutzdotvhqPjk19Ba8FHMoSQ9/RKrFf7hJLN+fSpRzdH6/Qnc+sdEn8oCsVd9dH5Ep7pOv0DT8aK2nZh1SedAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716117; c=relaxed/simple;
	bh=gy+jUNA+O1Dke5XEhLYl2A8HvP/VJgKAGU8g/kUqfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/s988Mlm1As5uwQdvQ7LR6DNYaIY4dI7tg4QZghA+cO0F0rkbtTucuNgmrgakUWzyrglcLk3XCSnp3NpXx206TfhM2UuYpIIz5r1LBoHhKAhWLiYgwlKDpwGWYJPishf8QdCFYieYFAoMGKEAYIOTdrOoR7ua4xVUoi4Q0chuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOmRhm4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC8EC433A6;
	Fri, 29 Mar 2024 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716117;
	bh=gy+jUNA+O1Dke5XEhLYl2A8HvP/VJgKAGU8g/kUqfFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOmRhm4GBRVkIudsBInRWC9jg4BUUTwn1yCwW87VDmPTFTwWv7a9IQALWQVrkvo4m
	 JzHOZnqvHfcBAXPvw4yI+rolwqILpU18JKyRioqDgpcyzp8h238mgXSUeLqO3+rDLT
	 ofl2Fu0AxL9teSEAKWAkK95COFTRZkQt8JgPC/sSMGtq3Ixg5q3jnv46P2NG2nhXoz
	 gSY6REW+XCGvDgvPrK/3RQOkbI9aVTZaHlb8U3CKnqM2ilOxVL8Mg98qrcGlvD11Bf
	 +iY/pzLUCmQ7kf5FdXevrwIFuFMUpOOXz6hJAlla/P7bsYXebRwFi1hkVqFhK+bvR/
	 mFeH32hiWpgUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 63/98] dma-direct: Leak pages on dma_set_decrypted() failure
Date: Fri, 29 Mar 2024 08:37:34 -0400
Message-ID: <20240329123919.3087149-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

[ Upstream commit b9fa16949d18e06bdf728a560f5c8af56d2bdcaf ]

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

DMA could free decrypted/shared pages if dma_set_decrypted() fails. This
should be a rare case. Just leak the pages in this case instead of
freeing them.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 98b2e192fd696..4d543b1e9d577 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -286,7 +286,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	} else {
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
-			goto out_free_pages;
+			goto out_leak_pages;
 	}
 
 	memset(ret, 0, size);
@@ -307,6 +307,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
+out_leak_pages:
+	return NULL;
 }
 
 void dma_direct_free(struct device *dev, size_t size,
@@ -367,12 +369,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	ret = page_address(page);
 	if (dma_set_decrypted(dev, ret, size))
-		goto out_free_pages;
+		goto out_leak_pages;
 	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
-out_free_pages:
-	__dma_direct_free_pages(dev, page, size);
+out_leak_pages:
 	return NULL;
 }
 
-- 
2.43.0


