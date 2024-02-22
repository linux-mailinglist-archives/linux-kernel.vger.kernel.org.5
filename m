Return-Path: <linux-kernel+bounces-75709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA0885EDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B291F2336D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE615749C;
	Thu, 22 Feb 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1q+ZAP2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6C1FB2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561062; cv=none; b=BNFX9fIIkhgCShn8LOuxElMvI5zOe3tYMYjHyqPknyuPx6o3D5jpMjV2BJpb1neOTmDlaORqzOligCd+C/XmOb65ySVtreB3I4iDmfjbkCwE7JOfv3GGakCT1L90zH6AHCQPTnW9qwsauISne6+x/SQKNZ/OUDTmn1UU0SDPyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561062; c=relaxed/simple;
	bh=a09YNCy07mYtJGRS2Rh/roKV8v3u3IkAZ8WtyECXgcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nWEZ9OO0POd0gqWvCr90B9p0wdYWWxJyPd54r3vmCY4/kUAXz3SDr3PyAepAHDTLLjOWKazr7PNUUvF3RG28SsKcffHTKURIotiM14Dh80us9e3hYZq2aENJwLphIbudcp5inl7EGwp4OQgxiIOAz/XNonDMG3JxRzLe/nNBwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1q+ZAP2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708561060; x=1740097060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a09YNCy07mYtJGRS2Rh/roKV8v3u3IkAZ8WtyECXgcM=;
  b=J1q+ZAP2MSghm+32yeYgz7NR+0v/E7sAb+gEVdHPtib8VXHmtANZWd/B
   YqtMEVSYi6wDiY8f1VhSGAfFfgLVp+HBgLgb7gmqkdMKqC0KPckh0xFXv
   ttZv4APnUJEhh6x89L1smkr2auaAd1rxG5fo40ykEi7SSh4GolnRYnL0A
   zKq/vZoxqT+ZtIE1z+YB0qTr+VGNHj/+p8o14+97KOPO5VPumXuSCPXDL
   IzTPrbmpXmtznw2VLuTqomowXE3Pr2AkFBJAWyKH28nyERbwxNdFUsjca
   AkTYdVQta6DSmlHNLRRe0aVoypNrU97TqgcZr09eo7F68UL64YXMIkpSa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6532588"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="6532588"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 16:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936729215"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="936729215"
Received: from nlokaya-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.62.65])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 16:17:35 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	iommu@lists.linux.dev
Subject: [PATCH] dma: Leak pages on dma_set_decrypted() failure
Date: Wed, 21 Feb 2024 16:17:21 -0800
Message-Id: <20240222001721.2269203-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.

DMA could free decrypted/shared pages if dma_set_decrypted() fails. This
should be a rare case. Just leak the pages in this case instead of freeing
them.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
Shared (decrypted) pages should never return to the page allocator, or 
future usage of the pages may allow for the contents to be exposed to the 
host. They may also cause the guest to crash if the page is used in way 
disallowed by HW (i.e. for executable code or as a page table).

Normally set_memory() call failures are rare. But on TDX 
set_memory_XXcrypted() involves calls to the untrusted VMM, and an attacker
could fail these calls such that:
 1. set_memory_encrypted() returns an error and leaves the pages fully
    shared.
 2. set_memory_decrypted() returns an error, but the pages are actually
    full converted to shared.

This means that patterns like the below can cause problems:
void *addr = alloc();
int fail = set_memory_decrypted(addr, 1);
if (fail)
        free_pages(addr, 0);

And:
void *addr = alloc();
int fail = set_memory_decrypted(addr, 1);
if (fail) {
        set_memory_encrypted(addr, 1);
        free_pages(addr, 0);
}

Unfortunately these patterns are all over the place. And what the 
set_memory() callers should do in this situation is not clear either. They 
shouldn’t use them as shared because something clearly went wrong, but 
they also need to fully reset the pages to private to free them. But, the 
kernel needs the VMMs help to do this and the VMM is already being 
uncooperative around the needed operations. So this isn't guaranteed to 
succeed and the caller is kind of stuck with unusable pages.

The only choice is to panic or leak the pages. The kernel tries not to 
panic if at all possible, so just leak the pages at the call sites. 
Separately there is a patch[0] to warn if the guest detects strange VMM 
behavior around this. It is stalled, so in the mean time I’m proceeding 
with fixing the callers to leak the pages. No additional warnings are 
added, because the plan is to warn in a single place in x86 set_memory() 
code.

[0] https://lore.kernel.org/lkml/20240122184003.129104-1-rick.p.edgecombe@intel.com/
---
---
 kernel/dma/direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 98b2e192fd69..4d543b1e9d57 100644
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
2.34.1


