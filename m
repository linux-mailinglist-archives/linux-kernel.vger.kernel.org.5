Return-Path: <linux-kernel+bounces-124912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C9891DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71EF1C27B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84714BFB0;
	Fri, 29 Mar 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaNL0ut3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CE29E1C5;
	Fri, 29 Mar 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716418; cv=none; b=PN3Q+Y9DtrkEG9xcJ3UnthjlDV+osA4RKvQ16jbY1Ona4T0kVgaQi8cVPhr9fUu9Z5aH0aSQdvB0DhdMN+Aq7d6g/ZvUQZ/F+FnPIBu3nzmYENP8YjLlpiaedjAqB1sDC84PSPWgWlBvX0L3u0KPO2BBdmPVkjGypCDVbc83Vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716418; c=relaxed/simple;
	bh=k817z/wiq1ZdzswJB0vLMttW1moO1DxXigH8OAcdidA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ5GPwFXsooIz0OxfD0VWXxgkolinqC2SDnOcvCdG2H5LlKoDwrUICZJQjH9R1rOGtAuxsKqkG4DbEq+vnHW0cqc7KaUNv/CfKHfwLqXD01pM1Oloe6nW+p3+i/S/e+avyBxh1XnyPHP6Te7wB68z/m6lSI/i7zyRjfbmZqN4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaNL0ut3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D10C43390;
	Fri, 29 Mar 2024 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716418;
	bh=k817z/wiq1ZdzswJB0vLMttW1moO1DxXigH8OAcdidA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QaNL0ut39GfeY9cNKBFVDg1JkZr6u0+tgt9hUplhYQXVZnchEkSb9NA77RQa4UXFF
	 Ve3sX28q3dM2j4oq5VwgE3XfNGRb0GOLCDQynpb+o9S5RBbyR+VuLJwJzzWA+Eha3J
	 Qc1bPAGP45gHjuNo6hoX7P3O1n6iwZrAlosdbZCTwuMn3ryuJikpmRlZntEoM4vrcR
	 OurigfXh+6e4eavFjZ5IQoeo71oxtL6L8BYSdAGgLK04WHHbvzfA+77J+knaAjeSjE
	 QpNhsr5K2KfUEL0wT9/WX5MAj4O8Psthk4Uu6yH8jd1cnU0sG+MBeDvuUivf6MgqUS
	 5U1KruezeiU7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 28/52] dma-direct: Leak pages on dma_set_decrypted() failure
Date: Fri, 29 Mar 2024 08:45:22 -0400
Message-ID: <20240329124605.3091273-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 63859a101ed83..d4215739efc71 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -296,7 +296,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	} else {
 		ret = page_address(page);
 		if (dma_set_decrypted(dev, ret, size))
-			goto out_free_pages;
+			goto out_leak_pages;
 	}
 
 	memset(ret, 0, size);
@@ -317,6 +317,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
+out_leak_pages:
+	return NULL;
 }
 
 void dma_direct_free(struct device *dev, size_t size,
@@ -379,12 +381,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 
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


