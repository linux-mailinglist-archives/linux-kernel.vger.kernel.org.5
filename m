Return-Path: <linux-kernel+bounces-124531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EA589196E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790691C24D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF7147C9D;
	Fri, 29 Mar 2024 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymolme0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F37147C7E;
	Fri, 29 Mar 2024 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715317; cv=none; b=OThRxgg1rTf4nQGnIrXIdHEF6c2r6bYEv4O3BCo0x6Rwb5FhZDTZEYbDd0892TkSQ4W9ec9oYrJS0oTQMhz+JfHfJ3iVzYHDviZxCnehw4XMTth6ehbLo/rARzRGieIF9D9y+h5rgZ4LLEl2kt5rFXHkp7NilAwWbbJRA8F4S7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715317; c=relaxed/simple;
	bh=gy+jUNA+O1Dke5XEhLYl2A8HvP/VJgKAGU8g/kUqfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsOI93l8YP1PgH12w8Xcl6rCauoZ/oNw+P1NJwou0dT8kGMYTTg9ZQ8eY7NOKr2qTq3X40nfrQPu0EA/RIWESEotPG/10TpYOdQoygGC10VAZQEEMob9v35TJNqwZzMytbq4g3s3r5qntm9VUVhNi1X8Zpo2ok1INPAQe9uHy8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymolme0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AC5C433B1;
	Fri, 29 Mar 2024 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715317;
	bh=gy+jUNA+O1Dke5XEhLYl2A8HvP/VJgKAGU8g/kUqfFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ymolme0q61kG+uvguRT18VznmRzVACWIPKVICDSRHTGiAhL1eD8km8oCZ9Fv8fqp8
	 0+Zdo7PFvHvvvilBOjdfm/ESZ3nYdB6lvRoNcd5EOeuORVyCaV3ijLMG3ek7+mcT7C
	 Jxf6M2IVqFohdzpdQOozpKpNxWRlqRmkLj6qtTSfuua7mINVYvGEP0EJFvOJvC0Qmi
	 zsyRlVJ4ishbii3UxDujwaTODfx5r3svsCp5Se9SmfXWimIy2QbuQglX1ih9VaG1oK
	 AAezueSAWasmV6q29ixf+v2nN56t2rBfnIct4aS1xxu0bTPhdjgGngZ8tFR7VbIQ3l
	 bKtrUUOk4ahdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.8 50/68] dma-direct: Leak pages on dma_set_decrypted() failure
Date: Fri, 29 Mar 2024 08:25:46 -0400
Message-ID: <20240329122652.3082296-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


