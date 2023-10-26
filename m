Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B87D8009
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjJZJwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJZJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:52:00 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D43192
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:51:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SGLJb3lyMz9v7YL
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 17:35:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.222.195])
        by APP1 (Coremail) with SMTP id LxC2BwBnwJGjNjplmLDyAg--.24089S2;
        Thu, 26 Oct 2023 10:51:38 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Wangkefeng <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH] swiotlb: check dynamically allocated TLB address before decrypting
Date:   Thu, 26 Oct 2023 11:51:23 +0200
Message-Id: <20231026095123.222-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnwJGjNjplmLDyAg--.24089S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDCry3Ar17Ww4fAr17GFg_yoW5Xr1kpF
        4Syr1Sqr98tFy7CrWxAF4kCFy3Kws5CFW3CFW5X343ZFnxWFySkr9rCw109ayfJr4kua17
        JrW0v3Wayr47ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnLvKUUUUU
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Do not decrypt a dynamically allocated TLB area until its physical address
is known to be below the requested limit. Currently, pages are allocated
and decrypted, but then they may be freed while still decrypted if
swiotlb_alloc_tlb() determines that the physical address is too high.

Let the caller differentiate between unsuitable physical address (=> retry
from a lower zone) and allocation failures (=> no point in retrying).

Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/swiotlb.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dff067bd56b1..d1118f6f61b8 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -558,30 +558,36 @@ void __init swiotlb_exit(void)
  * alloc_dma_pages() - allocate pages to be used for DMA
  * @gfp:	GFP flags for the allocation.
  * @bytes:	Size of the buffer.
+ * @phys_limit:	Maximum allowed physical address of the buffer.
  *
  * Allocate pages from the buddy allocator. If successful, make the allocated
  * pages decrypted that they can be used for DMA.
  *
- * Return: Decrypted pages, or %NULL on failure.
+ * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
+ * if the allocated physical address was above @phys_limit.
  */
-static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 {
 	unsigned int order = get_order(bytes);
 	struct page *page;
+	phys_addr_t paddr;
 	void *vaddr;
 
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
-	vaddr = page_address(page);
+	paddr = page_to_phys(page);
+	if (paddr + bytes - 1 > phys_limit)
+		goto error;
+	vaddr = phys_to_virt(paddr);
 	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		goto error;
 	return page;
 
 error:
 	__free_pages(page, order);
-	return NULL;
+	return ERR_PTR(-EAGAIN);
 }
 
 /**
@@ -618,11 +624,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
 
-	while ((page = alloc_dma_pages(gfp, bytes)) &&
-	       page_to_phys(page) + bytes - 1 > phys_limit) {
-		/* allocated, but too high */
-		__free_pages(page, get_order(bytes));
-
+	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
-- 
2.42.0

