Return-Path: <linux-kernel+bounces-124854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23E891D25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4BDD1F257F4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B0C1C231F;
	Fri, 29 Mar 2024 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU90wOeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9671C2308;
	Fri, 29 Mar 2024 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716296; cv=none; b=fNSO5snjldTEIjkFOZKR9YbeOBw5K/6/oOmXUOhNo+b0dVbioPCeOzu56VvdKBtIXyfTrfdrsJE46akmRczBzQE/KbV8AOz17L8+LWegzbLlRu4T1+k5/3zQsS41ncT5pO3wDQbtVciJbd94N1ceGb92l0hb6qw2uZxR8DmMJfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716296; c=relaxed/simple;
	bh=k3zuf16/TCQid4I2XHlZ7Fg+DXFG1/Fja7b3voOoAZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNqrXkk447EYsD5M/mcV26BL+L233UgOzevtHzwPs1NUgYJ8ZhmbRG6skL4F7GVM9GOx//q0Hp7virtllaERW8KLPUun2N2DtKeb8d0EZkd5MOKTczSDTZ9+uTyOYKt1UHu/l99RWUyXPCmXr9maKB0Aggu4hRS2sxTIBLc6hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU90wOeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92903C43390;
	Fri, 29 Mar 2024 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716296;
	bh=k3zuf16/TCQid4I2XHlZ7Fg+DXFG1/Fja7b3voOoAZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JU90wOeukIlADuZoBi8IeFA/LEWtYfeWiaKD9WdQGlbPbqaV4u6Y0rOHUKJNK8kXn
	 JBX4KFUPuj7tCAcQ0Qgf+F674EMdRRpNQMQAkeylKpPltvW3/I5ikOoTW8nygNOVjl
	 sm4+zP35tNiEHzQGPLSnd40jfQdDOF1XbYR2DyVQOY41W/nFD5jGsJfmRqzzk21am8
	 7+ItJ2cTKTro8rDJ/OIckqC6JS9DQofem/NFHM7ANY43dV8MrMfgwEZIgQZxaaz8MI
	 vjDHUyMts2SbHeC4dNeEII3oEIgwVzA64N6M5k3aLEEhjW4GaQG/T3XzpH5IK1gmZW
	 m/DYKLWTlezeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 45/75] dma-direct: Leak pages on dma_set_decrypted() failure
Date: Fri, 29 Mar 2024 08:42:26 -0400
Message-ID: <20240329124330.3089520-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 9596ae1aa0dac..fc2d10b2aca6f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -295,7 +295,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	} else {
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
-			goto out_free_pages;
+			goto out_leak_pages;
 	}
 
 	memset(ret, 0, size);
@@ -316,6 +316,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
+out_leak_pages:
+	return NULL;
 }
 
 void dma_direct_free(struct device *dev, size_t size,
@@ -378,12 +380,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 
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


