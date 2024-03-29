Return-Path: <linux-kernel+bounces-124587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F223891A45
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE59285CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770F157498;
	Fri, 29 Mar 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiOSPVSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467D157481;
	Fri, 29 Mar 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715473; cv=none; b=EjO2PHK/kTjr/6PzWJItpLRcyP+4Muz5UCX0QwuKtvMqn7cR2wXGGGXMgdfGO7so5Jj9GF0On8QFZqVnfAIHo5ThqaaRkhA5NCuebsq2OxqOO24cRQNGSbRgvcHM7d84ZZ67xLpOTlWeljtyCTR+PsE1fNaWi0kXeVFuf9txCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715473; c=relaxed/simple;
	bh=k3zuf16/TCQid4I2XHlZ7Fg+DXFG1/Fja7b3voOoAZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2wkskhUSiApgqy3qpWYy4kZOfedXAeiqXOX9jG6vrBSwuJM8MwKNXPqRSliWwfu6jX9xMACyfMo4JcFyhOyaCkAOL8k099ZkNRfvFOmQRhMpizL721ps1mTJjcMDeg01qmo2uaRoj/G6uMdtM/apjMdkS91AA/cTjPhJZezokA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiOSPVSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C2BC43399;
	Fri, 29 Mar 2024 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715473;
	bh=k3zuf16/TCQid4I2XHlZ7Fg+DXFG1/Fja7b3voOoAZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiOSPVSyzXi5kzzfmGn2LGvsGlNA4c8Dtfh1+BASpbr9wjwOjQ0r427U4Cci2ftKj
	 uzRLPftJ3P32RDyq52TFmFEx1WX4Ky69jUnScRy77CYv+eV+oHKZeLwqUwepGIMQjA
	 h27KlaMocs85tBfZ5p0c3rcYZyuayzT20zU3ja/KwkV4OTuRpfgr1e4SnGt0LmeUQd
	 TKr+2EscLzQoMIjxvGtIGx7+30t3nFzVfBT501D+tUMKJvAQcjvO+sZrsPNP6OL68O
	 25WEPQix0YpPUF/j1DCTq3TMhnbAuKS31ikhSkh2F/La8ZKkKy2JMpwatCGFZK7kgx
	 79Vz7jmFh+dUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 36/52] dma-direct: Leak pages on dma_set_decrypted() failure
Date: Fri, 29 Mar 2024 08:29:06 -0400
Message-ID: <20240329122956.3083859-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
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


