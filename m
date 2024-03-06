Return-Path: <linux-kernel+bounces-93334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D489872E2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6728AA2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829CA17745;
	Wed,  6 Mar 2024 05:01:42 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5617BB9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709701302; cv=none; b=pRQDSF297cYY50bQdxoiZSXhk/Kl3vzk9mp6VJaQgPEy3N33V5FWzjtdiHu6xJ4mpmrqvonEmT9/Heh7vz600/ter0wd6eBfTm84Zv8vuNgV/9fyViBcSqp8f+ORCxrHcHovBudF2QLKwiAGMC4503fzty8iUcWjdDJs1AD7mMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709701302; c=relaxed/simple;
	bh=YfmbS7+U/qR0DICSg92mtB6eCXorjkekqDjconR82e8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LDqnjutxau+KPPP/G1g2QAcN2RqYfukxsKApream1pofEY8qPYounUdODqghafOnIPq2e3cxmfBlwai6Ve9rUQiF0PuVb0lZQFZrDRTbBG91+zaFIsodtoL/xp8tJDOein4DofAyUuhSl1u8GtKnice0YdZ1H1VT8q41VSLHCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.17.6])
	by mail-app2 (Coremail) with SMTP id by_KCgBnq6qR+OdltmLGAg--.52750S2;
	Wed, 06 Mar 2024 13:01:15 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	dakr@redhat.com,
	lyude@redhat.com,
	kherbst@redhat.com,
	timur@kernel.org,
	jani.nikula@linux.intel.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v3] nouveau/dmem: handle kcalloc() allocation failure
Date: Wed,  6 Mar 2024 13:01:04 +0800
Message-Id: <20240306050104.11259-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBnq6qR+OdltmLGAg--.52750S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW5Cr1ruw4DCr4fKF4fGrg_yoW8KrW3pF
	WxGr1jyr47t3WjvryxKF48CF13Can8Jay8Ka9Fvr9I9Fs5XFyxCw42yFyUWayFvr13CrWI
	qr4kta4avFWjqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMLAWXnadMBYgBgsx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kcalloc() in nouveau_dmem_evict_chunk() will return null if
the physical memory has run out. As a result, if we dereference
src_pfns, dst_pfns or dma_addrs, the null pointer dereference bugs
will happen.

Moreover, the GPU is going away. If the kcalloc() fails, we could not
evict all pages mapping a chunk. So this patch adds a __GFP_NOFAIL
flag in kcalloc().

Finally, as there is no need to have physically contiguous memory,
this patch switches kcalloc() to kvcalloc() in order to avoid
failing allocations.

Fixes: 249881232e14 ("nouveau/dmem: evict device private memory during release")
Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v3:
  - Switch kcalloc() to kvcalloc().

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 12feecf71e7..6fb65b01d77 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -378,9 +378,9 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	dma_addr_t *dma_addrs;
 	struct nouveau_fence *fence;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
-	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dma_addrs = kvcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
 			npages);
@@ -406,11 +406,11 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	nouveau_dmem_fence_done(&fence);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 	for (i = 0; i < npages; i++)
 		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
-	kfree(dma_addrs);
+	kvfree(dma_addrs);
 }
 
 void
-- 
2.17.1


