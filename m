Return-Path: <linux-kernel+bounces-89668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96886F3F3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56554283D03
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAF69470;
	Sun,  3 Mar 2024 07:53:55 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6C8F5D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709452434; cv=none; b=RnV/1wsvESA6txcPQF6TF6IBu2oakjM/xvu0UNAj2/HN2VUeyjkr2AE4vWPQzwRiF55WzKjEM7Mf8u2Nl23fZZTZLt0hJrzasYaSI74Nkdk2e15Jzr2hp0NXO0DlYr2Le2GzpqnBJpv4mCR0eR9McrXzDjqjykW3eSkNFI+aFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709452434; c=relaxed/simple;
	bh=aJE/J1OJ5ZDl2zz2vpXR98OO8kPY5m2SyXGulSjHoUk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fsq5qlaeu0pp9LRRL+Sn/U3e+e3I6DW02EsXtV/hrnBLjIeWEDkWDADMX/HtvemOBLRUTE3veS/iezPmheK8/TcZkR/y8UdhmtfvG2MWqviBBLFuJ+0mDc5iZHia7JuxO2RzKo6G4mgh58KvyWw+lg7LCpV9yt6IORsTWukeEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.66])
	by mail-app4 (Coremail) with SMTP id cS_KCgCHgH5pLORlzhHfAQ--.40720S2;
	Sun, 03 Mar 2024 15:53:29 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	dakr@redhat.com,
	lyude@redhat.com,
	kherbst@redhat.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] nouveau/dmem: handle kcalloc() allocation failure
Date: Sun,  3 Mar 2024 15:53:12 +0800
Message-Id: <20240303075312.56349-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgCHgH5pLORlzhHfAQ--.40720S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW5Aw4kur1fWF4UGF13CFg_yoW8ZF48pF
	WxGF1jyr42yayjqry8tF1kur4ayan3JayxKa9Fy3sI9a4rXFy7Z3y7Aa45WFWYqrW7CrWa
	qr4Dta43ZF4Ut3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUU
	UU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIIAWXjdVMBCAAXs2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kcalloc() in nouveau_dmem_evict_chunk() will return null if
the physical memory has run out. As a result, if we dereference
src_pfns, dst_pfns or dma_addrs, the null pointer dereference bugs
will happen.

This patch uses stack variables to replace the kcalloc().

Fixes: 249881232e14 ("nouveau/dmem: evict device private memory during release")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 12feecf71e7..9a578262c6d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -374,13 +374,13 @@ static void
 nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 {
 	unsigned long i, npages = range_len(&chunk->pagemap.range) >> PAGE_SHIFT;
-	unsigned long *src_pfns, *dst_pfns;
-	dma_addr_t *dma_addrs;
+	unsigned long src_pfns[npages], dst_pfns[npages];
+	dma_addr_t dma_addrs[npages];
 	struct nouveau_fence *fence;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
-	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
+	memset(src_pfns, 0, npages);
+	memset(dst_pfns, 0, npages);
+	memset(dma_addrs, 0, npages);
 
 	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
 			npages);
@@ -406,11 +406,8 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	nouveau_dmem_fence_done(&fence);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
 	for (i = 0; i < npages; i++)
 		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
-	kfree(dma_addrs);
 }
 
 void
-- 
2.17.1


