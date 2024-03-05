Return-Path: <linux-kernel+bounces-92531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 269098721BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4CB8B24B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99C86AC2;
	Tue,  5 Mar 2024 14:40:24 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A06127
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649624; cv=none; b=Cj7qkdsQQt/HcV1KSps4cP2eHBYyZDzWY0hXUrLSu2W4lI2G1nZPFk5We8k0xON4dClKzKT0QpU0JG9cfOnE4sn46BuJsGSTjVAnmZ8yrD20gzh0RNwHY5P0LjzKIOM8HfLL/tsjVq/3GqQ+hadZMZL7nfJWCG2lsX2jY6Gpxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649624; c=relaxed/simple;
	bh=CmL12mENihxxmalpXqGHbfuDwzIahIPBnLrrhx5NxCA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fnnSl6IUb104GsBNY16dlrAdLef9H8IHeD6+AF6nV96uQmdzJ0KR3+sJR4F0YT2wIP78kGIxAMmxogXCg6/q1pDdz2SJPNuU+eEF78lncjYVp4x7eRTx8hDNQT0lZTmBrCdCJfn2iQBGTizCzY180IhpcopBQ/wwJSV8tbfkcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [106.117.76.127])
	by mail-app3 (Coremail) with SMTP id cC_KCgAX+zSoLudlI534AQ--.59749S2;
	Tue, 05 Mar 2024 22:39:52 +0800 (CST)
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
Subject: [PATCH v2] nouveau/dmem: handle kcalloc() allocation failure
Date: Tue,  5 Mar 2024 22:39:36 +0800
Message-Id: <20240305143936.25283-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgAX+zSoLudlI534AQ--.59749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trW5Aw4kur1fXw1DKr4kJFb_yoW8WrWfpF
	Z7Gr12vF4jya1jvry8KF48CF13AanxJay8Ka9Fy3sI9Fn5ZFy7C3y2yFyUWayFvr1fCrWv
	qr4kta4Y9F4jqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwULAWXmGFMTDgAqsz
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

Fixes: 249881232e14 ("nouveau/dmem: evict device private memory during release")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Allocate with __GFP_NOFAIL.

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 12feecf71e7..f5ae9724ee2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -378,9 +378,9 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	dma_addr_t *dma_addrs;
 	struct nouveau_fence *fence;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
-	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
+	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
 			npages);
-- 
2.17.1


